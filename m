Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65543008C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 17:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbhAVQiZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 11:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729672AbhAVQh5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:37:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0CDC061793;
        Fri, 22 Jan 2021 08:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wNS9X7L7s0iIAezeC8kbmjnHRSM8XWuFNVlVWiykM0o=; b=T3EzMSB9UoT1NHy8A5TldKJ418
        xiJRhNaX/eB0Cb2XKRn0D6w37OYmyCob/ASAY5LnjNhPIVYORbvHsZMb4YzXOpsOzdZSV4uiOdxtn
        3lA16llMXm4aErH4kToaXnxJyqZplUOQ9MTpShjoOXtyvT1ZRfcW7icGysKe9k+GyFhYafeHMuvv4
        hVmBc2C3pbR9KkvQkIWBvTRPjyxBJC/bISU5Vve02r/pXfCTlhhVgMAoPtGpqhNy7QKggs2aPyGZM
        s54b+AVcFImrpV9YWagaWtgY9WFuk56f6uSdLSyrpbwYl4vFnsZo8PhwTVfnzJYmEz205GudcRmrZ
        7qaWcBgw==;
Received: from [2001:4bb8:188:1954:662b:86d3:ab5f:ac21] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l2zO3-000xoq-9e; Fri, 22 Jan 2021 16:34:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, avi@scylladb.com,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>
Subject: [PATCH 11/11] xfs: reduce exclusive locking on unaligned dio
Date:   Fri, 22 Jan 2021 17:20:43 +0100
Message-Id: <20210122162043.616755-12-hch@lst.de>
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

Attempt shared locking for unaligned DIO, but only if the the
underlying extent is already allocated and in written state. On
failure, retry with the existing exclusive locking.

Test case is fio randrw of 512 byte IOs using AIO and an iodepth of
32 IOs.

Vanilla:

  READ: bw=4560KiB/s (4670kB/s), 4560KiB/s-4560KiB/s (4670kB/s-4670kB/s), io=134MiB (140MB), run=30001-30001msec
  WRITE: bw=4567KiB/s (4676kB/s), 4567KiB/s-4567KiB/s (4676kB/s-4676kB/s), io=134MiB (140MB), run=30001-30001msec

Patched:
   READ: bw=37.6MiB/s (39.4MB/s), 37.6MiB/s-37.6MiB/s (39.4MB/s-39.4MB/s), io=1127MiB (1182MB), run=30002-30002msec
  WRITE: bw=37.6MiB/s (39.4MB/s), 37.6MiB/s-37.6MiB/s (39.4MB/s-39.4MB/s), io=1128MiB (1183MB), run=30002-30002msec

That's an improvement from ~18k IOPS to a ~150k IOPS, which is
about the IOPS limit of the VM block device setup I'm testing on.

4kB block IO comparison:

   READ: bw=296MiB/s (310MB/s), 296MiB/s-296MiB/s (310MB/s-310MB/s), io=8868MiB (9299MB), run=30002-30002msec
  WRITE: bw=296MiB/s (310MB/s), 296MiB/s-296MiB/s (310MB/s-310MB/s), io=8878MiB (9309MB), run=30002-30002msec

Which is ~150k IOPS, same as what the test gets for sub-block
AIO+DIO writes with this patch.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
[hch: rebased, split unaligned from nowait]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
---
 fs/xfs/xfs_file.c  | 58 +++++++++++++++++++++++++++++++++++-----------
 fs/xfs/xfs_iomap.c | 29 ++++++++++++++++-------
 2 files changed, 66 insertions(+), 21 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index c60ff7b5dd829e..39695b59dfcc92 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -544,10 +544,13 @@ xfs_file_dio_write_aligned(
  * to do sub-block zeroing and that requires serialisation against other direct
  * I/O to the same block.  In this case we need to serialise the submission of
  * the unaligned I/O so that we don't get racing block zeroing in the dio layer.
+ * In the case where sub-block zeroing is not required, we can do concurrent
+ * sub-block dios to the same block successfully.
  *
- * This means that unaligned dio writes always block. There is no "nowait" fast
- * path in this code - if IOCB_NOWAIT is set we simply return -EAGAIN up front
- * and we don't have to worry about that anymore.
+ * Optimistically submit the I/O using the shared lock first, but use the
+ * IOMAP_DIO_OVERWRITE_ONLY flag to tell the lower layers to return -EAGAIN
+ * if block allocation or partial block zeroing would be required.  In that case
+ * we try again with the exclusive lock.
  */
 static noinline ssize_t
 xfs_file_dio_write_unaligned(
@@ -555,13 +558,28 @@ xfs_file_dio_write_unaligned(
 	struct kiocb		*iocb,
 	struct iov_iter		*from)
 {
-	int			iolock = XFS_IOLOCK_EXCL;
+	size_t			isize = i_size_read(VFS_I(ip));
+	size_t			count = iov_iter_count(from);
+	int			iolock = XFS_IOLOCK_SHARED;
+	unsigned int		flags = IOMAP_DIO_OVERWRITE_ONLY;
 	ssize_t			ret;
 
-	/* unaligned dio always waits, bail */
-	if (iocb->ki_flags & IOCB_NOWAIT)
-		return -EAGAIN;
-	xfs_ilock(ip, iolock);
+	/*
+	 * Extending writes need exclusivity because of the sub-block zeroing
+	 * that the DIO code always does for partial tail blocks beyond EOF, so
+	 * don't even bother trying the fast path in this case.
+	 */
+	if (iocb->ki_pos > isize || iocb->ki_pos + count >= isize) {
+retry_exclusive:
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			return -EAGAIN;
+		iolock = XFS_IOLOCK_EXCL;
+		flags = IOMAP_DIO_FORCE_WAIT;
+	}
+
+	ret = xfs_ilock_iocb(iocb, iolock);
+	if (ret)
+		return ret;
 
 	/*
 	 * We can't properly handle unaligned direct I/O to reflink files yet,
@@ -578,15 +596,29 @@ xfs_file_dio_write_unaligned(
 		goto out_unlock;
 
 	/*
-	 * If we are doing unaligned I/O, this must be the only I/O in-flight.
-	 * Otherwise we risk data corruption due to unwritten extent conversions
-	 * from the AIO end_io handler.  Wait for all other I/O to drain first.
+	 * If we are doing exclusive unaligned I/O, this must be the only I/O
+	 * in-flight.  Otherwise we risk data corruption due to unwritten extent
+	 * conversions from the AIO end_io handler.  Wait for all other I/O to
+	 * drain first.
 	 */
-	inode_dio_wait(VFS_I(ip));
+	if (flags & IOMAP_DIO_FORCE_WAIT)
+		inode_dio_wait(VFS_I(ip));
 
 	trace_xfs_file_direct_write(iocb, from);
 	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
-			   &xfs_dio_write_ops, IOMAP_DIO_FORCE_WAIT);
+			   &xfs_dio_write_ops, flags);
+
+	/*
+	 * Retry unaligned I/O with exclusive blocking semantics if the DIO
+	 * layer rejected it for mapping or locking reasons. If we are doing
+	 * nonblocking user I/O, propagate the error.
+	 */
+	if (ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT)) {
+		ASSERT(flags & IOMAP_DIO_OVERWRITE_ONLY);
+		xfs_iunlock(ip, iolock);
+		goto retry_exclusive;
+	}
+
 out_unlock:
 	if (iolock)
 		xfs_iunlock(ip, iolock);
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 7b9ff824e82d48..ef76f775fabf11 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -784,15 +784,28 @@ xfs_direct_write_iomap_begin(
 		goto allocate_blocks;
 
 	/*
-	 * NOWAIT IO needs to span the entire requested IO with a single map so
-	 * that we avoid partial IO failures due to the rest of the IO range not
-	 * covered by this map triggering an EAGAIN condition when it is
-	 * subsequently mapped and aborting the IO.
+	 * NOWAIT and OVERWRITE I/O needs to span the entire requested I/O with
+	 * a single map so that we avoid partial IO failures due to the rest of
+	 * the I/O range not covered by this map triggering an EAGAIN condition
+	 * when it is subsequently mapped and aborting the I/O.
 	 */
-	if ((flags & IOMAP_NOWAIT) &&
-	    !imap_spans_range(&imap, offset_fsb, end_fsb)) {
+	if (flags & (IOMAP_NOWAIT | IOMAP_OVERWRITE_ONLY)) {
 		error = -EAGAIN;
-		goto out_unlock;
+		if (!imap_spans_range(&imap, offset_fsb, end_fsb))
+			goto out_unlock;
+	}
+
+	/*
+	 * For overwrite only I/O, we cannot convert unwritten extents without
+	 * requiring sub-block zeroing.  This can only be done under an
+	 * exclusive IOLOCK, hence return -EAGAIN if this is not a written
+	 * extent to tell the caller to try again.
+	 */
+	if (flags & IOMAP_OVERWRITE_ONLY) {
+		error = -EAGAIN;
+		if (imap.br_state != XFS_EXT_NORM &&
+	            ((offset | length) & mp->m_blockmask))
+			goto out_unlock;
 	}
 
 	xfs_iunlock(ip, lockmode);
@@ -801,7 +814,7 @@ xfs_direct_write_iomap_begin(
 
 allocate_blocks:
 	error = -EAGAIN;
-	if (flags & IOMAP_NOWAIT)
+	if (flags & (IOMAP_NOWAIT | IOMAP_OVERWRITE_ONLY))
 		goto out_unlock;
 
 	/*
-- 
2.29.2

