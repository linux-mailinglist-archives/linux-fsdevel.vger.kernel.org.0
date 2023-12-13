Return-Path: <linux-fsdevel+bounces-5793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1F78108A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 04:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B65021F21B4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 03:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AEDC8C8;
	Wed, 13 Dec 2023 03:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="EE+sb2x4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B2ECF
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 19:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=q1e0sVyAULfkcONrOI7pHUW/iSjJQDx0jAb2enWyUV0=; b=EE+sb2x4kEr0CqfZ1jsDK82wcS
	6vFYTg8QX7PJispp5huBHhAC2nQKOIKdsSRMq9ZsP5NSm5v2bORk2wv/OwHQaOQXpBJMtFD6mFm5S
	GiMCLeEdBz4b2oYboEOSgcfOrtQEigZH85n5EUpLZhMxoho+jum2pEKbIXuNppAgVso+CCjc1pN9k
	WDjeqtp7yPT8cyPRzZnFgB1OJtKoPMYoIsMmJGchku9DHr+884/MRCaD9UllA9dVA/pW0ANisTMqq
	3AxXQQWnaMk4yseKzR2AJlpxWR3+EkkRFDjC4RWK24NP8G3KTwHu7kgo02EQoe42o01bcpTE4dPci
	0eHx9TgA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDFlU-00Bby5-2x;
	Wed, 13 Dec 2023 03:18:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Evgeniy Dushistov <dushistov@mail.ru>,
	"Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 07/12] ufs: untangle ubh_...block...(), part 2
Date: Wed, 13 Dec 2023 03:18:22 +0000
Message-Id: <20231213031827.2767531-7-viro@zeniv.linux.org.uk>
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
index dc3240f0ddea..89c890b5c54d 100644
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
2.39.2


