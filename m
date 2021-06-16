Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EAE3A90CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 06:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFPE4Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 00:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhFPE4X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 00:56:23 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6046DC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 21:54:18 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id 93so902169qtc.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 21:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g1CVGDhFH6X19kFVFfZho2czxMR+p0zaz3fGNrtl5z0=;
        b=cfg3QnT4SSoypMlLZNK2UipeJL32NDmDebrruFKB+q4EeVoCJD19SW386Ig6CLmBZe
         7U5fEFw0/1rb1Y83WQKaQyD28XGjDI2tolf5aEiP0MqALtUOdCDMfnCZ20BWaRrnnIi0
         XFqbbvAW3tyT3nLTDk0e0qRgmqcWX9H+hh6BI4UNuggHjoglfZyqv4p5V6CI0S05ZAII
         ENJLrO2SzXHrwJwZt29/l8EsLabRwdmTOv9ZZtnRR4RkB3/4Y+et3WdYbtIpdM7SNcha
         W9i5g2QrTMnbJfWmP3oBdSybiak6TVKnVZ9JuihwncdpVvicU0wEELGQdSwvIaSjf6Kq
         ZmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g1CVGDhFH6X19kFVFfZho2czxMR+p0zaz3fGNrtl5z0=;
        b=ek1VBX0XILkVMBd/bt75UVKNtSZv2FfWUDmLFZB1j9LKPlhDeyaN8xo1dD3lYnzpX4
         ibR8PoIbYJtr3ifBZI0u0eNnDBZQsATviIauKO/e/8VpPaDaT/HeVdOPOGZiTdcrcxsz
         5XFPgBNrg9uTjoY2OpSKX/5IafiuSPMCdQ7T6yCs2qKJGaJlMt1wQ/0lzCu7jzi4clYN
         cDlMknj255ImzqYhVZ6MAeJaHLyvY6aD0Mx/GysJ/CmAiAqkuR/xMiS85b0V3c6sZCa6
         NiCIdoI+MO64i1OIKh3Po1fjFY1FP8Yl52i2ND4CBQq0qtn/tWvuZvm6yCZO2baxv0fx
         p8AA==
X-Gm-Message-State: AOAM531BJB6LGKct4bodX4Ydsq7hVHMYuey7yrgCN4rwevXaEhAGYqe/
        gblsvd6Cbk3fjewCxobDvoGGhQ==
X-Google-Smtp-Source: ABdhPJwN5tXXXU5NpLnlxmnv7JoFwgd4ki2m7/1s0zmlWkPpFZZe1Ybfv/Mbt2qd5AWo3j/xdEJSgw==
X-Received: by 2002:ac8:6711:: with SMTP id e17mr3235887qtp.168.1623819257455;
        Tue, 15 Jun 2021 21:54:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4c0b])
        by smtp.gmail.com with ESMTPSA id z136sm901203qkb.34.2021.06.15.21.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 21:54:16 -0700 (PDT)
Date:   Wed, 16 Jun 2021 00:54:15 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/4] vfs: keep inodes with page cache off the inode
 shrinker LRU
Message-ID: <YMmD9xhBm9wGqYhf@cmpxchg.org>
References: <20210614211904.14420-1-hannes@cmpxchg.org>
 <20210614211904.14420-4-hannes@cmpxchg.org>
 <20210615062640.GD2419729@dread.disaster.area>
 <YMj2YbqJvVh1busC@cmpxchg.org>
 <20210616012008.GE2419729@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616012008.GE2419729@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 16, 2021 at 11:20:08AM +1000, Dave Chinner wrote:
> On Tue, Jun 15, 2021 at 02:50:09PM -0400, Johannes Weiner wrote:
> > On Tue, Jun 15, 2021 at 04:26:40PM +1000, Dave Chinner wrote:
> > > On Mon, Jun 14, 2021 at 05:19:04PM -0400, Johannes Weiner wrote:
> > > > @@ -1123,6 +1125,9 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
> > > >  			shadow = workingset_eviction(page, target_memcg);
> > > >  		__delete_from_page_cache(page, shadow);
> > > >  		xa_unlock_irq(&mapping->i_pages);
> > > > +		if (mapping_shrinkable(mapping))
> > > > +			inode_add_lru(mapping->host);
> > > > +		spin_unlock(&mapping->host->i_lock);
> > > >  
> > > 
> > > No. Inode locks have absolutely no place serialising core vmscan
> > > algorithms.
> > 
> > What if, and hear me out on this one, core vmscan algorithms change
> > the state of the inode?
> 
> Then the core vmscan algorithm has a layering violation.

You're just playing a word game here.

If we want the inode reclaimability to be dependent on the state of
the page cache, then reclaim and truncation change the state of the
inode. It's really that simple.

We can recognize that fact in the code, or we can be obtuse about it.

> > The alternative to propagating this change from where it occurs is
> > simply that the outer layer now has to do stupid things to infer it -
> > essentially needing to busy poll. See below.
> > 
> > > Really, all this complexity because:
> > > 
> > > | The issue is mostly that shrinker pools attract pressure based on
> > > | their size, and when objects get skipped the shrinkers remember this
> > > | as deferred reclaim work.
> > > 
> > > And so you want inodes with reclaimable mappings to avoid being
> > > considered deferred work for the inode shrinker. That's what is
> > > occuring because we are currently returning LRU_RETRY to them, or
> > > would also happen if we returned LRU_SKIP or LRU_ROTATE just to
> > > ignore them.
> > > 
> > > However, it's trivial to change inode_lru_isolate() to do something
> > > like:
> > > 
> > > 	if (inode_has_buffers(inode) || inode->i_data.nrpages) {
> > > 		if (!IS_ENABLED(CONFIG_HIGHMEM)) {
> > > 			spin_unlock(&inode->i_lock);
> > > 			return LRU_ROTATE_NODEFER;
> > > 		}
> > > 		.....
> > > 	}
> > 
> > Yeah, that's busy polling. It's simple and inefficient.
> 
> That's how the dentry and inode cache shrinkers work - the LRUs are
> lazily maintained to keep LRU list lock contention out of the fast
> paths. The trade off for that is some level of inefficiency in
> managing inodes and dentries that shouldn't be or aren't ideally
> placed on the LRU. IOWs, we push the decision on whether inodes
> should be on the LRU or whether they should be reclaimed into the
> shrinker scan logic, not the fast path lookup logic where inodes are
> referenced or dirtied or cleaned.

That's just not true.

The way the inode shrinker works is that all indefinite pins that make
an inode unreclaimable for reasons other than its age are kept off the
LRU. Yes, we're lazy about removing them if pins are established after
the object is already queued. But we don't queue objects with that
state, and sites that clear this pin update the LRU.

That's true when the inode is pinned by a refcount or by the dirty
state. I'm proposing to handle the page cache state in exactly the
same fashion.

It's you who is arguing we should deal with those particular pins
differently than how we deal with all others, and I find it difficult
to follow your reasoning for that.

> IOWs, the biggest problem with increasing the rate at which we move
> inodes on and off the LRU list is lock contention. It's already a
> major problem and hence the return values from the LRU code to say
> whether the inode was added/removed or not to the LRU.
> 
> By increasing the number inode LRU addition sites by an order of
> magnitude throughout the mm/ subsystem, we greatly increase the
> difficulty of managing the inode LRU. We no longer have a nice,
> predictable set of locations where the inodes are added to and
> removed from the LRUs, and so now we've got a huge increase in the
> number of different, unpredictable vectors that can lead to lock
> contention on the LRUs...

Rotating the same unreclaimable inodes over and over is BETTER for
lock/LRU contention than adding them once at the end of their life?

> > We can rotate the busy inodes to the end of the list when we see them,
> > but all *new* inodes get placed ahead of them and push them out the
> > back.  If you have a large set of populated inodes paired with an
> > ongoing stream of metadata operations creating one-off inodes, you end
> > up continuously shoveling through hundreds of thousand of the same
> > pinned inodes to get to the few reclaimable ones mixed in.
> 
> IDGI.
> 
> What has a huge stream of metadata dirty inodes going through the
> cache have to do with deciding when to reclaim a data inode with a
> non-zero page cache residency?

It's simply about the work it needs to perform in order to find
reclaimable nodes in the presence of a large number of permanently
unreclaimable ones.

> I mean, this whole patchset is intended to prevent the inode from
> being reclaimed until the page cache on the inode has been reclaimed
> by memory pressure, so what does it matter how often those data inodes
> are rotated through the LRU? They can't be reclaimed until the page
> cache frees the pages, so the presence or absence of other inodes on
> the list is entirely irrelevant.
> 
> For any workload that invloves streaming inodes through the inode
> cache, the inode shrinker is going to be scanning through the
> hundreds of thousands of inodes anyway. Once put in that context,
> the cost rotating on data inodes with page cache attached is going
> to be noise, regardless of whether it is inefficient or not.

How do you figure that?

If you have 1,000 inodes pinned by page cache, and then start
streaming, you have to rotate 1,000 inodes before you get to the first
reclaimable one. It depends on memory pressure how many streaming
inodes you were able to add before the inode pool is capped and
reclaim runs again. At least in theory, the worst case is having to
rotate every unreclaimable inode for every one you can reclaim.

Whether this is likely to happen in practice or not, I don't
understand why we should special case page cache pins from existing
pins and build a pathological cornercase into the shrinker behavior.

> And, really, if the inode cache has so many unreferenced inode with
> attached page cache attached to them that the size of the inode
> cache becomes an issue, then the page reclaim algorithms are totally
> failing to reclaim page cache quickly enough to maintian the desired
> system cache balance. i.e. We are supposed to be keeping a balance
> between the inode cache size and the page cache size, and if we
> can't keep that balance because inode reclaim can't make progress
> because page cache pinning inodes, then we have a page reclaim
> problem, not an inode reclaim problem.

We may never reclaim that page cache if we have no reason to do so.

Say you have a git tree fully cached, and now somebody runs grep on a
large subdirectory with lots of files. We don't kick out the git tree
cache for stuff that is only touched once - reclaim goes directly for
the cache coming off the grep. But the shrinker needs to first rotate
through the entire git tree to get to the grep inodes. Hopefully by
the time it gets to them, their page cache will have gone. If not,
we'll rotate them and go through the entire git tree inodes again.

What's the point in doing this when we know the exact point in time
where it makes sense to start scanning the git tree inodes?

Numbers talk, I get it, and I'll try to get some benchmarking done
next week. But do you really need numbers to understand how poorly
this algorithm performs?

The strongest argument you can make then is that the algorithm simply
never really matters. And that seems like a stretch.

> THere's also the problem of lack of visibility. RIght now, we know
> that all the unreferenced VFS inodes in the system are on the LRU
> and that they are generally all accounted for either by active
> references or walking the LRU. This change now creates a situation
> when inodes with page cache attached are not actively references but
> now also can't be found by walking the LRU list. i.e. we have inodes
> that are unaccounted for by various statistics. How do we know how
> many inodes are pinned by the page cache? We can't see them via
> inode shrinker count tracing, we can't see them via looking up all
> the active references to the inode (because there are none), and so
> on.

Can you elaborate on which statistics you are referring to?

I can see nr_inodes and nr_unused, but I don't see the delta being
broken down further into open and dirty - and if dirty whether it's
the inode that's dirty, or the page cache. So it appears we already
don't know how many inodes can be pinned today by the page cache.

From what I can see there seems to be a general lack of insight into
the state of the icache that may need a more general solution that is
outside the scope of my patch here.

> Essentially we have nothing tracking these inodes at all at this
> point, so if we ever miss a call in the mm/ to add the inode to the
> LRU that you've sprinked throughout the mm/ code, we essentially
> leak the inode. It's hard enough tracking down bugs that result in
> "VFS: busy inodes after unmount" errors without actively adding
> infrastructure that intentionally makes inodes disappear from
> tracking.

Well yes, but that's no different than missing an iput(). And there is
a lot more of those than there are page cache deletion sides.

> > Meanwhile, the MM is standing by, going "You know, I could tell you
> > exactly when those actually become reclaimable..."
> > 
> > If you think this is the more elegant implementation, simply because
> > it follows a made-up information hierarchy that doesn't actually map
> > to the real world, then I don't know what to tell you.
> > 
> > We take i_count and dirty inodes off the list because it's silly to
> > rotate them over and over, when we could just re-add them the moment
> > the pin goes away. It's not a stretch to do the same for populated
> > inodes, which usually make up a much bigger share of the pool.
> 
> We don't take dirty inodes off the LRU. We only take referenced
> inodes off the LRU in the shrinker isolation function because we can
> guarantee that when the inode reference is dropped via iput() the
> inode will be added back to the LRU if it needs to be placed there.
> 
> This is all all internal to the inode cache functionality
> (fs/inode.c) and that's the way it should remain because anything
> else will rapidly become unmaintainable.

You don't seem to understand how this code actually works - this is
patently false. I think this conversation could be more productive if
you spent some time catching up on that first.
