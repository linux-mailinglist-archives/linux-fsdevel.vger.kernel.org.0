Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E7B44C59E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 18:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhKJREL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 12:04:11 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:51776 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbhKJREK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 12:04:10 -0500
Received: by mail-il1-f200.google.com with SMTP id a14-20020a927f0e000000b002597075cb35so2235314ild.18
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Nov 2021 09:01:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=apNxvVnifkvAsHSjBm7UL7XJRKiT+vYJvXp/FLOJZtk=;
        b=KbZ0CgDwFQCx1eWR9vkAcm1THoqB3ZAQ6aFjEdQ6vlM/Fau/Ksmb+HMbwnytYptBsX
         0zPnmCbun9nbqihi00SJLBRtfsYDCyp9T3Gy+YTjplWtJdJEZt7elJceKK8lg2MfsuOi
         H+0RHgnN3nRmtG9XO3rDHlDM052R/Rb/6Th9I1G7z0El3L+Ks8blSuL2t96lqO5u22OD
         PSKccHtyscRvhnIR1Q+owzW7+RmIMidQFqop+ClKf5CmJPSz+SWyKFCzoutv8kv7mre4
         f3DpyLdcTq8vs1bwxb8s/U+5C8QS5Fmfv1yIHgM75w1yZ6ktLPxhSMAR6obLVUHlYP6a
         VnbA==
X-Gm-Message-State: AOAM533ZBgrY3NnHw87zSPo24uYvJScNUUSLQ8+7CUKPNh/RXbFDdCee
        2juocJwejCDrx8R0GM1QYGQOf0mC5fs2U3Hb1O+iIlICgkkD
X-Google-Smtp-Source: ABdhPJxuycFhHbkZu7pV4tsPGMPxTOXX3Fp/fntd5FgyBUYBjov+lbwQEMdFJRnFhmUAiedLoFhFBiCoZ+miq4sZSayCSdVEhsmY
MIME-Version: 1.0
X-Received: by 2002:a6b:fa1a:: with SMTP id p26mr426669ioh.68.1636563682610;
 Wed, 10 Nov 2021 09:01:22 -0800 (PST)
Date:   Wed, 10 Nov 2021 09:01:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f454c105d0722c63@google.com>
Subject: [syzbot] possible deadlock in input_event (2)
From:   syzbot <syzbot+d4c06e848a1c1f9f726f@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    cb690f5238d7 Merge tag 'for-5.16/drivers-2021-11-09' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=165fd58ab00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7259f0deb293aa
dashboard link: https://syzkaller.appspot.com/bug?extid=d4c06e848a1c1f9f726f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d4c06e848a1c1f9f726f@syzkaller.appspotmail.com

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
5.15.0-syzkaller #0 Not tainted
-----------------------------------------------------
syz-executor.4/9861 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffff88804ad623b8 (&f->f_owner.lock){...-}-{2:2}, at: send_sigio+0x24/0x380 fs/fcntl.c:796

and this task is already holding:
ffff88804c887018 (&new->fa_lock){....}-{2:2}, at: kill_fasync_rcu fs/fcntl.c:1014 [inline]
ffff88804c887018 (&new->fa_lock){....}-{2:2}, at: kill_fasync fs/fcntl.c:1035 [inline]
ffff88804c887018 (&new->fa_lock){....}-{2:2}, at: kill_fasync+0x136/0x470 fs/fcntl.c:1028
which would create a new lock dependency:
 (&new->fa_lock){....}-{2:2} -> (&f->f_owner.lock){...-}-{2:2}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&dev->event_lock){-...}-{2:2}

... which became HARDIRQ-irq-safe at:
  lock_acquire kernel/locking/lockdep.c:5637 [inline]
  lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
  input_event drivers/input/input.c:445 [inline]
  input_event+0x7b/0xb0 drivers/input/input.c:438
  input_report_key include/linux/input.h:425 [inline]
  psmouse_report_standard_buttons+0x2c/0x80 drivers/input/mouse/psmouse-base.c:123
  psmouse_report_standard_packet drivers/input/mouse/psmouse-base.c:141 [inline]
  psmouse_process_byte+0x1e1/0x890 drivers/input/mouse/psmouse-base.c:232
  psmouse_handle_byte+0x41/0x1b0 drivers/input/mouse/psmouse-base.c:274
  psmouse_interrupt+0x304/0xf00 drivers/input/mouse/psmouse-base.c:426
  serio_interrupt+0x88/0x150 drivers/input/serio/serio.c:1001
  i8042_interrupt+0x27a/0x520 drivers/input/serio/i8042.c:602
  __handle_irq_event_percpu+0x303/0x8f0 kernel/irq/handle.c:158
  handle_irq_event_percpu kernel/irq/handle.c:198 [inline]
  handle_irq_event+0x102/0x280 kernel/irq/handle.c:215
  handle_edge_irq+0x25f/0xd00 kernel/irq/chip.c:822
  generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
  handle_irq arch/x86/kernel/irq.c:231 [inline]
  __common_interrupt+0x9d/0x210 arch/x86/kernel/irq.c:250
  common_interrupt+0xa4/0xc0 arch/x86/kernel/irq.c:240
  asm_common_interrupt+0x1e/0x40 arch/x86/include/asm/idtentry.h:629
  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
  _raw_spin_unlock_irqrestore+0x38/0x70 kernel/locking/spinlock.c:194
  spin_unlock_irqrestore include/linux/spinlock.h:404 [inline]
  klist_next+0x288/0x510 lib/klist.c:401
  next_device drivers/base/bus.c:258 [inline]
  bus_for_each_dev+0x10d/0x1d0 drivers/base/bus.c:300
  bus_add_driver+0x41d/0x630 drivers/base/bus.c:618
  driver_register+0x220/0x3a0 drivers/base/driver.c:171
  usb_register_driver+0x249/0x460 drivers/usb/core/driver.c:1061
  do_one_initcall+0x103/0x650 init/main.c:1297
  do_initcall_level init/main.c:1370 [inline]
  do_initcalls init/main.c:1386 [inline]
  do_basic_setup init/main.c:1405 [inline]
  kernel_init_freeable+0x6b1/0x73a init/main.c:1610
  kernel_init+0x1a/0x1d0 init/main.c:1499
  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

to a HARDIRQ-irq-unsafe lock:
 (tasklist_lock){.+.?}-{2:2}

... which became HARDIRQ-irq-unsafe at:
...
  lock_acquire kernel/locking/lockdep.c:5637 [inline]
  lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
  __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
  _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
  do_wait+0x284/0xce0 kernel/exit.c:1511
  kernel_wait+0x9c/0x150 kernel/exit.c:1701
  call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
  call_usermodehelper_exec_work+0xf5/0x180 kernel/umh.c:166
  process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
  worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
  kthread+0x405/0x4f0 kernel/kthread.c:327
  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

other info that might help us debug this:

Chain exists of:
  &dev->event_lock --> &new->fa_lock --> tasklist_lock

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(tasklist_lock);
                               local_irq_disable();
                               lock(&dev->event_lock);
                               lock(&new->fa_lock);
  <Interrupt>
    lock(&dev->event_lock);

 *** DEADLOCK ***

8 locks held by syz-executor.4/9861:
 #0: ffff88801e33b110 (&evdev->mutex){+.+.}-{3:3}, at: evdev_write+0x1d3/0x760 drivers/input/evdev.c:513
 #1: ffff88801dfc0230 (&dev->event_lock){-...}-{2:2}, at: input_inject_event+0xa6/0x320 drivers/input/input.c:471
 #2: ffffffff8b983a20 (rcu_read_lock){....}-{1:2}, at: is_event_supported drivers/input/input.c:53 [inline]
 #2: ffffffff8b983a20 (rcu_read_lock){....}-{1:2}, at: is_event_supported drivers/input/input.c:50 [inline]
 #2: ffffffff8b983a20 (rcu_read_lock){....}-{1:2}, at: input_inject_event+0x92/0x320 drivers/input/input.c:470
 #3: ffffffff8b983a20 (rcu_read_lock){....}-{1:2}, at: input_dev_toggle drivers/input/input.c:1712 [inline]
 #3: ffffffff8b983a20 (rcu_read_lock){....}-{1:2}, at: input_pass_values.part.0+0x0/0x710 drivers/input/input.c:1832
 #4: ffffffff8b983a20 (rcu_read_lock){....}-{1:2}, at: evdev_events+0x59/0x3e0 drivers/input/evdev.c:296
 #5: ffff888044df9028 (&client->buffer_lock){....}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
 #5: ffff888044df9028 (&client->buffer_lock){....}-{2:2}, at: evdev_pass_values.part.0+0xf6/0x970 drivers/input/evdev.c:261
 #6: ffffffff8b983a20 (rcu_read_lock){....}-{1:2}, at: kill_fasync+0x41/0x470 fs/fcntl.c:1033
 #7: ffff88804c887018 (&new->fa_lock){....}-{2:2}, at: kill_fasync_rcu fs/fcntl.c:1014 [inline]
 #7: ffff88804c887018 (&new->fa_lock){....}-{2:2}, at: kill_fasync fs/fcntl.c:1035 [inline]
 #7: ffff88804c887018 (&new->fa_lock){....}-{2:2}, at: kill_fasync+0x136/0x470 fs/fcntl.c:1028

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
  -> (&dev->event_lock){-...}-{2:2} {
     IN-HARDIRQ-W at:
                        lock_acquire kernel/locking/lockdep.c:5637 [inline]
                        lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                        _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
                        input_event drivers/input/input.c:445 [inline]
                        input_event+0x7b/0xb0 drivers/input/input.c:438
                        input_report_key include/linux/input.h:425 [inline]
                        psmouse_report_standard_buttons+0x2c/0x80 drivers/input/mouse/psmouse-base.c:123
                        psmouse_report_standard_packet drivers/input/mouse/psmouse-base.c:141 [inline]
                        psmouse_process_byte+0x1e1/0x890 drivers/input/mouse/psmouse-base.c:232
                        psmouse_handle_byte+0x41/0x1b0 drivers/input/mouse/psmouse-base.c:274
                        psmouse_interrupt+0x304/0xf00 drivers/input/mouse/psmouse-base.c:426
                        serio_interrupt+0x88/0x150 drivers/input/serio/serio.c:1001
                        i8042_interrupt+0x27a/0x520 drivers/input/serio/i8042.c:602
                        __handle_irq_event_percpu+0x303/0x8f0 kernel/irq/handle.c:158
                        handle_irq_event_percpu kernel/irq/handle.c:198 [inline]
                        handle_irq_event+0x102/0x280 kernel/irq/handle.c:215
                        handle_edge_irq+0x25f/0xd00 kernel/irq/chip.c:822
                        generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
                        handle_irq arch/x86/kernel/irq.c:231 [inline]
                        __common_interrupt+0x9d/0x210 arch/x86/kernel/irq.c:250
                        common_interrupt+0xa4/0xc0 arch/x86/kernel/irq.c:240
                        asm_common_interrupt+0x1e/0x40 arch/x86/include/asm/idtentry.h:629
                        __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
                        _raw_spin_unlock_irqrestore+0x38/0x70 kernel/locking/spinlock.c:194
                        spin_unlock_irqrestore include/linux/spinlock.h:404 [inline]
                        klist_next+0x288/0x510 lib/klist.c:401
                        next_device drivers/base/bus.c:258 [inline]
                        bus_for_each_dev+0x10d/0x1d0 drivers/base/bus.c:300
                        bus_add_driver+0x41d/0x630 drivers/base/bus.c:618
                        driver_register+0x220/0x3a0 drivers/base/driver.c:171
                        usb_register_driver+0x249/0x460 drivers/usb/core/driver.c:1061
                        do_one_initcall+0x103/0x650 init/main.c:1297
                        do_initcall_level init/main.c:1370 [inline]
                        do_initcalls init/main.c:1386 [inline]
                        do_basic_setup init/main.c:1405 [inline]
                        kernel_init_freeable+0x6b1/0x73a init/main.c:1610
                        kernel_init+0x1a/0x1d0 init/main.c:1499
                        ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
     INITIAL USE at:
                       lock_acquire kernel/locking/lockdep.c:5637 [inline]
                       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                       _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
                       input_inject_event+0xa6/0x320 drivers/input/input.c:471
                       __led_set_brightness drivers/leds/led-core.c:47 [inline]
                       led_set_brightness_nopm drivers/leds/led-core.c:271 [inline]
                       led_set_brightness_nosleep+0xe6/0x1a0 drivers/leds/led-core.c:287
                       led_set_brightness+0x134/0x170 drivers/leds/led-core.c:264
                       led_trigger_event drivers/leds/led-triggers.c:390 [inline]
                       led_trigger_event+0xb0/0x200 drivers/leds/led-triggers.c:380
                       kbd_led_trigger_activate+0xc9/0x100 drivers/tty/vt/keyboard.c:1029
                       led_trigger_set+0x5d7/0xaf0 drivers/leds/led-triggers.c:197
                       led_trigger_set_default drivers/leds/led-triggers.c:262 [inline]
                       led_trigger_set_default+0x1a6/0x230 drivers/leds/led-triggers.c:249
                       led_classdev_register_ext+0x622/0x850 drivers/leds/led-class.c:417
                       led_classdev_register include/linux/leds.h:196 [inline]
                       input_leds_connect+0x4bd/0x860 drivers/input/input-leds.c:139
                       input_attach_handler+0x180/0x1f0 drivers/input/input.c:1035
                       input_register_device.cold+0xf0/0x304 drivers/input/input.c:2335
                       atkbd_connect+0x749/0xa10 drivers/input/keyboard/atkbd.c:1293
                       serio_connect_driver drivers/input/serio/serio.c:47 [inline]
                       serio_driver_probe+0x72/0xa0 drivers/input/serio/serio.c:778
                       call_driver_probe drivers/base/dd.c:517 [inline]
                       really_probe+0x245/0xcc0 drivers/base/dd.c:596
                       __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:751
                       driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:781
                       __driver_attach+0x22d/0x4e0 drivers/base/dd.c:1140
                       bus_for_each_dev+0x147/0x1d0 drivers/base/bus.c:301
                       serio_attach_driver drivers/input/serio/serio.c:807 [inline]
                       serio_handle_event+0x5f6/0xa30 drivers/input/serio/serio.c:227
                       process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
                       worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
                       kthread+0x405/0x4f0 kernel/kthread.c:327
                       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
   }
   ... key      at: [<ffffffff905ad960>] __key.8+0x0/0x40
 -> (&client->buffer_lock){....}-{2:2} {
    INITIAL USE at:
                     lock_acquire kernel/locking/lockdep.c:5637 [inline]
                     lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                     __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                     _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
                     spin_lock include/linux/spinlock.h:349 [inline]
                     evdev_pass_values.part.0+0xf6/0x970 drivers/input/evdev.c:261
                     evdev_pass_values drivers/input/evdev.c:253 [inline]
                     evdev_events+0x359/0x3e0 drivers/input/evdev.c:306
                     input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
                     input_pass_values.part.0+0x230/0x710 drivers/input/input.c:145
                     input_pass_values drivers/input/input.c:134 [inline]
                     input_handle_event+0x373/0x1440 drivers/input/input.c:404
                     input_inject_event+0x1bd/0x320 drivers/input/input.c:476
                     evdev_write+0x430/0x760 drivers/input/evdev.c:530
                     vfs_write+0x28e/0xae0 fs/read_write.c:588
                     ksys_write+0x1ee/0x250 fs/read_write.c:643
                     do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
                     __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
                     do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
                     entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
  }
  ... key      at: [<ffffffff905adde0>] __key.4+0x0/0x40
  ... acquired at:
   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
   _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
   spin_lock include/linux/spinlock.h:349 [inline]
   evdev_pass_values.part.0+0xf6/0x970 drivers/input/evdev.c:261
   evdev_pass_values drivers/input/evdev.c:253 [inline]
   evdev_events+0x359/0x3e0 drivers/input/evdev.c:306
   input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
   input_pass_values.part.0+0x230/0x710 drivers/input/input.c:145
   input_pass_values drivers/input/input.c:134 [inline]
   input_handle_event+0x373/0x1440 drivers/input/input.c:404
   input_inject_event+0x1bd/0x320 drivers/input/input.c:476
   evdev_write+0x430/0x760 drivers/input/evdev.c:530
   vfs_write+0x28e/0xae0 fs/read_write.c:588
   ksys_write+0x1ee/0x250 fs/read_write.c:643
   do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
   __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
   do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
   entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

-> (&new->fa_lock){....}-{2:2} {
   INITIAL READ USE at:
                        lock_acquire kernel/locking/lockdep.c:5637 [inline]
                        lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                        __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
                        _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236
                        kill_fasync_rcu fs/fcntl.c:1014 [inline]
                        kill_fasync fs/fcntl.c:1035 [inline]
                        kill_fasync+0x136/0x470 fs/fcntl.c:1028
                        __pass_event drivers/input/evdev.c:240 [inline]
                        evdev_pass_values.part.0+0x64e/0x970 drivers/input/evdev.c:278
                        evdev_pass_values drivers/input/evdev.c:253 [inline]
                        evdev_events+0x359/0x3e0 drivers/input/evdev.c:306
                        input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
                        input_pass_values.part.0+0x230/0x710 drivers/input/input.c:145
                        input_pass_values drivers/input/input.c:134 [inline]
                        input_handle_event+0x373/0x1440 drivers/input/input.c:404
                        input_inject_event+0x1bd/0x320 drivers/input/input.c:476
                        evdev_write+0x430/0x760 drivers/input/evdev.c:530
                        vfs_write+0x28e/0xae0 fs/read_write.c:588
                        ksys_write+0x1ee/0x250 fs/read_write.c:643
                        do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
                        __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
                        do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
                        entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
 }
 ... key      at: [<ffffffff90308bc0>] __key.0+0x0/0x40
 ... acquired at:
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
   _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236
   kill_fasync_rcu fs/fcntl.c:1014 [inline]
   kill_fasync fs/fcntl.c:1035 [inline]
   kill_fasync+0x136/0x470 fs/fcntl.c:1028
   __pass_event drivers/input/evdev.c:240 [inline]
   evdev_pass_values.part.0+0x64e/0x970 drivers/input/evdev.c:278
   evdev_pass_values drivers/input/evdev.c:253 [inline]
   evdev_events+0x359/0x3e0 drivers/input/evdev.c:306
   input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
   input_pass_values.part.0+0x230/0x710 drivers/input/input.c:145
   input_pass_values drivers/input/input.c:134 [inline]
   input_handle_event+0x373/0x1440 drivers/input/input.c:404
   input_inject_event+0x1bd/0x320 drivers/input/input.c:476
   evdev_write+0x430/0x760 drivers/input/evdev.c:530
   vfs_write+0x28e/0xae0 fs/read_write.c:588
   ksys_write+0x1ee/0x250 fs/read_write.c:643
   do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
   __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
   do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
   entry_SYSENTER_compat_after_hwframe+0x4d/0x5c


the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
 -> (tasklist_lock){.+.?}-{2:2} {
    HARDIRQ-ON-R at:
                      lock_acquire kernel/locking/lockdep.c:5637 [inline]
                      lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                      __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                      _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
                      do_wait+0x284/0xce0 kernel/exit.c:1511
                      kernel_wait+0x9c/0x150 kernel/exit.c:1701
                      call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
                      call_usermodehelper_exec_work+0xf5/0x180 kernel/umh.c:166
                      process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
                      worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
                      kthread+0x405/0x4f0 kernel/kthread.c:327
                      ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
    IN-SOFTIRQ-R at:
                      lock_acquire kernel/locking/lockdep.c:5637 [inline]
                      lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                      __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                      _raw_read_lock+0x36/0x70 kernel/locking/spinlock.c:228
                      send_sigurg+0xad/0xaf0 fs/fcntl.c:851
                      sk_send_sigurg+0x76/0x310 net/core/sock.c:3172
                      tcp_check_urg.isra.0+0x1f3/0x710 net/ipv4/tcp_input.c:5567
                      tcp_urg net/ipv4/tcp_input.c:5608 [inline]
                      tcp_rcv_established+0x12ab/0x2130 net/ipv4/tcp_input.c:5942
                      tcp_v4_do_rcv+0x600/0x8d0 net/ipv4/tcp_ipv4.c:1716
                      tcp_v4_rcv+0x2768/0x3080 net/ipv4/tcp_ipv4.c:2110
                      ip_protocol_deliver_rcu+0xa7/0xee0 net/ipv4/ip_input.c:204
                      ip_local_deliver_finish+0x20a/0x370 net/ipv4/ip_input.c:231
                      NF_HOOK include/linux/netfilter.h:307 [inline]
                      NF_HOOK include/linux/netfilter.h:301 [inline]
                      ip_local_deliver+0x1b3/0x200 net/ipv4/ip_input.c:252
                      dst_input include/net/dst.h:460 [inline]
                      ip_rcv_finish+0x1da/0x2f0 net/ipv4/ip_input.c:429
                      NF_HOOK include/linux/netfilter.h:307 [inline]
                      NF_HOOK include/linux/netfilter.h:301 [inline]
                      ip_rcv+0xaa/0xd0 net/ipv4/ip_input.c:540
                      __netif_receive_skb_one_core+0x114/0x180 net/core/dev.c:5462
                      __netif_receive_skb+0x24/0x1b0 net/core/dev.c:5576
                      process_backlog+0x2a5/0x6c0 net/core/dev.c:6452
                      __napi_poll+0xaf/0x440 net/core/dev.c:7017
                      napi_poll net/core/dev.c:7084 [inline]
                      net_rx_action+0x801/0xb40 net/core/dev.c:7171
                      __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
                      invoke_softirq kernel/softirq.c:432 [inline]
                      __irq_exit_rcu+0x123/0x180 kernel/softirq.c:636
                      irq_exit_rcu+0x5/0x20 kernel/softirq.c:648
                      sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
                      asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
                      freezer_do_not_count include/linux/freezer.h:109 [inline]
                      freezable_schedule include/linux/freezer.h:171 [inline]
                      do_nanosleep+0x223/0x690 kernel/time/hrtimer.c:2044
                      hrtimer_nanosleep+0x1f9/0x4a0 kernel/time/hrtimer.c:2097
                      common_nsleep+0xa2/0xc0 kernel/time/posix-timers.c:1227
                      __do_sys_clock_nanosleep kernel/time/posix-timers.c:1267 [inline]
                      __se_sys_clock_nanosleep kernel/time/posix-timers.c:1245 [inline]
                      __ia32_sys_clock_nanosleep+0x2f4/0x430 kernel/time/posix-timers.c:1245
                      do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
                      __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
                      do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
                      entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
    SOFTIRQ-ON-R at:
                      lock_acquire kernel/locking/lockdep.c:5637 [inline]
                      lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                      __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                      _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
                      do_wait+0x284/0xce0 kernel/exit.c:1511
                      kernel_wait+0x9c/0x150 kernel/exit.c:1701
                      call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
                      call_usermodehelper_exec_work+0xf5/0x180 kernel/umh.c:166
                      process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
                      worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
                      kthread+0x405/0x4f0 kernel/kthread.c:327
                      ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
    INITIAL USE at:
                     lock_acquire kernel/locking/lockdep.c:5637 [inline]
                     lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                     __raw_write_lock_irq include/linux/rwlock_api_smp.h:194 [inline]
                     _raw_write_lock_irq+0x32/0x50 kernel/locking/spinlock.c:316
                     copy_process+0x36c0/0x75a0 kernel/fork.c:2310
                     kernel_clone+0xe7/0xab0 kernel/fork.c:2581
                     kernel_thread+0xb5/0xf0 kernel/fork.c:2633
                     rest_init+0x23/0x3e0 init/main.c:690
                     start_kernel+0x47a/0x49b init/main.c:1135
                     secondary_startup_64_no_verify+0xb0/0xbb
    INITIAL READ USE at:
                          lock_acquire kernel/locking/lockdep.c:5637 [inline]
                          lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                          __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                          _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
                          do_wait+0x284/0xce0 kernel/exit.c:1511
                          kernel_wait+0x9c/0x150 kernel/exit.c:1701
                          call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
                          call_usermodehelper_exec_work+0xf5/0x180 kernel/umh.c:166
                          process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
                          worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
                          kthread+0x405/0x4f0 kernel/kthread.c:327
                          ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
  }
  ... key      at: [<ffffffff8b60a098>] tasklist_lock+0x18/0x40
  ... acquired at:
   __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
   _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
   send_sigurg+0xad/0xaf0 fs/fcntl.c:851
   sk_send_sigurg+0x76/0x310 net/core/sock.c:3172
   tcp_check_urg.isra.0+0x1f3/0x710 net/ipv4/tcp_input.c:5567
   tcp_urg net/ipv4/tcp_input.c:5608 [inline]
   tcp_rcv_established+0x12ab/0x2130 net/ipv4/tcp_input.c:5942
   tcp_v4_do_rcv+0x600/0x8d0 net/ipv4/tcp_ipv4.c:1716
   sk_backlog_rcv include/net/sock.h:1030 [inline]
   __release_sock+0x134/0x3b0 net/core/sock.c:2768
   release_sock+0x54/0x1b0 net/core/sock.c:3300
   sk_stream_wait_memory+0x604/0xed0 net/core/stream.c:145
   tcp_sendmsg_locked+0x7c1/0x2c60 net/ipv4/tcp.c:1384
   tcp_sendmsg+0x2b/0x40 net/ipv4/tcp.c:1422
   inet_sendmsg+0x99/0xe0 net/ipv4/af_inet.c:819
   sock_sendmsg_nosec net/socket.c:704 [inline]
   sock_sendmsg+0xcf/0x120 net/socket.c:724
   __sys_sendto+0x21c/0x320 net/socket.c:2036
   __do_sys_sendto net/socket.c:2048 [inline]
   __se_sys_sendto net/socket.c:2044 [inline]
   __ia32_sys_sendto+0xdb/0x1b0 net/socket.c:2044
   do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
   __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
   do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
   entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

-> (&f->f_owner.lock){...-}-{2:2} {
   IN-SOFTIRQ-R at:
                    lock_acquire kernel/locking/lockdep.c:5637 [inline]
                    lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                    __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
                    _raw_read_lock_irqsave+0x45/0x90 kernel/locking/spinlock.c:236
                    send_sigurg+0x1e/0xaf0 fs/fcntl.c:835
                    sk_send_sigurg+0x76/0x310 net/core/sock.c:3172
                    tcp_check_urg.isra.0+0x1f3/0x710 net/ipv4/tcp_input.c:5567
                    tcp_urg net/ipv4/tcp_input.c:5608 [inline]
                    tcp_rcv_established+0x12ab/0x2130 net/ipv4/tcp_input.c:5942
                    tcp_v6_do_rcv+0x461/0x1320 net/ipv6/tcp_ipv6.c:1522
                    tcp_v6_rcv+0x236d/0x2cb0 net/ipv6/tcp_ipv6.c:1765
                    ip6_protocol_deliver_rcu+0x2e9/0x1ca0 net/ipv6/ip6_input.c:422
                    ip6_input_finish+0x62/0x170 net/ipv6/ip6_input.c:463
                    NF_HOOK include/linux/netfilter.h:307 [inline]
                    NF_HOOK include/linux/netfilter.h:301 [inline]
                    ip6_input+0x9c/0xd0 net/ipv6/ip6_input.c:472
                    dst_input include/net/dst.h:460 [inline]
                    ip6_rcv_finish net/ipv6/ip6_input.c:76 [inline]
                    NF_HOOK include/linux/netfilter.h:307 [inline]
                    NF_HOOK include/linux/netfilter.h:301 [inline]
                    ipv6_rcv+0x28c/0x3c0 net/ipv6/ip6_input.c:297
                    __netif_receive_skb_one_core+0x114/0x180 net/core/dev.c:5462
                    __netif_receive_skb+0x24/0x1b0 net/core/dev.c:5576
                    process_backlog+0x2a5/0x6c0 net/core/dev.c:6452
                    __napi_poll+0xaf/0x440 net/core/dev.c:7017
                    napi_poll net/core/dev.c:7084 [inline]
                    net_rx_action+0x801/0xb40 net/core/dev.c:7171
                    __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
                    run_ksoftirqd kernel/softirq.c:920 [inline]
                    run_ksoftirqd+0x2d/0x60 kernel/softirq.c:912
                    smpboot_thread_fn+0x645/0x9c0 kernel/smpboot.c:164
                    kthread+0x405/0x4f0 kernel/kthread.c:327
                    ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5637 [inline]
                   lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:194 [inline]
                   _raw_write_lock_irq+0x32/0x50 kernel/locking/spinlock.c:316
                   f_modown+0x2a/0x390 fs/fcntl.c:91
                   __f_setown fs/fcntl.c:110 [inline]
                   f_setown+0xd7/0x230 fs/fcntl.c:138
                   do_fcntl+0x749/0x1210 fs/fcntl.c:393
                   do_compat_fcntl64+0x2ce/0x610 fs/fcntl.c:676
                   do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
                   __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
                   do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
                   entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
   INITIAL READ USE at:
                        lock_acquire kernel/locking/lockdep.c:5637 [inline]
                        lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                        __raw_read_lock_irq include/linux/rwlock_api_smp.h:168 [inline]
                        _raw_read_lock_irq+0x63/0x80 kernel/locking/spinlock.c:244
                        f_getown_ex fs/fcntl.c:212 [inline]
                        do_fcntl+0x8af/0x1210 fs/fcntl.c:396
                        do_compat_fcntl64+0x2ce/0x610 fs/fcntl.c:676
                        do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
                        __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
                        do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
                        entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
 }
 ... key      at: [<ffffffff90307de0>] __key.5+0x0/0x40
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5637 [inline]
   lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
   _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236
   send_sigio+0x24/0x380 fs/fcntl.c:796
   kill_fasync_rcu fs/fcntl.c:1021 [inline]
   kill_fasync fs/fcntl.c:1035 [inline]
   kill_fasync+0x1f8/0x470 fs/fcntl.c:1028
   __pass_event drivers/input/evdev.c:240 [inline]
   evdev_pass_values.part.0+0x64e/0x970 drivers/input/evdev.c:278
   evdev_pass_values drivers/input/evdev.c:253 [inline]
   evdev_events+0x359/0x3e0 drivers/input/evdev.c:306
   input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
   input_pass_values.part.0+0x230/0x710 drivers/input/input.c:145
   input_pass_values drivers/input/input.c:134 [inline]
   input_handle_event+0x373/0x1440 drivers/input/input.c:404
   input_inject_event+0x1bd/0x320 drivers/input/input.c:476
   evdev_write+0x430/0x760 drivers/input/evdev.c:530
   vfs_write+0x28e/0xae0 fs/read_write.c:588
   ksys_write+0x1ee/0x250 fs/read_write.c:643
   do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
   __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
   do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
   entry_SYSENTER_compat_after_hwframe+0x4d/0x5c


stack backtrace:
CPU: 0 PID: 9861 Comm: syz-executor.4 Not tainted 5.15.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_bad_irq_dependency kernel/locking/lockdep.c:2577 [inline]
 check_irq_usage.cold+0x4c1/0x6b0 kernel/locking/lockdep.c:2816
 check_prev_add kernel/locking/lockdep.c:3067 [inline]
 check_prevs_add kernel/locking/lockdep.c:3186 [inline]
 validate_chain kernel/locking/lockdep.c:3801 [inline]
 __lock_acquire+0x2a1f/0x54a0 kernel/locking/lockdep.c:5027
 lock_acquire kernel/locking/lockdep.c:5637 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
 __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
 _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236
 send_sigio+0x24/0x380 fs/fcntl.c:796
 kill_fasync_rcu fs/fcntl.c:1021 [inline]
 kill_fasync fs/fcntl.c:1035 [inline]
 kill_fasync+0x1f8/0x470 fs/fcntl.c:1028
 __pass_event drivers/input/evdev.c:240 [inline]
 evdev_pass_values.part.0+0x64e/0x970 drivers/input/evdev.c:278
 evdev_pass_values drivers/input/evdev.c:253 [inline]
 evdev_events+0x359/0x3e0 drivers/input/evdev.c:306
 input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
 input_pass_values.part.0+0x230/0x710 drivers/input/input.c:145
 input_pass_values drivers/input/input.c:134 [inline]
 input_handle_event+0x373/0x1440 drivers/input/input.c:404
 input_inject_event+0x1bd/0x320 drivers/input/input.c:476
 evdev_write+0x430/0x760 drivers/input/evdev.c:530
 vfs_write+0x28e/0xae0 fs/read_write.c:588
 ksys_write+0x1ee/0x250 fs/read_write.c:643
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf6e7b549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f44755fc EFLAGS: 00000296 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000020000040
RDX: 0000000000000373 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess):
   0:	03 74 c0 01          	add    0x1(%rax,%rax,8),%esi
   4:	10 05 03 74 b8 01    	adc    %al,0x1b87403(%rip)        # 0x1b8740d
   a:	10 06                	adc    %al,(%rsi)
   c:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
  10:	10 07                	adc    %al,(%rdi)
  12:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
  16:	10 08                	adc    %cl,(%rax)
  18:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1c:	00 00                	add    %al,(%rax)
  1e:	00 00                	add    %al,(%rax)
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
* 2a:	5d                   	pop    %rbp <-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	retq
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  39:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
