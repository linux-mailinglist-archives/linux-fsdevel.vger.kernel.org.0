Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30BF2128995
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2019 15:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfLUOm1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Dec 2019 09:42:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35296 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfLUOm1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Dec 2019 09:42:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uo1Jp8FXncNhPjFbCsmTvInmO2FpJumDYXZ4CzTH8ko=; b=JUNVhMefZrxe2RTKQf/eRJfkp
        AuP1HB7i0imcRqHpT8MOJ65kIUOnc6s3kIpei3OFBmUoZwqGcUXrINN9OmcMZ+tj2hQWmygyYtxHP
        cjOhzIMTIFEqqbXabzyam6dZwXU8fbGKsH43+WOusfkTXWFkT0mgehS48Hl1+RAFEHzA7uPGGMqq/
        Oc3d52kwjCESR2sB2cdFhS6I/iGgLaSPKY5oOV9gbQ0OIJnD6IRYCg4w5h6Oj5AHuVOdZ9GbA/Nqn
        8a3JN8vpZP0nyWPXFuxl1na3srAEs0gLA/KfwKj9L39Xe755NLmUxNk9sA9jPudL2te0+fBCdP9G/
        5pH4nCCCA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iifxa-0001Dv-RK; Sat, 21 Dec 2019 14:42:26 +0000
Date:   Sat, 21 Dec 2019 06:42:26 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, hch@infradead.org,
        darrick.wong@oracle.com, fdmanana@kernel.org, nborisov@suse.com,
        dsterba@suse.cz, jthumshirn@suse.de, linux-fsdevel@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 4/8] btrfs: Switch to iomap_dio_rw() for dio
Message-ID: <20191221144226.GA25804@infradead.org>
References: <20191213195750.32184-1-rgoldwyn@suse.de>
 <20191213195750.32184-5-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <20191213195750.32184-5-rgoldwyn@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

So Ilooked into the "unlocked" direct I/O case, and I think the current
code using dio_sem is really sketchy.  What btrfs really needs to do is
take i_rwsem shared by default for direct writes, and only upgrade to
the exclusive lock when needed, similar to xfs and the WIP ext4 code.

While looking for that I also noticed two other things:

 - check_direct_IO looks pretty bogus
 - btrfs_direct_IO really should be split and folded into the two
   callers

Untested patches attached.  The first should probably go into a prep
patch, and the second could be folded into this one.

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-btrfs-remove-direct-I-O-aligment-checks.patch"

From bc285e440a50140beb456f11e545a049bdf51ec1 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Sat, 21 Dec 2019 15:17:26 +0100
Subject: btrfs: remove direct I/O aligment checks

The direct I/O code itself already checks for the proper sector
size alignment, so remove the duplicate checks.  The remainder of
check_direct_IO is not ony needed for reads and can be moved to
file.c and outside of i_rwsem.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/file.c  | 34 +++++++++++++++++++++++++++-------
 fs/btrfs/inode.c | 37 -------------------------------------
 2 files changed, 27 insertions(+), 44 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index a6d41d7bf362..0522f6d45a98 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3444,21 +3444,41 @@ static int btrfs_file_open(struct inode *inode, struct file *filp)
 	return generic_file_open(inode, filp);
 }
 
-static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
+/*
+ * If there are duplicate iov_base's in this iovec, fall back to buffered I/O
+ * to avoid checksum errors.
+ */
+static bool btrfs_direct_read_ok(struct kiocb *iocb, struct iov_iter *iter)
 {
-	ssize_t ret = 0;
+	int seg, i;
 
-	if (iocb->ki_flags & IOCB_DIRECT) {
+	if (!iter_is_iovec(iter))
+		return true;
+
+	for (seg = 0; seg < iter->nr_segs; seg++) {
+		for (i = seg + 1; i < iter->nr_segs; i++) {
+			if (iter->iov[seg].iov_base == iter->iov[i].iov_base)
+				return false;
+		}
+	}
+
+	return true;
+}
+
+
+static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	if ((iocb->ki_flags & IOCB_DIRECT) && btrfs_direct_read_ok(iocb, to)) {
 		struct inode *inode = file_inode(iocb->ki_filp);
+		ssize_t ret;
 
 		inode_lock_shared(inode);
 		ret = btrfs_direct_IO(iocb, to);
 		inode_unlock_shared(inode);
-		if (ret < 0)
-			return ret;
-	}
 
-	return generic_file_buffered_read(iocb, to, ret);
+		return ret;
+	}
+	return generic_file_buffered_read(iocb, to, 0);
 }
 
 const struct file_operations btrfs_file_operations = {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 824f318cee5e..18d153a62655 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8581,39 +8581,6 @@ static blk_qc_t btrfs_submit_direct(struct bio *dio_bio, struct file *file,
 	return BLK_QC_T_NONE;
 }
 
-static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
-			       const struct iov_iter *iter, loff_t offset)
-{
-	int seg;
-	int i;
-	unsigned int blocksize_mask = fs_info->sectorsize - 1;
-	ssize_t retval = -EINVAL;
-
-	if (offset & blocksize_mask)
-		goto out;
-
-	if (iov_iter_alignment(iter) & blocksize_mask)
-		goto out;
-
-	/* If this is a write we don't need to check anymore */
-	if (iov_iter_rw(iter) != READ || !iter_is_iovec(iter))
-		return 0;
-	/*
-	 * Check to make sure we don't have duplicate iov_base's in this
-	 * iovec, if so return EINVAL, otherwise we'll get csum errors
-	 * when reading back.
-	 */
-	for (seg = 0; seg < iter->nr_segs; seg++) {
-		for (i = seg + 1; i < iter->nr_segs; i++) {
-			if (iter->iov[seg].iov_base == iter->iov[i].iov_base)
-				goto out;
-		}
-	}
-	retval = 0;
-out:
-	return retval;
-}
-
 static const struct iomap_ops btrfs_dio_iomap_ops = {
 	.iomap_begin            = btrfs_dio_iomap_begin,
 	.iomap_end		= btrfs_dio_iomap_end,
@@ -8635,7 +8602,6 @@ ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_changeset *data_reserved = NULL;
 	loff_t offset = iocb->ki_pos;
 	size_t count = 0;
@@ -8644,9 +8610,6 @@ ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 	lockdep_assert_held(&inode->i_rwsem);
 
-	if (check_direct_IO(fs_info, iter, offset))
-		return 0;
-
 	count = iov_iter_count(iter);
 	if (iov_iter_rw(iter) == WRITE) {
 		/*
-- 
2.24.0


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-btrfs-split-btrfs_direct_IO.patch"

From 7194fa1986a48af46d2b01457865066cdbd14e35 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Sat, 21 Dec 2019 15:23:41 +0100
Subject: btrfs: split btrfs_direct_IO

The read and write versions don't have anything in common except
for the call to iomap_dio_rw.  So split this function, and merge
each half into its only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/ctree.h |  4 ++-
 fs/btrfs/file.c  | 44 +++++++++++++++++++++++++----
 fs/btrfs/inode.c | 72 ++++--------------------------------------------
 3 files changed, 48 insertions(+), 72 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8faa069b0a73..fccbbfebdf88 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -28,6 +28,7 @@
 #include <linux/dynamic_debug.h>
 #include <linux/refcount.h>
 #include <linux/crc32c.h>
+#include <linux/iomap.h>
 #include "extent-io-tree.h"
 #include "extent_io.h"
 #include "extent_map.h"
@@ -2904,7 +2905,8 @@ int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
 void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
 					  u64 end, int uptodate);
 extern const struct dentry_operations btrfs_dentry_operations;
-ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
+const struct iomap_ops btrfs_dio_iomap_ops;
+const struct iomap_dio_ops btrfs_dio_ops;
 
 /* ioctl.c */
 long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0522f6d45a98..ed0b2e015d8d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1822,17 +1822,50 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	return num_written ? num_written : ret;
 }
 
-static ssize_t __btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
+static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
-	loff_t pos;
+	size_t count = iov_iter_count(from);
+	struct extent_changeset *data_reserved = NULL;
+	loff_t pos = iocb->ki_pos;
 	ssize_t written;
 	ssize_t written_buffered;
 	loff_t endbyte;
+	bool relock = false;
 	int err;
 
-	written = btrfs_direct_IO(iocb, from);
+	/*
+	 * If the write DIO is beyond the EOF, we need update the isize, but
+	 * it is protected by i_mutex. So we can not unlock the i_mutex in
+	 * this case.
+	 */
+	if (pos + count <= inode->i_size) {
+		inode_unlock(inode);
+		relock = true;
+	} else {
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			return -EAGAIN;
+	}
+
+	err = btrfs_delalloc_reserve_space(inode, &data_reserved, pos, count);
+	if (err) {
+		if (relock)
+			inode_lock(inode);
+		return err;
+	}
+
+	down_read(&BTRFS_I(inode)->dio_sem);
+	written = iomap_dio_rw(iocb, from, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
+			is_sync_kiocb(iocb));
+	up_read(&BTRFS_I(inode)->dio_sem);
+	if (written >= 0 && (size_t)written < count)
+		btrfs_delalloc_release_space(inode, data_reserved,
+				pos, count - (size_t)written, true);
+	btrfs_delalloc_release_extents(BTRFS_I(inode), count);
+	if (relock)
+		inode_lock(inode);
+	extent_changeset_free(data_reserved);
 
 	if (written < 0 || !iov_iter_count(from))
 		return written;
@@ -1975,7 +2008,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 		atomic_inc(&BTRFS_I(inode)->sync_writers);
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
-		num_written = __btrfs_direct_write(iocb, from);
+		num_written = btrfs_direct_write(iocb, from);
 	} else {
 		num_written = btrfs_buffered_write(iocb, from);
 		if (num_written > 0)
@@ -3473,7 +3506,8 @@ static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		ssize_t ret;
 
 		inode_lock_shared(inode);
-		ret = btrfs_direct_IO(iocb, to);
+		ret = iomap_dio_rw(iocb, to, &btrfs_dio_iomap_ops,
+				   &btrfs_dio_ops, is_sync_kiocb(iocb));
 		inode_unlock_shared(inode);
 
 		return ret;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 18d153a62655..7b747270ec40 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -29,7 +29,6 @@
 #include <linux/iversion.h>
 #include <linux/swap.h>
 #include <linux/sched/mm.h>
-#include <linux/iomap.h>
 #include <asm/unaligned.h>
 #include "misc.h"
 #include "ctree.h"
@@ -7856,6 +7855,11 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	return 0;
 }
 
+const struct iomap_ops btrfs_dio_iomap_ops = {
+	.iomap_begin            = btrfs_dio_iomap_begin,
+	.iomap_end		= btrfs_dio_iomap_end,
+};
+
 static inline blk_status_t submit_dio_repair_bio(struct inode *inode,
 						 struct bio *bio,
 						 int mirror_num)
@@ -8581,74 +8585,10 @@ static blk_qc_t btrfs_submit_direct(struct bio *dio_bio, struct file *file,
 	return BLK_QC_T_NONE;
 }
 
-static const struct iomap_ops btrfs_dio_iomap_ops = {
-	.iomap_begin            = btrfs_dio_iomap_begin,
-	.iomap_end		= btrfs_dio_iomap_end,
-};
-
-static const struct iomap_dio_ops btrfs_dops = {
+const struct iomap_dio_ops btrfs_dio_ops = {
 	.submit_io		= btrfs_submit_direct,
 };
 
-
-/*
- * btrfs_direct_IO - perform direct I/O
- * inode->i_rwsem must be locked before calling this function, shared or exclusive.
- * @iocb - kernel iocb
- * @iter - iter to/from data is copied
- */
-
-ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
-{
-	struct file *file = iocb->ki_filp;
-	struct inode *inode = file->f_mapping->host;
-	struct extent_changeset *data_reserved = NULL;
-	loff_t offset = iocb->ki_pos;
-	size_t count = 0;
-	bool relock = false;
-	ssize_t ret;
-
-	lockdep_assert_held(&inode->i_rwsem);
-
-	count = iov_iter_count(iter);
-	if (iov_iter_rw(iter) == WRITE) {
-		/*
-		 * If the write DIO is beyond the EOF, we need update
-		 * the isize, but it is protected by i_mutex. So we can
-		 * not unlock the i_mutex at this case.
-		 */
-		if (offset + count <= inode->i_size) {
-			inode_unlock(inode);
-			relock = true;
-		} else if (iocb->ki_flags & IOCB_NOWAIT) {
-			ret = -EAGAIN;
-			goto out;
-		}
-		ret = btrfs_delalloc_reserve_space(inode, &data_reserved,
-						   offset, count);
-		if (ret)
-			goto out;
-
-		down_read(&BTRFS_I(inode)->dio_sem);
-	}
-
-	ret = iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dops,
-			is_sync_kiocb(iocb));
-
-	if (iov_iter_rw(iter) == WRITE) {
-		up_read(&BTRFS_I(inode)->dio_sem);
-		if (ret >= 0 && (size_t)ret < count)
-			btrfs_delalloc_release_space(inode, data_reserved,
-					offset, count - (size_t)ret, true);
-		btrfs_delalloc_release_extents(BTRFS_I(inode), count);
-	}
-out:
-	if (relock)
-		inode_lock(inode);
-	extent_changeset_free(data_reserved);
-	return ret;
-}
-
 #define BTRFS_FIEMAP_FLAGS	(FIEMAP_FLAG_SYNC)
 
 static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
-- 
2.24.0


--FCuugMFkClbJLl1L--
