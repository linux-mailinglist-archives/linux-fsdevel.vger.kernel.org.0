Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD1B3C97ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbhGOFCg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 01:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhGOFCg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:02:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96036C06175F;
        Wed, 14 Jul 2021 21:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7lTXz8qKWpvI3xOInmpk72M0koZDIoK0yX/to4rhQ1E=; b=ZWsSi9JuYa7IMG6cWID1nDtJ/e
        LJ8mmucJ1MPwjZtaZ1tIyFV0fdJzc9vmy+BLlqfFOYTECl+eADIifZTGtM+gtWn1RbrXnbBIm7cfA
        ERyHI3+Fvy36Qzjp/ep4kE+GJTS/+KZmqr5DyFxIvoNaqV+LVB5nu47VVDZHxtg+pndYUiGbsfWXU
        hdqrMI1Skp5ba0ZOhsyujYkM3ncIuopwf+00tu2FJVuBP0tPxpWKyT8HG8uxM7NBYhnUmtMKywVfj
        UO1SA1BQNt3GDtRh6vbVrLHI6Ved7wiK2QvJQXO5c62WkRrVN2TazlZ8ATBDofsKc4PtVokHBCGRl
        FbjYJAzw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3tRc-002zS9-7q; Thu, 15 Jul 2021 04:58:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 101/138] iomap: Convert iomap_page_mkwrite to use a folio
Date:   Thu, 15 Jul 2021 04:36:27 +0100
Message-Id: <20210715033704.692967-102-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we write to any page in a folio, we have to mark the entire
folio as dirty, and potentially COW the entire folio, because it'll
all get written back as one unit.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 7c702d6c2f64..a3fe0d36c739 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -951,23 +951,23 @@ iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 }
 EXPORT_SYMBOL_GPL(iomap_truncate_page);
 
-static loff_t
-iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
-		void *data, struct iomap *iomap, struct iomap *srcmap)
+static loff_t iomap_folio_mkwrite_actor(struct inode *inode, loff_t pos,
+		loff_t length, void *data, struct iomap *iomap,
+		struct iomap *srcmap)
 {
-	struct page *page = data;
-	struct folio *folio = page_folio(page);
+	struct folio *folio = data;
 	int ret;
 
 	if (iomap->flags & IOMAP_F_BUFFER_HEAD) {
-		ret = __block_write_begin_int(page, pos, length, NULL, iomap);
+		ret = __block_write_begin_int(&folio->page, pos, length, NULL,
+						iomap);
 		if (ret)
 			return ret;
-		block_commit_write(page, 0, length);
+		block_commit_write(&folio->page, 0, length);
 	} else {
-		WARN_ON_ONCE(!PageUptodate(page));
+		WARN_ON_ONCE(!folio_test_uptodate(folio));
 		iomap_page_create(inode, folio);
-		set_page_dirty(page);
+		folio_mark_dirty(folio);
 	}
 
 	return length;
@@ -975,33 +975,33 @@ iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
 
 vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
 {
-	struct page *page = vmf->page;
+	struct folio *folio = page_folio(vmf->page);
 	struct inode *inode = file_inode(vmf->vma->vm_file);
-	unsigned long length;
-	loff_t offset;
+	size_t length;
+	loff_t pos;
 	ssize_t ret;
 
-	lock_page(page);
-	ret = page_mkwrite_check_truncate(page, inode);
+	folio_lock(folio);
+	ret = folio_mkwrite_check_truncate(folio, inode);
 	if (ret < 0)
 		goto out_unlock;
 	length = ret;
 
-	offset = page_offset(page);
+	pos = folio_pos(folio);
 	while (length > 0) {
-		ret = iomap_apply(inode, offset, length,
-				IOMAP_WRITE | IOMAP_FAULT, ops, page,
-				iomap_page_mkwrite_actor);
+		ret = iomap_apply(inode, pos, length,
+				IOMAP_WRITE | IOMAP_FAULT, ops, folio,
+				iomap_folio_mkwrite_actor);
 		if (unlikely(ret <= 0))
 			goto out_unlock;
-		offset += ret;
+		pos += ret;
 		length -= ret;
 	}
 
-	wait_for_stable_page(page);
+	folio_wait_stable(folio);
 	return VM_FAULT_LOCKED;
 out_unlock:
-	unlock_page(page);
+	folio_unlock(folio);
 	return block_page_mkwrite_return(ret);
 }
 EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
-- 
2.30.2

