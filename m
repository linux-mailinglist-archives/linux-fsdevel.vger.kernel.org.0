Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA4B262ADF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 10:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgIIIs0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 04:48:26 -0400
Received: from mail-il1-f206.google.com ([209.85.166.206]:44299 "EHLO
        mail-il1-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgIIIsS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:48:18 -0400
Received: by mail-il1-f206.google.com with SMTP id j11so1493958ilr.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2020 01:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hZXQDqmOoeS3Q7XUbaoUGQl/3oritwOriLpFXlrkboI=;
        b=npK72qumOmqe901VkAqaFdSqMXC32dWdc+1DMaZot8oLM+wPDky+daHLY6563oLfSW
         Eq/URiIpkBye76z0xaP/HDAUYg0HnZ5iblDOTwlr0EgVgFbeAMZc5FsblZw/+DflA/hH
         M23kolSTUfo9waQLSObRVvV/ZnnsRX6HArGLuFEG0BMiPdRSD/ULEXcYEkf+Mj33xcHd
         7qmuNv5lJZIfDyDxuQM1jCF2JInPh0TbmEotp+GS1AU6z5q+3JHL+d7zk4lJIijwulAe
         N8PWmLooLORngQqEYdNE0D3UTNZczjG4Enve9m1PQVSQUPRn3ypQSRHNudcPvx7wAaJO
         JGOA==
X-Gm-Message-State: AOAM533la1inB7/aTD1SGfuKFyv1u3x9hkMiwnmG2HFAtrFDBK99RhkG
        IWSn3wsATFJ8+QRIXFH4nCbHaHsxqn4NZ9205AxaqCxAx84G
X-Google-Smtp-Source: ABdhPJw6WRTTAS6hoL3Wa3YzS4Htjc2Uncbkigtj6c70kU5qMEJbn4IHEP68gRwoOXBZBFLZrr1sqlCXLoLlvnYPNHvdooN9SFbv
MIME-Version: 1.0
X-Received: by 2002:a5e:820d:: with SMTP id l13mr2635779iom.3.1599641295313;
 Wed, 09 Sep 2020 01:48:15 -0700 (PDT)
Date:   Wed, 09 Sep 2020 01:48:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002cdf7305aedd838d@google.com>
Subject: WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected (2)
From:   syzbot <syzbot+22e87cdf94021b984aa6@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    dff9f829 Add linux-next specific files for 20200908
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=113184dd900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37b3426c77bda44c
dashboard link: https://syzkaller.appspot.com/bug?extid=22e87cdf94021b984aa6
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108b740d900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12daa9ed900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+22e87cdf94021b984aa6@syzkaller.appspotmail.com

netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0
=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
5.9.0-rc4-next-20200908-syzkaller #0 Not tainted
-----------------------------------------------------
syz-executor198/6886 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffff88809ad60638 (&f->f_owner.lock){.+.+}-{2:2}, at: send_sigio+0x24/0x320 fs/fcntl.c:786

and this task is already holding:
ffff888092b709f0 (&new->fa_lock){....}-{2:2}, at: kill_fasync_rcu fs/fcntl.c:1002 [inline]
ffff888092b709f0 (&new->fa_lock){....}-{2:2}, at: kill_fasync fs/fcntl.c:1023 [inline]
ffff888092b709f0 (&new->fa_lock){....}-{2:2}, at: kill_fasync+0x14b/0x460 fs/fcntl.c:1016
which would create a new lock dependency:
 (&new->fa_lock){....}-{2:2} -> (&f->f_owner.lock){.+.+}-{2:2}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&dev->event_lock){-...}-{2:2}

... which became HARDIRQ-irq-safe at:
  lock_acquire+0x1f3/0xaf0 kernel/locking/lockdep.c:5398
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x94/0xd0 kernel/locking/spinlock.c:159
  input_event drivers/input/input.c:440 [inline]
  input_event+0x7b/0xb0 drivers/input/input.c:433
  input_report_key include/linux/input.h:417 [inline]
  psmouse_report_standard_buttons+0x2c/0x80 drivers/input/mouse/psmouse-base.c:123
  psmouse_report_standard_packet drivers/input/mouse/psmouse-base.c:141 [inline]
  psmouse_process_byte+0x1e1/0x890 drivers/input/mouse/psmouse-base.c:232
  psmouse_handle_byte+0x41/0x1b0 drivers/input/mouse/psmouse-base.c:274
  psmouse_interrupt+0x2fa/0xe90 drivers/input/mouse/psmouse-base.c:426
  serio_interrupt+0x88/0x150 drivers/input/serio/serio.c:1002
  i8042_interrupt+0x270/0x500 drivers/input/serio/i8042.c:598
  __handle_irq_event_percpu+0x223/0xaa0 kernel/irq/handle.c:156
  handle_irq_event_percpu kernel/irq/handle.c:196 [inline]
  handle_irq_event+0x102/0x290 kernel/irq/handle.c:213
  handle_edge_irq+0x25f/0xd00 kernel/irq/chip.c:819
  asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:706
  __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
  run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
  handle_irq arch/x86/kernel/irq.c:230 [inline]
  __common_interrupt arch/x86/kernel/irq.c:249 [inline]
  common_interrupt+0x115/0x1f0 arch/x86/kernel/irq.c:239
  asm_common_interrupt+0x1e/0x40 arch/x86/include/asm/idtentry.h:572
  arch_local_irq_restore arch/x86/include/asm/paravirt.h:653 [inline]
  lock_acquire+0x27b/0xaf0 kernel/locking/lockdep.c:5401
  rcu_lock_acquire include/linux/rcupdate.h:248 [inline]
  rcu_read_lock include/linux/rcupdate.h:641 [inline]
  path_init+0x851/0x13c0 fs/namei.c:2213
  path_openat+0x185/0x2730 fs/namei.c:3364
  do_filp_open+0x17e/0x3c0 fs/namei.c:3396
  do_open_execat+0x116/0x690 fs/exec.c:910
  bprm_execve+0x508/0x1b10 fs/exec.c:1909
  kernel_execve+0x370/0x460 fs/exec.c:2080
  call_usermodehelper_exec_async+0x27a/0x500 kernel/umh.c:101
  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

to a HARDIRQ-irq-unsafe lock:
 (&f->f_owner.lock){.+.+}-{2:2}

... which became HARDIRQ-irq-unsafe at:
...
  lock_acquire+0x1f3/0xaf0 kernel/locking/lockdep.c:5398
  __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
  _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
  send_sigurg+0x1e/0xa60 fs/fcntl.c:824
  sk_send_sigurg+0x76/0x300 net/core/sock.c:2930
  tcp_check_urg.isra.0+0x1f4/0x710 net/ipv4/tcp_input.c:5485
  tcp_urg net/ipv4/tcp_input.c:5526 [inline]
  tcp_rcv_established+0x10b9/0x1eb0 net/ipv4/tcp_input.c:5858
  tcp_v4_do_rcv+0x5d1/0x870 net/ipv4/tcp_ipv4.c:1643
  sk_backlog_rcv include/net/sock.h:1011 [inline]
  __release_sock+0x134/0x3a0 net/core/sock.c:2528
  release_sock+0x54/0x1b0 net/core/sock.c:3051
  tcp_sendmsg+0x36/0x40 net/ipv4/tcp.c:1444
  inet_sendmsg+0x99/0xe0 net/ipv4/af_inet.c:817
  sock_sendmsg_nosec net/socket.c:651 [inline]
  sock_sendmsg+0xcf/0x120 net/socket.c:671
  __sys_sendto+0x21c/0x320 net/socket.c:1992
  __do_sys_sendto net/socket.c:2004 [inline]
  __se_sys_sendto net/socket.c:2000 [inline]
  __x64_sys_sendto+0xdd/0x1b0 net/socket.c:2000
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

8 locks held by syz-executor198/6886:
 #0: ffff88809d2b5160 (&evdev->mutex){+.+.}-{3:3}, at: evdev_write+0x1cd/0x750 drivers/input/evdev.c:513
 #1: ffff88809eddc230 (&dev->event_lock){-...}-{2:2}, at: input_inject_event+0xa6/0x310 drivers/input/input.c:466
 #2: ffffffff89c68540 (rcu_read_lock){....}-{1:2}, at: is_event_supported drivers/input/input.c:53 [inline]
 #2: ffffffff89c68540 (rcu_read_lock){....}-{1:2}, at: is_event_supported drivers/input/input.c:50 [inline]
 #2: ffffffff89c68540 (rcu_read_lock){....}-{1:2}, at: input_inject_event+0x92/0x310 drivers/input/input.c:465
 #3: ffffffff89c68540 (rcu_read_lock){....}-{1:2}, at: input_pass_values.part.0+0x0/0x700 drivers/input/input.c:833
 #4: ffffffff89c68540 (rcu_read_lock){....}-{1:2}, at: evdev_events+0x55/0x330 drivers/input/evdev.c:297
 #5: ffff8880a81d4028 (&client->buffer_lock){....}-{2:2}, at: spin_lock include/linux/spinlock.h:354 [inline]
 #5: ffff8880a81d4028 (&client->buffer_lock){....}-{2:2}, at: evdev_pass_values+0x195/0xa30 drivers/input/evdev.c:262
 #6: ffffffff89c68540 (rcu_read_lock){....}-{1:2}, at: kill_fasync+0x3d/0x460 fs/fcntl.c:1021
 #7: ffff888092b709f0 (&new->fa_lock){....}-{2:2}, at: kill_fasync_rcu fs/fcntl.c:1002 [inline]
 #7: ffff888092b709f0 (&new->fa_lock){....}-{2:2}, at: kill_fasync fs/fcntl.c:1023 [inline]
 #7: ffff888092b709f0 (&new->fa_lock){....}-{2:2}, at: kill_fasync+0x14b/0x460 fs/fcntl.c:1016

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
  -> (&dev->event_lock){-...}-{2:2} {
     IN-HARDIRQ-W at:
                        lock_acquire+0x1f3/0xaf0 kernel/locking/lockdep.c:5398
                        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                        _raw_spin_lock_irqsave+0x94/0xd0 kernel/locking/spinlock.c:159
                        input_event drivers/input/input.c:440 [inline]
                        input_event+0x7b/0xb0 drivers/input/input.c:433
                        input_report_key include/linux/input.h:417 [inline]
                        psmouse_report_standard_buttons+0x2c/0x80 drivers/input/mouse/psmouse-base.c:123
                        psmouse_report_standard_packet drivers/input/mouse/psmouse-base.c:141 [inline]
                        psmouse_process_byte+0x1e1/0x890 drivers/input/mouse/psmouse-base.c:232
                        psmouse_handle_byte+0x41/0x1b0 drivers/input/mouse/psmouse-base.c:274
                        psmouse_interrupt+0x2fa/0xe90 drivers/input/mouse/psmouse-base.c:426
                        serio_interrupt+0x88/0x150 drivers/input/serio/serio.c:1002
                        i8042_interrupt+0x270/0x500 drivers/input/serio/i8042.c:598
                        __handle_irq_event_percpu+0x223/0xaa0 kernel/irq/handle.c:156
                        handle_irq_event_percpu kernel/irq/handle.c:196 [inline]
                        handle_irq_event+0x102/0x290 kernel/irq/handle.c:213
                        handle_edge_irq+0x25f/0xd00 kernel/irq/chip.c:819
                        asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:706
                        __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
                        run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
                        handle_irq arch/x86/kernel/irq.c:230 [inline]
                        __common_interrupt arch/x86/kernel/irq.c:249 [inline]
                        common_interrupt+0x115/0x1f0 arch/x86/kernel/irq.c:239
                        asm_common_interrupt+0x1e/0x40 arch/x86/include/asm/idtentry.h:572
                        arch_local_irq_restore arch/x86/include/asm/paravirt.h:653 [inline]
                        lock_acquire+0x27b/0xaf0 kernel/locking/lockdep.c:5401
                        rcu_lock_acquire include/linux/rcupdate.h:248 [inline]
                        rcu_read_lock include/linux/rcupdate.h:641 [inline]
                        path_init+0x851/0x13c0 fs/namei.c:2213
                        path_openat+0x185/0x2730 fs/namei.c:3364
                        do_filp_open+0x17e/0x3c0 fs/namei.c:3396
                        do_open_execat+0x116/0x690 fs/exec.c:910
                        bprm_execve+0x508/0x1b10 fs/exec.c:1909
                        kernel_execve+0x370/0x460 fs/exec.c:2080
                        call_usermodehelper_exec_async+0x27a/0x500 kernel/umh.c:101
                        ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
     INITIAL USE at:
                       lock_acquire+0x1f3/0xaf0 kernel/locking/lockdep.c:5398
                       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                       _raw_spin_lock_irqsave+0x94/0xd0 kernel/locking/spinlock.c:159
                       input_inject_event+0xa6/0x310 drivers/input/input.c:466
                       __led_set_brightness drivers/leds/led-core.c:48 [inline]
                       led_set_brightness_nopm drivers/leds/led-core.c:275 [inline]
                       led_set_brightness_nosleep+0xe6/0x1a0 drivers/leds/led-core.c:292
                       led_set_brightness+0x134/0x170 drivers/leds/led-core.c:267
                       led_trigger_event drivers/leds/led-triggers.c:387 [inline]
                       led_trigger_event+0x70/0xd0 drivers/leds/led-triggers.c:377
                       kbd_led_trigger_activate+0xfa/0x130 drivers/tty/vt/keyboard.c:1005
                       led_trigger_set+0x61e/0xbd0 drivers/leds/led-triggers.c:195
                       led_trigger_set_default drivers/leds/led-triggers.c:259 [inline]
                       led_trigger_set_default+0x1a6/0x230 drivers/leds/led-triggers.c:246
                       led_classdev_register_ext+0x511/0x6a0 drivers/leds/led-class.c:412
                       led_classdev_register include/linux/leds.h:190 [inline]
                       input_leds_connect+0x3e8/0x6c0 drivers/input/input-leds.c:139
                       input_attach_handler+0x180/0x1f0 drivers/input/input.c:1031
                       input_register_device.cold+0xf0/0x243 drivers/input/input.c:2229
                       atkbd_connect+0x736/0x9d0 drivers/input/keyboard/atkbd.c:1293
                       serio_connect_driver drivers/input/serio/serio.c:47 [inline]
                       serio_driver_probe+0x72/0xa0 drivers/input/serio/serio.c:778
                       really_probe+0x282/0x9f0 drivers/base/dd.c:553
                       driver_probe_device+0xfe/0x1d0 drivers/base/dd.c:738
                       device_driver_attach+0x228/0x290 drivers/base/dd.c:1013
                       __driver_attach drivers/base/dd.c:1090 [inline]
                       __driver_attach+0xda/0x240 drivers/base/dd.c:1044
                       bus_for_each_dev+0x147/0x1d0 drivers/base/bus.c:305
                       serio_attach_driver drivers/input/serio/serio.c:808 [inline]
                       serio_handle_event+0x5f6/0xa30 drivers/input/serio/serio.c:227
                       process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
                       worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
                       kthread+0x3af/0x4a0 kernel/kthread.c:292
                       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
   }
   ... key      at: [<ffffffff8d5c1a20>] __key.5+0x0/0x40
   ... acquired at:
   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
   _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
   spin_lock include/linux/spinlock.h:354 [inline]
   evdev_pass_values+0x195/0xa30 drivers/input/evdev.c:262
   evdev_events+0x20c/0x330 drivers/input/evdev.c:307
   input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
   input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
   input_pass_values drivers/input/input.c:134 [inline]
   input_handle_event+0x324/0x1390 drivers/input/input.c:399
   input_inject_event+0x2f5/0x310 drivers/input/input.c:471
   evdev_write+0x424/0x750 drivers/input/evdev.c:530
   vfs_write+0x28e/0x700 fs/read_write.c:593
   ksys_write+0x1ee/0x250 fs/read_write.c:648
   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

 -> (&client->buffer_lock){....}-{2:2} {
    INITIAL USE at:
                     lock_acquire+0x1f3/0xaf0 kernel/locking/lockdep.c:5398
                     __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                     _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
                     spin_lock include/linux/spinlock.h:354 [inline]
                     evdev_pass_values+0x195/0xa30 drivers/input/evdev.c:262
                     evdev_events+0x20c/0x330 drivers/input/evdev.c:307
                     input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
                     input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
                     input_pass_values drivers/input/input.c:134 [inline]
                     input_handle_event+0x324/0x1390 drivers/input/input.c:399
                     input_inject_event+0x2f5/0x310 drivers/input/input.c:471
                     evdev_write+0x424/0x750 drivers/input/evdev.c:530
                     vfs_write+0x28e/0x700 fs/read_write.c:593
                     ksys_write+0x1ee/0x250 fs/read_write.c:648
                     do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                     entry_SYSCALL_64_after_hwframe+0x44/0xa9
  }
  ... key      at: [<ffffffff8d5c1f20>] __key.4+0x0/0x40
  ... acquired at:
   __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
   _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
   kill_fasync_rcu fs/fcntl.c:1002 [inline]
   kill_fasync fs/fcntl.c:1023 [inline]
   kill_fasync+0x14b/0x460 fs/fcntl.c:1016
   __pass_event drivers/input/evdev.c:240 [inline]
   evdev_pass_values+0x715/0xa30 drivers/input/evdev.c:279
   evdev_events+0x20c/0x330 drivers/input/evdev.c:307
   input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
   input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
   input_pass_values drivers/input/input.c:134 [inline]
   input_handle_event+0x324/0x1390 drivers/input/input.c:399
   input_inject_event+0x2f5/0x310 drivers/input/input.c:471
   evdev_write+0x424/0x750 drivers/input/evdev.c:530
   vfs_write+0x28e/0x700 fs/read_write.c:593
   ksys_write+0x1ee/0x250 fs/read_write.c:648
   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> (&new->fa_lock){....}-{2:2} {
   (null) at:
general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 1 PID: 6886 Comm: syz-executor198 Not tainted 5.9.0-rc4-next-20200908-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:print_lock_trace kernel/locking/lockdep.c:1751 [inline]
RIP: 0010:print_lock_class_header kernel/locking/lockdep.c:2240 [inline]
RIP: 0010:print_shortest_lock_dependencies.cold+0x110/0x2af kernel/locking/lockdep.c:2263
Code: 48 8b 04 24 48 c1 e8 03 42 80 3c 20 00 74 09 48 8b 3c 24 e8 dd fb de f9 48 8b 04 24 48 8b 00 48 8d 78 14 48 89 fa 48 c1 ea 03 <42> 0f b6 0c 22 48 89 fa 83 e2 07 83 c2 03 38 ca 7c 08 84 c9 0f 85
RSP: 0018:ffffc900055e75c0 EFLAGS: 00010003
RAX: 0000000000000001 RBX: ffffc900055e7718 RCX: 0000000000000000
RDX: 0000000000000002 RSI: ffffffff815bc817 RDI: 0000000000000015
RBP: ffffc900055e7718 R08: 0000000000000004 R09: ffff8880ae720f8b
R10: 0000000000000000 R11: 6c6c756e28202020 R12: dffffc0000000000
R13: ffffffff8c6ff160 R14: 0000000000000009 R15: 0000000000000000
FS:  0000000000fee880(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020e68000 CR3: 0000000092552000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 print_bad_irq_dependency kernel/locking/lockdep.c:2395 [inline]
 check_irq_usage.cold+0x42d/0x5b0 kernel/locking/lockdep.c:2634
 check_prev_add kernel/locking/lockdep.c:2823 [inline]
 check_prevs_add kernel/locking/lockdep.c:2944 [inline]
 validate_chain kernel/locking/lockdep.c:3562 [inline]
 __lock_acquire+0x2800/0x55d0 kernel/locking/lockdep.c:4796
 lock_acquire+0x1f3/0xaf0 kernel/locking/lockdep.c:5398
 __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
 _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
 send_sigio+0x24/0x320 fs/fcntl.c:786
 kill_fasync_rcu fs/fcntl.c:1009 [inline]
 kill_fasync fs/fcntl.c:1023 [inline]
 kill_fasync+0x205/0x460 fs/fcntl.c:1016
 __pass_event drivers/input/evdev.c:240 [inline]
 evdev_pass_values+0x715/0xa30 drivers/input/evdev.c:279
 evdev_events+0x20c/0x330 drivers/input/evdev.c:307
 input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
 input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
 input_pass_values drivers/input/input.c:134 [inline]
 input_handle_event+0x324/0x1390 drivers/input/input.c:399
 input_inject_event+0x2f5/0x310 drivers/input/input.c:471
 evdev_write+0x424/0x750 drivers/input/evdev.c:530
 vfs_write+0x28e/0x700 fs/read_write.c:593
 ksys_write+0x1ee/0x250 fs/read_write.c:648
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x447769
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 0b d2 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe05f41328 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000447769
RDX: 0000000000000373 RSI: 0000000020000040 RDI: 0000000000000004
RBP: 00007ffe05f41340 R08: 00000000bb1414ac R09: 00000000bb1414ac
R10: 00000000bb1414ac R11: 0000000000000246 R12: 00007ffe05f41370
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 0cc9cc1229a01108 ]---
RIP: 0010:print_lock_trace kernel/locking/lockdep.c:1751 [inline]
RIP: 0010:print_lock_class_header kernel/locking/lockdep.c:2240 [inline]
RIP: 0010:print_shortest_lock_dependencies.cold+0x110/0x2af kernel/locking/lockdep.c:2263
Code: 48 8b 04 24 48 c1 e8 03 42 80 3c 20 00 74 09 48 8b 3c 24 e8 dd fb de f9 48 8b 04 24 48 8b 00 48 8d 78 14 48 89 fa 48 c1 ea 03 <42> 0f b6 0c 22 48 89 fa 83 e2 07 83 c2 03 38 ca 7c 08 84 c9 0f 85
RSP: 0018:ffffc900055e75c0 EFLAGS: 00010003
RAX: 0000000000000001 RBX: ffffc900055e7718 RCX: 0000000000000000
RDX: 0000000000000002 RSI: ffffffff815bc817 RDI: 0000000000000015
RBP: ffffc900055e7718 R08: 0000000000000004 R09: ffff8880ae720f8b
R10: 0000000000000000 R11: 6c6c756e28202020 R12: dffffc0000000000
R13: ffffffff8c6ff160 R14: 0000000000000009 R15: 0000000000000000
FS:  0000000000fee880(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020e68000 CR3: 0000000092552000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
