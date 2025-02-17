Return-Path: <linux-fsdevel+bounces-41882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A57BFA38B87
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 19:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63BF11891E6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 18:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE7D23718D;
	Mon, 17 Feb 2025 18:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="erLgtzU0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3493322A1EC;
	Mon, 17 Feb 2025 18:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739818284; cv=none; b=GaQz5iFudyhEIU+gJLge45rtzNBA7AqEUH8HFuh4EsH+yEIoCn95uguKzTmETE4O3Zrx4Se861O19LsEFlmQqDflC1rdlaj2g6D8vLKwsKuVpgkEsnV7rg3/TMykxE31XP/6W4CzSflrIN1K2rscc5vFGyPG7GohB42W3zomn8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739818284; c=relaxed/simple;
	bh=4v3rNrZh+Gu/1VMB75whnTf+GZh5snecmnPiDmD3CEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CtR8MQSCDRvURo24P9KR5K/1ltHgsKznXv5LZtZyjxLwmn7vAlTSn3U0fswb/MiXaMe7OCb/3zm3nZ3hBNayfR3EH7QizETEXkQ8MItglGr2qfyANwmBJ+ytOWT+fUtstn952sbwotfrpS5BMoPTUpxRgxGoK5yvkJWQ8KSwQK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=erLgtzU0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=tDRKjH/sI2KgWZjZG7atG9m0NcIGnYyk6khm+PZOyh0=; b=erLgtzU0yoXHb7Sez7fPtFpjCQ
	yRgL30NMsUvZMBERwlxzbyb42sxODlsSgW4g2CZLE0K3Jc3E5kKLEJp0VQeHQiIDDU8A5SbqMq0IV
	qT0V8Nz4hYBxzQRJLAc5zL+/wnLjLfTz3ZI1U8v/lXI1YLqAswW1ovidFcCsE0HDIddF5MZ6XSdRi
	ZlEa89vFoicRS29Gl+ScNP8dz9ehRbEvb5mZrKs5d2KVtiqupbAjy71uSfvdMpJVkNouGNfNnpg+h
	x0evSx5himJt2q5NOarpej7VVTMBvX6hh0C8jpIb5KmM9gUX5XLXSWb3xru+BufdVqxxGY82E5ugN
	dw3TuuJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6DB-00000001nvk-2UIU;
	Mon, 17 Feb 2025 18:51:21 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH v3 5/9] ceph: Convert writepage_nounlock() to write_folio_nounlock()
Date: Mon, 17 Feb 2025 18:51:13 +0000
Message-ID: <20250217185119.430193-6-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217185119.430193-1-willy@infradead.org>
References: <20250217185119.430193-1-willy@infradead.org>
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
index 08f8bdfc275e..871adfa82c1f 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -708,22 +708,23 @@ static u64 get_writepages_data_length(struct inode *inode,
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
@@ -731,27 +732,27 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
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
@@ -768,8 +769,8 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 		len = ceph_wbc.i_size - page_off;
 
 	wlen = IS_ENCRYPTED(inode) ? round_up(len, CEPH_FSCRYPT_BLOCK_SIZE) : len;
-	doutc(cl, "%llx.%llx page %p index %lu on %llu~%llu snapc %p seq %lld\n",
-	      ceph_vinop(inode), page, page->index, page_off, wlen, snapc,
+	doutc(cl, "%llx.%llx folio %p index %lu on %llu~%llu snapc %p seq %lld\n",
+	      ceph_vinop(inode), folio, folio->index, page_off, wlen, snapc,
 	      snapc->seq);
 
 	if (atomic_long_inc_return(&fsc->writeback_count) >
@@ -782,32 +783,32 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
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
@@ -833,25 +834,25 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
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
 
@@ -1830,7 +1831,7 @@ ceph_find_incompatible(struct folio *folio)
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


