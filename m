Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6421D71367C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 May 2023 23:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjE0VBt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 May 2023 17:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjE0VBp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 May 2023 17:01:45 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1B5BB
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 May 2023 14:01:43 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-766655c2cc7so134200139f.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 May 2023 14:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685221303; x=1687813303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AM1jbn0su24YV15CboMIyOZg7PxhpNpo2v60gsISwLw=;
        b=EMuXWJBwUY4ILyCJi0F9b+exOEv40fu77ChhZOzpMXoAz7jjUH73yoQi0/2HnZaajx
         pkRXBySUwlcTI1g934Y5Q6M5cH8Wa7uucUDBQx/o75LfVjcjBTAUJyuu3rIYCJTVbGF5
         9eTb+5A0bXjMQ+3QeM9oaY/vD315VZXugrJJkTNAObr2C908PmmbBF0rKPGCCoWNeS8k
         NflnslS2ZRGYoUqbNeLd24G9+lh9EAM5xXZ0ppyqgkuvTY50FiKq0Ue3rQIi9J4USUUw
         q3KxGwGpsc1SkjLyL0mkh7wztduWHgKyKJgmQOPcZ/zY+1tiTdr3X3aXdloIM3SFsMse
         XmGA==
X-Gm-Message-State: AC+VfDxlEqEG+ANziEgYYVbbHXBvv+dIOMzT3+agUBv+xoLNlIRX9t6D
        itBdyUyEihaIG3w0kH5aNQqn8SHTfcfevBN4CSXtbwzuiYLx
X-Google-Smtp-Source: ACHHUZ5mHoErI2NB1cEfebAyBDxRnRLcz1mhTojSY2U2Hj9NOz/SjzkXjzx39QAUiiglKr4ReM+nyUD02U9ggJdTUJs/ZMXt7gq+
MIME-Version: 1.0
X-Received: by 2002:a02:9585:0:b0:41a:d24b:c9c6 with SMTP id
 b5-20020a029585000000b0041ad24bc9c6mr1165343jai.3.1685221302930; Sat, 27 May
 2023 14:01:42 -0700 (PDT)
Date:   Sat, 27 May 2023 14:01:42 -0700
In-Reply-To: <000000000000cef3a005fc1bcc80@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000021168405fcb329a7@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in scheduler_tick (2)
From:   syzbot <syzbot+ece2915262061d6e0ac1@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org,
        almaz.alexandrovich@paragon-software.com, andreyknvl@gmail.com,
        dvyukov@google.com, elver@google.com, frederic@kernel.org,
        glider@google.com, hannes@cmpxchg.org, kasan-dev@googlegroups.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@techsingularity.net, mhocko@kernel.org,
        mhocko@suse.com, mingo@kernel.org, ntfs3@lists.linux.dev,
        penguin-kernel@i-love.sakura.ne.jp, ryabinin.a.a@gmail.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vbabka@suse.cz, vincenzo.frascino@arm.com, ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    eb0f1697d729 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17733b4d280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8860074b9a9d6c45
dashboard link: https://syzkaller.appspot.com/bug?extid=ece2915262061d6e0ac1
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b4e536280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10224d6d280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/034232da7cff/disk-eb0f1697.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b11411bec33e/vmlinux-eb0f1697.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a53c52e170dd/Image-eb0f1697.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2ce9b06770e0/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ece2915262061d6e0ac1@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.4.0-rc3-syzkaller-geb0f1697d729 #0 Not tainted
------------------------------------------------------
klogd/5578 is trying to acquire lock:
ffff0001fea76c40 (&pgdat->kcompactd_wait){-...}-{2:2}, at: __wake_up_common_lock kernel/sched/wait.c:137 [inline]
ffff0001fea76c40 (&pgdat->kcompactd_wait){-...}-{2:2}, at: __wake_up+0xec/0x1a8 kernel/sched/wait.c:160

but task is already holding lock:
ffff0001b4259b18 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested kernel/sched/core.c:558 [inline]
ffff0001b4259b18 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock kernel/sched/sched.h:1366 [inline]
ffff0001b4259b18 (&rq->__lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1653 [inline]
ffff0001b4259b18 (&rq->__lock){-.-.}-{2:2}, at: scheduler_tick+0xa4/0x52c kernel/sched/core.c:5616

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&rq->__lock){-.-.}-{2:2}:
       _raw_spin_lock_nested+0x50/0x6c kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x2c/0x44 kernel/sched/core.c:558
       raw_spin_rq_lock kernel/sched/sched.h:1366 [inline]
       rq_lock kernel/sched/sched.h:1653 [inline]
       task_fork_fair+0x7c/0x23c kernel/sched/fair.c:12095
       sched_cgroup_fork+0x38c/0x464 kernel/sched/core.c:4777
       copy_process+0x24fc/0x3514 kernel/fork.c:2618
       kernel_clone+0x1d8/0x8ac kernel/fork.c:2918
       user_mode_thread+0x110/0x178 kernel/fork.c:2996
       rest_init+0x2c/0x2f4 init/main.c:700
       start_kernel+0x0/0x55c init/main.c:834
       start_kernel+0x3f0/0x55c init/main.c:1088
       __primary_switched+0xb8/0xc0 arch/arm64/kernel/head.S:523

-> #1 (&p->pi_lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
       try_to_wake_up+0xb0/0xd9c kernel/sched/core.c:4191
       default_wake_function+0x4c/0x60 kernel/sched/core.c:6993
       autoremove_wake_function+0x24/0xf8 kernel/sched/wait.c:419
       __wake_up_common+0x23c/0x3bc kernel/sched/wait.c:107
       __wake_up_common_lock kernel/sched/wait.c:138 [inline]
       __wake_up+0x10c/0x1a8 kernel/sched/wait.c:160
       wakeup_kcompactd+0x254/0x310 mm/compaction.c:2942
       balance_pgdat+0x1880/0x1c34 mm/vmscan.c:7541
       kswapd+0x7d0/0x10fc mm/vmscan.c:7738
       kthread+0x288/0x310 kernel/kthread.c:379
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:853

-> #0 (&pgdat->kcompactd_wait){-...}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3108 [inline]
       check_prevs_add kernel/locking/lockdep.c:3227 [inline]
       validate_chain kernel/locking/lockdep.c:3842 [inline]
       __lock_acquire+0x3310/0x75f0 kernel/locking/lockdep.c:5074
       lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5691
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
       __wake_up_common_lock kernel/sched/wait.c:137 [inline]
       __wake_up+0xec/0x1a8 kernel/sched/wait.c:160
       wakeup_kcompactd+0x254/0x310 mm/compaction.c:2942
       wakeup_kswapd+0x350/0x8c8 mm/vmscan.c:7792
       wake_all_kswapds+0x13c/0x23c mm/page_alloc.c:4028
       __alloc_pages_slowpath+0x378/0x1edc mm/page_alloc.c:4296
       __alloc_pages+0x3bc/0x698 mm/page_alloc.c:4781
       alloc_pages+0x4bc/0x7c0
       __stack_depot_save+0x4ac/0x678 lib/stackdepot.c:410
       kasan_save_stack+0x54/0x6c mm/kasan/common.c:46
       __kasan_record_aux_stack+0xcc/0xe8 mm/kasan/generic.c:491
       kasan_record_aux_stack+0x14/0x20 mm/kasan/generic.c:496
       task_work_add+0x94/0x3c0 kernel/task_work.c:48
       task_tick_mm_cid kernel/sched/core.c:11940 [inline]
       scheduler_tick+0x2d0/0x52c kernel/sched/core.c:5626
       update_process_times+0x198/0x1f4 kernel/time/timer.c:2076
       tick_sched_handle kernel/time/tick-sched.c:243 [inline]
       tick_sched_timer+0x330/0x4e8 kernel/time/tick-sched.c:1481
       __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
       __hrtimer_run_queues+0x458/0xca0 kernel/time/hrtimer.c:1749
       hrtimer_interrupt+0x2c0/0xb64 kernel/time/hrtimer.c:1811
       timer_handler drivers/clocksource/arm_arch_timer.c:656 [inline]
       arch_timer_handler_virt+0x74/0x88 drivers/clocksource/arm_arch_timer.c:667
       handle_percpu_devid_irq+0x2a4/0x804 kernel/irq/chip.c:930
       generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
       handle_irq_desc kernel/irq/irqdesc.c:651 [inline]
       generic_handle_domain_irq+0x7c/0xc4 kernel/irq/irqdesc.c:707
       __gic_handle_irq drivers/irqchip/irq-gic-v3.c:728 [inline]
       __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:779 [inline]
       gic_handle_irq+0x70/0x1e4 drivers/irqchip/irq-gic-v3.c:823
       call_on_irq_stack+0x24/0x4c arch/arm64/kernel/entry.S:882
       do_interrupt_handler+0xd4/0x138 arch/arm64/kernel/entry-common.c:274
       __el1_irq arch/arm64/kernel/entry-common.c:471 [inline]
       el1_interrupt+0x34/0x68 arch/arm64/kernel/entry-common.c:486
       el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:491
       el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:587
       __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:182 [inline]
       arch_local_irq_restore arch/arm64/include/asm/irqflags.h:202 [inline]
       dump_stack_lvl+0x104/0x124 lib/dump_stack.c:107
       dump_stack+0x1c/0x28 lib/dump_stack.c:113
       dump_header+0xb4/0x954 mm/oom_kill.c:460
       oom_kill_process+0x10c/0x6ec mm/oom_kill.c:1036
       out_of_memory+0xe24/0x103c mm/oom_kill.c:1156
       __alloc_pages_may_oom mm/page_alloc.c:3669 [inline]
       __alloc_pages_slowpath+0x1714/0x1edc mm/page_alloc.c:4444
       __alloc_pages+0x3bc/0x698 mm/page_alloc.c:4781
       alloc_pages+0x4bc/0x7c0
       alloc_slab_page+0xa0/0x164 mm/slub.c:1851
       allocate_slab mm/slub.c:2006 [inline]
       new_slab+0x210/0x2f4 mm/slub.c:2051
       ___slab_alloc+0x80c/0xdf4 mm/slub.c:3192
       __slab_alloc mm/slub.c:3291 [inline]
       __slab_alloc_node mm/slub.c:3344 [inline]
       slab_alloc_node mm/slub.c:3441 [inline]
       kmem_cache_alloc_node+0x318/0x46c mm/slub.c:3496
       __alloc_skb+0x19c/0x3d8 net/core/skbuff.c:644
       alloc_skb include/linux/skbuff.h:1288 [inline]
       alloc_skb_with_frags+0xb4/0x590 net/core/skbuff.c:6378
       sock_alloc_send_pskb+0x76c/0x884 net/core/sock.c:2729
       unix_dgram_sendmsg+0x480/0x16c0 net/unix/af_unix.c:1944
       sock_sendmsg_nosec net/socket.c:724 [inline]
       sock_sendmsg net/socket.c:747 [inline]
       __sys_sendto+0x3b4/0x538 net/socket.c:2144
       __do_sys_sendto net/socket.c:2156 [inline]
       __se_sys_sendto net/socket.c:2152 [inline]
       __arm64_sys_sendto+0xd8/0xf8 net/socket.c:2152
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
       el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
       el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

other info that might help us debug this:

Chain exists of:
  &pgdat->kcompactd_wait --> &p->pi_lock --> &rq->__lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&rq->__lock);
                               lock(&p->pi_lock);
                               lock(&rq->__lock);
  lock(&pgdat->kcompactd_wait);

 *** DEADLOCK ***

2 locks held by klogd/5578:
 #0: ffff8000161245e8 (oom_lock){+.+.}-{3:3}, at: __alloc_pages_may_oom mm/page_alloc.c:3618 [inline]
 #0: ffff8000161245e8 (oom_lock){+.+.}-{3:3}, at: __alloc_pages_slowpath+0x1694/0x1edc mm/page_alloc.c:4444
 #1: ffff0001b4259b18 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested kernel/sched/core.c:558 [inline]
 #1: ffff0001b4259b18 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock kernel/sched/sched.h:1366 [inline]
 #1: ffff0001b4259b18 (&rq->__lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1653 [inline]
 #1: ffff0001b4259b18 (&rq->__lock){-.-.}-{2:2}, at: scheduler_tick+0xa4/0x52c kernel/sched/core.c:5616

stack backtrace:
CPU: 1 PID: 5578 Comm: klogd Not tainted 6.4.0-rc3-syzkaller-geb0f1697d729 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/28/2023
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 print_circular_bug+0x150/0x1b8 kernel/locking/lockdep.c:2066
 check_noncircular+0x2cc/0x378 kernel/locking/lockdep.c:2188
 check_prev_add kernel/locking/lockdep.c:3108 [inline]
 check_prevs_add kernel/locking/lockdep.c:3227 [inline]
 validate_chain kernel/locking/lockdep.c:3842 [inline]
 __lock_acquire+0x3310/0x75f0 kernel/locking/lockdep.c:5074
 lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5691
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
 __wake_up_common_lock kernel/sched/wait.c:137 [inline]
 __wake_up+0xec/0x1a8 kernel/sched/wait.c:160
 wakeup_kcompactd+0x254/0x310 mm/compaction.c:2942
 wakeup_kswapd+0x350/0x8c8 mm/vmscan.c:7792
 wake_all_kswapds+0x13c/0x23c mm/page_alloc.c:4028
 __alloc_pages_slowpath+0x378/0x1edc mm/page_alloc.c:4296
 __alloc_pages+0x3bc/0x698 mm/page_alloc.c:4781
 alloc_pages+0x4bc/0x7c0
 __stack_depot_save+0x4ac/0x678 lib/stackdepot.c:410
 kasan_save_stack+0x54/0x6c mm/kasan/common.c:46
 __kasan_record_aux_stack+0xcc/0xe8 mm/kasan/generic.c:491
 kasan_record_aux_stack+0x14/0x20 mm/kasan/generic.c:496
 task_work_add+0x94/0x3c0 kernel/task_work.c:48
 task_tick_mm_cid kernel/sched/core.c:11940 [inline]
 scheduler_tick+0x2d0/0x52c kernel/sched/core.c:5626
 update_process_times+0x198/0x1f4 kernel/time/timer.c:2076
 tick_sched_handle kernel/time/tick-sched.c:243 [inline]
 tick_sched_timer+0x330/0x4e8 kernel/time/tick-sched.c:1481
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
 __hrtimer_run_queues+0x458/0xca0 kernel/time/hrtimer.c:1749
 hrtimer_interrupt+0x2c0/0xb64 kernel/time/hrtimer.c:1811
 timer_handler drivers/clocksource/arm_arch_timer.c:656 [inline]
 arch_timer_handler_virt+0x74/0x88 drivers/clocksource/arm_arch_timer.c:667
 handle_percpu_devid_irq+0x2a4/0x804 kernel/irq/chip.c:930
 generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
 handle_irq_desc kernel/irq/irqdesc.c:651 [inline]
 generic_handle_domain_irq+0x7c/0xc4 kernel/irq/irqdesc.c:707
 __gic_handle_irq drivers/irqchip/irq-gic-v3.c:728 [inline]
 __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:779 [inline]
 gic_handle_irq+0x70/0x1e4 drivers/irqchip/irq-gic-v3.c:823
 call_on_irq_stack+0x24/0x4c arch/arm64/kernel/entry.S:882
 do_interrupt_handler+0xd4/0x138 arch/arm64/kernel/entry-common.c:274
 __el1_irq arch/arm64/kernel/entry-common.c:471 [inline]
 el1_interrupt+0x34/0x68 arch/arm64/kernel/entry-common.c:486
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:491
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:587
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:182 [inline]
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:202 [inline]
 dump_stack_lvl+0x104/0x124 lib/dump_stack.c:107
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 dump_header+0xb4/0x954 mm/oom_kill.c:460
 oom_kill_process+0x10c/0x6ec mm/oom_kill.c:1036
 out_of_memory+0xe24/0x103c mm/oom_kill.c:1156
 __alloc_pages_may_oom mm/page_alloc.c:3669 [inline]
 __alloc_pages_slowpath+0x1714/0x1edc mm/page_alloc.c:4444
 __alloc_pages+0x3bc/0x698 mm/page_alloc.c:4781
 alloc_pages+0x4bc/0x7c0
 alloc_slab_page+0xa0/0x164 mm/slub.c:1851
 allocate_slab mm/slub.c:2006 [inline]
 new_slab+0x210/0x2f4 mm/slub.c:2051
 ___slab_alloc+0x80c/0xdf4 mm/slub.c:3192
 __slab_alloc mm/slub.c:3291 [inline]
 __slab_alloc_node mm/slub.c:3344 [inline]
 slab_alloc_node mm/slub.c:3441 [inline]
 kmem_cache_alloc_node+0x318/0x46c mm/slub.c:3496
 __alloc_skb+0x19c/0x3d8 net/core/skbuff.c:644
 alloc_skb include/linux/skbuff.h:1288 [inline]
 alloc_skb_with_frags+0xb4/0x590 net/core/skbuff.c:6378
 sock_alloc_send_pskb+0x76c/0x884 net/core/sock.c:2729
 unix_dgram_sendmsg+0x480/0x16c0 net/unix/af_unix.c:1944
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg net/socket.c:747 [inline]
 __sys_sendto+0x3b4/0x538 net/socket.c:2144
 __do_sys_sendto net/socket.c:2156 [inline]
 __se_sys_sendto net/socket.c:2152 [inline]
 __arm64_sys_sendto+0xd8/0xf8 net/socket.c:2152
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
