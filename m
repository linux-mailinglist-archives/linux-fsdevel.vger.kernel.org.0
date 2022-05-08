Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B092351F18C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiEHUiC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbiEHUhE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:37:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8755711C3D
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=4zgwwwIw5SRNItgN6i+fhBBM1JSJG2OeYITK0OPXl04=; b=ZWdzeya0KPTbz+fhAJIe3z4BDb
        k1lQpS+KhIIObrx81j57e1/PEDpj1lUjTX2dkXgVLzzj7pfLC+IoSJ7M2c+GTHjqug7+nO5leEfYL
        BtxQHxSHjxVewoulI/A5qXYcyrefmqUtBU5HHn4i20q3gUWq4PisG18XGdVTyPkh3W82oiwPTPcuk
        an1sONhuNNooFiW2lHiCu9Lw39asckoOx5PNuwhCa8dLmBqHMyW2WWoW1jZGMpqek9I6OV0MI3Tn9
        zgtVGksUsv6Yt8bKgQ2qlg24iqQnTCXUvG//ws5g8iUrqaSP9gbOh5bJZYqcObN8ieVX7n0pM7GJG
        ROXcNaAQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnaF-002o34-VY; Sun, 08 May 2022 20:32:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 24/26] jbd2: Convert release_buffer_page() to use a folio
Date:   Sun,  8 May 2022 21:32:45 +0100
Message-Id: <20220508203247.668791-25-willy@infradead.org>
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

Saves a few calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jbd2/commit.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index ac7f067b7bdd..2f37108da0ec 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -62,6 +62,7 @@ static void journal_end_buffer_io_sync(struct buffer_head *bh, int uptodate)
  */
 static void release_buffer_page(struct buffer_head *bh)
 {
+	struct folio *folio;
 	struct page *page;
 
 	if (buffer_dirty(bh))
@@ -71,18 +72,19 @@ static void release_buffer_page(struct buffer_head *bh)
 	page = bh->b_page;
 	if (!page)
 		goto nope;
-	if (page->mapping)
+	folio = page_folio(page);
+	if (folio->mapping)
 		goto nope;
 
 	/* OK, it's a truncated page */
-	if (!trylock_page(page))
+	if (!folio_trylock(folio))
 		goto nope;
 
-	get_page(page);
+	folio_get(folio);
 	__brelse(bh);
-	try_to_free_buffers(page);
-	unlock_page(page);
-	put_page(page);
+	try_to_free_buffers(&folio->page);
+	folio_unlock(folio);
+	folio_put(folio);
 	return;
 
 nope:
-- 
2.34.1

