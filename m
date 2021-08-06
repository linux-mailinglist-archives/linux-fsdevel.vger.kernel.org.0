Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B9F3E2E78
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 18:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbhHFQm6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 12:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhHFQmz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 12:42:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C8EC0613CF;
        Fri,  6 Aug 2021 09:42:39 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628268155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kk2lzokAVmZhhmkoXQnRu32luG8afaBCbXzoD+9YANs=;
        b=pke0WyKqyLslgXt8ga5uRGMHIMozL9ODi2HhdKyMRJl/NDaTF74UXoIlbFP4kdYwnvHcCV
        F7nZnMwmdEg36la0yAhu3/lLoM2kzV8M1c5gEWOqahvdeuAjnJ+xbYiiK2XttOXAzSfMfs
        cwB3lAFoNnucYlXPk2WtiAJhIgUa8ctfLEKYn0CZABYM6XQIJ3SnJgNrZU6WSKb2LZkoam
        Rwpyv3rnETO68VCM57ehWLrTyyrUPW/T4FT02VjuUF+lX8sx3N1Q4ifxSL+QLWXSynFQla
        NaQTLXjvx+YYMZUobc/n4dFRSznQcsGLfXSmDkEEw/MJDyGXtqfZiLW4t/iqEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628268155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kk2lzokAVmZhhmkoXQnRu32luG8afaBCbXzoD+9YANs=;
        b=YSd5JfAfV6IzC8uvqRz8mwPXcWjMwmovQi+0B7GjCOEKNKr6VEnkIrNTGqqxnDpHV1pUUU
        h15SW/nRltGrgeBw==
To:     syzbot <syzbot+66e110c312ed4ae684a8@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Cc:     "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [syzbot] KASAN: use-after-free Read in timerfd_clock_was_set
In-Reply-To: <000000000000fdf3e205c88fa4cf@google.com>
References: <000000000000fdf3e205c88fa4cf@google.com>
Date:   Fri, 06 Aug 2021 18:42:34 +0200
Message-ID: <877dgy5xtx.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

On Mon, Aug 02 2021 at 01:49, syzbot wrote:
> syzbot found the following issue on:
>
> HEAD commit:    4010a528219e Merge tag 'fixes_for_v5.14-rc4' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13611f5c300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1dee114394f7d2c2
> dashboard link: https://syzkaller.appspot.com/bug?extid=66e110c312ed4ae684a8
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+66e110c312ed4ae684a8@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: use-after-free in timerfd_clock_was_set+0x2b8/0x2e0
> fs/timerfd.c:104

103	rcu_read_lock();
104	list_for_each_entry_rcu(ctx, &cancel_list, clist) {

>  timerfd_clock_was_set+0x2b8/0x2e0 fs/timerfd.c:104
>  timekeeping_inject_offset+0x4af/0x620 kernel/time/timekeeping.c:1375
>  do_adjtimex+0x28f/0xa30 kernel/time/timekeeping.c:2406
>  do_clock_adjtime kernel/time/posix-timers.c:1109 [inline]
>  __do_sys_clock_adjtime+0x163/0x270 kernel/time/posix-timers.c:1121
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80

...

> Allocated by task 1:
>  kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
>  kasan_set_track mm/kasan/common.c:46 [inline]
>  set_alloc_info mm/kasan/common.c:434 [inline]
>  ____kasan_kmalloc mm/kasan/common.c:513 [inline]
>  ____kasan_kmalloc mm/kasan/common.c:472 [inline]
>  __kasan_kmalloc+0x98/0xc0 mm/kasan/common.c:522
>  kasan_kmalloc include/linux/kasan.h:264 [inline]
>  kmem_cache_alloc_trace+0x1e4/0x480 mm/slab.c:3575
>  kmalloc include/linux/slab.h:591 [inline]
>  kzalloc include/linux/slab.h:721 [inline]
>  __do_sys_timerfd_create+0x265/0x370 fs/timerfd.c:412
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae

...

> Freed by task 3306:
>  kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
>  kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
>  kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:360
>  ____kasan_slab_free mm/kasan/common.c:366 [inline]
>  ____kasan_slab_free mm/kasan/common.c:328 [inline]
>  __kasan_slab_free+0xcd/0x100 mm/kasan/common.c:374
>  kasan_slab_free include/linux/kasan.h:230 [inline]
>  __cache_free mm/slab.c:3445 [inline]
>  kfree+0x106/0x2c0 mm/slab.c:3803
>  kvfree+0x42/0x50 mm/util.c:616
>  kfree_rcu_work+0x5b7/0x870 kernel/rcu/tree.c:3359
>  process_one_work+0x98d/0x1630 kernel/workqueue.c:2276
>  worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
>  kthread+0x3e5/0x4d0 kernel/kthread.c:319
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

So the free of the timerfd context happens while the context is
still linked in the cancel list, which does not make sense because

> Last potentially related work creation:
>  kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
>  kasan_record_aux_stack+0xa4/0xd0 mm/kasan/generic.c:348
>  kvfree_call_rcu+0x74/0x990 kernel/rcu/tree.c:3594
>  timerfd_release+0x105/0x290 fs/timerfd.c:229

timerfd_release() invokes timerfd_remove_cancel(context) before invoking
kfree_rcu().

>  __fput+0x288/0x920 fs/file_table.c:280
>  task_work_run+0xdd/0x1a0 kernel/task_work.c:164
>  tracehook_notify_resume include/linux/tracehook.h:189 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
>  exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:209
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
>  syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:302
>  do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
>  entry_SYSCALL_64_after_hwframe+0x44/0xae

The only reason why timerfd_remove_cancel() would not remove it from the
list is when context->might_cancel is false. But that would mean it's a
memory corruption of some sort which went undetected. I can't spot
anything in the timerfd code itself which would cause that.

Confused.

Thanks,

        tglx


