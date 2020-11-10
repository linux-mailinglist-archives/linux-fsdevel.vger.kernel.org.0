Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BECE2ACBF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 04:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731484AbgKJDhZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 22:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731487AbgKJDhY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 22:37:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EB7C0613D3
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 19:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/H3/vcaymJlMFs25KAXkG6a5fN3Vb71fAtWaKtHODt4=; b=eRNvWryA9rpDxrN9nNLez0BqZL
        TLobkC+gMfJYPs6ChjJTUsl2onQ5xugxL6ArAMrSHZEDeHsuuNHFTlmm6Ji1RZl9rtUVhbXErhoIO
        Wz9TSXTkKUemVbk6XCV+bTYOisMuvmEWHtkRjNESw3wZbF53SoKylFe3sauPZ4O5mSjWK2UJogax9
        riZ5XXwVSGcMh8TJ77divALGRN0PEO884QuzwuZaAOOeH8M1LTlKCvBSsHn45wxwQvhgurmDvGPvk
        rye3oglpsWZ7iFbM9vkvMp+L5tYdK2nu+6930NJ2io3pJyd2nEYH4H+OU1IuEasOsscXV/6ESQOfu
        6O+KJ87A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcKT7-000679-29; Tue, 10 Nov 2020 03:37:17 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v3 14/18] mm/filemap: Split filemap_readahead out of filemap_get_pages
Date:   Tue, 10 Nov 2020 03:36:59 +0000
Message-Id: <20201110033703.23261-15-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201110033703.23261-1-willy@infradead.org>
References: <20201110033703.23261-1-willy@infradead.org>
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
index 1cacadef0ded..d9cabdff9245 100644
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
@@ -2367,17 +2378,15 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
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
2.28.0

