Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633D04AFE4D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiBIUXE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:23:04 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiBIUWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2AFE040CBB
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Sh+3Y7aWFUPzzb3iJpZHLeUaRSTKPG9IGjdOEs+Uz5k=; b=ORKXy5qdY1TjocH8IEVhn1IR3g
        xJXT30SPtgcRj1O6MEZZz9ACAnA1naUYTQHzfK79ihECCkmr6bzAbJ+VVQGroowZEneqSdZGXzLrB
        +y0TfKcPucqa1GYsG4hYOOWMuIbzU6YlZPOeNEgk8uNaE9AEwadUE6upMFukLSa5LObPScYPF/yht
        RAOfOv5P7yiwBtsKvhgwEpWm0HMJUVc1Vh94umG8Ra6/j3zMGKO39K5HLyX6qXRu76NkBHUsti9Jp
        RrYTJfjumdK4gwpq15cdcWGSlCtB2d+2q0+MVx2SGh0HXmWKkvGJ8sTvCusb5ibmy3iayk9VOC9j1
        toVEYCrg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTu-008crg-KY; Wed, 09 Feb 2022 20:22:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 32/56] fs: Remove aops->invalidatepage
Date:   Wed,  9 Feb 2022 20:21:51 +0000
Message-Id: <20220209202215.2055748-33-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With all users migrated to ->invalidate_folio, remove the old operation.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/locking.rst |  2 --
 Documentation/filesystems/vfs.rst     |  1 -
 include/linux/fs.h                    |  1 -
 mm/truncate.c                         | 14 +++-----------
 4 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 29a045fd3860..8e9cbc0fb70f 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -251,7 +251,6 @@ prototypes::
 				struct page *page, void *fsdata);
 	sector_t (*bmap)(struct address_space *, sector_t);
 	void (*invalidate_folio) (struct folio *, size_t start, size_t len);
-	void (*invalidatepage) (struct page *, unsigned int, unsigned int);
 	int (*releasepage) (struct page *, int);
 	void (*freepage)(struct page *);
 	int (*direct_IO)(struct kiocb *, struct iov_iter *iter);
@@ -280,7 +279,6 @@ write_begin:		locks the page		 exclusive
 write_end:		yes, unlocks		 exclusive
 bmap:
 invalidate_folio:	yes					exclusive
-invalidatepage:		yes					exclusive
 releasepage:		yes
 freepage:		yes
 direct_IO:
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 26c090cd8cf5..28704831652c 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -736,7 +736,6 @@ cache in your filesystem.  The following members are defined:
 				 struct page *page, void *fsdata);
 		sector_t (*bmap)(struct address_space *, sector_t);
 		void (*invalidate_folio) (struct folio *, size_t start, size_t len);
-		void (*invalidatepage) (struct page *, unsigned int, unsigned int);
 		int (*releasepage) (struct page *, int);
 		void (*freepage)(struct page *);
 		ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a40ea82248da..af9ae091bd82 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -388,7 +388,6 @@ struct address_space_operations {
 	/* Unfortunately this kludge is needed for FIBMAP. Don't use it */
 	sector_t (*bmap)(struct address_space *, sector_t);
 	void (*invalidate_folio) (struct folio *, size_t offset, size_t len);
-	void (*invalidatepage) (struct page *, unsigned int, unsigned int);
 	int (*releasepage) (struct page *, gfp_t);
 	void (*freepage)(struct page *);
 	ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
diff --git a/mm/truncate.c b/mm/truncate.c
index 28650151091a..8010461a59bd 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -19,8 +19,7 @@
 #include <linux/highmem.h>
 #include <linux/pagevec.h>
 #include <linux/task_io_accounting_ops.h>
-#include <linux/buffer_head.h>	/* grr. try_to_release_page,
-				   do_invalidatepage */
+#include <linux/buffer_head.h>	/* grr. try_to_release_page */
 #include <linux/shmem_fs.h>
 #include <linux/rmap.h>
 #include "internal.h"
@@ -155,16 +154,9 @@ static int invalidate_exceptional_entry2(struct address_space *mapping,
 void folio_invalidate(struct folio *folio, size_t offset, size_t length)
 {
 	const struct address_space_operations *aops = folio->mapping->a_ops;
-	void (*invalidatepage)(struct page *, unsigned int, unsigned int);
 
-	if (aops->invalidate_folio) {
+	if (aops->invalidate_folio)
 		aops->invalidate_folio(folio, offset, length);
-		return;
-	}
-
-	invalidatepage = aops->invalidatepage;
-	if (invalidatepage)
-		(*invalidatepage)(&folio->page, offset, length);
 }
 EXPORT_SYMBOL_GPL(folio_invalidate);
 
@@ -334,7 +326,7 @@ int invalidate_inode_page(struct page *page)
  * mapping is large, it is probably the case that the final pages are the most
  * recently touched, and freeing happens in ascending file offset order.
  *
- * Note that since ->invalidatepage() accepts range to invalidate
+ * Note that since ->invalidate_folio() accepts range to invalidate
  * truncate_inode_pages_range is able to handle cases where lend + 1 is not
  * page aligned properly.
  */
-- 
2.34.1

