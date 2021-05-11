Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6458837B146
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 00:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhEKWEw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 18:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKWEw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 18:04:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341FFC061574;
        Tue, 11 May 2021 15:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=AtVyZwPq9MHbp7AqRYfbY7+rK/M2+SCPfu6LCiQJBE8=; b=CoB+CYcM5vJd4w6etnKmPctSnK
        IKZyckvZTDPxb00YEHFa3ZQvveFTTxULBR4SE2TGanktcX2QMMLqlvcqw6FwSX4VqFoMZqWxHDpjV
        gpGgUHLNDysqpa3AkLUaENrI9AA86SOc3eK0xcPNq5vV78odD6FkqTQh8be2hPY5zmg9sCWV48vtb
        L2jWKGsqaH4GMwHlFhY2FWV64nDRQCjjGpTdm+k5FGD5AwzpFypSDrE7QQI7cvBj2DDHdGVRHryRV
        yAh8YWQwJz54Y+rDtjPbsUi5ENyTJtF5PXQM35t49e/fZ5EaCRyiePyEGDR0mm5uRGhfEXfweqpII
        qOQmcgwg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgaSi-007iUD-Fm; Tue, 11 May 2021 22:02:53 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v10 23/33] mm/filemap: Add folio_wait_locked
Date:   Tue, 11 May 2021 22:47:25 +0100
Message-Id: <20210511214735.1836149-24-willy@infradead.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210511214735.1836149-1-willy@infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Also add folio_wait_locked_killable().  Turn wait_on_page_locked()
and wait_on_page_locked_killable() into wrappers.  This eliminates a
call to compound_head() from each call-site, reducing text size by 200
bytes for me.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/pagemap.h | 26 ++++++++++++++++++--------
 mm/filemap.c            |  4 ++--
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 21e394964288..e2648d906a84 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -721,23 +721,33 @@ extern void wait_on_page_bit(struct page *page, int bit_nr);
 extern int wait_on_page_bit_killable(struct page *page, int bit_nr);
 
 /* 
- * Wait for a page to be unlocked.
+ * Wait for a folio to be unlocked.
  *
- * This must be called with the caller "holding" the page,
- * ie with increased "page->count" so that the page won't
+ * This must be called with the caller "holding" the folio,
+ * ie with increased "page->count" so that the folio won't
  * go away during the wait..
  */
+static inline void folio_wait_locked(struct folio *folio)
+{
+	if (folio_locked(folio))
+		wait_on_page_bit(&folio->page, PG_locked);
+}
+
+static inline int folio_wait_locked_killable(struct folio *folio)
+{
+	if (!folio_locked(folio))
+		return 0;
+	return wait_on_page_bit_killable(&folio->page, PG_locked);
+}
+
 static inline void wait_on_page_locked(struct page *page)
 {
-	if (PageLocked(page))
-		wait_on_page_bit(compound_head(page), PG_locked);
+	folio_wait_locked(page_folio(page));
 }
 
 static inline int wait_on_page_locked_killable(struct page *page)
 {
-	if (!PageLocked(page))
-		return 0;
-	return wait_on_page_bit_killable(compound_head(page), PG_locked);
+	return folio_wait_locked_killable(page_folio(page));
 }
 
 int put_and_wait_on_page_locked(struct page *page, int state);
diff --git a/mm/filemap.c b/mm/filemap.c
index 28bf50041671..73c31b63392f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1645,9 +1645,9 @@ int __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
 
 		mmap_read_unlock(mm);
 		if (flags & FAULT_FLAG_KILLABLE)
-			wait_on_page_locked_killable(page);
+			folio_wait_locked_killable(folio);
 		else
-			wait_on_page_locked(page);
+			folio_wait_locked(folio);
 		return 0;
 	}
 	if (flags & FAULT_FLAG_KILLABLE) {
-- 
2.30.2

