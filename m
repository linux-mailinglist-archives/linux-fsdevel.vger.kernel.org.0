Return-Path: <linux-fsdevel+bounces-41885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A16A38B8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 19:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4D7B7A1578
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 18:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18E5236457;
	Mon, 17 Feb 2025 18:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XgskMAF4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C269235BF4;
	Mon, 17 Feb 2025 18:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739818286; cv=none; b=tZWW93gkf87y69DZgEEniRb9y3PdDiD+lFAQ8bXj9+e8WC6Caz3BT9VSEsqfedX3HkE131zz5OpbpTxbYC+R87IFeL6ZEVu67Ka+FmhuGXzFZO+FOGvvl7WkSIGhyHaaKgBU92iYKE1i9IqRmcjpzS6/fZMa9CGhmoe6G0Qb5kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739818286; c=relaxed/simple;
	bh=wYI++/sj5jglu3sNsTpH9O7Oed02NPw6gudP5qqChXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQaAkWoTuxLp63mE1epgM+JTcGPpSrvrgNMkm8n/nlhK/VrJK4lleNgPUx9jOGqjwkogvpoK8XIVWK9ujooZleVd7tiqQmEGF2ZtmD3nwsJrdSE26xVb4Wg1iHexWc7x/agwNs5LGJMSONqRZpwFaIqnRbyyikt8rHhKqp50nK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XgskMAF4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Hm9fjCN/JKEwkIkZRTE4nmENLJqXTwaxoFhpMzpe+34=; b=XgskMAF4Yz9Dy8DtS3Pg5Yd2Sp
	tcpbjcX33+NMQ8ZrxWOkr1LE7Tg4HG0PmvqHskPO2b/cLAug/VX2T7vcS4gYcw2PvhRJ4eRgQ327k
	pUipyr1VCvq7Zh3FOa+Gk+7ue4lK8tbRrsc6p2N3FKQl3x1jyNx008Wd2hsng9gsXktWgp4snPgEh
	Gn+Pw2Vsnkmzg88a4xVfZN4OQIR10xOtIdLp0hGhJp1dbwPAnJe6eHp/Q7atFTTpNE2wPkJiW/M/O
	v43mBSuCG0zkdmz+zXLOce/5cZzg13w4gU1B7l+JcqjleH9qRUGfqrvhzfUisotOosCHS+BNCQRli
	F89ct7ww==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6DB-00000001nw3-3Vra;
	Mon, 17 Feb 2025 18:51:21 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH v3 7/9] ceph: Remove uses of page from ceph_process_folio_batch()
Date: Mon, 17 Feb 2025 18:51:15 +0000
Message-ID: <20250217185119.430193-8-willy@infradead.org>
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

Remove uses of page->index and deprecated page APIs.  Saves a lot of
hidden calls to compound_head().

Also convert is_page_index_contiguous() to is_folio_index_contiguous()
and make its arguments const.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/addr.c | 47 ++++++++++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 90d154bc4808..fd46eab12ded 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1226,10 +1226,10 @@ void ceph_allocate_page_array(struct address_space *mapping,
 }
 
 static inline
-bool is_page_index_contiguous(struct ceph_writeback_ctl *ceph_wbc,
-			      struct page *page)
+bool is_folio_index_contiguous(const struct ceph_writeback_ctl *ceph_wbc,
+			      const struct folio *folio)
 {
-	return page->index == (ceph_wbc->offset + ceph_wbc->len) >> PAGE_SHIFT;
+	return folio->index == (ceph_wbc->offset + ceph_wbc->len) >> PAGE_SHIFT;
 }
 
 static inline
@@ -1294,7 +1294,6 @@ int ceph_process_folio_batch(struct address_space *mapping,
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_client *cl = fsc->client;
 	struct folio *folio = NULL;
-	struct page *page = NULL;
 	unsigned i;
 	int rc = 0;
 
@@ -1304,11 +1303,9 @@ int ceph_process_folio_batch(struct address_space *mapping,
 		if (!folio)
 			continue;
 
-		page = &folio->page;
-
 		doutc(cl, "? %p idx %lu, folio_test_writeback %#x, "
 			"folio_test_dirty %#x, folio_test_locked %#x\n",
-			page, page->index, folio_test_writeback(folio),
+			folio, folio->index, folio_test_writeback(folio),
 			folio_test_dirty(folio),
 			folio_test_locked(folio));
 
@@ -1321,27 +1318,27 @@ int ceph_process_folio_batch(struct address_space *mapping,
 		}
 
 		if (ceph_wbc->locked_pages == 0)
-			lock_page(page);  /* first page */
-		else if (!trylock_page(page))
+			folio_lock(folio);
+		else if (!folio_trylock(folio))
 			break;
 
 		rc = ceph_check_page_before_write(mapping, wbc,
 						  ceph_wbc, folio);
 		if (rc == -ENODATA) {
 			rc = 0;
-			unlock_page(page);
+			folio_unlock(folio);
 			ceph_wbc->fbatch.folios[i] = NULL;
 			continue;
 		} else if (rc == -E2BIG) {
 			rc = 0;
-			unlock_page(page);
+			folio_unlock(folio);
 			ceph_wbc->fbatch.folios[i] = NULL;
 			break;
 		}
 
-		if (!clear_page_dirty_for_io(page)) {
-			doutc(cl, "%p !clear_page_dirty_for_io\n", page);
-			unlock_page(page);
+		if (!folio_clear_dirty_for_io(folio)) {
+			doutc(cl, "%p !folio_clear_dirty_for_io\n", folio);
+			folio_unlock(folio);
 			ceph_wbc->fbatch.folios[i] = NULL;
 			continue;
 		}
@@ -1353,35 +1350,35 @@ int ceph_process_folio_batch(struct address_space *mapping,
 		 * allocate a page array
 		 */
 		if (ceph_wbc->locked_pages == 0) {
-			ceph_allocate_page_array(mapping, ceph_wbc, page);
-		} else if (!is_page_index_contiguous(ceph_wbc, page)) {
+			ceph_allocate_page_array(mapping, ceph_wbc, &folio->page);
+		} else if (!is_folio_index_contiguous(ceph_wbc, folio)) {
 			if (is_num_ops_too_big(ceph_wbc)) {
-				redirty_page_for_writepage(wbc, page);
-				unlock_page(page);
+				folio_redirty_for_writepage(wbc, folio);
+				folio_unlock(folio);
 				break;
 			}
 
 			ceph_wbc->num_ops++;
-			ceph_wbc->offset = (u64)page_offset(page);
+			ceph_wbc->offset = (u64)folio_pos(folio);
 			ceph_wbc->len = 0;
 		}
 
 		/* note position of first page in fbatch */
-		doutc(cl, "%llx.%llx will write page %p idx %lu\n",
-		      ceph_vinop(inode), page, page->index);
+		doutc(cl, "%llx.%llx will write folio %p idx %lu\n",
+		      ceph_vinop(inode), folio, folio->index);
 
 		fsc->write_congested = is_write_congestion_happened(fsc);
 
 		rc = ceph_move_dirty_page_in_page_array(mapping, wbc,
-							ceph_wbc, page);
+							ceph_wbc, &folio->page);
 		if (rc) {
-			redirty_page_for_writepage(wbc, page);
-			unlock_page(page);
+			folio_redirty_for_writepage(wbc, folio);
+			folio_unlock(folio);
 			break;
 		}
 
 		ceph_wbc->fbatch.folios[i] = NULL;
-		ceph_wbc->len += thp_size(page);
+		ceph_wbc->len += folio_size(folio);
 	}
 
 	ceph_wbc->processed_in_fbatch = i;
-- 
2.47.2


