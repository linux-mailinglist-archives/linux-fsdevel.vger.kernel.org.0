Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D31847A39C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Dec 2021 03:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbhLTCWU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Dec 2021 21:22:20 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:34733 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhLTCWT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Dec 2021 21:22:19 -0500
Received: by mail-il1-f198.google.com with SMTP id a18-20020a923312000000b002b384dccc91so761921ilf.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Dec 2021 18:22:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=7x7n0sxi0sErCMBhBft9zF4EBu9vvC/wAIOfnX8XXKA=;
        b=eEXCFSULCOIdxeYmwRi47aAzp8iY7vNu+6bvwMqE9/9u7tyGTar5kQRc5yALdMLT92
         6KSp2x80MF6Zbx0gx4QCL0lFqv/RPqJ04PkDjXw9Mofzt7lywR40OK3RpFyWwV/g2Jz9
         o+mJ0GXhz8mvJHKMs/+dO3e0R9vjWslJWqAvgWjUKc/SUaab8fiqNOKBQftjM2MvkuvG
         iG5m/N4rTHudrr2wVb02n5+KsWLuX6GmF15yRdOQDdJzWcW+iYa7cIIHTnAqD8Ea6jY3
         EhQPO0ov3WXqKCaX5mzH38SNdsqOUbEAsZMjv086QA+dSBSXw2VlTGtdJfbfLP3GTurS
         iBeg==
X-Gm-Message-State: AOAM533gzBkDhknL+fQbmSORizNQgTRcXtxN+D0StMq/4jD6wxbXcVof
        Uwd6rSDbCOkfex+W/7AyeZmpnyThxXVBcaEkA9i0xvScoeVC
X-Google-Smtp-Source: ABdhPJwUPU0wNCYeOP6b1wtF+slC15aX9kky4F+xMInm90wzQcHU5vR62wh+D55hOuWrieIzf1iDGu4JjVnBIUS/krsG/YGMKQA8
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e6:: with SMTP id l6mr7049788iln.275.1639966939092;
 Sun, 19 Dec 2021 18:22:19 -0800 (PST)
Date:   Sun, 19 Dec 2021 18:22:19 -0800
In-Reply-To: <0000000000008d88a205d0722901@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d91ee705d38a8e61@google.com>
Subject: Re: [syzbot] possible deadlock in _snd_pcm_stream_lock_irqsave (3)
From:   syzbot <syzbot+58740f570d9b0dacf2a3@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, bfields@fieldses.org,
        jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    a76c3d035872 Merge tag 'irq_urgent_for_v5.16_rc6' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1564a349b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa556098924b78f0
dashboard link: https://syzkaller.appspot.com/bug?extid=58740f570d9b0dacf2a3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111bc7d5b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+58740f570d9b0dacf2a3@syzkaller.appspotmail.com

========================================================
WARNING: possible irq lock inversion dependency detected
5.16.0-rc5-syzkaller #0 Not tainted
--------------------------------------------------------
swapper/0/0 just changed the state of lock:
ffff8880226f5910 (&group->lock){..-.}-{2:2}, at: _snd_pcm_stream_lock_irqsave+0x9f/0xd0 sound/core/pcm_native.c:170 sound/core/pcm_native.c:170
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
                            lock_acquire kernel/locking/lockdep.c:5637 [inline]
                            lock_acquire kernel/locking/lockdep.c:5637 [inline] kernel/locking/lockdep.c:5602
                            lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602 kernel/locking/lockdep.c:5602
                            __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                            __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline] kernel/locking/spinlock.c:228
                            _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228 kernel/locking/spinlock.c:228
                            do_wait+0x284/0xce0 kernel/exit.c:1511 kernel/exit.c:1511
                            kernel_wait+0x9c/0x150 kernel/exit.c:1701 kernel/exit.c:1701
                            call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
                            call_usermodehelper_exec_sync kernel/umh.c:139 [inline] kernel/umh.c:166
                            call_usermodehelper_exec_work+0xf5/0x180 kernel/umh.c:166 kernel/umh.c:166
                            process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298 kernel/workqueue.c:2298
                            worker_thread+0x658/0x11f0 kernel/workqueue.c:2445 kernel/workqueue.c:2445
                            kthread+0x405/0x4f0 kernel/kthread.c:327 kernel/kthread.c:327
                            ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295 arch/x86/entry/entry_64.S:295
       SOFTIRQ-ON-R at:
                            lock_acquire kernel/locking/lockdep.c:5637 [inline]
                            lock_acquire kernel/locking/lockdep.c:5637 [inline] kernel/locking/lockdep.c:5602
                            lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602 kernel/locking/lockdep.c:5602
                            __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                            __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline] kernel/locking/spinlock.c:228
                            _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228 kernel/locking/spinlock.c:228
                            do_wait+0x284/0xce0 kernel/exit.c:1511 kernel/exit.c:1511
                            kernel_wait+0x9c/0x150 kernel/exit.c:1701 kernel/exit.c:1701
                            call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
                            call_usermodehelper_exec_sync kernel/umh.c:139 [inline] kernel/umh.c:166
                            call_usermodehelper_exec_work+0xf5/0x180 kernel/umh.c:166 kernel/umh.c:166
                            process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298 kernel/workqueue.c:2298
                            worker_thread+0x658/0x11f0 kernel/workqueue.c:2445 kernel/workqueue.c:2445
                            kthread+0x405/0x4f0 kernel/kthread.c:327 kernel/kthread.c:327
                            ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295 arch/x86/entry/entry_64.S:295
       INITIAL USE at:
                           lock_acquire kernel/locking/lockdep.c:5637 [inline]
                           lock_acquire kernel/locking/lockdep.c:5637 [inline] kernel/locking/lockdep.c:5602
                           lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602 kernel/locking/lockdep.c:5602
                           __raw_write_lock_irq include/linux/rwlock_api_smp.h:194 [inline]
                           __raw_write_lock_irq include/linux/rwlock_api_smp.h:194 [inline] kernel/locking/spinlock.c:316
                           _raw_write_lock_irq+0x32/0x50 kernel/locking/spinlock.c:316 kernel/locking/spinlock.c:316
                           copy_process+0x36c8/0x75a0 kernel/fork.c:2311 kernel/fork.c:2311
                           kernel_clone+0xe7/0xab0 kernel/fork.c:2582 kernel/fork.c:2582
                           kernel_thread+0xb5/0xf0 kernel/fork.c:2634 kernel/fork.c:2634
                           rest_init+0x23/0x3e0 init/main.c:690 init/main.c:690
                           start_kernel+0x47a/0x49b init/main.c:1135 init/main.c:1135
                           secondary_startup_64_no_verify+0xb0/0xbb
       INITIAL READ USE at:
                                lock_acquire kernel/locking/lockdep.c:5637 [inline]
                                lock_acquire kernel/locking/lockdep.c:5637 [inline] kernel/locking/lockdep.c:5602
                                lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602 kernel/locking/lockdep.c:5602
                                __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                                __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline] kernel/locking/spinlock.c:228
                                _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228 kernel/locking/spinlock.c:228
                                do_wait+0x284/0xce0 kernel/exit.c:1511 kernel/exit.c:1511
                                kernel_wait+0x9c/0x150 kernel/exit.c:1701 kernel/exit.c:1701
                                call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
                                call_usermodehelper_exec_sync kernel/umh.c:139 [inline] kernel/umh.c:166
                                call_usermodehelper_exec_work+0xf5/0x180 kernel/umh.c:166 kernel/umh.c:166
                                process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298 kernel/workqueue.c:2298
                                worker_thread+0x658/0x11f0 kernel/workqueue.c:2445 kernel/workqueue.c:2445
                                kthread+0x405/0x4f0 kernel/kthread.c:327 kernel/kthread.c:327
                                ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295 arch/x86/entry/entry_64.S:295
     }
     ... key      at: [<ffffffff8b80a098>] tasklist_lock+0x18/0x40
     ... acquired at:
   __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
   __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline] kernel/locking/spinlock.c:228
   _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228 kernel/locking/spinlock.c:228
   send_sigio+0xab/0x380 fs/fcntl.c:810 fs/fcntl.c:810
   kill_fasync_rcu fs/fcntl.c:1021 [inline]
   kill_fasync fs/fcntl.c:1035 [inline]
   kill_fasync_rcu fs/fcntl.c:1021 [inline] fs/fcntl.c:1028
   kill_fasync fs/fcntl.c:1035 [inline] fs/fcntl.c:1028
   kill_fasync+0x1f8/0x470 fs/fcntl.c:1028 fs/fcntl.c:1028
   lease_break_callback+0x1f/0x30 fs/locks.c:477 fs/locks.c:477
   __break_lease+0x3d7/0x1420 fs/locks.c:1450 fs/locks.c:1450
   break_lease include/linux/fs.h:2633 [inline]
   break_lease include/linux/fs.h:2623 [inline]
   break_lease include/linux/fs.h:2633 [inline] fs/open.c:813
   break_lease include/linux/fs.h:2623 [inline] fs/open.c:813
   do_dentry_open+0x453/0x1250 fs/open.c:813 fs/open.c:813
   do_open fs/namei.c:3426 [inline]
   do_open fs/namei.c:3426 [inline] fs/namei.c:3559
   path_openat+0x1cad/0x2750 fs/namei.c:3559 fs/namei.c:3559
   do_filp_open+0x1aa/0x400 fs/namei.c:3586 fs/namei.c:3586
   do_sys_openat2+0x16d/0x4d0 fs/open.c:1212 fs/open.c:1212
   do_sys_open fs/open.c:1228 [inline]
   __do_sys_creat fs/open.c:1304 [inline]
   __se_sys_creat fs/open.c:1298 [inline]
   do_sys_open fs/open.c:1228 [inline] fs/open.c:1298
   __do_sys_creat fs/open.c:1304 [inline] fs/open.c:1298
   __se_sys_creat fs/open.c:1298 [inline] fs/open.c:1298
   __x64_sys_creat+0xc9/0x120 fs/open.c:1298 fs/open.c:1298
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_x64 arch/x86/entry/common.c:50 [inline] arch/x86/entry/common.c:80
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae

   -> (&f->f_owner.lock){....}-{2:2} {
      INITIAL USE at:
                         lock_acquire kernel/locking/lockdep.c:5637 [inline]
                         lock_acquire kernel/locking/lockdep.c:5637 [inline] kernel/locking/lockdep.c:5602
                         lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602 kernel/locking/lockdep.c:5602
                         __raw_write_lock_irq include/linux/rwlock_api_smp.h:194 [inline]
                         __raw_write_lock_irq include/linux/rwlock_api_smp.h:194 [inline] kernel/locking/spinlock.c:316
                         _raw_write_lock_irq+0x32/0x50 kernel/locking/spinlock.c:316 kernel/locking/spinlock.c:316
                         f_modown+0x2a/0x390 fs/fcntl.c:91 fs/fcntl.c:91
                         __f_setown fs/fcntl.c:110 [inline]
                         f_setown_ex fs/fcntl.c:200 [inline]
                         __f_setown fs/fcntl.c:110 [inline] fs/fcntl.c:399
                         f_setown_ex fs/fcntl.c:200 [inline] fs/fcntl.c:399
                         do_fcntl+0xb24/0x1210 fs/fcntl.c:399 fs/fcntl.c:399
                         __do_sys_fcntl fs/fcntl.c:472 [inline]
                         __se_sys_fcntl fs/fcntl.c:457 [inline]
                         __do_sys_fcntl fs/fcntl.c:472 [inline] fs/fcntl.c:457
                         __se_sys_fcntl fs/fcntl.c:457 [inline] fs/fcntl.c:457
                         __x64_sys_fcntl+0x165/0x1e0 fs/fcntl.c:457 fs/fcntl.c:457
                         do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                         do_syscall_x64 arch/x86/entry/common.c:50 [inline] arch/x86/entry/common.c:80
                         do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80 arch/x86/entry/common.c:80
                         entry_SYSCALL_64_after_hwframe+0x44/0xae
      INITIAL READ USE at:
                              lock_acquire kernel/locking/lockdep.c:5637 [inline]
                              lock_acquire kernel/locking/lockdep.c:5637 [inline] kernel/locking/lockdep.c:5602
                              lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602 kernel/locking/lockdep.c:5602
                              __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
                              __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline] kernel/locking/spinlock.c:236
                              _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236 kernel/locking/spinlock.c:236
                              send_sigio+0x24/0x380 fs/fcntl.c:796 fs/fcntl.c:796
                              kill_fasync_rcu fs/fcntl.c:1021 [inline]
                              kill_fasync fs/fcntl.c:1035 [inline]
                              kill_fasync_rcu fs/fcntl.c:1021 [inline] fs/fcntl.c:1028
                              kill_fasync fs/fcntl.c:1035 [inline] fs/fcntl.c:1028
                              kill_fasync+0x1f8/0x470 fs/fcntl.c:1028 fs/fcntl.c:1028
                              snd_timer_user_ccallback+0x298/0x330 sound/core/timer.c:1386 sound/core/timer.c:1386
                              snd_timer_notify1+0x11c/0x3b0 sound/core/timer.c:516 sound/core/timer.c:516
                              snd_timer_start1+0x4d4/0x800 sound/core/timer.c:578 sound/core/timer.c:578
                              snd_timer_start sound/core/timer.c:696 [inline]
                              snd_timer_start sound/core/timer.c:689 [inline]
                              snd_timer_start sound/core/timer.c:696 [inline] sound/core/timer.c:1984
                              snd_timer_start sound/core/timer.c:689 [inline] sound/core/timer.c:1984
                              snd_timer_user_start.isra.0+0x1e3/0x260 sound/core/timer.c:1984 sound/core/timer.c:1984
                              __snd_timer_user_ioctl.isra.0+0xda8/0x2490 sound/core/timer.c:2107 sound/core/timer.c:2107
                              snd_timer_user_ioctl+0x77/0xb0 sound/core/timer.c:2128 sound/core/timer.c:2128
                              vfs_ioctl fs/ioctl.c:51 [inline]
                              __do_sys_ioctl fs/ioctl.c:874 [inline]
                              __se_sys_ioctl fs/ioctl.c:860 [inline]
                              vfs_ioctl fs/ioctl.c:51 [inline] fs/ioctl.c:860
                              __do_sys_ioctl fs/ioctl.c:874 [inline] fs/ioctl.c:860
                              __se_sys_ioctl fs/ioctl.c:860 [inline] fs/ioctl.c:860
                              __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860 fs/ioctl.c:860
                              do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                              do_syscall_x64 arch/x86/entry/common.c:50 [inline] arch/x86/entry/common.c:80
                              do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80 arch/x86/entry/common.c:80
                              entry_SYSCALL_64_after_hwframe+0x44/0xae
    }
    ... key      at: [<ffffffff90534da0>] __key.5+0x0/0x40
    ... acquired at:
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline] kernel/locking/spinlock.c:236
   _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236 kernel/locking/spinlock.c:236
   send_sigio+0x24/0x380 fs/fcntl.c:796 fs/fcntl.c:796
   kill_fasync_rcu fs/fcntl.c:1021 [inline]
   kill_fasync fs/fcntl.c:1035 [inline]
   kill_fasync_rcu fs/fcntl.c:1021 [inline] fs/fcntl.c:1028
   kill_fasync fs/fcntl.c:1035 [inline] fs/fcntl.c:1028
   kill_fasync+0x1f8/0x470 fs/fcntl.c:1028 fs/fcntl.c:1028
   snd_timer_user_ccallback+0x298/0x330 sound/core/timer.c:1386 sound/core/timer.c:1386
   snd_timer_notify1+0x11c/0x3b0 sound/core/timer.c:516 sound/core/timer.c:516
   snd_timer_start1+0x4d4/0x800 sound/core/timer.c:578 sound/core/timer.c:578
   snd_timer_start sound/core/timer.c:696 [inline]
   snd_timer_start sound/core/timer.c:689 [inline]
   snd_timer_start sound/core/timer.c:696 [inline] sound/core/timer.c:1984
   snd_timer_start sound/core/timer.c:689 [inline] sound/core/timer.c:1984
   snd_timer_user_start.isra.0+0x1e3/0x260 sound/core/timer.c:1984 sound/core/timer.c:1984
   __snd_timer_user_ioctl.isra.0+0xda8/0x2490 sound/core/timer.c:2107 sound/core/timer.c:2107
   snd_timer_user_ioctl+0x77/0xb0 sound/core/timer.c:2128 sound/core/timer.c:2128
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:874 [inline]
   __se_sys_ioctl fs/ioctl.c:860 [inline]
   vfs_ioctl fs/ioctl.c:51 [inline] fs/ioctl.c:860
   __do_sys_ioctl fs/ioctl.c:874 [inline] fs/ioctl.c:860
   __se_sys_ioctl fs/ioctl.c:860 [inline] fs/ioctl.c:860
   __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860 fs/ioctl.c:860
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_x64 arch/x86/entry/common.c:50 [inline] arch/x86/entry/common.c:80
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae

  -> (&new->fa_lock){....}-{2:2} {
     INITIAL READ USE at:
                            lock_acquire kernel/locking/lockdep.c:5637 [inline]
                            lock_acquire kernel/locking/lockdep.c:5637 [inline] kernel/locking/lockdep.c:5602
                            lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602 kernel/locking/lockdep.c:5602
                            __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
                            __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline] kernel/locking/spinlock.c:236
                            _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236 kernel/locking/spinlock.c:236
                            kill_fasync_rcu fs/fcntl.c:1014 [inline]
                            kill_fasync fs/fcntl.c:1035 [inline]
                            kill_fasync_rcu fs/fcntl.c:1014 [inline] fs/fcntl.c:1028
                            kill_fasync fs/fcntl.c:1035 [inline] fs/fcntl.c:1028
                            kill_fasync+0x136/0x470 fs/fcntl.c:1028 fs/fcntl.c:1028
                            snd_timer_user_ccallback+0x298/0x330 sound/core/timer.c:1386 sound/core/timer.c:1386
                            snd_timer_notify1+0x11c/0x3b0 sound/core/timer.c:516 sound/core/timer.c:516
                            snd_timer_start1+0x4d4/0x800 sound/core/timer.c:578 sound/core/timer.c:578
                            snd_timer_start sound/core/timer.c:696 [inline]
                            snd_timer_start sound/core/timer.c:689 [inline]
                            snd_timer_start sound/core/timer.c:696 [inline] sound/core/timer.c:1984
                            snd_timer_start sound/core/timer.c:689 [inline] sound/core/timer.c:1984
                            snd_timer_user_start.isra.0+0x1e3/0x260 sound/core/timer.c:1984 sound/core/timer.c:1984
                            __snd_timer_user_ioctl.isra.0+0xda8/0x2490 sound/core/timer.c:2107 sound/core/timer.c:2107
                            snd_timer_user_ioctl+0x77/0xb0 sound/core/timer.c:2128 sound/core/timer.c:2128
                            vfs_ioctl fs/ioctl.c:51 [inline]
                            __do_sys_ioctl fs/ioctl.c:874 [inline]
                            __se_sys_ioctl fs/ioctl.c:860 [inline]
                            vfs_ioctl fs/ioctl.c:51 [inline] fs/ioctl.c:860
                            __do_sys_ioctl fs/ioctl.c:874 [inline] fs/ioctl.c:860
                            __se_sys_ioctl fs/ioctl.c:860 [inline] fs/ioctl.c:860
                            __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860 fs/ioctl.c:860
                            do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                            do_syscall_x64 arch/x86/entry/common.c:50 [inline] arch/x86/entry/common.c:80
                            do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80 arch/x86/entry/common.c:80
                            entry_SYSCALL_64_after_hwframe+0x44/0xae
   }
   ... key      at: [<ffffffff90535b80>] __key.0+0x0/0x40
   ... acquired at:
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline] kernel/locking/spinlock.c:236
   _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236 kernel/locking/spinlock.c:236
   kill_fasync_rcu fs/fcntl.c:1014 [inline]
   kill_fasync fs/fcntl.c:1035 [inline]
   kill_fasync_rcu fs/fcntl.c:1014 [inline] fs/fcntl.c:1028
   kill_fasync fs/fcntl.c:1035 [inline] fs/fcntl.c:1028
   kill_fasync+0x136/0x470 fs/fcntl.c:1028 fs/fcntl.c:1028
   snd_timer_user_ccallback+0x298/0x330 sound/core/timer.c:1386 sound/core/timer.c:1386
   snd_timer_notify1+0x11c/0x3b0 sound/core/timer.c:516 sound/core/timer.c:516
   snd_timer_start1+0x4d4/0x800 sound/core/timer.c:578 sound/core/timer.c:578
   snd_timer_start sound/core/timer.c:696 [inline]
   snd_timer_start sound/core/timer.c:689 [inline]
   snd_timer_start sound/core/timer.c:696 [inline] sound/core/timer.c:1984
   snd_timer_start sound/core/timer.c:689 [inline] sound/core/timer.c:1984
   snd_timer_user_start.isra.0+0x1e3/0x260 sound/core/timer.c:1984 sound/core/timer.c:1984
   __snd_timer_user_ioctl.isra.0+0xda8/0x2490 sound/core/timer.c:2107 sound/core/timer.c:2107
   snd_timer_user_ioctl+0x77/0xb0 sound/core/timer.c:2128 sound/core/timer.c:2128
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:874 [inline]
   __se_sys_ioctl fs/ioctl.c:860 [inline]
   vfs_ioctl fs/ioctl.c:51 [inline] fs/ioctl.c:860
   __do_sys_ioctl fs/ioctl.c:874 [inline] fs/ioctl.c:860
   __se_sys_ioctl fs/ioctl.c:860 [inline] fs/ioctl.c:860
   __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860 fs/ioctl.c:860
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_x64 arch/x86/entry/common.c:50 [inline] arch/x86/entry/common.c:80
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae

 -> (&timer->lock){....}-{2:2} {
    INITIAL USE at:
                     lock_acquire kernel/locking/lockdep.c:5637 [inline]
                     lock_acquire kernel/locking/lockdep.c:5637 [inline] kernel/locking/lockdep.c:5602
                     lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602 kernel/locking/lockdep.c:5602
                     __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                     __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline] kernel/locking/spinlock.c:162
                     _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162 kernel/locking/spinlock.c:162
                     snd_timer_resolution+0x55/0x100 sound/core/timer.c:489 sound/core/timer.c:489
                     snd_timer_user_params.isra.0+0x18e/0x8c0 sound/core/timer.c:1851 sound/core/timer.c:1851
                     __snd_timer_user_ioctl.isra.0+0x1020/0x2490 sound/core/timer.c:2100 sound/core/timer.c:2100
                     snd_timer_user_ioctl+0x77/0xb0 sound/core/timer.c:2128 sound/core/timer.c:2128
                     vfs_ioctl fs/ioctl.c:51 [inline]
                     __do_sys_ioctl fs/ioctl.c:874 [inline]
                     __se_sys_ioctl fs/ioctl.c:860 [inline]
                     vfs_ioctl fs/ioctl.c:51 [inline] fs/ioctl.c:860
                     __do_sys_ioctl fs/ioctl.c:874 [inline] fs/ioctl.c:860
                     __se_sys_ioctl fs/ioctl.c:860 [inline] fs/ioctl.c:860
                     __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860 fs/ioctl.c:860
                     do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                     do_syscall_x64 arch/x86/entry/common.c:50 [inline] arch/x86/entry/common.c:80
                     do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80 arch/x86/entry/common.c:80
                     entry_SYSCALL_64_after_hwframe+0x44/0xae
  }
  ... key      at: [<ffffffff90833500>] __key.12+0x0/0x40
  ... acquired at:
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline] kernel/locking/spinlock.c:162
   _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162 kernel/locking/spinlock.c:162
   snd_timer_notify sound/core/timer.c:1086 [inline]
   snd_timer_notify sound/core/timer.c:1086 [inline] sound/core/timer.c:1073
   snd_timer_notify+0x10c/0x3d0 sound/core/timer.c:1073 sound/core/timer.c:1073
   snd_pcm_timer_notify sound/core/pcm_native.c:595 [inline]
   snd_pcm_timer_notify sound/core/pcm_native.c:595 [inline] sound/core/pcm_native.c:1392
   snd_pcm_post_start+0x24a/0x310 sound/core/pcm_native.c:1392 sound/core/pcm_native.c:1392
   snd_pcm_action_single sound/core/pcm_native.c:1229 [inline]
   snd_pcm_action_single sound/core/pcm_native.c:1229 [inline] sound/core/pcm_native.c:1310
   snd_pcm_action+0x143/0x170 sound/core/pcm_native.c:1310 sound/core/pcm_native.c:1310
   __snd_pcm_lib_xfer+0x1289/0x1d80 sound/core/pcm_lib.c:2286 sound/core/pcm_lib.c:2286
   snd_pcm_oss_write3+0x103/0x250 sound/core/oss/pcm_oss.c:1241 sound/core/oss/pcm_oss.c:1241
   io_playback_transfer+0x27e/0x330 sound/core/oss/io.c:47 sound/core/oss/io.c:47
   snd_pcm_plug_write_transfer+0x2cd/0x3f0 sound/core/oss/pcm_plugin.c:627 sound/core/oss/pcm_plugin.c:627
   snd_pcm_oss_write2+0x245/0x3f0 sound/core/oss/pcm_oss.c:1373 sound/core/oss/pcm_oss.c:1373
   snd_pcm_oss_write1 sound/core/oss/pcm_oss.c:1439 [inline]
   snd_pcm_oss_write1 sound/core/oss/pcm_oss.c:1439 [inline] sound/core/oss/pcm_oss.c:2805
   snd_pcm_oss_write+0x75f/0x9c0 sound/core/oss/pcm_oss.c:2805 sound/core/oss/pcm_oss.c:2805
   vfs_write+0x28e/0xae0 fs/read_write.c:588 fs/read_write.c:588
   ksys_write+0x12d/0x250 fs/read_write.c:643 fs/read_write.c:643
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_x64 arch/x86/entry/common.c:50 [inline] arch/x86/entry/common.c:80
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae

-> (&group->lock){..-.}-{2:2} {
   IN-SOFTIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5637 [inline]
                    lock_acquire kernel/locking/lockdep.c:5637 [inline] kernel/locking/lockdep.c:5602
                    lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602 kernel/locking/lockdep.c:5602
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline] kernel/locking/spinlock.c:162
                    _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162 kernel/locking/spinlock.c:162
                    _snd_pcm_stream_lock_irqsave+0x9f/0xd0 sound/core/pcm_native.c:170 sound/core/pcm_native.c:170
                    snd_pcm_period_elapsed+0x1d/0x50 sound/core/pcm_lib.c:1848 sound/core/pcm_lib.c:1848
                    dummy_hrtimer_callback+0x94/0x1b0 sound/drivers/dummy.c:377 sound/drivers/dummy.c:377
                    __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
                    __run_hrtimer kernel/time/hrtimer.c:1685 [inline] kernel/time/hrtimer.c:1749
                    __hrtimer_run_queues+0x609/0xe50 kernel/time/hrtimer.c:1749 kernel/time/hrtimer.c:1749
                    hrtimer_run_softirq+0x17b/0x360 kernel/time/hrtimer.c:1766 kernel/time/hrtimer.c:1766
                    __do_softirq+0x29b/0x9c2 kernel/softirq.c:558 kernel/softirq.c:558
                    invoke_softirq kernel/softirq.c:432 [inline]
                    invoke_softirq kernel/softirq.c:432 [inline] kernel/softirq.c:637
                    __irq_exit_rcu+0x123/0x180 kernel/softirq.c:637 kernel/softirq.c:637
                    irq_exit_rcu+0x5/0x20 kernel/softirq.c:649 kernel/softirq.c:649
                    sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097 arch/x86/kernel/apic/apic.c:1097
                    asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638 arch/x86/include/asm/idtentry.h:638
                    native_safe_halt arch/x86/include/asm/irqflags.h:51 [inline]
                    arch_safe_halt arch/x86/include/asm/irqflags.h:89 [inline]
                    acpi_safe_halt drivers/acpi/processor_idle.c:109 [inline]
                    native_safe_halt arch/x86/include/asm/irqflags.h:51 [inline] drivers/acpi/processor_idle.c:553
                    arch_safe_halt arch/x86/include/asm/irqflags.h:89 [inline] drivers/acpi/processor_idle.c:553
                    acpi_safe_halt drivers/acpi/processor_idle.c:109 [inline] drivers/acpi/processor_idle.c:553
                    acpi_idle_do_entry+0x1c6/0x250 drivers/acpi/processor_idle.c:553 drivers/acpi/processor_idle.c:553
                    acpi_idle_enter+0x361/0x500 drivers/acpi/processor_idle.c:688 drivers/acpi/processor_idle.c:688
                    cpuidle_enter_state+0x1b1/0xc80 drivers/cpuidle/cpuidle.c:237 drivers/cpuidle/cpuidle.c:237
                    cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:351 drivers/cpuidle/cpuidle.c:351
                    call_cpuidle kernel/sched/idle.c:158 [inline]
                    cpuidle_idle_call kernel/sched/idle.c:239 [inline]
                    call_cpuidle kernel/sched/idle.c:158 [inline] kernel/sched/idle.c:306
                    cpuidle_idle_call kernel/sched/idle.c:239 [inline] kernel/sched/idle.c:306
                    do_idle+0x3e8/0x590 kernel/sched/idle.c:306 kernel/sched/idle.c:306
                    cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:403 kernel/sched/idle.c:403
                    start_kernel+0x47a/0x49b init/main.c:1135 init/main.c:1135
                    secondary_startup_64_no_verify+0xb0/0xbb
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5637 [inline]
                   lock_acquire kernel/locking/lockdep.c:5637 [inline] kernel/locking/lockdep.c:5602
                   lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602 kernel/locking/lockdep.c:5602
                   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
                   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline] kernel/locking/spinlock.c:170
                   _raw_spin_lock_irq+0x32/0x50 kernel/locking/spinlock.c:170 kernel/locking/spinlock.c:170
                   spin_lock_irq include/linux/spinlock.h:374 [inline]
                   snd_pcm_group_lock_irq sound/core/pcm_native.c:97 [inline]
                   snd_pcm_stream_lock_irq sound/core/pcm_native.c:136 [inline]
                   spin_lock_irq include/linux/spinlock.h:374 [inline] sound/core/pcm_native.c:686
                   snd_pcm_group_lock_irq sound/core/pcm_native.c:97 [inline] sound/core/pcm_native.c:686
                   snd_pcm_stream_lock_irq sound/core/pcm_native.c:136 [inline] sound/core/pcm_native.c:686
                   snd_pcm_hw_params+0x12a/0x1990 sound/core/pcm_native.c:686 sound/core/pcm_native.c:686
                   snd_pcm_kernel_ioctl+0x164/0x310 sound/core/pcm_native.c:3372 sound/core/pcm_native.c:3372
                   snd_pcm_oss_change_params_locked+0x13c8/0x3bf0 sound/core/oss/pcm_oss.c:960 sound/core/oss/pcm_oss.c:960
                   snd_pcm_oss_make_ready_locked+0xb3/0x130 sound/core/oss/pcm_oss.c:1186 sound/core/oss/pcm_oss.c:1186
                   snd_pcm_oss_write1 sound/core/oss/pcm_oss.c:1404 [inline]
                   snd_pcm_oss_write1 sound/core/oss/pcm_oss.c:1404 [inline] sound/core/oss/pcm_oss.c:2805
                   snd_pcm_oss_write+0x4b2/0x9c0 sound/core/oss/pcm_oss.c:2805 sound/core/oss/pcm_oss.c:2805
                   vfs_write+0x28e/0xae0 fs/read_write.c:588 fs/read_write.c:588
                   ksys_write+0x12d/0x250 fs/read_write.c:643 fs/read_write.c:643
                   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                   do_syscall_x64 arch/x86/entry/common.c:50 [inline] arch/x86/entry/common.c:80
                   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80 arch/x86/entry/common.c:80
                   entry_SYSCALL_64_after_hwframe+0x44/0xae
 }
 ... key      at: [<ffffffff90833d60>] __key.9+0x0/0x40
 ... acquired at:
   mark_usage kernel/locking/lockdep.c:4500 [inline]
   mark_usage kernel/locking/lockdep.c:4500 [inline] kernel/locking/lockdep.c:4981
   __lock_acquire+0x11d5/0x54a0 kernel/locking/lockdep.c:4981 kernel/locking/lockdep.c:4981
   lock_acquire kernel/locking/lockdep.c:5637 [inline]
   lock_acquire kernel/locking/lockdep.c:5637 [inline] kernel/locking/lockdep.c:5602
   lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602 kernel/locking/lockdep.c:5602
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline] kernel/locking/spinlock.c:162
   _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162 kernel/locking/spinlock.c:162
   _snd_pcm_stream_lock_irqsave+0x9f/0xd0 sound/core/pcm_native.c:170 sound/core/pcm_native.c:170
   snd_pcm_period_elapsed+0x1d/0x50 sound/core/pcm_lib.c:1848 sound/core/pcm_lib.c:1848
   dummy_hrtimer_callback+0x94/0x1b0 sound/drivers/dummy.c:377 sound/drivers/dummy.c:377
   __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
   __run_hrtimer kernel/time/hrtimer.c:1685 [inline] kernel/time/hrtimer.c:1749
   __hrtimer_run_queues+0x609/0xe50 kernel/time/hrtimer.c:1749 kernel/time/hrtimer.c:1749
   hrtimer_run_softirq+0x17b/0x360 kernel/time/hrtimer.c:1766 kernel/time/hrtimer.c:1766
   __do_softirq+0x29b/0x9c2 kernel/softirq.c:558 kernel/softirq.c:558
   invoke_softirq kernel/softirq.c:432 [inline]
   invoke_softirq kernel/softirq.c:432 [inline] kernel/softirq.c:637
   __irq_exit_rcu+0x123/0x180 kernel/softirq.c:637 kernel/softirq.c:637
   irq_exit_rcu+0x5/0x20 kernel/softirq.c:649 kernel/softirq.c:649
   sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097 arch/x86/kernel/apic/apic.c:1097
   asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638 arch/x86/include/asm/idtentry.h:638
   native_safe_halt arch/x86/include/asm/irqflags.h:51 [inline]
   arch_safe_halt arch/x86/include/asm/irqflags.h:89 [inline]
   acpi_safe_halt drivers/acpi/processor_idle.c:109 [inline]
   native_safe_halt arch/x86/include/asm/irqflags.h:51 [inline] drivers/acpi/processor_idle.c:553
   arch_safe_halt arch/x86/include/asm/irqflags.h:89 [inline] drivers/acpi/processor_idle.c:553
   acpi_safe_halt drivers/acpi/processor_idle.c:109 [inline] drivers/acpi/processor_idle.c:553
   acpi_idle_do_entry+0x1c6/0x250 drivers/acpi/processor_idle.c:553 drivers/acpi/processor_idle.c:553
   acpi_idle_enter+0x361/0x500 drivers/acpi/processor_idle.c:688 drivers/acpi/processor_idle.c:688
   cpuidle_enter_state+0x1b1/0xc80 drivers/cpuidle/cpuidle.c:237 drivers/cpuidle/cpuidle.c:237
   cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:351 drivers/cpuidle/cpuidle.c:351
   call_cpuidle kernel/sched/idle.c:158 [inline]
   cpuidle_idle_call kernel/sched/idle.c:239 [inline]
   call_cpuidle kernel/sched/idle.c:158 [inline] kernel/sched/idle.c:306
   cpuidle_idle_call kernel/sched/idle.c:239 [inline] kernel/sched/idle.c:306
   do_idle+0x3e8/0x590 kernel/sched/idle.c:306 kernel/sched/idle.c:306
   cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:403 kernel/sched/idle.c:403
   start_kernel+0x47a/0x49b init/main.c:1135 init/main.c:1135
   secondary_startup_64_no_verify+0xb0/0xbb


stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 __dump_stack lib/dump_stack.c:88 [inline] lib/dump_stack.c:106
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106 lib/dump_stack.c:106
 print_irq_inversion_bug kernel/locking/lockdep.c:203 [inline]
 check_usage_forwards kernel/locking/lockdep.c:4043 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4175 [inline]
 print_irq_inversion_bug kernel/locking/lockdep.c:203 [inline] kernel/locking/lockdep.c:4605
 check_usage_forwards kernel/locking/lockdep.c:4043 [inline] kernel/locking/lockdep.c:4605
 mark_lock_irq kernel/locking/lockdep.c:4175 [inline] kernel/locking/lockdep.c:4605
 mark_lock.cold+0x86/0x8e kernel/locking/lockdep.c:4605 kernel/locking/lockdep.c:4605
 mark_usage kernel/locking/lockdep.c:4500 [inline]
 mark_usage kernel/locking/lockdep.c:4500 [inline] kernel/locking/lockdep.c:4981
 __lock_acquire+0x11d5/0x54a0 kernel/locking/lockdep.c:4981 kernel/locking/lockdep.c:4981
 lock_acquire kernel/locking/lockdep.c:5637 [inline]
 lock_acquire kernel/locking/lockdep.c:5637 [inline] kernel/locking/lockdep.c:5602
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602 kernel/locking/lockdep.c:5602
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline] kernel/locking/spinlock.c:162
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162 kernel/locking/spinlock.c:162
 _snd_pcm_stream_lock_irqsave+0x9f/0xd0 sound/core/pcm_native.c:170 sound/core/pcm_native.c:170
 snd_pcm_period_elapsed+0x1d/0x50 sound/core/pcm_lib.c:1848 sound/core/pcm_lib.c:1848
 dummy_hrtimer_callback+0x94/0x1b0 sound/drivers/dummy.c:377 sound/drivers/dummy.c:377
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline] kernel/time/hrtimer.c:1749
 __hrtimer_run_queues+0x609/0xe50 kernel/time/hrtimer.c:1749 kernel/time/hrtimer.c:1749
 hrtimer_run_softirq+0x17b/0x360 kernel/time/hrtimer.c:1766 kernel/time/hrtimer.c:1766
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558 kernel/softirq.c:558
 invoke_softirq kernel/softirq.c:432 [inline]
 invoke_softirq kernel/softirq.c:432 [inline] kernel/softirq.c:637
 __irq_exit_rcu+0x123/0x180 kernel/softirq.c:637 kernel/softirq.c:637
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:649 kernel/softirq.c:649
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638 arch/x86/include/asm/idtentry.h:638
RIP: 0010:native_save_fl arch/x86/include/asm/irqflags.h:29 [inline]
RIP: 0010:arch_local_save_flags arch/x86/include/asm/irqflags.h:70 [inline]
RIP: 0010:arch_irqs_disabled arch/x86/include/asm/irqflags.h:132 [inline]
RIP: 0010:acpi_safe_halt drivers/acpi/processor_idle.c:110 [inline]
RIP: 0010:native_save_fl arch/x86/include/asm/irqflags.h:29 [inline] drivers/acpi/processor_idle.c:553
RIP: 0010:arch_local_save_flags arch/x86/include/asm/irqflags.h:70 [inline] drivers/acpi/processor_idle.c:553
RIP: 0010:arch_irqs_disabled arch/x86/include/asm/irqflags.h:132 [inline] drivers/acpi/processor_idle.c:553
RIP: 0010:acpi_safe_halt drivers/acpi/processor_idle.c:110 [inline] drivers/acpi/processor_idle.c:553
RIP: 0010:acpi_idle_do_entry+0x1c6/0x250 drivers/acpi/processor_idle.c:553 drivers/acpi/processor_idle.c:553
Code: 89 de e8 6d 5e 30 f8 84 db 75 ac e8 84 5a 30 f8 e8 cf 9e 36 f8 eb 0c e8 78 5a 30 f8 0f 00 2d d1 b4 c9 00 e8 6c 5a 30 f8 fb f4 <9c> 5b 81 e3 00 02 00 00 fa 31 ff 48 89 de e8 e7 5c 30 f8 48 85 db
RSP: 0018:ffffffff8b807d60 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffffffff8b8bc6c0 RSI: ffffffff89475854 RDI: 0000000000000000
RBP: ffff888011a74864 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff817df748 R11: 0000000000000000 R12: 0000000000000001
R13: ffff888011a74800 R14: ffff888011a74864 R15: ffff888145d9c804
 acpi_idle_enter+0x361/0x500 drivers/acpi/processor_idle.c:688 drivers/acpi/processor_idle.c:688
 cpuidle_enter_state+0x1b1/0xc80 drivers/cpuidle/cpuidle.c:237 drivers/cpuidle/cpuidle.c:237
 cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:351 drivers/cpuidle/cpuidle.c:351
 call_cpuidle kernel/sched/idle.c:158 [inline]
 cpuidle_idle_call kernel/sched/idle.c:239 [inline]
 call_cpuidle kernel/sched/idle.c:158 [inline] kernel/sched/idle.c:306
 cpuidle_idle_call kernel/sched/idle.c:239 [inline] kernel/sched/idle.c:306
 do_idle+0x3e8/0x590 kernel/sched/idle.c:306 kernel/sched/idle.c:306
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:403 kernel/sched/idle.c:403
 start_kernel+0x47a/0x49b init/main.c:1135 init/main.c:1135
 secondary_startup_64_no_verify+0xb0/0xbb
 </TASK>
----------------
Code disassembly (best guess):
   0:	89 de                	mov    %ebx,%esi
   2:	e8 6d 5e 30 f8       	callq  0xf8305e74
   7:	84 db                	test   %bl,%bl
   9:	75 ac                	jne    0xffffffb7
   b:	e8 84 5a 30 f8       	callq  0xf8305a94
  10:	e8 cf 9e 36 f8       	callq  0xf8369ee4
  15:	eb 0c                	jmp    0x23
  17:	e8 78 5a 30 f8       	callq  0xf8305a94
  1c:	0f 00 2d d1 b4 c9 00 	verw   0xc9b4d1(%rip)        # 0xc9b4f4
  23:	e8 6c 5a 30 f8       	callq  0xf8305a94
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	9c                   	pushfq <-- trapping instruction
  2b:	5b                   	pop    %rbx
  2c:	81 e3 00 02 00 00    	and    $0x200,%ebx
  32:	fa                   	cli
  33:	31 ff                	xor    %edi,%edi
  35:	48 89 de             	mov    %rbx,%rsi
  38:	e8 e7 5c 30 f8       	callq  0xf8305d24
  3d:	48 85 db             	test   %rbx,%rbx
----------------
Code disassembly (best guess):
   0:	89 de                	mov    %ebx,%esi
   2:	e8 6d 5e 30 f8       	callq  0xf8305e74
   7:	84 db                	test   %bl,%bl
   9:	75 ac                	jne    0xffffffb7
   b:	e8 84 5a 30 f8       	callq  0xf8305a94
  10:	e8 cf 9e 36 f8       	callq  0xf8369ee4
  15:	eb 0c                	jmp    0x23
  17:	e8 78 5a 30 f8       	callq  0xf8305a94
  1c:	0f 00 2d d1 b4 c9 00 	verw   0xc9b4d1(%rip)        # 0xc9b4f4
  23:	e8 6c 5a 30 f8       	callq  0xf8305a94
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	9c                   	pushfq <-- trapping instruction
  2b:	5b                   	pop    %rbx
  2c:	81 e3 00 02 00 00    	and    $0x200,%ebx
  32:	fa                   	cli
  33:	31 ff                	xor    %edi,%edi
  35:	48 89 de             	mov    %rbx,%rsi
  38:	e8 e7 5c 30 f8       	callq  0xf8305d24
  3d:	48 85 db             	test   %rbx,%rbx

