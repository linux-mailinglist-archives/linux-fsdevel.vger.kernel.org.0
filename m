Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79819158778
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 02:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgBKBDv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 20:03:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54720 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbgBKBDv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 20:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=X/JxTKwjJ9TnqVT/8JdgJyIFWM71sXK47ZA2JFZYOxI=; b=c5WDVT3QsX2lg/TH4aEtaxi/lC
        UHc15LNuf+UPnTqidfgz9p1TGfl1kmhHQwcx0Wu9Kt79Ahjk1UjbuZC+vhvW5dGLy+OjNdBvyDvNM
        5U7r3gloAH+ElNqbgFOBqIFzEbZmPFgGr9LpL4wCvERKRxUKsryqks8NFi8peMDIg9H30OXeO0DRD
        Ja3u7IflFAX79O6MMzgxFTYimYCr2aT3YacFEfny7qX73Z8ZADyWmNL08hSvgLKfZSV/7GMhZBfOs
        fvP2CW3mRH8Es2+wocON8KQrefoo8lvGcogLqOXU1RHhB0hB5K6V/ISf/Jt2f6jKMT1SDrl7ywXZ6
        WG4BclJQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1Jxu-0001o5-H9; Tue, 11 Feb 2020 01:03:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH v5 07/13] btrfs: Convert from readpages to readahead
Date:   Mon, 10 Feb 2020 17:03:42 -0800
Message-Id: <20200211010348.6872-8-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200211010348.6872-1-willy@infradead.org>
References: <20200211010348.6872-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the new readahead operation in btrfs.  Add a
readahead_for_each_batch() iterator to optimise the loop in the XArray.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/extent_io.c    | 48 ++++++++++++++---------------------------
 fs/btrfs/extent_io.h    |  3 +--
 fs/btrfs/inode.c        | 16 ++++++--------
 include/linux/pagemap.h | 26 ++++++++++++++++++++++
 4 files changed, 50 insertions(+), 43 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c0f202741e09..d9f66058e0a7 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4278,52 +4278,36 @@ int extent_writepages(struct address_space *mapping,
 	return ret;
 }
 
-int extent_readpages(struct address_space *mapping, struct list_head *pages,
-		     unsigned nr_pages)
+void extent_readahead(struct readahead_control *rac)
 {
 	struct bio *bio = NULL;
 	unsigned long bio_flags = 0;
 	struct page *pagepool[16];
 	struct extent_map *em_cached = NULL;
-	struct extent_io_tree *tree = &BTRFS_I(mapping->host)->io_tree;
-	int nr = 0;
+	struct extent_io_tree *tree = &BTRFS_I(rac->mapping->host)->io_tree;
 	u64 prev_em_start = (u64)-1;
+	int nr;
 
-	while (!list_empty(pages)) {
-		u64 contig_end = 0;
-
-		for (nr = 0; nr < ARRAY_SIZE(pagepool) && !list_empty(pages);) {
-			struct page *page = lru_to_page(pages);
-
-			prefetchw(&page->flags);
-			list_del(&page->lru);
-			if (add_to_page_cache_lru(page, mapping, page->index,
-						readahead_gfp_mask(mapping))) {
-				put_page(page);
-				break;
-			}
-
-			pagepool[nr++] = page;
-			contig_end = page_offset(page) + PAGE_SIZE - 1;
-		}
-
-		if (nr) {
-			u64 contig_start = page_offset(pagepool[0]);
+	readahead_for_each_batch(rac, pagepool, ARRAY_SIZE(pagepool), nr) {
+		u64 contig_start = page_offset(pagepool[0]);
+		u64 contig_end = page_offset(pagepool[nr - 1]) + PAGE_SIZE - 1;
 
-			ASSERT(contig_start + nr * PAGE_SIZE - 1 == contig_end);
+		ASSERT(contig_start + nr * PAGE_SIZE - 1 == contig_end);
 
-			contiguous_readpages(tree, pagepool, nr, contig_start,
-				     contig_end, &em_cached, &bio, &bio_flags,
-				     &prev_em_start);
-		}
+		contiguous_readpages(tree, pagepool, nr, contig_start,
+				contig_end, &em_cached, &bio, &bio_flags,
+				&prev_em_start);
 	}
 
 	if (em_cached)
 		free_extent_map(em_cached);
 
-	if (bio)
-		return submit_one_bio(bio, 0, bio_flags);
-	return 0;
+	if (bio) {
+		int ret = submit_one_bio(bio, 0, bio_flags);
+		if (ret < 0) {
+			/* XXX: unlock the pages here? */
+		}
+	}
 }
 
 /*
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 5d205bbaafdc..bddac32948c7 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -198,8 +198,7 @@ int extent_writepages(struct address_space *mapping,
 		      struct writeback_control *wbc);
 int btree_write_cache_pages(struct address_space *mapping,
 			    struct writeback_control *wbc);
-int extent_readpages(struct address_space *mapping, struct list_head *pages,
-		     unsigned nr_pages);
+void extent_readahead(struct readahead_control *rac);
 int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		__u64 start, __u64 len);
 void set_page_extent_mapped(struct page *page);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5b3ec93ff911..d964b2a78ed8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4794,8 +4794,8 @@ static void evict_inode_truncate_pages(struct inode *inode)
 
 	/*
 	 * Keep looping until we have no more ranges in the io tree.
-	 * We can have ongoing bios started by readpages (called from readahead)
-	 * that have their endio callback (extent_io.c:end_bio_extent_readpage)
+	 * We can have ongoing bios started by readahead that have
+	 * their endio callback (extent_io.c:end_bio_extent_readpage)
 	 * still in progress (unlocked the pages in the bio but did not yet
 	 * unlocked the ranges in the io tree). Therefore this means some
 	 * ranges can still be locked and eviction started because before
@@ -6996,11 +6996,11 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 			 * for it to complete) and then invalidate the pages for
 			 * this range (through invalidate_inode_pages2_range()),
 			 * but that can lead us to a deadlock with a concurrent
-			 * call to readpages() (a buffered read or a defrag call
+			 * call to readahead (a buffered read or a defrag call
 			 * triggered a readahead) on a page lock due to an
 			 * ordered dio extent we created before but did not have
 			 * yet a corresponding bio submitted (whence it can not
-			 * complete), which makes readpages() wait for that
+			 * complete), which makes readahead wait for that
 			 * ordered extent to complete while holding a lock on
 			 * that page.
 			 */
@@ -8239,11 +8239,9 @@ static int btrfs_writepages(struct address_space *mapping,
 	return extent_writepages(mapping, wbc);
 }
 
-static int
-btrfs_readpages(struct file *file, struct address_space *mapping,
-		struct list_head *pages, unsigned nr_pages)
+static void btrfs_readahead(struct readahead_control *rac)
 {
-	return extent_readpages(mapping, pages, nr_pages);
+	extent_readahead(rac);
 }
 
 static int __btrfs_releasepage(struct page *page, gfp_t gfp_flags)
@@ -10448,7 +10446,7 @@ static const struct address_space_operations btrfs_aops = {
 	.readpage	= btrfs_readpage,
 	.writepage	= btrfs_writepage,
 	.writepages	= btrfs_writepages,
-	.readpages	= btrfs_readpages,
+	.readahead	= btrfs_readahead,
 	.direct_IO	= btrfs_direct_IO,
 	.invalidatepage = btrfs_invalidatepage,
 	.releasepage	= btrfs_releasepage,
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index ddb2d1b43212..75bdfec49710 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -664,6 +664,32 @@ static inline struct page *readahead_page(struct readahead_control *rac)
 #define readahead_for_each(rac, page)					\
 	for (; (page = readahead_page(rac)); rac->nr_pages -= rac->batch_count)
 
+static inline unsigned int readahead_page_batch(struct readahead_control *rac,
+		struct page **array, unsigned int size)
+{
+	unsigned int batch = 0;
+	XA_STATE(xas, &rac->mapping->i_pages, rac->start);
+	struct page *page;
+
+	rac->batch_count = 0;
+	xas_for_each(&xas, page, rac->start + rac->nr_pages - 1) {
+		array[batch++] = page;
+		rac->batch_count += hpage_nr_pages(page);
+		rac->start += hpage_nr_pages(page);
+		if (PageHead(page))
+			xas_set(&xas, rac->start);
+
+		if (batch == size)
+			break;
+	}
+
+	return batch;
+}
+
+#define readahead_for_each_batch(rac, array, size, nr)			\
+	for (; (nr = readahead_page_batch(rac, array, size));		\
+			rac->nr_pages -= rac->batch_count)
+
 /* The byte offset into the file of this readahead block */
 static inline loff_t readahead_offset(struct readahead_control *rac)
 {
-- 
2.25.0

