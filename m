Return-Path: <linux-fsdevel+bounces-36115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2099DBF3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 06:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0F47164B74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 05:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B284D156678;
	Fri, 29 Nov 2024 05:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KY+Bnw+S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82276BA4B;
	Fri, 29 Nov 2024 05:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732859465; cv=none; b=WgxTM34iMghaGFlqSZFsCgZiBuYKgSiiuwcVONya+4BdyvFqUxygPBgyO8IFHqpqdUGi7XfGg4ON1mU7NolugHbGT0fW6zejc3x+0RkfpBTGTy99EysVF/ROaG1+6eHMcn3VGq2H/ubSsYJYGjiVrajiEgW5C44BHpJ/mqsN3DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732859465; c=relaxed/simple;
	bh=8egUAUxj44zpRy76l9tzygtGd3+xLyjW8P3/YBcigIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRNYx3zxEhZohuqE83F46/ShSGRINcsFMLtZ0rkBs6g6+10KFm8wC1BPTH0jkLhsZBmC3t6smTfE90APzwZQxApPOCDTntClPL+9dubFmO6sMVJvXeN582XPrFRgyIjJjMuP3e8r4/e9LMu+9fhitfdFmm3gWhX3x6/6Um1L5v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KY+Bnw+S; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=nuJhl9O2BQBA34eEY7w/GPOuwSdJHGPa+T+5bh/RH8s=; b=KY+Bnw+SsJi/wcpgAqGwlae7eQ
	bcKBVRNimMFvQr8q0m+fBaevOSbTQF8CtIziIrQgawGhsCUPbkHwldY6zS0QhcW+8GrwY/NSKfVAB
	zLpqNT1obqDcRoZ7oOoHGzoo4pd9KZ2k0neWEhgn1MwsfFvWD57hi0gSl1W2wMyKsEEg6bisqn3V0
	X23kO7jSU96gRqyaKjZtBYbPq+BVEqi6wNwgY+Xo2Pp1/DcctczhbwS5SqtA/a2bz6G6HM0lKm2Nd
	f0DPw9vL+OBF6o0NzvK5qPw8Cj9SbSh5HVigPFxTfjP7czPzyEcBl514EgQ4fWB5vfEjfXE3DeweM
	V4fWIdXQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGtu9-00000003bSC-1O2G;
	Fri, 29 Nov 2024 05:51:01 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Xiubo Li <xiubli@redhat.com>,
	ceph-devel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 3/5] ceph: Convert ceph_readdir_cache_control to store a folio
Date: Fri, 29 Nov 2024 05:50:54 +0000
Message-ID: <20241129055058.858940-4-willy@infradead.org>
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

Pass a folio around instead of a page.  This removes an access to
page->index and a few hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/dir.c   | 12 ++++++------
 fs/ceph/inode.c | 26 ++++++++++++++------------
 fs/ceph/super.h |  2 +-
 3 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 952109292d69..d646e1976d65 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -141,17 +141,17 @@ __dcache_find_get_entry(struct dentry *parent, u64 idx,
 	if (ptr_pos >= i_size_read(dir))
 		return NULL;
 
-	if (!cache_ctl->page || ptr_pgoff != cache_ctl->page->index) {
+	if (!cache_ctl->folio || ptr_pgoff != cache_ctl->folio->index) {
 		ceph_readdir_cache_release(cache_ctl);
-		cache_ctl->page = find_lock_page(&dir->i_data, ptr_pgoff);
-		if (!cache_ctl->page) {
+		cache_ctl->folio = filemap_lock_folio(&dir->i_data, ptr_pgoff);
+		if (!cache_ctl->folio) {
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
index 315ef02f9a3f..7e0376c771a6 100644
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
index 037eac35a9e0..135bb43b22be 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -904,7 +904,7 @@ ceph_find_rw_context(struct ceph_file_info *cf)
 }
 
 struct ceph_readdir_cache_control {
-	struct page  *page;
+	struct folio *folio;
 	struct dentry **dentries;
 	int index;
 };
-- 
2.45.2


