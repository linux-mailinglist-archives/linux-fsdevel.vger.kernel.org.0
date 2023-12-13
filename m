Return-Path: <linux-fsdevel+bounces-5791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074E98108A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 04:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B086B282333
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 03:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF86BE72;
	Wed, 13 Dec 2023 03:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZjCv3OKj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E207CA
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 19:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=s8HNLzILHg37bTX0xFxBYp9QuUN74TbeU3F3jc3e1ms=; b=ZjCv3OKjDnmqAMDVKcEUtFKoQx
	HwyIn5p1t4JCtzNPVm22lAWRmuGMbuM0LK0IsZlPRCSHiSqtf2ElyQec+9wilghGwAZ3Ssb3nyOoy
	tIPOMyDxXZcFVTA8hKn/zzGqHp3FOnZGqLgoGxqArS0LtdqeLTX3JLVNhDwcapRE/hnG25EdkybZM
	QhYwsl4pWxeB1pbhoSU59E7VL97XLoNIMQsJz0fMzqCK1RRjDsgfBNXvluQaN9Q9klSfBtKxsM8SN
	qwqdXt8aAeybVFnoN+xdMyV1LeOqb63Ibk6FSa+GuRzgEsN2k4R1hlD9O1AhN97Xh8nomjM/7SKkg
	wfaJjaaA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDFlU-00Bby1-2W;
	Wed, 13 Dec 2023 03:18:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Evgeniy Dushistov <dushistov@mail.ru>,
	"Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 06/12] ufs: untangle ubh_...block...() macros, part 1
Date: Wed, 13 Dec 2023 03:18:21 +0000
Message-Id: <20231213031827.2767531-6-viro@zeniv.linux.org.uk>
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

passing implicit argument to a macro by having it in a variable
with special name is Not Nice(tm); just pass it explicitly.

kill an unused macro, while we are at it...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ufs/balloc.c | 10 +++++-----
 fs/ufs/util.h   | 11 +++--------
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/fs/ufs/balloc.c b/fs/ufs/balloc.c
index 53c11be2b2c1..e412ddcfda03 100644
--- a/fs/ufs/balloc.c
+++ b/fs/ufs/balloc.c
@@ -95,7 +95,7 @@ void ufs_free_fragments(struct inode *inode, u64 fragment, unsigned count)
 	 * Trying to reassemble free fragments into block
 	 */
 	blkno = ufs_fragstoblks (bbase);
-	if (ubh_isblockset(UCPI_UBH(ucpi), ucpi->c_freeoff, blkno)) {
+	if (ubh_isblockset(uspi, UCPI_UBH(ucpi), ucpi->c_freeoff, blkno)) {
 		fs32_sub(sb, &ucg->cg_cs.cs_nffree, uspi->s_fpb);
 		uspi->cs_total.cs_nffree -= uspi->s_fpb;
 		fs32_sub(sb, &UFS_SB(sb)->fs_cs(cgno).cs_nffree, uspi->s_fpb);
@@ -182,10 +182,10 @@ void ufs_free_blocks(struct inode *inode, u64 fragment, unsigned count)
 
 	for (i = bit; i < end_bit; i += uspi->s_fpb) {
 		blkno = ufs_fragstoblks(i);
-		if (ubh_isblockset(UCPI_UBH(ucpi), ucpi->c_freeoff, blkno)) {
+		if (ubh_isblockset(uspi, UCPI_UBH(ucpi), ucpi->c_freeoff, blkno)) {
 			ufs_error(sb, "ufs_free_blocks", "freeing free fragment");
 		}
-		ubh_setblock(UCPI_UBH(ucpi), ucpi->c_freeoff, blkno);
+		ubh_setblock(uspi, UCPI_UBH(ucpi), ucpi->c_freeoff, blkno);
 		inode_sub_bytes(inode, uspi->s_fpb << uspi->s_fshift);
 		if ((UFS_SB(sb)->s_flags & UFS_CG_MASK) == UFS_CG_44BSD)
 			ufs_clusteracct (sb, ucpi, blkno, 1);
@@ -716,7 +716,7 @@ static u64 ufs_alloccg_block(struct inode *inode,
 	/*
 	 * If the requested block is available, use it.
 	 */
-	if (ubh_isblockset(UCPI_UBH(ucpi), ucpi->c_freeoff, ufs_fragstoblks(goal))) {
+	if (ubh_isblockset(uspi, UCPI_UBH(ucpi), ucpi->c_freeoff, ufs_fragstoblks(goal))) {
 		result = goal;
 		goto gotit;
 	}
@@ -730,7 +730,7 @@ static u64 ufs_alloccg_block(struct inode *inode,
 	if (!try_add_frags(inode, uspi->s_fpb))
 		return 0;
 	blkno = ufs_fragstoblks(result);
-	ubh_clrblock (UCPI_UBH(ucpi), ucpi->c_freeoff, blkno);
+	ubh_clrblock(uspi, UCPI_UBH(ucpi), ucpi->c_freeoff, blkno);
 	if ((UFS_SB(sb)->s_flags & UFS_CG_MASK) == UFS_CG_44BSD)
 		ufs_clusteracct (sb, ucpi, blkno, -1);
 
diff --git a/fs/ufs/util.h b/fs/ufs/util.h
index 0ecd2ed792f5..dc3240f0ddea 100644
--- a/fs/ufs/util.h
+++ b/fs/ufs/util.h
@@ -455,10 +455,7 @@ static inline unsigned _ubh_find_last_zero_bit_(
 	return (base << uspi->s_bpfshift) + pos - begin;
 } 	
 
-#define ubh_isblockclear(ubh,begin,block) (!_ubh_isblockset_(uspi,ubh,begin,block))
-
-#define ubh_isblockset(ubh,begin,block) _ubh_isblockset_(uspi,ubh,begin,block)
-static inline int _ubh_isblockset_(struct ufs_sb_private_info * uspi,
+static inline int ubh_isblockset(struct ufs_sb_private_info * uspi,
 	struct ufs_buffer_head * ubh, unsigned begin, unsigned block)
 {
 	u8 mask;
@@ -478,8 +475,7 @@ static inline int _ubh_isblockset_(struct ufs_sb_private_info * uspi,
 	return 0;	
 }
 
-#define ubh_clrblock(ubh,begin,block) _ubh_clrblock_(uspi,ubh,begin,block)
-static inline void _ubh_clrblock_(struct ufs_sb_private_info * uspi,
+static inline void ubh_clrblock(struct ufs_sb_private_info * uspi,
 	struct ufs_buffer_head * ubh, unsigned begin, unsigned block)
 {
 	switch (uspi->s_fpb) {
@@ -498,8 +494,7 @@ static inline void _ubh_clrblock_(struct ufs_sb_private_info * uspi,
 	}
 }
 
-#define ubh_setblock(ubh,begin,block) _ubh_setblock_(uspi,ubh,begin,block)
-static inline void _ubh_setblock_(struct ufs_sb_private_info * uspi,
+static inline void ubh_setblock(struct ufs_sb_private_info * uspi,
 	struct ufs_buffer_head * ubh, unsigned begin, unsigned block)
 {
 	switch (uspi->s_fpb) {
-- 
2.39.2


