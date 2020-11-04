Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3C22A6102
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 10:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgKDJ6U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 04:58:20 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:43334 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbgKDJ6S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 04:58:18 -0500
Received: by mail-il1-f197.google.com with SMTP id t6so14986086ilj.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2020 01:58:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=wZ2beKD3D99+dCpCpU96jUQds+jAy4fnYrluWJM7y/Q=;
        b=PhjXHgITzddp0cExQ1EnA3ZdUatzzaw/1dFjPWtZWgBLLrlribzRCzh0SSGYj/SNa+
         qIl7cILyxxfpWggUqeIjEK3eqrmQrQUr+naMi25RjjlUXJxINo3hzUIvIOBD2kl4t9YE
         XP4LpvORFdD51bmiqFW11AgIcTTn8Zwy/djclZxZHXj7ZmYnOKqZ5lU+fKkRZLQh6koF
         oCumhpAE3H++aNZliYCH/JNOMO/upJ6Zvx+WQYnlHcYa6+7qDBOmHmDUc15MTuc68899
         nhp6h1r7T/ncHV9i2LKlmxmMuQC1868yGgMNzM+zJel8CfWyA2ZcOYhFbvEs1WJsvckH
         W6CQ==
X-Gm-Message-State: AOAM533lbZdenL9elY77EIxRxccehFYG3U0j4DM6qrfH9G83wEShabG7
        C3ke0CoDxLoTt2spvsh7kb15RWZZ5xB+0v4w1PYx4vGKgrSY
X-Google-Smtp-Source: ABdhPJyd9etWIipDSyvu81WPCNoY3vRe5oWJVBkpjyb/UCKly67L1BlkqlM44fzV1/GZ5PsMHhUllAsmwoK8SJPd7plIVwyDyevA
MIME-Version: 1.0
X-Received: by 2002:a02:c995:: with SMTP id b21mr19436503jap.65.1604483896022;
 Wed, 04 Nov 2020 01:58:16 -0800 (PST)
Date:   Wed, 04 Nov 2020 01:58:16 -0800
In-Reply-To: <0000000000009d056805b252e883@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab999d05b34504d3@google.com>
Subject: Re: possible deadlock in send_sigurg (2)
From:   syzbot <syzbot+c5e32344981ad9f33750@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    4ef8451b Merge tag 'perf-tools-for-v5.10-2020-11-03' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16ab063a500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61033507391c77ff
dashboard link: https://syzkaller.appspot.com/bug?extid=c5e32344981ad9f33750
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15197862500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c59f6c500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c5e32344981ad9f33750@syzkaller.appspotmail.com

netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0
nf_conntrack: default automatic helper assignment has been turned off for security reasons and CT-based  firewall rule not found. Use the iptables CT target to attach helpers instead.
========================================================
WARNING: possible irq lock inversion dependency detected
5.10.0-rc2-syzkaller #0 Not tainted
--------------------------------------------------------
syz-executor981/8491 just changed the state of lock:
ffff88801798e638 (&f->f_owner.lock){.+..}-{2:2}, at: send_sigurg+0x1e/0xac0 fs/fcntl.c:824
but this lock was taken by another, HARDIRQ-safe lock in the past:
 (&dev->event_lock){-...}-{2:2}


and interrupts could create inverse lock ordering between them.


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

1 lock held by syz-executor981/8491:
 #0: ffff888023e118a0 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1581 [inline]
 #0: ffff888023e118a0 (sk_lock-AF_INET){+.+.}-{0:0}, at: inet_wait_for_connect net/ipv4/af_inet.c:596 [inline]
 #0: ffff888023e118a0 (sk_lock-AF_INET){+.+.}-{0:0}, at: __inet_stream_connect+0x596/0xe30 net/ipv4/af_inet.c:686

the shortest dependencies between 2nd lock and 1st lock:
   -> (&dev->event_lock){-...}-{2:2} {
      IN-HARDIRQ-W at:
                          lock_acquire kernel/locking/lockdep.c:5436 [inline]
                          lock_acquire+0x2a3/0x8c0 kernel/locking/lockdep.c:5401
                          __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                          _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:159
                          input_event drivers/input/input.c:440 [inline]
                          input_event+0x7b/0xb0 drivers/input/input.c:433
                          input_report_key include/linux/input.h:417 [inline]
                          psmouse_report_standard_buttons+0x2c/0x80 drivers/input/mouse/psmouse-base.c:123
                          psmouse_report_standard_packet drivers/input/mouse/psmouse-base.c:141 [inline]
                          psmouse_process_byte+0x1e1/0x890 drivers/input/mouse/psmouse-base.c:232
                          psmouse_handle_byte+0x41/0x1b0 drivers/input/mouse/psmouse-base.c:274
                          psmouse_interrupt+0x304/0xf00 drivers/input/mouse/psmouse-base.c:426
                          serio_interrupt+0x88/0x150 drivers/input/serio/serio.c:1002
                          i8042_interrupt+0x27a/0x520 drivers/input/serio/i8042.c:598
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
                          asm_common_interrupt+0x1e/0x40 arch/x86/include/asm/idtentry.h:622
                          native_safe_halt arch/x86/include/asm/irqflags.h:60 [inline]
                          arch_safe_halt arch/x86/include/asm/irqflags.h:103 [inline]
                          acpi_safe_halt drivers/acpi/processor_idle.c:111 [inline]
                          acpi_idle_do_entry+0x1c9/0x250 drivers/acpi/processor_idle.c:517
                          acpi_idle_enter+0x361/0x500 drivers/acpi/processor_idle.c:648
                          cpuidle_enter_state+0x1b1/0xc80 drivers/cpuidle/cpuidle.c:237
                          cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:351
                          call_cpuidle kernel/sched/idle.c:132 [inline]
                          cpuidle_idle_call kernel/sched/idle.c:213 [inline]
                          do_idle+0x3e1/0x590 kernel/sched/idle.c:273
                          cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:369
                          start_secondary+0x266/0x340 arch/x86/kernel/smpboot.c:266
                          secondary_startup_64_no_verify+0xb0/0xbb
      INITIAL USE at:
                         lock_acquire kernel/locking/lockdep.c:5436 [inline]
                         lock_acquire+0x2a3/0x8c0 kernel/locking/lockdep.c:5401
                         __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                         _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:159
                         input_inject_event+0xa6/0x310 drivers/input/input.c:466
                         __led_set_brightness drivers/leds/led-core.c:48 [inline]
                         led_set_brightness_nopm drivers/leds/led-core.c:275 [inline]
                         led_set_brightness_nosleep+0xe6/0x1a0 drivers/leds/led-core.c:292
                         led_set_brightness+0x134/0x170 drivers/leds/led-core.c:267
                         led_trigger_event drivers/leds/led-triggers.c:387 [inline]
                         led_trigger_event+0x70/0xd0 drivers/leds/led-triggers.c:377
                         kbd_led_trigger_activate+0xfa/0x130 drivers/tty/vt/keyboard.c:1010
                         led_trigger_set+0x61e/0xbd0 drivers/leds/led-triggers.c:195
                         led_trigger_set_default drivers/leds/led-triggers.c:259 [inline]
                         led_trigger_set_default+0x1a6/0x230 drivers/leds/led-triggers.c:246
                         led_classdev_register_ext+0x5b1/0x7c0 drivers/leds/led-class.c:417
                         led_classdev_register include/linux/leds.h:190 [inline]
                         input_leds_connect+0x3fb/0x740 drivers/input/input-leds.c:139
                         input_attach_handler+0x180/0x1f0 drivers/input/input.c:1031
                         input_register_device.cold+0xf0/0x307 drivers/input/input.c:2229
                         atkbd_connect+0x736/0xa00 drivers/input/keyboard/atkbd.c:1293
                         serio_connect_driver drivers/input/serio/serio.c:47 [inline]
                         serio_driver_probe+0x72/0xa0 drivers/input/serio/serio.c:778
                         really_probe+0x291/0xde0 drivers/base/dd.c:554
                         driver_probe_device+0x26b/0x3d0 drivers/base/dd.c:738
                         device_driver_attach+0x228/0x290 drivers/base/dd.c:1013
                         __driver_attach+0x15b/0x2f0 drivers/base/dd.c:1090
                         bus_for_each_dev+0x147/0x1d0 drivers/base/bus.c:305
                         serio_attach_driver drivers/input/serio/serio.c:808 [inline]
                         serio_handle_event+0x5f6/0xa30 drivers/input/serio/serio.c:227
                         process_one_work+0x933/0x15a0 kernel/workqueue.c:2272
                         worker_thread+0x64c/0x1120 kernel/workqueue.c:2418
                         kthread+0x3af/0x4a0 kernel/kthread.c:292
                         ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
    }
    ... key      at: [<ffffffff8fa24220>] __key.8+0x0/0x40
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
   input_handle_event+0x324/0x1400 drivers/input/input.c:399
   input_inject_event+0x2f5/0x310 drivers/input/input.c:471
   evdev_write+0x430/0x760 drivers/input/evdev.c:530
   vfs_write+0x28e/0x700 fs/read_write.c:603
   ksys_write+0x1ee/0x250 fs/read_write.c:658
   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

  -> (&client->buffer_lock){....}-{2:2} {
     INITIAL USE at:
                       lock_acquire kernel/locking/lockdep.c:5436 [inline]
                       lock_acquire+0x2a3/0x8c0 kernel/locking/lockdep.c:5401
                       __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                       _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
                       spin_lock include/linux/spinlock.h:354 [inline]
                       evdev_pass_values.part.0+0xf6/0x970 drivers/input/evdev.c:261
                       evdev_pass_values drivers/input/evdev.c:253 [inline]
                       evdev_events+0x28b/0x3f0 drivers/input/evdev.c:306
                       input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
                       input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
                       input_pass_values drivers/input/input.c:134 [inline]
                       input_handle_event+0x324/0x1400 drivers/input/input.c:399
                       input_inject_event+0x2f5/0x310 drivers/input/input.c:471
                       evdev_write+0x430/0x760 drivers/input/evdev.c:530
                       vfs_write+0x28e/0x700 fs/read_write.c:603
                       ksys_write+0x1ee/0x250 fs/read_write.c:658
                       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                       entry_SYSCALL_64_after_hwframe+0x44/0xa9
   }
   ... key      at: [<ffffffff8fa24720>] __key.4+0x0/0x40
   ... acquired at:
   __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
   _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
   kill_fasync_rcu fs/fcntl.c:1002 [inline]
   kill_fasync fs/fcntl.c:1023 [inline]
   kill_fasync+0x14b/0x460 fs/fcntl.c:1016
   __pass_event drivers/input/evdev.c:240 [inline]
   evdev_pass_values.part.0+0x64e/0x970 drivers/input/evdev.c:278
   evdev_pass_values drivers/input/evdev.c:253 [inline]
   evdev_events+0x28b/0x3f0 drivers/input/evdev.c:306
   input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
   input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
   input_pass_values drivers/input/input.c:134 [inline]
   input_handle_event+0x324/0x1400 drivers/input/input.c:399
   input_inject_event+0x2f5/0x310 drivers/input/input.c:471
   evdev_write+0x430/0x760 drivers/input/evdev.c:530
   vfs_write+0x28e/0x700 fs/read_write.c:603
   ksys_write+0x1ee/0x250 fs/read_write.c:658
   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

 -> (&new->fa_lock){....}-{2:2} {
    INITIAL READ USE at:
                          lock_acquire kernel/locking/lockdep.c:5436 [inline]
                          lock_acquire+0x2a3/0x8c0 kernel/locking/lockdep.c:5401
                          __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                          _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
                          kill_fasync_rcu fs/fcntl.c:1002 [inline]
                          kill_fasync fs/fcntl.c:1023 [inline]
                          kill_fasync+0x14b/0x460 fs/fcntl.c:1016
                          __pass_event drivers/input/evdev.c:240 [inline]
                          evdev_pass_values.part.0+0x64e/0x970 drivers/input/evdev.c:278
                          evdev_pass_values drivers/input/evdev.c:253 [inline]
                          evdev_events+0x28b/0x3f0 drivers/input/evdev.c:306
                          input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
                          input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
                          input_pass_values drivers/input/input.c:134 [inline]
                          input_handle_event+0x324/0x1400 drivers/input/input.c:399
                          input_inject_event+0x2f5/0x310 drivers/input/input.c:471
                          evdev_write+0x430/0x760 drivers/input/evdev.c:530
                          vfs_write+0x28e/0x700 fs/read_write.c:603
                          ksys_write+0x1ee/0x250 fs/read_write.c:658
                          do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                          entry_SYSCALL_64_after_hwframe+0x44/0xa9
  }
  ... key      at: [<ffffffff8ef5e800>] __key.0+0x0/0x40
  ... acquired at:
   __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
   _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
   send_sigio+0x24/0x360 fs/fcntl.c:786
   kill_fasync_rcu fs/fcntl.c:1009 [inline]
   kill_fasync fs/fcntl.c:1023 [inline]
   kill_fasync+0x205/0x460 fs/fcntl.c:1016
   __pass_event drivers/input/evdev.c:240 [inline]
   evdev_pass_values.part.0+0x64e/0x970 drivers/input/evdev.c:278
   evdev_pass_values drivers/input/evdev.c:253 [inline]
   evdev_events+0x28b/0x3f0 drivers/input/evdev.c:306
   input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
   input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
   input_pass_values drivers/input/input.c:134 [inline]
   input_handle_event+0x324/0x1400 drivers/input/input.c:399
   input_inject_event+0x2f5/0x310 drivers/input/input.c:471
   evdev_write+0x430/0x760 drivers/input/evdev.c:530
   vfs_write+0x28e/0x700 fs/read_write.c:603
   ksys_write+0x1ee/0x250 fs/read_write.c:658
   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> (&f->f_owner.lock){.+..}-{2:2} {
   HARDIRQ-ON-R at:
                    lock_acquire kernel/locking/lockdep.c:5436 [inline]
                    lock_acquire+0x2a3/0x8c0 kernel/locking/lockdep.c:5401
                    __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                    _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
                    send_sigurg+0x1e/0xac0 fs/fcntl.c:824
                    sk_send_sigurg+0x76/0x300 net/core/sock.c:2925
                    tcp_check_urg.isra.0+0x1f4/0x710 net/ipv4/tcp_input.c:5490
                    tcp_urg net/ipv4/tcp_input.c:5531 [inline]
                    tcp_rcv_established+0x106c/0x1eb0 net/ipv4/tcp_input.c:5865
                    tcp_v4_do_rcv+0x5d1/0x870 net/ipv4/tcp_ipv4.c:1652
                    sk_backlog_rcv include/net/sock.h:1010 [inline]
                    __release_sock+0x134/0x3a0 net/core/sock.c:2523
                    release_sock+0x54/0x1b0 net/core/sock.c:3053
                    sk_stream_wait_memory+0x5bd/0xe60 net/core/stream.c:145
                    tcp_sendmsg_locked+0x1034/0x2d20 net/ipv4/tcp.c:1404
                    tcp_sendmsg+0x2b/0x40 net/ipv4/tcp.c:1444
                    inet_sendmsg+0x99/0xe0 net/ipv4/af_inet.c:817
                    sock_sendmsg_nosec net/socket.c:651 [inline]
                    sock_sendmsg+0xcf/0x120 net/socket.c:671
                    __sys_sendto+0x21c/0x320 net/socket.c:1992
                    __do_sys_sendto net/socket.c:2004 [inline]
                    __se_sys_sendto net/socket.c:2000 [inline]
                    __x64_sys_sendto+0xdd/0x1b0 net/socket.c:2000
                    do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                    entry_SYSCALL_64_after_hwframe+0x44/0xa9
   INITIAL READ USE at:
                        lock_acquire kernel/locking/lockdep.c:5436 [inline]
                        lock_acquire+0x2a3/0x8c0 kernel/locking/lockdep.c:5401
                        __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                        _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
                        send_sigio+0x24/0x360 fs/fcntl.c:786
                        kill_fasync_rcu fs/fcntl.c:1009 [inline]
                        kill_fasync fs/fcntl.c:1023 [inline]
                        kill_fasync+0x205/0x460 fs/fcntl.c:1016
                        __pass_event drivers/input/evdev.c:240 [inline]
                        evdev_pass_values.part.0+0x64e/0x970 drivers/input/evdev.c:278
                        evdev_pass_values drivers/input/evdev.c:253 [inline]
                        evdev_events+0x28b/0x3f0 drivers/input/evdev.c:306
                        input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
                        input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
                        input_pass_values drivers/input/input.c:134 [inline]
                        input_handle_event+0x324/0x1400 drivers/input/input.c:399
                        input_inject_event+0x2f5/0x310 drivers/input/input.c:471
                        evdev_write+0x430/0x760 drivers/input/evdev.c:530
                        vfs_write+0x28e/0x700 fs/read_write.c:603
                        ksys_write+0x1ee/0x250 fs/read_write.c:658
                        do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                        entry_SYSCALL_64_after_hwframe+0x44/0xa9
 }
 ... key      at: [<ffffffff8ef5da20>] __key.5+0x0/0x40
 ... acquired at:
   mark_usage kernel/locking/lockdep.c:4311 [inline]
   __lock_acquire+0x11f5/0x5590 kernel/locking/lockdep.c:4785
   lock_acquire kernel/locking/lockdep.c:5436 [inline]
   lock_acquire+0x2a3/0x8c0 kernel/locking/lockdep.c:5401
   __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
   _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
   send_sigurg+0x1e/0xac0 fs/fcntl.c:824
   sk_send_sigurg+0x76/0x300 net/core/sock.c:2925
   tcp_check_urg.isra.0+0x1f4/0x710 net/ipv4/tcp_input.c:5490
   tcp_urg net/ipv4/tcp_input.c:5531 [inline]
   tcp_rcv_established+0x106c/0x1eb0 net/ipv4/tcp_input.c:5865
   tcp_v4_do_rcv+0x5d1/0x870 net/ipv4/tcp_ipv4.c:1652
   sk_backlog_rcv include/net/sock.h:1010 [inline]
   __release_sock+0x134/0x3a0 net/core/sock.c:2523
   release_sock+0x54/0x1b0 net/core/sock.c:3053
   sk_stream_wait_memory+0x5bd/0xe60 net/core/stream.c:145
   tcp_sendmsg_locked+0x1034/0x2d20 net/ipv4/tcp.c:1404
   tcp_sendmsg+0x2b/0x40 net/ipv4/tcp.c:1444
   inet_sendmsg+0x99/0xe0 net/ipv4/af_inet.c:817
   sock_sendmsg_nosec net/socket.c:651 [inline]
   sock_sendmsg+0xcf/0x120 net/socket.c:671
   __sys_sendto+0x21c/0x320 net/socket.c:1992
   __do_sys_sendto net/socket.c:2004 [inline]
   __se_sys_sendto net/socket.c:2000 [inline]
   __x64_sys_sendto+0xdd/0x1b0 net/socket.c:2000
   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
   entry_SYSCALL_64_after_hwframe+0x44/0xa9


stack backtrace:
CPU: 0 PID: 8491 Comm: syz-executor981 Not tainted 5.10.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 print_irq_inversion_bug kernel/locking/lockdep.c:3739 [inline]
 check_usage_backwards kernel/locking/lockdep.c:3883 [inline]
 mark_lock_irq kernel/locking/lockdep.c:3973 [inline]
 mark_lock.cold+0x1a/0x74 kernel/locking/lockdep.c:4410
 mark_usage kernel/locking/lockdep.c:4311 [inline]
 __lock_acquire+0x11f5/0x5590 kernel/locking/lockdep.c:4785
 lock_acquire kernel/locking/lockdep.c:5436 [inline]
 lock_acquire+0x2a3/0x8c0 kernel/locking/lockdep.c:5401
 __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
 _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
 send_sigurg+0x1e/0xac0 fs/fcntl.c:824
 sk_send_sigurg+0x76/0x300 net/core/sock.c:2925
 tcp_check_urg.isra.0+0x1f4/0x710 net/ipv4/tcp_input.c:5490
 tcp_urg net/ipv4/tcp_input.c:5531 [inline]
 tcp_rcv_established+0x106c/0x1eb0 net/ipv4/tcp_input.c:5865
 tcp_v4_do_rcv+0x5d1/0x870 net/ipv4/tcp_ipv4.c:1652
 sk_backlog_rcv include/net/sock.h:1010 [inline]
 __release_sock+0x134/0x3a0 net/core/sock.c:2523
 release_sock+0x54/0x1b0 net/core/sock.c:3053
 sk_stream_wait_memory+0x5bd/0xe60 net/core/stream.c:145
 tcp_sendmsg_locked+0x1034/0x2d20 net/ipv4/tcp.c:1404
 tcp_sendmsg+0x2b/0x40 net/ipv4/tcp.c:1444
 inet_sendmsg+0x99/0xe0 net/ipv4/af_inet.c:817
 sock_sendmsg_nosec net/socket.c:651 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:671
 __sys_sendto+0x21c/0x320 net/socket.c:1992
 __do_sys_sendto net/socket.c:2004 [inline]
 __se_sys_sendto net/socket.c:2000 [inline]
 __x64_sys_sendto+0xdd/0x1b0 net/socket.c:2000
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x447309
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 0b d2 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffd9b651c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000447309
RDX: ffffffffffffff58 RSI: 0000000020000140 RDI: 0000000000000004
RBP: 00007fffd9b651e0 R08: 0000000020000100 R09: 0000000000000010
R10: 0000000020008005 R11: 0000000000000246 R12: 00007fffd9b651f0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

