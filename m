Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414EB342B2E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 06:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbhCTFpN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 01:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhCTFov (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 01:44:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85D6C061762;
        Fri, 19 Mar 2021 22:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=30IifAMV+9SjIPC06TX4qxHTMbVci0D9vhNY5D2kHrs=; b=czb/YXKSnUYK8E7i9dfNKYPFCQ
        Bo0w/B31yKWGWKEfLgYRqGJcpslePdCRzM65+LobyOnxm878IqJ5aP4kqtz2Mz6swLcXknMWn1CXK
        V2TTPSLV689am4Ks9zoQ3Gc9KB4t97OKCFL7I935srf45kKomdM8nCDH4PR/fHMbUlTViy3Z+CM7F
        TMQ27Xf4eA2dLOHFz2PmxsK4tFhngMbUpAkMiZB8NpJpALtBQgqNZ3EXyGy2DpPiLdLKDMG47SRKt
        ZUjVBCC/7GXz+A3V4sPZnUJa/I4A8akTZHWVFumrUCHgzZ8EcT8rpD09jLjctmXiXWonmqZXvZwNf
        6yyPZ17Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNUOu-005Shq-7j; Sat, 20 Mar 2021 05:43:53 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: [PATCH v5 23/27] mm/writeback: Add wait_for_stable_folio
Date:   Sat, 20 Mar 2021 05:41:00 +0000
Message-Id: <20210320054104.1300774-24-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210320054104.1300774-1-willy@infradead.org>
References: <20210320054104.1300774-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move wait_for_stable_page() into the folio compatibility file.
wait_for_stable_folio() avoids a call to compound_head() and is 14 bytes
smaller than wait_for_stable_page() was.  The net text size grows by 24
bytes as a result of this patch.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  1 +
 mm/folio-compat.c       |  6 ++++++
 mm/page-writeback.c     | 17 ++++++++---------
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a6adf69ea5c5..c92782b77d98 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -813,6 +813,7 @@ int wait_on_folio_writeback_killable(struct folio *folio);
 void end_page_writeback(struct page *page);
 void end_folio_writeback(struct folio *folio);
 void wait_for_stable_page(struct page *page);
+void wait_for_stable_folio(struct folio *folio);
 
 void page_endio(struct page *page, bool is_write, int err);
 
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 6aadecc39fba..335594fe414e 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -29,3 +29,9 @@ void wait_on_page_writeback(struct page *page)
 	return wait_on_folio_writeback(page_folio(page));
 }
 EXPORT_SYMBOL_GPL(wait_on_page_writeback);
+
+void wait_for_stable_page(struct page *page)
+{
+	return wait_for_stable_folio(page_folio(page));
+}
+EXPORT_SYMBOL_GPL(wait_for_stable_page);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index a08e77abcf12..c222f88cf06b 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2862,17 +2862,16 @@ int wait_on_folio_writeback_killable(struct folio *folio)
 EXPORT_SYMBOL_GPL(wait_on_folio_writeback_killable);
 
 /**
- * wait_for_stable_page() - wait for writeback to finish, if necessary.
- * @page:	The page to wait on.
+ * wait_for_stable_folio() - wait for writeback to finish, if necessary.
+ * @folio: The folio to wait on.
  *
- * This function determines if the given page is related to a backing device
- * that requires page contents to be held stable during writeback.  If so, then
+ * This function determines if the given folio is related to a backing device
+ * that requires folio contents to be held stable during writeback.  If so, then
  * it will wait for any pending writeback to complete.
  */
-void wait_for_stable_page(struct page *page)
+void wait_for_stable_folio(struct folio *folio)
 {
-	page = thp_head(page);
-	if (page->mapping->host->i_sb->s_iflags & SB_I_STABLE_WRITES)
-		wait_on_page_writeback(page);
+	if (folio->page.mapping->host->i_sb->s_iflags & SB_I_STABLE_WRITES)
+		wait_on_folio_writeback(folio);
 }
-EXPORT_SYMBOL_GPL(wait_for_stable_page);
+EXPORT_SYMBOL_GPL(wait_for_stable_folio);
-- 
2.30.2

