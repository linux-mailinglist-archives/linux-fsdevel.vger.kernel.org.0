Return-Path: <linux-fsdevel+bounces-43298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E96FA50CBF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 21:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 789BB3AD3E8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 20:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204EE2571BE;
	Wed,  5 Mar 2025 20:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OQFDoEgS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E44253B4F
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 20:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741207660; cv=none; b=k9A9v5SbxHJjhviPFGcnAwbsUm3a+xvB/fFzTXD6e9QVZyKWKMtmOo2Tesg2K0nCswqZqt5+baZcgCOQpkhlD11Z4/nhrvGZBY/Ml9axEbLicXyTikq4ssiRcygjH8sENBaGp1ZHQCdT96ICy1g6kzUrvWyxiUEtQQwh6nesGbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741207660; c=relaxed/simple;
	bh=t6GU5joqG8Az3G15UHNVwOwsC0cD4LWwaZ5NgLNH8wA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXt44YDELJtcNwFz9kVy3u67ORpZEMc8YhbMbQ1V2vrCP+Yj0aHuQnGl8hiZTojl4XqxYJjeOUQ7aW3QhsLO/rFKFd+C9Ip43CjjzTBmIWFUlL+D6EwaUwcmynp2rsOgtOWkv3SQ8GRKr5fl1rA7H1RP9LSak0MtcPIiVVgjSdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OQFDoEgS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=1O5mcTlCY9Xs5ZmOA0cfSQHIHUlIXaHcXo/V1Pj27bE=; b=OQFDoEgSkew/iLLiCtK8UjvIo5
	nfFAR+awLcV1MtY3K/e1ncnNL5EXGqCvtvcjFoPGZSDc0pSSWryRwt3L0ory7jVwB3mxUrspLu2iU
	dseDT7lE6erAXc7OhD042UHgaMM3qrH3np40oHoYHc3I7SuoVHhkPsizbziE4xGl022M1ukh+iCw2
	Ar1Y+msfHL2XFLdxggsRX7cl0sEFHoK7EzgPWcJatMhhB6Od9FcyzvKDaT3m04M5okDrxOgtNs3bK
	gAiJkD66aTqY+KDOZrTE0AYID0is8br/0n10sXrVGJZDNnTBi02MkyCRKG3RyKUM2myUd3M6k1T+k
	gT6gJQrg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpveT-00000006BnN-26V3;
	Wed, 05 Mar 2025 20:47:37 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	devel@lists.orangefs.org,
	linux-fsdevel@vger.kernel.org,
	Mike Marshall <hubcap@omnibond.com>
Subject: [PATCH v2 6/9] orangefs: Pass mapping to orangefs_writepages_work()
Date: Wed,  5 Mar 2025 20:47:30 +0000
Message-ID: <20250305204734.1475264-7-willy@infradead.org>
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

Remove two accesses to page->mapping by passing the mapping from
orangefs_writepages() to orangefs_writepages_callback() and then
orangefs_writepages_work().  That makes it obvious that all folios come
from the same mapping, so we can hoist the call to mapping_set_error()
outside the loop.  While I'm here, switch from write_cache_pages()
to writeback_iter() which removes an indirect function call.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Tested-by: Mike Marshall <hubcap@omnibond.com>
---
 fs/orangefs/inode.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 90db1d705fe8..879d96c11b1c 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -71,14 +71,15 @@ struct orangefs_writepages {
 	kgid_t gid;
 	int maxpages;
 	int npages;
+	struct address_space *mapping;
 	struct page **pages;
 	struct bio_vec *bv;
 };
 
 static int orangefs_writepages_work(struct orangefs_writepages *ow,
-    struct writeback_control *wbc)
+		struct writeback_control *wbc)
 {
-	struct inode *inode = ow->pages[0]->mapping->host;
+	struct inode *inode = ow->mapping->host;
 	struct orangefs_write_range *wrp, wr;
 	struct iov_iter iter;
 	ssize_t ret;
@@ -107,8 +108,8 @@ static int orangefs_writepages_work(struct orangefs_writepages *ow,
 	ret = wait_for_direct_io(ORANGEFS_IO_WRITE, inode, &off, &iter, ow->len,
 	    0, &wr, NULL, NULL);
 	if (ret < 0) {
+		mapping_set_error(ow->mapping, ret);
 		for (i = 0; i < ow->npages; i++) {
-			mapping_set_error(ow->pages[i]->mapping, ret);
 			if (PagePrivate(ow->pages[i])) {
 				wrp = (struct orangefs_write_range *)
 				    page_private(ow->pages[i]);
@@ -137,9 +138,8 @@ static int orangefs_writepages_work(struct orangefs_writepages *ow,
 }
 
 static int orangefs_writepages_callback(struct folio *folio,
-		struct writeback_control *wbc, void *data)
+		struct writeback_control *wbc, struct orangefs_writepages *ow)
 {
-	struct orangefs_writepages *ow = data;
 	struct orangefs_write_range *wr = folio->private;
 	int ret;
 
@@ -197,7 +197,9 @@ static int orangefs_writepages(struct address_space *mapping,
 {
 	struct orangefs_writepages *ow;
 	struct blk_plug plug;
-	int ret;
+	int error;
+	struct folio *folio = NULL;
+
 	ow = kzalloc(sizeof(struct orangefs_writepages), GFP_KERNEL);
 	if (!ow)
 		return -ENOMEM;
@@ -213,15 +215,17 @@ static int orangefs_writepages(struct address_space *mapping,
 		kfree(ow);
 		return -ENOMEM;
 	}
+	ow->mapping = mapping;
 	blk_start_plug(&plug);
-	ret = write_cache_pages(mapping, wbc, orangefs_writepages_callback, ow);
+	while ((folio = writeback_iter(mapping, wbc, folio, &error)))
+		error = orangefs_writepages_callback(folio, wbc, ow);
 	if (ow->npages)
-		ret = orangefs_writepages_work(ow, wbc);
+		error = orangefs_writepages_work(ow, wbc);
 	blk_finish_plug(&plug);
 	kfree(ow->pages);
 	kfree(ow->bv);
 	kfree(ow);
-	return ret;
+	return error;
 }
 
 static int orangefs_launder_folio(struct folio *);
-- 
2.47.2


