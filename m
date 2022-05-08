Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1EA51F169
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiEHUgS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiEHUfg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:35:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242D95F97
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=aH16BpIhqvfVPG+WJB3hRIv4pV6OIvK+9fdHP6ll06M=; b=wImppcnmJv+BrmSEn3qHUVSLjH
        qWRByH5S3ZWCCcbziuSUWJgfjL1B9bS5a7ccIxaOHiGfUKS2wD+wocCp0F4Ib8rvZk9r3PCVInptd
        YPMPPlp3fit8TFnYfEVl5Va1q+LVWmefciiuQzK/oFG5EWKiyAOuS2SwZuKwW4fzoSPn6dBy+fgNm
        h1leMNpdw5Gb4NXfjtckGn2W5VqA+mcTXV3CvTa2euAkAKRZNcmwGScI5QaJq81PwlQ03j0VXpgxu
        iC0chTCK9ntug/00wC/Q239zfQP7YKXvcttPEvl0F4zWZjiFMB1Y9mB3PkXmQGTp6BXyg/OiM4O3N
        bm5grjfg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnZ6-002npa-Nt; Sun, 08 May 2022 20:31:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 30/37] orangefs: Convert orangefs to read_folio
Date:   Sun,  8 May 2022 21:31:24 +0100
Message-Id: <20220508203131.667959-31-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203131.667959-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203131.667959-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a full conversion which should be large folio ready, although
I have not tested it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/orangefs/inode.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index bc7ccd15d7a3..241ac21f527b 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -288,40 +288,39 @@ static void orangefs_readahead(struct readahead_control *rac)
 	}
 }
 
-static int orangefs_readpage(struct file *file, struct page *page)
+static int orangefs_read_folio(struct file *file, struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct iov_iter iter;
 	struct bio_vec bv;
 	ssize_t ret;
-	loff_t off; /* offset into this page */
+	loff_t off; /* offset of this folio in the file */
 
 	if (folio_test_dirty(folio))
 		orangefs_launder_folio(folio);
 
-	off = page_offset(page);
-	bv.bv_page = page;
-	bv.bv_len = PAGE_SIZE;
+	off = folio_pos(folio);
+	bv.bv_page = &folio->page;
+	bv.bv_len = folio_size(folio);
 	bv.bv_offset = 0;
-	iov_iter_bvec(&iter, READ, &bv, 1, PAGE_SIZE);
+	iov_iter_bvec(&iter, READ, &bv, 1, folio_size(folio));
 
 	ret = wait_for_direct_io(ORANGEFS_IO_READ, inode, &off, &iter,
-	    PAGE_SIZE, inode->i_size, NULL, NULL, file);
+			folio_size(folio), inode->i_size, NULL, NULL, file);
 	/* this will only zero remaining unread portions of the page data */
 	iov_iter_zero(~0U, &iter);
 	/* takes care of potential aliasing */
-	flush_dcache_page(page);
+	flush_dcache_folio(folio);
 	if (ret < 0) {
-		SetPageError(page);
+		folio_set_error(folio);
 	} else {
-		SetPageUptodate(page);
-		if (PageError(page))
-			ClearPageError(page);
+		folio_mark_uptodate(folio);
+		if (folio_test_error(folio))
+			folio_clear_error(folio);
 		ret = 0;
 	}
-	/* unlock the page after the ->readpage() routine completes */
-	unlock_page(page);
+	/* unlock the folio after the ->read_folio() routine completes */
+	folio_unlock(folio);
         return ret;
 }
 
@@ -631,7 +630,7 @@ static ssize_t orangefs_direct_IO(struct kiocb *iocb,
 static const struct address_space_operations orangefs_address_operations = {
 	.writepage = orangefs_writepage,
 	.readahead = orangefs_readahead,
-	.readpage = orangefs_readpage,
+	.read_folio = orangefs_read_folio,
 	.writepages = orangefs_writepages,
 	.dirty_folio = filemap_dirty_folio,
 	.write_begin = orangefs_write_begin,
-- 
2.34.1

