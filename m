Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9B0370082
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 20:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhD3Scn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 14:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhD3Scm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 14:32:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE4BC06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 11:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=hnKlPQ52GLJNFk079kXwh30lCvxz3Q0G5IQAMsKa0AE=; b=A0uDX3nAE0zRoMNeJE/LKVp1ji
        i+f3ioA/dLYoNE5aNKZwiXlCxnL+KnQsLisuXvDulwSKNxWwhy5F4/7Kb7L2eaZEDMNqAZ3u635xL
        HIhOxcZJKPPkvHxyWw3jBT8rUQlu9PxMTPHqGxfQFTlvh1I1EfONdCp22rUAHWxTmBX2M3stIQUrN
        HHTASSDx8g2fFiJImnjGcC2XPt5S4qCeOzZK8ZZXmAEykgOwztRg9EKxb4hZi4pJo7lEZVwJwsEAJ
        p+fy1hkFUkC2pPxI7X1JxPSeM4OBKN+lul7nVpBHn16aS3ZF9zi/efWaXoDqans7h5ytijsFt/dY6
        VczupBOA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcXuC-00BNqK-KU; Fri, 30 Apr 2021 18:30:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v8 26/31] mm/writeback: Add folio_wait_stable
Date:   Fri, 30 Apr 2021 19:07:35 +0100
Message-Id: <20210430180740.2707166-27-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210430180740.2707166-1-willy@infradead.org>
References: <20210430180740.2707166-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move wait_for_stable_page() into the folio compatibility file.
folio_wait_stable() avoids a call to compound_head() and is 14 bytes
smaller than wait_for_stable_page() was.  The net text size grows by 24
bytes as a result of this patch.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/pagemap.h |  1 +
 mm/folio-compat.c       |  6 ++++++
 mm/page-writeback.c     | 24 ++++++++++++++----------
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 814c488926d2..b11482e1ef18 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -833,6 +833,7 @@ int folio_wait_writeback_killable(struct folio *folio);
 void end_page_writeback(struct page *page);
 void folio_end_writeback(struct folio *folio);
 void wait_for_stable_page(struct page *page);
+void folio_wait_stable(struct folio *folio);
 
 void page_endio(struct page *page, bool is_write, int err);
 
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 41275dac7a92..3c83f03b80d7 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -29,3 +29,9 @@ void wait_on_page_writeback(struct page *page)
 	return folio_wait_writeback(page_folio(page));
 }
 EXPORT_SYMBOL_GPL(wait_on_page_writeback);
+
+void wait_for_stable_page(struct page *page)
+{
+	return folio_wait_stable(page_folio(page));
+}
+EXPORT_SYMBOL_GPL(wait_for_stable_page);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index c8bc78cd0f2b..8b15c44552f7 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2865,17 +2865,21 @@ int folio_wait_writeback_killable(struct folio *folio)
 EXPORT_SYMBOL_GPL(folio_wait_writeback_killable);
 
 /**
- * wait_for_stable_page() - wait for writeback to finish, if necessary.
- * @page:	The page to wait on.
+ * folio_wait_stable() - wait for writeback to finish, if necessary.
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
+void folio_wait_stable(struct folio *folio)
 {
-	page = thp_head(page);
-	if (page->mapping->host->i_sb->s_iflags & SB_I_STABLE_WRITES)
-		wait_on_page_writeback(page);
+	if (folio->mapping->host->i_sb->s_iflags & SB_I_STABLE_WRITES)
+		folio_wait_writeback(folio);
 }
-EXPORT_SYMBOL_GPL(wait_for_stable_page);
+EXPORT_SYMBOL_GPL(folio_wait_stable);
-- 
2.30.2

