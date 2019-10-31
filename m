Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28DCFEBADB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 00:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfJaXqd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 19:46:33 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:40531 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728637AbfJaXqc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 19:46:32 -0400
Received: from dread.disaster.area (pa49-180-67-183.pa.nsw.optusnet.com.au [49.180.67.183])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id B172F7EA8AA;
        Fri,  1 Nov 2019 10:46:25 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQK8x-0007Cb-O2; Fri, 01 Nov 2019 10:46:19 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQK8x-00042E-M1; Fri, 01 Nov 2019 10:46:19 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 22/28] xfs: remove mode from xfs_reclaim_inodes()
Date:   Fri,  1 Nov 2019 10:46:12 +1100
Message-Id: <20191031234618.15403-23-david@fromorbit.com>
X-Mailer: git-send-email 2.24.0.rc0
In-Reply-To: <20191031234618.15403-1-david@fromorbit.com>
References: <20191031234618.15403-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=3wLbm4YUAFX2xaPZIabsgw==:117 a=3wLbm4YUAFX2xaPZIabsgw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=MeAgGD-zjQ4A:10 a=20KFwNOVAAAA:8
        a=rBCjN8xBrULXB8iKm2EA:9
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Because it's always SYNC_WAIT now. Rename it to
xfs_reclaim_all_inodes() to make it clear how it is different to the
other similarly named reclaim functions.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Brian Foster <bfoster@redhat.com>
---
 fs/xfs/xfs_icache.c | 9 ++++-----
 fs/xfs/xfs_icache.h | 2 +-
 fs/xfs/xfs_mount.c  | 4 ++--
 fs/xfs/xfs_super.c  | 3 +--
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index ff8ae32614a6..048f7f1b54ff 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -1288,12 +1288,11 @@ xfs_reclaim_inodes_ag(
 	return freed;
 }
 
-int
-xfs_reclaim_inodes(
-	xfs_mount_t	*mp,
-	int		mode)
+void
+xfs_reclaim_all_inodes(
+	struct xfs_mount	*mp)
 {
-	return xfs_reclaim_inodes_ag(mp, mode, INT_MAX);
+	xfs_reclaim_inodes_ag(mp, SYNC_WAIT, INT_MAX);
 }
 
 /*
diff --git a/fs/xfs/xfs_icache.h b/fs/xfs/xfs_icache.h
index 4c0d8920cc54..37cd33741bee 100644
--- a/fs/xfs/xfs_icache.h
+++ b/fs/xfs/xfs_icache.h
@@ -49,7 +49,7 @@ int xfs_iget(struct xfs_mount *mp, struct xfs_trans *tp, xfs_ino_t ino,
 struct xfs_inode * xfs_inode_alloc(struct xfs_mount *mp, xfs_ino_t ino);
 void xfs_inode_free(struct xfs_inode *ip);
 
-int xfs_reclaim_inodes(struct xfs_mount *mp, int mode);
+void xfs_reclaim_all_inodes(struct xfs_mount *mp);
 int xfs_reclaim_inodes_count(struct xfs_mount *mp);
 long xfs_reclaim_inodes_nr(struct xfs_mount *mp, int nr_to_scan);
 
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 8f76c2add18b..5f3fd1d8f63f 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -952,7 +952,7 @@ xfs_mountfs(
 	 * qm_unmount_quotas and therefore rely on qm_unmount to release the
 	 * quota inodes.
 	 */
-	xfs_reclaim_inodes(mp, SYNC_WAIT);
+	xfs_reclaim_all_inodes(mp);
 	xfs_health_unmount(mp);
  out_log_dealloc:
 	mp->m_flags |= XFS_MOUNT_UNMOUNTING;
@@ -1034,7 +1034,7 @@ xfs_unmountfs(
 	 * reclaim just to be sure. We can stop background inode reclaim
 	 * here as well if it is still running.
 	 */
-	xfs_reclaim_inodes(mp, SYNC_WAIT);
+	xfs_reclaim_all_inodes(mp);
 	xfs_health_unmount(mp);
 
 	xfs_qm_unmount(mp);
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index a4fe679207ef..456a398aad82 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1151,8 +1151,7 @@ xfs_quiesce_attr(
 	xfs_log_force(mp, XFS_LOG_SYNC);
 
 	/* reclaim inodes to do any IO before the freeze completes */
-	xfs_reclaim_inodes(mp, 0);
-	xfs_reclaim_inodes(mp, SYNC_WAIT);
+	xfs_reclaim_all_inodes(mp);
 
 	/* Push the superblock and write an unmount record */
 	error = xfs_log_sbcount(mp);
-- 
2.24.0.rc0

