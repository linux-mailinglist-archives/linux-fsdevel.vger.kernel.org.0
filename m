Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 729D988F11
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2019 04:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfHKCTB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Aug 2019 22:19:01 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:48313 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726484AbfHKCTB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Aug 2019 22:19:01 -0400
Received: from dread.disaster.area (pa49-181-167-148.pa.nsw.optusnet.com.au [49.181.167.148])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id A751D365B77;
        Sun, 11 Aug 2019 12:18:54 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hwdQZ-000318-Gl; Sun, 11 Aug 2019 12:17:47 +1000
Date:   Sun, 11 Aug 2019 12:17:47 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 23/24] xfs: reclaim inodes from the LRU
Message-ID: <20190811021747.GE7777@dread.disaster.area>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-24-david@fromorbit.com>
 <20190808163905.GC24551@bfoster>
 <20190809012022.GX7777@dread.disaster.area>
 <20190809123632.GA29669@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809123632.GA29669@bfoster>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=gu9DDhuZhshYSb5Zs/lkOA==:117 a=gu9DDhuZhshYSb5Zs/lkOA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=yfrmvxV0w3xqykQ9w7EA:9
        a=d944y8aNix33yYBO:21 a=wEbLebVyk9Hl3MQ3:21 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 09, 2019 at 08:36:32AM -0400, Brian Foster wrote:
> On Fri, Aug 09, 2019 at 11:20:22AM +1000, Dave Chinner wrote:
> > On Thu, Aug 08, 2019 at 12:39:05PM -0400, Brian Foster wrote:
> > > On Thu, Aug 01, 2019 at 12:17:51PM +1000, Dave Chinner wrote:
> > > > From: Dave Chinner <dchinner@redhat.com>
> > > > 
> > > > Replace the AG radix tree walking reclaim code with a list_lru
> > > > walker, giving us both node-aware and memcg-aware inode reclaim
> > > > at the XFS level. This requires adding an inode isolation function to
> > > > determine if the inode can be reclaim, and a list walker to
> > > > dispose of the inodes that were isolated.
> > > > 
> > > > We want the isolation function to be non-blocking. If we can't
> > > > grab an inode then we either skip it or rotate it. If it's clean
> > > > then we skip it, if it's dirty then we rotate to give it time to be
> > > 
> > > Do you mean we remove it if it's clean?
> > 
> > No, I mean if we can't grab it and it's clean, then we just skip it,
> > leaving it at the head of the LRU for the next scanner to
> > immediately try to reclaim it. If it's dirty, we rotate it so that
> > time passes before we try to reclaim it again in the hope that it is
> > already clean by the time we've scanned through the entire LRU...
> > 
> 
> Ah, Ok. That could probably be worded more explicitly. E.g.:
> 
> "If we can't grab an inode, we skip it if it is clean or rotate it if
> dirty. Dirty inode rotation gives the inode time to be cleaned before
> it's scanned again. ..."

*nod*

> > > > +++ b/fs/xfs/xfs_super.c
> > > ...
> > > > @@ -1810,23 +1811,58 @@ xfs_fs_mount(
> ...
> > > > +	long freed;
> > > >  
> > > > -	return list_lru_shrink_count(&XFS_M(sb)->m_inode_lru, sc);
> > > > +	INIT_LIST_HEAD(&ra.freeable);
> > > > +	ra.lowest_lsn = NULLCOMMITLSN;
> > > > +	ra.dirty_skipped = 0;
> > > > +
> > > > +	freed = list_lru_shrink_walk(&mp->m_inode_lru, sc,
> > > > +					xfs_inode_reclaim_isolate, &ra);
> > > 
> > > This is more related to the locking discussion on the earlier patch, but
> > > this looks like it has more similar serialization to the example patch I
> > > posted than the one without locking at all. IIUC, this walk has an
> > > internal lock per node lru that is held across the walk and passed into
> > > the callback. We never cycle it, so for any given node we only allow one
> > > reclaimer through here at a time.
> > 
> > That's not a guarantee that list_lru gives us. It could drop it's
> > internal lock at any time during that walk and we would be
> > blissfully unaware that it has done this. And at that point, the
> > reclaim context is completely unaware that other reclaim contexts
> > may be scanning the same LRU at the same time and are interleaving
> > with it.
> > 
> 
> What is not a guarantee? I'm not following your point here. I suppose it
> technically could drop the lock, but then it would have to restart the
> iteration and wouldn't exactly provide predictable batching capability
> to users.

There is no guarantee that the list_lru_shrink_walk() provides a
single list walker at a time or that it provides predictable
batching capability to users.

> This internal lock protects the integrity of the list from external
> adds/removes, etc., but it's also passed into the callback so of course
> it can be cycled at any point. The callback just has to notify the
> caller to restart the walk. E.g., from __list_lru_walk_one():
> 
>         /*
>          * The lru lock has been dropped, our list traversal is
>          * now invalid and so we have to restart from scratch.
>          */

As the designer and author of the list_lru code, I do know how it
works. I also know exactly what this problem this behaviour was
intended to solve, because I had to solve it to meet the
requirements I had for the infrastructure.

The isolation walk lock batching currently done is an optimisation
to minimise lru lock contention - it amortise the cost of getting
the lock over a substantial batch of work. If we drop the lock on
every item we try to isolate - my initial implementations did this -
then the lru lock thrashes badly against concurrent inserts and
deletes and scalability is not much better than the global lock it
was replacing.

IOWs, the behaviour we have now is a result of lock contention
optimisation to meet scalability requirements, not because of some
"predictable batching" requirement. If we were to rework the
traversal mechanism such that the lru lock was not necessary to
protect the state of the LRU list across the batch of isolate
callbacks, then we'd get the scalability we need but we'd completely
change the concurrency behaviour. The list would still do LRU
reclaim, and the isolate functions still work exactly as tehy
currently do (i.e. they work on just the item passed to them) but
we'd have concurrent reclaim contexts isolating items on the same
LRU concurrently rather than being serialised. And that's perfectly
fine, because the isolate/dispose architecture just doesn't care
how the items on the LRU are isolated for disposal.....

What I'm trying to say is that the "isolation batching" we have is
not desirable but it is necessary, and we because that's internal to
the list_lru implementation, we can change that behaviour however
we want and it won't affect the subsystems that own the objects
being reclaimed. They still just get handed a list of items to
dispose, and they all come from the reclaim end of the LRU list...

Indeed, the new XFS inode shrinker is not dependent on any specific
batching order, it's not dependent on isolation being serialised,
and it's not dependent on the lru_lock being held across the
isolation function. IOWs, it's set up just right to take advantage
of any increases in isolation concurrency that the list_lru
infrastructure could provide...

> > > That seems to be Ok given we don't do much in the isolation handler, the
> > > lock isn't held across the dispose sequence and we're still batching in
> > > the shrinker core on top of that. We're still serialized over the lru
> > > fixups such that concurrent reclaimers aren't processing the same
> > > inodes, however.
> > 
> > The only thing that we may need here is need_resched() checks if it
> > turns out that holding a lock for 1024 items to be scanned proved to
> > be too long to hold on to a single CPU. If we do that we'd cycle the
> > LRU lock and return RETRY or RETRY_REMOVE, hence enabling reclaimers
> > more finer-grained interleaving....
> > 
> 
> Sure, with the caveat that we restart the traversal..

Which only re-traverses the inodes we skipped because they were
locked at the time. IOWs, Skipping inodes is rare because if it is
in reclaim then the only things that can be contending is a radix
tree lookup in progress or an inode clustering operation
(write/free) in progress. Either way, they will be relatively rare
and very short term lock holds, so if we have to restart the scan
after dropping the lru lock then it's likely we'll restart at next
inode in line for reclaim, anyway....

Hence I don't think having to restart a traversal would really
matter all that much....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
