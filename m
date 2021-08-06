Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD91F3E30ED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 23:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239507AbhHFVVj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 17:21:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232115AbhHFVVj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 17:21:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A264A60EE8;
        Fri,  6 Aug 2021 21:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628284882;
        bh=Bchx560CKUF229KPJgM7uqaIc2EZoNRJI+Mks07iNHA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hsT5SBu9WiktHQmjlAf031vszOskjOHRl5E3ZRNpWssWT8YkfpKYXmMGPlYPY6o8w
         QOiuOyOjVe+Osj3J66HLKuDcrlGwNdjG5vGZgGUQgbEGcBurbuIRsns2PsjDRuNZ17
         dlr5ioNtV/Yvv+YVA6YSDuEU5TDGaLVcOIgAXnVTXj0Ii1ooe5xoh16l+WcrvN8lyK
         TbnN+Por8sMt01tRSrqNSMGz9x1cxnlaF06iHFFAv6caRFgri7YXQCvDaiZf7jIQHW
         NpBwpb+sRoCrOV/Qs1r9YAYWS2yO9tTeDaFBfsrgSb/BcLRRLwSygGKZ6tSF4RJ+lH
         lsB8s1bH3JVCQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 713095C0546; Fri,  6 Aug 2021 14:21:22 -0700 (PDT)
Date:   Fri, 6 Aug 2021 14:21:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     syzbot <syzbot+66e110c312ed4ae684a8@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] KASAN: use-after-free Read in timerfd_clock_was_set
Message-ID: <20210806212122.GT4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <000000000000fdf3e205c88fa4cf@google.com>
 <877dgy5xtx.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dgy5xtx.ffs@tglx>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 06, 2021 at 06:42:34PM +0200, Thomas Gleixner wrote:
> Hi!
> 
> On Mon, Aug 02 2021 at 01:49, syzbot wrote:
> > syzbot found the following issue on:
> >
> > HEAD commit:    4010a528219e Merge tag 'fixes_for_v5.14-rc4' of git://git...
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13611f5c300000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=1dee114394f7d2c2
> > dashboard link: https://syzkaller.appspot.com/bug?extid=66e110c312ed4ae684a8
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+66e110c312ed4ae684a8@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KASAN: use-after-free in timerfd_clock_was_set+0x2b8/0x2e0
> > fs/timerfd.c:104
> 
> 103	rcu_read_lock();
> 104	list_for_each_entry_rcu(ctx, &cancel_list, clist) {
> 
> >  timerfd_clock_was_set+0x2b8/0x2e0 fs/timerfd.c:104
> >  timekeeping_inject_offset+0x4af/0x620 kernel/time/timekeeping.c:1375
> >  do_adjtimex+0x28f/0xa30 kernel/time/timekeeping.c:2406
> >  do_clock_adjtime kernel/time/posix-timers.c:1109 [inline]
> >  __do_sys_clock_adjtime+0x163/0x270 kernel/time/posix-timers.c:1121
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> 
> ...
> 
> > Allocated by task 1:
> >  kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
> >  kasan_set_track mm/kasan/common.c:46 [inline]
> >  set_alloc_info mm/kasan/common.c:434 [inline]
> >  ____kasan_kmalloc mm/kasan/common.c:513 [inline]
> >  ____kasan_kmalloc mm/kasan/common.c:472 [inline]
> >  __kasan_kmalloc+0x98/0xc0 mm/kasan/common.c:522
> >  kasan_kmalloc include/linux/kasan.h:264 [inline]
> >  kmem_cache_alloc_trace+0x1e4/0x480 mm/slab.c:3575
> >  kmalloc include/linux/slab.h:591 [inline]
> >  kzalloc include/linux/slab.h:721 [inline]
> >  __do_sys_timerfd_create+0x265/0x370 fs/timerfd.c:412
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> ...
> 
> > Freed by task 3306:
> >  kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
> >  kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
> >  kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:360
> >  ____kasan_slab_free mm/kasan/common.c:366 [inline]
> >  ____kasan_slab_free mm/kasan/common.c:328 [inline]
> >  __kasan_slab_free+0xcd/0x100 mm/kasan/common.c:374
> >  kasan_slab_free include/linux/kasan.h:230 [inline]
> >  __cache_free mm/slab.c:3445 [inline]
> >  kfree+0x106/0x2c0 mm/slab.c:3803
> >  kvfree+0x42/0x50 mm/util.c:616
> >  kfree_rcu_work+0x5b7/0x870 kernel/rcu/tree.c:3359
> >  process_one_work+0x98d/0x1630 kernel/workqueue.c:2276
> >  worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
> >  kthread+0x3e5/0x4d0 kernel/kthread.c:319
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> 
> So the free of the timerfd context happens while the context is
> still linked in the cancel list, which does not make sense because
> 
> > Last potentially related work creation:
> >  kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
> >  kasan_record_aux_stack+0xa4/0xd0 mm/kasan/generic.c:348
> >  kvfree_call_rcu+0x74/0x990 kernel/rcu/tree.c:3594
> >  timerfd_release+0x105/0x290 fs/timerfd.c:229
> 
> timerfd_release() invokes timerfd_remove_cancel(context) before invoking
> kfree_rcu().

And the list being deleted from is the same list that is being scanned.

> >  __fput+0x288/0x920 fs/file_table.c:280
> >  task_work_run+0xdd/0x1a0 kernel/task_work.c:164
> >  tracehook_notify_resume include/linux/tracehook.h:189 [inline]
> >  exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
> >  exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:209
> >  __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
> >  syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:302
> >  do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> The only reason why timerfd_remove_cancel() would not remove it from the
> list is when context->might_cancel is false. But that would mean it's a
> memory corruption of some sort which went undetected. I can't spot
> anything in the timerfd code itself which would cause that.
> 
> Confused.

You and me!

This kernel is built with CONFIG_PREEMPT_RCU=y, so a stray schedule()
in the RCU read-side critical section would not cause this to happen
(as it might on a CONFIG_PREEMPT_RCU=n kernel).  Besides, I am not seeing
any sign of a stray schedule() in that code.

This could of course be a too-short RCU grace period, but I have been
hammering RCU rather hard of late.  No guarantee, of course, but...

This kernel is already built with CONFIG_DEBUG_OBJECTS=y and also with
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y, which is my usual suggestion in this
situation.

There are a bunch of "Directory bread(block 6) failed" messages before
this splat.  Are those expected behavior, or might they be related?

							Thanx, Paul
