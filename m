Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35B1373EEF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 17:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbhEEPuQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 11:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhEEPuO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 11:50:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D479C061574;
        Wed,  5 May 2021 08:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bWSWbJw5qB0jdRtzzhXXszbqYIbf1wkDS/2X4nyFn7Q=; b=AtIzdSaswUAV5+vPiUsyUDfrSS
        RczVf8u5oJPPO3sNB3AT6oEGGP6pF0PeZYBCmfK5rY/XLL3JqH6acfE/wpdr9+t5lzyHYijrjWalY
        AIAFX19OBrTr4es54z3tViPqrzuZg4Bun4hSI9s4JYgjdY2FbJy/byBM+hoMEJT4T0LY6cPjI5nkk
        dNzysgAEJH1k3BJmRJN3tYfyBotaoNemZTGqeF9JliuCVwoV9pTIQv/WIKEwydWBOrKax/O3vK3+U
        sXGvvVZLJ4OdRqU+TAfnC6mgt4oVb8i89s/q3pI2ItSgWP7jXfd3gtGh69M802Utu4PY71V33ePde
        +zjdumIw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leJia-000WUb-VJ; Wed, 05 May 2021 15:46:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v9 33/96] mm/writeback: Add folio_wait_writeback
Date:   Wed,  5 May 2021 16:05:25 +0100
Message-Id: <20210505150628.111735-34-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

wait_on_page_writeback_killable() only has one caller, so convert it to
call folio_wait_writeback_killable().  For the wait_on_page_writeback()
callers, add a compatibility wrapper around folio_wait_writeback().

Turning PageWriteback() into folio_writeback() eliminates a call to
compound_head() which saves 8 bytes and 15 bytes in the two functions.
That is more than offset by adding the wait_on_page_writeback
compatibility wrapper for a net increase in text of 15 bytes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 fs/afs/write.c          |  9 ++++----
 include/linux/pagemap.h |  3 ++-
 mm/folio-compat.c       |  6 ++++++
 mm/page-writeback.c     | 48 ++++++++++++++++++++++++++++-------------
 4 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 3edb6204b937..22b1c4d43687 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -832,7 +832,8 @@ int afs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
  */
 vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 {
-	struct page *page = thp_head(vmf->page);
+	struct folio *folio = page_folio(vmf->page);
+	struct page *page = &folio->page;
 	struct file *file = vmf->vma->vm_file;
 	struct inode *inode = file_inode(file);
 	struct afs_vnode *vnode = AFS_FS_I(inode);
@@ -851,7 +852,7 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 		return VM_FAULT_RETRY;
 #endif
 
-	if (wait_on_page_writeback_killable(page))
+	if (folio_wait_writeback_killable(folio))
 		return VM_FAULT_RETRY;
 
 	if (lock_page_killable(page) < 0)
@@ -861,8 +862,8 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	 * details the portion of the page we need to write back and we might
 	 * need to redirty the page if there's a problem.
 	 */
-	if (wait_on_page_writeback_killable(page) < 0) {
-		unlock_page(page);
+	if (folio_wait_writeback_killable(folio) < 0) {
+		folio_unlock(folio);
 		return VM_FAULT_RETRY;
 	}
 
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index f1078272fb26..8849180c783c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -828,7 +828,8 @@ static inline int wait_on_page_locked_killable(struct page *page)
 
 int put_and_wait_on_page_locked(struct page *page, int state);
 void wait_on_page_writeback(struct page *page);
-int wait_on_page_writeback_killable(struct page *page);
+void folio_wait_writeback(struct folio *folio);
+int folio_wait_writeback_killable(struct folio *folio);
 void end_page_writeback(struct page *page);
 void folio_end_writeback(struct folio *folio);
 void wait_for_stable_page(struct page *page);
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 526843d03d58..41275dac7a92 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -23,3 +23,9 @@ void end_page_writeback(struct page *page)
 	return folio_end_writeback(page_folio(page));
 }
 EXPORT_SYMBOL(end_page_writeback);
+
+void wait_on_page_writeback(struct page *page)
+{
+	return folio_wait_writeback(page_folio(page));
+}
+EXPORT_SYMBOL_GPL(wait_on_page_writeback);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 0062d5c57d41..c8bc78cd0f2b 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2818,33 +2818,51 @@ int __test_set_page_writeback(struct page *page, bool keep_write)
 }
 EXPORT_SYMBOL(__test_set_page_writeback);
 
-/*
- * Wait for a page to complete writeback
+/**
+ * folio_wait_writeback - Wait for a folio to finish writeback.
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
+void folio_wait_writeback(struct folio *folio)
 {
-	while (PageWriteback(page)) {
-		trace_wait_on_page_writeback(page, page_mapping(page));
-		wait_on_page_bit(page, PG_writeback);
+	while (folio_writeback(folio)) {
+		trace_wait_on_page_writeback(&folio->page, folio_mapping(folio));
+		wait_on_page_bit(&folio->page, PG_writeback);
 	}
 }
-EXPORT_SYMBOL_GPL(wait_on_page_writeback);
+EXPORT_SYMBOL_GPL(folio_wait_writeback);
 
-/*
- * Wait for a page to complete writeback.  Returns -EINTR if we get a
- * fatal signal while waiting.
+/**
+ * folio_wait_writeback_killable - Wait for a folio to finish writeback.
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
+int folio_wait_writeback_killable(struct folio *folio)
 {
-	while (PageWriteback(page)) {
-		trace_wait_on_page_writeback(page, page_mapping(page));
-		if (wait_on_page_bit_killable(page, PG_writeback))
+	while (folio_writeback(folio)) {
+		trace_wait_on_page_writeback(&folio->page, folio_mapping(folio));
+		if (wait_on_page_bit_killable(&folio->page, PG_writeback))
 			return -EINTR;
 	}
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(wait_on_page_writeback_killable);
+EXPORT_SYMBOL_GPL(folio_wait_writeback_killable);
 
 /**
  * wait_for_stable_page() - wait for writeback to finish, if necessary.
-- 
2.30.2

