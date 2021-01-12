Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251A62F2541
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 02:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbhALBIh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 20:08:37 -0500
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:42418 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731358AbhALBIh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 20:08:37 -0500
Received: from dread.disaster.area (pa49-179-167-107.pa.nsw.optusnet.com.au [49.179.167.107])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 7EAA3824D07;
        Tue, 12 Jan 2021 12:07:52 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kz8A1-005WbK-Ky; Tue, 12 Jan 2021 12:07:49 +1100
Received: from dave by discord.disaster.area with local (Exim 4.94)
        (envelope-from <david@fromorbit.com>)
        id 1kz8A1-004qbB-Cn; Tue, 12 Jan 2021 12:07:49 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, avi@scylladb.com, andres@anarazel.de
Subject: [PATCH 6/6] xfs: reduce exclusive locking on unaligned dio
Date:   Tue, 12 Jan 2021 12:07:46 +1100
Message-Id: <20210112010746.1154363-7-david@fromorbit.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210112010746.1154363-1-david@fromorbit.com>
References: <20210112010746.1154363-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=+wqVUQIkAh0lLYI+QRsciw==:117 a=+wqVUQIkAh0lLYI+QRsciw==:17
        a=EmqxpYm9HcoA:10 a=20KFwNOVAAAA:8 a=kV-h00eVNQN3drKQWOoA:9
        a=DiKeHqHhRZ4A:10
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
---
 fs/xfs/xfs_file.c  | 94 +++++++++++++++++++++++++++++++---------------
 fs/xfs/xfs_iomap.c | 32 +++++++++++-----
 2 files changed, 86 insertions(+), 40 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index bba33be17eff..f5c75404b8a5 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -408,7 +408,7 @@ xfs_file_aio_write_checks(
 			drained_dio = true;
 			goto restart;
 		}
-	
+
 		trace_xfs_zero_eof(ip, isize, iocb->ki_pos - isize);
 		error = iomap_zero_range(inode, isize, iocb->ki_pos - isize,
 				NULL, &xfs_buffered_write_iomap_ops);
@@ -510,9 +510,9 @@ static const struct iomap_dio_ops xfs_dio_write_ops = {
 /*
  * Handle block aligned direct IO writes
  *
- * Lock the inode appropriately to prepare for and issue a direct IO write.
- * By separating it from the buffered write path we remove all the tricky to
- * follow locking changes and looping.
+ * Lock the inode appropriately to prepare for and issue a direct IO write.  By
+ * separating it from the buffered write path we remove all the tricky to follow
+ * locking changes and looping.
  *
  * If there are cached pages or we're extending the file, we need IOLOCK_EXCL
  * until we're sure the bytes at the new EOF have been zeroed and/or the cached
@@ -578,18 +578,31 @@ xfs_file_dio_write_aligned(
  * allowing them to be done in parallel with reads and other direct IO writes.
  * However, if the IO is not aligned to filesystem blocks, the direct IO layer
  * may need to do sub-block zeroing and that requires serialisation against other
- * direct IOs to the same block. In this case we need to serialise the
- * submission of the unaligned IOs so that we don't get racing block zeroing in
- * the dio layer.
+ * direct IOs to the same block. In the case where sub-block zeroing is not
+ * required, we can do concurrent sub-block dios to the same block successfully.
+ *
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
  *
- * To provide the same serialisation for AIO, we also need to wait for
+ * To provide the exclusivity required when using AIO, we also need to wait for
  * outstanding IOs to complete so that unwritten extent conversion is completed
  * before we try to map the overlapping block. This is currently implemented by
  * hitting it with a big hammer (i.e. inode_dio_wait()).
- *
- * This means that unaligned dio writes alwys block. There is no "nowait" fast
- * path in this code - if IOCB_NOWAIT is set we simply return -EAGAIN up front
- * and we don't have to worry about that anymore.
  */
 static ssize_t
 xfs_file_dio_write_unaligned(
@@ -597,23 +610,35 @@ xfs_file_dio_write_unaligned(
 	struct kiocb		*iocb,
 	struct iov_iter		*from)
 {
-	int			iolock = XFS_IOLOCK_EXCL;
+	int			iolock = XFS_IOLOCK_SHARED;
 	size_t			count;
 	ssize_t			ret;
+	size_t			isize = i_size_read(VFS_I(ip));
 	struct iomap_dio_rw_args args = {
 		.iocb			= iocb,
 		.iter			= from,
 		.ops			= &xfs_direct_write_iomap_ops,
 		.dops			= &xfs_dio_write_ops,
 		.wait_for_completion	= is_sync_kiocb(iocb),
-		.nonblocking		= (iocb->ki_flags & IOCB_NOWAIT),
+		.nonblocking		= true,
 	};
 
 	/*
-	 * This must be the only IO in-flight. Wait on it before we
-	 * release the iolock to prevent subsequent overlapping IO.
+	 * Extending writes need exclusivity because of the sub-block zeroing
+	 * that the DIO code always does for partial tail blocks beyond EOF.
 	 */
-	args.wait_for_completion = true;
+	if (iocb->ki_pos > isize || iocb->ki_pos + count >= isize) {
+retry_exclusive:
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			return -EAGAIN;
+		iolock = XFS_IOLOCK_EXCL;
+		args.nonblocking = false;
+		args.wait_for_completion = true;
+	}
+
+	ret = xfs_ilock_iocb(iocb, iolock);
+	if (ret)
+		return ret;
 
 	/*
 	 * We can't properly handle unaligned direct I/O to reflink
@@ -621,30 +646,37 @@ xfs_file_dio_write_unaligned(
 	 */
 	if (xfs_is_cow_inode(ip)) {
 		trace_xfs_reflink_bounce_dio_write(ip, iocb->ki_pos, count);
-		return -ENOTBLK;
+		ret = -ENOTBLK;
+		goto out_unlock;
 	}
 
-	/* unaligned dio always waits, bail */
-	if (iocb->ki_flags & IOCB_NOWAIT)
-		return -EAGAIN;
-	xfs_ilock(ip, iolock);
-
 	ret = xfs_file_aio_write_checks(iocb, from, &iolock);
 	if (ret)
-		goto out;
+		goto out_unlock;
 	count = iov_iter_count(from);
 
 	/*
-	 * If we are doing unaligned IO, we can't allow any other overlapping IO
-	 * in-flight at the same time or we risk data corruption. Wait for all
-	 * other IO to drain before we submit. If the IO is aligned, demote the
-	 * iolock if we had to take the exclusive lock in
-	 * xfs_file_aio_write_checks() for other reasons.
+	 * If we are doing exclusive unaligned IO, we can't allow any other
+	 * overlapping IO in-flight at the same time or we risk data corruption.
+	 * Wait for all other IO to drain before we submit.
 	 */
-	inode_dio_wait(VFS_I(ip));
+	if (!args.nonblocking)
+		inode_dio_wait(VFS_I(ip));
 	trace_xfs_file_direct_write(ip, count, iocb->ki_pos);
 	ret = iomap_dio_rw(&args);
-out:
+
+	/*
+	 * Retry unaligned IO with exclusive blocking semantics if the DIO
+	 * layer rejected it for mapping or locking reasons. If we are doing
+	 * nonblocking user IO, propagate the error.
+	 */
+	if (ret == -EAGAIN) {
+		ASSERT(args.nonblocking == true);
+		xfs_iunlock(ip, iolock);
+		goto retry_exclusive;
+	}
+
+out_unlock:
 	if (iolock)
 		xfs_iunlock(ip, iolock);
 
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 7b9ff824e82d..e5659200e5e8 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -783,16 +783,30 @@ xfs_direct_write_iomap_begin(
 	if (imap_needs_alloc(inode, flags, &imap, nimaps))
 		goto allocate_blocks;
 
-	/*
-	 * NOWAIT IO needs to span the entire requested IO with a single map so
-	 * that we avoid partial IO failures due to the rest of the IO range not
-	 * covered by this map triggering an EAGAIN condition when it is
-	 * subsequently mapped and aborting the IO.
-	 */
-	if ((flags & IOMAP_NOWAIT) &&
-	    !imap_spans_range(&imap, offset_fsb, end_fsb)) {
+	/* Handle special NOWAIT conditions for existing allocated extents. */
+	if (flags & IOMAP_NOWAIT) {
 		error = -EAGAIN;
-		goto out_unlock;
+		/*
+		 * NOWAIT IO needs to span the entire requested IO with a single
+		 * map so that we avoid partial IO failures due to the rest of
+		 * the IO range not covered by this map triggering an EAGAIN
+		 * condition when it is subsequently mapped and aborting the IO.
+		 */
+		if (!imap_spans_range(&imap, offset_fsb, end_fsb))
+			goto out_unlock;
+
+		/*
+		 * If the IO is unaligned and the caller holds a shared IOLOCK,
+		 * NOWAIT will be set because we can only do the IO if it spans
+		 * a written extent. Otherwise we have to do sub-block zeroing,
+		 * and that can only be done under an exclusive IOLOCK. Hence if
+		 * this is not a written extent, return EAGAIN to tell the
+		 * caller to try again.
+		 */
+		if (imap.br_state != XFS_EXT_NORM &&
+		    ((offset & mp->m_blockmask) ||
+		     ((offset + length) & mp->m_blockmask)))
+			goto out_unlock;
 	}
 
 	xfs_iunlock(ip, lockmode);
-- 
2.28.0

