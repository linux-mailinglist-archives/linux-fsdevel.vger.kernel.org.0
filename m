Return-Path: <linux-fsdevel+bounces-30260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5827C9887D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 17:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061A8280CDA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 15:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB37818C321;
	Fri, 27 Sep 2024 15:01:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E4F39AD6
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727449298; cv=none; b=kwzdrXx5Dm6i4WAPCMLqtZhMfuewYvIGsKjXbkSxMZYc71F9EfaI6gxIDduyHLYil/BQk1VBOk/DVxKg6m0wZrpKHpSPZcOVi3EwLv93KDY90g5rJYeiaF3Vt7/9yJaaPh7aZCC92uvcKL8wsWrjJqpBpV7m33+Kfj3U1+1fydY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727449298; c=relaxed/simple;
	bh=WkOk7wyxfbJ8MauTbHuU9BCQ2NXoSNLjHZIUEpZFfTs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GQhDar1GgxXWXfp8M0sMU1THg/z9q7WTcpG8BK5V5sxrdXACqL+EW/WuBEwmgafSOuf4Lmfa5WhIhKo/Kv0PSy2N23OVICmp6+zD0bguGUh8RasCWtRORsdDuJg+02GDVw6HFkf5iocudPT4j8MBRTU4wsF37PE4ZFVUsEfGZSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a0ce8cf657so27732745ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 08:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727449295; x=1728054095;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S4pn7NMkZqvFwvxNLFRYJPLnSNkD0TmIFRfVENb7Jto=;
        b=GxoI+BlmZ19Lp1ByOgzR/Itg1mLG2zEjHX5ZOB++NJtjANcgQrSdc7GNgGUh9aHsdo
         uxnFDnKjTz0ot8lOf3hmOwwcZRMWuwpp1KSxiJBgPJDL+RsH0K8H3FzXcnlncba6Kdkh
         lNwZWFs1u49aImdiF1fTsbuK9tnyAxbrdI8UbkcjFIIHqQqgkCdMAvaDaB1hJj8NT0vh
         QHkUmfLzt/atS8XSbH8W9DG9KKlk71IyBelMr0LXtib7iC1CMFustg21qduFbMA/mcBW
         1SmPbMHVpqeDLUPP1AKoIWILDFluyiesMFJiLMbtpTX+rYFoDJsxGxAwsGPVrwqSNnWF
         c5Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUlfUh6z5Nc5x7xeeXsnv1KhL4QBZKDJv/oT0KdkaQbXLMIdqPBWZbBKscg5tkJPaUBNe8NEho6bxW3CmHi@vger.kernel.org
X-Gm-Message-State: AOJu0YwrwQUDEB7FwItYuE/jmKGiB0I6qJbypNYIcqG613jq3MBx+yeH
	aL3WZ7B1slrBRNaHUzLo0fiuBdtUv9IIsIEVvWqXFpEoerc7yOzLd46cvxPc/roIdPx4Fkg8EOa
	uFdoW5CIpbc5AP1/Vvf5nHf7PcSpq8ub4NTrcbIFacC4v9ySc5lEDBXs=
X-Google-Smtp-Source: AGHT+IHUYOFLc6m73UNyjCtErafg84GMmM31XdFe/d/HChTw1gdNKqT0llBc0y45KUsSGqtbxGhoqaVYkGE7kHkvi9Jf1cLpZX8u
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1948:b0:3a1:a759:b3c0 with SMTP id
 e9e14a558f8ab-3a34517160emr37094595ab.8.1727449294728; Fri, 27 Sep 2024
 08:01:34 -0700 (PDT)
Date: Fri, 27 Sep 2024 08:01:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f6c8ce.050a0220.46d20.001c.GAE@google.com>
Subject: [syzbot] [fs?] possible deadlock in input_inject_event
From: syzbot <syzbot+79c403850e6816dc39cf@syzkaller.appspotmail.com>
To: amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2a17bb8c204f Merge tag 'devicetree-for-6.12' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15953b00580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c208b3605ba9ec44
dashboard link: https://syzkaller.appspot.com/bug?extid=79c403850e6816dc39cf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/940305284b35/disk-2a17bb8c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7ae2e1a8e92e/vmlinux-2a17bb8c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/414282d3b1f3/bzImage-2a17bb8c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+79c403850e6816dc39cf@syzkaller.appspotmail.com

=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
6.11.0-syzkaller-05591-g2a17bb8c204f #0 Not tainted
-----------------------------------------------------
syz.4.5212/19229 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffff88807f685da0 (&f_owner->lock){....}-{2:2}, at: send_sigio+0x37/0x390 fs/fcntl.c:910

and this task is already holding:
ffff88807f3b9750 (&new->fa_lock){...-}-{2:2}, at: kill_fasync_rcu fs/fcntl.c:1127 [inline]
ffff88807f3b9750 (&new->fa_lock){...-}-{2:2}, at: kill_fasync+0x199/0x4f0 fs/fcntl.c:1151
which would create a new lock dependency:
 (&new->fa_lock){...-}-{2:2} -> (&f_owner->lock){....}-{2:2}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (&dev->event_lock#2){..-.}-{2:2}

... which became SOFTIRQ-irq-safe at:
  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
  input_inject_event+0xc5/0x340 drivers/input/input.c:423
  kd_sound_helper+0x101/0x210 drivers/tty/vt/keyboard.c:256
  input_handler_for_each_handle+0x105/0x1d0 drivers/input/input.c:2676
  call_timer_fn+0x190/0x650 kernel/time/timer.c:1794
  expire_timers kernel/time/timer.c:1845 [inline]
  __run_timers kernel/time/timer.c:2419 [inline]
  __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2430
  run_timer_base kernel/time/timer.c:2439 [inline]
  run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2449
  handle_softirqs+0x2c7/0x980 kernel/softirq.c:554
  __do_softirq kernel/softirq.c:588 [inline]
  invoke_softirq kernel/softirq.c:428 [inline]
  __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
  irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1037 [inline]
  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1037
  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
  __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:160 [inline]
  _raw_spin_unlock_irq+0x29/0x50 kernel/locking/spinlock.c:202
  spin_unlock_irq include/linux/spinlock.h:401 [inline]
  filemap_remove_folio+0x110/0x2e0 mm/filemap.c:265
  truncate_inode_folio+0x5d/0x70 mm/truncate.c:178
  shmem_undo_range+0x45d/0x1df0 mm/shmem.c:1019
  shmem_truncate_range mm/shmem.c:1132 [inline]
  shmem_evict_inode+0x29b/0xa80 mm/shmem.c:1260
  evict+0x4ea/0x9b0 fs/inode.c:731
  __dentry_kill+0x20d/0x630 fs/dcache.c:615
  dput+0x19f/0x2b0 fs/dcache.c:857
  __fput+0x5d2/0x880 fs/file_table.c:439
  task_work_run+0x251/0x310 kernel/task_work.c:228
  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
  syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
  do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
  entry_SYSCALL_64_after_hwframe+0x77/0x7f

to a SOFTIRQ-irq-unsafe lock:
 (tasklist_lock){.+.+}-{2:2}

... which became SOFTIRQ-irq-unsafe at:
...
  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
  __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
  _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
  __do_wait+0x12d/0x850 kernel/exit.c:1591
  do_wait+0x1e9/0x560 kernel/exit.c:1635
  kernel_wait+0xe9/0x240 kernel/exit.c:1811
  call_usermodehelper_exec_sync kernel/umh.c:137 [inline]
  call_usermodehelper_exec_work+0xbd/0x230 kernel/umh.c:164
  process_one_work kernel/workqueue.c:3229 [inline]
  process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
  kthread+0x2f2/0x390 kernel/kthread.c:389
  ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  &dev->event_lock#2 --> &new->fa_lock --> tasklist_lock

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(tasklist_lock);
                               local_irq_disable();
                               lock(&dev->event_lock#2);
                               lock(&new->fa_lock);
  <Interrupt>
    lock(&dev->event_lock#2);

 *** DEADLOCK ***

4 locks held by syz.4.5212/19229:
 #0: ffffffff8ea9b7f0 (file_rwsem){++++}-{0:0}, at: __break_lease+0x3b3/0x1820 fs/locks.c:1563
 #1: ffff8880266f4858 (&ctx->flc_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #1: ffff8880266f4858 (&ctx->flc_lock){+.+.}-{2:2}, at: __break_lease+0x3c0/0x1820 fs/locks.c:1564
 #2: ffffffff8e938b60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #2: ffffffff8e938b60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #2: ffffffff8e938b60 (rcu_read_lock){....}-{1:2}, at: kill_fasync+0x54/0x4f0 fs/fcntl.c:1150
 #3: ffff88807f3b9750 (&new->fa_lock){...-}-{2:2}, at: kill_fasync_rcu fs/fcntl.c:1127 [inline]
 #3: ffff88807f3b9750 (&new->fa_lock){...-}-{2:2}, at: kill_fasync+0x199/0x4f0 fs/fcntl.c:1151

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
 -> (&dev->event_lock#2){..-.}-{2:2} {
    IN-SOFTIRQ-W at:
                      lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
                      __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                      _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                      input_inject_event+0xc5/0x340 drivers/input/input.c:423
                      kd_sound_helper+0x101/0x210 drivers/tty/vt/keyboard.c:256
                      input_handler_for_each_handle+0x105/0x1d0 drivers/input/input.c:2676
                      call_timer_fn+0x190/0x650 kernel/time/timer.c:1794
                      expire_timers kernel/time/timer.c:1845 [inline]
                      __run_timers kernel/time/timer.c:2419 [inline]
                      __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2430
                      run_timer_base kernel/time/timer.c:2439 [inline]
                      run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2449
                      handle_softirqs+0x2c7/0x980 kernel/softirq.c:554
                      __do_softirq kernel/softirq.c:588 [inline]
                      invoke_softirq kernel/softirq.c:428 [inline]
                      __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
                      irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
                      instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1037 [inline]
                      sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1037
                      asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                      __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:160 [inline]
                      _raw_spin_unlock_irq+0x29/0x50 kernel/locking/spinlock.c:202
                      spin_unlock_irq include/linux/spinlock.h:401 [inline]
                      filemap_remove_folio+0x110/0x2e0 mm/filemap.c:265
                      truncate_inode_folio+0x5d/0x70 mm/truncate.c:178
                      shmem_undo_range+0x45d/0x1df0 mm/shmem.c:1019
                      shmem_truncate_range mm/shmem.c:1132 [inline]
                      shmem_evict_inode+0x29b/0xa80 mm/shmem.c:1260
                      evict+0x4ea/0x9b0 fs/inode.c:731
                      __dentry_kill+0x20d/0x630 fs/dcache.c:615
                      dput+0x19f/0x2b0 fs/dcache.c:857
                      __fput+0x5d2/0x880 fs/file_table.c:439
                      task_work_run+0x251/0x310 kernel/task_work.c:228
                      resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
                      exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
                      exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
                      __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
                      syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
                      do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
                      entry_SYSCALL_64_after_hwframe+0x77/0x7f
    INITIAL USE at:
                     lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
                     __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                     _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                     input_inject_event+0xc5/0x340 drivers/input/input.c:423
                     kbd_led_trigger_activate+0xb8/0x100 drivers/tty/vt/keyboard.c:1036
                     led_trigger_set+0x584/0x9c0 drivers/leds/led-triggers.c:212
                     led_match_default_trigger drivers/leds/led-triggers.c:269 [inline]
                     led_trigger_set_default+0x229/0x260 drivers/leds/led-triggers.c:287
                     led_classdev_register_ext+0x6e6/0x8a0 drivers/leds/led-class.c:555
                     led_classdev_register include/linux/leds.h:273 [inline]
                     input_leds_connect+0x489/0x630 drivers/input/input-leds.c:145
                     input_attach_handler drivers/input/input.c:1027 [inline]
                     input_register_device+0xd3d/0x1110 drivers/input/input.c:2470
                     atkbd_connect+0x752/0xa00 drivers/input/keyboard/atkbd.c:1342
                     serio_connect_driver drivers/input/serio/serio.c:44 [inline]
                     serio_driver_probe+0x81/0xa0 drivers/input/serio/serio.c:775
                     really_probe+0x2ba/0xad0 drivers/base/dd.c:657
                     __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:799
                     driver_probe_device+0x50/0x430 drivers/base/dd.c:829
                     __driver_attach+0x45f/0x710 drivers/base/dd.c:1215
                     bus_for_each_dev+0x23b/0x2b0 drivers/base/bus.c:368
                     serio_attach_driver drivers/input/serio/serio.c:804 [inline]
                     serio_handle_event+0x1c7/0x920 drivers/input/serio/serio.c:224
                     process_one_work kernel/workqueue.c:3229 [inline]
                     process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
                     worker_thread+0x870/0xd30 kernel/workqueue.c:3391
                     kthread+0x2f2/0x390 kernel/kthread.c:389
                     ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
                     ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
  }
  ... key      at: [<ffffffff9a71d6e0>] input_allocate_device.__key.5+0x0/0x20
-> (&new->fa_lock){...-}-{2:2} {
   IN-SOFTIRQ-R at:
                    lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
                    __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
                    _raw_read_lock_irqsave+0xdd/0x130 kernel/locking/spinlock.c:236
                    kill_fasync_rcu fs/fcntl.c:1127 [inline]
                    kill_fasync+0x199/0x4f0 fs/fcntl.c:1151
                    sock_wake_async+0x147/0x170
                    sk_wake_async_rcu include/net/sock.h:2450 [inline]
                    sock_def_readable+0x3df/0x5b0 net/core/sock.c:3444
                    __udp_enqueue_schedule_skb+0x81a/0xb20 net/ipv4/udp.c:1566
                    __udpv6_queue_rcv_skb net/ipv6/udp.c:658 [inline]
                    udpv6_queue_rcv_one_skb+0xa22/0x18a0 net/ipv6/udp.c:770
                    udp6_unicast_rcv_skb+0x230/0x370 net/ipv6/udp.c:928
                    ip6_protocol_deliver_rcu+0xccf/0x1580 net/ipv6/ip6_input.c:436
                    ip6_input_finish+0x187/0x2d0 net/ipv6/ip6_input.c:481
                    NF_HOOK+0x3a6/0x450 include/linux/netfilter.h:314
                    NF_HOOK+0x3a6/0x450 include/linux/netfilter.h:314
                    __netif_receive_skb_one_core net/core/dev.c:5662 [inline]
                    __netif_receive_skb+0x1ea/0x650 net/core/dev.c:5775
                    process_backlog+0x662/0x15b0 net/core/dev.c:6107
                    __napi_poll+0xcd/0x490 net/core/dev.c:6771
                    napi_poll net/core/dev.c:6840 [inline]
                    net_rx_action+0x89b/0x1240 net/core/dev.c:6962
                    handle_softirqs+0x2c7/0x980 kernel/softirq.c:554
                    do_softirq+0x11b/0x1e0 kernel/softirq.c:455
                    __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
                    local_bh_enable include/linux/bottom_half.h:33 [inline]
                    rcu_read_unlock_bh include/linux/rcupdate.h:919 [inline]
                    __dev_queue_xmit+0x1764/0x3e80 net/core/dev.c:4451
                    dev_queue_xmit include/linux/netdevice.h:3094 [inline]
                    neigh_hh_output include/net/neighbour.h:526 [inline]
                    neigh_output include/net/neighbour.h:540 [inline]
                    ip6_finish_output2+0xfc9/0x1730 net/ipv6/ip6_output.c:141
                    ip6_finish_output+0x41e/0x810 net/ipv6/ip6_output.c:226
                    ip6_send_skb+0x1b1/0x3b0 net/ipv6/ip6_output.c:1968
                    udp_v6_send_skb+0xbf5/0x1870 net/ipv6/udp.c:1292
                    udpv6_sendmsg+0x23b6/0x3270 net/ipv6/udp.c:1588
                    sock_sendmsg_nosec net/socket.c:730 [inline]
                    __sock_sendmsg+0xef/0x270 net/socket.c:745
                    __sys_sendto+0x398/0x4f0 net/socket.c:2210
                    __do_sys_sendto net/socket.c:2222 [inline]
                    __se_sys_sendto net/socket.c:2218 [inline]
                    __x64_sys_sendto+0xde/0x100 net/socket.c:2218
                    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                    do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
                    entry_SYSCALL_64_after_hwframe+0x77/0x7f
   INITIAL USE at:
                   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                   _raw_write_lock_irq+0xd3/0x120 kernel/locking/spinlock.c:326
                   fasync_remove_entry+0xff/0x1d0 fs/fcntl.c:1004
                   __fput+0x71d/0x880 fs/file_table.c:428
                   task_work_run+0x251/0x310 kernel/task_work.c:228
                   resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
                   exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
                   exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
                   __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
                   syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
                   do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
                   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   INITIAL READ USE at:
                        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
                        __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
                        _raw_read_lock_irqsave+0xdd/0x130 kernel/locking/spinlock.c:236
                        kill_fasync_rcu fs/fcntl.c:1127 [inline]
                        kill_fasync+0x199/0x4f0 fs/fcntl.c:1151
                        mousedev_notify_readers+0x719/0xc80 drivers/input/mousedev.c:309
                        mousedev_event+0x5d9/0x1390 drivers/input/mousedev.c:394
                        input_handler_events_default+0x109/0x1c0 drivers/input/input.c:2549
                        input_pass_values+0x288/0x860 drivers/input/input.c:126
                        input_event_dispose+0x30f/0x600 drivers/input/input.c:341
                        input_handle_event+0xa71/0xbe0 drivers/input/input.c:369
                        input_inject_event+0x22f/0x340 drivers/input/input.c:428
                        evdev_write+0x66f/0x7c0 drivers/input/evdev.c:521
                        vfs_write+0x29e/0xc90 fs/read_write.c:681
                        ksys_write+0x1a0/0x2c0 fs/read_write.c:736
                        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                        do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
                        entry_SYSCALL_64_after_hwframe+0x77/0x7f
 }
 ... key      at: [<ffffffff9a40dcc0>] fasync_insert_entry.__key+0x0/0x20
 ... acquired at:
   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0xdd/0x130 kernel/locking/spinlock.c:236
   kill_fasync_rcu fs/fcntl.c:1127 [inline]
   kill_fasync+0x199/0x4f0 fs/fcntl.c:1151
   mousedev_notify_readers+0x719/0xc80 drivers/input/mousedev.c:309
   mousedev_event+0x5d9/0x1390 drivers/input/mousedev.c:394
   input_handler_events_default+0x109/0x1c0 drivers/input/input.c:2549
   input_pass_values+0x288/0x860 drivers/input/input.c:126
   input_event_dispose+0x30f/0x600 drivers/input/input.c:341
   input_handle_event+0xa71/0xbe0 drivers/input/input.c:369
   input_inject_event+0x22f/0x340 drivers/input/input.c:428
   evdev_write+0x66f/0x7c0 drivers/input/evdev.c:521
   vfs_write+0x29e/0xc90 fs/read_write.c:681
   ksys_write+0x1a0/0x2c0 fs/read_write.c:736
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f


the dependencies between the lock to be acquired
 and SOFTIRQ-irq-unsafe lock:
 -> (tasklist_lock){.+.+}-{2:2} {
    HARDIRQ-ON-R at:
                      lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
                      __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                      _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                      __do_wait+0x12d/0x850 kernel/exit.c:1591
                      do_wait+0x1e9/0x560 kernel/exit.c:1635
                      kernel_wait+0xe9/0x240 kernel/exit.c:1811
                      call_usermodehelper_exec_sync kernel/umh.c:137 [inline]
                      call_usermodehelper_exec_work+0xbd/0x230 kernel/umh.c:164
                      process_one_work kernel/workqueue.c:3229 [inline]
                      process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
                      worker_thread+0x870/0xd30 kernel/workqueue.c:3391
                      kthread+0x2f2/0x390 kernel/kthread.c:389
                      ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
                      ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
    SOFTIRQ-ON-R at:
                      lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
                      __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                      _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                      __do_wait+0x12d/0x850 kernel/exit.c:1591
                      do_wait+0x1e9/0x560 kernel/exit.c:1635
                      kernel_wait+0xe9/0x240 kernel/exit.c:1811
                      call_usermodehelper_exec_sync kernel/umh.c:137 [inline]
                      call_usermodehelper_exec_work+0xbd/0x230 kernel/umh.c:164
                      process_one_work kernel/workqueue.c:3229 [inline]
                      process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
                      worker_thread+0x870/0xd30 kernel/workqueue.c:3391
                      kthread+0x2f2/0x390 kernel/kthread.c:389
                      ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
                      ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
    INITIAL USE at:
                     lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
                     __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                     _raw_write_lock_irq+0xd3/0x120 kernel/locking/spinlock.c:326
                     copy_process+0x224b/0x3d80 kernel/fork.c:2499
                     kernel_clone+0x226/0x8f0 kernel/fork.c:2780
                     user_mode_thread+0x132/0x1a0 kernel/fork.c:2858
                     rest_init+0x23/0x300 init/main.c:712
                     start_kernel+0x47f/0x500 init/main.c:1105
                     x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
                     x86_64_start_kernel+0x9f/0xa0 arch/x86/kernel/head64.c:488
                     common_startup_64+0x13e/0x147
    INITIAL READ USE at:
                          lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
                          __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                          _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                          __do_wait+0x12d/0x850 kernel/exit.c:1591
                          do_wait+0x1e9/0x560 kernel/exit.c:1635
                          kernel_wait+0xe9/0x240 kernel/exit.c:1811
                          call_usermodehelper_exec_sync kernel/umh.c:137 [inline]
                          call_usermodehelper_exec_work+0xbd/0x230 kernel/umh.c:164
                          process_one_work kernel/workqueue.c:3229 [inline]
                          process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
                          worker_thread+0x870/0xd30 kernel/workqueue.c:3391
                          kthread+0x2f2/0x390 kernel/kthread.c:389
                          ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
                          ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
  }
  ... key      at: [<ffffffff8e60a058>] tasklist_lock+0x18/0x40
  ... acquired at:
   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
   __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
   _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
   send_sigio+0x108/0x390 fs/fcntl.c:924
   dnotify_handle_event+0x157/0x460 fs/notify/dnotify/dnotify.c:114
   fsnotify_handle_event fs/notify/fsnotify.c:347 [inline]
   send_to_group fs/notify/fsnotify.c:395 [inline]
   fsnotify+0x18ab/0x1f70 fs/notify/fsnotify.c:604
   fsnotify_parent include/linux/fsnotify.h:99 [inline]
   fsnotify_file include/linux/fsnotify.h:131 [inline]
   fsnotify_access include/linux/fsnotify.h:380 [inline]
   vfs_readv+0x921/0xa80 fs/read_write.c:1030
   do_preadv fs/read_write.c:1142 [inline]
   __do_sys_preadv fs/read_write.c:1192 [inline]
   __se_sys_preadv fs/read_write.c:1187 [inline]
   __x64_sys_preadv+0x1c7/0x2d0 fs/read_write.c:1187
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> (&f_owner->lock){....}-{2:2} {
   INITIAL USE at:
                   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                   _raw_write_lock_irq+0xd3/0x120 kernel/locking/spinlock.c:326
                   __f_setown+0x6b/0x380 fs/fcntl.c:137
                   fcntl_dirnotify+0x459/0x5b0 fs/notify/dnotify/dnotify.c:372
                   do_fcntl+0x7e2/0x1a60 fs/fcntl.c:534
                   __do_sys_fcntl fs/fcntl.c:586 [inline]
                   __se_sys_fcntl+0xd2/0x1e0 fs/fcntl.c:571
                   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
                   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   INITIAL READ USE at:
                        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
                        __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
                        _raw_read_lock_irqsave+0xdd/0x130 kernel/locking/spinlock.c:236
                        send_sigio+0x37/0x390 fs/fcntl.c:910
                        dnotify_handle_event+0x157/0x460 fs/notify/dnotify/dnotify.c:114
                        fsnotify_handle_event fs/notify/fsnotify.c:324 [inline]
                        send_to_group fs/notify/fsnotify.c:395 [inline]
                        fsnotify+0x1738/0x1f70 fs/notify/fsnotify.c:604
                        __fsnotify_parent+0x4f5/0x5e0 fs/notify/fsnotify.c:261
                        notify_change+0xc0c/0xe90 fs/attr.c:508
                        vfs_utimes+0x4b5/0x770 fs/utimes.c:66
                        do_utimes_fd fs/utimes.c:120 [inline]
                        do_utimes+0x162/0x270 fs/utimes.c:144
                        __do_sys_utimensat fs/utimes.c:164 [inline]
                        __se_sys_utimensat fs/utimes.c:148 [inline]
                        __x64_sys_utimensat+0x14f/0x250 fs/utimes.c:148
                        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                        do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
                        entry_SYSCALL_64_after_hwframe+0x77/0x7f
 }
 ... key      at: [<ffffffff9a40dca0>] file_f_owner_allocate.__key+0x0/0x20
 ... acquired at:
   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0xdd/0x130 kernel/locking/spinlock.c:236
   send_sigio+0x37/0x390 fs/fcntl.c:910
   kill_fasync_rcu fs/fcntl.c:1136 [inline]
   kill_fasync+0x256/0x4f0 fs/fcntl.c:1151
   lease_break_callback+0x26/0x30 fs/locks.c:558
   __break_lease+0x6d7/0x1820 fs/locks.c:1592
   break_lease include/linux/filelock.h:436 [inline]
   do_dentry_open+0x8d4/0x1460 fs/open.c:949
   vfs_open+0x3e/0x330 fs/open.c:1088
   do_open fs/namei.c:3774 [inline]
   path_openat+0x2c84/0x3590 fs/namei.c:3933
   do_filp_open+0x235/0x490 fs/namei.c:3960
   do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
   do_sys_open fs/open.c:1430 [inline]
   __do_sys_open fs/open.c:1438 [inline]
   __se_sys_open fs/open.c:1434 [inline]
   __x64_sys_open+0x225/0x270 fs/open.c:1434
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f


stack backtrace:
CPU: 1 UID: 0 PID: 19229 Comm: syz.4.5212 Not tainted 6.11.0-syzkaller-05591-g2a17bb8c204f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_bad_irq_dependency kernel/locking/lockdep.c:2644 [inline]
 check_irq_usage kernel/locking/lockdep.c:2885 [inline]
 check_prev_add kernel/locking/lockdep.c:3162 [inline]
 check_prevs_add kernel/locking/lockdep.c:3277 [inline]
 validate_chain+0x4ebd/0x5920 kernel/locking/lockdep.c:3901
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5199
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
 __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
 _raw_read_lock_irqsave+0xdd/0x130 kernel/locking/spinlock.c:236
 send_sigio+0x37/0x390 fs/fcntl.c:910
 kill_fasync_rcu fs/fcntl.c:1136 [inline]
 kill_fasync+0x256/0x4f0 fs/fcntl.c:1151
 lease_break_callback+0x26/0x30 fs/locks.c:558
 __break_lease+0x6d7/0x1820 fs/locks.c:1592
 break_lease include/linux/filelock.h:436 [inline]
 do_dentry_open+0x8d4/0x1460 fs/open.c:949
 vfs_open+0x3e/0x330 fs/open.c:1088
 do_open fs/namei.c:3774 [inline]
 path_openat+0x2c84/0x3590 fs/namei.c:3933
 do_filp_open+0x235/0x490 fs/namei.c:3960
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_open fs/open.c:1438 [inline]
 __se_sys_open fs/open.c:1434 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1434
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fec1c77def9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fec1d50f038 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fec1c935f80 RCX: 00007fec1c77def9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000540
RBP: 00007fec1c7f0b76 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fec1c935f80 R15: 00007fffa852a548
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

