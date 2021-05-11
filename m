Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123B537B16B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 00:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhEKWMP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 18:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhEKWMO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 18:12:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B2CC061574;
        Tue, 11 May 2021 15:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=lJ+yWH/42ixzn3OwMsOFN9x0u+2IeUkAMqrDQcbyCzA=; b=mwgmPPNfgIZjEOrTXoVe7X07At
        +exTZ0MK9S1sg1quYY3nzXvMB/bYSZ5uCJVdOPJq7BdzghW3wcEH5o7EuN/n3+k4pr41HNx1HoBI6
        s8I3eyxxxdvOIsgMGHTsmNrhr9hCEZXkqHfL95QDu+UZv3yrH9UaWtBvesKBXyRtAsqbMx2CPTssK
        +9ULyb0I0z1GLf4a4GtMQWKy7HnrF2CV/pWzU5FjcN07fy5bO+kJeg7HvcxhYuLeCHP8jaA5lHJLz
        h9rLnLSsUbbXTD7JC+Rcib2iyTrTmZdY3tVorzC4a5ALOmB+NMNI8H1l9+C0OxYb+XEM0MIgZ6Xdr
        LfOmZWEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgaZP-007ivO-0B; Tue, 11 May 2021 22:09:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 32/33] fs/netfs: Add folio fscache functions
Date:   Tue, 11 May 2021 22:47:34 +0100
Message-Id: <20210511214735.1836149-33-willy@infradead.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210511214735.1836149-1-willy@infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
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
index fad8c6209edd..b0bbd343fc98 100644
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
+	folio_set_private_2_flag(folio);
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

