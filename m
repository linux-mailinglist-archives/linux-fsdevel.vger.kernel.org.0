Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571173A707B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 22:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbhFNUe2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 16:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbhFNUe1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 16:34:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A45C061574;
        Mon, 14 Jun 2021 13:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=QxTx6Q7R4IUkk3PmXW9baVxVNESZdtfbzjBXV29RL7o=; b=EAADlyNLzWIS/2P7BbQFMoavXe
        TytHgcVVoJANqC6t+o/N5rFou4s8w0yA3Ojd17+3P1a/UILssNaBEkWJ5Iw+ibPEBxu5aej2WmJpA
        SLUS0d61RG0eXm2ysfgpBVeIhMoFegGtk11s0VvMOOdkAofcgjGnJl0enG8nucqMBqOSNjis0J9wb
        EUPGXhRXMRkcAMyuZ+gvwIm4B5v4lA+4IVRkea5FjuxyOigXCa2deUn5CRe1wistKfP4kz6n8iGci
        3jR12yELWsUDdcD6Cy1C1dOfeOhbtNkctZ/fwOPWfwNSgG9oiQmfUjyTFa5M/Y2vrypyc/35PWduw
        PZr68Ppg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lstEn-005oEK-Ck; Mon, 14 Jun 2021 20:31:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v11 27/33] mm/writeback: Add folio_wait_stable()
Date:   Mon, 14 Jun 2021 21:14:29 +0100
Message-Id: <20210614201435.1379188-28-willy@infradead.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210614201435.1379188-1-willy@infradead.org>
References: <20210614201435.1379188-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move wait_for_stable_page() into the folio compatibility file.
folio_wait_stable() avoids a call to compound_head() and is 14 bytes
smaller than wait_for_stable_page() was.  The net text size grows by 16
bytes as a result of this patch.  We can also remove thp_head() as this
was the last user.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/huge_mm.h | 15 ---------------
 include/linux/pagemap.h |  1 +
 mm/folio-compat.c       |  6 ++++++
 mm/page-writeback.c     | 24 ++++++++++++++----------
 4 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 9626fda5efce..406e7d841fa8 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -245,15 +245,6 @@ static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 		return NULL;
 }
 
-/**
- * thp_head - Head page of a transparent huge page.
- * @page: Any page (tail, head or regular) found in the page cache.
- */
-static inline struct page *thp_head(struct page *page)
-{
-	return compound_head(page);
-}
-
 /**
  * thp_order - Order of a transparent huge page.
  * @page: Head page of a transparent huge page.
@@ -330,12 +321,6 @@ static inline struct list_head *page_deferred_list(struct page *page)
 #define HPAGE_PUD_MASK ({ BUILD_BUG(); 0; })
 #define HPAGE_PUD_SIZE ({ BUILD_BUG(); 0; })
 
-static inline struct page *thp_head(struct page *page)
-{
-	VM_BUG_ON_PGFLAGS(PageTail(page), page);
-	return page;
-}
-
 static inline unsigned int thp_order(struct page *page)
 {
 	VM_BUG_ON_PGFLAGS(PageTail(page), page);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 341720c8ab56..8e31a02d3a56 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -760,6 +760,7 @@ int folio_wait_writeback_killable(struct folio *folio);
 void end_page_writeback(struct page *page);
 void folio_end_writeback(struct folio *folio);
 void wait_for_stable_page(struct page *page);
+void folio_wait_stable(struct folio *folio);
 
 void page_endio(struct page *page, bool is_write, int err);
 
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 41275dac7a92..3c83f03b80d7 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -29,3 +29,9 @@ void wait_on_page_writeback(struct page *page)
 	return folio_wait_writeback(page_folio(page));
 }
 EXPORT_SYMBOL_GPL(wait_on_page_writeback);
+
+void wait_for_stable_page(struct page *page)
+{
+	return folio_wait_stable(page_folio(page));
+}
+EXPORT_SYMBOL_GPL(wait_for_stable_page);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index c8bc78cd0f2b..8b15c44552f7 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2865,17 +2865,21 @@ int folio_wait_writeback_killable(struct folio *folio)
 EXPORT_SYMBOL_GPL(folio_wait_writeback_killable);
 
 /**
- * wait_for_stable_page() - wait for writeback to finish, if necessary.
- * @page:	The page to wait on.
+ * folio_wait_stable() - wait for writeback to finish, if necessary.
+ * @folio: The folio to wait on.
  *
- * This function determines if the given page is related to a backing device
- * that requires page contents to be held stable during writeback.  If so, then
- * it will wait for any pending writeback to complete.
+ * This function determines if the given folio is related to a backing
+ * device that requires folio contents to be held stable during writeback.
+ * If so, then it will wait for any pending writeback to complete.
+ *
+ * Context: Sleeps.  Must be called in process context and with
+ * no spinlocks held.  Caller should hold a reference on the folio.
+ * If the folio is not locked, writeback may start again after writeback
+ * has finished.
  */
-void wait_for_stable_page(struct page *page)
+void folio_wait_stable(struct folio *folio)
 {
-	page = thp_head(page);
-	if (page->mapping->host->i_sb->s_iflags & SB_I_STABLE_WRITES)
-		wait_on_page_writeback(page);
+	if (folio->mapping->host->i_sb->s_iflags & SB_I_STABLE_WRITES)
+		folio_wait_writeback(folio);
 }
-EXPORT_SYMBOL_GPL(wait_for_stable_page);
+EXPORT_SYMBOL_GPL(folio_wait_stable);
-- 
2.30.2

