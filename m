Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62AB7423D93
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 14:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbhJFMUW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 08:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbhJFMUW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 08:20:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A03C061749;
        Wed,  6 Oct 2021 05:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tuw64zH7FkvujlGPRt68jSX0rh3P5aIG7S452X6pvEs=; b=NUhlc4e3Ik4eh3/FI5sD9cWF57
        hO0GMwe+ms4IofLbPAjMYIkq2HdbHZDK1b9wEqENhT16eCAHhpq1ymT1ZU6w3D0gFtnvnzSZV947F
        OD8d9NZPdhY9P8OAkjcgM78Owmys9wr+oJEfsaQrYG6ZtsJxDU1piwZ+avAzkgMYf5Au9fbPvk8zv
        iplHrgSSKofRKiO7LjuiyavTFkSVxvpgVoEs+9RR6R7Uzezf+BGRU2kvPyFPoDK9recZ8Vt+8nlQ0
        hYs6P5Qqy6j/odYyL68/6laFK1bM9+Jg5BXtvmAo/q4cl81P6R0LDXyY4I0dOUiVHBkVr9TBOXgAL
        xk8CNmZw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mY5rY-000rQ4-PP; Wed, 06 Oct 2021 12:17:40 +0000
Date:   Wed, 6 Oct 2021 13:17:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>
Subject: Re: WARNING in __kernel_read
Message-ID: <YV2T3HVHHmQPHVYG@casper.infradead.org>
References: <CACkBjsbPsmUiC7NFgOZcVcwPA7RLpiCFkgEA=LsnvcFsWFG34Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACkBjsbPsmUiC7NFgOZcVcwPA7RLpiCFkgEA=LsnvcFsWFG34Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 06, 2021 at 05:33:47PM +0800, Hao Sun wrote:
> C reproducer: https://drive.google.com/file/d/1RzAsyIZzw5X_m340nY9fu4KWjGdG98pv/view?usp=sharing

It's easier than this reproducer makes it look.

	res = syscall(__NR_openat, -1, 0x20000080ul, 0x4c003ul, 0x10ul);
	syscall(__NR_finit_module, r[0], 0ul, 3ul);

should be enough.  Basically, userspace opens an fd without FMODE_READ
and passes it to finit_module().

> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 28082 at fs/read_write.c:429
> __kernel_read+0x3bb/0x410 fs/read_write.c:429
> Modules linked in:
> CPU: 1 PID: 28082 Comm: syz-executor Not tainted 5.15.0-rc3+ #21
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> RIP: 0010:__kernel_read+0x3bb/0x410 fs/read_write.c:429
> Call Trace:
>  kernel_read+0x47/0x60 fs/read_write.c:461
>  kernel_read_file+0x20a/0x370 fs/kernel_read_file.c:93
>  kernel_read_file_from_fd+0x55/0x90 fs/kernel_read_file.c:184
>  __do_sys_finit_module+0x89/0x110 kernel/module.c:4180

finit_module() is not the only caller of kernel_read_file_from_fd()
which passes it a fd that userspace passed in, for example
kexec_file_load() doesn't validate the fd either.  We could validate
the fd in individual syscalls, in kernel_read_file_from_fd()
or just do what vfs_read() does and return -EBADF without warning.

So, one of these two patches.  Christoph, Al, what's your preference?

diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index 87aac4c72c37..1f28b693d1db 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -178,7 +178,7 @@ int kernel_read_file_from_fd(int fd, loff_t offset, void **buf,
        struct fd f = fdget(fd);
        int ret = -EBADF;

-       if (!f.file)
+       if (!f.file || !(file->f_mode & FMODE_READ))
                goto out;

        ret = kernel_read_file(f.file, offset, buf, buf_size, file_size, id);

diff --git a/fs/read_write.c b/fs/read_write.c
index af057c57bdc6..bab43b8532d1 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -426,8 +426,8 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
        struct iov_iter iter;
        ssize_t ret;

-       if (WARN_ON_ONCE(!(file->f_mode & FMODE_READ)))
-               return -EINVAL;
+       if (!(file->f_mode & FMODE_READ))
+               return -EBADF;
        if (!(file->f_mode & FMODE_CAN_READ))
                return -EINVAL;
        /*

