Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C02730FD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 08:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244439AbjFOGuh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 02:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244557AbjFOGt7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:49:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0590335AD;
        Wed, 14 Jun 2023 23:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nWhNUEXFR5YBX8QlcKINGrQMm3Bdv1+u07uUK/T5CZY=; b=kUuqFdvcn61q3z/DgsZwZTx4pF
        FLsixr7CXS9bSSaomcmJct+F79QOvlOVYv1DwIyuF0hCtMH46KF2yjTQCffjGx07+jFemLGaDjYzN
        wBv+RrsoUNhtlNP3byd3ErvNU1z0YofpAriiv3uDFpI7QdlX5Mknc9blT4pSs2THjnYa9SGztzglu
        sDeZXFGn0onj1JzljTotqRCAJrM5tJL8mAHiKHnqv/VBZgdr5w+gWRIAcjShD3hPYruFTSvOAmlWV
        d0PCfiEruSoLQiXyNDHqu+nl/0tdWyxApuXextbJ4tCKG+ZsLif7dYYMNvQ9t4bg+vLMUT6lJbtHf
        0k1jIERA==;
Received: from 2a02-8389-2341-5b80-8c8c-28f8-1274-e038.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8c8c:28f8:1274:e038] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9gmv-00DuB2-1o;
        Thu, 15 Jun 2023 06:48:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/11] md-bitmap: refactor md_bitmap_init_from_disk
Date:   Thu, 15 Jun 2023 08:48:35 +0200
Message-Id: <20230615064840.629492-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615064840.629492-1-hch@lst.de>
References: <20230615064840.629492-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split the confusing loop in md_bitmap_init_from_disk that iterates over
all chunks but also needs to read and map the pages into three separate
loops: one that iterates over the pages to read them, a second optional
one to iterate over the pages to mark them invalid if the bitmaps are
out of date, and a final one that actually iterates over the chunks.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md-bitmap.c | 142 ++++++++++++++++++++---------------------
 1 file changed, 70 insertions(+), 72 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index fa0f6ca7b61b0b..1f71683b417981 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1065,33 +1065,31 @@ void md_bitmap_unplug_async(struct bitmap *bitmap)
 EXPORT_SYMBOL(md_bitmap_unplug_async);
 
 static void md_bitmap_set_memory_bits(struct bitmap *bitmap, sector_t offset, int needed);
-/* * bitmap_init_from_disk -- called at bitmap_create time to initialize
- * the in-memory bitmap from the on-disk bitmap -- also, sets up the
- * memory mapping of the bitmap file
- * Special cases:
- *   if there's no bitmap file, or if the bitmap file had been
- *   previously kicked from the array, we mark all the bits as
- *   1's in order to cause a full resync.
+
+/*
+ * Initialize the in-memory bitmap from the on-disk bitmap and set up the memory
+ * mapping of the bitmap file.
+ *
+ * Special case: If there's no bitmap file, or if the bitmap file had been
+ * previously kicked from the array, we mark all the bits as 1's in order to
+ * cause a full resync.
  *
  * We ignore all bits for sectors that end earlier than 'start'.
- * This is used when reading an out-of-date bitmap...
+ * This is used when reading an out-of-date bitmap.
  */
 static int md_bitmap_init_from_disk(struct bitmap *bitmap, sector_t start)
 {
-	unsigned long i, chunks, index, oldindex, bit, node_offset = 0;
-	struct page *page = NULL;
-	unsigned long bit_cnt = 0;
-	struct file *file;
-	unsigned long offset;
-	int outofdate;
-	int ret = -ENOSPC;
-	void *paddr;
+	bool outofdate = test_bit(BITMAP_STALE, &bitmap->flags);
+	struct mddev *mddev = bitmap->mddev;
+	unsigned long chunks = bitmap->counts.chunks;
 	struct bitmap_storage *store = &bitmap->storage;
+	struct file *file = store->file;
+	unsigned long node_offset = 0;
+	unsigned long bit_cnt = 0;
+	unsigned long i;
+	int ret;
 
-	chunks = bitmap->counts.chunks;
-	file = store->file;
-
-	if (!file && !bitmap->mddev->bitmap_info.offset) {
+	if (!file && !mddev->bitmap_info.offset) {
 		/* No permanent bitmap - fill with '1s'. */
 		store->filemap = NULL;
 		store->file_pages = 0;
@@ -1106,10 +1104,6 @@ static int md_bitmap_init_from_disk(struct bitmap *bitmap, sector_t start)
 		return 0;
 	}
 
-	outofdate = test_bit(BITMAP_STALE, &bitmap->flags);
-	if (outofdate)
-		pr_warn("%s: bitmap file is out of date, doing full recovery\n", bmname(bitmap));
-
 	if (file && i_size_read(file->f_mapping->host) < store->bytes) {
 		pr_warn("%s: bitmap file too short %lu < %lu\n",
 			bmname(bitmap),
@@ -1118,65 +1112,70 @@ static int md_bitmap_init_from_disk(struct bitmap *bitmap, sector_t start)
 		goto err;
 	}
 
-	oldindex = ~0L;
-	offset = 0;
-	if (!bitmap->mddev->bitmap_info.external)
-		offset = sizeof(bitmap_super_t);
-
-	if (mddev_is_clustered(bitmap->mddev))
+	if (mddev_is_clustered(mddev))
 		node_offset = bitmap->cluster_slot * (DIV_ROUND_UP(store->bytes, PAGE_SIZE));
 
-	for (i = 0; i < chunks; i++) {
-		int b;
-		index = file_page_index(&bitmap->storage, i);
-		bit = file_page_offset(&bitmap->storage, i);
-		if (index != oldindex) { /* this is a new page, read it in */
-			int count;
-			/* unmap the old page, we're done with it */
-			if (index == store->file_pages-1)
-				count = store->bytes - index * PAGE_SIZE;
-			else
-				count = PAGE_SIZE;
-			page = store->filemap[index];
-			if (file)
-				ret = read_file_page(file, index, bitmap,
-						count, page);
-			else
-				ret = read_sb_page(
-					bitmap->mddev,
-					bitmap->mddev->bitmap_info.offset,
-					page,
-					index + node_offset, count);
-
-			if (ret)
-				goto err;
+	for (i = 0; i < store->file_pages; i++) {
+		struct page *page = store->filemap[i];
+		int count;
 
-			oldindex = index;
+		/* unmap the old page, we're done with it */
+		if (i == store->file_pages - 1)
+			count = store->bytes - i * PAGE_SIZE;
+		else
+			count = PAGE_SIZE;
 
-			if (outofdate) {
-				/*
-				 * if bitmap is out of date, dirty the
-				 * whole page and write it out
-				 */
-				paddr = kmap_atomic(page);
-				memset(paddr + offset, 0xff,
-				       PAGE_SIZE - offset);
-				kunmap_atomic(paddr);
-				write_page(bitmap, page, 1);
+		if (file)
+			ret = read_file_page(file, i, bitmap, count, page);
+		else
+			ret = read_sb_page(mddev, mddev->bitmap_info.offset,
+					   page, i + node_offset, count);
+		if (ret)
+			goto err;
+	}
+
+	if (outofdate) {
+		pr_warn("%s: bitmap file is out of date, doing full recovery\n",
+			bmname(bitmap));
+
+		for (i = 0; i < store->file_pages; i++) {
+			struct page *page = store->filemap[i];
+			unsigned long offset = 0;
+			void *paddr;
+	
+			if (i == 0 && !mddev->bitmap_info.external)
+				offset = sizeof(bitmap_super_t);
+
+			/*
+			 * If the bitmap is out of date, dirty the whole page
+			 * and write it out
+			 */
+			paddr = kmap_atomic(page);
+			memset(paddr + offset, 0xff, PAGE_SIZE - offset);
+			kunmap_atomic(paddr);
 
+			write_page(bitmap, page, 1);
+			if (test_bit(BITMAP_WRITE_ERROR, &bitmap->flags)) {
 				ret = -EIO;
-				if (test_bit(BITMAP_WRITE_ERROR,
-					     &bitmap->flags))
-					goto err;
+				goto err;
 			}
 		}
+	}
+
+	for (i = 0; i < chunks; i++) {
+		struct page *page = filemap_get_page(&bitmap->storage, i);
+		unsigned long bit = file_page_offset(&bitmap->storage, i);
+		void *paddr;
+		bool was_set;
+
 		paddr = kmap_atomic(page);
 		if (test_bit(BITMAP_HOSTENDIAN, &bitmap->flags))
-			b = test_bit(bit, paddr);
+			was_set = test_bit(bit, paddr);
 		else
-			b = test_bit_le(bit, paddr);
+			was_set = test_bit_le(bit, paddr);
 		kunmap_atomic(paddr);
-		if (b) {
+
+		if (was_set) {
 			/* if the disk bit is set, set the memory bit */
 			int needed = ((sector_t)(i+1) << bitmap->counts.chunkshift
 				      >= start);
@@ -1185,7 +1184,6 @@ static int md_bitmap_init_from_disk(struct bitmap *bitmap, sector_t start)
 						  needed);
 			bit_cnt++;
 		}
-		offset = 0;
 	}
 
 	pr_debug("%s: bitmap initialized from disk: read %lu pages, set %lu of %lu bits\n",
-- 
2.39.2

