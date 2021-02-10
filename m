Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA370315F66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 07:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhBJGYR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 01:24:17 -0500
Received: from mga03.intel.com ([134.134.136.65]:39560 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231712AbhBJGYD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 01:24:03 -0500
IronPort-SDR: SsRD2rL6yUjl4dURbydi7X+IIhHAmuOIqLbKQOSL4haL+mABoVMaA+deIDvv7sgJBnPh+mIM83
 AKcSFzbs+oUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="182086734"
X-IronPort-AV: E=Sophos;i="5.81,167,1610438400"; 
   d="scan'208";a="182086734"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 22:22:38 -0800
IronPort-SDR: GX8zmzpuS6I71OEeDF0tby/133cA8k9DRJXDgchqyCU9Hz3fMNnboyTonEAPntBRE/ieprtVPc
 3MvnzIifGRUA==
X-IronPort-AV: E=Sophos;i="5.81,167,1610438400"; 
   d="scan'208";a="587246186"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 22:22:38 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>, clm@fb.com, josef@toxicpanda.com,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH V2 8/8] btrfs: convert to zero_user()
Date:   Tue,  9 Feb 2021 22:22:21 -0800
Message-Id: <20210210062221.3023586-9-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210210062221.3023586-1-ira.weiny@intel.com>
References: <20210210062221.3023586-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

There are many places where kmap/memset/kunmap patterns occur.

This pattern exists in the core as zero_user()

Use zero_user() to eliminate direct uses of kmap and leverage the new
core functions use of kmap_local_page().

The development of this patch was aided by the following coccinelle
script:

// <smpl>
// SPDX-License-Identifier: GPL-2.0-only
// Find kmap/memset/kunmap pattern and replace with memset*page calls
//
// NOTE: Offsets and other expressions may be more complex than what the script
// will automatically generate.  Therefore a catchall rule is provided to find
// the pattern which then must be evaluated by hand.
//
// Confidence: Low
// Copyright: (C) 2021 Intel Corporation
// URL: http://coccinelle.lip6.fr/
// Comments:
// Options:

//
// Then the memset pattern
//
@ memset_rule1 @
expression page, V, L, Off;
identifier ptr;
type VP;
@@

(
-VP ptr = kmap(page);
|
-ptr = kmap(page);
|
-VP ptr = kmap_atomic(page);
|
-ptr = kmap_atomic(page);
)
<+...
(
-memset(ptr, 0, L);
+zero_user(page, 0, L);
|
-memset(ptr + Off, 0, L);
+zero_user(page, Off, L);
|
-memset(ptr, V, L);
+memset_page(page, V, 0, L);
|
-memset(ptr + Off, V, L);
+memset_page(page, V, Off, L);
)
...+>
(
-kunmap(page);
|
-kunmap_atomic(ptr);
)

// Remove any pointers left unused
@
depends on memset_rule1
@
identifier memset_rule1.ptr;
type VP, VP1;
@@

-VP ptr;
	... when != ptr;
? VP1 ptr;

//
// Catch all
//
@ memset_rule2 @
expression page;
identifier ptr;
expression GenTo, GenSize, GenValue;
type VP;
@@

(
-VP ptr = kmap(page);
|
-ptr = kmap(page);
|
-VP ptr = kmap_atomic(page);
|
-ptr = kmap_atomic(page);
)
<+...
(
//
// Some call sites have complex expressions within the memset/memcpy
// The follow are catch alls which need to be evaluated by hand.
//
-memset(GenTo, 0, GenSize);
+zero_userExtra(page, GenTo, GenSize);
|
-memset(GenTo, GenValue, GenSize);
+memset_pageExtra(page, GenValue, GenTo, GenSize);
)
...+>
(
-kunmap(page);
|
-kunmap_atomic(ptr);
)

// Remove any pointers left unused
@
depends on memset_rule2
@
identifier memset_rule2.ptr;
type VP, VP1;
@@

-VP ptr;
	... when != ptr;
? VP1 ptr;

// </smpl>

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from v1:
	Update commit message per David
		https://lore.kernel.org/lkml/20210209151442.GU1993@suse.cz/
---
 fs/btrfs/compression.c |  5 +----
 fs/btrfs/extent_io.c   | 22 ++++------------------
 fs/btrfs/inode.c       | 33 ++++++++++-----------------------
 fs/btrfs/reflink.c     |  6 +-----
 fs/btrfs/zlib.c        |  5 +----
 fs/btrfs/zstd.c        |  5 +----
 6 files changed, 18 insertions(+), 58 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 047b632b4139..a219dcdb749e 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -567,16 +567,13 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		free_extent_map(em);
 
 		if (page->index == end_index) {
-			char *userpage;
 			size_t zero_offset = offset_in_page(isize);
 
 			if (zero_offset) {
 				int zeros;
 				zeros = PAGE_SIZE - zero_offset;
-				userpage = kmap_atomic(page);
-				memset(userpage + zero_offset, 0, zeros);
+				zero_user(page, zero_offset, zeros);
 				flush_dcache_page(page);
-				kunmap_atomic(userpage);
 			}
 		}
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c9cee458e001..bdc9389bff59 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3229,15 +3229,12 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 	}
 
 	if (page->index == last_byte >> PAGE_SHIFT) {
-		char *userpage;
 		size_t zero_offset = offset_in_page(last_byte);
 
 		if (zero_offset) {
 			iosize = PAGE_SIZE - zero_offset;
-			userpage = kmap_atomic(page);
-			memset(userpage + zero_offset, 0, iosize);
+			zero_user(page, zero_offset, iosize);
 			flush_dcache_page(page);
-			kunmap_atomic(userpage);
 		}
 	}
 	while (cur <= end) {
@@ -3245,14 +3242,11 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		u64 offset;
 
 		if (cur >= last_byte) {
-			char *userpage;
 			struct extent_state *cached = NULL;
 
 			iosize = PAGE_SIZE - pg_offset;
-			userpage = kmap_atomic(page);
-			memset(userpage + pg_offset, 0, iosize);
+			zero_user(page, pg_offset, iosize);
 			flush_dcache_page(page);
-			kunmap_atomic(userpage);
 			set_extent_uptodate(tree, cur, cur + iosize - 1,
 					    &cached, GFP_NOFS);
 			unlock_extent_cached(tree, cur,
@@ -3334,13 +3328,10 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 
 		/* we've found a hole, just zero and go on */
 		if (block_start == EXTENT_MAP_HOLE) {
-			char *userpage;
 			struct extent_state *cached = NULL;
 
-			userpage = kmap_atomic(page);
-			memset(userpage + pg_offset, 0, iosize);
+			zero_user(page, pg_offset, iosize);
 			flush_dcache_page(page);
-			kunmap_atomic(userpage);
 
 			set_extent_uptodate(tree, cur, cur + iosize - 1,
 					    &cached, GFP_NOFS);
@@ -3654,12 +3645,7 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	}
 
 	if (page->index == end_index) {
-		char *userpage;
-
-		userpage = kmap_atomic(page);
-		memset(userpage + pg_offset, 0,
-		       PAGE_SIZE - pg_offset);
-		kunmap_atomic(userpage);
+		zero_user(page, pg_offset, PAGE_SIZE - pg_offset);
 		flush_dcache_page(page);
 	}
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a8e0a6b038d3..641f21a11722 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -640,17 +640,12 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 		if (!ret) {
 			unsigned long offset = offset_in_page(total_compressed);
 			struct page *page = pages[nr_pages - 1];
-			char *kaddr;
 
 			/* zero the tail end of the last page, we might be
 			 * sending it down to disk
 			 */
-			if (offset) {
-				kaddr = kmap_atomic(page);
-				memset(kaddr + offset, 0,
-				       PAGE_SIZE - offset);
-				kunmap_atomic(kaddr);
-			}
+			if (offset)
+				zero_user(page, offset, PAGE_SIZE - offset);
 			will_compress = 1;
 		}
 	}
@@ -4675,7 +4670,6 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 	struct btrfs_ordered_extent *ordered;
 	struct extent_state *cached_state = NULL;
 	struct extent_changeset *data_reserved = NULL;
-	char *kaddr;
 	bool only_release_metadata = false;
 	u32 blocksize = fs_info->sectorsize;
 	pgoff_t index = from >> PAGE_SHIFT;
@@ -4765,15 +4759,13 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 	if (offset != blocksize) {
 		if (!len)
 			len = blocksize - offset;
-		kaddr = kmap(page);
 		if (front)
-			memset(kaddr + (block_start - page_offset(page)),
-				0, offset);
+			zero_user(page, (block_start - page_offset(page)),
+				  offset);
 		else
-			memset(kaddr + (block_start - page_offset(page)) +  offset,
-				0, len);
+			zero_user(page, (block_start - page_offset(page)) + offset,
+				  len);
 		flush_dcache_page(page);
-		kunmap(page);
 	}
 	ClearPageChecked(page);
 	set_page_dirty(page);
@@ -6660,11 +6652,9 @@ static noinline int uncompress_inline(struct btrfs_path *path,
 	 * cover that region here.
 	 */
 
-	if (max_size + pg_offset < PAGE_SIZE) {
-		char *map = kmap(page);
-		memset(map + pg_offset + max_size, 0, PAGE_SIZE - max_size - pg_offset);
-		kunmap(page);
-	}
+	if (max_size + pg_offset < PAGE_SIZE)
+		zero_user(page,  pg_offset + max_size,
+			  PAGE_SIZE - max_size - pg_offset);
 	kfree(tmp);
 	return ret;
 }
@@ -8303,7 +8293,6 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	struct btrfs_ordered_extent *ordered;
 	struct extent_state *cached_state = NULL;
 	struct extent_changeset *data_reserved = NULL;
-	char *kaddr;
 	unsigned long zero_start;
 	loff_t size;
 	vm_fault_t ret;
@@ -8410,10 +8399,8 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 		zero_start = PAGE_SIZE;
 
 	if (zero_start != PAGE_SIZE) {
-		kaddr = kmap(page);
-		memset(kaddr + zero_start, 0, PAGE_SIZE - zero_start);
+		zero_user(page, zero_start, PAGE_SIZE - zero_start);
 		flush_dcache_page(page);
-		kunmap(page);
 	}
 	ClearPageChecked(page);
 	set_page_dirty(page);
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 74c62e49c0c9..c052c4878670 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -126,12 +126,8 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
 	 * So what's in the range [500, 4095] corresponds to zeroes.
 	 */
 	if (datal < block_size) {
-		char *map;
-
-		map = kmap(page);
-		memset(map + datal, 0, block_size - datal);
+		zero_user(page, datal, block_size - datal);
 		flush_dcache_page(page);
-		kunmap(page);
 	}
 
 	SetPageUptodate(page);
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index d524acf7b3e5..fd612a509463 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -375,7 +375,6 @@ int zlib_decompress(struct list_head *ws, unsigned char *data_in,
 	unsigned long bytes_left;
 	unsigned long total_out = 0;
 	unsigned long pg_offset = 0;
-	char *kaddr;
 
 	destlen = min_t(unsigned long, destlen, PAGE_SIZE);
 	bytes_left = destlen;
@@ -455,9 +454,7 @@ int zlib_decompress(struct list_head *ws, unsigned char *data_in,
 	 * end of the inline extent (destlen) to the end of the page
 	 */
 	if (pg_offset < destlen) {
-		kaddr = kmap_atomic(dest_page);
-		memset(kaddr + pg_offset, 0, destlen - pg_offset);
-		kunmap_atomic(kaddr);
+		zero_user(dest_page, pg_offset, destlen - pg_offset);
 	}
 	return ret;
 }
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 8e9626d63976..b6f687b8a3da 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -631,7 +631,6 @@ int zstd_decompress(struct list_head *ws, unsigned char *data_in,
 	size_t ret2;
 	unsigned long total_out = 0;
 	unsigned long pg_offset = 0;
-	char *kaddr;
 
 	stream = ZSTD_initDStream(
 			ZSTD_BTRFS_MAX_INPUT, workspace->mem, workspace->size);
@@ -696,9 +695,7 @@ int zstd_decompress(struct list_head *ws, unsigned char *data_in,
 	ret = 0;
 finish:
 	if (pg_offset < destlen) {
-		kaddr = kmap_atomic(dest_page);
-		memset(kaddr + pg_offset, 0, destlen - pg_offset);
-		kunmap_atomic(kaddr);
+		zero_user(dest_page, pg_offset, destlen - pg_offset);
 	}
 	return ret;
 }
-- 
2.28.0.rc0.12.gb6a658bd00c9

