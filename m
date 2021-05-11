Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E3D37B14B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 00:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhEKWG0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 18:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhEKWG0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 18:06:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6DFC061574;
        Tue, 11 May 2021 15:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nIZShmYsPuYB9rPBwX4iyyvZK+ewt/FxGHXsAdEMvzA=; b=JZJcUExtjdznc/NI0YjcG4ekDE
        MkGczXV24BgDzpZIX+J3Y4rXxN568VM6nEq1N5by7esY/aBpQlKyj4njJ95wjTqxYgzSGWVmUfodt
        rkJPiOcSyL8ahAw26uo2aTcl7Vdf2gTrbVv5jboSqXsNODa1X2Tex0E7OECgMGFcB5rx2fL5lBLnD
        zlqrh1HiIB0hxvT1nhm9ySvA/FpFRnZ8NVgdrcJhN0rVSB8YWwwIOQSabaJaJRNChbsc2bLB3TdoB
        ZC36l1p4aP2Q2Jg8tPMz2sKF36yue1WqBLJgpzASr/rx3+2PV+O84JNJshDWGFcoP4zlssaKo60Nj
        WDAT5NmA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgaTn-007iZv-Qu; Tue, 11 May 2021 22:04:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v10 25/33] mm/filemap: Add folio_end_writeback
Date:   Tue, 11 May 2021 22:47:27 +0100
Message-Id: <20210511214735.1836149-26-willy@infradead.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210511214735.1836149-1-willy@infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an end_page_writeback() wrapper function for users that are not yet
converted to folios.

folio_end_writeback() is less than half the size of end_page_writeback()
at just 105 bytes compared to 213 bytes, due to removing all the
compound_head() calls.  The 30 byte wrapper function makes this a net
saving of 70 bytes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/pagemap.h |  3 ++-
 mm/filemap.c            | 40 ++++++++++++++++++++--------------------
 mm/folio-compat.c       |  6 ++++++
 3 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index e2648d906a84..cbd86c952e25 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -753,7 +753,8 @@ static inline int wait_on_page_locked_killable(struct page *page)
 int put_and_wait_on_page_locked(struct page *page, int state);
 void wait_on_page_writeback(struct page *page);
 int wait_on_page_writeback_killable(struct page *page);
-extern void end_page_writeback(struct page *page);
+void end_page_writeback(struct page *page);
+void folio_end_writeback(struct folio *folio);
 void wait_for_stable_page(struct page *page);
 
 void page_endio(struct page *page, bool is_write, int err);
diff --git a/mm/filemap.c b/mm/filemap.c
index 63654a2f7d56..62312edba8ce 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1175,11 +1175,11 @@ static void wake_up_page_bit(struct page *page, int bit_nr)
 	spin_unlock_irqrestore(&q->lock, flags);
 }
 
-static void wake_up_page(struct page *page, int bit)
+static void folio_wake(struct folio *folio, int bit)
 {
-	if (!PageWaiters(page))
+	if (!folio_waiters(folio))
 		return;
-	wake_up_page_bit(page, bit);
+	wake_up_page_bit(&folio->page, bit);
 }
 
 /*
@@ -1514,38 +1514,38 @@ int wait_on_page_private_2_killable(struct page *page)
 EXPORT_SYMBOL(wait_on_page_private_2_killable);
 
 /**
- * end_page_writeback - end writeback against a page
- * @page: the page
+ * folio_end_writeback - End writeback against a folio.
+ * @folio: The folio.
  */
-void end_page_writeback(struct page *page)
+void folio_end_writeback(struct folio *folio)
 {
 	/*
-	 * TestClearPageReclaim could be used here but it is an atomic
+	 * folio_test_clear_reclaim_flag() could be used here but it is an atomic
 	 * operation and overkill in this particular case. Failing to
-	 * shuffle a page marked for immediate reclaim is too mild to
+	 * shuffle a folio marked for immediate reclaim is too mild to
 	 * justify taking an atomic operation penalty at the end of
-	 * ever page writeback.
+	 * every folio writeback.
 	 */
-	if (PageReclaim(page)) {
-		ClearPageReclaim(page);
-		folio_rotate_reclaimable(page_folio(page));
+	if (folio_reclaim(folio)) {
+		folio_clear_reclaim_flag(folio);
+		folio_rotate_reclaimable(folio);
 	}
 
 	/*
-	 * Writeback does not hold a page reference of its own, relying
+	 * Writeback does not hold a folio reference of its own, relying
 	 * on truncation to wait for the clearing of PG_writeback.
-	 * But here we must make sure that the page is not freed and
-	 * reused before the wake_up_page().
+	 * But here we must make sure that the folio is not freed and
+	 * reused before the folio_wake().
 	 */
-	get_page(page);
-	if (!test_clear_page_writeback(page))
+	folio_get(folio);
+	if (!test_clear_page_writeback(&folio->page))
 		BUG();
 
 	smp_mb__after_atomic();
-	wake_up_page(page, PG_writeback);
-	put_page(page);
+	folio_wake(folio, PG_writeback);
+	folio_put(folio);
 }
-EXPORT_SYMBOL(end_page_writeback);
+EXPORT_SYMBOL(folio_end_writeback);
 
 /*
  * After completing I/O on a page, call this routine to update the page
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 91b3d00a92f7..526843d03d58 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -17,3 +17,9 @@ void unlock_page(struct page *page)
 	return folio_unlock(page_folio(page));
 }
 EXPORT_SYMBOL(unlock_page);
+
+void end_page_writeback(struct page *page)
+{
+	return folio_end_writeback(page_folio(page));
+}
+EXPORT_SYMBOL(end_page_writeback);
-- 
2.30.2

