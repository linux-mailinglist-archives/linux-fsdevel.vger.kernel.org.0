Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F808442250
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 22:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhKAVIj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 17:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhKAVIi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:08:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4384EC061714;
        Mon,  1 Nov 2021 14:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=GjVs3sP8YcLBM022Z/iDJU4ANcoNi+QMtRdM+DVSOYw=; b=C3ta9+Ug/JLSGKlke6O2qyFLRl
        m5NsOw9arejM5j198F8fOa9eZhxbnzqPoVirZlxmXCG7kjeZa1g+KVmoqOlbzh3H0SsGYM+txKoVg
        loG5VRB/ZYp1c3vqTZ3U+9syrcUFe9nT85r/UwD+sNZIubhKP24ie6anb2387y2Gl7oOH7VuxZexy
        DIuhcotbDNtJ2s+t8hIf1Oytv4C9lwvclekpP1fYZbuIWLWwVAjXLwH+qFD2XP5Jt58wg9YGQPEBt
        ZCYEX/DghJl7cJYLPp17OUZcEKKpCpVTZhzeeIPfcp8r4p34sY6mybYc0UjBZTynApVy1pLsuHgC8
        JHzmzWtQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mheSJ-00419M-7V; Mon, 01 Nov 2021 21:03:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 14/21] iomap: Convert iomap_page_mkwrite to use a folio
Date:   Mon,  1 Nov 2021 20:39:22 +0000
Message-Id: <20211101203929.954622-15-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211101203929.954622-1-willy@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we write to any page in a folio, we have to mark the entire
folio as dirty, and potentially COW the entire folio, because it'll
all get written back as one unit.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3c68ff26cd16..b55d947867b1 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -959,21 +959,21 @@ iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 }
 EXPORT_SYMBOL_GPL(iomap_truncate_page);
 
-static loff_t iomap_page_mkwrite_iter(struct iomap_iter *iter,
-		struct page *page)
+static loff_t iomap_folio_mkwrite_iter(struct iomap_iter *iter,
+		struct folio *folio)
 {
 	loff_t length = iomap_length(iter);
 	int ret;
 
 	if (iter->iomap.flags & IOMAP_F_BUFFER_HEAD) {
-		ret = __block_write_begin_int(page, iter->pos, length, NULL,
-					      &iter->iomap);
+		ret = __block_write_begin_int(&folio->page, iter->pos, length,
+						NULL, &iter->iomap);
 		if (ret)
 			return ret;
-		block_commit_write(page, 0, length);
+		block_commit_write(&folio->page, 0, length);
 	} else {
-		WARN_ON_ONCE(!PageUptodate(page));
-		set_page_dirty(page);
+		WARN_ON_ONCE(!folio_test_uptodate(folio));
+		folio_mark_dirty(folio);
 	}
 
 	return length;
@@ -985,24 +985,24 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
 		.inode		= file_inode(vmf->vma->vm_file),
 		.flags		= IOMAP_WRITE | IOMAP_FAULT,
 	};
-	struct page *page = vmf->page;
+	struct folio *folio = page_folio(vmf->page);
 	ssize_t ret;
 
-	lock_page(page);
-	ret = page_mkwrite_check_truncate(page, iter.inode);
+	folio_lock(folio);
+	ret = folio_mkwrite_check_truncate(folio, iter.inode);
 	if (ret < 0)
 		goto out_unlock;
-	iter.pos = page_offset(page);
+	iter.pos = folio_pos(folio);
 	iter.len = ret;
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.processed = iomap_page_mkwrite_iter(&iter, page);
+		iter.processed = iomap_folio_mkwrite_iter(&iter, folio);
 
 	if (ret < 0)
 		goto out_unlock;
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
2.33.0

