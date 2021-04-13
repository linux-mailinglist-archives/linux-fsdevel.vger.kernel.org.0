Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D12935DC04
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 11:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhDMJ7D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 05:59:03 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:37908 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229661AbhDMJ7B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 05:59:01 -0400
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id A46305ECAE6;
        Tue, 13 Apr 2021 19:58:38 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lWFob-005tqP-56; Tue, 13 Apr 2021 19:58:37 +1000
Date:   Tue, 13 Apr 2021 19:58:37 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, bigeasy@linutronix.de,
        hch@infradead.org, npiggin@kernel.dk
Subject: Re: bl_list and lockdep
Message-ID: <20210413095837.GD63242@dread.disaster.area>
References: <20210406123343.1739669-1-david@fromorbit.com>
 <20210406123343.1739669-4-david@fromorbit.com>
 <20210406132834.GP2531743@casper.infradead.org>
 <20210406212253.GC1990290@dread.disaster.area>
 <874kgb1qcq.ffs@nanos.tec.linutronix.de>
 <20210412221536.GQ1990290@dread.disaster.area>
 <87fszvytv8.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fszvytv8.ffs@nanos.tec.linutronix.de>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_f
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=kj9zAlcOel0A:10 a=3YhXtTcJ-WEA:10 a=7-415B0cAAAA:8
        a=Ta7Pabei9qwIYMADUlkA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 13, 2021 at 01:18:35AM +0200, Thomas Gleixner wrote:
> Dave,
> 
> On Tue, Apr 13 2021 at 08:15, Dave Chinner wrote:
> > On Mon, Apr 12, 2021 at 05:20:53PM +0200, Thomas Gleixner wrote:
> >> On Wed, Apr 07 2021 at 07:22, Dave Chinner wrote:
> >> > And, FWIW, I'm also aware of the problems that RT kernels have with
> >> > the use of bit spinlocks and being unable to turn them into sleeping
> >> > mutexes by preprocessor magic. I don't care about that either,
> >> > because dentry cache...
> >> 
> >> In the dentry cache it's a non-issue.
> >
> > Incorrect.
> 
> I'm impressed about your detailed knowledge of something you do not care
> about in the first place.

There's a difference between "don't care because don't understand"
and "don't care because I know how complex real-time is and I know I
can't validate any code I write to be RT safe".

Indeed, just because I work on filesystems now doesn't mean I don't
know what real-time is - I spent the best part of a decade as an
industrial control engineer building systems that provided water and
electricity to populations of millions of people before I started
working on filesystems....

> >> RT does not have a problem with bit spinlocks per se, it depends on how
> >> they are used and what nests inside. Most of them are just kept as bit
> >> spinlocks because the lock held, and therefore preempt disabled times
> >> are small and no other on RT conflicting operations happen inside.
> >> 
> >> In the case at hand this is going to be a problem because inode->i_lock
> >> nests inside the bit spinlock and we can't make inode->i_lock a raw
> >> spinlock because it protects way heavier weight code pathes as well.
> >
> > Yes, that's exactly the "problem" I'm refering to. And I don't care,
> > precisely because, well, dentry cache....
> >
> > THat is, the dcache calls wake_up_all() from under the
> > hlist_bl_lock() in __d_lookup_done(). That ends up in
> > __wake_up_common_lock() which takes a spin lock embedded inside a
> > wait_queue_head.  That's not a raw spinlock, either, so we already
> > have this "spinlock inside bit lock" situation with the dcache usage
> > of hlist_bl.
> 
> Sure, but you are missing that RT solves that by substituting the
> wait_queue with a swait_queue, which does not suffer from that. But that
> can't be done for the inode::i_lock case for various reasons.

I didn't know about that specific forklift replacement. But, really
that simply adds weight to my comment below....

> > FYI, this dentry cache behaviour was added to the dentry cache in
> > 2016 by commit d9171b934526 ("parallel lookups machinery, part 4
> > (and last)"), so it's not like it's a new thing, either.
> 
> Really? I wasn't aware of that. Thanks for the education.
> 
> > If you want to make hlist_bl RT safe, then re-implement it behind
> > the scenes for RT enabled kernels. All it takes is more memory
> > usage for the hash table + locks, but that's something that non-RT
> > people should not be burdened with caring about....

... because if RT devs are willing to forklift replace core kernel
functionality like wait queues to provide RT kernels with a
completely different locking schema to vanilla kernels, then
slightly modifying the hlist-bl structure in a RT compatible way is
child's play....

> I'm well aware that anything outside of @fromorbit universe is not
> interesting to you, but I neverless want to take the opportunity to
> express my appreciation for your truly caring and collaborative attitude
> versus interests of others who unfortunately do no share that universe.

I'm being realistic. I dont' have the time or mental bandwidth to
solve RT kernel problems. I don't have any way to test RT kernels,
and lockdep is a crock of shit for validating RT locking on vanilla
kernels because of the forklift upgrade games like the above that
give the RT kernel a different locking schema.

Because I have sufficient knowledge of the real-time game, I know
*I'm not an RT expert* these days. I know that I don't know all the
games it plays, nor do I have the time (or patience) to learn about
all of them, nor the resources or knowledge to test whether the code
I write follows all the rules I don't know about, whether I
introduced interrupt hold-offs longer than 50us, etc.

IOWs, I chose not to care about RT because I know I don't know
enough about it to write solid, well tested RT compatible kernel
code. I can write untested shit as well as any other programmer, but
I have much higher professional standards than that.

And I also know there are paid professionals who are RT experts who
are supposed to take care of this stuff so random kernel devs like
myself *don't need to care about the details of how RT kernels do
their magic*.

So for solving the inode cache scalability issue with RT in mind,
we're left with these choices:

a) increase memory consumption and cacheline misses for everyone by
   adding a spinlock per hash chain so that RT kernels can do their
   substitution magic and make the memory footprint and scalability
   for RT kernels worse

b) convert the inode hash table to something different (rhashtable,
   radix tree, Xarray, etc) that is more scalable and more "RT
   friendly".

c) have RT kernel substitute hlist-bl with hlist_head and a spinlock
   so that it all works correctly on RT kernels and only RT kernels
   take the memory footprint and cacheline miss penalties...

We rejected a) for the dentry hash table, so it is not an appropriate
soltion for the inode hash table for the same reasons.

There is a lot of downside to b). Firstly there's the time and
resources needed for experimentation to find an appropriate
algorithm for both scalability and RT. Then all the insert, removal
and search facilities will have to be rewritten, along with all the
subtlies like "fake hashing" to allow fielsysetms to provide their
own inode caches.  The changes in behaviour and, potentially, API
semantics will greatly increase the risk of regressions and adverse
behaviour on both vanilla and RT kernels compared to option a) or
c).

It is clear that option c) is of minimal risk to vanilla kernels,
and low risk to RT kernels. It's pretty straight forward to do for
both configs, and only the RT kernels take the memory footprint
penalty.

So a technical analysis points to c) being the most reasonable
resolution of the problem.

Making sure RT kernels work correctly is your job, Thomas, not mine.
Converting hlist-bl to a rt compatible structure should be pretty
simple:


struct hlist_bl_head {
        struct hlist_bl_node *first;
+#idef CONFIG_RT
+	spinlock_t lock;
+#endif
};

.....
static inline void hlist_bl_lock(struct hlist_bl_head *b)
{
+#ifdef CONFIG_RT
+	spin_lock(&b->lock);
+#else
	bit_spin_lock(0, (unsigned long *)b);
+#endif
}

static inline void hlist_bl_unlock(struct hlist_bl_head *b)
{
+#ifdef CONFIG_RT
+	spin_unlock(&b->lock);
+#else
	bit_spin_lock(0, (unsigned long *)b);
+#endif
}

So if you want to run up a patch that converts hlist-bl to be rt
compatible and test it on your RT test farm and send it to me, then
I'll happily include it in my patchset....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
