local opt = vim.opt
local g = vim.g

-------------- Plugins ----------------------------------------------------------------------
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')
Plug 'folke/tokyonight.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'cocopon/iceberg.vim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'itchyny/lightline.vim'
Plug 'romgrk/barbar.nvim'

--IDE
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'numToStr/Comment.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-surround'
vim.call('plug#end')
---------------------------------------------------------------------------------------------















----------------- plugins setups -------------------------------------------------------------
require('colorizer').setup()
require('Comment').setup()
require("nvim-autopairs").setup{}

require("indent_blankline").setup {
    char = '|',
    show_current_context = true
}

-- config pro telescope (baguio de procurar arquivos) ignorar binários, .git e essas merdas
require('telescope').setup{
    defaults = {
        file_ignore_patterns = { "%.bat", "%.toml", "%.zip",
            "%.exe", "%.love", "builds", "%.dll", ".git", 
            "%.png", "%.ttf", "%.mp3", "%.jpg", "%.jpeg", 
            "%.mp4", "%.ogg", ".vscode", ".luarc", "vimfiles"},
    }
}

--- barra de tabs -------- 
require('bufferline').setup{
    animations = true,
    clickable = true,
    closable = false,
    auto_hide = false,
    insert_at_end = true,
    icons = false,
}

-----------------------------------------------------------------------------------




















--------------- auto complete -----------------------------------------------------

vim.g.completeopt="menu,menuone,noselect,noinsert"

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {}
    if server.name == "sumneko_lua" then 
        opts = {
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        enable = false
                    },
                    telemetry = {
                        enable = false,
                    }
                },
            },
        }
    end
    server:setup(opts)
end)

vim.diagnostic.hide()

local configs = require('nvim-treesitter.configs')
configs.setup{
    ensure_installed = "all",
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    }
}


-- Setup nvim-cmp.
local cmp = require'cmp'
cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
            { name = 'buffer' },
        })
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require'lspconfig'['sumneko_lua'].setup {
    capabilities = capabilities
}
----------------------------------------------------------------------------------





-- vim keymaps --------------------------------------------------------------------
opt.undofile = true
opt.smartindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.shiftround = true
opt.expandtab = true
opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.cursorline = true
opt.relativenumber = true
opt.number = true
opt.viminfo = ""
opt.viminfofile = "NONE"
opt.ignorecase = true
opt.ttimeoutlen = 5
opt.compatible = false
opt.hidden = true
opt.shortmess = "atI"

vim.cmd [[
set nowrap
set nobackup
set nowritebackup
set noerrorbells
set noswapfile
set undodir=C:\Users\smezzy\vimfiles\undodir
set incsearch
set scrolloff=8
set noshowmode
set termguicolors
set nohlsearch
function! Preserve(command)
    let w = winsaveview()
    execute a:command
    call winrestview(w)
endfunction
let mapleader = ' '
inoremap Ç :
nnoremap ç :
vnoremap ç :
inoremap ç ;

inoremap <C-i> <C-o>
inoremap <C-o> <C-i>
nnoremap <C-i> <C-o>
nnoremap <C-o> <C-i>

nmap <leader>' ysiw'
nmap <leader>" ysiw"
nmap <leader>] ysiw)
nmap <leader>} ysiw}
nmap <leader>) ysiw)
nmap <leader>[ ysiw[
nmap <leader>{ ysiw{
nmap <leader>( ysiw(

nmap <up> <C-w><up>
nmap <down> <C-w><down>
nmap <right> <C-w><right>
nmap <left> <C-w><left>

imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>

nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>l
nnoremap <C-p> :Telescope find_files <CR>

map <A-l> :!lovec . <enter>

highlight IndentBlanklineChar guifg = #393b4d
colorscheme iceberg
let g:lightline = {
\ 'colorscheme': 'iceberg',
\ }
highlight IndentBlanklineIndent1 guibg=#43434d gui=nocombine
highlight IndentBlanklineIndent2 guibg=#2d3037 gui=nocombine
]]

--------------------------------------------------------------------------------------------- 

