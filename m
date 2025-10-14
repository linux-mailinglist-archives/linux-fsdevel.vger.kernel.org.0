Return-Path: <linux-fsdevel+bounces-64063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5571EBD6D5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 02:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159A43E402C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 00:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5351F5F6;
	Tue, 14 Oct 2025 00:10:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499E11862
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760400637; cv=none; b=k0rWgRJQxYPCQWbS8+EG4RP8YD12wdeW9brcO7x1565RnIqjHhaG7TJteTQKZhB2pmkoc+YdPdKMc6LxwsjJC0ZvTJsgipSy1kQ99itUiJlWcV3OZ/c0uNxs9/dKT31UBko0xmLL/Q8QdzrL06SVBM8qSjm6LxjtsMBouGAfMeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760400637; c=relaxed/simple;
	bh=5ydpcSlWMy170mxLBmOLRGrSJqMcJk2UF+bL1S4Q244=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=btnMR5fWgsg4w6TNOYuU7ZSIG55yDBEp4p7zspc2I87TCZg2KxRpUkrYr+125eBzjJq3nS8kbvCewNPW7rzTYKO9DZq8j7YqLdHH13s0UA42mfnNVPy9AtrYziAZpk6vGaOePaeyBOLA4pAnHarsBeQqXOnLXE3ySDWPoGZ4sR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-42f911a1984so291702635ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 17:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760400634; x=1761005434;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WdIS3KBE88XyLX32t0lwMdesYoMePOrnhTT4U9nInO4=;
        b=DWU6Cs3TYsFfw1GC17nnZcOC7P5aAsIXv2Q84cxJw0HzjaGRDPnMR6AdaYQW6g4mJD
         bdZjPBeCwcrvEPzTvFKIfG/mWPydGpEHnHxBgqn+7eW80CBgHiD6GtmPtNm3ZN3M8H9X
         zGaSQTFvogmuYk6ie3mtDHjHiNpPiqfRnGHBbIe7OqPIQsTzSFs+u3HdJzSI1iqaNRB3
         wmNAxuHdB8+3Q21Y4ZwnMhHQfz6pvV3UlVa44uqkV2W4tFmwnh48G/y5YrESuUbYIXhx
         alkTa2zsaeGuSNpDSjL+etdh495DnB3+ltbjlG8IgBGVqBPH7KtFflwVPbWt5ys97zZY
         TvWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaX4Ld1l8AHc7xEmNdQVlgRcUI2pqyz62yUVj8lxqkr5+A4fGZmgmvmwrVOxNFaNACVRFEnsK/a+Kw88kQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwA6FNrb5/2kXP0rdZntGcLisu0az5jqgcDfaHXnYkceCkYjME4
	h46j/PlIkI5+Bhy86mc6Ft30i9JJ1R4rtuSw59whmD6ivmvVKTD5TKxH2/70FYAkJWc9R9qx37j
	GMLeI5bZ9N3Cdl1wfCR8iF+XayEYDH9XuRFP9XvrWTNOlponrb/5fyPiSWq0=
X-Google-Smtp-Source: AGHT+IFMbDEIx+2batxJGlD8BWdZoL2+EdYQ9VrgS814hfu7++rjilkHUElGEmKqhwsHuVh7SnnUMb17rjbE+0Y1n2YeBD2CvX47
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aab:b0:430:a14f:314c with SMTP id
 e9e14a558f8ab-430a14f334cmr10072655ab.7.1760400634506; Mon, 13 Oct 2025
 17:10:34 -0700 (PDT)
Date: Mon, 13 Oct 2025 17:10:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ed94fa.050a0220.91a22.01f3.GAE@google.com>
Subject: [syzbot] [serial?] possible deadlock in kbd_event
From: syzbot <syzbot+781c8bb5e4d62cc883d3@syzkaller.appspotmail.com>
To: amir73il@gmail.com, gregkh@linuxfoundation.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3a8660878839 Linux 6.18-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=108fb9e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
dashboard link: https://syzkaller.appspot.com/bug?extid=781c8bb5e4d62cc883d3
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/25b4c153ce2b/disk-3a866087.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d46ef21feab1/vmlinux-3a866087.xz
kernel image: https://storage.googleapis.com/syzbot-assets/92d86bf0b54b/bzImage-3a866087.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+781c8bb5e4d62cc883d3@syzkaller.appspotmail.com

=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
syzkaller #0 Not tainted
-----------------------------------------------------
syz.8.7222/28053 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffff888077eaec90 (&new->fa_lock){....}-{3:3}, at: kill_fasync_rcu fs/fcntl.c:1122 [inline]
ffff888077eaec90 (&new->fa_lock){....}-{3:3}, at: kill_fasync+0x199/0x4d0 fs/fcntl.c:1146

and this task is already holding:
ffff88802ca16468 (&tty->flow.lock){....}-{3:3}, at: class_spinlock_irqsave_constructor include/linux/spinlock.h:585 [inline]
ffff88802ca16468 (&tty->flow.lock){....}-{3:3}, at: start_tty+0x20/0x70 drivers/tty/tty_io.c:793
which would create a new lock dependency:
 (&tty->flow.lock){....}-{3:3} -> (&new->fa_lock){....}-{3:3}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (kbd_event_lock){..-.}-{3:3}

... which became SOFTIRQ-irq-safe at:
  lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
  spin_lock include/linux/spinlock.h:351 [inline]
  kbd_event+0xd2/0x3f70 drivers/tty/vt/keyboard.c:1528
  input_handle_events_default+0xd4/0x1a0 drivers/input/input.c:2541
  input_pass_values+0x288/0x890 drivers/input/input.c:128
  input_event_dispose+0x3e5/0x6b0 drivers/input/input.c:353
  input_inject_event+0x1dd/0x340 drivers/input/input.c:424
  kd_sound_helper+0x19f/0x210 drivers/tty/vt/keyboard.c:261
  input_handler_for_each_handle+0x101/0x1c0 drivers/input/input.c:2520
  call_timer_fn+0x17e/0x5f0 kernel/time/timer.c:1747
  expire_timers kernel/time/timer.c:1798 [inline]
  __run_timers kernel/time/timer.c:2372 [inline]
  __run_timer_base+0x61a/0x860 kernel/time/timer.c:2384
  run_timer_base kernel/time/timer.c:2393 [inline]
  run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2403
  handle_softirqs+0x286/0x870 kernel/softirq.c:622
  __do_softirq kernel/softirq.c:656 [inline]
  invoke_softirq kernel/softirq.c:496 [inline]
  __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:723
  irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [inline]
  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1052
  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
  check_kcov_mode kernel/kcov.c:185 [inline]
  write_comp_data kernel/kcov.c:246 [inline]
  __sanitizer_cov_trace_const_cmp8+0x37/0x90 kernel/kcov.c:321
  __copy_present_ptes mm/memory.c:1093 [inline]
  copy_present_ptes mm/memory.c:1179 [inline]
  copy_pte_range mm/memory.c:1302 [inline]
  copy_pmd_range+0x220d/0x7f00 mm/memory.c:1389
  copy_pud_range mm/memory.c:1426 [inline]
  copy_p4d_range mm/memory.c:1450 [inline]
  copy_page_range+0xc14/0x1270 mm/memory.c:1538
  dup_mmap+0xf4c/0x1b10 mm/mmap.c:1834
  dup_mm kernel/fork.c:1489 [inline]
  copy_mm+0x13c/0x4b0 kernel/fork.c:1541
  copy_process+0x1706/0x3c00 kernel/fork.c:2181
  kernel_clone+0x21e/0x840 kernel/fork.c:2609
  __do_sys_clone kernel/fork.c:2750 [inline]
  __se_sys_clone kernel/fork.c:2734 [inline]
  __x64_sys_clone+0x18b/0x1e0 kernel/fork.c:2734
  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
  entry_SYSCALL_64_after_hwframe+0x77/0x7f

to a SOFTIRQ-irq-unsafe lock:
 (tasklist_lock){.+.+}-{3:3}

... which became SOFTIRQ-irq-unsafe at:
...
  lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
  __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
  _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
  __do_wait+0xde/0x740 kernel/exit.c:1667
  do_wait+0x1f8/0x510 kernel/exit.c:1711
  kernel_wait+0xab/0x170 kernel/exit.c:1887
  call_usermodehelper_exec_sync kernel/umh.c:136 [inline]
  call_usermodehelper_exec_work+0xbe/0x230 kernel/umh.c:163
  process_one_work kernel/workqueue.c:3263 [inline]
  process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
  kthread+0x711/0x8a0 kernel/kthread.c:463
  ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

Chain exists of:
  kbd_event_lock --> &tty->flow.lock --> tasklist_lock

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(tasklist_lock);
                               local_irq_disable();
                               lock(kbd_event_lock);
                               lock(&tty->flow.lock);
  <Interrupt>
    lock(kbd_event_lock);

 *** DEADLOCK ***

6 locks held by syz.8.7222/28053:
 #0: ffff88802ca160a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffff88802ca162e8 (&tty->termios_rwsem/1){++++}-{4:4}, at: tty_set_termios+0x138/0x17e0 drivers/tty/tty_ioctl.c:333
 #2: ffff88802ca160a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref+0x1c/0x90 drivers/tty/tty_ldisc.c:263
 #3: ffff88802ca16468 (&tty->flow.lock){....}-{3:3}, at: class_spinlock_irqsave_constructor include/linux/spinlock.h:585 [inline]
 #3: ffff88802ca16468 (&tty->flow.lock){....}-{3:3}, at: start_tty+0x20/0x70 drivers/tty/tty_io.c:793
 #4: ffff88802ca160a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref+0x1c/0x90 drivers/tty/tty_ldisc.c:263
 #5: ffffffff8e13d2e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #5: ffffffff8e13d2e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #5: ffffffff8e13d2e0 (rcu_read_lock){....}-{1:3}, at: kill_fasync+0x53/0x4d0 fs/fcntl.c:1145

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
 -> (kbd_event_lock){..-.}-{3:3} {
    IN-SOFTIRQ-W at:
                      lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
                      __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                      _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                      spin_lock include/linux/spinlock.h:351 [inline]
                      kbd_event+0xd2/0x3f70 drivers/tty/vt/keyboard.c:1528
                      input_handle_events_default+0xd4/0x1a0 drivers/input/input.c:2541
                      input_pass_values+0x288/0x890 drivers/input/input.c:128
                      input_event_dispose+0x3e5/0x6b0 drivers/input/input.c:353
                      input_inject_event+0x1dd/0x340 drivers/input/input.c:424
                      kd_sound_helper+0x19f/0x210 drivers/tty/vt/keyboard.c:261
                      input_handler_for_each_handle+0x101/0x1c0 drivers/input/input.c:2520
                      call_timer_fn+0x17e/0x5f0 kernel/time/timer.c:1747
                      expire_timers kernel/time/timer.c:1798 [inline]
                      __run_timers kernel/time/timer.c:2372 [inline]
                      __run_timer_base+0x61a/0x860 kernel/time/timer.c:2384
                      run_timer_base kernel/time/timer.c:2393 [inline]
                      run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2403
                      handle_softirqs+0x286/0x870 kernel/softirq.c:622
                      __do_softirq kernel/softirq.c:656 [inline]
                      invoke_softirq kernel/softirq.c:496 [inline]
                      __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:723
                      irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
                      instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [inline]
                      sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1052
                      asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
                      check_kcov_mode kernel/kcov.c:185 [inline]
                      write_comp_data kernel/kcov.c:246 [inline]
                      __sanitizer_cov_trace_const_cmp8+0x37/0x90 kernel/kcov.c:321
                      __copy_present_ptes mm/memory.c:1093 [inline]
                      copy_present_ptes mm/memory.c:1179 [inline]
                      copy_pte_range mm/memory.c:1302 [inline]
                      copy_pmd_range+0x220d/0x7f00 mm/memory.c:1389
                      copy_pud_range mm/memory.c:1426 [inline]
                      copy_p4d_range mm/memory.c:1450 [inline]
                      copy_page_range+0xc14/0x1270 mm/memory.c:1538
                      dup_mmap+0xf4c/0x1b10 mm/mmap.c:1834
                      dup_mm kernel/fork.c:1489 [inline]
                      copy_mm+0x13c/0x4b0 kernel/fork.c:1541
                      copy_process+0x1706/0x3c00 kernel/fork.c:2181
                      kernel_clone+0x21e/0x840 kernel/fork.c:2609
                      __do_sys_clone kernel/fork.c:2750 [inline]
                      __se_sys_clone kernel/fork.c:2734 [inline]
                      __x64_sys_clone+0x18b/0x1e0 kernel/fork.c:2734
                      do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                      do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
                      entry_SYSCALL_64_after_hwframe+0x77/0x7f
    INITIAL USE at:
                     lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
                     __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                     _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
                     vt_reset_unicode+0x2b/0x160 drivers/tty/vt/keyboard.c:2187
                     reset_vc+0x68/0x1b0 drivers/tty/vt/vt_ioctl.c:966
                     vc_init+0x70/0x4a0 drivers/tty/vt/vt.c:3728
                     con_init+0x385/0x9c0 drivers/tty/vt/vt.c:3793
                     console_init+0x10e/0x430 kernel/printk/printk.c:4298
                     start_kernel+0x254/0x410 init/main.c:1048
                     x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
                     x86_64_start_kernel+0x143/0x1c0 arch/x86/kernel/head64.c:291
                     common_startup_64+0x13e/0x147
  }
  ... key      at: [<ffffffff8e96ee78>] kbd_event_lock+0x18/0xa0 keyboard.c:-1
-> (&tty->flow.lock){....}-{3:3} {
   INITIAL USE at:
                   lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
                   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                   _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
                   class_spinlock_irqsave_constructor include/linux/spinlock.h:585 [inline]
                   start_tty+0x20/0x70 drivers/tty/tty_io.c:793
                   n_tty_set_termios+0xa7c/0x1090 drivers/tty/n_tty.c:1858
                   tty_set_termios+0xda4/0x17e0 drivers/tty/tty_ioctl.c:348
                   set_termios+0x516/0x6c0 drivers/tty/tty_ioctl.c:516
                   tty_mode_ioctl+0x47e/0x740 drivers/tty/tty_ioctl.c:-1
                   tty_ioctl+0x9c6/0xde0 drivers/tty/tty_io.c:2801
                   vfs_ioctl fs/ioctl.c:51 [inline]
                   __do_sys_ioctl fs/ioctl.c:597 [inline]
                   __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
                   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                   do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
                   entry_SYSCALL_64_after_hwframe+0x77/0x7f
 }
 ... key      at: [<ffffffff99d18ce0>] alloc_tty_struct.__key.35+0x0/0x20
 ... acquired at:
   lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
   class_spinlock_irqsave_constructor include/linux/spinlock.h:585 [inline]
   stop_tty+0x2f/0x150 drivers/tty/tty_io.c:765
   kbd_keycode drivers/tty/vt/keyboard.c:1515 [inline]
   kbd_event+0x2b72/0x3f70 drivers/tty/vt/keyboard.c:1534
   input_handle_events_default+0xd4/0x1a0 drivers/input/input.c:2541
   input_pass_values+0x288/0x890 drivers/input/input.c:128
   input_event_dispose+0x330/0x6b0 drivers/input/input.c:342
   input_inject_event+0x1dd/0x340 drivers/input/input.c:424
   evdev_write+0x2fc/0x480 drivers/input/evdev.c:528
   vfs_write+0x27e/0xb30 fs/read_write.c:684
   ksys_write+0x145/0x250 fs/read_write.c:738
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f


the dependencies between the lock to be acquired
 and SOFTIRQ-irq-unsafe lock:
  -> (tasklist_lock){.+.+}-{3:3} {
     HARDIRQ-ON-R at:
                        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
                        __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                        _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                        __do_wait+0xde/0x740 kernel/exit.c:1667
                        do_wait+0x1f8/0x510 kernel/exit.c:1711
                        kernel_wait+0xab/0x170 kernel/exit.c:1887
                        call_usermodehelper_exec_sync kernel/umh.c:136 [inline]
                        call_usermodehelper_exec_work+0xbe/0x230 kernel/umh.c:163
                        process_one_work kernel/workqueue.c:3263 [inline]
                        process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
                        worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
                        kthread+0x711/0x8a0 kernel/kthread.c:463
                        ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
                        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
     SOFTIRQ-ON-R at:
                        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
                        __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                        _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                        __do_wait+0xde/0x740 kernel/exit.c:1667
                        do_wait+0x1f8/0x510 kernel/exit.c:1711
                        kernel_wait+0xab/0x170 kernel/exit.c:1887
                        call_usermodehelper_exec_sync kernel/umh.c:136 [inline]
                        call_usermodehelper_exec_work+0xbe/0x230 kernel/umh.c:163
                        process_one_work kernel/workqueue.c:3263 [inline]
                        process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
                        worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
                        kthread+0x711/0x8a0 kernel/kthread.c:463
                        ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
                        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
     INITIAL USE at:
                       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
                       __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                       _raw_write_lock_irq+0xa2/0xf0 kernel/locking/spinlock.c:326
                       copy_process+0x224f/0x3c00 kernel/fork.c:2327
                       kernel_clone+0x21e/0x840 kernel/fork.c:2609
                       user_mode_thread+0xdd/0x140 kernel/fork.c:2685
                       rest_init+0x23/0x300 init/main.c:722
                       start_kernel+0x3ae/0x410 init/main.c:1111
                       x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
                       x86_64_start_kernel+0x143/0x1c0 arch/x86/kernel/head64.c:291
                       common_startup_64+0x13e/0x147
     INITIAL READ USE at:
                            lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
                            __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                            _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                            __do_wait+0xde/0x740 kernel/exit.c:1667
                            do_wait+0x1f8/0x510 kernel/exit.c:1711
                            kernel_wait+0xab/0x170 kernel/exit.c:1887
                            call_usermodehelper_exec_sync kernel/umh.c:136 [inline]
                            call_usermodehelper_exec_work+0xbe/0x230 kernel/umh.c:163
                            process_one_work kernel/workqueue.c:3263 [inline]
                            process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
                            worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
                            kthread+0x711/0x8a0 kernel/kthread.c:463
                            ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
                            ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
   }
   ... key      at: [<ffffffff8de0c058>] tasklist_lock+0x18/0x40
   ... acquired at:
   lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
   __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
   _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
   send_sigio+0x101/0x370 fs/fcntl.c:919
   dnotify_handle_event+0x169/0x440 fs/notify/dnotify/dnotify.c:113
   fsnotify_handle_event fs/notify/fsnotify.c:350 [inline]
   send_to_group fs/notify/fsnotify.c:424 [inline]
   fsnotify+0x1671/0x1a80 fs/notify/fsnotify.c:641
   __fsnotify_parent+0x3fe/0x540 fs/notify/fsnotify.c:287
   fsnotify_parent include/linux/fsnotify.h:96 [inline]
   fsnotify_path include/linux/fsnotify.h:113 [inline]
   fsnotify_file include/linux/fsnotify.h:127 [inline]
   fsnotify_modify include/linux/fsnotify.h:433 [inline]
   vfs_writev+0x77d/0x960 fs/read_write.c:1061
   do_pwritev fs/read_write.c:1153 [inline]
   __do_sys_pwritev2 fs/read_write.c:1211 [inline]
   __se_sys_pwritev2+0x179/0x290 fs/read_write.c:1202
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

 -> (&f_owner->lock){....}-{3:3} {
    INITIAL USE at:
                     lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
                     __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                     _raw_write_lock_irq+0xa2/0xf0 kernel/locking/spinlock.c:326
                     __f_setown+0x67/0x370 fs/fcntl.c:136
                     fcntl_dirnotify+0x3fa/0x6a0 fs/notify/dnotify/dnotify.c:369
                     do_fcntl+0x6d0/0x1910 fs/fcntl.c:537
                     __do_sys_fcntl fs/fcntl.c:589 [inline]
                     __se_sys_fcntl+0xc8/0x150 fs/fcntl.c:574
                     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                     do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
                     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    INITIAL READ USE at:
                          lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
                          __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
                          _raw_read_lock_irqsave+0xaf/0x100 kernel/locking/spinlock.c:236
                          send_sigio+0x38/0x370 fs/fcntl.c:905
                          kill_fasync_rcu fs/fcntl.c:1131 [inline]
                          kill_fasync+0x24d/0x4d0 fs/fcntl.c:1146
                          lease_break_callback+0x26/0x30 fs/locks.c:558
                          __break_lease+0x6a5/0x1620 fs/locks.c:1592
                          break_lease include/linux/filelock.h:446 [inline]
                          do_dentry_open+0x8b7/0x13f0 fs/open.c:956
                          vfs_open+0x3b/0x340 fs/open.c:1097
                          do_open fs/namei.c:3975 [inline]
                          path_openat+0x2ee5/0x3830 fs/namei.c:4134
                          do_filp_open+0x1fa/0x410 fs/namei.c:4161
                          do_sys_openat2+0x121/0x1c0 fs/open.c:1437
                          do_sys_open fs/open.c:1452 [inline]
                          __do_sys_open fs/open.c:1460 [inline]
                          __se_sys_open fs/open.c:1456 [inline]
                          __x64_sys_open+0x11e/0x150 fs/open.c:1456
                          do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                          do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
                          entry_SYSCALL_64_after_hwframe+0x77/0x7f
  }
  ... key      at: [<ffffffff99a3b880>] file_f_owner_allocate.__key+0x0/0x20
  ... acquired at:
   lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0xaf/0x100 kernel/locking/spinlock.c:236
   send_sigio+0x38/0x370 fs/fcntl.c:905
   kill_fasync_rcu fs/fcntl.c:1131 [inline]
   kill_fasync+0x24d/0x4d0 fs/fcntl.c:1146
   lease_break_callback+0x26/0x30 fs/locks.c:558
   __break_lease+0x6a5/0x1620 fs/locks.c:1592
   break_lease include/linux/filelock.h:446 [inline]
   do_dentry_open+0x8b7/0x13f0 fs/open.c:956
   vfs_open+0x3b/0x340 fs/open.c:1097
   do_open fs/namei.c:3975 [inline]
   path_openat+0x2ee5/0x3830 fs/namei.c:4134
   do_filp_open+0x1fa/0x410 fs/namei.c:4161
   do_sys_openat2+0x121/0x1c0 fs/open.c:1437
   do_sys_open fs/open.c:1452 [inline]
   __do_sys_open fs/open.c:1460 [inline]
   __se_sys_open fs/open.c:1456 [inline]
   __x64_sys_open+0x11e/0x150 fs/open.c:1456
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> (&new->fa_lock){....}-{3:3} {
   INITIAL USE at:
                   lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                   _raw_write_lock_irq+0xa2/0xf0 kernel/locking/spinlock.c:326
                   fasync_remove_entry+0xf1/0x1c0 fs/fcntl.c:999
                   pipe_fasync+0xa9/0x1e0 fs/pipe.c:756
                   __fput+0x8a2/0xa70 fs/file_table.c:465
                   task_work_run+0x1d4/0x260 kernel/task_work.c:227
                   resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
                   exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
                   exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
                   syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
                   syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
                   do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
                   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   INITIAL READ USE at:
                        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
                        __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
                        _raw_read_lock_irqsave+0xaf/0x100 kernel/locking/spinlock.c:236
                        kill_fasync_rcu fs/fcntl.c:1122 [inline]
                        kill_fasync+0x199/0x4d0 fs/fcntl.c:1146
                        sock_wake_async+0x137/0x160 net/socket.c:-1
                        sk_wake_async+0x184/0x280 include/net/sock.h:2539
                        mptcp_destroy_common+0x152/0x320 net/mptcp/protocol.c:3385
                        mptcp_disconnect+0x23d/0x700 net/mptcp/protocol.c:3197
                        inet_shutdown+0x1c4/0x390 net/ipv4/af_inet.c:937
                        __sys_shutdown_sock net/socket.c:2470 [inline]
                        __sys_shutdown net/socket.c:2486 [inline]
                        __do_sys_shutdown net/socket.c:2491 [inline]
                        __se_sys_shutdown net/socket.c:2489 [inline]
                        __x64_sys_shutdown+0x13f/0x1a0 net/socket.c:2489
                        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                        do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
                        entry_SYSCALL_64_after_hwframe+0x77/0x7f
 }
 ... key      at: [<ffffffff99a3b8a0>] fasync_insert_entry.__key+0x0/0x20
 ... acquired at:
   lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0xaf/0x100 kernel/locking/spinlock.c:236
   kill_fasync_rcu fs/fcntl.c:1122 [inline]
   kill_fasync+0x199/0x4d0 fs/fcntl.c:1146
   tty_wakeup drivers/tty/tty_io.c:515 [inline]
   __start_tty+0x18c/0x220 drivers/tty/tty_io.c:777
   start_tty+0x2b/0x70 drivers/tty/tty_io.c:794
   n_tty_set_termios+0xa7c/0x1090 drivers/tty/n_tty.c:1858
   tty_set_termios+0xda4/0x17e0 drivers/tty/tty_ioctl.c:348
   set_termios+0x516/0x6c0 drivers/tty/tty_ioctl.c:516
   tty_mode_ioctl+0x47e/0x740 drivers/tty/tty_ioctl.c:-1
   tty_ioctl+0x9c6/0xde0 drivers/tty/tty_io.c:2801
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:597 [inline]
   __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f


stack backtrace:
CPU: 0 UID: 0 PID: 28053 Comm: syz.8.7222 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_bad_irq_dependency kernel/locking/lockdep.c:2616 [inline]
 check_irq_usage kernel/locking/lockdep.c:2857 [inline]
 check_prev_add kernel/locking/lockdep.c:3169 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain+0x1f05/0x2140 kernel/locking/lockdep.c:3908
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
 _raw_read_lock_irqsave+0xaf/0x100 kernel/locking/spinlock.c:236
 kill_fasync_rcu fs/fcntl.c:1122 [inline]
 kill_fasync+0x199/0x4d0 fs/fcntl.c:1146
 tty_wakeup drivers/tty/tty_io.c:515 [inline]
 __start_tty+0x18c/0x220 drivers/tty/tty_io.c:777
 start_tty+0x2b/0x70 drivers/tty/tty_io.c:794
 n_tty_set_termios+0xa7c/0x1090 drivers/tty/n_tty.c:1858
 tty_set_termios+0xda4/0x17e0 drivers/tty/tty_ioctl.c:348
 set_termios+0x516/0x6c0 drivers/tty/tty_ioctl.c:516
 tty_mode_ioctl+0x47e/0x740 drivers/tty/tty_ioctl.c:-1
 tty_ioctl+0x9c6/0xde0 drivers/tty/tty_io.c:2801
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f157ff8eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1580d69038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f15801e6090 RCX: 00007f157ff8eec9
RDX: 0000200000000140 RSI: 0000000000005402 RDI: 0000000000000004
RBP: 00007f1580011f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f15801e6128 R14: 00007f15801e6090 R15: 00007f158030fa28
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

