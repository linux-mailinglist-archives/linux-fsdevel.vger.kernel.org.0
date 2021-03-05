Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5CA132E0B3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 05:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhCEEZN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 23:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhCEEZL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 23:25:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2963C061574;
        Thu,  4 Mar 2021 20:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nazHYrrFDV44XE1641cI3TndwK0v+eGEx7jvUCN/rZc=; b=RzztMA15GaL6tV6cZcBJyxZadt
        uvuISHcz7hstZ+alA7qY58w7WIGHXhxju1mSJfflOPp7zfp+HijGdL9MFcvrExEtg0YOs0UzlHs+1
        B7uG4t0Tu6Q+nIAHjJixI+IZ5cLgkqTGoVAXn9BtnbFeO+crvQ7zjHCAGbqVDKrLIYeWCFeHwa1lc
        jyHoS9r54aU7d9HdLgESYk5oT6cSOJrw29Rd10UYkP0o2HTGHhrKV6V8WQqVhBBvJb9rnb3Rgd7JB
        mQteW2BL4ifEwjS+eY/8CVqaMAVt32DpTsBY+3t7nq7gnZMh4z4GqXjgsQsw9Kjnf1J2QRuYbVhRh
        5/LmRQNg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lI20R-00A3pO-0h; Fri, 05 Mar 2021 04:24:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 16/25] mm/filemap: Convert end_page_writeback to end_folio_writeback
Date:   Fri,  5 Mar 2021 04:18:52 +0000
Message-Id: <20210305041901.2396498-17-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210305041901.2396498-1-willy@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a wrapper function for users that are not yet converted to folios.

end_folio_writeback() is less than half the size of end_page_writeback()
at just 105 bytes compared to 213 bytes, due to removing all the
compound_head() calls.  The 30 byte wrapper function makes this a net
saving of 70 bytes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  3 ++-
 mm/filemap.c            | 30 +++++++++++++++---------------
 mm/folio-compat.c       |  6 ++++++
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 9dbd9cf7d541..e7fe8b276a2d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -753,7 +753,8 @@ static inline int wait_on_page_locked_killable(struct page *page)
 
 int put_and_wait_on_page_locked(struct page *page, int state);
 void wait_on_page_writeback(struct page *page);
-extern void end_page_writeback(struct page *page);
+void end_page_writeback(struct page *page);
+void end_folio_writeback(struct folio *folio);
 void wait_for_stable_page(struct page *page);
 
 void page_endio(struct page *page, bool is_write, int err);
diff --git a/mm/filemap.c b/mm/filemap.c
index b99b068bc058..e25a5ebc914c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1148,11 +1148,11 @@ static void wake_up_page_bit(struct page *page, int bit_nr)
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
@@ -1426,10 +1426,10 @@ void unlock_folio(struct folio *folio)
 EXPORT_SYMBOL(unlock_folio);
 
 /**
- * end_page_writeback - end writeback against a page
- * @page: the page
+ * end_folio_writeback - End writeback against a page.
+ * @folio: The page.
  */
-void end_page_writeback(struct page *page)
+void end_folio_writeback(struct folio *folio)
 {
 	/*
 	 * TestClearPageReclaim could be used here but it is an atomic
@@ -1438,26 +1438,26 @@ void end_page_writeback(struct page *page)
 	 * justify taking an atomic operation penalty at the end of
 	 * ever page writeback.
 	 */
-	if (PageReclaim(page)) {
-		ClearPageReclaim(page);
-		rotate_reclaimable_page(page);
+	if (FolioReclaim(folio)) {
+		ClearFolioReclaim(folio);
+		rotate_reclaimable_page(&folio->page);
 	}
 
 	/*
 	 * Writeback does not hold a page reference of its own, relying
 	 * on truncation to wait for the clearing of PG_writeback.
 	 * But here we must make sure that the page is not freed and
-	 * reused before the wake_up_page().
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
2.30.0

