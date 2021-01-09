Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64212EFF47
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jan 2021 12:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbhAILz5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Jan 2021 06:55:57 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:45454 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbhAILz5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Jan 2021 06:55:57 -0500
Received: by mail-io1-f71.google.com with SMTP id x7so9835957ion.12
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 Jan 2021 03:55:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GQo8awZrNulUwwW60nN52gIoQaCxvxLhCdn1YoCnMJ0=;
        b=k7tkQfVHISwQ1GXjVGuXNkRjNEEMJeOHxfFHRh8e8hpYlKKdltyJgG6DM1AmPBNb9E
         jWZA5VA2V3kopbqmFzZAfW8dp1/J2jXHnPeJzYvNNzEQDaqdGP9AzMBbfJrV3Ch4IGxY
         aX3+BMpLaJ6mza40joDjjhn8+mU7Dkgi9iS8VxYytvmy6GhIlwQTwufh7PvA3FD27Ub+
         joYy9j/bBpRIbJcOCA59/CEQAjnm1ElLPWZeAqLIs7oNwQ237RIaaXntFkh7W+P4+arp
         J3hvquC38JKIDUvMKDQU824YulSulK5OO3y69jDTGFE0F1dKhrcV8THLNaFR9suFDGjj
         idow==
X-Gm-Message-State: AOAM531Mqvs1//p0HBK6Q1bDqYNuh5rUvtN5jEtVN8xg2aVj7VsPZYK9
        1mCa9KS+ZH6q7wlLiZy1PeR2tvz+NzSDLArKhBVNPnUffe1a
X-Google-Smtp-Source: ABdhPJxvXotfEYQded/3vGEJC95N8H37CbUxphf7hhi8IPzrGUOz7DrIhixblOEkasbChqxcUfGnBFPfH7mLeZ57dgizgXfBml3q
MIME-Version: 1.0
X-Received: by 2002:a02:7650:: with SMTP id z77mr7298624jab.134.1610193314888;
 Sat, 09 Jan 2021 03:55:14 -0800 (PST)
Date:   Sat, 09 Jan 2021 03:55:14 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008dc55b05b8765806@google.com>
Subject: possible deadlock in evdev_pass_values
From:   syzbot <syzbot+44ec99f248f7052472f1@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6207214a Merge tag 'afs-fixes-04012021' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16558750d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8aa30b9da402d224
dashboard link: https://syzkaller.appspot.com/bug?extid=44ec99f248f7052472f1
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+44ec99f248f7052472f1@syzkaller.appspotmail.com

=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
5.11.0-rc2-syzkaller #0 Not tainted
-----------------------------------------------------
syz-executor.4/17012 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffff888013a7f210 (&new->fa_lock){.+.+}-{2:2}, at: kill_fasync_rcu fs/fcntl.c:1004 [inline]
ffff888013a7f210 (&new->fa_lock){.+.+}-{2:2}, at: kill_fasync fs/fcntl.c:1025 [inline]
ffff888013a7f210 (&new->fa_lock){.+.+}-{2:2}, at: kill_fasync+0x14b/0x460 fs/fcntl.c:1018

and this task is already holding:
ffff88806c53b028 (&client->buffer_lock){..-.}-{2:2}, at: spin_lock include/linux/spinlock.h:354 [inline]
ffff88806c53b028 (&client->buffer_lock){..-.}-{2:2}, at: evdev_pass_values.part.0+0xf6/0x970 drivers/input/evdev.c:261
which would create a new lock dependency:
 (&client->buffer_lock){..-.}-{2:2} -> (&new->fa_lock){.+.+}-{2:2}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (&client->buffer_lock){..-.}-{2:2}

... which became SOFTIRQ-irq-safe at:
  lock_acquire kernel/locking/lockdep.c:5437 [inline]
  lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
  _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
  spin_lock include/linux/spinlock.h:354 [inline]
  evdev_pass_values.part.0+0xf6/0x970 drivers/input/evdev.c:261
  evdev_pass_values drivers/input/evdev.c:253 [inline]
  evdev_events+0x28b/0x3f0 drivers/input/evdev.c:306
  input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
  input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
  input_pass_values drivers/input/input.c:134 [inline]
  input_handle_event+0x373/0x1440 drivers/input/input.c:404
  input_event drivers/input/input.c:446 [inline]
  input_event+0x8e/0xb0 drivers/input/input.c:438
  input_sync include/linux/input.h:450 [inline]
  usbtouch_process_pkt+0x25c/0x460 drivers/input/touchscreen/usbtouchscreen.c:1404
  usbtouch_irq+0x192/0x380 drivers/input/touchscreen/usbtouchscreen.c:1517
  __usb_hcd_giveback_urb+0x2b0/0x5c0 drivers/usb/core/hcd.c:1657
  usb_hcd_giveback_urb+0x367/0x410 drivers/usb/core/hcd.c:1728
  dummy_timer+0x11f4/0x3280 drivers/usb/gadget/udc/dummy_hcd.c:1971
  call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1417
  expire_timers kernel/time/timer.c:1462 [inline]
  __run_timers.part.0+0x67c/0xa50 kernel/time/timer.c:1731
  __run_timers kernel/time/timer.c:1712 [inline]
  run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1744
  __do_softirq+0x2a5/0x9f7 kernel/softirq.c:343
  asm_call_irq_on_stack+0xf/0x20
  __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
  run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
  do_softirq_own_stack+0xaa/0xd0 arch/x86/kernel/irq_64.c:77
  invoke_softirq kernel/softirq.c:226 [inline]
  __irq_exit_rcu kernel/softirq.c:420 [inline]
  irq_exit_rcu+0x134/0x200 kernel/softirq.c:432
  sysvec_apic_timer_interrupt+0x4d/0x100 arch/x86/kernel/apic/apic.c:1096
  asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:628
  __orc_find+0x0/0xf0 include/asm-generic/rwonce.h:68
  orc_find arch/x86/kernel/unwind_orc.c:173 [inline]
  unwind_next_frame+0x342/0x1f90 arch/x86/kernel/unwind_orc.c:443
  arch_stack_walk+0x7d/0xe0 arch/x86/kernel/stacktrace.c:25
  stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:121
  kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
  kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
  kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:356
  ____kasan_slab_free+0xe1/0x110 mm/kasan/common.c:362
  kasan_slab_free include/linux/kasan.h:188 [inline]
  slab_free_hook mm/slub.c:1547 [inline]
  slab_free_freelist_hook+0x5d/0x150 mm/slub.c:1580
  slab_free mm/slub.c:3142 [inline]
  kfree+0xdb/0x360 mm/slub.c:4124
  tomoyo_realpath_from_path+0x191/0x620 security/tomoyo/realpath.c:291
  tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
  tomoyo_path_perm+0x21b/0x400 security/tomoyo/file.c:822
  security_inode_getattr+0xcf/0x140 security/security.c:1280
  vfs_getattr fs/stat.c:121 [inline]
  vfs_statx+0x164/0x390 fs/stat.c:189
  vfs_fstatat fs/stat.c:207 [inline]
  vfs_lstat include/linux/fs.h:3122 [inline]
  __do_sys_newlstat+0x91/0x110 fs/stat.c:362
  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

to a SOFTIRQ-irq-unsafe lock:
 (&new->fa_lock){.+.+}-{2:2}

... which became SOFTIRQ-irq-unsafe at:
...
  lock_acquire kernel/locking/lockdep.c:5437 [inline]
  lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
  __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
  _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
  kill_fasync_rcu fs/fcntl.c:1004 [inline]
  kill_fasync fs/fcntl.c:1025 [inline]
  kill_fasync+0x14b/0x460 fs/fcntl.c:1018
  fsnotify_add_event+0x398/0x4e0 fs/notify/notification.c:127
  inotify_handle_inode_event+0x340/0x5f0 fs/notify/inotify/inotify_fsnotify.c:118
  fsnotify_handle_inode_event.isra.0+0x1b8/0x270 fs/notify/fsnotify.c:263
  fsnotify_handle_event fs/notify/fsnotify.c:310 [inline]
  send_to_group fs/notify/fsnotify.c:364 [inline]
  fsnotify+0xbf0/0x1070 fs/notify/fsnotify.c:541
  fsnotify_parent include/linux/fsnotify.h:71 [inline]
  fsnotify_file include/linux/fsnotify.h:90 [inline]
  fsnotify_open include/linux/fsnotify.h:268 [inline]
  do_sys_openat2+0x3a3/0x420 fs/open.c:1177
  do_sys_open fs/open.c:1188 [inline]
  __do_sys_open fs/open.c:1196 [inline]
  __se_sys_open fs/open.c:1192 [inline]
  __x64_sys_open+0x119/0x1c0 fs/open.c:1192
  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&new->fa_lock);
                               local_irq_disable();
                               lock(&client->buffer_lock);
                               lock(&new->fa_lock);
  <Interrupt>
    lock(&client->buffer_lock);

 *** DEADLOCK ***

7 locks held by syz-executor.4/17012:
 #0: ffff888144ee5110 (&evdev->mutex){+.+.}-{3:3}, at: evdev_write+0x1d3/0x760 drivers/input/evdev.c:513
 #1: ffff888017aea230 (&dev->event_lock){-.-.}-{2:2}, at: input_inject_event+0xa6/0x310 drivers/input/input.c:471
 #2: ffffffff8b363860 (rcu_read_lock){....}-{1:2}, at: is_event_supported drivers/input/input.c:53 [inline]
 #2: ffffffff8b363860 (rcu_read_lock){....}-{1:2}, at: is_event_supported drivers/input/input.c:50 [inline]
 #2: ffffffff8b363860 (rcu_read_lock){....}-{1:2}, at: input_inject_event+0x92/0x310 drivers/input/input.c:470
 #3: ffffffff8b363860 (rcu_read_lock){....}-{1:2}, at: input_pass_values.part.0+0x0/0x700 drivers/input/input.c:837
 #4: ffffffff8b363860 (rcu_read_lock){....}-{1:2}, at: evdev_events+0x59/0x3f0 drivers/input/evdev.c:296
 #5: ffff88806c53b028 (&client->buffer_lock){..-.}-{2:2}, at: spin_lock include/linux/spinlock.h:354 [inline]
 #5: ffff88806c53b028 (&client->buffer_lock){..-.}-{2:2}, at: evdev_pass_values.part.0+0xf6/0x970 drivers/input/evdev.c:261
 #6: ffffffff8b363860 (rcu_read_lock){....}-{1:2}, at: kill_fasync+0x3d/0x460 fs/fcntl.c:1023

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
-> (&client->buffer_lock){..-.}-{2:2} {
   IN-SOFTIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5437 [inline]
                    lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
                    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                    _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
                    spin_lock include/linux/spinlock.h:354 [inline]
                    evdev_pass_values.part.0+0xf6/0x970 drivers/input/evdev.c:261
                    evdev_pass_values drivers/input/evdev.c:253 [inline]
                    evdev_events+0x28b/0x3f0 drivers/input/evdev.c:306
                    input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
                    input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
                    input_pass_values drivers/input/input.c:134 [inline]
                    input_handle_event+0x373/0x1440 drivers/input/input.c:404
                    input_event drivers/input/input.c:446 [inline]
                    input_event+0x8e/0xb0 drivers/input/input.c:438
                    input_sync include/linux/input.h:450 [inline]
                    usbtouch_process_pkt+0x25c/0x460 drivers/input/touchscreen/usbtouchscreen.c:1404
                    usbtouch_irq+0x192/0x380 drivers/input/touchscreen/usbtouchscreen.c:1517
                    __usb_hcd_giveback_urb+0x2b0/0x5c0 drivers/usb/core/hcd.c:1657
                    usb_hcd_giveback_urb+0x367/0x410 drivers/usb/core/hcd.c:1728
                    dummy_timer+0x11f4/0x3280 drivers/usb/gadget/udc/dummy_hcd.c:1971
                    call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1417
                    expire_timers kernel/time/timer.c:1462 [inline]
                    __run_timers.part.0+0x67c/0xa50 kernel/time/timer.c:1731
                    __run_timers kernel/time/timer.c:1712 [inline]
                    run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1744
                    __do_softirq+0x2a5/0x9f7 kernel/softirq.c:343
                    asm_call_irq_on_stack+0xf/0x20
                    __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
                    run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
                    do_softirq_own_stack+0xaa/0xd0 arch/x86/kernel/irq_64.c:77
                    invoke_softirq kernel/softirq.c:226 [inline]
                    __irq_exit_rcu kernel/softirq.c:420 [inline]
                    irq_exit_rcu+0x134/0x200 kernel/softirq.c:432
                    sysvec_apic_timer_interrupt+0x4d/0x100 arch/x86/kernel/apic/apic.c:1096
                    asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:628
                    __orc_find+0x0/0xf0 include/asm-generic/rwonce.h:68
                    orc_find arch/x86/kernel/unwind_orc.c:173 [inline]
                    unwind_next_frame+0x342/0x1f90 arch/x86/kernel/unwind_orc.c:443
                    arch_stack_walk+0x7d/0xe0 arch/x86/kernel/stacktrace.c:25
                    stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:121
                    kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
                    kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
                    kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:356
                    ____kasan_slab_free+0xe1/0x110 mm/kasan/common.c:362
                    kasan_slab_free include/linux/kasan.h:188 [inline]
                    slab_free_hook mm/slub.c:1547 [inline]
                    slab_free_freelist_hook+0x5d/0x150 mm/slub.c:1580
                    slab_free mm/slub.c:3142 [inline]
                    kfree+0xdb/0x360 mm/slub.c:4124
                    tomoyo_realpath_from_path+0x191/0x620 security/tomoyo/realpath.c:291
                    tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
                    tomoyo_path_perm+0x21b/0x400 security/tomoyo/file.c:822
                    security_inode_getattr+0xcf/0x140 security/security.c:1280
                    vfs_getattr fs/stat.c:121 [inline]
                    vfs_statx+0x164/0x390 fs/stat.c:189
                    vfs_fstatat fs/stat.c:207 [inline]
                    vfs_lstat include/linux/fs.h:3122 [inline]
                    __do_sys_newlstat+0x91/0x110 fs/stat.c:362
                    do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                    entry_SYSCALL_64_after_hwframe+0x44/0xa9
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5437 [inline]
                   lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
                   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                   _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
                   spin_lock include/linux/spinlock.h:354 [inline]
                   evdev_pass_values.part.0+0xf6/0x970 drivers/input/evdev.c:261
                   evdev_pass_values drivers/input/evdev.c:253 [inline]
                   evdev_events+0x28b/0x3f0 drivers/input/evdev.c:306
                   input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
                   input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
                   input_pass_values drivers/input/input.c:134 [inline]
                   input_handle_event+0x373/0x1440 drivers/input/input.c:404
                   input_inject_event+0x2f5/0x310 drivers/input/input.c:476
                   evdev_write+0x430/0x760 drivers/input/evdev.c:530
                   vfs_write+0x28e/0xa30 fs/read_write.c:603
                   ksys_write+0x1ee/0x250 fs/read_write.c:658
                   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                   entry_SYSCALL_64_after_hwframe+0x44/0xa9
 }
 ... key      at: [<ffffffff8fa51420>] __key.4+0x0/0x40
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5437 [inline]
   lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
   __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
   _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
   kill_fasync_rcu fs/fcntl.c:1004 [inline]
   kill_fasync fs/fcntl.c:1025 [inline]
   kill_fasync+0x14b/0x460 fs/fcntl.c:1018
   __pass_event drivers/input/evdev.c:240 [inline]
   evdev_pass_values.part.0+0x64e/0x970 drivers/input/evdev.c:278
   evdev_pass_values drivers/input/evdev.c:253 [inline]
   evdev_events+0x28b/0x3f0 drivers/input/evdev.c:306
   input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
   input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
   input_pass_values drivers/input/input.c:134 [inline]
   input_handle_event+0x373/0x1440 drivers/input/input.c:404
   input_inject_event+0x2f5/0x310 drivers/input/input.c:476
   evdev_write+0x430/0x760 drivers/input/evdev.c:530
   vfs_write+0x28e/0xa30 fs/read_write.c:603
   ksys_write+0x1ee/0x250 fs/read_write.c:658
   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
   entry_SYSCALL_64_after_hwframe+0x44/0xa9


the dependencies between the lock to be acquired
 and SOFTIRQ-irq-unsafe lock:
-> (&new->fa_lock){.+.+}-{2:2} {
   HARDIRQ-ON-R at:
                    lock_acquire kernel/locking/lockdep.c:5437 [inline]
                    lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
                    __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                    _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
                    kill_fasync_rcu fs/fcntl.c:1004 [inline]
                    kill_fasync fs/fcntl.c:1025 [inline]
                    kill_fasync+0x14b/0x460 fs/fcntl.c:1018
                    fsnotify_add_event+0x398/0x4e0 fs/notify/notification.c:127
                    inotify_handle_inode_event+0x340/0x5f0 fs/notify/inotify/inotify_fsnotify.c:118
                    fsnotify_handle_inode_event.isra.0+0x1b8/0x270 fs/notify/fsnotify.c:263
                    fsnotify_handle_event fs/notify/fsnotify.c:310 [inline]
                    send_to_group fs/notify/fsnotify.c:364 [inline]
                    fsnotify+0xbf0/0x1070 fs/notify/fsnotify.c:541
                    fsnotify_parent include/linux/fsnotify.h:71 [inline]
                    fsnotify_file include/linux/fsnotify.h:90 [inline]
                    fsnotify_open include/linux/fsnotify.h:268 [inline]
                    do_sys_openat2+0x3a3/0x420 fs/open.c:1177
                    do_sys_open fs/open.c:1188 [inline]
                    __do_sys_open fs/open.c:1196 [inline]
                    __se_sys_open fs/open.c:1192 [inline]
                    __x64_sys_open+0x119/0x1c0 fs/open.c:1192
                    do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                    entry_SYSCALL_64_after_hwframe+0x44/0xa9
   SOFTIRQ-ON-R at:
                    lock_acquire kernel/locking/lockdep.c:5437 [inline]
                    lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
                    __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                    _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
                    kill_fasync_rcu fs/fcntl.c:1004 [inline]
                    kill_fasync fs/fcntl.c:1025 [inline]
                    kill_fasync+0x14b/0x460 fs/fcntl.c:1018
                    fsnotify_add_event+0x398/0x4e0 fs/notify/notification.c:127
                    inotify_handle_inode_event+0x340/0x5f0 fs/notify/inotify/inotify_fsnotify.c:118
                    fsnotify_handle_inode_event.isra.0+0x1b8/0x270 fs/notify/fsnotify.c:263
                    fsnotify_handle_event fs/notify/fsnotify.c:310 [inline]
                    send_to_group fs/notify/fsnotify.c:364 [inline]
                    fsnotify+0xbf0/0x1070 fs/notify/fsnotify.c:541
                    fsnotify_parent include/linux/fsnotify.h:71 [inline]
                    fsnotify_file include/linux/fsnotify.h:90 [inline]
                    fsnotify_open include/linux/fsnotify.h:268 [inline]
                    do_sys_openat2+0x3a3/0x420 fs/open.c:1177
                    do_sys_open fs/open.c:1188 [inline]
                    __do_sys_open fs/open.c:1196 [inline]
                    __se_sys_open fs/open.c:1192 [inline]
                    __x64_sys_open+0x119/0x1c0 fs/open.c:1192
                    do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                    entry_SYSCALL_64_after_hwframe+0x44/0xa9
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5437 [inline]
                   lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:196 [inline]
                   _raw_write_lock_irq+0x32/0x50 kernel/locking/spinlock.c:311
                   fasync_remove_entry+0xb6/0x1f0 fs/fcntl.c:882
                   fasync_helper+0x9e/0xb0 fs/fcntl.c:985
                   fsnotify_fasync+0x4d/0x80 fs/notify/group.c:148
                   __fput+0x70d/0x920 fs/file_table.c:277
                   task_work_run+0xdd/0x190 kernel/task_work.c:140
                   tracehook_notify_resume include/linux/tracehook.h:189 [inline]
                   exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
                   exit_to_user_mode_prepare+0x249/0x250 kernel/entry/common.c:201
                   __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
                   syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:302
                   entry_SYSCALL_64_after_hwframe+0x44/0xa9
   INITIAL READ USE at:
                        lock_acquire kernel/locking/lockdep.c:5437 [inline]
                        lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
                        __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                        _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
                        kill_fasync_rcu fs/fcntl.c:1004 [inline]
                        kill_fasync fs/fcntl.c:1025 [inline]
                        kill_fasync+0x14b/0x460 fs/fcntl.c:1018
                        fsnotify_add_event+0x398/0x4e0 fs/notify/notification.c:127
                        inotify_handle_inode_event+0x340/0x5f0 fs/notify/inotify/inotify_fsnotify.c:118
                        fsnotify_handle_inode_event.isra.0+0x1b8/0x270 fs/notify/fsnotify.c:263
                        fsnotify_handle_event fs/notify/fsnotify.c:310 [inline]
                        send_to_group fs/notify/fsnotify.c:364 [inline]
                        fsnotify+0xbf0/0x1070 fs/notify/fsnotify.c:541
                        fsnotify_parent include/linux/fsnotify.h:71 [inline]
                        fsnotify_file include/linux/fsnotify.h:90 [inline]
                        fsnotify_open include/linux/fsnotify.h:268 [inline]
                        do_sys_openat2+0x3a3/0x420 fs/open.c:1177
                        do_sys_open fs/open.c:1188 [inline]
                        __do_sys_open fs/open.c:1196 [inline]
                        __se_sys_open fs/open.c:1192 [inline]
                        __x64_sys_open+0x119/0x1c0 fs/open.c:1192
                        do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                        entry_SYSCALL_64_after_hwframe+0x44/0xa9
 }
 ... key      at: [<ffffffff8ef8d980>] __key.0+0x0/0x40
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5437 [inline]
   lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
   __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
   _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
   kill_fasync_rcu fs/fcntl.c:1004 [inline]
   kill_fasync fs/fcntl.c:1025 [inline]
   kill_fasync+0x14b/0x460 fs/fcntl.c:1018
   __pass_event drivers/input/evdev.c:240 [inline]
   evdev_pass_values.part.0+0x64e/0x970 drivers/input/evdev.c:278
   evdev_pass_values drivers/input/evdev.c:253 [inline]
   evdev_events+0x28b/0x3f0 drivers/input/evdev.c:306
   input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
   input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
   input_pass_values drivers/input/input.c:134 [inline]
   input_handle_event+0x373/0x1440 drivers/input/input.c:404
   input_inject_event+0x2f5/0x310 drivers/input/input.c:476
   evdev_write+0x430/0x760 drivers/input/evdev.c:530
   vfs_write+0x28e/0xa30 fs/read_write.c:603
   ksys_write+0x1ee/0x250 fs/read_write.c:658
   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
   entry_SYSCALL_64_after_hwframe+0x44/0xa9


stack backtrace:
CPU: 0 PID: 17012 Comm: syz-executor.4 Not tainted 5.11.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_bad_irq_dependency kernel/locking/lockdep.c:2452 [inline]
 check_irq_usage.cold+0x4f5/0x6c8 kernel/locking/lockdep.c:2681
 check_prev_add kernel/locking/lockdep.c:2872 [inline]
 check_prevs_add kernel/locking/lockdep.c:2993 [inline]
 validate_chain kernel/locking/lockdep.c:3608 [inline]
 __lock_acquire+0x2af6/0x5500 kernel/locking/lockdep.c:4832
 lock_acquire kernel/locking/lockdep.c:5437 [inline]
 lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
 __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
 _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
 kill_fasync_rcu fs/fcntl.c:1004 [inline]
 kill_fasync fs/fcntl.c:1025 [inline]
 kill_fasync+0x14b/0x460 fs/fcntl.c:1018
 __pass_event drivers/input/evdev.c:240 [inline]
 evdev_pass_values.part.0+0x64e/0x970 drivers/input/evdev.c:278
 evdev_pass_values drivers/input/evdev.c:253 [inline]
 evdev_events+0x28b/0x3f0 drivers/input/evdev.c:306
 input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
 input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
 input_pass_values drivers/input/input.c:134 [inline]
 input_handle_event+0x373/0x1440 drivers/input/input.c:404
 input_inject_event+0x2f5/0x310 drivers/input/input.c:476
 evdev_write+0x430/0x760 drivers/input/evdev.c:530
 vfs_write+0x28e/0xa30 fs/read_write.c:603
 ksys_write+0x1ee/0x250 fs/read_write.c:658
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45e219
Code: 0d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f99a251cc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045e219
RDX: 0000000000000bb8 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 000000000119bfc0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000119bf8c
R13: 00000000016afb5f R14: 00007f99a251d9c0 R15: 000000000119bf8c


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
