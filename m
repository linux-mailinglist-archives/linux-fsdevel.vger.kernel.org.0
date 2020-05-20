Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6421DC097
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 22:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgETUxT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 16:53:19 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:36010 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbgETUxS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 16:53:18 -0400
Received: by mail-io1-f69.google.com with SMTP id n20so3157479iog.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2020 13:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Rb87Bzjcw5BZZ4t704CyHC78m8xK3zzc4utS90aukKs=;
        b=RlKJ0LFWquwIpUzcC5Wfw3/CN6Fq2gabjK3Xrdg/lQ+0oqILGV5eAoJygu6dC2U91q
         d0c6QdoRmtyU3Idd0VJCeU8MNsHifhg6G7xoJiOB7skoC9q7og/JHNEFcDTh+ZOAD/0V
         f4kGcdqw9IVncfSXk7FJ/LuByX6RkNRQVTrk/VjaEsQ8XvNg7bWfmmeZmhK0tm3ifql7
         /wtyHnsDCHU2c8vLrhUF4ESpt1i1HbExWhX09cwRwaNCIAWi1p8qoarSmhLjP/xBdxDN
         ia79qBMq2lDiuZC+fllRdRJvj7IHbOSGd5+ahBABCblc2mg9PvtGNUHKdy89JPimKhpZ
         8Uyw==
X-Gm-Message-State: AOAM5328nrVz0OdB5VvCD+IQ8mb9HY9R/3eu35KQ8TOKPg0iB+3j5tBm
        dMuUxLyB0/P6Exz/51o93AYCa179sAEvM4V9CGJTr+Pz/QrE
X-Google-Smtp-Source: ABdhPJwzLuP8/O0m9muI68oS0VyQjqQ09UQ41csTB8uXB200Jkh0/jqdmTZiFgYSzQULXgLmgD4BnpO6RSjbPgePVAfQtm3DZtsG
MIME-Version: 1.0
X-Received: by 2002:a92:5c87:: with SMTP id d7mr5954008ilg.114.1590007995850;
 Wed, 20 May 2020 13:53:15 -0700 (PDT)
Date:   Wed, 20 May 2020 13:53:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c866c705a61a95d4@google.com>
Subject: INFO: task hung in locks_remove_posix
From:   syzbot <syzbot+f5bc30abd8916982419c@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    806d8acc USB: dummy-hcd: use configurable endpoint naming ..
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=16c9ece2100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d800e9bad158025f
dashboard link: https://syzkaller.appspot.com/bug?extid=f5bc30abd8916982419c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f5bc30abd8916982419c@syzkaller.appspotmail.com

INFO: task syz-executor.2:3145 blocked for more than 143 seconds.
      Not tainted 5.7.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.2  D28552  3145    370 0x80004006
Call Trace:
 context_switch kernel/sched/core.c:3367 [inline]
 __schedule+0x892/0x1d80 kernel/sched/core.c:4083
 locks_remove_posix+0x277/0x4e0 fs/locks.c:2706
 __sched_text_start+0x8/0x8
 spin_unlock_irqrestore include/linux/spinlock.h:408 [inline]
 prepare_to_wait_event+0x129/0x650 kernel/sched/wait.c:305
 schedule+0xcd/0x2b0 kernel/sched/core.c:4158
 wdm_flush+0x2ea/0x3c0 drivers/usb/class/cdc-wdm.c:590
 wdm_poll+0x280/0x280 include/linux/poll.h:50
 wait_for_completion+0x280/0x280
 finish_wait+0x260/0x260 include/linux/list.h:301
 task_work_add+0x97/0x120 kernel/task_work.c:35
 wdm_poll+0x280/0x280 include/linux/poll.h:50
 filp_close+0xb4/0x170 fs/open.c:1251
 close_files fs/file.c:388 [inline]
 put_files_struct fs/file.c:416 [inline]
 put_files_struct+0x1d8/0x2e0 fs/file.c:413
 exit_files+0x7e/0xa0 fs/file.c:445
 do_exit+0xb36/0x2c80 kernel/exit.c:791
 find_held_lock+0x2d/0x110 kernel/locking/lockdep.c:4458
 mm_update_next_owner+0x7a0/0x7a0 kernel/exit.c:375
 lock_downgrade+0x720/0x720 kernel/locking/lockdep.c:4599
 do_group_exit+0x125/0x340 kernel/exit.c:894
 get_signal+0x480/0x2480 kernel/signal.c:2739
 schedule_timeout_idle+0x80/0x80 kernel/time/timer.c:1942
 do_signal+0x88/0x1ae0 arch/x86/kernel/signal.c:784
 free_object+0x5/0x70 lib/debugobjects.c:429
 destroy_hrtimer_on_stack kernel/time/hrtimer.c:453 [inline]
 hrtimer_nanosleep+0x211/0x3a0 kernel/time/hrtimer.c:1947
 nanosleep_copyout+0x100/0x100 kernel/time/hrtimer.c:1861
 force_valid_ss arch/x86/kernel/signal.c:73 [inline]
 restore_sigcontext+0x620/0x620 arch/x86/kernel/signal.c:134
 hrtimer_init_sleeper_on_stack+0x90/0x90 kernel/time/hrtimer.c:1833
 put_old_itimerspec32+0x1d0/0x1d0 kernel/time/time.c:908
 __do_sys_clock_gettime kernel/time/posix-timers.c:1094 [inline]
 __se_sys_clock_gettime kernel/time/posix-timers.c:1082 [inline]
 __x64_sys_clock_gettime+0x154/0x240 kernel/time/posix-timers.c:1082
 __do_sys_nanosleep kernel/time/hrtimer.c:1962 [inline]
 __se_sys_nanosleep kernel/time/hrtimer.c:1953 [inline]
 __x64_sys_nanosleep+0x1ed/0x260 kernel/time/hrtimer.c:1953
 hrtimer_nanosleep+0x3a0/0x3a0 kernel/time/hrtimer.c:1943
 exit_to_usermode_loop+0x1a2/0x200 arch/x86/entry/common.c:161
 prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:279 [inline]
 do_syscall_64+0x4e0/0x5a0 arch/x86/entry/common.c:305
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
 trace_hardirqs_off_caller+0x2b/0x200 kernel/trace/trace_preemptirq.c:67

Showing all locks held in the system:
1 lock held by khungtaskd/23:
 #0: ffffffff87111260 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x264 kernel/locking/lockdep.c:5754
1 lock held by in:imklog/267:
 #0: ffff8881d976d9f0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:826

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 23 Comm: khungtaskd Not tainted 5.7.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xef/0x16e lib/dump_stack.c:118
 irq_force_complete_move.cold+0x13/0x47 arch/x86/kernel/apic/vector.c:1023
 nmi_cpu_backtrace.cold+0x70/0xb1 lib/nmi_backtrace.c:101
 lapic_can_unplug_cpu.cold+0x3b/0x3b
 nmi_trigger_cpumask_backtrace+0x1db/0x207 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:205 [inline]
 watchdog+0xa99/0xfd0 kernel/hung_task.c:289
 reset_hung_task_detector+0x30/0x30 kernel/hung_task.c:243
 kthread+0x326/0x430 kernel/kthread.c:268
 kthread_create_on_node+0xf0/0xf0 kernel/kthread.c:405
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:351
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:60 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:103 [inline]
NMI backtrace for cpu 1 skipped: idling at default_idle+0x28/0x300 arch/x86/kernel/process.c:697


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
