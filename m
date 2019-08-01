Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC1527D342
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 04:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbfHACSa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 22:18:30 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:35264 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728877AbfHACSG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 22:18:06 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id B150F361934;
        Thu,  1 Aug 2019 12:17:58 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1ht0eB-0003bE-CP; Thu, 01 Aug 2019 12:16:51 +1000
Received: from dave by discord.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1ht0fH-0001lQ-9o; Thu, 01 Aug 2019 12:17:59 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 18/24] xfs: reduce kswapd blocking on inode locking.
Date:   Thu,  1 Aug 2019 12:17:46 +1000
Message-Id: <20190801021752.4986-19-david@fromorbit.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190801021752.4986-1-david@fromorbit.com>
References: <20190801021752.4986-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=FmdZ9Uzk2mMA:10 a=20KFwNOVAAAA:8
        a=KE6An8oM74Ymw0apzXAA:9
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

When doing async node reclaiming, we grab a batch of inodes that we
are likely able to reclaim and ignore those that are already
flushing. However, when we actually go to reclaim them, the first
thing we do is lock the inode. If we are racing with something
else reclaiming the inode or flushing it because it is dirty,
we block on the inode lock. Hence we can still block kswapd here.

Further, if we flush an inode, we also cluster all the other dirty
inodes in that cluster into the same IO, flush locking them all.
However, if the workload is operating on sequential inodes (e.g.
created by a tarball extraction) most of these inodes will be
sequntial in the cache and so in the same batch
we've already grabbed for reclaim scanning.

As a result, it is common for all the inodes in the batch to be
dirty and it is common for the first inode flushed to also flush all
the inodes in the reclaim batch. In which case, they are now all
going to be flush locked and we do not want to block on them.

Hence, for async reclaim (SYNC_TRYLOCK) make sure we always use
trylock semantics and abort reclaim of an inode as quickly as we can
without blocking kswapd.

Found via tracing and finding big batches of repeated lock/unlock
runs on inodes that we just flushed by write clustering during
reclaim.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_icache.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 2fa2f8dcf86b..e6b9030875b9 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -1104,11 +1104,23 @@ xfs_reclaim_inode(
 
 restart:
 	error = 0;
-	xfs_ilock(ip, XFS_ILOCK_EXCL);
-	if (!xfs_iflock_nowait(ip)) {
-		if (!(sync_mode & SYNC_WAIT))
+	/*
+	 * Don't try to flush the inode if another inode in this cluster has
+	 * already flushed it after we did the initial checks in
+	 * xfs_reclaim_inode_grab().
+	 */
+	if (sync_mode & SYNC_TRYLOCK) {
+		if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL))
 			goto out;
-		xfs_iflock(ip);
+		if (!xfs_iflock_nowait(ip))
+			goto out_unlock;
+	} else {
+		xfs_ilock(ip, XFS_ILOCK_EXCL);
+		if (!xfs_iflock_nowait(ip)) {
+			if (!(sync_mode & SYNC_WAIT))
+				goto out_unlock;
+			xfs_iflock(ip);
+		}
 	}
 
 	if (XFS_FORCED_SHUTDOWN(ip->i_mount)) {
@@ -1215,9 +1227,10 @@ xfs_reclaim_inode(
 
 out_ifunlock:
 	xfs_ifunlock(ip);
+out_unlock:
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 out:
 	xfs_iflags_clear(ip, XFS_IRECLAIM);
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	/*
 	 * We could return -EAGAIN here to make reclaim rescan the inode tree in
 	 * a short while. However, this just burns CPU time scanning the tree
-- 
2.22.0

