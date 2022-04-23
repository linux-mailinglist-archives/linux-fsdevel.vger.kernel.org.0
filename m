Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D95A50CDF1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Apr 2022 00:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbiDWW3V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Apr 2022 18:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiDWW3V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Apr 2022 18:29:21 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE5D167D0
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Apr 2022 15:26:22 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id y20-20020a5e8714000000b0065494b96af2so8370599ioj.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Apr 2022 15:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=aO6Cx7zrh79GKrhzyf35vM5kq8NNmOkPBiU9tlVZJX4=;
        b=CCWn0yvuFwq49QaUGxsyi3fu6vqUin2KNqOqv1jsEMOcy1MjJjqGXR9up8J+jYv7IX
         uRyjAxPHNOMPNTySpHrOdOhXs2zE5o6w0cTf2gR5Sx8E7jXIMZspygyIMksiZEceRpwA
         Xj0G80PF997BVT3ic7wzQFoxph1fNV9QKGTtRxHpxoev5h8a11SMA5IuPYAR/R+R5AJg
         loETTefOPJ45ImDhe24u1r4E8nWxGSu9VPta6j7lAVdtzclUaV8b9X+JrkLWs6C5MBsJ
         5Gl40bFFOIoS73RP3N8sFwXd+8asSvvpFiaUB8YbBsEm2bkIR09Bi8QFqM4ZeQDsUM+x
         FfMQ==
X-Gm-Message-State: AOAM531yjdZpywm4TkUQCqP7ZLqSofgn8ZDLfUpMdLK8VZrepG5i8Mvc
        jvYWPWoG9JV/HkIFE93GB2wjpWWkkizuVCWKbe/Xv5bSgizz
X-Google-Smtp-Source: ABdhPJw1DWxu0ZcsqannsnbLaUGyuEo/PcfK+aNffSWAawOAhmcwS5HuVeigvE32979EdJW0YKSYjjaOUSdxkNpfbF0fNTQYRoyn
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35ac:b0:328:973b:8842 with SMTP id
 v44-20020a05663835ac00b00328973b8842mr5199819jal.160.1650752781621; Sat, 23
 Apr 2022 15:26:21 -0700 (PDT)
Date:   Sat, 23 Apr 2022 15:26:21 -0700
In-Reply-To: <000000000000542dc005d43ec857@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000291c7005dd59d53d@google.com>
Subject: Re: [syzbot] possible deadlock in snd_pcm_period_elapsed (3)
From:   syzbot <syzbot+669c9abf11a6a011dd09@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, bfields@fieldses.org,
        broonie@kernel.org, jlayton@kernel.org,
        kai.vehmanen@linux.intel.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, o-takashi@sakamocchi.jp,
        perex@perex.cz, pierre-louis.bossart@linux.intel.com,
        ranjani.sridharan@linux.intel.com, syzkaller-bugs@googlegroups.com,
        tiwai@suse.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    45ab9400e73f Merge tag 'perf-tools-fixes-for-v5.18-2022-04..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e13008f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1843173f299d1e8
dashboard link: https://syzkaller.appspot.com/bug?extid=669c9abf11a6a011dd09
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154827d0f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e5002cf00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+669c9abf11a6a011dd09@syzkaller.appspotmail.com

========================================================
WARNING: possible irq lock inversion dependency detected
5.18.0-rc3-syzkaller-00196-g45ab9400e73f #0 Not tainted
--------------------------------------------------------
swapper/0/0 just changed the state of lock:
ffff888023b16110 (&group->lock){..-.}-{2:2}, at: snd_pcm_period_elapsed+0x2c/0x210 sound/core/pcm_lib.c:1848
but this lock took another, SOFTIRQ-READ-unsafe lock in the past:
 (tasklist_lock){.+.+}-{2:2}


and interrupts could create inverse lock ordering between them.


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

no locks held by swapper/0/0.

the shortest dependencies between 2nd lock and 1st lock:
    -> (tasklist_lock){.+.+}-{2:2} {
       HARDIRQ-ON-R at:
                            lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5641
                            __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                            _raw_read_lock+0x32/0x40 kernel/locking/spinlock.c:228
                            do_wait+0x224/0x9d0 kernel/exit.c:1508
                            kernel_wait+0xe4/0x230 kernel/exit.c:1698
                            call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
                            call_usermodehelper_exec_work+0xb4/0x220 kernel/umh.c:166
                            process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
                            worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
                            kthread+0x266/0x300 kernel/kthread.c:376
                            ret_from_fork+0x1f/0x30
       SOFTIRQ-ON-R at:
                            lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5641
                            __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                            _raw_read_lock+0x32/0x40 kernel/locking/spinlock.c:228
                            do_wait+0x224/0x9d0 kernel/exit.c:1508
                            kernel_wait+0xe4/0x230 kernel/exit.c:1698
                            call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
                            call_usermodehelper_exec_work+0xb4/0x220 kernel/umh.c:166
                            process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
                            worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
                            kthread+0x266/0x300 kernel/kthread.c:376
                            ret_from_fork+0x1f/0x30
       INITIAL USE at:
                           lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5641
                           __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                           _raw_write_lock_irq+0xcf/0x110 kernel/locking/spinlock.c:326
                           copy_process+0x234d/0x3f70 kernel/fork.c:2368
                           kernel_clone+0x22f/0x7a0 kernel/fork.c:2639
                           kernel_thread+0x167/0x1e0 kernel/fork.c:2691
                           rest_init+0x21/0x2e0 init/main.c:691
                           start_kernel+0x4bf/0x56e init/main.c:1140
                           secondary_startup_64_no_verify+0xc4/0xcb
       INITIAL READ USE at:
                                lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5641
                                __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                                _raw_read_lock+0x32/0x40 kernel/locking/spinlock.c:228
                                do_wait+0x224/0x9d0 kernel/exit.c:1508
                                kernel_wait+0xe4/0x230 kernel/exit.c:1698
                                call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
                                call_usermodehelper_exec_work+0xb4/0x220 kernel/umh.c:166
                                process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
                                worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
                                kthread+0x266/0x300 kernel/kthread.c:376
                                ret_from_fork+0x1f/0x30
     }
     ... key      at: [<ffffffff8c80a058>] tasklist_lock+0x18/0x40
     ... acquired at:
   lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5641
   __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
   _raw_read_lock+0x32/0x40 kernel/locking/spinlock.c:228
   send_sigio+0xbe/0x300 fs/fcntl.c:792
   dnotify_handle_event+0x136/0x450 fs/notify/dnotify/dnotify.c:115
   fsnotify+0xc84/0x1270 fs/notify/fsnotify.c:564
   fsnotify_name include/linux/fsnotify.h:36 [inline]
   fsnotify_dirent include/linux/fsnotify.h:42 [inline]
   fsnotify_create include/linux/fsnotify.h:207 [inline]
   open_last_lookups fs/namei.c:3402 [inline]
   path_openat+0x14b3/0x2ec0 fs/namei.c:3606
   do_filp_open+0x277/0x4f0 fs/namei.c:3636
   do_sys_openat2+0x13b/0x500 fs/open.c:1213
   do_sys_open fs/open.c:1229 [inline]
   __do_sys_creat fs/open.c:1305 [inline]
   __se_sys_creat fs/open.c:1299 [inline]
   __x64_sys_creat+0x11f/0x160 fs/open.c:1299
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae

   -> (&f->f_owner.lock){....}-{2:2} {
      INITIAL USE at:
                         lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5641
                         __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                         _raw_write_lock_irq+0xcf/0x110 kernel/locking/spinlock.c:326
                         f_modown+0x38/0x340 fs/fcntl.c:91
                         __f_setown fs/fcntl.c:110 [inline]
                         f_setown+0x113/0x1a0 fs/fcntl.c:138
                         do_fcntl+0x128/0x13b0 fs/fcntl.c:377
                         __do_sys_fcntl fs/fcntl.c:454 [inline]
                         __se_sys_fcntl+0xd5/0x1b0 fs/fcntl.c:439
                         do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                         do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
                         entry_SYSCALL_64_after_hwframe+0x44/0xae
      INITIAL READ USE at:
                              lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5641
                              __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
                              _raw_read_lock_irqsave+0xd9/0x120 kernel/locking/spinlock.c:236
                              send_sigio+0x2f/0x300 fs/fcntl.c:778
                              kill_fasync_rcu fs/fcntl.c:1003 [inline]
                              kill_fasync+0x1e4/0x430 fs/fcntl.c:1017
                              snd_timer_user_ccallback+0x370/0x540 sound/core/timer.c:1386
                              snd_timer_notify1+0x1ad/0x350 sound/core/timer.c:516
                              snd_timer_start1+0x53d/0x640 sound/core/timer.c:578
                              snd_timer_start sound/core/timer.c:696 [inline]
                              snd_timer_user_start sound/core/timer.c:1984 [inline]
                              __snd_timer_user_ioctl+0xae7/0x54c0 sound/core/timer.c:2107
                              snd_timer_user_ioctl+0x5d/0x80 sound/core/timer.c:2128
                              vfs_ioctl fs/ioctl.c:51 [inline]
                              __do_sys_ioctl fs/ioctl.c:870 [inline]
                              __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
                              do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                              do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
                              entry_SYSCALL_64_after_hwframe+0x44/0xae
    }
    ... key      at: [<ffffffff90c42cc0>] __alloc_file.__key+0x0/0x10
    ... acquired at:
   lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5641
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0xd9/0x120 kernel/locking/spinlock.c:236
   send_sigio+0x2f/0x300 fs/fcntl.c:778
   kill_fasync_rcu fs/fcntl.c:1003 [inline]
   kill_fasync+0x1e4/0x430 fs/fcntl.c:1017
   snd_timer_user_ccallback+0x370/0x540 sound/core/timer.c:1386
   snd_timer_notify1+0x1ad/0x350 sound/core/timer.c:516
   snd_timer_start1+0x53d/0x640 sound/core/timer.c:578
   snd_timer_start sound/core/timer.c:696 [inline]
   snd_timer_user_start sound/core/timer.c:1984 [inline]
   __snd_timer_user_ioctl+0xae7/0x54c0 sound/core/timer.c:2107
   snd_timer_user_ioctl+0x5d/0x80 sound/core/timer.c:2128
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:870 [inline]
   __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae

  -> (&new->fa_lock){....}-{2:2} {
     INITIAL READ USE at:
                            lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5641
                            __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
                            _raw_read_lock_irqsave+0xd9/0x120 kernel/locking/spinlock.c:236
                            kill_fasync_rcu fs/fcntl.c:996 [inline]
                            kill_fasync+0x13b/0x430 fs/fcntl.c:1017
                            snd_timer_user_ccallback+0x370/0x540 sound/core/timer.c:1386
                            snd_timer_notify1+0x1ad/0x350 sound/core/timer.c:516
                            snd_timer_start1+0x53d/0x640 sound/core/timer.c:578
                            snd_timer_start sound/core/timer.c:696 [inline]
                            snd_timer_user_start sound/core/timer.c:1984 [inline]
                            __snd_timer_user_ioctl+0xae7/0x54c0 sound/core/timer.c:2107
                            snd_timer_user_ioctl+0x5d/0x80 sound/core/timer.c:2128
                            vfs_ioctl fs/ioctl.c:51 [inline]
                            __do_sys_ioctl fs/ioctl.c:870 [inline]
                            __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
                            do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                            do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
                            entry_SYSCALL_64_after_hwframe+0x44/0xae
   }
   ... key      at: [<ffffffff90c43940>] fasync_insert_entry.__key+0x0/0x20
   ... acquired at:
   lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5641
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0xd9/0x120 kernel/locking/spinlock.c:236
   kill_fasync_rcu fs/fcntl.c:996 [inline]
   kill_fasync+0x13b/0x430 fs/fcntl.c:1017
   snd_timer_user_ccallback+0x370/0x540 sound/core/timer.c:1386
   snd_timer_notify1+0x1ad/0x350 sound/core/timer.c:516
   snd_timer_start1+0x53d/0x640 sound/core/timer.c:578
   snd_timer_start sound/core/timer.c:696 [inline]
   snd_timer_user_start sound/core/timer.c:1984 [inline]
   __snd_timer_user_ioctl+0xae7/0x54c0 sound/core/timer.c:2107
   snd_timer_user_ioctl+0x5d/0x80 sound/core/timer.c:2128
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:870 [inline]
   __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae

 -> (&timer->lock){....}-{2:2} {
    INITIAL USE at:
                     lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5641
                     __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                     _raw_spin_lock_irqsave+0xd1/0x120 kernel/locking/spinlock.c:162
                     snd_timer_resolution sound/core/timer.c:489 [inline]
                     snd_timer_user_params sound/core/timer.c:1851 [inline]
                     __snd_timer_user_ioctl+0x1a3f/0x54c0 sound/core/timer.c:2100
                     snd_timer_user_ioctl+0x5d/0x80 sound/core/timer.c:2128
                     vfs_ioctl fs/ioctl.c:51 [inline]
                     __do_sys_ioctl fs/ioctl.c:870 [inline]
                     __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
                     do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                     do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
                     entry_SYSCALL_64_after_hwframe+0x44/0xae
  }
  ... key      at: [<ffffffff90f96160>] snd_timer_new.__key+0x0/0x20
  ... acquired at:
   lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5641
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0xd1/0x120 kernel/locking/spinlock.c:162
   snd_timer_notify+0x105/0x3e0 sound/core/timer.c:1086
   snd_pcm_action sound/core/pcm_native.c:1364 [inline]
   snd_pcm_start+0x383/0x400 sound/core/pcm_native.c:1470
   __snd_pcm_lib_xfer+0x13e0/0x18a0 sound/core/pcm_lib.c:2308
   snd_pcm_oss_write3+0x202/0x390 sound/core/oss/pcm_oss.c:1253
   snd_pcm_oss_write2 sound/core/oss/pcm_oss.c:1393 [inline]
   snd_pcm_oss_sync1+0x3a6/0x7f0 sound/core/oss/pcm_oss.c:1627
   snd_pcm_oss_sync+0x9cf/0xf00 sound/core/oss/pcm_oss.c:1693
   snd_pcm_oss_release+0x119/0x270 sound/core/oss/pcm_oss.c:2590
   __fput+0x3b9/0x820 fs/file_table.c:317
   task_work_run+0x146/0x1c0 kernel/task_work.c:164
   exit_task_work include/linux/task_work.h:37 [inline]
   do_exit+0x547/0x1eb0 kernel/exit.c:795
   do_group_exit+0x23b/0x2f0 kernel/exit.c:925
   __do_sys_exit_group kernel/exit.c:936 [inline]
   __se_sys_exit_group kernel/exit.c:934 [inline]
   __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:934
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae

-> (&group->lock){..-.}-{2:2} {
   IN-SOFTIRQ-W at:
                    lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5641
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0xd1/0x120 kernel/locking/spinlock.c:162
                    snd_pcm_period_elapsed+0x2c/0x210 sound/core/pcm_lib.c:1848
                    dummy_hrtimer_callback+0x87/0x190 sound/drivers/dummy.c:377
                    __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
                    __hrtimer_run_queues+0x50b/0xa60 kernel/time/hrtimer.c:1749
                    hrtimer_run_softirq+0x1a1/0x580 kernel/time/hrtimer.c:1766
                    __do_softirq+0x382/0x793 kernel/softirq.c:558
                    __irq_exit_rcu+0xec/0x170 kernel/softirq.c:637
                    irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
                    sysvec_apic_timer_interrupt+0x91/0xb0 arch/x86/kernel/apic/apic.c:1097
                    asm_sysvec_apic_timer_interrupt+0x12/0x20
                    native_safe_halt arch/x86/include/asm/irqflags.h:51 [inline]
                    arch_safe_halt arch/x86/include/asm/irqflags.h:89 [inline]
                    acpi_safe_halt drivers/acpi/processor_idle.c:115 [inline]
                    acpi_idle_do_entry drivers/acpi/processor_idle.c:556 [inline]
                    acpi_idle_enter+0x42d/0x790 drivers/acpi/processor_idle.c:691
                    cpuidle_enter_state+0x517/0xed0 drivers/cpuidle/cpuidle.c:237
                    cpuidle_enter+0x59/0x90 drivers/cpuidle/cpuidle.c:351
                    call_cpuidle kernel/sched/idle.c:155 [inline]
                    cpuidle_idle_call kernel/sched/idle.c:236 [inline]
                    do_idle+0x3d2/0x640 kernel/sched/idle.c:303
                    cpu_startup_entry+0x15/0x20 kernel/sched/idle.c:400
                    start_kernel+0x4bf/0x56e init/main.c:1140
                    secondary_startup_64_no_verify+0xc4/0xcb
   INITIAL USE at:
                   lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5641
                   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
                   _raw_spin_lock_irq+0xcf/0x110 kernel/locking/spinlock.c:170
                   spin_lock_irq include/linux/spinlock.h:374 [inline]
                   snd_pcm_group_lock_irq sound/core/pcm_native.c:97 [inline]
                   snd_pcm_stream_lock_irq sound/core/pcm_native.c:136 [inline]
                   snd_pcm_hw_params+0x164/0x1860 sound/core/pcm_native.c:726
                   snd_pcm_oss_change_params_locked+0x1f21/0x3c80 sound/core/oss/pcm_oss.c:976
                   snd_pcm_oss_make_ready_locked sound/core/oss/pcm_oss.c:1198 [inline]
                   snd_pcm_oss_write1+0x249/0x1130 sound/core/oss/pcm_oss.c:1416
                   vfs_write+0x303/0xd40 fs/read_write.c:589
                   ksys_write+0x19b/0x2c0 fs/read_write.c:644
                   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                   do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
                   entry_SYSCALL_64_after_hwframe+0x44/0xae
 }
 ... key      at: [<ffffffff90f96980>] snd_pcm_group_init.__key+0x0/0x20
 ... acquired at:
   mark_lock+0x21c/0x350 kernel/locking/lockdep.c:4607
   __lock_acquire+0xb81/0x1f80 kernel/locking/lockdep.c:4983
   lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5641
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0xd1/0x120 kernel/locking/spinlock.c:162
   snd_pcm_period_elapsed+0x2c/0x210 sound/core/pcm_lib.c:1848
   dummy_hrtimer_callback+0x87/0x190 sound/drivers/dummy.c:377
   __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
   __hrtimer_run_queues+0x50b/0xa60 kernel/time/hrtimer.c:1749
   hrtimer_run_softirq+0x1a1/0x580 kernel/time/hrtimer.c:1766
   __do_softirq+0x382/0x793 kernel/softirq.c:558
   __irq_exit_rcu+0xec/0x170 kernel/softirq.c:637
   irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
   sysvec_apic_timer_interrupt+0x91/0xb0 arch/x86/kernel/apic/apic.c:1097
   asm_sysvec_apic_timer_interrupt+0x12/0x20
   native_safe_halt arch/x86/include/asm/irqflags.h:51 [inline]
   arch_safe_halt arch/x86/include/asm/irqflags.h:89 [inline]
   acpi_safe_halt drivers/acpi/processor_idle.c:115 [inline]
   acpi_idle_do_entry drivers/acpi/processor_idle.c:556 [inline]
   acpi_idle_enter+0x42d/0x790 drivers/acpi/processor_idle.c:691
   cpuidle_enter_state+0x517/0xed0 drivers/cpuidle/cpuidle.c:237
   cpuidle_enter+0x59/0x90 drivers/cpuidle/cpuidle.c:351
   call_cpuidle kernel/sched/idle.c:155 [inline]
   cpuidle_idle_call kernel/sched/idle.c:236 [inline]
   do_idle+0x3d2/0x640 kernel/sched/idle.c:303
   cpu_startup_entry+0x15/0x20 kernel/sched/idle.c:400
   start_kernel+0x4bf/0x56e init/main.c:1140
   secondary_startup_64_no_verify+0xc4/0xcb


stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.18.0-rc3-syzkaller-00196-g45ab9400e73f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 print_irq_inversion_bug+0x58c/0x6f0 kernel/locking/lockdep.c:4014
 mark_lock_irq+0x9d2/0xf00 kernel/locking/lockdep.c:4177
 mark_lock+0x21c/0x350 kernel/locking/lockdep.c:4607
 __lock_acquire+0xb81/0x1f80 kernel/locking/lockdep.c:4983
 lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5641
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd1/0x120 kernel/locking/spinlock.c:162
 snd_pcm_period_elapsed+0x2c/0x210 sound/core/pcm_lib.c:1848
 dummy_hrtimer_callback+0x87/0x190 sound/drivers/dummy.c:377
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
 __hrtimer_run_queues+0x50b/0xa60 kernel/time/hrtimer.c:1749
 hrtimer_run_softirq+0x1a1/0x580 kernel/time/hrtimer.c:1766
 __do_softirq+0x382/0x793 kernel/softirq.c:558
 __irq_exit_rcu+0xec/0x170 kernel/softirq.c:637
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
 sysvec_apic_timer_interrupt+0x91/0xb0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20
RIP: 0010:native_save_fl arch/x86/include/asm/irqflags.h:22 [inline]
RIP: 0010:arch_local_save_flags arch/x86/include/asm/irqflags.h:70 [inline]
RIP: 0010:arch_irqs_disabled arch/x86/include/asm/irqflags.h:130 [inline]
RIP: 0010:acpi_safe_halt drivers/acpi/processor_idle.c:116 [inline]
RIP: 0010:acpi_idle_do_entry drivers/acpi/processor_idle.c:556 [inline]
RIP: 0010:acpi_idle_enter+0x42d/0x790 drivers/acpi/processor_idle.c:691
Code: fc 48 83 e3 08 44 8b 7c 24 04 0f 85 22 01 00 00 4c 8d 74 24 40 e8 93 fd 00 fd eb 0c e8 ac 59 fa fc 0f 00 2d f5 a1 68 06 fb f4 <4c> 89 f3 48 c1 eb 03 42 80 3c 23 00 74 08 4c 89 f7 e8 5d 3f 4b fd
RSP: 0018:ffffffff8c807bc0 EFLAGS: 00000282
RAX: ea48baa34ad6ff00 RBX: 0000000000000000 RCX: ffffffff90b7a603
RDX: dffffc0000000000 RSI: ffffffff8a8d0480 RDI: ffffffff8ae88c20
RBP: ffffffff8c807c70 R08: ffffffff818ca320 R09: fffffbfff19176c9
R10: fffffbfff19176c9 R11: 1ffffffff19176c8 R12: dffffc0000000000
R13: ffff888016bdf064 R14: ffffffff8c807c00 R15: 0000000000000001
 cpuidle_enter_state+0x517/0xed0 drivers/cpuidle/cpuidle.c:237
----------------
Code disassembly (best guess):
   0:	fc                   	cld
   1:	48 83 e3 08          	and    $0x8,%rbx
   5:	44 8b 7c 24 04       	mov    0x4(%rsp),%r15d
   a:	0f 85 22 01 00 00    	jne    0x132
  10:	4c 8d 74 24 40       	lea    0x40(%rsp),%r14
  15:	e8 93 fd 00 fd       	callq  0xfd00fdad
  1a:	eb 0c                	jmp    0x28
  1c:	e8 ac 59 fa fc       	callq  0xfcfa59cd
  21:	0f 00 2d f5 a1 68 06 	verw   0x668a1f5(%rip)        # 0x668a21d
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	4c 89 f3             	mov    %r14,%rbx <-- trapping instruction
  2d:	48 c1 eb 03          	shr    $0x3,%rbx
  31:	42 80 3c 23 00       	cmpb   $0x0,(%rbx,%r12,1)
  36:	74 08                	je     0x40
  38:	4c 89 f7             	mov    %r14,%rdi
  3b:	e8 5d 3f 4b fd       	callq  0xfd4b3f9d

