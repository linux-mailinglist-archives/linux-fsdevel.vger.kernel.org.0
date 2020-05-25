Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8514F1E041B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 02:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388487AbgEYAOS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 May 2020 20:14:18 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:37390 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388219AbgEYAOS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 May 2020 20:14:18 -0400
Received: by mail-io1-f69.google.com with SMTP id z13so3575880ioh.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 May 2020 17:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=DlJkT0UPLfuv/lUFJdHs/6vHXUgfSbe3XxC1ZcA4U4E=;
        b=Lsr24XLXumjIXKXldz9JEwtH8QhZhHr0ZSOwsmDbO5XImVjySgQqdFQOkdDDCEC0Kz
         liriXrA6Mk+GO6WwWYZBnD8aVO1bBKmfvAHxvDVq2AKvZ4eZ+oczPXldpWWf8A7eXpJn
         qAdrfsV6o/ayL7ZIlZc3QQwePH4cyB8JaKGAXJsF24ZfIu8vyHwD6Pm8uI3sLNFC+6Y2
         klSQ3pj+bWU+I3s+QduQxUAP3HBl7szlWnKvOleVl8HsJYI678OIf3cfyGKzXo5muzSW
         Zblq3QC8Hi/bhJ4dyVJcNesvPpMCBGPA2hliRhiomLVX6PcLXtTZjVxMmNANyTV2JUAu
         KNgQ==
X-Gm-Message-State: AOAM531pJWWHknJNfI8HkE5ayFdgAEfeDeJQOxoEmnJhWRngkJgYWHS0
        iukhj5F3S9A5vMgphTshurVEPZUmQUuSIAPazmidfQZycscq
X-Google-Smtp-Source: ABdhPJz1WoDfZbZ/fOUveRXN6JswtkTr705dm87OxaVYGq7fQDtHbX6O+tm2uWjJ3Dpb5293fL3oBHzrlZhvfIZ5mY4fkqF5ifnr
MIME-Version: 1.0
X-Received: by 2002:a92:5f1d:: with SMTP id t29mr22218502ilb.153.1590365656646;
 Sun, 24 May 2020 17:14:16 -0700 (PDT)
Date:   Sun, 24 May 2020 17:14:16 -0700
In-Reply-To: <000000000000c866c705a61a95d4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000070cb305a66ddc71@google.com>
Subject: Re: INFO: task hung in locks_remove_posix
From:   syzbot <syzbot+f5bc30abd8916982419c@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, bfields@fieldses.org, dvyukov@google.com,
        hdanton@sina.com, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
        penguin-kernel@i-love.sakura.ne.jp,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    806d8acc USB: dummy-hcd: use configurable endpoint naming ..
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=1109c09a100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d800e9bad158025f
dashboard link: https://syzkaller.appspot.com/bug?extid=f5bc30abd8916982419c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171ea49a100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f5bc30abd8916982419c@syzkaller.appspotmail.com

INFO: task syz-executor.1:3125 blocked for more than 143 seconds.
      Not tainted 5.7.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.1  D26504  3125    389 0x80004006
Call Trace:
 context_switch kernel/sched/core.c:3367 [inline]
 __schedule+0x892/0x1d80 kernel/sched/core.c:4083
 locks_remove_posix+0x277/0x4e0 fs/locks.c:2706
 __sched_text_start+0x8/0x8
 spin_unlock_irqrestore include/linux/spinlock.h:408 [inline]
 prepare_to_wait_event+0x129/0x650 kernel/sched/wait.c:305
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
 _raw_spin_unlock_irqrestore+0x39/0x40 kernel/locking/spinlock.c:191
 schedule+0xcd/0x2b0 kernel/sched/core.c:4158
 wdm_flush+0x2ea/0x3c0 drivers/usb/class/cdc-wdm.c:590
 wdm_poll+0x280/0x280 include/linux/poll.h:50
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
 putname+0xe1/0x120 fs/namei.c:259
 lock_is_held include/linux/lockdep.h:406 [inline]
 rcu_read_lock_sched_held+0x9c/0xd0 kernel/rcu/update.c:121
 rcu_read_lock_bh_held+0xb0/0xb0 kernel/rcu/update.c:333
 do_signal+0x88/0x1ae0 arch/x86/kernel/signal.c:784
 putname+0xe1/0x120 fs/namei.c:259
 do_sys_openat2+0x46c/0x7d0 fs/open.c:1158
 force_valid_ss arch/x86/kernel/signal.c:73 [inline]
 restore_sigcontext+0x620/0x620 arch/x86/kernel/signal.c:134
 _copy_to_user+0x126/0x160 lib/usercopy.c:31
 put_timespec64+0xcb/0x120 kernel/time/time.c:812
 ns_to_kernel_old_timeval+0x100/0x100 kernel/time/time.c:521
 do_sys_open+0xc3/0x140 fs/open.c:1164
 filp_open+0x70/0x70 fs/open.c:1117
 exit_to_usermode_loop+0x1a2/0x200 arch/x86/entry/common.c:161
 prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:279 [inline]
 do_syscall_64+0x4e0/0x5a0 arch/x86/entry/common.c:305
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
INFO: task syz-executor.2:3132 blocked for more than 143 seconds.
      Not tainted 5.7.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.2  D28552  3132    380 0x80004006
Call Trace:
 context_switch kernel/sched/core.c:3367 [inline]
 __schedule+0x892/0x1d80 kernel/sched/core.c:4083
 locks_remove_posix+0x277/0x4e0 fs/locks.c:2706
 __sched_text_start+0x8/0x8
 spin_unlock_irqrestore include/linux/spinlock.h:408 [inline]
 prepare_to_wait_event+0x129/0x650 kernel/sched/wait.c:305
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
 _raw_spin_unlock_irqrestore+0x39/0x40 kernel/locking/spinlock.c:191
 schedule+0xcd/0x2b0 kernel/sched/core.c:4158
 wdm_flush+0x2ea/0x3c0 drivers/usb/class/cdc-wdm.c:590
 wdm_poll+0x280/0x280 include/linux/poll.h:50
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
 __do_sys_nanosleep kernel/time/hrtimer.c:1962 [inline]
 __se_sys_nanosleep kernel/time/hrtimer.c:1953 [inline]
 __x64_sys_nanosleep+0x1ed/0x260 kernel/time/hrtimer.c:1953
 hrtimer_nanosleep+0x3a0/0x3a0 kernel/time/hrtimer.c:1943
 exit_to_usermode_loop+0x1a2/0x200 arch/x86/entry/common.c:161
 prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:279 [inline]
 do_syscall_64+0x4e0/0x5a0 arch/x86/entry/common.c:305
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
INFO: task syz-executor.3:3150 blocked for more than 143 seconds.
      Not tainted 5.7.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.3  D29048  3150    386 0x80004006
Call Trace:
 context_switch kernel/sched/core.c:3367 [inline]
 __schedule+0x892/0x1d80 kernel/sched/core.c:4083
 locks_remove_posix+0x277/0x4e0 fs/locks.c:2706
 __sched_text_start+0x8/0x8
 spin_unlock_irqrestore include/linux/spinlock.h:408 [inline]
 prepare_to_wait_event+0x129/0x650 kernel/sched/wait.c:305
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
 _raw_spin_unlock_irqrestore+0x39/0x40 kernel/locking/spinlock.c:191
 schedule+0xcd/0x2b0 kernel/sched/core.c:4158
 wdm_flush+0x2ea/0x3c0 drivers/usb/class/cdc-wdm.c:590
 wdm_poll+0x280/0x280 include/linux/poll.h:50
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
 down_interruptible+0x4b/0x80 kernel/locking/semaphore.c:85
 do_signal+0x88/0x1ae0 arch/x86/kernel/signal.c:784
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
 _raw_spin_unlock_irqrestore+0x39/0x40 kernel/locking/spinlock.c:191
 __trace_hardirqs_on_caller kernel/locking/lockdep.c:3657 [inline]
 lockdep_hardirqs_on+0x3c7/0x5d0 kernel/locking/lockdep.c:3702
 force_valid_ss arch/x86/kernel/signal.c:73 [inline]
 restore_sigcontext+0x620/0x620 arch/x86/kernel/signal.c:134
 down_interruptible+0x4b/0x80 kernel/locking/semaphore.c:85
 raw_ioctl+0x11f/0x2570 drivers/usb/gadget/legacy/raw_gadget.c:1261
 ksys_dup3+0x3c0/0x3c0 include/linux/compiler.h:199
 raw_open+0x4d0/0x4d0 include/linux/semaphore.h:34
 down_read_nested+0x430/0x430 include/linux/compiler.h:199
 exit_to_usermode_loop+0x1a2/0x200 arch/x86/entry/common.c:161
 prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:279 [inline]
 do_syscall_64+0x4e0/0x5a0 arch/x86/entry/common.c:305
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
INFO: task syz-executor.4:3151 blocked for more than 143 seconds.
      Not tainted 5.7.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.4  D29048  3151    384 0x80004006
Call Trace:
 context_switch kernel/sched/core.c:3367 [inline]
 __schedule+0x892/0x1d80 kernel/sched/core.c:4083
 locks_remove_posix+0x277/0x4e0 fs/locks.c:2706
 __sched_text_start+0x8/0x8
 spin_unlock_irqrestore include/linux/spinlock.h:408 [inline]
 prepare_to_wait_event+0x129/0x650 kernel/sched/wait.c:305
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
 _raw_spin_unlock_irqrestore+0x39/0x40 kernel/locking/spinlock.c:191
 schedule+0xcd/0x2b0 kernel/sched/core.c:4158
 wdm_flush+0x2ea/0x3c0 drivers/usb/class/cdc-wdm.c:590
 wdm_poll+0x280/0x280 include/linux/poll.h:50
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
 down_interruptible+0x4b/0x80 kernel/locking/semaphore.c:85
 do_signal+0x88/0x1ae0 arch/x86/kernel/signal.c:784
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
 _raw_spin_unlock_irqrestore+0x39/0x40 kernel/locking/spinlock.c:191
 __trace_hardirqs_on_caller kernel/locking/lockdep.c:3657 [inline]
 lockdep_hardirqs_on+0x3c7/0x5d0 kernel/locking/lockdep.c:3702
 force_valid_ss arch/x86/kernel/signal.c:73 [inline]
 restore_sigcontext+0x620/0x620 arch/x86/kernel/signal.c:134
 down_interruptible+0x4b/0x80 kernel/locking/semaphore.c:85
 raw_ioctl+0x11f/0x2570 drivers/usb/gadget/legacy/raw_gadget.c:1261
 ksys_dup3+0x3c0/0x3c0 include/linux/compiler.h:199
 raw_open+0x4d0/0x4d0 include/linux/semaphore.h:34
 down_read_nested+0x430/0x430 include/linux/compiler.h:199
 exit_to_usermode_loop+0x1a2/0x200 arch/x86/entry/common.c:161
 prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:279 [inline]
 do_syscall_64+0x4e0/0x5a0 arch/x86/entry/common.c:305
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
INFO: task syz-executor.0:3152 blocked for more than 144 seconds.
      Not tainted 5.7.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.0  D29048  3152    383 0x80004006
Call Trace:
 context_switch kernel/sched/core.c:3367 [inline]
 __schedule+0x892/0x1d80 kernel/sched/core.c:4083
 locks_remove_posix+0x277/0x4e0 fs/locks.c:2706
 __sched_text_start+0x8/0x8
 spin_unlock_irqrestore include/linux/spinlock.h:408 [inline]
 prepare_to_wait_event+0x129/0x650 kernel/sched/wait.c:305
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
 _raw_spin_unlock_irqrestore+0x39/0x40 kernel/locking/spinlock.c:191
 schedule+0xcd/0x2b0 kernel/sched/core.c:4158
 wdm_flush+0x2ea/0x3c0 drivers/usb/class/cdc-wdm.c:590
 wdm_poll+0x280/0x280 include/linux/poll.h:50
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
 down_interruptible+0x4b/0x80 kernel/locking/semaphore.c:85
 do_signal+0x88/0x1ae0 arch/x86/kernel/signal.c:784
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
 _raw_spin_unlock_irqrestore+0x39/0x40 kernel/locking/spinlock.c:191
 __trace_hardirqs_on_caller kernel/locking/lockdep.c:3657 [inline]
 lockdep_hardirqs_on+0x3c7/0x5d0 kernel/locking/lockdep.c:3702
 force_valid_ss arch/x86/kernel/signal.c:73 [inline]
 restore_sigcontext+0x620/0x620 arch/x86/kernel/signal.c:134
 down_interruptible+0x4b/0x80 kernel/locking/semaphore.c:85
 raw_ioctl+0x11f/0x2570 drivers/usb/gadget/legacy/raw_gadget.c:1261
 ksys_dup3+0x3c0/0x3c0 include/linux/compiler.h:199
 raw_open+0x4d0/0x4d0 include/linux/semaphore.h:34
 down_read_nested+0x430/0x430 include/linux/compiler.h:199
 exit_to_usermode_loop+0x1a2/0x200 arch/x86/entry/common.c:161
 prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:279 [inline]
 do_syscall_64+0x4e0/0x5a0 arch/x86/entry/common.c:305
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

Showing all locks held in the system:
1 lock held by khungtaskd/23:
 #0: ffffffff87111260 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x264 kernel/locking/lockdep.c:5754
2 locks held by in:imklog/271:
 #0: ffff8881c8468370 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:826
 #1: ffffffff8719fce0 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_acquire.part.0+0x0/0x30 include/asm-generic/bitops/instrumented-atomic.h:30

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 23 Comm: khungtaskd Not tainted 5.7.0-rc5-syzkaller #0
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
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:60 [inline]
NMI backtrace for cpu 0 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:103 [inline]
NMI backtrace for cpu 0 skipped: idling at default_idle+0x28/0x300 arch/x86/kernel/process.c:697

