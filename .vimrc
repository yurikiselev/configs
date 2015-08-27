"=======================================
" Base VIM settings
"=======================================

set nocompatible " This must be first, because it changes other options as a side effect.

" This part is required for using vundle plagin manager
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'git://github.com/altercation/vim-colors-solarized.git'
Plugin 'a.vim'
Plugin 'git://github.com/Valloric/YouCompleteMe.git'
Plugin 'The-NERD-Commenter'
Plugin 'The-NERD-tree'
" Add above all plugins you need
call vundle#end()            " required
filetype plugin indent on    " required

syntax enable
syntax on " Switch on lighting of the sintax
set showmatch " Show matching brackets
set background=dark " light
colorscheme solarized " Set color palette, see http://ethanschoonover.com/solarized
let g:solarized_termtrans = 1

set ignorecase " Ignore case-sensitive when seaching
set smartcase " Case sensitive when uppercase present
set incsearch " Switch ON incremental search

set encoding=utf-8 " Code by default
set termencoding=utf-8 " Code of writing in the terminal
set fileencodings=utf-8,cp1251,koi8r " Possible code of file (auto recoding)

" smart indetns & converting tabs to spaces
set autoindent
set smartindent
set expandtab
set shiftwidth=4 " use indents of 4 spaces
set softtabstop=4 " let backspace delete indent
set tabstop=4

" Some Windows specific stuff -> could be erased
set clipboard=unnamed

" We can use the mouse ;)
set mouse=a
set mousemodel=popup

set wrap " nowrap // [not] wrap long lines

set title " Show current file name in the top of terminal window

set history=500 " command line history

set ruler " Always show position of the cursor

set nu " rnu // Switch on the numbering of the lines ('rnu' stands for RelativeNUmber)

set backspace=indent,eol,start whichwrap+=<,>,[,] " Allow to use backspace instead of "x"

set backupdir=$HOME/.vim/backup_files " Save backups in one place

" Use normal (bash like) tab completion for file names
set wildmode=longest,list,full
set wildmenu

set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸→
"set list " nolist // show tabs and trailing spaces

" Avoid tabs when you copy/paste
"set paste " !!! if this is set then "smartindent" does not work

" Add status line to the bottom, add file name there
"set laststatus=2
"set statusline+=%F

" we want to highlight word under the cursor with * or #
"set hlsearch

"set cursorline " Ligth of the current line

" Do not store backups at all
"set nobackup
"set nowritebackup

"=======================================
" Hot keys
"=======================================

" Wrapped lines goes down/up to next row, rather than next line in file
noremap j gj
noremap k gk

let mapleader = ',' " Set ',' (comma) as the default leader since it's in a standard

" search
nnoremap <leader>s :%s//<left>
vnoremap <leader>s :s//<left>

" open VIM config
nnoremap <leader>ov :e ~/.vimrc<cr>
vnoremap <leader>ov :e ~/.vimrc<cr>

" F2 - quick save
nmap <F2> :w<cr>
vmap <F2> <esc>:w<cr>i
imap <F2> <esc>:w<cr>i

" Ctrl-y - delete current line
nmap <C-y> dd
imap <C-y> <esc>ddi

" Ctrl+c, q - quit from Vim
map <C-c>q <Esc>:qa<cr>

" UNDO
map <C-Z> :undo <cr>
imap <C-Z> <esc> <C-Z>

" Remove trailing and leading spaces
nmap clr :%s/\s\+$//e<CR>

" Copy/Paste
map <C-C> "ay
nmap <C-V> "agpi
imap <C-V> <esc><esc> "agpi

" Select all
nmap <C-A> ggVG

" Moving through buffers
map <C-l> <C-w>l
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k

" Open new file using path to current buffer as a relative path
map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>t :tabe <C-R>=expand("%:p:h") . "/" <CR>
map <leader>s :vsp <C-R>=expand("%:p:h") . "/" <CR>

"=======================================
" Developer's things
"=======================================

" COMMON STUFF

" формат строки с ошибкой для gcc и sdcc, это нужно для errormarker
let &errorformat="%f:%l:%c: %t%*[^:]:%m,%f:%l: %t%*[^:]:%m," . &errorformat

" F3 - show log of errors
nmap <F3> :copen<cr>
vmap <F3> <esc>:copen<cr>
imap <F3> <esc>:copen<cr>

" F9 Build project release
"map <F9> :make release -j 16 %:p:h<cr>
"imap <F9> <esc> :make release -j 16 %:p:h<cr>i

" Switch between *.cpp and corresponding *.h and vice-versa (a.vim plugin)
map <C-c>sw <Esc>:A<CR>
nmap <C-c>sw :A<CR>

" YouCompleteMe
let g:ycm_confirm_extra_conf = 0 " silent .ycm_extra_conf.py loading
let g:ycm_show_diagnostics_ui = 1 " turns on YCM's diagnostic display features
let g:ycm_autoclose_preview_window_after_completion = 1 " auto-close the preview window after
"set completeopt=menuone " don't show extra info about the currently selected completion in the preview window (can be added with ",preview")
nmap <leader>d :YcmCompleter GoToDefinitionElseDeclaration<CR>
nmap def :YcmCompleter GoToDefinition<CR>
nmap dec :YcmCompleter GoToDeclaration<CR>

" Autocompleting words by Tab
function InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
imap <tab> <c-r>=InsertTabWrapper()<cr>

" Highlight all instances of word under cursor, when idle.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
    let @/ = ''
    if exists('#auto_highlight')
        au! auto_highlight
        augroup! auto_highlight
        setl updatetime=4000
        echo 'Highlight current word: off'
        return 0
    else
        augroup auto_highlight
        au!
        au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
        augroup end
        setl updatetime=500
        echo 'Highlight current word: ON'
        return 1
    endif
endfunction

"autocmd BufWritePre * :%s/\s\+$//e " Automatic removing trailing spaces before saving

"=======================================
" Tips & Tricks
"=======================================

" The NERD Commenter
  " <leader>cc - Comment out the current line or text selected in visual mode.
  " <leader>cu - Uncomments the selected line(s).

" '0 - open last file
"  Ctrl-V<Tab> - insert tab character

" moving around
    " ^ - move to the first character in the line
    " w - move to the next word
    " b - move to the previous word
    " e - move to the end of the next word
    " f{char} - To [count]'th occurrence of {char} to the right. The cursor is placed on {char} (inclusive).
    " F{char} - To the [count]'th occurrence of {char} to the left. The cursor is placed on {char} (inclusive).
    " ; - Repeat latest f, t, F or T [count] times.
    " , - Repeat latest f, t, F or T in opposite direction [count] times.
    " {NUM}| - go to col #NUM

" navigation, using tags file
    " Ctrl-] - Jump to a tag
    " g Ctrl-] - (pretty useless) Jump to a tag directly, if there is only one tag match, otherwise present a list of tag matches
    " Ctrl-W ] - Open the tag location in a new window
    " g] - Get a list of matching tags
    " :tags - list the current tag stack

" using marks to navigate
    " :ma a - create a mark with the name a
    " ma - the same as the previous command
    " 'a (that's single quote, mark label) - move to 'a' mark
    " '. - go to the last edit place

" yank/paste text (visual mode)
" "{char}Y - copy text to buffer marked as {char}
" "{char}p - paste text from buffer marked as {char}

" * - search word that is under the cursor
" [I (that's bracket-open, capital-i) - shows lines containing the word under the cursor
" gf - open file name under the cursor
" :e file - open existing file or create a new one
" <Ctrl-W>s - split window by horisontal <Ctrl-W>v - by vertical
" <Ctrl-W>w - switch to the next window
" {nn}G  or {nn}gg - go to nn line
" CTRL+O - go to previous position
" CTRL+I - go to next position

" VISUAL MODE
" > - shift labelled text to right
" < - shift labelled text to light

" Shortcuts in Error Window (F3)
" :cc [номер]           Отображение ошибки с указанным номером
" :cn                   Перейти к следующей ошибке
" :cp                   Перейти к предыдущей ошибке
" :cr                   Перейти к первой ошибке
" :cla                  Перейти к последней ошибке
" :cq                   Выйти из программы с возвратом кода ошибки

" :f - shows the path, line count, modified state, current cursor position, and more...

" :write ++enc=utf-8 % - change the encoding of the current file

