Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A193506FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 20:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbhCaSyf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 14:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbhCaSyE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:54:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA41DC061574;
        Wed, 31 Mar 2021 11:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=s4lQvo5EDcflactPiclRCs2NR/gq/ASPjSTuH+CL/fc=; b=JHaLLCqmEjt3aNc6Sq9DsHwUCE
        7+JgMtcg6Hqm8raBF6YF0O9kZMp6DlNFDJapZKQHHVhc+9aKk29kjVWVJCXvrh5/dZ64L/oXRXU+h
        lwSVCg1lK6F6150G2Cc3FHnWF3ng9cdpd0dgT815iMLtxFOkBtY0TmW4FU8Bew60Cp02MJA8eoE53
        Mz6XLUh5tk1albnQ8oqHFfZqfE6ntA2qovZg09XGDUZTKSCSV3SaikJ6TOWQMk5+V48txMR3u88ss
        qc003wu9FgbFeA/T6YnxzAdr8yREfoIO5SULLOEVWklDvMqB+C3Tg65Y4IbI/5M9TZMLRzSIjunnw
        j8tkJj3g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRfyT-004zjT-Ey; Wed, 31 Mar 2021 18:53:54 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: [PATCH v6 21/27] mm/filemap: Add wait_on_folio_locked
Date:   Wed, 31 Mar 2021 19:47:22 +0100
Message-Id: <20210331184728.1188084-22-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210331184728.1188084-1-willy@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Also add wait_on_folio_locked_killable().  Turn wait_on_page_locked()
and wait_on_page_locked_killable() into wrappers.  This eliminates a
call to compound_head() from each call-site, reducing text size by 200
bytes for me.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 26 ++++++++++++++++++--------
 mm/filemap.c            |  4 ++--
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 43664bef7392..a7bbc34d92cb 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -798,23 +798,33 @@ extern void wait_on_page_bit(struct page *page, int bit_nr);
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
+static inline void wait_on_folio_locked(struct folio *folio)
+{
+	if (FolioLocked(folio))
+		wait_on_page_bit(&folio->page, PG_locked);
+}
+
+static inline int wait_on_folio_locked_killable(struct folio *folio)
+{
+	if (!FolioLocked(folio))
+		return 0;
+	return wait_on_page_bit_killable(&folio->page, PG_locked);
+}
+
 static inline void wait_on_page_locked(struct page *page)
 {
-	if (PageLocked(page))
-		wait_on_page_bit(compound_head(page), PG_locked);
+	wait_on_folio_locked(page_folio(page));
 }
 
 static inline int wait_on_page_locked_killable(struct page *page)
 {
-	if (!PageLocked(page))
-		return 0;
-	return wait_on_page_bit_killable(compound_head(page), PG_locked);
+	return wait_on_folio_locked_killable(page_folio(page));
 }
 
 int put_and_wait_on_page_locked(struct page *page, int state);
diff --git a/mm/filemap.c b/mm/filemap.c
index c0a986ac830f..21607db04835 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1604,9 +1604,9 @@ int __lock_folio_or_retry(struct folio *folio, struct mm_struct *mm,
 
 		mmap_read_unlock(mm);
 		if (flags & FAULT_FLAG_KILLABLE)
-			wait_on_page_locked_killable(page);
+			wait_on_folio_locked_killable(folio);
 		else
-			wait_on_page_locked(page);
+			wait_on_folio_locked(folio);
 		return 0;
 	}
 	if (flags & FAULT_FLAG_KILLABLE) {
-- 
2.30.2

