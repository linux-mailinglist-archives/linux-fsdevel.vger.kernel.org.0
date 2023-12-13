Return-Path: <linux-fsdevel+bounces-5795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E307E8108A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 04:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A451F21C02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 03:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB61D295;
	Wed, 13 Dec 2023 03:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VzPMl5HL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E15AD3
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 19:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kg6auRfhHkERnlkL0+KpjMlxek7hUNOXFYFWaJTtzQ0=; b=VzPMl5HLxe+YDqNlADDyiMJszy
	UynBFjoR6vGV083Af67wSe7F+HhFifQG0BvqZWafpnUqxNw+GxT4YiUSXHGe+heu1K7PbnmarVfPY
	dMl8bDOEBgExCkUGTprCgpjuhGRS6o4AvXigUGJfn1tkwxs9EVAdpbMJGOveZo7rPhwxF2IEeFUTS
	TwPr7KZw+A70d/04ylghEshSVuXDVL4I8ZxXj6gxkr7wZ2acSSTrnbTlYpxG1OVcK3LQutCbjVUWm
	vRLFTWvTDBskkYHZUSSyItsyD5PQO2z9IuKU14c6TSzzr9Vzeh026Zo+hG5zFUbuOaDy+cayEBkD4
	A8rbWDlg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDFlV-00BbyD-0g;
	Wed, 13 Dec 2023 03:18:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Evgeniy Dushistov <dushistov@mail.ru>,
	"Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 09/12] ufs_clusteracct(): switch to passing fragment number
Date: Wed, 13 Dec 2023 03:18:24 +0000
Message-Id: <20231213031827.2767531-9-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231213031827.2767531-1-viro@zeniv.linux.org.uk>
References: <20231213031639.GJ1674809@ZenIV>
 <20231213031827.2767531-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

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
2.39.2


