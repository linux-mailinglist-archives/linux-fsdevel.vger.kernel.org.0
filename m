Return-Path: <linux-fsdevel+bounces-49811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0243AC315D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 May 2025 22:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8289317BDA5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 May 2025 20:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F12727C172;
	Sat, 24 May 2025 20:38:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A344A24
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 May 2025 20:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748119113; cv=none; b=n+AU69xvNoYGZXUcUDDq885KMPOQMlEY6I37WcZfU3BySNvc+0jEMoHxwnuX8sqZZSHYe4XL+hUx123iObxLVvw7KWl0OLZHqz8uFdv/e7ojou3x0yhwbaFg7EUYguH/WC6eUZSx7DPMX4+t4gRm66jFQITdlarFYeZ1KQrtN2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748119113; c=relaxed/simple;
	bh=f43CwY6r4/UjOvkAtimEfouLcaNoc47QDgU96VN3Bmk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oivQydXu+4PWQvRWTyyMLsjCJgZ01Qbf5XCbbPLv9pUcZo+v1zWBMv104C8lmLZW0yieK5ZDNWbpRH+0SK62fdRY083oDEbAFhNLgDdTN+Q54SSm06vhRiazhegJsEfiL5WHj56ekNwL8wvGPAihx6ahxIXqhKYXabwwFD70q6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-85e4f920dacso78935539f.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 May 2025 13:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748119110; x=1748723910;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dw5z5N7qh6szcVCOIIssv4ImPZrMep9PHqm/DacjQJs=;
        b=eGbQJdoyNgPjWnxFSz6cCZMF/hy9U8/xrSYc+Up+zdDGrtHuE/O0llF7tCyZGkKGTT
         f+KC3Fm5ZrWu5DKT1ydTw2wdGhv5/Vd2VIksUmX9zTNNC7Vhdw4+slxHfcZJutUvEvZB
         Zq1YRGa9NNI7HO+Lcba9okJVkVmSfvI84VpsUeNWYiCtm27kjapNfEuZGYHuq9nIM57O
         wihE9Rjnn5gXB+cc/wXMWmuemQ8gfa6qN9E0PHGskImNnDxDOQyktRDh4qk9qBCVnoVl
         rQZlCEinlYKon+HdYDsvYWI72UZjjFzJD+uN8lEPelYJgN0GVXZ3NxGxba/fQIbR+w+M
         T09g==
X-Forwarded-Encrypted: i=1; AJvYcCUnFDfL4j5W9E0KzkcFoEBnJnDugOO2h+x7r4eI2YJCZlfe2cSGCBWOp2JapaKp//jSu6MPd+OGnYRLD8sw@vger.kernel.org
X-Gm-Message-State: AOJu0YxCtbCI4h7YzB9jvH6MM370b+0fbBXnXLqoXWPFujZ5uktfEwRe
	aMQZ1KDvClDJzn/qfK/5jBYFSajoIDveOaOxPNkAT0KjMOZ//axigysoukVzlmnoa0J5fcp+Vg7
	42BCArQh1WHSNlTQA2/5qBm2CtuapKX9UakY5RNTJZo0vIVufk2sXO60Lkw0=
X-Google-Smtp-Source: AGHT+IETS1FllYSQ/JalKWFy4Ty0Tv7y2DmQt7mMWmymHsaiucMWTph3HlQ01QU/ViOjFDlLLkVRfaihZlfw3uzHp6v2qnNPnkxZ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:b8e:b0:86a:25d5:2db0 with SMTP id
 ca18e2360f4ac-86cbb84161amr477384639f.4.1748119109882; Sat, 24 May 2025
 13:38:29 -0700 (PDT)
Date: Sat, 24 May 2025 13:38:29 -0700
In-Reply-To: <66f6c8ce.050a0220.46d20.001c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68322e45.a70a0220.253bc2.0076.GAE@google.com>
Subject: Re: [syzbot] [fs?] possible deadlock in input_inject_event
From: syzbot <syzbot+79c403850e6816dc39cf@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, amir73il@gmail.com, bfields@fieldses.org, 
	brauner@kernel.org, changlianzhi@uniontech.com, chuck.lever@oracle.com, 
	dakr@kernel.org, dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org, 
	jack@suse.cz, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    4856ebd99715 Merge tag 'drm-fixes-2025-05-24' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11879ad4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9fd1c9848687d742
dashboard link: https://syzkaller.appspot.com/bug?extid=79c403850e6816dc39cf
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126515f4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177dc8e8580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-4856ebd9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/01d4bdc03dd1/vmlinux-4856ebd9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/be7030a85b77/bzImage-4856ebd9.xz

The issue was bisected to:

commit fb09d0ac07725b442b32dbf53f0ab0bea54804e9
Author: lianzhi chang <changlianzhi@uniontech.com>
Date:   Wed Dec 15 12:51:25 2021 +0000

    tty: Fix the keyboard led light display problem

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12ad3cdf980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11ad3cdf980000
console output: https://syzkaller.appspot.com/x/log.txt?x=16ad3cdf980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+79c403850e6816dc39cf@syzkaller.appspotmail.com
Fixes: fb09d0ac0772 ("tty: Fix the keyboard led light display problem")

=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
6.15.0-rc7-syzkaller-00142-g4856ebd99715 #0 Not tainted
-----------------------------------------------------
syz-executor408/5394 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffff8880345bc558 (&new->fa_lock){....}-{3:3}, at: kill_fasync_rcu fs/fcntl.c:1124 [inline]
ffff8880345bc558 (&new->fa_lock){....}-{3:3}, at: kill_fasync+0x199/0x4d0 fs/fcntl.c:1148

and this task is already holding:
ffff88804359a028 (&client->buffer_lock){....}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff88804359a028 (&client->buffer_lock){....}-{3:3}, at: evdev_pass_values+0xb9/0xbd0 drivers/input/evdev.c:261
which would create a new lock dependency:
 (&client->buffer_lock){....}-{3:3} -> (&new->fa_lock){....}-{3:3}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (&dev->event_lock#2){..-.}-{3:3}

... which became SOFTIRQ-irq-safe at:
  lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
  class_spinlock_irqsave_constructor include/linux/spinlock.h:585 [inline]
  input_inject_event+0xab/0x320 drivers/input/input.c:418
  led_trigger_event+0x138/0x210 drivers/leds/led-triggers.c:407
  kbd_propagate_led_state drivers/tty/vt/keyboard.c:1080 [inline]
  kbd_bh+0x1c6/0x2e0 drivers/tty/vt/keyboard.c:1269
  tasklet_action_common+0x36c/0x580 kernel/softirq.c:829
  handle_softirqs+0x286/0x870 kernel/softirq.c:579
  __do_softirq kernel/softirq.c:613 [inline]
  invoke_softirq kernel/softirq.c:453 [inline]
  __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
  irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
  __preempt_count_add arch/x86/include/asm/preempt.h:80 [inline]
  rcu_is_watching+0x10/0xb0 kernel/rcu/tree.c:735
  trace_lock_release include/trace/events/lock.h:69 [inline]
  lock_release+0x4b/0x3e0 kernel/locking/lockdep.c:5877
  rcu_lock_release include/linux/rcupdate.h:341 [inline]
  rcu_read_unlock include/linux/rcupdate.h:871 [inline]
  class_rcu_destructor include/linux/rcupdate.h:1155 [inline]
  unwind_next_frame+0x19a9/0x2390 arch/x86/kernel/unwind_orc.c:680
  arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
  stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
  kasan_save_stack mm/kasan/common.c:47 [inline]
  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
  unpoison_slab_object mm/kasan/common.c:319 [inline]
  __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:345
  kasan_slab_alloc include/linux/kasan.h:250 [inline]
  slab_post_alloc_hook mm/slub.c:4147 [inline]
  slab_alloc_node mm/slub.c:4196 [inline]
  kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4203
  lsm_inode_alloc security/security.c:755 [inline]
  security_inode_alloc+0x39/0x330 security/security.c:1697
  inode_init_always_gfp+0x9ed/0xdc0 fs/inode.c:306
  inode_init_always include/linux/fs.h:3226 [inline]
  alloc_inode+0x82/0x1b0 fs/inode.c:353
  new_inode+0x22/0x170 fs/inode.c:1145
  debugfs_get_inode fs/debugfs/inode.c:72 [inline]
  __debugfs_create_file+0x14d/0x4f0 fs/debugfs/inode.c:447
  debugfs_create_file_unsafe+0x3a/0x50 fs/debugfs/inode.c:523
  add_sta_files net/mac80211/debugfs_netdev.c:849 [inline]
  add_files net/mac80211/debugfs_netdev.c:958 [inline]
  ieee80211_debugfs_add_netdev net/mac80211/debugfs_netdev.c:1011 [inline]
  ieee80211_debugfs_recreate_netdev+0xca1/0x1460 net/mac80211/debugfs_netdev.c:1035
  ieee80211_if_add+0xc17/0x1390 net/mac80211/iface.c:2202
  ieee80211_register_hw+0x350d/0x4120 net/mac80211/main.c:1606
  mac80211_hwsim_new_radio+0x2f0e/0x5340 drivers/net/wireless/virtual/mac80211_hwsim.c:5559
  hwsim_new_radio_nl+0xea4/0x1b10 drivers/net/wireless/virtual/mac80211_hwsim.c:6243
  genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
  genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
  genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
  netlink_rcv_skb+0x21c/0x490 net/netlink/af_netlink.c:2534
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
  netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
  netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
  netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
  sock_sendmsg_nosec net/socket.c:712 [inline]
  __sock_sendmsg+0x219/0x270 net/socket.c:727
  __sys_sendto+0x3bd/0x520 net/socket.c:2180
  __do_sys_sendto net/socket.c:2187 [inline]
  __se_sys_sendto net/socket.c:2183 [inline]
  __x64_sys_sendto+0xde/0x100 net/socket.c:2183
  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
  do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
  entry_SYSCALL_64_after_hwframe+0x77/0x7f

to a SOFTIRQ-irq-unsafe lock:
 (tasklist_lock){.+.+}-{3:3}

... which became SOFTIRQ-irq-unsafe at:
...
  lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
  __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
  _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
  __do_wait+0xde/0x740 kernel/exit.c:1662
  do_wait+0x1f8/0x520 kernel/exit.c:1706
  kernel_wait+0xab/0x170 kernel/exit.c:1882
  call_usermodehelper_exec_sync kernel/umh.c:136 [inline]
  call_usermodehelper_exec_work+0xbe/0x230 kernel/umh.c:163
  process_one_work kernel/workqueue.c:3238 [inline]
  process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
  kthread+0x70e/0x8a0 kernel/kthread.c:464
  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

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

7 locks held by syz-executor408/5394:
 #0: ffff8880363a6118 (&evdev->mutex){+.+.}-{4:4}, at: evdev_write+0x1a1/0x480 drivers/input/evdev.c:511
 #1: ffff88801f34a230 (&dev->event_lock#2){..-.}-{3:3}, at: class_spinlock_irqsave_constructor include/linux/spinlock.h:585 [inline]
 #1: ffff88801f34a230 (&dev->event_lock#2){..-.}-{3:3}, at: input_inject_event+0xab/0x320 drivers/input/input.c:418
 #2: ffffffff8df3dee0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #2: ffffffff8df3dee0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #2: ffffffff8df3dee0 (rcu_read_lock){....}-{1:3}, at: class_rcu_constructor include/linux/rcupdate.h:1155 [inline]
 #2: ffffffff8df3dee0 (rcu_read_lock){....}-{1:3}, at: input_inject_event+0xbc/0x320 drivers/input/input.c:419
 #3: ffffffff8df3dee0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #3: ffffffff8df3dee0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #3: ffffffff8df3dee0 (rcu_read_lock){....}-{1:3}, at: class_rcu_constructor include/linux/rcupdate.h:1155 [inline]
 #3: ffffffff8df3dee0 (rcu_read_lock){....}-{1:3}, at: input_pass_values+0x8d/0x890 drivers/input/input.c:118
 #4: ffffffff8df3dee0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #4: ffffffff8df3dee0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #4: ffffffff8df3dee0 (rcu_read_lock){....}-{1:3}, at: evdev_events+0x79/0x340 drivers/input/evdev.c:298
 #5: ffff88804359a028 (&client->buffer_lock){....}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #5: ffff88804359a028 (&client->buffer_lock){....}-{3:3}, at: evdev_pass_values+0xb9/0xbd0 drivers/input/evdev.c:261
 #6: ffffffff8df3dee0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #6: ffffffff8df3dee0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #6: ffffffff8df3dee0 (rcu_read_lock){....}-{1:3}, at: kill_fasync+0x53/0x4d0 fs/fcntl.c:1147

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
 -> (&dev->event_lock#2){..-.}-{3:3} {
    IN-SOFTIRQ-W at:
                      lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
                      __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                      _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
                      class_spinlock_irqsave_constructor include/linux/spinlock.h:585 [inline]
                      input_inject_event+0xab/0x320 drivers/input/input.c:418
                      led_trigger_event+0x138/0x210 drivers/leds/led-triggers.c:407
                      kbd_propagate_led_state drivers/tty/vt/keyboard.c:1080 [inline]
                      kbd_bh+0x1c6/0x2e0 drivers/tty/vt/keyboard.c:1269
                      tasklet_action_common+0x36c/0x580 kernel/softirq.c:829
                      handle_softirqs+0x286/0x870 kernel/softirq.c:579
                      __do_softirq kernel/softirq.c:613 [inline]
                      invoke_softirq kernel/softirq.c:453 [inline]
                      __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
                      irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
                      instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
                      sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
                      asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                      __preempt_count_add arch/x86/include/asm/preempt.h:80 [inline]
                      rcu_is_watching+0x10/0xb0 kernel/rcu/tree.c:735
                      trace_lock_release include/trace/events/lock.h:69 [inline]
                      lock_release+0x4b/0x3e0 kernel/locking/lockdep.c:5877
                      rcu_lock_release include/linux/rcupdate.h:341 [inline]
                      rcu_read_unlock include/linux/rcupdate.h:871 [inline]
                      class_rcu_destructor include/linux/rcupdate.h:1155 [inline]
                      unwind_next_frame+0x19a9/0x2390 arch/x86/kernel/unwind_orc.c:680
                      arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
                      stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
                      kasan_save_stack mm/kasan/common.c:47 [inline]
                      kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
                      unpoison_slab_object mm/kasan/common.c:319 [inline]
                      __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:345
                      kasan_slab_alloc include/linux/kasan.h:250 [inline]
                      slab_post_alloc_hook mm/slub.c:4147 [inline]
                      slab_alloc_node mm/slub.c:4196 [inline]
                      kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4203
                      lsm_inode_alloc security/security.c:755 [inline]
                      security_inode_alloc+0x39/0x330 security/security.c:1697
                      inode_init_always_gfp+0x9ed/0xdc0 fs/inode.c:306
                      inode_init_always include/linux/fs.h:3226 [inline]
                      alloc_inode+0x82/0x1b0 fs/inode.c:353
                      new_inode+0x22/0x170 fs/inode.c:1145
                      debugfs_get_inode fs/debugfs/inode.c:72 [inline]
                      __debugfs_create_file+0x14d/0x4f0 fs/debugfs/inode.c:447
                      debugfs_create_file_unsafe+0x3a/0x50 fs/debugfs/inode.c:523
                      add_sta_files net/mac80211/debugfs_netdev.c:849 [inline]
                      add_files net/mac80211/debugfs_netdev.c:958 [inline]
                      ieee80211_debugfs_add_netdev net/mac80211/debugfs_netdev.c:1011 [inline]
                      ieee80211_debugfs_recreate_netdev+0xca1/0x1460 net/mac80211/debugfs_netdev.c:1035
                      ieee80211_if_add+0xc17/0x1390 net/mac80211/iface.c:2202
                      ieee80211_register_hw+0x350d/0x4120 net/mac80211/main.c:1606
                      mac80211_hwsim_new_radio+0x2f0e/0x5340 drivers/net/wireless/virtual/mac80211_hwsim.c:5559
                      hwsim_new_radio_nl+0xea4/0x1b10 drivers/net/wireless/virtual/mac80211_hwsim.c:6243
                      genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
                      genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
                      genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
                      netlink_rcv_skb+0x21c/0x490 net/netlink/af_netlink.c:2534
                      genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
                      netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
                      netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
                      netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
                      sock_sendmsg_nosec net/socket.c:712 [inline]
                      __sock_sendmsg+0x219/0x270 net/socket.c:727
                      __sys_sendto+0x3bd/0x520 net/socket.c:2180
                      __do_sys_sendto net/socket.c:2187 [inline]
                      __se_sys_sendto net/socket.c:2183 [inline]
                      __x64_sys_sendto+0xde/0x100 net/socket.c:2183
                      do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                      do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
                      entry_SYSCALL_64_after_hwframe+0x77/0x7f
    INITIAL USE at:
                     lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
                     __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                     _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
                     class_spinlock_irqsave_constructor include/linux/spinlock.h:585 [inline]
                     input_inject_event+0xab/0x320 drivers/input/input.c:418
                     kbd_led_trigger_activate+0xbc/0x100 drivers/tty/vt/keyboard.c:1036
                     led_trigger_set+0x52d/0x950 drivers/leds/led-triggers.c:212
                     led_match_default_trigger drivers/leds/led-triggers.c:269 [inline]
                     led_trigger_set_default+0x215/0x250 drivers/leds/led-triggers.c:287
                     led_classdev_register_ext+0x73d/0x930 drivers/leds/led-class.c:566
                     led_classdev_register include/linux/leds.h:274 [inline]
                     input_leds_connect+0x517/0x790 drivers/input/input-leds.c:145
                     input_attach_handler drivers/input/input.c:993 [inline]
                     input_register_device+0xcee/0x10b0 drivers/input/input.c:2412
                     atkbd_connect+0x70e/0x9c0 drivers/input/keyboard/atkbd.c:1340
                     serio_connect_driver drivers/input/serio/serio.c:43 [inline]
                     serio_driver_probe+0x7f/0xa0 drivers/input/serio/serio.c:747
                     call_driver_probe drivers/base/dd.c:-1 [inline]
                     really_probe+0x26d/0x9a0 drivers/base/dd.c:657
                     __driver_probe_device+0x18c/0x2f0 drivers/base/dd.c:799
                     driver_probe_device+0x4f/0x430 drivers/base/dd.c:829
                     __driver_attach+0x452/0x700 drivers/base/dd.c:1215
                     bus_for_each_dev+0x233/0x2b0 drivers/base/bus.c:370
                     serio_attach_driver drivers/input/serio/serio.c:776 [inline]
                     serio_handle_event+0x1a2/0x860 drivers/input/serio/serio.c:213
                     process_one_work kernel/workqueue.c:3238 [inline]
                     process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
                     worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
                     kthread+0x70e/0x8a0 kernel/kthread.c:464
                     ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
                     ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
  }
  ... key      at: [<ffffffff99b915c0>] input_allocate_device.__key.5+0x0/0x20
-> (&client->buffer_lock){....}-{3:3} {
   INITIAL USE at:
                   lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
                   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                   _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                   spin_lock include/linux/spinlock.h:351 [inline]
                   evdev_pass_values+0xb9/0xbd0 drivers/input/evdev.c:261
                   evdev_events+0x1e6/0x340 drivers/input/evdev.c:306
                   input_pass_values+0x288/0x890 drivers/input/input.c:127
                   input_event_dispose+0x330/0x6b0 drivers/input/input.c:341
                   input_inject_event+0x1fe/0x320 drivers/input/input.c:423
                   evdev_write+0x2fc/0x480 drivers/input/evdev.c:528
                   vfs_write+0x27b/0xa90 fs/read_write.c:682
                   ksys_write+0x145/0x250 fs/read_write.c:736
                   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                   do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
                   entry_SYSCALL_64_after_hwframe+0x77/0x7f
 }
 ... key      at: [<ffffffff99b91860>] evdev_open.__key.25+0x0/0x20
 ... acquired at:
   lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
   _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
   spin_lock include/linux/spinlock.h:351 [inline]
   evdev_pass_values+0xb9/0xbd0 drivers/input/evdev.c:261
   evdev_events+0x1e6/0x340 drivers/input/evdev.c:306
   input_pass_values+0x288/0x890 drivers/input/input.c:127
   input_event_dispose+0x330/0x6b0 drivers/input/input.c:341
   input_inject_event+0x1fe/0x320 drivers/input/input.c:423
   evdev_write+0x2fc/0x480 drivers/input/evdev.c:528
   vfs_write+0x27b/0xa90 fs/read_write.c:682
   ksys_write+0x145/0x250 fs/read_write.c:736
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f


the dependencies between the lock to be acquired
 and SOFTIRQ-irq-unsafe lock:
  -> (tasklist_lock){.+.+}-{3:3} {
     HARDIRQ-ON-R at:
                        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
                        __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                        _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                        __do_wait+0xde/0x740 kernel/exit.c:1662
                        do_wait+0x1f8/0x520 kernel/exit.c:1706
                        kernel_wait+0xab/0x170 kernel/exit.c:1882
                        call_usermodehelper_exec_sync kernel/umh.c:136 [inline]
                        call_usermodehelper_exec_work+0xbe/0x230 kernel/umh.c:163
                        process_one_work kernel/workqueue.c:3238 [inline]
                        process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
                        worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
                        kthread+0x70e/0x8a0 kernel/kthread.c:464
                        ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
                        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
     SOFTIRQ-ON-R at:
                        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
                        __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                        _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                        __do_wait+0xde/0x740 kernel/exit.c:1662
                        do_wait+0x1f8/0x520 kernel/exit.c:1706
                        kernel_wait+0xab/0x170 kernel/exit.c:1882
                        call_usermodehelper_exec_sync kernel/umh.c:136 [inline]
                        call_usermodehelper_exec_work+0xbe/0x230 kernel/umh.c:163
                        process_one_work kernel/workqueue.c:3238 [inline]
                        process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
                        worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
                        kthread+0x70e/0x8a0 kernel/kthread.c:464
                        ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
                        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
     INITIAL USE at:
                       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
                       __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                       _raw_write_lock_irq+0xa2/0xf0 kernel/locking/spinlock.c:326
                       copy_process+0x21d5/0x3b80 kernel/fork.c:2561
                       kernel_clone+0x21e/0x870 kernel/fork.c:2845
                       user_mode_thread+0xdd/0x140 kernel/fork.c:2923
                       rest_init+0x23/0x300 init/main.c:708
                       start_kernel+0x470/0x4f0 init/main.c:1099
                       x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:513
                       x86_64_start_kernel+0x66/0x70 arch/x86/kernel/head64.c:494
                       common_startup_64+0x13e/0x147
     INITIAL READ USE at:
                            lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
                            __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                            _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                            __do_wait+0xde/0x740 kernel/exit.c:1662
                            do_wait+0x1f8/0x520 kernel/exit.c:1706
                            kernel_wait+0xab/0x170 kernel/exit.c:1882
                            call_usermodehelper_exec_sync kernel/umh.c:136 [inline]
                            call_usermodehelper_exec_work+0xbe/0x230 kernel/umh.c:163
                            process_one_work kernel/workqueue.c:3238 [inline]
                            process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
                            worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
                            kthread+0x70e/0x8a0 kernel/kthread.c:464
                            ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
                            ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
   }
   ... key      at: [<ffffffff8dc0c058>] tasklist_lock+0x18/0x40
   ... acquired at:
   lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
   __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
   _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
   send_sigio+0x101/0x370 fs/fcntl.c:921
   kill_fasync_rcu fs/fcntl.c:1133 [inline]
   kill_fasync+0x24d/0x4d0 fs/fcntl.c:1148
   lease_break_callback+0x26/0x30 fs/locks.c:558
   __break_lease+0x6a5/0x1620 fs/locks.c:1592
   vfs_truncate+0x428/0x520 fs/open.c:109
   do_sys_truncate+0xdb/0x190 fs/open.c:138
   __do_sys_truncate fs/open.c:150 [inline]
   __se_sys_truncate fs/open.c:148 [inline]
   __x64_sys_truncate+0x5b/0x70 fs/open.c:148
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

 -> (&f_owner->lock){....}-{3:3} {
    INITIAL USE at:
                     lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
                     __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                     _raw_write_lock_irq+0xa2/0xf0 kernel/locking/spinlock.c:326
                     __f_setown+0x67/0x370 fs/fcntl.c:136
                     generic_add_lease fs/locks.c:1874 [inline]
                     generic_setlease+0xd5d/0x1240 fs/locks.c:1942
                     do_fcntl_add_lease fs/locks.c:2047 [inline]
                     fcntl_setlease+0x3a2/0x4c0 fs/locks.c:2069
                     do_fcntl+0x6a0/0x1910 fs/fcntl.c:536
                     __do_sys_fcntl fs/fcntl.c:591 [inline]
                     __se_sys_fcntl+0xc8/0x150 fs/fcntl.c:576
                     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                     do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
                     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    INITIAL READ USE at:
                          lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
                          __raw_read_lock_irq include/linux/rwlock_api_smp.h:169 [inline]
                          _raw_read_lock_irq+0xaa/0xf0 kernel/locking/spinlock.c:244
                          f_getown+0x54/0x2a0 fs/fcntl.c:204
                          sock_ioctl+0x536/0x790 net/socket.c:1256
                          vfs_ioctl fs/ioctl.c:51 [inline]
                          __do_sys_ioctl fs/ioctl.c:906 [inline]
                          __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:892
                          do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                          do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
                          entry_SYSCALL_64_after_hwframe+0x77/0x7f
  }
  ... key      at: [<ffffffff99882d00>] file_f_owner_allocate.__key+0x0/0x20
  ... acquired at:
   lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0xaf/0x100 kernel/locking/spinlock.c:236
   send_sigio+0x38/0x370 fs/fcntl.c:907
   kill_fasync_rcu fs/fcntl.c:1133 [inline]
   kill_fasync+0x24d/0x4d0 fs/fcntl.c:1148
   lease_break_callback+0x26/0x30 fs/locks.c:558
   __break_lease+0x6a5/0x1620 fs/locks.c:1592
   vfs_truncate+0x428/0x520 fs/open.c:109
   do_sys_truncate+0xdb/0x190 fs/open.c:138
   __do_sys_truncate fs/open.c:150 [inline]
   __se_sys_truncate fs/open.c:148 [inline]
   __x64_sys_truncate+0x5b/0x70 fs/open.c:148
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> (&new->fa_lock){....}-{3:3} {
   INITIAL USE at:
                   lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                   _raw_write_lock_irq+0xa2/0xf0 kernel/locking/spinlock.c:326
                   fasync_remove_entry+0xf1/0x1c0 fs/fcntl.c:1001
                   lease_modify+0x1ca/0x3c0 fs/locks.c:1455
                   locks_remove_lease fs/locks.c:2675 [inline]
                   locks_remove_file+0x4bf/0xea0 fs/locks.c:2700
                   __fput+0x3ab/0xa70 fs/file_table.c:457
                   task_work_run+0x1d1/0x260 kernel/task_work.c:227
                   exit_task_work include/linux/task_work.h:40 [inline]
                   do_exit+0x8d6/0x2550 kernel/exit.c:953
                   do_group_exit+0x21c/0x2d0 kernel/exit.c:1102
                   get_signal+0x125e/0x1310 kernel/signal.c:3034
                   arch_do_signal_or_restart+0x95/0x780 arch/x86/kernel/signal.c:337
                   exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
                   exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
                   __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
                   syscall_exit_to_user_mode+0x8b/0x120 kernel/entry/common.c:218
                   do_syscall_64+0x103/0x210 arch/x86/entry/syscall_64.c:100
                   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   INITIAL READ USE at:
                        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
                        __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
                        _raw_read_lock_irqsave+0xaf/0x100 kernel/locking/spinlock.c:236
                        kill_fasync_rcu fs/fcntl.c:1124 [inline]
                        kill_fasync+0x199/0x4d0 fs/fcntl.c:1148
                        lease_break_callback+0x26/0x30 fs/locks.c:558
                        __break_lease+0x6a5/0x1620 fs/locks.c:1592
                        vfs_truncate+0x428/0x520 fs/open.c:109
                        do_sys_truncate+0xdb/0x190 fs/open.c:138
                        __do_sys_truncate fs/open.c:150 [inline]
                        __se_sys_truncate fs/open.c:148 [inline]
                        __x64_sys_truncate+0x5b/0x70 fs/open.c:148
                        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                        do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
                        entry_SYSCALL_64_after_hwframe+0x77/0x7f
 }
 ... key      at: [<ffffffff99882d20>] fasync_insert_entry.__key+0x0/0x20
 ... acquired at:
   lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0xaf/0x100 kernel/locking/spinlock.c:236
   kill_fasync_rcu fs/fcntl.c:1124 [inline]
   kill_fasync+0x199/0x4d0 fs/fcntl.c:1148
   __pass_event drivers/input/evdev.c:240 [inline]
   evdev_pass_values+0x627/0xbd0 drivers/input/evdev.c:278
   evdev_events+0x1e6/0x340 drivers/input/evdev.c:306
   input_pass_values+0x288/0x890 drivers/input/input.c:127
   input_event_dispose+0x330/0x6b0 drivers/input/input.c:341
   input_inject_event+0x1fe/0x320 drivers/input/input.c:423
   evdev_write+0x2fc/0x480 drivers/input/evdev.c:528
   vfs_write+0x27b/0xa90 fs/read_write.c:682
   ksys_write+0x145/0x250 fs/read_write.c:736
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f


stack backtrace:
CPU: 0 UID: 0 PID: 5394 Comm: syz-executor408 Not tainted 6.15.0-rc7-syzkaller-00142-g4856ebd99715 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_bad_irq_dependency kernel/locking/lockdep.c:2652 [inline]
 check_irq_usage kernel/locking/lockdep.c:2893 [inline]
 check_prev_add kernel/locking/lockdep.c:3170 [inline]
 check_prevs_add kernel/locking/lockdep.c:3285 [inline]
 validate_chain+0x1f05/0x2140 kernel/locking/lockdep.c:3909
 __lock_acquire+0xaac/0xd20 kernel/locking/lockdep.c:5235
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
 __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
 _raw_read_lock_irqsave+0xaf/0x100 kernel/locking/spinlock.c:236
 kill_fasync_rcu fs/fcntl.c:1124 [inline]
 kill_fasync+0x199/0x4d0 fs/fcntl.c:1148
 __pass_event drivers/input/evdev.c:240 [inline]
 evdev_pass_values+0x627/0xbd0 drivers/input/evdev.c:278
 evdev_events+0x1e6/0x340 drivers/input/evdev.c:306
 input_pass_values+0x288/0x890 drivers/input/input.c:127
 input_event_dispose+0x330/0x6b0 drivers/input/input.c:341
 input_inject_event+0x1fe/0x320 drivers/input/input.c:423
 evdev_write+0x2fc/0x480 drivers/input/evdev.c:528
 vfs_write+0x27b/0xa90 fs/read_write.c:682
 ksys_write+0x145/0x250 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f666844d4f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 1d 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f66683f9218 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f66684cd428 RCX: 00007f666844d4f9
RDX: 0000000000001068 RSI: 0000200000000040 RDI: 0000000000000008
RBP: 00007f66684cd420 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f666849a548
R13: 0000200000000040 R14: 00002000000001c0 R15: 00002000000000c0
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

