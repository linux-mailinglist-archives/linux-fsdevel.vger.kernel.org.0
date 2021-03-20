Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84F6342B28
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 06:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhCTFoL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 01:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhCTFoG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 01:44:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654F6C061762;
        Fri, 19 Mar 2021 22:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fakHqo/hsd0J2JO7HEvfhjfuv+gkqjiek9RT8hdv1ww=; b=orTqE2KcP3Z/LhF6yW0EWgYFa7
        F7MGLCGUI0rsuAn9L9EoYF3NqnPMicaENEVmwgeuEzBGAQB03ZVCUqStOLtco4VyhQ/vgK2aJM3UX
        3agGU7jQFCoBIYbK5+M1FsfqjlppxW5qNDumBHxdxZaXaI/9+pqrOrQ1rQ/pDSQV1z8aDINQUL3mf
        7XZDz0NgSi5Z7DQJDmrgODZwObNKqxdxJbVcMxnF5upF9BjLkx659F6Aq2nooNAHJ+PY2whsWoEEr
        TGWBiFP6SHHLgyyAv/sa+UF0pBFLIbWLHsimVE+Sdws5zrvUg5MkVId9Tz9aezTyq+59KLtwUdUBM
        w1G+bxNQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNUOi-005Sgx-3Z; Sat, 20 Mar 2021 05:43:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: [PATCH v5 22/27] mm/writeback: Add wait_on_folio_writeback
Date:   Sat, 20 Mar 2021 05:40:59 +0000
Message-Id: <20210320054104.1300774-23-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210320054104.1300774-1-willy@infradead.org>
References: <20210320054104.1300774-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

wait_on_page_writeback_killable() only has one caller, so convert it to
call wait_on_folio_writeback_killable().  For the wait_on_page_writeback()
callers, add a compatibility wrapper around wait_on_folio_writeback().

Turning PageWriteback() into FolioWriteback() eliminates a call to
compound_head() which saves 8 bytes and 15 bytes in the two functions.
That is more than offset by adding the wait_on_page_writeback
compatibility wrapper for a net increase in text of 15 bytes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/afs/write.c          |  2 +-
 include/linux/pagemap.h |  3 ++-
 mm/folio-compat.c       |  6 ++++++
 mm/page-writeback.c     | 43 +++++++++++++++++++++++++++--------------
 4 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 106a864b6a93..4b70b0e7fcfa 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -850,7 +850,7 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 		return VM_FAULT_RETRY;
 #endif
 
-	if (wait_on_page_writeback_killable(page))
+	if (wait_on_folio_writeback_killable(page_folio(page)))
 		return VM_FAULT_RETRY;
 
 	if (lock_page_killable(page) < 0)
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 2ee6b1b9561c..a6adf69ea5c5 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -808,7 +808,8 @@ static inline int wait_on_page_locked_killable(struct page *page)
 
 int put_and_wait_on_page_locked(struct page *page, int state);
 void wait_on_page_writeback(struct page *page);
-int wait_on_page_writeback_killable(struct page *page);
+void wait_on_folio_writeback(struct folio *folio);
+int wait_on_folio_writeback_killable(struct folio *folio);
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
index 5e761fb62800..a08e77abcf12 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2818,33 +2818,48 @@ int __test_set_page_writeback(struct page *page, bool keep_write)
 }
 EXPORT_SYMBOL(__test_set_page_writeback);
 
-/*
- * Wait for a page to complete writeback
+/**
+ * wait_on_folio_writeback - Wait for a folio to complete writeback.
+ * @folio: The folio to wait for.
+ *
+ * If the folio is currently being written back to storage, wait for the
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
 
-/*
- * Wait for a page to complete writeback.  Returns -EINTR if we get a
+/**
+ * wait_on_folio_writeback_killable - Wait for a folio to complete writeback.
+ * @folio: The folio to wait for.
+ *
+ * If the folio is currently being written back to storage, wait for the
+ * I/O to complete or a fatal signal to arrive.
+ *
+ * Context: Sleeps; must be called in process context and with no spinlocks
+ * held.
+ * Return: 0 if the folio has completed writeback.  -EINTR if we get a
  * fatal signal while waiting.
  */
-int wait_on_page_writeback_killable(struct page *page)
+int wait_on_folio_writeback_killable(struct folio *folio)
 {
-	while (PageWriteback(page)) {
-		trace_wait_on_page_writeback(page, page_mapping(page));
-		if (wait_on_page_bit_killable(page, PG_writeback))
+	while (FolioWriteback(folio)) {
+		trace_wait_on_page_writeback(&folio->page, folio_mapping(folio));
+		if (wait_on_page_bit_killable(&folio->page, PG_writeback))
 			return -EINTR;
 	}
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(wait_on_page_writeback_killable);
+EXPORT_SYMBOL_GPL(wait_on_folio_writeback_killable);
 
 /**
  * wait_for_stable_page() - wait for writeback to finish, if necessary.
-- 
2.30.2

