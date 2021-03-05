Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B4132E0B9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 05:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhCEEZn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 23:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhCEEZm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 23:25:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C19CC061574;
        Thu,  4 Mar 2021 20:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ViUiDGdVnd7Iq4vdJDnK9pV32OXyBauhh7HNXcs3hWk=; b=HJV/2O4pf9RXMAw6lAoKTDf54y
        VEGFEKf0LEZCoauqkXpByXvcTOBxs0+GGYG3YARlLfXTahsDu1B/nhhDu0qkye3eO+/ygcRYy5K5X
        yv4f+ePzXS2tofWUz1fM6yCkOH4jouoL6hf2d/iHfjBTnKKywDXsNgWzqyOkT6u0zWThHeZubs51u
        JumpTVB5BnzgeHQ/MPt9YM+MbWoN5OU5DrLqfusBrUp6gqJpD/HMd4ahE/spyuNs8aBYKfpKsqc5v
        O+osyB0Cqf0VgOfm9QRnmmQ21abHsT/jwZqSUUYK19imKb0akySFhqSId9oaXLM+fFolZAGbRoQHF
        ui0+xE8g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lI21V-00A48z-E9; Fri, 05 Mar 2021 04:25:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 19/25] mm/page-writeback: Add wait_for_stable_folio
Date:   Fri,  5 Mar 2021 04:18:55 +0000
Message-Id: <20210305041901.2396498-20-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210305041901.2396498-1-willy@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
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
index 7d797847633c..e7ca8def2f0d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -767,6 +767,7 @@ void wait_on_folio_writeback(struct folio *folio);
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
index 968579452ea4..eef36edc9e0c 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2841,17 +2841,16 @@ void wait_on_folio_writeback(struct folio *folio)
 EXPORT_SYMBOL_GPL(wait_on_folio_writeback);
 
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
2.30.0

