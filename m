Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A1A2A3335
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 19:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgKBSna (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 13:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgKBSn3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:43:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94068C0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 10:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=QtHfrKT5xabd5uqtY4b+yuJs0ExznL5pKGwHYW5XBsc=; b=hmQCHLP7INmBJOug4JStsn+6kQ
        qxiTWM4ps8wndza/iHprPu2ivWO6Ls5OPS5QECPXXC47rAuETRmAD+B2pK+L/jBy9BI6q6g08yEMY
        nestnIFVn3wQ++JSHDD+Ur5/Plqdp9s92ekaXawKR1HaRkdPwnOlFTySrHxdckqq51jlhTmoCgJKj
        bKJscoW4lwPWfg8wIcNVWD6mjQYEl0wj9z/mRv0RR6bDrTNOBqUvjAUHGyHzy+WYFKOy2W5gFISpD
        tt96oWq6uUZ8VSDw0m/taZah8hm9IePKQWhq6IwvbPuxn8o48K3qCHzXM1IUvtTJU+tRS0KDnTWgf
        K07Agg8Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZenc-0006o3-5L; Mon, 02 Nov 2020 18:43:24 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH 11/17] mm/filemap: Add filemap_range_uptodate
Date:   Mon,  2 Nov 2020 18:43:06 +0000
Message-Id: <20201102184312.25926-12-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201102184312.25926-1-willy@infradead.org>
References: <20201102184312.25926-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the complicated condition and the calculations out of
filemap_update_page() into its own function.
---
 mm/filemap.c | 49 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 41b90243f4ee..81b569d818a3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2228,11 +2228,39 @@ static int filemap_read_page(struct file *file, struct address_space *mapping,
 	return error;
 }
 
+static bool filemap_range_uptodate(struct kiocb *iocb,
+		struct address_space *mapping, struct iov_iter *iter,
+		struct page *page)
+{
+	loff_t pos;
+	int count;
+
+	if (PageUptodate(page))
+		return true;
+	/* pipes can't handle partially uptodate pages */
+	if (iov_iter_is_pipe(iter))
+		return false;
+	if (!mapping->a_ops->is_partially_uptodate)
+		return false;
+	if (mapping->host->i_blkbits >= (PAGE_SHIFT + thp_order(page)))
+		return false;
+
+	pos = (loff_t) page->index << PAGE_SHIFT;
+	if (pos > iocb->ki_pos) {
+		count = iocb->ki_pos + iter->count - pos;
+		pos = 0;
+	} else {
+		count = iter->count;
+		pos = iocb->ki_pos & (thp_size(page) - 1);
+	}
+
+	return mapping->a_ops->is_partially_uptodate(page, pos, count);
+}
+
 static int filemap_update_page(struct kiocb *iocb,
 		struct address_space *mapping, struct iov_iter *iter,
 		struct page *page, loff_t pos, loff_t count, bool first)
 {
-	struct inode *inode = mapping->host;
 	int error = -EAGAIN;
 
 	if (!trylock_page(page)) {
@@ -2252,22 +2280,11 @@ static int filemap_update_page(struct kiocb *iocb,
 
 	if (!page->mapping)
 		goto truncated;
-	if (PageUptodate(page))
-		goto uptodate;
-	if (inode->i_blkbits == PAGE_SHIFT ||
-			!mapping->a_ops->is_partially_uptodate)
-		goto readpage;
-	/* pipes can't handle partially uptodate pages */
-	if (unlikely(iov_iter_is_pipe(iter)))
-		goto readpage;
-	if (!mapping->a_ops->is_partially_uptodate(page,
-				pos & (thp_size(page) - 1), count))
-		goto readpage;
-uptodate:
-	unlock_page(page);
-	return 0;
+	if (filemap_range_uptodate(iocb, mapping, iter, page)) {
+		unlock_page(page);
+		return 0;
+	}
 
-readpage:
 	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ)) {
 		unlock_page(page);
 		error = -EAGAIN;
-- 
2.28.0

