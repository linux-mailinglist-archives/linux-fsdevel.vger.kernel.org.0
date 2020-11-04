Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1478C2A6F0C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 21:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732316AbgKDUmf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 15:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732142AbgKDUmd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 15:42:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386B3C040201
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2020 12:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=EzLyDg0XjuxcQhMXYgM8pHY3Yys4o9DoqSKTg0VJ+k4=; b=UgsEfTsqUzBi7FXX/y+OqivOBu
        XopUIp7L0yTQvF5sqU8LUUg+x6oxrfidiQPe7xk+KVUXWYiO0mw7tsxDieodZ360IJKCG3LIYPM6G
        YU7fKtmu085x4d8fCCw7WpLf+3zBPhhmofZJ2lu6rAk9+BDkr5OeT+Vr6CvNOXNa9mB7fHnZqvRaP
        CKhfzvMHzmD/Ob0Z+fUjnYTY6jUB1amkiBci91rwCjz6Zii4NQnxdMhUBQ0LV5ItpZTAfTso9oFJl
        wdF+kVH5UL4GPKc1BlC49HbK3eovy8MRLEEtFXV/GC5aT34CibiQuksie9gJI7dELYeOkKyPRxe3v
        lz5l8fqg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaPbt-0006EP-LX; Wed, 04 Nov 2020 20:42:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v2 14/18] mm/filemap: Split filemap_readahead out of filemap_get_pages
Date:   Wed,  4 Nov 2020 20:42:15 +0000
Message-Id: <20201104204219.23810-15-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201104204219.23810-1-willy@infradead.org>
References: <20201104204219.23810-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This simplifies the error handling.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 mm/filemap.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 281538a05dc1..7af0e656c5f6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2330,6 +2330,17 @@ static int filemap_create_page(struct file *file,
 	return error;
 }
 
+static int filemap_readahead(struct kiocb *iocb, struct file *file,
+		struct address_space *mapping, struct page *page,
+		pgoff_t last_index)
+{
+	if (iocb->ki_flags & IOCB_NOIO)
+		return -EAGAIN;
+	page_cache_async_readahead(mapping, &file->f_ra, file, page,
+			page->index, last_index - page->index);
+	return 0;
+}
+
 static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 		struct pagevec *pvec)
 {
@@ -2368,17 +2379,14 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 got_pages:
 	{
 		struct page *page = pvec->pages[pvec->nr - 1];
-		pgoff_t pg_index = page->index;
 
 		if (PageReadahead(page)) {
-			if (iocb->ki_flags & IOCB_NOIO) {
-				put_page(page);
+			err = filemap_readahead(iocb, filp, mapping, page,
+					last_index);
+			if (err) {
 				pvec->nr--;
-				err = -EAGAIN;
 				goto err;
 			}
-			page_cache_async_readahead(mapping, ra, filp, page,
-					pg_index, last_index - pg_index);
 		}
 
 		if (!PageUptodate(page)) {
-- 
2.28.0

