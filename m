Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDC8813AED7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 17:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgANQMr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 11:12:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43516 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729263AbgANQMo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:12:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=keR0X+WfeQcwktT8eyN6Jj1q2oCggZn3aD+r2MvaupY=; b=iGOc6nDbzK9T+olY+Y8Yr6GQC8
        ldbeOze0xj3z7wnqZYqyikHW/b1WntEa1URKv7wRibkxDWk3f+5Y4aErWvbEQbccNPSXMk/P0rvdb
        hyOkQHJquup/q3zDF9vRIENczJRJhy9fjQNnyQc2K4fXuZjMdarik9T3iwuoxVRXAoTKERUFQF1HU
        U51jzCHo6Z/Y9tgkwjKnACfGGcWLUqk4L6dNksek+3toV/4GS7jG3T2GDVLlICozak3sBQdk8d8jK
        MdCHCRCpochiSs/D4KQ/kuFOt1NqfkHimNFhXXl0kElJi7wvvJabgZVYlydkY15YfiXgOAuWdTiyV
        9U35iYRQ==;
Received: from [2001:4bb8:18c:4f54:fcbb:a92b:61e1:719] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irOo7-0000BN-MA; Tue, 14 Jan 2020 16:12:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 06/12] iomap: pass a flags value to iomap_dio_rw
Date:   Tue, 14 Jan 2020 17:12:19 +0100
Message-Id: <20200114161225.309792-7-hch@lst.de>
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

Replace the wait_for_completion flag in struct iomap_dio with a new
IOMAP_DIO_SYNCHRONOUS flag for dio->flags, and allow passing the
initial flags to iomap_dio_rw.  Also take the check for synchronous
iocbs into iomap_dio_rw instead of duplicating it in all the callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/file.c        |  8 +++++---
 fs/gfs2/file.c        |  6 ++----
 fs/iomap/direct-io.c  |  7 ++++---
 fs/xfs/xfs_file.c     | 21 +++++++++------------
 include/linux/iomap.h |  5 +++--
 5 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 6a7293a5cda2..08b603d0c638 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -74,8 +74,7 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		return generic_file_read_iter(iocb, to);
 	}
 
-	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL,
-			   is_sync_kiocb(iocb));
+	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL, 0);
 	inode_unlock_shared(inode);
 
 	file_accessed(iocb->ki_filp);
@@ -371,6 +370,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	handle_t *handle;
 	struct inode *inode = file_inode(iocb->ki_filp);
 	bool extend = false, overwrite = false, unaligned_aio = false;
+	unsigned int dio_flags = 0;
 
 	if (iocb->ki_flags & IOCB_NOWAIT) {
 		if (!inode_trylock(inode))
@@ -404,6 +404,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS) &&
 	    !is_sync_kiocb(iocb) && ext4_unaligned_aio(inode, from, offset)) {
 		unaligned_aio = true;
+		dio_flags |= IOMAP_DIO_SYNCHRONOUS;
 		inode_dio_wait(inode);
 	}
 
@@ -432,11 +433,12 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		}
 
 		extend = true;
+		dio_flags |= IOMAP_DIO_SYNCHRONOUS;
 		ext4_journal_stop(handle);
 	}
 
 	ret = iomap_dio_rw(iocb, from, &ext4_iomap_ops, &ext4_dio_write_ops,
-			   is_sync_kiocb(iocb) || unaligned_aio || extend);
+			   dio_flags);
 
 	if (extend)
 		ret = ext4_handle_inode_extension(inode, offset, ret, count);
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 86c0e61407b6..2260cb5d31af 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -771,8 +771,7 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to)
 	if (ret)
 		goto out_uninit;
 
-	ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL,
-			   is_sync_kiocb(iocb));
+	ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL, 0);
 
 	gfs2_glock_dq(&gh);
 out_uninit:
@@ -807,8 +806,7 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	if (offset + len > i_size_read(&ip->i_inode))
 		goto out;
 
-	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL,
-			   is_sync_kiocb(iocb));
+	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL, 0);
 
 out:
 	gfs2_glock_dq(&gh);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 23837926c0c5..e706329d71a0 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -400,7 +400,7 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
 ssize_t
 iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
-		bool wait_for_completion)
+		unsigned int dio_flags)
 {
 	struct address_space *mapping = iocb->ki_filp->f_mapping;
 	struct inode *inode = file_inode(iocb->ki_filp);
@@ -410,14 +410,15 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	unsigned int flags = IOMAP_DIRECT;
 	struct blk_plug plug;
 	struct iomap_dio *dio;
+	bool wait_for_completion = false;
 
 	lockdep_assert_held(&inode->i_rwsem);
 
 	if (!count)
 		return 0;
 
-	if (WARN_ON(is_sync_kiocb(iocb) && !wait_for_completion))
-		return -EIO;
+	if (is_sync_kiocb(iocb) || (dio_flags & IOMAP_DIO_SYNCHRONOUS))
+		wait_for_completion = true;
 
 	dio = kmalloc(sizeof(*dio), GFP_KERNEL);
 	if (!dio)
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index b8a4a3f29b36..0cc843a4a163 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -193,8 +193,7 @@ xfs_file_dio_aio_read(
 	} else {
 		xfs_ilock(ip, XFS_IOLOCK_SHARED);
 	}
-	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL,
-			is_sync_kiocb(iocb));
+	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL, 0);
 	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
 
 	return ret;
@@ -493,6 +492,7 @@ xfs_file_dio_aio_write(
 	int			iolock;
 	size_t			count = iov_iter_count(from);
 	struct xfs_buftarg      *target = xfs_inode_buftarg(ip);
+	unsigned int		dio_flags = 0;
 
 	/* DIO must be aligned to device logical sector size */
 	if ((iocb->ki_pos | count) & target->bt_logical_sectormask)
@@ -538,27 +538,24 @@ xfs_file_dio_aio_write(
 	count = iov_iter_count(from);
 
 	/*
-	 * If we are doing unaligned IO, we can't allow any other overlapping IO
-	 * in-flight at the same time or we risk data corruption. Wait for all
-	 * other IO to drain before we submit. If the IO is aligned, demote the
-	 * iolock if we had to take the exclusive lock in
+	 * If we are doing unaligned I/O, we can't allow any other overlapping
+	 * I/O in-flight at the same time or we risk data corruption.  Wait for
+	 * all other I/O to drain before we submit and execute the I/O
+	 * synchronously to prevent subsequent overlapping I/O.  If the I/O is
+	 * aligned, demote the iolock if we had to take the exclusive lock in
 	 * xfs_file_aio_write_checks() for other reasons.
 	 */
 	if (unaligned_io) {
 		inode_dio_wait(inode);
+		dio_flags = IOMAP_DIO_SYNCHRONOUS;
 	} else if (iolock == XFS_IOLOCK_EXCL) {
 		xfs_ilock_demote(ip, XFS_IOLOCK_EXCL);
 		iolock = XFS_IOLOCK_SHARED;
 	}
 
 	trace_xfs_file_direct_write(ip, count, iocb->ki_pos);
-	/*
-	 * If unaligned, this is the only IO in-flight. Wait on it before we
-	 * release the iolock to prevent subsequent overlapping IO.
-	 */
 	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
-			   &xfs_dio_write_ops,
-			   is_sync_kiocb(iocb) || unaligned_io);
+			   &xfs_dio_write_ops, dio_flags);
 out:
 	xfs_iunlock(ip, iolock);
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8b09463dae0d..3faeb8fd0961 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -244,10 +244,11 @@ int iomap_writepages(struct address_space *mapping,
 		const struct iomap_writeback_ops *ops);
 
 /*
- * Flags for direct I/O ->end_io:
+ * Flags for iomap_dio_complete and ->end_io:
  */
 #define IOMAP_DIO_UNWRITTEN	(1 << 0)	/* covers unwritten extent(s) */
 #define IOMAP_DIO_COW		(1 << 1)	/* covers COW extent(s) */
+#define IOMAP_DIO_SYNCHRONOUS	(1 << 2)	/* no async completion */
 
 struct iomap_dio_ops {
 	int (*end_io)(struct kiocb *iocb, ssize_t size, int error,
@@ -256,7 +257,7 @@ struct iomap_dio_ops {
 
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
-		bool wait_for_completion);
+		unsigned int dio_flags);
 int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
 
 #ifdef CONFIG_SWAP
-- 
2.24.1

