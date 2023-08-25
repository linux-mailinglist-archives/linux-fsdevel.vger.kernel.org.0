Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F06788F9A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 22:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjHYUNQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 16:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjHYUMt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 16:12:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECA12689;
        Fri, 25 Aug 2023 13:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=NkHrDQW0zdoHeGozcjLEkarrh6gEgRffl2sh1UcNT00=; b=LiLd2rchK7sKwiPV7i7Nxq1a2S
        xJiSIK3R5YEuWy0of6MH1M5FwCbBoJOJZIReOiUGTCzHblSExbSVkT55RVZT8iZroWJX/oEbY/ueo
        sAODBbLZRpWVnJRSn8jdx0Fj4T9dXm9yy3vpNtpukit4HZ+uEbY7Rar6CwszqxNFXixJf3EcuBSs+
        0YDVn5RuV/7CZlLu5b1HuZMu9TgA4t739UjYRFqwG/TiNlQ5l0UogLPOlIasKnGshnb2L7Pp7E56+
        SXiBHnpRQ8eMAMcAhMVL7sQ1AK0d5MotfzwAa4ifeq1aLegjMAluYxRts9qqBhd9d6mNgyFZIh2Hu
        DXDwR1xw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qZdAV-001SZe-2D; Fri, 25 Aug 2023 20:12:31 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/15] ceph: Convert ceph_writepages_start() to use folios a little more
Date:   Fri, 25 Aug 2023 21:12:11 +0100
Message-Id: <20230825201225.348148-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230825201225.348148-1-willy@infradead.org>
References: <20230825201225.348148-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After we iterate through the locked folios using filemap_get_folios_tag(),
we currently convert back to a page (and then in some circumstaces back
to a folio again!).  Just use a folio throughout and avoid various hidden
calls to compound_head().  Ceph still uses a page array to interact with
the OSD which should be cleaned up in a subsequent patch.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/addr.c | 100 ++++++++++++++++++++++++-------------------------
 1 file changed, 49 insertions(+), 51 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index f4863078f7fe..9a0a79833eb0 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1018,7 +1018,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 		int num_ops = 0, op_idx;
 		unsigned i, nr_folios, max_pages, locked_pages = 0;
 		struct page **pages = NULL, **data_pages;
-		struct page *page;
+		struct folio *folio;
 		pgoff_t strip_unit_end = 0;
 		u64 offset = 0, len = 0;
 		bool from_pool = false;
@@ -1032,22 +1032,22 @@ static int ceph_writepages_start(struct address_space *mapping,
 		if (!nr_folios && !locked_pages)
 			break;
 		for (i = 0; i < nr_folios && locked_pages < max_pages; i++) {
-			page = &fbatch.folios[i]->page;
-			dout("? %p idx %lu\n", page, page->index);
+			folio = fbatch.folios[i];
+			dout("? %p idx %lu\n", folio, folio->index);
 			if (locked_pages == 0)
-				lock_page(page);  /* first page */
-			else if (!trylock_page(page))
+				folio_lock(folio);  /* first folio */
+			else if (!folio_trylock(folio))
 				break;
 
 			/* only dirty pages, or our accounting breaks */
-			if (unlikely(!PageDirty(page)) ||
-			    unlikely(page->mapping != mapping)) {
-				dout("!dirty or !mapping %p\n", page);
-				unlock_page(page);
+			if (unlikely(!folio_test_dirty(folio)) ||
+			    unlikely(folio->mapping != mapping)) {
+				dout("!dirty or !mapping %p\n", folio);
+				folio_unlock(folio);
 				continue;
 			}
 			/* only if matching snap context */
-			pgsnapc = page_snap_context(page);
+			pgsnapc = folio->private;
 			if (pgsnapc != snapc) {
 				dout("page snapc %p %lld != oldest %p %lld\n",
 				     pgsnapc, pgsnapc->seq, snapc, snapc->seq);
@@ -1055,12 +1055,10 @@ static int ceph_writepages_start(struct address_space *mapping,
 				    !ceph_wbc.head_snapc &&
 				    wbc->sync_mode != WB_SYNC_NONE)
 					should_loop = true;
-				unlock_page(page);
+				folio_unlock(folio);
 				continue;
 			}
-			if (page_offset(page) >= ceph_wbc.i_size) {
-				struct folio *folio = page_folio(page);
-
+			if (folio_pos(folio) >= ceph_wbc.i_size) {
 				dout("folio at %lu beyond eof %llu\n",
 				     folio->index, ceph_wbc.i_size);
 				if ((ceph_wbc.size_stable ||
@@ -1071,31 +1069,32 @@ static int ceph_writepages_start(struct address_space *mapping,
 				folio_unlock(folio);
 				continue;
 			}
-			if (strip_unit_end && (page->index > strip_unit_end)) {
-				dout("end of strip unit %p\n", page);
-				unlock_page(page);
+			if (strip_unit_end && (folio->index > strip_unit_end)) {
+				dout("end of strip unit %p\n", folio);
+				folio_unlock(folio);
 				break;
 			}
-			if (PageWriteback(page) || PageFsCache(page)) {
+			if (folio_test_writeback(folio) ||
+			    folio_test_fscache(folio)) {
 				if (wbc->sync_mode == WB_SYNC_NONE) {
-					dout("%p under writeback\n", page);
-					unlock_page(page);
+					dout("%p under writeback\n", folio);
+					folio_unlock(folio);
 					continue;
 				}
-				dout("waiting on writeback %p\n", page);
-				wait_on_page_writeback(page);
-				wait_on_page_fscache(page);
+				dout("waiting on writeback %p\n", folio);
+				folio_wait_writeback(folio);
+				folio_wait_fscache(folio);
 			}
 
-			if (!clear_page_dirty_for_io(page)) {
-				dout("%p !clear_page_dirty_for_io\n", page);
-				unlock_page(page);
+			if (!folio_clear_dirty_for_io(folio)) {
+				dout("%p !folio_clear_dirty_for_io\n", folio);
+				folio_unlock(folio);
 				continue;
 			}
 
 			/*
 			 * We have something to write.  If this is
-			 * the first locked page this time through,
+			 * the first locked folio this time through,
 			 * calculate max possinle write size and
 			 * allocate a page array
 			 */
@@ -1105,7 +1104,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 				u32 xlen;
 
 				/* prepare async write request */
-				offset = (u64)page_offset(page);
+				offset = folio_pos(folio);
 				ceph_calc_file_object_mapping(&ci->i_layout,
 							      offset, wsize,
 							      &objnum, &objoff,
@@ -1113,7 +1112,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 				len = xlen;
 
 				num_ops = 1;
-				strip_unit_end = page->index +
+				strip_unit_end = folio->index +
 					((len - 1) >> PAGE_SHIFT);
 
 				BUG_ON(pages);
@@ -1128,23 +1127,23 @@ static int ceph_writepages_start(struct address_space *mapping,
 				}
 
 				len = 0;
-			} else if (page->index !=
+			} else if (folio->index !=
 				   (offset + len) >> PAGE_SHIFT) {
 				if (num_ops >= (from_pool ?  CEPH_OSD_SLAB_OPS :
 							     CEPH_OSD_MAX_OPS)) {
-					redirty_page_for_writepage(wbc, page);
-					unlock_page(page);
+					folio_redirty_for_writepage(wbc, folio);
+					folio_unlock(folio);
 					break;
 				}
 
 				num_ops++;
-				offset = (u64)page_offset(page);
+				offset = (u64)folio_pos(folio);
 				len = 0;
 			}
 
 			/* note position of first page in fbatch */
-			dout("%p will write page %p idx %lu\n",
-			     inode, page, page->index);
+			dout("%p will write folio %p idx %lu\n",
+			     inode, folio, folio->index);
 
 			if (atomic_long_inc_return(&fsc->writeback_count) >
 			    CONGESTION_ON_THRESH(
@@ -1153,7 +1152,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 
 			if (IS_ENCRYPTED(inode)) {
 				pages[locked_pages] =
-					fscrypt_encrypt_pagecache_blocks(page,
+					fscrypt_encrypt_pagecache_blocks(&folio->page,
 						PAGE_SIZE, 0,
 						locked_pages ? GFP_NOWAIT : GFP_NOFS);
 				if (IS_ERR(pages[locked_pages])) {
@@ -1163,17 +1162,17 @@ static int ceph_writepages_start(struct address_space *mapping,
 					/* better not fail on first page! */
 					BUG_ON(locked_pages == 0);
 					pages[locked_pages] = NULL;
-					redirty_page_for_writepage(wbc, page);
-					unlock_page(page);
+					folio_redirty_for_writepage(wbc, folio);
+					folio_unlock(folio);
 					break;
 				}
 				++locked_pages;
 			} else {
-				pages[locked_pages++] = page;
+				pages[locked_pages++] = &folio->page;
 			}
 
 			fbatch.folios[i] = NULL;
-			len += thp_size(page);
+			len += folio_size(folio);
 		}
 
 		/* did we get anything? */
@@ -1222,7 +1221,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 			BUG_ON(IS_ERR(req));
 		}
 		BUG_ON(len < ceph_fscrypt_page_offset(pages[locked_pages - 1]) +
-			     thp_size(pages[locked_pages - 1]) - offset);
+			     folio_size(folio) - offset);
 
 		if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
 			rc = -EIO;
@@ -1236,9 +1235,9 @@ static int ceph_writepages_start(struct address_space *mapping,
 		data_pages = pages;
 		op_idx = 0;
 		for (i = 0; i < locked_pages; i++) {
-			struct page *page = ceph_fscrypt_pagecache_page(pages[i]);
+			struct folio *folio = page_folio(ceph_fscrypt_pagecache_page(pages[i]));
 
-			u64 cur_offset = page_offset(page);
+			u64 cur_offset = folio_pos(folio);
 			/*
 			 * Discontinuity in page range? Ceph can handle that by just passing
 			 * multiple extents in the write op.
@@ -1267,10 +1266,10 @@ static int ceph_writepages_start(struct address_space *mapping,
 				op_idx++;
 			}
 
-			set_page_writeback(page);
+			folio_start_writeback(folio);
 			if (caching)
-				ceph_set_page_fscache(page);
-			len += thp_size(page);
+				ceph_set_page_fscache(pages[i]);
+			len += folio_size(folio);
 		}
 		ceph_fscache_write_to_cache(inode, offset, len, caching);
 
@@ -1280,7 +1279,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 			/* writepages_finish() clears writeback pages
 			 * according to the data length, so make sure
 			 * data length covers all locked pages */
-			u64 min_len = len + 1 - thp_size(page);
+			u64 min_len = len + 1 - folio_size(folio);
 			len = get_writepages_data_length(inode, pages[i - 1],
 							 offset);
 			len = max(len, min_len);
@@ -1360,7 +1359,6 @@ static int ceph_writepages_start(struct address_space *mapping,
 		if (wbc->sync_mode != WB_SYNC_NONE &&
 		    start_index == 0 && /* all dirty pages were checked */
 		    !ceph_wbc.head_snapc) {
-			struct page *page;
 			unsigned i, nr;
 			index = 0;
 			while ((index <= end) &&
@@ -1369,10 +1367,10 @@ static int ceph_writepages_start(struct address_space *mapping,
 						PAGECACHE_TAG_WRITEBACK,
 						&fbatch))) {
 				for (i = 0; i < nr; i++) {
-					page = &fbatch.folios[i]->page;
-					if (page_snap_context(page) != snapc)
+					struct folio *folio = fbatch.folios[i];
+					if (folio->private != snapc)
 						continue;
-					wait_on_page_writeback(page);
+					folio_wait_writeback(folio);
 				}
 				folio_batch_release(&fbatch);
 				cond_resched();
-- 
2.40.1

