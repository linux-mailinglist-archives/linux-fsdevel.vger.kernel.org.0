Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E894625C3BC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 16:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgICO5l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 10:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbgICOJp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:09:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B97C0611E1
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2020 07:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FAQq0JHC+4hBhk6kiejCxxwB+HjKmiOQ1xHYoMPYFW8=; b=izOi1HE9F1UVZ23XIRcDn1FSVU
        9ClxTYLwWTGxrf7nIpjw64ehdbeLRkP6zB2Pd3gTAEgMpkLfsPhRTY/0r9DAJoYQfwV+o0h46dTgh
        VBvwgPi2cIAe7vH4F39zslZkN4KgKN3LQzQIGaHs2DLlM6Wq4VY0R+SV2vAszklB4sDmMpYXY1KMo
        HAp3gmNckQieD++cooypXFP9f7JmgVKsbmgiTt5CHeFg5jWveUMWXhnTX1G/WqSIM1TF2e9wN78VB
        3BESx4U3hP2Krmcyz1K10gmx081zM017eI33LhuFbOZb0vv9fGklMi/ufZpi2SEMcOsYWcX3kJAKO
        TH5QjRig==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDpv1-0003i6-Pg; Thu, 03 Sep 2020 14:08:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [PATCH 3/9] mm/readahead: Make page_cache_ra_unbounded take a readahead_control
Date:   Thu,  3 Sep 2020 15:08:38 +0100
Message-Id: <20200903140844.14194-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200903140844.14194-1-willy@infradead.org>
References: <20200903140844.14194-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Define it in the callers instead of in page_cache_ra_unbounded().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/verity.c        |  4 ++--
 fs/f2fs/verity.c        |  4 ++--
 include/linux/pagemap.h |  5 ++---
 mm/readahead.c          | 30 ++++++++++++++----------------
 4 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index bbd5e7e0632b..5b7ba8f71153 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -349,6 +349,7 @@ static struct page *ext4_read_merkle_tree_page(struct inode *inode,
 					       pgoff_t index,
 					       unsigned long num_ra_pages)
 {
+	DEFINE_READAHEAD(ractl, NULL, inode->i_mapping, index);
 	struct page *page;
 
 	index += ext4_verity_metadata_pos(inode) >> PAGE_SHIFT;
@@ -358,8 +359,7 @@ static struct page *ext4_read_merkle_tree_page(struct inode *inode,
 		if (page)
 			put_page(page);
 		else if (num_ra_pages > 1)
-			page_cache_readahead_unbounded(inode->i_mapping, NULL,
-					index, num_ra_pages, 0);
+			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
 		page = read_mapping_page(inode->i_mapping, index, NULL);
 	}
 	return page;
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 9eb0dba851e8..054ec852b5ea 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -228,6 +228,7 @@ static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
 					       pgoff_t index,
 					       unsigned long num_ra_pages)
 {
+	DEFINE_READAHEAD(ractl, NULL, inode->i_mapping, index);
 	struct page *page;
 
 	index += f2fs_verity_metadata_pos(inode) >> PAGE_SHIFT;
@@ -237,8 +238,7 @@ static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
 		if (page)
 			put_page(page);
 		else if (num_ra_pages > 1)
-			page_cache_readahead_unbounded(inode->i_mapping, NULL,
-					index, num_ra_pages, 0);
+			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
 		page = read_mapping_page(inode->i_mapping, index, NULL);
 	}
 	return page;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 19bba4360436..2b613c369a2f 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -705,9 +705,8 @@ void page_cache_sync_readahead(struct address_space *, struct file_ra_state *,
 void page_cache_async_readahead(struct address_space *, struct file_ra_state *,
 		struct file *, struct page *, pgoff_t index,
 		unsigned long req_count);
-void page_cache_readahead_unbounded(struct address_space *, struct file *,
-		pgoff_t index, unsigned long nr_to_read,
-		unsigned long lookahead_count);
+void page_cache_ra_unbounded(struct readahead_control *,
+		unsigned long nr_to_read, unsigned long lookahead_count);
 
 /*
  * Like add_to_page_cache_locked, but used to add newly allocated pages:
diff --git a/mm/readahead.c b/mm/readahead.c
index 2126a2754e22..a444943781bb 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -158,10 +158,8 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages,
 }
 
 /**
- * page_cache_readahead_unbounded - Start unchecked readahead.
- * @mapping: File address space.
- * @file: This instance of the open file; used for authentication.
- * @index: First page index to read.
+ * page_cache_ra_unbounded - Start unchecked readahead.
+ * @ractl: Readahead control.
  * @nr_to_read: The number of pages to read.
  * @lookahead_size: Where to start the next readahead.
  *
@@ -173,13 +171,13 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages,
  * Context: File is referenced by caller.  Mutexes may be held by caller.
  * May sleep, but will not reenter filesystem to reclaim memory.
  */
-void page_cache_readahead_unbounded(struct address_space *mapping,
-		struct file *file, pgoff_t index, unsigned long nr_to_read,
-		unsigned long lookahead_size)
+void page_cache_ra_unbounded(struct readahead_control *ractl,
+		unsigned long nr_to_read, unsigned long lookahead_size)
 {
+	struct address_space *mapping = ractl->mapping;
+	unsigned long index = readahead_index(ractl);
 	LIST_HEAD(page_pool);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
-	DEFINE_READAHEAD(rac, file, mapping, index);
 	unsigned long i;
 
 	/*
@@ -200,7 +198,7 @@ void page_cache_readahead_unbounded(struct address_space *mapping,
 	for (i = 0; i < nr_to_read; i++) {
 		struct page *page = xa_load(&mapping->i_pages, index + i);
 
-		BUG_ON(index + i != rac._index + rac._nr_pages);
+		BUG_ON(index + i != ractl->_index + ractl->_nr_pages);
 
 		if (page && !xa_is_value(page)) {
 			/*
@@ -211,7 +209,7 @@ void page_cache_readahead_unbounded(struct address_space *mapping,
 			 * have a stable reference to this page, and it's
 			 * not worth getting one just for that.
 			 */
-			read_pages(&rac, &page_pool, true);
+			read_pages(ractl, &page_pool, true);
 			continue;
 		}
 
@@ -224,12 +222,12 @@ void page_cache_readahead_unbounded(struct address_space *mapping,
 		} else if (add_to_page_cache_lru(page, mapping, index + i,
 					gfp_mask) < 0) {
 			put_page(page);
-			read_pages(&rac, &page_pool, true);
+			read_pages(ractl, &page_pool, true);
 			continue;
 		}
 		if (i == nr_to_read - lookahead_size)
 			SetPageReadahead(page);
-		rac._nr_pages++;
+		ractl->_nr_pages++;
 	}
 
 	/*
@@ -237,10 +235,10 @@ void page_cache_readahead_unbounded(struct address_space *mapping,
 	 * uptodate then the caller will launch readpage again, and
 	 * will then handle the error.
 	 */
-	read_pages(&rac, &page_pool, false);
+	read_pages(ractl, &page_pool, false);
 	memalloc_nofs_restore(nofs);
 }
-EXPORT_SYMBOL_GPL(page_cache_readahead_unbounded);
+EXPORT_SYMBOL_GPL(page_cache_ra_unbounded);
 
 /*
  * __do_page_cache_readahead() actually reads a chunk of disk.  It allocates
@@ -252,6 +250,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
 		struct file *file, pgoff_t index, unsigned long nr_to_read,
 		unsigned long lookahead_size)
 {
+	DEFINE_READAHEAD(ractl, file, mapping, index);
 	struct inode *inode = mapping->host;
 	loff_t isize = i_size_read(inode);
 	pgoff_t end_index;	/* The last page we want to read */
@@ -266,8 +265,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	if (nr_to_read > end_index - index)
 		nr_to_read = end_index - index + 1;
 
-	page_cache_readahead_unbounded(mapping, file, index, nr_to_read,
-			lookahead_size);
+	page_cache_ra_unbounded(&ractl, nr_to_read, lookahead_size);
 }
 
 /*
-- 
2.28.0

