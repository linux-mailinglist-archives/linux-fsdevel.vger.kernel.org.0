Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5990296BC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Oct 2020 11:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461131AbgJWJHc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Oct 2020 05:07:32 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:51227 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461037AbgJWJHZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:07:25 -0400
Received: by mail-io1-f70.google.com with SMTP id e65so577812iof.18
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2020 02:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=eHaJ/DCBMXkf0GERgPm7+1gNQuby2IfgpZTtk42mYSY=;
        b=mLA5dDDhneVjUr8ITaHAcxvWp9lOklvA+1GjgykGVEajmMklo09l65f1NF+IefSyFj
         WwZxs/PyYqkkhWmkhJUoe4AvaDNTGNzyJyUq1bSL6UKFsYGVLO5COAPA87qen38ya7QY
         JEbLSYksuIKd419h4aN4tjV5ZaV48GhZcrnyLNrRk0qaBckgrbYz+VeSJmtETxJ3W77T
         bdhENTO9xGdH9mot/tmmQOp95f1SqXPYtN1QWs0pC//9onimauTlt3BgSNr7zleSNql4
         dLeJ9ZESusZN1iGPyd3tkwKlhFEjGn+In/KW8Ifbk8naQEc0dLUwST+H2VErmxdle41O
         jksA==
X-Gm-Message-State: AOAM530gDZ8xoBX2/IWoSre1gv7w4zHA8VDiZ33WS1L3jgMeYA1Er/z9
        D6NllhqjSDaBRttQ2yn8hwloyc433UkS7Z3OtS2GEWWyqvFg
X-Google-Smtp-Source: ABdhPJyLHAfkhWr0fTREVGwWAYICjAL4LmBr5T6TpsTiqTm1lmnQqZArNipJdw4EUtyl/aevapsIwYlX71Y5ajs49MOTvcTGxyMd
MIME-Version: 1.0
X-Received: by 2002:a92:c650:: with SMTP id 16mr869420ill.94.1603444043218;
 Fri, 23 Oct 2020 02:07:23 -0700 (PDT)
Date:   Fri, 23 Oct 2020 02:07:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d056805b252e883@google.com>
Subject: possible deadlock in send_sigurg (2)
From:   syzbot <syzbot+c5e32344981ad9f33750@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7cf726a5 Merge tag 'linux-kselftest-kunit-5.10-rc1' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14ba8ea0500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=80f536b098d66fd2
dashboard link: https://syzkaller.appspot.com/bug?extid=c5e32344981ad9f33750
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c5e32344981ad9f33750@syzkaller.appspotmail.com

========================================================
WARNING: possible irq lock inversion dependency detected
5.9.0-syzkaller #0 Not tainted
--------------------------------------------------------
syz-executor.4/8709 just changed the state of lock:
ffff8880132a3438 (&f->f_owner.lock){.+..}-{2:2}, at: send_sigurg+0x1e/0xac0 fs/fcntl.c:824
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

1 lock held by syz-executor.4/8709:
 #0: ffff88802a83c160 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1581 [inline]
 #0: ffff88802a83c160 (sk_lock-AF_INET){+.+.}-{0:0}, at: inet_wait_for_connect net/ipv4/af_inet.c:596 [inline]
 #0: ffff88802a83c160 (sk_lock-AF_INET){+.+.}-{0:0}, at: __inet_stream_connect+0x596/0xe30 net/ipv4/af_inet.c:686

the shortest dependencies between 2nd lock and 1st lock:
   -> (&dev->event_lock){-...}-{2:2} {
      IN-HARDIRQ-W at:
                          lock_acquire kernel/locking/lockdep.c:5442 [inline]
                          lock_acquire+0x219/0x9d0 kernel/locking/lockdep.c:5407
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
                          common_interrupt+0x120/0x200 arch/x86/kernel/irq.c:239
                          asm_common_interrupt+0x1e/0x40 arch/x86/include/asm/idtentry.h:622
                          arch_local_irq_restore arch/x86/include/asm/paravirt.h:653 [inline]
                          __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
                          _raw_spin_unlock_irqrestore+0x4d/0x90 kernel/locking/spinlock.c:191
                          spin_unlock_irqrestore include/linux/spinlock.h:409 [inline]
                          i8042_command+0x111/0x130 drivers/input/serio/i8042.c:348
                          i8042_aux_write+0xd7/0x120 drivers/input/serio/i8042.c:383
                          serio_write include/linux/serio.h:125 [inline]
                          ps2_do_sendbyte+0x2cc/0x640 drivers/input/serio/libps2.c:40
                          ps2_sendbyte+0x4b/0x90 drivers/input/serio/libps2.c:92
                          cypress_ps2_sendbyte drivers/input/mouse/cypress_ps2.c:42 [inline]
                          cypress_ps2_read_cmd_status drivers/input/mouse/cypress_ps2.c:116 [inline]
                          cypress_send_ext_cmd+0x1cb/0x8a0 drivers/input/mouse/cypress_ps2.c:189
                          cypress_detect+0x75/0x190 drivers/input/mouse/cypress_ps2.c:205
                          psmouse_do_detect drivers/input/mouse/psmouse-base.c:1009 [inline]
                          psmouse_try_protocol+0x211/0x370 drivers/input/mouse/psmouse-base.c:1023
                          psmouse_extensions+0x557/0x930 drivers/input/mouse/psmouse-base.c:1146
                          psmouse_switch_protocol+0x52a/0x740 drivers/input/mouse/psmouse-base.c:1542
                          psmouse_connect+0x5e6/0xfc0 drivers/input/mouse/psmouse-base.c:1632
                          serio_connect_driver drivers/input/serio/serio.c:47 [inline]
                          serio_driver_probe+0x72/0xa0 drivers/input/serio/serio.c:778
                          really_probe+0x282/0x9f0 drivers/base/dd.c:554
                          driver_probe_device+0xfe/0x1d0 drivers/base/dd.c:738
                          device_driver_attach+0x228/0x290 drivers/base/dd.c:1013
                          __driver_attach drivers/base/dd.c:1090 [inline]
                          __driver_attach+0xda/0x240 drivers/base/dd.c:1044
                          bus_for_each_dev+0x147/0x1d0 drivers/base/bus.c:305
                          serio_attach_driver drivers/input/serio/serio.c:808 [inline]
                          serio_handle_event+0x5f6/0xa30 drivers/input/serio/serio.c:227
                          process_one_work+0x933/0x15a0 kernel/workqueue.c:2272
                          worker_thread+0x64c/0x1120 kernel/workqueue.c:2418
                          kthread+0x3b5/0x4a0 kernel/kthread.c:292
                          ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
      INITIAL USE at:
                         lock_acquire kernel/locking/lockdep.c:5442 [inline]
                         lock_acquire+0x219/0x9d0 kernel/locking/lockdep.c:5407
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
                         really_probe+0x282/0x9f0 drivers/base/dd.c:554
                         driver_probe_device+0xfe/0x1d0 drivers/base/dd.c:738
                         device_driver_attach+0x228/0x290 drivers/base/dd.c:1013
                         __driver_attach drivers/base/dd.c:1090 [inline]
                         __driver_attach+0xda/0x240 drivers/base/dd.c:1044
                         bus_for_each_dev+0x147/0x1d0 drivers/base/bus.c:305
                         serio_attach_driver drivers/input/serio/serio.c:808 [inline]
                         serio_handle_event+0x5f6/0xa30 drivers/input/serio/serio.c:227
                         process_one_work+0x933/0x15a0 kernel/workqueue.c:2272
                         worker_thread+0x64c/0x1120 kernel/workqueue.c:2418
                         kthread+0x3b5/0x4a0 kernel/kthread.c:292
                         ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
    }
    ... key      at: [<ffffffff8e616a40>] __key.5+0x0/0x40
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
   vfs_write+0x2b0/0x730 fs/read_write.c:584
   ksys_write+0x1ee/0x250 fs/read_write.c:639
   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

  -> (&client->buffer_lock){....}-{2:2} {
     INITIAL USE at:
                       lock_acquire kernel/locking/lockdep.c:5442 [inline]
                       lock_acquire+0x219/0x9d0 kernel/locking/lockdep.c:5407
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
                       vfs_write+0x2b0/0x730 fs/read_write.c:584
                       ksys_write+0x1ee/0x250 fs/read_write.c:639
                       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                       entry_SYSCALL_64_after_hwframe+0x44/0xa9
   }
   ... key      at: [<ffffffff8e616f40>] __key.4+0x0/0x40
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
   vfs_write+0x2b0/0x730 fs/read_write.c:584
   ksys_write+0x1ee/0x250 fs/read_write.c:639
   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

 -> (&new->fa_lock){....}-{2:2} {
    INITIAL USE at:
                     lock_acquire kernel/locking/lockdep.c:5442 [inline]
                     lock_acquire+0x219/0x9d0 kernel/locking/lockdep.c:5407
                     __raw_write_lock_irq include/linux/rwlock_api_smp.h:196 [inline]
                     _raw_write_lock_irq+0x94/0xd0 kernel/locking/spinlock.c:311
                     fasync_remove_entry+0xb6/0x1f0 fs/fcntl.c:880
                     fasync_helper+0x9e/0xb0 fs/fcntl.c:983
                     __fput+0x70f/0x920 fs/file_table.c:278
                     task_work_run+0xdd/0x190 kernel/task_work.c:141
                     tracehook_notify_resume include/linux/tracehook.h:188 [inline]
                     exit_to_user_mode_loop kernel/entry/common.c:165 [inline]
                     exit_to_user_mode_prepare+0x20e/0x230 kernel/entry/common.c:192
                     syscall_exit_to_user_mode+0x7a/0x2c0 kernel/entry/common.c:267
                     entry_SYSCALL_64_after_hwframe+0x44/0xa9
    INITIAL READ USE at:
                          lock_acquire kernel/locking/lockdep.c:5442 [inline]
                          lock_acquire+0x219/0x9d0 kernel/locking/lockdep.c:5407
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
                          vfs_write+0x2b0/0x730 fs/read_write.c:584
                          ksys_write+0x1ee/0x250 fs/read_write.c:639
                          do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                          entry_SYSCALL_64_after_hwframe+0x44/0xa9
  }
  ... key      at: [<ffffffff8dadc160>] __key.0+0x0/0x40
  ... acquired at:
   __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
   _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
   send_sigio+0x24/0x360 fs/fcntl.c:786
   kill_fasync_rcu fs/fcntl.c:1009 [inline]
   kill_fasync fs/fcntl.c:1023 [inline]
   kill_fasync+0x205/0x460 fs/fcntl.c:1016
   __pass_event drivers/input/evdev.c:240 [inline]
   evdev_pass_values+0x72a/0xa70 drivers/input/evdev.c:279
   evdev_events+0x20c/0x330 drivers/input/evdev.c:307
   input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
   input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
   input_pass_values drivers/input/input.c:134 [inline]
   input_handle_event+0x324/0x1400 drivers/input/input.c:399
   input_inject_event+0x2f5/0x310 drivers/input/input.c:471
   evdev_write+0x424/0x750 drivers/input/evdev.c:530
   vfs_write+0x2b0/0x730 fs/read_write.c:584
   ksys_write+0x1ee/0x250 fs/read_write.c:639
   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> (&f->f_owner.lock){.+..}-{2:2} {
   HARDIRQ-ON-R at:
                    lock_acquire kernel/locking/lockdep.c:5442 [inline]
                    lock_acquire+0x219/0x9d0 kernel/locking/lockdep.c:5407
                    __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                    _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
                    send_sigurg+0x1e/0xac0 fs/fcntl.c:824
                    sk_send_sigurg+0x76/0x300 net/core/sock.c:2925
                    tcp_check_urg.isra.0+0x1f4/0x710 net/ipv4/tcp_input.c:5489
                    tcp_urg net/ipv4/tcp_input.c:5530 [inline]
                    tcp_rcv_established+0x106c/0x1e40 net/ipv4/tcp_input.c:5862
                    tcp_v4_do_rcv+0x5d1/0x870 net/ipv4/tcp_ipv4.c:1652
                    sk_backlog_rcv include/net/sock.h:1010 [inline]
                    __release_sock+0x134/0x3a0 net/core/sock.c:2523
                    release_sock+0x54/0x1b0 net/core/sock.c:3053
                    sk_stream_wait_memory+0x5bd/0xe60 net/core/stream.c:145
                    tcp_sendmsg_locked+0x1034/0x2d30 net/ipv4/tcp.c:1402
                    tcp_sendmsg+0x2b/0x40 net/ipv4/tcp.c:1442
                    inet_sendmsg+0x99/0xe0 net/ipv4/af_inet.c:817
                    sock_sendmsg_nosec net/socket.c:651 [inline]
                    sock_sendmsg+0xcf/0x120 net/socket.c:671
                    __sys_sendto+0x21c/0x320 net/socket.c:1992
                    __do_sys_sendto net/socket.c:2004 [inline]
                    __se_sys_sendto net/socket.c:2000 [inline]
                    __x64_sys_sendto+0xdd/0x1b0 net/socket.c:2000
                    do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                    entry_SYSCALL_64_after_hwframe+0x44/0xa9
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5442 [inline]
                   lock_acquire+0x219/0x9d0 kernel/locking/lockdep.c:5407
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:196 [inline]
                   _raw_write_lock_irq+0x94/0xd0 kernel/locking/spinlock.c:311
                   f_modown+0x2a/0x390 fs/fcntl.c:90
                   __f_setown fs/fcntl.c:109 [inline]
                   f_setown+0xf4/0x230 fs/fcntl.c:137
                   sock_ioctl+0x263/0x730 net/socket.c:1128
                   vfs_ioctl fs/ioctl.c:48 [inline]
                   __do_sys_ioctl fs/ioctl.c:753 [inline]
                   __se_sys_ioctl fs/ioctl.c:739 [inline]
                   __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
                   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                   entry_SYSCALL_64_after_hwframe+0x44/0xa9
   INITIAL READ USE at:
                        lock_acquire kernel/locking/lockdep.c:5442 [inline]
                        lock_acquire+0x219/0x9d0 kernel/locking/lockdep.c:5407
                        __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                        _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
                        send_sigio+0x24/0x360 fs/fcntl.c:786
                        kill_fasync_rcu fs/fcntl.c:1009 [inline]
                        kill_fasync fs/fcntl.c:1023 [inline]
                        kill_fasync+0x205/0x460 fs/fcntl.c:1016
                        __pass_event drivers/input/evdev.c:240 [inline]
                        evdev_pass_values+0x72a/0xa70 drivers/input/evdev.c:279
                        evdev_events+0x20c/0x330 drivers/input/evdev.c:307
                        input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
                        input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
                        input_pass_values drivers/input/input.c:134 [inline]
                        input_handle_event+0x324/0x1400 drivers/input/input.c:399
                        input_inject_event+0x2f5/0x310 drivers/input/input.c:471
                        evdev_write+0x424/0x750 drivers/input/evdev.c:530
                        vfs_write+0x2b0/0x730 fs/read_write.c:584
                        ksys_write+0x1ee/0x250 fs/read_write.c:639
                        do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                        entry_SYSCALL_64_after_hwframe+0x44/0xa9
 }
 ... key      at: [<ffffffff8dadb380>] __key.5+0x0/0x40
 ... acquired at:
   mark_usage kernel/locking/lockdep.c:4311 [inline]
   __lock_acquire+0x11f5/0x5590 kernel/locking/lockdep.c:4791
   lock_acquire kernel/locking/lockdep.c:5442 [inline]
   lock_acquire+0x219/0x9d0 kernel/locking/lockdep.c:5407
   __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
   _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
   send_sigurg+0x1e/0xac0 fs/fcntl.c:824
   sk_send_sigurg+0x76/0x300 net/core/sock.c:2925
   tcp_check_urg.isra.0+0x1f4/0x710 net/ipv4/tcp_input.c:5489
   tcp_urg net/ipv4/tcp_input.c:5530 [inline]
   tcp_rcv_established+0x106c/0x1e40 net/ipv4/tcp_input.c:5862
   tcp_v4_do_rcv+0x5d1/0x870 net/ipv4/tcp_ipv4.c:1652
   sk_backlog_rcv include/net/sock.h:1010 [inline]
   __release_sock+0x134/0x3a0 net/core/sock.c:2523
   release_sock+0x54/0x1b0 net/core/sock.c:3053
   sk_stream_wait_memory+0x5bd/0xe60 net/core/stream.c:145
   tcp_sendmsg_locked+0x1034/0x2d30 net/ipv4/tcp.c:1402
   tcp_sendmsg+0x2b/0x40 net/ipv4/tcp.c:1442
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
CPU: 0 PID: 8709 Comm: syz-executor.4 Not tainted 5.9.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fb lib/dump_stack.c:118
 print_irq_inversion_bug kernel/locking/lockdep.c:4410 [inline]
 check_usage_backwards kernel/locking/lockdep.c:3883 [inline]
 mark_lock_irq kernel/locking/lockdep.c:3973 [inline]
 mark_lock.cold+0x6f/0x74 kernel/locking/lockdep.c:4408
 mark_usage kernel/locking/lockdep.c:4311 [inline]
 __lock_acquire+0x11f5/0x5590 kernel/locking/lockdep.c:4791
 lock_acquire kernel/locking/lockdep.c:5442 [inline]
 lock_acquire+0x219/0x9d0 kernel/locking/lockdep.c:5407
 __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
 _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
 send_sigurg+0x1e/0xac0 fs/fcntl.c:824
 sk_send_sigurg+0x76/0x300 net/core/sock.c:2925
 tcp_check_urg.isra.0+0x1f4/0x710 net/ipv4/tcp_input.c:5489
 tcp_urg net/ipv4/tcp_input.c:5530 [inline]
 tcp_rcv_established+0x106c/0x1e40 net/ipv4/tcp_input.c:5862
 tcp_v4_do_rcv+0x5d1/0x870 net/ipv4/tcp_ipv4.c:1652
 sk_backlog_rcv include/net/sock.h:1010 [inline]
 __release_sock+0x134/0x3a0 net/core/sock.c:2523
 release_sock+0x54/0x1b0 net/core/sock.c:3053
 sk_stream_wait_memory+0x5bd/0xe60 net/core/stream.c:145
 tcp_sendmsg_locked+0x1034/0x2d30 net/ipv4/tcp.c:1402
 tcp_sendmsg+0x2b/0x40 net/ipv4/tcp.c:1442
 inet_sendmsg+0x99/0xe0 net/ipv4/af_inet.c:817
 sock_sendmsg_nosec net/socket.c:651 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:671
 __sys_sendto+0x21c/0x320 net/socket.c:1992
 __do_sys_sendto net/socket.c:2004 [inline]
 __se_sys_sendto net/socket.c:2000 [inline]
 __x64_sys_sendto+0xdd/0x1b0 net/socket.c:2000
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45de59
Code: 0d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fcfd761cc78 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 000000000002e880 RCX: 000000000045de59
RDX: ffffffffffffff58 RSI: 0000000020000140 RDI: 0000000000000003
RBP: 000000000118bf78 R08: 0000000020000100 R09: 0000000000000010
R10: 0000000020008005 R11: 0000000000000246 R12: 000000000118bf2c
R13: 000000000169fb7f R14: 00007fcfd761d9c0 R15: 000000000118bf2c


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
