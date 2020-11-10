Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501DD2ACBF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 04:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731300AbgKJDhT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 22:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731366AbgKJDhP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 22:37:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5853C0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 19:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=QHs5v1YUXVPwXe5xLPhKJGU4nL7RPpQ66tQpFDSktyk=; b=ZhVL+Sf93+xtmAEFEcO++LSC/1
        RDMbcAJb01vlxAK5e5QhAcNa6/lY2++fXF0F6ErXPRs2N/uBi3IGh006Ix3Jyx7fndTTUuAQ8qLKN
        awFQR0b9UVuh4ICLrBmlh/CZQBXFAXhcNzAA0O1wzdnUu1MdTNq35zcaGu2Jooh9jVPmN+jVe0F9S
        SU36qaZe6q4loORH8mIueLOuCvY9nnDa1AT5x9huLU2QbyY5ydOQO2fwTUWdLbMyRpaCCFGCekJNV
        OIuHW8HSi40R/vu4dS7t7+OcnNfe2VyzoeRd5KUD2l43ua9k0CZZKCCW4Rm5QeZdmzx6DVItaNvcP
        Jb2aXd9w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcKT2-000662-Fi; Tue, 10 Nov 2020 03:37:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v3 11/18] mm/filemap: Convert filemap_update_page to return an errno
Date:   Tue, 10 Nov 2020 03:36:56 +0000
Message-Id: <20201110033703.23261-12-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201110033703.23261-1-willy@infradead.org>
References: <20201110033703.23261-1-willy@infradead.org>
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
---
 mm/filemap.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index ddc881c9d253..60ce7f15cc7e 100644
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
+			return error;
 	} else {
 		if (!trylock_page(page)) {
 			put_and_wait_on_page_locked(page, TASK_KILLABLE);
-			return NULL;
+			return AOP_TRUNCATED_PAGE;
 		}
 	}
 
@@ -2267,25 +2264,21 @@ static struct page *filemap_update_page(struct kiocb *iocb, struct file *filp,
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
@@ -2379,11 +2372,12 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
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
@@ -2391,6 +2385,8 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
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

