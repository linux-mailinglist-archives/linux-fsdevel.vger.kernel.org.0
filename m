Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523FD73E6B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 19:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjFZRiC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 13:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjFZRhD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:37:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757FB19A4;
        Mon, 26 Jun 2023 10:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Rl4mK631QVfMYqrn657sw5cU2nYiKao9j/G8hhMJYQc=; b=nbsu3asmGLUEUJkp+PGufwS657
        4CnYI/PCw6l8Xww27U0CYRwuyhdw3qbIis63qGdeGzCtVLsJOFwYt3NxR09Tdc5xZeJfOY8HBxSpD
        ML123J3s2go0dLVKtO7JpczdsBdChbc2qdUxfvc7R/nlZz9ke8A7G0kVR8Pe3BeM8cYwULIOBI4va
        QsVz+e8awbc3irLZPqIwC6yclmfeLbv2Eyi3WV9YAYsgEKeC1gNGPKT8+flhqRnRCmJZMdmeKgqPH
        POUXY9Q1cVqApg0noTgC9DVH6ZMLKwAsYN6jYt4BOAsygoP/Us8PMzM8KNlDC/dCF+nMklunLylR/
        u0gT4KlA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qDq7X-001vVB-PR; Mon, 26 Jun 2023 17:35:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>
Subject: [PATCH 07/12] writeback: Factor writeback_iter_init() out of write_cache_pages()
Date:   Mon, 26 Jun 2023 18:35:16 +0100
Message-Id: <20230626173521.459345-8-willy@infradead.org>
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

Make it return the first folio in the batch so that we can use it
in a typical for() pattern.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/page-writeback.c | 48 ++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index f782b48c5b0c..18f332611a52 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2430,6 +2430,28 @@ static bool should_writeback_folio(struct address_space *mapping,
 	return true;
 }
 
+static struct folio *writeback_iter_init(struct address_space *mapping,
+		struct writeback_control *wbc)
+{
+	if (wbc->range_cyclic) {
+		wbc->index = mapping->writeback_index; /* prev offset */
+		wbc->end = -1;
+	} else {
+		wbc->index = wbc->range_start >> PAGE_SHIFT;
+		wbc->end = wbc->range_end >> PAGE_SHIFT;
+		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
+			wbc->range_whole = 1;
+	}
+	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
+		tag_pages_for_writeback(mapping, wbc->index, wbc->end);
+
+	wbc->done_index = wbc->index;
+	folio_batch_init(&wbc->fbatch);
+	wbc->err = 0;
+
+	return writeback_get_next(mapping, wbc);
+}
+
 /**
  * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
  * @mapping: address space structure to write
@@ -2465,30 +2487,12 @@ int write_cache_pages(struct address_space *mapping,
 		      struct writeback_control *wbc, writepage_t writepage,
 		      void *data)
 {
+	struct folio *folio;
 	int error;
 
-	if (wbc->range_cyclic) {
-		wbc->index = mapping->writeback_index; /* prev offset */
-		wbc->end = -1;
-	} else {
-		wbc->index = wbc->range_start >> PAGE_SHIFT;
-		wbc->end = wbc->range_end >> PAGE_SHIFT;
-		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
-			wbc->range_whole = 1;
-	}
-	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
-		tag_pages_for_writeback(mapping, wbc->index, wbc->end);
-
-	wbc->done_index = wbc->index;
-	folio_batch_init(&wbc->fbatch);
-	wbc->err = 0;
-
-	for (;;) {
-		struct folio *folio = writeback_get_next(mapping, wbc);
-
-		if (!folio)
-			break;
-
+	for (folio = writeback_iter_init(mapping, wbc);
+	     folio;
+	     folio = writeback_get_next(mapping, wbc)) {
 		wbc->done_index = folio->index;
 
 		folio_lock(folio);
-- 
2.39.2

