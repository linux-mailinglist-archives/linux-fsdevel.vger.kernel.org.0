Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10EBD44C596
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 18:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhKJRDO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 12:03:14 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:36731 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbhKJRDN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 12:03:13 -0500
Received: by mail-io1-f69.google.com with SMTP id w16-20020a5d8a10000000b005e241c13c7bso2307545iod.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Nov 2021 09:00:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LgoWikA/MYp6z0FmcQIeM+KuWqm/hDXZaTKATbxyTsw=;
        b=Q0uUkqApscAJVZrM2WW1LKaOd0uRp1DIFzaCJ2Ac7whdOoMzZ4xmp7Uffl3++byjNo
         2Q8N4mYXqGhM4Bn/m8fMVqxa1yJqkgzB1vHqCo/4SkoJospvNPmtSQ8pYnmTDt5CYvdm
         PzGxfwZKKTEjFaOc+tmh9ms/aoP2yjtROkag4iVQOS/Y7jZnjyRXXfCjQd/if15UDuHn
         nparqnp3FW/J9QRmG2sYe8V5TIsgtabhss6uNNpBifHO4vRytt/DcYfrqDH0nP0Xa9x2
         AV4X+9ay0fpDjmkAvyWFAMsWkBou7VFUtqHO6MUivGjTw6WAkXfYtNqfNjz28ARzfWrP
         5JBg==
X-Gm-Message-State: AOAM5328sloQZdOj1IYgAJritzkqjO/UPwdakhBKHFwfBXm35/2FqZ00
        jVQFEDaBP+cCjKytXtbG4MUtpmt3LkHJqoxioNv7w9+FmXKU
X-Google-Smtp-Source: ABdhPJw/YczSvbi31Rz40Cxmwddi0gKl6m3ltvvdqz7tHt0/1wNkUX50O22uYakauOiQC4A/z9eKBBm/F/RhaS/HK+VTl7lr13t5
MIME-Version: 1.0
X-Received: by 2002:a6b:700e:: with SMTP id l14mr431049ioc.20.1636563625542;
 Wed, 10 Nov 2021 09:00:25 -0800 (PST)
Date:   Wed, 10 Nov 2021 09:00:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d88a205d0722901@google.com>
Subject: [syzbot] possible deadlock in _snd_pcm_stream_lock_irqsave (3)
From:   syzbot <syzbot+58740f570d9b0dacf2a3@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    cb690f5238d7 Merge tag 'for-5.16/drivers-2021-11-09' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14db95c1b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7259f0deb293aa
dashboard link: https://syzkaller.appspot.com/bug?extid=58740f570d9b0dacf2a3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+58740f570d9b0dacf2a3@syzkaller.appspotmail.com

=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
5.15.0-syzkaller #0 Not tainted
-----------------------------------------------------
syz-executor.3/27804 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffff88803102cd38 (&new->fa_lock){....}-{2:2}, at: kill_fasync_rcu fs/fcntl.c:1014 [inline]
ffff88803102cd38 (&new->fa_lock){....}-{2:2}, at: kill_fasync fs/fcntl.c:1035 [inline]
ffff88803102cd38 (&new->fa_lock){....}-{2:2}, at: kill_fasync+0x136/0x470 fs/fcntl.c:1028

and this task is already holding:
ffff88814af73948 (&timer->lock){....}-{2:2}, at: snd_timer_start1+0x5a/0x800 sound/core/timer.c:541
which would create a new lock dependency:
 (&timer->lock){....}-{2:2} -> (&new->fa_lock){....}-{2:2}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (&group->lock){..-.}-{2:2}

... which became SOFTIRQ-irq-safe at:
  lock_acquire kernel/locking/lockdep.c:5637 [inline]
  lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
  _snd_pcm_stream_lock_irqsave+0x9f/0xd0 sound/core/pcm_native.c:170
  snd_pcm_period_elapsed+0x1d/0x50 sound/core/pcm_lib.c:1848
  loopback_jiffies_timer_function+0x1c4/0x240 sound/drivers/aloop.c:668
  call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421
  expire_timers kernel/time/timer.c:1466 [inline]
  __run_timers.part.0+0x675/0xa20 kernel/time/timer.c:1734
  __run_timers kernel/time/timer.c:1715 [inline]
  run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1747
  __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
  invoke_softirq kernel/softirq.c:432 [inline]
  __irq_exit_rcu+0x123/0x180 kernel/softirq.c:636
  irq_exit_rcu+0x5/0x20 kernel/softirq.c:648
  sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
  asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
  _raw_spin_unlock_irqrestore+0x38/0x70 kernel/locking/spinlock.c:194
  __debug_check_no_obj_freed lib/debugobjects.c:1002 [inline]
  debug_check_no_obj_freed+0x20c/0x420 lib/debugobjects.c:1023
  slab_free_hook mm/slub.c:1698 [inline]
  slab_free_freelist_hook+0xeb/0x1c0 mm/slub.c:1749
  slab_free mm/slub.c:3513 [inline]
  kfree+0xf6/0x560 mm/slub.c:4561
  skb_free_head net/core/skbuff.c:655 [inline]
  skb_release_data+0x65a/0x790 net/core/skbuff.c:677
  skb_release_all net/core/skbuff.c:742 [inline]
  __kfree_skb net/core/skbuff.c:756 [inline]
  kfree_skb net/core/skbuff.c:774 [inline]
  kfree_skb+0x133/0x3f0 net/core/skbuff.c:768
  ieee80211_iface_work+0x411/0xd00 net/mac80211/iface.c:1522
  process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
  worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
  kthread+0x405/0x4f0 kernel/kthread.c:327
  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

to a SOFTIRQ-irq-unsafe lock:
 (tasklist_lock){.+.+}-{2:2}

... which became SOFTIRQ-irq-unsafe at:
...
  lock_acquire kernel/locking/lockdep.c:5637 [inline]
  lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
  __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
  _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
  do_wait+0x284/0xce0 kernel/exit.c:1511
  kernel_wait+0x9c/0x150 kernel/exit.c:1701
  call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
  call_usermodehelper_exec_work+0xf5/0x180 kernel/umh.c:166
  process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
  worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
  kthread+0x405/0x4f0 kernel/kthread.c:327
  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

other info that might help us debug this:

Chain exists of:
  &group->lock --> &timer->lock --> tasklist_lock

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(tasklist_lock);
                               local_irq_disable();
                               lock(&group->lock);
                               lock(&timer->lock);
  <Interrupt>
    lock(&group->lock);

 *** DEADLOCK ***

3 locks held by syz-executor.3/27804:
 #0: ffff8880409bf568 (&tu->ioctl_lock){+.+.}-{3:3}, at: snd_timer_user_ioctl+0x4c/0xb0 sound/core/timer.c:2128
 #1: ffff88814af73948 (&timer->lock){....}-{2:2}, at: snd_timer_start1+0x5a/0x800 sound/core/timer.c:541
 #2: ffffffff8b983a20 (rcu_read_lock){....}-{1:2}, at: kill_fasync+0x41/0x470 fs/fcntl.c:1033

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
 -> (&group->lock){..-.}-{2:2} {
    IN-SOFTIRQ-W at:
                      lock_acquire kernel/locking/lockdep.c:5637 [inline]
                      lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                      __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                      _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
                      _snd_pcm_stream_lock_irqsave+0x9f/0xd0 sound/core/pcm_native.c:170
                      snd_pcm_period_elapsed+0x1d/0x50 sound/core/pcm_lib.c:1848
                      loopback_jiffies_timer_function+0x1c4/0x240 sound/drivers/aloop.c:668
                      call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421
                      expire_timers kernel/time/timer.c:1466 [inline]
                      __run_timers.part.0+0x675/0xa20 kernel/time/timer.c:1734
                      __run_timers kernel/time/timer.c:1715 [inline]
                      run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1747
                      __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
                      invoke_softirq kernel/softirq.c:432 [inline]
                      __irq_exit_rcu+0x123/0x180 kernel/softirq.c:636
                      irq_exit_rcu+0x5/0x20 kernel/softirq.c:648
                      sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
                      asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
                      __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
                      _raw_spin_unlock_irqrestore+0x38/0x70 kernel/locking/spinlock.c:194
                      __debug_check_no_obj_freed lib/debugobjects.c:1002 [inline]
                      debug_check_no_obj_freed+0x20c/0x420 lib/debugobjects.c:1023
                      slab_free_hook mm/slub.c:1698 [inline]
                      slab_free_freelist_hook+0xeb/0x1c0 mm/slub.c:1749
                      slab_free mm/slub.c:3513 [inline]
                      kfree+0xf6/0x560 mm/slub.c:4561
                      skb_free_head net/core/skbuff.c:655 [inline]
                      skb_release_data+0x65a/0x790 net/core/skbuff.c:677
                      skb_release_all net/core/skbuff.c:742 [inline]
                      __kfree_skb net/core/skbuff.c:756 [inline]
                      kfree_skb net/core/skbuff.c:774 [inline]
                      kfree_skb+0x133/0x3f0 net/core/skbuff.c:768
                      ieee80211_iface_work+0x411/0xd00 net/mac80211/iface.c:1522
                      process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
                      worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
                      kthread+0x405/0x4f0 kernel/kthread.c:327
                      ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
    INITIAL USE at:
                     lock_acquire kernel/locking/lockdep.c:5637 [inline]
                     lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                     __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
                     _raw_spin_lock_irq+0x32/0x50 kernel/locking/spinlock.c:170
                     spin_lock_irq include/linux/spinlock.h:374 [inline]
                     snd_pcm_group_lock_irq sound/core/pcm_native.c:97 [inline]
                     snd_pcm_stream_lock_irq sound/core/pcm_native.c:136 [inline]
                     snd_pcm_hw_params+0x12a/0x1990 sound/core/pcm_native.c:686
                     snd_pcm_kernel_ioctl+0x164/0x310 sound/core/pcm_native.c:3372
                     snd_pcm_oss_change_params_locked+0x1936/0x3a60 sound/core/oss/pcm_oss.c:947
                     snd_pcm_oss_change_params sound/core/oss/pcm_oss.c:1091 [inline]
                     snd_pcm_oss_get_active_substream+0x164/0x1c0 sound/core/oss/pcm_oss.c:1108
                     snd_pcm_oss_get_formats+0x75/0x340 sound/core/oss/pcm_oss.c:1830
                     snd_pcm_oss_set_format sound/core/oss/pcm_oss.c:1872 [inline]
                     snd_pcm_oss_ioctl+0x1034/0x3430 sound/core/oss/pcm_oss.c:2644
                     vfs_ioctl fs/ioctl.c:51 [inline]
                     __do_sys_ioctl fs/ioctl.c:874 [inline]
                     __se_sys_ioctl fs/ioctl.c:860 [inline]
                     __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
                     do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                     do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                     entry_SYSCALL_64_after_hwframe+0x44/0xae
  }
  ... key      at: [<ffffffff90606fe0>] __key.9+0x0/0x40
-> (&timer->lock){....}-{2:2} {
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5637 [inline]
                   lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
                   _raw_spin_lock_irq+0x32/0x50 kernel/locking/spinlock.c:170
                   spin_lock_irq include/linux/spinlock.h:374 [inline]
                   snd_timer_close_locked+0x63/0xbb0 sound/core/timer.c:396
                   snd_timer_close+0x87/0xf0 sound/core/timer.c:463
                   snd_seq_timer_close+0x8c/0xe0 sound/core/seq/seq_timer.c:326
                   queue_delete+0x4a/0xa0 sound/core/seq/seq_queue.c:134
                   snd_seq_queue_delete+0x45/0x60 sound/core/seq/seq_queue.c:196
                   snd_seq_kernel_client_ctl+0x102/0x1e0 sound/core/seq/seq_clientmgr.c:2369
                   delete_seq_queue.part.0.isra.0+0xa2/0x110 sound/core/seq/oss/seq_oss_init.c:377
                   delete_seq_queue sound/core/seq/oss/seq_oss_init.c:373 [inline]
                   snd_seq_oss_release+0x10b/0x1a0 sound/core/seq/oss/seq_oss_init.c:422
                   odev_release+0x4f/0x70 sound/core/seq/oss/seq_oss.c:144
                   __fput+0x286/0x9f0 fs/file_table.c:280
                   task_work_run+0xdd/0x1a0 kernel/task_work.c:164
                   tracehook_notify_resume include/linux/tracehook.h:189 [inline]
                   exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
                   exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
                   __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
                   syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
                   do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
                   entry_SYSCALL_64_after_hwframe+0x44/0xae
 }
 ... key      at: [<ffffffff90606780>] __key.12+0x0/0x40
 ... acquired at:
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
   snd_timer_notify sound/core/timer.c:1087 [inline]
   snd_timer_notify+0x10c/0x3d0 sound/core/timer.c:1074
   snd_pcm_timer_notify sound/core/pcm_native.c:595 [inline]
   snd_pcm_post_start+0x24a/0x310 sound/core/pcm_native.c:1392
   snd_pcm_action_single sound/core/pcm_native.c:1229 [inline]
   snd_pcm_action+0x143/0x170 sound/core/pcm_native.c:1310
   __snd_pcm_lib_xfer+0x1633/0x1d80 sound/core/pcm_lib.c:2221
   snd_pcm_oss_read3+0x1c4/0x400 sound/core/oss/pcm_oss.c:1267
   snd_pcm_oss_read2+0x300/0x3f0 sound/core/oss/pcm_oss.c:1478
   snd_pcm_oss_read1 sound/core/oss/pcm_oss.c:1525 [inline]
   snd_pcm_oss_read+0x626/0x7b0 sound/core/oss/pcm_oss.c:2769
   vfs_read+0x1b5/0x600 fs/read_write.c:479
   ksys_read+0x12d/0x250 fs/read_write.c:619
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae


the dependencies between the lock to be acquired
 and SOFTIRQ-irq-unsafe lock:
  -> (tasklist_lock){.+.+}-{2:2} {
     HARDIRQ-ON-R at:
                        lock_acquire kernel/locking/lockdep.c:5637 [inline]
                        lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                        __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                        _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
                        do_wait+0x284/0xce0 kernel/exit.c:1511
                        kernel_wait+0x9c/0x150 kernel/exit.c:1701
                        call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
                        call_usermodehelper_exec_work+0xf5/0x180 kernel/umh.c:166
                        process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
                        worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
                        kthread+0x405/0x4f0 kernel/kthread.c:327
                        ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
     SOFTIRQ-ON-R at:
                        lock_acquire kernel/locking/lockdep.c:5637 [inline]
                        lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                        __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                        _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
                        do_wait+0x284/0xce0 kernel/exit.c:1511
                        kernel_wait+0x9c/0x150 kernel/exit.c:1701
                        call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
                        call_usermodehelper_exec_work+0xf5/0x180 kernel/umh.c:166
                        process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
                        worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
                        kthread+0x405/0x4f0 kernel/kthread.c:327
                        ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
     INITIAL USE at:
                       lock_acquire kernel/locking/lockdep.c:5637 [inline]
                       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                       __raw_write_lock_irq include/linux/rwlock_api_smp.h:194 [inline]
                       _raw_write_lock_irq+0x32/0x50 kernel/locking/spinlock.c:316
                       copy_process+0x36c0/0x75a0 kernel/fork.c:2310
                       kernel_clone+0xe7/0xab0 kernel/fork.c:2581
                       kernel_thread+0xb5/0xf0 kernel/fork.c:2633
                       rest_init+0x23/0x3e0 init/main.c:690
                       start_kernel+0x47a/0x49b init/main.c:1135
                       secondary_startup_64_no_verify+0xb0/0xbb
     INITIAL READ USE at:
                            lock_acquire kernel/locking/lockdep.c:5637 [inline]
                            lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                            __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                            _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
                            do_wait+0x284/0xce0 kernel/exit.c:1511
                            kernel_wait+0x9c/0x150 kernel/exit.c:1701
                            call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
                            call_usermodehelper_exec_work+0xf5/0x180 kernel/umh.c:166
                            process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
                            worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
                            kthread+0x405/0x4f0 kernel/kthread.c:327
                            ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
   }
   ... key      at: [<ffffffff8b60a098>] tasklist_lock+0x18/0x40
   ... acquired at:
   __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
   _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
   send_sigio+0xab/0x380 fs/fcntl.c:810
   kill_fasync_rcu fs/fcntl.c:1021 [inline]
   kill_fasync fs/fcntl.c:1035 [inline]
   kill_fasync+0x1f8/0x470 fs/fcntl.c:1028
   sock_wake_async+0xd2/0x160 net/socket.c:1368
   sk_wake_async include/net/sock.h:2400 [inline]
   sk_wake_async include/net/sock.h:2396 [inline]
   sock_def_readable+0x349/0x4e0 net/core/sock.c:3138
   unix_dgram_sendmsg+0xfa7/0x1950 net/unix/af_unix.c:1941
   sock_sendmsg_nosec net/socket.c:704 [inline]
   sock_sendmsg+0xcf/0x120 net/socket.c:724
   ____sys_sendmsg+0x331/0x810 net/socket.c:2409
   ___sys_sendmsg+0xf3/0x170 net/socket.c:2463
   __sys_sendmmsg+0x195/0x470 net/socket.c:2549
   __do_sys_sendmmsg net/socket.c:2578 [inline]
   __se_sys_sendmmsg net/socket.c:2575 [inline]
   __x64_sys_sendmmsg+0x99/0x100 net/socket.c:2575
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae

 -> (&f->f_owner.lock){....}-{2:2} {
    INITIAL USE at:
                     lock_acquire kernel/locking/lockdep.c:5637 [inline]
                     lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                     __raw_write_lock_irq include/linux/rwlock_api_smp.h:194 [inline]
                     _raw_write_lock_irq+0x32/0x50 kernel/locking/spinlock.c:316
                     f_modown+0x2a/0x390 fs/fcntl.c:91
                     __f_setown fs/fcntl.c:110 [inline]
                     f_setown+0xd7/0x230 fs/fcntl.c:138
                     do_fcntl+0x749/0x1210 fs/fcntl.c:393
                     __do_sys_fcntl fs/fcntl.c:472 [inline]
                     __se_sys_fcntl fs/fcntl.c:457 [inline]
                     __x64_sys_fcntl+0x165/0x1e0 fs/fcntl.c:457
                     do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                     do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                     entry_SYSCALL_64_after_hwframe+0x44/0xae
    INITIAL READ USE at:
                          lock_acquire kernel/locking/lockdep.c:5637 [inline]
                          lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                          __raw_read_lock_irq include/linux/rwlock_api_smp.h:168 [inline]
                          _raw_read_lock_irq+0x63/0x80 kernel/locking/spinlock.c:244
                          f_getown+0x23/0x2a0 fs/fcntl.c:154
                          do_fcntl+0xbd8/0x1210 fs/fcntl.c:389
                          __do_sys_fcntl fs/fcntl.c:472 [inline]
                          __se_sys_fcntl fs/fcntl.c:457 [inline]
                          __x64_sys_fcntl+0x165/0x1e0 fs/fcntl.c:457
                          do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                          do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                          entry_SYSCALL_64_after_hwframe+0x44/0xae
  }
  ... key      at: [<ffffffff90307de0>] __key.5+0x0/0x40
  ... acquired at:
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
   _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236
   send_sigio+0x24/0x380 fs/fcntl.c:796
   kill_fasync_rcu fs/fcntl.c:1021 [inline]
   kill_fasync fs/fcntl.c:1035 [inline]
   kill_fasync+0x1f8/0x470 fs/fcntl.c:1028
   sock_wake_async+0xd2/0x160 net/socket.c:1368
   sk_wake_async include/net/sock.h:2400 [inline]
   sk_wake_async+0x108/0x290 include/net/sock.h:2396
   unix_release_sock+0x79d/0xbc0 net/unix/af_unix.c:570
   unix_release+0x84/0xe0 net/unix/af_unix.c:949
   __sock_release+0xcd/0x280 net/socket.c:649
   sock_close+0x18/0x20 net/socket.c:1314
   __fput+0x286/0x9f0 fs/file_table.c:280
   task_work_run+0xdd/0x1a0 kernel/task_work.c:164
   get_signal+0x1b80/0x21d0 kernel/signal.c:2593
   arch_do_signal_or_restart+0x2a9/0x1c40 arch/x86/kernel/signal.c:868
   handle_signal_work kernel/entry/common.c:148 [inline]
   exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
   exit_to_user_mode_prepare+0x17d/0x290 kernel/entry/common.c:207
   __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
   syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
   do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
   entry_SYSCALL_64_after_hwframe+0x44/0xae

-> (&new->fa_lock){....}-{2:2} {
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5637 [inline]
                   lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:194 [inline]
                   _raw_write_lock_irq+0x32/0x50 kernel/locking/spinlock.c:316
                   fasync_remove_entry+0xb6/0x1f0 fs/fcntl.c:891
                   fasync_helper+0x9e/0xb0 fs/fcntl.c:994
                   sock_fasync+0x94/0x140 net/socket.c:1339
                   __fput+0x846/0x9f0 fs/file_table.c:277
                   task_work_run+0xdd/0x1a0 kernel/task_work.c:164
                   tracehook_notify_resume include/linux/tracehook.h:189 [inline]
                   exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
                   exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
                   __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
                   syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
                   do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
                   entry_SYSCALL_64_after_hwframe+0x44/0xae
   INITIAL READ USE at:
                        lock_acquire kernel/locking/lockdep.c:5637 [inline]
                        lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                        __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
                        _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236
                        kill_fasync_rcu fs/fcntl.c:1014 [inline]
                        kill_fasync fs/fcntl.c:1035 [inline]
                        kill_fasync+0x136/0x470 fs/fcntl.c:1028
                        sock_wake_async+0xd2/0x160 net/socket.c:1368
                        sk_wake_async include/net/sock.h:2400 [inline]
                        sk_wake_async+0x108/0x290 include/net/sock.h:2396
                        unix_release_sock+0x79d/0xbc0 net/unix/af_unix.c:570
                        unix_release+0x84/0xe0 net/unix/af_unix.c:949
                        __sock_release+0xcd/0x280 net/socket.c:649
                        sock_close+0x18/0x20 net/socket.c:1314
                        __fput+0x286/0x9f0 fs/file_table.c:280
                        task_work_run+0xdd/0x1a0 kernel/task_work.c:164
                        get_signal+0x1b80/0x21d0 kernel/signal.c:2593
                        arch_do_signal_or_restart+0x2a9/0x1c40 arch/x86/kernel/signal.c:868
                        handle_signal_work kernel/entry/common.c:148 [inline]
                        exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
                        exit_to_user_mode_prepare+0x17d/0x290 kernel/entry/common.c:207
                        __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
                        syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
                        do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
                        entry_SYSCALL_64_after_hwframe+0x44/0xae
 }
 ... key      at: [<ffffffff90308bc0>] __key.0+0x0/0x40
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5637 [inline]
   lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
   _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236
   kill_fasync_rcu fs/fcntl.c:1014 [inline]
   kill_fasync fs/fcntl.c:1035 [inline]
   kill_fasync+0x136/0x470 fs/fcntl.c:1028
   snd_timer_user_ccallback+0x298/0x330 sound/core/timer.c:1387
   snd_timer_notify1+0x11c/0x3b0 sound/core/timer.c:516
   snd_timer_start1+0x4d4/0x800 sound/core/timer.c:578
   snd_timer_start sound/core/timer.c:697 [inline]
   snd_timer_start sound/core/timer.c:690 [inline]
   snd_timer_user_start.isra.0+0x1e3/0x260 sound/core/timer.c:1985
   __snd_timer_user_ioctl.isra.0+0xda8/0x2490 sound/core/timer.c:2108
   snd_timer_user_ioctl+0x77/0xb0 sound/core/timer.c:2129
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:874 [inline]
   __se_sys_ioctl fs/ioctl.c:860 [inline]
   __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae


stack backtrace:
CPU: 1 PID: 27804 Comm: syz-executor.3 Not tainted 5.15.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_bad_irq_dependency kernel/locking/lockdep.c:2577 [inline]
 check_irq_usage.cold+0x4c1/0x6b0 kernel/locking/lockdep.c:2816
 check_prev_add kernel/locking/lockdep.c:3067 [inline]
 check_prevs_add kernel/locking/lockdep.c:3186 [inline]
 validate_chain kernel/locking/lockdep.c:3801 [inline]
 __lock_acquire+0x2a1f/0x54a0 kernel/locking/lockdep.c:5027
 lock_acquire kernel/locking/lockdep.c:5637 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
 __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
 _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236
 kill_fasync_rcu fs/fcntl.c:1014 [inline]
 kill_fasync fs/fcntl.c:1035 [inline]
 kill_fasync+0x136/0x470 fs/fcntl.c:1028
 snd_timer_user_ccallback+0x298/0x330 sound/core/timer.c:1387
 snd_timer_notify1+0x11c/0x3b0 sound/core/timer.c:516
 snd_timer_start1+0x4d4/0x800 sound/core/timer.c:578
 snd_timer_start sound/core/timer.c:697 [inline]
 snd_timer_start sound/core/timer.c:690 [inline]
 snd_timer_user_start.isra.0+0x1e3/0x260 sound/core/timer.c:1985
 __snd_timer_user_ioctl.isra.0+0xda8/0x2490 sound/core/timer.c:2108
 snd_timer_user_ioctl+0x77/0xb0 sound/core/timer.c:2129
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f927e7d2ae9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f927bd48188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f927e8e5f60 RCX: 00007f927e7d2ae9
RDX: 0000000000000000 RSI: 00000000000054a0 RDI: 0000000000000003
RBP: 00007f927e82cf6d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcc9c48d0f R14: 00007f927bd48300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
