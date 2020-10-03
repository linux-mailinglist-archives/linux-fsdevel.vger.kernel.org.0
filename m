Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3F3282399
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Oct 2020 12:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbgJCK3S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 06:29:18 -0400
Received: from mail-il1-f205.google.com ([209.85.166.205]:49632 "EHLO
        mail-il1-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgJCK3S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 06:29:18 -0400
Received: by mail-il1-f205.google.com with SMTP id o18so3142564ilm.16
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Oct 2020 03:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=G4i+qxoZS1h9xcqOjqce04kB/T00rcmIWlmTvez//Lk=;
        b=S2jpSKYP993qn7lM3VcBLCw84hvYNCQrbTeURut+FcYcTDgdptcrAtsC24alh98jcN
         yPkb9iPWLx52o0BrWbeP1DJqyjgMDy25XkSbOpQD4UK2GO8G+rvQrUr66V3mJw/1VPoP
         Xq2mOmbUNICwI9QQ9u4t91bZFsBVZc6VKAlySjgSRyPfrk4v9B7wjxMZ8jicXuAupD2M
         DukTTtCUXigtD1+LOWs5Io9oxb8pvoARBkmSmW5kTsq81jKwPp8NjuGBR9/C+cOCZM1Q
         boKDewAzqjRfnkrt3poyAxCo7P20bvGUHtEG7IgScRq6HoyzzYCb4gCmZcA629dMDE8n
         tcJQ==
X-Gm-Message-State: AOAM533m4YJMUSjcpPIZiWyoehs/BAvSBa/xmYxzcjpHshPZ6dQRDl8o
        dAKeliUUFpSIR4+Vjpy4mB6BtYsinxDIi0qbR8WcVWJeq1Oe
X-Google-Smtp-Source: ABdhPJy4g6XW5GNnNafS6v9MpxqMc7rKDJozmp7G6eth11SQ7uFAC0BluZMBgMkAP3Wl2PsfcXSHNCb24TxWolg9MTepjLu0mWnd
MIME-Version: 1.0
X-Received: by 2002:a02:6623:: with SMTP id k35mr5973348jac.105.1601720955989;
 Sat, 03 Oct 2020 03:29:15 -0700 (PDT)
Date:   Sat, 03 Oct 2020 03:29:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009c775805b0c1b811@google.com>
Subject: possible deadlock in kill_fasync
From:   syzbot <syzbot+3e12e14ee01b675e1af2@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    663b07a4 Add linux-next specific files for 20200928
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16202587900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4279ffe1791babf
dashboard link: https://syzkaller.appspot.com/bug?extid=3e12e14ee01b675e1af2
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3e12e14ee01b675e1af2@syzkaller.appspotmail.com

========================================================
WARNING: possible irq lock inversion dependency detected
5.9.0-rc7-next-20200928-syzkaller #0 Not tainted
--------------------------------------------------------
kworker/u4:3/37 just changed the state of lock:
ffff88809f2f6f30 (&new->fa_lock){.+..}-{2:2}, at: kill_fasync_rcu fs/fcntl.c:1002 [inline]
ffff88809f2f6f30 (&new->fa_lock){.+..}-{2:2}, at: kill_fasync fs/fcntl.c:1023 [inline]
ffff88809f2f6f30 (&new->fa_lock){.+..}-{2:2}, at: kill_fasync+0x14b/0x460 fs/fcntl.c:1016
but this lock was taken by another, HARDIRQ-safe lock in the past:
 (&dev->event_lock){-...}-{2:2}


and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
Chain exists of:
  &dev->event_lock --> &client->buffer_lock --> &new->fa_lock

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&new->fa_lock);
                               local_irq_disable();
                               lock(&dev->event_lock);
                               lock(&client->buffer_lock);
  <Interrupt>
    lock(&dev->event_lock);

 *** DEADLOCK ***

7 locks held by kworker/u4:3/37:
 #0: ffff888099228138 ((wq_completion)bat_events){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888099228138 ((wq_completion)bat_events){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff888099228138 ((wq_completion)bat_events){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff888099228138 ((wq_completion)bat_events){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:616 [inline]
 #0: ffff888099228138 ((wq_completion)bat_events){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff888099228138 ((wq_completion)bat_events){+.+.}-{0:0}, at: process_one_work+0x821/0x15a0 kernel/workqueue.c:2240
 #1: ffffc90000eb7da8 ((work_completion)(&(&forw_packet_aggr->delayed_work)->work)){+.+.}-{0:0}, at: process_one_work+0x854/0x15a0 kernel/workqueue.c:2244
 #2: ffffffff8a553ca0 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xmit+0x1d7/0x2d30 net/core/dev.c:4072
 #3: ffffffff8a553d00 (rcu_read_lock){....}-{1:2}, at: dev_queue_xmit_nit+0x0/0xac0 net/core/dev.c:5620
 #4: ffffffff8a553d00 (rcu_read_lock){....}-{1:2}, at: sock_def_readable+0x0/0x4c0 include/net/sock.h:1804
 #5: ffffffff8a553d00 (rcu_read_lock){....}-{1:2}, at: rcu_lock_release include/linux/rcupdate.h:258 [inline]
 #5: ffffffff8a553d00 (rcu_read_lock){....}-{1:2}, at: rcu_read_unlock include/linux/rcupdate.h:696 [inline]
 #5: ffffffff8a553d00 (rcu_read_lock){....}-{1:2}, at: sock_def_readable+0x1c7/0x4c0 net/core/sock.c:2897
 #6: ffffffff8a553d00 (rcu_read_lock){....}-{1:2}, at: kill_fasync+0x3d/0x460 fs/fcntl.c:1021

the shortest dependencies between 2nd lock and 1st lock:
  -> (&dev->event_lock){-...}-{2:2} {
     IN-HARDIRQ-W at:
                        lock_acquire+0x1f2/0xaa0 kernel/locking/lockdep.c:5398
                        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                        _raw_spin_lock_irqsave+0x94/0xd0 kernel/locking/spinlock.c:159
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
                        __handle_irq_event_percpu+0x20b/0x9e0 kernel/irq/handle.c:156
                        handle_irq_event_percpu kernel/irq/handle.c:196 [inline]
                        handle_irq_event+0x102/0x290 kernel/irq/handle.c:213
                        handle_edge_irq+0x25f/0xd00 kernel/irq/chip.c:819
                        asm_call_irq_on_stack+0xf/0x20
                        __run_irq_on_irqstack arch/x86/include/asm/irq_stack.h:48 [inline]
                        run_irq_on_irqstack_cond arch/x86/include/asm/irq_stack.h:101 [inline]
                        handle_irq arch/x86/kernel/irq.c:230 [inline]
                        __common_interrupt arch/x86/kernel/irq.c:249 [inline]
                        common_interrupt+0x115/0x1f0 arch/x86/kernel/irq.c:239
                        asm_common_interrupt+0x1e/0x40 arch/x86/include/asm/idtentry.h:622
                        arch_local_irq_restore arch/x86/include/asm/paravirt.h:653 [inline]
                        console_unlock+0xa31/0xd20 kernel/printk/printk.c:2500
                        vprintk_emit+0x2a6/0x6e0 kernel/printk/printk.c:2021
                        vprintk_func+0x8d/0x1e0 kernel/printk/printk_safe.c:393
                        printk+0xba/0xed kernel/printk/printk.c:2069
                        vivid_create_devnodes drivers/media/test-drivers/vivid/vivid-core.c:1528 [inline]
                        vivid_create_instance drivers/media/test-drivers/vivid/vivid-core.c:1886 [inline]
                        vivid_probe.cold+0x7178/0x845c drivers/media/test-drivers/vivid/vivid-core.c:1941
                        platform_drv_probe+0x87/0x140 drivers/base/platform.c:761
                        really_probe+0x282/0x9f0 drivers/base/dd.c:553
                        driver_probe_device+0xfe/0x1d0 drivers/base/dd.c:737
                        device_driver_attach+0x228/0x290 drivers/base/dd.c:1012
                        __driver_attach drivers/base/dd.c:1089 [inline]
                        __driver_attach+0xda/0x240 drivers/base/dd.c:1043
                        bus_for_each_dev+0x147/0x1d0 drivers/base/bus.c:305
                        bus_add_driver+0x348/0x5a0 drivers/base/bus.c:622
                        driver_register+0x220/0x3a0 drivers/base/driver.c:171
                        vivid_init+0x37/0x64 drivers/media/test-drivers/vivid/vivid-core.c:2069
                        do_one_initcall+0x103/0x6f0 init/main.c:1205
                        do_initcall_level init/main.c:1278 [inline]
                        do_initcalls init/main.c:1294 [inline]
                        do_basic_setup init/main.c:1314 [inline]
                        kernel_init_freeable+0x652/0x6d6 init/main.c:1514
                        kernel_init+0xd/0x1b8 init/main.c:1403
                        ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
     INITIAL USE at:
                       lock_acquire+0x1f2/0xaa0 kernel/locking/lockdep.c:5398
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
                       led_classdev_register_ext+0x552/0x6e0 drivers/leds/led-class.c:417
                       led_classdev_register include/linux/leds.h:190 [inline]
                       input_leds_connect+0x3fb/0x740 drivers/input/input-leds.c:139
                       input_attach_handler+0x180/0x1f0 drivers/input/input.c:1031
                       input_register_device.cold+0xf0/0x243 drivers/input/input.c:2229
                       atkbd_connect+0x736/0x9d0 drivers/input/keyboard/atkbd.c:1293
                       serio_connect_driver drivers/input/serio/serio.c:47 [inline]
                       serio_driver_probe+0x72/0xa0 drivers/input/serio/serio.c:778
                       really_probe+0x282/0x9f0 drivers/base/dd.c:553
                       driver_probe_device+0xfe/0x1d0 drivers/base/dd.c:737
                       device_driver_attach+0x228/0x290 drivers/base/dd.c:1012
                       __driver_attach drivers/base/dd.c:1089 [inline]
                       __driver_attach+0xda/0x240 drivers/base/dd.c:1043
                       bus_for_each_dev+0x147/0x1d0 drivers/base/bus.c:305
                       serio_attach_driver drivers/input/serio/serio.c:808 [inline]
                       serio_handle_event+0x5f6/0xa30 drivers/input/serio/serio.c:227
                       process_one_work+0x933/0x15a0 kernel/workqueue.c:2269
                       worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
                       kthread+0x3af/0x4a0 kernel/kthread.c:292
                       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
   }
   ... key      at: [<ffffffff8e607fa0>] __key.5+0x0/0x40
   ... acquired at:
   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
   _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
   spin_lock include/linux/spinlock.h:354 [inline]
   evdev_pass_values+0x195/0xa70 drivers/input/evdev.c:262
   evdev_events+0x20c/0x330 drivers/input/evdev.c:307
   input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
   input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
   input_pass_values drivers/input/input.c:134 [inline]
   input_handle_event+0x324/0x1400 drivers/input/input.c:399
   input_inject_event+0x2f5/0x310 drivers/input/input.c:471
   evdev_write+0x424/0x750 drivers/input/evdev.c:530
   vfs_write+0x28e/0x700 fs/read_write.c:593
   ksys_write+0x1ee/0x250 fs/read_write.c:648
   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

 -> (&client->buffer_lock){....}-{2:2} {
    INITIAL USE at:
                     lock_acquire+0x1f2/0xaa0 kernel/locking/lockdep.c:5398
                     __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                     _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
                     spin_lock include/linux/spinlock.h:354 [inline]
                     evdev_pass_values+0x195/0xa70 drivers/input/evdev.c:262
                     evdev_events+0x20c/0x330 drivers/input/evdev.c:307
                     input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
                     input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
                     input_pass_values drivers/input/input.c:134 [inline]
                     input_handle_event+0x324/0x1400 drivers/input/input.c:399
                     input_inject_event+0x2f5/0x310 drivers/input/input.c:471
                     evdev_write+0x424/0x750 drivers/input/evdev.c:530
                     vfs_write+0x28e/0x700 fs/read_write.c:593
                     ksys_write+0x1ee/0x250 fs/read_write.c:648
                     do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                     entry_SYSCALL_64_after_hwframe+0x44/0xa9
  }
  ... key      at: [<ffffffff8e6084a0>] __key.4+0x0/0x40
  ... acquired at:
   __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
   _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
   kill_fasync_rcu fs/fcntl.c:1002 [inline]
   kill_fasync fs/fcntl.c:1023 [inline]
   kill_fasync+0x14b/0x460 fs/fcntl.c:1016
   __pass_event drivers/input/evdev.c:240 [inline]
   evdev_pass_values+0x72a/0xa70 drivers/input/evdev.c:279
   evdev_events+0x20c/0x330 drivers/input/evdev.c:307
   input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
   input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
   input_pass_values drivers/input/input.c:134 [inline]
   input_handle_event+0x324/0x1400 drivers/input/input.c:399
   input_inject_event+0x2f5/0x310 drivers/input/input.c:471
   evdev_write+0x424/0x750 drivers/input/evdev.c:530
   vfs_write+0x28e/0x700 fs/read_write.c:593
   ksys_write+0x1ee/0x250 fs/read_write.c:648
   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> (&new->fa_lock){.+..}-{2:2} {
   HARDIRQ-ON-R at:
                    lock_acquire+0x1f2/0xaa0 kernel/locking/lockdep.c:5398
                    __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                    _raw_read_lock+0x36/0x70 kernel/locking/spinlock.c:223
                    kill_fasync_rcu fs/fcntl.c:1002 [inline]
                    kill_fasync fs/fcntl.c:1023 [inline]
                    kill_fasync+0x14b/0x460 fs/fcntl.c:1016
                    sock_wake_async+0xd2/0x160 net/socket.c:1331
                    sk_wake_async include/net/sock.h:2259 [inline]
                    sk_wake_async include/net/sock.h:2255 [inline]
                    sock_def_readable+0x2cb/0x4c0 net/core/sock.c:2896
                    __sock_queue_rcv_skb+0x520/0xaa0 net/core/sock.c:468
                    sock_queue_rcv_skb+0x41/0x60 net/core/sock.c:481
                    packet_rcv_spkt+0x3ad/0x530 net/packet/af_packet.c:1856
                    dev_queue_xmit_nit+0x7f6/0xac0 net/core/dev.c:2362
                    xmit_one net/core/dev.c:3558 [inline]
                    dev_hard_start_xmit+0xa4/0x880 net/core/dev.c:3578
                    __dev_queue_xmit+0x2062/0x2d30 net/core/dev.c:4137
                    batadv_send_skb_packet+0x4a9/0x5f0 net/batman-adv/send.c:108
                    batadv_iv_ogm_send_to_if net/batman-adv/bat_iv_ogm.c:394 [inline]
                    batadv_iv_ogm_emit net/batman-adv/bat_iv_ogm.c:420 [inline]
                    batadv_iv_send_outstanding_bat_ogm_packet+0x6ad/0x800 net/batman-adv/bat_iv_ogm.c:1712
                    process_one_work+0x933/0x15a0 kernel/workqueue.c:2269
                    worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
                    kthread+0x3af/0x4a0 kernel/kthread.c:292
                    ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
   INITIAL USE at:
                   lock_acquire+0x1f2/0xaa0 kernel/locking/lockdep.c:5398
                   __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                   _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
                   kill_fasync_rcu fs/fcntl.c:1002 [inline]
                   kill_fasync fs/fcntl.c:1023 [inline]
                   kill_fasync+0x14b/0x460 fs/fcntl.c:1016
                   __pass_event drivers/input/evdev.c:240 [inline]
                   evdev_pass_values+0x72a/0xa70 drivers/input/evdev.c:279
                   evdev_events+0x20c/0x330 drivers/input/evdev.c:307
                   input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
                   input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
                   input_pass_values drivers/input/input.c:134 [inline]
                   input_handle_event+0x324/0x1400 drivers/input/input.c:399
                   input_inject_event+0x2f5/0x310 drivers/input/input.c:471
                   evdev_write+0x424/0x750 drivers/input/evdev.c:530
                   vfs_write+0x28e/0x700 fs/read_write.c:593
                   ksys_write+0x1ee/0x250 fs/read_write.c:648
                   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                   entry_SYSCALL_64_after_hwframe+0x44/0xa9
   (null) at:
================================================================================
UBSAN: array-index-out-of-bounds in kernel/locking/lockdep.c:2240:40
index 9 is out of range for type 'lock_trace *[9]'
CPU: 0 PID: 37 Comm: kworker/u4:3 Not tainted 5.9.0-rc7-next-20200928-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fb lib/dump_stack.c:118
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
 __ubsan_handle_out_of_bounds.cold+0x62/0x6c lib/ubsan.c:356
 print_lock_class_header kernel/locking/lockdep.c:2240 [inline]
 print_shortest_lock_dependencies.cold+0x11c/0x2e2 kernel/locking/lockdep.c:2263
 print_irq_inversion_bug.part.0+0x2c6/0x2ee kernel/locking/lockdep.c:3769
 print_irq_inversion_bug kernel/locking/lockdep.c:3694 [inline]
 check_usage_backwards kernel/locking/lockdep.c:3838 [inline]
 mark_lock_irq kernel/locking/lockdep.c:3928 [inline]
 mark_lock.cold+0x1a/0x74 kernel/locking/lockdep.c:4375
 mark_usage kernel/locking/lockdep.c:4266 [inline]
 __lock_acquire+0x11ef/0x56d0 kernel/locking/lockdep.c:4750
 lock_acquire+0x1f2/0xaa0 kernel/locking/lockdep.c:5398
 __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
 _raw_read_lock+0x36/0x70 kernel/locking/spinlock.c:223
 kill_fasync_rcu fs/fcntl.c:1002 [inline]
 kill_fasync fs/fcntl.c:1023 [inline]
 kill_fasync+0x14b/0x460 fs/fcntl.c:1016
 sock_wake_async+0xd2/0x160 net/socket.c:1331
 sk_wake_async include/net/sock.h:2259 [inline]
 sk_wake_async include/net/sock.h:2255 [inline]
 sock_def_readable+0x2cb/0x4c0 net/core/sock.c:2896
 __sock_queue_rcv_skb+0x520/0xaa0 net/core/sock.c:468
 sock_queue_rcv_skb+0x41/0x60 net/core/sock.c:481
 packet_rcv_spkt+0x3ad/0x530 net/packet/af_packet.c:1856
 dev_queue_xmit_nit+0x7f6/0xac0 net/core/dev.c:2362
 xmit_one net/core/dev.c:3558 [inline]
 dev_hard_start_xmit+0xa4/0x880 net/core/dev.c:3578
 __dev_queue_xmit+0x2062/0x2d30 net/core/dev.c:4137
 batadv_send_skb_packet+0x4a9/0x5f0 net/batman-adv/send.c:108
 batadv_iv_ogm_send_to_if net/batman-adv/bat_iv_ogm.c:394 [inline]
 batadv_iv_ogm_emit net/batman-adv/bat_iv_ogm.c:420 [inline]
 batadv_iv_send_outstanding_bat_ogm_packet+0x6ad/0x800 net/batman-adv/bat_iv_ogm.c:1712
 process_one_work+0x933/0x15a0 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3af/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
