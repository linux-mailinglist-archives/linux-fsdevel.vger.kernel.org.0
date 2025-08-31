Return-Path: <linux-fsdevel+bounces-59719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B64F9B3D2A7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Aug 2025 14:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4CA818833DD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Aug 2025 12:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFE8253F3A;
	Sun, 31 Aug 2025 12:06:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B44202F9C
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 Aug 2025 12:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756641997; cv=none; b=qG3paxZTwlyIraaIGYiCZWXDYIwwF6jVr7t+ggtfn8uAQl7CSK2KZ8V7nw3eBdv6ElnxJzx/ZhNlbabgYmN52Pzh9u5k1xEppVPz7rMYtDGdJpsSU9EQnp//pCdKRygmhYJ85h7yLS21i1wU6Bq3/MStgyllArCvVZtDqRKTBKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756641997; c=relaxed/simple;
	bh=hXLlihRAbJK50wnzise41Mp3wBBc1/MlCNoafSu7ijg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s6GapIhxIZQ/ma5NdiadkuFUAZvYd91D23uYxfB5mPdCZHDKQRWvy77WnafpnpIHALVef2TY9GzWRmFtATN8SeHwRqSSXw1HICztjdKdgC0hI6Ym+3f7YfHTkEeRUUxfug/XSry21SOEqO9JCm0PVNdKyZpvJgPSbNk0WYGaYQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3efd62bc46fso36674565ab.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 Aug 2025 05:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756641994; x=1757246794;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/wpbfYp9bQ3977eO+74kqzfzqozZy2HcCgk/xYHTYro=;
        b=uxy6+VJOjagtb/TuUio+redT4l4SLd+QwEO0QmOznXlEmtlv/ZmSmlctbaVGlhPeq5
         D1rB7PM6vYztaA0/hHQ94Fq8Q7kKA7YEM+MAOfZKvQNKxs8GO1LRZGUrLlbeAo99K/3O
         pB6EKTpPFfcbZ0MkQ/6U9ptliZQiYARnTdQaic2fifwkylOyEngv13zqARpoD+Rt23Ds
         lulhnIjR2pcDwFPITh79x863h67z2Dx3MldOwBZNa2g5c239SPJOkefyep+olaRZB0ZY
         6H9rEOMdkxnZas+RsKdVY7NTOJGF62XyuMp7ZfjWlOqQ3Hbp9Z+vSP293hSl5T2lX+oC
         4qtA==
X-Forwarded-Encrypted: i=1; AJvYcCWZsf6d1HyZuHfH/uOpW9sTd1GqJhdJcun1PkgW46kISa6njuHtlcF24Hho/kAcf9KBbz8w5IBhQ/WkBhjU@vger.kernel.org
X-Gm-Message-State: AOJu0YxPNL96BbasOrJIzBDSw1tUvryBMdsmA/f8Q7GxoEHVt6P5bKPN
	0Ex+arNnwSkXBPgztMSkhANwS887tQFJ4utVmfJcIfWgBySbf6zo9m8YyNxgYeqFSu8dH/7DIhM
	yt04fh2U7bUJFi8/DwqAMiDl9+lezfNBUMtLnbdrcPKIWtHV6c4ZmSYt9TS4=
X-Google-Smtp-Source: AGHT+IEUbe66zfIWn3rpyQGKm4g7/OnK4e85v+IVH0idCjRYei2fLkla+XSaT/SfrQeJBfgl86da+xFI3vsX/cP8W46oidBKS71d
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1545:b0:3ed:a4b6:55eb with SMTP id
 e9e14a558f8ab-3f4002875d8mr114725575ab.10.1756641994614; Sun, 31 Aug 2025
 05:06:34 -0700 (PDT)
Date: Sun, 31 Aug 2025 05:06:34 -0700
In-Reply-To: <00000000000091e466061cee5be7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b43aca.a00a0220.1337b0.0036.GAE@google.com>
Subject: Re: [syzbot] [hfs?] INFO: task hung in deactivate_super (3)
From: syzbot <syzbot+cba6270878c89ed64a2d@syzkaller.appspotmail.com>
To: brauner@kernel.org, frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	jack@suse.cz, jfs-discussion@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, slava@dubeyko.com, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    c8bc81a52d5a Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10f5ce34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd9738e00c1bbfb4
dashboard link: https://syzkaller.appspot.com/bug?extid=cba6270878c89ed64a2d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10857a62580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f5ce34580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e617000fa273/disk-c8bc81a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7ae3a3f4924d/vmlinux-c8bc81a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d68d297e1f87/bzImage-c8bc81a5.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/fed9360d887d/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/ab84ca901131/mount_11.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cba6270878c89ed64a2d@syzkaller.appspotmail.com

INFO: task syz-executor:5962 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:21832 pid:5962  tgid:5962  ppid:1      task_flags:0x400140 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 rt_mutex_schedule+0x77/0xf0 kernel/sched/core.c:7339
 rwbase_write_lock+0x3dd/0x750 kernel/locking/rwbase_rt.c:272
 __super_lock fs/super.c:57 [inline]
 __super_lock_excl fs/super.c:72 [inline]
 deactivate_super+0xa9/0xe0 fs/super.c:506
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1375
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 exit_to_user_mode_loop+0[  309.321754][   T38]  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0[  309.321754][   T38]  exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff4a4aaff17
RSP: 002b:00007ffe8b16a008 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007ff4a4b31c05 RCX: 00007ff4a4aaff17
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffe8b16a0c0
RBP: 00007ffe8b16a0c0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffe8b16b150
R13: 00007ff4a4b31c05 R14: 00000000000257d4 R15: 00007ffe8b16b190
 </TASK>
INFO: task kworker/1:4:5964 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:4     state:D stack:20808 pid:5964  tgid:5964  ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue: events_long flush_mdb
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 io_schedule+0x81/0xe0 kernel/sched/core.c:7903
 bit_wait_io+0x11/0xd0 kernel/sched/wait_bit.c:250
 __wait_on_bit_lock+0xe0/0x4c0 kernel/sched/wait_bit.c:93
 out_of_line_wait_on_bit_lock+0x123/0x170 kernel/sched/wait_bit.c:120
 lock_buffer include/linux/buffer_head.h:432 [inline]
 hfs_mdb_commit+0x115/0x1160 fs/hfs/mdb.c:271
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task udevd:6018 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:24936 pid:6018  tgid:6018  ppid:5207   task_flags:0x400140 flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 rt_mutex_schedule+0x77/0xf0 kernel/sched/core.c:7339
 rt_mutex_slowlock_block+0x5ba/0x6d0 kernel/locking/rtmutex.c:1647
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1721 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
 rt_mutex_slowlock+0x2b1/0x6e0 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:536 [inline]
 mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:547
 bdev_release+0x1af/0x660 block/bdev.c:1128
 blkdev_release+0x15/0x20 block/fops.c:699
 __fput+0x45b/0xa80 fs/file_table.c:468
 fput_close_sync+0x119/0x200 fs/file_table.c:573
 __do_sys_close fs/open.c:1587 [inline]
 __se_sys_close fs/open.c:1572 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1572
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f633287c407
RSP: 002b:00007ffeae08dee0 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 00007f633278e880 RCX: 00007f633287c407
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000008
RBP: 00007f633278e6e8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
R13: 0000558ef3315190 R14: 0000000000000008 R15: 0000558ef33cfae0
 </TASK>
INFO: task syz.3.165:6251 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.165       state:D stack:25800 pid:6251  tgid:6251  ppid:5966   task_flags:0x400140 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 io_schedule+0x81/0xe0 kernel/sched/core.c:7903
 bit_wait_io+0x11/0xd0 kernel/sched/wait_bit.c:250
 __wait_on_bit_lock+0xe0/0x4c0 kernel/sched/wait_bit.c:93
 out_of_line_wait_on_bit_lock+0x123/0x170 kernel/sched/wait_bit.c:120
 wait_on_bit_lock_io include/linux/wait_bit.h:221 [inline]
 __lock_buffer fs/buffer.c:71 [inline]
 lock_buffer include/linux/buffer_head.h:432 [inline]
 __block_write_full_folio+0x54f/0xe10 fs/buffer.c:1910
 blkdev_writepages+0xd1/0x170 block/fops.c:483
 do_writepages+0x32b/0x550 mm/page-writeback.c:2634
 filemap_fdatawrite_wbc mm/filemap.c:386 [inline]
 __filemap_fdatawrite_range mm/filemap.c:419 [inline]
 __filemap_fdatawrite mm/filemap.c:425 [inline]
 filemap_fdatawrite+0x19c/0x240 mm/filemap.c:430
 sync_bdevs+0x242/0x340 block/bdev.c:1300
 ksys_sync+0xb9/0x150 fs/sync.c:105
 __ia32_sys_sync+0xe/0x20 fs/sync.c:113
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc44b10ebe9
RSP: 002b:00007ffcf5820f88 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00007fc44b345fa0 RCX: 00007fc44b10ebe9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc44b345fa0 R14: 00007fc44b345fa0 R15: 0000000000000000
 </TASK>
INFO: task syz.0.166:6253 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.166       state:D stack:25800 pid:6253  tgid:6253  ppid:5957   task_flags:0x400140 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 rt_mutex_schedule+0x77/0xf0 kernel/sched/core.c:7339
 rt_mutex_slowlock_block+0x5ba/0x6d0 kernel/locking/rtmutex.c:1647
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1721 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
 rt_mutex_slowlock+0x2b1/0x6e0 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:536 [inline]
 mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:547
 sync_bdevs+0x1ac/0x340 block/bdev.c:1288
 ksys_sync+0xb9/0x150 fs/sync.c:105
 __ia32_sys_sync+0xe/0x20 fs/sync.c:113
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fae3e64ebe9
RSP: 002b:00007fff744e41b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00007fae3e885fa0 RCX: 00007fae3e64ebe9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fae3e885fa0 R14: 00007fae3e885fa0 R15: 0000000000000000
 </TASK>
INFO: task syz.2.167:6252 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.167       state:D stack:25800 pid:6252  tgid:6252  ppid:5961   task_flags:0x400140 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 rt_mutex_schedule+0x77/0xf0 kernel/sched/core.c:7339
 rt_mutex_slowlock_block+0x5ba/0x6d0 kernel/locking/rtmutex.c:1647
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1721 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
 rt_mutex_slowlock+0x2b1/0x6e0 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:536 [inline]
 mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:547
 sync_bdevs+0x1ac/0x340 block/bdev.c:1288
 ksys_sync+0xb9/0x150 fs/sync.c:105
 __ia32_sys_sync+0xe/0x20 fs/sync.c:113
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f10152febe9
RSP: 002b:00007ffe7f472cd8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00007f1015535fa0 RCX: 00007f10152febe9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1015535fa0 R14: 00007f1015535fa0 R15: 0000000000000000
 </TASK>
INFO: task syz.4.168:6254 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.168       state:D stack:25800 pid:6254  tgid:6254  ppid:5967   task_flags:0x400140 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 io_schedule+0x81/0xe0 kernel/sched/core.c:7903
 folio_wait_bit_common+0x6b5/0xb90 mm/filemap.c:1317
 folio_lock include/linux/pagemap.h:1133 [inline]
 __find_get_block_slow fs/buffer.c:205 [inline]
 find_get_block_common+0x2e6/0xfc0 fs/buffer.c:1408
 bdev_getblk+0x4b/0x660 fs/buffer.c:-1
 __bread_gfp+0x89/0x3c0 fs/buffer.c:1515
 sb_bread include/linux/buffer_head.h:346 [inline]
 hfs_mdb_commit+0xa42/0x1160 fs/hfs/mdb.c:318
 hfs_sync_fs+0x15/0x20 fs/hfs/super.c:37
 __iterate_supers+0x13a/0x290 fs/super.c:924
 ksys_sync+0xa3/0x150 fs/sync.c:103
 __ia32_sys_sync+0xe/0x20 fs/sync.c:113
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f35c0abebe9
RSP: 002b:00007fff821c57b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00007f35c0cf5fa0 RCX: 00007f35c0abebe9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f35c0cf5fa0 R14: 00007f35c0cf5fa0 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/u8:1/13:
 #0: ffff8881404cc138 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff8881404cc138 ((wq_completion)writeback){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3319
 #1: ffffc90000127bc0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc90000127bc0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3319
 #2: ffff88801aaf00d0 (&type->s_umount_key#41){.+.+}-{4:4}, at: super_trylock_shared+0x20/0xf0 fs/super.c:563
1 lock held by khungtaskd/38:
 #0: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
3 locks held by kworker/u8:7/1181:
 #0: ffff8880309ac938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff8880309ac938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3319
 #1: ffffc90004cbfbc0 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc90004cbfbc0 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3319
 #2: ffffffff8ecd22b8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #2: ffffffff8ecd22b8 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_dad_work+0x119/0x15a0 net/ipv6/addrconf.c:4194
2 locks held by getty/5596:
 #0: ffff88823bf560a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90003e762e0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x444/0x1410 drivers/tty/n_tty.c:2222
1 lock held by syz-executor/5962:
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:506
2 locks held by kworker/1:4/5964:
 #0: ffff888019899138 ((wq_completion)events_long){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff888019899138 ((wq_completion)events_long){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3319
 #1: ffffc9000592fbc0 ((work_completion)(&(&sbi->mdb_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc9000592fbc0 ((work_completion)(&(&sbi->mdb_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3319
1 lock held by udevd/6018:
 #0: ffff888024a524c8 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_release+0x1af/0x660 block/bdev.c:1128
6 locks held by kworker/u8:13/6237:
 #0: ffff88801a6f4138 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff88801a6f4138 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3319
 #1: ffffc90004bbfbc0 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc90004bbfbc0 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3319
 #2: ffffffff8ecc53c0 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xf7/0x800 net/core/net_namespace.c:658
 #3: ffff8880386aa0d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:911 [inline]
 #3: ffff8880386aa0d8 (&dev->mutex){....}-{4:4}, at: devl_dev_lock net/devlink/devl_internal.h:108 [inline]
 #3: ffff8880386aa0d8 (&dev->mutex){....}-{4:4}, at: devlink_pernet_pre_exit+0x10a/0x3d0 net/devlink/core.c:506
 #4: ffff8880396d2300 (&devlink->lock_key#25){+.+.}-{4:4}, at: devl_lock net/devlink/core.c:276 [inline]
 #4: ffff8880396d2300 (&devlink->lock_key#25){+.+.}-{4:4}, at: devl_dev_lock net/devlink/devl_internal.h:109 [inline]
 #4: ffff8880396d2300 (&devlink->lock_key#25){+.+.}-{4:4}, at: devlink_pernet_pre_exit+0x11c/0x3d0 net/devlink/core.c:506
 #5: ffffffff8d9ae530 (rcu_state.barrier_mutex){+.+.}-{4:4}, at: rcu_barrier+0x4c/0x570 kernel/rcu/tree.c:3815
1 lock held by syz.3.165/6251:
 #0: ffff888024a524c8 (&disk->open_mutex){+.+.}-{4:4}, at: sync_bdevs+0x1ac/0x340 block/bdev.c:1288
1 lock held by syz.0.166/6253:
 #0: ffff888024a524c8 (&disk->open_mutex){+.+.}-{4:4}, at: sync_bdevs+0x1ac/0x340 block/bdev.c:1288
1 lock held by syz.2.167/6252:
 #0: ffff888024a524c8 (&disk->open_mutex){+.+.}-{4:4}, at: sync_bdevs+0x1ac/0x340 block/bdev.c:1288
1 lock held by syz.4.168/6254:
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: __super_lock fs/super.c:59 [inline]
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: super_lock+0x2a9/0x3b0 fs/super.c:121
1 lock held by syz.5.170/6386:
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: __super_lock fs/super.c:59 [inline]
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: super_lock+0x2a9/0x3b0 fs/super.c:121
1 lock held by syz.6.171/6387:
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: __super_lock fs/super.c:59 [inline]
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: super_lock+0x2a9/0x3b0 fs/super.c:121
1 lock held by syz.7.172/6388:
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: __super_lock fs/super.c:59 [inline]
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: super_lock+0x2a9/0x3b0 fs/super.c:121
1 lock held by syz.9.174/6389:
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: __super_lock fs/super.c:59 [inline]
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: super_lock+0x2a9/0x3b0 fs/super.c:121
1 lock held by syz.8.173/6390:
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: __super_lock fs/super.c:59 [inline]
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: super_lock+0x2a9/0x3b0 fs/super.c:121
1 lock held by syz-executor/6409:
 #0: ffff888024a524c8 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0xe0/0xcc0 block/bdev.c:945
1 lock held by syz.0.175/6464:
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: __super_lock fs/super.c:59 [inline]
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: super_lock+0x2a9/0x3b0 fs/super.c:121
1 lock held by syz.2.177/6501:
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: __super_lock fs/super.c:59 [inline]
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: super_lock+0x2a9/0x3b0 fs/super.c:121
1 lock held by syz.3.178/6502:
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: __super_lock fs/super.c:59 [inline]
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: super_lock+0x2a9/0x3b0 fs/super.c:121
1 lock held by syz.4.179/6503:
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: __super_lock fs/super.c:59 [inline]
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: super_lock+0x2a9/0x3b0 fs/super.c:121
1 lock held by syz.5.180/6592:
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: __super_lock fs/super.c:59 [inline]
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: super_lock+0x2a9/0x3b0 fs/super.c:121
4 locks held by kworker/u8:16/6605:
1 lock held by syz.6.181/6607:
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: __super_lock fs/super.c:59 [inline]
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: super_lock+0x2a9/0x3b0 fs/super.c:121
1 lock held by syz-executor/6649:
 #0: ffffffff8ecd22b8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #0: ffffffff8ecd22b8 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x3b0/0x18b0 net/ipv4/devinet.c:979
5 locks held by syz-executor/6671:
1 lock held by syz.7.182/6834:
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: __super_lock fs/super.c:59 [inline]
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: super_lock+0x2a9/0x3b0 fs/super.c:121
1 lock held by syz.9.184/6850:
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: __super_lock fs/super.c:59 [inline]
 #0: ffff88803976c0d0 (&type->s_umount_key#72){++++}-{4:4}, at: super_lock+0x2a9/0x3b0 fs/super.c:121
2 locks held by syz-executor/6856:
 #0: ffffffff8ecc53c0 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x304/0x4d0 net/core/net_namespace.c:566
 #1: ffffffff8ecd22b8 (rtnl_mutex){+.+.}-{4:4}, at: register_nexthop_notifier+0x80/0x210 net/ipv4/nexthop.c:3928

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 38 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:328 [inline]
 watchdog+0xf93/0xfe0 kernel/hung_task.c:491
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 6671 Comm: syz-executor Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:lockdep_hardirqs_on+0x47/0x150 kernel/locking/lockdep.c:4445
Code: 08 e0 f5 91 83 3d e8 e8 26 04 00 0f 84 94 00 00 00 65 8b 05 cb 6d ff 06 a9 00 00 f0 00 75 51 65 8b 05 3d ae ff 06 85 c0 75 7b <65> 8b 05 7a aa ff 06 85 c0 75 70 83 3d b7 b0 0a 0e 00 75 32 48 c7
RSP: 0018:ffffc90005d8e9b8 EFLAGS: 00000046
RAX: 0000000000000000 RBX: ffff888058833b80 RCX: c1b6123e9b4b6200
RDX: 0000000000000006 RSI: ffffffff8d218bdd RDI: ffffffff8af9e285
RBP: ffffc90005d8ea70 R08: ffffffff8f1d4a37 R09: 1ffffffff1e3a946
R10: dffffc0000000000 R11: fffffbfff1e3a947 R12: dffffc0000000000
R13: ffffc90005d8eac8 R14: ffff8880b893f370 R15: 1ffff92000bb1d3c
FS:  000055556c224500(0000) GS:ffff8881269c2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f41900d5000 CR3: 000000006746e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
 _raw_spin_unlock_irqrestore+0x85/0x110 kernel/locking/spinlock.c:194
 raw_spin_unlock_irqrestore_wake include/linux/sched/wake_q.h:94 [inline]
 rtlock_slowlock kernel/locking/rtmutex.c:1896 [inline]
 rtlock_lock kernel/locking/spinlock_rt.c:43 [inline]
 __rt_spin_lock kernel/locking/spinlock_rt.c:49 [inline]
 rt_spin_lock+0x167/0x2c0 kernel/locking/spinlock_rt.c:57
 spin_lock include/linux/spinlock_rt.h:44 [inline]
 ___slab_alloc+0x25c/0xdd0 mm/slub.c:3768
 __slab_alloc mm/slub.c:3981 [inline]
 __slab_alloc_node mm/slub.c:4056 [inline]
 slab_alloc_node mm/slub.c:4217 [inline]
 __do_kmalloc_node mm/slub.c:4364 [inline]
 __kmalloc_node_track_caller_noprof+0x14c/0x450 mm/slub.c:4384
 __kmemdup_nul mm/util.c:64 [inline]
 kstrdup+0x42/0x100 mm/util.c:84
 kobject_set_name_vargs+0x61/0x110 lib/kobject.c:274
 dev_set_name+0xd4/0x120 drivers/base/core.c:3492
 netdev_register_kobject+0xb7/0x310 net/core/net-sysfs.c:2342
 register_netdevice+0x12a0/0x1b10 net/core/dev.c:11206
 cfg80211_register_netdevice+0x150/0x2f0 net/wireless/core.c:1509
 ieee80211_if_add+0xe60/0x1390 net/mac80211/iface.c:2300
 ieee80211_register_hw+0x3551/0x4080 net/mac80211/main.c:1591
 mac80211_hwsim_new_radio+0x2c76/0x4e30 drivers/net/wireless/virtual/mac80211_hwsim.c:5568
 hwsim_new_radio_nl+0xea4/0x1b10 drivers/net/wireless/virtual/mac80211_hwsim.c:6252
 genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x843/0xa10 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:729
 __sys_sendto+0x3c7/0x520 net/socket.c:2228
 __do_sys_sendto net/socket.c:2235 [inline]
 __se_sys_sendto net/socket.c:2231 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2231
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f475e770a7c
Code: 2a 5f 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 70 5f 02 00 48 8b
RSP: 002b:00007fffff14cdc0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f475f4d4620 RCX: 00007f475e770a7c
RDX: 0000000000000024 RSI: 00007f475f4d4670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007fffff14ce14 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f475f4d4670 R15: 0000000000000000
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

