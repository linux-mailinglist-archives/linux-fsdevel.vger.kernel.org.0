Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E515B4CD6B2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 15:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239935AbiCDOrR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 09:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiCDOrQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:47:16 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3561BD980
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Mar 2022 06:46:26 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id s17-20020a056e0210d100b002c618c396b0so892642ilj.15
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Mar 2022 06:46:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=FvxOikeOYNqGVM9ftilHrry3PJVEslcNGdspyK5pBos=;
        b=5lWVokAW7EeTGhQSTDJ4ciBWSaCz5SoksfWsu2bNV+AWUPu1veIBR8F3uNImGcxsg+
         f8LEl5XuG23pe6xV0ufdOTiZcf8h36BVttSaJ4phACGNiyXukeWrEWFZq0OYIH0SkqAh
         i5rcxh2lhXMlqhGBiLHrA6nmplUKHS7mMjOTn/PXIdtmRd+JwfcPH2sKqFPMBtpTHhPH
         fv/q1QE4UmO+9JST4Ubk1MofyegkrpAm22adwSf7hy9WO0NaCVKtbYx/ZbB7o7TyBENF
         wMwvl/CU2iv9V+cv+X0p4Axk9eCCtKqaNu2p2Cm4B4yIBLlfGz8HX7pk8THY1fJZ/a0Y
         QMFQ==
X-Gm-Message-State: AOAM531jbvLEnauwmx7tI+BXBMxMVWcS5TNcPULf2dyRubo1WlgJnX2L
        Ubi2i2uvXp2rQJlnRXyLT89OEGXzVwEwZx8F++C9oxRASC0W
X-Google-Smtp-Source: ABdhPJz9nmRn18CZObo+KiOWTyOo+v2+W1VazKHeJcQI2WpXfGvfvQON847vBVKWzyTU8vJlXdQ+bjNG+LckTdeFa+9Ndbo79MHB
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18ce:b0:2be:1f36:eef8 with SMTP id
 s14-20020a056e0218ce00b002be1f36eef8mr35773987ilu.88.1646405186273; Fri, 04
 Mar 2022 06:46:26 -0800 (PST)
Date:   Fri, 04 Mar 2022 06:46:26 -0800
In-Reply-To: <000000000000afc4bc05d150d3af@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000048c71405d96594c7@google.com>
Subject: Re: [syzbot] possible deadlock in snd_timer_interrupt (2)
From:   syzbot <syzbot+1ee0910eca9c94f71f25@syzkaller.appspotmail.com>
To:     alsa-devel-owner@alsa-project.org, alsa-devel@alsa-project.org,
        bfields@fieldses.org, hdanton@sina.com, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com,
        viro@zeniv.linux.org.uk, wangwensheng4@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    38f80f42147f MAINTAINERS: Remove dead patchwork link
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=161736d6700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e9585407e09f75f
dashboard link: https://syzkaller.appspot.com/bug?extid=1ee0910eca9c94f71f25
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b6ad85700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12527ef1700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1ee0910eca9c94f71f25@syzkaller.appspotmail.com

========================================================
WARNING: possible irq lock inversion dependency detected
5.17.0-rc6-syzkaller-00184-g38f80f42147f #0 Not tainted
--------------------------------------------------------
syz-executor301/4486 just changed the state of lock:
ffff88814a78a948 (&timer->lock){..-.}-{2:2}, at: snd_timer_interrupt.part.0+0x34/0xcf0 sound/core/timer.c:856
but this lock took another, SOFTIRQ-READ-unsafe lock in the past:
 (tasklist_lock){.+.+}-{2:2}


and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
Chain exists of:
  &timer->lock --> &new->fa_lock --> tasklist_lock

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(tasklist_lock);
                               local_irq_disable();
                               lock(&timer->lock);
                               lock(&new->fa_lock);
  <Interrupt>
    lock(&timer->lock);

 *** DEADLOCK ***

1 lock held by syz-executor301/4486:
 #0: ffffc90000007d70 ((&priv->tlist)){+.-.}-{0:0}, at: lockdep_copy_map include/linux/lockdep.h:35 [inline]
 #0: ffffc90000007d70 ((&priv->tlist)){+.-.}-{0:0}, at: call_timer_fn+0xd5/0x6b0 kernel/time/timer.c:1411

the shortest dependencies between 2nd lock and 1st lock:
   -> (tasklist_lock){.+.+}-{2:2} {
      HARDIRQ-ON-R at:
                          lock_acquire kernel/locking/lockdep.c:5639 [inline]
                          lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                          __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                          _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
                          do_wait+0x284/0xce0 kernel/exit.c:1518
                          kernel_wait+0x9c/0x150 kernel/exit.c:1708
                          call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
                          call_usermodehelper_exec_work+0xf5/0x180 kernel/umh.c:166
                          process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
                          worker_thread+0x657/0x1110 kernel/workqueue.c:2454
                          kthread+0x2e9/0x3a0 kernel/kthread.c:377
                          ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
      SOFTIRQ-ON-R at:
                          lock_acquire kernel/locking/lockdep.c:5639 [inline]
                          lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                          __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                          _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
                          do_wait+0x284/0xce0 kernel/exit.c:1518
                          kernel_wait+0x9c/0x150 kernel/exit.c:1708
                          call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
                          call_usermodehelper_exec_work+0xf5/0x180 kernel/umh.c:166
                          process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
                          worker_thread+0x657/0x1110 kernel/workqueue.c:2454
                          kthread+0x2e9/0x3a0 kernel/kthread.c:377
                          ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
      INITIAL USE at:
                         lock_acquire kernel/locking/lockdep.c:5639 [inline]
                         lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                         __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                         _raw_write_lock_irq+0x32/0x50 kernel/locking/spinlock.c:326
                         copy_process+0x486a/0x7250 kernel/fork.c:2295
                         kernel_clone+0xe7/0xab0 kernel/fork.c:2565
                         kernel_thread+0xb5/0xf0 kernel/fork.c:2617
                         rest_init+0x23/0x3e0 init/main.c:690
                         start_kernel+0x47a/0x49b init/main.c:1138
                         secondary_startup_64_no_verify+0xc3/0xcb
      INITIAL READ USE at:
                              lock_acquire kernel/locking/lockdep.c:5639 [inline]
                              lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                              __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                              _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
                              do_wait+0x284/0xce0 kernel/exit.c:1518
                              kernel_wait+0x9c/0x150 kernel/exit.c:1708
                              call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
                              call_usermodehelper_exec_work+0xf5/0x180 kernel/umh.c:166
                              process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
                              worker_thread+0x657/0x1110 kernel/workqueue.c:2454
                              kthread+0x2e9/0x3a0 kernel/kthread.c:377
                              ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
    }
    ... key      at: [<ffffffff8b80a098>] tasklist_lock+0x18/0x40
    ... acquired at:
   __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
   _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
   send_sigio+0xab/0x380 fs/fcntl.c:810
   kill_fasync_rcu fs/fcntl.c:1021 [inline]
   kill_fasync fs/fcntl.c:1035 [inline]
   kill_fasync+0x1f8/0x470 fs/fcntl.c:1028
   snd_timer_user_ccallback+0x298/0x330 sound/core/timer.c:1386
   snd_timer_notify1+0x11c/0x3b0 sound/core/timer.c:516
   snd_timer_stop1+0x496/0x860 sound/core/timer.c:657
   snd_timer_stop sound/core/timer.c:710 [inline]
   snd_timer_close_locked+0x20f/0xbb0 sound/core/timer.c:408
   snd_timer_close+0x87/0xf0 sound/core/timer.c:463
   __snd_timer_user_ioctl.isra.0+0x10e2/0x2490 sound/core/timer.c:1762
   snd_timer_user_ioctl+0x77/0xb0 sound/core/timer.c:2128
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:874 [inline]
   __se_sys_ioctl fs/ioctl.c:860 [inline]
   __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae

  -> (&f->f_owner.lock){....}-{2:2} {
     INITIAL USE at:
                       lock_acquire kernel/locking/lockdep.c:5639 [inline]
                       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                       __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                       _raw_write_lock_irq+0x32/0x50 kernel/locking/spinlock.c:326
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
                            lock_acquire kernel/locking/lockdep.c:5639 [inline]
                            lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                            __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
                            _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236
                            send_sigio+0x24/0x380 fs/fcntl.c:796
                            kill_fasync_rcu fs/fcntl.c:1021 [inline]
                            kill_fasync fs/fcntl.c:1035 [inline]
                            kill_fasync+0x1f8/0x470 fs/fcntl.c:1028
                            snd_timer_user_ccallback+0x298/0x330 sound/core/timer.c:1386
                            snd_timer_notify1+0x11c/0x3b0 sound/core/timer.c:516
                            snd_timer_start1+0x4d4/0x800 sound/core/timer.c:578
                            snd_timer_start sound/core/timer.c:696 [inline]
                            snd_timer_start sound/core/timer.c:689 [inline]
                            snd_timer_user_start.isra.0+0x1e3/0x260 sound/core/timer.c:1984
                            __snd_timer_user_ioctl.isra.0+0xda8/0x2490 sound/core/timer.c:2107
                            snd_timer_user_ioctl+0x77/0xb0 sound/core/timer.c:2128
                            vfs_ioctl fs/ioctl.c:51 [inline]
                            __do_sys_ioctl fs/ioctl.c:874 [inline]
                            __se_sys_ioctl fs/ioctl.c:860 [inline]
                            __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
                            do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                            do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                            entry_SYSCALL_64_after_hwframe+0x44/0xae
   }
   ... key      at: [<ffffffff90585a40>] __key.5+0x0/0x40
   ... acquired at:
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236
   send_sigio+0x24/0x380 fs/fcntl.c:796
   kill_fasync_rcu fs/fcntl.c:1021 [inline]
   kill_fasync fs/fcntl.c:1035 [inline]
   kill_fasync+0x1f8/0x470 fs/fcntl.c:1028
   snd_timer_user_ccallback+0x298/0x330 sound/core/timer.c:1386
   snd_timer_notify1+0x11c/0x3b0 sound/core/timer.c:516
   snd_timer_start1+0x4d4/0x800 sound/core/timer.c:578
   snd_timer_start sound/core/timer.c:696 [inline]
   snd_timer_start sound/core/timer.c:689 [inline]
   snd_timer_user_start.isra.0+0x1e3/0x260 sound/core/timer.c:1984
   __snd_timer_user_ioctl.isra.0+0xda8/0x2490 sound/core/timer.c:2107
   snd_timer_user_ioctl+0x77/0xb0 sound/core/timer.c:2128
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:874 [inline]
   __se_sys_ioctl fs/ioctl.c:860 [inline]
   __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae

 -> (&new->fa_lock){....}-{2:2} {
    INITIAL USE at:
                     lock_acquire kernel/locking/lockdep.c:5639 [inline]
                     lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                     __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                     _raw_write_lock_irq+0x32/0x50 kernel/locking/spinlock.c:326
                     fasync_remove_entry+0xb6/0x1f0 fs/fcntl.c:891
                     fasync_helper+0x9e/0xb0 fs/fcntl.c:994
                     __fput+0x846/0x9f0 fs/file_table.c:314
                     task_work_run+0xdd/0x1a0 kernel/task_work.c:164
                     exit_task_work include/linux/task_work.h:32 [inline]
                     do_exit+0xb29/0x2a30 kernel/exit.c:806
                     do_group_exit+0xd2/0x2f0 kernel/exit.c:935
                     __do_sys_exit_group kernel/exit.c:946 [inline]
                     __se_sys_exit_group kernel/exit.c:944 [inline]
                     __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:944
                     do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                     do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                     entry_SYSCALL_64_after_hwframe+0x44/0xae
    INITIAL READ USE at:
                          lock_acquire kernel/locking/lockdep.c:5639 [inline]
                          lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                          __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
                          _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236
                          kill_fasync_rcu fs/fcntl.c:1014 [inline]
                          kill_fasync fs/fcntl.c:1035 [inline]
                          kill_fasync+0x136/0x470 fs/fcntl.c:1028
                          snd_timer_user_ccallback+0x298/0x330 sound/core/timer.c:1386
                          snd_timer_notify1+0x11c/0x3b0 sound/core/timer.c:516
                          snd_timer_start1+0x4d4/0x800 sound/core/timer.c:578
                          snd_timer_start sound/core/timer.c:696 [inline]
                          snd_timer_start sound/core/timer.c:689 [inline]
                          snd_timer_user_start.isra.0+0x1e3/0x260 sound/core/timer.c:1984
                          __snd_timer_user_ioctl.isra.0+0xda8/0x2490 sound/core/timer.c:2107
                          snd_timer_user_ioctl+0x77/0xb0 sound/core/timer.c:2128
                          vfs_ioctl fs/ioctl.c:51 [inline]
                          __do_sys_ioctl fs/ioctl.c:874 [inline]
                          __se_sys_ioctl fs/ioctl.c:860 [inline]
                          __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
                          do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                          do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                          entry_SYSCALL_64_after_hwframe+0x44/0xae
  }
  ... key      at: [<ffffffff90586820>] __key.0+0x0/0x40
  ... acquired at:
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236
   kill_fasync_rcu fs/fcntl.c:1014 [inline]
   kill_fasync fs/fcntl.c:1035 [inline]
   kill_fasync+0x136/0x470 fs/fcntl.c:1028
   snd_timer_user_ccallback+0x298/0x330 sound/core/timer.c:1386
   snd_timer_notify1+0x11c/0x3b0 sound/core/timer.c:516
   snd_timer_start1+0x4d4/0x800 sound/core/timer.c:578
   snd_timer_start sound/core/timer.c:696 [inline]
   snd_timer_start sound/core/timer.c:689 [inline]
   snd_timer_user_start.isra.0+0x1e3/0x260 sound/core/timer.c:1984
   __snd_timer_user_ioctl.isra.0+0xda8/0x2490 sound/core/timer.c:2107
   snd_timer_user_ioctl+0x77/0xb0 sound/core/timer.c:2128
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:874 [inline]
   __se_sys_ioctl fs/ioctl.c:860 [inline]
   __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae

-> (&timer->lock){..-.}-{2:2} {
   IN-SOFTIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5639 [inline]
                    lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
                    snd_timer_interrupt.part.0+0x34/0xcf0 sound/core/timer.c:856
                    snd_timer_interrupt sound/core/timer.c:1154 [inline]
                    snd_timer_s_function+0x14b/0x200 sound/core/timer.c:1154
                    call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421
                    expire_timers kernel/time/timer.c:1466 [inline]
                    __run_timers.part.0+0x67c/0xa30 kernel/time/timer.c:1734
                    __run_timers kernel/time/timer.c:1715 [inline]
                    run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1747
                    __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
                    invoke_softirq kernel/softirq.c:432 [inline]
                    __irq_exit_rcu+0x123/0x180 kernel/softirq.c:637
                    irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
                    sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
                    asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
                    bytes_is_nonzero mm/kasan/generic.c:85 [inline]
                    memory_is_nonzero mm/kasan/generic.c:102 [inline]
                    memory_is_poisoned_n mm/kasan/generic.c:128 [inline]
                    memory_is_poisoned mm/kasan/generic.c:159 [inline]
                    check_region_inline mm/kasan/generic.c:180 [inline]
                    kasan_check_range+0xde/0x180 mm/kasan/generic.c:189
                    instrument_atomic_read include/linux/instrumented.h:71 [inline]
                    atomic_long_read include/linux/atomic/atomic-instrumented.h:1265 [inline]
                    filp_close+0x22/0x170 fs/open.c:1318
                    close_files fs/file.c:403 [inline]
                    put_files_struct fs/file.c:418 [inline]
                    put_files_struct+0x1d0/0x350 fs/file.c:415
                    exit_files+0x7e/0xa0 fs/file.c:435
                    do_exit+0xaf2/0x2a30 kernel/exit.c:801
                    do_group_exit+0xd2/0x2f0 kernel/exit.c:935
                    __do_sys_exit_group kernel/exit.c:946 [inline]
                    __se_sys_exit_group kernel/exit.c:944 [inline]
                    __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:944
                    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                    do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                    entry_SYSCALL_64_after_hwframe+0x44/0xae
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5639 [inline]
                   lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                   _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
                   snd_timer_stop1+0x5c/0x860 sound/core/timer.c:626
                   snd_timer_stop sound/core/timer.c:710 [inline]
                   snd_timer_user_start.isra.0+0x8b/0x260 sound/core/timer.c:1981
                   __snd_timer_user_ioctl.isra.0+0xda8/0x2490 sound/core/timer.c:2107
                   snd_timer_user_ioctl+0x77/0xb0 sound/core/timer.c:2128
                   vfs_ioctl fs/ioctl.c:51 [inline]
                   __do_sys_ioctl fs/ioctl.c:874 [inline]
                   __se_sys_ioctl fs/ioctl.c:860 [inline]
                   __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
                   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                   entry_SYSCALL_64_after_hwframe+0x44/0xae
 }
 ... key      at: [<ffffffff908843c0>] __key.12+0x0/0x40
 ... acquired at:
   mark_lock kernel/locking/lockdep.c:4569 [inline]
   mark_usage kernel/locking/lockdep.c:4500 [inline]
   __lock_acquire+0x11e3/0x56c0 kernel/locking/lockdep.c:4981
   lock_acquire kernel/locking/lockdep.c:5639 [inline]
   lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
   snd_timer_interrupt.part.0+0x34/0xcf0 sound/core/timer.c:856
   snd_timer_interrupt sound/core/timer.c:1154 [inline]
   snd_timer_s_function+0x14b/0x200 sound/core/timer.c:1154
   call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421
   expire_timers kernel/time/timer.c:1466 [inline]
   __run_timers.part.0+0x67c/0xa30 kernel/time/timer.c:1734
   __run_timers kernel/time/timer.c:1715 [inline]
   run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1747
   __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
   invoke_softirq kernel/softirq.c:432 [inline]
   __irq_exit_rcu+0x123/0x180 kernel/softirq.c:637
   irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
   sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
   asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
   bytes_is_nonzero mm/kasan/generic.c:85 [inline]
   memory_is_nonzero mm/kasan/generic.c:102 [inline]
   memory_is_poisoned_n mm/kasan/generic.c:128 [inline]
   memory_is_poisoned mm/kasan/generic.c:159 [inline]
   check_region_inline mm/kasan/generic.c:180 [inline]
   kasan_check_range+0xde/0x180 mm/kasan/generic.c:189
   instrument_atomic_read include/linux/instrumented.h:71 [inline]
   atomic_long_read include/linux/atomic/atomic-instrumented.h:1265 [inline]
   filp_close+0x22/0x170 fs/open.c:1318
   close_files fs/file.c:403 [inline]
   put_files_struct fs/file.c:418 [inline]
   put_files_struct+0x1d0/0x350 fs/file.c:415
   exit_files+0x7e/0xa0 fs/file.c:435
   do_exit+0xaf2/0x2a30 kernel/exit.c:801
   do_group_exit+0xd2/0x2f0 kernel/exit.c:935
   __do_sys_exit_group kernel/exit.c:946 [inline]
   __se_sys_exit_group kernel/exit.c:944 [inline]
   __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:944
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae


stack backtrace:
CPU: 0 PID: 4486 Comm: syz-executor301 Not tainted 5.17.0-rc6-syzkaller-00184-g38f80f42147f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_irq_inversion_bug kernel/locking/lockdep.c:194 [inline]
 check_usage_forwards kernel/locking/lockdep.c:4043 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4175 [inline]
 mark_lock.part.0.cold+0x86/0xd8 kernel/locking/lockdep.c:4605
 mark_lock kernel/locking/lockdep.c:4569 [inline]
 mark_usage kernel/locking/lockdep.c:4500 [inline]
 __lock_acquire+0x11e3/0x56c0 kernel/locking/lockdep.c:4981
 lock_acquire kernel/locking/lockdep.c:5639 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
 snd_timer_interrupt.part.0+0x34/0xcf0 sound/core/timer.c:856
 snd_timer_interrupt sound/core/timer.c:1154 [inline]
 snd_timer_s_function+0x14b/0x200 sound/core/timer.c:1154
 call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421
 expire_timers kernel/time/timer.c:1466 [inline]
 __run_timers.part.0+0x67c/0xa30 kernel/time/timer.c:1734
 __run_timers kernel/time/timer.c:1715 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1747
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 invoke_softirq kernel/softirq.c:432 [inline]
 __irq_exit_rcu+0x123/0x180 kernel/softirq.c:637
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:85 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:102 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:128 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:159 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0xde/0x180 mm/kasan/generic.c:189
Code: 74 f2 48 89 c2 b8 01 00 00 00 48 85 d2 75 56 5b 5d 41 5c c3 48 85 d2 74 5e 48 01 ea eb 09 48 83 c0 01 48 39 d0 74 50 80 38 00 <74> f2 eb d4 41 bc 08 00 00 00 48 89 ea 45 29 dc 4d 8d 1c 2c eb 0c
RSP: 0018:ffffc9000376fd30 EFLAGS: 00000246
RAX: ffffed100f1d3d9f RBX: ffffed100f1d3da0 RCX: ffffffff81cb24b2
RDX: ffffed100f1d3da0 RSI: 0000000000000008 RDI: ffff888078e9ecf8
RBP: ffffed100f1d3d9f R08: 0000000000000000 R09: ffff888078e9ecff
R10: ffffed100f1d3d9f R11: 0000000000000000 R12: ffff88807ee70f00
R13: ffff888078e9ecf8 R14: ffff88807ee70f00 R15: ffff88807ee71028
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 atomic_long_read include/linux/atomic/atomic-instrumented.h:1265 [inline]
 filp_close+0x22/0x170 fs/open.c:1318
 close_files fs/file.c:403 [inline]
 put_files_struct fs/file.c:418 [inline]
 put_files_struct+0x1d0/0x350 fs/file.c:415
 exit_files+0x7e/0xa0 fs/file.c:435
 do_exit+0xaf2/0x2a30 kernel/exit.c:801
 do_group_exit+0xd2/0x2f0 kernel/exit.c:935
 __do_sys_exit_group kernel/exit.c:946 [inline]
 __se_sys_exit_group kernel/exit.c:944 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:944
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7ff95f986c99
Code: Unable to access opcode bytes at RIP 0x7ff95f986c6f.
RSP: 002b:00007ffecd4a5e98 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007ff95f9fb330 RCX: 00007ff95f986c99
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000246 R12: 00007ff95f9fb330
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>
----------------
Code disassembly (best guess):
   0:	74 f2                	je     0xfffffff4
   2:	48 89 c2             	mov    %rax,%rdx
   5:	b8 01 00 00 00       	mov    $0x1,%eax
   a:	48 85 d2             	test   %rdx,%rdx
   d:	75 56                	jne    0x65
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	c3                   	retq
  14:	48 85 d2             	test   %rdx,%rdx
  17:	74 5e                	je     0x77
  19:	48 01 ea             	add    %rbp,%rdx
  1c:	eb 09                	jmp    0x27
  1e:	48 83 c0 01          	add    $0x1,%rax
  22:	48 39 d0             	cmp    %rdx,%rax
  25:	74 50                	je     0x77
  27:	80 38 00             	cmpb   $0x0,(%rax)
* 2a:	74 f2                	je     0x1e <-- trapping instruction
  2c:	eb d4                	jmp    0x2
  2e:	41 bc 08 00 00 00    	mov    $0x8,%r12d
  34:	48 89 ea             	mov    %rbp,%rdx
  37:	45 29 dc             	sub    %r11d,%r12d
  3a:	4d 8d 1c 2c          	lea    (%r12,%rbp,1),%r11
  3e:	eb 0c                	jmp    0x4c

