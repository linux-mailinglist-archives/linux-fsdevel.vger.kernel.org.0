Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2465830090A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 17:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbhAVQvn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 11:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729425AbhAVQo6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:44:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402FCC06174A;
        Fri, 22 Jan 2021 08:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=xW+GNVdEkze1LKXdXM3jBkaZEvyUKVDUDB4GEqmx9Fs=; b=uQkLpKYZGNnPrhghLd2Zr3esn8
        l+iuASvjbO/l4SXuFmSR8JwPUXxAjsYXIeYe23zGSPmJpWB8Il14gstAEIwvLXbOatCwhMr1ggbwb
        Ni5q4fXhRyKinK9dv7KTvQWsxYd86MtzAZO9ytTqEwHm9C5iiZPkMsn1YvF6cAxDk+2W0/Enizumt
        pyfrJRlbdhFYZfmzknwX8wt/6Stsb7KzIFeBdE6eNi5Ea6SSC8Y0hMYLYmF/jwasw08p0vTQRmCrF
        ecZdUuUEXyd4JF934TYsAdCRiwLNurYNXdgYvYFRUs9EWc4xCNu/I24fXysd8K1VI04HGqcDNxVef
        6llxgw1g==;
Received: from [2001:4bb8:188:1954:662b:86d3:ab5f:ac21] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l2zLa-000xiM-IG; Fri, 22 Jan 2021 16:31:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, avi@scylladb.com,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 07/11] xfs: split the unaligned DIO write code out
Date:   Fri, 22 Jan 2021 17:20:39 +0100
Message-Id: <20210122162043.616755-8-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122162043.616755-1-hch@lst.de>
References: <20210122162043.616755-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

The unaligned DIO write path is more convolted than the normal path,
and we are about to make it more complex. Keep the block aligned
fast path dio write code trim and simple by splitting out the
unaligned DIO code from it.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
[hch: rebased, fixed a few minor nits]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_file.c | 170 +++++++++++++++++++++++-----------------------
 1 file changed, 85 insertions(+), 85 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index a696bd34f71d21..db0d96ca4d92cb 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -500,117 +500,117 @@ static const struct iomap_dio_ops xfs_dio_write_ops = {
 };
 
 /*
- * xfs_file_dio_write - handle direct IO writes
- *
- * Lock the inode appropriately to prepare for and issue a direct IO write.
- * By separating it from the buffered write path we remove all the tricky to
- * follow locking changes and looping.
- *
- * If there are cached pages or we're extending the file, we need IOLOCK_EXCL
- * until we're sure the bytes at the new EOF have been zeroed and/or the cached
- * pages are flushed out.
- *
- * In most cases the direct IO writes will be done holding IOLOCK_SHARED
- * allowing them to be done in parallel with reads and other direct IO writes.
- * However, if the IO is not aligned to filesystem blocks, the direct IO layer
- * needs to do sub-block zeroing and that requires serialisation against other
- * direct IOs to the same block. In this case we need to serialise the
- * submission of the unaligned IOs so that we don't get racing block zeroing in
- * the dio layer.  To avoid the problem with aio, we also need to wait for
- * outstanding IOs to complete so that unwritten extent conversion is completed
- * before we try to map the overlapping block. This is currently implemented by
- * hitting it with a big hammer (i.e. inode_dio_wait()).
- *
- * Returns with locks held indicated by @iolock and errors indicated by
- * negative return values.
+ * Handle block aligned direct I/O writes
  */
-STATIC ssize_t
-xfs_file_dio_write(
+static noinline ssize_t
+xfs_file_dio_write_aligned(
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
+	int			iolock = XFS_IOLOCK_SHARED;
+	ssize_t			ret;
 
-	/* DIO must be aligned to device logical sector size */
-	if ((iocb->ki_pos | count) & target->bt_logical_sectormask)
-		return -EINVAL;
+	ret = xfs_ilock_iocb(iocb, iolock);
+	if (ret)
+		return ret;
+	ret = xfs_file_write_checks(iocb, from, &iolock);
+	if (ret)
+		goto out_unlock;
 
 	/*
-	 * Don't take the exclusive iolock here unless the I/O is unaligned to
-	 * the file system block size.  We don't need to consider the EOF
-	 * extension case here because xfs_file_write_checks() will relock
-	 * the inode as necessary for EOF zeroing cases and fill out the new
-	 * inode size as appropriate.
+	 * We don't need to hold the IOLOCK exclusively across the IO, so demote
+	 * the iolock back to shared if we had to take the exclusive lock in
+	 * xfs_file_write_checks() for other reasons.
 	 */
-	if ((iocb->ki_pos & mp->m_blockmask) ||
-	    ((iocb->ki_pos + count) & mp->m_blockmask)) {
-		unaligned_io = 1;
-
-		/*
-		 * We can't properly handle unaligned direct I/O to reflink
-		 * files yet, as we can't unshare a partial block.
-		 */
-		if (xfs_is_cow_inode(ip)) {
-			trace_xfs_reflink_bounce_dio_write(iocb, from);
-			return -ENOTBLK;
-		}
-		iolock = XFS_IOLOCK_EXCL;
-	} else {
+	if (iolock == XFS_IOLOCK_EXCL) {
+		xfs_ilock_demote(ip, XFS_IOLOCK_EXCL);
 		iolock = XFS_IOLOCK_SHARED;
 	}
+	trace_xfs_file_direct_write(iocb, from);
+	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
+			   &xfs_dio_write_ops, is_sync_kiocb(iocb));
+out_unlock:
+	if (iolock)
+		xfs_iunlock(ip, iolock);
+	return ret;
+}
 
-	if (iocb->ki_flags & IOCB_NOWAIT) {
-		/* unaligned dio always waits, bail */
-		if (unaligned_io)
-			return -EAGAIN;
-		if (!xfs_ilock_nowait(ip, iolock))
-			return -EAGAIN;
-	} else {
-		xfs_ilock(ip, iolock);
+/*
+ * Handle block unaligned direct I/O writes
+ *
+ * In most cases direct I/O writes will be done holding IOLOCK_SHARED, allowing
+ * them to be done in parallel with reads and other direct I/O writes.  However,
+ * if the I/O is not aligned to filesystem blocks, the direct I/O layer may need
+ * to do sub-block zeroing and that requires serialisation against other direct
+ * I/O to the same block.  In this case we need to serialise the submission of
+ * the unaligned I/O so that we don't get racing block zeroing in the dio layer.
+ *
+ * This means that unaligned dio writes always block. There is no "nowait" fast
+ * path in this code - if IOCB_NOWAIT is set we simply return -EAGAIN up front
+ * and we don't have to worry about that anymore.
+ */
+static noinline ssize_t
+xfs_file_dio_write_unaligned(
+	struct xfs_inode	*ip,
+	struct kiocb		*iocb,
+	struct iov_iter		*from)
+{
+	int			iolock = XFS_IOLOCK_EXCL;
+	ssize_t			ret;
+
+	/* unaligned dio always waits, bail */
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		return -EAGAIN;
+	xfs_ilock(ip, iolock);
+
+	/*
+	 * We can't properly handle unaligned direct I/O to reflink files yet,
+	 * as we can't unshare a partial block.
+	 */
+	if (xfs_is_cow_inode(ip)) {
+		trace_xfs_reflink_bounce_dio_write(iocb, from);
+		ret = -ENOTBLK;
+		goto out_unlock;
 	}
 
 	ret = xfs_file_write_checks(iocb, from, &iolock);
 	if (ret)
-		goto out;
-	count = iov_iter_count(from);
+		goto out_unlock;
 
 	/*
-	 * If we are doing unaligned IO, we can't allow any other overlapping IO
-	 * in-flight at the same time or we risk data corruption. Wait for all
-	 * other IO to drain before we submit. If the IO is aligned, demote the
-	 * iolock if we had to take the exclusive lock in
-	 * xfs_file_write_checks() for other reasons.
+	 * If we are doing unaligned I/O, this must be the only I/O in-flight.
+	 * Otherwise we risk data corruption due to unwritten extent conversions
+	 * from the AIO end_io handler.  Wait for all other I/O to drain first.
 	 */
-	if (unaligned_io) {
-		inode_dio_wait(inode);
-	} else if (iolock == XFS_IOLOCK_EXCL) {
-		xfs_ilock_demote(ip, XFS_IOLOCK_EXCL);
-		iolock = XFS_IOLOCK_SHARED;
-	}
+	inode_dio_wait(VFS_I(ip));
 
 	trace_xfs_file_direct_write(iocb, from);
-	/*
-	 * If unaligned, this is the only IO in-flight. Wait on it before we
-	 * release the iolock to prevent subsequent overlapping IO.
-	 */
 	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
-			   &xfs_dio_write_ops,
-			   is_sync_kiocb(iocb) || unaligned_io);
-out:
+			   &xfs_dio_write_ops, true);
+out_unlock:
 	if (iolock)
 		xfs_iunlock(ip, iolock);
 	return ret;
 }
 
+static ssize_t
+xfs_file_dio_write(
+	struct kiocb		*iocb,
+	struct iov_iter		*from)
+{
+	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
+	struct xfs_buftarg      *target = xfs_inode_buftarg(ip);
+	size_t			count = iov_iter_count(from);
+
+	/* direct I/O must be aligned to device logical sector size */
+	if ((iocb->ki_pos | count) & target->bt_logical_sectormask)
+		return -EINVAL;
+	if ((iocb->ki_pos | count) & ip->i_mount->m_blockmask)
+		return xfs_file_dio_write_unaligned(ip, iocb, from);
+	return xfs_file_dio_write_aligned(ip, iocb, from);
+}
+
 static noinline ssize_t
 xfs_file_dax_write(
 	struct kiocb		*iocb,
-- 
2.29.2

