Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0785E262B1A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 10:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgIII6f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 04:58:35 -0400
Received: from mail-il1-f205.google.com ([209.85.166.205]:53336 "EHLO
        mail-il1-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgIII6d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:58:33 -0400
Received: by mail-il1-f205.google.com with SMTP id c8so1489192ila.20
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2020 01:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Tn8IQgw/Dbm8DU2LG9nUT43aKJJbqo51ix0e4vMP6Cg=;
        b=J60H/8tMwXrDhaKsyOkhCiP90fy7hdCvtnS64u6oLL6nB7DRoTduNVkfXVJlMyDgET
         P1bE/sJtWwRqVBViErqDhaO6J6gvVaajDkGJ93e/sPyT9EjN5NO3a0NKrxHTnRtaq8s5
         3Udtjo8OM9eK1sodbHZ04yowQy5U4aZaCNGNP+xLl3sKzyNbfKlZvjer6i44Px1w2GnZ
         XAodNa3CO5RduK4zxLv/CZvNbOjF8TZwVZpGlu+K/jbSQHbCrhBoqzIM9if8y/4p2bla
         Xe/ykSQZCl39SmyKci5FrHp/v4qFXArZ3rjL7BTXiBE9hmNnqEqwQB31/OhnI2boBsx0
         vzQQ==
X-Gm-Message-State: AOAM530NFNPs4EiUiTnz5b3w37TVLL1pTc33bpPW3Zzz7ZfP8/qQaMF7
        XHTnszIkokM51t/pEna4+9+hoUvGCNMq762Jf0BN79npXwos
X-Google-Smtp-Source: ABdhPJwOmzIFyNVIvJDdw+OORA4IiOKhhwnZ+CKckHbbER5c+dreBVBFP7Oxudvo5eVMwprSOOsvoJLjP1yDz36XrARODHSoc4Un
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:60c:: with SMTP id t12mr2815971ils.200.1599641910293;
 Wed, 09 Sep 2020 01:58:30 -0700 (PDT)
Date:   Wed, 09 Sep 2020 01:58:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4b96a05aedda7e2@google.com>
Subject: possible deadlock in send_sigio (2)
From:   syzbot <syzbot+907b8537e3b0e55151fc@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    dff9f829 Add linux-next specific files for 20200908
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17521b35900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37b3426c77bda44c
dashboard link: https://syzkaller.appspot.com/bug?extid=907b8537e3b0e55151fc
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+907b8537e3b0e55151fc@syzkaller.appspotmail.com

=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
5.9.0-rc4-next-20200908-syzkaller #0 Not tainted
-----------------------------------------------------
syz-executor.5/15112 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffff8880a828e478 (&f->f_owner.lock){.+.?}-{2:2}, at: send_sigio+0x24/0x320 fs/fcntl.c:786

and this task is already holding:
ffff88809d98b9f0 (&new->fa_lock){....}-{2:2}, at: kill_fasync_rcu fs/fcntl.c:1002 [inline]
ffff88809d98b9f0 (&new->fa_lock){....}-{2:2}, at: kill_fasync fs/fcntl.c:1023 [inline]
ffff88809d98b9f0 (&new->fa_lock){....}-{2:2}, at: kill_fasync+0x14b/0x460 fs/fcntl.c:1016
which would create a new lock dependency:
 (&new->fa_lock){....}-{2:2} -> (&f->f_owner.lock){.+.?}-{2:2}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (fasync_lock){+.+.}-{2:2}

... which became SOFTIRQ-irq-safe at:
  lock_acquire+0x1f3/0xaf0 kernel/locking/lockdep.c:5398
  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
  _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
  spin_lock include/linux/spinlock.h:354 [inline]
  fasync_remove_entry+0x2e/0x1f0 fs/fcntl.c:875
  fasync_helper+0x9e/0xb0 fs/fcntl.c:983
  __tty_fasync drivers/tty/tty_io.c:2126 [inline]
  tty_release+0x16d/0xf60 drivers/tty/tty_io.c:1664
  __fput+0x285/0x920 fs/file_table.c:281
  task_work_run+0xdd/0x190 kernel/task_work.c:141
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_user_mode_loop kernel/entry/common.c:163 [inline]
  exit_to_user_mode_prepare+0x1e2/0x1f0 kernel/entry/common.c:190
  syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:265
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

to a SOFTIRQ-irq-unsafe lock:
 (&f->f_owner.lock){.+.?}-{2:2}

... which became SOFTIRQ-irq-unsafe at:
...
  lock_acquire+0x1f3/0xaf0 kernel/locking/lockdep.c:5398
  __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
  _raw_read_lock+0x36/0x70 kernel/locking/spinlock.c:223
  send_sigurg+0x1e/0xa60 fs/fcntl.c:824
  sk_send_sigurg+0x76/0x300 net/core/sock.c:2930
  tcp_check_urg.isra.0+0x1f4/0x710 net/ipv4/tcp_input.c:5485
  tcp_urg net/ipv4/tcp_input.c:5526 [inline]
  tcp_rcv_established+0x10b9/0x1eb0 net/ipv4/tcp_input.c:5858
  tcp_v4_do_rcv+0x5d1/0x870 net/ipv4/tcp_ipv4.c:1643
  tcp_v4_rcv+0x2d10/0x3750 net/ipv4/tcp_ipv4.c:2025
  ip_protocol_deliver_rcu+0x5c/0x880 net/ipv4/ip_input.c:204
  ip_local_deliver_finish+0x20a/0x370 net/ipv4/ip_input.c:231
  NF_HOOK include/linux/netfilter.h:301 [inline]
  NF_HOOK include/linux/netfilter.h:295 [inline]
  ip_local_deliver+0x1b3/0x200 net/ipv4/ip_input.c:252
  dst_input include/net/dst.h:449 [inline]
  ip_rcv_finish+0x1da/0x2f0 net/ipv4/ip_input.c:428
  NF_HOOK include/linux/netfilter.h:301 [inline]
  NF_HOOK include/linux/netfilter.h:295 [inline]
  ip_rcv+0xaa/0xd0 net/ipv4/ip_input.c:539
  __netif_receive_skb_one_core+0x114/0x180 net/core/dev.c:5286
  __netif_receive_skb+0x27/0x1c0 net/core/dev.c:5400
  process_backlog+0x2e1/0x8e0 net/core/dev.c:6242
  napi_poll net/core/dev.c:6688 [inline]
  net_rx_action+0x4f8/0xf90 net/core/dev.c:6758
  __do_softirq+0x1f7/0xa91 kernel/softirq.c:298
  run_ksoftirqd kernel/softirq.c:652 [inline]
  run_ksoftirqd+0xcf/0x170 kernel/softirq.c:644
  smpboot_thread_fn+0x655/0x9e0 kernel/smpboot.c:165
  kthread+0x3af/0x4a0 kernel/kthread.c:292
  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

other info that might help us debug this:

Chain exists of:
  fasync_lock --> &new->fa_lock --> &f->f_owner.lock

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&f->f_owner.lock);
                               local_irq_disable();
                               lock(fasync_lock);
                               lock(&new->fa_lock);
  <Interrupt>
    lock(fasync_lock);

 *** DEADLOCK ***

8 locks held by syz-executor.5/15112:
 #0: ffff88809cee8160 (&evdev->mutex){+.+.}-{3:3}, at: evdev_write+0x1cd/0x750 drivers/input/evdev.c:513
 #1: ffff88809da12230 (&dev->event_lock){-...}-{2:2}, at: input_inject_event+0xa6/0x310 drivers/input/input.c:466
 #2: ffffffff89c68540 (rcu_read_lock){....}-{1:2}, at: is_event_supported drivers/input/input.c:53 [inline]
 #2: ffffffff89c68540 (rcu_read_lock){....}-{1:2}, at: is_event_supported drivers/input/input.c:50 [inline]
 #2: ffffffff89c68540 (rcu_read_lock){....}-{1:2}, at: input_inject_event+0x92/0x310 drivers/input/input.c:465
 #3: ffffffff89c68540 (rcu_read_lock){....}-{1:2}, at: input_pass_values.part.0+0x0/0x700 drivers/input/input.c:833
 #4: ffffffff89c68540 (rcu_read_lock){....}-{1:2}, at: evdev_events+0x55/0x330 drivers/input/evdev.c:297
 #5: ffff888097fef028 (&client->buffer_lock){....}-{2:2}, at: spin_lock include/linux/spinlock.h:354 [inline]
 #5: ffff888097fef028 (&client->buffer_lock){....}-{2:2}, at: evdev_pass_values+0x195/0xa30 drivers/input/evdev.c:262
 #6: ffffffff89c68540 (rcu_read_lock){....}-{1:2}, at: kill_fasync+0x3d/0x460 fs/fcntl.c:1021
 #7: ffff88809d98b9f0 (&new->fa_lock){....}-{2:2}, at: kill_fasync_rcu fs/fcntl.c:1002 [inline]
 #7: ffff88809d98b9f0 (&new->fa_lock){....}-{2:2}, at: kill_fasync fs/fcntl.c:1023 [inline]
 #7: ffff88809d98b9f0 (&new->fa_lock){....}-{2:2}, at: kill_fasync+0x14b/0x460 fs/fcntl.c:1016

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
 -> (fasync_lock){+.+.}-{2:2} {
    HARDIRQ-ON-W at:
                      lock_acquire+0x1f3/0xaf0 kernel/locking/lockdep.c:5398
                      __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                      _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
                      spin_lock include/linux/spinlock.h:354 [inline]
                      fasync_remove_entry+0x2e/0x1f0 fs/fcntl.c:875
                      fasync_helper+0x9e/0xb0 fs/fcntl.c:983
                      __tty_fasync drivers/tty/tty_io.c:2126 [inline]
                      tty_release+0x16d/0xf60 drivers/tty/tty_io.c:1664
                      __fput+0x285/0x920 fs/file_table.c:281
                      task_work_run+0xdd/0x190 kernel/task_work.c:141
                      tracehook_notify_resume include/linux/tracehook.h:188 [inline]
                      exit_to_user_mode_loop kernel/entry/common.c:163 [inline]
                      exit_to_user_mode_prepare+0x1e2/0x1f0 kernel/entry/common.c:190
                      syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:265
                      entry_SYSCALL_64_after_hwframe+0x44/0xa9
    SOFTIRQ-ON-W at:
                      lock_acquire+0x1f3/0xaf0 kernel/locking/lockdep.c:5398
                      __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                      _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
                      spin_lock include/linux/spinlock.h:354 [inline]
                      fasync_remove_entry+0x2e/0x1f0 fs/fcntl.c:875
                      fasync_helper+0x9e/0xb0 fs/fcntl.c:983
                      __tty_fasync drivers/tty/tty_io.c:2126 [inline]
                      tty_release+0x16d/0xf60 drivers/tty/tty_io.c:1664
                      __fput+0x285/0x920 fs/file_table.c:281
                      task_work_run+0xdd/0x190 kernel/task_work.c:141
                      tracehook_notify_resume include/linux/tracehook.h:188 [inline]
                      exit_to_user_mode_loop kernel/entry/common.c:163 [inline]
                      exit_to_user_mode_prepare+0x1e2/0x1f0 kernel/entry/common.c:190
                      syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:265
                      entry_SYSCALL_64_after_hwframe+0x44/0xa9
    INITIAL USE at:
                     lock_acquire+0x1f3/0xaf0 kernel/locking/lockdep.c:5398
                     __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                     _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
                     spin_lock include/linux/spinlock.h:354 [inline]
                     fasync_remove_entry+0x2e/0x1f0 fs/fcntl.c:875
                     fasync_helper+0x9e/0xb0 fs/fcntl.c:983
                     __tty_fasync drivers/tty/tty_io.c:2126 [inline]
                     tty_release+0x16d/0xf60 drivers/tty/tty_io.c:1664
                     __fput+0x285/0x920 fs/file_table.c:281
                     task_work_run+0xdd/0x190 kernel/task_work.c:141
                     tracehook_notify_resume include/linux/tracehook.h:188 [inline]
                     exit_to_user_mode_loop kernel/entry/common.c:163 [inline]
                     exit_to_user_mode_prepare+0x1e2/0x1f0 kernel/entry/common.c:190
                     syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:265
                     entry_SYSCALL_64_after_hwframe+0x44/0xa9
  }
  ... key      at: [<ffffffff89d445f8>] fasync_lock+0x18/0x660
  ... acquired at:
   __raw_write_lock_irq include/linux/rwlock_api_smp.h:196 [inline]
   _raw_write_lock_irq+0x94/0xd0 kernel/locking/spinlock.c:311
   fasync_remove_entry+0xb6/0x1f0 fs/fcntl.c:880
   fasync_helper+0x9e/0xb0 fs/fcntl.c:983
   lease_modify fs/locks.c:1522 [inline]
   lease_modify+0x28a/0x370 fs/locks.c:1509
   locks_remove_lease fs/locks.c:2770 [inline]
   locks_remove_file+0x2be/0x580 fs/locks.c:2795
   __fput+0x1b8/0x920 fs/file_table.c:273
   task_work_run+0xdd/0x190 kernel/task_work.c:141
   tracehook_notify_resume include/linux/tracehook.h:188 [inline]
   exit_to_user_mode_loop kernel/entry/common.c:163 [inline]
   exit_to_user_mode_prepare+0x1e2/0x1f0 kernel/entry/common.c:190
   syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:265
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> (&new->fa_lock){....}-{2:2} {
   INITIAL USE at:
                   lock_acquire+0x1f3/0xaf0 kernel/locking/lockdep.c:5398
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:196 [inline]
                   _raw_write_lock_irq+0x94/0xd0 kernel/locking/spinlock.c:311
                   fasync_remove_entry+0xb6/0x1f0 fs/fcntl.c:880
                   fasync_helper+0x9e/0xb0 fs/fcntl.c:983
                   lease_modify fs/locks.c:1522 [inline]
                   lease_modify+0x28a/0x370 fs/locks.c:1509
                   locks_remove_lease fs/locks.c:2770 [inline]
                   locks_remove_file+0x2be/0x580 fs/locks.c:2795
                   __fput+0x1b8/0x920 fs/file_table.c:273
                   task_work_run+0xdd/0x190 kernel/task_work.c:141
                   tracehook_notify_resume include/linux/tracehook.h:188 [inline]
                   exit_to_user_mode_loop kernel/entry/common.c:163 [inline]
                   exit_to_user_mode_prepare+0x1e2/0x1f0 kernel/entry/common.c:190
                   syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:265
                   entry_SYSCALL_64_after_hwframe+0x44/0xa9
   (null) at:
general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 0 PID: 15112 Comm: syz-executor.5 Not tainted 5.9.0-rc4-next-20200908-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:print_lock_trace kernel/locking/lockdep.c:1751 [inline]
RIP: 0010:print_lock_class_header kernel/locking/lockdep.c:2240 [inline]
RIP: 0010:print_shortest_lock_dependencies.cold+0x110/0x2af kernel/locking/lockdep.c:2263
Code: 48 8b 04 24 48 c1 e8 03 42 80 3c 20 00 74 09 48 8b 3c 24 e8 dd fb de f9 48 8b 04 24 48 8b 00 48 8d 78 14 48 89 fa 48 c1 ea 03 <42> 0f b6 0c 22 48 89 fa 83 e2 07 83 c2 03 38 ca 7c 08 84 c9 0f 85
RSP: 0018:ffffc900057875c0 EFLAGS: 00010003
RAX: 0000000000000001 RBX: ffffc90005787718 RCX: 0000000000000000
RDX: 0000000000000002 RSI: ffffffff815bc817 RDI: 0000000000000015
RBP: ffffc90005787718 R08: 0000000000000004 R09: ffff8880ae620f8b
R10: 0000000000000000 R11: 6c6c756e28202020 R12: dffffc0000000000
R13: ffffffff8c709bb8 R14: 0000000000000009 R15: 0000000000000000
FS:  00007f7930053700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004e9cf0 CR3: 000000008f8ef000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 print_bad_irq_dependency kernel/locking/lockdep.c:2395 [inline]
 check_irq_usage.cold+0x42d/0x5b0 kernel/locking/lockdep.c:2634
 check_prev_add kernel/locking/lockdep.c:2823 [inline]
 check_prevs_add kernel/locking/lockdep.c:2944 [inline]
 validate_chain kernel/locking/lockdep.c:3562 [inline]
 __lock_acquire+0x2800/0x55d0 kernel/locking/lockdep.c:4796
 lock_acquire+0x1f3/0xaf0 kernel/locking/lockdep.c:5398
 __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
 _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
 send_sigio+0x24/0x320 fs/fcntl.c:786
 kill_fasync_rcu fs/fcntl.c:1009 [inline]
 kill_fasync fs/fcntl.c:1023 [inline]
 kill_fasync+0x205/0x460 fs/fcntl.c:1016
 __pass_event drivers/input/evdev.c:240 [inline]
 evdev_pass_values+0x715/0xa30 drivers/input/evdev.c:279
 evdev_events+0x20c/0x330 drivers/input/evdev.c:307
 input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
 input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
 input_pass_values drivers/input/input.c:134 [inline]
 input_handle_event+0x324/0x1390 drivers/input/input.c:399
 input_inject_event+0x2f5/0x310 drivers/input/input.c:471
 evdev_write+0x424/0x750 drivers/input/evdev.c:530
 vfs_write+0x28e/0x700 fs/read_write.c:593
 ksys_write+0x1ee/0x250 fs/read_write.c:648
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45d5b9
Code: 5d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 2b b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f7930052c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000038f80 RCX: 000000000045d5b9
RDX: 0000000000000373 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 000000000118cf80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118cf4c
R13: 00007ffe25f626af R14: 00007f79300539c0 R15: 000000000118cf4c
Modules linked in:
---[ end trace 7926691370b595f2 ]---
RIP: 0010:print_lock_trace kernel/locking/lockdep.c:1751 [inline]
RIP: 0010:print_lock_class_header kernel/locking/lockdep.c:2240 [inline]
RIP: 0010:print_shortest_lock_dependencies.cold+0x110/0x2af kernel/locking/lockdep.c:2263
Code: 48 8b 04 24 48 c1 e8 03 42 80 3c 20 00 74 09 48 8b 3c 24 e8 dd fb de f9 48 8b 04 24 48 8b 00 48 8d 78 14 48 89 fa 48 c1 ea 03 <42> 0f b6 0c 22 48 89 fa 83 e2 07 83 c2 03 38 ca 7c 08 84 c9 0f 85
RSP: 0018:ffffc900057875c0 EFLAGS: 00010003
RAX: 0000000000000001 RBX: ffffc90005787718 RCX: 0000000000000000
RDX: 0000000000000002 RSI: ffffffff815bc817 RDI: 0000000000000015
RBP: ffffc90005787718 R08: 0000000000000004 R09: ffff8880ae620f8b
R10: 0000000000000000 R11: 6c6c756e28202020 R12: dffffc0000000000
R13: ffffffff8c709bb8 R14: 0000000000000009 R15: 0000000000000000
FS:  00007f7930053700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004e9cf0 CR3: 000000008f8ef000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
