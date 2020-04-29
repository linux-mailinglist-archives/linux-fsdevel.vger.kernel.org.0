Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F0C1BD261
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 04:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgD2Cop (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 22:44:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50920 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgD2Cop (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:44:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2htL3155949;
        Wed, 29 Apr 2020 02:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=DDKfNEFao+P2dZR33rqVXYI3gk5lvqtSbri2p/E4roo=;
 b=o7UP2jPfeG9eFQ3yJlYJpAUlqQJt+l2oeRCwTWxYQSKONk/2hB5z7926l1T+XffYT4NN
 60z6d4f8uNUGqI+zwhRBKxnw1QZNtdCi6fCku43UTaEUBE2bTtYqqvsgccTMTZy1rown
 k0PdDO9v7DaLNfsOA1Mqs8MddmPKmQPTmn8VQDZ26dMyLBdlGaaidoxklkO5GasXwNcR
 nkknvqc4gnGOD5DUYi1dGiVnq5IbxmOaCb6OoUXxlIDOP+tSZLGAsTra7nkEaI/AwGMV
 mHoN9JCVaZYcxFc3JtC/nyP7ainCEygv3pWwouK7ElMlaXW6b9c16RInLfmmrBvLeGQq GA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30p01nstgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:44:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2h1vk075497;
        Wed, 29 Apr 2020 02:44:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 30my0f8cht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:44:42 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03T2ifPP003486;
        Wed, 29 Apr 2020 02:44:41 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 19:44:40 -0700
Subject: [PATCH 04/18] xfs: support deferred bmap updates on the attr fork
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Tue, 28 Apr 2020 19:44:39 -0700
Message-ID: <158812827961.168506.8394664032648525321.stgit@magnolia>
In-Reply-To: <158812825316.168506.932540609191384366.stgit@magnolia>
References: <158812825316.168506.932540609191384366.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=3 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501 mlxscore=0
 suspectscore=3 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004290020
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

The deferred bmap update log item has always supported the attr fork, so
plumb this in so that higher layers can access this.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c |   42 ++++++++++++++++--------------------------
 fs/xfs/libxfs/xfs_bmap.h |    4 ++--
 fs/xfs/xfs_bmap_item.c   |    2 +-
 fs/xfs/xfs_bmap_util.c   |    8 ++++----
 fs/xfs/xfs_reflink.c     |    4 ++--
 5 files changed, 25 insertions(+), 35 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 33dbae784463..2752df4f4e69 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -6238,17 +6238,8 @@ xfs_bmap_split_extent(
 	return error;
 }
 
-/* Deferred mapping is only for real extents in the data fork. */
-static bool
-xfs_bmap_is_update_needed(
-	struct xfs_bmbt_irec	*bmap)
-{
-	return  bmap->br_startblock != HOLESTARTBLOCK &&
-		bmap->br_startblock != DELAYSTARTBLOCK;
-}
-
 /* Record a bmap intent. */
-static int
+static void
 __xfs_bmap_add(
 	struct xfs_trans		*tp,
 	enum xfs_bmap_intent_type	type,
@@ -6258,6 +6249,11 @@ __xfs_bmap_add(
 {
 	struct xfs_bmap_intent		*bi;
 
+	if ((whichfork != XFS_DATA_FORK && whichfork != XFS_ATTR_FORK) ||
+	    bmap->br_startblock == HOLESTARTBLOCK ||
+	    bmap->br_startblock == DELAYSTARTBLOCK)
+		return;
+
 	trace_xfs_bmap_defer(tp->t_mountp,
 			XFS_FSB_TO_AGNO(tp->t_mountp, bmap->br_startblock),
 			type,
@@ -6275,7 +6271,6 @@ __xfs_bmap_add(
 	bi->bi_bmap = *bmap;
 
 	xfs_defer_add(tp, XFS_DEFER_OPS_TYPE_BMAP, &bi->bi_list);
-	return 0;
 }
 
 /* Map an extent into a file. */
@@ -6283,12 +6278,10 @@ void
 xfs_bmap_map_extent(
 	struct xfs_trans	*tp,
 	struct xfs_inode	*ip,
+	int			whichfork,
 	struct xfs_bmbt_irec	*PREV)
 {
-	if (!xfs_bmap_is_update_needed(PREV))
-		return;
-
-	__xfs_bmap_add(tp, XFS_BMAP_MAP, ip, XFS_DATA_FORK, PREV);
+	__xfs_bmap_add(tp, XFS_BMAP_MAP, ip, whichfork, PREV);
 }
 
 /* Unmap an extent out of a file. */
@@ -6296,12 +6289,10 @@ void
 xfs_bmap_unmap_extent(
 	struct xfs_trans	*tp,
 	struct xfs_inode	*ip,
+	int			whichfork,
 	struct xfs_bmbt_irec	*PREV)
 {
-	if (!xfs_bmap_is_update_needed(PREV))
-		return;
-
-	__xfs_bmap_add(tp, XFS_BMAP_UNMAP, ip, XFS_DATA_FORK, PREV);
+	__xfs_bmap_add(tp, XFS_BMAP_UNMAP, ip, whichfork, PREV);
 }
 
 /*
@@ -6320,6 +6311,10 @@ xfs_bmap_finish_one(
 	xfs_exntst_t			state)
 {
 	int				error = 0;
+	int				flags = 0;
+
+	if (whichfork == XFS_ATTR_FORK)
+		flags |= XFS_BMAPI_ATTRFORK;
 
 	ASSERT(tp->t_firstblock == NULLFSBLOCK);
 
@@ -6328,11 +6323,6 @@ xfs_bmap_finish_one(
 			XFS_FSB_TO_AGBNO(tp->t_mountp, startblock),
 			ip->i_ino, whichfork, startoff, *blockcount, state);
 
-	if (WARN_ON_ONCE(whichfork != XFS_DATA_FORK)) {
-		xfs_bmap_mark_sick(ip, whichfork);
-		return -EFSCORRUPTED;
-	}
-
 	if (XFS_TEST_ERROR(false, tp->t_mountp,
 			XFS_ERRTAG_BMAP_FINISH_ONE))
 		return -EIO;
@@ -6340,12 +6330,12 @@ xfs_bmap_finish_one(
 	switch (type) {
 	case XFS_BMAP_MAP:
 		error = xfs_bmapi_remap(tp, ip, startoff, *blockcount,
-				startblock, 0);
+				startblock, flags);
 		*blockcount = 0;
 		break;
 	case XFS_BMAP_UNMAP:
 		error = __xfs_bunmapi(tp, ip, startoff, blockcount,
-				XFS_BMAPI_REMAP, 1);
+				flags | XFS_BMAPI_REMAP, 1);
 		break;
 	default:
 		ASSERT(0);
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index bbd8ccdecffa..3367df499ac8 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -266,9 +266,9 @@ int	xfs_bmap_finish_one(struct xfs_trans *tp, struct xfs_inode *ip,
 		xfs_fileoff_t startoff, xfs_fsblock_t startblock,
 		xfs_filblks_t *blockcount, xfs_exntst_t state);
 void	xfs_bmap_map_extent(struct xfs_trans *tp, struct xfs_inode *ip,
-		struct xfs_bmbt_irec *imap);
+		int whichfork, struct xfs_bmbt_irec *imap);
 void	xfs_bmap_unmap_extent(struct xfs_trans *tp, struct xfs_inode *ip,
-		struct xfs_bmbt_irec *imap);
+		int whichfork, struct xfs_bmbt_irec *imap);
 
 static inline int xfs_bmap_fork_to_state(int whichfork)
 {
diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
index 267351fbea67..7ad803a06634 100644
--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -581,7 +581,7 @@ xfs_bui_recover(
 		irec.br_blockcount = count;
 		irec.br_startoff = bmap->me_startoff;
 		irec.br_state = state;
-		xfs_bmap_unmap_extent(tp, ip, &irec);
+		xfs_bmap_unmap_extent(tp, ip, whichfork, &irec);
 	}
 
 	set_bit(XFS_BUI_RECOVERED, &buip->bui_flags);
diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 746bb0c8271c..070f657241a1 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1440,16 +1440,16 @@ xfs_swap_extent_rmap(
 			trace_xfs_swap_extent_rmap_remap_piece(tip, &uirec);
 
 			/* Remove the mapping from the donor file. */
-			xfs_bmap_unmap_extent(tp, tip, &uirec);
+			xfs_bmap_unmap_extent(tp, tip, XFS_DATA_FORK, &uirec);
 
 			/* Remove the mapping from the source file. */
-			xfs_bmap_unmap_extent(tp, ip, &irec);
+			xfs_bmap_unmap_extent(tp, ip, XFS_DATA_FORK, &irec);
 
 			/* Map the donor file's blocks into the source file. */
-			xfs_bmap_map_extent(tp, ip, &uirec);
+			xfs_bmap_map_extent(tp, ip, XFS_DATA_FORK, &uirec);
 
 			/* Map the source file's blocks into the donor file. */
-			xfs_bmap_map_extent(tp, tip, &irec);
+			xfs_bmap_map_extent(tp, tip, XFS_DATA_FORK, &irec);
 
 			error = xfs_defer_finish(tpp);
 			tp = *tpp;
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 5e978d1f169d..f206f6637daf 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -706,7 +706,7 @@ xfs_reflink_end_cow_extent(
 	xfs_refcount_free_cow_extent(tp, del.br_startblock, del.br_blockcount);
 
 	/* Map the new blocks into the data fork. */
-	xfs_bmap_map_extent(tp, ip, &del);
+	xfs_bmap_map_extent(tp, ip, XFS_DATA_FORK, &del);
 
 	/* Charge this new data fork mapping to the on-disk quota. */
 	xfs_trans_mod_dquot_byino(tp, ip, XFS_TRANS_DQ_DELBCOUNT,
@@ -1125,7 +1125,7 @@ xfs_reflink_remap_extent(
 		xfs_refcount_increase_extent(tp, &uirec);
 
 		/* Map the new blocks into the data fork. */
-		xfs_bmap_map_extent(tp, ip, &uirec);
+		xfs_bmap_map_extent(tp, ip, XFS_DATA_FORK, &uirec);
 
 		/* Update quota accounting. */
 		xfs_trans_mod_dquot_byino(tp, ip, XFS_TRANS_DQ_BCOUNT,

