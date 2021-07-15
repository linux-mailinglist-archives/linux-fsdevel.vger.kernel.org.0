Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5843C981D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 07:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238186AbhGOFP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 01:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbhGOFP2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:15:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB6AC06175F;
        Wed, 14 Jul 2021 22:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BzlU35lU3qSym1scpXVdTvYuYkJXSOHQJYSVBLZky0w=; b=PLI9hB/9pIA7VPcXi/xFVWEV67
        x2V+RSGP4ZERq8bvKO1ZlPVgTfPgL4/BqiVqzOUzr0g771DkEm/JdrKwoNGrG3r++gEt7BFlcwbvB
        qO09ISougSNBNxkUPncXDvnzsM2HZjJ0JgsveRcXsEQ6bgjDgPWLl+wtv1/3qR0Yge35Zx5v7mQ8T
        IuEF984wxw7itozvaqo6ZNkT7L01WtKErO1zqY2dJOLtHnQnHkqksqEDaXULp9ypfFu2Nw6yRr9fZ
        HUOurRK0NMxJio+7+CRZQ1DijYwgx+s0ovE5ozkgvRt0z3RbbKp87C84XWAqHQNDzhFd3KjnW3crx
        Tf5sDHtg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3tef-0030Gi-7R; Thu, 15 Jul 2021 05:11:34 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 116/138] mm/filemap: Convert filemap_range_uptodate to folios
Date:   Thu, 15 Jul 2021 04:36:42 +0100
Message-Id: <20210715033704.692967-117-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The only caller was already passing a head page, so this simply avoids
a call to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 7eda9afb0600..078c318e2f16 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2328,29 +2328,29 @@ static int filemap_read_folio(struct file *file, struct address_space *mapping,
 }
 
 static bool filemap_range_uptodate(struct address_space *mapping,
-		loff_t pos, struct iov_iter *iter, struct page *page)
+		loff_t pos, struct iov_iter *iter, struct folio *folio)
 {
 	int count;
 
-	if (PageUptodate(page))
+	if (folio_test_uptodate(folio))
 		return true;
 	/* pipes can't handle partially uptodate pages */
 	if (iov_iter_is_pipe(iter))
 		return false;
 	if (!mapping->a_ops->is_partially_uptodate)
 		return false;
-	if (mapping->host->i_blkbits >= (PAGE_SHIFT + thp_order(page)))
+	if (mapping->host->i_blkbits >= (folio_shift(folio)))
 		return false;
 
 	count = iter->count;
-	if (page_offset(page) > pos) {
-		count -= page_offset(page) - pos;
+	if (folio_pos(folio) > pos) {
+		count -= folio_pos(folio) - pos;
 		pos = 0;
 	} else {
-		pos -= page_offset(page);
+		pos -= folio_pos(folio);
 	}
 
-	return mapping->a_ops->is_partially_uptodate(page, pos, count);
+	return mapping->a_ops->is_partially_uptodate(&folio->page, pos, count);
 }
 
 static int filemap_update_page(struct kiocb *iocb,
@@ -2376,7 +2376,7 @@ static int filemap_update_page(struct kiocb *iocb,
 		goto truncated;
 
 	error = 0;
-	if (filemap_range_uptodate(mapping, iocb->ki_pos, iter, &folio->page))
+	if (filemap_range_uptodate(mapping, iocb->ki_pos, iter, folio))
 		goto unlock;
 
 	error = -EAGAIN;
-- 
2.30.2

