Return-Path: <linux-fsdevel+bounces-42485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C09FAA42AA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 19:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C7407A9E04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 18:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91309264F88;
	Mon, 24 Feb 2025 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZqxxjRaZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD7B26560F
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420336; cv=none; b=RUff9rEcsNyCwg6VqZu0yOW34OVFUx8MiOj+SrmZHZb8GlhExyFdMqpd4a+GBwTWXTexXsv/O7L9W/Q/xX6gvqfwNxuS1QFExtjAYF3OyUs6cs9TASKD+PA8SzoL8vulrQVAUKaer6PAMOBnIalyt5GJC/pAb6aDtAGOlMwIl0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420336; c=relaxed/simple;
	bh=lRGm6pIo5r4BMXs3sbPin41zQghVM4t8oYXPhAHMHmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhHW23FjLKcpCaacktugMksuvIHRpzdCHAEzhIySYnZoOyepmmKonYoc+dU9E9GrPJ6V2wqf0Bo1PjOqHh91PNPmS/HlQUFROPDUIaM26h2oyJaRBhkZ1C5JxJmeEqqifrkFH9L3vX9IMsrlQymxfqZnw4mqK78p+gZDODRI7aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZqxxjRaZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=VX6SiPQXZ6HO71HIsGr/vLC/OaqSG/bV0oaX30HN6Vc=; b=ZqxxjRaZwaxoJ8A7wHOTb9qcQS
	CidWiO0vT94arSRxrvRALnp89ny/ODNxmw8f2c/Sf8NAVCF7mxjQVKm4WEOqW8gtMg74WnJDBBQyo
	Et2Qy412keCmLFQEBDGpdJILtdopVqltRuQ7Y9B7nslXgL4xNrqJVnIF1xyqYbDPjE795mWy4aBMR
	Xz1Y1sjyrLAQOHT5zppDkhHP723TBsAx0kmUAfhJAahTwarRq5t+JusMLUHlRMY6aMdkeBmn6Ieoz
	s19k9Qru2Szd46NXb6TioW/IWci5QoS4AzaB+/qY3OjvqUhJcqpGvGdaAoWrj4E3X+OUbFz06ZVFo
	wWmGf+gA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmcph-000000082gX-0w6Y;
	Mon, 24 Feb 2025 18:05:33 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Mike Marshall <hubcap@omnibond.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Martin Brandenburg <martin@omnibond.com>,
	devel@lists.orangefs.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 9/9] orangefs: Convert orangefs_writepages to contain an array of folios
Date: Mon, 24 Feb 2025 18:05:27 +0000
Message-ID: <20250224180529.1916812-10-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224180529.1916812-1-willy@infradead.org>
References: <20250224180529.1916812-1-willy@infradead.org>
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


