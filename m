Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD991BD2A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 04:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgD2CrZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 22:47:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52950 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgD2CrZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:47:25 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2lKcC159037;
        Wed, 29 Apr 2020 02:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=YbxyQRYNMLnUlXv61jZPEj1CmrGgoU6OledFJg0xMZg=;
 b=UqFQdsYOCFsv+RWGyERFJAinyEA8t583dyM6SoYou2f5okzCP08nfA/p2H023Z0xNlx5
 fkjJPu1fIPpSt1h3QUZ4nktQOSBFeXQTUb5cLjAWSvLuRUpeBtw9/OdELO2kv7Fw5m61
 zvljL+i20EEHJoO9Jm8qeKHMs/Y0LvBO53asqZJwdOE3xbYSG8e2drT/jwf+7mg0OJAq
 HmzgniThtaEbVuv8QwlW9frR8778ERBc9GVO1RGqjiWQMy9CsxccAIHjXYQjNwN1yQaa
 s6MyURYdUtISnJIiMJKLabvUDR6ZJ3g1IarBoSY1Uy6RRl1c8EK7UBTFXgQu8v1TssqS tQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30p01nstpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:47:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2gi1S071666;
        Wed, 29 Apr 2020 02:45:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 30mxphp33g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:45:15 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03T2jE42015941;
        Wed, 29 Apr 2020 02:45:14 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 19:45:14 -0700
Subject: [PATCH 09/18] xfs: create deferred log items for extent swapping
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Tue, 28 Apr 2020 19:45:13 -0700
Message-ID: <158812831335.168506.4177678044971007213.stgit@magnolia>
In-Reply-To: <158812825316.168506.932540609191384366.stgit@magnolia>
References: <158812825316.168506.932540609191384366.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=3
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Now that we've created the skeleton of a log intent item to track and
restart extent swap operations, add the upper level logic to commit
intent items and turn them into concrete work recorded in the log.  We
use the deferred item "multihop" feature that was introduced a few
patches ago to constrain the number of active swap operations to one per
thread.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/Makefile             |    1 
 fs/xfs/libxfs/xfs_bmap.h    |   13 +
 fs/xfs/libxfs/xfs_defer.c   |    1 
 fs/xfs/libxfs/xfs_defer.h   |    2 
 fs/xfs/libxfs/xfs_swapext.c |  430 +++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_swapext.h |   57 ++++++
 fs/xfs/xfs_swapext_item.c   |  336 ++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_trace.c          |    1 
 fs/xfs/xfs_trace.h          |   49 +++++
 9 files changed, 885 insertions(+), 5 deletions(-)
 create mode 100644 fs/xfs/libxfs/xfs_swapext.c
 create mode 100644 fs/xfs/libxfs/xfs_swapext.h


diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index 27b4bd5c8ffe..6f8d8f2f8a8c 100644
--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -51,6 +51,7 @@ xfs-y				+= $(addprefix libxfs/, \
 				   xfs_refcount.o \
 				   xfs_refcount_btree.o \
 				   xfs_sb.o \
+				   xfs_swapext.o \
 				   xfs_symlink_remote.o \
 				   xfs_trans_inode.o \
 				   xfs_trans_resv.o \
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index 3367df499ac8..215ce1b8c736 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -158,6 +158,13 @@ static inline int xfs_bmapi_whichfork(int bmapi_flags)
 	{ BMAP_ATTRFORK,	"ATTR" }, \
 	{ BMAP_COWFORK,		"COW" }
 
+/* Return true if the extent is an allocated extent, written or not. */
+static inline bool xfs_bmap_is_mapped_extent(struct xfs_bmbt_irec *irec)
+{
+	return irec->br_startblock != HOLESTARTBLOCK &&
+		irec->br_startblock != DELAYSTARTBLOCK &&
+		!isnullstartblock(irec->br_startblock);
+}
 
 /*
  * Return true if the extent is a real, allocated extent, or false if it is  a
@@ -165,10 +172,8 @@ static inline int xfs_bmapi_whichfork(int bmapi_flags)
  */
 static inline bool xfs_bmap_is_real_extent(struct xfs_bmbt_irec *irec)
 {
-	return irec->br_state != XFS_EXT_UNWRITTEN &&
-		irec->br_startblock != HOLESTARTBLOCK &&
-		irec->br_startblock != DELAYSTARTBLOCK &&
-		!isnullstartblock(irec->br_startblock);
+	return xfs_bmap_is_mapped_extent(irec) &&
+		irec->br_state != XFS_EXT_UNWRITTEN;
 }
 
 /*
diff --git a/fs/xfs/libxfs/xfs_defer.c b/fs/xfs/libxfs/xfs_defer.c
index f53e3ce858eb..00bd0e478829 100644
--- a/fs/xfs/libxfs/xfs_defer.c
+++ b/fs/xfs/libxfs/xfs_defer.c
@@ -184,6 +184,7 @@ static const struct xfs_defer_op_type *defer_op_types[] = {
 	[XFS_DEFER_OPS_TYPE_RMAP]	= &xfs_rmap_update_defer_type,
 	[XFS_DEFER_OPS_TYPE_FREE]	= &xfs_extent_free_defer_type,
 	[XFS_DEFER_OPS_TYPE_AGFL_FREE]	= &xfs_agfl_free_defer_type,
+	[XFS_DEFER_OPS_TYPE_SWAPEXT]	= &xfs_swapext_defer_type,
 };
 
 /*
diff --git a/fs/xfs/libxfs/xfs_defer.h b/fs/xfs/libxfs/xfs_defer.h
index e64b577a9b95..226db6e5a1b0 100644
--- a/fs/xfs/libxfs/xfs_defer.h
+++ b/fs/xfs/libxfs/xfs_defer.h
@@ -18,6 +18,7 @@ enum xfs_defer_ops_type {
 	XFS_DEFER_OPS_TYPE_RMAP,
 	XFS_DEFER_OPS_TYPE_FREE,
 	XFS_DEFER_OPS_TYPE_AGFL_FREE,
+	XFS_DEFER_OPS_TYPE_SWAPEXT,
 	XFS_DEFER_OPS_TYPE_MAX,
 };
 
@@ -65,6 +66,7 @@ extern const struct xfs_defer_op_type xfs_refcount_update_defer_type;
 extern const struct xfs_defer_op_type xfs_rmap_update_defer_type;
 extern const struct xfs_defer_op_type xfs_extent_free_defer_type;
 extern const struct xfs_defer_op_type xfs_agfl_free_defer_type;
+extern const struct xfs_defer_op_type xfs_swapext_defer_type;
 
 /*
  * Deferred operation freezer.  This structure enables a dfops user to detach
diff --git a/fs/xfs/libxfs/xfs_swapext.c b/fs/xfs/libxfs/xfs_swapext.c
new file mode 100644
index 000000000000..2eff48453070
--- /dev/null
+++ b/fs/xfs/libxfs/xfs_swapext.c
@@ -0,0 +1,430 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <darrick.wong@oracle.com>
+ */
+#include "xfs.h"
+#include "xfs_fs.h"
+#include "xfs_shared.h"
+#include "xfs_format.h"
+#include "xfs_log_format.h"
+#include "xfs_trans_resv.h"
+#include "xfs_mount.h"
+#include "xfs_defer.h"
+#include "xfs_inode.h"
+#include "xfs_trans.h"
+#include "xfs_bmap.h"
+#include "xfs_icache.h"
+#include "xfs_quota.h"
+#include "xfs_swapext.h"
+#include "xfs_trace.h"
+
+/* Information to help us reset reflink flag / CoW fork state after a swap. */
+
+/* Are we swapping the data fork? */
+#define XFS_SX_REFLINK_DATAFORK		(1U << 0)
+
+/* Can we swap the flags? */
+#define XFS_SX_REFLINK_SWAPFLAGS	(1U << 1)
+
+/* Previous state of the two inodes' reflink flags. */
+#define XFS_SX_REFLINK_IP1_REFLINK	(1U << 2)
+#define XFS_SX_REFLINK_IP2_REFLINK	(1U << 3)
+
+
+/*
+ * Prepare both inodes' reflink state for an extent swap, and return our
+ * findings so that xfs_swapext_reflink_finish can deal with the aftermath.
+ */
+unsigned int
+xfs_swapext_reflink_prep(
+	struct xfs_inode	*ip1,
+	struct xfs_inode	*ip2,
+	int			whichfork,
+	xfs_fileoff_t		startoff1,
+	xfs_fileoff_t		startoff2,
+	xfs_filblks_t		blockcount)
+{
+	struct xfs_mount	*mp = ip1->i_mount;
+	unsigned int		rs = 0;
+
+	if (whichfork != XFS_DATA_FORK)
+		return 0;
+
+	/*
+	 * If either file has shared blocks and we're swapping data forks, we
+	 * must flag the other file as having shared blocks so that we get the
+	 * shared-block rmap functions if we need to fix up the rmaps.  The
+	 * flags will be switched for real by xfs_swapext_reflink_finish.
+	 */
+	if (xfs_is_reflink_inode(ip1))
+		rs |= XFS_SX_REFLINK_IP1_REFLINK;
+	if (xfs_is_reflink_inode(ip2))
+		rs |= XFS_SX_REFLINK_IP2_REFLINK;
+
+	if (rs & XFS_SX_REFLINK_IP1_REFLINK)
+		ip2->i_d.di_flags2 |= XFS_DIFLAG2_REFLINK;
+	if (rs & XFS_SX_REFLINK_IP2_REFLINK)
+		ip1->i_d.di_flags2 |= XFS_DIFLAG2_REFLINK;
+
+	/*
+	 * If either file had the reflink flag set before; and the two files'
+	 * reflink state was different; and we're swapping the entirety of both
+	 * files, then we can exchange the reflink flags at the end.
+	 * Otherwise, we propagate the reflink flag from either file to the
+	 * other file.
+	 *
+	 * Note that we've only set the _REFLINK flags of the reflink state, so
+	 * we can cheat and use hweight32 for the reflink flag test.
+	 *
+	 */
+	if (hweight32(rs) == 1 && startoff1 == 0 && startoff2 == 0 &&
+	    blockcount == XFS_B_TO_FSB(mp, ip1->i_d.di_size) &&
+	    blockcount == XFS_B_TO_FSB(mp, ip2->i_d.di_size))
+		rs |= XFS_SX_REFLINK_SWAPFLAGS;
+
+	rs |= XFS_SX_REFLINK_DATAFORK;
+	return rs;
+}
+
+/*
+ * If the reflink flag is set on either inode, make sure it has an incore CoW
+ * fork, since all reflink inodes must have them.  If there's a CoW fork and it
+ * has extents in it, make sure the inodes are tagged appropriately so that
+ * speculative preallocations can be GC'd if we run low of space.
+ */
+static inline void
+xfs_swapext_ensure_cowfork(
+	struct xfs_inode	*ip)
+{
+	struct xfs_ifork	*cfork;
+
+	if (xfs_is_reflink_inode(ip))
+		xfs_ifork_init_cow(ip);
+
+	cfork = XFS_IFORK_PTR(ip, XFS_COW_FORK);
+	if (!cfork)
+		return;
+	if (cfork->if_bytes > 0)
+		xfs_inode_set_cowblocks_tag(ip);
+	else
+		xfs_inode_clear_cowblocks_tag(ip);
+}
+
+/*
+ * Set both inodes' ondisk reflink flags to their final state and ensure that
+ * the incore state is ready to go.
+ */
+void
+xfs_swapext_reflink_finish(
+	struct xfs_trans	*tp,
+	struct xfs_inode	*ip1,
+	struct xfs_inode	*ip2,
+	unsigned int		rs)
+{
+	if (!(rs & XFS_SX_REFLINK_DATAFORK))
+		return;
+
+	if (rs & XFS_SX_REFLINK_SWAPFLAGS) {
+		/* Exchange the reflink inode flags and log them. */
+		ip1->i_d.di_flags2 &= ~XFS_DIFLAG2_REFLINK;
+		if (rs & XFS_SX_REFLINK_IP2_REFLINK)
+			ip1->i_d.di_flags2 |= XFS_DIFLAG2_REFLINK;
+
+		ip2->i_d.di_flags2 &= ~XFS_DIFLAG2_REFLINK;
+		if (rs & XFS_SX_REFLINK_IP1_REFLINK)
+			ip2->i_d.di_flags2 |= XFS_DIFLAG2_REFLINK;
+
+		xfs_trans_log_inode(tp, ip1, XFS_ILOG_CORE);
+		xfs_trans_log_inode(tp, ip2, XFS_ILOG_CORE);
+	}
+
+	xfs_swapext_ensure_cowfork(ip1);
+	xfs_swapext_ensure_cowfork(ip2);
+}
+
+/* Schedule an atomic extent swap. */
+static inline void
+xfs_swapext_schedule(
+	struct xfs_trans		*tp,
+	struct xfs_swapext_intent	*sxi)
+{
+	trace_xfs_swapext_defer(tp->t_mountp, sxi);
+	xfs_defer_add(tp, XFS_DEFER_OPS_TYPE_SWAPEXT, &sxi->si_list);
+}
+
+/* Reschedule an atomic extent swap on behalf of log recovery. */
+void
+xfs_swapext_reschedule(
+	struct xfs_trans		*tp,
+	const struct xfs_swapext_intent	*sxi)
+{
+	struct xfs_swapext_intent	*new_sxi;
+
+	new_sxi = kmem_alloc(sizeof(struct xfs_swapext_intent), KM_NOFS);
+	memcpy(new_sxi, sxi, sizeof(*new_sxi));
+	INIT_LIST_HEAD(&new_sxi->si_list);
+
+	xfs_swapext_schedule(tp, new_sxi);
+}
+
+/*
+ * Adjust the on-disk inode size upwards if needed so that we never map extents
+ * into the file past EOF.  This is crucial so that log recovery won't get
+ * confused by the sudden appearance of post-eof extents.
+ */
+STATIC void
+xfs_swapext_update_size(
+	struct xfs_trans	*tp,
+	struct xfs_inode	*ip,
+	struct xfs_bmbt_irec	*imap,
+	xfs_fsize_t		new_isize)
+{
+	struct xfs_mount	*mp = tp->t_mountp;
+	xfs_fsize_t		len;
+
+	if (new_isize < 0)
+		return;
+
+	len = min(XFS_FSB_TO_B(mp, imap->br_startoff + imap->br_blockcount),
+		  new_isize);
+
+	if (len <= ip->i_d.di_size)
+		return;
+
+	trace_xfs_swapext_update_inode_size(ip, len);
+
+	ip->i_d.di_size = len;
+	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
+}
+
+/* Do we have more work to do to finish this operation? */
+bool
+xfs_swapext_has_more_work(
+	struct xfs_swapext_intent	*sxi)
+{
+	return sxi->si_blockcount > 0;
+}
+
+/* Finish one extent swap, possibly log more. */
+int
+xfs_swapext_finish_one(
+	struct xfs_trans		*tp,
+	struct xfs_swapext_intent	*sxi)
+{
+	struct xfs_bmbt_irec		irec1, irec2;
+	int				whichfork;
+	int				nimaps;
+	int				bmap_flags;
+	int				error;
+
+	whichfork = (sxi->si_flags & XFS_SWAP_EXTENT_ATTR_FORK) ?
+			XFS_ATTR_FORK : XFS_DATA_FORK;
+	bmap_flags = xfs_bmapi_aflag(whichfork);
+
+	while (sxi->si_blockcount > 0) {
+		int64_t		ip1_delta = 0, ip2_delta = 0;
+
+		/* Read extent from the first file */
+		nimaps = 1;
+		error = xfs_bmapi_read(sxi->si_ip1, sxi->si_startoff1,
+				sxi->si_blockcount, &irec1, &nimaps,
+				bmap_flags);
+		if (error)
+			return error;
+		if (nimaps != 1 ||
+		    irec1.br_startblock == DELAYSTARTBLOCK ||
+		    irec1.br_startoff != sxi->si_startoff1) {
+			/*
+			 * We should never get no mapping or a delalloc extent
+			 * or something that doesn't match what we asked for,
+			 * since the caller flushed both inodes and we hold the
+			 * ILOCKs for both inodes.
+			 */
+			ASSERT(0);
+			return -EINVAL;
+		}
+
+		/* Read extent from the second file */
+		nimaps = 1;
+		error = xfs_bmapi_read(sxi->si_ip2, sxi->si_startoff2,
+				irec1.br_blockcount, &irec2, &nimaps,
+				bmap_flags);
+		if (error)
+			return error;
+		if (nimaps != 1 ||
+		    irec2.br_startblock == DELAYSTARTBLOCK ||
+		    irec2.br_startoff != sxi->si_startoff2) {
+			/*
+			 * We should never get no mapping or a delalloc extent
+			 * or something that doesn't match what we asked for,
+			 * since the caller flushed both inodes and we hold the
+			 * ILOCKs for both inodes.
+			 */
+			ASSERT(0);
+			return -EINVAL;
+		}
+
+		/*
+		 * We can only swap as many blocks as the smaller of the two
+		 * extent maps.
+		 */
+		irec1.br_blockcount = min(irec1.br_blockcount,
+					  irec2.br_blockcount);
+
+		trace_xfs_swapext_extent1(sxi->si_ip1, &irec1);
+		trace_xfs_swapext_extent2(sxi->si_ip2, &irec2);
+
+		/*
+		 * Two extents mapped to the same physical block must not have
+		 * different states; that's filesystem corruption.  Move on to
+		 * the next extent if they're both holes or both the same
+		 * physical extent.
+		 */
+		if (irec1.br_startblock == irec2.br_startblock) {
+			if (irec1.br_state != irec2.br_state)
+				return -EFSCORRUPTED;
+
+			sxi->si_startoff1 += irec1.br_blockcount;
+			sxi->si_startoff2 += irec1.br_blockcount;
+			sxi->si_blockcount -= irec1.br_blockcount;
+			continue;
+		}
+
+		/* Update quota accounting. */
+		if (xfs_bmap_is_mapped_extent(&irec1)) {
+			ip1_delta -= irec1.br_blockcount;
+			ip2_delta += irec1.br_blockcount;
+		}
+		if (xfs_bmap_is_mapped_extent(&irec2)) {
+			ip1_delta += irec2.br_blockcount;
+			ip2_delta -= irec2.br_blockcount;
+		}
+
+		if (ip1_delta)
+			xfs_trans_mod_dquot_byino(tp, sxi->si_ip1,
+					XFS_TRANS_DQ_BCOUNT, ip1_delta);
+		if (ip2_delta)
+			xfs_trans_mod_dquot_byino(tp, sxi->si_ip2,
+					XFS_TRANS_DQ_BCOUNT, ip2_delta);
+
+		/* Remove both mappings. */
+		xfs_bmap_unmap_extent(tp, sxi->si_ip1, whichfork, &irec1);
+		xfs_bmap_unmap_extent(tp, sxi->si_ip2, whichfork, &irec2);
+
+		/*
+		 * Re-add both mappings.  We swap the file offsets between the
+		 * two maps and add the opposite map, which has the effect of
+		 * filling the logical offsets we just unmapped, but with with
+		 * the physical mapping information swapped.
+		 */
+		swap(irec1.br_startoff, irec2.br_startoff);
+		xfs_bmap_map_extent(tp, sxi->si_ip1, whichfork, &irec2);
+		xfs_bmap_map_extent(tp, sxi->si_ip2, whichfork, &irec1);
+
+		/* Make sure we're not mapping extents past EOF. */
+		if (whichfork == XFS_DATA_FORK) {
+			xfs_swapext_update_size(tp, sxi->si_ip1, &irec2,
+					sxi->si_isize1);
+			xfs_swapext_update_size(tp, sxi->si_ip2, &irec1,
+					sxi->si_isize2);
+		}
+
+		/*
+		 * Advance our cursor and exit.   The caller (either defer ops
+		 * or log recovery) will log the SXD item, and if *blockcount
+		 * is nonzero, it will log a new SXI item for the remainder
+		 * and call us back.
+		 */
+		sxi->si_startoff1 += irec1.br_blockcount;
+		sxi->si_startoff2 += irec1.br_blockcount;
+		sxi->si_blockcount -= irec1.br_blockcount;
+		break;
+	}
+
+	/*
+	 * If we've reached the end of the remap operation and the caller
+	 * wanted us to exchange the sizes, do that now.
+	 */
+	if (sxi->si_blockcount == 0 &&
+	    (sxi->si_flags & XFS_SWAP_EXTENT_SET_SIZES)) {
+		sxi->si_ip1->i_d.di_size = sxi->si_isize1;
+		sxi->si_ip2->i_d.di_size = sxi->si_isize2;
+		xfs_trans_log_inode(tp, sxi->si_ip1, XFS_ILOG_CORE);
+		xfs_trans_log_inode(tp, sxi->si_ip2, XFS_ILOG_CORE);
+	}
+
+	if (xfs_swapext_has_more_work(sxi))
+		trace_xfs_swapext_defer(tp->t_mountp, sxi);
+	return 0;
+}
+
+static void
+xfs_swapext_init_intent(
+	struct xfs_swapext_intent	*sxi,
+	struct xfs_inode		*ip1,
+	struct xfs_inode		*ip2,
+	int				whichfork,
+	xfs_fileoff_t			startoff1,
+	xfs_fileoff_t			startoff2,
+	xfs_filblks_t			blockcount,
+	unsigned int			flags)
+{
+	INIT_LIST_HEAD(&sxi->si_list);
+	sxi->si_flags = 0;
+	if (whichfork == XFS_ATTR_FORK)
+		sxi->si_flags |= XFS_SWAP_EXTENT_ATTR_FORK;
+	sxi->si_isize1 = sxi->si_isize2 = -1;
+	if (whichfork == XFS_DATA_FORK && (flags & XFS_SWAPEXT_SET_SIZES)) {
+		sxi->si_flags |= XFS_SWAP_EXTENT_SET_SIZES;
+		sxi->si_isize1 = ip2->i_d.di_size;
+		sxi->si_isize2 = ip1->i_d.di_size;
+	}
+	sxi->si_ip1 = ip1;
+	sxi->si_ip2 = ip2;
+	sxi->si_startoff1 = startoff1;
+	sxi->si_startoff2 = startoff2;
+	sxi->si_blockcount = blockcount;
+}
+
+/*
+ * Atomically swap a range of extents from one inode to another.
+ *
+ * The caller must ensure the inodes must be joined to the transaction and
+ * ILOCKd; they will still be joined to the transaction at exit.
+ */
+int
+xfs_swapext_atomic(
+	struct xfs_trans		**tpp,
+	struct xfs_inode		*ip1,
+	struct xfs_inode		*ip2,
+	int				whichfork,
+	xfs_fileoff_t			startoff1,
+	xfs_fileoff_t			startoff2,
+	xfs_filblks_t			blockcount,
+	unsigned int			flags)
+{
+	struct xfs_swapext_intent	*sxi;
+	unsigned int			state;
+	int				error;
+
+	ASSERT(xfs_isilocked(ip1, XFS_ILOCK_EXCL));
+	ASSERT(xfs_isilocked(ip2, XFS_ILOCK_EXCL));
+	ASSERT(whichfork != XFS_COW_FORK);
+	ASSERT(whichfork == XFS_DATA_FORK || !(flags & XFS_SWAPEXT_SET_SIZES));
+
+	state = xfs_swapext_reflink_prep(ip1, ip2, whichfork, startoff1,
+			startoff2, blockcount);
+
+	sxi = kmem_alloc(sizeof(struct xfs_swapext_intent), KM_NOFS);
+	xfs_swapext_init_intent(sxi, ip1, ip2, whichfork, startoff1, startoff2,
+			blockcount, flags);
+	xfs_swapext_schedule(*tpp, sxi);
+
+	error = xfs_defer_finish(tpp);
+	if (error)
+		return error;
+
+	xfs_swapext_reflink_finish(*tpp, ip1, ip2, state);
+	return 0;
+}
diff --git a/fs/xfs/libxfs/xfs_swapext.h b/fs/xfs/libxfs/xfs_swapext.h
new file mode 100644
index 000000000000..af1893f37d39
--- /dev/null
+++ b/fs/xfs/libxfs/xfs_swapext.h
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <darrick.wong@oracle.com>
+ */
+#ifndef __XFS_SWAPEXT_H_
+#define __XFS_SWAPEXT_H_ 1
+
+/*
+ * In-core information about an extent swap request between ranges of two
+ * inodes.
+ */
+struct xfs_swapext_intent {
+	/* List of other incore deferred work. */
+	struct list_head	si_list;
+
+	/* The two inodes we're swapping. */
+	union {
+		struct xfs_inode *si_ip1;
+		xfs_ino_t	si_ino1;
+	};
+	union {
+		struct xfs_inode *si_ip2;
+		xfs_ino_t	si_ino2;
+	};
+
+	/* File offset range information. */
+	xfs_fileoff_t		si_startoff1;
+	xfs_fileoff_t		si_startoff2;
+	xfs_filblks_t		si_blockcount;
+	uint64_t		si_flags;
+
+	/* Set these file sizes after the operation, unless negative. */
+	xfs_fsize_t		si_isize1;
+	xfs_fsize_t		si_isize2;
+};
+
+bool xfs_swapext_has_more_work(struct xfs_swapext_intent *sxi);
+
+unsigned int xfs_swapext_reflink_prep(struct xfs_inode *ip1,
+		struct xfs_inode *ip2, int whichfork, xfs_fileoff_t startoff1,
+		xfs_fileoff_t startoff2, xfs_filblks_t blockcount);
+void xfs_swapext_reflink_finish(struct xfs_trans *tp, struct xfs_inode *ip1,
+		struct xfs_inode *ip2, unsigned int reflink_state);
+
+void xfs_swapext_reschedule(struct xfs_trans *tpp,
+		const struct xfs_swapext_intent *sxi_state);
+int xfs_swapext_finish_one(struct xfs_trans *tp,
+		struct xfs_swapext_intent *sxi_state);
+
+#define XFS_SWAPEXT_SET_SIZES		(1U << 0)
+int xfs_swapext_atomic(struct xfs_trans **tpp, struct xfs_inode *ip1,
+		struct xfs_inode *ip2, int whichfork, xfs_fileoff_t startoff1,
+		xfs_fileoff_t startoff2, xfs_filblks_t blockcount,
+		unsigned int flags);
+
+#endif /* __XFS_SWAPEXT_H_ */
diff --git a/fs/xfs/xfs_swapext_item.c b/fs/xfs/xfs_swapext_item.c
index 63ba43e5c3bb..fadd522c6841 100644
--- a/fs/xfs/xfs_swapext_item.c
+++ b/fs/xfs/xfs_swapext_item.c
@@ -16,9 +16,11 @@
 #include "xfs_trans.h"
 #include "xfs_trans_priv.h"
 #include "xfs_swapext_item.h"
+#include "xfs_swapext.h"
 #include "xfs_log.h"
 #include "xfs_bmap.h"
 #include "xfs_icache.h"
+#include "xfs_bmap_btree.h"
 #include "xfs_trans_space.h"
 #include "xfs_error.h"
 #include "xfs_log_priv.h"
@@ -205,6 +207,240 @@ static const struct xfs_item_ops xfs_sxd_item_ops = {
 	.iop_release	= xfs_sxd_item_release,
 };
 
+static struct xfs_sxd_log_item *
+xfs_trans_get_sxd(
+	struct xfs_trans		*tp,
+	struct xfs_sxi_log_item		*ilip)
+{
+	struct xfs_sxd_log_item		*dlip;
+
+	dlip = kmem_zone_zalloc(xfs_sxd_zone, 0);
+	xfs_log_item_init(tp->t_mountp, &dlip->sxd_item, XFS_LI_SXD,
+			  &xfs_sxd_item_ops);
+	dlip->sxd_intent_log_item = ilip;
+	dlip->sxd_format.sxd_sxi_id = ilip->sxi_format.sxi_id;
+
+	xfs_trans_add_item(tp, &dlip->sxd_item);
+	return dlip;
+}
+
+/*
+ * Finish an swapext update and log it to the SXD. Note that the
+ * transaction is marked dirty regardless of whether the swapext update
+ * succeeds or fails to support the SXI/SXD lifecycle rules.
+ */
+static int
+xfs_trans_log_finish_swapext_update(
+	struct xfs_trans		*tp,
+	struct xfs_sxd_log_item		*dlip,
+	struct xfs_swapext_intent	*sxi)
+{
+	int				error;
+
+	error = xfs_swapext_finish_one(tp, sxi);
+
+	/*
+	 * Mark the transaction dirty, even on error. This ensures the
+	 * transaction is aborted, which:
+	 *
+	 * 1.) releases the SXI and frees the SXD
+	 * 2.) shuts down the filesystem
+	 */
+	tp->t_flags |= XFS_TRANS_DIRTY;
+	set_bit(XFS_LI_DIRTY, &dlip->sxd_item.li_flags);
+
+	return error;
+}
+
+/* Sort swapext intents by inode. */
+static int
+xfs_swapext_diff_items(
+	void				*priv,
+	struct list_head		*a,
+	struct list_head		*b)
+{
+	struct xfs_swapext_intent	*sa;
+	struct xfs_swapext_intent	*sb;
+
+	sa = container_of(a, struct xfs_swapext_intent, si_list);
+	sb = container_of(b, struct xfs_swapext_intent, si_list);
+	return sa->si_ip1->i_ino - sb->si_ip2->i_ino;
+}
+
+/* Get an SXI. */
+STATIC void *
+xfs_swapext_create_intent(
+	struct xfs_trans		*tp,
+	unsigned int			count)
+{
+	struct xfs_sxi_log_item		*ilip;
+
+	ASSERT(count == XFS_SXI_MAX_FAST_EXTENTS);
+	ASSERT(tp != NULL);
+
+	ilip = xfs_sxi_init(tp->t_mountp);
+	ASSERT(ilip != NULL);
+
+	/*
+	 * Get a log_item_desc to point at the new item.
+	 */
+	xfs_trans_add_item(tp, &ilip->sxi_item);
+	return ilip;
+}
+
+/* Log swapext updates in the intent item. */
+STATIC void
+xfs_swapext_log_item(
+	struct xfs_trans		*tp,
+	void				*intent,
+	struct list_head		*item)
+{
+	struct xfs_sxi_log_item		*ilip = intent;
+	struct xfs_swapext_intent	*sxi;
+	struct xfs_swap_extent		*se;
+
+	ASSERT(!test_bit(XFS_LI_DIRTY, &ilip->sxi_item.li_flags));
+
+	sxi = container_of(item, struct xfs_swapext_intent, si_list);
+
+	tp->t_flags |= XFS_TRANS_DIRTY;
+	set_bit(XFS_LI_DIRTY, &ilip->sxi_item.li_flags);
+
+	se = &ilip->sxi_format.sxi_extent;
+	se->se_inode1 = sxi->si_ip1->i_ino;
+	se->se_inode2 = sxi->si_ip2->i_ino;
+	se->se_startoff1 = sxi->si_startoff1;
+	se->se_startoff2 = sxi->si_startoff2;
+	se->se_blockcount = sxi->si_blockcount;
+	se->se_isize1 = sxi->si_isize1;
+	se->se_isize2 = sxi->si_isize2;
+	se->se_flags = sxi->si_flags;
+}
+
+/* Get an SXD so we can process all the deferred swapext updates. */
+STATIC void *
+xfs_swapext_create_done(
+	struct xfs_trans		*tp,
+	void				*intent,
+	unsigned int			count)
+{
+	return xfs_trans_get_sxd(tp, intent);
+}
+
+/* Process a deferred swapext update. */
+STATIC int
+xfs_swapext_finish_item(
+	struct xfs_trans		*tp,
+	struct list_head		*item,
+	void				*done_item,
+	void				**state)
+{
+	struct xfs_swapext_intent	*sxi;
+	int				error;
+
+	sxi = container_of(item, struct xfs_swapext_intent, si_list);
+
+	/*
+	 * Swap one more extent between the two files.  If there's still more
+	 * work to do, we want to requeue ourselves after all other pending
+	 * deferred operations have finished.  This includes all of the dfops
+	 * that we queued directly as well as any new ones created in the
+	 * process of finishing the others.  Doing so prevents us from queuing
+	 * a large number of SXI log items in kernel memory, which in turn
+	 * prevents us from pinning the tail of the log (while logging those
+	 * new SXI items) until the first SXI items can be processed.
+	 */
+	error = xfs_trans_log_finish_swapext_update(tp, done_item, sxi);
+	if (!error && xfs_swapext_has_more_work(sxi))
+		return -EMULTIHOP;
+
+	kmem_free(sxi);
+	return error;
+}
+
+/* Abort all pending SXIs. */
+STATIC void
+xfs_swapext_abort_intent(
+	void				*intent)
+{
+	xfs_sxi_release(intent);
+}
+
+/* Cancel a deferred swapext update. */
+STATIC void
+xfs_swapext_cancel_item(
+	struct list_head		*item)
+{
+	struct xfs_swapext_intent	*sxi;
+
+	sxi = container_of(item, struct xfs_swapext_intent, si_list);
+	kmem_free(sxi);
+}
+
+/* Prepare a deferred swapext item for freezing by detaching the inodes. */
+STATIC int
+xfs_swapext_freeze_item(
+	struct xfs_defer_freezer	*freezer,
+	struct list_head		*item)
+{
+	struct xfs_swapext_intent	*sxi;
+	struct xfs_inode		*ip;
+	int				error;
+
+	sxi = container_of(item, struct xfs_swapext_intent, si_list);
+
+	ip = sxi->si_ip1;
+	error = xfs_defer_freezer_ijoin(freezer, ip);
+	if (error)
+		return error;
+	sxi->si_ino1 = ip->i_ino;
+
+	ip = sxi->si_ip2;
+	error = xfs_defer_freezer_ijoin(freezer, ip);
+	if (error)
+		return error;
+	sxi->si_ino2 = ip->i_ino;
+
+	return 0;
+}
+
+/* Thaw a deferred swapext item by reattaching the inodes. */
+STATIC int
+xfs_swapext_thaw_item(
+	struct xfs_defer_freezer	*freezer,
+	struct list_head		*item)
+{
+	struct xfs_swapext_intent	*sxi;
+	struct xfs_inode		*ip;
+
+	sxi = container_of(item, struct xfs_swapext_intent, si_list);
+
+	ip = xfs_defer_freezer_igrab(freezer, sxi->si_ino1);
+	if (!ip)
+		return -EFSCORRUPTED;
+	sxi->si_ip1 = ip;
+
+	ip = xfs_defer_freezer_igrab(freezer, sxi->si_ino2);
+	if (!ip)
+		return -EFSCORRUPTED;
+	sxi->si_ip2 = ip;
+
+	return 0;
+}
+
+const struct xfs_defer_op_type xfs_swapext_defer_type = {
+	.max_items	= XFS_SXI_MAX_FAST_EXTENTS,
+	.diff_items	= xfs_swapext_diff_items,
+	.create_intent	= xfs_swapext_create_intent,
+	.abort_intent	= xfs_swapext_abort_intent,
+	.log_item	= xfs_swapext_log_item,
+	.create_done	= xfs_swapext_create_done,
+	.finish_item	= xfs_swapext_finish_item,
+	.cancel_item	= xfs_swapext_cancel_item,
+	.freeze_item	= xfs_swapext_freeze_item,
+	.thaw_item	= xfs_swapext_thaw_item,
+};
+
 /*
  * Process a swapext update intent item that was recovered from the log.
  * We need to update some inode's bmbt.
@@ -215,7 +451,105 @@ xfs_sxi_recover(
 	struct xfs_defer_freezer	**dffp,
 	struct xfs_sxi_log_item		*ilip)
 {
-	return -EFSCORRUPTED;
+	struct xfs_swapext_intent	sxi;
+	struct xfs_swap_extent		*se;
+	struct xfs_sxd_log_item		*dlip;
+	struct xfs_trans		*tp;
+	int				error = 0;
+
+	ASSERT(!test_bit(XFS_SXI_RECOVERED, &ilip->sxi_flags));
+
+	/*
+	 * First check the validity of the extent described by the
+	 * SXI.  If anything is bad, then toss the SXI.
+	 */
+	se = &ilip->sxi_format.sxi_extent;
+	if (se->se_blockcount == 0 ||
+	    ilip->sxi_format.__pad != 0 ||
+	    !xfs_verify_ino(mp, se->se_inode1) ||
+	    !xfs_verify_ino(mp, se->se_inode2) ||
+	    (se->se_flags & ~XFS_SWAP_EXTENT_FLAGS) ||
+	    ((se->se_flags & XFS_SWAP_EXTENT_SET_SIZES) &&
+	     (se->se_isize1 < 0 || se->se_isize2 < 0))) {
+		/*
+		 * This will pull the SXI from the AIL and
+		 * free the memory associated with it.
+		 */
+		set_bit(XFS_SXI_RECOVERED, &ilip->sxi_flags);
+		xfs_sxi_release(ilip);
+		return -EFSCORRUPTED;
+	}
+
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate,
+			XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK), 0, 0, &tp);
+	if (error)
+		return error;
+
+	dlip = xfs_trans_get_sxd(tp, ilip);
+	memset(&sxi, 0, sizeof(sxi));
+	INIT_LIST_HEAD(&sxi.si_list);
+
+	/* Grab both inodes and lock them. */
+	error = xfs_iget(mp, tp, se->se_inode1, 0, 0, &sxi.si_ip1);
+	if (error)
+		goto out_fail;
+	error = xfs_iget(mp, tp, se->se_inode2, 0, 0, &sxi.si_ip2);
+	if (error)
+		goto out_fail;
+
+	xfs_lock_two_inodes(sxi.si_ip1, XFS_ILOCK_EXCL,
+			    sxi.si_ip2, XFS_ILOCK_EXCL);
+	xfs_trans_ijoin(tp, sxi.si_ip1, 0);
+	xfs_trans_ijoin(tp, sxi.si_ip2, 0);
+
+	/*
+	 * Set IRECOVERY to prevent trimming of post-eof extents and freeing of
+	 * unlinked inodes until we're totally done processing files.
+	 */
+	if (VFS_I(sxi.si_ip1)->i_nlink == 0)
+		xfs_iflags_set(sxi.si_ip1, XFS_IRECOVERY);
+	if (VFS_I(sxi.si_ip2)->i_nlink == 0)
+		xfs_iflags_set(sxi.si_ip2, XFS_IRECOVERY);
+
+	/*
+	 * Construct the rest of our in-core swapext intent state so that we
+	 * can call the deferred operation functions to continue the work.
+	 */
+	sxi.si_flags = se->se_flags;
+	sxi.si_startoff1 = se->se_startoff1;
+	sxi.si_startoff2 = se->se_startoff2;
+	sxi.si_blockcount = se->se_blockcount;
+	sxi.si_isize1 = se->se_isize1;
+	sxi.si_isize2 = se->se_isize2;
+	error = xfs_trans_log_finish_swapext_update(tp, dlip, &sxi);
+	if (error)
+		goto out_fail;
+
+	/*
+	 * If there's more extent swapping to be done, we have to schedule that
+	 * as a separate deferred operation to be run after we've finished
+	 * replaying all of the intents we recovered from the log.
+	 */
+	if (xfs_swapext_has_more_work(&sxi))
+		xfs_swapext_reschedule(tp, &sxi);
+
+	set_bit(XFS_SXI_RECOVERED, &ilip->sxi_flags);
+	error = xlog_recover_trans_commit(tp, dffp);
+	goto out_rele;
+
+out_fail:
+	xfs_trans_cancel(tp);
+out_rele:
+	if (sxi.si_ip2) {
+		xfs_iunlock(sxi.si_ip2, XFS_ILOCK_EXCL);
+		xfs_irele(sxi.si_ip2);
+	}
+	if (sxi.si_ip1) {
+		xfs_iunlock(sxi.si_ip1, XFS_ILOCK_EXCL);
+		xfs_irele(sxi.si_ip1);
+	}
+	return error;
+
 }
 
 /*
diff --git a/fs/xfs/xfs_trace.c b/fs/xfs/xfs_trace.c
index 9b8d703dc9fd..f8cceacfb51d 100644
--- a/fs/xfs/xfs_trace.c
+++ b/fs/xfs/xfs_trace.c
@@ -30,6 +30,7 @@
 #include "xfs_fsmap.h"
 #include "xfs_btree_staging.h"
 #include "xfs_icache.h"
+#include "xfs_swapext.h"
 
 /*
  * We include this last to have the helpers above available for the trace
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 721e14f5c98b..af9c7bcb7a8a 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -37,6 +37,7 @@ struct xfs_trans_res;
 struct xfs_inobt_rec_incore;
 union xfs_btree_ptr;
 struct xfs_eofblocks;
+struct xfs_swapext_intent;
 
 #define XFS_ATTR_FILTER_FLAGS \
 	{ XFS_ATTR_ROOT,	"ROOT" }, \
@@ -3207,6 +3208,9 @@ DEFINE_INODE_IREC_EVENT(xfs_reflink_cancel_cow);
 DEFINE_INODE_IREC_EVENT(xfs_swap_extent_rmap_remap);
 DEFINE_INODE_IREC_EVENT(xfs_swap_extent_rmap_remap_piece);
 DEFINE_INODE_ERROR_EVENT(xfs_swap_extent_rmap_error);
+DEFINE_INODE_IREC_EVENT(xfs_swapext_extent1);
+DEFINE_INODE_IREC_EVENT(xfs_swapext_extent2);
+DEFINE_ITRUNC_EVENT(xfs_swapext_update_inode_size);
 
 /* fsmap traces */
 DECLARE_EVENT_CLASS(xfs_fsmap_class,
@@ -3836,6 +3840,51 @@ DEFINE_NAMESPACE_EVENT(xfs_imeta_dir_created);
 DEFINE_NAMESPACE_EVENT(xfs_imeta_dir_unlinked);
 DEFINE_NAMESPACE_EVENT(xfs_imeta_dir_zap);
 
+#define XFS_SWAPEXT_FLAGS \
+	{ XFS_SWAP_EXTENT_ATTR_FORK,		"ATTRFORK" }, \
+	{ XFS_SWAP_EXTENT_SET_SIZES,		"SETSIZES" }
+
+TRACE_EVENT(xfs_swapext_defer,
+	TP_PROTO(struct xfs_mount *mp, const struct xfs_swapext_intent *sxi),
+	TP_ARGS(mp, sxi),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_ino_t, ino1)
+		__field(xfs_ino_t, ino2)
+		__field(uint64_t, flags)
+		__field(xfs_fileoff_t, startoff1)
+		__field(xfs_fileoff_t, startoff2)
+		__field(xfs_filblks_t, blockcount)
+		__field(xfs_fsize_t, isize1)
+		__field(xfs_fsize_t, isize2)
+		__field(xfs_fsize_t, new_isize1)
+		__field(xfs_fsize_t, new_isize2)
+	),
+	TP_fast_assign(
+		__entry->dev = mp->m_super->s_dev;
+		__entry->ino1 = sxi->si_ip1->i_ino;
+		__entry->ino2 = sxi->si_ip2->i_ino;
+		__entry->flags = sxi->si_flags;
+		__entry->startoff1 = sxi->si_startoff1;
+		__entry->startoff2 = sxi->si_startoff2;
+		__entry->blockcount = sxi->si_blockcount;
+		__entry->isize1 = sxi->si_ip1->i_d.di_size;
+		__entry->isize2 = sxi->si_ip2->i_d.di_size;
+		__entry->new_isize1 = sxi->si_isize1;
+		__entry->new_isize2 = sxi->si_isize2;
+	),
+	TP_printk("dev %d:%d ino1 0x%llx isize1 %lld ino2 0x%llx isize2 %lld flags (%s) startoff1 %llu startoff2 %llu blockcount %llu newisize1 %lld newisize2 %lld",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino1, __entry->isize1,
+		  __entry->ino2, __entry->isize2,
+		  __print_flags(__entry->flags, "|", XFS_SWAPEXT_FLAGS),
+		  __entry->startoff1,
+		  __entry->startoff2,
+		  __entry->blockcount,
+		  __entry->new_isize1, __entry->new_isize2)
+
+);
+
 #endif /* _TRACE_XFS_H */
 
 #undef TRACE_INCLUDE_PATH

