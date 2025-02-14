Return-Path: <linux-fsdevel+bounces-41726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7EDA36281
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 17:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FB53AB5FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 15:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FAF2676F2;
	Fri, 14 Feb 2025 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ira+kID6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F7A245002;
	Fri, 14 Feb 2025 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548638; cv=none; b=Vb0CTN/m9VHRUXZUSKqcZmCTNkZozTDxZYHx0JTLoNJtLyHZDgKYg0MGo3e8rD81W8ZJerbeJvoA7z0cXoW1aKessJEGddVdyh/DNwWh5M2i7/uAXjrspWLqW0AkSwNPwTPjVZxw8RhMLutl/mnjHPGatXndp9vZPbdD/cPdtZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548638; c=relaxed/simple;
	bh=x1e5i4T7IKPvRMvtUDrxtuf+t5sIjprfd6MBdXqW8FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRhSpNU7QM75v4kVkvE1wdnZkIMoGkmkBbrQqzYPnUJajqM2wUg3qi7/raaqEOtC+puisU6RD+36LXfBwM8+Uw05mSrJGtGd0zm5P6ZAwXECpn9TsblXPFm/iIH6kHq8dY7Vx+T2lh25gtWcaxBXLDywzQrKhosrRpZhgEHCOWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ira+kID6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=0zDsTnPiuyqkimhuCkvyQZpsdg8vGZA67YRzdY9g7Jw=; b=Ira+kID6A8hlNPPBVP+N8L11wf
	c6LHtsQ3LGU2X/e1coKYIXJMqzIW6jDrlwcGD3cBSwgJMoovDUGY0zq1wjHtIR47vlB990QC01+Jx
	UOwJ+H0PKIc5blHgG1G/spi6jVOzAOajPJy7AQohZ6yCtajOx7ngqbevEz86Tfz5zpLB5BUsbkeYd
	U2hQdistl/Qn1ZI8IgEPT64/YJ9foLbe+4O52ts8tAoI5s43c0Xd7H9YRuoMjD2o1qY4vKt6VoDcB
	nPtNFwubUV0mUi31Dha0I5c91xeYo5pemvoOi1e/4tnBVH0H2BxvJ4btNsN/x2NeqT5jAsCMCj6kd
	BMmEtnRw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tiy41-0000000Bhzk-0drX;
	Fri, 14 Feb 2025 15:57:13 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH v2 7/7] ceph: Use a folio in ceph_writepages_start()
Date: Fri, 14 Feb 2025 15:57:09 +0000
Message-ID: <20250214155710.2790505-8-willy@infradead.org>
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

We currently convert the folio returned from filemap_get_folios_tag()
to a page and operate on that page.  Remove this and operate on the
folio.  Removes a lot of calls to obsolete functions and references
to page->index and page->mapping.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/addr.c | 63 +++++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 822485db234e..a97a3eee426b 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1025,7 +1025,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 		int num_ops = 0, op_idx;
 		unsigned i, nr_folios, max_pages, locked_pages = 0;
 		struct page **pages = NULL, **data_pages;
-		struct page *page;
+		struct folio *folio;
 		pgoff_t strip_unit_end = 0;
 		u64 offset = 0, len = 0;
 		bool from_pool = false;
@@ -1039,24 +1039,23 @@ static int ceph_writepages_start(struct address_space *mapping,
 		if (!nr_folios && !locked_pages)
 			break;
 		for (i = 0; i < nr_folios && locked_pages < max_pages; i++) {
-			struct folio *folio = fbatch.folios[i];
+			folio = fbatch.folios[i];
 
-			page = &folio->page;
-			doutc(cl, "? %p idx %lu\n", page, page->index);
+			doutc(cl, "? %p idx %lu\n", folio, folio->index);
 			if (locked_pages == 0)
-				lock_page(page);  /* first page */
-			else if (!trylock_page(page))
+				folio_lock(folio);  /* first page */
+			else if (!folio_trylock(folio))
 				break;
 
 			/* only dirty pages, or our accounting breaks */
-			if (unlikely(!PageDirty(page)) ||
-			    unlikely(page->mapping != mapping)) {
-				doutc(cl, "!dirty or !mapping %p\n", page);
-				unlock_page(page);
+			if (unlikely(!folio_test_dirty(folio)) ||
+			    unlikely(folio->mapping != mapping)) {
+				doutc(cl, "!dirty or !mapping %p\n", folio);
+				folio_unlock(folio);
 				continue;
 			}
 			/* only if matching snap context */
-			pgsnapc = page_snap_context(page);
+			pgsnapc = page_snap_context(&folio->page);
 			if (pgsnapc != snapc) {
 				doutc(cl, "page snapc %p %lld != oldest %p %lld\n",
 				      pgsnapc, pgsnapc->seq, snapc, snapc->seq);
@@ -1064,10 +1063,10 @@ static int ceph_writepages_start(struct address_space *mapping,
 				    !ceph_wbc.head_snapc &&
 				    wbc->sync_mode != WB_SYNC_NONE)
 					should_loop = true;
-				unlock_page(page);
+				folio_unlock(folio);
 				continue;
 			}
-			if (page_offset(page) >= ceph_wbc.i_size) {
+			if (folio_pos(folio) >= ceph_wbc.i_size) {
 				doutc(cl, "folio at %lu beyond eof %llu\n",
 				      folio->index, ceph_wbc.i_size);
 				if ((ceph_wbc.size_stable ||
@@ -1078,9 +1077,9 @@ static int ceph_writepages_start(struct address_space *mapping,
 				folio_unlock(folio);
 				continue;
 			}
-			if (strip_unit_end && (page->index > strip_unit_end)) {
-				doutc(cl, "end of strip unit %p\n", page);
-				unlock_page(page);
+			if (strip_unit_end && (folio->index > strip_unit_end)) {
+				doutc(cl, "end of strip unit %p\n", folio);
+				folio_unlock(folio);
 				break;
 			}
 			if (folio_test_writeback(folio) ||
@@ -1095,9 +1094,9 @@ static int ceph_writepages_start(struct address_space *mapping,
 				folio_wait_private_2(folio); /* [DEPRECATED] */
 			}
 
-			if (!clear_page_dirty_for_io(page)) {
-				doutc(cl, "%p !clear_page_dirty_for_io\n", page);
-				unlock_page(page);
+			if (!folio_clear_dirty_for_io(folio)) {
+				doutc(cl, "%p !clear_page_dirty_for_io\n", folio);
+				folio_unlock(folio);
 				continue;
 			}
 
@@ -1113,7 +1112,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 				u32 xlen;
 
 				/* prepare async write request */
-				offset = (u64)page_offset(page);
+				offset = folio_pos(folio);
 				ceph_calc_file_object_mapping(&ci->i_layout,
 							      offset, wsize,
 							      &objnum, &objoff,
@@ -1121,7 +1120,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 				len = xlen;
 
 				num_ops = 1;
-				strip_unit_end = page->index +
+				strip_unit_end = folio->index +
 					((len - 1) >> PAGE_SHIFT);
 
 				BUG_ON(pages);
@@ -1136,23 +1135,23 @@ static int ceph_writepages_start(struct address_space *mapping,
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
+				offset = folio_pos(folio);
 				len = 0;
 			}
 
 			/* note position of first page in fbatch */
 			doutc(cl, "%llx.%llx will write page %p idx %lu\n",
-			      ceph_vinop(inode), page, page->index);
+			      ceph_vinop(inode), folio, folio->index);
 
 			if (atomic_long_inc_return(&fsc->writeback_count) >
 			    CONGESTION_ON_THRESH(
@@ -1161,7 +1160,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 
 			if (IS_ENCRYPTED(inode)) {
 				pages[locked_pages] =
-					fscrypt_encrypt_pagecache_blocks(page,
+					fscrypt_encrypt_pagecache_blocks(&folio->page,
 						PAGE_SIZE, 0,
 						locked_pages ? GFP_NOWAIT : GFP_NOFS);
 				if (IS_ERR(pages[locked_pages])) {
@@ -1172,17 +1171,17 @@ static int ceph_writepages_start(struct address_space *mapping,
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
@@ -1289,7 +1288,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 			/* writepages_finish() clears writeback pages
 			 * according to the data length, so make sure
 			 * data length covers all locked pages */
-			u64 min_len = len + 1 - thp_size(page);
+			u64 min_len = len + 1 - folio_size(folio);
 			len = get_writepages_data_length(inode, pages[i - 1],
 							 offset);
 			len = max(len, min_len);
-- 
2.47.2


