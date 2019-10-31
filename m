Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC37EBAD7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 00:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfJaXqt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 19:46:49 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:40133 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728578AbfJaXqe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 19:46:34 -0400
Received: from dread.disaster.area (pa49-180-67-183.pa.nsw.optusnet.com.au [49.180.67.183])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id ED9677EA903;
        Fri,  1 Nov 2019 10:46:25 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQK8x-0007Co-V0; Fri, 01 Nov 2019 10:46:19 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQK8x-00042W-SH; Fri, 01 Nov 2019 10:46:19 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 28/28] xfs: rework unreferenced inode lookups
Date:   Fri,  1 Nov 2019 10:46:18 +1100
Message-Id: <20191031234618.15403-29-david@fromorbit.com>
X-Mailer: git-send-email 2.24.0.rc0
In-Reply-To: <20191031234618.15403-1-david@fromorbit.com>
References: <20191031234618.15403-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=G6BsK5s5 c=1 sm=1 tr=0
        a=3wLbm4YUAFX2xaPZIabsgw==:117 a=3wLbm4YUAFX2xaPZIabsgw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=MeAgGD-zjQ4A:10 a=20KFwNOVAAAA:8
        a=r6joNmVve4b8u8DPqOAA:9 a=cpms68JvJ2FCVZZY:21 a=fhZphxW6ybyfpQKv:21
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Looking up an unreferenced inode in the inode cache is a bit hairy.
We do this for inode invalidation and writeback clustering purposes,
which is all invisible to the VFS. Hence we can't take reference
counts to the inode and so must be very careful how we do it.

There are several different places that all do the lookups and
checks slightly differently. Fundamentally, though, they are all
racy and inode reclaim has to block waiting for the inode lock if it
loses the race. This is not very optimal given all the work we;ve
already done to make reclaim non-blocking.

We can make the reclaim process nonblocking with a couple of simple
changes. If we define the unreferenced lookup process in a way that
will either always grab an inode in a way that reclaim will notice
and skip, or will notice a reclaim has grabbed the inode so it can
skip the inode, then there is no need for reclaim to need to cycle
the inode ILOCK at all.

Selecting an inode for reclaim is already non-blocking, so if the
ILOCK is held the inode will be skipped. If we ensure that reclaim
holds the ILOCK until the inode is freed, then we can do the same
thing in the unreferenced lookup to avoid inodes in reclaim. We can
do this simply by holding the ILOCK until the RCU grace period
expires and the inode freeing callback is run. As all unreferenced
lookups have to hold the rcu_read_lock(), we are guaranteed that
a reclaimed inode will be noticed as the trylock will fail.


Additional research notes on final reclaim locking before free
--------------------------------------------------------------

2016: 1f2dcfe89eda ("xfs: xfs_inode_free() isn't RCU safe")

Fixes situation where the inode is found during RCU lookup within
the freeing grace period, but critical structures have already been
freed. lookup code that has this problem is stuff like
xfs_iflush_cluster.


2008: 455486b9ccdd ("[XFS] avoid all reclaimable inodes in xfs_sync_inodes_ag")

Prior to this commit, the flushing of inodes required serialisation
with xfs_ireclaim(), which did this lock/unlock thingy to ensure
that it waited for flushing in xfs_sync_inodes_ag() to complete
before freeing the inode:

                /*
-                * If we can't get a reference on the VFS_I, the inode must be
-                * in reclaim. If we can get the inode lock without blocking,
-                * it is safe to flush the inode because we hold the tree lock
-                * and xfs_iextract will block right now. Hence if we lock the
-                * inode while holding the tree lock, xfs_ireclaim() is
-                * guaranteed to block on the inode lock we now hold and hence
-                * it is safe to reference the inode until we drop the inode
-                * locks completely.
+                * If we can't get a reference on the inode, it must be
+                * in reclaim. Leave it for the reclaim code to flush.
                 */

This case is completely gone from the modern code.

lock/unlock exists at start of git era. Switching to archive tree.

This xfs_sync() functionality goes back to 1994 when inode
writeback was first introduced by:

47ac6d60 ("Add support to xfs_ireclaim() needed for xfs_sync().")

So it has been there forever -  lets see if we can get rid of it.
State of existing codeL

- xfs_iflush_cluster() does not check for XFS_IRECLAIM inode flag
  while holding rcu_read_lock()/i_flags_lock, so doesn't avoid
  reclaimable or inodes that are in the process of being reclaimed.
  Inodes at this point of reclaim are clean, so if xfs_iflush_cluster
  wins the race to the ILOCK, then inode reclaim has to wait
  for the lock to be dropped by xfs_iflush_cluster() once it detects
  the inode is clean.

- xfs_ifree_cluster() has similar logic based around XFS_ISTALE,
  results in similar race conditions that require inode reclaim to
  cycle the ILOCK to serialise against.

- xfs_inode_ag_walk() uses xfs_inode_ag_walk_grab(), and it checks
  XFS_IRECLAIM under RCU. It then tries to take a reference to the
  VFS inode via igrab(), which will fail if the inode is either
  XFS_IRECLAIMABLE | XFS_IRECLAIM, and it if races then igrab() will
  fail because the inode has I_FREEING still set, so it's protected
  against reclaim races.

That leaves xfs_iflush_cluster() + xfs_ifree_cluster() to be
modified to do reclaim-safe lookups. W.r.t. new inode reclaim LRU
isolate function:

	1. inode can be referenced while rcu_read_lock() is held.

	2. XFS_IRECLAIM means inode has been fully locked down and
	   has placed on the dispose list, and will be freed soon.
		- ilock_nowait() will fail once IRECLAIM is set due
		  to lock order in isolation code.

	3. ip->i_ino == 0 means it's been removed from the dispose
	   list and is about to or has been removed from the radix
	   tree and may have already been queued on the rcu freeing
	   list to be freed at the end of the current grace period.

		- the old xfs_ireclaim() code will have dropped the
		  ILOCK here, and so there's a race between checking
		  IRECLAIM, grabbing ilock_nowait() and reclaim
		  freeing the inode.
		- this is what the spurious lock/unlock avoids.

	4. it xfs_ilock_nowait() fails before the rcu grace period
	   expires, it doesn't matter if we race between checking
	   IRECLAIM and failing the lock attempt. In fact, we don't
	   even have to check XFS_IRECLAIM - just failing
	   xfs_ilock_nowait() is sufficient to avoid inodes being
	   reclaimed.

	   Hence when xfs_ilock_nowait() fails, we can either drop the
	   rcu_read_lock at that point and restart the inode lookup,
	   or we just skip the inode altogether. If we raced with
	   reclaim, the retry will not find the inode in reclaim
	   again. If we raced wtih some other lock holder, then
	   we'll find the inode and try to lock it again.

		- Requires holding ILOCK into rcu freeing callback
		  and dropping it there. i.e. inode to be reclaimed
		  remains locked until grace period expires.
		- No window at all between IRECLAIM being set and
		  visible to other CPUs and the inode being removed
		  from the cache and freed where ilock_nowait will
		  succeed.
		- simple, effective, reliable.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/mrlock.h     |  27 +++++++++
 fs/xfs/xfs_icache.c |  88 +++++++++++++++++++++--------
 fs/xfs/xfs_inode.c  | 131 +++++++++++++++++++++-----------------------
 3 files changed, 153 insertions(+), 93 deletions(-)

diff --git a/fs/xfs/mrlock.h b/fs/xfs/mrlock.h
index 79155eec341b..1752a2592bcc 100644
--- a/fs/xfs/mrlock.h
+++ b/fs/xfs/mrlock.h
@@ -75,4 +75,31 @@ static inline void mrdemote(mrlock_t *mrp)
 	downgrade_write(&mrp->mr_lock);
 }
 
+/* special locking cases for inode reclaim */
+static inline void mrupdate_non_owner(mrlock_t *mrp)
+{
+	down_write_non_owner(&mrp->mr_lock);
+#if defined(DEBUG) || defined(XFS_WARN)
+	mrp->mr_writer = 1;
+#endif
+}
+
+static inline int mrtryupdate_non_owner(mrlock_t *mrp)
+{
+	if (!down_write_trylock_non_owner(&mrp->mr_lock))
+		return 0;
+#if defined(DEBUG) || defined(XFS_WARN)
+	mrp->mr_writer = 1;
+#endif
+	return 1;
+}
+
+static inline void mrunlock_excl_non_owner(mrlock_t *mrp)
+{
+#if defined(DEBUG) || defined(XFS_WARN)
+	mrp->mr_writer = 0;
+#endif
+	up_write_non_owner(&mrp->mr_lock);
+}
+
 #endif /* __XFS_SUPPORT_MRLOCK_H__ */
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 11bf4768d491..45ee3b5cd873 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -106,6 +106,7 @@ xfs_inode_free_callback(
 		ip->i_itemp = NULL;
 	}
 
+	mrunlock_excl_non_owner(&ip->i_lock);
 	kmem_zone_free(xfs_inode_zone, ip);
 }
 
@@ -132,6 +133,7 @@ xfs_inode_free(
 	 * free state. The ip->i_flags_lock provides the barrier against lookup
 	 * races.
 	 */
+	mrupdate_non_owner(&ip->i_lock);
 	spin_lock(&ip->i_flags_lock);
 	ip->i_flags = XFS_IRECLAIM;
 	ip->i_ino = 0;
@@ -295,11 +297,24 @@ xfs_iget_cache_hit(
 		}
 
 		/*
-		 * We need to set XFS_IRECLAIM to prevent xfs_reclaim_inode
-		 * from stomping over us while we recycle the inode. Remove it
-		 * from the LRU straight away so we can re-init the VFS inode.
+		 * Before we reinitialise the inode, we need to make sure
+		 * reclaim does not pull it out from underneath us. We already
+		 * hold the i_flags_lock, and because the XFS_IRECLAIM is not
+		 * set we know the inode is still on the LRU. However, the LRU
+		 * code may have just selected this inode to reclaim, so we need
+		 * to ensure we hold the i_flags_lock long enough for the
+		 * trylock in xfs_inode_reclaim_isolate() to fail. We do this by
+		 * removing the inode from the LRU, which will spin on the LRU
+		 * list locks until reclaim stops walking, at which point we
+		 * know there is no possible race between reclaim isolation and
+		 * this lookup.
+		 *
+		 * We also set the XFS_IRECLAIM flag here while trying to do the
+		 * re-initialisation to prevent multiple racing lookups on this
+		 * inode from all landing here at the same time.
 		 */
 		ip->i_flags |= XFS_IRECLAIM;
+		list_lru_del(&mp->m_inode_lru, &inode->i_lru);
 		spin_unlock(&ip->i_flags_lock);
 		rcu_read_unlock();
 
@@ -314,6 +329,7 @@ xfs_iget_cache_hit(
 			spin_lock(&ip->i_flags_lock);
 			wake = !!__xfs_iflags_test(ip, XFS_INEW);
 			ip->i_flags &= ~(XFS_INEW | XFS_IRECLAIM);
+			list_lru_add(&mp->m_inode_lru, &inode->i_lru);
 			if (wake)
 				wake_up_bit(&ip->i_flags, __XFS_INEW_BIT);
 			ASSERT(ip->i_flags & XFS_IRECLAIMABLE);
@@ -330,7 +346,6 @@ xfs_iget_cache_hit(
 		spin_lock(&ip->i_flags_lock);
 		ip->i_flags &= ~XFS_IRECLAIM_RESET_FLAGS;
 		ip->i_flags |= XFS_INEW;
-		list_lru_del(&mp->m_inode_lru, &inode->i_lru);
 		inode->i_state = I_NEW;
 		ip->i_sick = 0;
 		ip->i_checked = 0;
@@ -610,8 +625,7 @@ xfs_icache_inode_is_allocated(
 /*
  * The inode lookup is done in batches to keep the amount of lock traffic and
  * radix tree lookups to a minimum. The batch size is a trade off between
- * lookup reduction and stack usage. This is in the reclaim path, so we can't
- * be too greedy.
+ * lookup reduction and stack usage.
  */
 #define XFS_LOOKUP_BATCH	32
 
@@ -916,8 +930,13 @@ xfs_inode_reclaim_isolate(
 		goto out_unlock_flags;
 	}
 
+	/*
+	 * If we are going to reclaim this inode, it will be unlocked by the
+	 * RCU callback and so is in a different context. Hence we need to use
+	 * special non-owner trylock semantics for XFS_ILOCK_EXCL here.
+	 */
 	ret = LRU_SKIP;
-	if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL))
+	if (!mrtryupdate_non_owner(&ip->i_lock))
 		goto out_unlock_flags;
 
 	if (!__xfs_iflock_nowait(ip)) {
@@ -960,7 +979,7 @@ xfs_inode_reclaim_isolate(
 out_ifunlock:
 	__xfs_ifunlock(ip);
 out_unlock_inode:
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	mrunlock_excl_non_owner(&ip->i_lock);
 out_unlock_flags:
 	spin_unlock(&ip->i_flags_lock);
 
@@ -969,6 +988,41 @@ xfs_inode_reclaim_isolate(
 	return ret;
 }
 
+/*
+ * We are passed a locked inode to dispose of.
+ *
+ * To avoid race conditions with lookups that don't take references, we do
+ * not drop the XFS_ILOCK_EXCL until the RCU callback that frees the inode.
+ * This means that any attempt to lock the inode during the current RCU grace
+ * period will fail, and hence we do not need any synchonisation here to wait
+ * for code that pins unreferenced inodes with the XFS_ILOCK to drain.
+ *
+ * This requires code that requires such pins to do the following under a single
+ * rcu_read_lock() context:
+ *
+ *	- rcu_read_lock
+ *	- find the inode via radix tree lookup
+ *	- take the ip->i_flags_lock
+ *	- check ip->i_ino != 0
+ *	- check XFS_IRECLAIM is not set
+ *	- call xfs_ilock_nowait(ip, XFS_ILOCK_[SHARED|EXCL]) to lock the inode
+ *	- drop ip->i_flags_lock
+ *	- rcu_read_unlock()
+ *
+ * Only if all this succeeds and the caller has the inode locked and protected
+ * against it being freed until the ilock is released. If the XFS_IRECLAIM flag
+ * is set or xfs_ilock_nowait() fails, then the caller must either skip the
+ * inode and move on to the next inode (gang lookup) or drop the rcu_read_lock
+ * and start the entire inode lookup process again (individual lookup).
+ *
+ * This works because  i_flags_lock serialises against
+ * xfs_inode_reclaim_isolate() - if the lookup wins the race on i_flags_lock and
+ * XFS_IRECLAIM is not set, then it will be able to lock the inode and hold off
+ * reclaim. If the isolate function wins the race, it will lock the inode and
+ * set the XFS_IRECLAIM flag if it is going to free the inode and this will
+ * prevent the lookup callers from succeeding in getting unreferenced pin via
+ * the ILOCK.
+ */
 static void
 xfs_dispose_inode(
 	struct xfs_inode	*ip)
@@ -977,11 +1031,14 @@ xfs_dispose_inode(
 	struct xfs_perag	*pag;
 	xfs_ino_t		ino;
 
+	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
 	ASSERT(xfs_isiflocked(ip));
 	ASSERT(xfs_inode_clean(ip) || xfs_iflags_test(ip, XFS_ISTALE) ||
 	       XFS_FORCED_SHUTDOWN(mp));
 	ASSERT(ip->i_ino != 0);
 
+	XFS_STATS_INC(mp, xs_ig_reclaims);
+
 	/*
 	 * Process the shutdown reclaim work we deferred from the LRU isolation
 	 * callback before we go any further.
@@ -1008,9 +1065,6 @@ xfs_dispose_inode(
 	ip->i_flags = XFS_IRECLAIM;
 	ip->i_ino = 0;
 	spin_unlock(&ip->i_flags_lock);
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
-
-	XFS_STATS_INC(mp, xs_ig_reclaims);
 
 	/*
 	 * Remove the inode from the per-AG radix tree.
@@ -1022,19 +1076,7 @@ xfs_dispose_inode(
 	spin_unlock(&pag->pag_ici_lock);
 	xfs_perag_put(pag);
 
-	/*
-	 * Here we do an (almost) spurious inode lock in order to coordinate
-	 * with inode cache radix tree lookups.  This is because the lookup
-	 * can reference the inodes in the cache without taking references.
-	 *
-	 * We make that OK here by ensuring that we wait until the inode is
-	 * unlocked after the lookup before we go ahead and free it.
-	 *
-	 * XXX: need to check this is still true. Not sure it is.
-	 */
-	xfs_ilock(ip, XFS_ILOCK_EXCL);
 	xfs_qm_dqdetach(ip);
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 
 	__xfs_inode_free(ip);
 }
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 33edb18098ca..5c0be82195fc 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2538,60 +2538,63 @@ xfs_ifree_get_one_inode(
 	if (!ip)
 		goto out_rcu_unlock;
 
+
+	spin_lock(&ip->i_flags_lock);
+	if (!ip->i_ino || ip->i_ino != inum ||
+	    __xfs_iflags_test(ip, XFS_IRECLAIM))
+		goto out_iflags_unlock;
+
 	/*
-	 * because this is an RCU protected lookup, we could find a recently
-	 * freed or even reallocated inode during the lookup. We need to check
-	 * under the i_flags_lock for a valid inode here. Skip it if it is not
-	 * valid, the wrong inode or stale.
+	 * We've got the right inode and it isn't in reclaim but it might be
+	 * locked by someone else.  In that case, we retry the inode rather than
+	 * skipping it completely as we have to process it with the cluster
+	 * being freed.
 	 */
-	spin_lock(&ip->i_flags_lock);
-	if (ip->i_ino != inum || __xfs_iflags_test(ip, XFS_ISTALE)) {
+	if (ip != free_ip && !xfs_ilock_nowait(ip, XFS_ILOCK_EXCL)) {
 		spin_unlock(&ip->i_flags_lock);
-		goto out_rcu_unlock;
+		rcu_read_unlock();
+		delay(1);
+		goto retry;
 	}
-	spin_unlock(&ip->i_flags_lock);
 
 	/*
-	 * Don't try to lock/unlock the current inode, but we _cannot_ skip the
-	 * other inodes that we did not find in the list attached to the buffer
-	 * and are not already marked stale. If we can't lock it, back off and
-	 * retry.
+	 * Inode is now pinned against reclaim until we unlock it. If the inode
+	 * is already marked stale, then it has already been flush locked and
+	 * attached to the buffer so we don't need to do anything more here.
 	 */
-	if (ip != free_ip) {
-		if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL)) {
-			rcu_read_unlock();
-			delay(1);
-			goto retry;
-		}
-
-		/*
-		 * Check the inode number again in case we're racing with
-		 * freeing in xfs_reclaim_inode().  See the comments in that
-		 * function for more information as to why the initial check is
-		 * not sufficient.
-		 */
-		if (ip->i_ino != inum) {
+	if (__xfs_iflags_test(ip, XFS_ISTALE)) {
+		if (ip != free_ip)
 			xfs_iunlock(ip, XFS_ILOCK_EXCL);
-			goto out_rcu_unlock;
-		}
+		goto out_iflags_unlock;
 	}
+	__xfs_iflags_set(ip, XFS_ISTALE);
+	spin_unlock(&ip->i_flags_lock);
 	rcu_read_unlock();
 
+	/*
+	 * The flush lock will now hold off inode reclaim until the buffer
+	 * completion routine runs the xfs_istale_done callback and unlocks the
+	 * flush lock. Hence the caller can safely drop the ILOCK when it is
+	 * done attaching the inode to the cluster buffer.
+	 */
 	xfs_iflock(ip);
-	xfs_iflags_set(ip, XFS_ISTALE);
 
 	/*
-	 * We don't need to attach clean inodes or those only with unlogged
-	 * changes (which we throw away, anyway).
+	 * We don't need to attach clean inodes to the buffer - they are marked
+	 * stale in memory now and will need to be re-initialised by inode
+	 * allocation before they can be reused.
 	 */
 	if (!ip->i_itemp || xfs_inode_clean(ip)) {
 		ASSERT(ip != free_ip);
 		xfs_ifunlock(ip);
-		xfs_iunlock(ip, XFS_ILOCK_EXCL);
+		if (ip != free_ip)
+			xfs_iunlock(ip, XFS_ILOCK_EXCL);
 		goto out_no_inode;
 	}
 	return ip;
 
+out_iflags_unlock:
+	spin_unlock(&ip->i_flags_lock);
 out_rcu_unlock:
 	rcu_read_unlock();
 out_no_inode:
@@ -3519,44 +3522,40 @@ xfs_iflush_cluster(
 			continue;
 
 		/*
-		 * because this is an RCU protected lookup, we could find a
-		 * recently freed or even reallocated inode during the lookup.
-		 * We need to check under the i_flags_lock for a valid inode
-		 * here. Skip it if it is not valid or the wrong inode.
+		 * See xfs_dispose_inode() for an explanation of the
+		 * tests here to avoid inode reclaim races.
 		 */
 		spin_lock(&cip->i_flags_lock);
 		if (!cip->i_ino ||
-		    __xfs_iflags_test(cip, XFS_ISTALE)) {
+		    __xfs_iflags_test(cip, XFS_IRECLAIM)) {
 			spin_unlock(&cip->i_flags_lock);
 			continue;
 		}
 
-		/*
-		 * Once we fall off the end of the cluster, no point checking
-		 * any more inodes in the list because they will also all be
-		 * outside the cluster.
-		 */
+		/* ILOCK will pin the inode against reclaim */
+		if (!xfs_ilock_nowait(cip, XFS_ILOCK_SHARED)) {
+			spin_unlock(&cip->i_flags_lock);
+			continue;
+		}
+
+		if (__xfs_iflags_test(cip, XFS_ISTALE)) {
+			xfs_iunlock(cip, XFS_ILOCK_SHARED);
+			spin_unlock(&cip->i_flags_lock);
+			continue;
+		}
+
+		/* Lookup can find inodes outside the cluster being flushed. */
 		if ((XFS_INO_TO_AGINO(mp, cip->i_ino) & mask) != first_index) {
+			xfs_iunlock(cip, XFS_ILOCK_SHARED);
 			spin_unlock(&cip->i_flags_lock);
 			break;
 		}
 		spin_unlock(&cip->i_flags_lock);
 
 		/*
-		 * Do an un-protected check to see if the inode is dirty and
-		 * is a candidate for flushing.  These checks will be repeated
-		 * later after the appropriate locks are acquired.
-		 */
-		if (xfs_inode_clean(cip) && xfs_ipincount(cip) == 0)
-			continue;
-
-		/*
-		 * Try to get locks.  If any are unavailable or it is pinned,
+		 * If we can't get the flush lock now or the inode is pinned,
 		 * then this inode cannot be flushed and is skipped.
 		 */
-
-		if (!xfs_ilock_nowait(cip, XFS_ILOCK_SHARED))
-			continue;
 		if (!xfs_iflock_nowait(cip)) {
 			xfs_iunlock(cip, XFS_ILOCK_SHARED);
 			continue;
@@ -3567,22 +3566,9 @@ xfs_iflush_cluster(
 			continue;
 		}
 
-
 		/*
-		 * Check the inode number again, just to be certain we are not
-		 * racing with freeing in xfs_reclaim_inode(). See the comments
-		 * in that function for more information as to why the initial
-		 * check is not sufficient.
-		 */
-		if (!cip->i_ino) {
-			xfs_ifunlock(cip);
-			xfs_iunlock(cip, XFS_ILOCK_SHARED);
-			continue;
-		}
-
-		/*
-		 * arriving here means that this inode can be flushed.  First
-		 * re-check that it's dirty before flushing.
+		 * Arriving here means that this inode can be flushed. First
+		 * check that it's dirty before flushing.
 		 */
 		if (!xfs_inode_clean(cip)) {
 			int	error;
@@ -3596,6 +3582,7 @@ xfs_iflush_cluster(
 			xfs_ifunlock(cip);
 		}
 		xfs_iunlock(cip, XFS_ILOCK_SHARED);
+		/* unsafe to reference cip from here */
 	}
 
 	if (clcount) {
@@ -3634,7 +3621,11 @@ xfs_iflush_cluster(
 
 	xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_INCORE);
 
-	/* abort the corrupt inode, as it was not attached to the buffer */
+	/*
+	 * Abort the corrupt inode, as it was not attached to the buffer. It is
+	 * unlocked, but still pinned against reclaim by the flush lock so it is
+	 * safe to reference here until after the flush abort completes.
+	 */
 	xfs_iflush_abort(cip, false);
 	kmem_free(cilist);
 	xfs_perag_put(pag);
-- 
2.24.0.rc0

