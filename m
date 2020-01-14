Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D61F313AEC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 17:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgANQM4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 11:12:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43670 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbgANQMz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:12:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4Hexr2/FIsZz1f1S0iN0yG1Q7M/61ZediDTapXBtYP8=; b=ZKbbV85l+TR0/8EQoI6oK7HMR+
        L/ai9aEQ+wkkVnz+mMSjdF1R+fg/w7+4CTKvQpQgDarOYB1MK63tY0vW+MlRFVAuoLWnQ8aQ7jWJD
        4JesyRb3zYBTonvFcxVoMXA8CzIQa62hP9zFTQBaKJQt3gwCJYM6vjXKK2bD77kIspkFYRowTsJ0m
        pjT/twezcuXLpVRtlDpq5s7aph1jeYdoQwPNFbOHup/a/DOyV/htDWG5QbTxrNeSDYedphQ+97Lo/
        nPBO8jOkNXxdTSzw+yW7al2k2hrlZliDhwcFfAqp11Z97xlb2mWLOGw7cqIwMP7oxuVX86Xe8+4R7
        uAsY6AnQ==;
Received: from [2001:4bb8:18c:4f54:fcbb:a92b:61e1:719] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irOoI-0000Er-Ej; Tue, 14 Jan 2020 16:12:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 10/12] xfs: hold i_rwsem until AIO completes
Date:   Tue, 14 Jan 2020 17:12:23 +0100
Message-Id: <20200114161225.309792-11-hch@lst.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114161225.309792-1-hch@lst.de>
References: <20200114161225.309792-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch ext4 from the magic i_dio_count scheme to just hold i_rwsem
until the actual I/O has completed to reduce the locking complexity
and avoid nasty bugs due to missing inode_dio_wait calls.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/scrub/bmap.c    |  1 -
 fs/xfs/xfs_bmap_util.c |  3 ---
 fs/xfs/xfs_file.c      | 47 +++++++++++++-----------------------------
 fs/xfs/xfs_icache.c    |  3 +--
 fs/xfs/xfs_ioctl.c     |  1 -
 fs/xfs/xfs_iops.c      |  5 -----
 fs/xfs/xfs_reflink.c   |  2 --
 7 files changed, 15 insertions(+), 47 deletions(-)

diff --git a/fs/xfs/scrub/bmap.c b/fs/xfs/scrub/bmap.c
index fa6ea6407992..d3e4068d3189 100644
--- a/fs/xfs/scrub/bmap.c
+++ b/fs/xfs/scrub/bmap.c
@@ -45,7 +45,6 @@ xchk_setup_inode_bmap(
 	 */
 	if (S_ISREG(VFS_I(sc->ip)->i_mode) &&
 	    sc->sm->sm_type == XFS_SCRUB_TYPE_BMBTD) {
-		inode_dio_wait(VFS_I(sc->ip));
 		error = filemap_write_and_wait(VFS_I(sc->ip)->i_mapping);
 		if (error)
 			goto out;
diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index e62fb5216341..a454f481107e 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -674,9 +674,6 @@ xfs_free_eofblocks(
 		if (error)
 			return error;
 
-		/* wait on dio to ensure i_size has settled */
-		inode_dio_wait(VFS_I(ip));
-
 		error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0,
 				&tp);
 		if (error) {
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 0cc843a4a163..d0ee7d2932e4 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -193,9 +193,11 @@ xfs_file_dio_aio_read(
 	} else {
 		xfs_ilock(ip, XFS_IOLOCK_SHARED);
 	}
-	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL, 0);
-	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
 
+	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL,
+			   IOMAP_DIO_RWSEM_SHARED);
+	if (ret != -EIOCBQUEUED)
+		xfs_iunlock(ip, XFS_IOLOCK_SHARED);
 	return ret;
 }
 
@@ -341,15 +343,6 @@ xfs_file_aio_write_checks(
 				xfs_ilock(ip, *iolock);
 				iov_iter_reexpand(from, count);
 			}
-			/*
-			 * We now have an IO submission barrier in place, but
-			 * AIO can do EOF updates during IO completion and hence
-			 * we now need to wait for all of them to drain. Non-AIO
-			 * DIO will have drained before we are given the
-			 * XFS_IOLOCK_EXCL, and so for most cases this wait is a
-			 * no-op.
-			 */
-			inode_dio_wait(inode);
 			drained_dio = true;
 			goto restart;
 		}
@@ -469,13 +462,7 @@ static const struct iomap_dio_ops xfs_dio_write_ops = {
  * needs to do sub-block zeroing and that requires serialisation against other
  * direct IOs to the same block. In this case we need to serialise the
  * submission of the unaligned IOs so that we don't get racing block zeroing in
- * the dio layer.  To avoid the problem with aio, we also need to wait for
- * outstanding IOs to complete so that unwritten extent conversion is completed
- * before we try to map the overlapping block. This is currently implemented by
- * hitting it with a big hammer (i.e. inode_dio_wait()).
- *
- * Returns with locks held indicated by @iolock and errors indicated by
- * negative return values.
+ * the dio layer.
  */
 STATIC ssize_t
 xfs_file_dio_aio_write(
@@ -546,18 +533,21 @@ xfs_file_dio_aio_write(
 	 * xfs_file_aio_write_checks() for other reasons.
 	 */
 	if (unaligned_io) {
-		inode_dio_wait(inode);
-		dio_flags = IOMAP_DIO_SYNCHRONOUS;
-	} else if (iolock == XFS_IOLOCK_EXCL) {
-		xfs_ilock_demote(ip, XFS_IOLOCK_EXCL);
-		iolock = XFS_IOLOCK_SHARED;
+		dio_flags = IOMAP_DIO_RWSEM_EXCL | IOMAP_DIO_SYNCHRONOUS;
+	} else {
+		if (iolock == XFS_IOLOCK_EXCL) {
+			xfs_ilock_demote(ip, XFS_IOLOCK_EXCL);
+			iolock = XFS_IOLOCK_SHARED;
+		}
+		dio_flags = IOMAP_DIO_RWSEM_SHARED;
 	}
 
 	trace_xfs_file_direct_write(ip, count, iocb->ki_pos);
 	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
 			   &xfs_dio_write_ops, dio_flags);
 out:
-	xfs_iunlock(ip, iolock);
+	if (ret != -EIOCBQUEUED)
+		xfs_iunlock(ip, iolock);
 
 	/*
 	 * No fallback to buffered IO on errors for XFS, direct IO will either
@@ -819,15 +809,6 @@ xfs_file_fallocate(
 	if (error)
 		goto out_unlock;
 
-	/*
-	 * Must wait for all AIO to complete before we continue as AIO can
-	 * change the file size on completion without holding any locks we
-	 * currently hold. We must do this first because AIO can update both
-	 * the on disk and in memory inode sizes, and the operations that follow
-	 * require the in-memory size to be fully up-to-date.
-	 */
-	inode_dio_wait(inode);
-
 	/*
 	 * Now AIO and DIO has drained we flush and (if necessary) invalidate
 	 * the cached range over the first operation we are about to run.
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 8dc2e5414276..9e6f32fd32f5 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -1720,8 +1720,7 @@ xfs_prep_free_cowblocks(
 	 */
 	if ((VFS_I(ip)->i_state & I_DIRTY_PAGES) ||
 	    mapping_tagged(VFS_I(ip)->i_mapping, PAGECACHE_TAG_DIRTY) ||
-	    mapping_tagged(VFS_I(ip)->i_mapping, PAGECACHE_TAG_WRITEBACK) ||
-	    atomic_read(&VFS_I(ip)->i_dio_count))
+	    mapping_tagged(VFS_I(ip)->i_mapping, PAGECACHE_TAG_WRITEBACK))
 		return false;
 
 	return true;
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 7b35d62ede9f..331453f2c4be 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -548,7 +548,6 @@ xfs_ioc_space(
 	error = xfs_break_layouts(inode, &iolock, BREAK_UNMAP);
 	if (error)
 		goto out_unlock;
-	inode_dio_wait(inode);
 
 	switch (bf->l_whence) {
 	case 0: /*SEEK_SET*/
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 8afe69ca188b..700edeccc6bf 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -893,11 +893,6 @@ xfs_setattr_size(
 	if (error)
 		return error;
 
-	/*
-	 * Wait for all direct I/O to complete.
-	 */
-	inode_dio_wait(inode);
-
 	/*
 	 * File data changes must be complete before we start the transaction to
 	 * modify the inode.  This needs to be done before joining the inode to
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index de451235c4ee..f775e60ca6f7 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1525,8 +1525,6 @@ xfs_reflink_unshare(
 
 	trace_xfs_reflink_unshare(ip, offset, len);
 
-	inode_dio_wait(inode);
-
 	error = iomap_file_unshare(inode, offset, len,
 			&xfs_buffered_write_iomap_ops);
 	if (error)
-- 
2.24.1

