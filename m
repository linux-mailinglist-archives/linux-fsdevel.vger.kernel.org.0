Return-Path: <linux-fsdevel+bounces-17153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AFB8A86F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E331F22F1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 15:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38DD147C9D;
	Wed, 17 Apr 2024 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lednZond"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529A0146A9F
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366264; cv=none; b=UeQsEUEuqLZrFRoPhVJQrmfqyF942qT0kmdzsuXPGkMf2DiRXweH+s9w0aC7cx0MueEmTZn1WtsatjYFzmc8NbSy9avjgic3nluox8w0yGIE/6ZpBolrn8jOVnt+esILvxTQRWjawfmv3z6Qv0HyjveO23wwEshuQmKkcyjrtxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366264; c=relaxed/simple;
	bh=HVWsxR2Un2M5Z5ebwBlh8hoXkg2xrCwmeygtf0PH4Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VsXIouOJ4enCDzbTkkbBJP95m9uBZp7Zcv+u/zl+XF+ZMUrCEYa3/az4Phzyc2kshr62t24I7x3ubIwj9K49pZDIJh8T2xdTObK9rWFFZynTE+Jv7oC6i76VlKf7s2W5eTuZ9uZVG02RSjU2THYqx+zV3tLOSlHHnfuzGNSeKeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lednZond; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=atvJsVViKIgijLIaxFyBy0beNeCZrTimkQEKk/ptVdQ=; b=lednZondKJpU39cOmQjS249Y4u
	mFoqRPM+oV/6Lu51O/haUPli/kB2gT4pFR1afS5A/iaRpQjA2cYxr345s/+XlMtmG73I+8DMVtA5n
	qSEcBxDj/ir9x/FOXWtGv4AO60u/4/01wsWrMtsP/NGG5KyngOgeN383xYPx22NRovmAsMb7J2ZaM
	hw5Z0dyfolao03QYGVSm4Mvmq3RXI/RfL1xlJK/s3Nd8ab7znaiCP8g9+ufroZ5pF8ERLVWI2UYXV
	/qIZ0ehxInb71zMTZYkBnb0J9UYXsStFBh4WXUqGJOP6ec1Bm7OTKE59KoDx+pMVCswfMhAa8oICD
	hlylBaMg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx6pe-000000039t8-3CD4;
	Wed, 17 Apr 2024 15:04:18 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 7/7] udf: Use a folio in udf_write_end()
Date: Wed, 17 Apr 2024 16:04:13 +0100
Message-ID: <20240417150416.752929-8-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417150416.752929-1-willy@infradead.org>
References: <20240417150416.752929-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the page to a folio and use the folio APIs.  Replaces three
calls to compound_head() with one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/udf/inode.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index d34562156522..2fb21c5ffccf 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -276,17 +276,19 @@ static int udf_write_end(struct file *file, struct address_space *mapping,
 			 struct page *page, void *fsdata)
 {
 	struct inode *inode = file_inode(file);
+	struct folio *folio;
 	loff_t last_pos;
 
 	if (UDF_I(inode)->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB)
 		return generic_write_end(file, mapping, pos, len, copied, page,
 					 fsdata);
+	folio = page_folio(page);
 	last_pos = pos + copied;
 	if (last_pos > inode->i_size)
 		i_size_write(inode, last_pos);
-	set_page_dirty(page);
-	unlock_page(page);
-	put_page(page);
+	folio_mark_dirty(folio);
+	folio_unlock(folio);
+	folio_put(folio);
 
 	return copied;
 }
-- 
2.43.0


