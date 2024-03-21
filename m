Return-Path: <linux-fsdevel+bounces-14975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F1D885A53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 15:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15CDA283235
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 14:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5156D84FC4;
	Thu, 21 Mar 2024 14:06:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3504184FAF
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711029990; cv=none; b=NT4qc0uKD89ZjuOYIipREscD9FSs96ieylie1Ry4/kZU5vY46ibYWMSMe55JCROKJXof3aI21t+ieY+e5FJIowz9XBHq7KQRY+/Goop8S83qv5adoxxQGe/JgLZoFn18odarNhQhI8HpNXkTnZA9kpejLD/miB1DWtvKbyCuMDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711029990; c=relaxed/simple;
	bh=YT/4ZJ24ZzHYI234UPMxBZe4S7GHaEWMgIY5pFgLHPY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JgtbPEa/AT8tb0EQtOl1TAX1RNFmFVfc3uxqR91u0GfJcdTcmKbeW0jCoTxEH9SBzNPZPdKJNporH81Ah6Y2DNY1DLkvZcevn0fIN2xJ3jTH9cQc+Fq1bK8ylq4Fhmwnr34bNZAhiDcRM2s53OsihvPQEucD+BjUCkhDZxQ6pOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc74ea8606so97074039f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 07:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711029987; x=1711634787;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SgFumG3WbIyv67H482Ir2dnCIKIH8MQVJRP7vnPQ1Dc=;
        b=HGheEhJWpkPb883KcZrRGVtvQNE6p8OM/i4aWfAC73jPnaNIRHPgfogxlkq9u/c/B5
         9eY/VsjbmMRsVeYOqtP4cOR19Gp3qCgwXEOZtHaF1vkm3KbMM6hMx0jQNnhun41W/3Z9
         2OzxJLsL+9q3Jw49IjPdM+vVVywQFii2i57qpEl+LFu6p6n1oha5CJy3ZFlMT5+fZwwF
         bYbF5fA+KAvVeQpdsAOAKaeAL922+dwOTGfzF/ODGiIJ8M3uNPGiG4SPn6MM+MTKCaYz
         hifZOf96+D0Ldj9b8zznVoTm3KyT/RT8eyDYF8mYc/IyaNBCHKW2uf4sJZ6NuSriC2Jn
         mDfw==
X-Forwarded-Encrypted: i=1; AJvYcCXKdUgxnHoqMn307tU4Rj1FTLjhu4wgRganNWjDFQIBDNpOcDrGvP9zwqV2M+Cps1LuVVvTFila+qNWpz3hnr9X+MpiompHVMssyYQqtA==
X-Gm-Message-State: AOJu0YzABYhhpDClNhkLim06N4OnxfvEvNORv4miZg6MFgkRzIrTY5jM
	u9JwHNx7AzZQrgZ/RRE0m1nG2siVcaJAKg6lr0A4FzeHTzNX4MEHr+U1OUxEKmwYyNEJZdcP1tJ
	t2A3DhR6AXpEeFuEGmuy67ShQNqcmubU6bhZDxLChmG9EKideiLBhdCo=
X-Google-Smtp-Source: AGHT+IEx2TO88D0iRR1w2EbozR8Fc7ptQtR64Nx6BN3JvbV6VCjRSwOSN3KWHCmfoi+jr6WDe3JnSYWZ+qzQ71GFR0Zwri+vgdvN
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:168e:b0:476:7265:9bfc with SMTP id
 f14-20020a056638168e00b0047672659bfcmr1125590jat.6.1711029987036; Thu, 21 Mar
 2024 07:06:27 -0700 (PDT)
Date: Thu, 21 Mar 2024 07:06:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093ea0d06142c361a@google.com>
Subject: [syzbot] [exfat?] INFO: task hung in do_new_mount (2)
From: syzbot <syzbot+f59c2feaf7cb5988e877@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=156b7946180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=f59c2feaf7cb5988e877
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1075d2c9180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161012a5180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f6c04726a2ae/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/09c26ce901ea/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/134acf7f5322/bzImage-fe46a7dd.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8eeb4ed4feec/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f59c2feaf7cb5988e877@syzkaller.appspotmail.com

INFO: task syz-executor238:5068 blocked for more than 143 seconds.
      Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor238 state:D stack:25616 pid:5068  tgid:5068  ppid:5063   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x1781/0x49d0 kernel/sched/core.c:6736
 __schedule_loop kernel/sched/core.c:6813 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6828
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6885
 rwsem_down_write_slowpath+0xeeb/0x13b0 kernel/locking/rwsem.c:1178
 __down_write_common+0x1af/0x200 kernel/locking/rwsem.c:1306
 inode_lock include/linux/fs.h:793 [inline]
 do_lock_mount+0x112/0x3a0 fs/namespace.c:2460
 lock_mount fs/namespace.c:2502 [inline]
 do_new_mount_fc fs/namespace.c:3289 [inline]
 do_new_mount+0x43d/0xb40 fs/namespace.c:3354
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f180bc1f26a
RSP: 002b:00007ffce5f8f508 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffce5f8f520 RCX: 00007f180bc1f26a
RDX: 0000000020001500 RSI: 0000000020000140 RDI: 00007ffce5f8f520
RBP: 0000000000000005 R08: 00007ffce5f8f560 R09: 00000000000014f8
R10: 0000000000000800 R11: 0000000000000286 R12: 0000000000000800
R13: 00007ffce5f8f560 R14: 0000000000000004 R15: 0000000000020000
 </TASK>
INFO: task syz-executor238:5071 blocked for more than 143 seconds.
      Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor238 state:D stack:25336 pid:5071  tgid:5071  ppid:5066   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x1781/0x49d0 kernel/sched/core.c:6736
 __schedule_loop kernel/sched/core.c:6813 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6828
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6885
 rwsem_down_write_slowpath+0xeeb/0x13b0 kernel/locking/rwsem.c:1178
 __down_write_common+0x1af/0x200 kernel/locking/rwsem.c:1306
 inode_lock include/linux/fs.h:793 [inline]
 do_lock_mount+0x112/0x3a0 fs/namespace.c:2460
 lock_mount fs/namespace.c:2502 [inline]
 do_new_mount_fc fs/namespace.c:3289 [inline]
 do_new_mount+0x43d/0xb40 fs/namespace.c:3354
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f180bc1f26a
RSP: 002b:00007ffce5f8f508 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffce5f8f520 RCX: 00007f180bc1f26a
RDX: 0000000020001500 RSI: 0000000020000140 RDI: 00007ffce5f8f520
RBP: 0000000000000005 R08: 00007ffce5f8f560 R09: 00000000000014f8
R10: 0000000000000800 R11: 0000000000000286 R12: 0000000000000800
R13: 00007ffce5f8f560 R14: 0000000000000004 R15: 0000000000020000
 </TASK>
INFO: task syz-executor238:5073 blocked for more than 143 seconds.
      Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor238 state:D stack:25456 pid:5073  tgid:5073  ppid:5069   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x1781/0x49d0 kernel/sched/core.c:6736
 __schedule_loop kernel/sched/core.c:6813 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6828
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6885
 rwsem_down_write_slowpath+0xeeb/0x13b0 kernel/locking/rwsem.c:1178
 __down_write_common+0x1af/0x200 kernel/locking/rwsem.c:1306
 inode_lock include/linux/fs.h:793 [inline]
 do_lock_mount+0x112/0x3a0 fs/namespace.c:2460
 lock_mount fs/namespace.c:2502 [inline]
 do_new_mount_fc fs/namespace.c:3289 [inline]
 do_new_mount+0x43d/0xb40 fs/namespace.c:3354
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f180bc1f26a
RSP: 002b:00007ffce5f8f508 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffce5f8f520 RCX: 00007f180bc1f26a
RDX: 0000000020001500 RSI: 0000000020000140 RDI: 00007ffce5f8f520
RBP: 0000000000000005 R08: 00007ffce5f8f560 R09: 00000000000014f8
R10: 0000000000000800 R11: 0000000000000286 R12: 0000000000000800
R13: 00007ffce5f8f560 R14: 0000000000000004 R15: 0000000000020000
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
2 locks held by getty/4822:
 #0: ffff88802a7690a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900031332f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2201
1 lock held by syz-executor238/5068:
 #0: ffff88807b2a02b8 (&sb->s_type->i_mutex_key#14){++++}-{3:3}, at: inode_lock include/linux/fs.h:793 [inline]
 #0: ffff88807b2a02b8 (&sb->s_type->i_mutex_key#14){++++}-{3:3}, at: do_lock_mount+0x112/0x3a0 fs/namespace.c:2460
3 locks held by syz-executor238/5072:
1 lock held by syz-executor238/5071:
 #0: ffff88807b2a02b8 (&sb->s_type->i_mutex_key#14){++++}-{3:3}, at: inode_lock include/linux/fs.h:793 [inline]
 #0: ffff88807b2a02b8 (&sb->s_type->i_mutex_key#14){++++}-{3:3}, at: do_lock_mount+0x112/0x3a0 fs/namespace.c:2460
1 lock held by syz-executor238/5073:
 #0: ffff88807b2a02b8 (&sb->s_type->i_mutex_key#14){++++}-{3:3}, at: inode_lock include/linux/fs.h:793 [inline]
 #0: ffff88807b2a02b8 (&sb->s_type->i_mutex_key#14){++++}-{3:3}, at: do_lock_mount+0x112/0x3a0 fs/namespace.c:2460
2 locks held by syz-executor238/5141:
 #0: ffff88801ff6efc8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x259/0x320 fs/file.c:1191
 #1: ffff88807b2a02b8 (&sb->s_type->i_mutex_key#14){++++}-{3:3}, at: iterate_dir+0x436/0x6f0 fs/readdir.c:103

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 29 Comm: khungtaskd Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xfb0/0xff0 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5072 Comm: syz-executor238 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
RIP: 0010:__sanitizer_cov_trace_cmp8+0x7d/0x90 kernel/kcov.c:285
Code: c1 e1 05 48 8d 41 28 4c 39 c8 77 1e 49 ff c2 4c 89 12 48 c7 44 11 08 06 00 00 00 48 89 7c 11 10 48 89 74 11 18 4c 89 44 11 20 <c3> cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90 90 90
RSP: 0018:ffffc90004277398 EFLAGS: 00000093
RAX: 0000000000000000 RBX: 00000000000000a0 RCX: ffff888011465a00
RDX: ffff888011465a00 RSI: 00000000000000a0 RDI: 0000000000000080
RBP: ffffc900042774e0 R08: ffffffff8217736e R09: 1ffffffff289d8e4
R10: dffffc0000000000 R11: fffffbfff289d8e5 R12: ffff88807b1262b8
R13: 0000000000039030 R14: 0000000000000000 R15: 0000000000000080
FS:  00005555679ce380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f180361f000 CR3: 000000007721e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 lookup_bh_lru fs/buffer.c:1370 [inline]
 __find_get_block+0x46e/0x10d0 fs/buffer.c:1397
 bdev_getblk+0x38/0x610 fs/buffer.c:1423
 __bread_gfp+0xac/0x430 fs/buffer.c:1474
 sb_bread include/linux/buffer_head.h:321 [inline]
 exfat_get_dentry+0x53b/0x730 fs/exfat/dir.c:770
 exfat_readdir fs/exfat/dir.c:121 [inline]
 exfat_iterate+0xbd7/0x33e0 fs/exfat/dir.c:261
 wrap_directory_iterator+0x94/0xe0 fs/readdir.c:67
 iterate_dir+0x539/0x6f0 fs/readdir.c:110
 __do_sys_getdents64 fs/readdir.c:409 [inline]
 __se_sys_getdents64+0x20d/0x4f0 fs/readdir.c:394
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f180bc1ded9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffce5f8f698 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007f180bc67082 RCX: 00007f180bc1ded9
RDX: 0000000000000646 RSI: 0000000020000240 RDI: 0000000000000005
RBP: 0030656c69662f2e R08: 00005555679cf378 R09: 00005555679cf378
R10: 00000000000014f8 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffce5f8f6d0 R14: 00007ffce5f8f6bc R15: 00007f180bc6703b
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.453 msecs


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

