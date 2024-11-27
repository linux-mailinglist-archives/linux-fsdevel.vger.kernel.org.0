Return-Path: <linux-fsdevel+bounces-35964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 422BA9DA40D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 09:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F185E284AAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 08:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436F6189919;
	Wed, 27 Nov 2024 08:41:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBAC15E5CA
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 08:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732696890; cv=none; b=OoflUF0NrSflKHTPPv9Sf1uhqQaRMSjjVYmYI2btbOiUpiqBbGzSdzhQ6RlXdDuIBgE+PIVEWn9tevzXkg6UePQyWI3lY14BkMBuwTGyCVS/TdwPFX/IVbKYhhOHIfgCOP7tsO6Dpsm4QpYkomP0Nh3ci2GzYmwIeEjJvYaug44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732696890; c=relaxed/simple;
	bh=MkY4YRgn5gmBtFwvPAY6CBz1RmDdA7gfqUPKkFiqNa0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MD1OlVvK77YbIHojReFh61Mh8nw8nSD6/rr3Dl5WtnCsZnc7yK0gblKRR/iHzDakXnvbsCG0A6DoQmWkVR3QnlEIz9bDzZIb3rjMM4gj+5OlxzBA8tz6phqT5EGgIvdB4nynDAwbAPFbwM2RYgHibwKtO8xrrlfepOEiKRzcVRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83e5dc9f6a4so51585939f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 00:41:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732696886; x=1733301686;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=437GFNEDXtFj2HfB0LEp3YeJA7vVQPcE4C8ab+/P4ww=;
        b=TNAk/2oZDHBSy+dfTpwJJiEmwrOwXHAhdvGCl54ATn6W1Ug93EiUYWOg97kkF5d2bE
         72Zs6FY3mjbcdtfwpyHJY+Thl+xATewUJJ0nqABt407B6Zl6GYo63pDXBUi5hFQyPSdI
         mN5Rho2YwjLBydEM7A5s1NEaAC6NfCd9B+1Tk4lvcL4Nsl8zhxrjC9CvQoN60BRlWqyk
         CF2ZKqAje4c2qaENn4VSXur3bbEMuWKQPuQTlZnrwLucT37+5WIsdLbYvwyG2mBxjhWq
         m1wrTlqzhZSG3ZfjaEpmghzPdsnmp+tT8cW9CjHBdM7tGfSyxtHkrNzvk4K2IgG2Olvq
         9eAA==
X-Forwarded-Encrypted: i=1; AJvYcCV5uQOF9nbasfxtKP8zwocOk1cHwWios89e2rf0tXZkFG0B8Jlzn/3DiqUWEdmP/HA6dhwL9k7L5y/QzHnd@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+HlYY/y/O6OgSA511Sp1iPMco7wJZ6uRRbmp/ZHbhDahPX0fs
	swZINwXSJaXBaJdVfHx1PRzndWZ/1O45Wl2pAB7tNq852TOp49wwL3zJA1MdAxtiCEJmzoG7ByX
	77p82Crl4AazxWtpXSTtBgcgWY3oBaqcWD0ufVtWmVTf0oJcPv+6DDio=
X-Google-Smtp-Source: AGHT+IGn8zxVEx7zRs9oxJ1qIP4YpIVAWlRtWIuj3TteSm2fBbx1rKiKCZKUYDXzVNQaxdhzT8Css0HYsoS5mTg6B1ZuBy4WfCod
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184d:b0:3a7:a9ca:6169 with SMTP id
 e9e14a558f8ab-3a7c51f7b09mr18799775ab.5.1732696885987; Wed, 27 Nov 2024
 00:41:25 -0800 (PST)
Date: Wed, 27 Nov 2024 00:41:25 -0800
In-Reply-To: <66f6c8ce.050a0220.46d20.001c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6746db35.050a0220.1286eb.002d.GAE@google.com>
Subject: Re: [syzbot] [fs?] possible deadlock in input_inject_event
From: syzbot <syzbot+79c403850e6816dc39cf@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, amir73il@gmail.com, brauner@kernel.org, 
	chuck.lever@oracle.com, jack@suse.cz, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    7eef7e306d3c Merge tag 'for-6.13/dm-changes' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c07778580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8df9bf3383f5970
dashboard link: https://syzkaller.appspot.com/bug?extid=79c403850e6816dc39cf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13bfd530580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ea7fc4bd274d/disk-7eef7e30.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2b75212b0174/vmlinux-7eef7e30.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f1ab50706485/bzImage-7eef7e30.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+79c403850e6816dc39cf@syzkaller.appspotmail.com

=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
6.12.0-syzkaller-09567-g7eef7e306d3c #0 Not tainted
-----------------------------------------------------
syz.0.15/6015 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffff88807770f018 (&new->fa_lock){....}-{3:3}, at: kill_fasync_rcu fs/fcntl.c:1121 [inline]
ffff88807770f018 (&new->fa_lock){....}-{3:3}, at: kill_fasync+0x199/0x4f0 fs/fcntl.c:1145

and this task is already holding:
ffff888032183028 (&client->buffer_lock){....}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff888032183028 (&client->buffer_lock){....}-{3:3}, at: evdev_pass_values+0xf2/0xad0 drivers/input/evdev.c:261
which would create a new lock dependency:
 (&client->buffer_lock){....}-{3:3} -> (&new->fa_lock){....}-{3:3}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (&dev->event_lock#2){..-.}-{3:3}

... which became SOFTIRQ-irq-safe at:
  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
  input_inject_event+0xc5/0x340 drivers/input/input.c:423
  led_trigger_event+0x138/0x210 drivers/leds/led-triggers.c:407
  kbd_propagate_led_state drivers/tty/vt/keyboard.c:1080 [inline]
  kbd_bh+0x1b5/0x290 drivers/tty/vt/keyboard.c:1269
  tasklet_action_common+0x426/0x620 kernel/softirq.c:804
  handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
  run_ksoftirqd+0xca/0x130 kernel/softirq.c:943
  smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
  kthread+0x2f0/0x390 kernel/kthread.c:389
  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

to a SOFTIRQ-irq-unsafe lock:
 (tasklist_lock){.+.+}-{3:3}

... which became SOFTIRQ-irq-unsafe at:
...
  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
  __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
  _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
  __do_wait+0x12d/0x850 kernel/exit.c:1647
  do_wait+0x1e9/0x560 kernel/exit.c:1691
  kernel_wait+0xe9/0x240 kernel/exit.c:1867
  call_usermodehelper_exec_sync kernel/umh.c:136 [inline]
  call_usermodehelper_exec_work+0xbd/0x230 kernel/umh.c:163
  process_one_work kernel/workqueue.c:3229 [inline]
  process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
  kthread+0x2f0/0x390 kernel/kthread.c:389
  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  &dev->event_lock#2 --> &client->buffer_lock --> tasklist_lock

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(tasklist_lock);
                               local_irq_disable();
                               lock(&dev->event_lock#2);
                               lock(&client->buffer_lock);
  <Interrupt>
    lock(&dev->event_lock#2);

 *** DEADLOCK ***

7 locks held by syz.0.15/6015:
 #0: ffff88802a001118 (&evdev->mutex){+.+.}-{4:4}, at: evdev_write+0x25e/0x790 drivers/input/evdev.c:511
 #1: ffff888020738230 (&dev->event_lock#2){..-.}-{3:3}, at: input_inject_event+0xc5/0x340 drivers/input/input.c:423
 #2: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #2: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #2: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: input_inject_event+0xd6/0x340 drivers/input/input.c:425
 #3: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #3: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #3: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: input_pass_values+0x8e/0x890 drivers/input/input.c:118
 #4: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #4: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #4: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: evdev_events+0x6f/0x300 drivers/input/evdev.c:298
 #5: ffff888032183028 (&client->buffer_lock){....}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #5: ffff888032183028 (&client->buffer_lock){....}-{3:3}, at: evdev_pass_values+0xf2/0xad0 drivers/input/evdev.c:261
 #6: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #6: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #6: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: kill_fasync+0x54/0x4f0 fs/fcntl.c:1144

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
 -> (&dev->event_lock#2){..-.}-{3:3} {
    IN-SOFTIRQ-W at:
                      lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
                      __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                      _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                      input_inject_event+0xc5/0x340 drivers/input/input.c:423
                      led_trigger_event+0x138/0x210 drivers/leds/led-triggers.c:407
                      kbd_propagate_led_state drivers/tty/vt/keyboard.c:1080 [inline]
                      kbd_bh+0x1b5/0x290 drivers/tty/vt/keyboard.c:1269
                      tasklet_action_common+0x426/0x620 kernel/softirq.c:804
                      handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
                      run_ksoftirqd+0xca/0x130 kernel/softirq.c:943
                      smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
                      kthread+0x2f0/0x390 kernel/kthread.c:389
                      ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                      ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
    INITIAL USE at:
                     lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
                     __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                     _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                     input_inject_event+0xc5/0x340 drivers/input/input.c:423
                     kbd_led_trigger_activate+0xb8/0x100 drivers/tty/vt/keyboard.c:1036
                     led_trigger_set+0x582/0x9c0 drivers/leds/led-triggers.c:212
                     led_match_default_trigger drivers/leds/led-triggers.c:269 [inline]
                     led_trigger_set_default+0x229/0x260 drivers/leds/led-triggers.c:287
                     led_classdev_register_ext+0x732/0x8e0 drivers/leds/led-class.c:566
                     led_classdev_register include/linux/leds.h:274 [inline]
                     input_leds_connect+0x489/0x630 drivers/input/input-leds.c:145
                     input_attach_handler drivers/input/input.c:1032 [inline]
                     input_register_device+0xd3b/0x1110 drivers/input/input.c:2475
                     atkbd_connect+0x762/0xa20 drivers/input/keyboard/atkbd.c:1340
                     serio_connect_driver drivers/input/serio/serio.c:43 [inline]
                     serio_driver_probe+0x7f/0xa0 drivers/input/serio/serio.c:747
                     really_probe+0x2b8/0xad0 drivers/base/dd.c:658
                     __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
                     driver_probe_device+0x50/0x430 drivers/base/dd.c:830
                     __driver_attach+0x45f/0x710 drivers/base/dd.c:1216
                     bus_for_each_dev+0x239/0x2b0 drivers/base/bus.c:370
                     serio_attach_driver drivers/input/serio/serio.c:776 [inline]
                     serio_handle_event+0x1c7/0x920 drivers/input/serio/serio.c:213
                     process_one_work kernel/workqueue.c:3229 [inline]
                     process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
                     worker_thread+0x870/0xd30 kernel/workqueue.c:3391
                     kthread+0x2f0/0x390 kernel/kthread.c:389
                     ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                     ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
  }
  ... key      at: [<ffffffff9a771300>] input_allocate_device.__key.5+0x0/0x20
-> (&client->buffer_lock){....}-{3:3} {
   INITIAL USE at:
                   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
                   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                   _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                   spin_lock include/linux/spinlock.h:351 [inline]
                   evdev_pass_values+0xf2/0xad0 drivers/input/evdev.c:261
                   evdev_events+0x1c2/0x300 drivers/input/evdev.c:306
                   input_pass_values+0x268/0x890 drivers/input/input.c:126
                   input_event_dispose+0x30f/0x600 drivers/input/input.c:341
                   input_handle_event+0xa71/0xbe0 drivers/input/input.c:369
                   input_inject_event+0x22f/0x340 drivers/input/input.c:428
                   evdev_write+0x5fd/0x790 drivers/input/evdev.c:528
                   vfs_write+0x2a3/0xd30 fs/read_write.c:677
                   ksys_write+0x18f/0x2b0 fs/read_write.c:731
                   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
                   entry_SYSCALL_64_after_hwframe+0x77/0x7f
 }
 ... key      at: [<ffffffff9a7715a0>] evdev_open.__key.24+0x0/0x20
 ... acquired at:
   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
   _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
   spin_lock include/linux/spinlock.h:351 [inline]
   evdev_pass_values+0xf2/0xad0 drivers/input/evdev.c:261
   evdev_events+0x1c2/0x300 drivers/input/evdev.c:306
   input_pass_values+0x268/0x890 drivers/input/input.c:126
   input_event_dispose+0x30f/0x600 drivers/input/input.c:341
   input_handle_event+0xa71/0xbe0 drivers/input/input.c:369
   input_inject_event+0x22f/0x340 drivers/input/input.c:428
   evdev_write+0x5fd/0x790 drivers/input/evdev.c:528
   vfs_write+0x2a3/0xd30 fs/read_write.c:677
   ksys_write+0x18f/0x2b0 fs/read_write.c:731
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f


the dependencies between the lock to be acquired
 and SOFTIRQ-irq-unsafe lock:
  -> (tasklist_lock){.+.+}-{3:3} {
     HARDIRQ-ON-R at:
                        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
                        __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                        _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                        __do_wait+0x12d/0x850 kernel/exit.c:1647
                        do_wait+0x1e9/0x560 kernel/exit.c:1691
                        kernel_wait+0xe9/0x240 kernel/exit.c:1867
                        call_usermodehelper_exec_sync kernel/umh.c:136 [inline]
                        call_usermodehelper_exec_work+0xbd/0x230 kernel/umh.c:163
                        process_one_work kernel/workqueue.c:3229 [inline]
                        process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
                        worker_thread+0x870/0xd30 kernel/workqueue.c:3391
                        kthread+0x2f0/0x390 kernel/kthread.c:389
                        ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
     SOFTIRQ-ON-R at:
                        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
                        __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                        _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                        __do_wait+0x12d/0x850 kernel/exit.c:1647
                        do_wait+0x1e9/0x560 kernel/exit.c:1691
                        kernel_wait+0xe9/0x240 kernel/exit.c:1867
                        call_usermodehelper_exec_sync kernel/umh.c:136 [inline]
                        call_usermodehelper_exec_work+0xbd/0x230 kernel/umh.c:163
                        process_one_work kernel/workqueue.c:3229 [inline]
                        process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
                        worker_thread+0x870/0xd30 kernel/workqueue.c:3391
                        kthread+0x2f0/0x390 kernel/kthread.c:389
                        ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
     INITIAL USE at:
                       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
                       __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                       _raw_write_lock_irq+0xd3/0x120 kernel/locking/spinlock.c:326
                       copy_process+0x2267/0x3d50 kernel/fork.c:2503
                       kernel_clone+0x223/0x880 kernel/fork.c:2787
                       user_mode_thread+0x132/0x1a0 kernel/fork.c:2865
                       rest_init+0x23/0x300 init/main.c:712
                       start_kernel+0x47f/0x500 init/main.c:1102
                       x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
                       x86_64_start_kernel+0x9f/0xa0 arch/x86/kernel/head64.c:488
                       common_startup_64+0x13e/0x147
     INITIAL READ USE at:
                            lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
                            __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                            _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                            __do_wait+0x12d/0x850 kernel/exit.c:1647
                            do_wait+0x1e9/0x560 kernel/exit.c:1691
                            kernel_wait+0xe9/0x240 kernel/exit.c:1867
                            call_usermodehelper_exec_sync kernel/umh.c:136 [inline]
                            call_usermodehelper_exec_work+0xbd/0x230 kernel/umh.c:163
                            process_one_work kernel/workqueue.c:3229 [inline]
                            process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
                            worker_thread+0x870/0xd30 kernel/workqueue.c:3391
                            kthread+0x2f0/0x390 kernel/kthread.c:389
                            ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                            ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
   }
   ... key      at: [<ffffffff8e60b058>] tasklist_lock+0x18/0x40
   ... acquired at:
   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
   __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
   _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
   send_sigio+0x108/0x390 fs/fcntl.c:918
   kill_fasync_rcu fs/fcntl.c:1130 [inline]
   kill_fasync+0x256/0x4f0 fs/fcntl.c:1145
   lease_break_callback+0x26/0x30 fs/locks.c:558
   __break_lease+0x6d5/0x1820 fs/locks.c:1592
   vfs_truncate+0x26b/0x3b0 fs/open.c:105
   do_sys_truncate+0xdb/0x190 fs/open.c:134
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

 -> (&f_owner->lock){....}-{3:3} {
    INITIAL USE at:
                     lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
                     __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                     _raw_write_lock_irq+0xd3/0x120 kernel/locking/spinlock.c:326
                     __f_setown+0x6b/0x380 fs/fcntl.c:136
                     generic_add_lease fs/locks.c:1874 [inline]
                     generic_setlease+0xc74/0x1550 fs/locks.c:1942
                     do_fcntl_add_lease fs/locks.c:2047 [inline]
                     fcntl_setlease+0x404/0x540 fs/locks.c:2069
                     do_fcntl+0x6c6/0x1a80 fs/fcntl.c:533
                     __do_sys_fcntl fs/fcntl.c:588 [inline]
                     __se_sys_fcntl+0xd2/0x1e0 fs/fcntl.c:573
                     do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                     do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
                     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    INITIAL READ USE at:
                          lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
                          __raw_read_lock_irq include/linux/rwlock_api_smp.h:169 [inline]
                          _raw_read_lock_irq+0xda/0x120 kernel/locking/spinlock.c:244
                          f_getown+0x55/0x2a0 fs/fcntl.c:204
                          sock_ioctl+0x498/0x8e0 net/socket.c:1275
                          vfs_ioctl fs/ioctl.c:51 [inline]
                          __do_sys_ioctl fs/ioctl.c:906 [inline]
                          __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
                          do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                          do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
                          entry_SYSCALL_64_after_hwframe+0x77/0x7f
  }
  ... key      at: [<ffffffff9a461fc0>] file_f_owner_allocate.__key+0x0/0x20
  ... acquired at:
   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0xdd/0x130 kernel/locking/spinlock.c:236
   send_sigio+0x37/0x390 fs/fcntl.c:904
   kill_fasync_rcu fs/fcntl.c:1130 [inline]
   kill_fasync+0x256/0x4f0 fs/fcntl.c:1145
   lease_break_callback+0x26/0x30 fs/locks.c:558
   __break_lease+0x6d5/0x1820 fs/locks.c:1592
   vfs_truncate+0x26b/0x3b0 fs/open.c:105
   do_sys_truncate+0xdb/0x190 fs/open.c:134
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> (&new->fa_lock){....}-{3:3} {
   INITIAL READ USE at:
                        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
                        __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
                        _raw_read_lock_irqsave+0xdd/0x130 kernel/locking/spinlock.c:236
                        kill_fasync_rcu fs/fcntl.c:1121 [inline]
                        kill_fasync+0x199/0x4f0 fs/fcntl.c:1145
                        lease_break_callback+0x26/0x30 fs/locks.c:558
                        __break_lease+0x6d5/0x1820 fs/locks.c:1592
                        vfs_truncate+0x26b/0x3b0 fs/open.c:105
                        do_sys_truncate+0xdb/0x190 fs/open.c:134
                        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                        do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
                        entry_SYSCALL_64_after_hwframe+0x77/0x7f
 }
 ... key      at: [<ffffffff9a461fe0>] fasync_insert_entry.__key+0x0/0x20
 ... acquired at:
   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0xdd/0x130 kernel/locking/spinlock.c:236
   kill_fasync_rcu fs/fcntl.c:1121 [inline]
   kill_fasync+0x199/0x4f0 fs/fcntl.c:1145
   __pass_event drivers/input/evdev.c:240 [inline]
   evdev_pass_values+0x58a/0xad0 drivers/input/evdev.c:278
   evdev_events+0x1c2/0x300 drivers/input/evdev.c:306
   input_pass_values+0x268/0x890 drivers/input/input.c:126
   input_event_dispose+0x30f/0x600 drivers/input/input.c:341
   input_handle_event+0xa71/0xbe0 drivers/input/input.c:369
   input_inject_event+0x22f/0x340 drivers/input/input.c:428
   evdev_write+0x5fd/0x790 drivers/input/evdev.c:528
   vfs_write+0x2a3/0xd30 fs/read_write.c:677
   ksys_write+0x18f/0x2b0 fs/read_write.c:731
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f


stack backtrace:
CPU: 0 UID: 0 PID: 6015 Comm: syz.0.15 Not tainted 6.12.0-syzkaller-09567-g7eef7e306d3c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_bad_irq_dependency kernel/locking/lockdep.c:2647 [inline]
 check_irq_usage kernel/locking/lockdep.c:2888 [inline]
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x4ebd/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
 _raw_read_lock_irqsave+0xdd/0x130 kernel/locking/spinlock.c:236
 kill_fasync_rcu fs/fcntl.c:1121 [inline]
 kill_fasync+0x199/0x4f0 fs/fcntl.c:1145
 __pass_event drivers/input/evdev.c:240 [inline]
 evdev_pass_values+0x58a/0xad0 drivers/input/evdev.c:278
 evdev_events+0x1c2/0x300 drivers/input/evdev.c:306
 input_pass_values+0x268/0x890 drivers/input/input.c:126
 input_event_dispose+0x30f/0x600 drivers/input/input.c:341
 input_handle_event+0xa71/0xbe0 drivers/input/input.c:369
 input_inject_event+0x22f/0x340 drivers/input/input.c:428
 evdev_write+0x5fd/0x790 drivers/input/evdev.c:528
 vfs_write+0x2a3/0xd30 fs/read_write.c:677
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f773f380809
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f77401d2058 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f773f546080 RCX: 00007f773f380809
RDX: 0000000000001068 RSI: 0000000020000040 RDI: 0000000000000009
RBP: 00007f773f3f393e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f773f546080 R15: 00007ffc372f3228
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

