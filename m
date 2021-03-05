Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C3232E0B2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 05:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhCEEZN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 23:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhCEEZL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 23:25:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B6DC061756;
        Thu,  4 Mar 2021 20:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TbwKTsRFeRRDANTFRahEyrvCD2paHgaZGJcv04iRdsE=; b=pPmEabNdKjB2yes6KuAwcqe3iJ
        bh5J/cXoSJsZvy/YKVKrwJRFMYWcepswsJW28fGrnwftIMY8F9JC/oCMFUAA55u4S4ViSVRFfBPP5
        yCKnvtXvECap+Wj2ue5CnVjDyYGMC+eANie/Ih7Qw/xTplhBSydoVTa1gCngKVlWx9h+Zeco4FA3Q
        bGTRWF38KztlWT1KaQKxr9+lXMCM2UYnd4vs5a7fiSPWmYA9Vl0SIt03wdBDbU80MrIyOJskBDmVR
        UP/KrOv2zin6BARrEDTAnkZMW8Slq1YebYC9IOX11T/LrdjM18ZAbvc7yu9NfJQtjLEyo33U/AG1l
        GlF0JACA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lI20v-00A3tR-4l; Fri, 05 Mar 2021 04:24:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 17/25] mm/filemap: Add wait_on_folio_locked & wait_on_folio_locked_killable
Date:   Fri,  5 Mar 2021 04:18:53 +0000
Message-Id: <20210305041901.2396498-18-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210305041901.2396498-1-willy@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Turn wait_on_page_locked() and wait_on_page_locked_killable() into
wrappers.  This eliminates a call to compound_head() from each call-site,
reducing text size by 207 bytes for me.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 26 ++++++++++++++++++--------
 mm/filemap.c            |  4 ++--
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index e7fe8b276a2d..c53743f24550 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -732,23 +732,33 @@ extern void wait_on_page_bit(struct page *page, int bit_nr);
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
index e25a5ebc914c..50263fa62574 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1559,9 +1559,9 @@ int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 
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
2.30.0

