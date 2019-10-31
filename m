Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8DFEBB1E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 00:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbfJaXq0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 19:46:26 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:39693 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727382AbfJaXqZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 19:46:25 -0400
Received: from dread.disaster.area (pa49-180-67-183.pa.nsw.optusnet.com.au [49.180.67.183])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 690BD7EA88E;
        Fri,  1 Nov 2019 10:46:20 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQK8x-0007CA-8f; Fri, 01 Nov 2019 10:46:19 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQK8x-00041W-5z; Fri, 01 Nov 2019 10:46:19 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/28] xfs: factor inode lookup from xfs_ifree_cluster
Date:   Fri,  1 Nov 2019 10:45:58 +1100
Message-Id: <20191031234618.15403-9-david@fromorbit.com>
X-Mailer: git-send-email 2.24.0.rc0
In-Reply-To: <20191031234618.15403-1-david@fromorbit.com>
References: <20191031234618.15403-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=3wLbm4YUAFX2xaPZIabsgw==:117 a=3wLbm4YUAFX2xaPZIabsgw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=MeAgGD-zjQ4A:10 a=20KFwNOVAAAA:8
        a=v6uQa3AzV7p3N87VeX4A:9 a=KSkNJWIdgRSM0BYC:21 a=MFCUz6Zf14C1qaC9:21
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

There's lots of indent in this code which makes it a bit hard to
follow. We are also going to completely rework the inode lookup code
as part of the inode reclaim rework, so factor out the inode lookup
code from the inode cluster freeing code.

Based on prototype code from Christoph Hellwig.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_inode.c | 152 +++++++++++++++++++++++++--------------------
 1 file changed, 84 insertions(+), 68 deletions(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index e9e4f444f8ce..33edb18098ca 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2516,6 +2516,88 @@ xfs_iunlink_remove(
 	return error;
 }
 
+/*
+ * Look up the inode number specified and mark it stale if it is found. If it is
+ * dirty, return the inode so it can be attached to the cluster buffer so it can
+ * be processed appropriately when the cluster free transaction completes.
+ */
+static struct xfs_inode *
+xfs_ifree_get_one_inode(
+	struct xfs_perag	*pag,
+	struct xfs_inode	*free_ip,
+	int			inum)
+{
+	struct xfs_mount	*mp = pag->pag_mount;
+	struct xfs_inode	*ip;
+
+retry:
+	rcu_read_lock();
+	ip = radix_tree_lookup(&pag->pag_ici_root, XFS_INO_TO_AGINO(mp, inum));
+
+	/* Inode not in memory, nothing to do */
+	if (!ip)
+		goto out_rcu_unlock;
+
+	/*
+	 * because this is an RCU protected lookup, we could find a recently
+	 * freed or even reallocated inode during the lookup. We need to check
+	 * under the i_flags_lock for a valid inode here. Skip it if it is not
+	 * valid, the wrong inode or stale.
+	 */
+	spin_lock(&ip->i_flags_lock);
+	if (ip->i_ino != inum || __xfs_iflags_test(ip, XFS_ISTALE)) {
+		spin_unlock(&ip->i_flags_lock);
+		goto out_rcu_unlock;
+	}
+	spin_unlock(&ip->i_flags_lock);
+
+	/*
+	 * Don't try to lock/unlock the current inode, but we _cannot_ skip the
+	 * other inodes that we did not find in the list attached to the buffer
+	 * and are not already marked stale. If we can't lock it, back off and
+	 * retry.
+	 */
+	if (ip != free_ip) {
+		if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL)) {
+			rcu_read_unlock();
+			delay(1);
+			goto retry;
+		}
+
+		/*
+		 * Check the inode number again in case we're racing with
+		 * freeing in xfs_reclaim_inode().  See the comments in that
+		 * function for more information as to why the initial check is
+		 * not sufficient.
+		 */
+		if (ip->i_ino != inum) {
+			xfs_iunlock(ip, XFS_ILOCK_EXCL);
+			goto out_rcu_unlock;
+		}
+	}
+	rcu_read_unlock();
+
+	xfs_iflock(ip);
+	xfs_iflags_set(ip, XFS_ISTALE);
+
+	/*
+	 * We don't need to attach clean inodes or those only with unlogged
+	 * changes (which we throw away, anyway).
+	 */
+	if (!ip->i_itemp || xfs_inode_clean(ip)) {
+		ASSERT(ip != free_ip);
+		xfs_ifunlock(ip);
+		xfs_iunlock(ip, XFS_ILOCK_EXCL);
+		goto out_no_inode;
+	}
+	return ip;
+
+out_rcu_unlock:
+	rcu_read_unlock();
+out_no_inode:
+	return NULL;
+}
+
 /*
  * A big issue when freeing the inode cluster is that we _cannot_ skip any
  * inodes that are in memory - they all must be marked stale and attached to
@@ -2616,77 +2698,11 @@ xfs_ifree_cluster(
 		 * even trying to lock them.
 		 */
 		for (i = 0; i < igeo->inodes_per_cluster; i++) {
-retry:
-			rcu_read_lock();
-			ip = radix_tree_lookup(&pag->pag_ici_root,
-					XFS_INO_TO_AGINO(mp, (inum + i)));
-
-			/* Inode not in memory, nothing to do */
-			if (!ip) {
-				rcu_read_unlock();
+			ip = xfs_ifree_get_one_inode(pag, free_ip, inum + i);
+			if (!ip)
 				continue;
-			}
-
-			/*
-			 * because this is an RCU protected lookup, we could
-			 * find a recently freed or even reallocated inode
-			 * during the lookup. We need to check under the
-			 * i_flags_lock for a valid inode here. Skip it if it
-			 * is not valid, the wrong inode or stale.
-			 */
-			spin_lock(&ip->i_flags_lock);
-			if (ip->i_ino != inum + i ||
-			    __xfs_iflags_test(ip, XFS_ISTALE)) {
-				spin_unlock(&ip->i_flags_lock);
-				rcu_read_unlock();
-				continue;
-			}
-			spin_unlock(&ip->i_flags_lock);
-
-			/*
-			 * Don't try to lock/unlock the current inode, but we
-			 * _cannot_ skip the other inodes that we did not find
-			 * in the list attached to the buffer and are not
-			 * already marked stale. If we can't lock it, back off
-			 * and retry.
-			 */
-			if (ip != free_ip) {
-				if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL)) {
-					rcu_read_unlock();
-					delay(1);
-					goto retry;
-				}
-
-				/*
-				 * Check the inode number again in case we're
-				 * racing with freeing in xfs_reclaim_inode().
-				 * See the comments in that function for more
-				 * information as to why the initial check is
-				 * not sufficient.
-				 */
-				if (ip->i_ino != inum + i) {
-					xfs_iunlock(ip, XFS_ILOCK_EXCL);
-					rcu_read_unlock();
-					continue;
-				}
-			}
-			rcu_read_unlock();
 
-			xfs_iflock(ip);
-			xfs_iflags_set(ip, XFS_ISTALE);
-
-			/*
-			 * we don't need to attach clean inodes or those only
-			 * with unlogged changes (which we throw away, anyway).
-			 */
 			iip = ip->i_itemp;
-			if (!iip || xfs_inode_clean(ip)) {
-				ASSERT(ip != free_ip);
-				xfs_ifunlock(ip);
-				xfs_iunlock(ip, XFS_ILOCK_EXCL);
-				continue;
-			}
-
 			iip->ili_last_fields = iip->ili_fields;
 			iip->ili_fields = 0;
 			iip->ili_fsync_fields = 0;
-- 
2.24.0.rc0

