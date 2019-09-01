Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C404EA4B8F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2019 22:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbfIAUI6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Sep 2019 16:08:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:50420 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728888AbfIAUI4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Sep 2019 16:08:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DE6C9AE3F;
        Sun,  1 Sep 2019 20:08:54 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, darrick.wong@oracle.com, hch@lst.de,
        david@fromorbit.com, riteshh@linux.ibm.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 04/15] btrfs: Eliminate PagePrivate for btrfs data pages
Date:   Sun,  1 Sep 2019 15:08:25 -0500
Message-Id: <20190901200836.14959-5-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190901200836.14959-1-rgoldwyn@suse.de>
References: <20190901200836.14959-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

While most of the code works just eliminating page's private
field and related code, there is a problem when we are cloning.
The extent assumes the data is uptodate. Clear the EXTENT_UPTODATE
flag for the extent so the next time the file is read, it is
forced to be read from the disk as opposed to pagecache.

This patch is required to make sure we don't conflict with iomap's
usage of page->private.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/compression.c      |  1 -
 fs/btrfs/extent_io.c        | 13 -------------
 fs/btrfs/extent_io.h        |  2 --
 fs/btrfs/file.c             |  1 -
 fs/btrfs/free-space-cache.c |  1 -
 fs/btrfs/inode.c            | 15 +--------------
 fs/btrfs/ioctl.c            |  4 ++--
 fs/btrfs/relocation.c       |  2 --
 8 files changed, 3 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 60c47b417a4b..fe41fa3d2999 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -481,7 +481,6 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		 * for these bytes in the file.  But, we have to make
 		 * sure they map to this compressed extent on disk.
 		 */
-		set_page_extent_mapped(page);
 		lock_extent(tree, last_offset, end);
 		read_lock(&em_tree->lock);
 		em = lookup_extent_mapping(em_tree, last_offset,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1ff438fd5bc2..27233fb6660c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3005,15 +3005,6 @@ static void attach_extent_buffer_page(struct extent_buffer *eb,
 	}
 }
 
-void set_page_extent_mapped(struct page *page)
-{
-	if (!PagePrivate(page)) {
-		SetPagePrivate(page);
-		get_page(page);
-		set_page_private(page, EXTENT_PAGE_PRIVATE);
-	}
-}
-
 static struct extent_map *
 __get_extent_map(struct inode *inode, struct page *page, size_t pg_offset,
 		 u64 start, u64 len, get_extent_t *get_extent,
@@ -3074,8 +3065,6 @@ static int __do_readpage(struct extent_io_tree *tree,
 	size_t blocksize = inode->i_sb->s_blocksize;
 	unsigned long this_bio_flag = 0;
 
-	set_page_extent_mapped(page);
-
 	if (!PageUptodate(page)) {
 		if (cleancache_get_page(page) == 0) {
 			BUG_ON(blocksize != PAGE_SIZE);
@@ -3589,8 +3578,6 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 
 	pg_offset = 0;
 
-	set_page_extent_mapped(page);
-
 	if (!epd->extent_locked) {
 		ret = writepage_delalloc(inode, page, wbc, start, &nr_written);
 		if (ret == 1)
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 401423b16976..8082774371b5 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -416,8 +416,6 @@ int extent_readpages(struct address_space *mapping, struct list_head *pages,
 		     unsigned nr_pages);
 int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		__u64 start, __u64 len);
-void set_page_extent_mapped(struct page *page);
-
 struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 					  u64 start);
 struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 58a18ed11546..4466a09f2d98 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1539,7 +1539,6 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 	 * delalloc bits and dirty the pages as required.
 	 */
 	for (i = 0; i < num_pages; i++) {
-		set_page_extent_mapped(pages[i]);
 		WARN_ON(!PageLocked(pages[i]));
 	}
 
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 062be9dde4c6..9a0c519bd6d4 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -395,7 +395,6 @@ static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, struct inode *inode
 
 	for (i = 0; i < io_ctl->num_pages; i++) {
 		clear_page_dirty_for_io(io_ctl->pages[i]);
-		set_page_extent_mapped(io_ctl->pages[i]);
 	}
 
 	return 0;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ee582a36653d..258bacefdf5f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4932,7 +4932,6 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
 	wait_on_page_writeback(page);
 
 	lock_extent_bits(io_tree, block_start, block_end, &cached_state);
-	set_page_extent_mapped(page);
 
 	ordered = btrfs_lookup_ordered_extent(inode, block_start);
 	if (ordered) {
@@ -8754,13 +8753,7 @@ btrfs_readpages(struct file *file, struct address_space *mapping,
 
 static int __btrfs_releasepage(struct page *page, gfp_t gfp_flags)
 {
-	int ret = try_release_extent_mapping(page, gfp_flags);
-	if (ret == 1) {
-		ClearPagePrivate(page);
-		set_page_private(page, 0);
-		put_page(page);
-	}
-	return ret;
+	return try_release_extent_mapping(page, gfp_flags);
 }
 
 static int btrfs_releasepage(struct page *page, gfp_t gfp_flags)
@@ -8878,11 +8871,6 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 	}
 
 	ClearPageChecked(page);
-	if (PagePrivate(page)) {
-		ClearPagePrivate(page);
-		set_page_private(page, 0);
-		put_page(page);
-	}
 }
 
 /*
@@ -8961,7 +8949,6 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	wait_on_page_writeback(page);
 
 	lock_extent_bits(io_tree, page_start, page_end, &cached_state);
-	set_page_extent_mapped(page);
 
 	/*
 	 * we can't set the delalloc bits if there are pending ordered
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 818f7ec8bb0e..861617e3d0c9 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1355,7 +1355,6 @@ static int cluster_pages_for_defrag(struct inode *inode,
 	for (i = 0; i < i_done; i++) {
 		clear_page_dirty_for_io(pages[i]);
 		ClearPageChecked(pages[i]);
-		set_page_extent_mapped(pages[i]);
 		set_page_dirty(pages[i]);
 		unlock_page(pages[i]);
 		put_page(pages[i]);
@@ -3550,6 +3549,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 	int ret;
 	const u64 len = olen_aligned;
 	u64 last_dest_end = destoff;
+	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 
 	ret = -ENOMEM;
 	buf = kvmalloc(fs_info->nodesize, GFP_KERNEL);
@@ -3864,6 +3864,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 						destoff, olen, no_time_update);
 	}
 
+	clear_extent_uptodate(tree, destoff, destoff+olen, NULL);
 out:
 	btrfs_free_path(path);
 	kvfree(buf);
@@ -3935,7 +3936,6 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 	truncate_inode_pages_range(&inode->i_data,
 				round_down(destoff, PAGE_SIZE),
 				round_up(destoff + len, PAGE_SIZE) - 1);
-
 	return ret;
 }
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 7f219851fa23..612988b7eb27 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3300,8 +3300,6 @@ static int relocate_file_extent_cluster(struct inode *inode,
 
 		lock_extent(&BTRFS_I(inode)->io_tree, page_start, page_end);
 
-		set_page_extent_mapped(page);
-
 		if (nr < cluster->nr &&
 		    page_start + offset == cluster->boundary[nr]) {
 			set_extent_bits(&BTRFS_I(inode)->io_tree,
-- 
2.16.4

