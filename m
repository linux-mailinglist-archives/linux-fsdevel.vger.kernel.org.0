Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1022A14A7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Oct 2020 10:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgJaJTs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Oct 2020 05:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgJaJTs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Oct 2020 05:19:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271C5C0613D5
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2020 02:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rACcJrs34gaXXkKYt1uTpo4yAED7NWPkcMr50Jhtq5o=; b=qcZqxVQCmDjR2LuBgBCPF3Axfb
        5tHG4/g/tJd5jsQSUq6+Wx5UVge9UzCuC5bExxEsu7CDV4ylV+s9GBDOSrdKakIyr9hZIXWoJdSFd
        ZYEtDhWtapmWbt8/etCpmxDjStlJJnFMg4wyKk6g3KBQCMU7NxyQIjxfCbbjSrmUFyR6yVQlpUDmu
        rbxwJhGUO8wLvBo3ql/9evqeqwOS8VKkiymWEMXW32dZW4HIjENi9uhdfrKPzQCqs22HUQfyWHDXg
        RBow75EKZhCvw7lv+1vl8a1kpI4fLD8/9HkgADy1S878n/SjhR3YtY8XuWvBCSXuiDKjElvFIp74R
        j1eLwlpQ==;
Received: from 089144193201.atnat0002.highway.a1.net ([89.144.193.201] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYn33-00086W-6x; Sat, 31 Oct 2020 09:19:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/13] mm: move putting the page on error out of filemap_readpage
Date:   Sat, 31 Oct 2020 09:59:59 +0100
Message-Id: <20201031090004.452516-9-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031090004.452516-1-hch@lst.de>
References: <20201031090004.452516-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the put_page on error from filemap_readpage into the callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 96855299247c56..6089f1d9dd429f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2171,11 +2171,11 @@ static int lock_page_for_iocb(struct kiocb *iocb, struct page *page)
 static int filemap_readpage(struct kiocb *iocb, struct page *page)
 {
 	struct file *file = iocb->ki_filp;
-	int error = -EAGAIN;
+	int error;
 
 	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT)) {
 		unlock_page(page);
-		goto out_put_page;
+		return -EAGAIN;
 	}
 
 	/*
@@ -2186,12 +2186,12 @@ static int filemap_readpage(struct kiocb *iocb, struct page *page)
 	/* Start the actual read. The read will unlock the page. */
 	error = file->f_mapping->a_ops->readpage(file, page);
 	if (unlikely(error))
-		goto out_put_page;
+		return error;
 
 	if (!PageUptodate(page)) {
 		error = lock_page_for_iocb(iocb, page);
 		if (unlikely(error))
-			goto out_put_page;
+			return error;
 
 		if (!PageUptodate(page)) {
 			if (page->mapping == NULL) {
@@ -2199,22 +2199,16 @@ static int filemap_readpage(struct kiocb *iocb, struct page *page)
 				 * invalidate_mapping_pages got it
 				 */
 				unlock_page(page);
-				error = AOP_TRUNCATED_PAGE;
-				goto out_put_page;
+				return AOP_TRUNCATED_PAGE;
 			}
 			unlock_page(page);
 			shrink_readahead_size_eio(&file->f_ra);
-			error = -EIO;
-			goto out_put_page;
+			return -EIO;
 		}
 
 		unlock_page(page);
 	}
 	return 0;
-
-out_put_page:
-	put_page(page);
-	return error;
 }
 
 static int filemap_make_page_uptodate(struct kiocb *iocb, struct iov_iter *iter,
@@ -2293,7 +2287,10 @@ static int filemap_make_page_uptodate(struct kiocb *iocb, struct iov_iter *iter,
 	/* Did somebody else fill it already? */
 	if (PageUptodate(page))
 		goto unlock_page;
-	return filemap_readpage(iocb, page);
+	error = filemap_readpage(iocb, page);
+	if (error)
+		goto put_page;
+	return 0;
 
 put_page:
 	put_page(page);
@@ -2315,15 +2312,15 @@ static int filemap_new_page(struct kiocb *iocb, struct iov_iter *iter,
 	if (!page)
 		return -ENOMEM;
 	error = add_to_page_cache_lru(*page, mapping, index, gfp);
-	if (error) {
-		put_page(*page);
-		return error;
-	}
-
+	if (error)
+		goto put_page;
 	error = filemap_readpage(iocb, *page);
 	if (error)
-		return error;
+		goto put_page;
 	return filemap_make_page_uptodate(iocb, iter, *page, index, true);
+put_page:
+	put_page(*page);
+	return error;
 }
 
 static int filemap_find_get_pages(struct kiocb *iocb, struct iov_iter *iter,
-- 
2.28.0

