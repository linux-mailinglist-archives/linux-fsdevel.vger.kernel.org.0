Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8E225C3BF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 16:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgICO5z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 10:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbgICOJp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:09:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66EDC0611E2
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2020 07:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=YQWDKR2b9vvYoo/rMiI9oBJwndGbzqY3ajRHCZjhecQ=; b=Hxpv/A1QHyX5wyGaacCqKEXdyT
        7UBWHqRJT5AAR5FBsHZz40q+jNgy5o8yehAVs53Ma2bTVXzb5Au4w+n2tbeuv2mvLg4BTMGplebrY
        R72HZ19jf78uv201Y0pO5V3wen70UOdslavfuTheROvj3auSFi4slknH7EDe3VULPJdLE0I+/dzGM
        A1T+DMNeGemLb/q7BRoCBxDNwPEzG9XUUM3qRws10W33tjTuQ2X8PpI8pDkBWl/zeHVstLUco9mnj
        QkbdtnsOZNg2Jt8VT9Fqjpi3ZE99q/+ZqrTIpt9UZNvAjb2Sk0dbeiPI2co6SsA0lv6MQcNUaHRaz
        wUc15O6w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDpv2-0003ib-V8; Thu, 03 Sep 2020 14:08:53 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [PATCH 7/9] mm/readahead: Add page_cache_sync_ra and page_cache_async_ra
Date:   Thu,  3 Sep 2020 15:08:42 +0100
Message-Id: <20200903140844.14194-8-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200903140844.14194-1-willy@infradead.org>
References: <20200903140844.14194-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reimplement page_cache_sync_readahead() and page_cache_async_readahead()
as wrappers around versions of the function which take a readahead_control
in preparation for making do_sync_mmap_readahead() pass down an RAC
struct.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 64 ++++++++++++++++++++++++++++++++++-------
 mm/readahead.c          | 58 ++++++++-----------------------------
 2 files changed, 66 insertions(+), 56 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 2b613c369a2f..12ab56c3a86f 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -698,16 +698,6 @@ int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask);
 void delete_from_page_cache_batch(struct address_space *mapping,
 				  struct pagevec *pvec);
 
-#define VM_READAHEAD_PAGES	(SZ_128K / PAGE_SIZE)
-
-void page_cache_sync_readahead(struct address_space *, struct file_ra_state *,
-		struct file *, pgoff_t index, unsigned long req_count);
-void page_cache_async_readahead(struct address_space *, struct file_ra_state *,
-		struct file *, struct page *, pgoff_t index,
-		unsigned long req_count);
-void page_cache_ra_unbounded(struct readahead_control *,
-		unsigned long nr_to_read, unsigned long lookahead_count);
-
 /*
  * Like add_to_page_cache_locked, but used to add newly allocated pages:
  * the page is new, so we can just run __SetPageLocked() against it.
@@ -755,6 +745,60 @@ struct readahead_control {
 		._index = i,						\
 	}
 
+#define VM_READAHEAD_PAGES	(SZ_128K / PAGE_SIZE)
+
+void page_cache_ra_unbounded(struct readahead_control *,
+		unsigned long nr_to_read, unsigned long lookahead_count);
+void page_cache_sync_ra(struct readahead_control *, struct file_ra_state *,
+		unsigned long req_count);
+void page_cache_async_ra(struct readahead_control *, struct file_ra_state *,
+		struct page *, unsigned long req_count);
+
+/**
+ * page_cache_sync_readahead - generic file readahead
+ * @mapping: address_space which holds the pagecache and I/O vectors
+ * @ra: file_ra_state which holds the readahead state
+ * @file: Used by the filesystem for authentication.
+ * @index: Index of first page to be read.
+ * @req_count: Total number of pages being read by the caller.
+ *
+ * page_cache_sync_readahead() should be called when a cache miss happened:
+ * it will submit the read.  The readahead logic may decide to piggyback more
+ * pages onto the read request if access patterns suggest it will improve
+ * performance.
+ */
+static inline
+void page_cache_sync_readahead(struct address_space *mapping,
+		struct file_ra_state *ra, struct file *file, pgoff_t index,
+		unsigned long req_count)
+{
+	DEFINE_READAHEAD(ractl, file, mapping, index);
+	page_cache_sync_ra(&ractl, ra, req_count);
+}
+
+/**
+ * page_cache_async_readahead - file readahead for marked pages
+ * @mapping: address_space which holds the pagecache and I/O vectors
+ * @ra: file_ra_state which holds the readahead state
+ * @file: Used by the filesystem for authentication.
+ * @page: The page at @index which triggered the readahead call.
+ * @index: Index of first page to be read.
+ * @req_count: Total number of pages being read by the caller.
+ *
+ * page_cache_async_readahead() should be called when a page is used which
+ * is marked as PageReadahead; this is a marker to suggest that the application
+ * has used up enough of the readahead window that we should start pulling in
+ * more pages.
+ */
+static inline
+void page_cache_async_readahead(struct address_space *mapping,
+		struct file_ra_state *ra, struct file *file,
+		struct page *page, pgoff_t index, unsigned long req_count)
+{
+	DEFINE_READAHEAD(ractl, file, mapping, index);
+	page_cache_async_ra(&ractl, ra, page, req_count);
+}
+
 /**
  * readahead_page - Get the next page to read.
  * @rac: The current readahead request.
diff --git a/mm/readahead.c b/mm/readahead.c
index 3115ced5faae..620ac83f35cc 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -550,25 +550,9 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	do_page_cache_ra(ractl, ra->size, ra->async_size);
 }
 
-/**
- * page_cache_sync_readahead - generic file readahead
- * @mapping: address_space which holds the pagecache and I/O vectors
- * @ra: file_ra_state which holds the readahead state
- * @filp: passed on to ->readpage() and ->readpages()
- * @index: Index of first page to be read.
- * @req_count: Total number of pages being read by the caller.
- *
- * page_cache_sync_readahead() should be called when a cache miss happened:
- * it will submit the read.  The readahead logic may decide to piggyback more
- * pages onto the read request if access patterns suggest it will improve
- * performance.
- */
-void page_cache_sync_readahead(struct address_space *mapping,
-			       struct file_ra_state *ra, struct file *filp,
-			       pgoff_t index, unsigned long req_count)
+void page_cache_sync_ra(struct readahead_control *ractl,
+		struct file_ra_state *ra, unsigned long req_count)
 {
-	DEFINE_READAHEAD(ractl, filp, mapping, index);
-
 	/* no read-ahead */
 	if (!ra->ra_pages)
 		return;
@@ -577,38 +561,20 @@ void page_cache_sync_readahead(struct address_space *mapping,
 		return;
 
 	/* be dumb */
-	if (filp && (filp->f_mode & FMODE_RANDOM)) {
-		force_page_cache_ra(&ractl, req_count);
+	if (ractl->file && (ractl->file->f_mode & FMODE_RANDOM)) {
+		force_page_cache_ra(ractl, req_count);
 		return;
 	}
 
 	/* do read-ahead */
-	ondemand_readahead(&ractl, ra, false, req_count);
+	ondemand_readahead(ractl, ra, false, req_count);
 }
-EXPORT_SYMBOL_GPL(page_cache_sync_readahead);
+EXPORT_SYMBOL_GPL(page_cache_sync_ra);
 
-/**
- * page_cache_async_readahead - file readahead for marked pages
- * @mapping: address_space which holds the pagecache and I/O vectors
- * @ra: file_ra_state which holds the readahead state
- * @filp: passed on to ->readpage() and ->readpages()
- * @page: The page at @index which triggered the readahead call.
- * @index: Index of first page to be read.
- * @req_count: Total number of pages being read by the caller.
- *
- * page_cache_async_readahead() should be called when a page is used which
- * is marked as PageReadahead; this is a marker to suggest that the application
- * has used up enough of the readahead window that we should start pulling in
- * more pages.
- */
-void
-page_cache_async_readahead(struct address_space *mapping,
-			   struct file_ra_state *ra, struct file *filp,
-			   struct page *page, pgoff_t index,
-			   unsigned long req_count)
+void page_cache_async_ra(struct readahead_control *ractl,
+		struct file_ra_state *ra, struct page *page,
+		unsigned long req_count)
 {
-	DEFINE_READAHEAD(ractl, filp, mapping, index);
-
 	/* no read-ahead */
 	if (!ra->ra_pages)
 		return;
@@ -624,16 +590,16 @@ page_cache_async_readahead(struct address_space *mapping,
 	/*
 	 * Defer asynchronous read-ahead on IO congestion.
 	 */
-	if (inode_read_congested(mapping->host))
+	if (inode_read_congested(ractl->mapping->host))
 		return;
 
 	if (blk_cgroup_congested())
 		return;
 
 	/* do read-ahead */
-	ondemand_readahead(&ractl, ra, true, req_count);
+	ondemand_readahead(ractl, ra, true, req_count);
 }
-EXPORT_SYMBOL_GPL(page_cache_async_readahead);
+EXPORT_SYMBOL_GPL(page_cache_async_ra);
 
 ssize_t ksys_readahead(int fd, loff_t offset, size_t count)
 {
-- 
2.28.0

