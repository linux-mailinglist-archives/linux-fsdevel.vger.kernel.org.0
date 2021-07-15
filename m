Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950CB3C96B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 05:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbhGODzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 23:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbhGODzD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 23:55:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F97C06175F;
        Wed, 14 Jul 2021 20:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=yJjcL8JeT4ttM0WfFdjzDq9LTGoepY5vhGwfSSvIaTY=; b=DiLMs0A5FFEsfF4hgDykRoBmm7
        taepqtiDtpuKFLEXllIuWLXq//zU4sr4XDmW8Ax+/UxRfjCTzySv65UmzausBOCeKGwGbouZS8n/z
        kWZupXDUO+UIOujntqsGAhDVnFtPeK7+l/jqPJHIvsQ889j4bseBCNmhhCu3IcWQf/nVhuJHXxSfJ
        3isEj0IEx4+I5l7yVNfsucMFPC/2gIrVbtC5A/h7tDpXs6YmuhO2I0FfoNFViDWHAVRcO8R2X38If
        qJaoMXTTvDIJblIuLEvt3AuzXzrbOzJfw8rxJlmSLaEiAvmIESkPRdfsAvnVZYxFWcnT55Yha2Ppd
        iXBVchdA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3sNW-002v1u-Hs; Thu, 15 Jul 2021 03:49:56 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v14 017/138] mm/filemap: Add folio_unlock()
Date:   Thu, 15 Jul 2021 04:35:03 +0100
Message-Id: <20210715033704.692967-18-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert unlock_page() to call folio_unlock().  By using a folio we
avoid a call to compound_head().  This shortens the function from 39
bytes to 25 and removes 4 instructions on x86-64.  Because we still
have unlock_page(), it's a net increase of 16 bytes of text for the
kernel as a whole, but any path that uses folio_unlock() will execute
4 fewer instructions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: David Howells <dhowells@redhat.com>
---
 include/linux/pagemap.h |  3 ++-
 mm/filemap.c            | 29 ++++++++++++-----------------
 mm/folio-compat.c       |  6 ++++++
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a0925a89ba11..a13edc7a2916 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -658,7 +658,8 @@ extern int __lock_page_killable(struct page *page);
 extern int __lock_page_async(struct page *page, struct wait_page_queue *wait);
 extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 				unsigned int flags);
-extern void unlock_page(struct page *page);
+void unlock_page(struct page *page);
+void folio_unlock(struct folio *folio);
 
 /*
  * Return true if the page was successfully locked
diff --git a/mm/filemap.c b/mm/filemap.c
index 634adeacc4c1..1af67ef94e4c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1435,29 +1435,24 @@ static inline bool clear_bit_unlock_is_negative_byte(long nr, volatile void *mem
 #endif
 
 /**
- * unlock_page - unlock a locked page
- * @page: the page
+ * folio_unlock - Unlock a locked folio.
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
+void folio_unlock(struct folio *folio)
 {
+	/* Bit 7 allows x86 to check the byte's sign bit */
 	BUILD_BUG_ON(PG_waiters != 7);
-	page = compound_head(page);
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	if (clear_bit_unlock_is_negative_byte(PG_locked, &page->flags))
-		wake_up_page_bit(page, PG_locked);
+	BUILD_BUG_ON(PG_locked > 7);
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+	if (clear_bit_unlock_is_negative_byte(PG_locked, folio_flags(folio, 0)))
+		wake_up_page_bit(&folio->page, PG_locked);
 }
-EXPORT_SYMBOL(unlock_page);
+EXPORT_SYMBOL(folio_unlock);
 
 /**
  * end_page_private_2 - Clear PG_private_2 and release any waiters
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 5e107aa30a62..91b3d00a92f7 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -11,3 +11,9 @@ struct address_space *page_mapping(struct page *page)
 	return folio_mapping(page_folio(page));
 }
 EXPORT_SYMBOL(page_mapping);
+
+void unlock_page(struct page *page)
+{
+	return folio_unlock(page_folio(page));
+}
+EXPORT_SYMBOL(unlock_page);
-- 
2.30.2

