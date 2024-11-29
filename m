Return-Path: <linux-fsdevel+bounces-36116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EA09DBF3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 06:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DDB9B21BAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 05:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62673BA4B;
	Fri, 29 Nov 2024 05:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UnTZD3+t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822C915250F;
	Fri, 29 Nov 2024 05:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732859465; cv=none; b=S6hRzx9sVRwWRvIAT+DNGdVscS7hiXOrK58hMh++aARGVAWgXVirAN671n5ohnCAydRZumQBqBhDBX8tml6txPFqJjOJHtXVM1T2v4kLJRTBxRTVV3rOTRYkeMFdY0qOg8TMGQZgddKl3GInUuyiiLYoOI/8zwYoiNcJCVJaErk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732859465; c=relaxed/simple;
	bh=6nNwnsy9XDF6fTEJKOBprenqS8ZpNx8mkM8SleI8y5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBMJYZUjD6XTCLuWYG32ZxmPHh9nUAV+fuJAhwVKPGJ+M9AV+YwB+DKRpiNaEp6vHVLs4VDadTvs/gWwxicWAtElwFvoC5dwCBeNiDDWuAuE8KKsQ16KA1jv7omTOyyta0ZbhfqtAilgPW1qFmfHPNHr+N4vr63np5WC+8iLyR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UnTZD3+t; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=3FD4RxgDA+riPCAsGTZ05CrmziQl4duAAOIqznO9dI8=; b=UnTZD3+t+OFh3OWN4/MsxJePVs
	TxgcfWiIjz7YENUJVRrUZoNdlno4NtD8bgAGJ1/mB5oRCS1rbLUVjnLz5nvc1YLeyJzmKpyq9Fbvu
	AaYxSqCWH4oBRCti/sUXYXiePKn+9Ts3N9s3MxvMQvQPLVzbwtxZAdRQAA1SdybDcXyOk/L3PQy4g
	pclKD6gOGnpoZufyw9vwb9FnURvyUo1//FlFkMF6utFEUK/qjeG1IyhmIEeoCic42NzUuTWu3TBVp
	hKU38/SFhSaEELiKhIzIecf3lX6+hG0tE3ssb4I9JKoGb1uocoYfveBmdGBfn/PSVzFR6oBkM2cYt
	pwo+xi6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGtu9-00000003bSG-2A2j;
	Fri, 29 Nov 2024 05:51:01 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Xiubo Li <xiubli@redhat.com>,
	ceph-devel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 5/5] ceph: Use a folio in ceph_writepages_start()
Date: Fri, 29 Nov 2024 05:50:56 +0000
Message-ID: <20241129055058.858940-6-willy@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241129055058.858940-1-willy@infradead.org>
References: <20241129055058.858940-1-willy@infradead.org>
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
 fs/ceph/addr.c | 55 +++++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index aba8d55bd533..1e0c982f5abe 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1056,22 +1056,21 @@ static int ceph_writepages_start(struct address_space *mapping,
 		for (i = 0; i < nr_folios && locked_pages < max_pages; i++) {
 			struct folio *folio = fbatch.folios[i];
 
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
@@ -1079,10 +1078,10 @@ static int ceph_writepages_start(struct address_space *mapping,
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
@@ -1093,9 +1092,9 @@ static int ceph_writepages_start(struct address_space *mapping,
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
@@ -1110,9 +1109,9 @@ static int ceph_writepages_start(struct address_space *mapping,
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
 
@@ -1128,7 +1127,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 				u32 xlen;
 
 				/* prepare async write request */
-				offset = (u64)page_offset(page);
+				offset = folio_pos(folio);
 				ceph_calc_file_object_mapping(&ci->i_layout,
 							      offset, wsize,
 							      &objnum, &objoff,
@@ -1136,7 +1135,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 				len = xlen;
 
 				num_ops = 1;
-				strip_unit_end = page->index +
+				strip_unit_end = folio->index +
 					((len - 1) >> PAGE_SHIFT);
 
 				BUG_ON(pages);
@@ -1151,23 +1150,23 @@ static int ceph_writepages_start(struct address_space *mapping,
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
@@ -1187,17 +1186,17 @@ static int ceph_writepages_start(struct address_space *mapping,
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
-- 
2.45.2


