Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E135516A91
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 07:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383416AbiEBGAt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 02:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383409AbiEBGA2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 02:00:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B91205F3
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 May 2022 22:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=4zgwwwIw5SRNItgN6i+fhBBM1JSJG2OeYITK0OPXl04=; b=uIkxWLuyKOS0XZiaSDApWT0QGo
        dobxDrE1/EtHmR8ZdxTLyhDrwyY68hgUd1wBEdQCc9xPrhQQDV1pn029SJnMRFy+IFyjOqDkWPF2/
        m6k1ED25lSOOLWHqFuYXAr6FkO5ongwaDvrV1gUdzkmUdGPT17cJhGNn2+Seb1cygzBYgIk4Z2xwq
        ZrqsuwH95k1sYl62ozpD0sCDnpQPL0rsPDOb4KvM6mvPdH73KLMOwfcv+gzN8FDVdiaY9WxZZ3feB
        uGQlYrc6fJeScVErG/WalP2dXP4WtVNovvsYD86F3kbsSIGgWGgclK7rt7i9bwNY6JbPyEuRXJKPP
        85BDXZuQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlP2i-00EZXJ-1G; Mon, 02 May 2022 05:56:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 24/26] jbd2: Convert release_buffer_page() to use a folio
Date:   Mon,  2 May 2022 06:56:12 +0100
Message-Id: <20220502055614.3473032-25-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220502055614.3473032-1-willy@infradead.org>
References: <20220502055614.3473032-1-willy@infradead.org>
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

