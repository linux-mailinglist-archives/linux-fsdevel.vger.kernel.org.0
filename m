Return-Path: <linux-fsdevel+bounces-19165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE7D8C0E8F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 12:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 420362811F9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 10:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4D31311A1;
	Thu,  9 May 2024 10:51:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail78-58.sinamail.sina.com.cn (mail78-58.sinamail.sina.com.cn [219.142.78.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8374F12F5B8
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 May 2024 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715251891; cv=none; b=Vmj6X1NLTNZrMiuYzazwRdDo+Qpt8wZynLRIY4w6qjVVM1IfDjUf8rYr1DAS3XuNGmmylnHJFaU39QItnXmiRmV3wzXkuV22uLmBewZ8sddGj1wriUYg5VyuV3/Ur0fywNGkxUdhuYJOkrZcUiOipuaLR2+ViKZoQFZS0/WNXzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715251891; c=relaxed/simple;
	bh=c1hPixAJvj3AHl/3CV8F+R2t09WL5v2tVYkTtNhiEpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQj1bN7SgzfbQc7QrT8gVxokQhuvFT4SGUtXO9d/tsc+cTpgxqkxYAuLiYNWOIM1YEd9Mts6aT+RuZQIsEOeHAJDojx2FpCdBhZu2MtIzHJsK9cGuedyx+KkSguCTdI8CUPbWFzPxBjbX7ofLx1PgTwsx7j99EnTNikfYcJk+8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.68.141])
	by sina.com (172.16.235.25) with ESMTP
	id 663CAA1900006869; Thu, 9 May 2024 18:49:00 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 29018234210318
X-SMAIL-UIID: DA2DDA9809B844E8B5B5CAF31DD56CD1-20240509-184900-1
From: Hillf Danton <hdanton@sina.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: syzbot <syzbot+4c493dcd5a68168a94b2@syzkaller.appspotmail.com>,
	linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	linux-pm@vger.kernel.org
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_seq_start
Date: Thu,  9 May 2024 18:48:48 +0800
Message-Id: <20240509104848.2403-1-hdanton@sina.com>
In-Reply-To: <CAOQ4uxhDBbSh-4xbLgS=e6LtaZe2-E9Scgb9uP4ysCZEGG2skA@mail.gmail.com>
References: <00000000000091228c0617eaae32@google.com> <20240508231904.2259-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 9 May 2024 09:37:24 +0300 Amir Goldstein <amir73il@gmail.com>
> On Thu, May 9, 2024 at 2:19 AM Hillf Danton <hdanton@sina.com> wrote:
> > On Tue, 07 May 2024 22:36:18 -0700
> > > syzbot has found a reproducer for the following issue on:
> > >
> > > HEAD commit:    dccb07f2914c Merge tag 'for-6.9-rc7-tag' of git://git.kern..
> > > git tree:       upstream
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=137daa6c980000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7ea7de0cb32587
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=4c493dcd5a68168a94b2
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1134f3c0980000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1367a504980000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/ea1961ce01fe/disk-dccb07f2.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/445a00347402/vmlinux-dccb07f2.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/461aed7c4df3/bzImage-dccb07f2.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+4c493dcd5a68168a94b2@syzkaller.appspotmail.com
> > >
> > > ======================================================
> > > WARNING: possible circular locking dependency detected
> > > 6.9.0-rc7-syzkaller-00012-gdccb07f2914c #0 Not tainted
> > > ------------------------------------------------------
> > > syz-executor149/5078 is trying to acquire lock:
> > > ffff88802a978888 (&of->mutex){+.+.}-{3:3}, at: kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154
> > >
> > > but task is already holding lock:
> > > ffff88802d80b540 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xb7/0xd60 fs/seq_file.c:182
> > >
> > > which lock already depends on the new lock.
> > >
> > >
> > > the existing dependency chain (in reverse order) is:
> > >
> > > -> #4 (&p->lock){+.+.}-{3:3}:
> > >        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
> > >        __mutex_lock_common kernel/locking/mutex.c:608 [inline]
> > >        __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
> > >        seq_read_iter+0xb7/0xd60 fs/seq_file.c:182
> > >        call_read_iter include/linux/fs.h:2104 [inline]
> > >        copy_splice_read+0x662/0xb60 fs/splice.c:365
> > >        do_splice_read fs/splice.c:985 [inline]
> > >        splice_file_to_pipe+0x299/0x500 fs/splice.c:1295
> > >        do_sendfile+0x515/0xdc0 fs/read_write.c:1301
> > >        __do_sys_sendfile64 fs/read_write.c:1362 [inline]
> > >        __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1348
> > >        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >        do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
> > >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > -> #3 (&pipe->mutex){+.+.}-{3:3}:
> > >        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
> > >        __mutex_lock_common kernel/locking/mutex.c:608 [inline]
> > >        __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
> > >        iter_file_splice_write+0x335/0x14e0 fs/splice.c:687
> > >        backing_file_splice_write+0x2bc/0x4c0 fs/backing-file.c:289
> > >        ovl_splice_write+0x3cf/0x500 fs/overlayfs/file.c:379
> > >        do_splice_from fs/splice.c:941 [inline]
> > >        do_splice+0xd77/0x1880 fs/splice.c:1354

		file_start_write(out);
		ret = do_splice_from(ipipe, out, &offset, len, flags);
		file_end_write(out);

The correct locking order is

		sb_writers
		inode lock

> > >        __do_splice fs/splice.c:1436 [inline]
> > >        __do_sys_splice fs/splice.c:1652 [inline]
> > >        __se_sys_splice+0x331/0x4a0 fs/splice.c:1634
> > >        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >        do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
> > >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > -> #2 (sb_writers#4){.+.+}-{0:0}:
> > >        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
> > >        percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
> > >        __sb_start_write include/linux/fs.h:1664 [inline]
> > >        sb_start_write+0x4d/0x1c0 include/linux/fs.h:1800
> > >        mnt_want_write+0x3f/0x90 fs/namespace.c:409

but inverse order occurs here.

> > >        ovl_create_object+0x13b/0x370 fs/overlayfs/dir.c:629
> > >        lookup_open fs/namei.c:3497 [inline]
> > >        open_last_lookups fs/namei.c:3566 [inline]
> > >        path_openat+0x1425/0x3240 fs/namei.c:3796
> > >        do_filp_open+0x235/0x490 fs/namei.c:3826
> > >        do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
> > >        do_sys_open fs/open.c:1421 [inline]
> > >        __do_sys_open fs/open.c:1429 [inline]
> > >        __se_sys_open fs/open.c:1425 [inline]
> > >        __x64_sys_open+0x225/0x270 fs/open.c:1425
> > >        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >        do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
> > >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > -> #1 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}:
> > >        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
> > >        down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
> > >        inode_lock_shared include/linux/fs.h:805 [inline]
> > >        lookup_slow+0x45/0x70 fs/namei.c:1708
> > >        walk_component+0x2e1/0x410 fs/namei.c:2004
> > >        lookup_last fs/namei.c:2461 [inline]
> > >        path_lookupat+0x16f/0x450 fs/namei.c:2485
> > >        filename_lookup+0x256/0x610 fs/namei.c:2514
> > >        kern_path+0x35/0x50 fs/namei.c:2622
> > >        lookup_bdev+0xc5/0x290 block/bdev.c:1136
> > >        resume_store+0x1a0/0x710 kernel/power/hibernate.c:1235
> > >        kernfs_fop_write_iter+0x3a1/0x500 fs/kernfs/file.c:334
> > >        call_write_iter include/linux/fs.h:2110 [inline]
> > >        new_sync_write fs/read_write.c:497 [inline]
> > >        vfs_write+0xa84/0xcb0 fs/read_write.c:590
> > >        ksys_write+0x1a0/0x2c0 fs/read_write.c:643
> > >        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >        do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
> > >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > -> #0 (&of->mutex){+.+.}-{3:3}:
> > >        check_prev_add kernel/locking/lockdep.c:3134 [inline]
> > >        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
> > >        validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
> > >        __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
> > >        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
> > >        __mutex_lock_common kernel/locking/mutex.c:608 [inline]
> > >        __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
> > >        kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154
> > >        traverse+0x14f/0x550 fs/seq_file.c:106
> > >        seq_read_iter+0xc5e/0xd60 fs/seq_file.c:195
> > >        call_read_iter include/linux/fs.h:2104 [inline]
> > >        copy_splice_read+0x662/0xb60 fs/splice.c:365
> > >        do_splice_read fs/splice.c:985 [inline]
> > >        splice_file_to_pipe+0x299/0x500 fs/splice.c:1295
> > >        do_sendfile+0x515/0xdc0 fs/read_write.c:1301
> > >        __do_sys_sendfile64 fs/read_write.c:1362 [inline]
> > >        __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1348
> > >        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >        do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
> > >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > other info that might help us debug this:
> > >
> > > Chain exists of:
> > >   &of->mutex --> &pipe->mutex --> &p->lock
> > >
> > >  Possible unsafe locking scenario:
> > >
> > >        CPU0                    CPU1
> > >        ----                    ----
> > >   lock(&p->lock);
> > >                                lock(&pipe->mutex);
> > >                                lock(&p->lock);
> > >   lock(&of->mutex);
> > >
> > >  *** DEADLOCK ***
> >
> > This shows 16b52bbee482 ("kernfs: annotate different lockdep class for
> > of->mutex of writable files") is a bandaid.
> 
> Well, nobody said that it fixes the root cause.
> But the annotation fix is correct, because the former report was
> really false positive one.
> 
> The root cause is resume_store() doing vfs path lookup.

resume_store() looks innocent before locking order above is explained.

> If we could deprecate this allegedly unneeded UAPI we should.
> 
> That said, all those lockdep warnings indicate a possible deadlock
> if someone tries to hibernate into an overlayfs file.
> 
> If root tries to do that then, this is either an attack or stupidity.
> Either Way the news flash from this report is "root may be able
> to deadlock kernel on purpose"
> Not very exciting and not likely to happen in the real world.
> 
> The remaining question is what to do about the lockdep reports.
> 
> Questions to PM maintainers:
> Any chance to deprecate writing path to /sys/power/resume?
> Userspace should have no problem getting the same done
> with writing dev number.
> 
> Thanks,
> Amir.

