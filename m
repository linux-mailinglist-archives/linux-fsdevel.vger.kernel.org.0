Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F4F50CDF8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Apr 2022 00:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbiDWWz1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Apr 2022 18:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiDWWzY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Apr 2022 18:55:24 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C3D25C46
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Apr 2022 15:52:25 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id g16-20020a05660226d000b00638d8e1828bso8403004ioo.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Apr 2022 15:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Scm1NT1ZZOHkSEjNtN7ZIrzWc0JzDs3OJ36TIDsU4KA=;
        b=MccUHtlrad211NMsHNMT60KJa9aPxQWp3Hn+V+24FoJFEkNO4tXcnr0+tIur3Fde5r
         z78d+GRMNrkKYV2ZdYyVfhu7OJVZwP9URDJqjd+b0VYDGqFfEmV5aebddv1S8YcftTzM
         jFMsthyErxjcFS9VRbkJOFcn6T9eighEnR+QOs+qJjqZgi1sA5P/fVgnLXhIlozyagh7
         wl5YhivP5O+UEKuD376DSrCEPmwkoth9KYfoEnKEnJ6mz/hrtEj6c6EokQ3ycLgDWM0/
         hP/G/x3mhcoyGtZQHgfyWbmcFRxJEPWwlKchxlZdv/DM0ZMhjXxmC/Tele7egMhNZu7P
         oWzg==
X-Gm-Message-State: AOAM5319R1C7gSRjhsTJpDSj1uzQkqUNDoK/Icmq8M6BXEO7RkQidQwq
        JLuthK9bkme47+o3JpcxONdXRZmTfJiLL3QOEtxPbtfmiz2o
X-Google-Smtp-Source: ABdhPJyxJARbuHYRmSI2qzcAzqkW0ZNgKjepFO9qoFNEL0eP7hCEkiDM71VFsB3GN/jcu24H005jOfsPE+ux2Nxz+CQx0YBo+IFO
MIME-Version: 1.0
X-Received: by 2002:a92:4402:0:b0:2ca:b29a:9974 with SMTP id
 r2-20020a924402000000b002cab29a9974mr4135284ila.155.1650754344864; Sat, 23
 Apr 2022 15:52:24 -0700 (PDT)
Date:   Sat, 23 Apr 2022 15:52:24 -0700
In-Reply-To: <0000000000008d88a205d0722901@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000056576d05dd5a326e@google.com>
Subject: Re: [syzbot] possible deadlock in _snd_pcm_stream_lock_irqsave (3)
From:   syzbot <syzbot+58740f570d9b0dacf2a3@syzkaller.appspotmail.com>
To:     alsa-devel-owner@alsa-project.org, alsa-devel@alsa-project.org,
        bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com,
        viro@zeniv.linux.org.uk
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

HEAD commit:    13bc32bad705 Merge tag 'drm-fixes-2022-04-23' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11371798f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=71bf5c8488a4e33a
dashboard link: https://syzkaller.appspot.com/bug?extid=58740f570d9b0dacf2a3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=129b3992f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a6b6fcf00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+58740f570d9b0dacf2a3@syzkaller.appspotmail.com

========================================================
WARNING: possible irq lock inversion dependency detected
5.18.0-rc3-syzkaller-00218-g13bc32bad705 #0 Not tainted
--------------------------------------------------------
swapper/0/0 just changed the state of lock:
ffff888022e8b110 (&group->lock){..-.}-{2:2}, at: _snd_pcm_stream_lock_irqsave+0x9f/0xd0 sound/core/pcm_native.c:170
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
                            lock_acquire kernel/locking/lockdep.c:5641 [inline]
                            lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5606
                            __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                            _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
                            do_wait+0x284/0xce0 kernel/exit.c:1508
                            kernel_wait+0x9c/0x150 kernel/exit.c:1698
                            call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
                            call_usermodehelper_exec_work+0xf5/0x180 kernel/umh.c:166
                            process_one_work+0x996/0x1610 kernel/workqueue.c:2289
                            worker_thread+0x665/0x1080 kernel/workqueue.c:2436
                            kthread+0x2e9/0x3a0 kernel/kthread.c:376
                            ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
       SOFTIRQ-ON-R at:
                            lock_acquire kernel/locking/lockdep.c:5641 [inline]
                            lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5606
                            __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                            _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
                            do_wait+0x284/0xce0 kernel/exit.c:1508
                            kernel_wait+0x9c/0x150 kernel/exit.c:1698
                            call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
                            call_usermodehelper_exec_work+0xf5/0x180 kernel/umh.c:166
                            process_one_work+0x996/0x1610 kernel/workqueue.c:2289
                            worker_thread+0x665/0x1080 kernel/workqueue.c:2436
                            kthread+0x2e9/0x3a0 kernel/kthread.c:376
                            ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
       INITIAL USE at:
                           lock_acquire kernel/locking/lockdep.c:5641 [inline]
                           lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5606
                           __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                           _raw_write_lock_irq+0x32/0x50 kernel/locking/spinlock.c:326
                           copy_process+0x4364/0x6fe0 kernel/fork.c:2368
                           kernel_clone+0xe7/0xab0 kernel/fork.c:2639
                           kernel_thread+0xb5/0xf0 kernel/fork.c:2691
                           rest_init+0x23/0x3e0 init/main.c:691
                           start_kernel+0x47f/0x4a0 init/main.c:1140
                           secondary_startup_64_no_verify+0xc3/0xcb
       INITIAL READ USE at:
                                lock_acquire kernel/locking/lockdep.c:5641 [inline]
                                lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5606
                                __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                                _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
                                do_wait+0x284/0xce0 kernel/exit.c:1508
                                kernel_wait+0x9c/0x150 kernel/exit.c:1698
                                call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
                                call_usermodehelper_exec_work+0xf5/0x180 kernel/umh.c:166
                                process_one_work+0x996/0x1610 kernel/workqueue.c:2289
                                worker_thread+0x665/0x1080 kernel/workqueue.c:2436
                                kthread+0x2e9/0x3a0 kernel/kthread.c:376
                                ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
     }
     ... key      at: [<ffffffff8ba0a098>] tasklist_lock+0x18/0x40
     ... acquired at:
   __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
   _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
   send_sigio+0xab/0x380 fs/fcntl.c:792
   dnotify_handle_event+0x148/0x280 fs/notify/dnotify/dnotify.c:115
   fsnotify_handle_inode_event.isra.0+0x209/0x350 fs/notify/fsnotify.c:264
   fsnotify_handle_event fs/notify/fsnotify.c:323 [inline]
   send_to_group fs/notify/fsnotify.c:377 [inline]
   fsnotify+0xeaf/0x13d0 fs/notify/fsnotify.c:564
   fsnotify_name include/linux/fsnotify.h:36 [inline]
   fsnotify_name include/linux/fsnotify.h:29 [inline]
   fsnotify_dirent include/linux/fsnotify.h:42 [inline]
   fsnotify_create include/linux/fsnotify.h:207 [inline]
   open_last_lookups fs/namei.c:3402 [inline]
   path_openat+0x1232/0x2910 fs/namei.c:3606
   do_filp_open+0x1aa/0x400 fs/namei.c:3636
   do_sys_openat2+0x16d/0x4c0 fs/open.c:1213
   do_sys_open fs/open.c:1229 [inline]
   __do_sys_creat fs/open.c:1305 [inline]
   __se_sys_creat fs/open.c:1299 [inline]
   __x64_sys_creat+0xc9/0x120 fs/open.c:1299
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae

   -> (&f->f_owner.lock){....}-{2:2} {
      INITIAL USE at:
                         lock_acquire kernel/locking/lockdep.c:5641 [inline]
                         lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5606
                         __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                         _raw_write_lock_irq+0x32/0x50 kernel/locking/spinlock.c:326
                         f_modown+0x2a/0x390 fs/fcntl.c:91
                         __f_setown fs/fcntl.c:110 [inline]
                         f_setown+0xd7/0x230 fs/fcntl.c:138
                         do_fcntl+0x748/0x10b0 fs/fcntl.c:377
                         __do_sys_fcntl fs/fcntl.c:454 [inline]
                         __se_sys_fcntl fs/fcntl.c:439 [inline]
                         __x64_sys_fcntl+0x15f/0x1d0 fs/fcntl.c:439
                         do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                         do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                         entry_SYSCALL_64_after_hwframe+0x44/0xae
      INITIAL READ USE at:
                              lock_acquire kernel/locking/lockdep.c:5641 [inline]
                              lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5606
                              __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
                              _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236
                              send_sigio+0x24/0x380 fs/fcntl.c:778
                              kill_fasync_rcu fs/fcntl.c:1003 [inline]
                              kill_fasync fs/fcntl.c:1017 [inline]
                              kill_fasync+0x1f8/0x470 fs/fcntl.c:1010
                              snd_timer_user_ccallback+0x298/0x330 sound/core/timer.c:1386
                              snd_timer_notify1+0x11c/0x3b0 sound/core/timer.c:516
                              snd_timer_start1+0x4d4/0x800 sound/core/timer.c:578
                              snd_timer_start sound/core/timer.c:696 [inline]
                              snd_timer_start sound/core/timer.c:689 [inline]
                              snd_timer_user_start.isra.0+0x1e3/0x260 sound/core/timer.c:1984
                              __snd_timer_user_ioctl.isra.0+0xda4/0x2490 sound/core/timer.c:2107
                              snd_timer_user_ioctl+0x77/0xb0 sound/core/timer.c:2128
                              vfs_ioctl fs/ioctl.c:51 [inline]
                              __do_sys_ioctl fs/ioctl.c:870 [inline]
                              __se_sys_ioctl fs/ioctl.c:856 [inline]
                              __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
                              do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                              do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                              entry_SYSCALL_64_after_hwframe+0x44/0xae
    }
    ... key      at: [<ffffffff9061aa40>] __key.5+0x0/0x40
    ... acquired at:
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236
   send_sigio+0x24/0x380 fs/fcntl.c:778
   kill_fasync_rcu fs/fcntl.c:1003 [inline]
   kill_fasync fs/fcntl.c:1017 [inline]
   kill_fasync+0x1f8/0x470 fs/fcntl.c:1010
   snd_timer_user_ccallback+0x298/0x330 sound/core/timer.c:1386
   snd_timer_notify1+0x11c/0x3b0 sound/core/timer.c:516
   snd_timer_start1+0x4d4/0x800 sound/core/timer.c:578
   snd_timer_start sound/core/timer.c:696 [inline]
   snd_timer_start sound/core/timer.c:689 [inline]
   snd_timer_user_start.isra.0+0x1e3/0x260 sound/core/timer.c:1984
   __snd_timer_user_ioctl.isra.0+0xda4/0x2490 sound/core/timer.c:2107
   snd_timer_user_ioctl+0x77/0xb0 sound/core/timer.c:2128
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:870 [inline]
   __se_sys_ioctl fs/ioctl.c:856 [inline]
   __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae

  -> (&new->fa_lock){....}-{2:2} {
     INITIAL READ USE at:
                            lock_acquire kernel/locking/lockdep.c:5641 [inline]
                            lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5606
                            __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
                            _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236
                            kill_fasync_rcu fs/fcntl.c:996 [inline]
                            kill_fasync fs/fcntl.c:1017 [inline]
                            kill_fasync+0x136/0x470 fs/fcntl.c:1010
                            snd_timer_user_ccallback+0x298/0x330 sound/core/timer.c:1386
                            snd_timer_notify1+0x11c/0x3b0 sound/core/timer.c:516
                            snd_timer_start1+0x4d4/0x800 sound/core/timer.c:578
                            snd_timer_start sound/core/timer.c:696 [inline]
                            snd_timer_start sound/core/timer.c:689 [inline]
                            snd_timer_user_start.isra.0+0x1e3/0x260 sound/core/timer.c:1984
                            __snd_timer_user_ioctl.isra.0+0xda4/0x2490 sound/core/timer.c:2107
                            snd_timer_user_ioctl+0x77/0xb0 sound/core/timer.c:2128
                            vfs_ioctl fs/ioctl.c:51 [inline]
                            __do_sys_ioctl fs/ioctl.c:870 [inline]
                            __se_sys_ioctl fs/ioctl.c:856 [inline]
                            __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
                            do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                            do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                            entry_SYSCALL_64_after_hwframe+0x44/0xae
   }
   ... key      at: [<ffffffff9061b820>] __key.0+0x0/0x40
   ... acquired at:
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236
   kill_fasync_rcu fs/fcntl.c:996 [inline]
   kill_fasync fs/fcntl.c:1017 [inline]
   kill_fasync+0x136/0x470 fs/fcntl.c:1010
   snd_timer_user_ccallback+0x298/0x330 sound/core/timer.c:1386
   snd_timer_notify1+0x11c/0x3b0 sound/core/timer.c:516
   snd_timer_start1+0x4d4/0x800 sound/core/timer.c:578
   snd_timer_start sound/core/timer.c:696 [inline]
   snd_timer_start sound/core/timer.c:689 [inline]
   snd_timer_user_start.isra.0+0x1e3/0x260 sound/core/timer.c:1984
   __snd_timer_user_ioctl.isra.0+0xda4/0x2490 sound/core/timer.c:2107
   snd_timer_user_ioctl+0x77/0xb0 sound/core/timer.c:2128
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:870 [inline]
   __se_sys_ioctl fs/ioctl.c:856 [inline]
   __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae

 -> (&timer->lock){....}-{2:2} {
    INITIAL USE at:
                     lock_acquire kernel/locking/lockdep.c:5641 [inline]
                     lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5606
                     __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                     _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
                     snd_timer_resolution+0x55/0x100 sound/core/timer.c:489
                     snd_timer_user_params.isra.0+0x18e/0x8c0 sound/core/timer.c:1851
                     __snd_timer_user_ioctl.isra.0+0x101c/0x2490 sound/core/timer.c:2100
                     snd_timer_user_ioctl+0x77/0xb0 sound/core/timer.c:2128
                     vfs_ioctl fs/ioctl.c:51 [inline]
                     __do_sys_ioctl fs/ioctl.c:870 [inline]
                     __se_sys_ioctl fs/ioctl.c:856 [inline]
                     __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
                     do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                     do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                     entry_SYSCALL_64_after_hwframe+0x44/0xae
  }
  ... key      at: [<ffffffff909196a0>] __key.10+0x0/0x40
  ... acquired at:
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
   snd_timer_notify sound/core/timer.c:1086 [inline]
   snd_timer_notify+0x10c/0x3d0 sound/core/timer.c:1073
   snd_pcm_timer_notify sound/core/pcm_native.c:608 [inline]
   snd_pcm_post_start+0x24a/0x310 sound/core/pcm_native.c:1451
   snd_pcm_action_single+0xf4/0x130 sound/core/pcm_native.c:1283
   snd_pcm_action+0x6e/0x90 sound/core/pcm_native.c:1364
   __snd_pcm_lib_xfer+0x14d0/0x1e10 sound/core/pcm_lib.c:2308
   snd_pcm_oss_write3+0x103/0x250 sound/core/oss/pcm_oss.c:1253
   snd_pcm_oss_write2+0x30e/0x3f0 sound/core/oss/pcm_oss.c:1393
   snd_pcm_oss_sync1+0x187/0x440 sound/core/oss/pcm_oss.c:1627
   snd_pcm_oss_sync+0x638/0x800 sound/core/oss/pcm_oss.c:1704
   snd_pcm_oss_release+0x276/0x300 sound/core/oss/pcm_oss.c:2590
   __fput+0x277/0x9d0 fs/file_table.c:317
   task_work_run+0xdd/0x1a0 kernel/task_work.c:164
   exit_task_work include/linux/task_work.h:37 [inline]
   do_exit+0xaff/0x2a00 kernel/exit.c:795
   do_group_exit+0xd2/0x2f0 kernel/exit.c:925
   __do_sys_exit_group kernel/exit.c:936 [inline]
   __se_sys_exit_group kernel/exit.c:934 [inline]
   __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:934
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae

-> (&group->lock){..-.}-{2:2} {
   IN-SOFTIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5641 [inline]
                    lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5606
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
                    _snd_pcm_stream_lock_irqsave+0x9f/0xd0 sound/core/pcm_native.c:170
                    snd_pcm_period_elapsed+0x1d/0x50 sound/core/pcm_lib.c:1848
                    dummy_hrtimer_callback+0x94/0x1b0 sound/drivers/dummy.c:377
                    __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
                    __hrtimer_run_queues+0x609/0xe50 kernel/time/hrtimer.c:1749
                    hrtimer_run_softirq+0x17b/0x360 kernel/time/hrtimer.c:1766
                    __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
                    invoke_softirq kernel/softirq.c:432 [inline]
                    __irq_exit_rcu+0x123/0x180 kernel/softirq.c:637
                    irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
                    sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
                    asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:645
                    native_safe_halt arch/x86/include/asm/irqflags.h:51 [inline]
                    arch_safe_halt arch/x86/include/asm/irqflags.h:89 [inline]
                    acpi_safe_halt drivers/acpi/processor_idle.c:115 [inline]
                    acpi_idle_do_entry+0x1c6/0x250 drivers/acpi/processor_idle.c:556
                    acpi_idle_enter+0x361/0x500 drivers/acpi/processor_idle.c:691
                    cpuidle_enter_state+0x1b1/0xc80 drivers/cpuidle/cpuidle.c:237
                    cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:351
                    call_cpuidle kernel/sched/idle.c:155 [inline]
                    cpuidle_idle_call kernel/sched/idle.c:236 [inline]
                    do_idle+0x3e8/0x590 kernel/sched/idle.c:303
                    cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
                    start_kernel+0x47f/0x4a0 init/main.c:1140
                    secondary_startup_64_no_verify+0xc3/0xcb
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5641 [inline]
                   lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5606
                   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
                   _raw_spin_lock_irq+0x32/0x50 kernel/locking/spinlock.c:170
                   spin_lock_irq include/linux/spinlock.h:374 [inline]
                   snd_pcm_group_lock_irq sound/core/pcm_native.c:97 [inline]
                   snd_pcm_stream_lock_irq sound/core/pcm_native.c:136 [inline]
                   snd_pcm_hw_params+0x14b/0x19f0 sound/core/pcm_native.c:726
                   snd_pcm_kernel_ioctl+0x164/0x310 sound/core/pcm_native.c:3435
                   snd_pcm_oss_change_params_locked+0x14e2/0x3a70 sound/core/oss/pcm_oss.c:976
                   snd_pcm_oss_make_ready_locked+0xb3/0x130 sound/core/oss/pcm_oss.c:1198
                   snd_pcm_oss_write1 sound/core/oss/pcm_oss.c:1416 [inline]
                   snd_pcm_oss_write+0x4ac/0x9c0 sound/core/oss/pcm_oss.c:2811
                   vfs_write+0x269/0xac0 fs/read_write.c:589
                   ksys_write+0x127/0x250 fs/read_write.c:644
                   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                   entry_SYSCALL_64_after_hwframe+0x44/0xae
 }
 ... key      at: [<ffffffff90919f00>] __key.8+0x0/0x40
 ... acquired at:
   mark_lock kernel/locking/lockdep.c:4571 [inline]
   mark_usage kernel/locking/lockdep.c:4502 [inline]
   __lock_acquire+0x11e7/0x56c0 kernel/locking/lockdep.c:4983
   lock_acquire kernel/locking/lockdep.c:5641 [inline]
   lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5606
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
   _snd_pcm_stream_lock_irqsave+0x9f/0xd0 sound/core/pcm_native.c:170
   snd_pcm_period_elapsed+0x1d/0x50 sound/core/pcm_lib.c:1848
   dummy_hrtimer_callback+0x94/0x1b0 sound/drivers/dummy.c:377
   __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
   __hrtimer_run_queues+0x609/0xe50 kernel/time/hrtimer.c:1749
   hrtimer_run_softirq+0x17b/0x360 kernel/time/hrtimer.c:1766
   __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
   invoke_softirq kernel/softirq.c:432 [inline]
   __irq_exit_rcu+0x123/0x180 kernel/softirq.c:637
   irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
   sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
   asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:645
   native_safe_halt arch/x86/include/asm/irqflags.h:51 [inline]
   arch_safe_halt arch/x86/include/asm/irqflags.h:89 [inline]
   acpi_safe_halt drivers/acpi/processor_idle.c:115 [inline]
   acpi_idle_do_entry+0x1c6/0x250 drivers/acpi/processor_idle.c:556
   acpi_idle_enter+0x361/0x500 drivers/acpi/processor_idle.c:691
   cpuidle_enter_state+0x1b1/0xc80 drivers/cpuidle/cpuidle.c:237
   cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:351
   call_cpuidle kernel/sched/idle.c:155 [inline]
   cpuidle_idle_call kernel/sched/idle.c:236 [inline]
   do_idle+0x3e8/0x590 kernel/sched/idle.c:303
   cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
   start_kernel+0x47f/0x4a0 init/main.c:1140
   secondary_startup_64_no_verify+0xc3/0xcb


stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.18.0-rc3-syzkaller-00218-g13bc32bad705 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_irq_inversion_bug kernel/locking/lockdep.c:192 [inline]
 check_usage_forwards kernel/locking/lockdep.c:4045 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4177 [inline]
 mark_lock.part.0.cold+0x86/0xd8 kernel/locking/lockdep.c:4607
 mark_lock kernel/locking/lockdep.c:4571 [inline]
 mark_usage kernel/locking/lockdep.c:4502 [inline]
 __lock_acquire+0x11e7/0x56c0 kernel/locking/lockdep.c:4983
 lock_acquire kernel/locking/lockdep.c:5641 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5606
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
 _snd_pcm_stream_lock_irqsave+0x9f/0xd0 sound/core/pcm_native.c:170
 snd_pcm_period_elapsed+0x1d/0x50 sound/core/pcm_lib.c:1848
 dummy_hrtimer_callback+0x94/0x1b0 sound/drivers/dummy.c:377
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
 __hrtimer_run_queues+0x609/0xe50 kernel/time/hrtimer.c:1749
 hrtimer_run_softirq+0x17b/0x360 kernel/time/hrtimer.c:1766
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 invoke_softirq kernel/softirq.c:432 [inline]
 __irq_exit_rcu+0x123/0x180 kernel/softirq.c:637
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:native_save_fl arch/x86/include/asm/irqflags.h:29 [inline]
RIP: 0010:arch_local_save_flags arch/x86/include/asm/irqflags.h:70 [inline]
RIP: 0010:arch_irqs_disabled arch/x86/include/asm/irqflags.h:130 [inline]
RIP: 0010:acpi_safe_halt drivers/acpi/processor_idle.c:116 [inline]
RIP: 0010:acpi_idle_do_entry+0x1c6/0x250 drivers/acpi/processor_idle.c:556
Code: 89 de e8 7d 6e 0c f8 84 db 75 ac e8 94 6a 0c f8 e8 ff b2 12 f8 eb 0c e8 88 6a 0c f8 0f 00 2d 51 07 c6 00 e8 7c 6a 0c f8 fb f4 <9c> 5b 81 e3 00 02 00 00 fa 31 ff 48 89 de e8 f7 6c 0c f8 48 85 db
RSP: 0018:ffffffff8ba07d60 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffffffff8babc700 RSI: ffffffff896cc614 RDI: 0000000000000000
RBP: ffff8880165b4864 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff817f7938 R11: 0000000000000000 R12: 0000000000000001
R13: ffff8880165b4800 R14: ffff8880165b4864 R15: ffff8881407ed004
 acpi_idle_enter+0x361/0x500 drivers/acpi/processor_idle.c:691
 cpuidle_enter_state+0x1b1/0xc80 drivers/cpuidle/cpuidle.c:237
 cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:351
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:236 [inline]
 do_idle+0x3e8/0x590 kernel/sched/idle.c:303
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
 start_kernel+0x47f/0x4a0 init/main.c:1140
 second
----------------
Code disassembly (best guess):
   0:	89 de                	mov    %ebx,%esi
   2:	e8 7d 6e 0c f8       	callq  0xf80c6e84
   7:	84 db                	test   %bl,%bl
   9:	75 ac                	jne    0xffffffb7
   b:	e8 94 6a 0c f8       	callq  0xf80c6aa4
  10:	e8 ff b2 12 f8       	callq  0xf812b314
  15:	eb 0c                	jmp    0x23
  17:	e8 88 6a 0c f8       	callq  0xf80c6aa4
  1c:	0f 00 2d 51 07 c6 00 	verw   0xc60751(%rip)        # 0xc60774
  23:	e8 7c 6a 0c f8       	callq  0xf80c6aa4
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	9c                   	pushfq <-- trapping instruction
  2b:	5b                   	pop    %rbx
  2c:	81 e3 00 02 00 00    	and    $0x200,%ebx
  32:	fa                   	cli
  33:	31 ff                	xor    %edi,%edi
  35:	48 89 de             	mov    %rbx,%rsi
  38:	e8 f7 6c 0c f8       	callq  0xf80c6d34
  3d:	48 85 db             	test   %rbx,%rbx

