Return-Path: <linux-fsdevel+bounces-32389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6105B9A49E7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 01:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00A19B21578
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 23:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765601917D6;
	Fri, 18 Oct 2024 23:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Qsc8nfQS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22EC18FDD0
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 23:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293560; cv=none; b=JSeYriMc62jTSqRmZi0/r3GDwnLD7g2T+tEYiAoBH/85oWI8UbCqZVj9xiw8H+5hcco6sy8ucrTBdQ05ScuCMO8S19gwDGpQ975D7cDr0qPd87XJDJcV3bIfIX+Xqq/Bc8l79+xMKql8tsei9B9tXDVmdA1ySEysOFwlkU/ei/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293560; c=relaxed/simple;
	bh=LVL1SIFsrRb3myZu7jZVuO4YtYbDRR9fVyesr0H6z6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rhot52Ezmiu9Yy3hsmfL0jGunbonw2lVQh0GOyq7WK+vXTuskWG5aHvvhgUwWpDNaEScyMKdLjV1Pzv6hjyWSA6wYl2Wi4Bc5jdiol6KyuICmapfXXh+lQqekYp/kEQnImbrtUTNQg9dTSCw40QculTKROCVcpQZm1IahiF+GiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Qsc8nfQS; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=FbKNCmg51RM/Chun+chAXCK0MwTsqATxRI8ATuhBYjw=; b=Qsc8nfQS2jv2mTJGh2DGJSFP5E
	yhdjzB8ROBI7Yz/vbkEQPIpDDPUoAJPdILCa6vJ7cgvOOsN9uDOl1g+EZ9uPfqnhNNEe7Q8g/8Y5y
	yrCb9/QL/YX9yX7cGQPgDfeccG6cstJxzF557LRvpCI602qfZQ7+3xMcUPIXO3uIoNgfrjSZCRtPF
	zosalo8gOPfFzHQ5x8K2H15QpLhZhQrvyxt+5glVHCs73m0wNTR3ZPHlUY8cBR8TTqyRUro0btkTV
	IetF5SiGRdlb2lziMfjHXEMFz6FxFykKHOwFA6gZWI3KkIHdBe8uRse7hWRJK7Ohma5dLJo04avT4
	KIwh6sYg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1wFZ-00000005E6l-1tm1;
	Fri, 18 Oct 2024 23:19:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Evgeniy Dushistov <dushistov@mail.ru>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 07/17] ufs_clusteracct(): switch to passing fragment number
Date: Sat, 19 Oct 2024 00:19:06 +0100
Message-ID: <20241018231916.1245836-7-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018231916.1245836-1-viro@zeniv.linux.org.uk>
References: <20241018231428.GC1172273@ZenIV>
 <20241018231916.1245836-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Currently all callers pass it a block number.  All of them have it derived
from a fragment number (both fragment and block numbers are within a cylinder
group, and thus 32bit).  Pass it the fragment number instead; none of the
callers has other uses for the block number, so that ends up with cleaner
code.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ufs/balloc.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/ufs/balloc.c b/fs/ufs/balloc.c
index 7694666fac18..1793ce48df0a 100644
--- a/fs/ufs/balloc.c
+++ b/fs/ufs/balloc.c
@@ -43,7 +43,6 @@ void ufs_free_fragments(struct inode *inode, u64 fragment, unsigned count)
 	struct ufs_cg_private_info * ucpi;
 	struct ufs_cylinder_group * ucg;
 	unsigned cgno, bit, end_bit, bbase, blkmap, i;
-	u64 blkno;
 	
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
@@ -94,13 +93,12 @@ void ufs_free_fragments(struct inode *inode, u64 fragment, unsigned count)
 	/*
 	 * Trying to reassemble free fragments into block
 	 */
-	blkno = ufs_fragstoblks (bbase);
 	if (ubh_isblockset(uspi, ucpi, bbase)) {
 		fs32_sub(sb, &ucg->cg_cs.cs_nffree, uspi->s_fpb);
 		uspi->cs_total.cs_nffree -= uspi->s_fpb;
 		fs32_sub(sb, &UFS_SB(sb)->fs_cs(cgno).cs_nffree, uspi->s_fpb);
 		if ((UFS_SB(sb)->s_flags & UFS_CG_MASK) == UFS_CG_44BSD)
-			ufs_clusteracct (sb, ucpi, blkno, 1);
+			ufs_clusteracct(sb, ucpi, bbase, 1);
 		fs32_add(sb, &ucg->cg_cs.cs_nbfree, 1);
 		uspi->cs_total.cs_nbfree++;
 		fs32_add(sb, &UFS_SB(sb)->fs_cs(cgno).cs_nbfree, 1);
@@ -139,7 +137,6 @@ void ufs_free_blocks(struct inode *inode, u64 fragment, unsigned count)
 	struct ufs_cg_private_info * ucpi;
 	struct ufs_cylinder_group * ucg;
 	unsigned overflow, cgno, bit, end_bit, i;
-	u64 blkno;
 	
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
@@ -181,14 +178,13 @@ void ufs_free_blocks(struct inode *inode, u64 fragment, unsigned count)
 	}
 
 	for (i = bit; i < end_bit; i += uspi->s_fpb) {
-		blkno = ufs_fragstoblks(i);
 		if (ubh_isblockset(uspi, ucpi, i)) {
 			ufs_error(sb, "ufs_free_blocks", "freeing free fragment");
 		}
 		ubh_setblock(uspi, ucpi, i);
 		inode_sub_bytes(inode, uspi->s_fpb << uspi->s_fshift);
 		if ((UFS_SB(sb)->s_flags & UFS_CG_MASK) == UFS_CG_44BSD)
-			ufs_clusteracct (sb, ucpi, blkno, 1);
+			ufs_clusteracct(sb, ucpi, i, 1);
 
 		fs32_add(sb, &ucg->cg_cs.cs_nbfree, 1);
 		uspi->cs_total.cs_nbfree++;
@@ -698,7 +694,7 @@ static u64 ufs_alloccg_block(struct inode *inode,
 	struct super_block * sb;
 	struct ufs_sb_private_info * uspi;
 	struct ufs_cylinder_group * ucg;
-	u64 result, blkno;
+	u64 result;
 
 	UFSD("ENTER, goal %llu\n", (unsigned long long)goal);
 
@@ -729,10 +725,9 @@ static u64 ufs_alloccg_block(struct inode *inode,
 gotit:
 	if (!try_add_frags(inode, uspi->s_fpb))
 		return 0;
-	blkno = ufs_fragstoblks(result);
 	ubh_clrblock(uspi, ucpi, result);
 	if ((UFS_SB(sb)->s_flags & UFS_CG_MASK) == UFS_CG_44BSD)
-		ufs_clusteracct (sb, ucpi, blkno, -1);
+		ufs_clusteracct(sb, ucpi, result, -1);
 
 	fs32_sub(sb, &ucg->cg_cs.cs_nbfree, 1);
 	uspi->cs_total.cs_nbfree--;
@@ -863,12 +858,12 @@ static u64 ufs_bitmap_search(struct super_block *sb,
 }
 
 static void ufs_clusteracct(struct super_block * sb,
-	struct ufs_cg_private_info * ucpi, unsigned blkno, int cnt)
+	struct ufs_cg_private_info * ucpi, unsigned frag, int cnt)
 {
-	struct ufs_sb_private_info * uspi;
+	struct ufs_sb_private_info * uspi = UFS_SB(sb)->s_uspi;
 	int i, start, end, forw, back;
+	unsigned blkno = ufs_fragstoblks(frag);
 	
-	uspi = UFS_SB(sb)->s_uspi;
 	if (uspi->s_contigsumsize <= 0)
 		return;
 
-- 
2.39.5


