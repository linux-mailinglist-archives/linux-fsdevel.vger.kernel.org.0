Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2E7D4002
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 14:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfJKMzZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 08:55:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35896 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbfJKMzY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cpBxXW6xyZSjbosFzqbOGcgYwTTIttJNqLRC6iC23gU=; b=OFvUkDnEXmsMbwN74++/biIkuT
        EFA0r6RVaO3LhXwVVLvn8QmOSBauUblrQqyEZveW4y8BjSkuTf8ZzV4TD3cT/zYaUiRRLM4PhD8Bs
        sZsT/TRK/ZiJZ2Pf7nEL++fVih0dlRP3/lNEX/bohotZ4F+i/4vnzVp/XW9aSbhLz2gH8y/Ca/iMV
        rrUjQr0+dt1t7HBWdLgCGJk38OjxtfaqLF7uZhS0briRw5PzNw6BdK/dYqe9VGD04im/a/eTgvMX0
        rSc6C/4Njv4FOd82K/OZjN7dN+4UcX4Yy5rlkpC8ogZrmPgle5ycw6fQ6my2CLSaIeANRoj/UIZdZ
        mXVg/NvA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIuS2-0008B4-L0; Fri, 11 Oct 2019 12:55:22 +0000
Date:   Fri, 11 Oct 2019 05:55:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 25/26] xfs: rework unreferenced inode lookups
Message-ID: <20191011125522.GA13167@infradead.org>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-26-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191009032124.10541-26-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 02:21:23PM +1100, Dave Chinner wrote:
> 	4. it xfs_ilock_nowait() fails until the rcu grace period

Should this be:

> 	4. if xfs_ilock_nowait() fails before the rcu grace period

?

> +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>  	kmem_zone_free(xfs_inode_zone, ip);
>  }
>  
> @@ -131,6 +132,7 @@ xfs_inode_free(
>  	 * free state. The ip->i_flags_lock provides the barrier against lookup
>  	 * races.
>  	 */
> +	xfs_ilock(ip, XFS_ILOCK_EXCL);

This introduceѕ a non-owner unlock of an exclusively held rwsem.  As-is
this will make lockdep very unhappy.  We have a non-owner unlock version
of up_read, but not of up_write currently.  I'm also not sure if those
are allowed from RCU callback, which IIRC can run from softirq context.

That being said this scheme of only unlocking the inode in the rcu free
callback makes totaly sense to me, so I wish we can accomodate it
somehow.

> @@ -312,7 +327,8 @@ xfs_iget_cache_hit(
>  			rcu_read_lock();
>  			spin_lock(&ip->i_flags_lock);
>  			wake = !!__xfs_iflags_test(ip, XFS_INEW);
> -			ip->i_flags &= ~(XFS_INEW | XFS_IRECLAIM);
> +			ip->i_flags &= ~XFS_INEW | XFS_IRECLAIM;

This change looks wrong to me, or did I miss something?  We now
clear all bits that are not XFS_I_NEW and XFS_IRECLAIM, which
already is set in ~XFS_INEW.  So if that was the intent just:

		ip->i_flags &= ~XFS_INEW;

would do it.

> + * This requires code that requires such pins to do the following under a single

This adds an > 80 char line.  (there are a few more below.

> +		/* push the AIL to clean dirty reclaimable inodes */
> +		xfs_ail_push_all(mp->m_ail);
> +
> +		/* push the AIL to clean dirty reclaimable inodes */
> +		xfs_ail_push_all(mp->m_ail);
> +

This looks spurious vs the rest of the patch.

> +			if (__xfs_iflags_test(ip, XFS_ISTALE)) {
> +				spin_unlock(&ip->i_flags_lock);
> +				if (ip != free_ip)
>  					xfs_iunlock(ip, XFS_ILOCK_EXCL);
> -				}
> +				rcu_read_unlock();
> +				continue;

This unlock out of order.  Should be harmless, but also pointless.

I think this code would be a lot easier to understand if we fatored
this inner loop into a new helper.  Untested patch that does, and
also removes a no incorrect comment below:

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 1d7e3f575952..16d425174868 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2510,6 +2510,93 @@ xfs_iunlink_remove(
 	return error;
 }
 
+static void
+xfs_ifree_one_inode(
+	struct xfs_perag	*pag,
+	struct xfs_inode	*free_ip,
+	struct xfs_buf		*bp,
+	xfs_ino_t		ino)
+{
+	struct xfs_mount	*mp = free_ip->i_mount;
+	struct xfs_inode	*ip;
+	struct xfs_inode_log_item *iip;
+
+retry:
+	rcu_read_lock();
+	ip = radix_tree_lookup(&pag->pag_ici_root, XFS_INO_TO_AGINO(mp, ino));
+	if (!ip)
+		goto out_rcu_unlock;
+
+	/*
+	 * See xfs_dispose_inode() for an explanation of the tests here to avoid
+	 * inode reclaim races.
+	 */
+	spin_lock(&ip->i_flags_lock);
+	if (!ip->i_ino || __xfs_iflags_test(ip, XFS_IRECLAIM))
+		goto out_unlock_iflags;
+
+	/*
+	 * The inode isn't in reclaim, but it might be locked by someone else.
+	 * In that case, we retry the inode rather than skipping it completely.
+	 */
+	if (ip != free_ip && !xfs_ilock_nowait(ip, XFS_ILOCK_EXCL)) {
+		spin_unlock(&ip->i_flags_lock);
+		rcu_read_unlock();
+		delay(1);
+		goto retry;
+	}
+
+	/*
+	 * Inode is now pinned against reclaim until we unlock it, so now we can
+	 * do the work necessary to mark the inode stale and get it held until
+	 * the cluster freeing transaction is logged. If it's stale, then it has
+	 * already been attached to the buffer and we're done.
+	 */
+	if (__xfs_iflags_test(ip, XFS_ISTALE))
+		goto out_unlock_ilock;
+	__xfs_iflags_set(ip, XFS_ISTALE);
+	spin_unlock(&ip->i_flags_lock);
+	rcu_read_unlock();
+
+	/*
+	 * Flush lock will hold off inode reclaim until the buffer completion
+	 * routine runs the xfs_istale_done callback on the inode and unlocks
+	 * it.
+	 */
+	xfs_iflock(ip);
+
+	/*
+	 * We don't need to attach clean inodes or those only with unlogged
+	 * changes (which we throw away, anyway).
+	 */
+	iip = ip->i_itemp;
+	if (!iip || xfs_inode_clean(ip)) {
+		ASSERT(ip != free_ip);
+		xfs_ifunlock(ip);
+		goto done;
+	}
+
+	iip->ili_last_fields = iip->ili_fields;
+	iip->ili_fields = 0;
+	iip->ili_fsync_fields = 0;
+	iip->ili_logged = 1;
+	xfs_trans_ail_copy_lsn(mp->m_ail, &iip->ili_flush_lsn,
+				&iip->ili_item.li_lsn);
+
+	xfs_buf_attach_iodone(bp, xfs_istale_done, &iip->ili_item);
+done:
+	if (ip != free_ip)
+		xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return;
+out_unlock_ilock:
+	if (ip != free_ip)
+		xfs_iunlock(ip, XFS_ILOCK_EXCL);
+out_unlock_iflags:
+	spin_unlock(&ip->i_flags_lock);
+out_rcu_unlock:
+	rcu_read_unlock();
+}
+
 /*
  * A big issue when freeing the inode cluster is that we _cannot_ skip any
  * inodes that are in memory - they all must be marked stale and attached to
@@ -2527,7 +2614,6 @@ xfs_ifree_cluster(
 	int			ioffset;
 	xfs_daddr_t		blkno;
 	xfs_buf_t		*bp;
-	xfs_inode_t		*ip;
 	xfs_inode_log_item_t	*iip;
 	struct xfs_log_item	*lip;
 	struct xfs_perag	*pag;
@@ -2604,99 +2690,9 @@ xfs_ifree_cluster(
 		 * buffer and set it up for being staled on buffer IO
 		 * completion.  This is safe as we've locked out tail pushing
 		 * and flushing by locking the buffer.
-		 *
-		 * We have already marked every inode that was part of a
-		 * transaction stale above, which means there is no point in
-		 * even trying to lock them.
 		 */
-		for (i = 0; i < igeo->inodes_per_cluster; i++) {
-retry:
-			rcu_read_lock();
-			ip = radix_tree_lookup(&pag->pag_ici_root,
-					XFS_INO_TO_AGINO(mp, (inum + i)));
-
-			/* Inode not in memory, nothing to do */
-			if (!ip) {
-				rcu_read_unlock();
-				continue;
-			}
-
-			/*
-			 * See xfs_dispose_inode() for an explanation of the
-			 * tests here to avoid inode reclaim races.
-			 */
-			spin_lock(&ip->i_flags_lock);
-			if (!ip->i_ino ||
-			    __xfs_iflags_test(ip, XFS_IRECLAIM)) {
-				spin_unlock(&ip->i_flags_lock);
-				rcu_read_unlock();
-				continue;
-			}
-
-			/*
-			 * The inode isn't in reclaim, but it might be locked by
-			 * someone else. In that case, we retry the inode rather
-			 * than skipping it completely.
-			 */
-			if (ip != free_ip &&
-			    !xfs_ilock_nowait(ip, XFS_ILOCK_EXCL)) {
-				spin_unlock(&ip->i_flags_lock);
-				rcu_read_unlock();
-				delay(1);
-				goto retry;
-			}
-
-			/*
-			 * Inode is now pinned against reclaim until we unlock
-			 * it, so now we can do the work necessary to mark the
-			 * inode stale and get it held until the cluster freeing
-			 * transaction is logged. If it's stale, then it has
-			 * already been attached to the buffer and we're done.
-			 */
-			if (__xfs_iflags_test(ip, XFS_ISTALE)) {
-				spin_unlock(&ip->i_flags_lock);
-				if (ip != free_ip)
-					xfs_iunlock(ip, XFS_ILOCK_EXCL);
-				rcu_read_unlock();
-				continue;
-			}
-			__xfs_iflags_set(ip, XFS_ISTALE);
-			spin_unlock(&ip->i_flags_lock);
-			rcu_read_unlock();
-
-			/*
-			 * Flush lock will hold off inode reclaim until the
-			 * buffer completion routine runs the xfs_istale_done
-			 * callback on the inode and unlocks it.
-			 */
-			xfs_iflock(ip);
-
-			/*
-			 * we don't need to attach clean inodes or those only
-			 * with unlogged changes (which we throw away, anyway).
-			 */
-			iip = ip->i_itemp;
-			if (!iip || xfs_inode_clean(ip)) {
-				ASSERT(ip != free_ip);
-				xfs_ifunlock(ip);
-				if (ip != free_ip)
-					xfs_iunlock(ip, XFS_ILOCK_EXCL);
-				continue;
-			}
-
-			iip->ili_last_fields = iip->ili_fields;
-			iip->ili_fields = 0;
-			iip->ili_fsync_fields = 0;
-			iip->ili_logged = 1;
-			xfs_trans_ail_copy_lsn(mp->m_ail, &iip->ili_flush_lsn,
-						&iip->ili_item.li_lsn);
-
-			xfs_buf_attach_iodone(bp, xfs_istale_done,
-						  &iip->ili_item);
-
-			if (ip != free_ip)
-				xfs_iunlock(ip, XFS_ILOCK_EXCL);
-		}
+		for (i = 0; i < igeo->inodes_per_cluster; i++)
+			xfs_ifree_one_inode(pag, free_ip, bp, inum + i);
 
 		xfs_trans_stale_inode_buf(tp, bp);
 		xfs_trans_binval(tp, bp);
