Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12FF2A3336
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 19:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgKBSnb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 13:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgKBSna (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:43:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F975C0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 10:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TAKe5ShkzeUGiDLF7zD5jcjV0+ZkrFCKna03nopA5xQ=; b=D+L+8if9YPagHFPeQxIHYE/NWT
        zhtdCfDJJ9uLTM3OqOOla4ifoGgx/xBbtf9DvT9Gb+POXHrqv7PNIrfeN3pEO8AGVe+VWLwbXCBIK
        Hi90/+evC8MbwyrriKtp3VX/EBvB9NU8ke2aUlx3u8cAO9NX+8ZjmsNs9jhaATDcfrjHwKW2B5oSm
        m2wWqoyX0dWSPfgnK8+tRtAjvXB5AMYiZYMjPdI5llUohxz9M29f2TZ9aH27GM469q2jjWTR2ys5j
        Kxf4KJotfSfWOIYynYbQbLd/w9BZdjjIqOssHpb9oKEad6MkB680Sqv8YlV2ZMs5+EvTdNj28QMZu
        yaOJxSuw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZenf-0006oz-Ml; Mon, 02 Nov 2020 18:43:27 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH 12/17] mm/filemap: Split filemap_readahead out of filemap_get_pages
Date:   Mon,  2 Nov 2020 18:43:07 +0000
Message-Id: <20201102184312.25926-13-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201102184312.25926-1-willy@infradead.org>
References: <20201102184312.25926-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This simplifies the error handling.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 81b569d818a3..7c6380a3a871 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2324,6 +2324,17 @@ static struct page *filemap_create_page(struct file *file,
 	return ERR_PTR(error);
 }
 
+static int filemap_readahead(struct kiocb *iocb, struct file *file,
+		struct address_space *mapping, struct page *page,
+		pgoff_t last_index)
+{
+	if (iocb->ki_flags & IOCB_NOIO)
+		return -EAGAIN;
+	page_cache_async_readahead(mapping, ra, filp, page,
+			pg_index, last_index - pg_index);
+	return 0;
+}
+
 static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 		struct page **pages, unsigned int nr)
 {
@@ -2368,23 +2379,14 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 				    (loff_t) pg_index << PAGE_SHIFT);
 		loff_t pg_count = iocb->ki_pos + iter->count - pg_pos;
 
-		if (PageReadahead(page)) {
-			if (iocb->ki_flags & IOCB_NOIO) {
-				put_page(page);
-				nr_got--;
-				err = -EAGAIN;
-				goto err;
-			}
-			page_cache_async_readahead(mapping, ra, filp, page,
-					pg_index, last_index - pg_index);
-		}
-
-		if (!PageUptodate(page)) {
+		if (PageReadahead(page))
+			err = filemap_readahead(iocb, filp, mapping, page,
+					last_index);
+		if (!err && !PageUptodate(page))
 			err = filemap_update_page(iocb, mapping, iter, page,
 					pg_pos, pg_count, nr_got == 1);
-			if (err)
-				nr_got--;
-		}
+		if (err)
+			nr_got--;
 	}
 
 err:
-- 
2.28.0

