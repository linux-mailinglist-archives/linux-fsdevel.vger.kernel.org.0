Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4D7410B96
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Sep 2021 14:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbhISMms (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Sep 2021 08:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhISMmr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Sep 2021 08:42:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722F1C061574;
        Sun, 19 Sep 2021 05:41:22 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632055280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fJ+hrUpU5MiPbitihsh+gHOnN+VL18gvd0mwNVsinxQ=;
        b=LsGM8s+/IMvfPAuufPS6b/LxLmKMVB5d+13eFIC8MkwvaVoctGGb5awDoM40LKBk6G2Rzz
        te8mT8yYqn3cxJh3SCwLVN3LqSoRBuGN2fUVDZHMNGgkEcxS0W/GkeaTD6tAR6HTAPGDJN
        VFPa1sFqnMfTyWBYGPX9FfE4HlE/M/h7XNHe8wYwzj4vANeqpReOYfneQNlzUza3Lsao1N
        b5ABMnuKPhPjk+/Fs/8SrwKz0I6Kbyvrcpiky8s4d2wdWinYJQwwazXjdHS5CCEt6jN7el
        2TMv4aNICjpz6TP0cQ9How9OSLUIpUtb7rusvVkDOxP9xz3+3ILtKbeWnylTxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632055280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fJ+hrUpU5MiPbitihsh+gHOnN+VL18gvd0mwNVsinxQ=;
        b=f3GxbVALKFH02fjiUWP/En/F4kQ5sW5RGnLd/GOO8Eumo62RATeY86eimjCpZhU95HmdvX
        p2fJ3L2WsBlIJgDA==
To:     Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+d6c75f383e01426a40b4@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Waiman Long <llong@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [syzbot] WARNING in __init_work
In-Reply-To: <163175937144.763609.2073508754264771910@swboyd.mtv.corp.google.com>
References: <000000000000423e0a05cc0ba2c4@google.com>
 <20210915161457.95ad5c9470efc70196d48410@linux-foundation.org>
 <163175937144.763609.2073508754264771910@swboyd.mtv.corp.google.com>
Date:   Sun, 19 Sep 2021 14:41:18 +0200
Message-ID: <87sfy07n69.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stephen,

On Wed, Sep 15 2021 at 19:29, Stephen Boyd wrote:
> Quoting Andrew Morton (2021-09-15 16:14:57)
>> On Wed, 15 Sep 2021 10:00:22 -0700 syzbot <syzbot+d6c75f383e01426a40b4@syzkaller.appspotmail.com> wrote:
>> > 
>> > ODEBUG: object ffffc90000fd8bc8 is NOT on stack ffffc900022a0000, but annotated.
>
> This is saying that the object was supposed to be on the stack because
> debug objects was told that, but it isn't on the stack per the
> definition of object_is_on_stack().

Correct.

>> >  <IRQ>
>> >  __init_work+0x2d/0x50 kernel/workqueue.c:519
>> >  synchronize_rcu_expedited+0x392/0x620 kernel/rcu/tree_exp.h:847
>
> This line looks like
>
>   INIT_WORK_ONSTACK(&rew.rew_work, wait_rcu_exp_gp);
>
> inside synchronize_rcu_expedited(). The rew structure is declared on the
> stack
>
>    struct rcu_exp_work rew;

Yes, but object_is_on_stack() checks for task stacks only. And the splat
here is entirely correct:

softirq()
  ...
  synchronize_rcu_expedited()
     INIT_WORK_ONSTACK()
     queue_work()
     wait_event()

is obviously broken. You cannot wait in soft irq context.

synchronize_rcu_expedited() should really have a might_sleep() at the
beginning to make that more obvious.

The splat is clobbered btw:

[  416.415111][    C1] ODEBUG: object ffffc90000fd8bc8 is NOT on stack ffffc900022a0000, but annotated.
[  416.423424][T14850] truncated
[  416.431623][    C1] ------------[ cut here ]------------
[  416.438913][T14850] ------------[ cut here ]------------
[  416.440189][    C1] WARNING: CPU: 1 PID: 2971 at lib/debugobjects.c:548 __debug_object_init.cold+0x252/0x2e5
[  416.455797][T14850] refcount_t: addition on 0; use-after-free.

So there is a refcount_t violation as well.

Nevertheless a hint for finding the culprit is obviously here in that
call chain:

>> >  bdi_remove_from_list mm/backing-dev.c:938 [inline]
>> >  bdi_unregister+0x177/0x5a0 mm/backing-dev.c:946
>> >  release_bdi+0xa1/0xc0 mm/backing-dev.c:968
>> >  kref_put include/linux/kref.h:65 [inline]
>> >  bdi_put+0x72/0xa0 mm/backing-dev.c:976
>> >  bdev_free_inode+0x116/0x220 fs/block_dev.c:819
>> >  i_callback+0x3f/0x70 fs/inode.c:224

The inode code uses RCU for freeing an inode object which then ends up
calling bdi_put() and subsequently in synchronize_rcu_expedited().

>> >  rcu_do_batch kernel/rcu/tree.c:2508 [inline]
>> >  rcu_core+0x7ab/0x1470 kernel/rcu/tree.c:2743
>> >  __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
>> >  invoke_softirq kernel/softirq.c:432 [inline]
>> >  __irq_exit_rcu+0x123/0x180 kernel/softirq.c:636
>> >  irq_exit_rcu+0x5/0x20 kernel/softirq.c:648
>> >  sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
>> >  </IRQ>
>> 
>> Seems that we have a debugobject in the incorrect state, but it doesn't
>> necessarily mean there's something wrong in the bdi code.  It's just
>> that the bdi code happened to be the place which called
>> synchronize_rcu_expedited().

Again, it cannot do that from a softirq because
synchronize_rcu_expedited() might sleep.

> Is it possible that object_is_on_stack() doesn't work in IRQ context?
> I'm not really following along on x86 but I could see where
> task_stack_page() gets the wrong "stack" pointer because the task has one
> stack and the irq stack is some per-cpu dedicated allocation?

Even if debug objects would support objects on irq stacks, the above is
still bogus. But it does not and will not because the operations here
have to be fully synchronous:

    init() -> queue() or arm() -> wait() -> destroy()

because you obviously cannot queue work or arm a timer which are on stack
and then leave the function without waiting for the operation to complete.

So these operations have to be synchronous which is a NONO when running
in hard or soft interrupt context because waiting for the operation to
complete is not possible there.

Thanks,

        tglx
