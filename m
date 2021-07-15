Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0113C96C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 05:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhGOEBo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhGOEBo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:01:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82851C06175F;
        Wed, 14 Jul 2021 20:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IZCiBNqStsWdStEcl45/s7ejWTOvRS1aVZyHPqRW2vE=; b=A6E1QrSqJug+IGJ8zS4Qr/dE9u
        8TpYch9KfuQYWux4BAEjp9ZFA+GzyDcwIGtIjWc8ZO7YrHh0Tr1+NKT+ElhuPbtmWzv1LYx2Jcjhg
        E2ZqPzXrfAIRI2Te/IRPI/duTKewuotyBzFVDD3ioUDra+YKWkqHIY+5msEO6PPwz+smCdCKQLv4r
        dqYYbc2tGvU8ggpks155F6o+a6fLq/GfSYE+Ee1fHmxM8woCUDsQqw7SMDTMF6Q7x3e+3zgFIHeYm
        4wIYblp7OAeqBNoLeeM4wlP7ZLWag3g1W3VGOEkMNyqerrD3gRevDWNVtBQe3t5ezTxe1LF2L2PWi
        NM1kMSIg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3sVS-002vW3-LT; Thu, 15 Jul 2021 03:58:03 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v14 025/138] mm/writeback: Add folio_wait_writeback()
Date:   Thu, 15 Jul 2021 04:35:11 +0100
Message-Id: <20210715033704.692967-26-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

wait_on_page_writeback_killable() only has one caller, so convert it to
call folio_wait_writeback_killable().  For the wait_on_page_writeback()
callers, add a compatibility wrapper around folio_wait_writeback().

Turning PageWriteback() into folio_test_writeback() eliminates a call
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
index 3104b62c2082..fb7d5c1cabde 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -839,7 +839,8 @@ int afs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
  */
 vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 {
-	struct page *page = thp_head(vmf->page);
+	struct folio *folio = page_folio(vmf->page);
+	struct page *page = &folio->page;
 	struct file *file = vmf->vma->vm_file;
 	struct inode *inode = file_inode(file);
 	struct afs_vnode *vnode = AFS_FS_I(inode);
@@ -859,7 +860,7 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 		goto out;
 #endif
 
-	if (wait_on_page_writeback_killable(page))
+	if (folio_wait_writeback_killable(folio))
 		goto out;
 
 	if (lock_page_killable(page) < 0)
@@ -869,8 +870,8 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	 * details the portion of the page we need to write back and we might
 	 * need to redirty the page if there's a problem.
 	 */
-	if (wait_on_page_writeback_killable(page) < 0) {
-		unlock_page(page);
+	if (folio_wait_writeback_killable(folio) < 0) {
+		folio_unlock(folio);
 		goto out;
 	}
 
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 66a019178550..0c5f53368fe9 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -767,7 +767,8 @@ static inline int wait_on_page_locked_killable(struct page *page)
 
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
index 9f63548f247c..c2c00e1533ad 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2830,33 +2830,51 @@ int __test_set_page_writeback(struct page *page, bool keep_write)
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
+	while (folio_test_writeback(folio)) {
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
+	while (folio_test_writeback(folio)) {
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

