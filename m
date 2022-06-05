Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983AA53DE0C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jun 2022 21:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351564AbiFETjP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jun 2022 15:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245092AbiFETjM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jun 2022 15:39:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB7339694;
        Sun,  5 Jun 2022 12:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=W0H1cUQxatSgPZ6f11mLW4N05/pdthUaWOiji2r395Q=; b=vuZO7CSb7H6HQ4un97k5YqfJpv
        WRg4mesPevoGA4XIOIVE2ut/fbhfu85CTaveBcVULnFub7Mfq5oIGpDukf0GFFOtdms/yjo0srNbQ
        qAmlTagDosQ/iwYURVheI7Qn+0e+JiM35saYHuorbgNvOmwFZTGBSMX9gPqyPwtmqTCUpQrgxt08L
        zl+fZroMOE3CbrwEnxjVw9xWa9I9OBtn3/LlANUrlXOhUPAwmGVpiC8vKuDk0hB0q5d8Esreir30M
        qp+56a/8G270ZD18zh3VnRwQbfUZOj9Qy+FiUOVDgrzK9OgPFG3nJ+7PP+FJ4hse3IB4PQ0w6ecGA
        OfEX515Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nxw5Q-009wsV-Qh; Sun, 05 Jun 2022 19:38:56 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-nilfs@vger.kernel.org
Subject: [PATCH 04/10] ext4: Convert mpage_map_and_submit_buffers() to use filemap_get_folios()
Date:   Sun,  5 Jun 2022 20:38:48 +0100
Message-Id: <20220605193854.2371230-5-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220605193854.2371230-1-willy@infradead.org>
References: <20220605193854.2371230-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The called functions all use pages, so just convert back to a page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inode.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 32a7f5e024d6..1aaea53e67b5 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2314,8 +2314,8 @@ static int mpage_process_page(struct mpage_da_data *mpd, struct page *page,
  */
 static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
 {
-	struct pagevec pvec;
-	int nr_pages, i;
+	struct folio_batch fbatch;
+	unsigned nr, i;
 	struct inode *inode = mpd->inode;
 	int bpp_bits = PAGE_SHIFT - inode->i_blkbits;
 	pgoff_t start, end;
@@ -2329,14 +2329,13 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
 	lblk = start << bpp_bits;
 	pblock = mpd->map.m_pblk;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 	while (start <= end) {
-		nr_pages = pagevec_lookup_range(&pvec, inode->i_mapping,
-						&start, end);
-		if (nr_pages == 0)
+		nr = filemap_get_folios(inode->i_mapping, &start, end, &fbatch);
+		if (nr == 0)
 			break;
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr; i++) {
+			struct page *page = &fbatch.folios[i]->page;
 
 			err = mpage_process_page(mpd, page, &lblk, &pblock,
 						 &map_bh);
@@ -2352,14 +2351,14 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
 			if (err < 0)
 				goto out;
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 	}
 	/* Extent fully mapped and matches with page boundary. We are done. */
 	mpd->map.m_len = 0;
 	mpd->map.m_flags = 0;
 	return 0;
 out:
-	pagevec_release(&pvec);
+	folio_batch_release(&fbatch);
 	return err;
 }
 
-- 
2.35.1

