Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA4D88565B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 01:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbfHGXL4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Aug 2019 19:11:56 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:55282 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730045AbfHGXL4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Aug 2019 19:11:56 -0400
Received: from dread.disaster.area (pa49-181-167-148.pa.nsw.optusnet.com.au [49.181.167.148])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id F0A4D43E6F6;
        Thu,  8 Aug 2019 09:11:51 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hvV4u-0006IK-EC; Thu, 08 Aug 2019 09:10:44 +1000
Date:   Thu, 8 Aug 2019 09:10:44 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 20/24] xfs: use AIL pushing for inode reclaim IO
Message-ID: <20190807231044.GR7777@dread.disaster.area>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-21-david@fromorbit.com>
 <20190807180915.GA20425@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807180915.GA20425@bfoster>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=gu9DDhuZhshYSb5Zs/lkOA==:117 a=gu9DDhuZhshYSb5Zs/lkOA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=2u6jjkzSJdERxq6WDqUA:9
        a=II6kCMbtO0gN6Dj7:21 a=dWF_ZXg1rf0HNZcO:21 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 07, 2019 at 02:09:15PM -0400, Brian Foster wrote:
> On Thu, Aug 01, 2019 at 12:17:48PM +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Inode reclaim currently issues it's own inode IO when it comes
> > across dirty inodes. This is used to throttle direct reclaim down to
> > the rate at which we can reclaim dirty inodes. Failure to throttle
> > in this manner results in the OOM killer being trivial to trigger
> > even when there is lots of free memory available.
> > 
> > However, having direct reclaimers issue IO causes an amount of
> > IO thrashing to occur. We can have up to the number of AGs in the
> > filesystem concurrently issuing IO, plus the AIL pushing thread as
> > well. This means we can many competing sources of IO and they all
> > end up thrashing and competing for the request slots in the block
> > device.
> > 
> > Similar to dirty page throttling and the BDI flusher thread, we can
> > use the AIL pushing thread the sole place we issue inode writeback
> > from and everything else waits for it to make progress. To do this,
> > reclaim will skip over dirty inodes, but in doing so will record the
> > lowest LSN of all the dirty inodes it skips. It will then push the
> > AIL to this LSN and wait for it to complete that work.
> > 
> > In doing so, we block direct reclaim on the IO of at least one IO,
> > thereby providing some level of throttling for when we encounter
> > dirty inodes. However we gain the ability to scan and reclaim
> > clean inodes in a non-blocking fashion. This allows us to
> > remove all the per-ag reclaim locking that avoids excessive direct
> > reclaim, as repeated concurrent direct reclaim will hit the same
> > dirty inodes on block waiting on the same IO to complete.
> > 
> 
> The last part of the above sentence sounds borked..

s/on/and/

:)

> >  /*
> > - * Grab the inode for reclaim exclusively.
> > - * Return 0 if we grabbed it, non-zero otherwise.
> > + * Grab the inode for reclaim.
> > + *
> > + * Return false if we aren't going to reclaim it, true if it is a reclaim
> > + * candidate.
> > + *
> > + * If the inode is clean or unreclaimable, return NULLCOMMITLSN to tell the
> > + * caller it does not require flushing. Otherwise return the log item lsn of the
> > + * inode so the caller can determine it's inode flush target.  If we get the
> > + * clean/dirty state wrong then it will be sorted in xfs_reclaim_inode() once we
> > + * have locks held.
> >   */
> > -STATIC int
> > +STATIC bool
> >  xfs_reclaim_inode_grab(
> >  	struct xfs_inode	*ip,
> > -	int			flags)
> > +	int			flags,
> > +	xfs_lsn_t		*lsn)
> >  {
> >  	ASSERT(rcu_read_lock_held());
> > +	*lsn = 0;
> 
> The comment above says we return NULLCOMMITLSN. Given the rest of the
> code, I'm assuming we should just fix up the comment.

Yup, I think I've already fixed it.

> > -restart:
> > -	error = 0;
> >  	/*
> >  	 * Don't try to flush the inode if another inode in this cluster has
> >  	 * already flushed it after we did the initial checks in
> >  	 * xfs_reclaim_inode_grab().
> >  	 */
> > -	if (sync_mode & SYNC_TRYLOCK) {
> > -		if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL))
> > -			goto out;
> > -		if (!xfs_iflock_nowait(ip))
> > -			goto out_unlock;
> > -	} else {
> > -		xfs_ilock(ip, XFS_ILOCK_EXCL);
> > -		if (!xfs_iflock_nowait(ip)) {
> > -			if (!(sync_mode & SYNC_WAIT))
> > -				goto out_unlock;
> > -			xfs_iflock(ip);
> > -		}
> > -	}
> > +	if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL))
> > +		goto out;
> > +	if (!xfs_iflock_nowait(ip))
> > +		goto out_unlock;
> >  
> 
> Do we even need the flush lock here any more if we're never going to
> flush from this context?

Ideally, no. But the inode my currently be being flushed, in which
case the incore inode is clean, but we can't reclaim it yet. Hence
we need the flush lock to serialise against IO completion.

> The shutdown case just below notwithstanding
> (which I'm also wondering if we should just drop given we abort from
> xfs_iflush() on shutdown), the pin count is an atomic and the dirty
> state changes under ilock.

The shutdown case has to handle pinned inodes, not just inodes being
flushed.

> Maybe I'm missing something else, but the reason I ask is that the
> increased flush lock contention in codepaths that don't actually flush
> once it's acquired gives me a bit of concern that we could reduce
> effectiveness of the one task that actually does (xfsaild).

The flush lock isn't a contended lock - it's actually a bit that is
protected by the i_flags_lock, so if we are contending on anything
it will be the flags lock. And, well, see the LRU isolate function
conversion of this code, becuase it changes how the flags lock is
used for reclaim but I haven't seen any contention as a result of
that change....

> 
> > -	 * Never flush out dirty data during non-blocking reclaim, as it would
> > -	 * just contend with AIL pushing trying to do the same job.
> > +	 * If it is pinned, we only want to flush this if there's nothing else
> > +	 * to be flushed as it requires a log force. Hence we essentially set
> > +	 * the LSN to flush the entire AIL which will end up triggering a log
> > +	 * force to unpin this inode, but that will only happen if there are not
> > +	 * other inodes in the scan that only need writeback.
> >  	 */
> > -	if (!(sync_mode & SYNC_WAIT))
> > +	if (xfs_ipincount(ip)) {
> > +		*lsn = ip->i_itemp->ili_last_lsn;
> 
> ->ili_last_lsn comes from xfs_cil_ctx->sequence, which I don't think is
> actually a physical LSN suitable for AIL pushing. The lsn assigned to
> the item once it's physically logged and AIL inserted comes from
> ctx->start_lsn, which comes from the iclog header and so is a physical
> LSN.

Yup, I've already noticed and fixed that bug :)

> >  	while ((pag = xfs_perag_get_tag(mp, ag, XFS_ICI_RECLAIM_TAG))) {
> >  		unsigned long	first_index = 0;
> >  		int		done = 0;
> >  		int		nr_found = 0;
> >  
> >  		ag = pag->pag_agno + 1;
> > -
> > -		if (trylock) {
> > -			if (!mutex_trylock(&pag->pag_ici_reclaim_lock)) {
> > -				skipped++;
> > -				xfs_perag_put(pag);
> > -				continue;
> > -			}
> > -			first_index = pag->pag_ici_reclaim_cursor;
> > -		} else
> > -			mutex_lock(&pag->pag_ici_reclaim_lock);
> 
> I understand that the eliminated blocking drops a dependency on the
> perag reclaim exclusion as described by the commit log, but I'm not sure
> it's enough to justify removing it entirely. For one, the reclaim cursor
> management looks potentially racy.

We really don't care if the cursor updates are racy. All that will
result in is some inode ranges being scanned twice in quick
succession. All this does now is prevent reclaim from starting at
the start of the AG every time it runs, so we end up with most
reclaimers iterating over previously unscanned inodes.

> Also, doesn't this exclusion provide
> some balance for reclaim across AGs? E.g., if a bunch of reclaim threads
> come in at the same time, this allows them to walk across AGs instead of
> potentially stumbling over eachother in the batching/grabbing code.

What they do now is leapfrog each other and work through the same
AGs much faster. The overall pattern of reclaim doesn't actually
change much, just the speed at which individual AGs are scanned.

But that was not what the locking was put in place for. THe locking
was put in place to be able to throttle the number of concurrent
reclaimers issuing IO. If the reclaimers leapfrogged like they do
without the locking, then we end up with non-sequential inode
writeback patterns, and writeback performance goes really bad,
really quickly. Hence the locking is there to ensure we get
sequential inode writeback patterns from each AG that is being
reclaimed from. That can be optimised by block layer merging, and so
even though we might have a lot of concurrent reclaimers, we get
lots of large, well-formed IOs from each of them.

IOWs, the locking was all about preventing the IO patterns from
breaking down under memory pressure, not about optimising how
reclaimers interact with each other.

> I see again that most of this code seems to ultimately go away, replaced
> by an LRU mechanism so we no longer operate on a per-ag basis. I can see
> how this becomes irrelevant with that mechanism, but I think it might
> make more sense to drop this locking along with the broader mechanism in
> the last patch or two of the series rather than doing it here.

Fundamentally, this patch is all about shifting the IO and blocking
mechanisms to the AIL. This locking is no longer necessary, and it
actually gets in the way of doing non-blocking reclaim and shifting
the IO to the AIL. i.e. we block where we no longer need to, and
that causes more problems for this change than it solves.

> If
> nothing else, that eliminates the need for the reviewer to consider this
> transient "old mechanism + new locking" state as opposed to reasoning
> about the old mechanism vs. new mechanism and why the old locking simply
> no longer applies.

I think you're putting to much "make every step of the transition
perfect" focus on this. We've got to drop this locking to make
reclaim non-blocking, and we have to make reclaim non-blocking
before we can move to a LRU mechanisms that relies on LRU removal
being completely non-blocking and cannot issue IO. It's a waste of
time trying to break this down further and further into "perfect"
patches - it works well enough and without functional regressions so
it does not create landmines for people doing bisects, and that's
largely all that matters in the middle of a large patchset that is
making large algorithm changes...

> > +		first_index = pag->pag_ici_reclaim_cursor;
> >  
> >  		do {
> >  			struct xfs_inode *batch[XFS_LOOKUP_BATCH];
> ...
> > diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
> > index 00d66175f41a..5802139f786b 100644
> > --- a/fs/xfs/xfs_trans_ail.c
> > +++ b/fs/xfs/xfs_trans_ail.c
> > @@ -676,8 +676,10 @@ xfs_ail_push_sync(
> >  	spin_lock(&ailp->ail_lock);
> >  	while ((lip = xfs_ail_min(ailp)) != NULL) {
> >  		prepare_to_wait(&ailp->ail_push, &wait, TASK_UNINTERRUPTIBLE);
> > +	trace_printk("lip lsn 0x%llx thres 0x%llx targ 0x%llx",
> > +			lip->li_lsn, threshold_lsn, ailp->ail_target);
> >  		if (XFS_FORCED_SHUTDOWN(ailp->ail_mount) ||
> > -		    XFS_LSN_CMP(threshold_lsn, lip->li_lsn) <= 0)
> > +		    XFS_LSN_CMP(threshold_lsn, lip->li_lsn) < 0)
> >  			break;
> 
> Stale/mislocated changes?

I've already cleaned that one up, too.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
