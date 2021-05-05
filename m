Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A33C373FC3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 18:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbhEEQ2l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 12:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbhEEQ2l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 12:28:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE54C061574;
        Wed,  5 May 2021 09:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=KZsJy15ycqPl2QquPyrBUmKx94yOcdRveQxvm3oyBj4=; b=mt12vptRP8+zYkM49Dq74um4xi
        zqjyLAYgSOo+mmRryJehoJdPmLQZ7/zRBEkbEoa9500IXUU3qm87WL67GS1Os9CBMJ7SnzijzwSPj
        kPauFfg9AJbLJxqzluy4ztKd1UltWK+w9IDGymb0TIutk1G5Qh6qxqmeR0tK3Cc467rWFPCiEF2SZ
        NA17YkBYNvio9UNRlv3kB+T2nn5Mi4LeXHqFnrAWHkxVEuj+SCQcZT3h2lGtpOKZF4jcwppk5teRh
        bbs4Y2/Ebx5YLBIhUTI3R///g1nUtvFN6nLjFH41UANE32oBHztvJeaP8SKu3XjM1Gc5MwujbY1LW
        +FoAL4Ew==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leKJZ-000aHo-Sb; Wed, 05 May 2021 16:24:30 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 67/96] mm/writeback: Add folio_redirty_for_writepage
Date:   Wed,  5 May 2021 16:05:59 +0100
Message-Id: <20210505150628.111735-68-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reimplement redirty_page_for_writepage() as a wrapper around
folio_redirty_for_writepage().  Account the number of pages in the
folio, add kernel-doc and move the prototype to writeback.h.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
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
index 36e9ae216df3..3f91c9971b32 100644
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
@@ -1991,8 +1989,6 @@ extern void do_invalidatepage(struct page *page, unsigned int offset,
 
 int __set_page_dirty_nobuffers(struct page *page);
 int __set_page_dirty_no_writeback(struct page *page);
-int redirty_page_for_writepage(struct writeback_control *wbc,
-				struct page *page);
 bool folio_mark_dirty(struct folio *folio);
 bool set_page_dirty(struct page *page);
 int set_page_dirty_lock(struct page *page);
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 9883dbf8b763..bdf933f74a1d 100644
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
index 76262bcf858c..a57a1f53512c 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -72,3 +72,10 @@ bool clear_page_dirty_for_io(struct page *page)
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
index 1ff3e7dec0bd..ac86f3cbba1c 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2565,21 +2565,31 @@ void folio_account_redirty(struct folio *folio)
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

