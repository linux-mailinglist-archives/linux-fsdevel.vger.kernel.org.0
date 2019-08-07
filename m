Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A112852B2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2019 20:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389174AbfHGSJT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Aug 2019 14:09:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388029AbfHGSJT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Aug 2019 14:09:19 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 42FE62F366C;
        Wed,  7 Aug 2019 18:09:18 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A2BD010016E8;
        Wed,  7 Aug 2019 18:09:17 +0000 (UTC)
Date:   Wed, 7 Aug 2019 14:09:15 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 20/24] xfs: use AIL pushing for inode reclaim IO
Message-ID: <20190807180915.GA20425@bfoster>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-21-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801021752.4986-21-david@fromorbit.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 07 Aug 2019 18:09:18 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 01, 2019 at 12:17:48PM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Inode reclaim currently issues it's own inode IO when it comes
> across dirty inodes. This is used to throttle direct reclaim down to
> the rate at which we can reclaim dirty inodes. Failure to throttle
> in this manner results in the OOM killer being trivial to trigger
> even when there is lots of free memory available.
> 
> However, having direct reclaimers issue IO causes an amount of
> IO thrashing to occur. We can have up to the number of AGs in the
> filesystem concurrently issuing IO, plus the AIL pushing thread as
> well. This means we can many competing sources of IO and they all
> end up thrashing and competing for the request slots in the block
> device.
> 
> Similar to dirty page throttling and the BDI flusher thread, we can
> use the AIL pushing thread the sole place we issue inode writeback
> from and everything else waits for it to make progress. To do this,
> reclaim will skip over dirty inodes, but in doing so will record the
> lowest LSN of all the dirty inodes it skips. It will then push the
> AIL to this LSN and wait for it to complete that work.
> 
> In doing so, we block direct reclaim on the IO of at least one IO,
> thereby providing some level of throttling for when we encounter
> dirty inodes. However we gain the ability to scan and reclaim
> clean inodes in a non-blocking fashion. This allows us to
> remove all the per-ag reclaim locking that avoids excessive direct
> reclaim, as repeated concurrent direct reclaim will hit the same
> dirty inodes on block waiting on the same IO to complete.
> 

The last part of the above sentence sounds borked..

> Hence direct reclaim will be throttled directly by the rate at which
> dirty inodes are cleaned by AIL pushing, rather than by delays
> caused by competing IO submissions. This allows us to remove all the
> locking that limits direct reclaim concurrency and greatly
> simplifies the inode reclaim code now that it just skips dirty
> inodes.
> 
> Note: this patch by itself isn't completely able to throttle direct
> reclaim sufficiently to prevent OOM killer madness. We can't do that
> until we change the way we index reclaimable inodes in the next
> patch and can feed back state to the mm core sanely.  However, we
> can't change the way we index reclaimable inodes until we have
> IO-less non-blocking reclaim for both direct reclaim and kswapd
> reclaim.  Catch-22...
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  fs/xfs/xfs_icache.c    | 208 +++++++++++++++++------------------------
>  fs/xfs/xfs_mount.c     |   4 -
>  fs/xfs/xfs_mount.h     |   1 -
>  fs/xfs/xfs_trans_ail.c |   4 +-
>  4 files changed, 90 insertions(+), 127 deletions(-)
> 
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index 0bd4420a7e16..4c4c5bc12147 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -22,6 +22,7 @@
>  #include "xfs_dquot_item.h"
>  #include "xfs_dquot.h"
>  #include "xfs_reflink.h"
> +#include "xfs_log.h"
>  
>  #include <linux/iversion.h>
>  
> @@ -967,28 +968,42 @@ xfs_inode_ag_iterator_tag(
>  }
>  
>  /*
> - * Grab the inode for reclaim exclusively.
> - * Return 0 if we grabbed it, non-zero otherwise.
> + * Grab the inode for reclaim.
> + *
> + * Return false if we aren't going to reclaim it, true if it is a reclaim
> + * candidate.
> + *
> + * If the inode is clean or unreclaimable, return NULLCOMMITLSN to tell the
> + * caller it does not require flushing. Otherwise return the log item lsn of the
> + * inode so the caller can determine it's inode flush target.  If we get the
> + * clean/dirty state wrong then it will be sorted in xfs_reclaim_inode() once we
> + * have locks held.
>   */
> -STATIC int
> +STATIC bool
>  xfs_reclaim_inode_grab(
>  	struct xfs_inode	*ip,
> -	int			flags)
> +	int			flags,
> +	xfs_lsn_t		*lsn)
>  {
>  	ASSERT(rcu_read_lock_held());
> +	*lsn = 0;

The comment above says we return NULLCOMMITLSN. Given the rest of the
code, I'm assuming we should just fix up the comment.

>  
>  	/* quick check for stale RCU freed inode */
>  	if (!ip->i_ino)
> -		return 1;
> +		return false;
>  
>  	/*
> -	 * If we are asked for non-blocking operation, do unlocked checks to
> -	 * see if the inode already is being flushed or in reclaim to avoid
> -	 * lock traffic.
> +	 * Do unlocked checks to see if the inode already is being flushed or in
> +	 * reclaim to avoid lock traffic. If the inode is not clean, return the
> +	 * it's position in the AIL for the caller to push to.
>  	 */
> -	if ((flags & SYNC_TRYLOCK) &&
> -	    __xfs_iflags_test(ip, XFS_IFLOCK | XFS_IRECLAIM))
> -		return 1;
> +	if (!xfs_inode_clean(ip)) {
> +		*lsn = ip->i_itemp->ili_item.li_lsn;
> +		return false;
> +	}
> +
> +	if (__xfs_iflags_test(ip, XFS_IFLOCK | XFS_IRECLAIM))
> +		return false;
>  
>  	/*
>  	 * The radix tree lock here protects a thread in xfs_iget from racing
...
> @@ -1050,92 +1065,67 @@ xfs_reclaim_inode_grab(
>   *	clean		=> reclaim
>   *	dirty, async	=> requeue
>   *	dirty, sync	=> flush, wait and reclaim
> + *
> + * Returns true if the inode was reclaimed, false otherwise.
>   */
> -STATIC int
> +STATIC bool
>  xfs_reclaim_inode(
>  	struct xfs_inode	*ip,
>  	struct xfs_perag	*pag,
> -	int			sync_mode)
> +	xfs_lsn_t		*lsn)
>  {
> -	struct xfs_buf		*bp = NULL;
> -	xfs_ino_t		ino = ip->i_ino; /* for radix_tree_delete */
> -	int			error;
> +	xfs_ino_t		ino;
> +
> +	*lsn = 0;
>  
> -restart:
> -	error = 0;
>  	/*
>  	 * Don't try to flush the inode if another inode in this cluster has
>  	 * already flushed it after we did the initial checks in
>  	 * xfs_reclaim_inode_grab().
>  	 */
> -	if (sync_mode & SYNC_TRYLOCK) {
> -		if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL))
> -			goto out;
> -		if (!xfs_iflock_nowait(ip))
> -			goto out_unlock;
> -	} else {
> -		xfs_ilock(ip, XFS_ILOCK_EXCL);
> -		if (!xfs_iflock_nowait(ip)) {
> -			if (!(sync_mode & SYNC_WAIT))
> -				goto out_unlock;
> -			xfs_iflock(ip);
> -		}
> -	}
> +	if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL))
> +		goto out;
> +	if (!xfs_iflock_nowait(ip))
> +		goto out_unlock;
>  

Do we even need the flush lock here any more if we're never going to
flush from this context? The shutdown case just below notwithstanding
(which I'm also wondering if we should just drop given we abort from
xfs_iflush() on shutdown), the pin count is an atomic and the dirty
state changes under ilock.

Maybe I'm missing something else, but the reason I ask is that the
increased flush lock contention in codepaths that don't actually flush
once it's acquired gives me a bit of concern that we could reduce
effectiveness of the one task that actually does (xfsaild).

> +	/* If we are in shutdown, we don't care about blocking. */
>  	if (XFS_FORCED_SHUTDOWN(ip->i_mount)) {
>  		xfs_iunpin_wait(ip);
>  		/* xfs_iflush_abort() drops the flush lock */
>  		xfs_iflush_abort(ip, false);
>  		goto reclaim;
>  	}
> -	if (xfs_ipincount(ip)) {
> -		if (!(sync_mode & SYNC_WAIT))
> -			goto out_ifunlock;
> -		xfs_iunpin_wait(ip);
> -	}
> -	if (xfs_iflags_test(ip, XFS_ISTALE) || xfs_inode_clean(ip)) {
> -		xfs_ifunlock(ip);
> -		goto reclaim;
> -	}
>  
>  	/*
> -	 * Never flush out dirty data during non-blocking reclaim, as it would
> -	 * just contend with AIL pushing trying to do the same job.
> +	 * If it is pinned, we only want to flush this if there's nothing else
> +	 * to be flushed as it requires a log force. Hence we essentially set
> +	 * the LSN to flush the entire AIL which will end up triggering a log
> +	 * force to unpin this inode, but that will only happen if there are not
> +	 * other inodes in the scan that only need writeback.
>  	 */
> -	if (!(sync_mode & SYNC_WAIT))
> +	if (xfs_ipincount(ip)) {
> +		*lsn = ip->i_itemp->ili_last_lsn;

->ili_last_lsn comes from xfs_cil_ctx->sequence, which I don't think is
actually a physical LSN suitable for AIL pushing. The lsn assigned to
the item once it's physically logged and AIL inserted comes from
ctx->start_lsn, which comes from the iclog header and so is a physical
LSN.

That said, this usage of ili_last_lsn seems to disappear by the end of
the series...

>  		goto out_ifunlock;
> +	}
>  
...
> @@ -1205,39 +1189,28 @@ xfs_reclaim_inode(
>   * corrupted, we still want to try to reclaim all the inodes. If we don't,
>   * then a shut down during filesystem unmount reclaim walk leak all the
>   * unreclaimed inodes.
> + *
> + * Return the number of inodes freed.
>   */
>  STATIC int
>  xfs_reclaim_inodes_ag(
>  	struct xfs_mount	*mp,
>  	int			flags,
> -	int			*nr_to_scan)
> +	int			nr_to_scan)
>  {
>  	struct xfs_perag	*pag;
> -	int			error = 0;
> -	int			last_error = 0;
>  	xfs_agnumber_t		ag;
> -	int			trylock = flags & SYNC_TRYLOCK;
> -	int			skipped;
> +	xfs_lsn_t		lsn, lowest_lsn = NULLCOMMITLSN;
> +	long			freed = 0;
>  
> -restart:
>  	ag = 0;
> -	skipped = 0;
>  	while ((pag = xfs_perag_get_tag(mp, ag, XFS_ICI_RECLAIM_TAG))) {
>  		unsigned long	first_index = 0;
>  		int		done = 0;
>  		int		nr_found = 0;
>  
>  		ag = pag->pag_agno + 1;
> -
> -		if (trylock) {
> -			if (!mutex_trylock(&pag->pag_ici_reclaim_lock)) {
> -				skipped++;
> -				xfs_perag_put(pag);
> -				continue;
> -			}
> -			first_index = pag->pag_ici_reclaim_cursor;
> -		} else
> -			mutex_lock(&pag->pag_ici_reclaim_lock);

I understand that the eliminated blocking drops a dependency on the
perag reclaim exclusion as described by the commit log, but I'm not sure
it's enough to justify removing it entirely. For one, the reclaim cursor
management looks potentially racy. Also, doesn't this exclusion provide
some balance for reclaim across AGs? E.g., if a bunch of reclaim threads
come in at the same time, this allows them to walk across AGs instead of
potentially stumbling over eachother in the batching/grabbing code.

I see again that most of this code seems to ultimately go away, replaced
by an LRU mechanism so we no longer operate on a per-ag basis. I can see
how this becomes irrelevant with that mechanism, but I think it might
make more sense to drop this locking along with the broader mechanism in
the last patch or two of the series rather than doing it here. If
nothing else, that eliminates the need for the reviewer to consider this
transient "old mechanism + new locking" state as opposed to reasoning
about the old mechanism vs. new mechanism and why the old locking simply
no longer applies.

> +		first_index = pag->pag_ici_reclaim_cursor;
>  
>  		do {
>  			struct xfs_inode *batch[XFS_LOOKUP_BATCH];
...
> diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
> index 00d66175f41a..5802139f786b 100644
> --- a/fs/xfs/xfs_trans_ail.c
> +++ b/fs/xfs/xfs_trans_ail.c
> @@ -676,8 +676,10 @@ xfs_ail_push_sync(
>  	spin_lock(&ailp->ail_lock);
>  	while ((lip = xfs_ail_min(ailp)) != NULL) {
>  		prepare_to_wait(&ailp->ail_push, &wait, TASK_UNINTERRUPTIBLE);
> +	trace_printk("lip lsn 0x%llx thres 0x%llx targ 0x%llx",
> +			lip->li_lsn, threshold_lsn, ailp->ail_target);
>  		if (XFS_FORCED_SHUTDOWN(ailp->ail_mount) ||
> -		    XFS_LSN_CMP(threshold_lsn, lip->li_lsn) <= 0)
> +		    XFS_LSN_CMP(threshold_lsn, lip->li_lsn) < 0)
>  			break;

Stale/mislocated changes?

Brian

>  		/* XXX: cmpxchg? */
>  		while (XFS_LSN_CMP(threshold_lsn, ailp->ail_target) > 0)
> -- 
> 2.22.0
> 
