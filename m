Return-Path: <linux-fsdevel+bounces-32392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16CA9A49EA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 01:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B02A283CC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 23:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E211922E2;
	Fri, 18 Oct 2024 23:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Fmg4tNo+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A30190075
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 23:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293561; cv=none; b=u3Qa6MmBbrQkDlKLumDVNFqH7HVhGDSo8Vk9TeFGNBqiHcrgEN+mT8lQd3tCL2YgwrTeXCseiezVvmS33WCP0kQ1cu3HroVFO6KDrEmx9m4yeGiA0an7WpzNJ28Dbo0CA7rAfrdsgBaR6a2san0qXfZ27ruKl3Ih6cNY9S8rXG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293561; c=relaxed/simple;
	bh=oHI06Ef7DuHMnQqXn8oti1fQJix3NS7BoFW99d0Dl5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0C6QMNIJ8ReTUwdnbuxgkb4Y4QB7RHMuvfPns+MPQQ1oO1gY9XlQtzXSCNvoSaNVXeMUl/6SLaU/q7uFDvw0+088/rv1Pjmrhw2WHeSqih16jaMB6+ZySUbmSzPzLsqGblL4RDvoDewqZzFtanXt4247cFcSnuLjJk+XeFDO+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Fmg4tNo+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=esmyTWgXte12JiQAycTnydBVMov49q4rLLuz+63PTQA=; b=Fmg4tNo+u/BPkyMZbwqURVjcgc
	JXQuRibjbMqWxObZndl/drRF9tYxfd6/kv8e2pQbSG6oRpAMm5CkyN8awLs6hGI4Eb+vB3mUC+Rjt
	JtoCWmmP/xMjMMNp8zHg09puMzXjmnNJyPibIcrN5sRRd4e78+hHrglvFy2qW5cHwPEhdM8XIKf7/
	kIdtMtqM0mCsMU8EiJUloAiZG8wsdGBLdDFniVWQ7gSaQCWNu3/P1U3G09sp9Yk1P/HOFMUEQPKtX
	lpad0JjPVHHW9FMguwEt/2R7t/F55gi68mJLPB8M1ukqHmq78DvUT1VlrKmpiw+fmtoPpmSGWG+el
	MNgYNppA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1wFZ-00000005E6f-1XON;
	Fri, 18 Oct 2024 23:19:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Evgeniy Dushistov <dushistov@mail.ru>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 06/17] ufs: untangle ubh_...block...(), part 3
Date: Sat, 19 Oct 2024 00:19:05 +0100
Message-ID: <20241018231916.1245836-6-viro@zeniv.linux.org.uk>
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

Pass fragment number instead of a block one.  It's available in all
callers and it makes the logics inside those helpers much simpler.
The bitmap they operate upon is with bit per fragment, block being
an aligned group of 1, 2, 4 or 8 adjacent fragments.  We still
need a switch by the number of fragments in block (== number of
bits to check/set/clear), but finding the byte we need to work
with becomes uniform and that makes the things easier to follow.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ufs/balloc.c | 10 +++++-----
 fs/ufs/util.h   | 45 ++++++++++++++++++++++++---------------------
 2 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/fs/ufs/balloc.c b/fs/ufs/balloc.c
index d76c04fbd4fa..7694666fac18 100644
--- a/fs/ufs/balloc.c
+++ b/fs/ufs/balloc.c
@@ -95,7 +95,7 @@ void ufs_free_fragments(struct inode *inode, u64 fragment, unsigned count)
 	 * Trying to reassemble free fragments into block
 	 */
 	blkno = ufs_fragstoblks (bbase);
-	if (ubh_isblockset(uspi, ucpi, blkno)) {
+	if (ubh_isblockset(uspi, ucpi, bbase)) {
 		fs32_sub(sb, &ucg->cg_cs.cs_nffree, uspi->s_fpb);
 		uspi->cs_total.cs_nffree -= uspi->s_fpb;
 		fs32_sub(sb, &UFS_SB(sb)->fs_cs(cgno).cs_nffree, uspi->s_fpb);
@@ -182,10 +182,10 @@ void ufs_free_blocks(struct inode *inode, u64 fragment, unsigned count)
 
 	for (i = bit; i < end_bit; i += uspi->s_fpb) {
 		blkno = ufs_fragstoblks(i);
-		if (ubh_isblockset(uspi, ucpi, blkno)) {
+		if (ubh_isblockset(uspi, ucpi, i)) {
 			ufs_error(sb, "ufs_free_blocks", "freeing free fragment");
 		}
-		ubh_setblock(uspi, ucpi, blkno);
+		ubh_setblock(uspi, ucpi, i);
 		inode_sub_bytes(inode, uspi->s_fpb << uspi->s_fshift);
 		if ((UFS_SB(sb)->s_flags & UFS_CG_MASK) == UFS_CG_44BSD)
 			ufs_clusteracct (sb, ucpi, blkno, 1);
@@ -716,7 +716,7 @@ static u64 ufs_alloccg_block(struct inode *inode,
 	/*
 	 * If the requested block is available, use it.
 	 */
-	if (ubh_isblockset(uspi, ucpi, ufs_fragstoblks(goal))) {
+	if (ubh_isblockset(uspi, ucpi, goal)) {
 		result = goal;
 		goto gotit;
 	}
@@ -730,7 +730,7 @@ static u64 ufs_alloccg_block(struct inode *inode,
 	if (!try_add_frags(inode, uspi->s_fpb))
 		return 0;
 	blkno = ufs_fragstoblks(result);
-	ubh_clrblock(uspi, ucpi, blkno);
+	ubh_clrblock(uspi, ucpi, result);
 	if ((UFS_SB(sb)->s_flags & UFS_CG_MASK) == UFS_CG_44BSD)
 		ufs_clusteracct (sb, ucpi, blkno, -1);
 
diff --git a/fs/ufs/util.h b/fs/ufs/util.h
index c7196a81fb0d..fafae166ee55 100644
--- a/fs/ufs/util.h
+++ b/fs/ufs/util.h
@@ -456,65 +456,68 @@ static inline unsigned _ubh_find_last_zero_bit_(
 } 	
 
 static inline int ubh_isblockset(struct ufs_sb_private_info *uspi,
-	struct ufs_cg_private_info *ucpi, unsigned block)
+	struct ufs_cg_private_info *ucpi, unsigned int frag)
 {
 	struct ufs_buffer_head *ubh = UCPI_UBH(ucpi);
-	unsigned begin = ucpi->c_freeoff;
+	u8 *p = ubh_get_addr(ubh, ucpi->c_freeoff + (frag >> 3));
 	u8 mask;
+
 	switch (uspi->s_fpb) {
 	case 8:
-	    	return (*ubh_get_addr (ubh, begin + block) == 0xff);
+		return *p == 0xff;
 	case 4:
-		mask = 0x0f << ((block & 0x01) << 2);
-		return (*ubh_get_addr (ubh, begin + (block >> 1)) & mask) == mask;
+		mask = 0x0f << (frag & 4);
+		return (*p & mask) == mask;
 	case 2:
-		mask = 0x03 << ((block & 0x03) << 1);
-		return (*ubh_get_addr (ubh, begin + (block >> 2)) & mask) == mask;
+		mask = 0x03 << (frag & 6);
+		return (*p & mask) == mask;
 	case 1:
-		mask = 0x01 << (block & 0x07);
-		return (*ubh_get_addr (ubh, begin + (block >> 3)) & mask) == mask;
+		mask = 0x01 << (frag & 7);
+		return (*p & mask) == mask;
 	}
 	return 0;	
 }
 
 static inline void ubh_clrblock(struct ufs_sb_private_info *uspi,
-	struct ufs_cg_private_info *ucpi, unsigned block)
+	struct ufs_cg_private_info *ucpi, unsigned int frag)
 {
 	struct ufs_buffer_head *ubh = UCPI_UBH(ucpi);
-	unsigned begin = ucpi->c_freeoff;
+	u8 *p = ubh_get_addr(ubh, ucpi->c_freeoff + (frag >> 3));
+
 	switch (uspi->s_fpb) {
 	case 8:
-	    	*ubh_get_addr (ubh, begin + block) = 0x00;
+		*p = 0x00;
 	    	return; 
 	case 4:
-		*ubh_get_addr (ubh, begin + (block >> 1)) &= ~(0x0f << ((block & 0x01) << 2));
+		*p &= ~(0x0f << (frag & 4));
 		return;
 	case 2:
-		*ubh_get_addr (ubh, begin + (block >> 2)) &= ~(0x03 << ((block & 0x03) << 1));
+		*p &= ~(0x03 << (frag & 6));
 		return;
 	case 1:
-		*ubh_get_addr (ubh, begin + (block >> 3)) &= ~(0x01 << ((block & 0x07)));
+		*p &= ~(0x01 << (frag & 7));
 		return;
 	}
 }
 
 static inline void ubh_setblock(struct ufs_sb_private_info * uspi,
-	struct ufs_cg_private_info *ucpi, unsigned block)
+	struct ufs_cg_private_info *ucpi, unsigned int frag)
 {
 	struct ufs_buffer_head *ubh = UCPI_UBH(ucpi);
-	unsigned begin = ucpi->c_freeoff;
+	u8 *p = ubh_get_addr(ubh, ucpi->c_freeoff + (frag >> 3));
+
 	switch (uspi->s_fpb) {
 	case 8:
-	    	*ubh_get_addr(ubh, begin + block) = 0xff;
+		*p = 0xff;
 	    	return;
 	case 4:
-		*ubh_get_addr(ubh, begin + (block >> 1)) |= (0x0f << ((block & 0x01) << 2));
+		*p |= 0x0f << (frag & 4);
 		return;
 	case 2:
-		*ubh_get_addr(ubh, begin + (block >> 2)) |= (0x03 << ((block & 0x03) << 1));
+		*p |= 0x03 << (frag & 6);
 		return;
 	case 1:
-		*ubh_get_addr(ubh, begin + (block >> 3)) |= (0x01 << ((block & 0x07)));
+		*p |= 0x01 << (frag & 7);
 		return;
 	}
 }
-- 
2.39.5


