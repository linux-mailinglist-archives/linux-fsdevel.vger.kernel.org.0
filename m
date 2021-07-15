Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979123C96DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhGOEG2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbhGOEG2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:06:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA402C06175F;
        Wed, 14 Jul 2021 21:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bKWRwLOIt1ttjlVihKsRpElpi9XSK8qH7EZQbsN6S1c=; b=H2aE0EVGHT4uw8RxOHvzk3pBt2
        ciCzSOVduc5JmmzDVCyDGWUDtZvFYZ0yr6PKDSeY4YHhHunOc2G6554wGuxh/4ZQugWZoWcWU0aS5
        Whh4D6fHT+1WK6nA5z/bL/mzMX9QEr/Lgu193hZG3r8J8n1Z0RYYFpzxo35RLmRSQv524MUMfPj1T
        NMpM3fWoXgSYMiLssR54aP4+je/GzsFTAkt8vlc7nj647FZE9bkXcNuO7Wjo3+6aOEuUhXm5ZN03R
        wSThbds5tIZbK0PF/sHbg8k53/pL7dYXfSrZRVpJgTSVexJ7DGnwOrfYpvDXZWbqHpUwShFcQEo5J
        +2Hoiq6g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3sZZ-002vl2-EU; Thu, 15 Jul 2021 04:02:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v14 031/138] fs/netfs: Add folio fscache functions
Date:   Thu, 15 Jul 2021 04:35:17 +0100
Message-Id: <20210715033704.692967-32-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Match the page writeback functions by adding
folio_start_fscache(), folio_end_fscache(), folio_wait_fscache() and
folio_wait_fscache_killable().  Remove set_page_private_2().  Also rewrite
the kernel-doc to describe when to use the function rather than what the
function does, and include the kernel-doc in the appropriate rst file.
Saves 31 bytes of text in netfs_rreq_unlock() due to set_page_fscache()
calling page_folio() once instead of three times.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 Documentation/filesystems/netfs_library.rst |  2 +
 include/linux/netfs.h                       | 75 +++++++++++++--------
 include/linux/pagemap.h                     | 16 -----
 3 files changed, 50 insertions(+), 43 deletions(-)

diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index 57a641847818..bb68d39f03b7 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -524,3 +524,5 @@ Note that these methods are passed a pointer to the cache resource structure,
 not the read request structure as they could be used in other situations where
 there isn't a read request structure as well, such as writing dirty data to the
 cache.
+
+.. kernel-doc:: include/linux/netfs.h
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index fad8c6209edd..e03ed7fc3aef 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -22,6 +22,7 @@
  * Overload PG_private_2 to give us PG_fscache - this is used to indicate that
  * a page is currently backed by a local disk cache
  */
+#define folio_test_fscache(folio)	folio_test_private_2(folio)
 #define PageFsCache(page)		PagePrivate2((page))
 #define SetPageFsCache(page)		SetPagePrivate2((page))
 #define ClearPageFsCache(page)		ClearPagePrivate2((page))
@@ -29,57 +30,77 @@
 #define TestClearPageFsCache(page)	TestClearPagePrivate2((page))
 
 /**
- * set_page_fscache - Set PG_fscache on a page and take a ref
- * @page: The page.
+ * folio_start_fscache - Start an fscache write on a folio.
+ * @folio: The folio.
  *
- * Set the PG_fscache (PG_private_2) flag on a page and take the reference
- * needed for the VM to handle its lifetime correctly.  This sets the flag and
- * takes the reference unconditionally, so care must be taken not to set the
- * flag again if it's already set.
+ * Call this function before writing a folio to a local cache.  Starting a
+ * second write before the first one finishes is not allowed.
  */
-static inline void set_page_fscache(struct page *page)
+static inline void folio_start_fscache(struct folio *folio)
 {
-	set_page_private_2(page);
+	VM_BUG_ON_FOLIO(folio_test_private_2(folio), folio);
+	folio_get(folio);
+	folio_set_private_2_flag(folio);
 }
 
 /**
- * end_page_fscache - Clear PG_fscache and release any waiters
- * @page: The page
- *
- * Clear the PG_fscache (PG_private_2) bit on a page and wake up any sleepers
- * waiting for this.  The page ref held for PG_private_2 being set is released.
+ * folio_end_fscache - End an fscache write on a folio.
+ * @folio: The folio.
  *
- * This is, for example, used when a netfs page is being written to a local
- * disk cache, thereby allowing writes to the cache for the same page to be
- * serialised.
+ * Call this function after the folio has been written to the local cache.
+ * This will wake any sleepers waiting on this folio.
  */
-static inline void end_page_fscache(struct page *page)
+static inline void folio_end_fscache(struct folio *folio)
 {
-	folio_end_private_2(page_folio(page));
+	folio_end_private_2(folio);
 }
 
 /**
- * wait_on_page_fscache - Wait for PG_fscache to be cleared on a page
- * @page: The page to wait on
+ * folio_wait_fscache - Wait for an fscache write on this folio to end.
+ * @folio: The folio.
  *
- * Wait for PG_fscache (aka PG_private_2) to be cleared on a page.
+ * If this folio is currently being written to a local cache, wait for
+ * the write to finish.  Another write may start after this one finishes,
+ * unless the caller holds the folio lock.
  */
-static inline void wait_on_page_fscache(struct page *page)
+static inline void folio_wait_fscache(struct folio *folio)
 {
-	folio_wait_private_2(page_folio(page));
+	folio_wait_private_2(folio);
 }
 
 /**
- * wait_on_page_fscache_killable - Wait for PG_fscache to be cleared on a page
- * @page: The page to wait on
+ * folio_wait_fscache_killable - Wait for an fscache write on this folio to end.
+ * @folio: The folio.
  *
- * Wait for PG_fscache (aka PG_private_2) to be cleared on a page or until a
- * fatal signal is received by the calling task.
+ * If this folio is currently being written to a local cache, wait
+ * for the write to finish or for a fatal signal to be received.
+ * Another write may start after this one finishes, unless the caller
+ * holds the folio lock.
  *
  * Return:
  * - 0 if successful.
  * - -EINTR if a fatal signal was encountered.
  */
+static inline int folio_wait_fscache_killable(struct folio *folio)
+{
+	return folio_wait_private_2_killable(folio);
+}
+
+static inline void set_page_fscache(struct page *page)
+{
+	folio_start_fscache(page_folio(page));
+}
+
+static inline void end_page_fscache(struct page *page)
+{
+	folio_end_private_2(page_folio(page));
+}
+
+static inline void wait_on_page_fscache(struct page *page)
+{
+	folio_wait_private_2(page_folio(page));
+}
+
 static inline int wait_on_page_fscache_killable(struct page *page)
 {
 	return folio_wait_private_2_killable(page_folio(page));
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index edf58a581bce..08f40e004d97 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -780,22 +780,6 @@ int __set_page_dirty_no_writeback(struct page *page);
 
 void page_endio(struct page *page, bool is_write, int err);
 
-/**
- * set_page_private_2 - Set PG_private_2 on a page and take a ref
- * @page: The page.
- *
- * Set the PG_private_2 flag on a page and take the reference needed for the VM
- * to handle its lifetime correctly.  This sets the flag and takes the
- * reference unconditionally, so care must be taken not to set the flag again
- * if it's already set.
- */
-static inline void set_page_private_2(struct page *page)
-{
-	page = compound_head(page);
-	get_page(page);
-	SetPagePrivate2(page);
-}
-
 void folio_end_private_2(struct folio *folio);
 void folio_wait_private_2(struct folio *folio);
 int folio_wait_private_2_killable(struct folio *folio);
-- 
2.30.2

