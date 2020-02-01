Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EECC14F834
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2020 16:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgBAPMo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Feb 2020 10:12:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51792 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgBAPMm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Feb 2020 10:12:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xYwAfdpS6hrmEl94Puvsi7IdImGde6rBNX47LcdKaVk=; b=T7D+lG5GLXYKWTZpicm/6rP+Dy
        BGGfBYqgDqdVsPkeCgloGKm21LWX+OmYBNOuyoiHCkn1URRQf8+LBBlAbw3wQKVNzO+KnaGLoCTd5
        C4TVclnA99vj0PbiDQury7MRKSUlP+bQbw5Nneu8mrKSR5n+YJC41TL+wu+9o0E9+PkjND8fwWKG2
        GuTsHnkhEVKV8iN461UDqtyqhf9SSmoo2tv43fI5/lNjdRFyz1aHpAFHcGL6AXQRR/OtB6laaZgCV
        tqEuPiQY+sQ/vikq277LnDGO+lU0GyIUDT3qh8h064exlNntBmhPVa4CMd0NJHIMIkKe6gDrilX7u
        evbguPQg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixuRu-0006Ht-Bn; Sat, 01 Feb 2020 15:12:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: [PATCH v4 09/12] ext4: Convert from readpages to readahead
Date:   Sat,  1 Feb 2020 07:12:37 -0800
Message-Id: <20200201151240.24082-10-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200201151240.24082-1-willy@infradead.org>
References: <20200201151240.24082-1-willy@infradead.org>
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
 fs/ext4/ext4.h     |  5 ++---
 fs/ext4/inode.c    | 24 ++++++++++++------------
 fs/ext4/readpage.c | 20 +++++++-------------
 fs/ext4/verity.c   | 16 +++++++++++-----
 4 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9a2ee2428ecc..346ad9e1403b 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3275,9 +3275,8 @@ static inline void ext4_set_de_type(struct super_block *sb,
 }
 
 /* readpages.c */
-extern int ext4_mpage_readpages(struct address_space *mapping,
-				struct list_head *pages, struct page *page,
-				unsigned nr_pages, bool is_readahead);
+extern int ext4_mpage_readpages(struct address_space *mapping, pgoff_t start,
+		struct page *page, unsigned nr_pages, bool is_readahead);
 extern int __init ext4_init_post_read_processing(void);
 extern void ext4_exit_post_read_processing(void);
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3313168b680f..e1f5864e5ecf 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3218,7 +3218,7 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
 static int ext4_readpage(struct file *file, struct page *page)
 {
 	int ret = -EAGAIN;
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = file_inode(file);
 
 	trace_ext4_readpage(page);
 
@@ -3226,23 +3226,23 @@ static int ext4_readpage(struct file *file, struct page *page)
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
@@ -3587,7 +3587,7 @@ static int ext4_set_page_dirty(struct page *page)
 
 static const struct address_space_operations ext4_aops = {
 	.readpage		= ext4_readpage,
-	.readpages		= ext4_readpages,
+	.readahead		= ext4_readahead,
 	.writepage		= ext4_writepage,
 	.writepages		= ext4_writepages,
 	.write_begin		= ext4_write_begin,
@@ -3604,7 +3604,7 @@ static const struct address_space_operations ext4_aops = {
 
 static const struct address_space_operations ext4_journalled_aops = {
 	.readpage		= ext4_readpage,
-	.readpages		= ext4_readpages,
+	.readahead		= ext4_readahead,
 	.writepage		= ext4_writepage,
 	.writepages		= ext4_writepages,
 	.write_begin		= ext4_write_begin,
@@ -3620,7 +3620,7 @@ static const struct address_space_operations ext4_journalled_aops = {
 
 static const struct address_space_operations ext4_da_aops = {
 	.readpage		= ext4_readpage,
-	.readpages		= ext4_readpages,
+	.readahead		= ext4_readahead,
 	.writepage		= ext4_writepage,
 	.writepages		= ext4_writepages,
 	.write_begin		= ext4_da_write_begin,
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index c1769afbf799..aaeb298c8fdb 100644
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
@@ -221,9 +221,8 @@ static inline loff_t ext4_readpage_limit(struct inode *inode)
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
@@ -251,14 +250,10 @@ int ext4_mpage_readpages(struct address_space *mapping,
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
@@ -406,10 +401,9 @@ int ext4_mpage_readpages(struct address_space *mapping,
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
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index dc5ec724d889..40a550c0da2b 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -351,7 +351,6 @@ static int ext4_get_verity_descriptor(struct inode *inode, void *buf,
 static void ext4_merkle_tree_readahead(struct address_space *mapping,
 				       pgoff_t start_index, unsigned long count)
 {
-	LIST_HEAD(pages);
 	unsigned int nr_pages = 0;
 	struct page *page;
 	pgoff_t index;
@@ -360,16 +359,23 @@ static void ext4_merkle_tree_readahead(struct address_space *mapping,
 	for (index = start_index; index < start_index + count; index++) {
 		page = xa_load(&mapping->i_pages, index);
 		if (!page || xa_is_value(page)) {
-			page = __page_cache_alloc(readahead_gfp_mask(mapping));
+			gfp_t gfp = readahead_gfp_mask(mapping);
+			page = __page_cache_alloc(gfp);
 			if (!page)
 				break;
-			page->index = index;
-			list_add(&page->lru, &pages);
+			if (add_to_page_cache_lru(page, mapping, index, gfp)) {
+				put_page(page);
+				break;
+			}
 			nr_pages++;
 		}
 	}
+
+	if (!nr_pages)
+		return;
+
 	blk_start_plug(&plug);
-	ext4_mpage_readpages(mapping, &pages, NULL, nr_pages, true);
+	ext4_mpage_readpages(mapping, start_index, NULL, nr_pages, true);
 	blk_finish_plug(&plug);
 }
 
-- 
2.24.1

