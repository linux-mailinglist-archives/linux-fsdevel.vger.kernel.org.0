Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D123FE396
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 22:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244893AbhIAUST (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 16:18:19 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:37799 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbhIAUSS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 16:18:18 -0400
Received: by mail-il1-f200.google.com with SMTP id w12-20020a92ad0c000000b00227fc2e6eaeso311115ilh.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Sep 2021 13:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=FNMy+qj19qsqpjiRjE2NyPkIAsyhDlbzF8yjiFo18h0=;
        b=YEGzmQGXgUPBlncktz2NTtAslgh7GuqWgEYJbgxfio5eqJa+a3eKb/OAPd7czxG0gf
         k2/Dp2Fx5ioXIzAfoCRCgth0rjT5v+pT3G6PGjZP7L5mnusrTfDBuD9daxnWz1A2E8Xg
         c2Ic9Y1dK8Quyxv57ivAlb10gb61T5C8eLPnq3v7mOrEIWLFtwU5F4F2nQ1G1yIkaDWV
         6WkAOuBgWb+W5Utwe/ZTYWqH2quWsaZs66m+6Z+imXwntqILdSQgEQBHclakkTciRBO5
         cZHlnZQc9/qwi+LtHTiovLtbaG2US8kZSg1Zhnb8BXOVFQaIOcOS63dSCd+PIS90k1Wd
         NXiw==
X-Gm-Message-State: AOAM532A5YeDrGDVI1y4fBcozkN2AFg9x1FGalflsTlY4/CdyJpJlMJf
        k7ERfqYa6rhxJyJh7717R1fm/kN25VZL00oD9L7w+Rb/2kwW
X-Google-Smtp-Source: ABdhPJxyNuOj2mKccd1MJdaNAlwEVU80bWC9fHmvHystXIIrZZduAmQuWiJpu8GvdRKcgfYkhAT10oooWFKvXUiFqN+dIKtN43+a
MIME-Version: 1.0
X-Received: by 2002:a05:6638:5b5:: with SMTP id b21mr1212044jar.109.1630527440969;
 Wed, 01 Sep 2021 13:17:20 -0700 (PDT)
Date:   Wed, 01 Sep 2021 13:17:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea643805caf4c00a@google.com>
Subject: [syzbot] INFO: task hung in __sync_dirty_buffer
From:   syzbot <syzbot+91dccab7c64e2850a4e5@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    64b4fc45bea6 Merge tag 'block-5.14-2021-08-27' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c81d85300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94074b5caf8665c7
dashboard link: https://syzkaller.appspot.com/bug?extid=91dccab7c64e2850a4e5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bfe1a9300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136c35fe300000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13831da9300000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10431da9300000
console output: https://syzkaller.appspot.com/x/log.txt?x=17831da9300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+91dccab7c64e2850a4e5@syzkaller.appspotmail.com

INFO: task syz-executor409:8464 blocked for more than 143 seconds.
      Not tainted 5.14.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor409 state:D stack:25624 pid: 8464 ppid:  8463 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4681 [inline]
 __schedule+0x93a/0x26f0 kernel/sched/core.c:5938
 schedule+0xd3/0x270 kernel/sched/core.c:6017
 io_schedule+0xba/0x130 kernel/sched/core.c:7988
 bit_wait_io+0x12/0xd0 kernel/sched/wait_bit.c:209
 __wait_on_bit_lock+0x121/0x1a0 kernel/sched/wait_bit.c:90
 out_of_line_wait_on_bit_lock+0xd5/0x110 kernel/sched/wait_bit.c:117
 wait_on_bit_lock_io include/linux/wait_bit.h:208 [inline]
 __lock_buffer fs/buffer.c:69 [inline]
 lock_buffer include/linux/buffer_head.h:368 [inline]
 __sync_dirty_buffer+0x363/0x3f0 fs/buffer.c:3138
 __ext4_handle_dirty_metadata+0x28f/0x720 fs/ext4/ext4_jbd2.c:361
 ext4_convert_inline_data_nolock+0x67a/0xf30 fs/ext4/inline.c:1237
 ext4_convert_inline_data+0x31a/0x490 fs/ext4/inline.c:1990
 ext4_fallocate+0x1ae/0x3ff0 fs/ext4/extents.c:4666
 vfs_fallocate+0x48d/0xd80 fs/open.c:311
 ksys_fallocate fs/open.c:334 [inline]
 __do_sys_fallocate fs/open.c:342 [inline]
 __se_sys_fallocate fs/open.c:340 [inline]
 __x64_sys_fallocate+0xcf/0x140 fs/open.c:340
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x444b09
RSP: 002b:00007fff1122eaa8 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00000000004004a0 RCX: 0000000000444b09
RDX: 0000000000000000 RSI: 0000000100000001 RDI: 0000000000000006
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 000000002811fdff R11: 0000000000000246 R12: 00007fff1122ead0
R13: 0000000000000000 R14: 431bde82d7b634db R15: 00000000004004a0

Showing all locks held in the system:
1 lock held by khungtaskd/1654:
 #0: ffffffff8b97c280 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6446
2 locks held by syz-executor409/8464:
 #0: ffff88802f05a460 (sb_writers#5){.+.+}-{0:0}, at: ksys_fallocate fs/open.c:334 [inline]
 #0: ffff88802f05a460 (sb_writers#5){.+.+}-{0:0}, at: __do_sys_fallocate fs/open.c:342 [inline]
 #0: ffff88802f05a460 (sb_writers#5){.+.+}-{0:0}, at: __se_sys_fallocate fs/open.c:340 [inline]
 #0: ffff88802f05a460 (sb_writers#5){.+.+}-{0:0}, at: __x64_sys_fallocate+0xcf/0x140 fs/open.c:340
 #1: ffff8880379ea8a8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:142 [inline]
 #1: ffff8880379ea8a8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_convert_inline_data+0x21e/0x490 fs/ext4/inline.c:1988

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1654 Comm: khungtaskd Not tainted 5.14.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xd0a/0xfc0 kernel/hung_task.c:295
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 8471 Comm: kworker/u4:0 Not tainted 5.14.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:kasan_check_range+0x15/0x180 mm/kasan/generic.c:188
Code: 39 02 0f 1f 00 48 89 f2 be f8 00 00 00 e9 a3 aa 39 02 0f 1f 00 48 85 f6 0f 84 70 01 00 00 49 89 f9 41 54 44 0f b6 c2 49 01 f1 <55> 53 0f 82 18 01 00 00 48 b8 ff ff ff ff ff 7f ff ff 48 39 c7 0f
RSP: 0018:ffffc900015af948 EFLAGS: 00000286
RAX: 0000000000000000 RBX: 1ffff920002b5f2d RCX: ffffffff815b2948
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff8d6c81d0
RBP: 0000000000000001 R08: 0000000000000000 R09: ffffffff8d6c81d8
R10: ffffffff819871c0 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffffffff8b847e48 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd7c14da000 CR3: 000000000b68e000 CR4: 0000000000350ee0
Call Trace:
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
 cpumask_test_cpu include/linux/cpumask.h:344 [inline]
 cpu_online include/linux/cpumask.h:895 [inline]
 trace_lock_acquire include/trace/events/lock.h:13 [inline]
 lock_acquire+0xb8/0x510 kernel/locking/lockdep.c:5596
 __mutex_lock_common kernel/locking/mutex.c:959 [inline]
 __mutex_lock+0x12a/0x10a0 kernel/locking/mutex.c:1104
 arch_jump_label_transform_queue+0x58/0x100 arch/x86/kernel/jump_label.c:136
 __jump_label_update+0x12e/0x400 kernel/jump_label.c:451
 jump_label_update+0x1d5/0x430 kernel/jump_label.c:830
 static_key_disable_cpuslocked+0x152/0x1b0 kernel/jump_label.c:207
 static_key_disable+0x16/0x20 kernel/jump_label.c:215
 toggle_allocation_gate mm/kfence/core.c:637 [inline]
 toggle_allocation_gate+0x185/0x390 mm/kfence/core.c:615
 process_one_work+0x98d/0x1630 kernel/workqueue.c:2276
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
----------------
Code disassembly (best guess):
   0:	39 02                	cmp    %eax,(%rdx)
   2:	0f 1f 00             	nopl   (%rax)
   5:	48 89 f2             	mov    %rsi,%rdx
   8:	be f8 00 00 00       	mov    $0xf8,%esi
   d:	e9 a3 aa 39 02       	jmpq   0x239aab5
  12:	0f 1f 00             	nopl   (%rax)
  15:	48 85 f6             	test   %rsi,%rsi
  18:	0f 84 70 01 00 00    	je     0x18e
  1e:	49 89 f9             	mov    %rdi,%r9
  21:	41 54                	push   %r12
  23:	44 0f b6 c2          	movzbl %dl,%r8d
  27:	49 01 f1             	add    %rsi,%r9
* 2a:	55                   	push   %rbp <-- trapping instruction
  2b:	53                   	push   %rbx
  2c:	0f 82 18 01 00 00    	jb     0x14a
  32:	48 b8 ff ff ff ff ff 	movabs $0xffff7fffffffffff,%rax
  39:	7f ff ff
  3c:	48 39 c7             	cmp    %rax,%rdi
  3f:	0f                   	.byte 0xf


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
