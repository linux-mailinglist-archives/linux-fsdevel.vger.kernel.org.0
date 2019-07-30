Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDFA179DE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 03:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbfG3BVf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 21:21:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42008 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfG3BVf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:21:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6U194AN012499;
        Tue, 30 Jul 2019 01:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=NKDEhykjaU9dobTwK4mi+Fknh4IWMVV8m89vU7hGnn8=;
 b=mdoCKTTKyU3ZlTQD0qxccfI0gRu8f6mMpDVI7alUBKVwofFt0lT1LBJ2W0ODnKxqZY8K
 S7Qmgn/tW0C2mRsYshbILEqvsTO87jsyimcLThmMW1Y7+GYpES42rfoV/1UlQjGnNLgQ
 PlWnVKgpDi81IJFj6+jfscSXX8FcnZAeuBxoqjt1CD6BTdQpXwcTnAEN8peywPnldelS
 4f7s0PoM/Ar5pfQwcGGI2EbpM8JkNURSZXW5fuPIdurY5UV1jcOhnElA8VEzk9iZLXfN
 jbNfi/Lse7H29nk/5/NXGmg3J/xNge/76+hnaZabrKv7rznAeaUwBZG+Soc1N+4UcLDm Jg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2u0e1tk5p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 01:19:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6U1IRvG017720;
        Tue, 30 Jul 2019 01:19:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2u0ee4nbsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 01:19:01 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6U1J0k3012603;
        Tue, 30 Jul 2019 01:19:00 GMT
Received: from localhost (/10.159.132.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Jul 2019 18:19:00 -0700
Subject: [PATCH 3/5] xfs: remove the fork fields in the writepage_ctx and
 ioend
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Damien.LeMoal@wdc.com, Christoph Hellwig <hch@lst.de>,
        agruenba@redhat.com
Date:   Mon, 29 Jul 2019 18:19:00 -0700
Message-ID: <156444954007.2682520.7677605159311778499.stgit@magnolia>
In-Reply-To: <156444951713.2682520.8109813555788585092.stgit@magnolia>
References: <156444951713.2682520.8109813555788585092.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9333 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907300011
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9333 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907300010
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

In preparation for moving the writeback code to iomap.c, replace the
XFS-specific COW fork concept with the iomap IOMAP_F_SHARED flag.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_aops.c |   42 ++++++++++++++++++++++--------------------
 fs/xfs/xfs_aops.h |    2 +-
 2 files changed, 23 insertions(+), 21 deletions(-)


diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 12f42922251c..93f1bf315585 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -23,7 +23,6 @@
  */
 struct xfs_writepage_ctx {
 	struct iomap		iomap;
-	int			fork;
 	unsigned int		data_seq;
 	unsigned int		cow_seq;
 	struct xfs_ioend	*ioend;
@@ -269,7 +268,7 @@ xfs_end_ioend(
 	 */
 	error = blk_status_to_errno(ioend->io_bio->bi_status);
 	if (unlikely(error)) {
-		if (ioend->io_fork == XFS_COW_FORK)
+		if (ioend->io_flags & IOMAP_F_SHARED)
 			xfs_reflink_cancel_cow_range(ip, offset, size, true);
 		goto done;
 	}
@@ -277,7 +276,7 @@ xfs_end_ioend(
 	/*
 	 * Success: commit the COW or unwritten blocks if needed.
 	 */
-	if (ioend->io_fork == XFS_COW_FORK)
+	if (ioend->io_flags & IOMAP_F_SHARED)
 		error = xfs_reflink_end_cow(ip, offset, size);
 	else if (ioend->io_type == IOMAP_UNWRITTEN)
 		error = xfs_iomap_write_unwritten(ip, offset, size, false);
@@ -301,7 +300,8 @@ xfs_ioend_can_merge(
 {
 	if (ioend->io_bio->bi_status != next->io_bio->bi_status)
 		return false;
-	if ((ioend->io_fork == XFS_COW_FORK) ^ (next->io_fork == XFS_COW_FORK))
+	if ((ioend->io_flags & IOMAP_F_SHARED) ^
+	    (next->io_flags & IOMAP_F_SHARED))
 		return false;
 	if ((ioend->io_type == IOMAP_UNWRITTEN) ^
 	    (next->io_type == IOMAP_UNWRITTEN))
@@ -408,7 +408,7 @@ xfs_end_bio(
 	struct xfs_mount	*mp = ip->i_mount;
 	unsigned long		flags;
 
-	if (ioend->io_fork == XFS_COW_FORK ||
+	if ((ioend->io_flags & IOMAP_F_SHARED) ||
 	    ioend->io_type == IOMAP_UNWRITTEN ||
 	    ioend->io_private) {
 		spin_lock_irqsave(&ip->i_ioend_lock, flags);
@@ -439,7 +439,7 @@ xfs_imap_valid(
 	 * covers the offset. Be careful to check this first because the caller
 	 * can revalidate a COW mapping without updating the data seqno.
 	 */
-	if (wpc->fork == XFS_COW_FORK)
+	if (wpc->iomap.flags & IOMAP_F_SHARED)
 		return true;
 
 	/*
@@ -469,6 +469,7 @@ static int
 xfs_convert_blocks(
 	struct xfs_writepage_ctx *wpc,
 	struct xfs_inode	*ip,
+	int			whichfork,
 	loff_t			offset)
 {
 	int			error;
@@ -480,8 +481,8 @@ xfs_convert_blocks(
 	 * delalloc extent if free space is sufficiently fragmented.
 	 */
 	do {
-		error = xfs_bmapi_convert_delalloc(ip, wpc->fork, offset,
-				&wpc->iomap, wpc->fork == XFS_COW_FORK ?
+		error = xfs_bmapi_convert_delalloc(ip, whichfork, offset,
+				&wpc->iomap, whichfork == XFS_COW_FORK ?
 					&wpc->cow_seq : &wpc->data_seq);
 		if (error)
 			return error;
@@ -502,6 +503,7 @@ xfs_map_blocks(
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = XFS_B_TO_FSB(mp, offset + count);
 	xfs_fileoff_t		cow_fsb = NULLFILEOFF;
+	int			whichfork = XFS_DATA_FORK;
 	struct xfs_bmbt_irec	imap;
 	struct xfs_iext_cursor	icur;
 	int			retries = 0;
@@ -550,7 +552,7 @@ xfs_map_blocks(
 		wpc->cow_seq = READ_ONCE(ip->i_cowfp->if_seq);
 		xfs_iunlock(ip, XFS_ILOCK_SHARED);
 
-		wpc->fork = XFS_COW_FORK;
+		whichfork = XFS_COW_FORK;
 		goto allocate_blocks;
 	}
 
@@ -573,8 +575,6 @@ xfs_map_blocks(
 	wpc->data_seq = READ_ONCE(ip->i_df.if_seq);
 	xfs_iunlock(ip, XFS_ILOCK_SHARED);
 
-	wpc->fork = XFS_DATA_FORK;
-
 	/* landed in a hole or beyond EOF? */
 	if (imap.br_startoff > offset_fsb) {
 		imap.br_blockcount = imap.br_startoff - offset_fsb;
@@ -599,10 +599,10 @@ xfs_map_blocks(
 		goto allocate_blocks;
 
 	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0);
-	trace_xfs_map_blocks_found(ip, offset, count, wpc->fork, &imap);
+	trace_xfs_map_blocks_found(ip, offset, count, whichfork, &imap);
 	return 0;
 allocate_blocks:
-	error = xfs_convert_blocks(wpc, ip, offset);
+	error = xfs_convert_blocks(wpc, ip, whichfork, offset);
 	if (error) {
 		/*
 		 * If we failed to find the extent in the COW fork we might have
@@ -611,7 +611,8 @@ xfs_map_blocks(
 		 * the former case, but prevent additional retries to avoid
 		 * looping forever for the latter case.
 		 */
-		if (error == -EAGAIN && wpc->fork == XFS_COW_FORK && !retries++)
+		if (error == -EAGAIN && (wpc->iomap.flags & IOMAP_F_SHARED) &&
+		    !retries++)
 			goto retry;
 		ASSERT(error != -EAGAIN);
 		return error;
@@ -622,7 +623,7 @@ xfs_map_blocks(
 	 * original delalloc one.  Trim the return extent to the next COW
 	 * boundary again to force a re-lookup.
 	 */
-	if (wpc->fork != XFS_COW_FORK && cow_fsb != NULLFILEOFF) {
+	if (!(wpc->iomap.flags & IOMAP_F_SHARED) && cow_fsb != NULLFILEOFF) {
 		loff_t		cow_offset = XFS_FSB_TO_B(mp, cow_fsb);
 
 		if (cow_offset < wpc->iomap.offset + wpc->iomap.length)
@@ -631,7 +632,7 @@ xfs_map_blocks(
 
 	ASSERT(wpc->iomap.offset <= offset);
 	ASSERT(wpc->iomap.offset + wpc->iomap.length > offset);
-	trace_xfs_map_blocks_alloc(ip, offset, count, wpc->fork, &imap);
+	trace_xfs_map_blocks_alloc(ip, offset, count, whichfork, &imap);
 	return 0;
 }
 
@@ -665,14 +666,14 @@ xfs_submit_ioend(
 	nofs_flag = memalloc_nofs_save();
 
 	/* Convert CoW extents to regular */
-	if (!status && ioend->io_fork == XFS_COW_FORK) {
+	if (!status && (ioend->io_flags & IOMAP_F_SHARED)) {
 		status = xfs_reflink_convert_cow(XFS_I(ioend->io_inode),
 				ioend->io_offset, ioend->io_size);
 	}
 
 	/* Reserve log space if we might write beyond the on-disk inode size. */
 	if (!status &&
-	    (ioend->io_fork == XFS_COW_FORK ||
+	    ((ioend->io_flags & IOMAP_F_SHARED) ||
 	     ioend->io_type != IOMAP_UNWRITTEN) &&
 	    xfs_ioend_is_append(ioend) &&
 	    !ioend->io_private)
@@ -719,8 +720,8 @@ xfs_alloc_ioend(
 
 	ioend = container_of(bio, struct xfs_ioend, io_inline_bio);
 	INIT_LIST_HEAD(&ioend->io_list);
-	ioend->io_fork = wpc->fork;
 	ioend->io_type = wpc->iomap.type;
+	ioend->io_flags = wpc->iomap.flags;
 	ioend->io_inode = inode;
 	ioend->io_size = 0;
 	ioend->io_offset = offset;
@@ -774,7 +775,8 @@ xfs_add_to_ioend(
 	bool			merged, same_page = false;
 
 	if (!wpc->ioend ||
-	    wpc->fork != wpc->ioend->io_fork ||
+	    (wpc->iomap.flags & IOMAP_F_SHARED) !=
+	    (wpc->ioend->io_flags & IOMAP_F_SHARED) ||
 	    wpc->iomap.type != wpc->ioend->io_type ||
 	    sector != bio_end_sector(wpc->ioend->io_bio) ||
 	    offset != wpc->ioend->io_offset + wpc->ioend->io_size) {
diff --git a/fs/xfs/xfs_aops.h b/fs/xfs/xfs_aops.h
index 6a45d675dcba..4a0226cdad4f 100644
--- a/fs/xfs/xfs_aops.h
+++ b/fs/xfs/xfs_aops.h
@@ -13,8 +13,8 @@ extern struct bio_set xfs_ioend_bioset;
  */
 struct xfs_ioend {
 	struct list_head	io_list;	/* next ioend in chain */
-	int			io_fork;	/* inode fork written back */
 	u16			io_type;
+	u16			io_flags;	/* IOMAP_F_* */
 	struct inode		*io_inode;	/* file being written to */
 	size_t			io_size;	/* size of the extent */
 	xfs_off_t		io_offset;	/* offset in the file */

