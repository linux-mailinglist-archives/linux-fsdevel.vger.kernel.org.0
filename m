Return-Path: <linux-fsdevel+bounces-41725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE5BA36269
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 16:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11C277A3BB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 15:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BED22673BA;
	Fri, 14 Feb 2025 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UJM6iUXF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A14267388;
	Fri, 14 Feb 2025 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548637; cv=none; b=SU7gv72pUi9OgGZQ/Fic+AVqHzDOa+RpPNn8JnO9VWwHLA7hpT/jPT22Oi8PoJYa3Oail4N1jtCCWSqg6Ln4E9IQho6u9G5aMQnDXzkB4+fFz5gVI9Ip7fwkJmVer6rR99TEqHH48wAakc3GqOQT/FouMB/nMh1e26Bc6ibJBMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548637; c=relaxed/simple;
	bh=bzxQseKXbMAK1qk1J6tWR8GvndETFXxXPIyhR4fQG1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HduvLwh7qNlxr5y3HRlH/nnCeqdRKv8c8UON87ru15vEVUjxR+l7X82VX0T+brOTFVR2koczAmHlJrdW2IM+brwj1qQqaResjrF9tJMkxV+x5SXQqA4vVKx+ra30KLUQycHPiV0YRFHl7FRDUtQoEw1rWX0cWguDY37/YDoRKM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UJM6iUXF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=lNnrBe2rfDStZYzI9U5RdaNOKNT6hzquJXWjCMDSLWI=; b=UJM6iUXF1fDye+4NvpR1N7edJs
	kBVhhcZz+z6hK4xdn0to0Tk9pBVCCA7R3JXPbjvE1+/920cHK85HVlaYUo2B0RUrwL/TsT0ITIAaI
	aupJSJBdk2JjcWNLRVs3rwisPw5Q6sfCuzZ58RmsXSvkNlekxgkDKeNtN/A9v3QdCD5SS44fxmI+4
	2fRFKKxTyFSc0HBOpZTodnpenR928GmpG4ZHjcwVqO+q4xGDwdaEz72KmvaUKxNWYgA7AlZytEBVI
	hUuIar1sDzu76SYl24ZQxZb/OaOBBQpK4S6D1poR1N/sv6mLbyd9g+QvuEV9Eb47U5Y2h3VzLX8aM
	tm3rhHyA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tiy40-0000000Bhzc-3oL0;
	Fri, 14 Feb 2025 15:57:13 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH v2 6/7] ceph: Convert writepage_nounlock() to write_folio_nounlock()
Date: Fri, 14 Feb 2025 15:57:08 +0000
Message-ID: <20250214155710.2790505-7-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214155710.2790505-1-willy@infradead.org>
References: <20250214155710.2790505-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove references to page->index, page->mapping, thp_size(),
page_offset() and other page APIs in favour of their more efficient
folio replacements.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/addr.c | 67 +++++++++++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 33 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 7a2aa81b20eb..822485db234e 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -666,22 +666,23 @@ static u64 get_writepages_data_length(struct inode *inode,
 }
 
 /*
- * Write a single page, but leave the page locked.
+ * Write a folio, but leave it locked.
  *
  * If we get a write error, mark the mapping for error, but still adjust the
- * dirty page accounting (i.e., page is no longer dirty).
+ * dirty page accounting (i.e., folio is no longer dirty).
  */
-static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
+static int write_folio_nounlock(struct folio *folio,
+		struct writeback_control *wbc)
 {
-	struct folio *folio = page_folio(page);
-	struct inode *inode = page->mapping->host;
+	struct page *page = &folio->page;
+	struct inode *inode = folio->mapping->host;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_client *cl = fsc->client;
 	struct ceph_snap_context *snapc, *oldest;
-	loff_t page_off = page_offset(page);
+	loff_t page_off = folio_pos(folio);
 	int err;
-	loff_t len = thp_size(page);
+	loff_t len = folio_size(folio);
 	loff_t wlen;
 	struct ceph_writeback_ctl ceph_wbc;
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
@@ -689,27 +690,27 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	bool caching = ceph_is_cache_enabled(inode);
 	struct page *bounce_page = NULL;
 
-	doutc(cl, "%llx.%llx page %p idx %lu\n", ceph_vinop(inode), page,
-	      page->index);
+	doutc(cl, "%llx.%llx folio %p idx %lu\n", ceph_vinop(inode), folio,
+	      folio->index);
 
 	if (ceph_inode_is_shutdown(inode))
 		return -EIO;
 
 	/* verify this is a writeable snap context */
-	snapc = page_snap_context(page);
+	snapc = page_snap_context(&folio->page);
 	if (!snapc) {
-		doutc(cl, "%llx.%llx page %p not dirty?\n", ceph_vinop(inode),
-		      page);
+		doutc(cl, "%llx.%llx folio %p not dirty?\n", ceph_vinop(inode),
+		      folio);
 		return 0;
 	}
 	oldest = get_oldest_context(inode, &ceph_wbc, snapc);
 	if (snapc->seq > oldest->seq) {
-		doutc(cl, "%llx.%llx page %p snapc %p not writeable - noop\n",
-		      ceph_vinop(inode), page, snapc);
+		doutc(cl, "%llx.%llx folio %p snapc %p not writeable - noop\n",
+		      ceph_vinop(inode), folio, snapc);
 		/* we should only noop if called by kswapd */
 		WARN_ON(!(current->flags & PF_MEMALLOC));
 		ceph_put_snap_context(oldest);
-		redirty_page_for_writepage(wbc, page);
+		folio_redirty_for_writepage(wbc, folio);
 		return 0;
 	}
 	ceph_put_snap_context(oldest);
@@ -726,8 +727,8 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 		len = ceph_wbc.i_size - page_off;
 
 	wlen = IS_ENCRYPTED(inode) ? round_up(len, CEPH_FSCRYPT_BLOCK_SIZE) : len;
-	doutc(cl, "%llx.%llx page %p index %lu on %llu~%llu snapc %p seq %lld\n",
-	      ceph_vinop(inode), page, page->index, page_off, wlen, snapc,
+	doutc(cl, "%llx.%llx folio %p index %lu on %llu~%llu snapc %p seq %lld\n",
+	      ceph_vinop(inode), folio, folio->index, page_off, wlen, snapc,
 	      snapc->seq);
 
 	if (atomic_long_inc_return(&fsc->writeback_count) >
@@ -740,32 +741,32 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
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
@@ -791,25 +792,25 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 		if (err == -ERESTARTSYS) {
 			/* killed by SIGKILL */
 			doutc(cl, "%llx.%llx interrupted page %p\n",
-			      ceph_vinop(inode), page);
-			redirty_page_for_writepage(wbc, page);
-			end_page_writeback(page);
+			      ceph_vinop(inode), folio);
+			folio_redirty_for_writepage(wbc, folio);
+			folio_end_writeback(folio);
 			return err;
 		}
 		if (err == -EBLOCKLISTED)
 			fsc->blocklisted = true;
-		doutc(cl, "%llx.%llx setting page/mapping error %d %p\n",
-		      ceph_vinop(inode), err, page);
+		doutc(cl, "%llx.%llx setting mapping error %d %p\n",
+		      ceph_vinop(inode), err, folio);
 		mapping_set_error(&inode->i_data, err);
 		wbc->pages_skipped++;
 	} else {
 		doutc(cl, "%llx.%llx cleaned page %p\n",
-		      ceph_vinop(inode), page);
+		      ceph_vinop(inode), folio);
 		err = 0;  /* vfs expects us to return 0 */
 	}
-	oldest = detach_page_private(page);
+	oldest = folio_detach_private(folio);
 	WARN_ON_ONCE(oldest != snapc);
-	end_page_writeback(page);
+	folio_end_writeback(folio);
 	ceph_put_wrbuffer_cap_refs(ci, 1, snapc);
 	ceph_put_snap_context(snapc);  /* page's reference */
 
@@ -1473,7 +1474,7 @@ ceph_find_incompatible(struct folio *folio)
 		doutc(cl, " %llx.%llx folio %p snapc %p not current, but oldest\n",
 		      ceph_vinop(inode), folio, snapc);
 		if (folio_clear_dirty_for_io(folio)) {
-			int r = writepage_nounlock(&folio->page, NULL);
+			int r = write_folio_nounlock(folio, NULL);
 			if (r < 0)
 				return ERR_PTR(r);
 		}
-- 
2.47.2


