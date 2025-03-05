Return-Path: <linux-fsdevel+bounces-43300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E15A50CC8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 21:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 374643AD743
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 20:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75352571D9;
	Wed,  5 Mar 2025 20:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IZVHKWev"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974DB254B08
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 20:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741207661; cv=none; b=eZhDRvbvqUdDysNtZ4znsKDx2jjKpptgtZWErdRZT7c2M+KZ6LDHcxk6s/FyRJVEo86F+pGMaLUMVJCrGVA5H9XO9vdsKFr82mymYEs0I0PFSRD2IAin+GTkkNIkTUcMHKc+CdvqmNxvhoql/vdpy65fsmjGDqPWEMrJdhnl7G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741207661; c=relaxed/simple;
	bh=ll5oxveZrMva2kz+1PiK2eJnVmd2XRWg56X+X3pf8Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbAyemEC6e6oMyAHw0OIN5QmSkRQiUoiYjcWLzPadYhJ3AkeamHnuUmoxbrcjuejyB/R0dO3SrzL2Aa5bYyLjeNEwhWwDStf7t6D9/u414M1l94VVdCHQuMnwHeu+pETnJDB5u+6nYeXscC500GTSAa8u4zgnrb01idKyk2OjzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IZVHKWev; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=tXo+ZuPAyts6XBMuIz5tH6es//GYM0Tf/xZ9OJ1H5bg=; b=IZVHKWevsCGdlRe4oAFMK0V4F9
	u+S93gzLSYL+uXYm2OzaUiOC2dAgRmhmKpAsnf1uZiZakxUhU09/aodwaaBgAzeBx75xTwQEEVyLF
	Dk8hrSNoUrZVLy6g6L1dvsm4IO6yiwdZZqrQof8178w6hGx/Ta3G49e/7YgDgE18uDR/ISIyI77y2
	qWsoRon3YgD0eFrrld+iCNGvhdutiFrazOJdngKuJzJAIypahV1JU+R3Un0u4ooImGlhFlwugFb+R
	PIQYcRWwfK1soAFppHINw0VcHvkUFebPs3pumVy4WawmoaAX7EXa3uBrhcPUPw/0JyVzsZnQDsH2W
	wiKgcG1g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpveU-00000006Bnn-0KcC;
	Wed, 05 Mar 2025 20:47:38 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	devel@lists.orangefs.org,
	linux-fsdevel@vger.kernel.org,
	Mike Marshall <hubcap@omnibond.com>
Subject: [PATCH v2 9/9] orangefs: Convert orangefs_writepages to contain an array of folios
Date: Wed,  5 Mar 2025 20:47:33 +0000
Message-ID: <20250305204734.1475264-10-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305204734.1475264-1-willy@infradead.org>
References: <20250305204734.1475264-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pages being passed in are always folios (since they come from the
page cache).  This eliminates several hidden calls to compound_head(),
and uses of legacy APIs.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Tested-by: Mike Marshall <hubcap@omnibond.com>
---
 fs/orangefs/inode.c | 57 +++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 31 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 7b5272931e3b..5ac743c6bc2e 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -70,9 +70,9 @@ struct orangefs_writepages {
 	kuid_t uid;
 	kgid_t gid;
 	int maxpages;
-	int npages;
+	int nfolios;
 	struct address_space *mapping;
-	struct page **pages;
+	struct folio **folios;
 	struct bio_vec *bv;
 };
 
@@ -89,14 +89,14 @@ static int orangefs_writepages_work(struct orangefs_writepages *ow,
 
 	len = i_size_read(inode);
 
-	start = offset_in_page(ow->off);
-	for (i = 0; i < ow->npages; i++) {
-		set_page_writeback(ow->pages[i]);
-		bvec_set_page(&ow->bv[i], ow->pages[i], PAGE_SIZE - start,
-			      start);
+	start = offset_in_folio(ow->folios[0], ow->off);
+	for (i = 0; i < ow->nfolios; i++) {
+		folio_start_writeback(ow->folios[i]);
+		bvec_set_folio(&ow->bv[i], ow->folios[i],
+				folio_size(ow->folios[i]) - start, start);
 		start = 0;
 	}
-	iov_iter_bvec(&iter, ITER_SOURCE, ow->bv, ow->npages, ow->len);
+	iov_iter_bvec(&iter, ITER_SOURCE, ow->bv, ow->nfolios, ow->len);
 
 	WARN_ON(ow->off >= len);
 	if (ow->off + ow->len > len)
@@ -112,16 +112,11 @@ static int orangefs_writepages_work(struct orangefs_writepages *ow,
 	else
 		ret = 0;
 
-	for (i = 0; i < ow->npages; i++) {
-		if (PagePrivate(ow->pages[i])) {
-			wrp = (struct orangefs_write_range *)
-			    page_private(ow->pages[i]);
-			ClearPagePrivate(ow->pages[i]);
-			put_page(ow->pages[i]);
-			kfree(wrp);
-		}
-		end_page_writeback(ow->pages[i]);
-		unlock_page(ow->pages[i]);
+	for (i = 0; i < ow->nfolios; i++) {
+		wrp = folio_detach_private(ow->folios[i]);
+		kfree(wrp);
+		folio_end_writeback(ow->folios[i]);
+		folio_unlock(ow->folios[i]);
 	}
 
 	return ret;
@@ -142,41 +137,41 @@ static int orangefs_writepages_callback(struct folio *folio,
 	}
 
 	ret = -1;
-	if (ow->npages == 0) {
+	if (ow->nfolios == 0) {
 		ow->off = wr->pos;
 		ow->len = wr->len;
 		ow->uid = wr->uid;
 		ow->gid = wr->gid;
-		ow->pages[ow->npages++] = &folio->page;
+		ow->folios[ow->nfolios++] = folio;
 		ret = 0;
 		goto done;
 	}
 	if (!uid_eq(ow->uid, wr->uid) || !gid_eq(ow->gid, wr->gid)) {
 		orangefs_writepages_work(ow, wbc);
-		ow->npages = 0;
+		ow->nfolios = 0;
 		ret = -1;
 		goto done;
 	}
 	if (ow->off + ow->len == wr->pos) {
 		ow->len += wr->len;
-		ow->pages[ow->npages++] = &folio->page;
+		ow->folios[ow->nfolios++] = folio;
 		ret = 0;
 		goto done;
 	}
 done:
 	if (ret == -1) {
-		if (ow->npages) {
+		if (ow->nfolios) {
 			orangefs_writepages_work(ow, wbc);
-			ow->npages = 0;
+			ow->nfolios = 0;
 		}
 		ret = orangefs_writepage_locked(folio, wbc);
 		mapping_set_error(folio->mapping, ret);
 		folio_unlock(folio);
 		folio_end_writeback(folio);
 	} else {
-		if (ow->npages == ow->maxpages) {
+		if (ow->nfolios == ow->maxpages) {
 			orangefs_writepages_work(ow, wbc);
-			ow->npages = 0;
+			ow->nfolios = 0;
 		}
 	}
 	return ret;
@@ -194,14 +189,14 @@ static int orangefs_writepages(struct address_space *mapping,
 	if (!ow)
 		return -ENOMEM;
 	ow->maxpages = orangefs_bufmap_size_query()/PAGE_SIZE;
-	ow->pages = kcalloc(ow->maxpages, sizeof(struct page *), GFP_KERNEL);
-	if (!ow->pages) {
+	ow->folios = kcalloc(ow->maxpages, sizeof(struct folio *), GFP_KERNEL);
+	if (!ow->folios) {
 		kfree(ow);
 		return -ENOMEM;
 	}
 	ow->bv = kcalloc(ow->maxpages, sizeof(struct bio_vec), GFP_KERNEL);
 	if (!ow->bv) {
-		kfree(ow->pages);
+		kfree(ow->folios);
 		kfree(ow);
 		return -ENOMEM;
 	}
@@ -209,10 +204,10 @@ static int orangefs_writepages(struct address_space *mapping,
 	blk_start_plug(&plug);
 	while ((folio = writeback_iter(mapping, wbc, folio, &error)))
 		error = orangefs_writepages_callback(folio, wbc, ow);
-	if (ow->npages)
+	if (ow->nfolios)
 		error = orangefs_writepages_work(ow, wbc);
 	blk_finish_plug(&plug);
-	kfree(ow->pages);
+	kfree(ow->folios);
 	kfree(ow->bv);
 	kfree(ow);
 	return error;
-- 
2.47.2


