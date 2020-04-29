Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A3D1BD272
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 04:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgD2Cpd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 22:45:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48896 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgD2Cpc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:45:32 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2h6gR072916;
        Wed, 29 Apr 2020 02:45:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=/GqMvnZm7ctqNarf3UK8yO20PuE3GtR89fcuQmYbX5M=;
 b=QyZ/1T7ZZOrMLLQXddMSh+jH10AojjEu8XXWhc1dS5Gid+NDlfix1doVu4iGfCDFZRfE
 Oq2bHn1zdN/Bcsi1H5qvtIwpll4/G+655OkUM9lldFhuDRX423UvffIZKXKioTJR/BS9
 M+B5FQQwfypv4rYfwvqX8itALdd1Tn7VwSyadMK7kY8t1VRBZikKaFec/r2M3mRH/BQF
 6bcu438fqChfxIDhEfX9bdahIjUMsWUqNlXymuD0ye8ndeQN6A+fiX9XjGCn69RpM2sE
 koil+/gofyapZnrNnpFsxBZUW4ScHKH/+USBoctku4eURZgY+VJnMxN5LY9wcaphh/g6 qw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30nucg39p3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:45:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2g3VA039235;
        Wed, 29 Apr 2020 02:45:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 30mxru04wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:45:29 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03T2jRHn022735;
        Wed, 29 Apr 2020 02:45:28 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 19:45:27 -0700
Subject: [PATCH 11/18] xfs: add a ->swap_file_range handler
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Tue, 28 Apr 2020 19:45:26 -0700
Message-ID: <158812832621.168506.10248212998434869117.stgit@magnolia>
In-Reply-To: <158812825316.168506.932540609191384366.stgit@magnolia>
References: <158812825316.168506.932540609191384366.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=3
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004290020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=3 malwarescore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290020
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Add a function to handle range swap requests from the vfs.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_bmap_util.c |  340 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_bmap_util.h |    4 +
 fs/xfs/xfs_file.c      |   39 ++++++
 fs/xfs/xfs_trace.h     |    4 +
 4 files changed, 387 insertions(+)


diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 070f657241a1..a8bd2627d76e 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -29,6 +29,7 @@
 #include "xfs_iomap.h"
 #include "xfs_reflink.h"
 #include "xfs_sb.h"
+#include "xfs_swapext.h"
 
 /* Kernel only BMAP related definitions and functions */
 
@@ -1841,3 +1842,342 @@ xfs_swap_extents(
 	xfs_trans_cancel(tp);
 	goto out_unlock;
 }
+
+/* Prepare two files to have their data swapped. */
+int
+xfs_swap_range_prep(
+	struct file		*file1,
+	struct file		*file2,
+	struct file_swap_range	*fsr)
+{
+	struct xfs_inode	*ip1 = XFS_I(file_inode(file1));
+	struct xfs_inode	*ip2 = XFS_I(file_inode(file2));
+	int			ret;
+
+	/* Verify both files are either real-time or non-realtime */
+	if (XFS_IS_REALTIME_INODE(ip1) != XFS_IS_REALTIME_INODE(ip2))
+		return -EINVAL;
+
+	ret = generic_swap_file_range_prep(file1, file2, fsr);
+	if (ret)
+		return ret;
+
+	/* Attach dquots to both inodes before changing block maps. */
+	ret = xfs_qm_dqattach(ip2);
+	if (ret)
+		return ret;
+	ret = xfs_qm_dqattach(ip1);
+	if (ret)
+		return ret;
+
+	/* Flush the relevant ranges of both files. */
+	ret = xfs_flush_unmap_range(ip2, fsr->file2_offset, fsr->length);
+	if (ret)
+		return ret;
+	return xfs_flush_unmap_range(ip1, fsr->file1_offset, fsr->length);
+}
+
+/*
+ * Compute the number of blocks and extents mapped to part of a file, and the
+ * worst case estimate of the number of bmbt blocks required to store those
+ * mappings.
+ */
+STATIC int
+xfs_bmap_count_range_blocks(
+	struct xfs_inode	*ip,
+	int			whichfork,
+	xfs_fileoff_t		startoff,
+	xfs_filblks_t		blockcount,
+	xfs_filblks_t		*nr_mapped_blocks)
+{
+	struct xfs_bmbt_irec	irec;
+	xfs_filblks_t		nr_blocks = 0;
+	xfs_extnum_t		extents = 0;
+	int			bmapi_flags = xfs_bmapi_aflag(whichfork);
+	int			nimaps;
+	int			error;
+
+	*nr_mapped_blocks = 0;
+
+	/* Count all the extents that map to allocated space. */
+	while (blockcount > 0) {
+		nimaps = 1;
+		error = xfs_bmapi_read(ip, startoff, blockcount, &irec,
+				&nimaps, bmapi_flags);
+		if (error)
+			return error;
+		if (nimaps != 1)
+			return -EINVAL;
+		if (xfs_bmap_is_mapped_extent(&irec)) {
+			nr_blocks += irec.br_blockcount;
+			extents++;
+		}
+		startoff += irec.br_blockcount;
+		blockcount -= irec.br_blockcount;
+	}
+
+	/* Add in the number of bmbt splits that could happen. */
+	nr_blocks += XFS_NEXTENTADD_SPACE_RES(ip->i_mount, nr_blocks,
+			whichfork);
+	*nr_mapped_blocks = nr_blocks;
+
+	return 0;
+}
+
+/*
+ * Compute the number of blocks we need to reserve to handle a log-assisted
+ * extent swap operation.
+ */
+static inline unsigned int
+xfs_swap_range_calc_resblks(
+	struct xfs_inode	*ip1,
+	struct xfs_inode	*ip2,
+	int			whichfork,
+	xfs_filblks_t		blockcount)
+{
+	struct xfs_mount	*mp = ip1->i_mount;
+	xfs_extnum_t		ip1_nr = XFS_IFORK_NEXTENTS(ip1, whichfork);
+	xfs_extnum_t		ip2_nr = XFS_IFORK_NEXTENTS(ip2, whichfork);
+	unsigned int		resblks;
+
+	/*
+	 * Each file range cannot have more extents than there are blocks in
+	 * that range.
+	 */
+	ip1_nr = min_t(xfs_filblks_t, ip1_nr, blockcount);
+	ip2_nr = min_t(xfs_filblks_t, ip2_nr, blockcount);
+
+	/*
+	 * Conceptually this shouldn't affect the shape of either bmbt, but
+	 * since we atomically move extents one by one, we reserve enough space
+	 * to rebuild both trees.
+	 */
+	resblks =  XFS_SWAP_RMAP_SPACE_RES(mp, ip1_nr, whichfork);
+	resblks += XFS_SWAP_RMAP_SPACE_RES(mp, ip2_nr, whichfork);
+
+	/*
+	 * Handle the corner case where either inode might straddle the btree
+	 * format boundary. If so, the inode could bounce between btree <->
+	 * extent format on unmap -> remap cycles, freeing and allocating a
+	 * bmapbt block each time.
+	 */
+	if (ip1_nr == (XFS_IFORK_MAXEXT(ip1, whichfork) + 1))
+		resblks += XFS_IFORK_MAXEXT(ip1, whichfork);
+	if (ip2_nr == (XFS_IFORK_MAXEXT(ip2, whichfork) + 1))
+		resblks += XFS_IFORK_MAXEXT(ip2, whichfork);
+
+	return resblks;
+}
+
+/*
+ * Obtain a quota reservation to make sure we don't hit EDQUOT.  We can skip
+ * this if quota enforcement is disabled or if both inodes' dquots are the
+ * same.
+ */
+STATIC int
+xfs_swap_range_prep_quota(
+	struct xfs_trans	*tp,
+	struct xfs_inode	*ip1,
+	struct xfs_inode	*ip2,
+	int			whichfork,
+	xfs_fileoff_t		startoff1,
+	xfs_fileoff_t		startoff2,
+	xfs_filblks_t		blockcount)
+{
+	struct xfs_mount	*mp = ip1->i_mount;
+	xfs_filblks_t		ip1_mapped, ip2_mapped;
+	int			error;
+
+	/*
+	 * Don't bother with a quota reservation if we're not enforcing them
+	 * or the two inodes have the same dquots.
+	 */
+	if (!(mp->m_qflags & XFS_ALL_QUOTA_ENFD) || ip1 == ip2)
+		return 0;
+
+	if (ip1->i_udquot == ip2->i_udquot &&
+	    ip1->i_gdquot == ip2->i_gdquot &&
+	    ip1->i_pdquot == ip2->i_pdquot)
+		return 0;
+
+	/* Figure out how many blocks we'll move out of each file. */
+	error = xfs_bmap_count_range_blocks(ip1, whichfork, startoff1,
+			blockcount, &ip1_mapped);
+	if (error)
+		return error;
+	error = xfs_bmap_count_range_blocks(ip2, whichfork, startoff2,
+			blockcount, &ip2_mapped);
+	if (error)
+		return error;
+
+	/*
+	 * For each file, compute the net gain in the number of blocks that
+	 * will be mapped into that file and reserve that much quota.  The
+	 * quota counts must be able to absorb at least that much space.
+	 */
+	if (ip2_mapped > ip1_mapped) {
+		error = xfs_trans_reserve_quota_nblks(tp, ip1,
+				ip2_mapped - ip1_mapped, 0,
+				XFS_QMOPT_RES_REGBLKS);
+		if (error)
+			return error;
+	}
+
+	if (ip1_mapped > ip2_mapped) {
+		error = xfs_trans_reserve_quota_nblks(tp, ip2,
+				ip1_mapped - ip2_mapped, 0,
+				XFS_QMOPT_RES_REGBLKS);
+		if (error)
+			return error;
+	}
+
+	/*
+	 * For each file, forcibly reserve the gross gain in mapped blocks so
+	 * that we don't trip over any quota block reservation assertions.
+	 * We must reserve the gross gain because the quota code subtracts from
+	 * bcount the number of blocks that we unmap; it does not add that
+	 * quantity back to the quota block reservation.
+	 */
+	error = xfs_trans_reserve_quota_nblks(tp, ip1, ip1_mapped, 0,
+			XFS_QMOPT_FORCE_RES | XFS_QMOPT_RES_REGBLKS);
+	if (error)
+		return error;
+
+	return xfs_trans_reserve_quota_nblks(tp, ip2, ip2_mapped, 0,
+			XFS_QMOPT_FORCE_RES | XFS_QMOPT_RES_REGBLKS);
+}
+
+/* Swap parts of two files. */
+int
+xfs_swap_range(
+	struct xfs_inode	*ip1,
+	struct xfs_inode	*ip2,
+	const struct file_swap_range *fsr)
+{
+	struct xfs_mount	*mp = ip1->i_mount;
+	struct xfs_trans	*tp;
+	xfs_fileoff_t		startoff1;
+	xfs_fileoff_t		startoff2;
+	xfs_filblks_t		blockcount = XFS_B_TO_FSB(mp, fsr->length);
+	unsigned int		resblks;
+	unsigned int		sxflags = 0;
+	int			error;
+
+	if (!xfs_sb_version_hasatomicswap(&mp->m_sb))
+		return -EOPNOTSUPP;
+
+	startoff1 = XFS_B_TO_FSBT(mp, fsr->file1_offset);
+	startoff2 = XFS_B_TO_FSBT(mp, fsr->file2_offset);
+
+	/*
+	 * Cancel CoW fork preallocations for the ranges of both files.  The
+	 * prep function should have flushed all the dirty data, so the only
+	 * extents remaining should be speculative.
+	 */
+	if (xfs_inode_has_cow_data(ip1)) {
+		error = xfs_reflink_cancel_cow_range(ip1, fsr->file1_offset,
+				fsr->length, true);
+		if (error)
+			return error;
+	}
+
+	if (xfs_inode_has_cow_data(ip2)) {
+		error = xfs_reflink_cancel_cow_range(ip2, fsr->file2_offset,
+				fsr->length, true);
+		if (error)
+			return error;
+	}
+
+	resblks = xfs_swap_range_calc_resblks(ip1, ip2, XFS_DATA_FORK,
+			blockcount);
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0, 0, &tp);
+	if (error)
+		return error;
+
+	/*
+	 * Lock and join the inodes to the tansaction so that transaction commit
+	 * or cancel will unlock the inodes from this point onwards.
+	 */
+	if (ip1 != ip2) {
+		xfs_lock_two_inodes(ip1, XFS_ILOCK_EXCL, ip2, XFS_ILOCK_EXCL);
+		xfs_trans_ijoin(tp, ip1, 0);
+		xfs_trans_ijoin(tp, ip2, 0);
+	} else {
+		xfs_ilock(ip1, XFS_ILOCK_EXCL);
+		xfs_trans_ijoin(tp, ip1, 0);
+	}
+
+	trace_xfs_swap_extent_before(ip2, 0);
+	trace_xfs_swap_extent_before(ip1, 1);
+
+	/*
+	 * Do all of the inputs checking that we can only do once we've taken
+	 * both ILOCKs.
+	 */
+	error = generic_swap_file_range_check_fresh(VFS_I(ip1), VFS_I(ip2),
+			fsr);
+	if (error)
+		goto out_trans_cancel;
+
+	if (XFS_IFORK_FORMAT(ip1, XFS_DATA_FORK) == XFS_DINODE_FMT_LOCAL ||
+	    XFS_IFORK_FORMAT(ip2, XFS_DATA_FORK) == XFS_DINODE_FMT_LOCAL) {
+		error = -EINVAL;
+		goto out_trans_cancel;
+	}
+
+	/*
+	 * Reserve ourselves some quota if any of them are in enforcing mode.
+	 * In theory we only need enough to satisfy the change in the number
+	 * of blocks between the two ranges being remapped.
+	 */
+	error = xfs_swap_range_prep_quota(tp, ip1, ip2, XFS_DATA_FORK,
+			startoff1, startoff2, blockcount);
+	if (error)
+		goto out_trans_cancel;
+
+	/* Perform the file range swap. */
+	if (fsr->flags & FILE_SWAP_RANGE_TO_EOF)
+		sxflags |= XFS_SWAPEXT_SET_SIZES;
+
+	error = xfs_swapext_atomic(&tp, ip1, ip2, XFS_DATA_FORK, startoff1,
+			startoff2, blockcount, sxflags);
+	if (error)
+		goto out_trans_cancel;
+
+	/*
+	 * If the caller wanted us to swap two complete files of unequal
+	 * length, swap the incore sizes now.  This should be safe because we
+	 * flushed both files' page caches and moved all the post-eof extents,
+	 * so there should not be anything to zero.
+	 */
+	if (fsr->flags & FILE_SWAP_RANGE_TO_EOF) {
+		loff_t	temp;
+
+		temp = i_size_read(VFS_I(ip2));
+		i_size_write(VFS_I(ip2), i_size_read(VFS_I(ip1)));
+		i_size_write(VFS_I(ip1), temp);
+	}
+
+	/*
+	 * If this is a synchronous mount, make sure that the
+	 * transaction goes to disk before returning to the user.
+	 */
+	if (mp->m_flags & XFS_MOUNT_WSYNC)
+		xfs_trans_set_sync(tp);
+
+	error = xfs_trans_commit(tp);
+
+	trace_xfs_swap_extent_after(ip2, 0);
+	trace_xfs_swap_extent_after(ip1, 1);
+
+out_unlock:
+	xfs_iunlock(ip1, XFS_ILOCK_EXCL);
+	if (ip1 != ip2)
+		xfs_iunlock(ip2, XFS_ILOCK_EXCL);
+	return error;
+
+out_trans_cancel:
+	xfs_trans_cancel(tp);
+	goto out_unlock;
+}
+
diff --git a/fs/xfs/xfs_bmap_util.h b/fs/xfs/xfs_bmap_util.h
index 9f993168b55b..d3444a63bbd7 100644
--- a/fs/xfs/xfs_bmap_util.h
+++ b/fs/xfs/xfs_bmap_util.h
@@ -68,6 +68,10 @@ int	xfs_free_eofblocks(struct xfs_inode *ip);
 
 int	xfs_swap_extents(struct xfs_inode *ip, struct xfs_inode *tip,
 			 struct xfs_swapext *sx);
+int	xfs_swap_range_prep(struct file *file1, struct file *file2,
+			    struct file_swap_range *fsr);
+int	xfs_swap_range(struct xfs_inode *ip1, struct xfs_inode *ip2,
+		       const struct file_swap_range *fsr);
 
 xfs_daddr_t xfs_fsb_to_db(struct xfs_inode *ip, xfs_fsblock_t fsb);
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 9bce98323ca6..d446c16cfc30 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1065,6 +1065,44 @@ xfs_file_remap_range(
 	return remapped > 0 ? remapped : ret;
 }
 
+STATIC int
+xfs_file_swap_range(
+	struct file		*file1,
+	struct file		*file2,
+	struct file_swap_range	*fsr)
+{
+	struct xfs_inode	*ip1 = XFS_I(file_inode(file1));
+	struct xfs_inode	*ip2 = XFS_I(file_inode(file2));
+	struct xfs_mount	*mp = ip1->i_mount;
+	int			ret;
+
+	if (XFS_FORCED_SHUTDOWN(mp))
+		return -EIO;
+
+	/* Lock both files against IO */
+	ret = xfs_ilock_two_io(ip1, ip2);
+	if (ret)
+		return ret;
+
+	/* Prepare and then swap file data. */
+	ret = xfs_swap_range_prep(file1, file2, fsr);
+	if (ret)
+		goto out_unlock;
+
+	trace_xfs_file_swap_range(ip1, fsr->file1_offset, fsr->length, ip2,
+			fsr->file2_offset);
+
+	ret = xfs_swap_range(ip1, ip2, fsr);
+	if (ret)
+		goto out_unlock;
+
+out_unlock:
+	xfs_iunlock_two_io(ip1, ip2);
+	if (ret)
+		trace_xfs_file_swap_range_error(ip2, ret, _RET_IP_);
+	return ret;
+}
+
 STATIC int
 xfs_file_open(
 	struct inode	*inode,
@@ -1307,6 +1345,7 @@ const struct file_operations xfs_file_operations = {
 	.fallocate	= xfs_file_fallocate,
 	.fadvise	= xfs_file_fadvise,
 	.remap_file_range = xfs_file_remap_range,
+	.swap_file_range = xfs_file_swap_range,
 };
 
 const struct file_operations xfs_dir_file_operations = {
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index af9c7bcb7a8a..7917203e56d4 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -3208,6 +3208,10 @@ DEFINE_INODE_IREC_EVENT(xfs_reflink_cancel_cow);
 DEFINE_INODE_IREC_EVENT(xfs_swap_extent_rmap_remap);
 DEFINE_INODE_IREC_EVENT(xfs_swap_extent_rmap_remap_piece);
 DEFINE_INODE_ERROR_EVENT(xfs_swap_extent_rmap_error);
+
+/* swapext tracepoints */
+DEFINE_DOUBLE_IO_EVENT(xfs_file_swap_range);
+DEFINE_INODE_ERROR_EVENT(xfs_file_swap_range_error);
 DEFINE_INODE_IREC_EVENT(xfs_swapext_extent1);
 DEFINE_INODE_IREC_EVENT(xfs_swapext_extent2);
 DEFINE_ITRUNC_EVENT(xfs_swapext_update_inode_size);

