Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEA180277
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2019 00:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437150AbfHBWBX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 18:01:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:38112 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437135AbfHBWBR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 18:01:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7DBC7B613;
        Fri,  2 Aug 2019 22:01:15 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, hch@lst.de, darrick.wong@oracle.com,
        ruansy.fnst@cn.fujitsu.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 11/13] btrfs: Use iomap_dio_rw for performing direct I/O writes
Date:   Fri,  2 Aug 2019 17:00:46 -0500
Message-Id: <20190802220048.16142-12-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190802220048.16142-1-rgoldwyn@suse.de>
References: <20190802220048.16142-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Since btrfs Direct I/O needs to perform operations before submission,
use the submit_io function which operates on the bio to perform checksum
calculations etc.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ctree.h |   3 ++
 fs/btrfs/file.c  |   2 +-
 fs/btrfs/inode.c |  14 +++--
 fs/btrfs/iomap.c | 158 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 165 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b8b19647b43e..3b7a6ddceed6 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3206,6 +3206,8 @@ int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
 void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
 					  u64 end, int uptodate);
 extern const struct dentry_operations btrfs_dentry_operations;
+void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
+		loff_t file_offset);
 
 /* ioctl.c */
 long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
@@ -3255,6 +3257,7 @@ loff_t btrfs_remap_file_range(struct file *file_in, loff_t pos_in,
 /* iomap.c */
 size_t btrfs_buffered_iomap_write(struct kiocb *iocb, struct iov_iter *from);
 ssize_t btrfs_dio_iomap_read(struct kiocb *iocb, struct iov_iter *to);
+ssize_t btrfs_dio_iomap_write(struct kiocb *iocb, struct iov_iter *from);
 
 /* tree-defrag.c */
 int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 997eb152a35a..faa5ad89469f 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1501,7 +1501,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 		atomic_inc(&BTRFS_I(inode)->sync_writers);
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
-		num_written = __btrfs_direct_write(iocb, from);
+		num_written = btrfs_dio_iomap_write(iocb, from);
 	} else {
 		num_written = btrfs_buffered_iomap_write(iocb, from);
 		if (num_written > 0)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d415534ce733..323d72858c9c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8167,9 +8167,8 @@ static void btrfs_endio_direct_read(struct bio *bio)
 	kfree(dip);
 
 	dio_bio->bi_status = err;
-	dio_end_io(dio_bio);
+	bio_endio(dio_bio);
 	btrfs_io_bio_free_csum(io_bio);
-	bio_put(bio);
 }
 
 void btrfs_update_ordered_extent(struct inode *inode,
@@ -8231,8 +8230,7 @@ static void btrfs_endio_direct_write(struct bio *bio)
 	kfree(dip);
 
 	dio_bio->bi_status = bio->bi_status;
-	dio_end_io(dio_bio);
-	bio_put(bio);
+	bio_endio(dio_bio);
 }
 
 static blk_status_t btrfs_submit_bio_start_direct_io(void *private_data,
@@ -8464,8 +8462,8 @@ static int btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
 	return 0;
 }
 
-static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
-				loff_t file_offset)
+void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
+			 loff_t file_offset)
 {
 	struct btrfs_dio_private *dip = NULL;
 	struct bio *bio = NULL;
@@ -8536,7 +8534,7 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 		/*
 		 * The end io callbacks free our dip, do the final put on bio
 		 * and all the cleanup and final put for dio_bio (through
-		 * dio_end_io()).
+		 * end_io()).
 		 */
 		dip = NULL;
 		bio = NULL;
@@ -8555,7 +8553,7 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 		 * Releases and cleans up our dio_bio, no need to bio_put()
 		 * nor bio_endio()/bio_io_error() against dio_bio.
 		 */
-		dio_end_io(dio_bio);
+		bio_endio(dio_bio);
 	}
 	if (bio)
 		bio_put(bio);
diff --git a/fs/btrfs/iomap.c b/fs/btrfs/iomap.c
index 36df606fc028..329954c8cb88 100644
--- a/fs/btrfs/iomap.c
+++ b/fs/btrfs/iomap.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/iomap.h>
+#include <linux/uio.h>
 #include "ctree.h"
 #include "btrfs_inode.h"
 #include "volumes.h"
@@ -420,15 +421,127 @@ size_t btrfs_buffered_iomap_write(struct kiocb *iocb, struct iov_iter *from)
 	return written;
 }
 
+static const struct iomap_page_ops btrfs_dio_iomap_page_ops = {
+	.submit_io = btrfs_submit_direct,
+};
+
+static struct btrfs_iomap *btrfs_iomap_init(struct inode *inode,
+		struct extent_map **em,
+		loff_t pos, loff_t length)
+{
+	int ret = 0;
+	struct extent_map *map = *em;
+	struct btrfs_iomap *bi;
+	u64 num_bytes;
+
+	bi = kzalloc(sizeof(struct btrfs_iomap), GFP_NOFS);
+	if (!bi)
+		return ERR_PTR(-ENOMEM);
+
+	bi->start = round_down(pos, PAGE_SIZE);
+	bi->end = PAGE_ALIGN(pos + length) - 1;
+	num_bytes = bi->end - bi->start + 1;
+
+	/* Wait for existing ordered extents in range to finish */
+	btrfs_wait_ordered_range(inode, bi->start, num_bytes);
+
+	lock_extent_bits(&BTRFS_I(inode)->io_tree, bi->start, bi->end, &bi->cached_state);
+
+	ret = btrfs_delalloc_reserve_space(inode, &bi->data_reserved,
+			bi->start, num_bytes);
+	if (ret) {
+		unlock_extent_cached(&BTRFS_I(inode)->io_tree, bi->start, bi->end,
+				&bi->cached_state);
+		kfree(bi);
+		return ERR_PTR(ret);
+	}
+
+	refcount_inc(&map->refs);
+	ret = btrfs_get_extent_map_write(em, NULL,
+			inode, bi->start, num_bytes);
+	if (ret) {
+		unlock_extent_cached(&BTRFS_I(inode)->io_tree, bi->start, bi->end,
+				&bi->cached_state);
+		btrfs_delalloc_release_space(inode,
+				bi->data_reserved, bi->start,
+				num_bytes, true);
+		extent_changeset_free(bi->data_reserved);
+		kfree(bi);
+		return ERR_PTR(ret);
+	}
+	free_extent_map(map);
+	return bi;
+}
+
 static int btrfs_dio_iomap_begin(struct inode *inode, loff_t pos,
-		loff_t length, unsigned flags, struct iomap *iomap,
-		struct iomap *srcmap)
+                loff_t length, unsigned flags, struct iomap *iomap,
+                struct iomap *srcmap)
 {
-	return get_iomap(inode, pos, length, iomap);
+        struct extent_map *em;
+        struct btrfs_iomap *bi = NULL;
+
+        em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, pos, length, 0);
+
+        if (flags & IOMAP_WRITE) {
+                srcmap->offset = em->start;
+                srcmap->length = em->len;
+                srcmap->bdev = em->bdev;
+                if (em->block_start == EXTENT_MAP_HOLE) {
+                        srcmap->type = IOMAP_HOLE;
+                } else {
+                        srcmap->type = IOMAP_MAPPED;
+                        srcmap->addr = em->block_start;
+                }
+                bi = btrfs_iomap_init(inode, &em, pos, length);
+                if (IS_ERR(bi))
+                        return PTR_ERR(bi);
+        }
+
+        iomap->offset = em->start;
+        iomap->length = em->len;
+        iomap->bdev = em->bdev;
+
+	if (em->block_start == EXTENT_MAP_HOLE) {
+		iomap->type = IOMAP_HOLE;
+	} else {
+		iomap->type = IOMAP_MAPPED;
+		iomap->addr = em->block_start;
+	}
+        iomap->private = bi;
+	iomap->page_ops = &btrfs_dio_iomap_page_ops;
+        return 0;
+}
+
+static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos,
+		loff_t length, ssize_t written, unsigned flags,
+		struct iomap *iomap)
+{
+	struct btrfs_iomap *bi = iomap->private;
+	u64 wend;
+	loff_t release_bytes;
+
+	if (!bi)
+		return 0;
+
+	unlock_extent_cached(&BTRFS_I(inode)->io_tree, bi->start, bi->end,
+			&bi->cached_state);
+
+	wend = PAGE_ALIGN(pos + written);
+	release_bytes = wend - bi->end - 1;
+	if (release_bytes > 0)
+		btrfs_delalloc_release_space(inode,
+				bi->data_reserved, wend,
+				release_bytes, true);
+
+	btrfs_delalloc_release_extents(BTRFS_I(inode), wend - bi->start, false);
+	extent_changeset_free(bi->data_reserved);
+	kfree(bi);
+	return 0;
 }
 
 static const struct iomap_ops btrfs_dio_iomap_ops = {
 	.iomap_begin            = btrfs_dio_iomap_begin,
+	.iomap_end              = btrfs_dio_iomap_end,
 };
 
 ssize_t btrfs_dio_iomap_read(struct kiocb *iocb, struct iov_iter *to)
@@ -440,3 +553,42 @@ ssize_t btrfs_dio_iomap_read(struct kiocb *iocb, struct iov_iter *to)
 	inode_unlock_shared(inode);
 	return ret;
 }
+
+ssize_t btrfs_dio_iomap_write(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
+	ssize_t written, written_buffered;
+	loff_t pos, endbyte;
+	int err;
+
+	written = iomap_dio_rw(iocb, from, &btrfs_dio_iomap_ops, NULL);
+	if (written < 0 || !iov_iter_count(from))
+		return written;
+
+	pos = iocb->ki_pos;
+	written_buffered = btrfs_buffered_iomap_write(iocb, from);
+	if (written_buffered < 0) {
+		err = written_buffered;
+		goto out;
+	}
+	/*
+	 * Ensure all data is persisted. We want the next direct IO read to be
+	 * able to read what was just written.
+	 */
+	endbyte = pos + written_buffered - 1;
+	err = btrfs_fdatawrite_range(inode, pos, endbyte);
+	if (err)
+		goto out;
+	err = filemap_fdatawait_range(inode->i_mapping, pos, endbyte);
+	if (err)
+		goto out;
+	written += written_buffered;
+	iocb->ki_pos = pos + written_buffered;
+	invalidate_mapping_pages(file->f_mapping, pos >> PAGE_SHIFT,
+			endbyte >> PAGE_SHIFT);
+out:
+	if (written > 0 && iocb->ki_pos > i_size_read(inode))
+			i_size_write(inode, iocb->ki_pos);
+	return written ? written : err;
+}
-- 
2.16.4

