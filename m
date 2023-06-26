Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2F873E6AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 19:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjFZRhP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 13:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjFZRgH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:36:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246EC10D7;
        Mon, 26 Jun 2023 10:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Hry/pakf3XrjxtX3FxEBHlEHaVaCFV/OlgXU52VAJV8=; b=jW+KKslSaTipXxmpNDSSeOnylL
        hzbQCyN3wKzjlszSqjc4HEgvviOgGGjspRJs0Vjv5zO3/R9XMbjtxpTsmS+9Gcwuw/ZcmCCyUnNeN
        H4tbBHnB66YtrhxCVg35T1Z99VBOHuc93t96BguJpmXgSVovFmRpL3E4/mslcgF20oYguKO1t+f7E
        aUfCqCMqXZB9pkY6yvUPK4VnHdbnXMwfDHnVDWMQUOAefkCf44Iu/CmD4lgC7Vnrxqd1w5+fQwu8z
        //QbapaLS3fMPaq6e7Ev6OQIihxf6gBxNalmqp3q/qnWQWabKWAZg/iTq63WdoLJnsWBSSCUnMJEx
        OM6BZUcg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qDq7X-001vV5-HI; Mon, 26 Jun 2023 17:35:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>
Subject: [PATCH 04/12] writeback: Simplify the loops in write_cache_pages()
Date:   Mon, 26 Jun 2023 18:35:13 +0100
Message-Id: <20230626173521.459345-5-willy@infradead.org>
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

Collapse the two nested loops into one.  This is needed as a step
towards turning this into an iterator.
---
 mm/page-writeback.c | 94 ++++++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 54f2972dab45..68f28eeb15ed 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2461,6 +2461,7 @@ int write_cache_pages(struct address_space *mapping,
 		      void *data)
 {
 	int error;
+	int i = 0;
 
 	if (wbc->range_cyclic) {
 		wbc->index = mapping->writeback_index; /* prev offset */
@@ -2478,65 +2479,64 @@ int write_cache_pages(struct address_space *mapping,
 	folio_batch_init(&wbc->fbatch);
 	wbc->err = 0;
 
-	while (wbc->index <= wbc->end) {
-		int i;
-
-		writeback_get_batch(mapping, wbc);
+	for (;;) {
+		struct folio *folio;
 
+		if (i == wbc->fbatch.nr) {
+			writeback_get_batch(mapping, wbc);
+			i = 0;
+		}
 		if (wbc->fbatch.nr == 0)
 			break;
 
-		for (i = 0; i < wbc->fbatch.nr; i++) {
-			struct folio *folio = wbc->fbatch.folios[i];
+		folio = wbc->fbatch.folios[i++];
 
-			wbc->done_index = folio->index;
+		wbc->done_index = folio->index;
 
-			folio_lock(folio);
-			if (!should_writeback_folio(mapping, wbc, folio)) {
-				folio_unlock(folio);
-				continue;
-			}
+		folio_lock(folio);
+		if (!should_writeback_folio(mapping, wbc, folio)) {
+			folio_unlock(folio);
+			continue;
+		}
 
-			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
-
-			error = writepage(folio, wbc, data);
-			if (unlikely(error)) {
-				/*
-				 * Handle errors according to the type of
-				 * writeback. There's no need to continue for
-				 * background writeback. Just push done_index
-				 * past this page so media errors won't choke
-				 * writeout for the entire file. For integrity
-				 * writeback, we must process the entire dirty
-				 * set regardless of errors because the fs may
-				 * still have state to clear for each page. In
-				 * that case we continue processing and return
-				 * the first error.
-				 */
-				if (error == AOP_WRITEPAGE_ACTIVATE) {
-					folio_unlock(folio);
-					error = 0;
-				} else if (wbc->sync_mode != WB_SYNC_ALL) {
-					wbc->err = error;
-					wbc->done_index = folio->index +
-							folio_nr_pages(folio);
-					return writeback_finish(mapping,
-							wbc, true);
-				}
-				if (!wbc->err)
-					wbc->err = error;
-			}
+		trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
 
+		error = writepage(folio, wbc, data);
+		if (unlikely(error)) {
 			/*
-			 * We stop writing back only if we are not doing
-			 * integrity sync. In case of integrity sync we have to
-			 * keep going until we have written all the pages
-			 * we tagged for writeback prior to entering this loop.
+			 * Handle errors according to the type of
+			 * writeback. There's no need to continue for
+			 * background writeback. Just push done_index
+			 * past this page so media errors won't choke
+			 * writeout for the entire file. For integrity
+			 * writeback, we must process the entire dirty
+			 * set regardless of errors because the fs may
+			 * still have state to clear for each page. In
+			 * that case we continue processing and return
+			 * the first error.
 			 */
-			if (--wbc->nr_to_write <= 0 &&
-			    wbc->sync_mode == WB_SYNC_NONE)
+			if (error == AOP_WRITEPAGE_ACTIVATE) {
+				folio_unlock(folio);
+				error = 0;
+			} else if (wbc->sync_mode != WB_SYNC_ALL) {
+				wbc->err = error;
+				wbc->done_index = folio->index +
+						folio_nr_pages(folio);
 				return writeback_finish(mapping, wbc, true);
+			}
+			if (!wbc->err)
+				wbc->err = error;
 		}
+
+		/*
+		 * We stop writing back only if we are not doing
+		 * integrity sync. In case of integrity sync we have to
+		 * keep going until we have written all the pages
+		 * we tagged for writeback prior to entering this loop.
+		 */
+		if (--wbc->nr_to_write <= 0 &&
+		    wbc->sync_mode == WB_SYNC_NONE)
+			return writeback_finish(mapping, wbc, true);
 	}
 
 	return writeback_finish(mapping, wbc, false);
-- 
2.39.2

