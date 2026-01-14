Return-Path: <linux-fsdevel+bounces-73842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF42D21A88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 23:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A5DD3004C8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 22:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EC538A9A1;
	Wed, 14 Jan 2026 22:52:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7975530BF6B
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 22:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768431147; cv=none; b=OGBZk+2Avqidk9eYpYvNmLBBCnKozSg74LwnEQsPg3NcdL/d+ktZtreq3vY8lN1tuR5wYNVag7mNmabjgkw0txk1yRuBLpD073qtbUVZ82VHmKCIV60Th2zoLYux8Ydo+DGpTuLSmT93or3BXfevTf1Dn2ZTuBhXvpwe9tvqMLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768431147; c=relaxed/simple;
	bh=p7L6qELAvkFlaDn9o2Nx2zs7ZywFJcXKPlOvWpd9FNk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Gukd41KDSRzRt4R7RbMJkQTfPdGzMaKgetGv4W+NkBDQp2daDFOgDDinTEhvBYJHP+Ma1N5Z0XO5VKkNsQOJbRFtK5E4Ff+NAzaMmyvHEXPQ6UAaXPthlh/ghNXemT1SzKTwoRlansHWem1SJOnVSoUxn/N+segocFWrQc0Psqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-66108d1cd11so1434167eaf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 14:52:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768431141; x=1769035941;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iZZkCEw/WeW2vM/tvnG86l5+djWR/1Vkl2HTr8RTrtQ=;
        b=MXY/PIYkRBvreOpBIHrWRechZtqU4VWIZ3k/FZgR4nxTGcqiBlpXIP1KHF4uHq/nKk
         SsAbcYCq8edE31HMuQSPYAmWOmYAlNJGI5xpNG5UDUN/5uQw2wzHJWmMPdsDbpe4Nuoy
         olHxopCst0Kuv7X2if+ZQG6JtQh856YC3Sh0ZklT9IxtP5sqXe75eGZDMtgFAw3WsCz6
         PekR8PcCQuTKApbZPb8x7H3Nc/Xany22Brj/hFlbWa1ezp3k3hWI5zMsJstzDxWqTiNy
         Q6KLUjQXhRhnn8SjYTUVLoDYP97e5xqDvpjBLFrQHF2Np/x62Yy9eR2q9E239M1DbKRU
         MqHw==
X-Forwarded-Encrypted: i=1; AJvYcCVsLCgQNLHc7HvKIwUTx84pLmItMbyiUWEu5T0iavGJWRc+4cawTsQYAeThNaUHyN7RZwoyaoUbMH1KlDPo@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+hq/QZ1oGirZkKn2MXQBDvLT2WxACpNjZxroApuDLqQDIgAq3
	ZGF9jhVktaAlweoELScZOHnZMG1NC7Ce/aTGCUAsaFHYG7lqGN0qnJhC9gnmwkLfMOk/9ppEavH
	zwXQK2OQwrxJBgNSFL1Q0ehu6h5dv3GAlGmvUN9neZ+05SiH9did0e0JO5vM=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f031:b0:65d:1697:e6cc with SMTP id
 006d021491bc7-6610070217dmr3048949eaf.60.1768431141567; Wed, 14 Jan 2026
 14:52:21 -0800 (PST)
Date: Wed, 14 Jan 2026 14:52:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69681e25.050a0220.58bed.0006.GAE@google.com>
Subject: [syzbot] [fs?] possible deadlock in serial8250_handle_irq (2)
From: syzbot <syzbot+b503105c2410c3433459@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, brauner@kernel.org, chuck.lever@oracle.com, 
	jack@suse.cz, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b6151c4e60e5 Merge tag 'erofs-for-6.19-rc5-fixes' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ea319a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1859476832863c41
dashboard link: https://syzkaller.appspot.com/bug?extid=b503105c2410c3433459
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bc30f76f868c/disk-b6151c4e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/30226681480d/vmlinux-b6151c4e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/936a69accb40/bzImage-b6151c4e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b503105c2410c3433459@syzkaller.appspotmail.com

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
syzkaller #0 Tainted: G             L     
-----------------------------------------------------
syz.3.6696/30358 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffffffff8e00c098 (tasklist_lock){.+.+}-{3:3}, at: send_sigurg+0xed/0xc80 fs/fcntl.c:978

and this task is already holding:
ffff888144b9bea0 (&f_owner->lock){....}-{3:3}, at: send_sigurg+0x5f/0xc80 fs/fcntl.c:962
which would create a new lock dependency:
 (&f_owner->lock){....}-{3:3} -> (tasklist_lock){.+.+}-{3:3}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&port_lock_key){-.-.}-{3:3}

... which became HARDIRQ-irq-safe at:
  lock_acquire kernel/locking/lockdep.c:5868 [inline]
  lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
  uart_port_lock_irqsave include/linux/serial_core.h:717 [inline]
  serial8250_handle_irq+0x95/0xcb0 drivers/tty/serial/8250/8250_port.c:1798
  serial8250_default_handle_irq+0x9e/0x270 drivers/tty/serial/8250/8250_port.c:1846
  serial8250_interrupt+0xf8/0x1d0 drivers/tty/serial/8250/8250_core.c:86
  __handle_irq_event_percpu+0x236/0x890 kernel/irq/handle.c:211
  handle_irq_event_percpu kernel/irq/handle.c:248 [inline]
  handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:265
  handle_edge_irq+0x3ca/0x9e0 kernel/irq/chip.c:855
  generic_handle_irq_desc include/linux/irqdesc.h:172 [inline]
  handle_irq arch/x86/kernel/irq.c:255 [inline]
  call_irq_handler arch/x86/kernel/irq.c:311 [inline]
  __common_interrupt+0xd0/0x2f0 arch/x86/kernel/irq.c:326
  common_interrupt+0xba/0xe0 arch/x86/kernel/irq.c:319
  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:688
  native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
  pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:81
  arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
  default_idle+0x13/0x20 arch/x86/kernel/process.c:767
  default_idle_call+0x6c/0xb0 kernel/sched/idle.c:122
  cpuidle_idle_call kernel/sched/idle.c:191 [inline]
  do_idle+0x38d/0x510 kernel/sched/idle.c:332
  cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:430
  start_secondary+0x21d/0x2d0 arch/x86/kernel/smpboot.c:312
  common_startup_64+0x13e/0x148

to a HARDIRQ-irq-unsafe lock:
 (tasklist_lock){.+.+}-{3:3}

... which became HARDIRQ-irq-unsafe at:
...
  lock_acquire kernel/locking/lockdep.c:5868 [inline]
  lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
  __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
  _raw_read_lock+0x5f/0x70 kernel/locking/spinlock.c:228
  __do_wait+0x105/0x890 kernel/exit.c:1672
  do_wait+0x21d/0x570 kernel/exit.c:1716
  kernel_wait+0x9f/0x160 kernel/exit.c:1892
  call_usermodehelper_exec_sync kernel/umh.c:136 [inline]
  call_usermodehelper_exec_work+0xf1/0x170 kernel/umh.c:163
  process_one_work+0x9ba/0x1b20 kernel/workqueue.c:3257
  process_scheduled_works kernel/workqueue.c:3340 [inline]
  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3421
  kthread+0x3c5/0x780 kernel/kthread.c:463
  ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

other info that might help us debug this:

Chain exists of:
  &port_lock_key --> &f_owner->lock --> tasklist_lock

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(tasklist_lock);
                               local_irq_disable();
                               lock(&port_lock_key);
                               lock(&f_owner->lock);
  <Interrupt>
    lock(&port_lock_key);

 *** DEADLOCK ***

2 locks held by syz.3.6696/30358:
 #0: ffff88805f14a120 (&u->lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #0: ffff88805f14a120 (&u->lock){+.+.}-{3:3}, at: queue_oob net/unix/af_unix.c:2336 [inline]
 #0: ffff88805f14a120 (&u->lock){+.+.}-{3:3}, at: unix_stream_sendmsg+0xd33/0x1320 net/unix/af_unix.c:2491
 #1: ffff888144b9bea0 (&f_owner->lock){....}-{3:3}, at: send_sigurg+0x5f/0xc80 fs/fcntl.c:962

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
  -> (&port_lock_key){-.-.}-{3:3} {
     IN-HARDIRQ-W at:
                        lock_acquire kernel/locking/lockdep.c:5868 [inline]
                        lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
                        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                        _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
                        uart_port_lock_irqsave include/linux/serial_core.h:717 [inline]
                        serial8250_handle_irq+0x95/0xcb0 drivers/tty/serial/8250/8250_port.c:1798
                        serial8250_default_handle_irq+0x9e/0x270 drivers/tty/serial/8250/8250_port.c:1846
                        serial8250_interrupt+0xf8/0x1d0 drivers/tty/serial/8250/8250_core.c:86
                        __handle_irq_event_percpu+0x236/0x890 kernel/irq/handle.c:211
                        handle_irq_event_percpu kernel/irq/handle.c:248 [inline]
                        handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:265
                        handle_edge_irq+0x3ca/0x9e0 kernel/irq/chip.c:855
                        generic_handle_irq_desc include/linux/irqdesc.h:172 [inline]
                        handle_irq arch/x86/kernel/irq.c:255 [inline]
                        call_irq_handler arch/x86/kernel/irq.c:311 [inline]
                        __common_interrupt+0xd0/0x2f0 arch/x86/kernel/irq.c:326
                        common_interrupt+0xba/0xe0 arch/x86/kernel/irq.c:319
                        asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:688
                        native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
                        pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:81
                        arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
                        default_idle+0x13/0x20 arch/x86/kernel/process.c:767
                        default_idle_call+0x6c/0xb0 kernel/sched/idle.c:122
                        cpuidle_idle_call kernel/sched/idle.c:191 [inline]
                        do_idle+0x38d/0x510 kernel/sched/idle.c:332
                        cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:430
                        start_secondary+0x21d/0x2d0 arch/x86/kernel/smpboot.c:312
                        common_startup_64+0x13e/0x148
     IN-SOFTIRQ-W at:
                        lock_acquire kernel/locking/lockdep.c:5868 [inline]
                        lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
                        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                        _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
                        uart_port_lock_irqsave include/linux/serial_core.h:717 [inline]
                        serial8250_handle_irq+0x95/0xcb0 drivers/tty/serial/8250/8250_port.c:1798
                        serial8250_default_handle_irq+0x9e/0x270 drivers/tty/serial/8250/8250_port.c:1846
                        serial8250_interrupt+0xf8/0x1d0 drivers/tty/serial/8250/8250_core.c:86
                        __handle_irq_event_percpu+0x236/0x890 kernel/irq/handle.c:211
                        handle_irq_event_percpu kernel/irq/handle.c:248 [inline]
                        handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:265
                        handle_edge_irq+0x3ca/0x9e0 kernel/irq/chip.c:855
                        generic_handle_irq_desc include/linux/irqdesc.h:172 [inline]
                        handle_irq arch/x86/kernel/irq.c:255 [inline]
                        call_irq_handler arch/x86/kernel/irq.c:311 [inline]
                        __common_interrupt+0xd0/0x2f0 arch/x86/kernel/irq.c:326
                        common_interrupt+0x61/0xe0 arch/x86/kernel/irq.c:319
                        asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:688
                        __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:160 [inline]
                        _raw_spin_unlock_irq+0x29/0x50 kernel/locking/spinlock.c:202
                        __run_timer_base kernel/time/timer.c:2386 [inline]
                        __run_timer_base kernel/time/timer.c:2377 [inline]
                        run_timer_base+0x11c/0x190 kernel/time/timer.c:2394
                        run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2404
                        handle_softirqs+0x219/0x950 kernel/softirq.c:622
                        __do_softirq kernel/softirq.c:656 [inline]
                        invoke_softirq kernel/softirq.c:496 [inline]
                        __irq_exit_rcu+0x109/0x170 kernel/softirq.c:723
                        irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
                        instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
                        sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1056
                        asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
                        native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
                        pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:81
                        arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
                        default_idle+0x13/0x20 arch/x86/kernel/process.c:767
                        default_idle_call+0x6c/0xb0 kernel/sched/idle.c:122
                        cpuidle_idle_call kernel/sched/idle.c:191 [inline]
                        do_idle+0x38d/0x510 kernel/sched/idle.c:332
                        cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:430
                        start_secondary+0x21d/0x2d0 arch/x86/kernel/smpboot.c:312
                        common_startup_64+0x13e/0x148
     INITIAL USE at:
                       lock_acquire kernel/locking/lockdep.c:5868 [inline]
                       lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
                       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
                       uart_port_lock_irqsave include/linux/serial_core.h:717 [inline]
                       class_uart_port_lock_irqsave_constructor include/linux/serial_core.h:797 [inline]
                       serial8250_do_set_termios+0x2cc/0x1740 drivers/tty/serial/8250/8250_port.c:2760
                       serial8250_set_termios+0x6e/0x80 drivers/tty/serial/8250/8250_port.c:2787
                       uart_set_options+0x31a/0x5f0 drivers/tty/serial/serial_core.c:2234
                       serial8250_console_setup+0x189/0x450 drivers/tty/serial/8250/8250_port.c:3405
                       univ8250_console_setup+0x1eb/0x2e0 drivers/tty/serial/8250/8250_core.c:430
                       console_call_setup kernel/printk/printk.c:3844 [inline]
                       console_call_setup kernel/printk/printk.c:3835 [inline]
                       try_enable_preferred_console+0x2fd/0x530 kernel/printk/printk.c:3888
                       register_console+0x3a7/0x1210 kernel/printk/printk.c:4082
                       univ8250_console_init+0x5f/0x90 drivers/tty/serial/8250/8250_core.c:515
                       console_init+0x152/0x600 kernel/printk/printk.c:4369
                       start_kernel+0x298/0x4d0 init/main.c:1143
                       x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:310
                       x86_64_start_kernel+0x130/0x190 arch/x86/kernel/head64.c:291
                       common_startup_64+0x13e/0x148
   }
   ... key      at: [<ffffffff9aeed9c0>] port_lock_key+0x0/0x40
 -> (&new->fa_lock){...-}-{3:3} {
    IN-SOFTIRQ-R at:
                      lock_acquire kernel/locking/lockdep.c:5868 [inline]
                      lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
                      __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
                      _raw_read_lock_irqsave+0x46/0x90 kernel/locking/spinlock.c:236
                      kill_fasync_rcu fs/fcntl.c:1135 [inline]
                      kill_fasync fs/fcntl.c:1159 [inline]
                      kill_fasync+0x138/0x510 fs/fcntl.c:1152
                      sock_wake_async+0x132/0x160 net/socket.c:1509
                      sk_wake_async_rcu include/net/sock.h:2570 [inline]
                      sk_wake_async_rcu include/net/sock.h:2567 [inline]
                      sock_def_error_report+0x352/0x400 net/core/sock.c:3598
                      sk_error_report+0x3f/0x260 net/core/sock.c:348
                      tcp_done_with_error+0xa4/0xc0 net/ipv4/tcp_input.c:4644
                      tcp_reset+0x140/0x2e0 net/ipv4/tcp_input.c:4674
                      tcp_validate_incoming+0x875/0x2420 net/ipv4/tcp_input.c:6257
                      tcp_rcv_established+0x4f0/0x36e0 net/ipv4/tcp_input.c:6457
                      tcp_v6_do_rcv+0x11cd/0x1dc0 net/ipv6/tcp_ipv6.c:1607
                      tcp_v6_rcv+0x2ab5/0x48f0 net/ipv6/tcp_ipv6.c:1877
                      ip6_protocol_deliver_rcu+0x188/0x1520 net/ipv6/ip6_input.c:438
                      ip6_input_finish+0x1e4/0x4b0 net/ipv6/ip6_input.c:489
                      NF_HOOK include/linux/netfilter.h:318 [inline]
                      NF_HOOK include/linux/netfilter.h:312 [inline]
                      ip6_input+0x105/0x2f0 net/ipv6/ip6_input.c:500
                      dst_input include/net/dst.h:474 [inline]
                      ip6_rcv_finish net/ipv6/ip6_input.c:79 [inline]
                      NF_HOOK include/linux/netfilter.h:318 [inline]
                      NF_HOOK include/linux/netfilter.h:312 [inline]
                      ipv6_rcv+0x264/0x650 net/ipv6/ip6_input.c:311
                      __netif_receive_skb_one_core+0x12d/0x1e0 net/core/dev.c:6139
                      __netif_receive_skb+0x1d/0x160 net/core/dev.c:6252
                      process_backlog+0x4a2/0x1650 net/core/dev.c:6604
                      __napi_poll.constprop.0+0xb3/0x540 net/core/dev.c:7668
                      napi_poll net/core/dev.c:7731 [inline]
                      net_rx_action+0x9f9/0xfa0 net/core/dev.c:7883
                      handle_softirqs+0x219/0x950 kernel/softirq.c:622
                      run_ksoftirqd kernel/softirq.c:1063 [inline]
                      run_ksoftirqd+0x3a/0x60 kernel/softirq.c:1055
                      smpboot_thread_fn+0x3f7/0xae0 kernel/smpboot.c:160
                      kthread+0x3c5/0x780 kernel/kthread.c:463
                      ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
                      ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
    INITIAL USE at:
                     lock_acquire kernel/locking/lockdep.c:5868 [inline]
                     lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
                     __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                     _raw_write_lock_irq+0x36/0x50 kernel/locking/spinlock.c:326
                     fasync_remove_entry+0xb2/0x1e0 fs/fcntl.c:1012
                     fasync_helper+0xaf/0xd0 fs/fcntl.c:1115
                     snd_fasync_helper+0x1ea/0x290 sound/core/misc.c:141
                     setfl fs/fcntl.c:76 [inline]
                     do_fcntl+0xc56/0x1660 fs/fcntl.c:477
                     __do_sys_fcntl fs/fcntl.c:602 [inline]
                     __se_sys_fcntl fs/fcntl.c:587 [inline]
                     __x64_sys_fcntl+0x163/0x200 fs/fcntl.c:587
                     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                     do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
                     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    INITIAL READ USE at:
                          lock_acquire kernel/locking/lockdep.c:5868 [inline]
                          lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
                          __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
                          _raw_read_lock_irqsave+0x74/0x90 kernel/locking/spinlock.c:236
                          kill_fasync_rcu fs/fcntl.c:1135 [inline]
                          kill_fasync fs/fcntl.c:1159 [inline]
                          kill_fasync+0x138/0x510 fs/fcntl.c:1152
                          lease_break_callback+0x23/0x30 fs/locks.c:567
                          __break_lease+0x6cd/0x1800 fs/locks.c:1647
                          break_lease include/linux/filelock.h:477 [inline]
                          do_dentry_open+0x6e7/0x1590 fs/open.c:953
                          vfs_open+0x82/0x3f0 fs/open.c:1094
                          do_open fs/namei.c:4637 [inline]
                          path_openat+0x2078/0x3140 fs/namei.c:4796
                          do_filp_open+0x20b/0x470 fs/namei.c:4823
                          do_open_execat+0xf9/0x3a0 fs/exec.c:783
                          open_exec+0x45/0x80 fs/exec.c:822
                          load_script+0x51d/0x790 fs/binfmt_script.c:132
                          search_binary_handler fs/exec.c:1669 [inline]
                          exec_binprm fs/exec.c:1701 [inline]
                          bprm_execve fs/exec.c:1753 [inline]
                          bprm_execve+0x8c2/0x1620 fs/exec.c:1729
                          do_execveat_common.isra.0+0x4a5/0x610 fs/exec.c:1859
                          do_execveat fs/exec.c:1944 [inline]
                          __do_sys_execveat fs/exec.c:2018 [inline]
                          __se_sys_execveat fs/exec.c:2012 [inline]
                          __x64_sys_execveat+0xda/0x120 fs/exec.c:2012
                          do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                          do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
                          entry_SYSCALL_64_after_hwframe+0x77/0x7f
  }
  ... key      at: [<ffffffff9ac56380>] __key.0+0x0/0x40
  ... acquired at:
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0x74/0x90 kernel/locking/spinlock.c:236
   kill_fasync_rcu fs/fcntl.c:1135 [inline]
   kill_fasync fs/fcntl.c:1159 [inline]
   kill_fasync+0x138/0x510 fs/fcntl.c:1152
   tty_wakeup+0xe8/0x120 drivers/tty/tty_io.c:515
   tty_port_default_wakeup+0x4d/0x60 drivers/tty/tty_port.c:67
   serial8250_tx_chars+0x68e/0x860 drivers/tty/serial/8250/8250_port.c:1719
   __start_tx+0x3df/0x490 drivers/tty/serial/8250/8250_port.c:1426
   serial8250_start_tx+0x368/0x530 drivers/tty/serial/8250/8250_port.c:1535
   __uart_start+0x295/0x500 drivers/tty/serial/serial_core.c:161
   uart_write+0x218/0xb30 drivers/tty/serial/serial_core.c:633
   n_tty_write+0xb52/0x1280 drivers/tty/n_tty.c:2388
   iterate_tty_write drivers/tty/tty_io.c:1006 [inline]
   file_tty_write.constprop.0+0x503/0x9b0 drivers/tty/tty_io.c:1081
   new_sync_write fs/read_write.c:593 [inline]
   vfs_write+0x7d3/0x11d0 fs/read_write.c:686
   ksys_write+0x12a/0x250 fs/read_write.c:738
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> (&f_owner->lock){....}-{3:3} {
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5868 [inline]
                   lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                   _raw_write_lock_irq+0x36/0x50 kernel/locking/spinlock.c:326
                   __f_setown+0x61/0x3c0 fs/fcntl.c:136
                   generic_add_lease fs/locks.c:1898 [inline]
                   generic_setlease+0xed4/0x1280 fs/locks.c:1974
                   kernel_setlease+0x106/0x140 fs/locks.c:2023
                   vfs_setlease+0x1e8/0x280 fs/locks.c:2056
                   do_fcntl_add_lease+0x3c4/0x550 fs/locks.c:2077
                   fcntl_setlease+0xfc/0x180 fs/locks.c:2102
                   do_fcntl+0x153b/0x1660 fs/fcntl.c:535
                   __do_sys_fcntl fs/fcntl.c:602 [inline]
                   __se_sys_fcntl fs/fcntl.c:587 [inline]
                   __x64_sys_fcntl+0x163/0x200 fs/fcntl.c:587
                   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                   do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
                   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   INITIAL READ USE at:
                        lock_acquire kernel/locking/lockdep.c:5868 [inline]
                        lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
                        __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
                        _raw_read_lock_irqsave+0x74/0x90 kernel/locking/spinlock.c:236
                        send_sigio+0x31/0x3e0 fs/fcntl.c:918
                        kill_fasync_rcu fs/fcntl.c:1144 [inline]
                        kill_fasync fs/fcntl.c:1159 [inline]
                        kill_fasync+0x214/0x510 fs/fcntl.c:1152
                        lease_break_callback+0x23/0x30 fs/locks.c:567
                        __break_lease+0x6cd/0x1800 fs/locks.c:1647
                        break_lease include/linux/filelock.h:477 [inline]
                        do_dentry_open+0x6e7/0x1590 fs/open.c:953
                        vfs_open+0x82/0x3f0 fs/open.c:1094
                        do_open fs/namei.c:4637 [inline]
                        path_openat+0x2078/0x3140 fs/namei.c:4796
                        do_filp_open+0x20b/0x470 fs/namei.c:4823
                        do_open_execat+0xf9/0x3a0 fs/exec.c:783
                        open_exec+0x45/0x80 fs/exec.c:822
                        load_script+0x51d/0x790 fs/binfmt_script.c:132
                        search_binary_handler fs/exec.c:1669 [inline]
                        exec_binprm fs/exec.c:1701 [inline]
                        bprm_execve fs/exec.c:1753 [inline]
                        bprm_execve+0x8c2/0x1620 fs/exec.c:1729
                        do_execveat_common.isra.0+0x4a5/0x610 fs/exec.c:1859
                        do_execveat fs/exec.c:1944 [inline]
                        __do_sys_execveat fs/exec.c:2018 [inline]
                        __se_sys_execveat fs/exec.c:2012 [inline]
                        __x64_sys_execveat+0xda/0x120 fs/exec.c:2012
                        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                        do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
                        entry_SYSCALL_64_after_hwframe+0x77/0x7f
 }
 ... key      at: [<ffffffff9ac563c0>] __key.1+0x0/0x40
 ... acquired at:
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0x74/0x90 kernel/locking/spinlock.c:236
   send_sigio+0x31/0x3e0 fs/fcntl.c:918
   kill_fasync_rcu fs/fcntl.c:1144 [inline]
   kill_fasync fs/fcntl.c:1159 [inline]
   kill_fasync+0x214/0x510 fs/fcntl.c:1152
   lease_break_callback+0x23/0x30 fs/locks.c:567
   __break_lease+0x6cd/0x1800 fs/locks.c:1647
   break_lease include/linux/filelock.h:477 [inline]
   do_dentry_open+0x6e7/0x1590 fs/open.c:953
   vfs_open+0x82/0x3f0 fs/open.c:1094
   do_open fs/namei.c:4637 [inline]
   path_openat+0x2078/0x3140 fs/namei.c:4796
   do_filp_open+0x20b/0x470 fs/namei.c:4823
   do_open_execat+0xf9/0x3a0 fs/exec.c:783
   open_exec+0x45/0x80 fs/exec.c:822
   load_script+0x51d/0x790 fs/binfmt_script.c:132
   search_binary_handler fs/exec.c:1669 [inline]
   exec_binprm fs/exec.c:1701 [inline]
   bprm_execve fs/exec.c:1753 [inline]
   bprm_execve+0x8c2/0x1620 fs/exec.c:1729
   do_execveat_common.isra.0+0x4a5/0x610 fs/exec.c:1859
   do_execveat fs/exec.c:1944 [inline]
   __do_sys_execveat fs/exec.c:2018 [inline]
   __se_sys_execveat fs/exec.c:2012 [inline]
   __x64_sys_execveat+0xda/0x120 fs/exec.c:2012
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f


the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
-> (tasklist_lock){.+.+}-{3:3} {
   HARDIRQ-ON-R at:
                    lock_acquire kernel/locking/lockdep.c:5868 [inline]
                    lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
                    __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                    _raw_read_lock+0x5f/0x70 kernel/locking/spinlock.c:228
                    __do_wait+0x105/0x890 kernel/exit.c:1672
                    do_wait+0x21d/0x570 kernel/exit.c:1716
                    kernel_wait+0x9f/0x160 kernel/exit.c:1892
                    call_usermodehelper_exec_sync kernel/umh.c:136 [inline]
                    call_usermodehelper_exec_work+0xf1/0x170 kernel/umh.c:163
                    process_one_work+0x9ba/0x1b20 kernel/workqueue.c:3257
                    process_scheduled_works kernel/workqueue.c:3340 [inline]
                    worker_thread+0x6c8/0xf10 kernel/workqueue.c:3421
                    kthread+0x3c5/0x780 kernel/kthread.c:463
                    ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
   SOFTIRQ-ON-R at:
                    lock_acquire kernel/locking/lockdep.c:5868 [inline]
                    lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
                    __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                    _raw_read_lock+0x5f/0x70 kernel/locking/spinlock.c:228
                    __do_wait+0x105/0x890 kernel/exit.c:1672
                    do_wait+0x21d/0x570 kernel/exit.c:1716
                    kernel_wait+0x9f/0x160 kernel/exit.c:1892
                    call_usermodehelper_exec_sync kernel/umh.c:136 [inline]
                    call_usermodehelper_exec_work+0xf1/0x170 kernel/umh.c:163
                    process_one_work+0x9ba/0x1b20 kernel/workqueue.c:3257
                    process_scheduled_works kernel/workqueue.c:3340 [inline]
                    worker_thread+0x6c8/0xf10 kernel/workqueue.c:3421
                    kthread+0x3c5/0x780 kernel/kthread.c:463
                    ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5868 [inline]
                   lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                   _raw_write_lock_irq+0x36/0x50 kernel/locking/spinlock.c:326
                   copy_process+0x4668/0x7430 kernel/fork.c:2367
                   kernel_clone+0xfc/0x910 kernel/fork.c:2651
                   user_mode_thread+0xc8/0x110 kernel/fork.c:2727
                   rest_init+0x23/0x2b0 init/main.c:722
                   start_kernel+0x3ef/0x4d0 init/main.c:1206
                   x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:310
                   x86_64_start_kernel+0x130/0x190 arch/x86/kernel/head64.c:291
                   common_startup_64+0x13e/0x148
   INITIAL READ USE at:
                        lock_acquire kernel/locking/lockdep.c:5868 [inline]
                        lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
                        __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                        _raw_read_lock+0x5f/0x70 kernel/locking/spinlock.c:228
                        __do_wait+0x105/0x890 kernel/exit.c:1672
                        do_wait+0x21d/0x570 kernel/exit.c:1716
                        kernel_wait+0x9f/0x160 kernel/exit.c:1892
                        call_usermodehelper_exec_sync kernel/umh.c:136 [inline]
                        call_usermodehelper_exec_work+0xf1/0x170 kernel/umh.c:163
                        process_one_work+0x9ba/0x1b20 kernel/workqueue.c:3257
                        process_scheduled_works kernel/workqueue.c:3340 [inline]
                        worker_thread+0x6c8/0xf10 kernel/workqueue.c:3421
                        kthread+0x3c5/0x780 kernel/kthread.c:463
                        ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
                        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 }
 ... key      at: [<ffffffff8e00c098>] tasklist_lock+0x18/0x40
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5868 [inline]
   lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
   __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
   _raw_read_lock+0x5f/0x70 kernel/locking/spinlock.c:228
   send_sigurg+0xed/0xc80 fs/fcntl.c:978
   sk_send_sigurg+0x76/0x360 net/core/sock.c:3669
   queue_oob net/unix/af_unix.c:2357 [inline]
   unix_stream_sendmsg+0xfa3/0x1320 net/unix/af_unix.c:2491
   sock_sendmsg_nosec net/socket.c:727 [inline]
   __sock_sendmsg net/socket.c:742 [inline]
   ____sys_sendmsg+0xa5d/0xc30 net/socket.c:2592
   ___sys_sendmsg+0x134/0x1d0 net/socket.c:2646
   __sys_sendmmsg+0x200/0x420 net/socket.c:2735
   __do_sys_sendmmsg net/socket.c:2762 [inline]
   __se_sys_sendmmsg net/socket.c:2759 [inline]
   __x64_sys_sendmmsg+0x9c/0x100 net/socket.c:2759
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f


stack backtrace:
CPU: 0 UID: 60928 PID: 30358 Comm: syz.3.6696 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_bad_irq_dependency kernel/locking/lockdep.c:2616 [inline]
 check_irq_usage+0x8e6/0xbc0 kernel/locking/lockdep.c:2857
 check_prev_add kernel/locking/lockdep.c:3169 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x167f/0x2890 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
 __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
 _raw_read_lock+0x5f/0x70 kernel/locking/spinlock.c:228
 send_sigurg+0xed/0xc80 fs/fcntl.c:978
 sk_send_sigurg+0x76/0x360 net/core/sock.c:3669
 queue_oob net/unix/af_unix.c:2357 [inline]
 unix_stream_sendmsg+0xfa3/0x1320 net/unix/af_unix.c:2491
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xa5d/0xc30 net/socket.c:2592
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2646
 __sys_sendmmsg+0x200/0x420 net/socket.c:2735
 __do_sys_sendmmsg net/socket.c:2762 [inline]
 __se_sys_sendmmsg net/socket.c:2759 [inline]
 __x64_sys_sendmmsg+0x9c/0x100 net/socket.c:2759
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6dde98f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6ddf83b038 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007f6ddebe5fa0 RCX: 00007f6dde98f749
RDX: 0000000000000001 RSI: 0000200000006c40 RDI: 0000000000000007
RBP: 00007f6ddea13f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000040015 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6ddebe6038 R14: 00007f6ddebe5fa0 R15: 00007ffcaa509058
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

