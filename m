Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460EB40C23C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 10:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbhIOJAj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 05:00:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48114 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237065AbhIOJAb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 05:00:31 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 61A1F20047;
        Wed, 15 Sep 2021 08:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631696350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HdT2B8J53ILAyk5O9cCoY63S/U5/pDNyDuOpo+g+ckE=;
        b=WY9vUXVmVQi8t16Yfqwuo5EMv39ia/PvF+lZC1G4E4xIYN2ZQsZxDTFKBTaRaWLa//RNgo
        XeRrd8eokhe38KWqGcMgRPaw5KJa9Je3plFdXOYkjhiY/M5gn92GTHPEBexMxbo/i7aYp7
        02fn6jD91EcfaRFUYcX+oLKCPwApoLc=
Received: from suse.com (mgorman.tcp.ovpn2.nue.suse.de [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DE4EAA3B90;
        Wed, 15 Sep 2021 08:59:08 +0000 (UTC)
Date:   Wed, 15 Sep 2021 09:59:04 +0100
From:   Mel Gorman <mgorman@suse.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] EXT4: Remove ENOMEM/congestion_wait() loops.
Message-ID: <20210915085904.GU3828@suse.com>
References: <163157808321.13293.486682642188075090.stgit@noble.brown>
 <163157838437.13293.14244628630141187199.stgit@noble.brown>
 <20210914163432.GR3828@suse.com>
 <20210914235535.GL2361455@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210914235535.GL2361455@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 15, 2021 at 09:55:35AM +1000, Dave Chinner wrote:
> On Tue, Sep 14, 2021 at 05:34:32PM +0100, Mel Gorman wrote:
> > On Tue, Sep 14, 2021 at 10:13:04AM +1000, NeilBrown wrote:
> > > Indefinite loops waiting for memory allocation are discouraged by
> > > documentation in gfp.h which says the use of __GFP_NOFAIL that it
> > > 
> > >  is definitely preferable to use the flag rather than opencode endless
> > >  loop around allocator.
> > > 
> > > Such loops that use congestion_wait() are particularly unwise as
> > > congestion_wait() is indistinguishable from
> > > schedule_timeout_uninterruptible() in practice - and should be
> > > deprecated.
> > > 
> > > So this patch changes the two loops in ext4_ext_truncate() to use
> > > __GFP_NOFAIL instead of looping.
> > > 
> > > As the allocation is multiple layers deeper in the call stack, this
> > > requires passing the EXT4_EX_NOFAIL flag down and handling it in various
> > > places.
> > > 
> > > Of particular interest is the ext4_journal_start family of calls which
> > > can now have EXT4_EX_NOFAIL 'or'ed in to the 'type'.  This could be seen
> > > as a blurring of types.  However 'type' is 8 bits, and EXT4_EX_NOFAIL is
> > > a high bit, so it is safe in practice.
> > > 
> > > jbd2__journal_start() is enhanced so that the gfp_t flags passed are
> > > used for *all* allocations.
> > > 
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > 
> > I'm not a fan. GFP_NOFAIL allows access to emergency reserves increasing
> > the risk of a livelock if memory is completely depleted where as some
> > callers can afford to wait.
> 
> Undocumented behaviour, never mentioned or communicated to users in
> any __GFP_NOFAIL discussion I've taken part in until now.
> 
> How is it different to, say, GFP_ATOMIC? i.e. Does GFP_NOFAIL
> actually imply GFP_ATOMIC, or is there some other undocumented
> behaviour going on here?
> 

Hmm, it's similar but not the same as GFP_ATOMIC. The most severe aspect
of depleting emergency reserves comes from this block which is relevant
when the system is effectively OOM

        /*
         * XXX: GFP_NOFS allocations should rather fail than rely on
         * other request to make a forward progress.
         * We are in an unfortunate situation where out_of_memory cannot
         * do much for this context but let's try it to at least get
         * access to memory reserved if the current task is killed (see
         * out_of_memory). Once filesystems are ready to handle allocation
         * failures more gracefully we should just bail out here.
         */

        /* Exhausted what can be done so it's blame time */
        if (out_of_memory(&oc) || WARN_ON_ONCE(gfp_mask & __GFP_NOFAIL)) {
                *did_some_progress = 1;

                /*
                 * Help non-failing allocations by giving them access to memory
                 * reserves
                 */
                if (gfp_mask & __GFP_NOFAIL)
                        page = __alloc_pages_cpuset_fallback(gfp_mask, order,
                                        ALLOC_NO_WATERMARKS, ac);
        }

The less severe aspect comes from

                /*
                 * Help non-failing allocations by giving them access to memory
                 * reserves but do not use ALLOC_NO_WATERMARKS because this
                 * could deplete whole memory reserves which would just make
                 * the situation worse
                 */
                page = __alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_HARDER, ac);
                if (page)
                        goto got_pg;

This doesn't dip into reserves as much as an atomic allocation does but
it competes with them.


> We've already go ~80 __GFP_NOFAIL allocation contexts in fs/ and the
> vast majority of the are GFP_KERNEL | __GFP_NOFAIL or GFP_NOFS |
> __GFP_NOFAIL, so some clarification on what this actually means
> would be really good...
> 

I'm not sure how much clarity can be given. Whatever the documented
semantics, at some point under the current implementation __GFP_NOFAIL
potentially competes with the same reserves as GFP_ATOMIC and has a path
where watermarks are ignored entirely.

> > The key event should be reclaim making progress.
> 
> Yup, that's what we need, but I don't see why it needs to be exposed
> outside the allocation code at all.
> 

Probably not. At least some of it could be contained within reclaim
itself to block when reclaim is not making progress as opposed to anything
congestion related. That might still livelock if no progress can be made
but that's not new, the OOM hammer should eventually kick in.

> > The hack below is
> > intended to vaguely demonstrate how blocking can be based on reclaim
> > making progress instead of "congestion" but has not even been booted. A
> > more complete overhaul may involve introducing
> > reclaim_congestion_wait_nodemask(gfp_t gfp_mask, long timeout, nodemask_t *nodemask)
> > and
> > reclaim_congestion_wait_nodemask(gfp_t gfp_mask, long timeout)
> 
> I think that's racy. There's no guarantee that the node we are
> currently running on matches the cpu/node id that we failed to
> allocate from.

I know, I commented

+       /*
+        * Dangerous, local memory may be forbidden by cpuset or policies,
+        * use first eligible zone in zonelists node instead
+        */

There may be multiple nodes "we failed to allocate from", but the first
eligible node is definitely one of them. There is the possibility that
the first eligible node may be completely unreclaimable (all anonymous,
no swap) in which case the timeout kicks in. I don't think this should
be a global workqueue because there will be spurious wakeups.

> Pre-emptible kernels and all that. IOWs, I think
> needs to be completely internal to the reclaim infrastructure and
> based on the current context we are trying to reclaim from.
> 

A further step could be something similar to capture_control
whereby reclaimed pages are immediately assigned to tasks blocked on
reclaim_congestion_wait. It may be excessively complicated and overkill.

> That way "GFP_RETRY_FOREVER" allocation contexts don't have to jump
> through an ever changing tangle of hoops to make basic "never-fail"
> allocation semantics behave correctly.
> 

True and I can see what that is desirable. What I'm saying is that right
now, increasing the use of __GFP_NOFAIL may cause a different set of
problems (unbounded retries combined with ATOMIC allocation failures) as
they compete for similar resources.

> > and converting congestion_wait and wait_iff_congestion to calling
> > reclaim_congestion_wait_nodemask which waits on the first usable node
> > and then audit every single congestion_wait() user to see which API
> > they should call. Further work would be to establish whether the page allocator should
> > call reclaim_congestion_wait_nodemask() if direct reclaim is not making
> > progress or whether that should be in vmscan.c. Conceivably, GFP_NOFAIL
> > could then soften its access to emergency reserves but I haven't given
> > it much thought.
> > 
> > Yes it's significant work, but it would be a better than letting
> > __GFP_NOFAIL propagate further and kicking us down the road.
> 
> Unfortunately, that seems to ignore the fact that we still need
> never-fail allocation semantics for stable system performance.  Like
> it or not the requirements for __GFP_NOFAIL (and "retry forever"
> equivalent semantics) or open coded endless retry loops
> are *never* going away.
> 

I'm aware there will be cases where never-fail allocation semantics are
required, particularly in GFP_NOFS contexts. What I'm saying is that right
now because throttling is based on imaginary "congestion" that increasing
the use could result in live-lock like bugs when multiple users complete
for similar emergency resources to atomic. Note that I didn't NACK this.

> IOWs, I'd suggest that we should think about how to formally
> support "never-fail" allocation semantics in both the API and the
> implementation in such a way that we don't end up with this
> __GFP_NOFAIL catch-22 ever again. Having the memory reclaim code
> wait on forwards progress instead of congestion as you propose here
> would be a core part of providing "never-fail" allocations...
> 
> > This hack is terrible, it's not the right way to do it, it's just to
> > illustrate the idea of "waiting on memory should be based on reclaim
> > making progress and not the state of storage" is not impossible.
> 
> I've been saying that is how reclaim should work for years. :/
> 
> It was LFSMM 2013 or 2014 that I was advocating for memory reclaim
> to move to IO-less reclaim throttling based on the rate at which
> free pages are returned to the freelists similar to the way IO-less
> dirty page throttling is based on the rate dirty pages are cleaned.
> 

I'm going to guess no one ever tried.

> Relying on IO interactions (submitting IO or waiting for completion)
> for high level page state management has always been a bad way to
> throttle demand because it only provides indirect control and has
> poor feedback indication.
> 

Also true.

> It's also a good way to remove the dependency on direct reclaim -
> just sleep instead of duplicating the work that kswapd should
> already be doing in the background to reclaim pages...
> 

Even for direct reclaim, I do think that the number of direct reclaimers
should be limited with the rest going to sleep. At some point, excessive
direct reclaim tasks are simply hammering the lru lock.

> > --8<--
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 5c0318509f9e..5ed81c5746ec 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -832,6 +832,7 @@ typedef struct pglist_data {
> >  	unsigned long node_spanned_pages; /* total size of physical page
> >  					     range, including holes */
> >  	int node_id;
> > +	wait_queue_head_t reclaim_wait;
> >  	wait_queue_head_t kswapd_wait;
> >  	wait_queue_head_t pfmemalloc_wait;
> >  	struct task_struct *kswapd;	/* Protected by
> > diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> > index 6122c78ce914..21a9cd693d12 100644
> > --- a/mm/backing-dev.c
> > +++ b/mm/backing-dev.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/module.h>
> >  #include <linux/writeback.h>
> >  #include <linux/device.h>
> > +#include <linux/swap.h>
> >  #include <trace/events/writeback.h>
> >  
> >  struct backing_dev_info noop_backing_dev_info;
> > @@ -1013,25 +1014,41 @@ void set_bdi_congested(struct backing_dev_info *bdi, int sync)
> >  EXPORT_SYMBOL(set_bdi_congested);
> >  
> >  /**
> > - * congestion_wait - wait for a backing_dev to become uncongested
> > - * @sync: SYNC or ASYNC IO
> > - * @timeout: timeout in jiffies
> > + * congestion_wait - the docs are now worthless but avoiding a rename
> >   *
> > - * Waits for up to @timeout jiffies for a backing_dev (any backing_dev) to exit
> > - * write congestion.  If no backing_devs are congested then just wait for the
> > - * next write to be completed.
> > + * New thing -- wait for a timeout or reclaim to make progress
> >   */
> >  long congestion_wait(int sync, long timeout)
> >  {
> > +	pg_data_t *pgdat;
> >  	long ret;
> >  	unsigned long start = jiffies;
> >  	DEFINE_WAIT(wait);
> > -	wait_queue_head_t *wqh = &congestion_wqh[sync];
> > +	wait_queue_head_t *wqh;
> >  
> > -	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
> > -	ret = io_schedule_timeout(timeout);
> > +	/* Never let kswapd sleep on itself */
> > +	if (current_is_kswapd())
> > +		goto trace;
> 
> I think this breaks the kswapd 100ms immediate reclaim backoff in
> shrink_node().
> 

Yep, it is. That would definitely need better care.

> > +
> > +	/*
> > +	 * Dangerous, local memory may be forbidden by cpuset or policies,
> > +	 * use first eligible zone in zonelists node instead
> > +	 */
> > +	preempt_disable();
> > +	pgdat = NODE_DATA(smp_processor_id());
> > +	preempt_enable();
> > +	wqh = &pgdat->reclaim_wait;
> 
> This goes away if it is kept internal and is passed the reclaim
> pgdat context we just failed to reclaim pages from.
> 

Yep, that would also work if this was called only from reclaim contexts
or mm internally. Some helper would still be needed to implement an
alternative congestion_wait that looks up the same information until
congestion_wait callers can be removed.

Again, I wasn't trying to offer a correct implementation, only illustrating
that it's perfectly possible to throttle based on reclaim making progress
instead of "congestion".

> > +
> > +	/*
> > +	 * Should probably check watermark of suitable zones here
> > +	 * in case this is spuriously called
> > +	 */
> 
> Ditto.
> 
> These hacks really make me think that an external "wait for memory
> reclaim to make progress before retrying allocation" behaviour is
> the wrong way to tackle this. It's always been a hack because
> open-coded retry loops had to be implemented everywhere for
> never-fail allocation semantics.
> 
> Neil has the right idea by replacing such fail-never back-offs with
> actual allocation attempts that encapsulate waiting for reclaim to
> make progress. This needs to be a formally supported function of
> memory allocation, and then these backoffs can be properly
> integrated into the memory reclaim retry mechanism instead of being
> poorly grafted onto the side...
> 

I'm not necessarily opposed to this. What I'm saying is that doing the
conversion now *MIGHT* mean an increase in live-lock-like bugs because
with the current implementation, the callers may not sleep/throttle in
the same way the crappy "loop around congestion_wait" implementations did.

> Whether that be __GFP_NOFAIL or GFP_RETRY_FOREVER that doesn't have
> the "dip into reserves" behaviour of __GFP_NOFAIL (which we clearly
> don't need because open coded retry loops have clearly work well
> enough for production systems for many years), I don't really care.
> 

I suspected this was true and that it might be appropriate for __GFP_NOFAIL
to obey normal watermarks unless __GFP_HIGH is also specified if it's
absolutely necessary but I'm not sure because I haven't put enough thought
into it.

> But I think the memory allocation subsystem needs to move beyond
> "ahhhh, never-fail is too hard!!!!" and take steps to integrate this
> behaviour properly so that it can be made to work a whole lot better
> than it currently does....
> 

Again, not opposed. It's simply a heads-up that converting now may cause
problems that manifest as livelock-like bugs unless, at minimum, internal
reclaim bases throttling on some reclaim making progress instead of
congestion_wait. Given my current load, I can't promise I'd find the time
to follow through with converting the hack into a proper implementation
but someone reading linux-mm might. Either way, I felt it was necessary
to at least warn about the hazards.

-- 
Mel Gorman
SUSE Labs
