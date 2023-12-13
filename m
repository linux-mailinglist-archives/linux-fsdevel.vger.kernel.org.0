Return-Path: <linux-fsdevel+bounces-5792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0907F8108A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 04:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B91E628239E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 03:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55010C154;
	Wed, 13 Dec 2023 03:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SLKtX9AB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F906D0
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 19:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=QAtV5tuB+Me1ccSVI1rSQgNFnTQhTkww+CkbPrd5hj4=; b=SLKtX9ABL/QWMalpur75MJI0nu
	QjR32vr8NC4uVRd/5YlOPksm3xg5gYA7X3fch1YqrXfwno+/DSr2WvGh0N3I937hn4HXM8bKuVV2k
	xxQPQX/So1P7NFb4CdjVtpdTTG0RuXK3JoV0WyaC2ZZdjtuyOJKoNgxZKsLb0+OtdYR8OwSvY89SR
	efjZ1LJwoHXZ36COEKBITDw+ITSJY1KhsIu1sOycMXHUgrz0gxMH7BFFeIdVx7GAtpIsdCZUVdwlS
	N+0QdEBC3hWuRucBwN3QSqan0T3KaU/WosQTQfLRivcZYy8I9pU/q+4Rv4Fo9cJ8KRw1gLhLFN+E4
	F8mqWZTA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDFlV-00Bby9-0D;
	Wed, 13 Dec 2023 03:18:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Evgeniy Dushistov <dushistov@mail.ru>,
	"Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 08/12] ufs: untangle ubh_...block...(), part 3
Date: Wed, 13 Dec 2023 03:18:23 +0000
Message-Id: <20231213031827.2767531-8-viro@zeniv.linux.org.uk>
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
index 89c890b5c54d..6fff3da93a66 100644
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
2.39.2


