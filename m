Return-Path: <linux-fsdevel+bounces-41727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9196AA3626D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 16:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB51A162C0B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 15:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A01267706;
	Fri, 14 Feb 2025 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oG8vQc+8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C394C2641C6;
	Fri, 14 Feb 2025 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548638; cv=none; b=t0rXPKSKnQawUsTzBMLUN1TszDZTRr7ImIFJwW5PBwjcOuXrPfT9cPfGq5GK94OOatsOKcG7aenzl7dMk9JwN/d2lrtGCU6xApq00tCQ1YTcC0b172wz8345VMAZdTqlbXPdKoN9/4WPbQfCrECtvqMCKlWQgn6dArMXJthF3Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548638; c=relaxed/simple;
	bh=ssmnd9rFf7zrQHln0HHZAtCAQtdxoV7qobBWJzBtxhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHue3VcStnARsZBpKDtoSdtGvdAzNPMSTT4JO0aZHmo1ZrDo67UEqiBeawwnisPA10vqf3JKT1AxWWo/DYqx+WSIk1i34W3VTUJzoGTTuZ7Ui+fNYsVFOhlNdulrBK59eCUi2QCLhU3VtFV8Pz9ASnYVBZ4LaBDVjtAJyPrIoKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oG8vQc+8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=UwGNQo7FFm93dwaLZf6nrcT/ljmHCKJMVSJJ8zKHGeo=; b=oG8vQc+8ee1n52bINZ2YhEre/+
	18K5AL9Q0+fUWx0GaE84a9qsUK8Z1Tdqqs3CNCgUWP+6YGLDpk7gttDGKUngpGxLPcHLpFiZgEe0h
	IboblXPNBbzeNQESsgzmc6v7vuZ9zMRQptTL50pYYLtjb3nJDXdWccqUpHjhF5r82Lo4PW6TAnCgU
	ze94Snvpe57hjdxOr+tqpcUQtABmF064xPp//XDd3X/CdmJ+2BF4o8xPhR8y3PSdamTEwrYfjzWay
	50c79Q6LxJBzeu2L5wl+UBukjzATr0sb3IV9CeLgeMJ1cuHDFIWTimm0xqzMj4tDsnHvoVD5SMOAk
	C/nac1Gw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tiy40-0000000BhzO-3DsR;
	Fri, 14 Feb 2025 15:57:12 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH v2 5/7] ceph: Convert ceph_readdir_cache_control to store a folio
Date: Fri, 14 Feb 2025 15:57:07 +0000
Message-ID: <20250214155710.2790505-6-willy@infradead.org>
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

Pass a folio around instead of a page.  This removes an access to
page->index and a few hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/dir.c   | 13 +++++++------
 fs/ceph/inode.c | 26 ++++++++++++++------------
 fs/ceph/super.h |  2 +-
 3 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 62e99e65250d..66f00604c86b 100644
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
+		cache_ctl->folio = filemap_lock_folio(&dir->i_data, ptr_pgoff);
+		if (IS_ERR(cache_ctl->folio)) {
+			cache_ctl->folio = NULL;
 			doutc(cl, " page %lu not found\n", ptr_pgoff);
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


