
(setenv "HOME" "D:/apps/emacs-24.5")

(setenv "PATH" "D:/apps/emacs-24.5")

;;set the default file path

(setq default-directory "~/")

;;load path test
(add-to-list 'load-path "D:/apps/emacs-24.5/plugin")

;;set the default text coding system
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Remove splash screen
(setq inhibit-splash-screen t)

;; Set default window size
(setq default-frame-alist 
'((left . 0) (top . 0) (height . 40) (width . 125) (menu-bar-lines . 20) (tool-bar-lines . 0))) 

;; Set font
;(set-default-font "WenQuanYi Micro Hei 10")
;(set-default-font "DejaVu Sans Mono 10")
;(set-default-font "Monaco 10")
;(set-fontset-font (frame-parameter nil 'font) 'han' ("WenQuanYi Micro Hei"))
;(setq default-frame-alist (font . "WenQuanYi Micro Hei 12"))
;(setq default-frame-alist (font . "Lucida Console 12"))

;; Setting English Font
;(set-face-attribute 'default nil :font "DejaVu Sans Mono 10")
 
;; Chinese Font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
                      charset
                      (font-spec :family "WenQuanYi Micro Hei" :size 12)))

;; Set cursor as bar
(setq-default cursor-type 'bar)

;; the following function is to scroll the text one line down while keeping the cursor
(defun scroll-down-keep-cursor ()
(interactive)
   (scroll-down 3))

;; the following function is to scroll the text one line up while keeping the cursor
(defun scroll-up-keep-cursor ()
(interactive)
   (scroll-up 3))

;; binding mouse-4 and mouse-5 to the above two functions
(global-set-key [mouse-4] 'scroll-down-keep-cursor)
(global-set-key [mouse-5] 'scroll-up-keep-cursor)

;; hide tool bar
(tool-bar-mode 0)
(menu-bar-mode 0)
;(scroll-bar-mode 0)

;; auto backup
(setq backup-directory-alist '(("" . "~/.emacsBackup")))
(setq-default make-backup-file t)
(setq make-backup-file t)
(setq make-backup-files t)
(setq version-control t)
(setq kept-old-versions 2)
(setq kept-new-versions 10)
(setq delete-old-versions t)

;;remove the scroll bar
(scroll-bar-mode nil)
;;send selected text to clipboard
(setq x-select-enable-clipboard t)

;; highlight parenthesis
(show-paren-mode t)

;;auto insert parenthesis
(defun code-mode-auto-pair ()
"autoPair"
(interactive)
(make-local-variable 'skeleton-pair-alist)
(setq skeleton-pair-alist '(
(?` ?` _ "''")
(?\( ? _ " )")
(?\[ ? _ " ]")
(?{ \n > _ \n ?} >)
(?\'? _ "'")
(?\"? _ "\"")
))
(setq skeleton-pair t)
(local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(local-set-key (kbd "`") 'skeleton-pair-insert-maybe)
(local-set-key (kbd "[") 'skeleton-pair-insert-maybe)
(local-set-key (kbd "'") 'skeleton-pair-insert-maybe)
(local-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
)

;;auto pair, add hook to groovy mode
(add-hook 'groovy-mode-hook 'code-mode-auto-pair)

;;copy current line
(global-set-key (kbd "C-c C-w") 'copy-lines)
(defun copy-lines(&optional arg)
  (interactive "p")
  (save-excursion
    (beginning-of-line)
    (set-mark (point))
    (next-line arg)
    (kill-ring-save (mark) (point))
    )
  )

;;key config, refresh
(global-set-key [f5] 'revert-buffer)
(global-set-key [C-f5] 'revert-buffer-with-coding-system)
(fset 'yes-or-no-p 'y-or-n-p)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; autoload php mode
(autoload 'php-mode "php-mode" "PHP Mode." t)
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))

;show line number
(global-linum-mode t)

;highlight-symbol
(require 'highlight-symbol)
(add-hook 'find-file-hooks 'highlight-hooks)
(defun highlight-hooks()
(setq highlight-symbol-idle-delay 0.4)
(highlight-symbol-mode t))
(global-set-key [(control f3)] 'highlight-symbol-at-point)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(control meta f3)] 'highlight-symbol-query-replace)
;; higlight changes in documents
(global-highlight-changes-mode t)
(setq highlight-changes-visibility-initial-state nil) ; initially, hide#
;; toggle changes visibility
(global-set-key (kbd "") 'highlight-changes-visible-mode) ;; changes
;; remove the change-highlight in region
(global-set-key (kbd "") 'highlight-changes-remove-highlight)
;; alt-pgup/pgdown jump to the previous/next change
(global-set-key (kbd "") 'highlight-changes-previous-change)
(global-set-key (kbd "") 'highlight-changes-next-change)
(set-face-foreground 'highlight-changes nil)
(set-face-foreground 'highlight-changes-delete nil)
(set-face-background 'highlight-changes "#382f2f")
(set-face-background 'highlight-changes-delete "#916868")


(column-number-mode t);显示列号  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;for groovy
;;; turn on syntax highlighting
(global-font-lock-mode 1)

;;; use groovy-mode when file ends in .groovy or has #!/bin/groovy at start
(autoload 'groovy-mode "groovy-mode" "Major mode for editing Groovy code." t)
(add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
(add-to-list 'auto-mode-alist '("\.gradle$" . groovy-mode))
(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))

;;; make Groovy mode electric by default.
(add-hook 'groovy-mode-hook
          '(lambda ()
             (require 'groovy-electric)
             (groovy-electric-mode)))

;insert line
(global-set-key (kbd "S-<return>") '(lambda()(interactive)(move-end-of-line 1)(newline)))
(global-set-key (kbd "C-S-<return>") '(lambda()(interactive)(move-beginning-of-line 1)(newline)(previous-line)))