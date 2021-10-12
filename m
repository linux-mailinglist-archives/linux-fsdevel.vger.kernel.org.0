Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5021429D9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 08:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhJLGXp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 02:23:45 -0400
Received: from verein.lst.de ([213.95.11.211]:40086 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231190AbhJLGXo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 02:23:44 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 911C468B05; Tue, 12 Oct 2021 08:21:41 +0200 (CEST)
Date:   Tue, 12 Oct 2021 08:21:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hao Sun <sunhao.th@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>
Subject: Re: WARNING in __kernel_read
Message-ID: <20211012062141.GC17407@lst.de>
References: <CACkBjsbPsmUiC7NFgOZcVcwPA7RLpiCFkgEA=LsnvcFsWFG34Q@mail.gmail.com> <YV2T3HVHHmQPHVYG@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YV2T3HVHHmQPHVYG@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 06, 2021 at 01:17:32PM +0100, Matthew Wilcox wrote:
> On Wed, Oct 06, 2021 at 05:33:47PM +0800, Hao Sun wrote:
> > C reproducer: https://drive.google.com/file/d/1RzAsyIZzw5X_m340nY9fu4KWjGdG98pv/view?usp=sharing
> 
> It's easier than this reproducer makes it look.
> 
> 	res = syscall(__NR_openat, -1, 0x20000080ul, 0x4c003ul, 0x10ul);
> 	syscall(__NR_finit_module, r[0], 0ul, 3ul);
> 
> should be enough.  Basically, userspace opens an fd without FMODE_READ
> and passes it to finit_module().
> 
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 28082 at fs/read_write.c:429
> > __kernel_read+0x3bb/0x410 fs/read_write.c:429
> > Modules linked in:
> > CPU: 1 PID: 28082 Comm: syz-executor Not tainted 5.15.0-rc3+ #21
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> > RIP: 0010:__kernel_read+0x3bb/0x410 fs/read_write.c:429
> > Call Trace:
> >  kernel_read+0x47/0x60 fs/read_write.c:461
> >  kernel_read_file+0x20a/0x370 fs/kernel_read_file.c:93
> >  kernel_read_file_from_fd+0x55/0x90 fs/kernel_read_file.c:184
> >  __do_sys_finit_module+0x89/0x110 kernel/module.c:4180
> 
> finit_module() is not the only caller of kernel_read_file_from_fd()
> which passes it a fd that userspace passed in, for example
> kexec_file_load() doesn't validate the fd either.  We could validate
> the fd in individual syscalls, in kernel_read_file_from_fd()
> or just do what vfs_read() does and return -EBADF without warning.
> 
> So, one of these two patches.  Christoph, Al, what's your preference?

I think the warning was something Linux wanted.  So the first one seems
like the way to go.
