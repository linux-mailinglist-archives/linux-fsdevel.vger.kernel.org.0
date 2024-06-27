Return-Path: <linux-fsdevel+bounces-22627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 429D791A723
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 14:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673741C245E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 12:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC441849C2;
	Thu, 27 Jun 2024 12:58:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680391836D0
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493101; cv=none; b=iw7GqEBmJrNprUUfd8M4dgi4vhoW5/d6r5/6ueA+NwH7P4uUBRrHkKfOIDjB/P2/cup1gWJMQphllvaOIpb9uADaq0+7i1jYXkiHfgPnHEp99oIS5xJW9o70g771vJmxaMxjSr7RHPULolF+qMmvQXrljTjy1dVwpZ4+5JLa4p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493101; c=relaxed/simple;
	bh=jpeoYNh/2I4ArZNrhiN2R8d8Pg4wzU7Qn6keDXvwOjk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lGz7wJgWDeuyprucjISb2HbI16N59A0aL1kxurTk2i2msjXKOEQCdEfuLEWZbDmRx+xGRMvI9cVA3tJ5gcr1Rd0YFkKvIsDfY+cvvd0sSTqWrUhqVLf+DrLDlR5FCjXldAfAv8S+0cTC2eZDrxy2v1SNmqFSlwqvkJHgSPR+mQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-37715eaa486so34788725ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 05:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719493098; x=1720097898;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h9JzpylPnYBoMCUezeQZztT3YnyQHUAysOaFuhmh2ws=;
        b=i8T82kCJIX++L4EaYNMR+XE1gnnN9homSm2NyGfImuDxaCQ1jxqVUEDBbHd2OwW5TZ
         X75RcgcojP15Ndq2YPq5yb56SfNt5ZP5MSN7YExN1SZb8G/bHz0cSzNTX6tSYnNF44w+
         E+vnAydPEspl1VMBiZ+oV96fv3ev1HgvYgbBWW7an1kG7iJ7PpRTWIMDq+WNPf78DilV
         0VsSf58KP6SmYmOm01H3oPmmgwKDig2hDb2NTY37hjUP0yMWDg8Ppo1Pl9MLfACMT8d9
         YKY60kwCU8RE8/jutHj0SMBjWYa6mUU0N6H4vvaIL9aoxsJMSF4RMaLePatizsf0pdmF
         b82w==
X-Forwarded-Encrypted: i=1; AJvYcCUF+Fj1u46wDn1kEE/VWI6N21tKOx9JKwzZWwXKDUa/jSKRvNrn1csUeHjSfzt0M8j/3lGB9F7LYVDNhvzBxgnl6Ioabkwh0IcwbkkbKA==
X-Gm-Message-State: AOJu0YwKxQFxpGPpABXZtI8aFWnpBXC4NJgXtrOglxY4SSA6+tZ576qE
	AQm6wJgTppz9rs3J1blysTI4r3xtkYciejqtmEU6iq+JghhGK7u7YBLwUoJX05PSzHdiLhPxCYR
	Bsww4huuHAnoLmqOoPKSJoevgyHNpZo2iwe3ZkDLgpYWszBdv5CuI0Rw=
X-Google-Smtp-Source: AGHT+IH/KB0/l9s/pTuSk2SC2qHzYJUYzysWI5UwkvIeKdvnTpWBHnSHr6jfAGHkVjaTOAsd1W4i/9SGL1e4AhrpAXJyJM6Ovb66
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2187:b0:377:117e:e25e with SMTP id
 e9e14a558f8ab-377117ee8femr6620895ab.0.1719493098620; Thu, 27 Jun 2024
 05:58:18 -0700 (PDT)
Date: Thu, 27 Jun 2024 05:58:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000565ec5061bdeafd5@google.com>
Subject: [syzbot] [exfat?] possible deadlock in exfat_iterate (2)
From: syzbot <syzbot+df3558df41609451e4ac@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    55027e689933 Merge tag 'input-for-v6.10-rc5' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16390ac1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53ab35b556129242
dashboard link: https://syzkaller.appspot.com/bug?extid=df3558df41609451e4ac
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-55027e68.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a36929b5a065/vmlinux-55027e68.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d72de6f61ddc/bzImage-55027e68.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+df3558df41609451e4ac@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc5-syzkaller-00018-g55027e689933 #0 Not tainted
------------------------------------------------------
syz-executor.2/6265 is trying to acquire lock:
ffffffff8dd3ab20 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:334 [inline]
ffffffff8dd3ab20 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:3891 [inline]
ffffffff8dd3ab20 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:3981 [inline]
ffffffff8dd3ab20 (fs_reclaim){+.+.}-{0:0}, at: __do_kmalloc_node mm/slub.c:4121 [inline]
ffffffff8dd3ab20 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc_noprof+0xb5/0x420 mm/slub.c:4135

but task is already holding lock:
ffff88804af1a0e0 (&sbi->s_lock#2){+.+.}-{3:3}, at: exfat_iterate+0x33f/0xad0 fs/exfat/dir.c:256

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&sbi->s_lock#2){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       exfat_evict_inode+0x25b/0x340 fs/exfat/inode.c:725
       evict+0x2ed/0x6c0 fs/inode.c:667
       iput_final fs/inode.c:1741 [inline]
       iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
       iput+0x5c/0x80 fs/inode.c:1757
       dentry_unlink_inode+0x295/0x480 fs/dcache.c:400
       __dentry_kill+0x1d0/0x600 fs/dcache.c:603
       shrink_kill fs/dcache.c:1048 [inline]
       shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1075
       prune_dcache_sb+0xeb/0x150 fs/dcache.c:1156
       super_cache_scan+0x32a/0x550 fs/super.c:221
       do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
       shrink_slab_memcg mm/shrinker.c:548 [inline]
       shrink_slab+0xa87/0x1310 mm/shrinker.c:626
       shrink_one+0x493/0x7c0 mm/vmscan.c:4790
       shrink_many mm/vmscan.c:4851 [inline]
       lru_gen_shrink_node+0x89f/0x1750 mm/vmscan.c:4951
       shrink_node mm/vmscan.c:5910 [inline]
       kswapd_shrink_node mm/vmscan.c:6720 [inline]
       balance_pgdat+0x1105/0x1970 mm/vmscan.c:6911
       kswapd+0x5ea/0xbf0 mm/vmscan.c:7180
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       __fs_reclaim_acquire mm/page_alloc.c:3801 [inline]
       fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3815
       might_alloc include/linux/sched/mm.h:334 [inline]
       slab_pre_alloc_hook mm/slub.c:3891 [inline]
       slab_alloc_node mm/slub.c:3981 [inline]
       __do_kmalloc_node mm/slub.c:4121 [inline]
       __kmalloc_noprof+0xb5/0x420 mm/slub.c:4135
       kmalloc_noprof include/linux/slab.h:664 [inline]
       kmalloc_array_noprof include/linux/slab.h:699 [inline]
       __exfat_get_dentry_set+0x81e/0xa90 fs/exfat/dir.c:816
       exfat_get_dentry_set+0x36/0x210 fs/exfat/dir.c:859
       exfat_get_uniname_from_ext_entry fs/exfat/dir.c:39 [inline]
       exfat_readdir+0x950/0x1520 fs/exfat/dir.c:155
       exfat_iterate+0x3c7/0xad0 fs/exfat/dir.c:261
       wrap_directory_iterator+0xa5/0xe0 fs/readdir.c:67
       iterate_dir+0x53e/0xb60 fs/readdir.c:110
       __do_sys_getdents64 fs/readdir.c:409 [inline]
       __se_sys_getdents64 fs/readdir.c:394 [inline]
       __ia32_sys_getdents64+0x14f/0x2e0 fs/readdir.c:394
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sbi->s_lock#2);
                               lock(fs_reclaim);
                               lock(&sbi->s_lock#2);
  lock(fs_reclaim);

 *** DEADLOCK ***

3 locks held by syz-executor.2/6265:
 #0: ffff88801db114c8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xeb/0x180 fs/file.c:1191
 #1: ffff8880483da9e8 (&sb->s_type->i_mutex_key#24){++++}-{3:3}, at: wrap_directory_iterator+0x5a/0xe0 fs/readdir.c:56
 #2: ffff88804af1a0e0 (&sbi->s_lock#2){+.+.}-{3:3}, at: exfat_iterate+0x33f/0xad0 fs/exfat/dir.c:256

stack backtrace:
CPU: 0 PID: 6265 Comm: syz-executor.2 Not tainted 6.10.0-rc5-syzkaller-00018-g55027e689933 #0
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
 __fs_reclaim_acquire mm/page_alloc.c:3801 [inline]
 fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3815
 might_alloc include/linux/sched/mm.h:334 [inline]
 slab_pre_alloc_hook mm/slub.c:3891 [inline]
 slab_alloc_node mm/slub.c:3981 [inline]
 __do_kmalloc_node mm/slub.c:4121 [inline]
 __kmalloc_noprof+0xb5/0x420 mm/slub.c:4135
 kmalloc_noprof include/linux/slab.h:664 [inline]
 kmalloc_array_noprof include/linux/slab.h:699 [inline]
 __exfat_get_dentry_set+0x81e/0xa90 fs/exfat/dir.c:816
 exfat_get_dentry_set+0x36/0x210 fs/exfat/dir.c:859
 exfat_get_uniname_from_ext_entry fs/exfat/dir.c:39 [inline]
 exfat_readdir+0x950/0x1520 fs/exfat/dir.c:155
 exfat_iterate+0x3c7/0xad0 fs/exfat/dir.c:261
 wrap_directory_iterator+0xa5/0xe0 fs/readdir.c:67
 iterate_dir+0x53e/0xb60 fs/readdir.c:110
 __do_sys_getdents64 fs/readdir.c:409 [inline]
 __se_sys_getdents64 fs/readdir.c:394 [inline]
 __ia32_sys_getdents64+0x14f/0x2e0 fs/readdir.c:394
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf72f8579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5ec95ac EFLAGS: 00000292 ORIG_RAX: 00000000000000dc
RAX: ffffffffffffffda RBX: 000000000000000a RCX: 0000000020002ec0
RDX: 0000000000001000 RSI: 0000000000000000 RDI: 0000000000000000
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

