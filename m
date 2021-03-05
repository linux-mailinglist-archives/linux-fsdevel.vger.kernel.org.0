Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE95E32E0B6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 05:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhCEEZS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 23:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhCEEZR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 23:25:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE991C061574;
        Thu,  4 Mar 2021 20:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ByBvZRAgYRACtY2rVghjrF+s5V0nWEFj/GUpqmY/krg=; b=bdhen0e0A+TMa408MU8/lgkXfj
        tjTiCKz2w10Kbk5JviHWXpBE+ZxYrTDcBZDzM5esN+e1I2n44YqOa4Le8lUl/Ky/CoVNpWQ1XQbty
        65cLZ8HbD/GcFhxKjmU/W5DBmdMhriRhVi3WkLBW4I8MuCCZGVhP/bqE3O5Y7vDCvByMa0IPN2vqS
        cOjr3BpbSvWV1LWwYZKg1Ufd6BBgPn86nGGLlrGhYNeo5sLiM4cI4W2LyoS39JSchQYsdoA2pK8fm
        KP/HWKLkt93OIea0kGGllnKQccsmjdLu5JYm0NsRnYTJDW0DeLM7OWcu6UzFg8TD9+Jj/chiHvV++
        FcIiqP/A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lI216-00A409-R4; Fri, 05 Mar 2021 04:24:48 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 18/25] mm/page-writeback: Add wait_on_folio_writeback
Date:   Fri,  5 Mar 2021 04:18:54 +0000
Message-Id: <20210305041901.2396498-19-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210305041901.2396498-1-willy@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This eliminates a call to compound_head() by turning PageWriteback()
into FolioWriteback(), which saves 8 bytes.  That is more than offset
by adding the wait_on_page_writeback compatibility wrapper for a net
increase in text of 30 bytes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  1 +
 mm/folio-compat.c       |  6 ++++++
 mm/page-writeback.c     | 21 ++++++++++++++-------
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index c53743f24550..7d797847633c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -763,6 +763,7 @@ static inline int wait_on_page_locked_killable(struct page *page)
 
 int put_and_wait_on_page_locked(struct page *page, int state);
 void wait_on_page_writeback(struct page *page);
+void wait_on_folio_writeback(struct folio *folio);
 void end_page_writeback(struct page *page);
 void end_folio_writeback(struct folio *folio);
 void wait_for_stable_page(struct page *page);
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index d1a1dfe52589..6aadecc39fba 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -23,3 +23,9 @@ void end_page_writeback(struct page *page)
 	return end_folio_writeback(page_folio(page));
 }
 EXPORT_SYMBOL(end_page_writeback);
+
+void wait_on_page_writeback(struct page *page)
+{
+	return wait_on_folio_writeback(page_folio(page));
+}
+EXPORT_SYMBOL_GPL(wait_on_page_writeback);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index eb34d204d4ee..968579452ea4 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2821,17 +2821,24 @@ int __test_set_page_writeback(struct page *page, bool keep_write)
 }
 EXPORT_SYMBOL(__test_set_page_writeback);
 
-/*
- * Wait for a page to complete writeback
+/**
+ * wait_on_folio_writeback - Wait for a folio to complete writeback.
+ * @folio: The folio to wait for.
+ *
+ * If the folio is currently being written back to storage, waits for the
+ * I/O to complete.
+ *
+ * Context: Sleeps; must be called in process context and with no spinlocks
+ * held.
  */
-void wait_on_page_writeback(struct page *page)
+void wait_on_folio_writeback(struct folio *folio)
 {
-	while (PageWriteback(page)) {
-		trace_wait_on_page_writeback(page, page_mapping(page));
-		wait_on_page_bit(page, PG_writeback);
+	while (FolioWriteback(folio)) {
+		trace_wait_on_page_writeback(&folio->page, folio_mapping(folio));
+		wait_on_page_bit(&folio->page, PG_writeback);
 	}
 }
-EXPORT_SYMBOL_GPL(wait_on_page_writeback);
+EXPORT_SYMBOL_GPL(wait_on_folio_writeback);
 
 /**
  * wait_for_stable_page() - wait for writeback to finish, if necessary.
-- 
2.30.0

