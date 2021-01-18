Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2EEC2FAAD9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 21:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437741AbhARUDU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 15:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437882AbhARUCP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 15:02:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C995C061574;
        Mon, 18 Jan 2021 12:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=p0cORD1RPUmhWWSnG/FGqT6kyVoIKDSSa6QISQ0aNrM=; b=Ys0fCfHxyQmA+vM8whfvU68fmm
        70PdG28B6/0ZXaBcRT7UKK1NdmZa9Ki0V145psoNHR7gC7ZZFpa/XGwaGwYiITabntStgn25F/vpp
        rdT1fh13vgGzLrsQM6wg8Cm2QeJtg3ROAKslkKeWUDQBDdnXVw92/LmOGq8+i7VuvtG+jiRWJlSpb
        ytRdF0/3J8ftJZ8CdTLkPGIyok46EygTshorc+a7easqc4UtVvpW/tiyv4o4c4R5CaNo/LLE1p/0n
        lZe6QV+AH0b1aww2ezoQ9kyNu1b6h/CwKR6q+2qcGYlgrJrd+wNhwpd/k4nY1sDATInBBCRPHwSxT
        RXDWR4ag==;
Received: from [2001:4bb8:188:1954:cede:2e6d:2fd9:db4d] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l1aiO-00DKer-ED; Mon, 18 Jan 2021 20:01:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, avi@scylladb.com,
        Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 11/11] xfs: reduce exclusive locking on unaligned dio
Date:   Mon, 18 Jan 2021 20:35:16 +0100
Message-Id: <20210118193516.2915706-12-hch@lst.de>
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
---
 fs/xfs/xfs_file.c  | 87 ++++++++++++++++++++++++++++++++--------------
 fs/xfs/xfs_iomap.c | 31 ++++++++++++-----
 2 files changed, 84 insertions(+), 34 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index b181db42f2f32f..4e475e750148db 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -544,22 +544,35 @@ xfs_file_dio_write_aligned(
 /*
  * Handle block unaligned direct IO writes
  *
- * In most cases direct IO writes will be done holding IOLOCK_SHARED, allowing
- * them to be done in parallel with reads and other direct IO writes.  However,
- * if the I/O is not aligned to filesystem blocks, the direct I/O layer may
- * need to do sub-block zeroing and that requires serialisation against other
- * direct I/Os to the same block. In this case we need to serialise the
- * submission of the unaligned I/Os so that we don't get racing block zeroing in
- * the dio layer.
+ * In most cases direct IO writes will be done holding IOLOCK_SHARED
+ * allowing them to be done in parallel with reads and other direct IO writes.
+ * However, if the IO is not aligned to filesystem blocks, the direct IO layer
+ * may need to do sub-block zeroing and that requires serialisation against other
+ * direct IOs to the same block. In the case where sub-block zeroing is not
+ * required, we can do concurrent sub-block dios to the same block successfully.
  *
- * To provide the same serialisation for AIO, we also need to wait for
+ * Hence we have two cases here - the shared, optimisitic fast path for written
+ * extents, and everything else that needs exclusive IO path access across the
+ * entire IO.
+ *
+ * For the first case, we do all the checks we need at the mapping layer in the
+ * DIO code as part of the existing NOWAIT infrastructure. Hence all we need to
+ * do to support concurrent subblock dio is first try a non-blocking submission.
+ * If that returns -EAGAIN, then we simply repeat the IO submission with full
+ * IO exclusivity guaranteed so that we avoid racing sub-block zeroing.
+ *
+ * The only wrinkle in this case is that the iomap DIO code always does
+ * partial tail sub-block zeroing for post-EOF writes. Hence for any IO that
+ * _ends_ past the current EOF we need to run with full exclusivity. Note that
+ * we also check for the start of IO being beyond EOF because then zeroing
+ * between the old EOF and the start of the IO is required and that also
+ * requires exclusivity. Hence we avoid lock cycles and blocking under
+ * IOCB_NOWAIT for this situation, too.
+ *
+ * To provide the exclusivity required when using AIO, we also need to wait for
  * outstanding IOs to complete so that unwritten extent conversion is completed
  * before we try to map the overlapping block. This is currently implemented by
  * hitting it with a big hammer (i.e. inode_dio_wait()).
- *
- * This means that unaligned dio writes always block. There is no "nowait" fast
- * path in this code - if IOCB_NOWAIT is set we simply return -EAGAIN up front
- * and we don't have to worry about that anymore.
  */
 static noinline ssize_t
 xfs_file_dio_write_unaligned(
@@ -567,13 +580,27 @@ xfs_file_dio_write_unaligned(
 	struct kiocb		*iocb,
 	struct iov_iter		*from)
 {
-	int			iolock = XFS_IOLOCK_EXCL;
+	size_t			isize = i_size_read(VFS_I(ip));
+	size_t			count = iov_iter_count(from);
+	int			iolock = XFS_IOLOCK_SHARED;
+	unsigned int		flags = IOMAP_DIO_UNALIGNED;
 	ssize_t			ret;
 
-	/* unaligned dio always waits, bail */
-	if (iocb->ki_flags & IOCB_NOWAIT)
-		return -EAGAIN;
-	xfs_ilock(ip, iolock);
+	/*
+	 * Extending writes need exclusivity because of the sub-block zeroing
+	 * that the DIO code always does for partial tail blocks beyond EOF.
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
@@ -590,19 +617,27 @@ xfs_file_dio_write_unaligned(
 		goto out_unlock;
 
 	/*
-	 * If we are doing unaligned I/O, we can't allow any other overlapping
-	 * I/O in-flight at the same time or we risk data corruption. Wait for
-	 * all other I/O to drain before we submit.
+	 * If we are doing exclusive unaligned IO, we can't allow any other
+	 * overlapping IO in-flight at the same time or we risk data corruption.
+	 * Wait for all other IO to drain before we submit.
 	 */
-	inode_dio_wait(VFS_I(ip));
+	if (!(flags & IOMAP_DIO_UNALIGNED))
+		inode_dio_wait(VFS_I(ip));
 
-	/*
-	 * This must be the only I/O in-flight. Wait on it before we release the
-	 * iolock to prevent subsequent overlapping I/O.
-	 */
 	trace_xfs_file_direct_write(iocb, from);
 	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
-			   &xfs_dio_write_ops, IOMAP_DIO_FORCE_WAIT);
+			   &xfs_dio_write_ops, flags);
+	/*
+	 * Retry unaligned IO with exclusive blocking semantics if the DIO
+	 * layer rejected it for mapping or locking reasons. If we are doing
+	 * nonblocking user IO, propagate the error.
+	 */
+	if (ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT)) {
+		ASSERT(flags & IOMAP_DIO_UNALIGNED);
+		xfs_iunlock(ip, iolock);
+		goto retry_exclusive;
+	}
+
 out_unlock:
 	if (iolock)
 		xfs_iunlock(ip, iolock);
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 7b9ff824e82d48..dc8c86e98b99bf 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -784,15 +784,30 @@ xfs_direct_write_iomap_begin(
 		goto allocate_blocks;
 
 	/*
-	 * NOWAIT IO needs to span the entire requested IO with a single map so
-	 * that we avoid partial IO failures due to the rest of the IO range not
-	 * covered by this map triggering an EAGAIN condition when it is
-	 * subsequently mapped and aborting the IO.
+	 * NOWAIT and unaligned IO needs to span the entire requested IO with a
+	 * single map so that we avoid partial IO failures due to the rest of
+	 * the IO range not covered by this map triggering an EAGAIN condition
+	 * when it is subsequently mapped and aborting the IO.
 	 */
-	if ((flags & IOMAP_NOWAIT) &&
-	    !imap_spans_range(&imap, offset_fsb, end_fsb)) {
+	if (flags & (IOMAP_NOWAIT | IOMAP_UNALIGNED)) {
 		error = -EAGAIN;
-		goto out_unlock;
+		if (!imap_spans_range(&imap, offset_fsb, end_fsb))
+			goto out_unlock;
+	}
+
+	/*
+	 * For unsigned I/O we can't convert an unwritten extents if the I/O is
+	 * not block size aligned, as such a conversion would have to do
+	 * sub-block zeroing, and that can only be done under an exclusive
+	 * IOLOCK. Hence if this is not a written extent, return EAGAIN to tell
+	 * the caller to try again.
+	 */
+	if (flags & IOMAP_UNALIGNED) {
+		error = -EAGAIN;
+		if (imap.br_state != XFS_EXT_NORM &&
+		    ((offset & mp->m_blockmask) ||
+		     ((offset + length) & mp->m_blockmask)))
+			goto out_unlock;
 	}
 
 	xfs_iunlock(ip, lockmode);
@@ -801,7 +816,7 @@ xfs_direct_write_iomap_begin(
 
 allocate_blocks:
 	error = -EAGAIN;
-	if (flags & IOMAP_NOWAIT)
+	if (flags & (IOMAP_NOWAIT | IOMAP_UNALIGNED))
 		goto out_unlock;
 
 	/*
-- 
2.29.2

