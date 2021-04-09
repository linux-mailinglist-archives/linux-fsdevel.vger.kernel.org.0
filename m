Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A85A35A6A0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 21:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbhDITFg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 15:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbhDITFg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 15:05:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D395C061762;
        Fri,  9 Apr 2021 12:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dEYtOiesPhKO969ltF4fYPScY5/+C6rMBP9ybWDg6qg=; b=XWaCEO+s/LiIimx4mSUkNbSSoZ
        uZUKx149UmZ6nZhqxNt3W+j4q+Z+7oITEZcBCb+h5I6M5y65NBM3LxtblNJH/olg4wat7M65T2YcF
        SHiQxAGWcm3eUdoIG1/6+ZLGABc+AIbLWKfBg+H79jhuiXK7Wqgg9UK3mmlCWpuqldbpK+b3sMCwg
        hKG7Fur4+80MxBxiU2s/RwespncE7WlMZNbiSgJkt1w3c3SqXGpt49zFM4zRn3wyfAYyVROYgQ+Dc
        vRi0Q0Ndgkx0aH0ohiCrDtAPjVfd0kKLcbqCyyfRht6Dm2K5aSruHoxVk5HfDrkoXYt3cGuynJLoc
        XMIfN+Bg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUwPw-000oAa-Ei; Fri, 09 Apr 2021 19:04:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v7 17/28] mm/filemap: Add unlock_folio
Date:   Fri,  9 Apr 2021 19:50:54 +0100
Message-Id: <20210409185105.188284-18-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210409185105.188284-1-willy@infradead.org>
References: <20210409185105.188284-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert unlock_page() to call unlock_folio().  By using a folio we
avoid a call to compound_head().  This shortens the function from 39
bytes to 25 and removes 4 instructions on x86-64.  Because we still
have unlock_page(), it's a net increase of 24 bytes of text for the
kernel as a whole, but any path that uses unlock_folio() will execute
4 fewer instructions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/pagemap.h |  3 ++-
 mm/filemap.c            | 27 ++++++++++-----------------
 mm/folio-compat.c       |  6 ++++++
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index f8150dfbf110..d94c9f8a451d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -719,7 +719,8 @@ extern int __lock_page_killable(struct page *page);
 extern int __lock_page_async(struct page *page, struct wait_page_queue *wait);
 extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 				unsigned int flags);
-extern void unlock_page(struct page *page);
+void unlock_page(struct page *page);
+void unlock_folio(struct folio *folio);
 
 /*
  * Return true if the page was successfully locked
diff --git a/mm/filemap.c b/mm/filemap.c
index 7aacec5684c7..d1cf51274921 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1435,29 +1435,22 @@ static inline bool clear_bit_unlock_is_negative_byte(long nr, volatile void *mem
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
+	if (clear_bit_unlock_is_negative_byte(PG_locked, folio_flags(folio, 0)))
+		wake_up_page_bit(&folio->page, PG_locked);
 }
-EXPORT_SYMBOL(unlock_page);
+EXPORT_SYMBOL(unlock_folio);
 
 /**
  * end_page_private_2 - Clear PG_private_2 and release any waiters
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 5e107aa30a62..02798abf19a1 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -11,3 +11,9 @@ struct address_space *page_mapping(struct page *page)
 	return folio_mapping(page_folio(page));
 }
 EXPORT_SYMBOL(page_mapping);
+
+void unlock_page(struct page *page)
+{
+	return unlock_folio(page_folio(page));
+}
+EXPORT_SYMBOL(unlock_page);
-- 
2.30.2

