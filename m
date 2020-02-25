Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B594116F1F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 22:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgBYVsm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 16:48:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43520 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbgBYVsm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 16:48:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/YJ0sSq9BBtDgy7CcJstdFLF86NYpYiig2J/aQqOczg=; b=C/LlxEzQ0ZXPYjeWMEus4SCkyX
        3C5cBNDKiXeS2IULtqq3L/PwSwDGOkwXrRErXKMSb7WgOm9HFyXVu2S92s/XnzW04LhaYH7BrTIIn
        lKsMD+RwMcm1y8JpsSUWBcVkuJe5KVwSY49NUGgs/8NKHba+kaQ5YX09cW6tvfL4vFMAUXD5QENgI
        13VxlbEYkUJQuJgh++FrtFxffXj1+alNX4q91EyV3RBiRKPlE7KzoukodRbH/xgHL1R0bFb7osa4N
        btd3wMOFY9kjLmqU8HpTYfqI+EflUcoj7W7jLvYNGRKCvTGV3p2QAZysCH04CtDzYob4aE+GVJIee
        +4JIWhrQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6i4H-0007rE-N9; Tue, 25 Feb 2020 21:48:41 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH v8 22/25] f2fs: Convert from readpages to readahead
Date:   Tue, 25 Feb 2020 13:48:35 -0800
Message-Id: <20200225214838.30017-23-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200225214838.30017-1-willy@infradead.org>
References: <20200225214838.30017-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the new readahead operation in f2fs

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/data.c              | 47 +++++++++++++++----------------------
 include/trace/events/f2fs.h |  6 ++---
 2 files changed, 22 insertions(+), 31 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8e9aa2254490..237dff36fe73 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2160,8 +2160,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
  * from read-ahead.
  */
 static int f2fs_mpage_readpages(struct address_space *mapping,
-			struct list_head *pages, struct page *page,
-			unsigned nr_pages, bool is_readahead)
+		struct readahead_control *rac, struct page *page)
 {
 	struct bio *bio = NULL;
 	sector_t last_block_in_bio = 0;
@@ -2179,6 +2178,7 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 		.nr_cpages = 0,
 	};
 #endif
+	unsigned nr_pages = rac ? readahead_count(rac) : 1;
 	unsigned max_nr_pages = nr_pages;
 	int ret = 0;
 
@@ -2192,15 +2192,9 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 	map.m_may_create = false;
 
 	for (; nr_pages; nr_pages--) {
-		if (pages) {
-			page = list_last_entry(pages, struct page, lru);
-
+		if (rac) {
+			page = readahead_page(rac);
 			prefetchw(&page->flags);
-			list_del(&page->lru);
-			if (add_to_page_cache_lru(page, mapping,
-						  page_index(page),
-						  readahead_gfp_mask(mapping)))
-				goto next_page;
 		}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
@@ -2210,7 +2204,7 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 				ret = f2fs_read_multi_pages(&cc, &bio,
 							max_nr_pages,
 							&last_block_in_bio,
-							is_readahead);
+							rac);
 				f2fs_destroy_compress_ctx(&cc);
 				if (ret)
 					goto set_error_page;
@@ -2233,7 +2227,7 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 #endif
 
 		ret = f2fs_read_single_page(inode, page, max_nr_pages, &map,
-					&bio, &last_block_in_bio, is_readahead);
+					&bio, &last_block_in_bio, rac);
 		if (ret) {
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 set_error_page:
@@ -2242,8 +2236,10 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 			zero_user_segment(page, 0, PAGE_SIZE);
 			unlock_page(page);
 		}
+#ifdef CONFIG_F2FS_FS_COMPRESSION
 next_page:
-		if (pages)
+#endif
+		if (rac)
 			put_page(page);
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
@@ -2253,16 +2249,15 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 				ret = f2fs_read_multi_pages(&cc, &bio,
 							max_nr_pages,
 							&last_block_in_bio,
-							is_readahead);
+							rac);
 				f2fs_destroy_compress_ctx(&cc);
 			}
 		}
 #endif
 	}
-	BUG_ON(pages && !list_empty(pages));
 	if (bio)
 		__submit_bio(F2FS_I_SB(inode), bio, DATA);
-	return pages ? 0 : ret;
+	return ret;
 }
 
 static int f2fs_read_data_page(struct file *file, struct page *page)
@@ -2281,28 +2276,24 @@ static int f2fs_read_data_page(struct file *file, struct page *page)
 	if (f2fs_has_inline_data(inode))
 		ret = f2fs_read_inline_data(inode, page);
 	if (ret == -EAGAIN)
-		ret = f2fs_mpage_readpages(page_file_mapping(page),
-						NULL, page, 1, false);
+		ret = f2fs_mpage_readpages(page_file_mapping(page), NULL, page);
 	return ret;
 }
 
-static int f2fs_read_data_pages(struct file *file,
-			struct address_space *mapping,
-			struct list_head *pages, unsigned nr_pages)
+static void f2fs_readahead(struct readahead_control *rac)
 {
-	struct inode *inode = mapping->host;
-	struct page *page = list_last_entry(pages, struct page, lru);
+	struct inode *inode = rac->mapping->host;
 
-	trace_f2fs_readpages(inode, page, nr_pages);
+	trace_f2fs_readpages(inode, readahead_index(rac), readahead_count(rac));
 
 	if (!f2fs_is_compress_backend_ready(inode))
-		return 0;
+		return;
 
 	/* If the file has inline data, skip readpages */
 	if (f2fs_has_inline_data(inode))
-		return 0;
+		return;
 
-	return f2fs_mpage_readpages(mapping, pages, NULL, nr_pages, true);
+	f2fs_mpage_readpages(rac->mapping, rac, NULL);
 }
 
 int f2fs_encrypt_one_page(struct f2fs_io_info *fio)
@@ -3784,7 +3775,7 @@ static void f2fs_swap_deactivate(struct file *file)
 
 const struct address_space_operations f2fs_dblock_aops = {
 	.readpage	= f2fs_read_data_page,
-	.readpages	= f2fs_read_data_pages,
+	.readahead	= f2fs_readahead,
 	.writepage	= f2fs_write_data_page,
 	.writepages	= f2fs_write_data_pages,
 	.write_begin	= f2fs_write_begin,
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 67a97838c2a0..d72da4a33883 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1375,9 +1375,9 @@ TRACE_EVENT(f2fs_writepages,
 
 TRACE_EVENT(f2fs_readpages,
 
-	TP_PROTO(struct inode *inode, struct page *page, unsigned int nrpage),
+	TP_PROTO(struct inode *inode, pgoff_t start, unsigned int nrpage),
 
-	TP_ARGS(inode, page, nrpage),
+	TP_ARGS(inode, start, nrpage),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
@@ -1389,7 +1389,7 @@ TRACE_EVENT(f2fs_readpages,
 	TP_fast_assign(
 		__entry->dev	= inode->i_sb->s_dev;
 		__entry->ino	= inode->i_ino;
-		__entry->start	= page->index;
+		__entry->start	= start;
 		__entry->nrpage	= nrpage;
 	),
 
-- 
2.25.0

