Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9A35D6365
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2019 15:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbfJNNHX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Oct 2019 09:07:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfJNNHW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:07:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A56F30ADBC0;
        Mon, 14 Oct 2019 13:07:22 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D0F760468;
        Mon, 14 Oct 2019 13:07:21 +0000 (UTC)
Date:   Mon, 14 Oct 2019 09:07:19 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 25/26] xfs: rework unreferenced inode lookups
Message-ID: <20191014130719.GE12380@bfoster>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-26-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009032124.10541-26-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 14 Oct 2019 13:07:22 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 02:21:23PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Looking up an unreferenced inode in the inode cache is a bit hairy.
> We do this for inode invalidation and writeback clustering purposes,
> which is all invisible to the VFS. Hence we can't take reference
> counts to the inode and so must be very careful how we do it.
> 
> There are several different places that all do the lookups and
> checks slightly differently. Fundamentally, though, they are all
> racy and inode reclaim has to block waiting for the inode lock if it
> loses the race. This is not very optimal given all the work we;ve
> already done to make reclaim non-blocking.
> 
> We can make the reclaim process nonblocking with a couple of simple
> changes. If we define the unreferenced lookup process in a way that
> will either always grab an inode in a way that reclaim will notice
> and skip, or will notice a reclaim has grabbed the inode so it can
> skip the inode, then there is no need for reclaim to need to cycle
> the inode ILOCK at all.
> 
> Selecting an inode for reclaim is already non-blocking, so if the
> ILOCK is held the inode will be skipped. If we ensure that reclaim
> holds the ILOCK until the inode is freed, then we can do the same
> thing in the unreferenced lookup to avoid inodes in reclaim. We can
> do this simply by holding the ILOCK until the RCU grace period
> expires and the inode freeing callback is run. As all unreferenced
> lookups have to hold the rcu_read_lock(), we are guaranteed that
> a reclaimed inode will be noticed as the trylock will fail.
> 
> 
> Additional research notes on final reclaim locking before free
> --------------------------------------------------------------
> 
> 2016: 1f2dcfe89eda ("xfs: xfs_inode_free() isn't RCU safe")
> 
> Fixes situation where the inode is found during RCU lookup within
> the freeing grace period, but critical structures have already been
> freed. lookup code that has this problem is stuff like
> xfs_iflush_cluster.
> 
> 
> 2008: 455486b9ccdd ("[XFS] avoid all reclaimable inodes in xfs_sync_inodes_ag")
> 
> Prior to this commit, the flushing of inodes required serialisation
> with xfs_ireclaim(), which did this lock/unlock thingy to ensure
> that it waited for flushing in xfs_sync_inodes_ag() to complete
> before freeing the inode:
> 
>                 /*
> -                * If we can't get a reference on the VFS_I, the inode must be
> -                * in reclaim. If we can get the inode lock without blocking,
> -                * it is safe to flush the inode because we hold the tree lock
> -                * and xfs_iextract will block right now. Hence if we lock the
> -                * inode while holding the tree lock, xfs_ireclaim() is
> -                * guaranteed to block on the inode lock we now hold and hence
> -                * it is safe to reference the inode until we drop the inode
> -                * locks completely.
> +                * If we can't get a reference on the inode, it must be
> +                * in reclaim. Leave it for the reclaim code to flush.
>                  */
> 
> This case is completely gone from the modern code.
> 
> lock/unlock exists at start of git era. Switching to archive tree.
> 
> This xfs_sync() functionality goes back to 1994 when inode
> writeback was first introduced by:
> 
> 47ac6d60 ("Add support to xfs_ireclaim() needed for xfs_sync().")
> 
> So it has been there forever -  lets see if we can get rid of it.
> State of existing codeL
> 
> - xfs_iflush_cluster() does not check for XFS_IRECLAIM inode flag
>   while holding rcu_read_lock()/i_flags_lock, so doesn't avoid
>   reclaimable or inodes that are in the process of being reclaimed.
>   Inodes at this point of reclaim are clean, so if xfs_iflush_cluster
>   wins the race to the ILOCK, then inode reclaim has to wait
>   for the lock to be dropped by xfs_iflush_cluster() once it detects
>   the inode is clean.
> 

Ok, so the iflush/ifree clustering functionality doesn't account for
inodes under reclaim, thus has the potential to contend with reclaim in
progress via ilock. The new isolate function trylocks the ilock and
iflock to check dirty state and whatnot before it sets XFS_IRECLAIM and
continues scanning, so we aren't blocking through that code. Both of
those locks are held until the dispose, where ->i_ino is zeroed and
ilock released.

I'd think at this point a racing iflush/ifree would see the ->i_ino
update. If I'm following this correctly, blocking in reclaim would
require a race where iflush gets ->i_flags_lock and sees a valid
->i_ino, a reclaim in progress is waiting on ->i_flags_lock to reset
->i_ino, iflush releases ->i_flags_lock in time for reclaim to acquire
it, reset ->i_ino and then release ilock before the iflush ilock_nowait
fails (since reclaim still has it) or reclaim itself reacquires it. At
that point, reclaim blocks on ilock and ends up waiting on iflush to
identify that ->i_ino is zero and drop the lock. Am I following that
correctly?

If so, then to avoid that race condition (this sounds more like a lock
contention inefficiency than a blocking problem), we hold the ilock in
reclaim until the inode is freed to guarantee that iflush/ifree cannot
ever access an inode that is about to be freed. I need to stare at the
code some more, but that seems reasonable to me in principle.

Brian

> - xfs_ifree_cluster() has similar logic based around XFS_ISTALE,
>   results in similar race conditions that require inode reclaim to
>   cycle the ILOCK to serialise against.
> 
> - xfs_inode_ag_walk() uses xfs_inode_ag_walk_grab(), and it checks
>   XFS_IRECLAIM under RCU. It then tries to take a reference to the
>   VFS inode via igrab(), which will fail if the inode is either
>   XFS_IRECLAIMABLE | XFS_IRECLAIM, and it if races then igrab() will
>   fail because the inode has I_FREEING still set, so it's protected
>   against reclaim races.
> 
> That leaves xfs_iflush_cluster() + xfs_ifree_cluster() to be
> modified to do reclaim-safe lookups. W.r.t. new inode reclaim LRU
> isolate function:
> 
> 	1. inode can be referenced while rcu_read_lock() is held.
> 
> 	2. XFS_IRECLAIM means inode has been fully locked down and
> 	   has placed on the dispose list, and will be freed soon.
> 		- ilock_nowait() will fail once IRECLAIM is set due
> 		  to lock order in isolation code.
> 
> 	3. ip->i_ino == 0 means it's been removed from the dispose
> 	   list and is about to or has been removed from the radix
> 	   tree and may have already been queued on the rcu freeing
> 	   list to be freed at the end of the current grace period.
> 
> 		- the old xfs_ireclaim() code will have dropped the
> 		  ILOCK here, and so there's a race between checking
> 		  IRECLAIM, grabbing ilock_nowait() and reclaim
> 		  freeing the inode.
> 		- this is what the spurious lock/unlock avoids.
> 
> 	4. it xfs_ilock_nowait() fails until the rcu grace period
> 	   expires, it doesn't matter if we race between checking
> 	   IRECLAIM and failing the lock attempt. In fact, we don't
> 	   even have to check XFS_IRECLAIM - just failing
> 	   xfs_ilock_nowait() is sufficient to avoid inodes being
> 	   reclaimed.
> 
> 	   Hence when xfs_ilock_nowait() fails, we can either drop the
> 	   rcu_read_lock at that point and restart the inode lookup,
> 	   or we just skip the inode altogether. If we raced with
> 	   reclaim, the retry will not find the inode in reclaim
> 	   again. If we raced wtih some other lock holder, then
> 	   we'll find the inode and try to lock it again.
> 
> 		- Requires holding ILOCK into rcu freeing callback
> 		  and dropping it there. i.e. inode to be reclaimed
> 		  remains locked until grace period expires.
> 		- No window at all between IRECLAIM being set and
> 		  visible to other CPUs and the inode being removed
> 		  from the cache and freed where ilock_nowait will
> 		  succeed.
> 		- simple, effective, reliable.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  fs/xfs/xfs_icache.c |  86 ++++++++++++++++++++++-------
>  fs/xfs/xfs_inode.c  | 131 +++++++++++++++++++++-----------------------
>  2 files changed, 126 insertions(+), 91 deletions(-)
> 
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index a6de159c71c2..7a507aefeea6 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -105,6 +105,7 @@ xfs_inode_free_callback(
>  		ip->i_itemp = NULL;
>  	}
>  
> +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>  	kmem_zone_free(xfs_inode_zone, ip);
>  }
>  
> @@ -131,6 +132,7 @@ xfs_inode_free(
>  	 * free state. The ip->i_flags_lock provides the barrier against lookup
>  	 * races.
>  	 */
> +	xfs_ilock(ip, XFS_ILOCK_EXCL);
>  	spin_lock(&ip->i_flags_lock);
>  	ip->i_flags = XFS_IRECLAIM;
>  	ip->i_ino = 0;
> @@ -294,11 +296,24 @@ xfs_iget_cache_hit(
>  		}
>  
>  		/*
> -		 * We need to set XFS_IRECLAIM to prevent xfs_reclaim_inode
> -		 * from stomping over us while we recycle the inode. Remove it
> -		 * from the LRU straight away so we can re-init the VFS inode.
> +		 * Before we reinitialise the inode, we need to make sure
> +		 * reclaim does not pull it out from underneath us. We already
> +		 * hold the i_flags_lock, and because the XFS_IRECLAIM is not
> +		 * set we know the inode is still on the LRU. However, the LRU
> +		 * code may have just selected this inode to reclaim, so we need
> +		 * to ensure we hold the i_flags_lock long enough for the
> +		 * trylock in xfs_inode_reclaim_isolate() to fail. We do this by
> +		 * removing the inode from the LRU, which will spin on the LRU
> +		 * list locks until reclaim stops walking, at which point we
> +		 * know there is no possible race between reclaim isolation and
> +		 * this lookup.
> +		 *
> +		 * We also set the XFS_IRECLAIM flag here while trying to do the
> +		 * re-initialisation to prevent multiple racing lookups on this
> +		 * inode from all landing here at the same time.
>  		 */
>  		ip->i_flags |= XFS_IRECLAIM;
> +		list_lru_del(&mp->m_inode_lru, &inode->i_lru);
>  		spin_unlock(&ip->i_flags_lock);
>  		rcu_read_unlock();
>  
> @@ -312,7 +327,8 @@ xfs_iget_cache_hit(
>  			rcu_read_lock();
>  			spin_lock(&ip->i_flags_lock);
>  			wake = !!__xfs_iflags_test(ip, XFS_INEW);
> -			ip->i_flags &= ~(XFS_INEW | XFS_IRECLAIM);
> +			ip->i_flags &= ~XFS_INEW | XFS_IRECLAIM;
> +			list_lru_add(&mp->m_inode_lru, &inode->i_lru);
>  			if (wake)
>  				wake_up_bit(&ip->i_flags, __XFS_INEW_BIT);
>  			ASSERT(ip->i_flags & XFS_IRECLAIMABLE);
> @@ -329,7 +345,6 @@ xfs_iget_cache_hit(
>  		spin_lock(&ip->i_flags_lock);
>  		ip->i_flags &= ~XFS_IRECLAIM_RESET_FLAGS;
>  		ip->i_flags |= XFS_INEW;
> -		list_lru_del(&mp->m_inode_lru, &inode->i_lru);
>  		inode->i_state = I_NEW;
>  		ip->i_sick = 0;
>  		ip->i_checked = 0;
> @@ -609,8 +624,7 @@ xfs_icache_inode_is_allocated(
>  /*
>   * The inode lookup is done in batches to keep the amount of lock traffic and
>   * radix tree lookups to a minimum. The batch size is a trade off between
> - * lookup reduction and stack usage. This is in the reclaim path, so we can't
> - * be too greedy.
> + * lookup reduction and stack usage.
>   */
>  #define XFS_LOOKUP_BATCH	32
>  
> @@ -967,6 +981,41 @@ xfs_inode_reclaim_isolate(
>  	return ret;
>  }
>  
> +/*
> + * We are passed a locked inode to dispose of.
> + *
> + * To avoid race conditions with lookups that don't take references, we do
> + * not drop the XFS_ILOCK_EXCL until the RCU callback that frees the inode.
> + * This means that any attempt to lock the inode during the current RCU grace
> + * period will fail, and hence we do not need any synchonisation here to wait
> + * for code that pins unreferenced inodes with the XFS_ILOCK to drain.
> + *
> + * This requires code that requires such pins to do the following under a single
> + * rcu_read_lock() context:
> + *
> + *	- rcu_read_lock
> + *	- find the inode via radix tree lookup
> + *	- take the ip->i_flags_lock
> + *	- check ip->i_ino != 0
> + *	- check XFS_IRECLAIM is not set
> + *	- call xfs_ilock_nowait(ip, XFS_ILOCK_[SHARED|EXCL]) to lock the inode
> + *	- drop ip->i_flags_lock
> + *	- rcu_read_unlock()
> + *
> + * Only if all this succeeds and the caller has the inode locked and protected
> + * against it being freed until the ilock is released. If the XFS_IRECLAIM flag
> + * is set or xfs_ilock_nowait() fails, then the caller must either skip the
> + * inode and move on to the next inode (gang lookup) or drop the rcu_read_lock
> + * and start the entire inode lookup process again (individual lookup).
> + *
> + * This works because  i_flags_lock serialises against
> + * xfs_inode_reclaim_isolate() - if the lookup wins the race on i_flags_lock and
> + * XFS_IRECLAIM is not set, then it will be able to lock the inode and hold off
> + * reclaim. If the isolate function wins the race, it will lock the inode and
> + * set the XFS_IRECLAIM flag if it is going to free the inode and this will
> + * prevent the lookup callers from succeeding in getting unreferenced pin via
> + * the ILOCK.
> + */
>  static void
>  xfs_dispose_inode(
>  	struct xfs_inode	*ip)
> @@ -975,11 +1024,14 @@ xfs_dispose_inode(
>  	struct xfs_perag	*pag;
>  	xfs_ino_t		ino;
>  
> +	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
>  	ASSERT(xfs_isiflocked(ip));
>  	ASSERT(xfs_inode_clean(ip) || xfs_iflags_test(ip, XFS_ISTALE) ||
>  	       XFS_FORCED_SHUTDOWN(mp));
>  	ASSERT(ip->i_ino != 0);
>  
> +	XFS_STATS_INC(mp, xs_ig_reclaims);
> +
>  	/*
>  	 * Process the shutdown reclaim work we deferred from the LRU isolation
>  	 * callback before we go any further.
> @@ -1006,9 +1058,7 @@ xfs_dispose_inode(
>  	ip->i_flags = XFS_IRECLAIM;
>  	ip->i_ino = 0;
>  	spin_unlock(&ip->i_flags_lock);
> -	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>  
> -	XFS_STATS_INC(mp, xs_ig_reclaims);
>  	/*
>  	 * Remove the inode from the per-AG radix tree.
>  	 *
> @@ -1023,19 +1073,7 @@ xfs_dispose_inode(
>  	spin_unlock(&pag->pag_ici_lock);
>  	xfs_perag_put(pag);
>  
> -	/*
> -	 * Here we do an (almost) spurious inode lock in order to coordinate
> -	 * with inode cache radix tree lookups.  This is because the lookup
> -	 * can reference the inodes in the cache without taking references.
> -	 *
> -	 * We make that OK here by ensuring that we wait until the inode is
> -	 * unlocked after the lookup before we go ahead and free it.
> -	 *
> -	 * XXX: need to check this is still true. Not sure it is.
> -	 */
> -	xfs_ilock(ip, XFS_ILOCK_EXCL);
>  	xfs_qm_dqdetach(ip);
> -	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>  
>  	__xfs_inode_free(ip);
>  }
> @@ -1062,6 +1100,12 @@ xfs_reclaim_inodes(
>  		struct xfs_ireclaim_args ra;
>  		long freed, to_free;
>  
> +		/* push the AIL to clean dirty reclaimable inodes */
> +		xfs_ail_push_all(mp->m_ail);
> +
> +		/* push the AIL to clean dirty reclaimable inodes */
> +		xfs_ail_push_all(mp->m_ail);
> +
>  		INIT_LIST_HEAD(&ra.freeable);
>  		ra.lowest_lsn = NULLCOMMITLSN;
>  		to_free = list_lru_count(&mp->m_inode_lru);
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 18f4b262e61c..1d7e3f575952 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -2622,52 +2622,54 @@ xfs_ifree_cluster(
>  			}
>  
>  			/*
> -			 * because this is an RCU protected lookup, we could
> -			 * find a recently freed or even reallocated inode
> -			 * during the lookup. We need to check under the
> -			 * i_flags_lock for a valid inode here. Skip it if it
> -			 * is not valid, the wrong inode or stale.
> +			 * See xfs_dispose_inode() for an explanation of the
> +			 * tests here to avoid inode reclaim races.
>  			 */
>  			spin_lock(&ip->i_flags_lock);
> -			if (ip->i_ino != inum + i ||
> -			    __xfs_iflags_test(ip, XFS_ISTALE)) {
> +			if (!ip->i_ino ||
> +			    __xfs_iflags_test(ip, XFS_IRECLAIM)) {
>  				spin_unlock(&ip->i_flags_lock);
>  				rcu_read_unlock();
>  				continue;
>  			}
> -			spin_unlock(&ip->i_flags_lock);
>  
>  			/*
> -			 * Don't try to lock/unlock the current inode, but we
> -			 * _cannot_ skip the other inodes that we did not find
> -			 * in the list attached to the buffer and are not
> -			 * already marked stale. If we can't lock it, back off
> -			 * and retry.
> +			 * The inode isn't in reclaim, but it might be locked by
> +			 * someone else. In that case, we retry the inode rather
> +			 * than skipping it completely.
>  			 */
> -			if (ip != free_ip) {
> -				if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL)) {
> -					rcu_read_unlock();
> -					delay(1);
> -					goto retry;
> -				}
> +			if (ip != free_ip &&
> +			    !xfs_ilock_nowait(ip, XFS_ILOCK_EXCL)) {
> +				spin_unlock(&ip->i_flags_lock);
> +				rcu_read_unlock();
> +				delay(1);
> +				goto retry;
> +			}
>  
> -				/*
> -				 * Check the inode number again in case we're
> -				 * racing with freeing in xfs_reclaim_inode().
> -				 * See the comments in that function for more
> -				 * information as to why the initial check is
> -				 * not sufficient.
> -				 */
> -				if (ip->i_ino != inum + i) {
> +			/*
> +			 * Inode is now pinned against reclaim until we unlock
> +			 * it, so now we can do the work necessary to mark the
> +			 * inode stale and get it held until the cluster freeing
> +			 * transaction is logged. If it's stale, then it has
> +			 * already been attached to the buffer and we're done.
> +			 */
> +			if (__xfs_iflags_test(ip, XFS_ISTALE)) {
> +				spin_unlock(&ip->i_flags_lock);
> +				if (ip != free_ip)
>  					xfs_iunlock(ip, XFS_ILOCK_EXCL);
> -					rcu_read_unlock();
> -					continue;
> -				}
> +				rcu_read_unlock();
> +				continue;
>  			}
> +			__xfs_iflags_set(ip, XFS_ISTALE);
> +			spin_unlock(&ip->i_flags_lock);
>  			rcu_read_unlock();
>  
> +			/*
> +			 * Flush lock will hold off inode reclaim until the
> +			 * buffer completion routine runs the xfs_istale_done
> +			 * callback on the inode and unlocks it.
> +			 */
>  			xfs_iflock(ip);
> -			xfs_iflags_set(ip, XFS_ISTALE);
>  
>  			/*
>  			 * we don't need to attach clean inodes or those only
> @@ -2677,7 +2679,8 @@ xfs_ifree_cluster(
>  			if (!iip || xfs_inode_clean(ip)) {
>  				ASSERT(ip != free_ip);
>  				xfs_ifunlock(ip);
> -				xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +				if (ip != free_ip)
> +					xfs_iunlock(ip, XFS_ILOCK_EXCL);
>  				continue;
>  			}
>  
> @@ -3498,44 +3501,40 @@ xfs_iflush_cluster(
>  			continue;
>  
>  		/*
> -		 * because this is an RCU protected lookup, we could find a
> -		 * recently freed or even reallocated inode during the lookup.
> -		 * We need to check under the i_flags_lock for a valid inode
> -		 * here. Skip it if it is not valid or the wrong inode.
> +		 * See xfs_dispose_inode() for an explanation of the
> +		 * tests here to avoid inode reclaim races.
>  		 */
>  		spin_lock(&cip->i_flags_lock);
>  		if (!cip->i_ino ||
> -		    __xfs_iflags_test(cip, XFS_ISTALE)) {
> +		    __xfs_iflags_test(cip, XFS_IRECLAIM)) {
>  			spin_unlock(&cip->i_flags_lock);
>  			continue;
>  		}
>  
> -		/*
> -		 * Once we fall off the end of the cluster, no point checking
> -		 * any more inodes in the list because they will also all be
> -		 * outside the cluster.
> -		 */
> +		/* ILOCK will pin the inode against reclaim */
> +		if (!xfs_ilock_nowait(cip, XFS_ILOCK_SHARED)) {
> +			spin_unlock(&cip->i_flags_lock);
> +			continue;
> +		}
> +
> +		if (__xfs_iflags_test(cip, XFS_ISTALE)) {
> +			xfs_iunlock(cip, XFS_ILOCK_SHARED);
> +			spin_unlock(&cip->i_flags_lock);
> +			continue;
> +		}
> +
> +		/* Lookup can find inodes outside the cluster being flushed. */
>  		if ((XFS_INO_TO_AGINO(mp, cip->i_ino) & mask) != first_index) {
> +			xfs_iunlock(cip, XFS_ILOCK_SHARED);
>  			spin_unlock(&cip->i_flags_lock);
>  			break;
>  		}
>  		spin_unlock(&cip->i_flags_lock);
>  
>  		/*
> -		 * Do an un-protected check to see if the inode is dirty and
> -		 * is a candidate for flushing.  These checks will be repeated
> -		 * later after the appropriate locks are acquired.
> -		 */
> -		if (xfs_inode_clean(cip) && xfs_ipincount(cip) == 0)
> -			continue;
> -
> -		/*
> -		 * Try to get locks.  If any are unavailable or it is pinned,
> +		 * If we can't get the flush lock now or the inode is pinned,
>  		 * then this inode cannot be flushed and is skipped.
>  		 */
> -
> -		if (!xfs_ilock_nowait(cip, XFS_ILOCK_SHARED))
> -			continue;
>  		if (!xfs_iflock_nowait(cip)) {
>  			xfs_iunlock(cip, XFS_ILOCK_SHARED);
>  			continue;
> @@ -3546,22 +3545,9 @@ xfs_iflush_cluster(
>  			continue;
>  		}
>  
> -
>  		/*
> -		 * Check the inode number again, just to be certain we are not
> -		 * racing with freeing in xfs_reclaim_inode(). See the comments
> -		 * in that function for more information as to why the initial
> -		 * check is not sufficient.
> -		 */
> -		if (!cip->i_ino) {
> -			xfs_ifunlock(cip);
> -			xfs_iunlock(cip, XFS_ILOCK_SHARED);
> -			continue;
> -		}
> -
> -		/*
> -		 * arriving here means that this inode can be flushed.  First
> -		 * re-check that it's dirty before flushing.
> +		 * Arriving here means that this inode can be flushed. First
> +		 * check that it's dirty before flushing.
>  		 */
>  		if (!xfs_inode_clean(cip)) {
>  			int	error;
> @@ -3575,6 +3561,7 @@ xfs_iflush_cluster(
>  			xfs_ifunlock(cip);
>  		}
>  		xfs_iunlock(cip, XFS_ILOCK_SHARED);
> +		/* unsafe to reference cip from here */
>  	}
>  
>  	if (clcount) {
> @@ -3613,7 +3600,11 @@ xfs_iflush_cluster(
>  
>  	xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_INCORE);
>  
> -	/* abort the corrupt inode, as it was not attached to the buffer */
> +	/*
> +	 * Abort the corrupt inode, as it was not attached to the buffer. It is
> +	 * unlocked, but still pinned against reclaim by the flush lock so it is
> +	 * safe to reference here until after the flush abort completes.
> +	 */
>  	xfs_iflush_abort(cip, false);
>  	kmem_free(cilist);
>  	xfs_perag_put(pag);
> -- 
> 2.23.0.rc1
> 
