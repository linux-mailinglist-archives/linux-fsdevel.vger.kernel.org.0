Return-Path: <linux-fsdevel+bounces-1503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 604F97DAA15
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Oct 2023 00:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41DB41C209C1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 22:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AE417997;
	Sat, 28 Oct 2023 22:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B371315ADA
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 22:43:33 +0000 (UTC)
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D76CD6
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 15:43:31 -0700 (PDT)
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-6ce53378ff9so4127994a34.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 15:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698533010; x=1699137810;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kKaKu5M6rUWJh/V22wyQQBR72UTXCs6uvQVuL0NHfts=;
        b=Mx+kJw0crrsYmE82L6JMqwYUZ+FxAuJKtb93qGmO3JBl0SrwqkbKAcbNLHlOiAgL8I
         wOerPOzTYS3pn3pJ80XbnloQICJK0vmxjLBof1amRWdWlhMAk7GS56IE9HMmYk+STcqA
         9aRcoqZ8J5XsU0mr2xwplsSNnzT3wQtBbgBef3SMZ7raNmPDH23jY4vlHR+WFe8c87E8
         PHg9ndAWtpbYdXt8TCAHZ7P2HaHE4yklj+DFFB8joHmRsyiAGr4SgBZUKd48GilJxBX1
         oeerdyp59607JB34tn2ATZp6TONEJQ2R6CqHE2gw2QDUCsFl6jUKJqLqitF9JgybvT58
         SARA==
X-Gm-Message-State: AOJu0YwrgSpDwLPzTTNGXYpzeVYsKotoFEGIwGjY+C+fYFCmOa+oY580
	0zRwEh2DQp6Q4DGJYR8nNcoNPfrceK0VdZr4Xtjj94SQ4VPM
X-Google-Smtp-Source: AGHT+IGKwmSwzHpWoYMQnqtejvR5tj1v/Fm5QD/4uFVJ2R0ycnP3BmYS+ecZGOcPw+BjAN7wforn14PtxPXE+zfPd1D2q82uAfex
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6830:4687:b0:6c6:2b19:7270 with SMTP id
 ay7-20020a056830468700b006c62b197270mr2352287otb.1.1698533010599; Sat, 28 Oct
 2023 15:43:30 -0700 (PDT)
Date: Sat, 28 Oct 2023 15:43:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc767f0608ce8895@google.com>
Subject: [syzbot] [ntfs3?] possible deadlock in indx_read
From: syzbot <syzbot+1e19c0a6b5e324635721@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f017d9a92a73 Add linux-next specific files for 20231024
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=114f9135680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8fd5ab06ad389b6f
dashboard link: https://syzkaller.appspot.com/bug?extid=1e19c0a6b5e324635721
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/feca2ffa52fd/disk-f017d9a9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c2643e9e7d02/vmlinux-f017d9a9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7492edb5b60c/bzImage-f017d9a9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1e19c0a6b5e324635721@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.6.0-rc7-next-20231024-syzkaller #0 Not tainted
------------------------------------------------------
kworker/u4:0/24418 is trying to acquire lock:
ffff888039a1e1c0 (&indx->run_lock){.+.+}-{3:3}, at: indx_read+0x251/0xcd0 fs/ntfs3/index.c:1066

but task is already holding lock:
ffff888039a1e0e0 (&ni->ni_lock#2){+.+.}-{3:3}, at: ni_trylock fs/ntfs3/ntfs_fs.h:1144 [inline]
ffff888039a1e0e0 (&ni->ni_lock#2){+.+.}-{3:3}, at: ni_update_parent fs/ntfs3/frecord.c:3230 [inline]
ffff888039a1e0e0 (&ni->ni_lock#2){+.+.}-{3:3}, at: ni_write_inode+0x15a4/0x2850 fs/ntfs3/frecord.c:3321

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&ni->ni_lock#2){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x181/0x1330 kernel/locking/mutex.c:747
       ntfs_set_state+0x1d2/0x6a0 fs/ntfs3/fsntfs.c:946
       ni_remove_name+0x2ff/0x670 fs/ntfs3/frecord.c:2926
       ntfs_unlink_inode+0x37a/0x740 fs/ntfs3/inode.c:1772
       ntfs_rename+0x387/0xec0 fs/ntfs3/namei.c:288
       vfs_rename+0xe20/0x1c30 fs/namei.c:4843
       do_renameat2+0xc3c/0xdc0 fs/namei.c:4995
       __do_sys_rename fs/namei.c:5041 [inline]
       __se_sys_rename fs/namei.c:5039 [inline]
       __x64_sys_rename+0x81/0xa0 fs/namei.c:5039
       do_syscall_x64 arch/x86/entry/common.c:51 [inline]
       do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
       entry_SYSCALL_64_after_hwframe+0x62/0x6a

-> #3 (&ni->ni_lock#2/4){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x181/0x1330 kernel/locking/mutex.c:747
       ni_lock fs/ntfs3/ntfs_fs.h:1124 [inline]
       ntfs_fallocate+0x73d/0x1260 fs/ntfs3/file.c:499
       vfs_fallocate+0x46c/0xe50 fs/open.c:324
       ksys_fallocate fs/open.c:347 [inline]
       __do_sys_fallocate fs/open.c:355 [inline]
       __se_sys_fallocate fs/open.c:353 [inline]
       __x64_sys_fallocate+0xd5/0x140 fs/open.c:353
       do_syscall_x64 arch/x86/entry/common.c:51 [inline]
       do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
       entry_SYSCALL_64_after_hwframe+0x62/0x6a

-> #2 (mapping.invalidate_lock#5){++++}-{3:3}:
       down_read+0x9c/0x470 kernel/locking/rwsem.c:1526
       filemap_invalidate_lock_shared include/linux/fs.h:857 [inline]
       filemap_fault+0x28c/0x3570 mm/filemap.c:3225
       __do_fault+0x107/0x5f0 mm/memory.c:4268
       do_read_fault mm/memory.c:4631 [inline]
       do_fault mm/memory.c:4765 [inline]
       do_pte_missing mm/memory.c:3733 [inline]
       handle_pte_fault mm/memory.c:5041 [inline]
       __handle_mm_fault+0x2682/0x3d60 mm/memory.c:5182
       handle_mm_fault+0x474/0x9f0 mm/memory.c:5347
       faultin_page mm/gup.c:956 [inline]
       __get_user_pages+0x4b1/0x1480 mm/gup.c:1239
       populate_vma_page_range+0x2d4/0x410 mm/gup.c:1677
       __mm_populate+0x1d6/0x380 mm/gup.c:1786
       mm_populate include/linux/mm.h:3379 [inline]
       vm_mmap_pgoff+0x2cc/0x3b0 mm/util.c:551
       ksys_mmap_pgoff+0x421/0x5a0 mm/mmap.c:1428
       __do_sys_mmap arch/x86/kernel/sys_x86_64.c:93 [inline]
       __se_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
       __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:86
       do_syscall_x64 arch/x86/entry/common.c:51 [inline]
       do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
       entry_SYSCALL_64_after_hwframe+0x62/0x6a

-> #1 (&mm->mmap_lock){++++}-{3:3}:
       __might_fault mm/memory.c:5958 [inline]
       __might_fault+0x11b/0x190 mm/memory.c:5951
       _copy_to_user+0x2b/0xb0 lib/usercopy.c:36
       copy_to_user include/linux/uaccess.h:191 [inline]
       fiemap_fill_next_extent+0x232/0x380 fs/ioctl.c:145
       ni_fiemap+0x440/0xc00 fs/ntfs3/frecord.c:2065
       ntfs_fiemap+0xc9/0x110 fs/ntfs3/file.c:1164
       ioctl_fiemap fs/ioctl.c:220 [inline]
       do_vfs_ioctl+0x339/0x1920 fs/ioctl.c:811
       __do_sys_ioctl fs/ioctl.c:869 [inline]
       __se_sys_ioctl fs/ioctl.c:857 [inline]
       __x64_sys_ioctl+0x112/0x210 fs/ioctl.c:857
       do_syscall_x64 arch/x86/entry/common.c:51 [inline]
       do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
       entry_SYSCALL_64_after_hwframe+0x62/0x6a

-> #0 (&indx->run_lock){.+.+}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x2e22/0x5dc0 kernel/locking/lockdep.c:5136
       lock_acquire kernel/locking/lockdep.c:5753 [inline]
       lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
       down_read+0x9c/0x470 kernel/locking/rwsem.c:1526
       indx_read+0x251/0xcd0 fs/ntfs3/index.c:1066
       indx_find+0x4a9/0x980 fs/ntfs3/index.c:1181
       indx_update_dup+0x166/0x440 fs/ntfs3/index.c:2659
       ni_update_parent fs/ntfs3/frecord.c:3233 [inline]
       ni_write_inode+0x1650/0x2850 fs/ntfs3/frecord.c:3321
       write_inode fs/fs-writeback.c:1473 [inline]
       __writeback_single_inode+0xa84/0xe60 fs/fs-writeback.c:1690
       writeback_sb_inodes+0x5a2/0x1090 fs/fs-writeback.c:1916
       __writeback_inodes_wb+0xff/0x2d0 fs/fs-writeback.c:1987
       wb_writeback+0x7fe/0xaa0 fs/fs-writeback.c:2094
       wb_check_old_data_flush fs/fs-writeback.c:2198 [inline]
       wb_do_writeback fs/fs-writeback.c:2251 [inline]
       wb_workfn+0x9f8/0xfd0 fs/fs-writeback.c:2279
       process_one_work+0x8a2/0x15e0 kernel/workqueue.c:2630
       process_scheduled_works kernel/workqueue.c:2703 [inline]
       worker_thread+0x8b6/0x1280 kernel/workqueue.c:2784
       kthread+0x337/0x440 kernel/kthread.c:388
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

other info that might help us debug this:

Chain exists of:
  &indx->run_lock --> &ni->ni_lock#2/4 --> &ni->ni_lock#2

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ni->ni_lock#2);
                               lock(&ni->ni_lock#2/4);
                               lock(&ni->ni_lock#2);
  rlock(&indx->run_lock);

 *** DEADLOCK ***

5 locks held by kworker/u4:0/24418:
 #0: ffff88814226d938 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x78a/0x15e0 kernel/workqueue.c:2605
 #1: ffffc9000326fd80 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x7f4/0x15e0 kernel/workqueue.c:2606
 #2: ffff888030fde0e0 (&type->s_umount_key#65){++++}-{3:3}, at: super_trylock_shared+0x1e/0xf0 fs/super.c:610
 #3: ffff888039a1e840 (&ni->ni_lock#2){+.+.}-{3:3}, at: ni_trylock fs/ntfs3/ntfs_fs.h:1144 [inline]
 #3: ffff888039a1e840 (&ni->ni_lock#2){+.+.}-{3:3}, at: ni_write_inode+0x1c6/0x2850 fs/ntfs3/frecord.c:3262
 #4: ffff888039a1e0e0 (&ni->ni_lock#2){+.+.}-{3:3}, at: ni_trylock fs/ntfs3/ntfs_fs.h:1144 [inline]
 #4: ffff888039a1e0e0 (&ni->ni_lock#2){+.+.}-{3:3}, at: ni_update_parent fs/ntfs3/frecord.c:3230 [inline]
 #4: ffff888039a1e0e0 (&ni->ni_lock#2){+.+.}-{3:3}, at: ni_write_inode+0x15a4/0x2850 fs/ntfs3/frecord.c:3321

stack backtrace:
CPU: 1 PID: 24418 Comm: kworker/u4:0 Not tainted 6.6.0-rc7-next-20231024-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Workqueue: writeback wb_workfn (flush-7:4)
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 check_noncircular+0x310/0x3f0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x2e22/0x5dc0 kernel/locking/lockdep.c:5136
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
 down_read+0x9c/0x470 kernel/locking/rwsem.c:1526
 indx_read+0x251/0xcd0 fs/ntfs3/index.c:1066
 indx_find+0x4a9/0x980 fs/ntfs3/index.c:1181
 indx_update_dup+0x166/0x440 fs/ntfs3/index.c:2659
 ni_update_parent fs/ntfs3/frecord.c:3233 [inline]
 ni_write_inode+0x1650/0x2850 fs/ntfs3/frecord.c:3321
 write_inode fs/fs-writeback.c:1473 [inline]
 __writeback_single_inode+0xa84/0xe60 fs/fs-writeback.c:1690
 writeback_sb_inodes+0x5a2/0x1090 fs/fs-writeback.c:1916
 __writeback_inodes_wb+0xff/0x2d0 fs/fs-writeback.c:1987
 wb_writeback+0x7fe/0xaa0 fs/fs-writeback.c:2094
 wb_check_old_data_flush fs/fs-writeback.c:2198 [inline]
 wb_do_writeback fs/fs-writeback.c:2251 [inline]
 wb_workfn+0x9f8/0xfd0 fs/fs-writeback.c:2279
 process_one_work+0x8a2/0x15e0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b6/0x1280 kernel/workqueue.c:2784
 kthread+0x337/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

