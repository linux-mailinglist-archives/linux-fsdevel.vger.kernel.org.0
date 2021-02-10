Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2904315F64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 07:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhBJGYE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 01:24:04 -0500
Received: from mga03.intel.com ([134.134.136.65]:39564 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231701AbhBJGXo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 01:23:44 -0500
IronPort-SDR: LESFlbkG4VZiuwpxyOmsiQ4f1yCzSY05ovQMPD9wtqJY3bHkkujKwswJ3vwRyn2YDgMiaSZeF9
 kk9ldE5SihhA==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="182086731"
X-IronPort-AV: E=Sophos;i="5.81,167,1610438400"; 
   d="scan'208";a="182086731"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 22:22:37 -0800
IronPort-SDR: SvzNAszZ/j3OV6gr1AHh06AEXKAlw7i7WN3BZ6xs/hC6eQImCd0+UWNW2K0//PRUO5n1NyN9xv
 vl+aAYhxZeNA==
X-IronPort-AV: E=Sophos;i="5.81,167,1610438400"; 
   d="scan'208";a="587246169"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 22:22:36 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>, clm@fb.com, josef@toxicpanda.com,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH V2 6/8] btrfs: use memcpy_[to|from]_page() and kmap_local_page()
Date:   Tue,  9 Feb 2021 22:22:19 -0800
Message-Id: <20210210062221.3023586-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210210062221.3023586-1-ira.weiny@intel.com>
References: <20210210062221.3023586-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

There are many places where the pattern kmap/memcpy/kunmap occurs.

This pattern was lifted to the core common functions
memcpy_[to|from]_page().

Use these new functions to reduce the code, eliminate direct uses of
kmap, and leverage the new core functions use of kmap_local_page().

Also, there is 1 place where a kmap/memcpy is followed by an
optional memset.  Here we leave the kmap open coded to avoid remapping
the page but use kmap_local_page() directly.

Development of this patch was aided by the coccinelle script:

// <smpl>
// SPDX-License-Identifier: GPL-2.0-only
// Find kmap/memcpy/kunmap pattern and replace with memcpy*page calls
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
// simple memcpy version
//
@ memcpy_rule1 @
expression page, T, F, B, Off;
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
-memcpy(ptr + Off, F, B);
+memcpy_to_page(page, Off, F, B);
|
-memcpy(ptr, F, B);
+memcpy_to_page(page, 0, F, B);
|
-memcpy(T, ptr + Off, B);
+memcpy_from_page(T, page, Off, B);
|
-memcpy(T, ptr, B);
+memcpy_from_page(T, page, 0, B);
)
...+>
(
-kunmap(page);
|
-kunmap_atomic(ptr);
)

// Remove any pointers left unused
@
depends on memcpy_rule1
@
identifier memcpy_rule1.ptr;
type VP, VP1;
@@

-VP ptr;
	... when != ptr;
? VP1 ptr;

//
// Some callers kmap without a temp pointer
//
@ memcpy_rule2 @
expression page, T, Off, F, B;
@@

<+...
(
-memcpy(kmap(page) + Off, F, B);
+memcpy_to_page(page, Off, F, B);
|
-memcpy(kmap(page), F, B);
+memcpy_to_page(page, 0, F, B);
|
-memcpy(T, kmap(page) + Off, B);
+memcpy_from_page(T, page, Off, B);
|
-memcpy(T, kmap(page), B);
+memcpy_from_page(T, page, 0, B);
)
...+>
-kunmap(page);
// No need for the ptr variable removal

//
// Catch all
//
@ memcpy_rule3 @
expression page;
expression GenTo, GenFrom, GenSize;
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
//
// Some call sites have complex expressions within the memcpy
// match a catch all to be evaluated by hand.
//
-memcpy(GenTo, GenFrom, GenSize);
+memcpy_to_pageExtra(page, GenTo, GenFrom, GenSize);
+memcpy_from_pageExtra(GenTo, page, GenFrom, GenSize);
)
...+>
(
-kunmap(page);
|
-kunmap_atomic(ptr);
)

// Remove any pointers left unused
@
depends on memcpy_rule3
@
identifier memcpy_rule3.ptr;
type VP, VP1;
@@

-VP ptr;
	... when != ptr;
? VP1 ptr;

// <smpl>

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from v1:
	Update commit message per David
		https://lore.kernel.org/lkml/20210209151442.GU1993@suse.cz/
---
 fs/btrfs/compression.c | 6 ++----
 fs/btrfs/lzo.c         | 4 ++--
 fs/btrfs/reflink.c     | 6 +-----
 fs/btrfs/send.c        | 7 ++-----
 fs/btrfs/zlib.c        | 5 ++---
 fs/btrfs/zstd.c        | 6 ++----
 6 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 5ae3fa0386b7..047b632b4139 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1231,7 +1231,6 @@ int btrfs_decompress_buf2page(const char *buf, unsigned long buf_start,
 	unsigned long prev_start_byte;
 	unsigned long working_bytes = total_out - buf_start;
 	unsigned long bytes;
-	char *kaddr;
 	struct bio_vec bvec = bio_iter_iovec(bio, bio->bi_iter);
 
 	/*
@@ -1262,9 +1261,8 @@ int btrfs_decompress_buf2page(const char *buf, unsigned long buf_start,
 				PAGE_SIZE - (buf_offset % PAGE_SIZE));
 		bytes = min(bytes, working_bytes);
 
-		kaddr = kmap_atomic(bvec.bv_page);
-		memcpy(kaddr + bvec.bv_offset, buf + buf_offset, bytes);
-		kunmap_atomic(kaddr);
+		memcpy_to_page(bvec.bv_page, bvec.bv_offset, buf + buf_offset,
+			       bytes);
 		flush_dcache_page(bvec.bv_page);
 
 		buf_offset += bytes;
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index aa9cd11f4b78..9084a950dc09 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -467,7 +467,7 @@ int lzo_decompress(struct list_head *ws, unsigned char *data_in,
 	destlen = min_t(unsigned long, destlen, PAGE_SIZE);
 	bytes = min_t(unsigned long, destlen, out_len - start_byte);
 
-	kaddr = kmap_atomic(dest_page);
+	kaddr = kmap_local_page(dest_page);
 	memcpy(kaddr, workspace->buf + start_byte, bytes);
 
 	/*
@@ -477,7 +477,7 @@ int lzo_decompress(struct list_head *ws, unsigned char *data_in,
 	 */
 	if (bytes < destlen)
 		memset(kaddr+bytes, 0, destlen-bytes);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 out:
 	return ret;
 }
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index b03e7891394e..74c62e49c0c9 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -103,12 +103,8 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
 	set_bit(BTRFS_INODE_NO_DELALLOC_FLUSH, &inode->runtime_flags);
 
 	if (comp_type == BTRFS_COMPRESS_NONE) {
-		char *map;
-
-		map = kmap(page);
-		memcpy(map, data_start, datal);
+		memcpy_to_page(page, 0, data_start, datal);
 		flush_dcache_page(page);
-		kunmap(page);
 	} else {
 		ret = btrfs_decompress(comp_type, data_start, page, 0,
 				       inline_size, datal);
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 78a35374d492..83982b3b7057 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4948,7 +4948,6 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct inode *inode;
 	struct page *page;
-	char *addr;
 	pgoff_t index = offset >> PAGE_SHIFT;
 	pgoff_t last_index;
 	unsigned pg_offset = offset_in_page(offset);
@@ -5001,10 +5000,8 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
 			}
 		}
 
-		addr = kmap(page);
-		memcpy(sctx->send_buf + sctx->send_size, addr + pg_offset,
-		       cur_len);
-		kunmap(page);
+		memcpy_from_page(sctx->send_buf + sctx->send_size, page,
+				 pg_offset, cur_len);
 		unlock_page(page);
 		put_page(page);
 		index++;
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 05615a1099db..d524acf7b3e5 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -432,9 +432,8 @@ int zlib_decompress(struct list_head *ws, unsigned char *data_in,
 			    PAGE_SIZE - (buf_offset % PAGE_SIZE));
 		bytes = min(bytes, bytes_left);
 
-		kaddr = kmap_atomic(dest_page);
-		memcpy(kaddr + pg_offset, workspace->buf + buf_offset, bytes);
-		kunmap_atomic(kaddr);
+		memcpy_to_page(dest_page, pg_offset,
+			       workspace->buf + buf_offset, bytes);
 
 		pg_offset += bytes;
 		bytes_left -= bytes;
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 9a4871636c6c..8e9626d63976 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -688,10 +688,8 @@ int zstd_decompress(struct list_head *ws, unsigned char *data_in,
 		bytes = min_t(unsigned long, destlen - pg_offset,
 				workspace->out_buf.size - buf_offset);
 
-		kaddr = kmap_atomic(dest_page);
-		memcpy(kaddr + pg_offset, workspace->out_buf.dst + buf_offset,
-				bytes);
-		kunmap_atomic(kaddr);
+		memcpy_to_page(dest_page, pg_offset,
+			       workspace->out_buf.dst + buf_offset, bytes);
 
 		pg_offset += bytes;
 	}
-- 
2.28.0.rc0.12.gb6a658bd00c9

