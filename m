Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACA7477E41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 22:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241756AbhLPVHs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 16:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241589AbhLPVHY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:07:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD45BC061756;
        Thu, 16 Dec 2021 13:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=t+DGtRseGLddgzRTezSz/EKylPqS09NEepsXJi8iyNA=; b=NRYY4U2Cq4ZuwxLo6LGrUNVdmF
        C/jHDnjjthvgzsW9H8KZi17/73l7n0qAVxcwgPavN/vJ3bdhcLPCKelJ82nQe63NkxXY9OS8UWFIz
        QzUalCQ2nKIlmF0+MK/jEDW7VgU6MkhlDpn/KhJ7GOsmwlRTj17z4RIbKTVcWv1hiPp5TUCAKYbq/
        4tOonRnk6JTXqGIhhpXwqO+9gtjsiBDTcqW4ocMQ5khsQvgK/+y2OenfV65VWbg2XsipxQNAYp+Sa
        GUuDbh3Xi7UA1Nr5SJO+GYalPT47bxkyK5CRw/8O19G/pylgLXn6VJUHJzE6l/6P3dE0lieRNi3iy
        4Sk9+hlw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxxyC-00Fx4G-Gg; Thu, 16 Dec 2021 21:07:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 14/25] iomap: Convert iomap_page_mkwrite to use a folio
Date:   Thu, 16 Dec 2021 21:07:04 +0000
Message-Id: <20211216210715.3801857-15-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216210715.3801857-1-willy@infradead.org>
References: <20211216210715.3801857-1-willy@infradead.org>
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
index ad89c20cb741..8d7a67655b60 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -967,10 +967,9 @@ iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
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
 
@@ -979,10 +978,10 @@ static loff_t iomap_page_mkwrite_iter(struct iomap_iter *iter,
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
@@ -994,24 +993,24 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
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

