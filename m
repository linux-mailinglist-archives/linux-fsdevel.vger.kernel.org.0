Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314E3722D0A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 18:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbjFEQy2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 12:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjFEQy1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:54:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432E9E6;
        Mon,  5 Jun 2023 09:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=HpyU5vYECS3ihRXMDJHkI7+8hWYMhLS5y+P9+j5BbXk=; b=FkwJRvbYzkh86puDEDAwcX+/r4
        fIND5rwr6JZTSSyd0F/4SXPvqT2YB9EBWkc/E1Ot2MaE78ixckTSbQuqSucmC0ofv3ESeoBoiLeV7
        jmPHXktKIMDimMnAiwlJtgSwd6ZPneDt/CuelW7zLikjbDW/j77WyQsSnDCGwK/znM6sM0MC9H0g6
        eH/Y5lIMsc2hzUmYw/YE/SkVhkIBcrkWnFychMHsqAVOEInhLlrLV0bT3HsW+QlnDK2pvU2uj8qV0
        0EIAOPy+u0EFipprafiryVRAymU+adp3iAhZlw3OSGTHQbF55fH/MX+Rns9zYhcFjzho+aHuJkXu+
        Ra/ZiP0g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6DTI-00CCqv-Cx; Mon, 05 Jun 2023 16:54:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] ceph: Convert ceph_writepages_start() to use folios a little more
Date:   Mon,  5 Jun 2023 17:54:18 +0100
Message-Id: <20230605165418.2909336-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
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

After we iterate through the locked folios using filemap_get_folios_tag(),
we currently convert back to a page (and then in some circumstaces back
to a folio again!).  Just use a folio throughout and avoid various hidden
calls to compound_head().  Ceph still uses a page array to interact with
the OSD which should be cleaned up in a subsequent patch.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/addr.c | 79 +++++++++++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 40 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 6bb251a4d613..e2d92a8a53ca 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -888,7 +888,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 		int num_ops = 0, op_idx;
 		unsigned i, nr_folios, max_pages, locked_pages = 0;
 		struct page **pages = NULL, **data_pages;
-		struct page *page;
+		struct folio *folio;
 		pgoff_t strip_unit_end = 0;
 		u64 offset = 0, len = 0;
 		bool from_pool = false;
@@ -902,22 +902,22 @@ static int ceph_writepages_start(struct address_space *mapping,
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
+			pgsnapc = page_snap_context(&folio->page);
 			if (pgsnapc != snapc) {
 				dout("page snapc %p %lld != oldest %p %lld\n",
 				     pgsnapc, pgsnapc->seq, snapc, snapc->seq);
@@ -925,12 +925,10 @@ static int ceph_writepages_start(struct address_space *mapping,
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
@@ -941,31 +939,32 @@ static int ceph_writepages_start(struct address_space *mapping,
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
@@ -975,7 +974,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 				u32 xlen;
 
 				/* prepare async write request */
-				offset = (u64)page_offset(page);
+				offset = folio_pos(folio);
 				ceph_calc_file_object_mapping(&ci->i_layout,
 							      offset, wsize,
 							      &objnum, &objoff,
@@ -983,7 +982,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 				len = xlen;
 
 				num_ops = 1;
-				strip_unit_end = page->index +
+				strip_unit_end = folio->index +
 					((len - 1) >> PAGE_SHIFT);
 
 				BUG_ON(pages);
@@ -998,33 +997,33 @@ static int ceph_writepages_start(struct address_space *mapping,
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
 				    fsc->mount_options->congestion_kb))
 				fsc->write_congested = true;
 
-			pages[locked_pages++] = page;
+			pages[locked_pages++] = &folio->page;
 			fbatch.folios[i] = NULL;
 
-			len += thp_size(page);
+			len += folio_size(folio);
 		}
 
 		/* did we get anything? */
@@ -1073,7 +1072,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 			BUG_ON(IS_ERR(req));
 		}
 		BUG_ON(len < page_offset(pages[locked_pages - 1]) +
-			     thp_size(page) - offset);
+			     folio_size(folio) - offset);
 
 		req->r_callback = writepages_finish;
 		req->r_inode = inode;
@@ -1115,7 +1114,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 			set_page_writeback(pages[i]);
 			if (caching)
 				ceph_set_page_fscache(pages[i]);
-			len += thp_size(page);
+			len += folio_size(folio);
 		}
 		ceph_fscache_write_to_cache(inode, offset, len, caching);
 
@@ -1125,7 +1124,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 			/* writepages_finish() clears writeback pages
 			 * according to the data length, so make sure
 			 * data length covers all locked pages */
-			u64 min_len = len + 1 - thp_size(page);
+			u64 min_len = len + 1 - folio_size(folio);
 			len = get_writepages_data_length(inode, pages[i - 1],
 							 offset);
 			len = max(len, min_len);
-- 
2.39.2

