Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90302FAAB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 20:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437641AbhARTzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 14:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394024AbhARTyw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:54:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEFBC061574;
        Mon, 18 Jan 2021 11:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6/oR6lDXpa3EWkbl4ihHMZf7Dei9pDqPjBfjgy5Axtw=; b=WWiaOeV0fevY98aj3vxw5Rzxop
        nRZXHuJKm2AnMOcgpgfZhC7m1dLoCodIjFm2M7LHSj5RixodYJZh3YqK+mpWnSZvOLwci4tsC5P7U
        EJXY5ofZn9FBV7vR+D95cylvo8XlIGffEwL/FzbwQiaX8cWTWuKLoMWaMzZh+IVnMilo7y1rkE8oc
        lk94pAc6G/UR81wUML/wZSeFz0zWHkpd6T50vMPd2sAI84izU/RYQ14NzCpyP1wRiAOI+WPjyouic
        otJWSbl6vp+iFDZ32GQNqLXPGSkT1t/Gsaze4mSFlp6013+qqjS/N7qhFc8R0VOxOnCbbQ9H0ogYQ
        ERvO4ndg==;
Received: from 089144206130.atnat0015.highway.bob.at ([89.144.206.130] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l1ab4-00DK8S-Cp; Mon, 18 Jan 2021 19:54:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, avi@scylladb.com,
        Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 07/11] xfs: split unaligned DIO write code out
Date:   Mon, 18 Jan 2021 20:35:12 +0100
Message-Id: <20210118193516.2915706-8-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118193516.2915706-1-hch@lst.de>
References: <20210118193516.2915706-1-hch@lst.de>
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
---
 fs/xfs/xfs_file.c | 168 +++++++++++++++++++++++++---------------------
 1 file changed, 92 insertions(+), 76 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index a696bd34f71d21..bffd7240cefb7f 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -500,117 +500,133 @@ static const struct iomap_dio_ops xfs_dio_write_ops = {
 };
 
 /*
- * xfs_file_dio_write - handle direct IO writes
+ * Handle block aligned direct IO writes
  *
  * Lock the inode appropriately to prepare for and issue a direct IO write.
- * By separating it from the buffered write path we remove all the tricky to
- * follow locking changes and looping.
  *
  * If there are cached pages or we're extending the file, we need IOLOCK_EXCL
  * until we're sure the bytes at the new EOF have been zeroed and/or the cached
  * pages are flushed out.
+ */
+static noinline ssize_t
+xfs_file_dio_write_aligned(
+	struct xfs_inode	*ip,
+	struct kiocb		*iocb,
+	struct iov_iter		*from)
+{
+	int			iolock = XFS_IOLOCK_SHARED;
+	ssize_t			ret;
+
+	ret = xfs_ilock_iocb(iocb, iolock);
+	if (ret)
+		return ret;
+	ret = xfs_file_write_checks(iocb, from, &iolock);
+	if (ret)
+		goto out_unlock;
+
+	/*
+	 * We don't need to hold the IOLOCK exclusively across the IO, so demote
+	 * the iolock back to shared if we had to take the exclusive lock in
+	 * xfs_file_write_checks() for other reasons.
+	 */
+	if (iolock == XFS_IOLOCK_EXCL) {
+		xfs_ilock_demote(ip, XFS_IOLOCK_EXCL);
+		iolock = XFS_IOLOCK_SHARED;
+	}
+	trace_xfs_file_direct_write(iocb, from);
+	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
+			   &xfs_dio_write_ops, is_sync_kiocb(iocb));
+out_unlock:
+	if (iolock)
+		xfs_iunlock(ip, iolock);
+	return ret;
+}
+
+/*
+ * Handle block unaligned direct IO writes
+ *
+ * In most cases direct IO writes will be done holding IOLOCK_SHARED, allowing
+ * them to be done in parallel with reads and other direct IO writes.  However,
+ * if the I/O is not aligned to filesystem blocks, the direct I/O layer may
+ * need to do sub-block zeroing and that requires serialisation against other
+ * direct I/Os to the same block. In this case we need to serialise the
+ * submission of the unaligned I/Os so that we don't get racing block zeroing in
+ * the dio layer.
  *
- * In most cases the direct IO writes will be done holding IOLOCK_SHARED
- * allowing them to be done in parallel with reads and other direct IO writes.
- * However, if the IO is not aligned to filesystem blocks, the direct IO layer
- * needs to do sub-block zeroing and that requires serialisation against other
- * direct IOs to the same block. In this case we need to serialise the
- * submission of the unaligned IOs so that we don't get racing block zeroing in
- * the dio layer.  To avoid the problem with aio, we also need to wait for
+ * To provide the same serialisation for AIO, we also need to wait for
  * outstanding IOs to complete so that unwritten extent conversion is completed
  * before we try to map the overlapping block. This is currently implemented by
  * hitting it with a big hammer (i.e. inode_dio_wait()).
  *
- * Returns with locks held indicated by @iolock and errors indicated by
- * negative return values.
+ * This means that unaligned dio writes always block. There is no "nowait" fast
+ * path in this code - if IOCB_NOWAIT is set we simply return -EAGAIN up front
+ * and we don't have to worry about that anymore.
  */
-STATIC ssize_t
-xfs_file_dio_write(
+static noinline ssize_t
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
+	ssize_t			ret;
 
-	/* DIO must be aligned to device logical sector size */
-	if ((iocb->ki_pos | count) & target->bt_logical_sectormask)
-		return -EINVAL;
+	/* unaligned dio always waits, bail */
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		return -EAGAIN;
+	xfs_ilock(ip, iolock);
 
 	/*
-	 * Don't take the exclusive iolock here unless the I/O is unaligned to
-	 * the file system block size.  We don't need to consider the EOF
-	 * extension case here because xfs_file_write_checks() will relock
-	 * the inode as necessary for EOF zeroing cases and fill out the new
-	 * inode size as appropriate.
+	 * We can't properly handle unaligned direct I/O to reflink files yet,
+	 * as we can't unshare a partial block.
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
-		iolock = XFS_IOLOCK_SHARED;
-	}
-
-	if (iocb->ki_flags & IOCB_NOWAIT) {
-		/* unaligned dio always waits, bail */
-		if (unaligned_io)
-			return -EAGAIN;
-		if (!xfs_ilock_nowait(ip, iolock))
-			return -EAGAIN;
-	} else {
-		xfs_ilock(ip, iolock);
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
+	 * If we are doing unaligned I/O, we can't allow any other overlapping
+	 * I/O in-flight at the same time or we risk data corruption. Wait for
+	 * all other I/O to drain before we submit.
 	 */
-	if (unaligned_io) {
-		inode_dio_wait(inode);
-	} else if (iolock == XFS_IOLOCK_EXCL) {
-		xfs_ilock_demote(ip, XFS_IOLOCK_EXCL);
-		iolock = XFS_IOLOCK_SHARED;
-	}
+	inode_dio_wait(VFS_I(ip));
 
-	trace_xfs_file_direct_write(iocb, from);
 	/*
-	 * If unaligned, this is the only IO in-flight. Wait on it before we
-	 * release the iolock to prevent subsequent overlapping IO.
+	 * This must be the only I/O in-flight. Wait on it before we release the
+	 * iolock to prevent subsequent overlapping I/O.
 	 */
+	trace_xfs_file_direct_write(iocb, from);
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
+	/* DIO must be aligned to device logical sector size */
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

