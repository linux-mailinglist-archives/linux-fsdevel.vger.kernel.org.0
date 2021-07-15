Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4563C96C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 05:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhGOEBg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhGOEBg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:01:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF0FC06175F;
        Wed, 14 Jul 2021 20:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+QyNTsHA0SVbGG1VH5A6VoiB8kow5agwPtQU0LPKsu8=; b=Lk2FnWyRhFAuS4AEqvUD4gpBrU
        eYm5QtfCpSFHS09hR13esWgp7lTs/nJJpO4oa0UGY3CM5uKbcgQJ9INcRtaxjrIyh+cdy5exlbxVg
        Pu5166Y+0sAUFQvSPGo5Y4Hf1339ayi3RlZARG2QJhK8vsaMv2H2JNhjaGtdzvrkODJ5+8OiBwT0H
        JJY+aGCFhBNBJcyH2xdWTiom5kc3W5cFRivuQLHVjsZc0YSvI2PEk0dHMIoSCa3goE4ltAtY89PO0
        +/16g6TbIgNrO73EZErcHg5Xr15jyJ9rGZ1UdnIyD+pZg8paXmrMF9Ug48UFbwwuixS1a7D5At/sq
        kkr4v9aA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3sUo-002vQx-Is; Thu, 15 Jul 2021 03:57:24 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v14 024/138] mm/filemap: Add folio_end_writeback()
Date:   Thu, 15 Jul 2021 04:35:10 +0100
Message-Id: <20210715033704.692967-25-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an end_page_writeback() wrapper function for users that are not yet
converted to folios.

folio_end_writeback() is less than half the size of end_page_writeback()
at just 105 bytes compared to 228 bytes, due to removing all the
compound_head() calls.  The 30 byte wrapper function makes this a net
saving of 93 bytes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: David Howells <dhowells@redhat.com>
---
 include/linux/pagemap.h |  3 ++-
 mm/filemap.c            | 43 ++++++++++++++++++++---------------------
 mm/folio-compat.c       |  6 ++++++
 3 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 626dbccbfb90..66a019178550 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -768,7 +768,8 @@ static inline int wait_on_page_locked_killable(struct page *page)
 int put_and_wait_on_page_locked(struct page *page, int state);
 void wait_on_page_writeback(struct page *page);
 int wait_on_page_writeback_killable(struct page *page);
-extern void end_page_writeback(struct page *page);
+void end_page_writeback(struct page *page);
+void folio_end_writeback(struct folio *folio);
 void wait_for_stable_page(struct page *page);
 
 void __set_page_dirty(struct page *, struct address_space *, int warn);
diff --git a/mm/filemap.c b/mm/filemap.c
index 4ce2b22b64f8..b5a0d546e436 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1175,11 +1175,11 @@ static void wake_up_page_bit(struct page *page, int bit_nr)
 	spin_unlock_irqrestore(&q->lock, flags);
 }
 
-static void wake_up_page(struct page *page, int bit)
+static void folio_wake(struct folio *folio, int bit)
 {
-	if (!PageWaiters(page))
+	if (!folio_test_waiters(folio))
 		return;
-	wake_up_page_bit(page, bit);
+	wake_up_page_bit(&folio->page, bit);
 }
 
 /*
@@ -1516,39 +1516,38 @@ int wait_on_page_private_2_killable(struct page *page)
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
-	 * operation and overkill in this particular case. Failing to
-	 * shuffle a page marked for immediate reclaim is too mild to
-	 * justify taking an atomic operation penalty at the end of
-	 * ever page writeback.
+	 * folio_test_clear_reclaim() could be used here but it is an
+	 * atomic operation and overkill in this particular case. Failing
+	 * to shuffle a folio marked for immediate reclaim is too mild
+	 * a gain to justify taking an atomic operation penalty at the
+	 * end of every folio writeback.
 	 */
-	if (PageReclaim(page)) {
-		struct folio *folio = page_folio(page);
-		ClearPageReclaim(page);
+	if (folio_test_reclaim(folio)) {
+		folio_clear_reclaim(folio);
 		folio_rotate_reclaimable(folio);
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

