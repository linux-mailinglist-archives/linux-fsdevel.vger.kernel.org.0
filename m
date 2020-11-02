Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A2A2A3337
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 19:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgKBSnc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 13:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgKBSnb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:43:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E27C0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 10:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=MhaGM2ZGeDwxTv2rpzeXcoU4mMvsEnyn3vSYd9SK9Ns=; b=lKrZrlFOyo5i2BYg2CkDhPoyeo
        oVOeraG38fSUovw9klaZ8NccZMgZobBZMIzUdOSTnVK14ujz5UB/ZjFD+SBVz/G8DAx0h08TWEORI
        reHs/gyimctMbFymljtC0GX6MwlkC86AqENyTJADE4WDl3IAGLyBjwp+vfwDZRaKKnEsDGkOZtFB3
        A3tJrlOctRFfoc+y4cBWMkvFi5pkL9iM896cTUNzy3gXIr56V04JFJ9YzhC+pOvVxiHGE3rCwZNOC
        lT2M3WyVJrkaoLa1lU9EEeLFfWWpF9Xf/M4C2HgTnIGqqrSRdMrb86M8zmdz9MzaDtc+bmFyeAwA9
        9eaJaLSw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZeng-0006pb-Ji; Mon, 02 Nov 2020 18:43:28 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH 13/17] mm/filemap: Remove parameters from filemap_update_page()
Date:   Mon,  2 Nov 2020 18:43:08 +0000
Message-Id: <20201102184312.25926-14-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201102184312.25926-1-willy@infradead.org>
References: <20201102184312.25926-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The 'pos' and 'count' params are no longer used in filemap_update_page()

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 7c6380a3a871..0ae8305ccb97 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2259,7 +2259,7 @@ static bool filemap_range_uptodate(struct kiocb *iocb,
 
 static int filemap_update_page(struct kiocb *iocb,
 		struct address_space *mapping, struct iov_iter *iter,
-		struct page *page, loff_t pos, loff_t count, bool first)
+		struct page *page, bool first)
 {
 	int error = -EAGAIN;
 
@@ -2330,8 +2330,8 @@ static int filemap_readahead(struct kiocb *iocb, struct file *file,
 {
 	if (iocb->ki_flags & IOCB_NOIO)
 		return -EAGAIN;
-	page_cache_async_readahead(mapping, ra, filp, page,
-			pg_index, last_index - pg_index);
+	page_cache_async_readahead(mapping, &file->f_ra, file, page,
+			page->index, last_index - page->index);
 	return 0;
 }
 
@@ -2374,22 +2374,17 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 got_pages:
 	if (nr_got > 0) {
 		struct page *page = pages[nr_got - 1];
-		pgoff_t pg_index = page->index;
-		loff_t pg_pos = max(iocb->ki_pos,
-				    (loff_t) pg_index << PAGE_SHIFT);
-		loff_t pg_count = iocb->ki_pos + iter->count - pg_pos;
 
 		if (PageReadahead(page))
 			err = filemap_readahead(iocb, filp, mapping, page,
 					last_index);
 		if (!err && !PageUptodate(page))
 			err = filemap_update_page(iocb, mapping, iter, page,
-					pg_pos, pg_count, nr_got == 1);
+					nr_got == 1);
 		if (err)
 			nr_got--;
 	}
 
-err:
 	if (likely(nr_got))
 		return nr_got;
 	if (err < 0)
-- 
2.28.0

