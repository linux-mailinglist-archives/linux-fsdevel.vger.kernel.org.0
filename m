Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77A82DC635
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 19:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbgLPSYv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 13:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730360AbgLPSYT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:24:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F9DC0617B0;
        Wed, 16 Dec 2020 10:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=02W9frCE4IO4n9Ugezl8wZx7eesn2EplgZ4NP74A3Qc=; b=DpRf1pyn1/Opx0SKW7e3x7adMp
        gFl/o+Cw1knrDwjRD+QI2QIb5SZJD+dhwTBlKBVm21X4J/p6LVIFf6B8Ts3I4vtkNOenu0LC7RV/x
        wpzYgOMbAQZXJoBBm0xNEKt/U0i0CuR4fJDPAE7TNVOea9M+TGGDEVSwrFwl8IkjoozvsxvIyxO2N
        QiqgkCAhxZwt4pS3896SE+zNB/CBG99tGgTURg2o9Z8C0F2ArtAnlOlKVPTxjsy9gurUgbc/92Jwy
        YgTqZJdOtCtkuyS80bxs1XtuynnY7l+5fmXKQHWLAvz1yVNbRQtEdDPmatB17fQp6PMdF6lB9ZfH/
        q1BXUpAw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpbSb-00076L-Ql; Wed, 16 Dec 2020 18:23:37 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/25] mm: Add unlock_folio
Date:   Wed, 16 Dec 2020 18:23:15 +0000
Message-Id: <20201216182335.27227-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201216182335.27227-1-willy@infradead.org>
References: <20201216182335.27227-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert unlock_page() to call unlock_folio().  By using a folio we avoid
doing a repeated compound_head() This shortens the function from 120
bytes to 76 bytes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 16 +++++++++++++++-
 mm/filemap.c            | 27 ++++++++++-----------------
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index b5af2c3719ab..83786e7eeb23 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -604,7 +604,21 @@ extern int __lock_page_killable(struct page *page);
 extern int __lock_page_async(struct page *page, struct wait_page_queue *wait);
 extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 				unsigned int flags);
-extern void unlock_page(struct page *page);
+extern void unlock_folio(struct folio *folio);
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
index 13ef23f72330..8af89ecc1452 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1443,29 +1443,22 @@ static inline bool clear_bit_unlock_is_negative_byte(long nr, volatile void *mem
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
+	VM_BUG_ON_PAGE(!FolioLocked(folio), &folio->page);
+	if (clear_bit_unlock_is_negative_byte(PG_locked, folio_flags(folio)))
+		wake_up_page_bit(&folio->page, PG_locked);
 }
-EXPORT_SYMBOL(unlock_page);
+EXPORT_SYMBOL(unlock_folio);
 
 /**
  * end_page_writeback - end writeback against a page
-- 
2.29.2

