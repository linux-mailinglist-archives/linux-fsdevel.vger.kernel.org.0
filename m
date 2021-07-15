Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CA23CADE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 22:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhGOUdJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 16:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhGOUdH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:33:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F56C061760
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jul 2021 13:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=xSYyCZy/TvQ3u8VOTIJK1lZXh/nrQMsTgRx2OIA2bZw=; b=f3UUT0f2bXzAZqUtVesYLUrki6
        InO/J13EbGsorgmUfg/ou4HRCNMUAQ65vbwkyAZU1pCXwMlwOEcYrm2xqsBcJ3egzdWTWb+Fm4kZa
        GC99jedK3rpKH5mugcLzhizDvZCIvoQATUhPCij2Of7+UQK3+j/UaocvnrYJXGMiYF/0P02VnQT6d
        UmTyYP2gG6D8QU2NxSEzve1CAdyNAgDn7MSzYIRCsqTX7Pc5DwlYZHPJtF86XUlysk8lS7Ufzom9U
        oxMHSr6g4eYKcYlV84GCT0eOCSDC39AfGpoh6SbQlWeIT9gb4qRwiv2tsuzR5V4BrB3DdpG7oPiL9
        UTXC6JGA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m47x4-003phU-2Q; Thu, 15 Jul 2021 20:27:34 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 26/39] mm/writeback: Add folio_redirty_for_writepage()
Date:   Thu, 15 Jul 2021 21:00:17 +0100
Message-Id: <20210715200030.899216-27-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715200030.899216-1-willy@infradead.org>
References: <20210715200030.899216-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reimplement redirty_page_for_writepage() as a wrapper around
folio_redirty_for_writepage().  Account the number of pages in the
folio, add kernel-doc and move the prototype to writeback.h.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/jfs/jfs_metapage.c     |  1 +
 include/linux/mm.h        |  4 ----
 include/linux/writeback.h |  2 ++
 mm/folio-compat.c         |  7 +++++++
 mm/page-writeback.c       | 30 ++++++++++++++++++++----------
 5 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 176580f54af9..104ae698443e 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -13,6 +13,7 @@
 #include <linux/buffer_head.h>
 #include <linux/mempool.h>
 #include <linux/seq_file.h>
+#include <linux/writeback.h>
 #include "jfs_incore.h"
 #include "jfs_superblock.h"
 #include "jfs_filsys.h"
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 26883ea28349..4803f2c01367 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -36,9 +36,7 @@
 struct mempolicy;
 struct anon_vma;
 struct anon_vma_chain;
-struct file_ra_state;
 struct user_struct;
-struct writeback_control;
 struct pt_regs;
 
 extern int sysctl_page_lock_unfairness;
@@ -2000,8 +1998,6 @@ extern int try_to_release_page(struct page * page, gfp_t gfp_mask);
 extern void do_invalidatepage(struct page *page, unsigned int offset,
 			      unsigned int length);
 
-int redirty_page_for_writepage(struct writeback_control *wbc,
-				struct page *page);
 bool folio_mark_dirty(struct folio *folio);
 bool set_page_dirty(struct page *page);
 int set_page_dirty_lock(struct page *page);
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 50cb6e25ab9e..5383f7e39816 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -404,6 +404,8 @@ static inline void account_page_redirty(struct page *page)
 {
 	folio_account_redirty(page_folio(page));
 }
+bool folio_redirty_for_writepage(struct writeback_control *, struct folio *);
+bool redirty_page_for_writepage(struct writeback_control *, struct page *);
 
 void sb_mark_inode_writeback(struct inode *inode);
 void sb_clear_inode_writeback(struct inode *inode);
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 39f5a8d963b1..c1e01bc36d32 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -95,3 +95,10 @@ bool clear_page_dirty_for_io(struct page *page)
 	return folio_clear_dirty_for_io(page_folio(page));
 }
 EXPORT_SYMBOL(clear_page_dirty_for_io);
+
+bool redirty_page_for_writepage(struct writeback_control *wbc,
+		struct page *page)
+{
+	return folio_redirty_for_writepage(wbc, page_folio(page));
+}
+EXPORT_SYMBOL(redirty_page_for_writepage);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index d7bd5580c91e..c2987f05c944 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2558,21 +2558,31 @@ void folio_account_redirty(struct folio *folio)
 }
 EXPORT_SYMBOL(folio_account_redirty);
 
-/*
- * When a writepage implementation decides that it doesn't want to write this
- * page for some reason, it should redirty the locked page via
- * redirty_page_for_writepage() and it should then unlock the page and return 0
+/**
+ * folio_redirty_for_writepage - Decline to write a dirty folio.
+ * @wbc: The writeback control.
+ * @folio: The folio.
+ *
+ * When a writepage implementation decides that it doesn't want to write
+ * @folio for some reason, it should call this function, unlock @folio and
+ * return 0.
+ *
+ * Return: True if we redirtied the folio.  False if someone else dirtied
+ * it first.
  */
-int redirty_page_for_writepage(struct writeback_control *wbc, struct page *page)
+bool folio_redirty_for_writepage(struct writeback_control *wbc,
+		struct folio *folio)
 {
-	int ret;
+	bool ret;
+	unsigned nr = folio_nr_pages(folio);
+
+	wbc->pages_skipped += nr;
+	ret = filemap_dirty_folio(folio->mapping, folio);
+	folio_account_redirty(folio);
 
-	wbc->pages_skipped++;
-	ret = __set_page_dirty_nobuffers(page);
-	account_page_redirty(page);
 	return ret;
 }
-EXPORT_SYMBOL(redirty_page_for_writepage);
+EXPORT_SYMBOL(folio_redirty_for_writepage);
 
 /**
  * folio_mark_dirty - Mark a folio as being modified.
-- 
2.30.2

