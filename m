Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032A72D0B03
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 08:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgLGHOp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 02:14:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:57988 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgLGHOp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 02:14:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607325237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=E0HKrc4R9p/q58WV0Xezh33wcRd1QTdG1A8+DCCdLPQ=;
        b=Rrgw9RLuB9j8vxSSoHPqwUFnZwmpdhb4qvLuEk1zmiuW4Bx9JWqitynkzMoJcwyEseFxS2
        vkl6xAuUMZFO45aXZuYBNy70wZ83gNp5p/p9X+Ho7cM3JndVPs8K7/Jc0HI3SmPCz+5mn5
        io2Fwz9TK43U2tZo5P1GVE/83VJpTvk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9A2C5AC2E;
        Mon,  7 Dec 2020 07:13:57 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC] btrfs: remove cow fixup related code
Date:   Mon,  7 Dec 2020 15:13:52 +0800
Message-Id: <20201207071352.106160-1-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From the initial merge of btrfs, there is always the mystery cow fixup.

According to its comment and code, the functionality is to detect MM
code which dirtied the page when it has been unlocked and under
writeback.

But there are several problems:
- The fixup timing can be in next transaction
  That means, even if such case really happens, the "corrupted" data
  will be written to disk, and fixup can be queued for next transaction.

  Thus it doesn't really solve anything, but masking the "problem"

- No cow fixup really get executed
  At least I didn't find it in my test environment.
  I know this doesn't mean anything, but see my next comment.

- All page dirty path have already waited writeback
  For existing btrfs page dirty path, we always wait page writeback
  before populating the page.
  I don't see why MM/VFS layer can't do it.

- munmap is not dirtying related page
  A quick glance into mmap code doesn't show anywhere we dirty the
  pages.

Since I'm not familiar with ancient btrfs code, nor the MM layer, this
patch is mostly RFC and hopes the community can either give a sold
answer on why cow fixup is still needed, or can use this patch as the
first step to remove cow fixup.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c      |   7 --
 fs/btrfs/ctree.h            |   8 --
 fs/btrfs/disk-io.c          |   7 +-
 fs/btrfs/extent_io.c        |  12 ---
 fs/btrfs/extent_io.h        |   5 +-
 fs/btrfs/file.c             |   8 --
 fs/btrfs/free-space-cache.c |   1 -
 fs/btrfs/inode.c            | 192 +-----------------------------------
 fs/btrfs/ioctl.c            |   1 -
 fs/btrfs/reflink.c          |   1 -
 10 files changed, 4 insertions(+), 238 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 12d50f1cdc58..bdb2351d7cba 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -246,14 +246,7 @@ static void end_compressed_bio_read(struct bio *bio)
 		struct bio_vec *bvec;
 		struct bvec_iter_all iter_all;
 
-		/*
-		 * we have verified the checksum already, set page
-		 * checked so the end_io handlers know about it
-		 */
 		ASSERT(!bio_flagged(bio, BIO_CLONED));
-		bio_for_each_segment_all(bvec, cb->orig_bio, iter_all)
-			SetPageChecked(bvec->bv_page);
-
 		bio_endio(cb->orig_bio);
 	}
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 2744e13e8eb9..93434e964520 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -772,13 +772,6 @@ struct btrfs_fs_info {
 	struct btrfs_workqueue *endio_freespace_worker;
 	struct btrfs_workqueue *caching_workers;
 	struct btrfs_workqueue *readahead_workers;
-
-	/*
-	 * fixup workers take dirty pages that didn't properly go through
-	 * the cow mechanism and make them safe to write.  It happens
-	 * for the sys_munmap function call path
-	 */
-	struct btrfs_workqueue *fixup_workers;
 	struct btrfs_workqueue *delayed_workers;
 
 	struct task_struct *transaction_kthread;
@@ -3136,7 +3129,6 @@ int btrfs_prealloc_file_range_trans(struct inode *inode,
 int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page,
 		u64 start, u64 end, int *page_started, unsigned long *nr_written,
 		struct writeback_control *wbc);
-int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
 void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
 					  u64 end, int uptodate);
 extern const struct dentry_operations btrfs_dentry_operations;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 46dd9e0b077e..74ffad7b6c11 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1958,7 +1958,6 @@ static int read_backup_root(struct btrfs_fs_info *fs_info, u8 priority)
 /* helper to cleanup workers */
 static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
 {
-	btrfs_destroy_workqueue(fs_info->fixup_workers);
 	btrfs_destroy_workqueue(fs_info->delalloc_workers);
 	btrfs_destroy_workqueue(fs_info->workers);
 	btrfs_destroy_workqueue(fs_info->endio_workers);
@@ -2144,9 +2143,6 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info,
 	fs_info->caching_workers =
 		btrfs_alloc_workqueue(fs_info, "cache", flags, max_active, 0);
 
-	fs_info->fixup_workers =
-		btrfs_alloc_workqueue(fs_info, "fixup", flags, 1, 0);
-
 	/*
 	 * endios are largely parallel and should have a very
 	 * low idle thresh
@@ -2188,8 +2184,7 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info,
 	      fs_info->endio_write_workers && fs_info->endio_raid56_workers &&
 	      fs_info->endio_freespace_worker && fs_info->rmw_workers &&
 	      fs_info->caching_workers && fs_info->readahead_workers &&
-	      fs_info->fixup_workers && fs_info->delayed_workers &&
-	      fs_info->qgroup_rescan_workers &&
+	      fs_info->delayed_workers && fs_info->qgroup_rescan_workers &&
 	      fs_info->discard_ctl.discard_workers)) {
 		return -ENOMEM;
 	}
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 569d50ccf78a..e899335ec2f9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1969,9 +1969,6 @@ static int __process_pages_contig(struct address_space *mapping,
 		}
 
 		for (i = 0; i < ret; i++) {
-			if (page_ops & PAGE_SET_PRIVATE2)
-				SetPagePrivate2(pages[i]);
-
 			if (locked_page && pages[i] == locked_page) {
 				put_page(pages[i]);
 				pages_processed++;
@@ -3523,15 +3520,6 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	const unsigned int write_flags = wbc_to_write_flags(wbc);
 	bool compressed;
 
-	ret = btrfs_writepage_cow_fixup(page, start, page_end);
-	if (ret) {
-		/* Fixup worker will requeue */
-		redirty_page_for_writepage(wbc, page);
-		update_nr_written(wbc, nr_written);
-		unlock_page(page);
-		return 1;
-	}
-
 	/*
 	 * we don't want to touch the inode after unlocking the page,
 	 * so we update the mapping writeback index now
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 66762c3cdf81..79e13380e6fd 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -37,9 +37,8 @@ enum {
 #define PAGE_CLEAR_DIRTY	(1 << 1)
 #define PAGE_SET_WRITEBACK	(1 << 2)
 #define PAGE_END_WRITEBACK	(1 << 3)
-#define PAGE_SET_PRIVATE2	(1 << 4)
-#define PAGE_SET_ERROR		(1 << 5)
-#define PAGE_LOCK		(1 << 6)
+#define PAGE_SET_ERROR		(1 << 4)
+#define PAGE_LOCK		(1 << 5)
 
 /*
  * page->private values.  Every page that is controlled by the extent
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0e41459b8de6..9816bf1b7f5b 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -440,13 +440,6 @@ static void btrfs_drop_pages(struct page **pages, size_t num_pages)
 {
 	size_t i;
 	for (i = 0; i < num_pages; i++) {
-		/* page checked is some magic around finding pages that
-		 * have been modified without going through btrfs_set_page_dirty
-		 * clear it here. There should be no need to mark the pages
-		 * accessed as prepare_pages should have marked them accessed
-		 * in prepare_pages via find_or_create_page()
-		 */
-		ClearPageChecked(pages[i]);
 		unlock_page(pages[i]);
 		put_page(pages[i]);
 	}
@@ -502,7 +495,6 @@ int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
 	for (i = 0; i < num_pages; i++) {
 		struct page *p = pages[i];
 		SetPageUptodate(p);
-		ClearPageChecked(p);
 		set_page_dirty(p);
 	}
 
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index cd5996350cf0..9ec089791360 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -424,7 +424,6 @@ static void io_ctl_drop_pages(struct btrfs_io_ctl *io_ctl)
 
 	for (i = 0; i < io_ctl->num_pages; i++) {
 		if (io_ctl->pages[i]) {
-			ClearPageChecked(io_ctl->pages[i]);
 			unlock_page(io_ctl->pages[i]);
 			put_page(io_ctl->pages[i]);
 		}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0ce42d52d53e..aae9d4bcc25a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1161,7 +1161,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		 * setup for writepage
 		 */
 		page_ops = unlock ? PAGE_UNLOCK : 0;
-		page_ops |= PAGE_SET_PRIVATE2;
 
 		extent_clear_unlock_delalloc(inode, start, start + ram_size - 1,
 					     locked_page,
@@ -1806,7 +1805,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 					     locked_page, EXTENT_LOCKED |
 					     EXTENT_DELALLOC |
 					     EXTENT_CLEAR_DATA_RESV,
-					     PAGE_UNLOCK | PAGE_SET_PRIVATE2);
+					     PAGE_UNLOCK);
 
 		cur_offset = extent_end;
 
@@ -2392,187 +2391,6 @@ struct btrfs_writepage_fixup {
 	struct btrfs_work work;
 };
 
-static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
-{
-	struct btrfs_writepage_fixup *fixup;
-	struct btrfs_ordered_extent *ordered;
-	struct extent_state *cached_state = NULL;
-	struct extent_changeset *data_reserved = NULL;
-	struct page *page;
-	struct btrfs_inode *inode;
-	u64 page_start;
-	u64 page_end;
-	int ret = 0;
-	bool free_delalloc_space = true;
-
-	fixup = container_of(work, struct btrfs_writepage_fixup, work);
-	page = fixup->page;
-	inode = BTRFS_I(fixup->inode);
-	page_start = page_offset(page);
-	page_end = page_offset(page) + PAGE_SIZE - 1;
-
-	/*
-	 * This is similar to page_mkwrite, we need to reserve the space before
-	 * we take the page lock.
-	 */
-	ret = btrfs_delalloc_reserve_space(inode, &data_reserved, page_start,
-					   PAGE_SIZE);
-again:
-	lock_page(page);
-
-	/*
-	 * Before we queued this fixup, we took a reference on the page.
-	 * page->mapping may go NULL, but it shouldn't be moved to a different
-	 * address space.
-	 */
-	if (!page->mapping || !PageDirty(page) || !PageChecked(page)) {
-		/*
-		 * Unfortunately this is a little tricky, either
-		 *
-		 * 1) We got here and our page had already been dealt with and
-		 *    we reserved our space, thus ret == 0, so we need to just
-		 *    drop our space reservation and bail.  This can happen the
-		 *    first time we come into the fixup worker, or could happen
-		 *    while waiting for the ordered extent.
-		 * 2) Our page was already dealt with, but we happened to get an
-		 *    ENOSPC above from the btrfs_delalloc_reserve_space.  In
-		 *    this case we obviously don't have anything to release, but
-		 *    because the page was already dealt with we don't want to
-		 *    mark the page with an error, so make sure we're resetting
-		 *    ret to 0.  This is why we have this check _before_ the ret
-		 *    check, because we do not want to have a surprise ENOSPC
-		 *    when the page was already properly dealt with.
-		 */
-		if (!ret) {
-			btrfs_delalloc_release_extents(inode, PAGE_SIZE);
-			btrfs_delalloc_release_space(inode, data_reserved,
-						     page_start, PAGE_SIZE,
-						     true);
-		}
-		ret = 0;
-		goto out_page;
-	}
-
-	/*
-	 * We can't mess with the page state unless it is locked, so now that
-	 * it is locked bail if we failed to make our space reservation.
-	 */
-	if (ret)
-		goto out_page;
-
-	lock_extent_bits(&inode->io_tree, page_start, page_end, &cached_state);
-
-	/* already ordered? We're done */
-	if (PagePrivate2(page))
-		goto out_reserved;
-
-	ordered = btrfs_lookup_ordered_range(inode, page_start, PAGE_SIZE);
-	if (ordered) {
-		unlock_extent_cached(&inode->io_tree, page_start, page_end,
-				     &cached_state);
-		unlock_page(page);
-		btrfs_start_ordered_extent(ordered, 1);
-		btrfs_put_ordered_extent(ordered);
-		goto again;
-	}
-
-	ret = btrfs_set_extent_delalloc(inode, page_start, page_end, 0,
-					&cached_state);
-	if (ret)
-		goto out_reserved;
-
-	/*
-	 * Everything went as planned, we're now the owner of a dirty page with
-	 * delayed allocation bits set and space reserved for our COW
-	 * destination.
-	 *
-	 * The page was dirty when we started, nothing should have cleaned it.
-	 */
-	BUG_ON(!PageDirty(page));
-	free_delalloc_space = false;
-out_reserved:
-	btrfs_delalloc_release_extents(inode, PAGE_SIZE);
-	if (free_delalloc_space)
-		btrfs_delalloc_release_space(inode, data_reserved, page_start,
-					     PAGE_SIZE, true);
-	unlock_extent_cached(&inode->io_tree, page_start, page_end,
-			     &cached_state);
-out_page:
-	if (ret) {
-		/*
-		 * We hit ENOSPC or other errors.  Update the mapping and page
-		 * to reflect the errors and clean the page.
-		 */
-		mapping_set_error(page->mapping, ret);
-		end_extent_writepage(page, ret, page_start, page_end);
-		clear_page_dirty_for_io(page);
-		SetPageError(page);
-	}
-	ClearPageChecked(page);
-	unlock_page(page);
-	put_page(page);
-	kfree(fixup);
-	extent_changeset_free(data_reserved);
-	/*
-	 * As a precaution, do a delayed iput in case it would be the last iput
-	 * that could need flushing space. Recursing back to fixup worker would
-	 * deadlock.
-	 */
-	btrfs_add_delayed_iput(&inode->vfs_inode);
-}
-
-/*
- * There are a few paths in the higher layers of the kernel that directly
- * set the page dirty bit without asking the filesystem if it is a
- * good idea.  This causes problems because we want to make sure COW
- * properly happens and the data=ordered rules are followed.
- *
- * In our case any range that doesn't have the ORDERED bit set
- * hasn't been properly setup for IO.  We kick off an async process
- * to fix it up.  The async helper will wait for ordered extents, set
- * the delalloc bit and make it safe to write the page.
- */
-int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end)
-{
-	struct inode *inode = page->mapping->host;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_writepage_fixup *fixup;
-
-	/* this page is properly in the ordered list */
-	if (TestClearPagePrivate2(page))
-		return 0;
-
-	/*
-	 * PageChecked is set below when we create a fixup worker for this page,
-	 * don't try to create another one if we're already PageChecked()
-	 *
-	 * The extent_io writepage code will redirty the page if we send back
-	 * EAGAIN.
-	 */
-	if (PageChecked(page))
-		return -EAGAIN;
-
-	fixup = kzalloc(sizeof(*fixup), GFP_NOFS);
-	if (!fixup)
-		return -EAGAIN;
-
-	/*
-	 * We are already holding a reference to this inode from
-	 * write_cache_pages.  We need to hold it because the space reservation
-	 * takes place outside of the page lock, and we can't trust
-	 * page->mapping outside of the page lock.
-	 */
-	ihold(inode);
-	SetPageChecked(page);
-	get_page(page);
-	btrfs_init_work(&fixup->work, btrfs_writepage_fixup_worker, NULL, NULL);
-	fixup->page = page;
-	fixup->inode = inode;
-	btrfs_queue_work(fs_info->fixup_workers, &fixup->work);
-
-	return -EAGAIN;
-}
-
 static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 				       struct btrfs_inode *inode, u64 file_pos,
 				       struct btrfs_file_extent_item *stack_fi,
@@ -3000,11 +2818,6 @@ int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u64 phy_offset,
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 
-	if (PageChecked(page)) {
-		ClearPageChecked(page);
-		return 0;
-	}
-
 	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
 		return 0;
 
@@ -4757,7 +4570,6 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 		flush_dcache_page(page);
 		kunmap(page);
 	}
-	ClearPageChecked(page);
 	set_page_dirty(page);
 	unlock_extent_cached(io_tree, block_start, block_end, &cached_state);
 
@@ -8256,7 +8068,6 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 		__btrfs_releasepage(page, GFP_NOFS);
 	}
 
-	ClearPageChecked(page);
 	detach_page_private(page);
 }
 
@@ -8396,7 +8207,6 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 		flush_dcache_page(page);
 		kunmap(page);
 	}
-	ClearPageChecked(page);
 	set_page_dirty(page);
 	SetPageUptodate(page);
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 703212ff50a5..d2636e5756ad 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1439,7 +1439,6 @@ static int cluster_pages_for_defrag(struct inode *inode,
 
 	for (i = 0; i < i_done; i++) {
 		clear_page_dirty_for_io(pages[i]);
-		ClearPageChecked(pages[i]);
 		set_page_extent_mapped(pages[i]);
 		set_page_dirty(pages[i]);
 		unlock_page(pages[i]);
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index ab80896315be..57e1f8cd0d4d 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -126,7 +126,6 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
 	}
 
 	SetPageUptodate(page);
-	ClearPageChecked(page);
 	set_page_dirty(page);
 out_unlock:
 	if (page) {
-- 
2.29.2

