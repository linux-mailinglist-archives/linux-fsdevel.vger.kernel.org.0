Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8567788F91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 22:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjHYUNM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 16:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjHYUMl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 16:12:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0989F2690;
        Fri, 25 Aug 2023 13:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=NZROqDnVo1AJOEsHXhdtifpOHoAwSMxJtl59fuVOhak=; b=hm+L48Vlc8aQqrk1DFeY90KUV2
        dbyylE9Q0Qb8wAkja7c4lAOhhv0i0WE4qsFyeCWgM9NWNC2VV9eEjRXQyor9McgjJy4+AwH6vzsHk
        qXfIeHNACohuJOhuSPwTHD+vV90vwvmVMyj7jFYOFi9mIdtE1VwK6p3FokxOS+T6NIJ8fXosvCPSG
        uVMSk2LbY0EeDHDRQuTOKen3exs6gzLfWfoObY5Jct3Pzt/5tkJQ42cgjRBbOx4DQC8YEm3VySLDa
        60sMO25wWosnBtzESg6kY1jHYs3cArHvxPNmoi0ZnH2s12kFDCblMReFcFnERer2cE17cr1tetbNV
        AhDGWRxg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qZdAV-001SZq-Ks; Fri, 25 Aug 2023 20:12:31 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/15] ceph: Convert writepage_nounlock() to take a folio
Date:   Fri, 25 Aug 2023 21:12:17 +0100
Message-Id: <20230825201225.348148-8-willy@infradead.org>
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

Remove the use of a lot of old APIs and use folio->index to
identify folios in debug output.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/addr.c | 66 +++++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 0027906a9257..02caf10d43ed 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -648,52 +648,52 @@ static u64 get_writepages_data_length(struct inode *inode,
 }
 
 /*
- * Write a single page, but leave the page locked.
+ * Write a single folio, but leave the folio locked.
  *
  * If we get a write error, mark the mapping for error, but still adjust the
- * dirty page accounting (i.e., page is no longer dirty).
+ * dirty page accounting (i.e., folio is no longer dirty).
  */
-static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
+static int writepage_nounlock(struct folio *folio, struct writeback_control *wbc)
 {
-	struct folio *folio = page_folio(page);
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
 	struct ceph_snap_context *snapc, *oldest;
-	loff_t page_off = page_offset(page);
+	loff_t page_off = folio_pos(folio);
 	int err;
-	loff_t len = thp_size(page);
+	loff_t len = folio_size(folio);
 	loff_t wlen;
 	struct ceph_writeback_ctl ceph_wbc;
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	struct ceph_osd_request *req;
 	bool caching = ceph_is_cache_enabled(inode);
+	struct page *page = &folio->page;
 	struct page *bounce_page = NULL;
 
-	dout("writepage %p idx %lu\n", page, page->index);
+	dout("writepage %lu\n", folio->index);
 
 	if (ceph_inode_is_shutdown(inode))
 		return -EIO;
 
 	/* verify this is a writeable snap context */
-	snapc = page_snap_context(page);
+	snapc = folio->private;
 	if (!snapc) {
-		dout("writepage %p page %p not dirty?\n", inode, page);
+		dout("writepage %p folio %lu not dirty?\n", inode, folio->index);
 		return 0;
 	}
 	oldest = get_oldest_context(inode, &ceph_wbc, snapc);
 	if (snapc->seq > oldest->seq) {
-		dout("writepage %p page %p snapc %p not writeable - noop\n",
-		     inode, page, snapc);
+		dout("writepage %p folio %lu snapc %p not writeable - noop\n",
+		     inode, folio->index, snapc);
 		/* we should only noop if called by kswapd */
 		WARN_ON(!(current->flags & PF_MEMALLOC));
 		ceph_put_snap_context(oldest);
-		redirty_page_for_writepage(wbc, page);
+		folio_redirty_for_writepage(wbc, folio);
 		return 0;
 	}
 	ceph_put_snap_context(oldest);
 
-	/* is this a partial page at end of file? */
+	/* is this a partial folio at end of file? */
 	if (page_off >= ceph_wbc.i_size) {
 		dout("folio at %lu beyond eof %llu\n", folio->index,
 				ceph_wbc.i_size);
@@ -705,8 +705,8 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 		len = ceph_wbc.i_size - page_off;
 
 	wlen = IS_ENCRYPTED(inode) ? round_up(len, CEPH_FSCRYPT_BLOCK_SIZE) : len;
-	dout("writepage %p page %p index %lu on %llu~%llu snapc %p seq %lld\n",
-	     inode, page, page->index, page_off, wlen, snapc, snapc->seq);
+	dout("writepage %p folio %lu on %llu~%llu snapc %p seq %lld\n",
+	     inode, folio->index, page_off, wlen, snapc, snapc->seq);
 
 	if (atomic_long_inc_return(&fsc->writeback_count) >
 	    CONGESTION_ON_THRESH(fsc->mount_options->congestion_kb))
@@ -718,32 +718,32 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 				    ceph_wbc.truncate_seq,
 				    ceph_wbc.truncate_size, true);
 	if (IS_ERR(req)) {
-		redirty_page_for_writepage(wbc, page);
+		folio_redirty_for_writepage(wbc, folio);
 		return PTR_ERR(req);
 	}
 
 	if (wlen < len)
 		len = wlen;
 
-	set_page_writeback(page);
+	folio_start_writeback(folio);
 	if (caching)
-		ceph_set_page_fscache(page);
+		ceph_set_page_fscache(&folio->page);
 	ceph_fscache_write_to_cache(inode, page_off, len, caching);
 
 	if (IS_ENCRYPTED(inode)) {
-		bounce_page = fscrypt_encrypt_pagecache_blocks(page,
+		bounce_page = fscrypt_encrypt_pagecache_blocks(&folio->page,
 						    CEPH_FSCRYPT_BLOCK_SIZE, 0,
 						    GFP_NOFS);
 		if (IS_ERR(bounce_page)) {
-			redirty_page_for_writepage(wbc, page);
-			end_page_writeback(page);
+			folio_redirty_for_writepage(wbc, folio);
+			folio_end_writeback(folio);
 			ceph_osdc_put_request(req);
 			return PTR_ERR(bounce_page);
 		}
 	}
 
 	/* it may be a short write due to an object boundary */
-	WARN_ON_ONCE(len > thp_size(page));
+	WARN_ON_ONCE(len > folio_size(folio));
 	osd_req_op_extent_osd_data_pages(req, 0,
 			bounce_page ? &bounce_page : &page, wlen, 0,
 			false, false);
@@ -767,26 +767,26 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 			wbc = &tmp_wbc;
 		if (err == -ERESTARTSYS) {
 			/* killed by SIGKILL */
-			dout("writepage interrupted page %p\n", page);
-			redirty_page_for_writepage(wbc, page);
-			end_page_writeback(page);
+			dout("writepage interrupted folio %lu\n", folio->index);
+			folio_redirty_for_writepage(wbc, folio);
+			folio_end_writeback(folio);
 			return err;
 		}
 		if (err == -EBLOCKLISTED)
 			fsc->blocklisted = true;
-		dout("writepage setting page/mapping error %d %p\n",
-		     err, page);
+		dout("writepage setting folio/mapping error %d %lu\n",
+		     err, folio->index);
 		mapping_set_error(&inode->i_data, err);
 		wbc->pages_skipped++;
 	} else {
-		dout("writepage cleaned page %p\n", page);
+		dout("writepage cleaned folio %lu\n", folio->index);
 		err = 0;  /* vfs expects us to return 0 */
 	}
-	oldest = detach_page_private(page);
+	oldest = folio_detach_private(folio);
 	WARN_ON_ONCE(oldest != snapc);
-	end_page_writeback(page);
+	folio_end_writeback(folio);
 	ceph_put_wrbuffer_cap_refs(ci, 1, snapc);
-	ceph_put_snap_context(snapc);  /* page's reference */
+	ceph_put_snap_context(snapc);  /* folio's reference */
 
 	if (atomic_long_dec_return(&fsc->writeback_count) <
 	    CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
@@ -1432,7 +1432,7 @@ static struct ceph_snap_context *ceph_find_incompatible(struct folio *folio)
 		dout(" folio %ld snapc %p not current, but oldest\n",
 				folio->index, snapc);
 		if (folio_clear_dirty_for_io(folio)) {
-			int r = writepage_nounlock(&folio->page, NULL);
+			int r = writepage_nounlock(folio, NULL);
 			if (r < 0)
 				return ERR_PTR(r);
 		}
-- 
2.40.1

