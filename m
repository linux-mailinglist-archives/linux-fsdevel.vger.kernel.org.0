Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871AA2A1903
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Oct 2020 18:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgJaRjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Oct 2020 13:39:18 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:43831 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgJaRjS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Oct 2020 13:39:18 -0400
Received: by mail-il1-f197.google.com with SMTP id t6so7002777ilj.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2020 10:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=C2E/D5AiG8hyRywQJxXvf9ie/UFFcsJh3gckMZJTd6c=;
        b=iuIb6XhJs5FEbkLb8ELjY+IvnvUwrKb+vsJWcORhSa57Z0tzUi/RBV+LwPjkEmkKta
         neJ4xv+uibJBbzh+rtJkNJRcfIhIzUkqjM19MxQc7V4OkdLBWB0hLdIc36uzdxx4KAhI
         QwkK2ZdHhQvg021qoqe7VY940qLRJqrNleVE4TaxRAyVMUIegbNlnIog02i/5RC2Wlql
         P4GyjsNsFY1SPOCjhYENSeDionKfwUDREnTxlwtLOUksudx6+ea2QrtDX+s5Ti/7WYCu
         F3i67QWO7yjlcwECVwDIT/mAU7yPA/r6pVS2AXD6BPlaHJAq8fYouWh2Evc524t2P9Ot
         gbaQ==
X-Gm-Message-State: AOAM530zQM28PdGaE1h9BacRAXrLTvM//uRK56mKZlJ7A/cBIVD3QHmF
        TptmV8/rvy6jBL0HMJ2FZfhA+YifpEGDa707iyIeOdsNiPZS
X-Google-Smtp-Source: ABdhPJxffQ78ZMFHgdGpos4vUTKGGr4aNtztCbTPQF/KAErn8TVzvIKn4LTEcZf/AFWi8Mrkq5OFGjYM0tozu699QHRCv7cAj4HJ
MIME-Version: 1.0
X-Received: by 2002:a02:ccd6:: with SMTP id k22mr170915jaq.93.1604165957484;
 Sat, 31 Oct 2020 10:39:17 -0700 (PDT)
Date:   Sat, 31 Oct 2020 10:39:17 -0700
In-Reply-To: <0000000000005b4a3805b05a75f8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e85be05b2fafe47@google.com>
Subject: Re: possible deadlock in do_fcntl
From:   syzbot <syzbot+e6d5398a02c516ce5e70@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    4e78c578 Add linux-next specific files for 20201030
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17c275a2500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=83318758268dc331
dashboard link: https://syzkaller.appspot.com/bug?extid=e6d5398a02c516ce5e70
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b24ecc500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c01512500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e6d5398a02c516ce5e70@syzkaller.appspotmail.com

========================================================
WARNING: possible irq lock inversion dependency detected
5.10.0-rc1-next-20201030-syzkaller #0 Not tainted
--------------------------------------------------------
syz-executor138/8506 just changed the state of lock:
ffff88801d4c3a38 (&f->f_owner.lock){.+..}-{2:2}, at: f_getown_ex fs/fcntl.c:206 [inline]
ffff88801d4c3a38 (&f->f_owner.lock){.+..}-{2:2}, at: do_fcntl+0x8ab/0x1070 fs/fcntl.c:387
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

no locks held by syz-executor138/8506.

the shortest dependencies between 2nd lock and 1st lock:
   -> (&dev->event_lock){-...}-{2:2} {
      IN-HARDIRQ-W at:
                          lock_acquire kernel/locking/lockdep.c:5436 [inline]
                          lock_acquire+0x1af/0x8b0 kernel/locking/lockdep.c:5401
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
                          asm_common_interrupt+0x1e/0x40 arch/x86/include/asm/idtentry.h:622
                          native_restore_fl arch/x86/include/asm/irqflags.h:41 [inline]
                          arch_local_irq_restore arch/x86/include/asm/irqflags.h:84 [inline]
                          __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
                          _raw_spin_unlock_irqrestore+0x25/0x50 kernel/locking/spinlock.c:191
                          spin_unlock_irqrestore include/linux/spinlock.h:409 [inline]
                          i8042_command+0x12e/0x150 drivers/input/serio/i8042.c:352
                          i8042_aux_write+0xd7/0x120 drivers/input/serio/i8042.c:387
                          serio_write include/linux/serio.h:125 [inline]
                          ps2_do_sendbyte+0x2ca/0x710 drivers/input/serio/libps2.c:40
                          ps2_sendbyte+0x58/0x150 drivers/input/serio/libps2.c:92
                          cypress_ps2_sendbyte+0x2e/0x160 drivers/input/mouse/cypress_ps2.c:42
                          cypress_ps2_read_cmd_status drivers/input/mouse/cypress_ps2.c:116 [inline]
                          cypress_send_ext_cmd+0x1d0/0x8d0 drivers/input/mouse/cypress_ps2.c:189
                          cypress_detect+0x75/0x190 drivers/input/mouse/cypress_ps2.c:205
                          psmouse_do_detect drivers/input/mouse/psmouse-base.c:1009 [inline]
                          psmouse_try_protocol+0x211/0x370 drivers/input/mouse/psmouse-base.c:1023
                          psmouse_extensions+0x557/0x930 drivers/input/mouse/psmouse-base.c:1146
                          psmouse_switch_protocol+0x52a/0x740 drivers/input/mouse/psmouse-base.c:1542
                          psmouse_connect+0x5e6/0xfc0 drivers/input/mouse/psmouse-base.c:1632
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
      INITIAL USE at:
                         lock_acquire kernel/locking/lockdep.c:5436 [inline]
                         lock_acquire+0x1af/0x8b0 kernel/locking/lockdep.c:5401
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
    ... key      at: [<ffffffff8fa2c2a0>] __key.8+0x0/0x40
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
                       lock_acquire+0x1af/0x8b0 kernel/locking/lockdep.c:5401
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
   ... key      at: [<ffffffff8fa2c7a0>] __key.4+0x0/0x40
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
                          lock_acquire+0x1af/0x8b0 kernel/locking/lockdep.c:5401
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
  ... key      at: [<ffffffff8ef66880>] __key.0+0x0/0x40
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
                    lock_acquire+0x1af/0x8b0 kernel/locking/lockdep.c:5401
                    __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                    _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
                    f_getown_ex fs/fcntl.c:206 [inline]
                    do_fcntl+0x8ab/0x1070 fs/fcntl.c:387
                    __do_sys_fcntl fs/fcntl.c:463 [inline]
                    __se_sys_fcntl fs/fcntl.c:448 [inline]
                    __x64_sys_fcntl+0x165/0x1e0 fs/fcntl.c:448
                    do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                    entry_SYSCALL_64_after_hwframe+0x44/0xa9
   INITIAL READ USE at:
                        lock_acquire kernel/locking/lockdep.c:5436 [inline]
                        lock_acquire+0x1af/0x8b0 kernel/locking/lockdep.c:5401
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
 ... key      at: [<ffffffff8ef65aa0>] __key.5+0x0/0x40
 ... acquired at:
   mark_usage kernel/locking/lockdep.c:4311 [inline]
   __lock_acquire+0x11f5/0x5590 kernel/locking/lockdep.c:4785
   lock_acquire kernel/locking/lockdep.c:5436 [inline]
   lock_acquire+0x1af/0x8b0 kernel/locking/lockdep.c:5401
   __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
   _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
   f_getown_ex fs/fcntl.c:206 [inline]
   do_fcntl+0x8ab/0x1070 fs/fcntl.c:387
   __do_sys_fcntl fs/fcntl.c:463 [inline]
   __se_sys_fcntl fs/fcntl.c:448 [inline]
   __x64_sys_fcntl+0x165/0x1e0 fs/fcntl.c:448
   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
   entry_SYSCALL_64_after_hwframe+0x44/0xa9


stack backtrace:
CPU: 0 PID: 8506 Comm: syz-executor138 Not tainted 5.10.0-rc1-next-20201030-syzkaller #0
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
 lock_acquire+0x1af/0x8b0 kernel/locking/lockdep.c:5401
 __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
 _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
 f_getown_ex fs/fcntl.c:206 [inline]
 do_fcntl+0x8ab/0x1070 fs/fcntl.c:387
 __do_sys_fcntl fs/fcntl.c:463 [inline]
 __se_sys_fcntl fs/fcntl.c:448 [inline]
 __x64_sys_fcntl+0x165/0x1e0 fs/fcntl.c:448
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4475d9
Code: e8 bc af 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 9b d7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd26d7f9d8 EFLAGS

