Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 543894EF74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2019 21:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfFUT2o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 15:28:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:33250 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725947AbfFUT2o (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 15:28:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 362C9AF0F;
        Fri, 21 Jun 2019 19:28:41 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de, darrick.wong@oracle.com,
        david@fromorbit.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 4/6] btrfs: Add a simple buffered iomap write
Date:   Fri, 21 Jun 2019 14:28:26 -0500
Message-Id: <20190621192828.28900-5-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190621192828.28900-1-rgoldwyn@suse.de>
References: <20190621192828.28900-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Introduce a new static structure btrfs_iomap, which carries
information from iomap_begin() to iomap_end(). This primarily
contains reservation and extent locking information.

This one is a long patch. Most of the code is "inspired" by
fs/btrfs/file.c. To keep the size small, all removals are in
following patches.

Patch inclusion / Coding style question -
From a code-readability PoV, I prefer lot of small functions versus a big
function. I would like to further break this down, but since
it was a 1-1 mapping with file.c, I let it be. Would you prefer to put
breaking into smaller functions in this same patch, or prefer it as
a separate patch (re)modifying this code?

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/Makefile |   2 +-
 fs/btrfs/ctree.h  |   1 +
 fs/btrfs/file.c   |   4 +-
 fs/btrfs/iomap.c  | 389 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 393 insertions(+), 3 deletions(-)
 create mode 100644 fs/btrfs/iomap.c

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index ca693dd554e9..bfc1954204cf 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -10,7 +10,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   export.o tree-log.o free-space-cache.o zlib.o lzo.o zstd.o \
 	   compression.o delayed-ref.o relocation.o delayed-inode.o scrub.o \
 	   reada.o backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
-	   uuid-tree.o props.o free-space-tree.o tree-checker.o
+	   uuid-tree.o props.o free-space-tree.o tree-checker.o iomap.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0a61dff27f57..80d37dfff873 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3348,6 +3348,7 @@ int btrfs_fdatawrite_range(struct inode *inode, loff_t start, loff_t end);
 loff_t btrfs_remap_file_range(struct file *file_in, loff_t pos_in,
 			      struct file *file_out, loff_t pos_out,
 			      loff_t len, unsigned int remap_flags);
+size_t btrfs_buffered_iomap_write(struct kiocb *iocb, struct iov_iter *from);
 
 /* tree-defrag.c */
 int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 89f5be2bfb43..fc3032d8b573 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1839,7 +1839,7 @@ static ssize_t __btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		return written;
 
 	pos = iocb->ki_pos;
-	written_buffered = btrfs_buffered_write(iocb, from);
+	written_buffered = btrfs_buffered_iomap_write(iocb, from);
 	if (written_buffered < 0) {
 		err = written_buffered;
 		goto out;
@@ -1976,7 +1976,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		num_written = __btrfs_direct_write(iocb, from);
 	} else {
-		num_written = btrfs_buffered_write(iocb, from);
+		num_written = btrfs_buffered_iomap_write(iocb, from);
 		if (num_written > 0)
 			iocb->ki_pos = pos + num_written;
 		if (clean_page)
diff --git a/fs/btrfs/iomap.c b/fs/btrfs/iomap.c
new file mode 100644
index 000000000000..0435b179d461
--- /dev/null
+++ b/fs/btrfs/iomap.c
@@ -0,0 +1,389 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * iomap support for BTRFS
+ *
+ * Copyright (c) 2019  SUSE Linux
+ * Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
+ */
+
+#include <linux/iomap.h>
+#include "ctree.h"
+#include "btrfs_inode.h"
+#include "volumes.h"
+#include "disk-io.h"
+
+struct btrfs_iomap {
+	u64 start;
+	u64 end;
+	bool nocow;
+	int extents_locked;
+	ssize_t reserved_bytes;
+	struct extent_changeset *data_reserved;
+	struct extent_state *cached_state;
+};
+
+
+/*
+ * This function locks the extent and properly waits for data=ordered extents
+ * to finish before allowing the pages to be modified if need.
+ *
+ * The return value:
+ * 1 - the extent is locked
+ * 0 - the extent is not locked, and everything is OK
+ * -EAGAIN - need re-prepare the pages
+ * the other < 0 number - Something wrong happens
+ */
+static noinline int
+lock_and_cleanup_extent(struct btrfs_inode *inode, loff_t pos,
+			 size_t write_bytes,
+			 u64 *lockstart, u64 *lockend,
+			 struct extent_state **cached_state)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	u64 start_pos;
+	u64 last_pos;
+	int ret = 0;
+
+	start_pos = round_down(pos, fs_info->sectorsize);
+	last_pos = start_pos
+		+ round_up(pos + write_bytes - start_pos,
+			   fs_info->sectorsize) - 1;
+
+	if (start_pos < inode->vfs_inode.i_size) {
+		struct btrfs_ordered_extent *ordered;
+
+		lock_extent_bits(&inode->io_tree, start_pos, last_pos,
+				cached_state);
+		ordered = btrfs_lookup_ordered_range(inode, start_pos,
+						     last_pos - start_pos + 1);
+		if (ordered &&
+		    ordered->file_offset + ordered->len > start_pos &&
+		    ordered->file_offset <= last_pos) {
+			unlock_extent_cached(&inode->io_tree, start_pos,
+					last_pos, cached_state);
+			btrfs_start_ordered_extent(&inode->vfs_inode,
+					ordered, 1);
+			btrfs_put_ordered_extent(ordered);
+			return -EAGAIN;
+		}
+		if (ordered)
+			btrfs_put_ordered_extent(ordered);
+
+		*lockstart = start_pos;
+		*lockend = last_pos;
+		ret = 1;
+	}
+
+	return ret;
+}
+
+static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
+				    size_t *write_bytes)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct btrfs_root *root = inode->root;
+	struct btrfs_ordered_extent *ordered;
+	u64 lockstart, lockend;
+	u64 num_bytes;
+	int ret;
+
+	ret = btrfs_start_write_no_snapshotting(root);
+	if (!ret)
+		return -ENOSPC;
+
+	lockstart = round_down(pos, fs_info->sectorsize);
+	lockend = round_up(pos + *write_bytes,
+			   fs_info->sectorsize) - 1;
+
+	while (1) {
+		lock_extent(&inode->io_tree, lockstart, lockend);
+		ordered = btrfs_lookup_ordered_range(inode, lockstart,
+						     lockend - lockstart + 1);
+		if (!ordered) {
+			break;
+		}
+		unlock_extent(&inode->io_tree, lockstart, lockend);
+		btrfs_start_ordered_extent(&inode->vfs_inode, ordered, 1);
+		btrfs_put_ordered_extent(ordered);
+	}
+
+	num_bytes = lockend - lockstart + 1;
+	ret = can_nocow_extent(&inode->vfs_inode, lockstart, &num_bytes,
+			NULL, NULL, NULL);
+	if (ret <= 0) {
+		ret = 0;
+		btrfs_end_write_no_snapshotting(root);
+	} else {
+		*write_bytes = min_t(size_t, *write_bytes ,
+				     num_bytes - pos + lockstart);
+	}
+
+	unlock_extent(&inode->io_tree, lockstart, lockend);
+
+	return ret;
+}
+
+static int btrfs_find_new_delalloc_bytes(struct btrfs_inode *inode,
+					 const u64 start,
+					 const u64 len,
+					 struct extent_state **cached_state)
+{
+	u64 search_start = start;
+	const u64 end = start + len - 1;
+
+	while (search_start < end) {
+		const u64 search_len = end - search_start + 1;
+		struct extent_map *em;
+		u64 em_len;
+		int ret = 0;
+
+		em = btrfs_get_extent(inode, NULL, 0, search_start,
+				      search_len, 0);
+		if (IS_ERR(em))
+			return PTR_ERR(em);
+
+		if (em->block_start != EXTENT_MAP_HOLE)
+			goto next;
+
+		em_len = em->len;
+		if (em->start < search_start)
+			em_len -= search_start - em->start;
+		if (em_len > search_len)
+			em_len = search_len;
+
+		ret = set_extent_bit(&inode->io_tree, search_start,
+				     search_start + em_len - 1,
+				     EXTENT_DELALLOC_NEW,
+				     NULL, cached_state, GFP_NOFS);
+next:
+		search_start = extent_map_end(em);
+		free_extent_map(em);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static int btrfs_buffered_page_prepare(struct inode *inode, loff_t pos,
+		unsigned len, struct iomap *iomap)
+{
+	//wait_on_page_writeback(page);
+	//set_page_extent_mapped(page);
+	return 0;
+}
+
+static void btrfs_buffered_page_done(struct inode *inode, loff_t pos,
+		unsigned copied, struct page *page,
+		struct iomap *iomap)
+{
+	SetPageUptodate(page);
+	ClearPageChecked(page);
+	set_page_dirty(page);
+	get_page(page);
+}
+
+
+static const struct iomap_page_ops btrfs_buffered_page_ops = {
+	.page_prepare = btrfs_buffered_page_prepare,
+	.page_done = btrfs_buffered_page_done,
+};
+
+
+static int btrfs_buffered_iomap_begin(struct inode *inode, loff_t pos,
+		loff_t length, unsigned flags, struct iomap *iomap,
+		struct iomap *srcmap)
+{
+	int ret;
+	size_t write_bytes = length;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	size_t sector_offset = pos & (fs_info->sectorsize - 1);
+	struct btrfs_iomap *bi;
+
+	bi = kzalloc(sizeof(struct btrfs_iomap), GFP_NOFS);
+	if (!bi)
+		return -ENOMEM;
+
+	bi->reserved_bytes = round_up(write_bytes + sector_offset,
+			fs_info->sectorsize);
+
+	/* Reserve data space */
+	ret = btrfs_check_data_free_space(inode, &bi->data_reserved, pos,
+			write_bytes);
+	if (ret < 0) {
+		/*
+		 * Space allocation failed. Let's check if we can
+		 * continue I/O without allocations
+		 */
+		if ((BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
+						BTRFS_INODE_PREALLOC)) &&
+				check_can_nocow(BTRFS_I(inode), pos,
+					&write_bytes) > 0) {
+			bi->nocow = true;
+			/*
+			 * our prealloc extent may be smaller than
+			 * write_bytes, so scale down.
+			 */
+			bi->reserved_bytes = round_up(write_bytes +
+					sector_offset,
+					fs_info->sectorsize);
+		} else {
+			goto error;
+		}
+	}
+
+	WARN_ON(bi->reserved_bytes == 0);
+
+	/* We have the data space allocated, reserve the metadata now */
+	ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
+			bi->reserved_bytes);
+	if (ret) {
+		struct btrfs_root *root = BTRFS_I(inode)->root;
+		if (!bi->nocow)
+			btrfs_free_reserved_data_space(inode,
+					bi->data_reserved, pos,
+					write_bytes);
+		else
+			btrfs_end_write_no_snapshotting(root);
+		goto error;
+	}
+
+	do {
+		ret = lock_and_cleanup_extent(
+				BTRFS_I(inode), pos, write_bytes, &bi->start,
+				&bi->end, &bi->cached_state);
+	} while (ret == -EAGAIN);
+
+	if (ret < 0) {
+		btrfs_delalloc_release_extents(BTRFS_I(inode),
+					       bi->reserved_bytes, true);
+		goto release;
+	} else {
+		bi->extents_locked = ret;
+	}
+	iomap->private = bi;
+	iomap->length = round_up(write_bytes, fs_info->sectorsize);
+	iomap->offset = round_down(pos, fs_info->sectorsize);
+	iomap->addr = IOMAP_NULL_ADDR;
+	iomap->type = IOMAP_DELALLOC;
+	iomap->bdev = fs_info->fs_devices->latest_bdev;
+	iomap->page_ops = &btrfs_buffered_page_ops;
+	return 0;
+release:
+	if (bi->extents_locked)
+		unlock_extent_cached(&BTRFS_I(inode)->io_tree, bi->start,
+				bi->end, &bi->cached_state);
+	if (bi->nocow) {
+		struct btrfs_root *root = BTRFS_I(inode)->root;
+		btrfs_end_write_no_snapshotting(root);
+		btrfs_delalloc_release_metadata(BTRFS_I(inode),
+				bi->reserved_bytes, true);
+	} else {
+		btrfs_delalloc_release_space(inode, bi->data_reserved,
+				round_down(pos, fs_info->sectorsize),
+				bi->reserved_bytes, true);
+	}
+	extent_changeset_free(bi->data_reserved);
+
+error:
+	kfree(bi);
+	return ret;
+}
+
+static int btrfs_buffered_iomap_end(struct inode *inode, loff_t pos,
+		loff_t length, ssize_t written, unsigned flags,
+		struct iomap *iomap)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_iomap *bi = iomap->private;
+	ssize_t release_bytes = round_down(bi->reserved_bytes - written,
+			1 << fs_info->sb->s_blocksize_bits);
+	unsigned int extra_bits = 0;
+	u64 start_pos = pos & ~((u64) fs_info->sectorsize - 1);
+	u64 num_bytes = round_up(written + pos - start_pos,
+			fs_info->sectorsize);
+	u64 end_of_last_block = start_pos + num_bytes - 1;
+	int ret = 0;
+
+	if (release_bytes > 0) {
+		if (bi->nocow) {
+			btrfs_delalloc_release_metadata(BTRFS_I(inode),
+					release_bytes, true);
+		} else {
+			u64 __pos = round_down(pos + written, fs_info->sectorsize);
+			btrfs_delalloc_release_space(inode, bi->data_reserved,
+					__pos, release_bytes, true);
+		}
+	}
+
+	/*
+	 * The pages may have already been dirty, clear out old accounting so
+	 * we can set things up properly
+	 */
+	clear_extent_bit(&BTRFS_I(inode)->io_tree, start_pos, end_of_last_block,
+			EXTENT_DIRTY | EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
+			EXTENT_DEFRAG, 0, 0, &bi->cached_state);
+
+	if (!btrfs_is_free_space_inode(BTRFS_I(inode))) {
+		if (start_pos >= i_size_read(inode) &&
+		    !(BTRFS_I(inode)->flags & BTRFS_INODE_PREALLOC)) {
+			/*
+			 * There can't be any extents following eof in this case
+			 * so just set the delalloc new bit for the range
+			 * directly.
+			 */
+			extra_bits |= EXTENT_DELALLOC_NEW;
+		} else {
+			ret = btrfs_find_new_delalloc_bytes(BTRFS_I(inode),
+					start_pos, num_bytes,
+					&bi->cached_state);
+			if (ret)
+				goto unlock;
+		}
+	}
+
+	ret = btrfs_set_extent_delalloc(inode, start_pos, end_of_last_block,
+			extra_bits, &bi->cached_state, 0);
+unlock:
+	if (bi->extents_locked)
+		unlock_extent_cached(&BTRFS_I(inode)->io_tree,
+				bi->start, bi->end, &bi->cached_state);
+
+	if (bi->nocow) {
+		struct btrfs_root *root = BTRFS_I(inode)->root;
+		btrfs_end_write_no_snapshotting(root);
+		if (written > 0) {
+			u64 start = round_down(pos, fs_info->sectorsize);
+			u64 end = round_up(pos + written, fs_info->sectorsize) - 1;
+			set_extent_bit(&BTRFS_I(inode)->io_tree, start, end,
+					EXTENT_NORESERVE, NULL, NULL, GFP_NOFS);
+		}
+
+	}
+	btrfs_delalloc_release_extents(BTRFS_I(inode), bi->reserved_bytes,
+			true);
+
+	if (written < fs_info->nodesize)
+		btrfs_btree_balance_dirty(fs_info);
+
+	extent_changeset_free(bi->data_reserved);
+	kfree(bi);
+	return ret;
+}
+
+static const struct iomap_ops btrfs_buffered_iomap_ops = {
+	.iomap_begin            = btrfs_buffered_iomap_begin,
+	.iomap_end              = btrfs_buffered_iomap_end,
+};
+
+size_t btrfs_buffered_iomap_write(struct kiocb *iocb, struct iov_iter *from)
+{
+	ssize_t written;
+	struct inode *inode = file_inode(iocb->ki_filp);
+	written = iomap_file_buffered_write(iocb, from, &btrfs_buffered_iomap_ops);
+	if (written > 0)
+		iocb->ki_pos += written;
+	if (iocb->ki_pos > i_size_read(inode))
+		i_size_write(inode, iocb->ki_pos);
+	return written;
+}
+
-- 
2.16.4

