Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9381FFD0D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 23:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfKNWQH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 17:16:07 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:51031 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726613AbfKNWQH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 17:16:07 -0500
Received: from dread.disaster.area (pa49-181-255-80.pa.nsw.optusnet.com.au [49.181.255.80])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id ECDDD3A0B37;
        Fri, 15 Nov 2019 09:16:03 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iVNPG-0003sf-Ih; Fri, 15 Nov 2019 09:16:02 +1100
Date:   Fri, 15 Nov 2019 09:16:02 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 28/28] xfs: rework unreferenced inode lookups
Message-ID: <20191114221602.GJ4614@dread.disaster.area>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-29-david@fromorbit.com>
 <20191106221846.GE37080@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106221846.GE37080@bfoster>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=XqaD5fcB6dAc7xyKljs8OA==:117 a=XqaD5fcB6dAc7xyKljs8OA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=MeAgGD-zjQ4A:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=IWTshbZNQ61hlG1uunsA:9
        a=t2uFhITubsOjiuAe:21 a=IvPsoiGnKNB4D9hQ:21 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 06, 2019 at 05:18:46PM -0500, Brian Foster wrote:
> On Fri, Nov 01, 2019 at 10:46:18AM +1100, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Looking up an unreferenced inode in the inode cache is a bit hairy.
> > We do this for inode invalidation and writeback clustering purposes,
> > which is all invisible to the VFS. Hence we can't take reference
> > counts to the inode and so must be very careful how we do it.
> > 
> > There are several different places that all do the lookups and
> > checks slightly differently. Fundamentally, though, they are all
> > racy and inode reclaim has to block waiting for the inode lock if it
> > loses the race. This is not very optimal given all the work we;ve
> > already done to make reclaim non-blocking.
> > 
> > We can make the reclaim process nonblocking with a couple of simple
> > changes. If we define the unreferenced lookup process in a way that
> > will either always grab an inode in a way that reclaim will notice
> > and skip, or will notice a reclaim has grabbed the inode so it can
> > skip the inode, then there is no need for reclaim to need to cycle
> > the inode ILOCK at all.
> > 
> > Selecting an inode for reclaim is already non-blocking, so if the
> > ILOCK is held the inode will be skipped. If we ensure that reclaim
> > holds the ILOCK until the inode is freed, then we can do the same
> > thing in the unreferenced lookup to avoid inodes in reclaim. We can
> > do this simply by holding the ILOCK until the RCU grace period
> > expires and the inode freeing callback is run. As all unreferenced
> > lookups have to hold the rcu_read_lock(), we are guaranteed that
> > a reclaimed inode will be noticed as the trylock will fail.
> > 
> ...
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  fs/xfs/mrlock.h     |  27 +++++++++
> >  fs/xfs/xfs_icache.c |  88 +++++++++++++++++++++--------
> >  fs/xfs/xfs_inode.c  | 131 +++++++++++++++++++++-----------------------
> >  3 files changed, 153 insertions(+), 93 deletions(-)
> > 
> > diff --git a/fs/xfs/mrlock.h b/fs/xfs/mrlock.h
> > index 79155eec341b..1752a2592bcc 100644
> > --- a/fs/xfs/mrlock.h
> > +++ b/fs/xfs/mrlock.h
> ...
> > diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> > index 11bf4768d491..45ee3b5cd873 100644
> > --- a/fs/xfs/xfs_icache.c
> > +++ b/fs/xfs/xfs_icache.c
> > @@ -106,6 +106,7 @@ xfs_inode_free_callback(
> >  		ip->i_itemp = NULL;
> >  	}
> >  
> > +	mrunlock_excl_non_owner(&ip->i_lock);
> >  	kmem_zone_free(xfs_inode_zone, ip);
> >  }
> >  
> > @@ -132,6 +133,7 @@ xfs_inode_free(
> >  	 * free state. The ip->i_flags_lock provides the barrier against lookup
> >  	 * races.
> >  	 */
> > +	mrupdate_non_owner(&ip->i_lock);
> 
> Can we tie these into the proper locking interface using flags? For
> example, something like xfs_ilock(ip, XFS_ILOCK_EXCL|XFS_ILOCK_NONOWNER)
> or xfs_ilock(ip, XFS_ILOCK_EXCL_NONOWNER) perhaps?

I'd prefer not to make this part of the common locking interface -
it's a one off special use case, not something we want to progate
elsewhere into the code.

Now that I think over it, I probably should have tagged this with
patch with [RFC]. I think we should just get rid of the mrlock
wrappers rather than add more, and that would simplify this a lot.


> >  	spin_lock(&ip->i_flags_lock);
> >  	ip->i_flags = XFS_IRECLAIM;
> >  	ip->i_ino = 0;
> > @@ -295,11 +297,24 @@ xfs_iget_cache_hit(
> >  		}
> >  
> >  		/*
> > -		 * We need to set XFS_IRECLAIM to prevent xfs_reclaim_inode
> > -		 * from stomping over us while we recycle the inode. Remove it
> > -		 * from the LRU straight away so we can re-init the VFS inode.
> > +		 * Before we reinitialise the inode, we need to make sure
> > +		 * reclaim does not pull it out from underneath us. We already
> > +		 * hold the i_flags_lock, and because the XFS_IRECLAIM is not
> > +		 * set we know the inode is still on the LRU. However, the LRU
> > +		 * code may have just selected this inode to reclaim, so we need
> > +		 * to ensure we hold the i_flags_lock long enough for the
> > +		 * trylock in xfs_inode_reclaim_isolate() to fail. We do this by
> > +		 * removing the inode from the LRU, which will spin on the LRU
> > +		 * list locks until reclaim stops walking, at which point we
> > +		 * know there is no possible race between reclaim isolation and
> > +		 * this lookup.
> > +		 *
> 
> Somewhat related to my question about the lru_lock on the earlier patch.

*nod*

The caveat here is that this is the slow path so spinning for a
while doesn't really matter.

> > @@ -1022,19 +1076,7 @@ xfs_dispose_inode(
> >  	spin_unlock(&pag->pag_ici_lock);
> >  	xfs_perag_put(pag);
> >  
> > -	/*
> > -	 * Here we do an (almost) spurious inode lock in order to coordinate
> > -	 * with inode cache radix tree lookups.  This is because the lookup
> > -	 * can reference the inodes in the cache without taking references.
> > -	 *
> > -	 * We make that OK here by ensuring that we wait until the inode is
> > -	 * unlocked after the lookup before we go ahead and free it.
> > -	 *
> > -	 * XXX: need to check this is still true. Not sure it is.
> > -	 */
> > -	xfs_ilock(ip, XFS_ILOCK_EXCL);
> >  	xfs_qm_dqdetach(ip);
> > -	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> 
> Ok, so I'm staring at this a bit more and think I'm missing something.
> If we put aside the change to hold ilock until the inode is freed, we
> basically have the following (simplified) flow as the inode goes from
> isolation to disposal:
> 
> 	ilock	(isolate)
> 	iflock
> 	set XFS_IRECLAIM
> 	ifunlock (disposal)
> 	iunlock
> 	radix delete
> 	ilock cycle (drain)
> 	rcu free
> 
> What we're trying to eliminate is the ilock cycle to drain any
> concurrent unreferenced lookups from accessing the inode once it is
> freed. The free itself is still RCU protected.
> 
> Looking over at the ifree path, we now have something like this:
> 
> 	rcu_read_lock()
> 	radix lookup
> 	check XFS_IRECLAIM
> 	ilock
> 	if XFS_ISTALE, skip
> 	set XFS_ISTALE
> 	rcu_read_unlock()
> 	iflock
> 	/* return locked down inode */

You missed a lock.

	rcu_read_lock()
	radix lookup
>>>	i_flags_lock
	check XFS_IRECLAIM
	ilock
	if XFS_ISTALE, skip
	set XFS_ISTALE
>>>	i_flags_unlock
	rcu_read_unlock()
	iflock

> Given that we set XFS_IRECLAIM under ilock, would we still need either
> the ilock cycle or to hold ilock through the RCU free if the ifree side
> (re)checked XFS_IRECLAIM after it has the ilock (but before it drops the
> rcu read lock)?

We set XFS_IRECLAIM under the i_flags_lock.

It is the combination of rcu_read_lock() and i_flags_lock() that
provides the RCU lookup state barriers - the ILOCK is not part of
that at all.

The key point here is that once we've validated the inode we found
in the radix tree under the i_flags_lock, we then take the ILOCK,
thereby serialising the taking of the ILOCK here with the taking of
the ILOCK in the reclaim isolation code.

i.e. all the reclaim state serialisation is actually based around
holding the i_flags_lock, not the ILOCK. 

Once we have grabbed the ILOCK under the i_flags_lock, we can
drop the i_flags_lock knowing that reclaim will not be able isolate
this inode and set XFS_IRECLAIM.

> ISTM we should either have a non-reclaim inode with
> ilock protection or a reclaim inode with RCU protection (so we can skip
> it before it frees), but I could easily be missing something here..

Heh. Yeah, it's a complex dance, and it's all based around how
RCU lookups and the i_flags_lock interact to provide coherent
detection of freed inodes.

I have a nagging feeling that this whole ILOCK-held-to-rcu-free game
can be avoided. I need to walk myself through the lookup state
machine again and determine if ordering the XFS_IRECLAIM flag check
after greabbing the ILOCK is sufficient to prevent ifree/iflush
lookups from accessing the inode outside the rcu_read_lock()
context.

If so, most of this patch will go away....

> > +	 * attached to the buffer so we don't need to do anything more here.
> >  	 */
> > -	if (ip != free_ip) {
> > -		if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL)) {
> > -			rcu_read_unlock();
> > -			delay(1);
> > -			goto retry;
> > -		}
> > -
> > -		/*
> > -		 * Check the inode number again in case we're racing with
> > -		 * freeing in xfs_reclaim_inode().  See the comments in that
> > -		 * function for more information as to why the initial check is
> > -		 * not sufficient.
> > -		 */
> > -		if (ip->i_ino != inum) {
> > +	if (__xfs_iflags_test(ip, XFS_ISTALE)) {
> 
> Is there a correctness reason for why we move the stale check to under
> ilock (in both iflush/ifree)?

It's under the i_flags_lock, and so I moved it up under the lookup
hold of the i_flags_lock so we don't need to cycle it again.

> >  	/*
> > -	 * We don't need to attach clean inodes or those only with unlogged
> > -	 * changes (which we throw away, anyway).
> > +	 * We don't need to attach clean inodes to the buffer - they are marked
> > +	 * stale in memory now and will need to be re-initialised by inode
> > +	 * allocation before they can be reused.
> >  	 */
> >  	if (!ip->i_itemp || xfs_inode_clean(ip)) {
> >  		ASSERT(ip != free_ip);
> >  		xfs_ifunlock(ip);
> > -		xfs_iunlock(ip, XFS_ILOCK_EXCL);
> > +		if (ip != free_ip)
> > +			xfs_iunlock(ip, XFS_ILOCK_EXCL);
> 
> There's an assert against this case just above, though I suppose there's
> nothing wrong with just keeping it and making the functional code more
> cautious.

*nod*

It follows Darrick's lead of making sure that production kernels
don't do something stupid because of some whacky corruption we
didn't expect to ever see.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
