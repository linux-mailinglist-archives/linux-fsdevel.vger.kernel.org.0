Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEFEB3506FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 20:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbhCaSyh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 14:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236083AbhCaSyV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:54:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AEEC061574;
        Wed, 31 Mar 2021 11:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jBvyUkg0K6+dhH/UQpU2Gq17PKaf9GSpt0cheNu67uc=; b=pSSsrqIUZpmTCNnonoijYKdu1x
        feNLHO+gBe7iL3d4D516S7muJ8T89IQ5WnVBzn3y5Xf/IMWOo0OtcAquyvoEZJx5+wokeJmoCUWyF
        PTgKnGZlyBUFEj2x37I4G8rqvZxM+/sTzF3LW6xVwzxlKr7oeLb1pH9G/yIZJ1g6cgyylWCx6FNqb
        U6EwodiWo3uBwXHoho6647dVVFiNUuS+IL70sBb7yFlPJGGYZP0KQ3lNvqdltOWxitLp879P+SnZA
        Khpln7oyaQoeNVYFWhHUZ3nuGNjVke8uHgeHMx2hH9BtNEXeiWENQUR3bWBbC2z0rE2ZTIAUVQ/Kn
        r7FUIVTw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRfya-004zl2-Iw; Wed, 31 Mar 2021 18:54:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: [PATCH v6 23/27] mm/writeback: Add wait_on_folio_writeback
Date:   Wed, 31 Mar 2021 19:47:24 +0100
Message-Id: <20210331184728.1188084-24-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210331184728.1188084-1-willy@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

wait_on_page_writeback_killable() only has one caller, so convert it to
call wait_on_folio_writeback_killable().  For the wait_on_page_writeback()
callers, add a compatibility wrapper around wait_on_folio_writeback().

Turning PageWriteback() into FolioWriteback() eliminates a call to
compound_head() which saves 8 bytes and 15 bytes in the two functions.
That is more than offset by adding the wait_on_page_writeback
compatibility wrapper for a net increase in text of 15 bytes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/afs/write.c          |  5 +++--
 include/linux/pagemap.h |  3 ++-
 mm/folio-compat.c       |  6 ++++++
 mm/page-writeback.c     | 48 ++++++++++++++++++++++++++++-------------
 4 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 106a864b6a93..7af2b57e601b 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -831,7 +831,8 @@ int afs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
  */
 vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 {
-	struct page *page = thp_head(vmf->page);
+	struct folio *folio = page_folio(vmf->page);
+	struct page *page = &folio->page;
 	struct file *file = vmf->vma->vm_file;
 	struct inode *inode = file_inode(file);
 	struct afs_vnode *vnode = AFS_FS_I(inode);
@@ -850,7 +851,7 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 		return VM_FAULT_RETRY;
 #endif
 
-	if (wait_on_page_writeback_killable(page))
+	if (wait_on_folio_writeback_killable(folio))
 		return VM_FAULT_RETRY;
 
 	if (lock_page_killable(page) < 0)
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 36c31cfa3e64..2be3a028eb3d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -829,7 +829,8 @@ static inline int wait_on_page_locked_killable(struct page *page)
 
 int put_and_wait_on_page_locked(struct page *page, int state);
 void wait_on_page_writeback(struct page *page);
-int wait_on_page_writeback_killable(struct page *page);
+void wait_on_folio_writeback(struct folio *folio);
+int wait_on_folio_writeback_killable(struct folio *folio);
 void end_page_writeback(struct page *page);
 void end_folio_writeback(struct folio *folio);
 void wait_for_stable_page(struct page *page);
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index d1a1dfe52589..6aadecc39fba 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -23,3 +23,9 @@ void end_page_writeback(struct page *page)
 	return end_folio_writeback(page_folio(page));
 }
 EXPORT_SYMBOL(end_page_writeback);
+
+void wait_on_page_writeback(struct page *page)
+{
+	return wait_on_folio_writeback(page_folio(page));
+}
+EXPORT_SYMBOL_GPL(wait_on_page_writeback);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 0062d5c57d41..8271f9b24b69 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2818,33 +2818,51 @@ int __test_set_page_writeback(struct page *page, bool keep_write)
 }
 EXPORT_SYMBOL(__test_set_page_writeback);
 
-/*
- * Wait for a page to complete writeback
+/**
+ * wait_on_folio_writeback - Wait for a folio to finish writeback.
+ * @folio: The folio to wait for.
+ *
+ * If the folio is currently being written back to storage, wait for the
+ * I/O to complete.
+ *
+ * Context: Sleeps.  Must be called in process context and with
+ * no spinlocks held.  Caller should hold a reference on the folio.
+ * If the folio is not locked, writeback may start again after writeback
+ * has finished.
  */
-void wait_on_page_writeback(struct page *page)
+void wait_on_folio_writeback(struct folio *folio)
 {
-	while (PageWriteback(page)) {
-		trace_wait_on_page_writeback(page, page_mapping(page));
-		wait_on_page_bit(page, PG_writeback);
+	while (FolioWriteback(folio)) {
+		trace_wait_on_page_writeback(&folio->page, folio_mapping(folio));
+		wait_on_page_bit(&folio->page, PG_writeback);
 	}
 }
-EXPORT_SYMBOL_GPL(wait_on_page_writeback);
+EXPORT_SYMBOL_GPL(wait_on_folio_writeback);
 
-/*
- * Wait for a page to complete writeback.  Returns -EINTR if we get a
- * fatal signal while waiting.
+/**
+ * wait_on_folio_writeback_killable - Wait for a folio to finish writeback.
+ * @folio: The folio to wait for.
+ *
+ * If the folio is currently being written back to storage, wait for the
+ * I/O to complete or a fatal signal to arrive.
+ *
+ * Context: Sleeps.  Must be called in process context and with
+ * no spinlocks held.  Caller should hold a reference on the folio.
+ * If the folio is not locked, writeback may start again after writeback
+ * has finished.
+ * Return: 0 on success, -EINTR if we get a fatal signal while waiting.
  */
-int wait_on_page_writeback_killable(struct page *page)
+int wait_on_folio_writeback_killable(struct folio *folio)
 {
-	while (PageWriteback(page)) {
-		trace_wait_on_page_writeback(page, page_mapping(page));
-		if (wait_on_page_bit_killable(page, PG_writeback))
+	while (FolioWriteback(folio)) {
+		trace_wait_on_page_writeback(&folio->page, folio_mapping(folio));
+		if (wait_on_page_bit_killable(&folio->page, PG_writeback))
 			return -EINTR;
 	}
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(wait_on_page_writeback_killable);
+EXPORT_SYMBOL_GPL(wait_on_folio_writeback_killable);
 
 /**
  * wait_for_stable_page() - wait for writeback to finish, if necessary.
-- 
2.30.2

