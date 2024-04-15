Return-Path: <linux-fsdevel+bounces-16894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2198A4648
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 02:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67B4B1F218FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 00:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F55848D;
	Mon, 15 Apr 2024 00:11:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52FFA50
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 00:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713139881; cv=none; b=W9ZjjNRiBAHw2AubvrVFVyd+aw8aTmLNUDQQwkqGM7Xz+NRS9APthb3w9Ta6HAgxFY2pC70HX32JRD166fPmHDeM4DL+wHRqPdwFdtgDTkPqmvmnYpc1XhP6+tIzjDaykohCh5twsw35fa2F+3TOVxL5FKPq9AbRVyELTLVGCHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713139881; c=relaxed/simple;
	bh=y7sLsvC+sIsLPpOLvDRjnaMGEI7DDoGcr6wiZLTi7D0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mjMCfG9Z6m7QG2nzMwy8f+JHVBFDIp5BOASMpOse1uEYfLMbc/BtWqlnMSwL8N3PbbydCOGjfJC6wpZtvAP/fEFq1Nb/Ag/P6RhXtoQnZHTvpEvIsxBFNfKMmT/wnuoFV3ycVUlzxkGjmkLnXVhgCFcdUgDR11MeFHbdDUJ9Obc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc764c885bso338915439f.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Apr 2024 17:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713139879; x=1713744679;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9jiKT8kTE1128KEvfOtgwJoNA14ICV6Re1oSVw8v94A=;
        b=YeH2A7QzBq/XyvYK3CyHI4+IC023K83OOtHI2G1ac6YNqvyodv3qJuY8oishmIB+m1
         Cs/Db1dzv+tqgWWkFm+M6hh9jIE/sFOMNCN67J/8BgJhfckqMAPGQ1VHmc/yPUpqpkqi
         nmMOHxAlmLKOodAshEE7W/DtPQ4vltIDVbvKbPDovKCcju8bJk10k8xr4uMdbAmJD1hV
         ExoaGl5Lkrb853GiX1LiJHzGkxz/ypmTW/Okgwc2AdolTtWJcH1tPoaNcFtvL4pe+159
         YUewEWN1x5nrFqnJkad6Ufp2hZLgxlhm9Osug0XSUq/YVj+AX4G7qSe5OpHcuyw8btpo
         kuqg==
X-Forwarded-Encrypted: i=1; AJvYcCXUNLg194P4A7C4qe8V30qX8Bz8vAdZjyB4Sx7aZDq84X32DcBvLfo+qaR7ogBPV/8vgnnHcvrvEJS7Y6ZYBJ7k86ekel+lTBsPx1fSWw==
X-Gm-Message-State: AOJu0YwYDhMzJSg0PEILhu03tHHOkj71JvTNeN996hnQ1+QEl2RaYpKh
	S9DjKzWfy9XgrDd3b8gpffIQKQSIYQfTq5RISzSlhQjjDjtE12NqNSOT6J04paL38feEy8tpzIj
	+awbYjUxKfRP4qvzigcC0mEPEmK7WUi44Os7tUm5C3+smsTOC5uZ7e40=
X-Google-Smtp-Source: AGHT+IHnU2W5Tepq6j4kkQWoDzCwwPMiJCBd3BG8rHjbyQZcLrOSra26bYUeME/J2Sg0+54R4zH5NNn+KT3tYSETasXN3ZI1Becn
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:842a:b0:482:fc0f:e5a8 with SMTP id
 iq42-20020a056638842a00b00482fc0fe5a8mr198256jab.2.1713139879092; Sun, 14 Apr
 2024 17:11:19 -0700 (PDT)
Date: Sun, 14 Apr 2024 17:11:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1ae1a06161775de@google.com>
Subject: [syzbot] [xfs?] possible deadlock in xfs_ilock (2)
From: syzbot <syzbot+c6d7bff58a2218f14632@syzkaller.appspotmail.com>
To: chandan.babu@oracle.com, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    72374d71c315 Merge tag 'pull-sysfs-annotation-fix' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10639da3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=43fc40c117780e9b
dashboard link: https://syzkaller.appspot.com/bug?extid=c6d7bff58a2218f14632
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-72374d71.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0ea69c8c9aa6/vmlinux-72374d71.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fcfb8e2b6b87/bzImage-72374d71.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c6d7bff58a2218f14632@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc3-syzkaller-00399-g72374d71c315 #0 Not tainted
------------------------------------------------------
syz-executor.0/6233 is trying to acquire lock:
ffffffff8d9373c0 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:312 [inline]
ffffffff8d9373c0 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:3746 [inline]
ffffffff8d9373c0 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:3827 [inline]
ffffffff8d9373c0 (fs_reclaim){+.+.}-{0:0}, at: __do_kmalloc_node mm/slub.c:3965 [inline]
ffffffff8d9373c0 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc+0xb5/0x440 mm/slub.c:3979

but task is already holding lock:
ffff888028971858 (&xfs_dir_ilock_class){++++}-{3:3}, at: xfs_ilock+0x16a/0x420 fs/xfs/xfs_inode.c:208

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&xfs_dir_ilock_class){++++}-{3:3}:
       down_write_nested+0x3d/0x50 kernel/locking/rwsem.c:1695
       xfs_ilock+0x2ef/0x420 fs/xfs/xfs_inode.c:206
       xfs_reclaim_inode fs/xfs/xfs_icache.c:945 [inline]
       xfs_icwalk_process_inode fs/xfs/xfs_icache.c:1631 [inline]
       xfs_icwalk_ag+0xca6/0x1780 fs/xfs/xfs_icache.c:1713
       xfs_icwalk+0x57/0x100 fs/xfs/xfs_icache.c:1762
       xfs_reclaim_inodes_nr+0x182/0x250 fs/xfs/xfs_icache.c:1011
       super_cache_scan+0x409/0x550 fs/super.c:227
       do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
       shrink_slab+0x18a/0x1310 mm/shrinker.c:662
       shrink_one+0x493/0x7c0 mm/vmscan.c:4774
       shrink_many mm/vmscan.c:4835 [inline]
       lru_gen_shrink_node+0x89f/0x1750 mm/vmscan.c:4935
       shrink_node mm/vmscan.c:5894 [inline]
       kswapd_shrink_node mm/vmscan.c:6704 [inline]
       balance_pgdat+0x10d1/0x1a10 mm/vmscan.c:6895
       kswapd+0x5ea/0xbf0 mm/vmscan.c:7164
       kthread+0x2c1/0x3a0 kernel/kthread.c:388
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       __fs_reclaim_acquire mm/page_alloc.c:3698 [inline]
       fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3712
       might_alloc include/linux/sched/mm.h:312 [inline]
       slab_pre_alloc_hook mm/slub.c:3746 [inline]
       slab_alloc_node mm/slub.c:3827 [inline]
       __do_kmalloc_node mm/slub.c:3965 [inline]
       __kmalloc+0xb5/0x440 mm/slub.c:3979
       kmalloc include/linux/slab.h:632 [inline]
       xfs_attr_shortform_list fs/xfs/xfs_attr_list.c:115 [inline]
       xfs_attr_list_ilocked+0x8b7/0x1740 fs/xfs/xfs_attr_list.c:527
       xfs_attr_list+0x1f9/0x2b0 fs/xfs/xfs_attr_list.c:547
       xfs_vn_listxattr+0x11f/0x1c0 fs/xfs/xfs_xattr.c:314
       vfs_listxattr+0xb7/0x140 fs/xattr.c:493
       listxattr+0x69/0x190 fs/xattr.c:840
       path_listxattr+0xc3/0x160 fs/xattr.c:864
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x75/0x120 arch/x86/entry/common.c:321
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:346
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&xfs_dir_ilock_class);
                               lock(fs_reclaim);
                               lock(&xfs_dir_ilock_class);
  lock(fs_reclaim);

 *** DEADLOCK ***

1 lock held by syz-executor.0/6233:
 #0: ffff888028971858 (&xfs_dir_ilock_class){++++}-{3:3}, at: xfs_ilock+0x16a/0x420 fs/xfs/xfs_inode.c:208

stack backtrace:
CPU: 2 PID: 6233 Comm: syz-executor.0 Not tainted 6.9.0-rc3-syzkaller-00399-g72374d71c315 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __fs_reclaim_acquire mm/page_alloc.c:3698 [inline]
 fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3712
 might_alloc include/linux/sched/mm.h:312 [inline]
 slab_pre_alloc_hook mm/slub.c:3746 [inline]
 slab_alloc_node mm/slub.c:3827 [inline]
 __do_kmalloc_node mm/slub.c:3965 [inline]
 __kmalloc+0xb5/0x440 mm/slub.c:3979
 kmalloc include/linux/slab.h:632 [inline]
 xfs_attr_shortform_list fs/xfs/xfs_attr_list.c:115 [inline]
 xfs_attr_list_ilocked+0x8b7/0x1740 fs/xfs/xfs_attr_list.c:527
 xfs_attr_list+0x1f9/0x2b0 fs/xfs/xfs_attr_list.c:547
 xfs_vn_listxattr+0x11f/0x1c0 fs/xfs/xfs_xattr.c:314
 vfs_listxattr+0xb7/0x140 fs/xattr.c:493
 listxattr+0x69/0x190 fs/xattr.c:840
 path_listxattr+0xc3/0x160 fs/xattr.c:864
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x75/0x120 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:346
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf728a579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5e7c5ac EFLAGS: 00000292 ORIG_RAX: 00000000000000e9
RAX: ffffffffffffffda RBX: 00000000200000c0 RCX: 0000000000000000
RDX: 0000000000000002 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

