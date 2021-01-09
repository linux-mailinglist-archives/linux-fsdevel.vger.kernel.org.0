Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84ED22EFF1A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jan 2021 11:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbhAIK4G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Jan 2021 05:56:06 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:47647 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbhAIK4G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Jan 2021 05:56:06 -0500
Received: by mail-io1-f72.google.com with SMTP id q21so9810255ios.14
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 Jan 2021 02:55:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6yVz9Mqgzwqe9s9n/EDJTxc3/UjjvZ5VbIMTqUd/4rY=;
        b=bplwcQ2jxmH1xH6FqV8w2wJnu1MTMbdswDlF922bfpjs1/TpDvVYI/T+zQMYgT9wpi
         SasLLZn0YTWsQhu0ZgnXWJi2b9mtpeKskEjXYdFK7gE5YC7ZBEoKlustVcINu90JxeDS
         qe4qrP2vpVuljB1LCo5tSmueCEpuRDkeG4EWVPhaA539kgsrV3o7GbtC7CY9TtiKT3/a
         viHs7PLDRwWPyZa8aFWPkCIjVoDyEY8TnEGl282tgFqXmJ4QjYX8stU8YFD1vAOUCMW5
         lx0YWxCv6ZHJ9kM2KT0J4Fe/H5DiQPctvPX4fnRAbAgP3RQKRXnhZ/8OjO7GCXAuwIYg
         gD9w==
X-Gm-Message-State: AOAM531FSb/BwLxEaLF+nwr26vQP/DQNGh7hS3wnawt/3LvgKxrJsBol
        FPzmSOnLkJUgsPpvNZQbTM8gtF5LtHvvNGiLNFmVRGthu7Z0
X-Google-Smtp-Source: ABdhPJzlagA8FrRPT21rgY/f+yVLgWG8E2pyLtqZCP0Yx3yi1tNo5zmlCEA1oiHGRTEHolrQjdZxO+tFJsj8//4CiaCThH8dygWB
MIME-Version: 1.0
X-Received: by 2002:a92:ad05:: with SMTP id w5mr7638546ilh.226.1610189724017;
 Sat, 09 Jan 2021 02:55:24 -0800 (PST)
Date:   Sat, 09 Jan 2021 02:55:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000085683e05b875822f@google.com>
Subject: possible deadlock in input_event
From:   syzbot <syzbot+5f27d4a2c40aea06d3ea@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, boqun.feng@gmail.com, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    36bbbd0e Merge branch 'rcu/urgent' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=150148f7500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8aa30b9da402d224
dashboard link: https://syzkaller.appspot.com/bug?extid=5f27d4a2c40aea06d3ea
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13397e1f500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11233bc0d00000

The issue was bisected to:

commit f08e3888574d490b31481eef6d84c61bedba7a47
Author: Boqun Feng <boqun.feng@gmail.com>
Date:   Fri Aug 7 07:42:30 2020 +0000

    lockdep: Fix recursive read lock related safe->unsafe detection

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13b3814f500000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1073814f500000
console output: https://syzkaller.appspot.com/x/log.txt?x=17b3814f500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5f27d4a2c40aea06d3ea@syzkaller.appspotmail.com
Fixes: f08e3888574d ("lockdep: Fix recursive read lock related safe->unsafe detection")

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
5.11.0-rc2-syzkaller #0 Not tainted
-----------------------------------------------------
syz-executor435/8478 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffff88801c992638 (&f->f_owner.lock){.+.+}-{2:2}, at: send_sigio+0x24/0x360 fs/fcntl.c:787

and this task is already holding:
ffff88802063e018 (&new->fa_lock){....}-{2:2}, at: kill_fasync_rcu fs/fcntl.c:1004 [inline]
ffff88802063e018 (&new->fa_lock){....}-{2:2}, at: kill_fasync fs/fcntl.c:1025 [inline]
ffff88802063e018 (&new->fa_lock){....}-{2:2}, at: kill_fasync+0x14b/0x460 fs/fcntl.c:1018
which would create a new lock dependency:
 (&new->fa_lock){....}-{2:2} -> (&f->f_owner.lock){.+.+}-{2:2}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&dev->event_lock){-...}-{2:2}

... which became HARDIRQ-irq-safe at:
  lock_acquire kernel/locking/lockdep.c:5437 [inline]
  lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:159
  input_event drivers/input/input.c:445 [inline]
  input_event+0x7b/0xb0 drivers/input/input.c:438
  input_report_key include/linux/input.h:425 [inline]
  psmouse_report_standard_buttons+0x2c/0x80 drivers/input/mouse/psmouse-base.c:123
  psmouse_report_standard_packet drivers/input/mouse/psmouse-base.c:141 [inline]
  psmouse_process_byte+0x1e1/0x890 drivers/input/mouse/psmouse-base.c:232
  psmouse_handle_byte+0x41/0x1b0 drivers/input/mouse/psmouse-base.c:274
  psmouse_interrupt+0x304/0xf00 drivers/input/mouse/psmouse-base.c:426
  serio_interrupt+0x88/0x150 drivers/input/serio/serio.c:1002
  i8042_interrupt+0x27a/0x520 drivers/input/serio/i8042.c:602
  __handle_irq_event_percpu+0x303/0x8f0 kernel/irq/handle.c:156
  handle_irq_event_percpu kernel/irq/handle.c:196 [inline]
  handle_irq_event+0x102/0x290 kernel/irq/handle.c:213
  handle_edge_irq+0x25f/0xd00 kernel/irq/chip.c:819
  asm_call_irq_on_stack+0xf/0x20
  __run_irq_on_irqstack arch/x86/include/asm/irq_stack.h:48 [inline]
  run_irq_on_irqstack_cond arch/x86/include/asm/irq_stack.h:101 [inline]
  handle_irq arch/x86/kernel/irq.c:230 [inline]
  __common_interrupt arch/x86/kernel/irq.c:249 [inline]
  common_interrupt+0x120/0x200 arch/x86/kernel/irq.c:239
  asm_common_interrupt+0x1e/0x40 arch/x86/include/asm/idtentry.h:619
  unwind_next_frame+0x445/0x1f90 arch/x86/kernel/unwind_orc.c:464
  arch_stack_walk+0x7d/0xe0 arch/x86/kernel/stacktrace.c:25
  stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:121
  kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
  kasan_set_track mm/kasan/common.c:46 [inline]
  set_alloc_info mm/kasan/common.c:401 [inline]
  ____kasan_kmalloc.constprop.0+0x82/0xa0 mm/kasan/common.c:429
  kasan_slab_alloc include/linux/kasan.h:205 [inline]
  slab_post_alloc_hook mm/slab.h:512 [inline]
  slab_alloc_node mm/slub.c:2891 [inline]
  slab_alloc mm/slub.c:2899 [inline]
  kmem_cache_alloc+0x1c6/0x440 mm/slub.c:2904
  anon_vma_chain_alloc mm/rmap.c:136 [inline]
  __anon_vma_prepare+0x5d/0x560 mm/rmap.c:190
  anon_vma_prepare include/linux/rmap.h:152 [inline]
  do_anonymous_page mm/memory.c:3533 [inline]
  handle_pte_fault mm/memory.c:4385 [inline]
  __handle_mm_fault mm/memory.c:4522 [inline]
  handle_mm_fault+0x87d/0x5640 mm/memory.c:4620
  faultin_page mm/gup.c:851 [inline]
  __get_user_pages+0x7ca/0x1490 mm/gup.c:1070
  __get_user_pages_locked mm/gup.c:1256 [inline]
  __get_user_pages_remote+0x18f/0x810 mm/gup.c:1723
  get_user_pages_remote+0x63/0x90 mm/gup.c:1796
  get_arg_page+0xba/0x200 fs/exec.c:223
  copy_string_kernel+0x1b4/0x520 fs/exec.c:634
  kernel_execve+0x25c/0x460 fs/exec.c:1956
  call_usermodehelper_exec_async+0x2de/0x580 kernel/umh.c:110
  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

to a HARDIRQ-irq-unsafe lock:
 (&f->f_owner.lock){.+.+}-{2:2}

... which became HARDIRQ-irq-unsafe at:
...
  lock_acquire kernel/locking/lockdep.c:5437 [inline]
  lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
  __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
  _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
  f_getown+0x1b/0xb0 fs/fcntl.c:152
  sock_ioctl+0x4ba/0x6a0 net/socket.c:1122
  vfs_ioctl fs/ioctl.c:48 [inline]
  __do_sys_ioctl fs/ioctl.c:753 [inline]
  __se_sys_ioctl fs/ioctl.c:739 [inline]
  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

other info that might help us debug this:

Chain exists of:
  &dev->event_lock --> &new->fa_lock --> &f->f_owner.lock

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&f->f_owner.lock);
                               local_irq_disable();
                               lock(&dev->event_lock);
                               lock(&new->fa_lock);
  <Interrupt>
    lock(&dev->event_lock);

 *** DEADLOCK ***

8 locks held by syz-executor435/8478:
 #0: ffff88801d245110 (&evdev->mutex){+.+.}-{3:3}, at: evdev_write+0x1d3/0x760 drivers/input/evdev.c:513
 #1: ffff888145044230 (&dev->event_lock){-...}-{2:2}, at: input_inject_event+0xa6/0x310 drivers/input/input.c:471
 #2: ffffffff8b363860 (rcu_read_lock){....}-{1:2}, at: is_event_supported drivers/input/input.c:53 [inline]
 #2: ffffffff8b363860 (rcu_read_lock){....}-{1:2}, at: is_event_supported drivers/input/input.c:50 [inline]
 #2: ffffffff8b363860 (rcu_read_lock){....}-{1:2}, at: input_inject_event+0x92/0x310 drivers/input/input.c:470
 #3: ffffffff8b363860 (rcu_read_lock){....}-{1:2}, at: input_pass_values.part.0+0x0/0x700 drivers/input/input.c:837
 #4: ffffffff8b363860 (rcu_read_lock){....}-{1:2}, at: evdev_events+0x59/0x3f0 drivers/input/evdev.c:296
 #5: ffff888147dfc028 (&client->buffer_lock){....}-{2:2}, at: spin_lock include/linux/spinlock.h:354 [inline]
 #5: ffff888147dfc028 (&client->buffer_lock){....}-{2:2}, at: evdev_pass_values.part.0+0xf6/0x970 drivers/input/evdev.c:261
 #6: ffffffff8b363860 (rcu_read_lock){....}-{1:2}, at: kill_fasync+0x3d/0x460 fs/fcntl.c:1023
 #7: ffff88802063e018 (&new->fa_lock){....}-{2:2}, at: kill_fasync_rcu fs/fcntl.c:1004 [inline]
 #7: ffff88802063e018 (&new->fa_lock){....}-{2:2}, at: kill_fasync fs/fcntl.c:1025 [inline]
 #7: ffff88802063e018 (&new->fa_lock){....}-{2:2}, at: kill_fasync+0x14b/0x460 fs/fcntl.c:1018

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
  -> (&dev->event_lock){-...}-{2:2} {
     IN-HARDIRQ-W at:
                        lock_acquire kernel/locking/lockdep.c:5437 [inline]
                        lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
                        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                        _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:159
                        input_event drivers/input/input.c:445 [inline]
                        input_event+0x7b/0xb0 drivers/input/input.c:438
                        input_report_key include/linux/input.h:425 [inline]
                        psmouse_report_standard_buttons+0x2c/0x80 drivers/input/mouse/psmouse-base.c:123
                        psmouse_report_standard_packet drivers/input/mouse/psmouse-base.c:141 [inline]
                        psmouse_process_byte+0x1e1/0x890 drivers/input/mouse/psmouse-base.c:232
                        psmouse_handle_byte+0x41/0x1b0 drivers/input/mouse/psmouse-base.c:274
                        psmouse_interrupt+0x304/0xf00 drivers/input/mouse/psmouse-base.c:426
                        serio_interrupt+0x88/0x150 drivers/input/serio/serio.c:1002
                        i8042_interrupt+0x27a/0x520 drivers/input/serio/i8042.c:602
                        __handle_irq_event_percpu+0x303/0x8f0 kernel/irq/handle.c:156
                        handle_irq_event_percpu kernel/irq/handle.c:196 [inline]
                        handle_irq_event+0x102/0x290 kernel/irq/handle.c:213
                        handle_edge_irq+0x25f/0xd00 kernel/irq/chip.c:819
                        asm_call_irq_on_stack+0xf/0x20
                        __run_irq_on_irqstack arch/x86/include/asm/irq_stack.h:48 [inline]
                        run_irq_on_irqstack_cond arch/x86/include/asm/irq_stack.h:101 [inline]
                        handle_irq arch/x86/kernel/irq.c:230 [inline]
                        __common_interrupt arch/x86/kernel/irq.c:249 [inline]
                        common_interrupt+0x120/0x200 arch/x86/kernel/irq.c:239
                        asm_common_interrupt+0x1e/0x40 arch/x86/include/asm/idtentry.h:619
                        unwind_next_frame+0x445/0x1f90 arch/x86/kernel/unwind_orc.c:464
                        arch_stack_walk+0x7d/0xe0 arch/x86/kernel/stacktrace.c:25
                        stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:121
                        kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
                        kasan_set_track mm/kasan/common.c:46 [inline]
                        set_alloc_info mm/kasan/common.c:401 [inline]
                        ____kasan_kmalloc.constprop.0+0x82/0xa0 mm/kasan/common.c:429
                        kasan_slab_alloc include/linux/kasan.h:205 [inline]
                        slab_post_alloc_hook mm/slab.h:512 [inline]
                        slab_alloc_node mm/slub.c:2891 [inline]
                        slab_alloc mm/slub.c:2899 [inline]
                        kmem_cache_alloc+0x1c6/0x440 mm/slub.c:2904
                        anon_vma_chain_alloc mm/rmap.c:136 [inline]
                        __anon_vma_prepare+0x5d/0x560 mm/rmap.c:190
                        anon_vma_prepare include/linux/rmap.h:152 [inline]
                        do_anonymous_page mm/memory.c:3533 [inline]
                        handle_pte_fault mm/memory.c:4385 [inline]
                        __handle_mm_fault mm/memory.c:4522 [inline]
                        handle_mm_fault+0x87d/0x5640 mm/memory.c:4620
                        faultin_page mm/gup.c:851 [inline]
                        __get_user_pages+0x7ca/0x1490 mm/gup.c:1070
                        __get_user_pages_locked mm/gup.c:1256 [inline]
                        __get_user_pages_remote+0x18f/0x810 mm/gup.c:1723
                        get_user_pages_remote+0x63/0x90 mm/gup.c:1796
                        get_arg_page+0xba/0x200 fs/exec.c:223
                        copy_string_kernel+0x1b4/0x520 fs/exec.c:634
                        kernel_execve+0x25c/0x460 fs/exec.c:1956
                        call_usermodehelper_exec_async+0x2de/0x580 kernel/umh.c:110
                        ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
     INITIAL USE at:
                       lock_acquire kernel/locking/lockdep.c:5437 [inline]
                       lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
                       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                       _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:159
                       input_inject_event+0xa6/0x310 drivers/input/input.c:471
                       __led_set_brightness drivers/leds/led-core.c:48 [inline]
                       led_set_brightness_nopm drivers/leds/led-core.c:275 [inline]
                       led_set_brightness_nosleep+0xe6/0x1a0 drivers/leds/led-core.c:292
                       led_set_brightness+0x134/0x170 drivers/leds/led-core.c:267
                       led_trigger_event drivers/leds/led-triggers.c:387 [inline]
                       led_trigger_event+0x70/0xd0 drivers/leds/led-triggers.c:377
                       kbd_led_trigger_activate+0xfa/0x130 drivers/tty/vt/keyboard.c:1017
                       led_trigger_set+0x61e/0xbd0 drivers/leds/led-triggers.c:195
                       led_trigger_set_default drivers/leds/led-triggers.c:259 [inline]
                       led_trigger_set_default+0x1a6/0x230 drivers/leds/led-triggers.c:246
                       led_classdev_register_ext+0x5b1/0x7c0 drivers/leds/led-class.c:417
                       led_classdev_register include/linux/leds.h:190 [inline]
                       input_leds_connect+0x3fb/0x740 drivers/input/input-leds.c:139
                       input_attach_handler+0x180/0x1f0 drivers/input/input.c:1035
                       input_register_device.cold+0xf0/0x307 drivers/input/input.c:2335
                       atkbd_connect+0x736/0xa00 drivers/input/keyboard/atkbd.c:1293
                       serio_connect_driver drivers/input/serio/serio.c:47 [inline]
                       serio_driver_probe+0x72/0xa0 drivers/input/serio/serio.c:778
                       really_probe+0x291/0xde0 drivers/base/dd.c:561
                       driver_probe_device+0x26b/0x3d0 drivers/base/dd.c:745
                       device_driver_attach+0x228/0x290 drivers/base/dd.c:1020
                       __driver_attach+0x15b/0x2f0 drivers/base/dd.c:1097
                       bus_for_each_dev+0x147/0x1d0 drivers/base/bus.c:305
                       serio_attach_driver drivers/input/serio/serio.c:808 [inline]
                       serio_handle_event+0x5f6/0xa30 drivers/input/serio/serio.c:227
                       process_one_work+0x98d/0x15f0 kernel/workqueue.c:2275
                       worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
                       kthread+0x3b1/0x4a0 kernel/kthread.c:292
                       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
   }
   ... key      at: [<ffffffff8fa50fa0>] __key.8+0x0/0x40
   ... acquired at:
   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
   _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
   spin_lock include/linux/spinlock.h:354 [inline]
   evdev_pass_values.part.0+0xf6/0x970 drivers/input/evdev.c:261
   evdev_pass_values drivers/input/evdev.c:253 [inline]
   evdev_events+0x28b/0x3f0 drivers/input/evdev.c:306
   input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
   input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
   input_pass_values drivers/input/input.c:134 [inline]
   input_handle_event+0x373/0x1440 drivers/input/input.c:404
   input_inject_event+0x2f5/0x310 drivers/input/input.c:476
   evdev_write+0x430/0x760 drivers/input/evdev.c:530
   vfs_write+0x28e/0xa30 fs/read_write.c:603
   ksys_write+0x1ee/0x250 fs/read_write.c:658
   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

 -> (&client->buffer_lock){....}-{2:2} {
    INITIAL USE at:
                     lock_acquire kernel/locking/lockdep.c:5437 [inline]
                     lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
                     __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                     _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
                     spin_lock include/linux/spinlock.h:354 [inline]
                     evdev_pass_values.part.0+0xf6/0x970 drivers/input/evdev.c:261
                     evdev_pass_values drivers/input/evdev.c:253 [inline]
                     evdev_events+0x28b/0x3f0 drivers/input/evdev.c:306
                     input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
                     input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
                     input_pass_values drivers/input/input.c:134 [inline]
                     input_handle_event+0x373/0x1440 drivers/input/input.c:404
                     input_inject_event+0x2f5/0x310 drivers/input/input.c:476
                     evdev_write+0x430/0x760 drivers/input/evdev.c:530
                     vfs_write+0x28e/0xa30 fs/read_write.c:603
                     ksys_write+0x1ee/0x250 fs/read_write.c:658
                     do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                     entry_SYSCALL_64_after_hwframe+0x44/0xa9
  }
  ... key      at: [<ffffffff8fa51420>] __key.4+0x0/0x40
  ... acquired at:
   __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
   _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
   kill_fasync_rcu fs/fcntl.c:1004 [inline]
   kill_fasync fs/fcntl.c:1025 [inline]
   kill_fasync+0x14b/0x460 fs/fcntl.c:1018
   __pass_event drivers/input/evdev.c:240 [inline]
   evdev_pass_values.part.0+0x64e/0x970 drivers/input/evdev.c:278
   evdev_pass_values drivers/input/evdev.c:253 [inline]
   evdev_events+0x28b/0x3f0 drivers/input/evdev.c:306
   input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
   input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
   input_pass_values drivers/input/input.c:134 [inline]
   input_handle_event+0x373/0x1440 drivers/input/input.c:404
   input_inject_event+0x2f5/0x310 drivers/input/input.c:476
   evdev_write+0x430/0x760 drivers/input/evdev.c:530
   vfs_write+0x28e/0xa30 fs/read_write.c:603
   ksys_write+0x1ee/0x250 fs/read_write.c:658
   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> (&new->fa_lock){....}-{2:2} {
   INITIAL READ USE at:
                        lock_acquire kernel/locking/lockdep.c:5437 [inline]
                        lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
                        __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                        _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
                        kill_fasync_rcu fs/fcntl.c:1004 [inline]
                        kill_fasync fs/fcntl.c:1025 [inline]
                        kill_fasync+0x14b/0x460 fs/fcntl.c:1018
                        __pass_event drivers/input/evdev.c:240 [inline]
                        evdev_pass_values.part.0+0x64e/0x970 drivers/input/evdev.c:278
                        evdev_pass_values drivers/input/evdev.c:253 [inline]
                        evdev_events+0x28b/0x3f0 drivers/input/evdev.c:306
                        input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
                        input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
                        input_pass_values drivers/input/input.c:134 [inline]
                        input_handle_event+0x373/0x1440 drivers/input/input.c:404
                        input_inject_event+0x2f5/0x310 drivers/input/input.c:476
                        evdev_write+0x430/0x760 drivers/input/evdev.c:530
                        vfs_write+0x28e/0xa30 fs/read_write.c:603
                        ksys_write+0x1ee/0x250 fs/read_write.c:658
                        do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                        entry_SYSCALL_64_after_hwframe+0x44/0xa9
 }
 ... key      at: [<ffffffff8ef8d980>] __key.0+0x0/0x40
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5437 [inline]
   lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
   _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:231
   send_sigio+0x24/0x360 fs/fcntl.c:787
   kill_fasync_rcu fs/fcntl.c:1011 [inline]
   kill_fasync fs/fcntl.c:1025 [inline]
   kill_fasync+0x205/0x460 fs/fcntl.c:1018
   __pass_event drivers/input/evdev.c:240 [inline]
   evdev_pass_values.part.0+0x64e/0x970 drivers/input/evdev.c:278
   evdev_pass_values drivers/input/evdev.c:253 [inline]
   evdev_events+0x28b/0x3f0 drivers/input/evdev.c:306
   input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
   input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
   input_pass_values drivers/input/input.c:134 [inline]
   input_handle_event+0x373/0x1440 drivers/input/input.c:404
   input_inject_event+0x2f5/0x310 drivers/input/input.c:476
   evdev_write+0x430/0x760 drivers/input/evdev.c:530
   vfs_write+0x28e/0xa30 fs/read_write.c:603
   ksys_write+0x1ee/0x250 fs/read_write.c:658
   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
   entry_SYSCALL_64_after_hwframe+0x44/0xa9


the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
-> (&f->f_owner.lock){.+.+}-{2:2} {
   HARDIRQ-ON-R at:
                    lock_acquire kernel/locking/lockdep.c:5437 [inline]
                    lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
                    __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                    _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
                    f_getown+0x1b/0xb0 fs/fcntl.c:152
                    sock_ioctl+0x4ba/0x6a0 net/socket.c:1122
                    vfs_ioctl fs/ioctl.c:48 [inline]
                    __do_sys_ioctl fs/ioctl.c:753 [inline]
                    __se_sys_ioctl fs/ioctl.c:739 [inline]
                    __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
                    do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                    entry_SYSCALL_64_after_hwframe+0x44/0xa9
   SOFTIRQ-ON-R at:
                    lock_acquire kernel/locking/lockdep.c:5437 [inline]
                    lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
                    __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                    _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
                    f_getown+0x1b/0xb0 fs/fcntl.c:152
                    sock_ioctl+0x4ba/0x6a0 net/socket.c:1122
                    vfs_ioctl fs/ioctl.c:48 [inline]
                    __do_sys_ioctl fs/ioctl.c:753 [inline]
                    __se_sys_ioctl fs/ioctl.c:739 [inline]
                    __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
                    do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                    entry_SYSCALL_64_after_hwframe+0x44/0xa9
   INITIAL READ USE at:
                        lock_acquire kernel/locking/lockdep.c:5437 [inline]
                        lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
                        __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                        _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
                        f_getown+0x1b/0xb0 fs/fcntl.c:152
                        sock_ioctl+0x4ba/0x6a0 net/socket.c:1122
                        vfs_ioctl fs/ioctl.c:48 [inline]
                        __do_sys_ioctl fs/ioctl.c:753 [inline]
                        __se_sys_ioctl fs/ioctl.c:739 [inline]
                        __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
                        do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                        entry_SYSCALL_64_after_hwframe+0x44/0xa9
 }
 ... key      at: [<ffffffff8ef8cba0>] __key.5+0x0/0x40
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5437 [inline]
   lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
   _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:231
   send_sigio+0x24/0x360 fs/fcntl.c:787
   kill_fasync_rcu fs/fcntl.c:1011 [inline]
   kill_fasync fs/fcntl.c:1025 [inline]
   kill_fasync+0x205/0x460 fs/fcntl.c:1018
   __pass_event drivers/input/evdev.c:240 [inline]
   evdev_pass_values.part.0+0x64e/0x970 drivers/input/evdev.c:278
   evdev_pass_values drivers/input/evdev.c:253 [inline]
   evdev_events+0x28b/0x3f0 drivers/input/evdev.c:306
   input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
   input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
   input_pass_values drivers/input/input.c:134 [inline]
   input_handle_event+0x373/0x1440 drivers/input/input.c:404
   input_inject_event+0x2f5/0x310 drivers/input/input.c:476
   evdev_write+0x430/0x760 drivers/input/evdev.c:530
   vfs_write+0x28e/0xa30 fs/read_write.c:603
   ksys_write+0x1ee/0x250 fs/read_write.c:658
   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
   entry_SYSCALL_64_after_hwframe+0x44/0xa9


stack backtrace:
CPU: 0 PID: 8478 Comm: syz-executor435 Not tainted 5.11.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_bad_irq_dependency kernel/locking/lockdep.c:2452 [inline]
 check_irq_usage.cold+0x4f5/0x6c8 kernel/locking/lockdep.c:2681
 check_prev_add kernel/locking/lockdep.c:2872 [inline]
 check_prevs_add kernel/locking/lockdep.c:2993 [inline]
 validate_chain kernel/locking/lockdep.c:3608 [inline]
 __lock_acquire+0x2af6/0x5500 kernel/locking/lockdep.c:4832
 lock_acquire kernel/locking/lockdep.c:5437 [inline]
 lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
 __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
 _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:231
 send_sigio+0x24/0x360 fs/fcntl.c:787
 kill_fasync_rcu fs/fcntl.c:1011 [inline]
 kill_fasync fs/fcntl.c:1025 [inline]
 kill_fasync+0x205/0x460 fs/fcntl.c:1018
 __pass_event drivers/input/evdev.c:240 [inline]
 evdev_pass_values.part.0+0x64e/0x970 drivers/input/evdev.c:278
 evdev_pass_values drivers/input/evdev.c:253 [inline]
 evdev_events+0x28b/0x3f0 drivers/input/evdev.c:306
 input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
 input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
 input_pass_values drivers/input/input.c:134 [inline]
 input_handle_event+0x373/0x1440 drivers/input/input.c:404
 input_inject_event+0x2f5/0x310 drivers/input/input.c:476
 evdev_write+0x430/0x760 drivers/input/evdev.c:530
 vfs_write+0x28e/0xa30 fs/read_write.c:603
 ksys_write+0x1ee/0x250 fs/read_write.c:658
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4475b9
Code: e8 bc af 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 9b d7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd4b0caf48 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 00000000004475b9
RDX: 0000000000035000 RSI: 000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
