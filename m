Return-Path: <linux-fsdevel+bounces-42482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3ACA42AA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 19:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5548A175EAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 18:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5DD265CDC;
	Mon, 24 Feb 2025 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X34duR8Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7195626560B
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420336; cv=none; b=sJCh/weh6OlHO1kND4tLnPpQyE0i0sEiFNiKtqaEZ8IawXDSP/Yvvn+DetF/ju3Vzg22KsvQWzZLdJ1g512ybu5vbeLex50bGCsipLfrjKENNobFr2eXdrCsFvtgbNbIc1BwQ8k5iQiu1m6dZT8xZrvcFhHi9fS0Lexg/HOAm2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420336; c=relaxed/simple;
	bh=wkPJJz2Eq0JVFigjREG8F8y1EDv72QSexGcRtcczOqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iG7XFGSz9C6aLePox/aw0KHTIv5zk08FRna7Dya1/TRaptJHv2FggIcrJzFQwK7OxDkKJUknjWGUjQpxDLMa4rC6Bw4jS+g4vFxJjoxwqnLbkksvKxtuhcDx6MoxuolyQsTaxtIW1rPYj4jKShSOId3qzR2k64hgsL85Y55rEys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X34duR8Z; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=hDHGnJYeP0II7jdkeYZwvzVglFmHPemsfc+e8TBo4GM=; b=X34duR8ZoWxg0D1Xqq6uSWD3F3
	VXUI3wMczZELHcn7ipYMLK7iO+pTbKCT3DzqraQHsL5+QBJm6wujDPvOKtpMOrzUYhOW9H9Ugu67b
	Cols+0H3aH8nkwvpSgHxUKcJ9q3dEra+omT2DWY0bFV0JnSj5Kr7oKLSu2cdBhcesMenQGfI6xlsY
	8NezaCEqEsr3q+fG9OKq+w9XWXXLgfQ3vR19hrPB0IX0zrffCv7X3jCClML7khwQ1Sbj5c0fNR/j0
	PNwRsD4YfcVG+9irCQ2iKWMABK6LXCuBUVeqNhhYdIhPoRSzNxXSxUeAuYdd7AW2d0+KiE4/WwPey
	vHsohjdQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmcpg-000000082g9-33Ea;
	Mon, 24 Feb 2025 18:05:32 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Mike Marshall <hubcap@omnibond.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Martin Brandenburg <martin@omnibond.com>,
	devel@lists.orangefs.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/9] orangefs: Pass mapping to orangefs_writepages_work()
Date: Mon, 24 Feb 2025 18:05:24 +0000
Message-ID: <20250224180529.1916812-7-willy@infradead.org>
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

Remove two accesses to page->mapping by passing the mapping from
orangefs_writepages() to orangefs_writepages_callback() and then
orangefs_writepages_work().  That makes it obvious that all folios come
from the same mapping, so we can hoist the call to mapping_set_error()
outside the loop.  While I'm here, switch from write_cache_pages()
to writeback_iter() which removes an indirect function call.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
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


