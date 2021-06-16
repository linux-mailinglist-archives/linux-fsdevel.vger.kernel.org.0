Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E798F3A8E38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 03:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhFPBWT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 21:22:19 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:52221 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230265AbhFPBWT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 21:22:19 -0400
Received: from dread.disaster.area (pa49-179-138-183.pa.nsw.optusnet.com.au [49.179.138.183])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id C301580B4AD;
        Wed, 16 Jun 2021 11:20:10 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ltKDw-00DFDR-Vq; Wed, 16 Jun 2021 11:20:09 +1000
Date:   Wed, 16 Jun 2021 11:20:08 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/4] vfs: keep inodes with page cache off the inode
 shrinker LRU
Message-ID: <20210616012008.GE2419729@dread.disaster.area>
References: <20210614211904.14420-1-hannes@cmpxchg.org>
 <20210614211904.14420-4-hannes@cmpxchg.org>
 <20210615062640.GD2419729@dread.disaster.area>
 <YMj2YbqJvVh1busC@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMj2YbqJvVh1busC@cmpxchg.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=MnllW2CieawZLw/OcHE/Ng==:117 a=MnllW2CieawZLw/OcHE/Ng==:17
        a=kj9zAlcOel0A:10 a=r6YtysWOX24A:10 a=7-415B0cAAAA:8
        a=Lo8aqW6Lf7eoI5Hr-CAA:9 a=rTCC6jnXJJvoturn:21 a=ltynGAQbLn8o59Jy:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 02:50:09PM -0400, Johannes Weiner wrote:
> On Tue, Jun 15, 2021 at 04:26:40PM +1000, Dave Chinner wrote:
> > On Mon, Jun 14, 2021 at 05:19:04PM -0400, Johannes Weiner wrote:
> > > Historically (pre-2.5), the inode shrinker used to reclaim only empty
> > > inodes and skip over those that still contained page cache. This
> > > caused problems on highmem hosts: struct inode could put fill lowmem
> > > zones before the cache was getting reclaimed in the highmem zones.
> > > 
> > > To address this, the inode shrinker started to strip page cache to
> > > facilitate reclaiming lowmem. However, this comes with its own set of
> > > problems: the shrinkers may drop actively used page cache just because
> > > the inodes are not currently open or dirty - think working with a
> > > large git tree. It further doesn't respect cgroup memory protection
> > > settings and can cause priority inversions between containers.
> > > 
> > > Nowadays, the page cache also holds non-resident info for evicted
> > > cache pages in order to detect refaults. We've come to rely heavily on
> > > this data inside reclaim for protecting the cache workingset and
> > > driving swap behavior. We also use it to quantify and report workload
> > > health through psi. The latter in turn is used for fleet health
> > > monitoring, as well as driving automated memory sizing of workloads
> > > and containers, proactive reclaim and memory offloading schemes.
> > > 
> > > The consequences of dropping page cache prematurely is that we're
> > > seeing subtle and not-so-subtle failures in all of the above-mentioned
> > > scenarios, with the workload generally entering unexpected thrashing
> > > states while losing the ability to reliably detect it.
> > > 
> > > To fix this on non-highmem systems at least, going back to rotating
> > > inodes on the LRU isn't feasible. We've tried (commit a76cf1a474d7
> > > ("mm: don't reclaim inodes with many attached pages")) and failed
> > > (commit 69056ee6a8a3 ("Revert "mm: don't reclaim inodes with many
> > > attached pages"")). The issue is mostly that shrinker pools attract
> > > pressure based on their size, and when objects get skipped the
> > > shrinkers remember this as deferred reclaim work. This accumulates
> > > excessive pressure on the remaining inodes, and we can quickly eat
> > > into heavily used ones, or dirty ones that require IO to reclaim, when
> > > there potentially is plenty of cold, clean cache around still.
> > > 
> > > Instead, this patch keeps populated inodes off the inode LRU in the
> > > first place - just like an open file or dirty state would. An
> > > otherwise clean and unused inode then gets queued when the last cache
> > > entry disappears. This solves the problem without reintroducing the
> > > reclaim issues, and generally is a bit more scalable than having to
> > > wade through potentially hundreds of thousands of busy inodes.
> > > 
> > > Locking is a bit tricky because the locks protecting the inode state
> > > (i_lock) and the inode LRU (lru_list.lock) don't nest inside the
> > > irq-safe page cache lock (i_pages.xa_lock). Page cache deletions are
> > > serialized through i_lock, taken before the i_pages lock, to make sure
> > > depopulated inodes are queued reliably. Additions may race with
> > > deletions, but we'll check again in the shrinker. If additions race
> > > with the shrinker itself, we're protected by the i_lock: if
> > > find_inode() or iput() win, the shrinker will bail on the elevated
> > > i_count or I_REFERENCED; if the shrinker wins and goes ahead with the
> > > inode, it will set I_FREEING and inhibit further igets(), which will
> > > cause the other side to create a new instance of the inode instead.
> > 
> > This makes an awful mess of the inode locking and, to me, is a
> > serious layering violation....
> 
> The direction through the layers is no different than set_page_dirty()
> calling mark_inode_dirty() from under the page lock.
> 
> This is simply where the state change of the inode originates. What's
> the benefit of having the code pretend otherwise?
> 
> > > index e89df447fae3..c9956fac640e 100644
> > > --- a/include/linux/pagemap.h
> > > +++ b/include/linux/pagemap.h
> > > @@ -23,6 +23,56 @@ static inline bool mapping_empty(struct address_space *mapping)
> > >  	return xa_empty(&mapping->i_pages);
> > >  }
> > >  
> > > +/*
> > > + * mapping_shrinkable - test if page cache state allows inode reclaim
> > > + * @mapping: the page cache mapping
> > > + *
> > > + * This checks the mapping's cache state for the pupose of inode
> > > + * reclaim and LRU management.
> > > + *
> > > + * The caller is expected to hold the i_lock, but is not required to
> > > + * hold the i_pages lock, which usually protects cache state. That's
> > > + * because the i_lock and the list_lru lock that protect the inode and
> > > + * its LRU state don't nest inside the irq-safe i_pages lock.
> > > + *
> > > + * Cache deletions are performed under the i_lock, which ensures that
> > > + * when an inode goes empty, it will reliably get queued on the LRU.
> > > + *
> > > + * Cache additions do not acquire the i_lock and may race with this
> > > + * check, in which case we'll report the inode as shrinkable when it
> > > + * has cache pages. This is okay: the shrinker also checks the
> > > + * refcount and the referenced bit, which will be elevated or set in
> > > + * the process of adding new cache pages to an inode.
> > > + */
> > 
> > .... because you're expanding the inode->i_lock to now cover the
> > page cache additions and removal and that massively increases the
> > scope of the i_lock. The ilock is for internal inode serialisation
> > purposes, not serialisation with external subsystems that inodes
> > interact with like mappings.
> 
> I'm expanding it to cover another state change in the inode that
> happens to originate in the mapping.
> 
> Yes, it would have been slightly easier if the inode locks nested
> under the page cache locks, like they do for dirty state. This way we
> could have updated the inode from the innermost context where the
> mapping state changes, which would have been a bit more compact.
> 
> Unfortunately, the i_pages lock is irq-safe - to deal with writeback
> completion changing cache state from IRQ context. We'd have to make
> the i_lock and the list_lru lock irq-safe as well, and I'm not sure
> that is more desirable than ordering the locks the other way.
> 
> Doing it this way means annotating a few more deletion entry points.
> But there are a limited number of ways for pages to leave the page
> cache - reclaim and truncation - so it's within reason.
> 
> The i_lock isn't expanded to cover additions, if you take a look at
> the code. That would have been a much larger surface area indeed.
> 
> > > +static inline bool mapping_shrinkable(struct address_space *mapping)
> > > +{
> > > +	void *head;
> > > +
> > > +	/*
> > > +	 * On highmem systems, there could be lowmem pressure from the
> > > +	 * inodes before there is highmem pressure from the page
> > > +	 * cache. Make inodes shrinkable regardless of cache state.
> > > +	 */
> > > +	if (IS_ENABLED(CONFIG_HIGHMEM))
> > > +		return true;
> > > +
> > > +	/* Cache completely empty? Shrink away. */
> > > +	head = rcu_access_pointer(mapping->i_pages.xa_head);
> > > +	if (!head)
> > > +		return true;
> > > +
> > > +	/*
> > > +	 * The xarray stores single offset-0 entries directly in the
> > > +	 * head pointer, which allows non-resident page cache entries
> > > +	 * to escape the shadow shrinker's list of xarray nodes. The
> > > +	 * inode shrinker needs to pick them up under memory pressure.
> > > +	 */
> > > +	if (!xa_is_node(head) && xa_is_value(head))
> > > +		return true;
> > > +
> > > +	return false;
> > > +}
> > 
> > It just occurred to me: mapping_shrinkable() == available for
> > shrinking, not "mapping can be shrunk by having pages freed from
> > it".
> > 
> > If this lives, it really needs a better name and API - this isn't
> > applying a check of whether the mapping can be shrunk, it indicates
> > whether the inode hosting the mapping is considered freeable or not.
> 
> Right, it indicates whether the state of the mapping translates to the
> inode being eligigble for shrinker reclaim or not.
> 
> I've used mapping_populated() in a previous version, but this function
> here captures additional reclaim policy (highmem setups e.g.), so it's
> not a suitable name for it.
> 
> This is the best I could come up with, so I'm open to suggestions.
> 
> > > @@ -260,9 +260,13 @@ void delete_from_page_cache(struct page *page)
> > >  	struct address_space *mapping = page_mapping(page);
> > >  
> > >  	BUG_ON(!PageLocked(page));
> > > +	spin_lock(&mapping->host->i_lock);
> > >  	xa_lock_irq(&mapping->i_pages);
> > >  	__delete_from_page_cache(page, NULL);
> > >  	xa_unlock_irq(&mapping->i_pages);
> > > +	if (mapping_shrinkable(mapping))
> > > +		inode_add_lru(mapping->host);
> > > +	spin_unlock(&mapping->host->i_lock);
> > >  
> > 
> > This, to me is an example of the layering problesm here. No mapping
> > specific function should be using locks that belong to the mapping
> > host for internal mapping serialisation.
> > 
> > Especially considering that inode_add_lru() is defined in
> > fs/internal.h - nothing outside the core fs code should really be
> > using inode_add_lru(), just lik enothing outside of fs code should
> > be using the inode->i_lock for anything.
> 
> Again, it's no different than dirty state propagation. That's simply
> the direction in which this information flows through the stack.
> 
> We can encapsulate it all into wrapper/API functions if you prefer,
> but it doesn't really change the direction in which the information
> travels, nor the lock scoping.
> 
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index cc5d7cd75935..6dd5ef8a11bc 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -1055,6 +1055,8 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
> > >  	BUG_ON(!PageLocked(page));
> > >  	BUG_ON(mapping != page_mapping(page));
> > >  
> > > +	if (!PageSwapCache(page))
> > > +		spin_lock(&mapping->host->i_lock);
> > >  	xa_lock_irq(&mapping->i_pages);
> > >  	/*
> > >  	 * The non racy check for a busy page.
> > > @@ -1123,6 +1125,9 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
> > >  			shadow = workingset_eviction(page, target_memcg);
> > >  		__delete_from_page_cache(page, shadow);
> > >  		xa_unlock_irq(&mapping->i_pages);
> > > +		if (mapping_shrinkable(mapping))
> > > +			inode_add_lru(mapping->host);
> > > +		spin_unlock(&mapping->host->i_lock);
> > >  
> > 
> > No. Inode locks have absolutely no place serialising core vmscan
> > algorithms.
> 
> What if, and hear me out on this one, core vmscan algorithms change
> the state of the inode?

Then the core vmscan algorithm has a layering violation.

vmscan operates on pages and address spaces attached to pages. It
should not be peering any deeper into the mapping than what is
contained in the mapping. If it needs to go any deeper (i.e. needs
host level operations) then that is what the address space
operations are for.  i.e. if emptying a mapping needs action to be
taken at the inode level, then it should call out via operation so
that the filesysetm can take appropriate action.

We have strong abstractions and layering between different
subsystems for good reason. If you can't make what you need work
without violating those abstractions, you need to have a compelling
reason to do so. You haven't given us one yet.

> The alternative to propagating this change from where it occurs is
> simply that the outer layer now has to do stupid things to infer it -
> essentially needing to busy poll. See below.
> 
> > Really, all this complexity because:
> > 
> > | The issue is mostly that shrinker pools attract pressure based on
> > | their size, and when objects get skipped the shrinkers remember this
> > | as deferred reclaim work.
> > 
> > And so you want inodes with reclaimable mappings to avoid being
> > considered deferred work for the inode shrinker. That's what is
> > occuring because we are currently returning LRU_RETRY to them, or
> > would also happen if we returned LRU_SKIP or LRU_ROTATE just to
> > ignore them.
> > 
> > However, it's trivial to change inode_lru_isolate() to do something
> > like:
> > 
> > 	if (inode_has_buffers(inode) || inode->i_data.nrpages) {
> > 		if (!IS_ENABLED(CONFIG_HIGHMEM)) {
> > 			spin_unlock(&inode->i_lock);
> > 			return LRU_ROTATE_NODEFER;
> > 		}
> > 		.....
> > 	}
> 
> Yeah, that's busy polling. It's simple and inefficient.

That's how the dentry and inode cache shrinkers work - the LRUs are
lazily maintained to keep LRU list lock contention out of the fast
paths. The trade off for that is some level of inefficiency in
managing inodes and dentries that shouldn't be or aren't ideally
placed on the LRU. IOWs, we push the decision on whether inodes
should be on the LRU or whether they should be reclaimed into the
shrinker scan logic, not the fast path lookup logic where inodes are
referenced or dirtied or cleaned.

IOWs, the biggest problem with increasing the rate at which we move
inodes on and off the LRU list is lock contention. It's already a
major problem and hence the return values from the LRU code to say
whether the inode was added/removed or not to the LRU.

By increasing the number inode LRU addition sites by an order of
magnitude throughout the mm/ subsystem, we greatly increase the
difficulty of managing the inode LRU. We no longer have a nice,
predictable set of locations where the inodes are added to and
removed from the LRUs, and so now we've got a huge increase in the
number of different, unpredictable vectors that can lead to lock
contention on the LRUs...

> We can rotate the busy inodes to the end of the list when we see them,
> but all *new* inodes get placed ahead of them and push them out the
> back.  If you have a large set of populated inodes paired with an
> ongoing stream of metadata operations creating one-off inodes, you end
> up continuously shoveling through hundreds of thousand of the same
> pinned inodes to get to the few reclaimable ones mixed in.

IDGI.

What has a huge stream of metadata dirty inodes going through the
cache have to do with deciding when to reclaim a data inode with a
non-zero page cache residency?

I mean, this whole patchset is intended to prevent the inode from
being reclaimed until the page cache on the inode has been reclaimed
by memory pressure, so what does it matter how often those data inodes
are rotated through the LRU? They can't be reclaimed until the page
cache frees the pages, so the presence or absence of other inodes on
the list is entirely irrelevant.

For any workload that invloves streaming inodes through the inode
cache, the inode shrinker is going to be scanning through the
hundreds of thousands of inodes anyway. Once put in that context,
the cost rotating on data inodes with page cache attached is going
to be noise, regardless of whether it is inefficient or not.

And, really, if the inode cache has so many unreferenced inode with
attached page cache attached to them that the size of the inode
cache becomes an issue, then the page reclaim algorithms are totally
failing to reclaim page cache quickly enough to maintian the desired
system cache balance. i.e. We are supposed to be keeping a balance
between the inode cache size and the page cache size, and if we
can't keep that balance because inode reclaim can't make progress
because page cache pinning inodes, then we have a page reclaim
problem, not an inode reclaim problem.

THere's also the problem of lack of visibility. RIght now, we know
that all the unreferenced VFS inodes in the system are on the LRU
and that they are generally all accounted for either by active
references or walking the LRU. This change now creates a situation
when inodes with page cache attached are not actively references but
now also can't be found by walking the LRU list. i.e. we have inodes
that are unaccounted for by various statistics. How do we know how
many inodes are pinned by the page cache? We can't see them via
inode shrinker count tracing, we can't see them via looking up all
the active references to the inode (because there are none), and so
on.

Essentially we have nothing tracking these inodes at all at this
point, so if we ever miss a call in the mm/ to add the inode to the
LRU that you've sprinked throughout the mm/ code, we essentially
leak the inode. It's hard enough tracking down bugs that result in
"VFS: busy inodes after unmount" errors without actively adding
infrastructure that intentionally makes inodes disappear from
tracking.

> Meanwhile, the MM is standing by, going "You know, I could tell you
> exactly when those actually become reclaimable..."
> 
> If you think this is the more elegant implementation, simply because
> it follows a made-up information hierarchy that doesn't actually map
> to the real world, then I don't know what to tell you.
> 
> We take i_count and dirty inodes off the list because it's silly to
> rotate them over and over, when we could just re-add them the moment
> the pin goes away. It's not a stretch to do the same for populated
> inodes, which usually make up a much bigger share of the pool.

We don't take dirty inodes off the LRU. We only take referenced
inodes off the LRU in the shrinker isolation function because we can
guarantee that when the inode reference is dropped via iput() the
inode will be added back to the LRU if it needs to be placed there.

This is all all internal to the inode cache functionality
(fs/inode.c) and that's the way it should remain because anything
else will rapidly become unmaintainable.

> > And in __list_lru_walk_one() just add:
> > 
> > 		case LRU_ROTATE_NODEFER:
> > 			isolated++;
> > 			/* fallthrough */
> > 		case LRU_ROTATE:
> > 			list_move_tail(item, &l->list);
> > 			break;
> > 
> > And now inodes with active page cache  rotated to the tail of the
> > list and are considered to have had work done on them. Hence they
> > don't add to the work accumulation that the shrinker infrastructure
> > defers, and so will allow the page reclaim to do it's stuff with
> > page reclaim before such inodes will get reclaimed.
> > 
> > That's *much* simpler than your proposed patch and should get you
> > pretty much the same result.
> 
> It solves the deferred work buildup, but it's absurdly inefficient.

So you keep saying. Show us the numbers. Show us that it's so
inefficient that it's completely unworkable. _You_ need to justify
why violating modularity and layering is the only viable solution to
this problem. Given that there is an alternative simple, straight
forward solution to the problem, it's on you to prove it is
insufficient to solve your issues.

I'm sceptical that the complexity is necessary given that in general
workloads, the inode shrinker doesn't even register in kernel
profiles and that the problem being avoided generally isn't even hit
in most workloads. IOWs, I'll take a simple but inefficient solution
for avoiding a corner case behaviour over a solution that is
complex, fragile and full of layering violations any day of the
weeks.

Whether you disagree with me or not is largely irrelevant - nothing
you are saying changes the fact that this patchset makes an
unmanageable mess of internal filesystem locks and APIs and that's
not simply acceptible. There's a simple way to acheive what you
want, so do it that way first, then we can work out if further
improvement is necessary.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
