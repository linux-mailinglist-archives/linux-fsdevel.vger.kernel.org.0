Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 729BC19D035
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 08:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388405AbgDCGZS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 02:25:18 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:40405 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388227AbgDCGZR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 02:25:17 -0400
Received: by mail-il1-f198.google.com with SMTP id g79so5946586ild.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2020 23:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=raMsFl24anIEOt03rkcBpv/Qk6SneqXyBrinXLdfbVA=;
        b=Abhsd4xvyWmpf5k61vrN0D5PqvUIG5jsWEIDQIEEoU32vqr6XBxNDK1ibuDoKFgMww
         ym9a8I5tCzIM77u8b60GbzYIPaof3CsGWsOX0V+m1i2p83OQ5aWHW0nYqbdYPccp8dMW
         FNlD8ls934DIfNu9evyaXu5LhfAfr44eCv+0ZxnV98icE7hk8m6BE1WkbhzrvpOK4rOi
         XDeYYcr1JFy/GLbW+lmOkS0lSeDPMvzl5H+DRN/F0DXoV1xfM9/JkL+QE8osV+B+ea7X
         LlnLFm3BX0z5/sVoB0B7TMbf2MYZNcDQm96LMEiayggVfJeg1kO4T40GogC9VuhgOhu7
         W68Q==
X-Gm-Message-State: AGi0PuZ4//WrnGdLqs8s29zyYIprAxnYRRPr8M2lpu9cxjQq713PKz+s
        IBc7sAvc3zyiAGF2kKPyjD3uL0+L0fHbri/CmFLDSlli54XY
X-Google-Smtp-Source: APiQypJBmdukRpVpIeg53MJwbfGtA6tqREJp/27Nxuma75fOCrTWD/v5bAkXlUwrqj2s0Oi4penA/s4D/RThZn3OAeCdf5/kG9dT
MIME-Version: 1.0
X-Received: by 2002:a6b:ec19:: with SMTP id c25mr5793080ioh.98.1585895114642;
 Thu, 02 Apr 2020 23:25:14 -0700 (PDT)
Date:   Thu, 02 Apr 2020 23:25:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f59ac305a25cfa14@google.com>
Subject: possible deadlock in io_submit_one (3)
From:   syzbot <syzbot+343f75cdeea091340956@syzkaller.appspotmail.com>
To:     bcrl@kvack.org, linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7be97138 Merge tag 'xfs-5.7-merge-8' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13d37663e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec722f9d4eb221d2
dashboard link: https://syzkaller.appspot.com/bug?extid=343f75cdeea091340956
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+343f75cdeea091340956@syzkaller.appspotmail.com

=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
5.6.0-syzkaller #0 Not tainted
-----------------------------------------------------
syz-executor.2/11911 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffff888088003548 (&pid->wait_pidfd){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:353 [inline]
ffff888088003548 (&pid->wait_pidfd){+.+.}-{2:2}, at: aio_poll fs/aio.c:1767 [inline]
ffff888088003548 (&pid->wait_pidfd){+.+.}-{2:2}, at: __io_submit_one fs/aio.c:1841 [inline]
ffff888088003548 (&pid->wait_pidfd){+.+.}-{2:2}, at: io_submit_one+0x10f5/0x1a80 fs/aio.c:1878

and this task is already holding:
ffff888045d05c98 (&ctx->ctx_lock){..-.}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:378 [inline]
ffff888045d05c98 (&ctx->ctx_lock){..-.}-{2:2}, at: aio_poll fs/aio.c:1765 [inline]
ffff888045d05c98 (&ctx->ctx_lock){..-.}-{2:2}, at: __io_submit_one fs/aio.c:1841 [inline]
ffff888045d05c98 (&ctx->ctx_lock){..-.}-{2:2}, at: io_submit_one+0x10cb/0x1a80 fs/aio.c:1878
which would create a new lock dependency:
 (&ctx->ctx_lock){..-.}-{2:2} -> (&pid->wait_pidfd){+.+.}-{2:2}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (&ctx->ctx_lock){..-.}-{2:2}

... which became SOFTIRQ-irq-safe at:
  lock_acquire+0x169/0x480 kernel/locking/lockdep.c:4923
  __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
  _raw_spin_lock_irq+0x67/0x80 kernel/locking/spinlock.c:167
  spin_lock_irq include/linux/spinlock.h:378 [inline]
  free_ioctx_users+0x30/0x1c0 fs/aio.c:618
  percpu_ref_put_many include/linux/percpu-refcount.h:309 [inline]
  percpu_ref_put+0x18d/0x1a0 include/linux/percpu-refcount.h:325
  rcu_do_batch kernel/rcu/tree.c:2206 [inline]
  rcu_core+0x816/0x1120 kernel/rcu/tree.c:2433
  __do_softirq+0x268/0x80c kernel/softirq.c:292
  do_softirq_own_stack+0x2a/0x40 arch/x86/entry/entry_64.S:1082
  do_softirq+0xf9/0x190 kernel/softirq.c:337
  __local_bh_enable_ip+0x18b/0x230 kernel/softirq.c:189
  spin_unlock_bh include/linux/spinlock.h:398 [inline]
  netif_addr_unlock_bh include/linux/netdevice.h:4182 [inline]
  dev_uc_add+0x374/0x440 net/core/dev_addr_lists.c:593
  macsec_dev_open+0x8b/0x670 drivers/net/macsec.c:3487
  __dev_open+0x27c/0x410 net/core/dev.c:1436
  __dev_change_flags+0x198/0x650 net/core/dev.c:8143
  dev_change_flags+0x85/0x190 net/core/dev.c:8214
  do_setlink+0xb17/0x3900 net/core/rtnetlink.c:2598
  __rtnl_newlink net/core/rtnetlink.c:3266 [inline]
  rtnl_newlink+0x1509/0x1c00 net/core/rtnetlink.c:3391
  rtnetlink_rcv_msg+0x889/0xd40 net/core/rtnetlink.c:5454
  netlink_rcv_skb+0x190/0x3a0 net/netlink/af_netlink.c:2469
  netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
  netlink_unicast+0x786/0x940 net/netlink/af_netlink.c:1329
  netlink_sendmsg+0xa57/0xd70 net/netlink/af_netlink.c:1918
  sock_sendmsg_nosec net/socket.c:652 [inline]
  sock_sendmsg net/socket.c:672 [inline]
  __sys_sendto+0x3f3/0x590 net/socket.c:2000
  __do_sys_sendto net/socket.c:2012 [inline]
  __se_sys_sendto net/socket.c:2008 [inline]
  __x64_sys_sendto+0xda/0xf0 net/socket.c:2008
  do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
  entry_SYSCALL_64_after_hwframe+0x49/0xb3

to a SOFTIRQ-irq-unsafe lock:
 (&pid->wait_pidfd){+.+.}-{2:2}

... which became SOFTIRQ-irq-unsafe at:
...
  lock_acquire+0x169/0x480 kernel/locking/lockdep.c:4923
  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
  _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
  spin_lock include/linux/spinlock.h:353 [inline]
  proc_pid_make_inode+0x187/0x2d0 fs/proc/base.c:1880
  proc_pid_instantiate+0x4b/0x1a0 fs/proc/base.c:3285
  proc_pid_lookup+0x218/0x2f0 fs/proc/base.c:3320
  proc_root_lookup+0x1b/0x50 fs/proc/root.c:243
  __lookup_slow+0x240/0x370 fs/namei.c:1530
  lookup_slow fs/namei.c:1547 [inline]
  walk_component+0x442/0x680 fs/namei.c:1846
  link_path_walk+0x66d/0xba0 fs/namei.c:2165
  path_openat+0x21d/0x38b0 fs/namei.c:3342
  do_filp_open+0x2b4/0x3a0 fs/namei.c:3375
  do_sys_openat2+0x463/0x6f0 fs/open.c:1148
  do_sys_open fs/open.c:1164 [inline]
  ksys_open include/linux/syscalls.h:1386 [inline]
  __do_sys_open fs/open.c:1170 [inline]
  __se_sys_open fs/open.c:1168 [inline]
  __x64_sys_open+0x1af/0x1e0 fs/open.c:1168
  do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
  entry_SYSCALL_64_after_hwframe+0x49/0xb3

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&pid->wait_pidfd);
                               local_irq_disable();
                               lock(&ctx->ctx_lock);
                               lock(&pid->wait_pidfd);
  <Interrupt>
    lock(&ctx->ctx_lock);

 *** DEADLOCK ***

1 lock held by syz-executor.2/11911:
 #0: ffff888045d05c98 (&ctx->ctx_lock){..-.}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:378 [inline]
 #0: ffff888045d05c98 (&ctx->ctx_lock){..-.}-{2:2}, at: aio_poll fs/aio.c:1765 [inline]
 #0: ffff888045d05c98 (&ctx->ctx_lock){..-.}-{2:2}, at: __io_submit_one fs/aio.c:1841 [inline]
 #0: ffff888045d05c98 (&ctx->ctx_lock){..-.}-{2:2}, at: io_submit_one+0x10cb/0x1a80 fs/aio.c:1878

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
-> (&ctx->ctx_lock){..-.}-{2:2} {
   IN-SOFTIRQ-W at:
                    lock_acquire+0x169/0x480 kernel/locking/lockdep.c:4923
                    __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
                    _raw_spin_lock_irq+0x67/0x80 kernel/locking/spinlock.c:167
                    spin_lock_irq include/linux/spinlock.h:378 [inline]
                    free_ioctx_users+0x30/0x1c0 fs/aio.c:618
                    percpu_ref_put_many include/linux/percpu-refcount.h:309 [inline]
                    percpu_ref_put+0x18d/0x1a0 include/linux/percpu-refcount.h:325
                    rcu_do_batch kernel/rcu/tree.c:2206 [inline]
                    rcu_core+0x816/0x1120 kernel/rcu/tree.c:2433
                    __do_softirq+0x268/0x80c kernel/softirq.c:292
                    do_softirq_own_stack+0x2a/0x40 arch/x86/entry/entry_64.S:1082
                    do_softirq+0xf9/0x190 kernel/softirq.c:337
                    __local_bh_enable_ip+0x18b/0x230 kernel/softirq.c:189
                    spin_unlock_bh include/linux/spinlock.h:398 [inline]
                    netif_addr_unlock_bh include/linux/netdevice.h:4182 [inline]
                    dev_uc_add+0x374/0x440 net/core/dev_addr_lists.c:593
                    macsec_dev_open+0x8b/0x670 drivers/net/macsec.c:3487
                    __dev_open+0x27c/0x410 net/core/dev.c:1436
                    __dev_change_flags+0x198/0x650 net/core/dev.c:8143
                    dev_change_flags+0x85/0x190 net/core/dev.c:8214
                    do_setlink+0xb17/0x3900 net/core/rtnetlink.c:2598
                    __rtnl_newlink net/core/rtnetlink.c:3266 [inline]
                    rtnl_newlink+0x1509/0x1c00 net/core/rtnetlink.c:3391
                    rtnetlink_rcv_msg+0x889/0xd40 net/core/rtnetlink.c:5454
                    netlink_rcv_skb+0x190/0x3a0 net/netlink/af_netlink.c:2469
                    netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
                    netlink_unicast+0x786/0x940 net/netlink/af_netlink.c:1329
                    netlink_sendmsg+0xa57/0xd70 net/netlink/af_netlink.c:1918
                    sock_sendmsg_nosec net/socket.c:652 [inline]
                    sock_sendmsg net/socket.c:672 [inline]
                    __sys_sendto+0x3f3/0x590 net/socket.c:2000
                    __do_sys_sendto net/socket.c:2012 [inline]
                    __se_sys_sendto net/socket.c:2008 [inline]
                    __x64_sys_sendto+0xda/0xf0 net/socket.c:2008
                    do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
                    entry_SYSCALL_64_after_hwframe+0x49/0xb3
   INITIAL USE at:
                   lock_acquire+0x169/0x480 kernel/locking/lockdep.c:4923
                   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
                   _raw_spin_lock_irq+0x67/0x80 kernel/locking/spinlock.c:167
                   spin_lock_irq include/linux/spinlock.h:378 [inline]
                   free_ioctx_users+0x30/0x1c0 fs/aio.c:618
                   percpu_ref_put_many include/linux/percpu-refcount.h:309 [inline]
                   percpu_ref_put+0x18d/0x1a0 include/linux/percpu-refcount.h:325
                   rcu_do_batch kernel/rcu/tree.c:2206 [inline]
                   rcu_core+0x816/0x1120 kernel/rcu/tree.c:2433
                   __do_softirq+0x268/0x80c kernel/softirq.c:292
                   do_softirq_own_stack+0x2a/0x40 arch/x86/entry/entry_64.S:1082
                   do_softirq+0xf9/0x190 kernel/softirq.c:337
                   __local_bh_enable_ip+0x18b/0x230 kernel/softirq.c:189
                   spin_unlock_bh include/linux/spinlock.h:398 [inline]
                   netif_addr_unlock_bh include/linux/netdevice.h:4182 [inline]
                   dev_uc_add+0x374/0x440 net/core/dev_addr_lists.c:593
                   macsec_dev_open+0x8b/0x670 drivers/net/macsec.c:3487
                   __dev_open+0x27c/0x410 net/core/dev.c:1436
                   __dev_change_flags+0x198/0x650 net/core/dev.c:8143
                   dev_change_flags+0x85/0x190 net/core/dev.c:8214
                   do_setlink+0xb17/0x3900 net/core/rtnetlink.c:2598
                   __rtnl_newlink net/core/rtnetlink.c:3266 [inline]
                   rtnl_newlink+0x1509/0x1c00 net/core/rtnetlink.c:3391
                   rtnetlink_rcv_msg+0x889/0xd40 net/core/rtnetlink.c:5454
                   netlink_rcv_skb+0x190/0x3a0 net/netlink/af_netlink.c:2469
                   netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
                   netlink_unicast+0x786/0x940 net/netlink/af_netlink.c:1329
                   netlink_sendmsg+0xa57/0xd70 net/netlink/af_netlink.c:1918
                   sock_sendmsg_nosec net/socket.c:652 [inline]
                   sock_sendmsg net/socket.c:672 [inline]
                   __sys_sendto+0x3f3/0x590 net/socket.c:2000
                   __do_sys_sendto net/socket.c:2012 [inline]
                   __se_sys_sendto net/socket.c:2008 [inline]
                   __x64_sys_sendto+0xda/0xf0 net/socket.c:2008
                   do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
                   entry_SYSCALL_64_after_hwframe+0x49/0xb3
 }
 ... key      at: [<ffffffff8b596090>] ioctx_alloc.__key+0x0/0x10
 ... acquired at:
   lock_acquire+0x169/0x480 kernel/locking/lockdep.c:4923
   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
   _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
   spin_lock include/linux/spinlock.h:353 [inline]
   aio_poll fs/aio.c:1767 [inline]
   __io_submit_one fs/aio.c:1841 [inline]
   io_submit_one+0x10f5/0x1a80 fs/aio.c:1878
   __do_sys_io_submit fs/aio.c:1937 [inline]
   __se_sys_io_submit+0x117/0x220 fs/aio.c:1907
   do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
   entry_SYSCALL_64_after_hwframe+0x49/0xb3


the dependencies between the lock to be acquired
 and SOFTIRQ-irq-unsafe lock:
-> (&pid->wait_pidfd){+.+.}-{2:2} {
   HARDIRQ-ON-W at:
                    lock_acquire+0x169/0x480 kernel/locking/lockdep.c:4923
                    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                    _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
                    spin_lock include/linux/spinlock.h:353 [inline]
                    proc_pid_make_inode+0x187/0x2d0 fs/proc/base.c:1880
                    proc_pid_instantiate+0x4b/0x1a0 fs/proc/base.c:3285
                    proc_pid_lookup+0x218/0x2f0 fs/proc/base.c:3320
                    proc_root_lookup+0x1b/0x50 fs/proc/root.c:243
                    __lookup_slow+0x240/0x370 fs/namei.c:1530
                    lookup_slow fs/namei.c:1547 [inline]
                    walk_component+0x442/0x680 fs/namei.c:1846
                    link_path_walk+0x66d/0xba0 fs/namei.c:2165
                    path_openat+0x21d/0x38b0 fs/namei.c:3342
                    do_filp_open+0x2b4/0x3a0 fs/namei.c:3375
                    do_sys_openat2+0x463/0x6f0 fs/open.c:1148
                    do_sys_open fs/open.c:1164 [inline]
                    ksys_open include/linux/syscalls.h:1386 [inline]
                    __do_sys_open fs/open.c:1170 [inline]
                    __se_sys_open fs/open.c:1168 [inline]
                    __x64_sys_open+0x1af/0x1e0 fs/open.c:1168
                    do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
                    entry_SYSCALL_64_after_hwframe+0x49/0xb3
   SOFTIRQ-ON-W at:
                    lock_acquire+0x169/0x480 kernel/locking/lockdep.c:4923
                    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                    _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
                    spin_lock include/linux/spinlock.h:353 [inline]
                    proc_pid_make_inode+0x187/0x2d0 fs/proc/base.c:1880
                    proc_pid_instantiate+0x4b/0x1a0 fs/proc/base.c:3285
                    proc_pid_lookup+0x218/0x2f0 fs/proc/base.c:3320
                    proc_root_lookup+0x1b/0x50 fs/proc/root.c:243
                    __lookup_slow+0x240/0x370 fs/namei.c:1530
                    lookup_slow fs/namei.c:1547 [inline]
                    walk_component+0x442/0x680 fs/namei.c:1846
                    link_path_walk+0x66d/0xba0 fs/namei.c:2165
                    path_openat+0x21d/0x38b0 fs/namei.c:3342
                    do_filp_open+0x2b4/0x3a0 fs/namei.c:3375
                    do_sys_openat2+0x463/0x6f0 fs/open.c:1148
                    do_sys_open fs/open.c:1164 [inline]
                    ksys_open include/linux/syscalls.h:1386 [inline]
                    __do_sys_open fs/open.c:1170 [inline]
                    __se_sys_open fs/open.c:1168 [inline]
                    __x64_sys_open+0x1af/0x1e0 fs/open.c:1168
                    do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
                    entry_SYSCALL_64_after_hwframe+0x49/0xb3
   INITIAL USE at:
                   lock_acquire+0x169/0x480 kernel/locking/lockdep.c:4923
                   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                   _raw_spin_lock_irqsave+0x9e/0xc0 kernel/locking/spinlock.c:159
                   __wake_up_common_lock kernel/sched/wait.c:122 [inline]
                   __wake_up+0xb8/0x150 kernel/sched/wait.c:142
                   do_notify_pidfd kernel/signal.c:1900 [inline]
                   do_notify_parent+0x167/0xce0 kernel/signal.c:1927
                   exit_notify kernel/exit.c:660 [inline]
                   do_exit+0x12c5/0x1f80 kernel/exit.c:816
                   call_usermodehelper_exec_async+0x47c/0x480 kernel/umh.c:125
                   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
 }
 ... key      at: [<ffffffff8aae6790>] alloc_pid.__key+0x0/0x10
 ... acquired at:
   lock_acquire+0x169/0x480 kernel/locking/lockdep.c:4923
   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
   _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
   spin_lock include/linux/spinlock.h:353 [inline]
   aio_poll fs/aio.c:1767 [inline]
   __io_submit_one fs/aio.c:1841 [inline]
   io_submit_one+0x10f5/0x1a80 fs/aio.c:1878
   __do_sys_io_submit fs/aio.c:1937 [inline]
   __se_sys_io_submit+0x117/0x220 fs/aio.c:1907
   do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
   entry_SYSCALL_64_after_hwframe+0x49/0xb3


stack backtrace:
CPU: 0 PID: 11911 Comm: syz-executor.2 Not tainted 5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1e9/0x30e lib/dump_stack.c:118
 print_bad_irq_dependency kernel/locking/lockdep.c:2132 [inline]
 check_irq_usage kernel/locking/lockdep.c:2330 [inline]
 check_prev_add kernel/locking/lockdep.c:2519 [inline]
 check_prevs_add kernel/locking/lockdep.c:2620 [inline]
 validate_chain+0x8479/0x8920 kernel/locking/lockdep.c:3237
 __lock_acquire+0x116c/0x2b90 kernel/locking/lockdep.c:4344
 lock_acquire+0x169/0x480 kernel/locking/lockdep.c:4923
 __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
 spin_lock include/linux/spinlock.h:353 [inline]
 aio_poll fs/aio.c:1767 [inline]
 __io_submit_one fs/aio.c:1841 [inline]
 io_submit_one+0x10f5/0x1a80 fs/aio.c:1878
 __do_sys_io_submit fs/aio.c:1937 [inline]
 __se_sys_io_submit+0x117/0x220 fs/aio.c:1907
 do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45c849
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0fdf51ec78 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00007f0fdf51f6d4 RCX: 000000000045c849
RDX: 0000000020000040 RSI: 0000000020000103 RDI: 00007f0fdf4fe000
RBP: 000000000076bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000001f9 R14: 00000000004c422b R15: 000000000076bf0c


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
