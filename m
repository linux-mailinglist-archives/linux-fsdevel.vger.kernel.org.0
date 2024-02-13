Return-Path: <linux-fsdevel+bounces-11356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AA8852FBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 12:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A92E1C25211
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 11:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A52381B4;
	Tue, 13 Feb 2024 11:42:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail3-163.sinamail.sina.com.cn (mail3-163.sinamail.sina.com.cn [202.108.3.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8454A38DDF
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 11:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824539; cv=none; b=GxIk7Fp2UeYOyJZ5t7rtoo19pyz12JUYp5Ch42ow30to4Mx3h8s9P8e+f2vcpyrTd7j3Y5tVqetCGnlrUyWOXowhCkH9J/3lC9TRYyPovd9Joq641AflE6zsMe5DnFdh7wqWncn66fzv5Qj83ab4pyHiFbJ1FQkYMe5hcGdTWic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824539; c=relaxed/simple;
	bh=oSxe1FJZlCGcbRapDJTRHz75Y/P6sXJvOGbg3MtEggU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfvJgWCIa5Tz/bFUO7ufjgLjZwT5pxxp7FylGLo9CKrSrnL6bbjhJkU1W7ZnR2Glw3EatfRmOkNLMh9V7NQXI9EZdsvaWX4E2iORrFe8xprG3AJCuLRgM4qK3o40ScI4opDXaYXAKTn49xsO6pTVsARNFJJxpbRXrJW3U4pD1o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=202.108.3.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.59.61])
	by sina.com (10.182.253.22) with ESMTP
	id 65CB558C00007BC9; Tue, 13 Feb 2024 19:42:06 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3290486816228
X-SMAIL-UIID: FEEA4E0FB2D3410CBE3ECB306D4FB6FA-20240213-194206-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+c2ada45c23d98d646118@syzkaller.appspotmail.com>
Cc: almaz.alexandrovich@paragon-software.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntfs3@lists.linux.dev,
	Boqun Feng <boqun.feng@gmail.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_set_state (2)
Date: Tue, 13 Feb 2024 19:41:50 +0800
Message-ID: <20240213114151.982-1-hdanton@sina.com>
In-Reply-To: <000000000000998cff06113e1d91@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 12 Feb 2024 23:12:22 -0800
> HEAD commit:    716f4aaa7b48 Merge tag 'vfs-6.8-rc5.fixes' of git://git.ke..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=100fd062180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1d7c92dd8d5c7a1e
> dashboard link: https://syzkaller.appspot.com/bug?extid=c2ada45c23d98d646118
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11fcbd48180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f6e642180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ca4bf59e5a18/disk-716f4aaa.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3d7ade517e63/vmlinux-716f4aaa.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e13f7054c0c1/bzImage-716f4aaa.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/00ba9c2f3dd0/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c2ada45c23d98d646118@syzkaller.appspotmail.com
> 
> loop0: detected capacity change from 0 to 4096
> ntfs3: loop0: Different NTFS sector size (4096) and media sector size (512).
> ntfs3: loop0: ino=5, "/" ntfs_iget5
> ============================================
> WARNING: possible recursive locking detected
> 6.8.0-rc4-syzkaller-00003-g716f4aaa7b48 #0 Not tainted
> --------------------------------------------
> syz-executor354/5071 is trying to acquire lock:
> ffff888070ee0100 (&ni->ni_lock#3){+.+.}-{3:3}, at: ntfs_set_state+0x1ff/0x6c0 fs/ntfs3/fsntfs.c:947
> 
> but task is already holding lock:
> ffff888070de3c00 (&ni->ni_lock#3){+.+.}-{3:3}, at: ni_trylock fs/ntfs3/ntfs_fs.h:1141 [inline]
> ffff888070de3c00 (&ni->ni_lock#3){+.+.}-{3:3}, at: ni_write_inode+0x1bc/0x1010 fs/ntfs3/frecord.c:3265
> 
This report looks false positive but raises the question -- what made lockedp
pull the wrong trigger? Because of the correct lock_class_key in mutex_init()
instead of &ni->ni_lock?

> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&ni->ni_lock#3);
>   lock(&ni->ni_lock#3);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> 3 locks held by syz-executor354/5071:
>  #0: ffff88802223a420 (sb_writers#9){.+.+}-{0:0}, at: do_sys_ftruncate+0x25c/0x390 fs/open.c:191
>  #1: ffff888070de3ea0 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:802 [inline]
>  #1: ffff888070de3ea0 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: do_truncate+0x20c/0x310 fs/open.c:64
>  #2: ffff888070de3c00 (&ni->ni_lock#3){+.+.}-{3:3}, at: ni_trylock fs/ntfs3/ntfs_fs.h:1141 [inline]
>  #2: ffff888070de3c00 (&ni->ni_lock#3){+.+.}-{3:3}, at: ni_write_inode+0x1bc/0x1010 fs/ntfs3/frecord.c:3265
> 
> stack backtrace:
> CPU: 0 PID: 5071 Comm: syz-executor354 Not tainted 6.8.0-rc4-syzkaller-00003-g716f4aaa7b48 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
>  check_deadlock kernel/locking/lockdep.c:3062 [inline]
>  validate_chain+0x15c0/0x58e0 kernel/locking/lockdep.c:3856
>  __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
>  lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
>  __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>  __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
>  ntfs_set_state+0x1ff/0x6c0 fs/ntfs3/fsntfs.c:947
>  ntfs_iget5+0x3f0/0x3b70 fs/ntfs3/inode.c:535
>  ni_update_parent+0x943/0xdd0 fs/ntfs3/frecord.c:3218
>  ni_write_inode+0xde9/0x1010 fs/ntfs3/frecord.c:3324
>  ntfs_truncate fs/ntfs3/file.c:410 [inline]
>  ntfs3_setattr+0x950/0xb40 fs/ntfs3/file.c:703
>  notify_change+0xb9f/0xe70 fs/attr.c:499
>  do_truncate+0x220/0x310 fs/open.c:66
>  do_sys_ftruncate+0x2f7/0x390 fs/open.c:194
>  do_syscall_64+0xfb/0x240
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> RIP: 0033:0x7fd0ca446639
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff0baab678 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
> RAX: ffffffffffffffda RBX: 00007fff0baab848 RCX: 00007fd0ca446639
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
> RBP: 00007fd0ca4d8610 R08: 0000000000000000 R09: 00007fff0baab848
> R10: 000000000001f20a R11: 0000000000000246 R12: 0000000000000001
> R13: 00007fff0baab838 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 

