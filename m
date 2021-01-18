Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037382FA74E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 18:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406998AbhARRT2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 12:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406868AbhARRD2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:03:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF057C061799;
        Mon, 18 Jan 2021 09:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bXX3+hQnf3NuQ+rlk9aKuExUlTCGLcKGpr5DsiUhGrU=; b=LVv2zxKh7SZews7ObE6Vwq2Xdu
        kmm7pN5XWJNd6j/UvRS0RZmom6v8vbyFnDLSRfdOtmhqCrJmJBIITGYSvsXEPyxfWycYoWQCDB8Be
        9HLRvTXSm21Ont9wXs4kLTwxOdwK7DZy9Ve7XjVnYr3ikxo01+QlrNkq2WvvlxSMPoarL6wAZ5WOJ
        E37A6xwfNNgqBXG1whCs6DENufExUrnG8kV2CxGiH+eNC2RV9BvpIH7JW6SQ2KM6Sq65T2kBMqPZS
        qTAFrfATuj8UzQRBb25QcMhAzhse9Mwc+7kpDbpupgPKONIvF7XF2FHh7hj8gKs84cIxACAS/HUWU
        TPut5faw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1Xuz-00D7KR-9N; Mon, 18 Jan 2021 17:02:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/27] mm: Add unlock_folio
Date:   Mon, 18 Jan 2021 17:01:34 +0000
Message-Id: <20210118170148.3126186-14-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118170148.3126186-1-willy@infradead.org>
References: <20210118170148.3126186-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert unlock_page() to call unlock_folio().  By using a folio we avoid
a call to compound_head().  This shortens the function from 39 bytes to
25 and removes 4 instructions on x86-64.  Those instructions are currently
pushed into each caller, but subsequent patches will convert many of the
callers to operate on folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 16 +++++++++++++++-
 mm/filemap.c            | 27 ++++++++++-----------------
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index c27b74c63b5e..44675104008b 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -623,7 +623,21 @@ extern int __lock_page_killable(struct page *page);
 extern int __lock_page_async(struct page *page, struct wait_page_queue *wait);
 extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 				unsigned int flags);
-extern void unlock_page(struct page *page);
+void unlock_folio(struct folio *folio);
+
+/**
+ * unlock_page - Unlock a locked page.
+ * @page: The page.
+ *
+ * Unlocks the page and wakes up any thread sleeping on the page lock.
+ *
+ * Context: May be called from interrupt or process context.  May not be
+ * called from NMI context.
+ */
+static inline void unlock_page(struct page *page)
+{
+	return unlock_folio(page_folio(page));
+}
 
 /*
  * Return true if the page was successfully locked
diff --git a/mm/filemap.c b/mm/filemap.c
index bb28dd6d9e22..31470b36ac89 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1438,29 +1438,22 @@ static inline bool clear_bit_unlock_is_negative_byte(long nr, volatile void *mem
 #endif
 
 /**
- * unlock_page - unlock a locked page
- * @page: the page
+ * unlock_folio - Unlock a locked folio.
+ * @folio: The folio.
  *
- * Unlocks the page and wakes up sleepers in wait_on_page_locked().
- * Also wakes sleepers in wait_on_page_writeback() because the wakeup
- * mechanism between PageLocked pages and PageWriteback pages is shared.
- * But that's OK - sleepers in wait_on_page_writeback() just go back to sleep.
+ * Unlocks the folio and wakes up any thread sleeping on the page lock.
  *
- * Note that this depends on PG_waiters being the sign bit in the byte
- * that contains PG_locked - thus the BUILD_BUG_ON(). That allows us to
- * clear the PG_locked bit and test PG_waiters at the same time fairly
- * portably (architectures that do LL/SC can test any bit, while x86 can
- * test the sign bit).
+ * Context: May be called from interrupt or process context.  May not be
+ * called from NMI context.
  */
-void unlock_page(struct page *page)
+void unlock_folio(struct folio *folio)
 {
 	BUILD_BUG_ON(PG_waiters != 7);
-	page = compound_head(page);
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	if (clear_bit_unlock_is_negative_byte(PG_locked, &page->flags))
-		wake_up_page_bit(page, PG_locked);
+	VM_BUG_ON_FOLIO(!FolioLocked(folio), folio);
+	if (clear_bit_unlock_is_negative_byte(PG_locked, folio_flags(folio)))
+		wake_up_page_bit(&folio->page, PG_locked);
 }
-EXPORT_SYMBOL(unlock_page);
+EXPORT_SYMBOL(unlock_folio);
 
 /**
  * end_page_writeback - end writeback against a page
-- 
2.29.2

