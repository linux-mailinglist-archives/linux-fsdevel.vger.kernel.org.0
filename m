Return-Path: <linux-fsdevel+bounces-41891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DA3A38C3D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 20:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8F11887120
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 19:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCBF23717F;
	Mon, 17 Feb 2025 19:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VbrNGmUQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C966235BF4
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2025 19:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739820014; cv=none; b=mN7xk35K1I0NWSLLz3iC16Kpuq9Ni7hV2ol4yUgXENIZ/twnMN6zTmLiPItfG4PA6ZJUT6IafpRzpAObBJ/0FGlXYAZoU+RgtiurtpC88bDQhQHVD7s7GDLPayDbeZ5mExVcr/H0U7YVlbia7RFl3vizF7AvpLIemdxVRwGQ9tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739820014; c=relaxed/simple;
	bh=swQ3n7dg/mMu98RCJdbi5fDoYxZk9aO9RiqzwrAOIx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rAh4fjJl4XZRCcaax9LolBjf2HrUGULvJbVCTxHcU+DnYPSWT7zh6fBOvJFI6uvPg8Eyvc3J+/vIwSMeLmrURfriz8ooaiA76XBYat83VbGvI7Jxde7hC7XMqzBf0YdIHXUkpYOQPYuzZCAVTjZ1uyDPHv+BVmpYL1Q1HpakKpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VbrNGmUQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=bpxlu1VpRHaMCuJHYNJDFh9kAemaYJrHAe9o8N/mo/c=; b=VbrNGmUQwJg+LP7rYf68pxYOP7
	762/PVz7ngiEptNx0T5WinBj1kRXwhHh8wmrGbyg/kbzKKTJDIQ1Z7Kh4NbuQvu2FvITreeqOf7Q+
	bIm76Xqg0S8LJ6m8Xhk4XhN/yBW24eJHqBJl8kSDPiYBmSahicSUQSspztL2bbkgF1ngSHOw6SgI7
	xK39GDI7yBRZrdlCpgwL2suuWqsIQ3SBaNSQeY87Bg5GJx0p4s/IH2GsbkGBV9NiBcMMvmDO8KMP6
	d/d53J9+3feSlnrN2FpSqMQ1hCyHn6ZSIHnYFYVXEPwddNrRuFS9BUsdTNv9feVqZ4DVQJrwD+2ub
	3GYX6ZRQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6f5-00000001pvQ-1MFQ;
	Mon, 17 Feb 2025 19:20:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/3] fs: Convert block_commit_write() to take a folio
Date: Mon, 17 Feb 2025 19:20:06 +0000
Message-ID: <20250217192009.437916-1-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All callers now have a folio, so pass it in instead of converting
folio->page->folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c                 | 14 ++++----------
 fs/ext4/inline.c            |  2 +-
 fs/ext4/move_extent.c       |  2 +-
 fs/iomap/buffered-io.c      |  2 +-
 fs/ocfs2/aops.c             |  4 ++--
 fs/ocfs2/file.c             |  2 +-
 fs/udf/file.c               |  2 +-
 include/linux/buffer_head.h |  2 +-
 8 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index cc8452f60251..c66a59bb068b 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2166,7 +2166,7 @@ int __block_write_begin(struct folio *folio, loff_t pos, unsigned len,
 }
 EXPORT_SYMBOL(__block_write_begin);
 
-static void __block_commit_write(struct folio *folio, size_t from, size_t to)
+void block_commit_write(struct folio *folio, size_t from, size_t to)
 {
 	size_t block_start, block_end;
 	bool partial = false;
@@ -2204,6 +2204,7 @@ static void __block_commit_write(struct folio *folio, size_t from, size_t to)
 	if (!partial)
 		folio_mark_uptodate(folio);
 }
+EXPORT_SYMBOL(block_commit_write);
 
 /*
  * block_write_begin takes care of the basic task of block allocation and
@@ -2262,7 +2263,7 @@ int block_write_end(struct file *file, struct address_space *mapping,
 	flush_dcache_folio(folio);
 
 	/* This could be a short (even 0-length) commit */
-	__block_commit_write(folio, start, start + copied);
+	block_commit_write(folio, start, start + copied);
 
 	return copied;
 }
@@ -2578,13 +2579,6 @@ int cont_write_begin(struct file *file, struct address_space *mapping,
 }
 EXPORT_SYMBOL(cont_write_begin);
 
-void block_commit_write(struct page *page, unsigned from, unsigned to)
-{
-	struct folio *folio = page_folio(page);
-	__block_commit_write(folio, from, to);
-}
-EXPORT_SYMBOL(block_commit_write);
-
 /*
  * block_page_mkwrite() is not allowed to change the file size as it gets
  * called from a page fault handler when a page is first dirtied. Hence we must
@@ -2630,7 +2624,7 @@ int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
 	if (unlikely(ret))
 		goto out_unlock;
 
-	__block_commit_write(folio, 0, end);
+	block_commit_write(folio, 0, end);
 
 	folio_mark_dirty(folio);
 	folio_wait_stable(folio);
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 3536ca7e4fcc..0af474c8b260 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -637,7 +637,7 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 		goto retry;
 
 	if (folio)
-		block_commit_write(&folio->page, from, to);
+		block_commit_write(folio, from, to);
 out:
 	if (folio) {
 		folio_unlock(folio);
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 898443e98efc..48649be64d6a 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -399,7 +399,7 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 		bh = bh->b_this_page;
 	}
 
-	block_commit_write(&folio[0]->page, from, from + replaced_size);
+	block_commit_write(folio[0], from, from + replaced_size);
 
 	/* Even in case of data=writeback it is reasonable to pin
 	 * inode to transaction, to prevent unexpected data loss */
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d303e6c8900c..f3904d13cda4 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1484,7 +1484,7 @@ static loff_t iomap_folio_mkwrite_iter(struct iomap_iter *iter,
 					      &iter->iomap);
 		if (ret)
 			return ret;
-		block_commit_write(&folio->page, 0, length);
+		block_commit_write(folio, 0, length);
 	} else {
 		WARN_ON_ONCE(!folio_test_uptodate(folio));
 		folio_mark_dirty(folio);
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 5bbeb6fbb1ac..ee1d92ed950f 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -920,7 +920,7 @@ static void ocfs2_write_failure(struct inode *inode,
 				ocfs2_jbd2_inode_add_write(wc->w_handle, inode,
 							   user_pos, user_len);
 
-			block_commit_write(&folio->page, from, to);
+			block_commit_write(folio, from, to);
 		}
 	}
 }
@@ -2012,7 +2012,7 @@ int ocfs2_write_end_nolock(struct address_space *mapping, loff_t pos,
 				ocfs2_jbd2_inode_add_write(handle, inode,
 							   start_byte, length);
 			}
-			block_commit_write(&folio->page, from, to);
+			block_commit_write(folio, from, to);
 		}
 	}
 
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index e54f2c4b5a90..2056cf08ac1e 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -813,7 +813,7 @@ static int ocfs2_write_zero_page(struct inode *inode, u64 abs_from,
 
 
 		/* must not update i_size! */
-		block_commit_write(&folio->page, block_start + 1, block_start + 1);
+		block_commit_write(folio, block_start + 1, block_start + 1);
 	}
 
 	/*
diff --git a/fs/udf/file.c b/fs/udf/file.c
index 412fe7c4d348..0d76c4f37b3e 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -69,7 +69,7 @@ static vm_fault_t udf_page_mkwrite(struct vm_fault *vmf)
 		goto out_unlock;
 	}
 
-	block_commit_write(&folio->page, 0, end);
+	block_commit_write(folio, 0, end);
 out_dirty:
 	folio_mark_dirty(folio);
 	folio_wait_stable(folio);
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 932139c5d46f..6672e1a5031c 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -271,7 +271,7 @@ int cont_write_begin(struct file *, struct address_space *, loff_t,
 			unsigned, struct folio **, void **,
 			get_block_t *, loff_t *);
 int generic_cont_expand_simple(struct inode *inode, loff_t size);
-void block_commit_write(struct page *page, unsigned int from, unsigned int to);
+void block_commit_write(struct folio *folio, size_t from, size_t to);
 int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
 				get_block_t get_block);
 sector_t generic_block_bmap(struct address_space *, sector_t, get_block_t *);
-- 
2.47.2


