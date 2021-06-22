Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297583B03AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhFVMHY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbhFVMHW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:07:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E1CC06175F;
        Tue, 22 Jun 2021 05:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vk3MbpG8QaPYUVc1jW/XrnCBUuwvTuz+v9ZTl418MiA=; b=T7vCZAYOm+bo/Oh6Cx2Rdnlajf
        5P58AbeLgcCSgeqy3vUTkjJl5RUUmCwyyPQIVHg71Y43fq9Ej47SLcZW0gyAFvq2JpwDdvuBLHV0j
        y1NaV1D2pjf3vFCOObHheCaVU1PQ5w3DutcU2DdC5pn6TtfPuq/P8GJirTHuQTNlpNoWxKQt8tYJs
        gGZj2PekqU8ZYqFwBRm5fBFHRgV+ecBgc2AiDOtFQ4d/hhNcGiY/KauLJAeC2ZAX7Mfgwc+1hTEDk
        fpwZlR87aOwJ2KMT/9HY+US3fSAdhwxutIrJWyu90HClzJs3kVIpu6nQmVJqzTbcQXd21QrG5rFqf
        Ww48Gzmg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvf7b-00EF7V-4z; Tue, 22 Jun 2021 12:03:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v12 26/33] mm/writeback: Add folio_wait_writeback()
Date:   Tue, 22 Jun 2021 12:41:11 +0100
Message-Id: <20210622114118.3388190-27-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622114118.3388190-1-willy@infradead.org>
References: <20210622114118.3388190-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

wait_on_page_writeback_killable() only has one caller, so convert it to
call folio_wait_writeback_killable().  For the wait_on_page_writeback()
callers, add a compatibility wrapper around folio_wait_writeback().

Turning PageWriteback() into folio_writeback() eliminates a call
to compound_head() which saves 8 bytes and 15 bytes in the two
functions.  Unfortunately, that is more than offset by adding the
wait_on_page_writeback compatibility wrapper for a net increase in text
of 7 bytes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
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
index e65dc5191ff6..18288888eddf 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -766,7 +766,8 @@ static inline int wait_on_page_locked_killable(struct page *page)
 
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
index 75f6d1c5ee64..8277a0f60511 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2826,33 +2826,51 @@ int __test_set_page_writeback(struct page *page, bool keep_write)
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

