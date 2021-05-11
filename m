Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4013537B153
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 00:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhEKWIk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 18:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhEKWIj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 18:08:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4B8C061574;
        Tue, 11 May 2021 15:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=S0gs1unS68UpCFsyCjciKkGZ9wNHpsEIHeclcBFV5Lo=; b=qiJnXUHPnAR2GTfk0gILwXJu/f
        2IBtYjJnUHAQNUeWA6OnMNbpFY/ebiRddtPvtQycAFwzJFzPjW6fmOd5ehToljmsDoletUKZfAEJR
        8iic/q689JVKyg5xF87k0eP1ze9/qZO2pNXNZ6cl/FZLZ9zP47dbABX34popWMdrSrq0+4aXkuPog
        tvzpj3A/1VGv+7S9ech8ED2PyzQ73toRJI4OmF5fHi4XJ/4ccBOPqKJho4o9ApxNnHrhJc/7zMxcW
        dCMPoyzEOZHzjo7q1abP882fJEK/BXVRhQVYAa9LpOds5mFuIxUbTX9WNDqE8KzhxL5mNp06M1YV+
        2+azOj8g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgaV2-007ig9-MN; Tue, 11 May 2021 22:05:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v10 27/33] mm/writeback: Add folio_wait_stable
Date:   Tue, 11 May 2021 22:47:29 +0100
Message-Id: <20210511214735.1836149-28-willy@infradead.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210511214735.1836149-1-willy@infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move wait_for_stable_page() into the folio compatibility file.
folio_wait_stable() avoids a call to compound_head() and is 14 bytes
smaller than wait_for_stable_page() was.  The net text size grows by 24
bytes as a result of this patch.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/pagemap.h |  1 +
 mm/folio-compat.c       |  6 ++++++
 mm/page-writeback.c     | 24 ++++++++++++++----------
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 417efd7edd19..06b69cd03da3 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -757,6 +757,7 @@ int folio_wait_writeback_killable(struct folio *folio);
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
index d7ac428df68a..003b85813f7c 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2860,17 +2860,21 @@ int folio_wait_writeback_killable(struct folio *folio)
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

