Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F927E8EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 19:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbfD2R1X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 13:27:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:58172 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728929AbfD2R1W (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:27:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1AAACAD5D;
        Mon, 29 Apr 2019 17:27:20 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     kilobyte@angband.pl, linux-fsdevel@vger.kernel.org, jack@suse.cz,
        david@fromorbit.com, willy@infradead.org, hch@lst.de,
        darrick.wong@oracle.com, dsterba@suse.cz, nborisov@suse.com,
        linux-nvdimm@lists.01.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 07/18] btrfs: add dax write support
Date:   Mon, 29 Apr 2019 12:26:38 -0500
Message-Id: <20190429172649.8288-8-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190429172649.8288-1-rgoldwyn@suse.de>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

IOMAP_DAX_COW allows to inform the dax code, to first perform
a copy which are not page-aligned before performing the write.
The responsibility of checking if data edges are page aligned
is performed in ->iomap_begin() and the source address is
stored in ->inline_data

A new struct btrfs_iomap is passed from iomap_begin() to
iomap_end(), which contains all the accounting and locking information
for CoW based writes.

For writing to a hole, iomap->inline_data is set to zero.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ctree.h |   6 ++
 fs/btrfs/dax.c   | 182 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/file.c  |   4 +-
 3 files changed, 185 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1e3e758b83c2..eec01eb92f33 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3801,6 +3801,12 @@ int btree_readahead_hook(struct extent_buffer *eb, int err);
 #ifdef CONFIG_FS_DAX
 /* dax.c */
 ssize_t btrfs_file_dax_read(struct kiocb *iocb, struct iov_iter *to);
+ssize_t btrfs_file_dax_write(struct kiocb *iocb, struct iov_iter *from);
+#else
+static inline ssize_t btrfs_file_dax_write(struct kiocb *iocb, struct iov_iter *from)
+{
+	return 0;
+}
 #endif /* CONFIG_FS_DAX */
 
 static inline int is_fstree(u64 rootid)
diff --git a/fs/btrfs/dax.c b/fs/btrfs/dax.c
index bf3d46b0acb6..f5cc9bcdbf14 100644
--- a/fs/btrfs/dax.c
+++ b/fs/btrfs/dax.c
@@ -9,30 +9,184 @@
 #ifdef CONFIG_FS_DAX
 #include <linux/dax.h>
 #include <linux/iomap.h>
+#include <linux/uio.h>
 #include "ctree.h"
 #include "btrfs_inode.h"
 
+struct btrfs_iomap {
+	u64 start;
+	u64 end;
+	bool nocow;
+	struct extent_changeset *data_reserved;
+	struct extent_state *cached_state;
+};
+
+static struct btrfs_iomap *btrfs_iomap_init(struct inode *inode,
+				     struct extent_map **em,
+				     loff_t pos, loff_t length)
+{
+	int ret = 0;
+	struct extent_map *map = *em;
+	struct btrfs_iomap *bi;
+
+	bi = kzalloc(sizeof(struct btrfs_iomap), GFP_NOFS);
+	if (!bi)
+		return ERR_PTR(-ENOMEM);
+
+	bi->start = round_down(pos, PAGE_SIZE);
+	bi->end = PAGE_ALIGN(pos + length);
+
+	/* Wait for existing ordered extents in range to finish */
+	btrfs_wait_ordered_range(inode, bi->start, bi->end - bi->start);
+
+	lock_extent_bits(&BTRFS_I(inode)->io_tree, bi->start, bi->end, &bi->cached_state);
+
+	ret = btrfs_delalloc_reserve_space(inode, &bi->data_reserved,
+			bi->start, bi->end - bi->start);
+	if (ret) {
+		unlock_extent_cached(&BTRFS_I(inode)->io_tree, bi->start, bi->end,
+				&bi->cached_state);
+		kfree(bi);
+		return ERR_PTR(ret);
+	}
+
+	refcount_inc(&map->refs);
+	ret = btrfs_get_extent_map_write(em, NULL,
+			inode, bi->start, bi->end - bi->start, &bi->nocow);
+	if (ret) {
+		unlock_extent_cached(&BTRFS_I(inode)->io_tree, bi->start, bi->end,
+				&bi->cached_state);
+		btrfs_delalloc_release_space(inode,
+				bi->data_reserved, bi->start,
+				bi->end - bi->start, true);
+		extent_changeset_free(bi->data_reserved);
+		kfree(bi);
+		return ERR_PTR(ret);
+	}
+	free_extent_map(map);
+	return bi;
+}
+
+static void *dax_address(struct block_device *bdev, struct dax_device *dax_dev,
+			 sector_t sector, loff_t pos, loff_t length)
+{
+	size_t size = ALIGN(pos + length, PAGE_SIZE);
+	int id, ret = 0;
+	void *kaddr = NULL;
+	pgoff_t pgoff;
+	long map_len;
+
+	id = dax_read_lock();
+
+	ret = bdev_dax_pgoff(bdev, sector, size, &pgoff);
+	if (ret)
+		goto out;
+
+	map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
+			&kaddr, NULL);
+	if (map_len < 0)
+		ret = map_len;
+
+out:
+	dax_read_unlock(id);
+	if (ret)
+		return ERR_PTR(ret);
+	return kaddr;
+}
+
 static int btrfs_iomap_begin(struct inode *inode, loff_t pos,
 		loff_t length, unsigned flags, struct iomap *iomap)
 {
 	struct extent_map *em;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_iomap *bi = NULL;
+	unsigned offset = pos & (PAGE_SIZE - 1);
+	u64 srcblk = 0;
+	loff_t diff;
+
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, pos, length, 0);
+
+	iomap->type = IOMAP_MAPPED;
+
+	if (flags & IOMAP_WRITE) {
+		if (em->block_start != EXTENT_MAP_HOLE)
+			srcblk = em->block_start + pos - em->start - offset;
+
+		bi = btrfs_iomap_init(inode, &em, pos, length);
+		if (IS_ERR(bi))
+			return PTR_ERR(bi);
+
+	}
+
+	/*
+	 * Advance the difference between pos and start, to align well with
+	 * inline_data in case of writes
+	 */
+	diff = round_down(pos - em->start, PAGE_SIZE);
+	iomap->offset = em->start + diff;
+	iomap->length = em->len - diff;
+	iomap->bdev = em->bdev;
+	iomap->dax_dev = fs_info->dax_dev;
+
+	/*
+	 * This will be true for reads only since we have already
+	 * allocated em
+	 */
 	if (em->block_start == EXTENT_MAP_HOLE) {
 		iomap->type = IOMAP_HOLE;
 		return 0;
 	}
-	iomap->type = IOMAP_MAPPED;
-	iomap->bdev = em->bdev;
-	iomap->dax_dev = fs_info->dax_dev;
-	iomap->offset = em->start;
-	iomap->length = em->len;
-	iomap->addr = em->block_start;
+
+	iomap->addr = em->block_start + diff;
+	/* Check if we really need to copy data from old extent */
+	if (bi && !bi->nocow && (offset || pos + length < bi->end)) {
+		iomap->type = IOMAP_DAX_COW;
+		if (srcblk) {
+			sector_t sector = (srcblk + (pos & PAGE_MASK) -
+					  iomap->offset) >> 9;
+			iomap->inline_data = dax_address(em->bdev,
+					fs_info->dax_dev, sector, pos, length);
+			if (IS_ERR(iomap->inline_data)) {
+				kfree(bi);
+				return PTR_ERR(iomap->inline_data);
+			}
+		}
+	}
+
+	iomap->private = bi;
+	return 0;
+}
+
+static int btrfs_iomap_end(struct inode *inode, loff_t pos,
+		loff_t length, ssize_t written, unsigned flags,
+		struct iomap *iomap)
+{
+	struct btrfs_iomap *bi = iomap->private;
+	u64 wend;
+
+	if (!bi)
+		return 0;
+
+	unlock_extent_cached(&BTRFS_I(inode)->io_tree, bi->start, bi->end,
+			&bi->cached_state);
+
+	wend = PAGE_ALIGN(pos + written);
+	if (wend < bi->end) {
+		btrfs_delalloc_release_space(inode,
+				bi->data_reserved, wend,
+				bi->end - wend, true);
+	}
+
+	btrfs_update_ordered_extent(inode, bi->start, wend - bi->start, true);
+	btrfs_delalloc_release_extents(BTRFS_I(inode), wend - bi->start, false);
+	extent_changeset_free(bi->data_reserved);
+	kfree(bi);
 	return 0;
 }
 
 static const struct iomap_ops btrfs_iomap_ops = {
 	.iomap_begin		= btrfs_iomap_begin,
+	.iomap_end		= btrfs_iomap_end,
 };
 
 ssize_t btrfs_file_dax_read(struct kiocb *iocb, struct iov_iter *to)
@@ -46,4 +200,20 @@ ssize_t btrfs_file_dax_read(struct kiocb *iocb, struct iov_iter *to)
 
 	return ret;
 }
+
+ssize_t btrfs_file_dax_write(struct kiocb *iocb, struct iov_iter *iter)
+{
+	ssize_t ret = 0;
+	u64 pos = iocb->ki_pos;
+	struct inode *inode = file_inode(iocb->ki_filp);
+	ret = dax_iomap_rw(iocb, iter, &btrfs_iomap_ops);
+
+	if (ret > 0) {
+		pos += ret;
+		if (pos > i_size_read(inode))
+			i_size_write(inode, pos);
+		iocb->ki_pos = pos;
+	}
+	return ret;
+}
 #endif /* CONFIG_FS_DAX */
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 9194591f9eea..a795023e26ca 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1964,7 +1964,9 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	if (sync)
 		atomic_inc(&BTRFS_I(inode)->sync_writers);
 
-	if (iocb->ki_flags & IOCB_DIRECT) {
+	if (IS_DAX(inode)) {
+		num_written = btrfs_file_dax_write(iocb, from);
+	} else if (iocb->ki_flags & IOCB_DIRECT) {
 		num_written = __btrfs_direct_write(iocb, from);
 	} else {
 		num_written = btrfs_buffered_write(iocb, from);
-- 
2.16.4

