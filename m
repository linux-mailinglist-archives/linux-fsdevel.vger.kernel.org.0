Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4C2B4EF77
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2019 21:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfFUT2s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 15:28:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:33272 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726111AbfFUT2q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 15:28:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4E23FAF3E;
        Fri, 21 Jun 2019 19:28:45 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de, darrick.wong@oracle.com,
        david@fromorbit.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 6/6] btrfs: remove buffered write code made unnecessary
Date:   Fri, 21 Jun 2019 14:28:28 -0500
Message-Id: <20190621192828.28900-7-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190621192828.28900-1-rgoldwyn@suse.de>
References: <20190621192828.28900-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Better done in a separate patch to keep the main patch short(er)

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c | 464 --------------------------------------------------------
 1 file changed, 464 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index fc3032d8b573..61b5512ef035 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -389,79 +389,6 @@ int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info)
 	return 0;
 }
 
-/* simple helper to fault in pages and copy.  This should go away
- * and be replaced with calls into generic code.
- */
-static noinline int btrfs_copy_from_user(loff_t pos, size_t write_bytes,
-					 struct page **prepared_pages,
-					 struct iov_iter *i)
-{
-	size_t copied = 0;
-	size_t total_copied = 0;
-	int pg = 0;
-	int offset = offset_in_page(pos);
-
-	while (write_bytes > 0) {
-		size_t count = min_t(size_t,
-				     PAGE_SIZE - offset, write_bytes);
-		struct page *page = prepared_pages[pg];
-		/*
-		 * Copy data from userspace to the current page
-		 */
-		copied = iov_iter_copy_from_user_atomic(page, i, offset, count);
-
-		/* Flush processor's dcache for this page */
-		flush_dcache_page(page);
-
-		/*
-		 * if we get a partial write, we can end up with
-		 * partially up to date pages.  These add
-		 * a lot of complexity, so make sure they don't
-		 * happen by forcing this copy to be retried.
-		 *
-		 * The rest of the btrfs_file_write code will fall
-		 * back to page at a time copies after we return 0.
-		 */
-		if (!PageUptodate(page) && copied < count)
-			copied = 0;
-
-		iov_iter_advance(i, copied);
-		write_bytes -= copied;
-		total_copied += copied;
-
-		/* Return to btrfs_file_write_iter to fault page */
-		if (unlikely(copied == 0))
-			break;
-
-		if (copied < PAGE_SIZE - offset) {
-			offset += copied;
-		} else {
-			pg++;
-			offset = 0;
-		}
-	}
-	return total_copied;
-}
-
-/*
- * unlocks pages after btrfs_file_write is done with them
- */
-static void btrfs_drop_pages(struct page **pages, size_t num_pages)
-{
-	size_t i;
-	for (i = 0; i < num_pages; i++) {
-		/* page checked is some magic around finding pages that
-		 * have been modified without going through btrfs_set_page_dirty
-		 * clear it here. There should be no need to mark the pages
-		 * accessed as prepare_pages should have marked them accessed
-		 * in prepare_pages via find_or_create_page()
-		 */
-		ClearPageChecked(pages[i]);
-		unlock_page(pages[i]);
-		put_page(pages[i]);
-	}
-}
-
 static int btrfs_find_new_delalloc_bytes(struct btrfs_inode *inode,
 					 const u64 start,
 					 const u64 len,
@@ -1386,165 +1313,6 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
-/*
- * on error we return an unlocked page and the error value
- * on success we return a locked page and 0
- */
-static int prepare_uptodate_page(struct inode *inode,
-				 struct page *page, u64 pos,
-				 bool force_uptodate)
-{
-	int ret = 0;
-
-	if (((pos & (PAGE_SIZE - 1)) || force_uptodate) &&
-	    !PageUptodate(page)) {
-		ret = btrfs_readpage(NULL, page);
-		if (ret)
-			return ret;
-		lock_page(page);
-		if (!PageUptodate(page)) {
-			unlock_page(page);
-			return -EIO;
-		}
-		if (page->mapping != inode->i_mapping) {
-			unlock_page(page);
-			return -EAGAIN;
-		}
-	}
-	return 0;
-}
-
-/*
- * this just gets pages into the page cache and locks them down.
- */
-static noinline int prepare_pages(struct inode *inode, struct page **pages,
-				  size_t num_pages, loff_t pos,
-				  size_t write_bytes, bool force_uptodate)
-{
-	int i;
-	unsigned long index = pos >> PAGE_SHIFT;
-	gfp_t mask = btrfs_alloc_write_mask(inode->i_mapping);
-	int err = 0;
-	int faili;
-
-	for (i = 0; i < num_pages; i++) {
-again:
-		pages[i] = find_or_create_page(inode->i_mapping, index + i,
-					       mask | __GFP_WRITE);
-		if (!pages[i]) {
-			faili = i - 1;
-			err = -ENOMEM;
-			goto fail;
-		}
-
-		if (i == 0)
-			err = prepare_uptodate_page(inode, pages[i], pos,
-						    force_uptodate);
-		if (!err && i == num_pages - 1)
-			err = prepare_uptodate_page(inode, pages[i],
-						    pos + write_bytes, false);
-		if (err) {
-			put_page(pages[i]);
-			if (err == -EAGAIN) {
-				err = 0;
-				goto again;
-			}
-			faili = i - 1;
-			goto fail;
-		}
-		wait_on_page_writeback(pages[i]);
-	}
-
-	return 0;
-fail:
-	while (faili >= 0) {
-		unlock_page(pages[faili]);
-		put_page(pages[faili]);
-		faili--;
-	}
-	return err;
-
-}
-
-/*
- * This function locks the extent and properly waits for data=ordered extents
- * to finish before allowing the pages to be modified if need.
- *
- * The return value:
- * 1 - the extent is locked
- * 0 - the extent is not locked, and everything is OK
- * -EAGAIN - need re-prepare the pages
- * the other < 0 number - Something wrong happens
- */
-static noinline int
-lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
-				size_t num_pages, loff_t pos,
-				size_t write_bytes,
-				u64 *lockstart, u64 *lockend,
-				struct extent_state **cached_state)
-{
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	u64 start_pos;
-	u64 last_pos;
-	int i;
-	int ret = 0;
-
-	start_pos = round_down(pos, fs_info->sectorsize);
-	last_pos = start_pos
-		+ round_up(pos + write_bytes - start_pos,
-			   fs_info->sectorsize) - 1;
-
-	if (start_pos < inode->vfs_inode.i_size) {
-		struct btrfs_ordered_extent *ordered;
-
-		lock_extent_bits(&inode->io_tree, start_pos, last_pos,
-				cached_state);
-		ordered = btrfs_lookup_ordered_range(inode, start_pos,
-						     last_pos - start_pos + 1);
-		if (ordered &&
-		    ordered->file_offset + ordered->len > start_pos &&
-		    ordered->file_offset <= last_pos) {
-			unlock_extent_cached(&inode->io_tree, start_pos,
-					last_pos, cached_state);
-			for (i = 0; i < num_pages; i++) {
-				unlock_page(pages[i]);
-				put_page(pages[i]);
-			}
-			btrfs_start_ordered_extent(&inode->vfs_inode,
-					ordered, 1);
-			btrfs_put_ordered_extent(ordered);
-			return -EAGAIN;
-		}
-		if (ordered)
-			btrfs_put_ordered_extent(ordered);
-
-		*lockstart = start_pos;
-		*lockend = last_pos;
-		ret = 1;
-	}
-
-	/*
-	 * It's possible the pages are dirty right now, but we don't want
-	 * to clean them yet because copy_from_user may catch a page fault
-	 * and we might have to fall back to one page at a time.  If that
-	 * happens, we'll unlock these pages and we'd have a window where
-	 * reclaim could sneak in and drop the once-dirty page on the floor
-	 * without writing it.
-	 *
-	 * We have the pages locked and the extent range locked, so there's
-	 * no way someone can start IO on any dirty pages in this range.
-	 *
-	 * We'll call btrfs_dirty_pages() later on, and that will flip around
-	 * delalloc bits and dirty the pages as required.
-	 */
-	for (i = 0; i < num_pages; i++) {
-		set_page_extent_mapped(pages[i]);
-		WARN_ON(!PageLocked(pages[i]));
-	}
-
-	return ret;
-}
-
 static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
 				    size_t *write_bytes)
 {
@@ -1591,238 +1359,6 @@ static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
 	return ret;
 }
 
-static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
-					       struct iov_iter *i)
-{
-	struct file *file = iocb->ki_filp;
-	loff_t pos = iocb->ki_pos;
-	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_root *root = BTRFS_I(inode)->root;
-	struct page **pages = NULL;
-	struct extent_state *cached_state = NULL;
-	struct extent_changeset *data_reserved = NULL;
-	u64 release_bytes = 0;
-	u64 lockstart;
-	u64 lockend;
-	size_t num_written = 0;
-	int nrptrs;
-	int ret = 0;
-	bool only_release_metadata = false;
-	bool force_page_uptodate = false;
-
-	nrptrs = min(DIV_ROUND_UP(iov_iter_count(i), PAGE_SIZE),
-			PAGE_SIZE / (sizeof(struct page *)));
-	nrptrs = min(nrptrs, current->nr_dirtied_pause - current->nr_dirtied);
-	nrptrs = max(nrptrs, 8);
-	pages = kmalloc_array(nrptrs, sizeof(struct page *), GFP_KERNEL);
-	if (!pages)
-		return -ENOMEM;
-
-	while (iov_iter_count(i) > 0) {
-		size_t offset = offset_in_page(pos);
-		size_t sector_offset;
-		size_t write_bytes = min(iov_iter_count(i),
-					 nrptrs * (size_t)PAGE_SIZE -
-					 offset);
-		size_t num_pages = DIV_ROUND_UP(write_bytes + offset,
-						PAGE_SIZE);
-		size_t reserve_bytes;
-		size_t dirty_pages;
-		size_t copied;
-		size_t dirty_sectors;
-		size_t num_sectors;
-		int extents_locked;
-
-		WARN_ON(num_pages > nrptrs);
-
-		/*
-		 * Fault pages before locking them in prepare_pages
-		 * to avoid recursive lock
-		 */
-		if (unlikely(iov_iter_fault_in_readable(i, write_bytes))) {
-			ret = -EFAULT;
-			break;
-		}
-
-		sector_offset = pos & (fs_info->sectorsize - 1);
-		reserve_bytes = round_up(write_bytes + sector_offset,
-				fs_info->sectorsize);
-
-		extent_changeset_release(data_reserved);
-		ret = btrfs_check_data_free_space(inode, &data_reserved, pos,
-						  write_bytes);
-		if (ret < 0) {
-			if ((BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
-						      BTRFS_INODE_PREALLOC)) &&
-			    check_can_nocow(BTRFS_I(inode), pos,
-					&write_bytes) > 0) {
-				/*
-				 * For nodata cow case, no need to reserve
-				 * data space.
-				 */
-				only_release_metadata = true;
-				/*
-				 * our prealloc extent may be smaller than
-				 * write_bytes, so scale down.
-				 */
-				num_pages = DIV_ROUND_UP(write_bytes + offset,
-							 PAGE_SIZE);
-				reserve_bytes = round_up(write_bytes +
-							 sector_offset,
-							 fs_info->sectorsize);
-			} else {
-				break;
-			}
-		}
-
-		WARN_ON(reserve_bytes == 0);
-		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
-				reserve_bytes);
-		if (ret) {
-			if (!only_release_metadata)
-				btrfs_free_reserved_data_space(inode,
-						data_reserved, pos,
-						write_bytes);
-			else
-				btrfs_end_write_no_snapshotting(root);
-			break;
-		}
-
-		release_bytes = reserve_bytes;
-again:
-		/*
-		 * This is going to setup the pages array with the number of
-		 * pages we want, so we don't really need to worry about the
-		 * contents of pages from loop to loop
-		 */
-		ret = prepare_pages(inode, pages, num_pages,
-				    pos, write_bytes,
-				    force_page_uptodate);
-		if (ret) {
-			btrfs_delalloc_release_extents(BTRFS_I(inode),
-						       reserve_bytes, true);
-			break;
-		}
-
-		extents_locked = lock_and_cleanup_extent_if_need(
-				BTRFS_I(inode), pages,
-				num_pages, pos, write_bytes, &lockstart,
-				&lockend, &cached_state);
-		if (extents_locked < 0) {
-			if (extents_locked == -EAGAIN)
-				goto again;
-			btrfs_delalloc_release_extents(BTRFS_I(inode),
-						       reserve_bytes, true);
-			ret = extents_locked;
-			break;
-		}
-
-		copied = btrfs_copy_from_user(pos, write_bytes, pages, i);
-
-		num_sectors = BTRFS_BYTES_TO_BLKS(fs_info, reserve_bytes);
-		dirty_sectors = round_up(copied + sector_offset,
-					fs_info->sectorsize);
-		dirty_sectors = BTRFS_BYTES_TO_BLKS(fs_info, dirty_sectors);
-
-		/*
-		 * if we have trouble faulting in the pages, fall
-		 * back to one page at a time
-		 */
-		if (copied < write_bytes)
-			nrptrs = 1;
-
-		if (copied == 0) {
-			force_page_uptodate = true;
-			dirty_sectors = 0;
-			dirty_pages = 0;
-		} else {
-			force_page_uptodate = false;
-			dirty_pages = DIV_ROUND_UP(copied + offset,
-						   PAGE_SIZE);
-		}
-
-		if (num_sectors > dirty_sectors) {
-			/* release everything except the sectors we dirtied */
-			release_bytes -= dirty_sectors <<
-						fs_info->sb->s_blocksize_bits;
-			if (only_release_metadata) {
-				btrfs_delalloc_release_metadata(BTRFS_I(inode),
-							release_bytes, true);
-			} else {
-				u64 __pos;
-
-				__pos = round_down(pos,
-						   fs_info->sectorsize) +
-					(dirty_pages << PAGE_SHIFT);
-				btrfs_delalloc_release_space(inode,
-						data_reserved, __pos,
-						release_bytes, true);
-			}
-		}
-
-		release_bytes = round_up(copied + sector_offset,
-					fs_info->sectorsize);
-
-		if (copied > 0)
-			ret = btrfs_dirty_pages(inode, pages, dirty_pages,
-						pos, copied, &cached_state);
-		if (extents_locked)
-			unlock_extent_cached(&BTRFS_I(inode)->io_tree,
-					     lockstart, lockend, &cached_state);
-		btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes,
-					       true);
-		if (ret) {
-			btrfs_drop_pages(pages, num_pages);
-			break;
-		}
-
-		release_bytes = 0;
-		if (only_release_metadata)
-			btrfs_end_write_no_snapshotting(root);
-
-		if (only_release_metadata && copied > 0) {
-			lockstart = round_down(pos,
-					       fs_info->sectorsize);
-			lockend = round_up(pos + copied,
-					   fs_info->sectorsize) - 1;
-
-			set_extent_bit(&BTRFS_I(inode)->io_tree, lockstart,
-				       lockend, EXTENT_NORESERVE, NULL,
-				       NULL, GFP_NOFS);
-			only_release_metadata = false;
-		}
-
-		btrfs_drop_pages(pages, num_pages);
-
-		cond_resched();
-
-		balance_dirty_pages_ratelimited(inode->i_mapping);
-		if (dirty_pages < (fs_info->nodesize >> PAGE_SHIFT) + 1)
-			btrfs_btree_balance_dirty(fs_info);
-
-		pos += copied;
-		num_written += copied;
-	}
-
-	kfree(pages);
-
-	if (release_bytes) {
-		if (only_release_metadata) {
-			btrfs_end_write_no_snapshotting(root);
-			btrfs_delalloc_release_metadata(BTRFS_I(inode),
-					release_bytes, true);
-		} else {
-			btrfs_delalloc_release_space(inode, data_reserved,
-					round_down(pos, fs_info->sectorsize),
-					release_bytes, true);
-		}
-	}
-
-	extent_changeset_free(data_reserved);
-	return num_written ? num_written : ret;
-}
-
 static ssize_t __btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
-- 
2.16.4

