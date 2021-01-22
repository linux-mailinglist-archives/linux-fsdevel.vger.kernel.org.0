Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7DF300859
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 17:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbhAVQLy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 11:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729504AbhAVQLo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:11:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF610C06174A;
        Fri, 22 Jan 2021 08:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jfugzsM0alWjT34BzPisiavewfjggn230xNmr/mWe+s=; b=WUq91r2/3iaaw23zTGy4jLmeuu
        VS98pc5hFHoZ6VgsdGQo8IJ/ghUkzxAnnxQXKev3+G1vzMFqmIHggoyKjAIL3sMM4HF8/XEDWo3us
        B53ow4VEmTKPmCpA4T6SM3A0rMuIKkNRTiweLDFTfOX1LfzK07jdINkLn6GxSbCxOZBcP3/E4ryDu
        YfxSPytawQrw9A1Iv7wi1NzH+d1hqBo3rh2sCCLCVBcH8pL5cE2JMt/c9+bhdpDRHqH1UlN5rIoXl
        1OsKpwIfzJkAvC7tZzwiLSCvOaVDhpCkSLS2WvgfO3TlXtriTR/n+hB74rQyro5MIOvDzN+OdxcI5
        VOhxf0kA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2z03-000wTi-Pe; Fri, 22 Jan 2021 16:09:47 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 11/18] mm/filemap: Convert filemap_update_page to return an errno
Date:   Fri, 22 Jan 2021 16:01:33 +0000
Message-Id: <20210122160140.223228-12-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122160140.223228-1-willy@infradead.org>
References: <20210122160140.223228-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use AOP_TRUNCATED_PAGE to indicate that no error occurred, but the
page we looked up is no longer valid.  In this case, the reference
to the page will have been removed; if we hit any other error, the
caller will release the reference.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 3e0790626addf..469fc97659cb5 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2246,24 +2246,21 @@ static int filemap_read_page(struct file *file, struct address_space *mapping,
 	return error;
 }
 
-static struct page *filemap_update_page(struct kiocb *iocb, struct file *filp,
-		struct iov_iter *iter, struct page *page, loff_t pos,
-		loff_t count)
+static int filemap_update_page(struct kiocb *iocb,
+		struct address_space *mapping, struct iov_iter *iter,
+		struct page *page, loff_t pos, loff_t count)
 {
-	struct address_space *mapping = filp->f_mapping;
 	struct inode *inode = mapping->host;
 	int error;
 
 	if (iocb->ki_flags & IOCB_WAITQ) {
 		error = lock_page_async(page, iocb->ki_waitq);
-		if (error) {
-			put_page(page);
-			return ERR_PTR(error);
-		}
+		if (error)
+			return error;
 	} else {
 		if (!trylock_page(page)) {
 			put_and_wait_on_page_locked(page, TASK_KILLABLE);
-			return NULL;
+			return AOP_TRUNCATED_PAGE;
 		}
 	}
 
@@ -2282,25 +2279,21 @@ static struct page *filemap_update_page(struct kiocb *iocb, struct file *filp,
 		goto readpage;
 uptodate:
 	unlock_page(page);
-	return page;
+	return 0;
 
 readpage:
 	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ)) {
 		unlock_page(page);
-		put_page(page);
-		return ERR_PTR(-EAGAIN);
+		return -EAGAIN;
 	}
 	error = filemap_read_page(iocb->ki_filp, mapping, page);
-	if (!error)
-		return page;
-	put_page(page);
 	if (error == AOP_TRUNCATED_PAGE)
-		return NULL;
-	return ERR_PTR(error);
+		put_page(page);
+	return error;
 truncated:
 	unlock_page(page);
 	put_page(page);
-	return NULL;
+	return AOP_TRUNCATED_PAGE;
 }
 
 static int filemap_create_page(struct file *file,
@@ -2394,11 +2387,12 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 				goto err;
 			}
 
-			page = filemap_update_page(iocb, filp, iter, page,
+			err = filemap_update_page(iocb, mapping, iter, page,
 					pg_pos, pg_count);
-			if (IS_ERR_OR_NULL(page)) {
+			if (err) {
+				if (err < 0)
+					put_page(page);
 				pvec->nr--;
-				err = PTR_ERR_OR_ZERO(page);
 			}
 		}
 	}
@@ -2406,6 +2400,8 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 err:
 	if (likely(pvec->nr))
 		return 0;
+	if (err == AOP_TRUNCATED_PAGE)
+		goto find_page;
 	if (err)
 		return err;
 	/*
-- 
2.29.2

