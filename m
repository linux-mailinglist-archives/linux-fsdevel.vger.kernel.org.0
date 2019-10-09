Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7F6ED05EC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 05:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbfJIDVk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 23:21:40 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:46803 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730339AbfJIDVf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 23:21:35 -0400
Received: from dread.disaster.area (pa49-181-226-196.pa.nsw.optusnet.com.au [49.181.226.196])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 5624543EC97;
        Wed,  9 Oct 2019 14:21:27 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iI2XX-0006C1-Dd; Wed, 09 Oct 2019 14:21:27 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1iI2XX-00039u-Bl; Wed, 09 Oct 2019 14:21:27 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 21/26] xfs: remove mode from xfs_reclaim_inodes()
Date:   Wed,  9 Oct 2019 14:21:19 +1100
Message-Id: <20191009032124.10541-22-david@fromorbit.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20191009032124.10541-1-david@fromorbit.com>
References: <20191009032124.10541-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=dRuLqZ1tmBNts2YiI0zFQg==:117 a=dRuLqZ1tmBNts2YiI0zFQg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=XobE76Q3jBoA:10 a=20KFwNOVAAAA:8
        a=rBCjN8xBrULXB8iKm2EA:9
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Because it's always SYNC_WAIT now.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_icache.c | 7 +++----
 fs/xfs/xfs_icache.h | 2 +-
 fs/xfs/xfs_mount.c  | 4 ++--
 fs/xfs/xfs_super.c  | 3 +--
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index ed996b37bda0..39c56200f1ce 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -1293,12 +1293,11 @@ xfs_reclaim_inodes_ag(
 	return freed;
 }
 
-int
+void
 xfs_reclaim_inodes(
-	xfs_mount_t	*mp,
-	int		mode)
+	struct xfs_mount	*mp)
 {
-	return xfs_reclaim_inodes_ag(mp, mode, INT_MAX);
+	xfs_reclaim_inodes_ag(mp, SYNC_WAIT, INT_MAX);
 }
 
 /*
diff --git a/fs/xfs/xfs_icache.h b/fs/xfs/xfs_icache.h
index 4c0d8920cc54..1c9b9edb2986 100644
--- a/fs/xfs/xfs_icache.h
+++ b/fs/xfs/xfs_icache.h
@@ -49,7 +49,7 @@ int xfs_iget(struct xfs_mount *mp, struct xfs_trans *tp, xfs_ino_t ino,
 struct xfs_inode * xfs_inode_alloc(struct xfs_mount *mp, xfs_ino_t ino);
 void xfs_inode_free(struct xfs_inode *ip);
 
-int xfs_reclaim_inodes(struct xfs_mount *mp, int mode);
+void xfs_reclaim_inodes(struct xfs_mount *mp);
 int xfs_reclaim_inodes_count(struct xfs_mount *mp);
 long xfs_reclaim_inodes_nr(struct xfs_mount *mp, int nr_to_scan);
 
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index ecbc21af9100..3a38fe7c4f8d 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -988,7 +988,7 @@ xfs_mountfs(
 	 * qm_unmount_quotas and therefore rely on qm_unmount to release the
 	 * quota inodes.
 	 */
-	xfs_reclaim_inodes(mp, SYNC_WAIT);
+	xfs_reclaim_inodes(mp);
 	xfs_health_unmount(mp);
  out_log_dealloc:
 	mp->m_flags |= XFS_MOUNT_UNMOUNTING;
@@ -1070,7 +1070,7 @@ xfs_unmountfs(
 	 * reclaim just to be sure. We can stop background inode reclaim
 	 * here as well if it is still running.
 	 */
-	xfs_reclaim_inodes(mp, SYNC_WAIT);
+	xfs_reclaim_inodes(mp);
 	xfs_health_unmount(mp);
 
 	xfs_qm_unmount(mp);
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 74767e6f48a7..d0619bf02a5d 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1180,8 +1180,7 @@ xfs_quiesce_attr(
 	xfs_log_force(mp, XFS_LOG_SYNC);
 
 	/* reclaim inodes to do any IO before the freeze completes */
-	xfs_reclaim_inodes(mp, 0);
-	xfs_reclaim_inodes(mp, SYNC_WAIT);
+	xfs_reclaim_inodes(mp);
 
 	/* Push the superblock and write an unmount record */
 	error = xfs_log_sbcount(mp);
-- 
2.23.0.rc1

