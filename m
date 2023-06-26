Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3D473E6AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 19:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjFZRhf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 13:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjFZRgO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:36:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D2C170D;
        Mon, 26 Jun 2023 10:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Eb8+i22W56HZAod8nWQSK472UiI/gYMP48K8do/ME/8=; b=I8BvqJCHhBej30amkNnVaHN6rH
        u9uO/sVt2f+jz7JcGOSx+zl/f70NIeziA/OlCB4o62GnbbwwGLVv/hBjABtamZ47YbH1j4ZOO4hoc
        QRtJcd7ZjBN83uepkFoGD0dLghMKRhe+wpJC6dFdWan3E0U1OHu3sqtiCt8ZD7+zxqDSwb0Vbi5uq
        nOyJHt2ANqAHJbdn5QtHLs8S1Ecyurt3g/m+y5pugk3uH39x/eU2jWFeYf7aR2cgIn9Y2zwwl/ozy
        mNgR7J1eV9HCBuDFaS061IwieX96E0vWyEzjHBhaHEzX9wLQ2iAiERfPCLB4uIn1bhmMDv7lULBmZ
        j2uURkZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qDq7X-001vV1-CW; Mon, 26 Jun 2023 17:35:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>
Subject: [PATCH 02/12] writeback: Factor writeback_get_batch() out of write_cache_pages()
Date:   Mon, 26 Jun 2023 18:35:11 +0100
Message-Id: <20230626173521.459345-3-willy@infradead.org>
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

This simple helper will be the basis of the writeback iterator.
To make this work, we need to remember the current index
and end positions in writeback_control.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/writeback.h |  2 ++
 mm/page-writeback.c       | 49 +++++++++++++++++++++------------------
 2 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 5b7d11f54013..7dd050b40e4b 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -54,6 +54,8 @@ struct writeback_control {
 	loff_t range_end;
 
 	struct folio_batch fbatch;
+	pgoff_t index;
+	pgoff_t end;		/* Inclusive */
 	pgoff_t done_index;
 	int err;
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index abd7c0eebc72..67c7f1564727 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2378,6 +2378,22 @@ static int writeback_finish(struct address_space *mapping,
 	return wbc->err;
 }
 
+static void writeback_get_batch(struct address_space *mapping,
+		struct writeback_control *wbc)
+{
+	xa_mark_t tag;
+
+	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
+		tag = PAGECACHE_TAG_TOWRITE;
+	else
+		tag = PAGECACHE_TAG_DIRTY;
+
+	folio_batch_release(&wbc->fbatch);
+	cond_resched();
+	filemap_get_folios_tag(mapping, &wbc->index, wbc->end, tag,
+			&wbc->fbatch);
+}
+
 /**
  * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
  * @mapping: address space structure to write
@@ -2414,41 +2430,32 @@ int write_cache_pages(struct address_space *mapping,
 		      void *data)
 {
 	int error;
-	int nr_folios;
-	pgoff_t index;
-	pgoff_t end;		/* Inclusive */
-	xa_mark_t tag;
 
 	if (wbc->range_cyclic) {
-		index = mapping->writeback_index; /* prev offset */
-		end = -1;
+		wbc->index = mapping->writeback_index; /* prev offset */
+		wbc->end = -1;
 	} else {
-		index = wbc->range_start >> PAGE_SHIFT;
-		end = wbc->range_end >> PAGE_SHIFT;
+		wbc->index = wbc->range_start >> PAGE_SHIFT;
+		wbc->end = wbc->range_end >> PAGE_SHIFT;
 		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
 			wbc->range_whole = 1;
 	}
-	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages) {
-		tag_pages_for_writeback(mapping, index, end);
-		tag = PAGECACHE_TAG_TOWRITE;
-	} else {
-		tag = PAGECACHE_TAG_DIRTY;
-	}
+	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
+		tag_pages_for_writeback(mapping, wbc->index, wbc->end);
 
-	wbc->done_index = index;
+	wbc->done_index = wbc->index;
 	folio_batch_init(&wbc->fbatch);
 	wbc->err = 0;
 
-	while (index <= end) {
+	while (wbc->index <= wbc->end) {
 		int i;
 
-		nr_folios = filemap_get_folios_tag(mapping, &index, end,
-				tag, &wbc->fbatch);
+		writeback_get_batch(mapping, wbc);
 
-		if (nr_folios == 0)
+		if (wbc->fbatch.nr == 0)
 			break;
 
-		for (i = 0; i < nr_folios; i++) {
+		for (i = 0; i < wbc->fbatch.nr; i++) {
 			struct folio *folio = wbc->fbatch.folios[i];
 
 			wbc->done_index = folio->index;
@@ -2524,8 +2531,6 @@ int write_cache_pages(struct address_space *mapping,
 			    wbc->sync_mode == WB_SYNC_NONE)
 				return writeback_finish(mapping, wbc, true);
 		}
-		folio_batch_release(&wbc->fbatch);
-		cond_resched();
 	}
 
 	return writeback_finish(mapping, wbc, false);
-- 
2.39.2

