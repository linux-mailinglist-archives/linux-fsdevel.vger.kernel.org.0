Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0CF3A88D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 20:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhFOSwS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 14:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhFOSwR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:52:17 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5729C06175F
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 11:50:11 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id c18so27983977qkc.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 11:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xzUcgkT3sG8sp6kZgX9h/y1VkhP/02QxOi1ygYmoj1g=;
        b=nn++HBcrR7EE0OLBnpNyBNvA/P9rWvSGoH7dN+smO9lBoiMZ2jZjX9J/WnGDnnaAuR
         D8k4uA3/hSrJ+9xf7Vme7YIa+dh/UuetCqTydMlLhilCv+r+g7Fz50ZGR1MzHUpIVABD
         8vjXNm9EiBnRtbIq8UVkh4W3KaWNJ/51Up/ty0Z32Gd+KTfBCKmKOmG8CFC4cWwn5y1J
         Q59N8bPjJgskQjEqA5dDshwLYinbLjaWPFD622v/3htWZzi14E2fnfT7GHcsZ7cUoN13
         tnDTxXbVjVFKpH4+YxP8Cmm1ZXntz4CUNyiBrOlPBCjdtoRSAaJOii59pS31cjgT3MsW
         yvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xzUcgkT3sG8sp6kZgX9h/y1VkhP/02QxOi1ygYmoj1g=;
        b=AWqk6jMMy2zLzZtV9m/0Yvn0BS9bDvRn7mMWp+Wd2CY2SwhGgdKeyQSAgOM9Ta/4Ol
         iTPcJ9lD9Gh1fRAasEgQtBIrMSaTPdNDVihIxo2IPVss1xarJ5Eg0V6v9DtJils9yz7c
         DAeEb718S42KWl3Kn/f+/9/k/yle4RpXhEXalXkZafZgs18dbH7V/a/9xL7CcxtjeNSd
         FXMzZrRR0S8Nj/Oa+DD4KNbQ6GSjpuFDjfJIJeVRKufoKQZVEwKsci9v1/SsDGIi6nzS
         js6jE+wCX2QinRKGM03dtMuD6oyRx4o5nWWqGz/hwgcnrUEDiGRqt3O9O/WS1XZfBeGR
         mrUw==
X-Gm-Message-State: AOAM533J2hN38j7wcgFAQUhnZU12BQqocjL8L3gOgenViXCLdrLl8qZe
        USBsfY6Lc32Y5jZD4pnWNaCn4g==
X-Google-Smtp-Source: ABdhPJy1oNiwDcOUPIir/7we0kQI88PN9mlyvaxx/nwHNNJKGJhhsVCGp5tzBDQZ2SEvl132Y4dxFQ==
X-Received: by 2002:a37:e02:: with SMTP id 2mr1164399qko.198.1623783010765;
        Tue, 15 Jun 2021 11:50:10 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id h14sm12387530qtp.46.2021.06.15.11.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 11:50:10 -0700 (PDT)
Date:   Tue, 15 Jun 2021 14:50:09 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/4] vfs: keep inodes with page cache off the inode
 shrinker LRU
Message-ID: <YMj2YbqJvVh1busC@cmpxchg.org>
References: <20210614211904.14420-1-hannes@cmpxchg.org>
 <20210614211904.14420-4-hannes@cmpxchg.org>
 <20210615062640.GD2419729@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615062640.GD2419729@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 04:26:40PM +1000, Dave Chinner wrote:
> On Mon, Jun 14, 2021 at 05:19:04PM -0400, Johannes Weiner wrote:
> > Historically (pre-2.5), the inode shrinker used to reclaim only empty
> > inodes and skip over those that still contained page cache. This
> > caused problems on highmem hosts: struct inode could put fill lowmem
> > zones before the cache was getting reclaimed in the highmem zones.
> > 
> > To address this, the inode shrinker started to strip page cache to
> > facilitate reclaiming lowmem. However, this comes with its own set of
> > problems: the shrinkers may drop actively used page cache just because
> > the inodes are not currently open or dirty - think working with a
> > large git tree. It further doesn't respect cgroup memory protection
> > settings and can cause priority inversions between containers.
> > 
> > Nowadays, the page cache also holds non-resident info for evicted
> > cache pages in order to detect refaults. We've come to rely heavily on
> > this data inside reclaim for protecting the cache workingset and
> > driving swap behavior. We also use it to quantify and report workload
> > health through psi. The latter in turn is used for fleet health
> > monitoring, as well as driving automated memory sizing of workloads
> > and containers, proactive reclaim and memory offloading schemes.
> > 
> > The consequences of dropping page cache prematurely is that we're
> > seeing subtle and not-so-subtle failures in all of the above-mentioned
> > scenarios, with the workload generally entering unexpected thrashing
> > states while losing the ability to reliably detect it.
> > 
> > To fix this on non-highmem systems at least, going back to rotating
> > inodes on the LRU isn't feasible. We've tried (commit a76cf1a474d7
> > ("mm: don't reclaim inodes with many attached pages")) and failed
> > (commit 69056ee6a8a3 ("Revert "mm: don't reclaim inodes with many
> > attached pages"")). The issue is mostly that shrinker pools attract
> > pressure based on their size, and when objects get skipped the
> > shrinkers remember this as deferred reclaim work. This accumulates
> > excessive pressure on the remaining inodes, and we can quickly eat
> > into heavily used ones, or dirty ones that require IO to reclaim, when
> > there potentially is plenty of cold, clean cache around still.
> > 
> > Instead, this patch keeps populated inodes off the inode LRU in the
> > first place - just like an open file or dirty state would. An
> > otherwise clean and unused inode then gets queued when the last cache
> > entry disappears. This solves the problem without reintroducing the
> > reclaim issues, and generally is a bit more scalable than having to
> > wade through potentially hundreds of thousands of busy inodes.
> > 
> > Locking is a bit tricky because the locks protecting the inode state
> > (i_lock) and the inode LRU (lru_list.lock) don't nest inside the
> > irq-safe page cache lock (i_pages.xa_lock). Page cache deletions are
> > serialized through i_lock, taken before the i_pages lock, to make sure
> > depopulated inodes are queued reliably. Additions may race with
> > deletions, but we'll check again in the shrinker. If additions race
> > with the shrinker itself, we're protected by the i_lock: if
> > find_inode() or iput() win, the shrinker will bail on the elevated
> > i_count or I_REFERENCED; if the shrinker wins and goes ahead with the
> > inode, it will set I_FREEING and inhibit further igets(), which will
> > cause the other side to create a new instance of the inode instead.
> 
> This makes an awful mess of the inode locking and, to me, is a
> serious layering violation....

The direction through the layers is no different than set_page_dirty()
calling mark_inode_dirty() from under the page lock.

This is simply where the state change of the inode originates. What's
the benefit of having the code pretend otherwise?

> > index e89df447fae3..c9956fac640e 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -23,6 +23,56 @@ static inline bool mapping_empty(struct address_space *mapping)
> >  	return xa_empty(&mapping->i_pages);
> >  }
> >  
> > +/*
> > + * mapping_shrinkable - test if page cache state allows inode reclaim
> > + * @mapping: the page cache mapping
> > + *
> > + * This checks the mapping's cache state for the pupose of inode
> > + * reclaim and LRU management.
> > + *
> > + * The caller is expected to hold the i_lock, but is not required to
> > + * hold the i_pages lock, which usually protects cache state. That's
> > + * because the i_lock and the list_lru lock that protect the inode and
> > + * its LRU state don't nest inside the irq-safe i_pages lock.
> > + *
> > + * Cache deletions are performed under the i_lock, which ensures that
> > + * when an inode goes empty, it will reliably get queued on the LRU.
> > + *
> > + * Cache additions do not acquire the i_lock and may race with this
> > + * check, in which case we'll report the inode as shrinkable when it
> > + * has cache pages. This is okay: the shrinker also checks the
> > + * refcount and the referenced bit, which will be elevated or set in
> > + * the process of adding new cache pages to an inode.
> > + */
> 
> .... because you're expanding the inode->i_lock to now cover the
> page cache additions and removal and that massively increases the
> scope of the i_lock. The ilock is for internal inode serialisation
> purposes, not serialisation with external subsystems that inodes
> interact with like mappings.

I'm expanding it to cover another state change in the inode that
happens to originate in the mapping.

Yes, it would have been slightly easier if the inode locks nested
under the page cache locks, like they do for dirty state. This way we
could have updated the inode from the innermost context where the
mapping state changes, which would have been a bit more compact.

Unfortunately, the i_pages lock is irq-safe - to deal with writeback
completion changing cache state from IRQ context. We'd have to make
the i_lock and the list_lru lock irq-safe as well, and I'm not sure
that is more desirable than ordering the locks the other way.

Doing it this way means annotating a few more deletion entry points.
But there are a limited number of ways for pages to leave the page
cache - reclaim and truncation - so it's within reason.

The i_lock isn't expanded to cover additions, if you take a look at
the code. That would have been a much larger surface area indeed.

> > +static inline bool mapping_shrinkable(struct address_space *mapping)
> > +{
> > +	void *head;
> > +
> > +	/*
> > +	 * On highmem systems, there could be lowmem pressure from the
> > +	 * inodes before there is highmem pressure from the page
> > +	 * cache. Make inodes shrinkable regardless of cache state.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_HIGHMEM))
> > +		return true;
> > +
> > +	/* Cache completely empty? Shrink away. */
> > +	head = rcu_access_pointer(mapping->i_pages.xa_head);
> > +	if (!head)
> > +		return true;
> > +
> > +	/*
> > +	 * The xarray stores single offset-0 entries directly in the
> > +	 * head pointer, which allows non-resident page cache entries
> > +	 * to escape the shadow shrinker's list of xarray nodes. The
> > +	 * inode shrinker needs to pick them up under memory pressure.
> > +	 */
> > +	if (!xa_is_node(head) && xa_is_value(head))
> > +		return true;
> > +
> > +	return false;
> > +}
> 
> It just occurred to me: mapping_shrinkable() == available for
> shrinking, not "mapping can be shrunk by having pages freed from
> it".
> 
> If this lives, it really needs a better name and API - this isn't
> applying a check of whether the mapping can be shrunk, it indicates
> whether the inode hosting the mapping is considered freeable or not.

Right, it indicates whether the state of the mapping translates to the
inode being eligigble for shrinker reclaim or not.

I've used mapping_populated() in a previous version, but this function
here captures additional reclaim policy (highmem setups e.g.), so it's
not a suitable name for it.

This is the best I could come up with, so I'm open to suggestions.

> > @@ -260,9 +260,13 @@ void delete_from_page_cache(struct page *page)
> >  	struct address_space *mapping = page_mapping(page);
> >  
> >  	BUG_ON(!PageLocked(page));
> > +	spin_lock(&mapping->host->i_lock);
> >  	xa_lock_irq(&mapping->i_pages);
> >  	__delete_from_page_cache(page, NULL);
> >  	xa_unlock_irq(&mapping->i_pages);
> > +	if (mapping_shrinkable(mapping))
> > +		inode_add_lru(mapping->host);
> > +	spin_unlock(&mapping->host->i_lock);
> >  
> 
> This, to me is an example of the layering problesm here. No mapping
> specific function should be using locks that belong to the mapping
> host for internal mapping serialisation.
> 
> Especially considering that inode_add_lru() is defined in
> fs/internal.h - nothing outside the core fs code should really be
> using inode_add_lru(), just lik enothing outside of fs code should
> be using the inode->i_lock for anything.

Again, it's no different than dirty state propagation. That's simply
the direction in which this information flows through the stack.

We can encapsulate it all into wrapper/API functions if you prefer,
but it doesn't really change the direction in which the information
travels, nor the lock scoping.

> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index cc5d7cd75935..6dd5ef8a11bc 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1055,6 +1055,8 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
> >  	BUG_ON(!PageLocked(page));
> >  	BUG_ON(mapping != page_mapping(page));
> >  
> > +	if (!PageSwapCache(page))
> > +		spin_lock(&mapping->host->i_lock);
> >  	xa_lock_irq(&mapping->i_pages);
> >  	/*
> >  	 * The non racy check for a busy page.
> > @@ -1123,6 +1125,9 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
> >  			shadow = workingset_eviction(page, target_memcg);
> >  		__delete_from_page_cache(page, shadow);
> >  		xa_unlock_irq(&mapping->i_pages);
> > +		if (mapping_shrinkable(mapping))
> > +			inode_add_lru(mapping->host);
> > +		spin_unlock(&mapping->host->i_lock);
> >  
> 
> No. Inode locks have absolutely no place serialising core vmscan
> algorithms.

What if, and hear me out on this one, core vmscan algorithms change
the state of the inode?

The alternative to propagating this change from where it occurs is
simply that the outer layer now has to do stupid things to infer it -
essentially needing to busy poll. See below.

> Really, all this complexity because:
> 
> | The issue is mostly that shrinker pools attract pressure based on
> | their size, and when objects get skipped the shrinkers remember this
> | as deferred reclaim work.
> 
> And so you want inodes with reclaimable mappings to avoid being
> considered deferred work for the inode shrinker. That's what is
> occuring because we are currently returning LRU_RETRY to them, or
> would also happen if we returned LRU_SKIP or LRU_ROTATE just to
> ignore them.
> 
> However, it's trivial to change inode_lru_isolate() to do something
> like:
> 
> 	if (inode_has_buffers(inode) || inode->i_data.nrpages) {
> 		if (!IS_ENABLED(CONFIG_HIGHMEM)) {
> 			spin_unlock(&inode->i_lock);
> 			return LRU_ROTATE_NODEFER;
> 		}
> 		.....
> 	}

Yeah, that's busy polling. It's simple and inefficient.

We can rotate the busy inodes to the end of the list when we see them,
but all *new* inodes get placed ahead of them and push them out the
back. If you have a large set of populated inodes paired with an
ongoing stream of metadata operations creating one-off inodes, you end
up continuously shoveling through hundreds of thousand of the same
pinned inodes to get to the few reclaimable ones mixed in.

Meanwhile, the MM is standing by, going "You know, I could tell you
exactly when those actually become reclaimable..."

If you think this is the more elegant implementation, simply because
it follows a made-up information hierarchy that doesn't actually map
to the real world, then I don't know what to tell you.

We take i_count and dirty inodes off the list because it's silly to
rotate them over and over, when we could just re-add them the moment
the pin goes away. It's not a stretch to do the same for populated
inodes, which usually make up a much bigger share of the pool.

> And in __list_lru_walk_one() just add:
> 
> 		case LRU_ROTATE_NODEFER:
> 			isolated++;
> 			/* fallthrough */
> 		case LRU_ROTATE:
> 			list_move_tail(item, &l->list);
> 			break;
> 
> And now inodes with active page cache  rotated to the tail of the
> list and are considered to have had work done on them. Hence they
> don't add to the work accumulation that the shrinker infrastructure
> defers, and so will allow the page reclaim to do it's stuff with
> page reclaim before such inodes will get reclaimed.
> 
> That's *much* simpler than your proposed patch and should get you
> pretty much the same result.

It solves the deferred work buildup, but it's absurdly inefficient.

So no, unfortunately I disagree with your assessment of this patch and
the arguments you've made in support of that. There is precedent for
propagating state change from the page cache to the inode, and doing
so is vastly more elegant and efficient than having the outer layer
abuse its own aging machinery to busy poll that state.
