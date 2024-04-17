Return-Path: <linux-fsdevel+bounces-17148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5548A86EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE0AFB25153
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 15:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58372146A99;
	Wed, 17 Apr 2024 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K2NzD7uv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45DC146A9C
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 15:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366261; cv=none; b=FqIn6JFPL2bexs0NR/dClPC2cQcrfqUA0lbeNMQ6LT+s+joPQOBM2hEPQJbPSaJswR+4sLrk/7lXIg2sJvD/x1Ngy8B5D6bPkNfZ2ZBy+ZXQBSRicM8SdfEeIJQBVnFi/i5cqutcnUHnbI20mu76j0G7SYLSn/2+aU4sZ2abh9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366261; c=relaxed/simple;
	bh=1/PC5zyu2WViqsl2NNkGD7Losd2xwp3pWm1dJpPlE0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HH2O4jbLOvtAGsOZguu9pakBFSr5jGHzGMGzBCSzwEcPn56XiCFsYOYsBAAZ5STMLfwSRBuW62VIQAsZLrQXcjlZ0adm2KIjVKtQ5vzSr3Oom6OkFoCRyAxO0KS2qIbReoUIyF9QzFsCQ6keCglwn1DPZIt3cXkx6RSSk3zCAUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K2NzD7uv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=87FKHCCGdhxffL/mCXQT5VI1YF9tuBbPEZRsI5Ng4hc=; b=K2NzD7uvOXufhY6p9mhV4PApy0
	Afcw80621cQ6g1tG3OOuKVaAN8dueZG69PWl/22T3ZJ/Fl5GCvBJU7z/jmIFNJqDwCHixEgVhJcPc
	ehk+tmoPUl4GmgvDOjZ+CSEWjVmH5XckzO2uiITztmWW/pcFd/dkpBNSxEo11FO75yptzZljpuOFk
	gry9/vxhN1M2QDmALPq4K/p/avft5asmlcLSTv5nMxLDB4EOOFBXN4Nk6+ylKzIAqTaHYyaRM/cPk
	zcWWK3guwUHA9jyfMGrHe1dE3RgwvsubxIxUYUL+mG9annQXjNZVd4OtDHx6QT3dmNTb8QVsRp2hC
	Mi57aLrg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx6pe-000000039sa-0cG5;
	Wed, 17 Apr 2024 15:04:18 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/7] udf: Convert udf_write_begin() to use a folio
Date: Wed, 17 Apr 2024 16:04:08 +0100
Message-ID: <20240417150416.752929-3-willy@infradead.org>
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

Use the folio APIs throughout instead of the deprecated page APIs.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/udf/inode.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 2f831a3a91af..5146b9d7aba3 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -254,7 +254,7 @@ static int udf_write_begin(struct file *file, struct address_space *mapping,
 			   struct page **pagep, void **fsdata)
 {
 	struct udf_inode_info *iinfo = UDF_I(file_inode(file));
-	struct page *page;
+	struct folio *folio;
 	int ret;
 
 	if (iinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
@@ -266,12 +266,13 @@ static int udf_write_begin(struct file *file, struct address_space *mapping,
 	}
 	if (WARN_ON_ONCE(pos >= PAGE_SIZE))
 		return -EIO;
-	page = grab_cache_page_write_begin(mapping, 0);
-	if (!page)
-		return -ENOMEM;
-	*pagep = page;
-	if (!PageUptodate(page))
-		udf_adinicb_readpage(page);
+	folio = __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN,
+			mapping_gfp_mask(mapping));
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
+	*pagep = &folio->page;
+	if (!folio_test_uptodate(folio))
+		udf_adinicb_readpage(&folio->page);
 	return 0;
 }
 
-- 
2.43.0


