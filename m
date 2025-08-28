Return-Path: <linux-fsdevel+bounces-59474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E8AB398A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 11:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24F95606FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 09:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EE730146E;
	Thu, 28 Aug 2025 09:40:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8733E301471
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756374034; cv=none; b=esI9Fa/h8+eU0fq55hscFLdTjYi9XG1jx3lTi/7wbE1laM8Hl7Op2w+vAOrESgYZGyoCBSqD4y3jMk9/DsQFzKkWKbfgCvoYk3VQrVYlKGSLqTfcED7488COusL2U34rNFHx0PQndvylrRbScwAeZNR7pHXxfC88vPmVXEuBVE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756374034; c=relaxed/simple;
	bh=4CDNVwqfZGsuYZcMWmCNK5lSE73YjWmj64ZshH2lYSw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SVFbrA3Rt36qfTZojgGzWL10b1qMr9oSwBSL6WDvq06U9TS0Hem+RZdu2yB3rbV4StER3ZYgnN0qVWKQmtuV1J4faRYZFgjDdEa1Wsc1dAp4v7LAyxxy3sz1Ls0sJv0yIaWNXGClADmnqgjusiq0El7Pq+8XD611LQJIWR4QtLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ed39b8563cso18941635ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 02:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756374031; x=1756978831;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+JQa2Q3RMgKoz8KLEXgRA8PGx4jpTO7vqVWF1zeuITc=;
        b=qgY6KepjDpzpMJD28AyWHU4ppuWXcK8YTiXFD8hhdaerfKMyMV8tPvxKyBRSfedX8F
         Xz3+s2YNR87GJo/vPlwGbRaCgFoZWIFoyo/v5OKOINPGYs0CbDjiT/FS80UlRJRVcKBq
         7rBKf++AcoqbfIVnBGWNqBQi6jK3PO945KtbNlD55qSHvuE0Qw4iabKOQCTcCbh6EFvz
         zUmIkaD4s2yGa+Ozkv+1ho1TsO8pMPWGJlHjEoP8e8gpae2qfnIpzyi8i9UMD6ehTw8f
         hvWkqp1epZ1WuUiOHSY3Lo0YBuS/Odp62RbUR1r+4xtn7WLnq8SdMvKIw8fe7KqtGcIn
         WV6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmFRWIedA0j2zMAV6I5/7FQIrgQ7ftU3T0sUyr/zI9pBD0PvrFxrEobkblyagNh2VSvtG3wQiRyjO2E34X@vger.kernel.org
X-Gm-Message-State: AOJu0YyVZDK3hiVb47GI3Ll1bdcnDBHM4pA/goLnFZIRm3f9rEJNiLAh
	94ZE1hwMv3aphFJUbqkqu0so3A8HMtP9FdG9it+TrrLTxNezZAp95CQE0pMHlno6y1SZ2m3K8DY
	kVx7F/isUetyNEo8to1cH3wGGF5GP+KCvzzNV70833hDBfwglhkvjUrFbjek=
X-Google-Smtp-Source: AGHT+IHFj13AhOz4c8+6RJ6E2HfOioGeTrqhki0cj2hLOJ/oEBldJxeb9JYvHPhzr3RDbZOf0t8BwSfgZU5cWX6MZAChLNbGRnkn
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170d:b0:3f1:ed24:cfa1 with SMTP id
 e9e14a558f8ab-3f1ed24d055mr4176705ab.27.1756374031605; Thu, 28 Aug 2025
 02:40:31 -0700 (PDT)
Date: Thu, 28 Aug 2025 02:40:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b0240f.a00a0220.1337b0.0006.GAE@google.com>
Subject: [syzbot] [gfs2?] INFO: task hung in writeback_iter (3)
From: syzbot <syzbot+1e3ff4b07c16ca0f6fe2@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7fa4d8dc380f Add linux-next specific files for 20250821
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=130beef0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d054fcd55656377
dashboard link: https://syzkaller.appspot.com/bug?extid=1e3ff4b07c16ca0f6fe2
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10339c42580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1668e462580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a843be98ab42/disk-7fa4d8dc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/17b718892b67/vmlinux-7fa4d8dc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8939424b4b54/bzImage-7fa4d8dc.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6c5d1c428942/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=150beef0580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1e3ff4b07c16ca0f6fe2@syzkaller.appspotmail.com

INFO: task syz.0.17:6037 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:25096 pid:6037  tgid:6037  ppid:5973   task_flags:0x400140 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 io_schedule+0x80/0xd0 kernel/sched/core.c:7903
 folio_wait_bit_common+0x6b0/0xb90 mm/filemap.c:1317
 folio_lock include/linux/pagemap.h:1139 [inline]
 writeback_get_folio mm/page-writeback.c:2468 [inline]
 writeback_iter+0x8d8/0x12a0 mm/page-writeback.c:2562
 iomap_writepages+0x14d/0x2d0 fs/iomap/buffered-io.c:1761
 gfs2_writepages+0x177/0x250 fs/gfs2/aops.c:175
 do_writepages+0x32e/0x550 mm/page-writeback.c:2634
 filemap_fdatawrite_wbc mm/filemap.c:386 [inline]
 __filemap_fdatawrite_range mm/filemap.c:419 [inline]
 __filemap_fdatawrite mm/filemap.c:425 [inline]
 filemap_fdatawrite+0x199/0x240 mm/filemap.c:430
 gfs2_ordered_write fs/gfs2/log.c:733 [inline]
 gfs2_log_flush+0x966/0x24c0 fs/gfs2/log.c:1102
 gfs2_trans_end+0x37c/0x570 fs/gfs2/trans.c:158
 gfs2_page_mkwrite+0x14a8/0x1910 fs/gfs2/file.c:535
 do_page_mkwrite+0x14d/0x310 mm/memory.c:3489
 do_shared_fault mm/memory.c:5779 [inline]
 do_fault mm/memory.c:5841 [inline]
 do_pte_missing mm/memory.c:4362 [inline]
 handle_pte_fault mm/memory.c:6182 [inline]
 __handle_mm_fault+0x1916/0x5400 mm/memory.c:6323
 handle_mm_fault+0x40a/0x8e0 mm/memory.c:6492
 do_user_addr_fault+0xa81/0x1390 arch/x86/mm/fault.c:1336
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x82/0x100 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
RIP: 0033:0x7f97632550b3
RSP: 002b:00007ffef0bb04e0 EFLAGS: 00010246
RAX: 0000200000000180 RBX: 0000000000000008 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00005555685083c8
RBP: 00007ffef0bb05e8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 00007f97635b5fac
R13: 00007f97635b5fa0 R14: fffffffffffffffe R15: 0000000000000006
 </TASK>
INFO: lockdep is turned off.
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:332 [inline]
 watchdog+0xf60/0xfa0 kernel/hung_task.c:495
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x47c/0x820 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 6836 Comm: syz.1.269 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:dsp_cmx_send+0x0/0x1b40 drivers/isdn/mISDN/dsp_cmx.c:1618
Code: 3b aa f9 48 ba 00 00 00 00 00 fc ff df e9 09 f2 ff ff 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 55 41 57 41 56 41 55 41 54 53 48 81 ec e0 00 00 00 e8
RSP: 0018:ffffc90000a08b98 EFLAGS: 00000246
RAX: ffffffff81ae4d15 RBX: 0000000000000101 RCX: ffff88801d78da00
RDX: 0000000000000100 RSI: ffffffff8c035860 RDI: ffffffff9a057420
RBP: ffffc90000a08c90 R08: ffffffff8fc40337 R09: 1ffffffff1f88066
R10: dffffc0000000000 R11: ffffffff8879fcb0 R12: 1ffff92000141178
R13: ffffffff9a057420 R14: 0000000000000001 R15: 0000000000000001
FS:  0000555565d25500(0000) GS:ffff888125aff000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4ea15ff000 CR3: 0000000027184000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 call_timer_fn+0x17b/0x5f0 kernel/time/timer.c:1747
 expire_timers kernel/time/timer.c:1798 [inline]
 __run_timers kernel/time/timer.c:2372 [inline]
 __run_timer_base+0x61a/0x860 kernel/time/timer.c:2384
 run_timer_base kernel/time/timer.c:2393 [inline]
 run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2403
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1050
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:console_trylock_spinning kernel/printk/printk.c:2061 [inline]
RIP: 0010:vprintk_emit+0x58f/0x7a0 kernel/printk/printk.c:2449
Code: 85 32 01 00 00 e8 a1 81 1f 00 41 89 df 4d 85 f6 48 8b 1c 24 75 07 e8 90 81 1f 00 eb 06 e8 89 81 1f 00 fb 48 c7 c7 80 02 33 8e <31> f6 ba 01 00 00 00 31 c9 41 b8 01 00 00 00 45 31 c9 53 e8 b9 35
RSP: 0018:ffffc90004a8ed80 EFLAGS: 00000293
RAX: ffffffff81a10d47 RBX: ffffffff81a10c04 RCX: ffff88801d78da00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8e330280
RBP: ffffc90004a8ee90 R08: ffffffff8fc40337 R09: 1ffffffff1f88066
R10: dffffc0000000000 R11: fffffbfff1f88067 R12: dffffc0000000000
R13: 1ffff92000951db4 R14: 0000000000000200 R15: 000000000000002f
 _printk+0xcf/0x120 kernel/printk/printk.c:2475
 set_capacity_and_notify+0x208/0x2d0 block/genhd.c:93
 loop_set_size+0x44/0xb0 drivers/block/loop.c:214
 loop_configure+0x9f4/0xe50 drivers/block/loop.c:1071
 lo_ioctl+0x810/0x1b30 drivers/block/loop.c:-1
 blkdev_ioctl+0x5a8/0x6d0 block/ioctl.c:705
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4ea958e7eb
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007ffc529a9be0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f4ea958e7eb
RDX: 0000000000000003 RSI: 0000000000004c00 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000001f78a
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 00007ffc529a9d10 R14: 00007ffc529a9cd0 R15: 00007f4ea0600000
 </TASK>


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

