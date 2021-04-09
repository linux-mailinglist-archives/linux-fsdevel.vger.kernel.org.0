Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E80C35A6BA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 21:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbhDITKD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 15:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbhDITKC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 15:10:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA21C061762;
        Fri,  9 Apr 2021 12:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jzCo+pBb6RjK6WTBBYJ8+V5wTDdpVkn59I9euqlG9VI=; b=hwrQz1i+Pi2KkqfYXslso+Ig6D
        dv0PMP/SJGM8vtNGVnhH0kWgCU0jogSjz7SWea66OwG/hOGpax19VCdUcV9mDDn1H8GM12dZWeKOv
        kc+UOQvfhTVl9bg8a568DpcLRUhuI3r12PeeCa9A7mscZ4CmIrodIbrFrVkkC77/F/mctMcvy8Kql
        RmdpDi7G1oV1MMu+ZlqUVSWWY2P8Q9V88Y7oA1R2XzOHXqdchyy2wZlw3iB/XSvo1c4SszFBUYX+B
        MD3Q6MximzRpsaSMgu9m6wNTEtv+gEkGdHfMbj+sK722rHX8AuON5M2y1rv0hh15jmom/2MWjEUeM
        3SQi0W6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUwUb-000oWG-Gc; Fri, 09 Apr 2021 19:08:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v7 23/28] mm/filemap: Add end_folio_writeback
Date:   Fri,  9 Apr 2021 19:51:00 +0100
Message-Id: <20210409185105.188284-24-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210409185105.188284-1-willy@infradead.org>
References: <20210409185105.188284-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an end_page_writeback() wrapper function for users that are not yet
converted to folios.

end_folio_writeback() is less than half the size of end_page_writeback()
at just 105 bytes compared to 213 bytes, due to removing all the
compound_head() calls.  The 30 byte wrapper function makes this a net
saving of 70 bytes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/pagemap.h |  3 ++-
 mm/filemap.c            | 38 +++++++++++++++++++-------------------
 mm/folio-compat.c       |  6 ++++++
 3 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 18c4c2ae8074..9bc01429dc25 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -829,7 +829,8 @@ static inline int wait_on_page_locked_killable(struct page *page)
 int put_and_wait_on_page_locked(struct page *page, int state);
 void wait_on_page_writeback(struct page *page);
 int wait_on_page_writeback_killable(struct page *page);
-extern void end_page_writeback(struct page *page);
+void end_page_writeback(struct page *page);
+void end_folio_writeback(struct folio *folio);
 void wait_for_stable_page(struct page *page);
 
 void page_endio(struct page *page, bool is_write, int err);
diff --git a/mm/filemap.c b/mm/filemap.c
index d23430ad5bbc..cdb8250af510 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1175,11 +1175,11 @@ static void wake_up_page_bit(struct page *page, int bit_nr)
 	spin_unlock_irqrestore(&q->lock, flags);
 }
 
-static void wake_up_page(struct page *page, int bit)
+static void wake_up_folio(struct folio *folio, int bit)
 {
-	if (!PageWaiters(page))
+	if (!FolioWaiters(folio))
 		return;
-	wake_up_page_bit(page, bit);
+	wake_up_page_bit(&folio->page, bit);
 }
 
 /*
@@ -1512,38 +1512,38 @@ int wait_on_page_private_2_killable(struct page *page)
 EXPORT_SYMBOL(wait_on_page_private_2_killable);
 
 /**
- * end_page_writeback - end writeback against a page
- * @page: the page
+ * end_folio_writeback - End writeback against a folio.
+ * @folio: The folio.
  */
-void end_page_writeback(struct page *page)
+void end_folio_writeback(struct folio *folio)
 {
 	/*
 	 * TestClearPageReclaim could be used here but it is an atomic
 	 * operation and overkill in this particular case. Failing to
-	 * shuffle a page marked for immediate reclaim is too mild to
+	 * shuffle a folio marked for immediate reclaim is too mild to
 	 * justify taking an atomic operation penalty at the end of
-	 * ever page writeback.
+	 * every folio writeback.
 	 */
-	if (PageReclaim(page)) {
-		ClearPageReclaim(page);
-		rotate_reclaimable_page(page);
+	if (FolioReclaim(folio)) {
+		ClearFolioReclaim(folio);
+		rotate_reclaimable_page(&folio->page);
 	}
 
 	/*
-	 * Writeback does not hold a page reference of its own, relying
+	 * Writeback does not hold a folio reference of its own, relying
 	 * on truncation to wait for the clearing of PG_writeback.
-	 * But here we must make sure that the page is not freed and
-	 * reused before the wake_up_page().
+	 * But here we must make sure that the folio is not freed and
+	 * reused before the wake_up_folio().
 	 */
-	get_page(page);
-	if (!test_clear_page_writeback(page))
+	get_folio(folio);
+	if (!test_clear_page_writeback(&folio->page))
 		BUG();
 
 	smp_mb__after_atomic();
-	wake_up_page(page, PG_writeback);
-	put_page(page);
+	wake_up_folio(folio, PG_writeback);
+	put_folio(folio);
 }
-EXPORT_SYMBOL(end_page_writeback);
+EXPORT_SYMBOL(end_folio_writeback);
 
 /*
  * After completing I/O on a page, call this routine to update the page
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 02798abf19a1..d1a1dfe52589 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -17,3 +17,9 @@ void unlock_page(struct page *page)
 	return unlock_folio(page_folio(page));
 }
 EXPORT_SYMBOL(unlock_page);
+
+void end_page_writeback(struct page *page)
+{
+	return end_folio_writeback(page_folio(page));
+}
+EXPORT_SYMBOL(end_page_writeback);
-- 
2.30.2

