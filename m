Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409FE2A14C3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Oct 2020 10:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgJaJ0W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Oct 2020 05:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgJaJ0V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Oct 2020 05:26:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A594C0613D5
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2020 02:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=MWaMneU7BhzODsMhJkl5CJM+zMKEb8OgtLKiOZosoCk=; b=qE5NYOKMbe4XeE8BYN8fFNEy9q
        DViNDofJVNr1FC64B8Kea7D3I4Jd9NJjh4+0FlckN5mLaPnpU3S0gEGuYcYJd5qopVCnLHNy1/PCT
        o7KGBEOJ3wcURPs38tRliRa76rn8KRo6Pz5n2eOXpA/nz111btt8WiqFA+0LC1hvnYBWxNpp8hIwB
        cc790NyWsudCExvSHRC83ut/sX7RbKGLZzUJviU6ZhOSG7RQl4Ej4AmKby3XUn7Xt6cSc/vNzaFhq
        wu/gbeiGAsgpvmjoRehH03O1Dmu7yUm9v0kOtoiyB0LYVnkUXIQdXwZagffzPmCq82egBvBIpf/GN
        CTPWPNug==;
Received: from 089144193201.atnat0002.highway.a1.net ([89.144.193.201] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYn9O-00004x-Fg; Sat, 31 Oct 2020 09:26:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/13] mm: streamline the partially uptodate checks in filemap_make_page_uptodate
Date:   Sat, 31 Oct 2020 10:00:02 +0100
Message-Id: <20201031090004.452516-12-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031090004.452516-1-hch@lst.de>
References: <20201031090004.452516-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Unwind the goto mess a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 000f75cd359d1c..904b0a4fb9e008 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2218,7 +2218,6 @@ static int filemap_make_page_uptodate(struct kiocb *iocb, struct iov_iter *iter,
 	struct address_space *mapping = file->f_mapping;
 	loff_t last = iocb->ki_pos + iter->count;
 	pgoff_t last_index = (last + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	loff_t pos = max(iocb->ki_pos, (loff_t)pg_index << PAGE_SHIFT);
 	int error;
 
 	if (PageReadahead(page)) {
@@ -2251,32 +2250,22 @@ static int filemap_make_page_uptodate(struct kiocb *iocb, struct iov_iter *iter,
 	if (PageUptodate(page))
 		return 0;
 
-	if (mapping->host->i_blkbits == PAGE_SHIFT ||
-	    !mapping->a_ops->is_partially_uptodate)
-		goto page_not_up_to_date;
-	/* pipes can't handle partially uptodate pages */
-	if (unlikely(iov_iter_is_pipe(iter)))
-		goto page_not_up_to_date;
-	if (!trylock_page(page))
-		goto page_not_up_to_date;
-	/* Did it get truncated before we got the lock? */
-	if (!page->mapping)
-		goto page_not_up_to_date_locked;
-	if (!mapping->a_ops->is_partially_uptodate(page, pos & ~PAGE_MASK,
-			last - pos))
-		goto page_not_up_to_date_locked;
-
-unlock_page:
-	unlock_page(page);
-	return 0;
+	if (mapping->host->i_blkbits <= PAGE_SHIFT &&
+	    mapping->a_ops->is_partially_uptodate &&
+	    !iov_iter_is_pipe(iter) &&
+	    trylock_page(page)) {
+		loff_t pos = max(iocb->ki_pos, (loff_t)pg_index << PAGE_SHIFT);
 
-page_not_up_to_date:
-	/* Get exclusive access to the page ... */
-	error = lock_page_for_iocb(iocb, page);
-	if (unlikely(error))
-		return error;
+		if (page->mapping &&
+		    mapping->a_ops->is_partially_uptodate(page,
+				pos & ~PAGE_MASK, last - pos))
+			goto unlock_page;
+	} else {
+		error = lock_page_for_iocb(iocb, page);
+		if (unlikely(error))
+			return error;
+	}
 
-page_not_up_to_date_locked:
 	/* Did it get truncated before we got the lock? */
 	if (!page->mapping) {
 		unlock_page(page);
@@ -2287,6 +2276,9 @@ static int filemap_make_page_uptodate(struct kiocb *iocb, struct iov_iter *iter,
 	if (PageUptodate(page))
 		goto unlock_page;
 	return filemap_readpage(iocb, page);
+unlock_page:
+	unlock_page(page);
+	return 0;
 }
 
 static int filemap_new_page(struct kiocb *iocb, struct iov_iter *iter,
-- 
2.28.0

