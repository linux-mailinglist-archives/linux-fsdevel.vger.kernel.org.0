Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB58A229F26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 20:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbgGVSW0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 14:22:26 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:44629 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGVSWZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:22:25 -0400
Received: by mail-io1-f69.google.com with SMTP id h15so2370343ioj.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 11:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=XrYGZkc4GV3jQ5w/n38pu1v8gHEZy7A4d97WtIMN0gA=;
        b=ktgGwhaSL/N2b/ZTd8Clp/3fidn8Rysp4LWtz6SAB1UOwxaMPxJJr77kfvRo1Dyp7R
         kEwV6wqfQMe6Qj9zFsK9k/TN4iApQjNgNCzmMhO7jBCrmsm8StLLOyeEgYrTee8+OmU4
         Sw/+ztWi3uL9spZb29yh7gE+o6WPuqztvheAf2NZdBHbpfIAqsXjB2167Mp4cW7NrsAu
         6uQNteE4ZPA5gy593UP9Q3+AbBNWvqZ+gs2wK0zER+8Oi4/l92prClfENGk5P4bAkMQT
         L0wH+ciY50PlRgagEOrIDX+sm1K0DdxHr2Uk/cRAlm6rxVm+ukR8feWufkq67A2NLKpG
         Rvfg==
X-Gm-Message-State: AOAM53212hvf9ALoyppDbnE5UzAGOd0G5C1zkQjdT71JS43NtSilSgC0
        Gu1oE3ZSuVF6va+CqXGeSFMyxtvXy/K4NocgmftacFXzGhHu
X-Google-Smtp-Source: ABdhPJyh3fcWvkdUrgUQd4J7lWRF4QCvcP/YaS4lNsYjaoVHIfnb2esDWOMgSyx0MXwcmb0Tg48CRlxMBdDweeWUQrrrAdHlZnpv
MIME-Version: 1.0
X-Received: by 2002:a92:d809:: with SMTP id y9mr1151356ilm.51.1595442143962;
 Wed, 22 Jul 2020 11:22:23 -0700 (PDT)
Date:   Wed, 22 Jul 2020 11:22:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000402c5305ab0bd2a2@google.com>
Subject: INFO: task hung in synchronize_rcu (3)
From:   syzbot <syzbot+0c6da80218456f1edc36@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4fa640dc Merge tag 'vfio-v5.8-rc7' of git://github.com/awi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c738a0900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f87a5e4232fdb267
dashboard link: https://syzkaller.appspot.com/bug?extid=0c6da80218456f1edc36
compiler:       gcc (GCC) 10.1.0-syz 20200507
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e2a437100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13af00e8900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0c6da80218456f1edc36@syzkaller.appspotmail.com

INFO: task kworker/0:5:2530 blocked for more than 144 seconds.
      Not tainted 5.8.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/0:5     D26496  2530      2 0x00004000
Workqueue: events free_ipc
Call Trace:
 context_switch kernel/sched/core.c:3458 [inline]
 __schedule+0x91f/0x2250 kernel/sched/core.c:4215
 schedule+0xd0/0x2a0 kernel/sched/core.c:4290
 schedule_timeout+0x1d8/0x250 kernel/time/timer.c:1884
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x163/0x260 kernel/sched/completion.c:138
 __wait_rcu_gp+0x217/0x2d0 kernel/rcu/update.c:411
 synchronize_rcu+0x10a/0x180 kernel/rcu/tree.c:3430
 kern_unmount fs/namespace.c:3861 [inline]
 kern_unmount+0x67/0xe0 fs/namespace.c:3856
 free_ipc_ns ipc/namespace.c:123 [inline]
 free_ipc+0xbe/0x1b0 ipc/namespace.c:141
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
INFO: task syz-executor643:6834 blocked for more than 144 seconds.
      Not tainted 5.8.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor643 D24000  6834   6833 0xa0024002
Call Trace:
 context_switch kernel/sched/core.c:3458 [inline]
 __schedule+0x91f/0x2250 kernel/sched/core.c:4215
 schedule+0xd0/0x2a0 kernel/sched/core.c:4290
 schedule_timeout+0x1d8/0x250 kernel/time/timer.c:1884
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x163/0x260 kernel/sched/completion.c:138
 rcu_barrier+0x2d1/0x4a0 kernel/rcu/tree.c:3661
 netdev_run_todo+0x100/0xac0 net/core/dev.c:9758
 tun_detach drivers/net/tun.c:711 [inline]
 tun_chr_close+0xf5/0x180 drivers/net/tun.c:3423
 __fput+0x33c/0x880 fs/file_table.c:281
 task_work_run+0xdd/0x190 kernel/task_work.c:135
 exit_task_work include/linux/task_work.h:25 [inline]
 do_exit+0xb72/0x2a40 kernel/exit.c:805
 do_group_exit+0x125/0x310 kernel/exit.c:903
 __do_sys_exit_group kernel/exit.c:914 [inline]
 __se_sys_exit_group kernel/exit.c:912 [inline]
 __ia32_sys_exit_group+0x3a/0x50 kernel/exit.c:912
 do_syscall_32_irqs_on+0x3f/0x60 arch/x86/entry/common.c:428
 __do_fast_syscall_32 arch/x86/entry/common.c:475 [inline]
 do_fast_syscall_32+0x7f/0x120 arch/x86/entry/common.c:503
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7fef569
Code: Bad RIP value.
RSP: 002b:00000000ffdacd8c EFLAGS: 00000292 ORIG_RAX: 00000000000000fc
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00000000080f7b38
RDX: 0000000000000000 RSI: 00000000080dffbc RDI: 00000000080f7b40
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Showing all locks held in the system:
1 lock held by khungtaskd/1155:
 #0: ffffffff89bc11c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:5779
2 locks held by kworker/0:5/2530:
 #0: ffff8880aa026d38 ((wq_completion)events){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880aa026d38 ((wq_completion)events){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff8880aa026d38 ((wq_completion)events){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff8880aa026d38 ((wq_completion)events){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:616 [inline]
 #0: ffff8880aa026d38 ((wq_completion)events){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff8880aa026d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x82b/0x1670 kernel/workqueue.c:2240
 #1: ffffc9000804fda8 (free_ipc_work){+.+.}-{0:0}, at: process_one_work+0x85f/0x1670 kernel/workqueue.c:2244
1 lock held by in:imklog/6529:
 #0: ffff88809f8eadf0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:826
1 lock held by syz-executor643/6834:
 #0: ffffffff89bc5728 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x44/0x4a0 kernel/rcu/tree.c:3596

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1155 Comm: khungtaskd Not tainted 5.8.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x70/0xb1 lib/nmi_backtrace.c:101
 nmi_trigger_cpumask_backtrace+0x1b3/0x223 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:209 [inline]
 watchdog+0xd7d/0x1000 kernel/hung_task.c:295
 kthread+0x3b5/0x4a0 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.8.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:advance_sched+0x455/0x990 net/sched/sch_taprio.c:747
Code: 08 84 d2 0f 85 99 04 00 00 41 89 6c 24 20 e8 72 be 10 fb 48 b8 00 00 00 00 00 fc ff df 48 8b 54 24 08 48 c1 ea 03 80 3c 02 00 <0f> 85 4c 04 00 00 48 8b 7c 24 18 4c 89 63 e8 e8 d7 64 85 01 48 8d
RSP: 0018:ffffc90000007d78 EFLAGS: 00000046
RAX: dffffc0000000000 RBX: ffff88809dc04b40 RCX: ffffffff8662fdea
RDX: 1ffff11013b80965 RSI: ffffffff8662fe1e RDI: ffff8880a74c71a0
RBP: 0000000000000a00 R08: 0000000000000001 R09: ffff8880a74c71a3
R10: ffffed1014e98e34 R11: 0000000000000000 R12: ffff8880a74c7180
R13: 1623e9f81cc16400 R14: ffff8880a74c71a0 R15: 1623e9f81cc16400
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000080a8270 CR3: 0000000009a79000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __run_hrtimer kernel/time/hrtimer.c:1520 [inline]
 __hrtimer_run_queues+0x6a9/0xfc0 kernel/time/hrtimer.c:1584
 hrtimer_interrupt+0x32a/0x930 kernel/time/hrtimer.c:1646
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1080 [inline]
 __sysvec_apic_timer_interrupt+0x142/0x5e0 arch/x86/kernel/apic/apic.c:1097
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:711
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 sysvec_apic_timer_interrupt+0xe0/0x120 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:585
RIP: 0010:native_safe_halt+0xe/0x10 arch/x86/include/asm/irqflags.h:61
Code: ff 4c 89 ef e8 53 c8 ca f9 e9 8e fe ff ff 48 89 df e8 46 c8 ca f9 eb 8a cc cc cc cc e9 07 00 00 00 0f 00 2d 74 5f 60 00 fb f4 <c3> 90 e9 07 00 00 00 0f 00 2d 64 5f 60 00 f4 c3 cc cc 55 53 e8 29
RSP: 0018:ffffffff89a07c70 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffffffff89a86580 RSI: ffffffff87e85c48 RDI: ffffffff87e85c1e
RBP: ffff8880a7120064 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff8880a7120064
R13: 1ffffffff1340f98 R14: ffff8880a7120065 R15: 0000000000000001
 arch_safe_halt arch/x86/include/asm/paravirt.h:150 [inline]
 acpi_safe_halt+0x8d/0x110 drivers/acpi/processor_idle.c:111
 acpi_idle_do_entry+0x15c/0x1b0 drivers/acpi/processor_idle.c:525
 acpi_idle_enter+0x3f9/0xab0 drivers/acpi/processor_idle.c:651
 cpuidle_enter_state+0xff/0x960 drivers/cpuidle/cpuidle.c:235
 cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:346
 call_cpuidle kernel/sched/idle.c:126 [inline]
 cpuidle_idle_call kernel/sched/idle.c:214 [inline]
 do_idle+0x431/0x6d0 kernel/sched/idle.c:276
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:372
 start_kernel+0x9cb/0xa06 init/main.c:1043
 secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
