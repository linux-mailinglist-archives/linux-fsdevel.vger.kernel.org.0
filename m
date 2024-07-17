Return-Path: <linux-fsdevel+bounces-23854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CACAF933FF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0254A1C21B1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3A0183070;
	Wed, 17 Jul 2024 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OgsYRddb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0630181BB9
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231245; cv=none; b=Q2Up2ThrskDTEuuNaFj8qsW15Mmp4nzSf7uRxTtXH/pZ5uWH3Tw5sQUqimMxntI5LBPTulIYUQZPYCMbDyI/4hFQIENthRNHBtE3516TtgxAHGCE1Oj/Dov52azHt2EjLr8jDUjlufZGrKiI2I8bIDxW4mdQXipYhGP8G0+QkLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231245; c=relaxed/simple;
	bh=23XqkOEoHqq9RLypAp929cS4JWCT27C/7ZaU4L36cnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dBJJOgROjoLAGNG//Gcq5U6TEObpLtMA9FUVLSWj2SsluGnXh40OYsYD0sQmZV2nOTxd7lDkZKO18HSA7JgrBDAjMqaT8pQDnYM+9K8UVXbeZK9gKEJFjA225lYt6pJqcN3GVDji98p8ipixud6dtN2ZBr9dAtuwPX7sQvwdL7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OgsYRddb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=RySqyuqC5ZwMr/3iXYtn3DY3jDmkpTT3cRQ63RE9m7c=; b=OgsYRddbwLP6jFb0WSUTke1Sew
	5qGXWIjqjfwFuN3AVvG36zwuykSyJ6of72tONsP9MBpwmIYXww+BjLhL5dVsL8YBWIvrGWpqIPtYA
	cKJWjU6o+LBZUBF7GPUfOyIMGtORc3+IAJDrv00wQKt8ol7kUyQclFzJtQlYE/RpPyH2TbX+NZZNe
	NRaqVcV0KVIAapO9cfjg15C5mdQmuGFXNriwK+wzwpO2rbu3cioAPGXmA+pcoi1AUbq5A+teB/Kas
	CBFbJKwJyn16hE/UXuwSgFgRUjP9bPtzbLxcdgrUvmcwYCBrYZpDcWwQrCjQEUw5ELUF7kC28TnAX
	Ikm561/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU6sE-00000000zvf-1BES;
	Wed, 17 Jul 2024 15:47:22 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 18/23] orangefs: Convert orangefs_write_begin() to use a folio
Date: Wed, 17 Jul 2024 16:47:08 +0100
Message-ID: <20240717154716.237943-19-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717154716.237943-1-willy@infradead.org>
References: <20240717154716.237943-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Retrieve a folio from the page cache instead of a page.  This
function was previously mostly converted to use a folio, so it's
a fairly small change.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/orangefs/inode.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 6595417f62b1..e8440fa7d73c 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -313,18 +313,14 @@ static int orangefs_write_begin(struct file *file,
 {
 	struct orangefs_write_range *wr;
 	struct folio *folio;
-	struct page *page;
-	pgoff_t index;
 	int ret;
 
-	index = pos >> PAGE_SHIFT;
+	folio = __filemap_get_folio(mapping, pos / PAGE_SIZE, FGP_WRITEBEGIN,
+			mapping_gfp_mask(mapping));
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
 
-	page = grab_cache_page_write_begin(mapping, index);
-	if (!page)
-		return -ENOMEM;
-
-	*pagep = page;
-	folio = page_folio(page);
+	*pagep = &folio->page;
 
 	if (folio_test_dirty(folio) && !folio_test_private(folio)) {
 		/*
-- 
2.43.0


