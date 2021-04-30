Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44A8370079
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 20:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhD3S3t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 14:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhD3S3s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 14:29:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AC4C06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 11:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FhXpmXP74kARZx6emCazGSqbSUw6zsxeO6xpp9GpVpE=; b=bt+5NqFAmSDC0u16WF2XGddJiB
        htcn6g2Jp1DAvVq8rOKMO3pFLYLlTkUHCKMqPJnv4d9mYL63Y6gaM6v7S5jPUTYdtvuaGYXaFyzpT
        m8Fcb4VnMffAYxi0aS+q6BIEVUn9uwoioUo83swXkYty92a1z+9CQKnU9dx/Vnu52G4HLXjtfL5Ak
        lfKX4LSqEWo5/A9SEC7t//GZ5arKXt+8oytLvsDlPwgr9nX9qOwthhV9QaibwsGUXzpUHSNo07+/v
        hwmYl7GGK6JQGlpeB6UlYBGl2xBM9qMQY65ft0IqswnsUDarkmB1A7+tJ7YnpW54+uFk8YJ0q5sto
        vkblwuLQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcXrQ-00BNaI-2P; Fri, 30 Apr 2021 18:27:46 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v8 22/31] mm/filemap: Add folio_wait_locked
Date:   Fri, 30 Apr 2021 19:07:31 +0100
Message-Id: <20210430180740.2707166-23-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210430180740.2707166-1-willy@infradead.org>
References: <20210430180740.2707166-1-willy@infradead.org>
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
index ad554aef9cfb..87002bc2fdce 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -797,23 +797,33 @@ extern void wait_on_page_bit(struct page *page, int bit_nr);
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
index c70d3da2b7b2..3eb0447604b4 100644
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

