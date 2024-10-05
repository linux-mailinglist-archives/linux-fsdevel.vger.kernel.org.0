Return-Path: <linux-fsdevel+bounces-31069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3864991929
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 20:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B12282CDC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 18:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E0715AADE;
	Sat,  5 Oct 2024 18:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WS37ciV0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83292158DC2
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Oct 2024 18:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728151349; cv=none; b=OGL2zykpHMOXtcOZ05HV3hHndCEZos7p631lIYH5e/DOXd8E8FoAKgT4cCKGZU4pV1K4xPy0EZ1XC+pRvUs6JSrdkBr1dR4yERRDArx76KPgbXKZnJlp+2hoAxvxe/rbzB0/jC+6ykxPxhukL+GV4fQzJfgLgyUeKgqpv/adq1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728151349; c=relaxed/simple;
	bh=PlWCxq6U6xjwTX2JCgCekdY46o3eRorVdLgWcknPces=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0jFO1THTx66MD8YQVpVoGu2PUabCLZPgPye0rGk+dIq0qJMoUxmf24N/LKL87faObwpa8Ou7sLYeOA6diJQDi6JF0JkA7ZegsSRoXFe+YuiNgcIzjWm4POeRX5e+B3RAV6AGIk0uEIm+QmseyB7mMqq406trr/hkp5OpbtdTKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WS37ciV0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=fPKh53M83a7w8zQJie8gJVgmbMJi4dZBW1SxuYASWY0=; b=WS37ciV0iJQuQAstvvx3CbHlXR
	zwKtP+y1jWdWozkusTUk31wll0yLG+u09Hld7L013t8xBW13BqcrSbxG6luTL7Ouk7uifXb+1OIzD
	A0KBgTdp6h5lB/h7i3qS1gNajiOTcSVIhfY9g2zGNhmgdJemhdStWSEaW6NBTGt1D6XDGIlwr+f2U
	+TTYKw1ySreONDacKeGutlWDaMsFqqneCRkC1Z0d9KBJixYHMn3FR9Wg7B2L4bqmDiQuPaZ5Tsrsn
	FE3Nd6EIOdfpTL8yDCPdzz7ciYmSebNgyTB7ZvH8mDWl5RUsHfLxPHlROsrQ8JQXVbInEfVeEvwH/
	p8VvLL2A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sx96f-0000000DLl8-24NF;
	Sat, 05 Oct 2024 18:02:17 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/5] ufs: Convert ufs_inode_getblock() to take a folio
Date: Sat,  5 Oct 2024 19:02:04 +0100
Message-ID: <20241005180214.3181728-2-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241005180214.3181728-1-willy@infradead.org>
References: <20241005180214.3181728-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass bh->b_folio instead of bh->b_page.  They're in a union, so no
code change expected.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ufs/inode.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index 5331ae7ebf3e..aad3bdd4422f 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -329,12 +329,11 @@ ufs_inode_getfrag(struct inode *inode, unsigned index,
  *  (block will hold this fragment and also uspi->s_fpb-1)
  * @err: see ufs_inode_getfrag()
  * @new: see ufs_inode_getfrag()
- * @locked_page: see ufs_inode_getfrag()
+ * @locked_folio: see ufs_inode_getfrag()
  */
-static u64
-ufs_inode_getblock(struct inode *inode, u64 ind_block,
-		  unsigned index, sector_t new_fragment, int *err,
-		  int *new, struct page *locked_page)
+static u64 ufs_inode_getblock(struct inode *inode, u64 ind_block,
+		unsigned index, sector_t new_fragment, int *err,
+		int *new, struct folio *locked_folio)
 {
 	struct super_block *sb = inode->i_sb;
 	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
@@ -369,7 +368,7 @@ ufs_inode_getblock(struct inode *inode, u64 ind_block,
 	else
 		goal = bh->b_blocknr + uspi->s_fpb;
 	tmp = ufs_new_fragments(inode, p, ufs_blknum(new_fragment), goal,
-				uspi->s_fpb, err, locked_page);
+				uspi->s_fpb, err, &locked_folio->page);
 	if (!tmp)
 		goto out;
 
@@ -450,7 +449,7 @@ static int ufs_getfrag_block(struct inode *inode, sector_t fragment, struct buff
 			phys64 = ufs_inode_getblock(inode, phys64, offsets[i],
 						fragment, &err, NULL, NULL);
 		phys64 = ufs_inode_getblock(inode, phys64, offsets[depth - 1],
-					fragment, &err, &new, bh_result->b_page);
+				fragment, &err, &new, bh_result->b_folio);
 	}
 out:
 	if (phys64) {
-- 
2.43.0


