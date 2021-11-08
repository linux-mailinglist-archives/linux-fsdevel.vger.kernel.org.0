Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383C7447993
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 05:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbhKHExq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Nov 2021 23:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237588AbhKHExl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Nov 2021 23:53:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F1DC061766;
        Sun,  7 Nov 2021 20:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ABOv/y8+NXP2UR+IqvkpxutjcwPquj4gNrIuYlOU0hA=; b=dYwvRN3+fqkPpLR/io9BmJ/HK3
        SSWPMVurgAaiwUidE1ZChcbkoLpNs9gcLYLNkagI8RaqK7exsY4UuMwMP8h9VJjq/U3fZcmC9XZDM
        5cMH+AkFN/y1pKVv4veEjRxN4+nvb8HQFB6PUDHNegiyB1IaR0EjVf4W2iC9naTGZIKLqs/qzzLpq
        /Q7bsJ+PTY7So+foG/oZZr+FNhSzQEhD8nDLUzl7usPcXNXs5x+XH5A+G0rt3Z3oHeFV7KwYMIjjZ
        0glVYzT8b60+h9zscisMdMX39uVOk8pfDRvjWCfb9a1WRjs5l1M/EQsDC+4FZT4MX5GYiXljg04PA
        y/Dfb8KA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjwZX-008AQX-Vg; Mon, 08 Nov 2021 04:48:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J . Wong " <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 18/28] iomap: Convert iomap_page_mkwrite to use a folio
Date:   Mon,  8 Nov 2021 04:05:41 +0000
Message-Id: <20211108040551.1942823-19-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108040551.1942823-1-willy@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index b0b402e1779e..64e54981b651 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -960,10 +960,9 @@ iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 }
 EXPORT_SYMBOL_GPL(iomap_truncate_page);
 
-static loff_t iomap_page_mkwrite_iter(struct iomap_iter *iter,
-		struct page *page)
+static loff_t iomap_folio_mkwrite_iter(struct iomap_iter *iter,
+		struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	loff_t length = iomap_length(iter);
 	int ret;
 
@@ -972,10 +971,10 @@ static loff_t iomap_page_mkwrite_iter(struct iomap_iter *iter,
 					      &iter->iomap);
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
@@ -987,24 +986,24 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
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

