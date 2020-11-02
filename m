Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8992A3332
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 19:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgKBSn1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 13:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgKBSnZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:43:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65FCC061A04
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 10:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=u754MWx1ZhWf2ZlBtQmrFs0jUJq0Q4zppwEcbORl0e8=; b=fYPMVz4bLScctBBqKzp5R+MwN6
        LIwEN1f9+csABwucbT8VvHLzLEUgLUzcXgUc4Nb99cqhW0F6Dc9vSwIPm3cBYC5f2df0nfUzMYl1+
        ld4y2ZaHpI5akIVAV3bLZPinXg06isSM65tCNndjynPwdy/lUOh/M4pN4xxa4bJeh0RPzsw2z4Hek
        TKB9FjCq/eA3Pnor+q1Jk9tsqAODWJZUbFtC1hc5RLMBpr4z37/CECDl9OszRPVwG03EGy+I+asHv
        pwTQ3X+rsBySeH9/TB+PhKtQ7JYiaqwweqJx8Ddzw0I2agT1Sn9WV15aSTC3qakjYfxt7i83TTriL
        bxbx6ofg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZena-0006nI-Az; Mon, 02 Nov 2020 18:43:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH 09/17] mm/filemap: Convert filemap_update_page to return an errno
Date:   Mon,  2 Nov 2020 18:43:04 +0000
Message-Id: <20201102184312.25926-10-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201102184312.25926-1-willy@infradead.org>
References: <20201102184312.25926-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use AOP_TRUNCATED_PAGE to indicate that no error occurred, but the
page we looked up is no longer valid.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 43 +++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 5527b239771c..ebb14fdec0cc 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2228,24 +2228,21 @@ static int filemap_read_page(struct file *file, struct address_space *mapping,
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
 
@@ -2264,25 +2261,24 @@ static struct page *filemap_update_page(struct kiocb *iocb, struct file *filp,
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
 
 static struct page *filemap_create_page(struct file *file,
@@ -2371,20 +2367,19 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 				goto err;
 			}
 
-			page = filemap_update_page(iocb, filp, iter, page,
+			err = filemap_update_page(iocb, mapping, iter, page,
 					pg_pos, pg_count);
-			if (IS_ERR_OR_NULL(page)) {
+			if (err)
 				nr_got--;
-				err = PTR_ERR_OR_ZERO(page);
-			}
 		}
 	}
 
 err:
 	if (likely(nr_got))
 		return nr_got;
-	if (err)
+	if (err < 0)
 		return err;
+	err = 0;
 	/*
 	 * No pages and no error means we raced and should retry:
 	 */
-- 
2.28.0

