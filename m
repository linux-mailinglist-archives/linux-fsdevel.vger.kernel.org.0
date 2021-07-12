Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609C03C42A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 06:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhGLELM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 00:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhGLELL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:11:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36022C0613DD;
        Sun, 11 Jul 2021 21:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=SPsFYGmtYSvUVDRhpRjc0EjIdtUkOTioVaGrJYo03FE=; b=hMvA+L5zfIZmcWk4Z9L65qRcxR
        3Fw7PQZsBmryfiMDdWzQ9SF5263RhGGxoHHVn5OJID56vEsl3y18/o9zxJtO+scJiRQMdDRNSOY8J
        p9BZgsWGnFd5gAr1TzBDHkuUPeDrCXU1vB2vI9YtFU/PIe12eItrJ8IIWl9KWyHmTc4TNvd1Ru/79
        Qhng1Tw38EpfPmo8mw4gaSUfKoeYZsvY0MYypT+BAy+p/c7xZTtkOJG3EUFtIDixMPuVAGDwbaCoq
        FqZNbszEu7nmtR9gwgRcTVHfgXaP+RkhXLrwICM8tDygcwi0OaUYyczFVdOyj0abdNBIHmVbI7JZJ
        D10p9T+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2nDv-00Gr5C-SY; Mon, 12 Jul 2021 04:07:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 115/137] mm/filemap: Convert filemap_range_uptodate to folios
Date:   Mon, 12 Jul 2021 04:06:39 +0100
Message-Id: <20210712030701.4000097-116-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
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
index 537d3026cefa..d0b9c99ccb3e 100644
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
+	if (folio_uptodate(folio))
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

