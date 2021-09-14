Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903F140BC62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 01:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbhINX46 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 19:56:58 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:52016 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233774AbhINX46 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 19:56:58 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id E17CE881B60;
        Wed, 15 Sep 2021 09:55:36 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mQIH1-00CYei-40; Wed, 15 Sep 2021 09:55:35 +1000
Date:   Wed, 15 Sep 2021 09:55:35 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Mel Gorman <mgorman@suse.com>
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
Message-ID: <20210914235535.GL2361455@dread.disaster.area>
References: <163157808321.13293.486682642188075090.stgit@noble.brown>
 <163157838437.13293.14244628630141187199.stgit@noble.brown>
 <20210914163432.GR3828@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914163432.GR3828@suse.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=7-415B0cAAAA:8
        a=WvNPZvkCUhCNbaOxYEgA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 14, 2021 at 05:34:32PM +0100, Mel Gorman wrote:
> On Tue, Sep 14, 2021 at 10:13:04AM +1000, NeilBrown wrote:
> > Indefinite loops waiting for memory allocation are discouraged by
> > documentation in gfp.h which says the use of __GFP_NOFAIL that it
> > 
> >  is definitely preferable to use the flag rather than opencode endless
> >  loop around allocator.
> > 
> > Such loops that use congestion_wait() are particularly unwise as
> > congestion_wait() is indistinguishable from
> > schedule_timeout_uninterruptible() in practice - and should be
> > deprecated.
> > 
> > So this patch changes the two loops in ext4_ext_truncate() to use
> > __GFP_NOFAIL instead of looping.
> > 
> > As the allocation is multiple layers deeper in the call stack, this
> > requires passing the EXT4_EX_NOFAIL flag down and handling it in various
> > places.
> > 
> > Of particular interest is the ext4_journal_start family of calls which
> > can now have EXT4_EX_NOFAIL 'or'ed in to the 'type'.  This could be seen
> > as a blurring of types.  However 'type' is 8 bits, and EXT4_EX_NOFAIL is
> > a high bit, so it is safe in practice.
> > 
> > jbd2__journal_start() is enhanced so that the gfp_t flags passed are
> > used for *all* allocations.
> > 
> > Signed-off-by: NeilBrown <neilb@suse.de>
> 
> I'm not a fan. GFP_NOFAIL allows access to emergency reserves increasing
> the risk of a livelock if memory is completely depleted where as some
> callers can afford to wait.

Undocumented behaviour, never mentioned or communicated to users in
any __GFP_NOFAIL discussion I've taken part in until now.

How is it different to, say, GFP_ATOMIC? i.e. Does GFP_NOFAIL
actually imply GFP_ATOMIC, or is there some other undocumented
behaviour going on here?

We've already go ~80 __GFP_NOFAIL allocation contexts in fs/ and the
vast majority of the are GFP_KERNEL | __GFP_NOFAIL or GFP_NOFS |
__GFP_NOFAIL, so some clarification on what this actually means
would be really good...

> The key event should be reclaim making progress.

Yup, that's what we need, but I don't see why it needs to be exposed
outside the allocation code at all.

> The hack below is
> intended to vaguely demonstrate how blocking can be based on reclaim
> making progress instead of "congestion" but has not even been booted. A
> more complete overhaul may involve introducing
> reclaim_congestion_wait_nodemask(gfp_t gfp_mask, long timeout, nodemask_t *nodemask)
> and
> reclaim_congestion_wait_nodemask(gfp_t gfp_mask, long timeout)

I think that's racy. There's no guarantee that the node we are
currently running on matches the cpu/node id that we failed to
allocate from. Pre-emptible kernels and all that. IOWs, I think
needs to be completely internal to the reclaim infrastructure and
based on the current context we are trying to reclaim from.

That way "GFP_RETRY_FOREVER" allocation contexts don't have to jump
through an ever changing tangle of hoops to make basic "never-fail"
allocation semantics behave correctly.

> and converting congestion_wait and wait_iff_congestion to calling
> reclaim_congestion_wait_nodemask which waits on the first usable node
> and then audit every single congestion_wait() user to see which API
> they should call. Further work would be to establish whether the page allocator should
> call reclaim_congestion_wait_nodemask() if direct reclaim is not making
> progress or whether that should be in vmscan.c. Conceivably, GFP_NOFAIL
> could then soften its access to emergency reserves but I haven't given
> it much thought.
> 
> Yes it's significant work, but it would be a better than letting
> __GFP_NOFAIL propagate further and kicking us down the road.

Unfortunately, that seems to ignore the fact that we still need
never-fail allocation semantics for stable system performance.  Like
it or not the requirements for __GFP_NOFAIL (and "retry forever"
equivalent semantics) or open coded endless retry loops
are *never* going away.

IOWs, I'd suggest that we should think about how to formally
support "never-fail" allocation semantics in both the API and the
implementation in such a way that we don't end up with this
__GFP_NOFAIL catch-22 ever again. Having the memory reclaim code
wait on forwards progress instead of congestion as you propose here
would be a core part of providing "never-fail" allocations...

> This hack is terrible, it's not the right way to do it, it's just to
> illustrate the idea of "waiting on memory should be based on reclaim
> making progress and not the state of storage" is not impossible.

I've been saying that is how reclaim should work for years. :/

It was LFSMM 2013 or 2014 that I was advocating for memory reclaim
to move to IO-less reclaim throttling based on the rate at which
free pages are returned to the freelists similar to the way IO-less
dirty page throttling is based on the rate dirty pages are cleaned.

Relying on IO interactions (submitting IO or waiting for completion)
for high level page state management has always been a bad way to
throttle demand because it only provides indirect control and has
poor feedback indication.

It's also a good way to remove the dependency on direct reclaim -
just sleep instead of duplicating the work that kswapd should
already be doing in the background to reclaim pages...

> --8<--
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 5c0318509f9e..5ed81c5746ec 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -832,6 +832,7 @@ typedef struct pglist_data {
>  	unsigned long node_spanned_pages; /* total size of physical page
>  					     range, including holes */
>  	int node_id;
> +	wait_queue_head_t reclaim_wait;
>  	wait_queue_head_t kswapd_wait;
>  	wait_queue_head_t pfmemalloc_wait;
>  	struct task_struct *kswapd;	/* Protected by
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 6122c78ce914..21a9cd693d12 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/writeback.h>
>  #include <linux/device.h>
> +#include <linux/swap.h>
>  #include <trace/events/writeback.h>
>  
>  struct backing_dev_info noop_backing_dev_info;
> @@ -1013,25 +1014,41 @@ void set_bdi_congested(struct backing_dev_info *bdi, int sync)
>  EXPORT_SYMBOL(set_bdi_congested);
>  
>  /**
> - * congestion_wait - wait for a backing_dev to become uncongested
> - * @sync: SYNC or ASYNC IO
> - * @timeout: timeout in jiffies
> + * congestion_wait - the docs are now worthless but avoiding a rename
>   *
> - * Waits for up to @timeout jiffies for a backing_dev (any backing_dev) to exit
> - * write congestion.  If no backing_devs are congested then just wait for the
> - * next write to be completed.
> + * New thing -- wait for a timeout or reclaim to make progress
>   */
>  long congestion_wait(int sync, long timeout)
>  {
> +	pg_data_t *pgdat;
>  	long ret;
>  	unsigned long start = jiffies;
>  	DEFINE_WAIT(wait);
> -	wait_queue_head_t *wqh = &congestion_wqh[sync];
> +	wait_queue_head_t *wqh;
>  
> -	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
> -	ret = io_schedule_timeout(timeout);
> +	/* Never let kswapd sleep on itself */
> +	if (current_is_kswapd())
> +		goto trace;

I think this breaks the kswapd 100ms immediate reclaim backoff in
shrink_node().

> +
> +	/*
> +	 * Dangerous, local memory may be forbidden by cpuset or policies,
> +	 * use first eligible zone in zonelists node instead
> +	 */
> +	preempt_disable();
> +	pgdat = NODE_DATA(smp_processor_id());
> +	preempt_enable();
> +	wqh = &pgdat->reclaim_wait;

This goes away if it is kept internal and is passed the reclaim
pgdat context we just failed to reclaim pages from.

> +
> +	/*
> +	 * Should probably check watermark of suitable zones here
> +	 * in case this is spuriously called
> +	 */

Ditto.

These hacks really make me think that an external "wait for memory
reclaim to make progress before retrying allocation" behaviour is
the wrong way to tackle this. It's always been a hack because
open-coded retry loops had to be implemented everywhere for
never-fail allocation semantics.

Neil has the right idea by replacing such fail-never back-offs with
actual allocation attempts that encapsulate waiting for reclaim to
make progress. This needs to be a formally supported function of
memory allocation, and then these backoffs can be properly
integrated into the memory reclaim retry mechanism instead of being
poorly grafted onto the side...

Whether that be __GFP_NOFAIL or GFP_RETRY_FOREVER that doesn't have
the "dip into reserves" behaviour of __GFP_NOFAIL (which we clearly
don't need because open coded retry loops have clearly work well
enough for production systems for many years), I don't really care.

But I think the memory allocation subsystem needs to move beyond
"ahhhh, never-fail is too hard!!!!" and take steps to integrate this
behaviour properly so that it can be made to work a whole lot better
than it currently does....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
