Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7CF2A6F13
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 21:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732323AbgKDUml (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 15:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732073AbgKDUm0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 15:42:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EABFC061A4A
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2020 12:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IO+k8uenUtokvjHXHB5nYnweRPf35rV98FYUgve2yF8=; b=vyKezbBR3DfMqOj6dGV6N3I8L5
        SfF90eLmdvYDOKniftPV/yi9JOGBHxrKccqoebzlwaByDv4Lh7cDxkM9UXhgjifoKh9uHQjkJn5tZ
        g58d8qNCbnINd554bIfgqi9C45hC4Snjj3JyjEznukna/RhXrgSzXggB+A4gY1pgv4lvRnWJ15+I3
        i4pYdTg+J8tOlYuPMsaMyXKFGWi3jCvgBW37pqHNImSx57RqkEW7GMPhOcZgCk0vb2SANn5t7e/dv
        JIfyCz5gjlJ8BAWYXcyBdHIkIYW+udIHTfKM3cXfWl3nM9qBNTWwZclPOd9rkUYDZwGhQhHqtwRNJ
        lkG/zx4g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaPbs-0006Dz-Ms; Wed, 04 Nov 2020 20:42:24 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v2 11/18] mm/filemap: Convert filemap_update_page to return an errno
Date:   Wed,  4 Nov 2020 20:42:12 +0000
Message-Id: <20201104204219.23810-12-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201104204219.23810-1-willy@infradead.org>
References: <20201104204219.23810-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use AOP_TRUNCATED_PAGE to indicate that no error occurred, but the
page we looked up is no longer valid.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 mm/filemap.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 25945fefdd39..93c054f51677 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2231,24 +2231,21 @@ static int filemap_read_page(struct file *file, struct address_space *mapping,
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
+			goto error;
 	} else {
 		if (!trylock_page(page)) {
 			put_and_wait_on_page_locked(page, TASK_KILLABLE);
-			return NULL;
+			return AOP_TRUNCATED_PAGE;
 		}
 	}
 
@@ -2267,25 +2264,24 @@ static struct page *filemap_update_page(struct kiocb *iocb, struct file *filp,
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
+		error = -EAGAIN;
+	} else {
+		error = filemap_read_page(iocb->ki_filp, mapping, page);
+		if (!error)
+			return 0;
 	}
-	error = filemap_read_page(iocb->ki_filp, mapping, page);
-	if (!error)
-		return page;
+error:
 	put_page(page);
-	if (error == AOP_TRUNCATED_PAGE)
-		return NULL;
-	return ERR_PTR(error);
+	return error;
 truncated:
 	unlock_page(page);
 	put_page(page);
-	return NULL;
+	return AOP_TRUNCATED_PAGE;
 }
 
 static int filemap_create_page(struct file *file,
@@ -2380,18 +2376,18 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 				goto err;
 			}
 
-			page = filemap_update_page(iocb, filp, iter, page,
+			err = filemap_update_page(iocb, mapping, iter, page,
 					pg_pos, pg_count);
-			if (IS_ERR_OR_NULL(page)) {
+			if (err)
 				pvec->nr--;
-				err = PTR_ERR_OR_ZERO(page);
-			}
 		}
 	}
 
 err:
 	if (likely(pvec->nr))
 		return 0;
+	if (err == AOP_TRUNCATED_PAGE)
+		goto find_page;
 	if (err)
 		return err;
 	/*
-- 
2.28.0

