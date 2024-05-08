Return-Path: <linux-fsdevel+bounces-19138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4760C8C0798
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 01:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2DE72809C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 23:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7FB7D3FB;
	Wed,  8 May 2024 23:20:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail114-240.sinamail.sina.com.cn (mail114-240.sinamail.sina.com.cn [218.30.114.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1C2393
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 23:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715210405; cv=none; b=GBZqd0P/CeTd29FdHKu53G9U3hRZsvsLdErp7mSysXGOnpkW50YIOjqUZkyTFt8HjyNlwbuahvu0r3+foafgb+lUguQYjyZCGuzjywwMkB9hysU6+9x3LBVUwrCZMAIbFc50cR+32hiA8BqdA/+bZ0TrIis7SqmQkbv6OHY9vww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715210405; c=relaxed/simple;
	bh=1c7DWZndfIPznggPwRWDXBRacHcgOM3n3jV83krPvZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T9aA+GgPbY1eo4/2oh1PWiiJadYjpHZzLL56ceGwcX5u1AVcrWnNMFDWDSq5twvVw7EvrhqTBCYTou9KL39YiYQimDUGFL5LaVba0dEO6i8f9HjfI4ruLShoZzTvlZoQLzR6ppWT+CHZvnw9P7domd8L4aQuuuxzcEGOdDtKdEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.68.141])
	by sina.com (172.16.235.24) with ESMTP
	id 663C087200002DDE; Wed, 9 May 2024 07:19:16 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 30334845089175
X-SMAIL-UIID: 4F517887A2F04F25BD5F1E1DED0636A7-20240509-071916-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+4c493dcd5a68168a94b2@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_seq_start
Date: Thu,  9 May 2024 07:19:04 +0800
Message-Id: <20240508231904.2259-1-hdanton@sina.com>
In-Reply-To: <00000000000091228c0617eaae32@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 07 May 2024 22:36:18 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    dccb07f2914c Merge tag 'for-6.9-rc7-tag' of git://git.kern..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=137daa6c980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7ea7de0cb32587
> dashboard link: https://syzkaller.appspot.com/bug?extid=4c493dcd5a68168a94b2
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1134f3c0980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1367a504980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ea1961ce01fe/disk-dccb07f2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/445a00347402/vmlinux-dccb07f2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/461aed7c4df3/bzImage-dccb07f2.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4c493dcd5a68168a94b2@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.9.0-rc7-syzkaller-00012-gdccb07f2914c #0 Not tainted
> ------------------------------------------------------
> syz-executor149/5078 is trying to acquire lock:
> ffff88802a978888 (&of->mutex){+.+.}-{3:3}, at: kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154
> 
> but task is already holding lock:
> ffff88802d80b540 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xb7/0xd60 fs/seq_file.c:182
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #4 (&p->lock){+.+.}-{3:3}:
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
>        __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>        __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
>        seq_read_iter+0xb7/0xd60 fs/seq_file.c:182
>        call_read_iter include/linux/fs.h:2104 [inline]
>        copy_splice_read+0x662/0xb60 fs/splice.c:365
>        do_splice_read fs/splice.c:985 [inline]
>        splice_file_to_pipe+0x299/0x500 fs/splice.c:1295
>        do_sendfile+0x515/0xdc0 fs/read_write.c:1301
>        __do_sys_sendfile64 fs/read_write.c:1362 [inline]
>        __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1348
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #3 (&pipe->mutex){+.+.}-{3:3}:
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
>        __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>        __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
>        iter_file_splice_write+0x335/0x14e0 fs/splice.c:687
>        backing_file_splice_write+0x2bc/0x4c0 fs/backing-file.c:289
>        ovl_splice_write+0x3cf/0x500 fs/overlayfs/file.c:379
>        do_splice_from fs/splice.c:941 [inline]
>        do_splice+0xd77/0x1880 fs/splice.c:1354
>        __do_splice fs/splice.c:1436 [inline]
>        __do_sys_splice fs/splice.c:1652 [inline]
>        __se_sys_splice+0x331/0x4a0 fs/splice.c:1634
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #2 (sb_writers#4){.+.+}-{0:0}:
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
>        percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
>        __sb_start_write include/linux/fs.h:1664 [inline]
>        sb_start_write+0x4d/0x1c0 include/linux/fs.h:1800
>        mnt_want_write+0x3f/0x90 fs/namespace.c:409
>        ovl_create_object+0x13b/0x370 fs/overlayfs/dir.c:629
>        lookup_open fs/namei.c:3497 [inline]
>        open_last_lookups fs/namei.c:3566 [inline]
>        path_openat+0x1425/0x3240 fs/namei.c:3796
>        do_filp_open+0x235/0x490 fs/namei.c:3826
>        do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
>        do_sys_open fs/open.c:1421 [inline]
>        __do_sys_open fs/open.c:1429 [inline]
>        __se_sys_open fs/open.c:1425 [inline]
>        __x64_sys_open+0x225/0x270 fs/open.c:1425
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #1 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}:
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
>        down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
>        inode_lock_shared include/linux/fs.h:805 [inline]
>        lookup_slow+0x45/0x70 fs/namei.c:1708
>        walk_component+0x2e1/0x410 fs/namei.c:2004
>        lookup_last fs/namei.c:2461 [inline]
>        path_lookupat+0x16f/0x450 fs/namei.c:2485
>        filename_lookup+0x256/0x610 fs/namei.c:2514
>        kern_path+0x35/0x50 fs/namei.c:2622
>        lookup_bdev+0xc5/0x290 block/bdev.c:1136
>        resume_store+0x1a0/0x710 kernel/power/hibernate.c:1235
>        kernfs_fop_write_iter+0x3a1/0x500 fs/kernfs/file.c:334
>        call_write_iter include/linux/fs.h:2110 [inline]
>        new_sync_write fs/read_write.c:497 [inline]
>        vfs_write+0xa84/0xcb0 fs/read_write.c:590
>        ksys_write+0x1a0/0x2c0 fs/read_write.c:643
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #0 (&of->mutex){+.+.}-{3:3}:
>        check_prev_add kernel/locking/lockdep.c:3134 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>        validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
>        __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
>        __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>        __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
>        kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154
>        traverse+0x14f/0x550 fs/seq_file.c:106
>        seq_read_iter+0xc5e/0xd60 fs/seq_file.c:195
>        call_read_iter include/linux/fs.h:2104 [inline]
>        copy_splice_read+0x662/0xb60 fs/splice.c:365
>        do_splice_read fs/splice.c:985 [inline]
>        splice_file_to_pipe+0x299/0x500 fs/splice.c:1295
>        do_sendfile+0x515/0xdc0 fs/read_write.c:1301
>        __do_sys_sendfile64 fs/read_write.c:1362 [inline]
>        __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1348
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   &of->mutex --> &pipe->mutex --> &p->lock
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&p->lock);
>                                lock(&pipe->mutex);
>                                lock(&p->lock);
>   lock(&of->mutex);
> 
>  *** DEADLOCK ***

This shows 16b52bbee482 ("kernfs: annotate different lockdep class for
of->mutex of writable files") is a bandaid.
> 
> 2 locks held by syz-executor149/5078:
>  #0: ffff88807de89868 (&pipe->mutex){+.+.}-{3:3}, at: splice_file_to_pipe+0x2e/0x500 fs/splice.c:1292
>  #1: ffff88802d80b540 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xb7/0xd60 fs/seq_file.c:182
> 
> stack backtrace:
> CPU: 0 PID: 5078 Comm: syz-executor149 Not tainted 6.9.0-rc7-syzkaller-00012-gdccb07f2914c #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
>  check_prev_add kernel/locking/lockdep.c:3134 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>  validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
>  __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
>  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
>  __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>  __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
>  kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154
>  traverse+0x14f/0x550 fs/seq_file.c:106
>  seq_read_iter+0xc5e/0xd60 fs/seq_file.c:195
>  call_read_iter include/linux/fs.h:2104 [inline]
>  copy_splice_read+0x662/0xb60 fs/splice.c:365
>  do_splice_read fs/splice.c:985 [inline]
>  splice_file_to_pipe+0x299/0x500 fs/splice.c:1295
>  do_sendfile+0x515/0xdc0 fs/read_write.c:1301
>  __do_sys_sendfile64 fs/read_write.c:1362 [inline]
>  __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1348
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f7d8d33f8e9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f7d8d2b8218 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 00007f7d8d3c9428 RCX: 00007f7d8d33f8e9
> RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000006
> RBP: 00007f7d8d3c9420 R08: 00007ffdc82d7c57 R09: 0000000000000000
> R10: 0000000000000004 R11: 0000000000000246 R12: 00007f7d8d39606c
> R13: 0030656c69662f2e R14: 0079616c7265766f R15: 00007f7d8d39603b
>  </TASK>
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 

