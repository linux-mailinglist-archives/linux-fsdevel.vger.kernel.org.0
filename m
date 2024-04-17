Return-Path: <linux-fsdevel+bounces-17154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD8D8A86F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9823B284F0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 15:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F171482F1;
	Wed, 17 Apr 2024 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R7aOuWCC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5592E146D41
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366265; cv=none; b=AdkrA+qtsD1yhYPPNhTWP6v2EJvedHj7TT6w5It/o0qbo3dLrJkl1X2WHO7IfzyIBdPZ7Z4YngtGdze9aBsGHvLiSWC1yd41Y4ZCQOx/PyfGHNdQyozBn8JLADbF1duJbwQ3zL9USi0e3QYOfO447uFHMJW7O0sziL4MhhZbIN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366265; c=relaxed/simple;
	bh=Gw7OnBH2/oRSRi2jh77j+Are39dCP5m7V6ZD88+U5gY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CMkOJFszKkCVE2Egl3cuVa8Og9kBceQVGck4IVa4LU6kwk3lmgUlwBva8e3bwB55NVPVMac7/dMFZHWVY2dSq1QO2I3zszRZITLLr16+iM8tWugyWnzO1znQEEoYawBlMDqoFJJX0QBcEeJ/Q8e+zuZvxari/PQcLYw5810HI8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R7aOuWCC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=abJreXktpiF5PI7nmRuI16aBaDcs1cBZcegeYCHMuLI=; b=R7aOuWCCDHQUGWsIgDMgMXh9yF
	J9V5Nokd7a1DyeXtDPcRSongN4JxFKb4oOiyv6E7+YMD7sy+SwRJwciEgahaHILJPbpVtFVBuHenN
	lVoNinKzvxpEXtRjSOgxccrrMxx4DN/sGRf4CHL3rvWDbGQuW8T5RSLMVtlK384rWsplMkIf9HAjt
	C4EswqtXL0HGq6GztHMTfdIxLuhGnFChypHVfO3yh0U+mQ14/ecSdM3FzlKyoqLYYwYJr/sZ0UAs6
	nuXQgy0PCCAaBI14kzh/jUzfe+oSeiSsXFIINLhynSandoHyIYSpTEvYw5V4FMhQHJ14V3voz53zs
	gUFuQk3Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx6pe-000000039sv-266E;
	Wed, 17 Apr 2024 15:04:18 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/7] udf: Convert udf_symlink_getattr() to use a folio
Date: Wed, 17 Apr 2024 16:04:11 +0100
Message-ID: <20240417150416.752929-6-willy@infradead.org>
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

We're getting this from the page cache, so it's definitely a folio.
Saves a call to compound_head() hidden in put_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/udf/symlink.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/udf/symlink.c b/fs/udf/symlink.c
index 0105e7e2ba3d..fe03745d09b1 100644
--- a/fs/udf/symlink.c
+++ b/fs/udf/symlink.c
@@ -137,12 +137,12 @@ static int udf_symlink_getattr(struct mnt_idmap *idmap,
 {
 	struct dentry *dentry = path->dentry;
 	struct inode *inode = d_backing_inode(dentry);
-	struct page *page;
+	struct folio *folio;
 
 	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
-	page = read_mapping_page(inode->i_mapping, 0, NULL);
-	if (IS_ERR(page))
-		return PTR_ERR(page);
+	folio = read_mapping_folio(inode->i_mapping, 0, NULL);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
 	/*
 	 * UDF uses non-trivial encoding of symlinks so i_size does not match
 	 * number of characters reported by readlink(2) which apparently some
@@ -152,8 +152,8 @@ static int udf_symlink_getattr(struct mnt_idmap *idmap,
 	 * let's report the length of string returned by readlink(2) for
 	 * st_size.
 	 */
-	stat->size = strlen(page_address(page));
-	put_page(page);
+	stat->size = strlen(folio_address(folio));
+	folio_put(folio);
 
 	return 0;
 }
-- 
2.43.0


