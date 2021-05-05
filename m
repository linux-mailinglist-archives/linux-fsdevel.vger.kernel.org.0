Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B066373EC3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 17:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhEEPoo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 11:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbhEEPon (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 11:44:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E08C061574;
        Wed,  5 May 2021 08:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rbGVteh2s9te6MVdcmvYoc2Et5yX2sCir12yjQI+tSg=; b=qYUiQ1L5guG0/qZdlV7IBH1TLC
        GCJYdwb5Ln2CLa+pF7moOCIsBCF6HnpSeEBaJNG7djVEgNpuQwIKpUwkFxTW6zuFePV0V/T5a8Q+9
        aWlvjIJ6cZgcL+arP6c4ciYdEMd9Rc87M/HPtgtMGoAqKPn5PC9KFyW+sTqHaKlA50vA5Dn4XKRoc
        Ui5H2K1/756ITJaQlZd3zYvvd/MPdDKguywv1+9hiHKGXMpgZPYz9zqf4mwXBXXWeMenDkMBCsAz9
        tzcsty+cNvvd8/ZrMOuGu8ShyzaBAPxZQkiDzMIEO2wqC48xhE1Q5qULE01PRP9midRugqgOZPxS5
        JREP6acg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leJeR-000WF4-Ja; Wed, 05 May 2021 15:41:34 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v9 30/96] mm/filemap: Add folio_wait_locked
Date:   Wed,  5 May 2021 16:05:22 +0100
Message-Id: <20210505150628.111735-31-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
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
index dd1ca33896b4..615f5b3e65c4 100644
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
index 3c159e5f2dcd..73e078c40bd7 100644
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

