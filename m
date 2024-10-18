Return-Path: <linux-fsdevel+bounces-32400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DA69A49F1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 01:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D6BEB21A6F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 23:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207CB190664;
	Fri, 18 Oct 2024 23:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hKMgt7Y/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D6318FDA6
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 23:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293562; cv=none; b=OVWKT7Me2l/EO78s3myhw1uIjrCCzs15/n0RFOTdPDJiNOZPkyNOBOYfravblaD5ywabN7N2mkJ+lJwfG+kZggYtCKUW4iKe9O58djBZ1yGSJ80ajETB2SJ9iBNqlsTEc9PJ9ldf4pSF4c/uW5PfuHGLTzWDEIbUJcUhzZ+yr+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293562; c=relaxed/simple;
	bh=XOnVHF6dXO3Ivt2gd0u6OrKU8qrlT8bgdpFkoozptUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HCdy25T/8Em4kU/MS8cRJUpUROZ3t0tV+9jBtX3kO+TSmLIU2kZJNfN4rYDeML3tXWO5KlrCLHlyaSZybLFqq8lwcoWyl4vPQxs2eIVyk/CNFIv0yvZohZQYHNKdlZnF5iwRRf75ic4+oiAOLRR1tNlXmx/7oKwUegDaZ74c08E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hKMgt7Y/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gpcfBgA2ce/B4YO54z7L3tTLaHGnCVJmJuXYnYqg95k=; b=hKMgt7Y/G8mwR0GNvsRaSei7ra
	BsrDh4zHFhIleq6Mp92je7FRb0360Xh1fQcmdez5snwdWm/gkyFd/VpERAPrR+a7G8Bjkhj0GLVAR
	AflKhie9oOQrJA4zGM8gMdoSU1YWWy9qEpw5m4j6mOR7xF/F8kZr1hwASGsL/jvDvwxoGjsUaThb1
	Pdu6sP02jGmVORStTgMHfgTN698kFzaZYe5FoTH7XxrPjA9RIulD3AlNc/tDNY8tjbJFGb+s3NQc4
	Dd9Qn0WMUKGPSuu81ZTyFvjTZhIHHdjxliCczawA1sdSjOmUbzS6apPQdQavLdUtYOG/h2Jubt5Pc
	i6Go17qw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1wFZ-00000005E6Z-1DMm;
	Fri, 18 Oct 2024 23:19:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Evgeniy Dushistov <dushistov@mail.ru>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 05/17] ufs: untangle ubh_...block...(), part 2
Date: Sat, 19 Oct 2024 00:19:04 +0100
Message-ID: <20241018231916.1245836-5-viro@zeniv.linux.org.uk>
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

pass cylinder group descriptor instead of its buffer head (ubh,
always UCPI_UBH(ucpi)) and its ->c_freeoff.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ufs/balloc.c | 10 +++++-----
 fs/ufs/util.h   | 16 +++++++++++-----
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/ufs/balloc.c b/fs/ufs/balloc.c
index e412ddcfda03..d76c04fbd4fa 100644
--- a/fs/ufs/balloc.c
+++ b/fs/ufs/balloc.c
@@ -95,7 +95,7 @@ void ufs_free_fragments(struct inode *inode, u64 fragment, unsigned count)
 	 * Trying to reassemble free fragments into block
 	 */
 	blkno = ufs_fragstoblks (bbase);
-	if (ubh_isblockset(uspi, UCPI_UBH(ucpi), ucpi->c_freeoff, blkno)) {
+	if (ubh_isblockset(uspi, ucpi, blkno)) {
 		fs32_sub(sb, &ucg->cg_cs.cs_nffree, uspi->s_fpb);
 		uspi->cs_total.cs_nffree -= uspi->s_fpb;
 		fs32_sub(sb, &UFS_SB(sb)->fs_cs(cgno).cs_nffree, uspi->s_fpb);
@@ -182,10 +182,10 @@ void ufs_free_blocks(struct inode *inode, u64 fragment, unsigned count)
 
 	for (i = bit; i < end_bit; i += uspi->s_fpb) {
 		blkno = ufs_fragstoblks(i);
-		if (ubh_isblockset(uspi, UCPI_UBH(ucpi), ucpi->c_freeoff, blkno)) {
+		if (ubh_isblockset(uspi, ucpi, blkno)) {
 			ufs_error(sb, "ufs_free_blocks", "freeing free fragment");
 		}
-		ubh_setblock(uspi, UCPI_UBH(ucpi), ucpi->c_freeoff, blkno);
+		ubh_setblock(uspi, ucpi, blkno);
 		inode_sub_bytes(inode, uspi->s_fpb << uspi->s_fshift);
 		if ((UFS_SB(sb)->s_flags & UFS_CG_MASK) == UFS_CG_44BSD)
 			ufs_clusteracct (sb, ucpi, blkno, 1);
@@ -716,7 +716,7 @@ static u64 ufs_alloccg_block(struct inode *inode,
 	/*
 	 * If the requested block is available, use it.
 	 */
-	if (ubh_isblockset(uspi, UCPI_UBH(ucpi), ucpi->c_freeoff, ufs_fragstoblks(goal))) {
+	if (ubh_isblockset(uspi, ucpi, ufs_fragstoblks(goal))) {
 		result = goal;
 		goto gotit;
 	}
@@ -730,7 +730,7 @@ static u64 ufs_alloccg_block(struct inode *inode,
 	if (!try_add_frags(inode, uspi->s_fpb))
 		return 0;
 	blkno = ufs_fragstoblks(result);
-	ubh_clrblock(uspi, UCPI_UBH(ucpi), ucpi->c_freeoff, blkno);
+	ubh_clrblock(uspi, ucpi, blkno);
 	if ((UFS_SB(sb)->s_flags & UFS_CG_MASK) == UFS_CG_44BSD)
 		ufs_clusteracct (sb, ucpi, blkno, -1);
 
diff --git a/fs/ufs/util.h b/fs/ufs/util.h
index 729bc55398f2..c7196a81fb0d 100644
--- a/fs/ufs/util.h
+++ b/fs/ufs/util.h
@@ -455,9 +455,11 @@ static inline unsigned _ubh_find_last_zero_bit_(
 	return (base << uspi->s_bpfshift) + pos - begin;
 } 	
 
-static inline int ubh_isblockset(struct ufs_sb_private_info * uspi,
-	struct ufs_buffer_head * ubh, unsigned begin, unsigned block)
+static inline int ubh_isblockset(struct ufs_sb_private_info *uspi,
+	struct ufs_cg_private_info *ucpi, unsigned block)
 {
+	struct ufs_buffer_head *ubh = UCPI_UBH(ucpi);
+	unsigned begin = ucpi->c_freeoff;
 	u8 mask;
 	switch (uspi->s_fpb) {
 	case 8:
@@ -475,9 +477,11 @@ static inline int ubh_isblockset(struct ufs_sb_private_info * uspi,
 	return 0;	
 }
 
-static inline void ubh_clrblock(struct ufs_sb_private_info * uspi,
-	struct ufs_buffer_head * ubh, unsigned begin, unsigned block)
+static inline void ubh_clrblock(struct ufs_sb_private_info *uspi,
+	struct ufs_cg_private_info *ucpi, unsigned block)
 {
+	struct ufs_buffer_head *ubh = UCPI_UBH(ucpi);
+	unsigned begin = ucpi->c_freeoff;
 	switch (uspi->s_fpb) {
 	case 8:
 	    	*ubh_get_addr (ubh, begin + block) = 0x00;
@@ -495,8 +499,10 @@ static inline void ubh_clrblock(struct ufs_sb_private_info * uspi,
 }
 
 static inline void ubh_setblock(struct ufs_sb_private_info * uspi,
-	struct ufs_buffer_head * ubh, unsigned begin, unsigned block)
+	struct ufs_cg_private_info *ucpi, unsigned block)
 {
+	struct ufs_buffer_head *ubh = UCPI_UBH(ucpi);
+	unsigned begin = ucpi->c_freeoff;
 	switch (uspi->s_fpb) {
 	case 8:
 	    	*ubh_get_addr(ubh, begin + block) = 0xff;
-- 
2.39.5


