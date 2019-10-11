Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A81ADD46C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 19:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbfJKRij (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 13:38:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32760 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728547AbfJKRii (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 13:38:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 272E718CB90E;
        Fri, 11 Oct 2019 17:38:38 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 88EC660BF4;
        Fri, 11 Oct 2019 17:38:37 +0000 (UTC)
Date:   Fri, 11 Oct 2019 13:38:35 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 20/26] xfs: use AIL pushing for inode reclaim IO
Message-ID: <20191011173835.GA64237@bfoster>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-21-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009032124.10541-21-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Fri, 11 Oct 2019 17:38:38 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 02:21:18PM +1100, Dave Chinner wrote:
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
> dirty inodes and block waiting on the same IO to complete.
> 
> Hence direct reclaim will be throttled directly by the rate at which
> dirty inodes are cleaned by AIL pushing, rather than by delays
> caused by competing IO submissions. This allows us to remove all the
> locking that limits direct reclaim concurrency and greatly
> simplifies the inode reclaim code now that it just skips dirty
> inodes.
> 

The above couple paragraphs should probably change to explain the
modified locking since the locking is no longer completely removed. 

Otherwise, just a few small things..

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
>  fs/xfs/xfs_icache.c | 215 +++++++++++++++++++-------------------------
>  1 file changed, 90 insertions(+), 125 deletions(-)
> 
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index 7e175304e146..ed996b37bda0 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
...
> @@ -967,28 +968,42 @@ xfs_inode_ag_iterator_tag(
...
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

"return the it's position ..." ?

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
> @@ -1050,92 +1065,64 @@ xfs_reclaim_inode_grab(
...
> -STATIC int
> +STATIC bool
>  xfs_reclaim_inode(
>  	struct xfs_inode	*ip,
>  	struct xfs_perag	*pag,
> -	int			sync_mode)
> +	xfs_lsn_t		*lsn)
>  {
...
>  
>  	/*
> -	 * Never flush out dirty data during non-blocking reclaim, as it would
> -	 * just contend with AIL pushing trying to do the same job.
> +	 * If it is pinned, we don't have an LSN we can push the AIL to - just
> +	 * an LSN that we can push the CIL with. We don't want to block doing
> +	 * that, so we'll just skip over this one without triggering writeback
> +	 * for now.
>  	 */
> -	if (!(sync_mode & SYNC_WAIT))
> +	if (xfs_ipincount(ip))
>  		goto out_ifunlock;

Hmm, so this seems slightly inconsistent with the grab codepath in terms
of how we handle the lsn of a pinned inode. Here, we ignore the li_lsn
of a pinned inode even though it may very well be in the AIL. However in
the _grab() case, we consider li_lsn whenever the inode is !clean (even
though it may be pinned).

TBH I'm not really convinced it matters which approach we use in the
bigger picture, but it would be good to have consistent logic either
way. Just dropping the pin check from here is probably the most simple
thing since we no longer do I/O from reclaim.

>  
...
> @@ -1205,44 +1186,34 @@ xfs_reclaim_inode(
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
...
>  		do {
>  			struct xfs_inode *batch[XFS_LOOKUP_BATCH];
>  			int	i;
>  
> +			mutex_lock(&pag->pag_ici_reclaim_lock);
> +			first_index = pag->pag_ici_reclaim_cursor;
> +
>  			rcu_read_lock();
>  			nr_found = radix_tree_gang_lookup_tag(
>  					&pag->pag_ici_root,

We need to unlock ->pag_ici_reclaim_lock in the !nr_found case before we
break out of the loop.

> @@ -1262,9 +1233,13 @@ xfs_reclaim_inodes_ag(
>  			for (i = 0; i < nr_found; i++) {
>  				struct xfs_inode *ip = batch[i];
>  
> -				if (done || xfs_reclaim_inode_grab(ip, flags))
> +				if (done ||
> +				    !xfs_reclaim_inode_grab(ip, flags, &lsn))
>  					batch[i] = NULL;
>  
> +				if (lsn && XFS_LSN_CMP(lsn, lowest_lsn) < 0)
> +					lowest_lsn = lsn;

FWIW, this is a little tricky in that xfs_lsn_t is signed and
NULLCOMMITLSN is -1. It works because [CYCLE|BLOCK]_LSN() cast to uint,
but it might be worth checking for lowest_lsn == NULLCOMMITLSN
explicitly as done in other places.

Brian

> +
>  				/*
>  				 * Update the index for the next lookup. Catch
>  				 * overflows into the next AG range which can
> @@ -1289,41 +1264,33 @@ xfs_reclaim_inodes_ag(
>  
>  			/* unlock now we've grabbed the inodes. */
>  			rcu_read_unlock();
> +			if (!done)
> +				pag->pag_ici_reclaim_cursor = first_index;
> +			else
> +				pag->pag_ici_reclaim_cursor = 0;
> +			mutex_unlock(&pag->pag_ici_reclaim_lock);
>  
>  			for (i = 0; i < nr_found; i++) {
>  				if (!batch[i])
>  					continue;
> -				error = xfs_reclaim_inode(batch[i], pag, flags);
> -				if (error && last_error != -EFSCORRUPTED)
> -					last_error = error;
> +				if (xfs_reclaim_inode(batch[i], pag, &lsn))
> +					freed++;
> +				if (lsn && XFS_LSN_CMP(lsn, lowest_lsn) < 0)
> +					lowest_lsn = lsn;
>  			}
>  
> -			*nr_to_scan -= XFS_LOOKUP_BATCH;
> -
> +			nr_to_scan -= XFS_LOOKUP_BATCH;
>  			cond_resched();
>  
> -		} while (nr_found && !done && *nr_to_scan > 0);
> +		} while (nr_found && !done && nr_to_scan > 0);
>  
> -		if (trylock && !done)
> -			pag->pag_ici_reclaim_cursor = first_index;
> -		else
> -			pag->pag_ici_reclaim_cursor = 0;
> -		mutex_unlock(&pag->pag_ici_reclaim_lock);
>  		xfs_perag_put(pag);
>  	}
>  
> -	/*
> -	 * if we skipped any AG, and we still have scan count remaining, do
> -	 * another pass this time using blocking reclaim semantics (i.e
> -	 * waiting on the reclaim locks and ignoring the reclaim cursors). This
> -	 * ensure that when we get more reclaimers than AGs we block rather
> -	 * than spin trying to execute reclaim.
> -	 */
> -	if (skipped && (flags & SYNC_WAIT) && *nr_to_scan > 0) {
> -		trylock = 0;
> -		goto restart;
> -	}
> -	return last_error;
> +	if ((flags & SYNC_WAIT) && lowest_lsn != NULLCOMMITLSN)
> +		xfs_ail_push_sync(mp->m_ail, lowest_lsn);
> +
> +	return freed;
>  }
>  
>  int
> @@ -1331,9 +1298,7 @@ xfs_reclaim_inodes(
>  	xfs_mount_t	*mp,
>  	int		mode)
>  {
> -	int		nr_to_scan = INT_MAX;
> -
> -	return xfs_reclaim_inodes_ag(mp, mode, &nr_to_scan);
> +	return xfs_reclaim_inodes_ag(mp, mode, INT_MAX);
>  }
>  
>  /*
> @@ -1350,7 +1315,7 @@ xfs_reclaim_inodes_nr(
>  	struct xfs_mount	*mp,
>  	int			nr_to_scan)
>  {
> -	int			sync_mode = SYNC_TRYLOCK;
> +	int			sync_mode = 0;
>  
>  	/*
>  	 * For kswapd, we kick background inode writeback. For direct
> @@ -1362,7 +1327,7 @@ xfs_reclaim_inodes_nr(
>  	else
>  		sync_mode |= SYNC_WAIT;
>  
> -	return xfs_reclaim_inodes_ag(mp, sync_mode, &nr_to_scan);
> +	return xfs_reclaim_inodes_ag(mp, sync_mode, nr_to_scan);
>  }
>  
>  /*
> -- 
> 2.23.0.rc1
> 
