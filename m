Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3077F73E697
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 19:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjFZRgS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 13:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjFZRf4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:35:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC05272C;
        Mon, 26 Jun 2023 10:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=4j8qD1VIDkeu8FuhbX23YTq3SVJUsBomytwghqZoPiA=; b=jO+IuqRONCDpfM0ToVlDzBovD9
        NnIpFqCSVbzcdzA354Ai8J4uwvQXN3vjxzaPqsdl/xu+9TkLDzcRKCal7PcOkbcF4dV4DToUbguua
        DhQc5GIdojQ+898Vu6UjYABB/NZtHhCqnv6dR6n3B4zANWT8SgicSzfUO8KQHTKbqL3iiVruTyBBi
        TgOxqzuFcqc3rCbML9MBL2LZcXwzT5+YcSAaJsyE93G9W7FkKk1k0a6BL0e2AQngll3EYEidWhOx1
        MbKdipsmpf8sBpR98d+bhM2uO0wX76Fuou4HTdMTNuQoYS1f6L3Oed9cA/g5bqwApTqNnCdDFN0wS
        UGzEVQmg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qDq7X-001vVD-S2; Mon, 26 Jun 2023 17:35:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>
Subject: [PATCH 08/12] writeback: Factor writeback_get_folio() out of write_cache_pages()
Date:   Mon, 26 Jun 2023 18:35:17 +0100
Message-Id: <20230626173521.459345-9-willy@infradead.org>
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

Move the loop for should-we-write-this-folio to its own function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/page-writeback.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 18f332611a52..659df2b5c7c0 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2430,6 +2430,27 @@ static bool should_writeback_folio(struct address_space *mapping,
 	return true;
 }
 
+static struct folio *writeback_get_folio(struct address_space *mapping,
+		struct writeback_control *wbc)
+{
+	struct folio *folio;
+
+	for (;;) {
+		folio = writeback_get_next(mapping, wbc);
+		if (!folio)
+			return NULL;
+		wbc->done_index = folio->index;
+
+		folio_lock(folio);
+		if (likely(should_writeback_folio(mapping, wbc, folio)))
+			break;
+		folio_unlock(folio);
+	}
+
+	trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
+	return folio;
+}
+
 static struct folio *writeback_iter_init(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
@@ -2449,7 +2470,7 @@ static struct folio *writeback_iter_init(struct address_space *mapping,
 	folio_batch_init(&wbc->fbatch);
 	wbc->err = 0;
 
-	return writeback_get_next(mapping, wbc);
+	return writeback_get_folio(mapping, wbc);
 }
 
 /**
@@ -2492,17 +2513,7 @@ int write_cache_pages(struct address_space *mapping,
 
 	for (folio = writeback_iter_init(mapping, wbc);
 	     folio;
-	     folio = writeback_get_next(mapping, wbc)) {
-		wbc->done_index = folio->index;
-
-		folio_lock(folio);
-		if (!should_writeback_folio(mapping, wbc, folio)) {
-			folio_unlock(folio);
-			continue;
-		}
-
-		trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
-
+	     folio = writeback_get_folio(mapping, wbc)) {
 		error = writepage(folio, wbc, data);
 		if (unlikely(error)) {
 			/*
-- 
2.39.2

