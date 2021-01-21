Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29522FE0B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 05:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbhAUEax (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 23:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbhAUE23 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:28:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF493C0613C1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jan 2021 20:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PfsugLMlMKM6Eja7Rl0rIsDhrIsWo7j34Z7nIC0Z8zU=; b=RS+/nXccKBqmC2cEMYpopG5tlO
        4cOtABty6oC1c1KRHikB1WMmGBOIRELXQwKy03LpDNKf/IoyXc7EK3cKhL6GheaOpluRAQhhYMYCg
        9mLlriuaIDL0JJOza7TAFAPKm07G0OvS8r7vCvw1mMOwDDr3s1Zon5VFIfIbaT+FXGwpjcHaR7jnD
        ozDPX+XH3BfkREIZ/EaueaQj0omWifxz/fOxds1ZyQOZwIyq5UwgD8Fvo85RQ3vyC/H3bTQ3Ek1e8
        06phhurooYx46Ne8dnzB+8+v823t2nLs8QQPA5JOAghE4wLUNrZ8HTFSsK79JIAqoBWX9sp16kfyB
        6DuiC7JA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2RYS-00GbeX-Pw; Thu, 21 Jan 2021 04:26:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v4 13/18] mm/filemap: Add filemap_range_uptodate
Date:   Thu, 21 Jan 2021 04:16:11 +0000
Message-Id: <20210121041616.3955703-14-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121041616.3955703-1-willy@infradead.org>
References: <20210121041616.3955703-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the complicated condition and the calculations out of
filemap_update_page() into its own function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 mm/filemap.c | 68 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 28 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 141d5917770d6..df755b86a0a7b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2223,11 +2223,36 @@ static int filemap_read_page(struct file *file, struct address_space *mapping,
 	return error;
 }
 
+static bool filemap_range_uptodate(struct address_space *mapping,
+		loff_t pos, struct iov_iter *iter, struct page *page)
+{
+	int count;
+
+	if (PageUptodate(page))
+		return true;
+	/* pipes can't handle partially uptodate pages */
+	if (iov_iter_is_pipe(iter))
+		return false;
+	if (!mapping->a_ops->is_partially_uptodate)
+		return false;
+	if (mapping->host->i_blkbits >= (PAGE_SHIFT + thp_order(page)))
+		return false;
+
+	count = iter->count;
+	if (page_offset(page) > pos) {
+		count -= page_offset(page) - pos;
+		pos = 0;
+	} else {
+		pos -= page_offset(page);
+	}
+
+	return mapping->a_ops->is_partially_uptodate(page, pos, count);
+}
+
 static int filemap_update_page(struct kiocb *iocb,
 		struct address_space *mapping, struct iov_iter *iter,
-		struct page *page, loff_t pos, loff_t count)
+		struct page *page)
 {
-	struct inode *inode = mapping->host;
 	int error;
 
 	if (!trylock_page(page)) {
@@ -2244,34 +2269,25 @@ static int filemap_update_page(struct kiocb *iocb,
 
 	if (!page->mapping)
 		goto truncated;
-	if (PageUptodate(page))
-		goto uptodate;
-	if (inode->i_blkbits == PAGE_SHIFT ||
-			!mapping->a_ops->is_partially_uptodate)
-		goto readpage;
-	/* pipes can't handle partially uptodate pages */
-	if (unlikely(iov_iter_is_pipe(iter)))
-		goto readpage;
-	if (!mapping->a_ops->is_partially_uptodate(page,
-				pos & (thp_size(page) - 1), count))
-		goto readpage;
-uptodate:
-	unlock_page(page);
-	return 0;
 
-readpage:
-	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ)) {
-		unlock_page(page);
-		return -EAGAIN;
-	}
+	error = 0;
+	if (filemap_range_uptodate(mapping, iocb->ki_pos, iter, page))
+		goto unlock;
+
+	error = -EAGAIN;
+	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ))
+		goto unlock;
+
 	error = filemap_read_page(iocb->ki_filp, mapping, page);
 	if (error == AOP_TRUNCATED_PAGE)
 		put_page(page);
 	return error;
 truncated:
-	unlock_page(page);
+	error = AOP_TRUNCATED_PAGE;
 	put_page(page);
-	return AOP_TRUNCATED_PAGE;
+unlock:
+	unlock_page(page);
+	return error;
 }
 
 static int filemap_create_page(struct file *file,
@@ -2341,9 +2357,6 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 	{
 		struct page *page = pvec->pages[pvec->nr - 1];
 		pgoff_t pg_index = page->index;
-		loff_t pg_pos = max(iocb->ki_pos,
-				    (loff_t) pg_index << PAGE_SHIFT);
-		loff_t pg_count = iocb->ki_pos + iter->count - pg_pos;
 
 		if (PageReadahead(page)) {
 			if (iocb->ki_flags & IOCB_NOIO) {
@@ -2360,8 +2373,7 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 			if ((iocb->ki_flags & IOCB_WAITQ) &&
 			    pagevec_count(pvec) > 1)
 				iocb->ki_flags |= IOCB_NOWAIT;
-			err = filemap_update_page(iocb, mapping, iter, page,
-					pg_pos, pg_count);
+			err = filemap_update_page(iocb, mapping, iter, page);
 			if (err) {
 				if (err < 0)
 					put_page(page);
-- 
2.29.2

