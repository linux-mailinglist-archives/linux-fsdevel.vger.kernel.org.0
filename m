Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B9C37009D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 20:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhD3ShW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 14:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhD3ShV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 14:37:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC36C06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 11:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dZ2IK1Dw6of5c4BwCX68RJdv+iq6/fSp1N40hoMJlKM=; b=vSafSmdjP31TrVLGzsKK2iHs/V
        E7kS/CANrr5lDtnxL8rnOWhoCPlc86poYY7l/SheEd4nhfqrFaUFgLiNI4MK7Ho/pZzyqs8ihkYUg
        PyisME2oP0jasD+tGWTBQ5XUJ/g+BUgiQ7T18fZ31vHnGS5ACkpy5O1VS0i891sGJOManTfTLnA77
        DOaTmr1cstaNH4AROsON8y5cenbvozAxlFRztGQNmJgN4AlcgG1RIrcjdDq/s7ppDrd95iaI5K71z
        t9NHCa/tU43fbqh6u0kPqUtzQgXAk/hJZGZxPuvlhaI3XIjjhyi8qN0WdGr8AbRKm7j38HwNj4SJO
        YlzU419A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcXy9-00BO6r-RA; Fri, 30 Apr 2021 18:34:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v8 31/31] fs/netfs: Add folio fscache functions
Date:   Fri, 30 Apr 2021 19:07:40 +0100
Message-Id: <20210430180740.2707166-32-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210430180740.2707166-1-willy@infradead.org>
References: <20210430180740.2707166-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Match the page writeback functions by adding
folio_start_fscache(), folio_end_fscache(), folio_wait_fscache() and
folio_wait_fscache_killable().  Also rewrite the kernel-doc to describe
when to use the function rather than what the function does, and include
the kernel-doc in the appropriate rst file.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/netfs_library.rst |  2 +
 include/linux/netfs.h                       | 75 +++++++++++++--------
 2 files changed, 50 insertions(+), 27 deletions(-)

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
index fad8c6209edd..ea0bb793ac98 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -22,6 +22,7 @@
  * Overload PG_private_2 to give us PG_fscache - this is used to indicate that
  * a page is currently backed by a local disk cache
  */
+#define folio_fscache(folio)		folio_private_2(folio)
 #define PageFsCache(page)		PagePrivate2((page))
 #define SetPageFsCache(page)		SetPagePrivate2((page))
 #define ClearPageFsCache(page)		ClearPagePrivate2((page))
@@ -29,57 +30,77 @@
 #define TestClearPageFsCache(page)	TestClearPagePrivate2((page))
 
 /**
- * set_page_fscache - Set PG_fscache on a page and take a ref
- * @page: The page.
+ * folio_start_fscache - Start an fscache operation on a folio.
+ * @folio: The folio.
  *
- * Set the PG_fscache (PG_private_2) flag on a page and take the reference
- * needed for the VM to handle its lifetime correctly.  This sets the flag and
- * takes the reference unconditionally, so care must be taken not to set the
- * flag again if it's already set.
+ * Call this function before an fscache operation starts on a folio.
+ * Starting a second fscache operation before the first one finishes is
+ * not allowed.
  */
-static inline void set_page_fscache(struct page *page)
+static inline void folio_start_fscache(struct folio *folio)
 {
-	set_page_private_2(page);
+	VM_BUG_ON_FOLIO(folio_private_2(folio), folio);
+	folio_get(folio);
+	folio_set_private_2(folio);
 }
 
 /**
- * end_page_fscache - Clear PG_fscache and release any waiters
- * @page: The page
- *
- * Clear the PG_fscache (PG_private_2) bit on a page and wake up any sleepers
- * waiting for this.  The page ref held for PG_private_2 being set is released.
+ * folio_end_fscache - End an fscache operation on a folio.
+ * @folio: The folio.
  *
- * This is, for example, used when a netfs page is being written to a local
- * disk cache, thereby allowing writes to the cache for the same page to be
- * serialised.
+ * Call this function after an fscache operation has finished.  This will
+ * wake any sleepers waiting on this folio.
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
+ * folio_wait_fscache - Wait for an fscache operation on this folio to end.
+ * @folio: The folio.
  *
- * Wait for PG_fscache (aka PG_private_2) to be cleared on a page.
+ * If an fscache operation is in progress on this folio, wait for it to
+ * finish.  Another fscache operation may start after this one finishes,
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
+ * folio_wait_fscache_killable - Wait for an fscache operation on this folio to end.
+ * @folio: The folio.
  *
- * Wait for PG_fscache (aka PG_private_2) to be cleared on a page or until a
- * fatal signal is received by the calling task.
+ * If an fscache operation is in progress on this folio, wait for it to
+ * finish or for a fatal signal to be received.  Another fscache operation
+ * may start after this one finishes, unless the caller holds the folio lock.
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
-- 
2.30.2

