Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08E181492A9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2020 02:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387651AbgAYBf5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 20:35:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36710 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729742AbgAYBfz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 20:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=H30YE8NU4tKkTXmN/PrPqu9Iluf7+ogDxPJqpSWmKeA=; b=bc/vhtIkIpuJcuK1rjIoRviGLM
        E+C+60+SFj/vK0N1QIiPhGxVF6CrgigPNcTt9uRy7BaXi8Ys/LGt3qpWJrNqyGhTRO12b+FIfLD6p
        dT09bQ5ixyfDqOO7hEzhaMdESWGqJGi+fUYKFYDOWz+8/P3U/Dxk4uUmbQr2st5i42X2yXWcGWBP4
        8VRQGjTWxLmK26pwh3+KZj8l4arkG5kAf0qaD8LiB75OAoU16hlDY99/I9DD9IURDz6mem4eEpQ/d
        sKizbviYSAvVlvvU27ceEwuZjq4O9fLMiItj7S1P800/LRbO9xRHL22V2b9ELF79vJZ6LcJ1+keMt
        YkV9/Smw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ivAMd-0006Vt-FJ; Sat, 25 Jan 2020 01:35:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: [PATCH 09/12] ext4: Convert from readpages to readahead
Date:   Fri, 24 Jan 2020 17:35:50 -0800
Message-Id: <20200125013553.24899-10-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200125013553.24899-1-willy@infradead.org>
References: <20200125013553.24899-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the new readahead operation in ext4

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: linux-ext4@vger.kernel.org
---
 fs/ext4/ext4.h     |  2 +-
 fs/ext4/inode.c    | 24 ++++++++++++------------
 fs/ext4/readpage.c | 20 +++++++-------------
 3 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index f8578caba40d..a035694f3d9b 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3216,7 +3216,7 @@ static inline void ext4_set_de_type(struct super_block *sb,
 
 /* readpages.c */
 extern int ext4_mpage_readpages(struct address_space *mapping,
-				struct list_head *pages, struct page *page,
+				pgoff_t start, struct page *page,
 				unsigned nr_pages, bool is_readahead);
 extern int __init ext4_init_post_read_processing(void);
 extern void ext4_exit_post_read_processing(void);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 629a25d999f0..4afefc991b01 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3217,7 +3217,7 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
 static int ext4_readpage(struct file *file, struct page *page)
 {
 	int ret = -EAGAIN;
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = file_inode(file);
 
 	trace_ext4_readpage(page);
 
@@ -3225,23 +3225,23 @@ static int ext4_readpage(struct file *file, struct page *page)
 		ret = ext4_readpage_inline(inode, page);
 
 	if (ret == -EAGAIN)
-		return ext4_mpage_readpages(page->mapping, NULL, page, 1,
-						false);
+		return ext4_mpage_readpages(page->mapping, 0, page, 1, false);
 
 	return ret;
 }
 
-static int
-ext4_readpages(struct file *file, struct address_space *mapping,
-		struct list_head *pages, unsigned nr_pages)
+static unsigned
+ext4_readahead(struct file *file, struct address_space *mapping,
+		pgoff_t start, unsigned nr_pages)
 {
 	struct inode *inode = mapping->host;
 
-	/* If the file has inline data, no need to do readpages. */
+	/* If the file has inline data, no need to do readahead. */
 	if (ext4_has_inline_data(inode))
-		return 0;
+		return nr_pages;
 
-	return ext4_mpage_readpages(mapping, pages, NULL, nr_pages, true);
+	ext4_mpage_readpages(mapping, start, NULL, nr_pages, true);
+	return 0;
 }
 
 static void ext4_invalidatepage(struct page *page, unsigned int offset,
@@ -3565,7 +3565,7 @@ static int ext4_set_page_dirty(struct page *page)
 
 static const struct address_space_operations ext4_aops = {
 	.readpage		= ext4_readpage,
-	.readpages		= ext4_readpages,
+	.readahead		= ext4_readahead,
 	.writepage		= ext4_writepage,
 	.writepages		= ext4_writepages,
 	.write_begin		= ext4_write_begin,
@@ -3582,7 +3582,7 @@ static const struct address_space_operations ext4_aops = {
 
 static const struct address_space_operations ext4_journalled_aops = {
 	.readpage		= ext4_readpage,
-	.readpages		= ext4_readpages,
+	.readahead		= ext4_readahead,
 	.writepage		= ext4_writepage,
 	.writepages		= ext4_writepages,
 	.write_begin		= ext4_write_begin,
@@ -3598,7 +3598,7 @@ static const struct address_space_operations ext4_journalled_aops = {
 
 static const struct address_space_operations ext4_da_aops = {
 	.readpage		= ext4_readpage,
-	.readpages		= ext4_readpages,
+	.readahead		= ext4_readahead,
 	.writepage		= ext4_writepage,
 	.writepages		= ext4_writepages,
 	.write_begin		= ext4_da_write_begin,
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index fef7755300c3..aa3f46a237ef 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -7,8 +7,8 @@
  *
  * This was originally taken from fs/mpage.c
  *
- * The intent is the ext4_mpage_readpages() function here is intended
- * to replace mpage_readpages() in the general case, not just for
+ * The ext4_mpage_readahead() function here is intended to
+ * replace mpage_readahead() in the general case, not just for
  * encrypted files.  It has some limitations (see below), where it
  * will fall back to read_block_full_page(), but these limitations
  * should only be hit when page_size != block_size.
@@ -209,9 +209,8 @@ static inline loff_t ext4_readpage_limit(struct inode *inode)
 	return i_size_read(inode);
 }
 
-int ext4_mpage_readpages(struct address_space *mapping,
-			 struct list_head *pages, struct page *page,
-			 unsigned nr_pages, bool is_readahead)
+int ext4_mpage_readpages(struct address_space *mapping, pgoff_t start,
+		struct page *page, unsigned nr_pages, bool is_readahead)
 {
 	struct bio *bio = NULL;
 	sector_t last_block_in_bio = 0;
@@ -239,14 +238,10 @@ int ext4_mpage_readpages(struct address_space *mapping,
 		int fully_mapped = 1;
 		unsigned first_hole = blocks_per_page;
 
-		if (pages) {
-			page = lru_to_page(pages);
+		if (is_readahead) {
+			page = readahead_page(mapping, start++);
 
 			prefetchw(&page->flags);
-			list_del(&page->lru);
-			if (add_to_page_cache_lru(page, mapping, page->index,
-				  readahead_gfp_mask(mapping)))
-				goto next_page;
 		}
 
 		if (page_has_buffers(page))
@@ -402,10 +397,9 @@ int ext4_mpage_readpages(struct address_space *mapping,
 		else
 			unlock_page(page);
 	next_page:
-		if (pages)
+		if (is_readahead)
 			put_page(page);
 	}
-	BUG_ON(pages && !list_empty(pages));
 	if (bio)
 		submit_bio(bio);
 	return 0;
-- 
2.24.1

