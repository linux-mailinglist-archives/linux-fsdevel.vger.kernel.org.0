Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F13B1BD27E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 04:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgD2Cp6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 22:45:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49174 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgD2Cp6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:45:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2j6kE074138;
        Wed, 29 Apr 2020 02:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=nmNUKSiFUHDR5UYywkzOXuBx7CPOqyjicEFgyzI25+I=;
 b=qeweivu4QupNVFSNx9rKML2qQHhWljVU/jGG2wMnIY3FMn6Sqrdxq+kupLAA5t4N7bll
 HVEb2dTf8DEcDonureSQjQjjfeGeNO7DEpUSsDpRS7XP6DwPmkxxTvocdkjzOYIuplRB
 4RIUVsDmxwImez9PlZKwxdFH+US/7RHuZL96kfr3Ep/8oSRVEywNBrBsOaSf8dwOkCue
 k3X1HtymrJCRWG1sFO6ccm81KQ9P4S3QBIMFzZFdixlHpqPX6HFb7VYbg+sOVwP3d5zl
 Nxp2ZfuxbNGNZnIOFdt0JyV5FVJpNZy3oKWBTLwQ/NDS9AqAd1pmkOzWtClFfIHfThuw mA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 30nucg39q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:45:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2h12B075391;
        Wed, 29 Apr 2020 02:45:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30my0f8f4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:45:54 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03T2jsXo003894;
        Wed, 29 Apr 2020 02:45:54 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 19:45:53 -0700
Subject: [PATCH 15/18] xfs: consolidate all of the xfs_swap_extent_forks code
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Tue, 28 Apr 2020 19:45:53 -0700
Message-ID: <158812835295.168506.6384467972863200135.stgit@magnolia>
In-Reply-To: <158812825316.168506.932540609191384366.stgit@magnolia>
References: <158812825316.168506.932540609191384366.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=1 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=1 malwarescore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290020
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Consolidate the bmbt owner change scan code in xfs_swap_extent_forks,
since it's not needed for the deferred bmap log item swapext
implementation.

The goal is to package up all three implementations into functions that
have the same preconditions and leave the system in the same state.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_bmap_util.c |  211 +++++++++++++++++++++++-------------------------
 1 file changed, 103 insertions(+), 108 deletions(-)


diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index d1351f0176a3..1767f1586c46 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1351,19 +1351,61 @@ xfs_swap_extent_flush(
 	return 0;
 }
 
+/*
+ * Fix up the owners of the bmbt blocks to refer to the current inode. The
+ * change owner scan attempts to order all modified buffers in the current
+ * transaction. In the event of ordered buffer failure, the offending buffer is
+ * physically logged as a fallback and the scan returns -EAGAIN. We must roll
+ * the transaction in this case to replenish the fallback log reservation and
+ * restart the scan. This process repeats until the scan completes.
+ */
+static int
+xfs_swap_change_owner(
+	struct xfs_trans	**tpp,
+	struct xfs_inode	*ip,
+	struct xfs_inode	*tmpip)
+{
+	int			error;
+	struct xfs_trans	*tp = *tpp;
+
+	do {
+		error = xfs_bmbt_change_owner(tp, ip, XFS_DATA_FORK, ip->i_ino,
+					      NULL);
+		/* success or fatal error */
+		if (error != -EAGAIN)
+			break;
+
+		error = xfs_trans_roll(tpp);
+		if (error)
+			break;
+		tp = *tpp;
+
+		/*
+		 * Redirty both inodes so they can relog and keep the log tail
+		 * moving forward.
+		 */
+		xfs_trans_ijoin(tp, ip, 0);
+		xfs_trans_ijoin(tp, tmpip, 0);
+		xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
+		xfs_trans_log_inode(tp, tmpip, XFS_ILOG_CORE);
+	} while (true);
+
+	return error;
+}
+
 /* Swap the extents of two files by swapping data forks. */
 STATIC int
 xfs_swap_extent_forks(
-	struct xfs_trans	*tp,
+	struct xfs_trans	**tpp,
 	struct xfs_inode	*ip,
-	struct xfs_inode	*tip,
-	int			*src_log_flags,
-	int			*target_log_flags)
+	struct xfs_inode	*tip)
 {
 	xfs_filblks_t		aforkblks = 0;
 	xfs_filblks_t		taforkblks = 0;
 	xfs_extnum_t		junk;
 	uint64_t		tmp;
+	int			src_log_flags = XFS_ILOG_CORE;
+	int			target_log_flags = XFS_ILOG_CORE;
 	int			error;
 
 	/*
@@ -1371,14 +1413,14 @@ xfs_swap_extent_forks(
 	 */
 	if ( ((XFS_IFORK_Q(ip) != 0) && (ip->i_d.di_anextents > 0)) &&
 	     (ip->i_d.di_aformat != XFS_DINODE_FMT_LOCAL)) {
-		error = xfs_bmap_count_blocks(tp, ip, XFS_ATTR_FORK, &junk,
+		error = xfs_bmap_count_blocks(*tpp, ip, XFS_ATTR_FORK, &junk,
 				&aforkblks);
 		if (error)
 			return error;
 	}
 	if ( ((XFS_IFORK_Q(tip) != 0) && (tip->i_d.di_anextents > 0)) &&
 	     (tip->i_d.di_aformat != XFS_DINODE_FMT_LOCAL)) {
-		error = xfs_bmap_count_blocks(tp, tip, XFS_ATTR_FORK, &junk,
+		error = xfs_bmap_count_blocks(*tpp, tip, XFS_ATTR_FORK, &junk,
 				&taforkblks);
 		if (error)
 			return error;
@@ -1393,9 +1435,9 @@ xfs_swap_extent_forks(
 	 */
 	if (xfs_sb_version_has_v3inode(&ip->i_mount->m_sb)) {
 		if (ip->i_d.di_format == XFS_DINODE_FMT_BTREE)
-			(*target_log_flags) |= XFS_ILOG_DOWNER;
+			target_log_flags |= XFS_ILOG_DOWNER;
 		if (tip->i_d.di_format == XFS_DINODE_FMT_BTREE)
-			(*src_log_flags) |= XFS_ILOG_DOWNER;
+			src_log_flags |= XFS_ILOG_DOWNER;
 	}
 
 	/*
@@ -1428,69 +1470,77 @@ xfs_swap_extent_forks(
 
 	switch (ip->i_d.di_format) {
 	case XFS_DINODE_FMT_EXTENTS:
-		(*src_log_flags) |= XFS_ILOG_DEXT;
+		src_log_flags |= XFS_ILOG_DEXT;
 		break;
 	case XFS_DINODE_FMT_BTREE:
 		ASSERT(!xfs_sb_version_has_v3inode(&ip->i_mount->m_sb) ||
-		       (*src_log_flags & XFS_ILOG_DOWNER));
-		(*src_log_flags) |= XFS_ILOG_DBROOT;
+		       (src_log_flags & XFS_ILOG_DOWNER));
+		src_log_flags |= XFS_ILOG_DBROOT;
 		break;
 	}
 
 	switch (tip->i_d.di_format) {
 	case XFS_DINODE_FMT_EXTENTS:
-		(*target_log_flags) |= XFS_ILOG_DEXT;
+		target_log_flags |= XFS_ILOG_DEXT;
 		break;
 	case XFS_DINODE_FMT_BTREE:
-		(*target_log_flags) |= XFS_ILOG_DBROOT;
+		target_log_flags |= XFS_ILOG_DBROOT;
 		ASSERT(!xfs_sb_version_has_v3inode(&ip->i_mount->m_sb) ||
-		       (*target_log_flags & XFS_ILOG_DOWNER));
+		       (target_log_flags & XFS_ILOG_DOWNER));
 		break;
 	}
 
-	return 0;
-}
+	/* Do we have to swap reflink flags? */
+	if ((ip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK) ^
+	    (tip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK)) {
+		uint64_t	f;
 
-/*
- * Fix up the owners of the bmbt blocks to refer to the current inode. The
- * change owner scan attempts to order all modified buffers in the current
- * transaction. In the event of ordered buffer failure, the offending buffer is
- * physically logged as a fallback and the scan returns -EAGAIN. We must roll
- * the transaction in this case to replenish the fallback log reservation and
- * restart the scan. This process repeats until the scan completes.
- */
-static int
-xfs_swap_change_owner(
-	struct xfs_trans	**tpp,
-	struct xfs_inode	*ip,
-	struct xfs_inode	*tmpip)
-{
-	int			error;
-	struct xfs_trans	*tp = *tpp;
+		f = ip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK;
+		ip->i_d.di_flags2 &= ~XFS_DIFLAG2_REFLINK;
+		ip->i_d.di_flags2 |= tip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK;
+		tip->i_d.di_flags2 &= ~XFS_DIFLAG2_REFLINK;
+		tip->i_d.di_flags2 |= f & XFS_DIFLAG2_REFLINK;
+	}
 
-	do {
-		error = xfs_bmbt_change_owner(tp, ip, XFS_DATA_FORK, ip->i_ino,
-					      NULL);
-		/* success or fatal error */
-		if (error != -EAGAIN)
-			break;
+	/* Swap the cow forks. */
+	if (xfs_sb_version_hasreflink(&ip->i_mount->m_sb)) {
+		ASSERT(ip->i_cformat == XFS_DINODE_FMT_EXTENTS);
+		ASSERT(tip->i_cformat == XFS_DINODE_FMT_EXTENTS);
 
-		error = xfs_trans_roll(tpp);
-		if (error)
-			break;
-		tp = *tpp;
+		swap(ip->i_cnextents, tip->i_cnextents);
+		swap(ip->i_cowfp, tip->i_cowfp);
 
-		/*
-		 * Redirty both inodes so they can relog and keep the log tail
-		 * moving forward.
-		 */
-		xfs_trans_ijoin(tp, ip, 0);
-		xfs_trans_ijoin(tp, tmpip, 0);
-		xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
-		xfs_trans_log_inode(tp, tmpip, XFS_ILOG_CORE);
-	} while (true);
+		if (ip->i_cowfp && ip->i_cowfp->if_bytes)
+			xfs_inode_set_cowblocks_tag(ip);
+		else
+			xfs_inode_clear_cowblocks_tag(ip);
+		if (tip->i_cowfp && tip->i_cowfp->if_bytes)
+			xfs_inode_set_cowblocks_tag(tip);
+		else
+			xfs_inode_clear_cowblocks_tag(tip);
+	}
 
-	return error;
+	xfs_trans_log_inode(*tpp, ip,  src_log_flags);
+	xfs_trans_log_inode(*tpp, tip, target_log_flags);
+
+	/*
+	 * The extent forks have been swapped, but crc=1,rmapbt=0 filesystems
+	 * have inode number owner values in the bmbt blocks that still refer to
+	 * the old inode. Scan each bmbt to fix up the owner values with the
+	 * inode number of the current inode.
+	 */
+	if (src_log_flags & XFS_ILOG_DOWNER) {
+		error = xfs_swap_change_owner(tpp, ip, tip);
+		if (error)
+			return error;
+	}
+	if (target_log_flags & XFS_ILOG_DOWNER) {
+		error = xfs_swap_change_owner(tpp, tip, ip);
+		if (error)
+			return error;
+	}
+
+	return 0;
 }
 
 int
@@ -1502,10 +1552,8 @@ xfs_swap_extents(
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_trans	*tp;
 	struct xfs_bstat	*sbp = &sxp->sx_stat;
-	int			src_log_flags, target_log_flags;
 	int			error = 0;
 	int			lock_flags;
-	uint64_t		f;
 	int			resblks = 0;
 
 	/*
@@ -1636,70 +1684,17 @@ xfs_swap_extents(
 	 * recovery is going to see the fork as owned by the swapped inode,
 	 * not the pre-swapped inodes.
 	 */
-	src_log_flags = XFS_ILOG_CORE;
-	target_log_flags = XFS_ILOG_CORE;
-
 	if (xfs_sb_version_hasrmapbt(&mp->m_sb))
 		error = xfs_swapext_deferred_bmap(&tp, ip, tip, XFS_DATA_FORK,
 				0, 0, XFS_B_TO_FSB(ip->i_mount,
 						   i_size_read(VFS_I(ip))), 0);
 	else
-		error = xfs_swap_extent_forks(tp, ip, tip, &src_log_flags,
-				&target_log_flags);
+		error = xfs_swap_extent_forks(&tp, ip, tip);
 	if (error) {
 		trace_xfs_swap_extent_error(ip, error, _THIS_IP_);
 		goto out_trans_cancel;
 	}
 
-	/* Do we have to swap reflink flags? */
-	if (!xfs_sb_version_hasrmapbt(&mp->m_sb) &&
-	    (ip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK) ^
-	    (tip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK)) {
-		f = ip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK;
-		ip->i_d.di_flags2 &= ~XFS_DIFLAG2_REFLINK;
-		ip->i_d.di_flags2 |= tip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK;
-		tip->i_d.di_flags2 &= ~XFS_DIFLAG2_REFLINK;
-		tip->i_d.di_flags2 |= f & XFS_DIFLAG2_REFLINK;
-	}
-
-	/* Swap the cow forks. */
-	if (xfs_sb_version_hasreflink(&mp->m_sb)) {
-		ASSERT(ip->i_cformat == XFS_DINODE_FMT_EXTENTS);
-		ASSERT(tip->i_cformat == XFS_DINODE_FMT_EXTENTS);
-
-		swap(ip->i_cnextents, tip->i_cnextents);
-		swap(ip->i_cowfp, tip->i_cowfp);
-
-		if (ip->i_cowfp && ip->i_cowfp->if_bytes)
-			xfs_inode_set_cowblocks_tag(ip);
-		else
-			xfs_inode_clear_cowblocks_tag(ip);
-		if (tip->i_cowfp && tip->i_cowfp->if_bytes)
-			xfs_inode_set_cowblocks_tag(tip);
-		else
-			xfs_inode_clear_cowblocks_tag(tip);
-	}
-
-	xfs_trans_log_inode(tp, ip,  src_log_flags);
-	xfs_trans_log_inode(tp, tip, target_log_flags);
-
-	/*
-	 * The extent forks have been swapped, but crc=1,rmapbt=0 filesystems
-	 * have inode number owner values in the bmbt blocks that still refer to
-	 * the old inode. Scan each bmbt to fix up the owner values with the
-	 * inode number of the current inode.
-	 */
-	if (src_log_flags & XFS_ILOG_DOWNER) {
-		error = xfs_swap_change_owner(&tp, ip, tip);
-		if (error)
-			goto out_trans_cancel;
-	}
-	if (target_log_flags & XFS_ILOG_DOWNER) {
-		error = xfs_swap_change_owner(&tp, tip, ip);
-		if (error)
-			goto out_trans_cancel;
-	}
-
 	/*
 	 * If this is a synchronous mount, make sure that the
 	 * transaction goes to disk before returning to the user.

