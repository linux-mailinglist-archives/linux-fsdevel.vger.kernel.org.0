Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570C151F190
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbiEHUht (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbiEHUhE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:37:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240EC11C39
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VQ6jqtngGXvzx1zwMFkonroHqNpenCazJO7v657zZ4M=; b=O3wAC0Kz8KdsVX57nRGCd4EwVN
        sfA6IIAETtIF6zPGOogtWztXCKfrrddh/lZODbs2v1SQkA8b5F74sDPBTBlXXSSx1wfkJgJirCznS
        qdOR/mxX0daAb7aNhSY4j05aIbBGhX2MtKM6uymqewgiU7SdW68O9SzRKHGoePdeUTwpfDaT13g6+
        RBBDKsHpozqrr1JDWNDVqkZVAANB1htqWqOPTokt55hsNu8/5FpxHnYOxNqF7AMJ6RDF9snh83z25
        ZwDU0Ui6dElTTHxx9c91YLlBWLWN8MePIb4dyfSklmeJZHgcTc0B2pwLKruhOBh5g/z83QjR7Ul3a
        ThLcB0UA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnaF-002o2n-NP; Sun, 08 May 2022 20:32:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 22/26] reiserfs: Convert release_buffer_page() to use a folio
Date:   Sun,  8 May 2022 21:32:43 +0100
Message-Id: <20220508203247.668791-23-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203247.668791-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203247.668791-1-willy@infradead.org>
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

Saves 671 bytes from an allmodconfig build (!)

Function                                     old     new   delta
release_buffer_page                         1617     946    -671
Total: Before=67656, After=66985, chg -0.99%

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/reiserfs/journal.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index b5b6f6201bed..99ba495b0f28 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -601,14 +601,14 @@ static int journal_list_still_alive(struct super_block *s,
  */
 static void release_buffer_page(struct buffer_head *bh)
 {
-	struct page *page = bh->b_page;
-	if (!page->mapping && trylock_page(page)) {
-		get_page(page);
+	struct folio *folio = page_folio(bh->b_page);
+	if (!folio->mapping && folio_trylock(folio)) {
+		folio_get(folio);
 		put_bh(bh);
-		if (!page->mapping)
-			try_to_free_buffers(page);
-		unlock_page(page);
-		put_page(page);
+		if (!folio->mapping)
+			try_to_free_buffers(&folio->page);
+		folio_unlock(folio);
+		folio_put(folio);
 	} else {
 		put_bh(bh);
 	}
-- 
2.34.1

