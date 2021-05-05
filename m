Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA6F37478A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 20:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbhEER6f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 13:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbhEER6X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 13:58:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE20C043448;
        Wed,  5 May 2021 10:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wSdGdqYDvIF9CLHaCh7peRm0lOUtvPQJ3yOyHepK0BY=; b=pOpYx9N/INbq7a4FHPmH9WfnoT
        ITY83Ngf6o0/AZC2FJ+U0yMmrQfcMlkhR2qg/ZFU6ZBPTCeN9WwYWgwBVw/0jsZ9GX7dNFQzbK4yd
        eWYxSd6zZZiz3ySMLpdLmsWOge2fZy0P5Ovn7OGGiDvGO8YlYe55JbTSZa1NFWFG5OBq9eEzkwjXy
        05arhCGhDK+//3RGiGYnN2A9tJuOqqNCX4TcgMu1jpPXHYNMop8t8y632DHdb61teZQx3iDHa3Hiw
        JgVQJtBftBbW5Bvedk5ju42bYP/Ahpft3Uwa78wyQa5o5CEIg6J7aQoi3UTdAsgUtvo1wnhBeTtKF
        VkT1bp4g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leLJR-000eH9-Ce; Wed, 05 May 2021 17:28:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 91/96] iomap: Convert iomap_page_mkwrite to use a folio
Date:   Wed,  5 May 2021 16:06:23 +0100
Message-Id: <20210505150628.111735-92-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
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
 fs/iomap/buffered-io.c | 67 +++++++++++++-----------------------------
 include/linux/iomap.h  |  2 +-
 mm/page-writeback.c    |  1 -
 3 files changed, 22 insertions(+), 48 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 1962967dc4b0..c52c266d4abe 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -637,31 +637,6 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 	return status;
 }
 
-int
-iomap_set_page_dirty(struct page *page)
-{
-	struct address_space *mapping = page_mapping(page);
-	int newly_dirty;
-
-	if (unlikely(!mapping))
-		return !TestSetPageDirty(page);
-
-	/*
-	 * Lock out page's memcg migration to keep PageDirty
-	 * synchronized with per-memcg dirty page counters.
-	 */
-	lock_page_memcg(page);
-	newly_dirty = !TestSetPageDirty(page);
-	if (newly_dirty)
-		__set_page_dirty(page, mapping, 0);
-	unlock_page_memcg(page);
-
-	if (newly_dirty)
-		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
-	return newly_dirty;
-}
-EXPORT_SYMBOL_GPL(iomap_set_page_dirty);
-
 static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 		size_t copied, struct page *page)
 {
@@ -982,23 +957,23 @@ iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
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
+		WARN_ON_ONCE(!folio_uptodate(folio));
 		iomap_page_create(inode, folio);
-		set_page_dirty(page);
+		folio_mark_dirty(folio);
 	}
 
 	return length;
@@ -1006,33 +981,33 @@ iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
 
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
+	pos = folio_offset(folio);
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
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index c87d0cb0de6d..bd02a07ddd6e 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -159,7 +159,7 @@ ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops);
 int iomap_readpage(struct page *page, const struct iomap_ops *ops);
 void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
-int iomap_set_page_dirty(struct page *page);
+#define iomap_set_page_dirty	__set_page_dirty_nobuffers
 int iomap_is_partially_uptodate(struct page *page, unsigned long from,
 		unsigned long count);
 int iomap_releasepage(struct page *page, gfp_t gfp_mask);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index ac86f3cbba1c..1b5384cf51e1 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2488,7 +2488,6 @@ void __folio_mark_dirty(struct folio *folio, struct address_space *mapping,
 	}
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
 }
-EXPORT_SYMBOL_GPL(__folio_mark_dirty);
 
 /**
  * filemap_dirty_folio - Mark a folio dirty for filesystems which do not use buffer_heads.
-- 
2.30.2

