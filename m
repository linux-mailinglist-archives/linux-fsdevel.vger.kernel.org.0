Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D68219256
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 23:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgGHVTt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 17:19:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:35398 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgGHVTs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 17:19:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D3DF6AD33;
        Wed,  8 Jul 2020 21:19:46 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, hch@lst.de,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 1/6] iomap: Convert wait_for_completion to flags
Date:   Wed,  8 Jul 2020 16:19:21 -0500
Message-Id: <20200708211926.7706-2-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200708211926.7706-1-rgoldwyn@suse.de>
References: <20200708211926.7706-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Convert wait_for_completion boolean to flags so we can pass more flags
to iomap_dio_rw()

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/ext4/file.c        | 11 +++++++++--
 fs/gfs2/file.c        | 14 ++++++++++----
 fs/iomap/direct-io.c  |  3 ++-
 fs/xfs/xfs_file.c     | 15 +++++++++++----
 fs/zonefs/super.c     | 16 ++++++++++++----
 include/linux/iomap.h | 11 ++++++++++-
 6 files changed, 54 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 2a01e31a032c..8f6324eb6b27 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -53,6 +53,7 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	ssize_t ret;
 	struct inode *inode = file_inode(iocb->ki_filp);
+	unsigned int flags = 0;
 
 	if (iocb->ki_flags & IOCB_NOWAIT) {
 		if (!inode_trylock_shared(inode))
@@ -74,8 +75,11 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		return generic_file_read_iter(iocb, to);
 	}
 
+	if (is_sync_kiocb(iocb))
+		flags |= IOMAP_DIO_RWF_SYNCIO;
+
 	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL,
-			   is_sync_kiocb(iocb));
+			   flags);
 	inode_unlock_shared(inode);
 
 	file_accessed(iocb->ki_filp);
@@ -457,6 +461,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	const struct iomap_ops *iomap_ops = &ext4_iomap_ops;
 	bool extend = false, unaligned_io = false;
 	bool ilock_shared = true;
+	unsigned int flags = 0;
 
 	/*
 	 * We initially start with shared inode lock unless it is
@@ -540,10 +545,12 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		ext4_journal_stop(handle);
 	}
 
+	if (is_sync_kiocb(iocb) || unaligned_io || extend)
+		flags |= IOMAP_DIO_RWF_SYNCIO;
 	if (ilock_shared)
 		iomap_ops = &ext4_iomap_overwrite_ops;
 	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
-			   is_sync_kiocb(iocb) || unaligned_io || extend);
+			   flags);
 
 	if (extend)
 		ret = ext4_handle_inode_extension(inode, offset, ret, count);
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index fe305e4bfd37..68f4ee4a20ee 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -767,6 +767,7 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to)
 	size_t count = iov_iter_count(to);
 	struct gfs2_holder gh;
 	ssize_t ret;
+	unsigned int flags = 0;
 
 	if (!count)
 		return 0; /* skip atime */
@@ -776,8 +777,10 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to)
 	if (ret)
 		goto out_uninit;
 
-	ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL,
-			   is_sync_kiocb(iocb));
+	if (is_sync_kiocb(iocb))
+		flags |= IOMAP_DIO_RWF_SYNCIO;
+
+	ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL, flags);
 
 	gfs2_glock_dq(&gh);
 out_uninit:
@@ -794,6 +797,7 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	loff_t offset = iocb->ki_pos;
 	struct gfs2_holder gh;
 	ssize_t ret;
+	unsigned int flags = 0;
 
 	/*
 	 * Deferred lock, even if its a write, since we do no allocation on
@@ -812,8 +816,10 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	if (offset + len > i_size_read(&ip->i_inode))
 		goto out;
 
-	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL,
-			   is_sync_kiocb(iocb));
+	if (is_sync_kiocb(iocb))
+		flags |= IOMAP_DIO_RWF_SYNCIO;
+
+	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL, flags);
 
 out:
 	gfs2_glock_dq(&gh);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index ec7b78e6feca..2753b7022403 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -405,7 +405,7 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
 ssize_t
 iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
-		bool wait_for_completion)
+		unsigned int dio_flags)
 {
 	struct address_space *mapping = iocb->ki_filp->f_mapping;
 	struct inode *inode = file_inode(iocb->ki_filp);
@@ -415,6 +415,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	unsigned int flags = IOMAP_DIRECT;
 	struct blk_plug plug;
 	struct iomap_dio *dio;
+	bool wait_for_completion = dio_flags & IOMAP_DIO_RWF_SYNCIO;
 
 	if (!count)
 		return 0;
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 00db81eac80d..6a7edb2c3167 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -169,6 +169,8 @@ xfs_file_dio_aio_read(
 	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
 	size_t			count = iov_iter_count(to);
 	ssize_t			ret;
+	unsigned int		flags = 0;
+
 
 	trace_xfs_file_direct_read(ip, count, iocb->ki_pos);
 
@@ -183,8 +185,11 @@ xfs_file_dio_aio_read(
 	} else {
 		xfs_ilock(ip, XFS_IOLOCK_SHARED);
 	}
-	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL,
-			is_sync_kiocb(iocb));
+
+	if (is_sync_kiocb(iocb))
+		flags |= IOMAP_DIO_RWF_SYNCIO;
+
+	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL,	flags);
 	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
 
 	return ret;
@@ -483,6 +488,7 @@ xfs_file_dio_aio_write(
 	int			iolock;
 	size_t			count = iov_iter_count(from);
 	struct xfs_buftarg      *target = xfs_inode_buftarg(ip);
+	unsigned int		flags = 0;
 
 	/* DIO must be aligned to device logical sector size */
 	if ((iocb->ki_pos | count) & target->bt_logical_sectormask)
@@ -546,9 +552,10 @@ xfs_file_dio_aio_write(
 	 * If unaligned, this is the only IO in-flight. Wait on it before we
 	 * release the iolock to prevent subsequent overlapping IO.
 	 */
+	if (is_sync_kiocb(iocb) || unaligned_io)
+		flags |= IOMAP_DIO_RWF_SYNCIO;
 	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
-			   &xfs_dio_write_ops,
-			   is_sync_kiocb(iocb) || unaligned_io);
+			   &xfs_dio_write_ops, flags);
 out:
 	xfs_iunlock(ip, iolock);
 
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 07bc42d62673..798e2e636887 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -670,6 +670,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 	bool append = false;
 	size_t count;
 	ssize_t ret;
+	int flags = 0;
 
 	/*
 	 * For async direct IOs to sequential zone files, refuse IOCB_NOWAIT
@@ -711,11 +712,15 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 		append = sync;
 	}
 
-	if (append)
+	if (append) {
 		ret = zonefs_file_dio_append(iocb, from);
-	else
+	} else {
+		if (is_sync_kiocb(iocb))
+			flags |= IOMAP_DIO_RWF_SYNCIO;
+
 		ret = iomap_dio_rw(iocb, from, &zonefs_iomap_ops,
-				   &zonefs_write_dio_ops, sync);
+				&zonefs_write_dio_ops, flags);
+	}
 	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ &&
 	    (ret > 0 || ret == -EIOCBQUEUED)) {
 		if (ret > 0)
@@ -814,6 +819,7 @@ static ssize_t zonefs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct super_block *sb = inode->i_sb;
 	loff_t isize;
 	ssize_t ret;
+	int flags = 0;
 
 	/* Offline zones cannot be read */
 	if (unlikely(IS_IMMUTABLE(inode) && !(inode->i_mode & 0777)))
@@ -848,8 +854,10 @@ static ssize_t zonefs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			goto inode_unlock;
 		}
 		file_accessed(iocb->ki_filp);
+		if (is_sync_kiocb(iocb))
+			flags |= IOMAP_DIO_RWF_SYNCIO;
 		ret = iomap_dio_rw(iocb, to, &zonefs_iomap_ops,
-				   &zonefs_read_dio_ops, is_sync_kiocb(iocb));
+				   &zonefs_read_dio_ops, flags);
 	} else {
 		ret = generic_file_read_iter(iocb, to);
 		if (ret == -EIO)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 4d1d3c3469e9..80cd5f524124 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -255,9 +255,18 @@ struct iomap_dio_ops {
 			struct bio *bio, loff_t file_offset);
 };
 
+/*
+ * Flags to pass iomap_dio_rw()
+ */
+
+/*
+ * Wait for completion of DIO
+ */
+#define IOMAP_DIO_RWF_SYNCIO			(1 << 0)
+
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
-		bool wait_for_completion);
+		unsigned int flags);
 int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
 
 #ifdef CONFIG_SWAP
-- 
2.26.2

