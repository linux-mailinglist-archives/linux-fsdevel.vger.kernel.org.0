Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF13350702
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 20:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbhCaSzj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 14:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbhCaSz0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:55:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BC6C061574;
        Wed, 31 Mar 2021 11:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=QhjvAwIphJQ5orJt+4iPRIVY31UtY38qCQDOplio82c=; b=Y0+DwTf4nzq1ij1vSYbU6KQO+5
        seEXuRe0GKy5l8GHVrB+T7bfU/0F24fFPswSLVDMbbUWifh/fsUO81L/GPOWXh6/+YpqWTnNL5hRE
        ykqJPUNQsYIM0gsX8A2sQeo120D51K9gk2S2mi+CzpJj/VZya4YDvk3NH3R75omc60+Sy6e90MtlY
        OJ+Vu4WeC9NVAAFQXiEbBV9RmSf2FLylB1mzGJi5SNjU4hSMBcJ6HKgpY1I/djuLGq4eoeBJtmvbL
        FAIWeGb+rpIml2+iHCHoKuQuhErYF2T9QXhDr+c+zNSXt/9SXFvosks9/U0sEFKaZmYye/fovtQpT
        M5TWQW2Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRfyj-004zmV-Rm; Wed, 31 Mar 2021 18:54:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: [PATCH v6 24/27] mm/writeback: Add wait_for_stable_folio
Date:   Wed, 31 Mar 2021 19:47:25 +0100
Message-Id: <20210331184728.1188084-25-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210331184728.1188084-1-willy@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
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
 mm/page-writeback.c     | 24 ++++++++++++++----------
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 2be3a028eb3d..001f8ec67ee7 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -834,6 +834,7 @@ int wait_on_folio_writeback_killable(struct folio *folio);
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
index 8271f9b24b69..9d55ceec05c0 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2865,17 +2865,21 @@ int wait_on_folio_writeback_killable(struct folio *folio)
 EXPORT_SYMBOL_GPL(wait_on_folio_writeback_killable);
 
 /**
- * wait_for_stable_page() - wait for writeback to finish, if necessary.
- * @page:	The page to wait on.
+ * wait_for_stable_folio() - wait for writeback to finish, if necessary.
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
+void wait_for_stable_folio(struct folio *folio)
 {
-	page = thp_head(page);
-	if (page->mapping->host->i_sb->s_iflags & SB_I_STABLE_WRITES)
-		wait_on_page_writeback(page);
+	if (folio->mapping->host->i_sb->s_iflags & SB_I_STABLE_WRITES)
+		wait_on_folio_writeback(folio);
 }
-EXPORT_SYMBOL_GPL(wait_for_stable_page);
+EXPORT_SYMBOL_GPL(wait_for_stable_folio);
-- 
2.30.2

