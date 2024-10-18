Return-Path: <linux-fsdevel+bounces-32393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 597F39A49E9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 01:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7E21F21290
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 23:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429501922E1;
	Fri, 18 Oct 2024 23:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VL/rlYfi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B032718FC99
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 23:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293561; cv=none; b=sBjB3Y/DSH4OOgbQAYTv7SJ9QwHRDCKK6PrY1RcsGRJDcfxuvsN+DPt9WS3Shlxf+1dmu/Wwej48NBmva9N0wy8FWgtYDGgvJP32sE2hV4Pz43u4d/RNeZe5dr0zkC+7GwC1zkGBP4xIAS2Tgq2m9p1W2JSmLAyjRpiItd7Lzzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293561; c=relaxed/simple;
	bh=o8pSp0IrTxeOo0HjTx22NXnCaZ09CDsUwT6c9lcR71g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNgbfea6v+jC0phubhHLCiALupq2Ho1S0oer1SJkvFGv/eI7Oew/EiVi85LKU+gyQQS6zdcwI800esu+HoRvRPqyu2NOwfi20c9zENDgupwFNdCEow7XQkiIgHHxDbOlcO+6EabpbwFZtYh5KH6dDyzheoPqwygoqOCGUf+b4o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VL/rlYfi; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=z9/oNAMbW15hF3u9s5+Z+RqEND71MHH/NHQbs7zD1UU=; b=VL/rlYfiIsAp2kXDZ8VTAeW6ww
	JkgHipBIWjttWt9WMLvkfjDttDs/FuLHx+DQb0aCWBQzI1+0D4eZR1l3vmLFreTb3qOYcKBNakOQm
	yxpUWglK6q9BEE5MYLKOIrDlk2JSa4YIuewDGDiru53ZxMlBmm+Wk94eP+wa3MXtxaQXSOodTJXHR
	XdbyjGpVBYknPuPM1soCVVX/rDAOut1kqRAmiXDPd+WWznLqweWPQ9P/y1WUYDPbUYYExC7HwSQF2
	o34ZFH/uckzICUWUVqoCNvsS6RPKZhLmVbs+GUfS1OUqOmGaH1e7/UkuL4q45yhW1R5LxkHrNTPvd
	Xhq0EUzw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1wFZ-00000005E6T-0eZ4;
	Fri, 18 Oct 2024 23:19:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Evgeniy Dushistov <dushistov@mail.ru>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 04/17] ufs: untangle ubh_...block...() macros, part 1
Date: Sat, 19 Oct 2024 00:19:03 +0100
Message-ID: <20241018231916.1245836-4-viro@zeniv.linux.org.uk>
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
index bf708b68f150..729bc55398f2 100644
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
2.39.5


