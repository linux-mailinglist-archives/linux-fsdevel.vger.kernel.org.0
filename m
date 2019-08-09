Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 251FF87A44
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2019 14:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406657AbfHIMgf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 08:36:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfHIMgf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 08:36:35 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B4BDC6378;
        Fri,  9 Aug 2019 12:36:34 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3676A194B9;
        Fri,  9 Aug 2019 12:36:34 +0000 (UTC)
Date:   Fri, 9 Aug 2019 08:36:32 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 23/24] xfs: reclaim inodes from the LRU
Message-ID: <20190809123632.GA29669@bfoster>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-24-david@fromorbit.com>
 <20190808163905.GC24551@bfoster>
 <20190809012022.GX7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809012022.GX7777@dread.disaster.area>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 09 Aug 2019 12:36:34 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 09, 2019 at 11:20:22AM +1000, Dave Chinner wrote:
> On Thu, Aug 08, 2019 at 12:39:05PM -0400, Brian Foster wrote:
> > On Thu, Aug 01, 2019 at 12:17:51PM +1000, Dave Chinner wrote:
> > > From: Dave Chinner <dchinner@redhat.com>
> > > 
> > > Replace the AG radix tree walking reclaim code with a list_lru
> > > walker, giving us both node-aware and memcg-aware inode reclaim
> > > at the XFS level. This requires adding an inode isolation function to
> > > determine if the inode can be reclaim, and a list walker to
> > > dispose of the inodes that were isolated.
> > > 
> > > We want the isolation function to be non-blocking. If we can't
> > > grab an inode then we either skip it or rotate it. If it's clean
> > > then we skip it, if it's dirty then we rotate to give it time to be
> > 
> > Do you mean we remove it if it's clean?
> 
> No, I mean if we can't grab it and it's clean, then we just skip it,
> leaving it at the head of the LRU for the next scanner to
> immediately try to reclaim it. If it's dirty, we rotate it so that
> time passes before we try to reclaim it again in the hope that it is
> already clean by the time we've scanned through the entire LRU...
> 

Ah, Ok. That could probably be worded more explicitly. E.g.:

"If we can't grab an inode, we skip it if it is clean or rotate it if
dirty. Dirty inode rotation gives the inode time to be cleaned before
it's scanned again. ..."

> > > +++ b/fs/xfs/xfs_super.c
> > ...
> > > @@ -1810,23 +1811,58 @@ xfs_fs_mount(
...
> > > +	long freed;
> > >  
> > > -	return list_lru_shrink_count(&XFS_M(sb)->m_inode_lru, sc);
> > > +	INIT_LIST_HEAD(&ra.freeable);
> > > +	ra.lowest_lsn = NULLCOMMITLSN;
> > > +	ra.dirty_skipped = 0;
> > > +
> > > +	freed = list_lru_shrink_walk(&mp->m_inode_lru, sc,
> > > +					xfs_inode_reclaim_isolate, &ra);
> > 
> > This is more related to the locking discussion on the earlier patch, but
> > this looks like it has more similar serialization to the example patch I
> > posted than the one without locking at all. IIUC, this walk has an
> > internal lock per node lru that is held across the walk and passed into
> > the callback. We never cycle it, so for any given node we only allow one
> > reclaimer through here at a time.
> 
> That's not a guarantee that list_lru gives us. It could drop it's
> internal lock at any time during that walk and we would be
> blissfully unaware that it has done this. And at that point, the
> reclaim context is completely unaware that other reclaim contexts
> may be scanning the same LRU at the same time and are interleaving
> with it.
> 

What is not a guarantee? I'm not following your point here. I suppose it
technically could drop the lock, but then it would have to restart the
iteration and wouldn't exactly provide predictable batching capability
to users.

This internal lock protects the integrity of the list from external
adds/removes, etc., but it's also passed into the callback so of course
it can be cycled at any point. The callback just has to notify the
caller to restart the walk. E.g., from __list_lru_walk_one():

        /*
         * The lru lock has been dropped, our list traversal is
         * now invalid and so we have to restart from scratch.
         */

> And, really, that does not matter one iota. If multiple scanners are
> interleaving, the reclaim traversal order and the decisions made are
> no different from what a single reclaimer does.  i.e. we just don't
> have to care if reclaim contexts interleave or not, because they
> will not repeat work that has already been done unnecessarily.
> That's one of the reasons for moving to IO-less LRU ordered reclaim
> - it removes all the gross hacks we've had to implement to guarantee
> reclaim scanning progress in one nice neat package of generic
> infrastructure.
> 

Yes, exactly. The difference I'm pointing out is that with the earlier
patch that drops locking from the perag based scan mechanism, the
interleaving of multiple reclaim scanners over the same range is not
exactly the same as a single reclaimer. That sort of behavior is the
intent of the example patch I appended to change the locking instead of
remove it.

> > That seems to be Ok given we don't do much in the isolation handler, the
> > lock isn't held across the dispose sequence and we're still batching in
> > the shrinker core on top of that. We're still serialized over the lru
> > fixups such that concurrent reclaimers aren't processing the same
> > inodes, however.
> 
> The only thing that we may need here is need_resched() checks if it
> turns out that holding a lock for 1024 items to be scanned proved to
> be too long to hold on to a single CPU. If we do that we'd cycle the
> LRU lock and return RETRY or RETRY_REMOVE, hence enabling reclaimers
> more finer-grained interleaving....
> 

Sure, with the caveat that we restart the traversal..

> > BTW I got a lockdep splat[1] for some reason on a straight mount/unmount
> > cycle with this patch.
> ....
> > [   39.030519]  lock_acquire+0x90/0x170
> > [   39.031170]  ? xfs_ilock+0xd2/0x280 [xfs]
> > [   39.031603]  down_write_nested+0x4f/0xb0
> > [   39.032064]  ? xfs_ilock+0xd2/0x280 [xfs]
> > [   39.032684]  ? xfs_dispose_inodes+0x124/0x320 [xfs]
> > [   39.033575]  xfs_ilock+0xd2/0x280 [xfs]
> > [   39.034058]  xfs_dispose_inodes+0x124/0x320 [xfs]
> 
> False positive, AFAICT. It's complaining about the final xfs_ilock()
> call we do before freeing the inode because we have other inodes
> locked. I don't think this can deadlock because the inodes under
> reclaim should not be usable by anyone else at this point because
> they have the I_RECLAIM flag set.
> 

Ok. The code looked sane to me at a glance, but lockdep tends to confuse
the hell out of me.

Brian

> I did notice this - I added a XXX comment I added to the case being
> complained about to note I needed to resolve this locking issue.
> 
> +        * Here we do an (almost) spurious inode lock in order to coordinate
> +        * with inode cache radix tree lookups.  This is because the lookup
> +        * can reference the inodes in the cache without taking references.
> +        *
> +        * We make that OK here by ensuring that we wait until the inode is
> +        * unlocked after the lookup before we go ahead and free it. 
> +        * unlocked after the lookup before we go ahead and free it. 
> +        *
> +        * XXX: need to check this is still true. Not sure it is.
>          */
> 
> I added that last line in this patch. In more detail....
> 
> The comment is suggesting that we need to take the ILOCK to
> co-ordinate with RCU protected lookups in progress before we RCU
> free the inode. That's waht RCU is supposed to do, so I'm not at all
> sure what this is actually serialising against any more.
> 
> i.e. any racing radix tree lookup from this point in time is going
> to see the XFS_IRECLAIM flag and ip->i_ino == 0 while under the
> rcu_read_lock, and they will go try again after dropping all lock
> context and waiting for a bit. The inode may remain visibile until
> the next rcu grace period expires, but all lookups will abort long
> before the get anywhere near the ILOCK. And once the RCU grace
> period expires, lookups will be locked out by the rcu_read_lock(),
> the raidx tree moves to a state where the removal of the inode is
> guaranteed visibile to all CPUs, and then the object is freed.
> 
> So the ILOCK should have no part in lookup serialisation, and I need
> to go look at the history of the code to determine where and why
> this was added, and whether the condition it protects against is
> still a valid concern or not....
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
