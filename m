Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED2F280A53
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Oct 2020 00:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgJAWiy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 18:38:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgJAWiy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 18:38:54 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E03020719;
        Thu,  1 Oct 2020 22:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601591933;
        bh=dgse0uKa9q4y1xba5nTOCZw8RfdMgAh2siEKq6FEbw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uRuY1p+tObvxgjKQUQAF6agnUD66dxoDsbXY8z+yb9idAVI5vvinrorOkLYZAv/F7
         DPYSFXNEXwAGkMDceSMSd5SAnuu8zJt2dObGFRPH4WevNG+L9cVNrZpWvla8kZuQnd
         Xe1EwPVM8XPZbYMgJUTknon6uxvaqhf+cnjKVCq0=
Date:   Thu, 1 Oct 2020 15:38:52 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 05/14] fs: don't allow kernel reads and writes without
 iter ops
Message-ID: <20201001223852.GA855@sol.localdomain>
References: <20200903142242.925828-1-hch@lst.de>
 <20200903142242.925828-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903142242.925828-6-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph, Al, and Linus:

On Thu, Sep 03, 2020 at 04:22:33PM +0200, Christoph Hellwig wrote:
> @@ -510,28 +524,31 @@ static ssize_t new_sync_write(struct file *filp, const char __user *buf, size_t
>  /* caller is responsible for file_start_write/file_end_write */
>  ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t *pos)
>  {
> -	mm_segment_t old_fs;
> -	const char __user *p;
> +	struct kvec iov = {
> +		.iov_base	= (void *)buf,
> +		.iov_len	= min_t(size_t, count, MAX_RW_COUNT),
> +	};
> +	struct kiocb kiocb;
> +	struct iov_iter iter;
>  	ssize_t ret;
>  
>  	if (WARN_ON_ONCE(!(file->f_mode & FMODE_WRITE)))
>  		return -EBADF;
>  	if (!(file->f_mode & FMODE_CAN_WRITE))
>  		return -EINVAL;
> +	/*
> +	 * Also fail if ->write_iter and ->write are both wired up as that
> +	 * implies very convoluted semantics.
> +	 */
> +	if (unlikely(!file->f_op->write_iter || file->f_op->write))
> +		return warn_unsupported(file, "write");
>  
> -	old_fs = get_fs();
> -	set_fs(KERNEL_DS);
> -	p = (__force const char __user *)buf;
> -	if (count > MAX_RW_COUNT)
> -		count =  MAX_RW_COUNT;
> -	if (file->f_op->write)
> -		ret = file->f_op->write(file, p, count, pos);
> -	else if (file->f_op->write_iter)
> -		ret = new_sync_write(file, p, count, pos);
> -	else
> -		ret = -EINVAL;
> -	set_fs(old_fs);
> +	init_sync_kiocb(&kiocb, file);
> +	kiocb.ki_pos = *pos;
> +	iov_iter_kvec(&iter, WRITE, &iov, 1, iov.iov_len);
> +	ret = file->f_op->write_iter(&kiocb, &iter);

next-20201001 crashes on boot for me because there is a bad interaction between
this commit in vfs/for-next:

	commit 4d03e3cc59828c82ee89ea6e27a2f3cdf95aaadf
	Author: Christoph Hellwig <hch@lst.de>
	Date:   Thu Sep 3 16:22:33 2020 +0200

	    fs: don't allow kernel reads and writes without iter ops

... and Linus's mainline commit:

	commit 90fb702791bf99b959006972e8ee7bb4609f441b
	Author: Linus Torvalds <torvalds@linux-foundation.org>
	Date:   Tue Sep 29 17:18:34 2020 -0700

	    autofs: use __kernel_write() for the autofs pipe writing

Linus's commit made autofs start passing pos=NULL to __kernel_write().
But, Christoph's commit made __kernel_write() no longer accept a NULL pos.

The following fixes it:

diff --git a/fs/autofs/waitq.c b/fs/autofs/waitq.c
index 5ced859dac53..b04c528b19d3 100644
--- a/fs/autofs/waitq.c
+++ b/fs/autofs/waitq.c
@@ -53,7 +53,7 @@ static int autofs_write(struct autofs_sb_info *sbi,
 
 	mutex_lock(&sbi->pipe_mutex);
 	while (bytes) {
-		wr = __kernel_write(file, data, bytes, NULL);
+		wr = __kernel_write(file, data, bytes, &file->f_pos);
 		if (wr <= 0)
 			break;
 		data += wr;

I'm not sure what was intended, though.

Full stack trace below.

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 12 PID: 383 Comm: systemd-binfmt Tainted: G                T 5.9.0-rc7-next-20201001 #2
Hardware name: Gigabyte Technology Co., Ltd. X399 AORUS Gaming 7/X399 AORUS Gaming 7, BIOS F2 08/31/2017
RIP: 0010:init_sync_kiocb include/linux/fs.h:2050 [inline]
RIP: 0010:__kernel_write+0x16c/0x2b0 fs/read_write.c:546
Code: 24 4a b9 01 00 00 00 0f 45 c7 be 01 00 00 00 48 8d 7c 24 10 48 c7 44 24 40 00 00 00 00 48 c7 44 24 58 00 00 00 00 89 44 24 4c <48> 8b 03 48 c7 44 24 60 00 00 00 00 48 89 44 24 50 4c 89 64 24 38
RSP: 0018:ffffa2fc0102f8b0 EFLAGS: 00010246
RAX: 0000000000020000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: ffffa2fc0102f8b0 RSI: 0000000000000001 RDI: ffffa2fc0102f8c0
RBP: ffff8ad2927e2940 R08: 0000000000000130 R09: ffff8ad29a201800
R10: 000000000000000f R11: ffff8ad292547510 R12: ffff8ad2927e2940
R13: ffffa2fc0102f8e8 R14: ffff8ad29a951768 R15: 0000000000000130
FS:  00007f11023b9000(0000) GS:ffff8ad29ed00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000857b62000 CR4: 00000000003506e0
Call Trace:
 autofs_write fs/autofs/waitq.c:56 [inline]
 autofs_notify_daemon.constprop.0+0x115/0x260 fs/autofs/waitq.c:163
 autofs_wait+0x5b1/0x750 fs/autofs/waitq.c:465
 autofs_mount_wait+0x2d/0x60 fs/autofs/root.c:250
 autofs_d_automount+0xc4/0x1a0 fs/autofs/root.c:379
 follow_automount fs/namei.c:1198 [inline]
 __traverse_mounts+0x8d/0x230 fs/namei.c:1243
 traverse_mounts fs/namei.c:1272 [inline]
 handle_mounts fs/namei.c:1381 [inline]
 step_into+0x44e/0x730 fs/namei.c:1691
 walk_component+0x7e/0x1b0 fs/namei.c:1867
 link_path_walk+0x270/0x3b0 fs/namei.c:2184
 path_openat+0x90/0xe40 fs/namei.c:3365
 do_filp_open+0x98/0x140 fs/namei.c:3396
 do_sys_openat2+0xac/0x170 fs/open.c:1168
 do_sys_open fs/open.c:1184 [inline]
 __do_sys_openat fs/open.c:1200 [inline]
 __se_sys_openat fs/open.c:1195 [inline]
 __x64_sys_openat+0x51/0x90 fs/open.c:1195
 do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f11031d3c1b
Code: 25 00 00 41 00 3d 00 00 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 4c 24 28 64 48 2b 0c 25
RSP: 002b:00007ffda6c0a1c0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000020 RCX: 00007f11031d3c1b
RDX: 0000000000080101 RSI: 000055f65e114278 RDI: 00000000ffffff9c
random: lvm: uninitialized urandom read (4 bytes read)
RBP: 000055f65e114278 R08: 00000000ffffffff R09: 000055f65ef055d8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080101
R13: 000055f65e11434a R14: 0000000000000000 R15: 0000000000000000
CR2: 0000000000000000
---[ end trace 166ad5429f22801b ]---
