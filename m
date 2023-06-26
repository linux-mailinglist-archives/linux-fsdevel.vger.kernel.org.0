Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7AC73E699
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 19:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjFZRgU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 13:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjFZRf5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:35:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B02B2943;
        Mon, 26 Jun 2023 10:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=X5nRO0yDxZXWnd7LdLo4tOM7JIHXSxr3v1Ba4laEERQ=; b=dHEryiCMCiT4PhowBmljTazeb4
        RfsGun/8AwiFhnxjHPY2gvtCCziQPaTgjIcWGU73SOzA0fIcWSc+KbOLrgdYC4Zw96YeQhBZRALK/
        NSBPdxwMWaRAijWdgrt+j34hxyho6y0P1lr64rSX2UkSY1tDGNfQdbrrGFebrtmHVEhAv0KlkYeFU
        ujdjqmyJB88r6R4mfBfQoxY25rsKXKRMoVEo5+adJIWvQ62By9WrCtZs+R2PDfdlY39s3mGEwpvNk
        KHhl2zlWg2zGwPsq6yaIwOvK4o9yUved9e1DKnPqix1EiRAggAwzHGMIQkutgfy3RkGGM5orcLDHJ
        6asH01mQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qDq7X-001vUz-9V; Mon, 26 Jun 2023 17:35:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>
Subject: [PATCH 01/12] writeback: Factor out writeback_finish()
Date:   Mon, 26 Jun 2023 18:35:10 +0100
Message-Id: <20230626173521.459345-2-willy@infradead.org>
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

Instead of having a 'done' variable that controls the nested loops,
have a writeback_finish() that can be returned directly.  This involves
keeping more things in writeback_control, but it's just moving stuff
allocated on the stack to being allocated slightly earlier on the stack.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/writeback.h |  6 ++++
 mm/page-writeback.c       | 74 +++++++++++++++++++++------------------
 2 files changed, 45 insertions(+), 35 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index fba937999fbf..5b7d11f54013 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -11,6 +11,7 @@
 #include <linux/flex_proportions.h>
 #include <linux/backing-dev-defs.h>
 #include <linux/blk_types.h>
+#include <linux/pagevec.h>
 
 struct bio;
 
@@ -52,6 +53,10 @@ struct writeback_control {
 	loff_t range_start;
 	loff_t range_end;
 
+	struct folio_batch fbatch;
+	pgoff_t done_index;
+	int err;
+
 	enum writeback_sync_modes sync_mode;
 
 	unsigned for_kupdate:1;		/* A kupdate writeback */
@@ -59,6 +64,7 @@ struct writeback_control {
 	unsigned tagged_writepages:1;	/* tag-and-write to avoid livelock */
 	unsigned for_reclaim:1;		/* Invoked from the page allocator */
 	unsigned range_cyclic:1;	/* range_start is cyclic */
+	unsigned range_whole:1;		/* entire file */
 	unsigned for_sync:1;		/* sync(2) WB_SYNC_ALL writeback */
 	unsigned unpinned_fscache_wb:1;	/* Cleared I_PINNING_FSCACHE_WB */
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 1d17fb1ec863..abd7c0eebc72 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2360,6 +2360,24 @@ void tag_pages_for_writeback(struct address_space *mapping,
 }
 EXPORT_SYMBOL(tag_pages_for_writeback);
 
+static int writeback_finish(struct address_space *mapping,
+		struct writeback_control *wbc, bool done)
+{
+	folio_batch_release(&wbc->fbatch);
+
+	/*
+	 * If we hit the last page and there is more work to be done:
+	 * wrap the index back to the start of the file for the next
+	 * time we are called.
+	 */
+	if (wbc->range_cyclic && !done)
+		wbc->done_index = 0;
+	if (wbc->range_cyclic || (wbc->range_whole && wbc->nr_to_write > 0))
+		mapping->writeback_index = wbc->done_index;
+
+	return wbc->err;
+}
+
 /**
  * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
  * @mapping: address space structure to write
@@ -2395,18 +2413,12 @@ int write_cache_pages(struct address_space *mapping,
 		      struct writeback_control *wbc, writepage_t writepage,
 		      void *data)
 {
-	int ret = 0;
-	int done = 0;
 	int error;
-	struct folio_batch fbatch;
 	int nr_folios;
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
-	pgoff_t done_index;
-	int range_whole = 0;
 	xa_mark_t tag;
 
-	folio_batch_init(&fbatch);
 	if (wbc->range_cyclic) {
 		index = mapping->writeback_index; /* prev offset */
 		end = -1;
@@ -2414,7 +2426,7 @@ int write_cache_pages(struct address_space *mapping,
 		index = wbc->range_start >> PAGE_SHIFT;
 		end = wbc->range_end >> PAGE_SHIFT;
 		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
-			range_whole = 1;
+			wbc->range_whole = 1;
 	}
 	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages) {
 		tag_pages_for_writeback(mapping, index, end);
@@ -2422,20 +2434,24 @@ int write_cache_pages(struct address_space *mapping,
 	} else {
 		tag = PAGECACHE_TAG_DIRTY;
 	}
-	done_index = index;
-	while (!done && (index <= end)) {
+
+	wbc->done_index = index;
+	folio_batch_init(&wbc->fbatch);
+	wbc->err = 0;
+
+	while (index <= end) {
 		int i;
 
 		nr_folios = filemap_get_folios_tag(mapping, &index, end,
-				tag, &fbatch);
+				tag, &wbc->fbatch);
 
 		if (nr_folios == 0)
 			break;
 
 		for (i = 0; i < nr_folios; i++) {
-			struct folio *folio = fbatch.folios[i];
+			struct folio *folio = wbc->fbatch.folios[i];
 
-			done_index = folio->index;
+			wbc->done_index = folio->index;
 
 			folio_lock(folio);
 
@@ -2488,14 +2504,14 @@ int write_cache_pages(struct address_space *mapping,
 					folio_unlock(folio);
 					error = 0;
 				} else if (wbc->sync_mode != WB_SYNC_ALL) {
-					ret = error;
-					done_index = folio->index +
-						folio_nr_pages(folio);
-					done = 1;
-					break;
+					wbc->err = error;
+					wbc->done_index = folio->index +
+							folio_nr_pages(folio);
+					return writeback_finish(mapping,
+							wbc, true);
 				}
-				if (!ret)
-					ret = error;
+				if (!wbc->err)
+					wbc->err = error;
 			}
 
 			/*
@@ -2505,26 +2521,14 @@ int write_cache_pages(struct address_space *mapping,
 			 * we tagged for writeback prior to entering this loop.
 			 */
 			if (--wbc->nr_to_write <= 0 &&
-			    wbc->sync_mode == WB_SYNC_NONE) {
-				done = 1;
-				break;
-			}
+			    wbc->sync_mode == WB_SYNC_NONE)
+				return writeback_finish(mapping, wbc, true);
 		}
-		folio_batch_release(&fbatch);
+		folio_batch_release(&wbc->fbatch);
 		cond_resched();
 	}
 
-	/*
-	 * If we hit the last page and there is more work to be done: wrap
-	 * back the index back to the start of the file for the next
-	 * time we are called.
-	 */
-	if (wbc->range_cyclic && !done)
-		done_index = 0;
-	if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
-		mapping->writeback_index = done_index;
-
-	return ret;
+	return writeback_finish(mapping, wbc, false);
 }
 EXPORT_SYMBOL(write_cache_pages);
 
-- 
2.39.2

