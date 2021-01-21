Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15892FE0B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 05:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbhAUEad (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 23:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729761AbhAUE3l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:29:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56951C0613D3
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jan 2021 20:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9p4GrZrrvz+8hR3so0b8tfHJcuAhbnc2XtMcd7mJomY=; b=FibBvRmX7qFpg6URPQ9Tf7E6GP
        SxkVuV6RSr7vFwO8WCpmPqSgb09nRdz6xDcvSq/EnPtmYo/RyGDIi2jttWx7RUJ9gPtpxyK3Y/IQZ
        9hMOlup4uN1B069NrGpxgkpymxPUk5J7hMqlnQaNLM7PDrT9zHNQzUpCHXDZ76SQh8K3VGIat1qog
        MUwx1eiAVIz06ZZVXKjhNjLMKIImUycAaISir+nIydei8SZv/j6altxH+34mJVF+V/dQdDUPSuRbv
        bEPrAScyAsu8X4AFDJlzqDPyNC11o1zsBJORqHPfWzdXIQ0qGIGa7vskoVUczqPYg7pq0Zc+UMMCY
        v4Ih4UgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2RYs-00Gbfo-19; Thu, 21 Jan 2021 04:27:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v4 14/18] mm/filemap: Split filemap_readahead out of filemap_get_pages
Date:   Thu, 21 Jan 2021 04:16:12 +0000
Message-Id: <20210121041616.3955703-15-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121041616.3955703-1-willy@infradead.org>
References: <20210121041616.3955703-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This simplifies the error handling.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 mm/filemap.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index df755b86a0a7b..f1c5c7d7aae8e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2319,6 +2319,17 @@ static int filemap_create_page(struct file *file,
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
@@ -2356,17 +2367,15 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 got_pages:
 	{
 		struct page *page = pvec->pages[pvec->nr - 1];
-		pgoff_t pg_index = page->index;
 
 		if (PageReadahead(page)) {
-			if (iocb->ki_flags & IOCB_NOIO) {
+			err = filemap_readahead(iocb, filp, mapping, page,
+					last_index);
+			if (err) {
 				put_page(page);
 				pvec->nr--;
-				err = -EAGAIN;
 				goto err;
 			}
-			page_cache_async_readahead(mapping, ra, filp, page,
-					pg_index, last_index - pg_index);
 		}
 
 		if (!PageUptodate(page)) {
-- 
2.29.2

