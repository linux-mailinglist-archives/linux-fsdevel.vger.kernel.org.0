Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A632FE0A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 05:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbhAUE1j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 23:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbhAUE1H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:27:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC19C0613C1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jan 2021 20:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=cCpO00SFBp0/M+OPnIkbSN6EvBTGTW5uWRa8yrKkcTs=; b=iUPbv9td/FCePLLiZuPCft2DGq
        60UVsB0tdgI9dSxev627/lsFBgTe2Dp5Z5ONKxZ7Is4Oih0jOm3IaI7Ea31Xx9NUphIebSe62uN4p
        TZiz1jdIIKfZ/+Nx4cVEGBK6YiGF06KXrDnzugyh6hD2Dk8CAGGKIXfCWZmu0kMUXRzLwx+jzSMEv
        1BaQW03ZY+O9toiLnPgxbsWJxkYlsAitc0lLj9ikjfLKLaIiCip9P9smwGC0XbGw+yJrhtZwX+n9D
        ggO4A+En/5JVQwBS0Cbp2pJzrDw2IN9RRHrkc2x1e7zMM6p1/hy0a2G2KQWWCHs4vq+yEuOMWadPT
        99tVU2Kw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2RWF-00GbW0-5D; Thu, 21 Jan 2021 04:25:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v4 11/18] mm/filemap: Convert filemap_update_page to return an errno
Date:   Thu, 21 Jan 2021 04:16:09 +0000
Message-Id: <20210121041616.3955703-12-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121041616.3955703-1-willy@infradead.org>
References: <20210121041616.3955703-1-willy@infradead.org>
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
index 602191fe6c53f..adac12ed48415 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2223,24 +2223,21 @@ static int filemap_read_page(struct file *file, struct address_space *mapping,
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
 
@@ -2259,25 +2256,21 @@ static struct page *filemap_update_page(struct kiocb *iocb, struct file *filp,
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
@@ -2371,11 +2364,12 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
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
@@ -2383,6 +2377,8 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
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

