Return-Path: <linux-fsdevel+bounces-41888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F81A38B9A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 19:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1832F3B44B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 18:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E30C238D54;
	Mon, 17 Feb 2025 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="urVN9h2R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B02123642E;
	Mon, 17 Feb 2025 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739818293; cv=none; b=uuDLN+7QI3sxJeCDoRlSNipEvYx0ASBiNfRLUGOGBkAnCjAUDHCPUhXcTRynEdBVZ5vC2TOczN5lPy3xa+4GXIbjS2+ObJ6H8Kqoemt++YGt4anbo0kntFj+n3dTfkXVhLX9ZPzB+SwytREKygtcWPwDumqHA+i89w6rKDRGqNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739818293; c=relaxed/simple;
	bh=mU7NI6a5d9A7g5ReKjk6GnGHeBcYNlRGHWdtczZMBgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9UT/WZbgJrKzGps7Wp2XldbTQ1IrOFQya5yyKUfcZ26ZYDOilAMX6pHOcJBBFYJ1yuJU5w61Z72r+xY08XrP7GIbaCDC4tPCHUCFr6XtxS8VWk5Wnzb6XYGpa039Bwil49ltQKQ+nSQy1jdO4VCOEdHvQEW8spZWZJ1//bZajo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=urVN9h2R; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=6DHO0Y+Q4FIeywZECiCQmlhTCbqDLFjeS9LJzrHP7s0=; b=urVN9h2RJUwp2WwgL/jeGX0+75
	PRnCcNpIYklzSvgrK4cltmOmI42CMgcFWCzpxlFK0IXd3d+h68KTarTuBM4Bx14s5wE9i8S4RiUGl
	UKrpJGguQbAQ2AjpGNFCmlVdPVUPoQE8M65PAyICzC0QRiKexIFAzA09/jabU/hayx7QxWVPTuYBn
	anzaAAMXCbLiktirwuRtQfYYn21aZsoY2sDH3CSdgsnxZTCIpvW+2n3JbC5pLj9afGZWaf3AO4zce
	vZX4RFJdFR4wFR+PDChnAOVFgPJPwersUBcw6Kp9l7VJl+78tgNSnVQwYDOoR9rHzs+yGIrN1TDPj
	wPXy2xrg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6DB-00000001nvi-260u;
	Mon, 17 Feb 2025 18:51:21 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH v3 4/9] ceph: Convert ceph_readdir_cache_control to store a folio
Date: Mon, 17 Feb 2025 18:51:12 +0000
Message-ID: <20250217185119.430193-5-willy@infradead.org>
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

Pass a folio around instead of a page.  This removes an access to
page->index and a few hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 fs/ceph/dir.c   | 15 ++++++++-------
 fs/ceph/inode.c | 26 ++++++++++++++------------
 fs/ceph/super.h |  2 +-
 3 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 62e99e65250d..d22be9314de3 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -141,17 +141,18 @@ __dcache_find_get_entry(struct dentry *parent, u64 idx,
 	if (ptr_pos >= i_size_read(dir))
 		return NULL;
 
-	if (!cache_ctl->page || ptr_pgoff != cache_ctl->page->index) {
+	if (!cache_ctl->folio || ptr_pgoff != cache_ctl->folio->index) {
 		ceph_readdir_cache_release(cache_ctl);
-		cache_ctl->page = find_lock_page(&dir->i_data, ptr_pgoff);
-		if (!cache_ctl->page) {
-			doutc(cl, " page %lu not found\n", ptr_pgoff);
+		cache_ctl->folio = filemap_lock_folio(&dir->i_data, ptr_pgoff);
+		if (IS_ERR(cache_ctl->folio)) {
+			cache_ctl->folio = NULL;
+			doutc(cl, " folio %lu not found\n", ptr_pgoff);
 			return ERR_PTR(-EAGAIN);
 		}
 		/* reading/filling the cache are serialized by
-		   i_rwsem, no need to use page lock */
-		unlock_page(cache_ctl->page);
-		cache_ctl->dentries = kmap(cache_ctl->page);
+		   i_rwsem, no need to use folio lock */
+		folio_unlock(cache_ctl->folio);
+		cache_ctl->dentries = kmap_local_folio(cache_ctl->folio, 0);
 	}
 
 	cache_ctl->index = idx & idx_mask;
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 7dd6c2275085..c15970fa240f 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1845,10 +1845,9 @@ static int readdir_prepopulate_inodes_only(struct ceph_mds_request *req,
 
 void ceph_readdir_cache_release(struct ceph_readdir_cache_control *ctl)
 {
-	if (ctl->page) {
-		kunmap(ctl->page);
-		put_page(ctl->page);
-		ctl->page = NULL;
+	if (ctl->folio) {
+		folio_release_kmap(ctl->folio, ctl->dentries);
+		ctl->folio = NULL;
 	}
 }
 
@@ -1862,20 +1861,23 @@ static int fill_readdir_cache(struct inode *dir, struct dentry *dn,
 	unsigned idx = ctl->index % nsize;
 	pgoff_t pgoff = ctl->index / nsize;
 
-	if (!ctl->page || pgoff != ctl->page->index) {
+	if (!ctl->folio || pgoff != ctl->folio->index) {
 		ceph_readdir_cache_release(ctl);
+		fgf_t fgf = FGP_LOCK;
+
 		if (idx == 0)
-			ctl->page = grab_cache_page(&dir->i_data, pgoff);
-		else
-			ctl->page = find_lock_page(&dir->i_data, pgoff);
-		if (!ctl->page) {
+			fgf |= FGP_ACCESSED | FGP_CREAT;
+
+		ctl->folio = __filemap_get_folio(&dir->i_data, pgoff,
+				fgf, mapping_gfp_mask(&dir->i_data));
+		if (!ctl->folio) {
 			ctl->index = -1;
 			return idx == 0 ? -ENOMEM : 0;
 		}
 		/* reading/filling the cache are serialized by
-		 * i_rwsem, no need to use page lock */
-		unlock_page(ctl->page);
-		ctl->dentries = kmap(ctl->page);
+		 * i_rwsem, no need to use folio lock */
+		folio_unlock(ctl->folio);
+		ctl->dentries = kmap_local_folio(ctl->folio, 0);
 		if (idx == 0)
 			memset(ctl->dentries, 0, PAGE_SIZE);
 	}
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 7fa1e7be50e4..bb0db0cc8003 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -903,7 +903,7 @@ ceph_find_rw_context(struct ceph_file_info *cf)
 }
 
 struct ceph_readdir_cache_control {
-	struct page  *page;
+	struct folio *folio;
 	struct dentry **dentries;
 	int index;
 };
-- 
2.47.2


