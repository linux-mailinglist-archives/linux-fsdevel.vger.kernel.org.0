Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89C76891B2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2019 14:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfHKMqI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Aug 2019 08:46:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfHKMqH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Aug 2019 08:46:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 29C172D6A0F;
        Sun, 11 Aug 2019 12:46:07 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7932F6012D;
        Sun, 11 Aug 2019 12:46:06 +0000 (UTC)
Date:   Sun, 11 Aug 2019 08:46:04 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 23/24] xfs: reclaim inodes from the LRU
Message-ID: <20190811124604.GA27188@bfoster>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-24-david@fromorbit.com>
 <20190808163905.GC24551@bfoster>
 <20190809012022.GX7777@dread.disaster.area>
 <20190809123632.GA29669@bfoster>
 <20190811021747.GE7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811021747.GE7777@dread.disaster.area>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sun, 11 Aug 2019 12:46:07 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 11, 2019 at 12:17:47PM +1000, Dave Chinner wrote:
> On Fri, Aug 09, 2019 at 08:36:32AM -0400, Brian Foster wrote:
> > On Fri, Aug 09, 2019 at 11:20:22AM +1000, Dave Chinner wrote:
> > > On Thu, Aug 08, 2019 at 12:39:05PM -0400, Brian Foster wrote:
> > > > On Thu, Aug 01, 2019 at 12:17:51PM +1000, Dave Chinner wrote:
> > > > > From: Dave Chinner <dchinner@redhat.com>
...
> > > > > +	long freed;
> > > > >  
> > > > > -	return list_lru_shrink_count(&XFS_M(sb)->m_inode_lru, sc);
> > > > > +	INIT_LIST_HEAD(&ra.freeable);
> > > > > +	ra.lowest_lsn = NULLCOMMITLSN;
> > > > > +	ra.dirty_skipped = 0;
> > > > > +
> > > > > +	freed = list_lru_shrink_walk(&mp->m_inode_lru, sc,
> > > > > +					xfs_inode_reclaim_isolate, &ra);
> > > > 
> > > > This is more related to the locking discussion on the earlier patch, but
> > > > this looks like it has more similar serialization to the example patch I
> > > > posted than the one without locking at all. IIUC, this walk has an
> > > > internal lock per node lru that is held across the walk and passed into
> > > > the callback. We never cycle it, so for any given node we only allow one
> > > > reclaimer through here at a time.
> > > 
> > > That's not a guarantee that list_lru gives us. It could drop it's
> > > internal lock at any time during that walk and we would be
> > > blissfully unaware that it has done this. And at that point, the
> > > reclaim context is completely unaware that other reclaim contexts
> > > may be scanning the same LRU at the same time and are interleaving
> > > with it.
> > > 
> > 
> > What is not a guarantee? I'm not following your point here. I suppose it
> > technically could drop the lock, but then it would have to restart the
> > iteration and wouldn't exactly provide predictable batching capability
> > to users.
> 
> There is no guarantee that the list_lru_shrink_walk() provides a
> single list walker at a time or that it provides predictable
> batching capability to users.
> 

Hm, Ok. I suppose the code could change if that's your point. But how is
that relevant to how XFS reclaim behavior as of this patch compares to
the intermediate patch 20? Note again that this the only reason I bring
it up in this patch (which seems mostly sane to me). Perhaps I should
have just replied again to patch 20 to avoid confusion. Apologies for
that, but that ship has sailed...

To reiterate, I suggested not dropping the lock in patch 20 for
$reasons. You replied generally that doing so might cause more problems
than it solves. I replied with a compromise patch that leaves the lock,
but only acquires it across inode grabbing instead of the entire reclaim
operation. This essentially implements "serialized isolation batching"
as we've termed it here (assuming the patch is correct).

I eventually made it to this patch and observe that you end up with an
implementation that does serialized isolation batching. Of course the
locking and implementation is quite different with this being a whole
new mechanism, so performance and things could be quite different too.
But my point is that if serialized isolation batching is acceptable
behavior for XFS inode reclaim right now, then it seems reasonable to me
that it be acceptable in patch 20 for what is ultimately just an
intermediate state.

I appreciate all of the discussion and background information that
follows, but it gets way far off from the original feedback. I've still
seen no direct response to the thoughts above either here or in patch
20. Are you planning to incorporate that example patch or something
similar? If so, then I think we're on the same page.

> > This internal lock protects the integrity of the list from external
> > adds/removes, etc., but it's also passed into the callback so of course
> > it can be cycled at any point. The callback just has to notify the
> > caller to restart the walk. E.g., from __list_lru_walk_one():
> > 
> >         /*
> >          * The lru lock has been dropped, our list traversal is
> >          * now invalid and so we have to restart from scratch.
> >          */
> 
> As the designer and author of the list_lru code, I do know how it
> works. I also know exactly what this problem this behaviour was
> intended to solve, because I had to solve it to meet the
> requirements I had for the infrastructure.
> 
> The isolation walk lock batching currently done is an optimisation
> to minimise lru lock contention - it amortise the cost of getting
> the lock over a substantial batch of work. If we drop the lock on
> every item we try to isolate - my initial implementations did this -
> then the lru lock thrashes badly against concurrent inserts and
> deletes and scalability is not much better than the global lock it
> was replacing.
> 

Ok.

> IOWs, the behaviour we have now is a result of lock contention
> optimisation to meet scalability requirements, not because of some
> "predictable batching" requirement. If we were to rework the
> traversal mechanism such that the lru lock was not necessary to
> protect the state of the LRU list across the batch of isolate
> callbacks, then we'd get the scalability we need but we'd completely
> change the concurrency behaviour. The list would still do LRU
> reclaim, and the isolate functions still work exactly as tehy
> currently do (i.e. they work on just the item passed to them) but
> we'd have concurrent reclaim contexts isolating items on the same
> LRU concurrently rather than being serialised. And that's perfectly
> fine, because the isolate/dispose architecture just doesn't care
> how the items on the LRU are isolated for disposal.....
> 

Sure, that mostly makes sense. We're free to similarly rework the old
mechanism to not require locking just as well. My point is that the
patch to move I/O submission to the AIL doesn't do that sufficiently,
despite that being the initial purpose of the lock.

BTW, the commit[1] that introduces the pag reclaim lock back in 2010
introduces the cursor at the same time and actually does mention some of
the things I'm pointing out as potential problems with patch 20. It
refers to potential for "massive contention" and prevention of
reclaimers "continually scanning the same inodes in each AG." Again, I'm
not worried about that for this series because we ultimately rework the
shrinker past those issues, but it appears that it wasn't purely a
matter of I/O submission ordering that motivated the lock (though I'm
sure that was part of it).

Given that, I think another reasonable option for patch 20 is to remove
the cursor and locking together. That at least matches some form of
historical reclaim behavior in XFS. If we took that approach, it might
make sense to split patch 20 into one patch that shifts I/O to xfsaild
(new behavior) and a subsequent that undoes [1].

[1] 69b491c214d7 ("xfs: serialise inode reclaim within an AG")

> What I'm trying to say is that the "isolation batching" we have is
> not desirable but it is necessary, and we because that's internal to
> the list_lru implementation, we can change that behaviour however
> we want and it won't affect the subsystems that own the objects
> being reclaimed. They still just get handed a list of items to
> dispose, and they all come from the reclaim end of the LRU list...
> 
> Indeed, the new XFS inode shrinker is not dependent on any specific
> batching order, it's not dependent on isolation being serialised,
> and it's not dependent on the lru_lock being held across the
> isolation function. IOWs, it's set up just right to take advantage
> of any increases in isolation concurrency that the list_lru
> infrastructure could provide...
>

Yep, it's a nice abstraction. This has no bearing on the old
implementation which does have XFS specific locking, however.
 
> > > > That seems to be Ok given we don't do much in the isolation handler, the
> > > > lock isn't held across the dispose sequence and we're still batching in
> > > > the shrinker core on top of that. We're still serialized over the lru
> > > > fixups such that concurrent reclaimers aren't processing the same
> > > > inodes, however.
> > > 
> > > The only thing that we may need here is need_resched() checks if it
> > > turns out that holding a lock for 1024 items to be scanned proved to
> > > be too long to hold on to a single CPU. If we do that we'd cycle the
> > > LRU lock and return RETRY or RETRY_REMOVE, hence enabling reclaimers
> > > more finer-grained interleaving....
> > > 
> > 
> > Sure, with the caveat that we restart the traversal..
> 
> Which only re-traverses the inodes we skipped because they were
> locked at the time. IOWs, Skipping inodes is rare because if it is
> in reclaim then the only things that can be contending is a radix
> tree lookup in progress or an inode clustering operation
> (write/free) in progress. Either way, they will be relatively rare
> and very short term lock holds, so if we have to restart the scan
> after dropping the lru lock then it's likely we'll restart at next
> inode in line for reclaim, anyway....
> 
> Hence I don't think having to restart a traversal would really
> matter all that much....
> 

Perhaps, that seems fairly reasonable given that we rotate dirty inodes.
I'm not totally convinced we might not thrash on an LRU with a high
population of dirty inodes or that a restart is even the simplest
approach to dealing with large batch sizes, but I'd reserve judgement on
that until there's code to review.

Brian

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
