Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1432173E69F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 19:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjFZRg0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 13:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjFZRgB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:36:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21687295B;
        Mon, 26 Jun 2023 10:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9GHSvlYBgCYCqD7sma1ZZnKYfGDXP4peUgN6BejXrU0=; b=H2DjqGYqS0ifPU6GyJXK8/BxHu
        vFVfQGhUx+x0NN019oG/9u6ta/c935isFdskogz6Zi5wk9YpfV1rQeHd3yOr16sdWHX3Sm1wYo4Tl
        q8Fc6gm3j5a09vRX3D7oa0aXQ+iDxgDnkfjvdQIGdTEVvqcbxfdqAXQOe5yO1SaLR+j0jt7+c+sW9
        Pf8KrI7ur+AjXLjxw7Oxzr9qKsXddBrG4X2eYIqgC9KINNGsUfczjLXew+6IH5c7gUiUOekAEY/4T
        S1ZXhpeY87W/eVlS6lP9H5r3hIaN6in+5mIpOPY/vuuee0LlE5XFsUlbax1JnG8mOLDe9HZw6BXwb
        4sjyyKCg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qDq7X-001vV9-Mf; Mon, 26 Jun 2023 17:35:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>
Subject: [PATCH 06/12] writeback: Use the folio_batch queue iterator
Date:   Mon, 26 Jun 2023 18:35:15 +0100
Message-Id: <20230626173521.459345-7-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230626173521.459345-1-willy@infradead.org>
References: <20230626173521.459345-1-willy@infradead.org>
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

Instead of keeping our own local iterator variable, use the one just
added to folio_batch.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/page-writeback.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 68f28eeb15ed..f782b48c5b0c 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2378,11 +2378,15 @@ static int writeback_finish(struct address_space *mapping,
 	return wbc->err;
 }
 
-static void writeback_get_batch(struct address_space *mapping,
+static struct folio *writeback_get_next(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
+	struct folio *folio = folio_batch_next(&wbc->fbatch);
 	xa_mark_t tag;
 
+	if (folio)
+		return folio;
+
 	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
 		tag = PAGECACHE_TAG_TOWRITE;
 	else
@@ -2392,6 +2396,7 @@ static void writeback_get_batch(struct address_space *mapping,
 	cond_resched();
 	filemap_get_folios_tag(mapping, &wbc->index, wbc->end, tag,
 			&wbc->fbatch);
+	return folio_batch_next(&wbc->fbatch);
 }
 
 static bool should_writeback_folio(struct address_space *mapping,
@@ -2461,7 +2466,6 @@ int write_cache_pages(struct address_space *mapping,
 		      void *data)
 {
 	int error;
-	int i = 0;
 
 	if (wbc->range_cyclic) {
 		wbc->index = mapping->writeback_index; /* prev offset */
@@ -2480,17 +2484,11 @@ int write_cache_pages(struct address_space *mapping,
 	wbc->err = 0;
 
 	for (;;) {
-		struct folio *folio;
+		struct folio *folio = writeback_get_next(mapping, wbc);
 
-		if (i == wbc->fbatch.nr) {
-			writeback_get_batch(mapping, wbc);
-			i = 0;
-		}
-		if (wbc->fbatch.nr == 0)
+		if (!folio)
 			break;
 
-		folio = wbc->fbatch.folios[i++];
-
 		wbc->done_index = folio->index;
 
 		folio_lock(folio);
-- 
2.39.2

