Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5730527A8FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Sep 2020 09:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgI1Hsa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Sep 2020 03:48:30 -0400
Received: from mail-il1-f205.google.com ([209.85.166.205]:35150 "EHLO
        mail-il1-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgI1HsT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:48:19 -0400
Received: by mail-il1-f205.google.com with SMTP id f10so124480ilq.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2020 00:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=tnyl88/oaTLnBxy6nbX39sonvrvle4CZHUFURO/Gm3c=;
        b=sRtSXVBHimfI8JPiQjMJnOrrJbYYAdqCDEknwNfGQ/zhmtIuAfuqNBCpF+kNpibS9Y
         8/wauYaoJT5cVMfKyP91q+AZ5iDSL7Ky7w4H1MH55OkUr/pp68Xryp6IV+pC8W1afR+f
         z+a6J4+8yDXTBM58weQBOKTtue5ctDxTMR8fBZx2xPT4ohKXnpgtLxAI3paTnaHIy7VD
         iUtSF5EL/gi1MsmVF6NeTgEkGHrkWPWadyJftn/Fwyc+Xvp3xiokH+tRFYEteR1oz0MT
         UN1tMCX0zimuIfsWWuw5pOXH9dAmqokUnH38eMqFi24FyHPFW3H3XYV5T6hrpIx8EiJx
         jkyQ==
X-Gm-Message-State: AOAM532i+RDo+Euez3c4HEQJxxPoHHCaigz//5csafADp+6gsu59FPyQ
        WREGDsf5tzCCcCH2RSrfnv4bbj1TW/Jq8CGhovsyGbVae2aF
X-Google-Smtp-Source: ABdhPJwHEH6KPjAbMX9kltlOp50V/9wjdhq5UeVisqWbh2J2IZWEzgkiOdwbfakI8HvvhWyXcZzJwexLSedxt1BRfdKj/ZcQhis3
MIME-Version: 1.0
X-Received: by 2002:a92:845c:: with SMTP id l89mr159295ild.114.1601279298071;
 Mon, 28 Sep 2020 00:48:18 -0700 (PDT)
Date:   Mon, 28 Sep 2020 00:48:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bf710a05b05ae3f6@google.com>
Subject: possible deadlock in f_getown
From:   syzbot <syzbot+8073030e235a5a84dd31@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d1d2220c Add linux-next specific files for 20200924
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=174e41e3900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=254e028a642027c
dashboard link: https://syzkaller.appspot.com/bug?extid=8073030e235a5a84dd31
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8073030e235a5a84dd31@syzkaller.appspotmail.com

========================================================
WARNING: possible irq lock inversion dependency detected
5.9.0-rc6-next-20200924-syzkaller #0 Not tainted
--------------------------------------------------------
syz-executor.4/18922 just changed the state of lock:
ffff888092938e38 (&f->f_owner.lock){.+..}-{2:2}, at: f_getown+0x1b/0xb0 fs/fcntl.c:152
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

no locks held by syz-executor.4/18922.

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
                          asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:786
                          __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
                          run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
                          handle_irq arch/x86/kernel/irq.c:230 [inline]
                          __common_interrupt arch/x86/kernel/irq.c:249 [inline]
                          common_interrupt+0x115/0x1f0 arch/x86/kernel/irq.c:239
                          asm_common_interrupt+0x1e/0x40 arch/x86/include/asm/idtentry.h:622
                          arch_local_irq_restore arch/x86/include/asm/paravirt.h:653 [inline]
                          __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
                          _raw_spin_unlock_irqrestore+0x4d/0x90 kernel/locking/spinlock.c:191
                          spin_unlock_irqrestore include/linux/spinlock.h:409 [inline]
                          get_random_u64+0xf0/0x1f0 drivers/char/random.c:2207
                          get_random_long include/linux/random.h:61 [inline]
                          get_random_canary include/linux/random.h:83 [inline]
                          dup_task_struct kernel/fork.c:909 [inline]
                          copy_process+0xb35/0x6e70 kernel/fork.c:1935
                          kernel_clone+0xe5/0xae0 kernel/fork.c:2449
                          kernel_thread+0xb5/0xf0 kernel/fork.c:2501
                          call_usermodehelper_exec_work kernel/umh.c:163 [inline]
                          call_usermodehelper_exec_work+0xcc/0x180 kernel/umh.c:149
                          process_one_work+0x933/0x15a0 kernel/workqueue.c:2269
                          worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
                          kthread+0x3af/0x4a0 kernel/kthread.c:292
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
                         led_classdev_register_ext+0x511/0x6a0 drivers/leds/led-class.c:412
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
    ... key      at: [<ffffffff8e5f3e60>] __key.5+0x0/0x40
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
   ... key      at: [<ffffffff8e5f4360>] __key.4+0x0/0x40
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

 -> (&new->fa_lock){....}-{2:2} {
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
CPU: 1 PID: 18922 Comm: syz-executor.4 Not tainted 5.9.0-rc6-next-20200924-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
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
 _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
 f_getown+0x1b/0xb0 fs/fcntl.c:152
 sock_ioctl+0x545/0x770 net/socket.c:1132
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45e179
Code: 3d b2 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 0b b2 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fca63ebfc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000001f880 RCX: 000000000045e179
RDX: 0000000000000000 RSI: 0000000000008903 RDI: 0000000000000004
RBP: 000000000118cf80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118cf4c
R13: 00007ffcd04670ef R14: 00007fca63ec09c0 R15: 000000000118cf4c
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
