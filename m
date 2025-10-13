Return-Path: <linux-fsdevel+bounces-63892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2F9BD14AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 05:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0128B1896B02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 03:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658982F28F1;
	Mon, 13 Oct 2025 02:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IaTnSPQF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E65C1F5423;
	Mon, 13 Oct 2025 02:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760324377; cv=none; b=AS4XGxbIeDRmu+Q/bL7EUcXS4LSai9+lpl+3GpGfZzuK685mIEx+nqRMpwyIE/cbJbz7GxVIESLDCvwibL/jXkVMWiWRVk76zwYdueZ/XFQmxCA8XToN9igcXcbJQYyVyzmnjb00j5puU/ldQnVP2uoHfPi7k4ySUIQ/LRLnbLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760324377; c=relaxed/simple;
	bh=N9cvdF9ZWC3JHp3NMG+9zlaQlHLHShhH0gCBVFmGPh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WC+a0KGG9Yrz1LJw/90Qr8ZEmS+SaDM4B3nHroNS9DDKghAcMo6PpvPZ3rG0SVH06y1IWKcXF6XOJyBucHkk1aM0S7gJ50kASsJ4xLXqbTVnTt6X6jPlhKbL3A0Pci5+q9G0EX4g+wdaMmbVxDOzOjCjqWwOElOlakpXnPEGc4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IaTnSPQF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=HdnyQGqrNCayWqrk6FmNGitJaDaql2Ia+2Cy7TiImxs=; b=IaTnSPQF1Yn6B4lp14WfnvVTFo
	7MHe/bnlcZDqhOwu2i+/VZeNdamAtyIbCtnKoiyu4PAeAvz+wWZyCBW+qsOBXAl95Tn3OrM5TH7ln
	BWkp9Ksp9vLnC4dgzzYhfQ4XE8FEWdayjc504eXPuG2BImWR8Dri0wsenaaT1ORZVtx8100PbkrBv
	oa0+qtWQj+8MLdEDawVjUOdDwft+/cmgomFWNM/y5bprbUjaq2zDtWjIb5LatVIoHkLdOzcEfjBtO
	chNK5tiFJvo3g1quERws/1j0h1+IvldPD6Zc1sIqOUdgO6HOgVT4o7Ghdz74w9RlccJUzUNcGQAe7
	E5j+WuCA==;
Received: from [220.85.59.196] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v88ma-0000000C8Rv-11QA;
	Mon, 13 Oct 2025 02:59:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jan Kara <jack@suse.cz>,
	linux-block@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	ocfs2-devel@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 10/10] mm: rename filemap_flush to filemap_fdatawrite_kick
Date: Mon, 13 Oct 2025 11:58:05 +0900
Message-ID: <20251013025808.4111128-11-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251013025808.4111128-1-hch@lst.de>
References: <20251013025808.4111128-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Make the naming consistent with the other helpers and get away from
the flush terminology that is way to overloaded.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bdev.c            | 2 +-
 fs/btrfs/defrag.c       | 4 ++--
 fs/btrfs/extent_io.c    | 3 ++-
 fs/btrfs/file.c         | 2 +-
 fs/btrfs/inode.c        | 6 +++---
 fs/btrfs/reflink.c      | 2 +-
 fs/btrfs/super.c        | 2 +-
 fs/ext4/inline.c        | 2 +-
 fs/ext4/inode.c         | 6 +++---
 fs/fat/inode.c          | 2 +-
 fs/jfs/jfs_logmgr.c     | 2 +-
 fs/xfs/xfs_file.c       | 2 +-
 include/linux/pagemap.h | 2 +-
 mm/filemap.c            | 6 +++---
 mm/khugepaged.c         | 2 +-
 15 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 810707cca970..e8a564120ac7 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -245,7 +245,7 @@ int sync_blockdev_nowait(struct block_device *bdev)
 {
 	if (!bdev)
 		return 0;
-	return filemap_flush(bdev->bd_mapping);
+	return filemap_fdatawrite_kick(bdev->bd_mapping);
 }
 EXPORT_SYMBOL_GPL(sync_blockdev_nowait);
 
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 7b277934f66f..e2f3027060db 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -1483,10 +1483,10 @@ int btrfs_defrag_file(struct btrfs_inode *inode, struct file_ra_state *ra,
 		 * need to be written back immediately.
 		 */
 		if (range->flags & BTRFS_DEFRAG_RANGE_START_IO) {
-			filemap_flush(inode->vfs_inode.i_mapping);
+			filemap_fdatawrite_kick(inode->vfs_inode.i_mapping);
 			if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
 				     &inode->runtime_flags))
-				filemap_flush(inode->vfs_inode.i_mapping);
+				filemap_fdatawrite_kick(inode->vfs_inode.i_mapping);
 		}
 		if (range->compress_type == BTRFS_COMPRESS_LZO)
 			btrfs_set_fs_incompat(fs_info, COMPRESS_LZO);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c123a3ef154a..c86cb27876a4 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2450,7 +2450,8 @@ static int extent_write_cache_pages(struct address_space *mapping,
 
 	/*
 	 * We do the tagged writepage as long as the snapshot flush bit is set
-	 * and we are the first one who do the filemap_flush() on this inode.
+	 * and we are the first one who do the filemap_fdatawrite_kick() on this
+	 * inode.
 	 *
 	 * The nr_to_write == LONG_MAX is needed to make sure other flushers do
 	 * not race in and drop the bit.
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 7efd1f8a1912..9190488f1aae 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1498,7 +1498,7 @@ int btrfs_release_file(struct inode *inode, struct file *filp)
 	 */
 	if (test_and_clear_bit(BTRFS_INODE_FLUSH_ON_CLOSE,
 			       &BTRFS_I(inode)->runtime_flags))
-			filemap_flush(inode->i_mapping);
+			filemap_fdatawrite_kick(inode->i_mapping);
 	return 0;
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b63d77154c45..4192056f4d42 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8434,7 +8434,7 @@ static int btrfs_rename(struct mnt_idmap *idmap,
 	 * now so  we don't add too much work to the end of the transaction
 	 */
 	if (new_inode && S_ISREG(old_inode->i_mode) && new_inode->i_size)
-		filemap_flush(old_inode->i_mapping);
+		filemap_fdatawrite_kick(old_inode->i_mapping);
 
 	if (flags & RENAME_WHITEOUT) {
 		whiteout_args.inode = new_whiteout_inode(idmap, old_dir);
@@ -8680,10 +8680,10 @@ static void btrfs_run_delalloc_work(struct btrfs_work *work)
 	delalloc_work = container_of(work, struct btrfs_delalloc_work,
 				     work);
 	inode = delalloc_work->inode;
-	filemap_flush(inode->i_mapping);
+	filemap_fdatawrite_kick(inode->i_mapping);
 	if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
 				&BTRFS_I(inode)->runtime_flags))
-		filemap_flush(inode->i_mapping);
+		filemap_fdatawrite_kick(inode->i_mapping);
 
 	iput(inode);
 	complete(&delalloc_work->completion);
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 5465a5eae9b2..72f9b5faa2e8 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -834,7 +834,7 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 	 * Also we don't need to check ASYNC_EXTENT, as async extent will be
 	 * CoWed anyway, not affecting nocow part.
 	 */
-	ret = filemap_flush(inode_in->vfs_inode.i_mapping);
+	ret = filemap_fdatawrite_kick(inode_in->vfs_inode.i_mapping);
 	if (ret < 0)
 		return ret;
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d6e496436539..e634d93a908c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1022,7 +1022,7 @@ int btrfs_sync_fs(struct super_block *sb, int wait)
 	trace_btrfs_sync_fs(fs_info, wait);
 
 	if (!wait) {
-		filemap_flush(fs_info->btree_inode->i_mapping);
+		filemap_fdatawrite_kick(fs_info->btree_inode->i_mapping);
 		return 0;
 	}
 
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 1b094a4f3866..692d28dbee64 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1951,7 +1951,7 @@ int ext4_convert_inline_data(struct inode *inode)
 		 * inline data to delay allocated block. Just force writeout
 		 * here to finish conversion.
 		 */
-		error = filemap_flush(inode->i_mapping);
+		error = filemap_fdatawrite_kick(inode->i_mapping);
 		if (error)
 			return error;
 		if (!ext4_has_inline_data(inode))
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index f9e4ac87211e..f4bcbcfd4531 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3302,7 +3302,7 @@ int ext4_alloc_da_blocks(struct inode *inode)
 		return 0;
 
 	/*
-	 * We do something simple for now.  The filemap_flush() will
+	 * We do something simple for now.  The filemap_fdatawrite_kick() will
 	 * also start triggering a write of the data blocks, which is
 	 * not strictly speaking necessary (and for users of
 	 * laptop_mode, not even desirable).  However, to do otherwise
@@ -3328,11 +3328,11 @@ int ext4_alloc_da_blocks(struct inode *inode)
 	 * logical block extents, call the multi-block allocator, and
 	 * then update the buffer heads with the block allocations.
 	 *
-	 * For now, though, we'll cheat by calling filemap_flush(),
+	 * For now, though, we'll cheat by calling filemap_fdatawrite_kick(),
 	 * which will map the blocks, and start the I/O, but not
 	 * actually wait for the I/O to complete.
 	 */
-	return filemap_flush(inode->i_mapping);
+	return filemap_fdatawrite_kick(inode->i_mapping);
 }
 
 /*
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 9648ed097816..f1ecb4c211bc 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -1877,7 +1877,7 @@ static int writeback_inode(struct inode *inode)
  * write data and metadata corresponding to i1 and i2.  The io is
  * started but we do not wait for any of it to finish.
  *
- * filemap_flush is used for the block device, so if there is a dirty
+ * filemap_fdatawrite_kick is used for the block device, so if there is a dirty
  * page for a block already in flight, we will not wait and start the
  * io over again
  */
diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index b343c5ea1159..4cdb0bb6c921 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -934,7 +934,7 @@ static int lmLogSync(struct jfs_log * log, int hard_sync)
 	if (hard_sync)
 		write_special_inodes(log, filemap_fdatawrite);
 	else
-		write_special_inodes(log, filemap_flush);
+		write_special_inodes(log, filemap_fdatawrite_kick);
 
 	/*
 	 *	forward syncpt
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 2702fef2c90c..bf39bfd4a8cd 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1615,7 +1615,7 @@ xfs_file_release(
 	if (xfs_iflags_test_and_clear(ip, XFS_ITRUNCATED)) {
 		xfs_iflags_clear(ip, XFS_EOFBLOCKS_RELEASED);
 		if (ip->i_delayed_blks > 0)
-			filemap_flush(inode->i_mapping);
+			filemap_fdatawrite_kick(inode->i_mapping);
 	}
 
 	/*
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 664f23f2330a..e7c4d8bba952 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -37,7 +37,7 @@ int filemap_invalidate_pages(struct address_space *mapping,
 
 int write_inode_now(struct inode *, int sync);
 int filemap_fdatawrite(struct address_space *);
-int filemap_flush(struct address_space *);
+int filemap_fdatawrite_kick(struct address_space *);
 int filemap_fdatawrite_kick_nr(struct address_space *mapping,
 		long *nr_to_write);
 int filemap_fdatawait_keep_errors(struct address_space *mapping);
diff --git a/mm/filemap.c b/mm/filemap.c
index ec19ed127de2..3ad6698c39c9 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -437,7 +437,7 @@ int filemap_fdatawrite_range_kick(struct address_space *mapping, loff_t start,
 EXPORT_SYMBOL_GPL(filemap_fdatawrite_range_kick);
 
 /**
- * filemap_flush - mostly a non-blocking flush
+ * filemap_fdatawrite_kick - mostly a non-blocking flush
  * @mapping:	target address_space
  *
  * This is a mostly non-blocking flush.  Not suitable for data-integrity
@@ -445,11 +445,11 @@ EXPORT_SYMBOL_GPL(filemap_fdatawrite_range_kick);
  *
  * Return: %0 on success, negative error code otherwise.
  */
-int filemap_flush(struct address_space *mapping)
+int filemap_fdatawrite_kick(struct address_space *mapping)
 {
 	return filemap_fdatawrite_range_kick(mapping, 0, LLONG_MAX);
 }
-EXPORT_SYMBOL(filemap_flush);
+EXPORT_SYMBOL(filemap_fdatawrite_kick);
 
 /*
  * Start writeback on @nr_to_write pages from @mapping.  No one but the existing
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index abe54f0043c7..5a4a43e979c4 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1949,7 +1949,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 				 * forcing writeback in loop.
 				 */
 				xas_unlock_irq(&xas);
-				filemap_flush(mapping);
+				filemap_fdatawrite_kick(mapping);
 				result = SCAN_FAIL;
 				goto xa_unlocked;
 			} else if (folio_test_writeback(folio)) {
-- 
2.47.3


