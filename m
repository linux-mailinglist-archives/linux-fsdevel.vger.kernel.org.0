Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A03973E69C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 19:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjFZRgU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 13:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjFZRf6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:35:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7458E2947;
        Mon, 26 Jun 2023 10:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=E3aum7WU0bI7IZ184SOLo7ZVUjIFr4d1vA4qDi5sBMk=; b=rbgGQajzMWS1Zvm8l8B087MlBY
        fs44oUGNMU1wvCmN1CEVg8sLCwUHuiJlE08WOgKcUUJtDr9vSnXdpzQu4hlEVqGAcXaOveiLHWRJ1
        1u6GHkry9xBdQ+r/N6cioIMqR/K0lH0Jf8YA7KNQuh3yKOHri1HNfo7aRakN0NWaL9VTHfI+TFQux
        TOzoFNpy0Ud+oGkcZUrTaqQ9Vujxhrvbn5RT2aQviJhsaKZjlRED4Zewl45kh+nmk/MNYILFiyZO1
        5iKDAXUGwGzrxMmiWKexkmO63AcO7cu39YjbMncfmuaVnM7mc9wjySOtqZrDnAo8xwQ4xeVmtsNpf
        ddtVl8Nw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qDq7X-001vVG-VE; Mon, 26 Jun 2023 17:35:24 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>
Subject: [PATCH 09/12] writeback: Factor writeback_iter_next() out of write_cache_pages()
Date:   Mon, 26 Jun 2023 18:35:18 +0100
Message-Id: <20230626173521.459345-10-willy@infradead.org>
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

Pull the post-processing of the writepage_t callback into a
separate function.  That means changing writeback_finish() to
return NULL, and writeback_get_next() to call writeback_finish()
when we naturally run out of folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/page-writeback.c | 84 ++++++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 40 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 659df2b5c7c0..ef61d7006c5e 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2360,7 +2360,7 @@ void tag_pages_for_writeback(struct address_space *mapping,
 }
 EXPORT_SYMBOL(tag_pages_for_writeback);
 
-static int writeback_finish(struct address_space *mapping,
+static struct folio *writeback_finish(struct address_space *mapping,
 		struct writeback_control *wbc, bool done)
 {
 	folio_batch_release(&wbc->fbatch);
@@ -2375,7 +2375,7 @@ static int writeback_finish(struct address_space *mapping,
 	if (wbc->range_cyclic || (wbc->range_whole && wbc->nr_to_write > 0))
 		mapping->writeback_index = wbc->done_index;
 
-	return wbc->err;
+	return NULL;
 }
 
 static struct folio *writeback_get_next(struct address_space *mapping,
@@ -2438,7 +2438,7 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
 	for (;;) {
 		folio = writeback_get_next(mapping, wbc);
 		if (!folio)
-			return NULL;
+			return writeback_finish(mapping, wbc, false);
 		wbc->done_index = folio->index;
 
 		folio_lock(folio);
@@ -2473,6 +2473,45 @@ static struct folio *writeback_iter_init(struct address_space *mapping,
 	return writeback_get_folio(mapping, wbc);
 }
 
+static struct folio *writeback_iter_next(struct address_space *mapping,
+		struct writeback_control *wbc, struct folio *folio, int error)
+{
+	if (unlikely(error)) {
+		/*
+		 * Handle errors according to the type of writeback.
+		 * There's no need to continue for background writeback.
+		 * Just push done_index past this folio so media
+		 * errors won't choke writeout for the entire file.
+		 * For integrity writeback, we must process the entire
+		 * dirty set regardless of errors because the fs may
+		 * still have state to clear for each folio.  In that
+		 * case we continue processing and return the first error.
+		 */
+		if (error == AOP_WRITEPAGE_ACTIVATE) {
+			folio_unlock(folio);
+			error = 0;
+		} else if (wbc->sync_mode != WB_SYNC_ALL) {
+			wbc->err = error;
+			wbc->done_index = folio->index +
+					folio_nr_pages(folio);
+			return writeback_finish(mapping, wbc, true);
+		}
+		if (!wbc->err)
+			wbc->err = error;
+	}
+
+	/*
+	 * We stop writing back only if we are not doing integrity
+	 * sync. In case of integrity sync we have to keep going until
+	 * we have written all the folios we tagged for writeback prior
+	 * to entering this loop.
+	 */
+	if (--wbc->nr_to_write <= 0 && wbc->sync_mode == WB_SYNC_NONE)
+		return writeback_finish(mapping, wbc, true);
+
+	return writeback_get_folio(mapping, wbc);
+}
+
 /**
  * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
  * @mapping: address space structure to write
@@ -2513,46 +2552,11 @@ int write_cache_pages(struct address_space *mapping,
 
 	for (folio = writeback_iter_init(mapping, wbc);
 	     folio;
-	     folio = writeback_get_folio(mapping, wbc)) {
+	     folio = writeback_iter_next(mapping, wbc, folio, error)) {
 		error = writepage(folio, wbc, data);
-		if (unlikely(error)) {
-			/*
-			 * Handle errors according to the type of
-			 * writeback. There's no need to continue for
-			 * background writeback. Just push done_index
-			 * past this page so media errors won't choke
-			 * writeout for the entire file. For integrity
-			 * writeback, we must process the entire dirty
-			 * set regardless of errors because the fs may
-			 * still have state to clear for each page. In
-			 * that case we continue processing and return
-			 * the first error.
-			 */
-			if (error == AOP_WRITEPAGE_ACTIVATE) {
-				folio_unlock(folio);
-				error = 0;
-			} else if (wbc->sync_mode != WB_SYNC_ALL) {
-				wbc->err = error;
-				wbc->done_index = folio->index +
-						folio_nr_pages(folio);
-				return writeback_finish(mapping, wbc, true);
-			}
-			if (!wbc->err)
-				wbc->err = error;
-		}
-
-		/*
-		 * We stop writing back only if we are not doing
-		 * integrity sync. In case of integrity sync we have to
-		 * keep going until we have written all the pages
-		 * we tagged for writeback prior to entering this loop.
-		 */
-		if (--wbc->nr_to_write <= 0 &&
-		    wbc->sync_mode == WB_SYNC_NONE)
-			return writeback_finish(mapping, wbc, true);
 	}
 
-	return writeback_finish(mapping, wbc, false);
+	return wbc->err;
 }
 EXPORT_SYMBOL(write_cache_pages);
 
-- 
2.39.2

