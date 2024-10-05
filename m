Return-Path: <linux-fsdevel+bounces-31067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFD2991927
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 20:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FC1282FB8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 18:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D5D15A84D;
	Sat,  5 Oct 2024 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DQ6Xd5ZJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A97B25777
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Oct 2024 18:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728151347; cv=none; b=E2Gg3waJjgKW3Vlm11vB363bGoLMZOkPaY9LWdgawgZtfVevEP3Lte8Rj82yGb/HT7Xmc66SRK3fytD0UhbAs+GO1p5wMGkVQAnVPUGRES0loa9jdFodnEuZq58abvAA1A38QRWZjLkhYp0P5y6eyawUilS9+tuxmveaEa3SM6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728151347; c=relaxed/simple;
	bh=xr3WTDE8Jzv9iHD3GzuSA8kDc08NZjDpgnfQplLZH8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9fhcJIrNPW88QY36oLNDxS7CVJl6tEOzgs2U/+m712JYtXAZVOAW+aPi+PgCITAYPalXS6/nXtr+QLzOULjSr2vlvf4OCMnNV6kAd0pu4Tbjp+y9tJi9yr2dSre6uqNTKRzDenYT1p3WEaeY6jP+BCWIr1DXaOtzN97Ar3FqYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DQ6Xd5ZJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=4BdRuetzXnT7AY6jjsMZNuMTqbIN3zM+26SdswZP6vY=; b=DQ6Xd5ZJYJ8gXjkboid199Sf32
	OcNXvYZ+BL96sbcdCJEfVV6AMb30VNKpPVk+cBO7JOSKGSQS+0XrHqeJAI5dZskKJf7N/myysa4dx
	3Xe00LQTJqoiYFwuiF/bmLx9fSWgKTIpHQ6dzQVk0mEQGXWXqSHVmn8wYWrwt/47Nxyg2Kk4ktJf8
	gZ1C2t8hu3XczKGhz9uij48JM/xJDywR0ADMfl15stNDQiawLlWnbxQfuS3XbYvqOtMpRJepqidDA
	JyAVlH/dZjTJgP81cmylPYyutbtpOVCoc6K+JSJXpBN3pQ/vDqxsrug4wrHu0jVBXujiHSfwSPdxt
	DAd25OkQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sx96f-0000000DLlQ-34sx;
	Sat, 05 Oct 2024 18:02:17 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/5] ufs: Convert ufs_inode_getfrag() to take a folio
Date: Sat,  5 Oct 2024 19:02:06 +0100
Message-ID: <20241005180214.3181728-4-willy@infradead.org>
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
 fs/ufs/inode.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index 937d3b787d1e..a2be1bd301ee 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -252,10 +252,9 @@ ufs_extend_tail(struct inode *inode, u64 writes_to,
  * @new: we set it if we allocate new block
  * @locked_page: for ufs_new_fragments()
  */
-static u64
-ufs_inode_getfrag(struct inode *inode, unsigned index,
+static u64 ufs_inode_getfrag(struct inode *inode, unsigned index,
 		  sector_t new_fragment, int *err,
-		  int *new, struct page *locked_page)
+		  int *new, struct folio *locked_folio)
 {
 	struct ufs_inode_info *ufsi = UFS_I(inode);
 	struct super_block *sb = inode->i_sb;
@@ -288,7 +287,7 @@ ufs_inode_getfrag(struct inode *inode, unsigned index,
 			goal += uspi->s_fpb;
 	}
 	tmp = ufs_new_fragments(inode, p, ufs_blknum(new_fragment),
-				goal, nfrags, err, locked_page);
+				goal, nfrags, err, &locked_folio->page);
 
 	if (!tmp) {
 		*err = -ENOSPC;
@@ -440,7 +439,7 @@ static int ufs_getfrag_block(struct inode *inode, sector_t fragment, struct buff
 
 	if (depth == 1) {
 		phys64 = ufs_inode_getfrag(inode, offsets[0], fragment,
-					   &err, &new, bh_result->b_page);
+					   &err, &new, bh_result->b_folio);
 	} else {
 		int i;
 		phys64 = ufs_inode_getfrag(inode, offsets[0], fragment,
-- 
2.43.0


