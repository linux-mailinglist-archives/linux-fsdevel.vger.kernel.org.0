Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D472FE0AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 05:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732066AbhAUE2u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 23:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbhAUE2H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:28:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BCCC061757
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jan 2021 20:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=JFA/0PQnOiQvHSolbGA9rFsFxqdMHN7no15nOhIz7Hg=; b=BuKLB1Q6AnAHxfvAWT1imcs1en
        dbMyi7i2SP5wmLLUFOcinkQQhnpTV9aNOqxi83WI0wB4q+dIvkmk4JAtpC3Ht8ez+Cju+EH6mLdRM
        0uLf0EfuKLJm62Ypb6UnnnsPVmQRJTHyVYdWwk25yMT+wXkZfztWqFNagQaLMVBQ1D+ipnkx7axm0
        8rgELgELSPNX6Oq0OSoZebBq4kIo7r1adrzb9e6/l6WrIV6YQEksczvyOUtcx9e0DTHyKIuFNlxkX
        tcL0cZ1pBCRqsBmHIdPCZ284YIiGBf6XvQBGal/0KvTADDzSbeoFRYRziZyztie5K4R04DaHaymce
        A9XUeFVg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2RXA-00Gbbs-R8; Thu, 21 Jan 2021 04:25:37 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v4 12/18] mm/filemap: Move the iocb checks into filemap_update_page
Date:   Thu, 21 Jan 2021 04:16:10 +0000
Message-Id: <20210121041616.3955703-13-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121041616.3955703-1-willy@infradead.org>
References: <20210121041616.3955703-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We don't need to give up when a non-blocking request sees a !Uptodate page.
We may be able to satisfy the read from a partially-uptodate page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index adac12ed48415..141d5917770d6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2230,15 +2230,16 @@ static int filemap_update_page(struct kiocb *iocb,
 	struct inode *inode = mapping->host;
 	int error;
 
-	if (iocb->ki_flags & IOCB_WAITQ) {
-		error = lock_page_async(page, iocb->ki_waitq);
-		if (error)
-			return error;
-	} else {
-		if (!trylock_page(page)) {
+	if (!trylock_page(page)) {
+		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_NOIO))
+			return -EAGAIN;
+		if (!(iocb->ki_flags & IOCB_WAITQ)) {
 			put_and_wait_on_page_locked(page, TASK_KILLABLE);
 			return AOP_TRUNCATED_PAGE;
 		}
+		error = __lock_page_async(page, iocb->ki_waitq);
+		if (error)
+			return error;
 	}
 
 	if (!page->mapping)
@@ -2356,14 +2357,9 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 		}
 
 		if (!PageUptodate(page)) {
-			if ((iocb->ki_flags & IOCB_NOWAIT) ||
-			    ((iocb->ki_flags & IOCB_WAITQ) && pvec->nr > 1)) {
-				put_page(page);
-				pvec->nr--;
-				err = -EAGAIN;
-				goto err;
-			}
-
+			if ((iocb->ki_flags & IOCB_WAITQ) &&
+			    pagevec_count(pvec) > 1)
+				iocb->ki_flags |= IOCB_NOWAIT;
 			err = filemap_update_page(iocb, mapping, iter, page,
 					pg_pos, pg_count);
 			if (err) {
-- 
2.29.2

