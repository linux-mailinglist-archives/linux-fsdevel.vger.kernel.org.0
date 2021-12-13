Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC414471F65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 03:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhLMCmT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Dec 2021 21:42:19 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:47842 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhLMCmS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Dec 2021 21:42:18 -0500
Received: by mail-io1-f72.google.com with SMTP id o11-20020a0566022e0b00b005e95edf792dso14364743iow.14
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Dec 2021 18:42:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=CyDS6V1aVH92L99qejpBc09S/9T4NOlPmeOPIEK0qpA=;
        b=031Ka1nzVzTEitDQbDDMzmYd8kRZTX1H0lRBTYml4zVku2CrEeY2rYYByreAc1LRcx
         D6raR8+yiOr+43GVfpz3ovpYku5da9/IOSbOqsFYWmT5m1T2HL6bYAxcO7kt6YEbW6Jn
         5/bxSyVedZHwG45f9w07iTh5Pa/QrIVSk8hRNL48e4yXsCWkmLupl92ZhXjnnqRg6JnX
         S1ybyUbKyv7XowaFBI243E5CZFFfENunTb5IsNNO0WxuR4zu7YpOVEzDLPvHVVX09KPb
         GrRGf/6VhTZJDPjxalaqMRWcbERAknzN/u1/Yxmsud5z/SjJ+SBLF+53ZBgxliOEEAaV
         EJrg==
X-Gm-Message-State: AOAM530wcbDK3s85F56MqKHoVKITMSQ8Q2zhx0TKQZFASh5991kgi4aG
        PaMfAPeuTsKp7IVjPICWDhT7sHhTYRQbzPWyoX8N+z0jON/U
X-Google-Smtp-Source: ABdhPJzqXMDkOfJnRrDXpHNDN486PHUYTh7zkN7GWmELCbXyma/DavHV2101WeZeDC4U70Qv0h5t41l/yim4MBWAaUUDqDGICb3P
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1549:: with SMTP id h9mr30655497iow.30.1639363338136;
 Sun, 12 Dec 2021 18:42:18 -0800 (PST)
Date:   Sun, 12 Dec 2021 18:42:18 -0800
In-Reply-To: <000000000000f454c105d0722c63@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006d6f4105d2fe05ed@google.com>
Subject: Re: [syzbot] possible deadlock in input_event (2)
From:   syzbot <syzbot+d4c06e848a1c1f9f726f@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    90d9fbc16b69 Merge tag 'usb-5.16-rc5' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15996741b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=221ffc09e39ebbd1
dashboard link: https://syzkaller.appspot.com/bug?extid=d4c06e848a1c1f9f726f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108f4d4db00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a0f551b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d4c06e848a1c1f9f726f@syzkaller.appspotmail.com

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
5.16.0-rc4-syzkaller #0 Not tainted
-----------------------------------------------------
syz-executor835/3750 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffffffff8b80a098 (tasklist_lock){.+.+}-{2:2}, at: send_sigio+0xab/0x380 fs/fcntl.c:810

and this task is already holding:
ffff88801c0172b8 (&f->f_owner.lock){....}-{2:2}, at: send_sigio+0x24/0x380 fs/fcntl.c:796
which would create a new lock dependency:
 (&f->f_owner.lock){....}-{2:2} -> (tasklist_lock){.+.+}-{2:2}

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
  i8042_command+0x12e/0x150 drivers/input/serio/i8042.c:352
  i8042_aux_write+0xd7/0x120 drivers/input/serio/i8042.c:387
  serio_write include/linux/serio.h:125 [inline]
  ps2_do_sendbyte+0x2cd/0x710 drivers/input/serio/libps2.c:40
  ps2_sendbyte+0x58/0x150 drivers/input/serio/libps2.c:92
  cypress_ps2_sendbyte+0x2e/0x160 drivers/input/mouse/cypress_ps2.c:42
  cypress_ps2_read_cmd_status drivers/input/mouse/cypress_ps2.c:116 [inline]
  cypress_send_ext_cmd+0x1d0/0x8e0 drivers/input/mouse/cypress_ps2.c:189
  cypress_detect+0x75/0x190 drivers/input/mouse/cypress_ps2.c:205
  psmouse_do_detect drivers/input/mouse/psmouse-base.c:1009 [inline]
  psmouse_try_protocol+0x211/0x370 drivers/input/mouse/psmouse-base.c:1023
  psmouse_extensions+0x557/0x930 drivers/input/mouse/psmouse-base.c:1146
  psmouse_switch_protocol+0x52a/0x740 drivers/input/mouse/psmouse-base.c:1542
  psmouse_connect+0x5e9/0xfb0 drivers/input/mouse/psmouse-base.c:1632
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

to a HARDIRQ-irq-unsafe lock:
 (tasklist_lock){.+.+}-{2:2}

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
  &dev->event_lock --> &f->f_owner.lock --> tasklist_lock

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(tasklist_lock);
                               local_irq_disable();
                               lock(&dev->event_lock);
                               lock(&f->f_owner.lock);
  <Interrupt>
    lock(&dev->event_lock);

 *** DEADLOCK ***

9 locks held by syz-executor835/3750:
 #0: ffff88801df50110 (&evdev->mutex){+.+.}-{3:3}, at: evdev_write+0x1d3/0x760 drivers/input/evdev.c:513
 #1: ffff8881468e8230 (&dev->event_lock){-...}-{2:2}, at: input_inject_event+0xa6/0x320 drivers/input/input.c:471
 #2: ffffffff8bb83e60 (rcu_read_lock){....}-{1:2}, at: is_event_supported drivers/input/input.c:53 [inline]
 #2: ffffffff8bb83e60 (rcu_read_lock){....}-{1:2}, at: is_event_supported drivers/input/input.c:50 [inline]
 #2: ffffffff8bb83e60 (rcu_read_lock){....}-{1:2}, at: input_inject_event+0x92/0x320 drivers/input/input.c:470
 #3: ffffffff8bb83e60 (rcu_read_lock){....}-{1:2}, at: input_dev_toggle drivers/input/input.c:1712 [inline]
 #3: ffffffff8bb83e60 (rcu_read_lock){....}-{1:2}, at: input_pass_values.part.0+0x0/0x710 drivers/input/input.c:1832
 #4: ffffffff8bb83e60 (rcu_read_lock){....}-{1:2}, at: evdev_events+0x59/0x3e0 drivers/input/evdev.c:296
 #5: ffff8880741ae028 (&client->buffer_lock){....}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
 #5: ffff8880741ae028 (&client->buffer_lock){....}-{2:2}, at: evdev_pass_values.part.0+0xf6/0x970 drivers/input/evdev.c:261
 #6: ffffffff8bb83e60 (rcu_read_lock){....}-{1:2}, at: kill_fasync+0x41/0x470 fs/fcntl.c:1033
 #7: ffff88801c739be8 (&new->fa_lock){....}-{2:2}, at: kill_fasync_rcu fs/fcntl.c:1014 [inline]
 #7: ffff88801c739be8 (&new->fa_lock){....}-{2:2}, at: kill_fasync fs/fcntl.c:1035 [inline]
 #7: ffff88801c739be8 (&new->fa_lock){....}-{2:2}, at: kill_fasync+0x136/0x470 fs/fcntl.c:1028
 #8: ffff88801c0172b8 (&f->f_owner.lock){....}-{2:2}, at: send_sigio+0x24/0x380 fs/fcntl.c:796

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
                          i8042_command+0x12e/0x150 drivers/input/serio/i8042.c:352
                          i8042_aux_write+0xd7/0x120 drivers/input/serio/i8042.c:387
                          serio_write include/linux/serio.h:125 [inline]
                          ps2_do_sendbyte+0x2cd/0x710 drivers/input/serio/libps2.c:40
                          ps2_sendbyte+0x58/0x150 drivers/input/serio/libps2.c:92
                          cypress_ps2_sendbyte+0x2e/0x160 drivers/input/mouse/cypress_ps2.c:42
                          cypress_ps2_read_cmd_status drivers/input/mouse/cypress_ps2.c:116 [inline]
                          cypress_send_ext_cmd+0x1d0/0x8e0 drivers/input/mouse/cypress_ps2.c:189
                          cypress_detect+0x75/0x190 drivers/input/mouse/cypress_ps2.c:205
                          psmouse_do_detect drivers/input/mouse/psmouse-base.c:1009 [inline]
                          psmouse_try_protocol+0x211/0x370 drivers/input/mouse/psmouse-base.c:1023
                          psmouse_extensions+0x557/0x930 drivers/input/mouse/psmouse-base.c:1146
                          psmouse_switch_protocol+0x52a/0x740 drivers/input/mouse/psmouse-base.c:1542
                          psmouse_connect+0x5e9/0xfb0 drivers/input/mouse/psmouse-base.c:1632
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
    ... key      at: [<ffffffff907da6e0>] __key.8+0x0/0x40
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
                       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                       entry_SYSCALL_64_after_hwframe+0x44/0xae
   }
   ... key      at: [<ffffffff907dab60>] __key.4+0x0/0x40
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
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae

 -> (&new->fa_lock){....}-{2:2} {
    INITIAL USE at:
                     lock_acquire kernel/locking/lockdep.c:5637 [inline]
                     lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                     __raw_write_lock_irq include/linux/rwlock_api_smp.h:194 [inline]
                     _raw_write_lock_irq+0x32/0x50 kernel/locking/spinlock.c:316
                     fasync_remove_entry+0xb6/0x1f0 fs/fcntl.c:891
                     fasync_helper+0x9e/0xb0 fs/fcntl.c:994
                     __fput+0x846/0x9f0 fs/file_table.c:277
                     task_work_run+0xdd/0x1a0 kernel/task_work.c:164
                     exit_task_work include/linux/task_work.h:32 [inline]
                     do_exit+0xc14/0x2b40 kernel/exit.c:832
                     do_group_exit+0x125/0x310 kernel/exit.c:929
                     get_signal+0x47d/0x2220 kernel/signal.c:2852
                     arch_do_signal_or_restart+0x2a9/0x1c40 arch/x86/kernel/signal.c:868
                     handle_signal_work kernel/entry/common.c:148 [inline]
                     exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
                     exit_to_user_mode_prepare+0x17d/0x290 kernel/entry/common.c:207
                     __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
                     syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
                     do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
                     entry_SYSCALL_64_after_hwframe+0x44/0xae
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
                          do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                          do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                          entry_SYSCALL_64_after_hwframe+0x44/0xae
  }
  ... key      at: [<ffffffff90535bc0>] __key.0+0x0/0x40
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
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae

-> (&f->f_owner.lock){....}-{2:2} {
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5637 [inline]
                   lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:194 [inline]
                   _raw_write_lock_irq+0x32/0x50 kernel/locking/spinlock.c:316
                   f_modown+0x2a/0x390 fs/fcntl.c:91
                   __f_setown fs/fcntl.c:110 [inline]
                   f_setown+0xd7/0x230 fs/fcntl.c:138
                   do_fcntl+0x749/0x1210 fs/fcntl.c:393
                   __do_sys_fcntl fs/fcntl.c:472 [inline]
                   __se_sys_fcntl fs/fcntl.c:457 [inline]
                   __x64_sys_fcntl+0x165/0x1e0 fs/fcntl.c:457
                   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                   entry_SYSCALL_64_after_hwframe+0x44/0xae
   INITIAL READ USE at:
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
                        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                        do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                        entry_SYSCALL_64_after_hwframe+0x44/0xae
 }
 ... key      at: [<ffffffff90534de0>] __key.5+0x0/0x40
 ... acquired at:
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
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae


the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
-> (tasklist_lock){.+.+}-{2:2} {
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
                   copy_process+0x36c8/0x75a0 kernel/fork.c:2311
                   kernel_clone+0xe7/0xab0 kernel/fork.c:2582
                   kernel_thread+0xb5/0xf0 kernel/fork.c:2634
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
 ... key      at: [<ffffffff8b80a098>] tasklist_lock+0x18/0x40
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5637 [inline]
   lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
   __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
   _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
   send_sigio+0xab/0x380 fs/fcntl.c:810
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
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae


stack backtrace:
CPU: 1 PID: 3750 Comm: syz-executor835 Not tainted 5.16.0-rc4-syzkaller #0
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
 __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
 _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
 send_sigio+0xab/0x380 fs/fcntl.c:810
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
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f45cf04c349
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f45ceff62f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f45cf0d04c0 RCX: 00007f45cf04c349
RDX: 0000000000003888 RSI: 0000000020000080 RDI: 0000000000000004
RBP: 00007f45cf09d08c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000200012a8
R13: f36140dfc32eddd6 R14: 0030656c69662f2e R15: 00007f45cf0d04c8
 </TASK>

