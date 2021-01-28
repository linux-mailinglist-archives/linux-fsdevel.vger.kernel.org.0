Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81B2306E1E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhA1HGl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbhA1HGC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:06:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2048BC0617A9;
        Wed, 27 Jan 2021 23:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9oVIcCkUXd+sZVNIsuy1+nfatx2hPStEQuhz4k/iTZ8=; b=Kv2Gm2DZYgduSqaqVAyqxVHzml
        /onl1b27i5NHeHBX1w4RDTXCftiD5GUAt14eJzT3Yil50i45rlZ+2WcxwDAxC9ANRPVCkHdV+VcEX
        VN0oK7IhrponProZDAd/n6YEpU5v8XMOUCh1uGyzgX6I2kCp3ao8rS5qtV6qL/fGiN77uQkAkX27H
        4HIcm/WjGMVHsOYOdlzFYNKIyBRg0yZKlFQ8qqI1/yRCWjs2XllU/HK55z4qT9lkVoJWfRFzPoYcK
        c48uFejfuCA0db6YB1jXBJCVLLbWXhuMkaLpesWdCNkb9LcxM4MdSrhValF7BQMlBmK70HAW9Z262
        kwJrPCSA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l51Lw-00847s-18; Thu, 28 Jan 2021 07:04:28 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/25] mm: Add unlock_folio
Date:   Thu, 28 Jan 2021 07:03:52 +0000
Message-Id: <20210128070404.1922318-14-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128070404.1922318-1-willy@infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert unlock_page() to call unlock_folio().  By using a folio we avoid
a call to compound_head().  This shortens the function from 39 bytes to
25 and removes 4 instructions on x86-64.  Those instructions are currently
pushed into each caller, but subsequent patches will convert many of the
callers to operate on folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 16 +++++++++++++++-
 mm/filemap.c            | 27 ++++++++++-----------------
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 86956e97cd5e..5fcab5e1787c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -623,9 +623,23 @@ extern int __lock_page_killable(struct page *page);
 extern int __lock_page_async(struct page *page, struct wait_page_queue *wait);
 extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 				unsigned int flags);
-extern void unlock_page(struct page *page);
+void unlock_folio(struct folio *folio);
 extern void unlock_page_fscache(struct page *page);
 
+/**
+ * unlock_page - Unlock a locked page.
+ * @page: The page.
+ *
+ * Unlocks the page and wakes up any thread sleeping on the page lock.
+ *
+ * Context: May be called from interrupt or process context.  May not be
+ * called from NMI context.
+ */
+static inline void unlock_page(struct page *page)
+{
+	return unlock_folio(page_folio(page));
+}
+
 /*
  * Return true if the page was successfully locked
  */
diff --git a/mm/filemap.c b/mm/filemap.c
index 4417fd15d633..b639651d1573 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1407,29 +1407,22 @@ static inline bool clear_bit_unlock_is_negative_byte(long nr, volatile void *mem
 #endif
 
 /**
- * unlock_page - unlock a locked page
- * @page: the page
+ * unlock_folio - Unlock a locked folio.
+ * @folio: The folio.
  *
- * Unlocks the page and wakes up sleepers in wait_on_page_locked().
- * Also wakes sleepers in wait_on_page_writeback() because the wakeup
- * mechanism between PageLocked pages and PageWriteback pages is shared.
- * But that's OK - sleepers in wait_on_page_writeback() just go back to sleep.
+ * Unlocks the folio and wakes up any thread sleeping on the page lock.
  *
- * Note that this depends on PG_waiters being the sign bit in the byte
- * that contains PG_locked - thus the BUILD_BUG_ON(). That allows us to
- * clear the PG_locked bit and test PG_waiters at the same time fairly
- * portably (architectures that do LL/SC can test any bit, while x86 can
- * test the sign bit).
+ * Context: May be called from interrupt or process context.  May not be
+ * called from NMI context.
  */
-void unlock_page(struct page *page)
+void unlock_folio(struct folio *folio)
 {
 	BUILD_BUG_ON(PG_waiters != 7);
-	page = compound_head(page);
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	if (clear_bit_unlock_is_negative_byte(PG_locked, &page->flags))
-		wake_up_page_bit(page, PG_locked);
+	VM_BUG_ON_FOLIO(!FolioLocked(folio), folio);
+	if (clear_bit_unlock_is_negative_byte(PG_locked, folio_flags(folio)))
+		wake_up_page_bit(&folio->page, PG_locked);
 }
-EXPORT_SYMBOL(unlock_page);
+EXPORT_SYMBOL(unlock_folio);
 
 /**
  * unlock_page_fscache - Unlock a page pinned with PG_fscache
-- 
2.29.2

