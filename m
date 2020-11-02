Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA572A3338
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 19:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgKBSnd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 13:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgKBSnd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:43:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3856C0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 10:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=n+REdW1xoOea4wiyJWdr2S+YGLxyipm2rcZL5gYfVC8=; b=M4UFc6+RWWZ4YxauVIwZf4ObKR
        enRZBjteDCpQ4K18wTrH8TqUhXHXIshDmOAhQQKHybNLpQ79LULFq8sK3uh1UqZvKVisJYO8r4B4r
        RtBh0KahVKVU9QHVx9ZljhoQVh+xvSmiJ9/Z6+zlY6yafvqIX0bkWCSxqjIEzseUvis/ZXzuWYsUb
        NcIIVnVENX+/XrN+rAKSghdqIqSb0Ey0s17L3I46HApZsv/eWGkd7CJnYByUfvjbuGNBSvd3xycbT
        gBPY5ua8luCMoHo5DCBrJMdmPHg34P1guWSctRyNaZTbQYxXpazwFtkff1QGNYKL7wjIgy0Bo7uHt
        NgZJHZZw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZeni-0006qS-Gy; Mon, 02 Nov 2020 18:43:30 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH 15/17] mm/filemap: Don't relock the page after calling readpage
Date:   Mon,  2 Nov 2020 18:43:10 +0000
Message-Id: <20201102184312.25926-16-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201102184312.25926-1-willy@infradead.org>
References: <20201102184312.25926-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We don't need to get the page lock again; we just need to wait for
the I/O to finish, so use wait_on_page_locked_killable() like the
other callers of ->readpage.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index f16b1eb03bca..f2de97d51441 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2209,23 +2209,16 @@ static int filemap_read_page(struct file *file, struct address_space *mapping,
 	error = mapping->a_ops->readpage(file, page);
 	if (error)
 		return error;
-	if (PageUptodate(page))
-		return 0;
 
-	error = lock_page_killable(page);
+	error = wait_on_page_locked_killable(page);
 	if (error)
 		return error;
-	if (!PageUptodate(page)) {
-		if (page->mapping == NULL) {
-			/* page truncated */
-			error = AOP_TRUNCATED_PAGE;
-		} else {
-			shrink_readahead_size_eio(&file->f_ra);
-			error = -EIO;
-		}
-	}
-	unlock_page(page);
-	return error;
+	if (PageUptodate(page))
+		return 0;
+	if (!page->mapping)	/* page truncated */
+		return AOP_TRUNCATED_PAGE;
+	shrink_readahead_size_eio(&file->f_ra);
+	return -EIO;
 }
 
 static bool filemap_range_uptodate(struct kiocb *iocb,
-- 
2.28.0

