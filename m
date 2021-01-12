Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D0B2F2543
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 02:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbhALBIo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 20:08:44 -0500
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:37844 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731454AbhALBIo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 20:08:44 -0500
Received: from dread.disaster.area (pa49-179-167-107.pa.nsw.optusnet.com.au [49.179.167.107])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 00E761B4F38;
        Tue, 12 Jan 2021 12:08:00 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kz8A1-005WbI-JP; Tue, 12 Jan 2021 12:07:49 +1100
Received: from dave by discord.disaster.area with local (Exim 4.94)
        (envelope-from <david@fromorbit.com>)
        id 1kz8A1-004qb8-Bm; Tue, 12 Jan 2021 12:07:49 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, avi@scylladb.com, andres@anarazel.de
Subject: [PATCH 5/6] xfs: split unaligned DIO write code out
Date:   Tue, 12 Jan 2021 12:07:45 +1100
Message-Id: <20210112010746.1154363-6-david@fromorbit.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210112010746.1154363-1-david@fromorbit.com>
References: <20210112010746.1154363-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=+wqVUQIkAh0lLYI+QRsciw==:117 a=+wqVUQIkAh0lLYI+QRsciw==:17
        a=EmqxpYm9HcoA:10 a=20KFwNOVAAAA:8 a=AsoV7O_VX2oRa6YRAogA:9
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

The unaligned DIO write path is more convulted than the normal path,
and we are about to make it more complex. Keep the block aligned
fast path dio write code trim and simple by splitting out the
unaligned DIO code from it.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_file.c | 177 +++++++++++++++++++++++++++++-----------------
 1 file changed, 113 insertions(+), 64 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 512833ce1d41..bba33be17eff 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -508,7 +508,7 @@ static const struct iomap_dio_ops xfs_dio_write_ops = {
 };
 
 /*
- * xfs_file_dio_aio_write - handle direct IO writes
+ * Handle block aligned direct IO writes
  *
  * Lock the inode appropriately to prepare for and issue a direct IO write.
  * By separating it from the buffered write path we remove all the tricky to
@@ -518,35 +518,88 @@ static const struct iomap_dio_ops xfs_dio_write_ops = {
  * until we're sure the bytes at the new EOF have been zeroed and/or the cached
  * pages are flushed out.
  *
- * In most cases the direct IO writes will be done holding IOLOCK_SHARED
+ * Returns with locks held indicated by @iolock and errors indicated by
+ * negative return values.
+ */
+STATIC ssize_t
+xfs_file_dio_write_aligned(
+	struct xfs_inode	*ip,
+	struct kiocb		*iocb,
+	struct iov_iter		*from)
+{
+	int			iolock = XFS_IOLOCK_SHARED;
+	size_t			count;
+	ssize_t			ret;
+	struct iomap_dio_rw_args args = {
+		.iocb			= iocb,
+		.iter			= from,
+		.ops			= &xfs_direct_write_iomap_ops,
+		.dops			= &xfs_dio_write_ops,
+		.wait_for_completion	= is_sync_kiocb(iocb),
+		.nonblocking		= (iocb->ki_flags & IOCB_NOWAIT),
+	};
+
+	ret = xfs_ilock_iocb(iocb, iolock);
+	if (ret)
+		return ret;
+	ret = xfs_file_aio_write_checks(iocb, from, &iolock);
+	if (ret)
+		goto out;
+	count = iov_iter_count(from);
+
+	/*
+	 * We don't need to hold the IOLOCK exclusively across the IO, so demote
+	 * the iolock back to shared if we had to take the exclusive lock in
+	 * xfs_file_aio_write_checks() for other reasons.
+	 */
+	if (iolock == XFS_IOLOCK_EXCL) {
+		xfs_ilock_demote(ip, XFS_IOLOCK_EXCL);
+		iolock = XFS_IOLOCK_SHARED;
+	}
+
+	trace_xfs_file_direct_write(ip, count, iocb->ki_pos);
+	ret = iomap_dio_rw(&args);
+out:
+	if (iolock)
+		xfs_iunlock(ip, iolock);
+
+	/*
+	 * No fallback to buffered IO after short writes for XFS, direct I/O
+	 * will either complete fully or return an error.
+	 */
+	ASSERT(ret < 0 || ret == count);
+	return ret;
+}
+
+/*
+ * Handle block unaligned direct IO writes
+ *
+ * In most cases direct IO writes will be done holding IOLOCK_SHARED
  * allowing them to be done in parallel with reads and other direct IO writes.
  * However, if the IO is not aligned to filesystem blocks, the direct IO layer
- * needs to do sub-block zeroing and that requires serialisation against other
+ * may need to do sub-block zeroing and that requires serialisation against other
  * direct IOs to the same block. In this case we need to serialise the
  * submission of the unaligned IOs so that we don't get racing block zeroing in
- * the dio layer.  To avoid the problem with aio, we also need to wait for
+ * the dio layer.
+ *
+ * To provide the same serialisation for AIO, we also need to wait for
  * outstanding IOs to complete so that unwritten extent conversion is completed
  * before we try to map the overlapping block. This is currently implemented by
  * hitting it with a big hammer (i.e. inode_dio_wait()).
  *
- * Returns with locks held indicated by @iolock and errors indicated by
- * negative return values.
+ * This means that unaligned dio writes alwys block. There is no "nowait" fast
+ * path in this code - if IOCB_NOWAIT is set we simply return -EAGAIN up front
+ * and we don't have to worry about that anymore.
  */
-STATIC ssize_t
-xfs_file_dio_aio_write(
+static ssize_t
+xfs_file_dio_write_unaligned(
+	struct xfs_inode	*ip,
 	struct kiocb		*iocb,
 	struct iov_iter		*from)
 {
-	struct file		*file = iocb->ki_filp;
-	struct address_space	*mapping = file->f_mapping;
-	struct inode		*inode = mapping->host;
-	struct xfs_inode	*ip = XFS_I(inode);
-	struct xfs_mount	*mp = ip->i_mount;
-	ssize_t			ret = 0;
-	int			unaligned_io = 0;
-	int			iolock;
-	size_t			count = iov_iter_count(from);
-	struct xfs_buftarg      *target = xfs_inode_buftarg(ip);
+	int			iolock = XFS_IOLOCK_EXCL;
+	size_t			count;
+	ssize_t			ret;
 	struct iomap_dio_rw_args args = {
 		.iocb			= iocb,
 		.iter			= from,
@@ -556,49 +609,25 @@ xfs_file_dio_aio_write(
 		.nonblocking		= (iocb->ki_flags & IOCB_NOWAIT),
 	};
 
-	/* DIO must be aligned to device logical sector size */
-	if ((iocb->ki_pos | count) & target->bt_logical_sectormask)
-		return -EINVAL;
-
 	/*
-	 * Don't take the exclusive iolock here unless the I/O is unaligned to
-	 * the file system block size.  We don't need to consider the EOF
-	 * extension case here because xfs_file_aio_write_checks() will relock
-	 * the inode as necessary for EOF zeroing cases and fill out the new
-	 * inode size as appropriate.
+	 * This must be the only IO in-flight. Wait on it before we
+	 * release the iolock to prevent subsequent overlapping IO.
 	 */
-	if ((iocb->ki_pos & mp->m_blockmask) ||
-	    ((iocb->ki_pos + count) & mp->m_blockmask)) {
-		unaligned_io = 1;
-
-		/*
-		 * This must be the only IO in-flight. Wait on it before we
-		 * release the iolock to prevent subsequent overlapping IO.
-		 */
-		args.wait_for_completion = true;
+	args.wait_for_completion = true;
 
-		/*
-		 * We can't properly handle unaligned direct I/O to reflink
-		 * files yet, as we can't unshare a partial block.
-		 */
-		if (xfs_is_cow_inode(ip)) {
-			trace_xfs_reflink_bounce_dio_write(ip, iocb->ki_pos, count);
-			return -ENOTBLK;
-		}
-		iolock = XFS_IOLOCK_EXCL;
-	} else {
-		iolock = XFS_IOLOCK_SHARED;
+	/*
+	 * We can't properly handle unaligned direct I/O to reflink
+	 * files yet, as we can't unshare a partial block.
+	 */
+	if (xfs_is_cow_inode(ip)) {
+		trace_xfs_reflink_bounce_dio_write(ip, iocb->ki_pos, count);
+		return -ENOTBLK;
 	}
 
-	if (iocb->ki_flags & IOCB_NOWAIT) {
-		/* unaligned dio always waits, bail */
-		if (unaligned_io)
-			return -EAGAIN;
-		if (!xfs_ilock_nowait(ip, iolock))
-			return -EAGAIN;
-	} else {
-		xfs_ilock(ip, iolock);
-	}
+	/* unaligned dio always waits, bail */
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		return -EAGAIN;
+	xfs_ilock(ip, iolock);
 
 	ret = xfs_file_aio_write_checks(iocb, from, &iolock);
 	if (ret)
@@ -612,13 +641,7 @@ xfs_file_dio_aio_write(
 	 * iolock if we had to take the exclusive lock in
 	 * xfs_file_aio_write_checks() for other reasons.
 	 */
-	if (unaligned_io) {
-		inode_dio_wait(inode);
-	} else if (iolock == XFS_IOLOCK_EXCL) {
-		xfs_ilock_demote(ip, XFS_IOLOCK_EXCL);
-		iolock = XFS_IOLOCK_SHARED;
-	}
-
+	inode_dio_wait(VFS_I(ip));
 	trace_xfs_file_direct_write(ip, count, iocb->ki_pos);
 	ret = iomap_dio_rw(&args);
 out:
@@ -633,6 +656,32 @@ xfs_file_dio_aio_write(
 	return ret;
 }
 
+static ssize_t
+xfs_file_dio_write(
+	struct kiocb		*iocb,
+	struct iov_iter		*from)
+{
+	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_buftarg      *target = xfs_inode_buftarg(ip);
+	size_t			count = iov_iter_count(from);
+
+	/* DIO must be aligned to device logical sector size */
+	if ((iocb->ki_pos | count) & target->bt_logical_sectormask)
+		return -EINVAL;
+
+	/*
+	 * Don't take the exclusive iolock here unless the I/O is unaligned to
+	 * the file system block size.  We don't need to consider the EOF
+	 * extension case here because xfs_file_aio_write_checks() will relock
+	 * the inode as necessary for EOF zeroing cases and fill out the new
+	 * inode size as appropriate.
+	 */
+	if ((iocb->ki_pos | count) & mp->m_blockmask)
+		return xfs_file_dio_write_unaligned(ip, iocb, from);
+	return xfs_file_dio_write_aligned(ip, iocb, from);
+}
+
 static noinline ssize_t
 xfs_file_dax_write(
 	struct kiocb		*iocb,
@@ -783,7 +832,7 @@ xfs_file_write_iter(
 		 * CoW.  In all other directio scenarios we do not
 		 * allow an operation to fall back to buffered mode.
 		 */
-		ret = xfs_file_dio_aio_write(iocb, from);
+		ret = xfs_file_dio_write(iocb, from);
 		if (ret != -ENOTBLK)
 			return ret;
 	}
-- 
2.28.0

