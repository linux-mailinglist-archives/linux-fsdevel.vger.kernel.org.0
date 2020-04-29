Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609341BD27B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 04:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgD2Cpw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 22:45:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39076 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgD2Cpw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:45:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2hjcZ121531;
        Wed, 29 Apr 2020 02:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=iBdeNDEStaoZqSxt9mY/tdQsl4D7IPvOjSPNK+x7piw=;
 b=dhFWCtKbfWFWmUrTKsjNQuxuUrQEMYNHWbIVuuh7ryJc5ktVh+pcvU4xf+uKf4+N7Z45
 5eV8HrU6HPolwHXkugxI/tTwrAq5KSfJxIQMxjr1x2Co/ZPfpqJ5WTVMn5sdIGQ0oLNz
 FSRv8tBXsdA9RoyBy1+83IC/123MtK2LoNVpCj8qbQysFaL8xMeC0Z7Sc5oknXW6A2cA
 kMegGqmobFEQGPxeg8qrB5UCMmDufe8b1H35csOCOyhifcVnkXIozzmqYzUL9OV/G9SS
 IRt04piP4h0zg0dSsi/alkYIOGf37zKxt3A3ZHLzmexUifpdeW4biEImZ8pFmK1D71nX wQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 30p2p08p3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:45:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2h0NR075358;
        Wed, 29 Apr 2020 02:45:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30my0f8ew9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:45:48 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03T2jlla003886;
        Wed, 29 Apr 2020 02:45:47 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 19:45:46 -0700
Subject: [PATCH 14/18] xfs: port xfs_swap_extents_rmap to our new code
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Tue, 28 Apr 2020 19:45:45 -0700
Message-ID: <158812834534.168506.15707098363449442583.stgit@magnolia>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=1 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004290020
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

The inner loop of xfs_swap_extents_rmap does the same work as
xfs_swapext_finish_one, so adapt it to use that.  Doing so has the side
benefit that the older code path no longer wastes its time remapping
shared extents.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/libxfs/xfs_swapext.c |   46 +++++++++++++++
 fs/xfs/libxfs/xfs_swapext.h |    5 ++
 fs/xfs/xfs_bmap_util.c      |  136 +++----------------------------------------
 fs/xfs/xfs_trace.h          |    5 --
 4 files changed, 60 insertions(+), 132 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_swapext.c b/fs/xfs/libxfs/xfs_swapext.c
index 6597c613fa3e..64083d48fb7d 100644
--- a/fs/xfs/libxfs/xfs_swapext.c
+++ b/fs/xfs/libxfs/xfs_swapext.c
@@ -433,3 +433,49 @@ xfs_swapext_atomic(
 	xfs_swapext_reflink_finish(*tpp, ip1, ip2, state);
 	return 0;
 }
+
+/*
+ * Swap a range of extents from one inode to another, non-atomically.
+ *
+ * Use deferred bmap log items swap a range of extents from one inode with
+ * another.  Overall extent swap progress is /not/ tracked through the log,
+ * which means that while log recovery can finish remapping a single extent,
+ * it cannot finish the entire operation.
+ */
+int
+xfs_swapext_deferred_bmap(
+	struct xfs_trans		**tpp,
+	struct xfs_inode		*ip1,
+	struct xfs_inode		*ip2,
+	int				whichfork,
+	xfs_fileoff_t			startoff1,
+	xfs_fileoff_t			startoff2,
+	xfs_filblks_t			blockcount,
+	unsigned int			flags)
+{
+	struct xfs_swapext_intent	sxi;
+	unsigned int			state;
+	int				error;
+
+	ASSERT(xfs_isilocked(ip1, XFS_ILOCK_EXCL));
+	ASSERT(xfs_isilocked(ip2, XFS_ILOCK_EXCL));
+	ASSERT(whichfork != XFS_COW_FORK);
+
+	state = xfs_swapext_reflink_prep(ip1, ip2, whichfork, startoff1,
+			startoff2, blockcount);
+
+	xfs_swapext_init_intent(&sxi, ip1, ip2, whichfork, startoff1, startoff2,
+			blockcount, flags);
+
+	while (sxi.si_blockcount > 0) {
+		error = xfs_swapext_finish_one(*tpp, &sxi);
+		if (error)
+			return error;
+		error = xfs_defer_finish(tpp);
+		if (error)
+			return error;
+	}
+
+	xfs_swapext_reflink_finish(*tpp, ip1, ip2, state);
+	return 0;
+}
diff --git a/fs/xfs/libxfs/xfs_swapext.h b/fs/xfs/libxfs/xfs_swapext.h
index af1893f37d39..f4146f55a4c9 100644
--- a/fs/xfs/libxfs/xfs_swapext.h
+++ b/fs/xfs/libxfs/xfs_swapext.h
@@ -54,4 +54,9 @@ int xfs_swapext_atomic(struct xfs_trans **tpp, struct xfs_inode *ip1,
 		xfs_fileoff_t startoff2, xfs_filblks_t blockcount,
 		unsigned int flags);
 
+int xfs_swapext_deferred_bmap(struct xfs_trans **tpp, struct xfs_inode *ip1,
+		struct xfs_inode *ip2, int whichfork, xfs_fileoff_t startoff1,
+		xfs_fileoff_t startoff2, xfs_filblks_t blockcount,
+		unsigned int flags);
+
 #endif /* __XFS_SWAPEXT_H_ */
diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 72aebf7ed42d..d1351f0176a3 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1351,131 +1351,6 @@ xfs_swap_extent_flush(
 	return 0;
 }
 
-/*
- * Move extents from one file to another, when rmap is enabled.
- */
-STATIC int
-xfs_swap_extent_rmap(
-	struct xfs_trans		**tpp,
-	struct xfs_inode		*ip,
-	struct xfs_inode		*tip)
-{
-	struct xfs_trans		*tp = *tpp;
-	struct xfs_bmbt_irec		irec;
-	struct xfs_bmbt_irec		uirec;
-	struct xfs_bmbt_irec		tirec;
-	xfs_fileoff_t			offset_fsb;
-	xfs_fileoff_t			end_fsb;
-	xfs_filblks_t			count_fsb;
-	int				error;
-	xfs_filblks_t			ilen;
-	xfs_filblks_t			rlen;
-	int				nimaps;
-	uint64_t			tip_flags2;
-
-	/*
-	 * If the source file has shared blocks, we must flag the donor
-	 * file as having shared blocks so that we get the shared-block
-	 * rmap functions when we go to fix up the rmaps.  The flags
-	 * will be switch for reals later.
-	 */
-	tip_flags2 = tip->i_d.di_flags2;
-	if (ip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK)
-		tip->i_d.di_flags2 |= XFS_DIFLAG2_REFLINK;
-
-	offset_fsb = 0;
-	end_fsb = XFS_B_TO_FSB(ip->i_mount, i_size_read(VFS_I(ip)));
-	count_fsb = (xfs_filblks_t)(end_fsb - offset_fsb);
-
-	while (count_fsb) {
-		/* Read extent from the donor file */
-		nimaps = 1;
-		error = xfs_bmapi_read(tip, offset_fsb, count_fsb, &tirec,
-				&nimaps, 0);
-		if (error)
-			goto out;
-		if (nimaps != 1 || tirec.br_startblock == DELAYSTARTBLOCK) {
-			/*
-			 * We should never get no mapping or a delalloc extent
-			 * since the donor file should have been flushed by the
-			 * caller.
-			 */
-			ASSERT(0);
-			error = -EINVAL;
-			goto out;
-		}
-
-		trace_xfs_swap_extent_rmap_remap(tip, &tirec);
-		ilen = tirec.br_blockcount;
-
-		/* Unmap the old blocks in the source file. */
-		while (tirec.br_blockcount) {
-			ASSERT(tp->t_firstblock == NULLFSBLOCK);
-			trace_xfs_swap_extent_rmap_remap_piece(tip, &tirec);
-
-			/* Read extent from the source file */
-			nimaps = 1;
-			error = xfs_bmapi_read(ip, tirec.br_startoff,
-					tirec.br_blockcount, &irec,
-					&nimaps, 0);
-			if (error)
-				goto out;
-			if (nimaps != 1 ||
-			    tirec.br_startoff != irec.br_startoff) {
-				/*
-				 * We should never get no mapping or a mapping
-				 * for another offset, but bail out if that
-				 * ever does.
-				 */
-				ASSERT(0);
-				error = -EFSCORRUPTED;
-				goto out;
-			}
-			trace_xfs_swap_extent_rmap_remap_piece(ip, &irec);
-
-			/* Trim the extent. */
-			uirec = tirec;
-			uirec.br_blockcount = rlen = min_t(xfs_filblks_t,
-					tirec.br_blockcount,
-					irec.br_blockcount);
-			trace_xfs_swap_extent_rmap_remap_piece(tip, &uirec);
-
-			/* Remove the mapping from the donor file. */
-			xfs_bmap_unmap_extent(tp, tip, XFS_DATA_FORK, &uirec);
-
-			/* Remove the mapping from the source file. */
-			xfs_bmap_unmap_extent(tp, ip, XFS_DATA_FORK, &irec);
-
-			/* Map the donor file's blocks into the source file. */
-			xfs_bmap_map_extent(tp, ip, XFS_DATA_FORK, &uirec);
-
-			/* Map the source file's blocks into the donor file. */
-			xfs_bmap_map_extent(tp, tip, XFS_DATA_FORK, &irec);
-
-			error = xfs_defer_finish(tpp);
-			tp = *tpp;
-			if (error)
-				goto out;
-
-			tirec.br_startoff += rlen;
-			if (tirec.br_startblock != HOLESTARTBLOCK &&
-			    tirec.br_startblock != DELAYSTARTBLOCK)
-				tirec.br_startblock += rlen;
-			tirec.br_blockcount -= rlen;
-		}
-
-		/* Roll on... */
-		count_fsb -= ilen;
-		offset_fsb += ilen;
-	}
-
-out:
-	if (error)
-		trace_xfs_swap_extent_rmap_error(ip, error, _RET_IP_);
-	tip->i_d.di_flags2 = tip_flags2;
-	return error;
-}
-
 /* Swap the extents of two files by swapping data forks. */
 STATIC int
 xfs_swap_extent_forks(
@@ -1765,15 +1640,20 @@ xfs_swap_extents(
 	target_log_flags = XFS_ILOG_CORE;
 
 	if (xfs_sb_version_hasrmapbt(&mp->m_sb))
-		error = xfs_swap_extent_rmap(&tp, ip, tip);
+		error = xfs_swapext_deferred_bmap(&tp, ip, tip, XFS_DATA_FORK,
+				0, 0, XFS_B_TO_FSB(ip->i_mount,
+						   i_size_read(VFS_I(ip))), 0);
 	else
 		error = xfs_swap_extent_forks(tp, ip, tip, &src_log_flags,
 				&target_log_flags);
-	if (error)
+	if (error) {
+		trace_xfs_swap_extent_error(ip, error, _THIS_IP_);
 		goto out_trans_cancel;
+	}
 
 	/* Do we have to swap reflink flags? */
-	if ((ip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK) ^
+	if (!xfs_sb_version_hasrmapbt(&mp->m_sb) &&
+	    (ip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK) ^
 	    (tip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK)) {
 		f = ip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK;
 		ip->i_d.di_flags2 &= ~XFS_DIFLAG2_REFLINK;
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 7917203e56d4..306cf86c353d 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -3204,14 +3204,11 @@ DEFINE_INODE_ERROR_EVENT(xfs_reflink_end_cow_error);
 
 DEFINE_INODE_IREC_EVENT(xfs_reflink_cancel_cow);
 
-/* rmap swapext tracepoints */
-DEFINE_INODE_IREC_EVENT(xfs_swap_extent_rmap_remap);
-DEFINE_INODE_IREC_EVENT(xfs_swap_extent_rmap_remap_piece);
-DEFINE_INODE_ERROR_EVENT(xfs_swap_extent_rmap_error);
 
 /* swapext tracepoints */
 DEFINE_DOUBLE_IO_EVENT(xfs_file_swap_range);
 DEFINE_INODE_ERROR_EVENT(xfs_file_swap_range_error);
+DEFINE_INODE_ERROR_EVENT(xfs_swap_extent_error);
 DEFINE_INODE_IREC_EVENT(xfs_swapext_extent1);
 DEFINE_INODE_IREC_EVENT(xfs_swapext_extent2);
 DEFINE_ITRUNC_EVENT(xfs_swapext_update_inode_size);

