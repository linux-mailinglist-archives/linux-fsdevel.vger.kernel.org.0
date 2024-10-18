Return-Path: <linux-fsdevel+bounces-32402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BE69A49F3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 01:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 188F3B23918
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 23:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3621925B4;
	Fri, 18 Oct 2024 23:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MrvNEuV9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B78190676
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 23:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293563; cv=none; b=URMKX0YsL5Hza71PhzSOH/LUHkBETsGBetvV5qDTV+6rln0S8d6Tl31kH3Kqawe5dEQryORDsyonPVchTRoLqlBRLLwQhepN755TobcgppWKBt5y7ds1lPe2E2JJDY6PkGF2wx6AMQR7oTO6xgpzYdbnq9WjKiMgtuM5qH7lzFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293563; c=relaxed/simple;
	bh=ncS2EwebJwVkIBvupJsgGEkc2PgIQxYVHfAHcAH5kFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3QovUviVh202SBdq/RHuU7osHnZOctkX9vgJLobxyKzTxmHfBuWAKCPvR0JQSagfY2rby58U7O9z1VS/SVN6fx6qpNSPIivB4DKE13saD0TS/fWyiOH+Ure+C8D0VWzsap9LytYwit0VqJud+rGDmzJ1Nhf42vlYgQFpWy7nQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MrvNEuV9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=L3yvI0PxQV2PHgIYlSEX8bt8DFBuH9lu+yPBoVKvTW0=; b=MrvNEuV9mJ5G81eAhVeUVAb3AU
	yVVGOV/L5ylVtY3X6KC4Um6n+MOc7tnnaVGA3wDKJi82Q2zf3ajilThaRXS4/8E47RIg/URVMClNJ
	YvMlHvzbcw08LfNPyane4dSxEC8ENSLXXYjlyZCIfn2piAivOUQ7Wc6Ib1DN42yVNQtRGwjEcVYhd
	1QEM/RoLEkC9wrI2bRe+dvLyiGfz7sp0NSf3aanAl/joZk/Sy43sszrM5FHmk9wgpsDb3y4cq2PNZ
	t25p/xXXAjzk8F+ov1fVqNk44zlnuD4DWneVe3D2x96Mwbh0nIkMU/4B1M85rwrqkpZPkRd06JCN1
	BWeKVfVg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1wFZ-00000005E74-2s4z;
	Fri, 18 Oct 2024 23:19:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Evgeniy Dushistov <dushistov@mail.ru>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 10/17] ufs: get rid of ubh_{ubhcpymem,memcpyubh}()
Date: Sat, 19 Oct 2024 00:19:09 +0100
Message-ID: <20241018231916.1245836-10-viro@zeniv.linux.org.uk>
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

used only in ufs_read_cylinder_structures()/ufs_put_super_internal()
and there we can just as well avoid bothering with ufs_buffer_head
and just deal with it fragment-by-fragment.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ufs/super.c | 45 +++++++++++++++++----------------------------
 fs/ufs/util.c  | 46 ----------------------------------------------
 fs/ufs/util.h  |  5 -----
 3 files changed, 17 insertions(+), 79 deletions(-)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index bc625788589c..e876c60e70ea 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -505,7 +505,6 @@ static int ufs_read_cylinder_structures(struct super_block *sb)
 {
 	struct ufs_sb_info *sbi = UFS_SB(sb);
 	struct ufs_sb_private_info *uspi = sbi->s_uspi;
-	struct ufs_buffer_head * ubh;
 	unsigned char * base, * space;
 	unsigned size, blks, i;
 
@@ -521,21 +520,13 @@ static int ufs_read_cylinder_structures(struct super_block *sb)
 	if (!base)
 		goto failed; 
 	sbi->s_csp = (struct ufs_csum *)space;
-	for (i = 0; i < blks; i += uspi->s_fpb) {
-		size = uspi->s_bsize;
-		if (i + uspi->s_fpb > blks)
-			size = (blks - i) * uspi->s_fsize;
-
-		ubh = ubh_bread(sb, uspi->s_csaddr + i, size);
-		
-		if (!ubh)
+	for (i = 0; i < blks; i++) {
+		struct buffer_head *bh = sb_bread(sb, uspi->s_csaddr + i);
+		if (!bh)
 			goto failed;
-
-		ubh_ubhcpymem (space, ubh, size);
-
-		space += size;
-		ubh_brelse (ubh);
-		ubh = NULL;
+		memcpy(space, bh->b_data, uspi->s_fsize);
+		space += uspi->s_fsize;
+		brelse (bh);
 	}
 
 	/*
@@ -645,7 +636,6 @@ static void ufs_put_super_internal(struct super_block *sb)
 {
 	struct ufs_sb_info *sbi = UFS_SB(sb);
 	struct ufs_sb_private_info *uspi = sbi->s_uspi;
-	struct ufs_buffer_head * ubh;
 	unsigned char * base, * space;
 	unsigned blks, size, i;
 
@@ -656,18 +646,17 @@ static void ufs_put_super_internal(struct super_block *sb)
 	size = uspi->s_cssize;
 	blks = (size + uspi->s_fsize - 1) >> uspi->s_fshift;
 	base = space = (char*) sbi->s_csp;
-	for (i = 0; i < blks; i += uspi->s_fpb) {
-		size = uspi->s_bsize;
-		if (i + uspi->s_fpb > blks)
-			size = (blks - i) * uspi->s_fsize;
-
-		ubh = ubh_bread(sb, uspi->s_csaddr + i, size);
-
-		ubh_memcpyubh (ubh, space, size);
-		space += size;
-		ubh_mark_buffer_uptodate (ubh, 1);
-		ubh_mark_buffer_dirty (ubh);
-		ubh_brelse (ubh);
+	for (i = 0; i < blks; i++, space += uspi->s_fsize) {
+		struct buffer_head *bh = sb_bread(sb, uspi->s_csaddr + i);
+
+		if (unlikely(!bh)) { // better than an oops...
+			ufs_panic(sb, __func__,
+				"can't write part of cylinder group summary");
+			continue;
+		}
+		memcpy(bh->b_data, space, uspi->s_fsize);
+		mark_buffer_dirty(bh);
+		brelse(bh);
 	}
 	for (i = 0; i < sbi->s_cg_loaded; i++) {
 		ufs_put_cylinder (sb, i);
diff --git a/fs/ufs/util.c b/fs/ufs/util.c
index 2acf191eb89e..f0e906ab4ddd 100644
--- a/fs/ufs/util.c
+++ b/fs/ufs/util.c
@@ -99,20 +99,6 @@ void ubh_mark_buffer_dirty (struct ufs_buffer_head * ubh)
 		mark_buffer_dirty (ubh->bh[i]);
 }
 
-void ubh_mark_buffer_uptodate (struct ufs_buffer_head * ubh, int flag)
-{
-	unsigned i;
-	if (!ubh)
-		return;
-	if (flag) {
-		for ( i = 0; i < ubh->count; i++ )
-			set_buffer_uptodate (ubh->bh[i]);
-	} else {
-		for ( i = 0; i < ubh->count; i++ )
-			clear_buffer_uptodate (ubh->bh[i]);
-	}
-}
-
 void ubh_sync_block(struct ufs_buffer_head *ubh)
 {
 	if (ubh) {
@@ -146,38 +132,6 @@ int ubh_buffer_dirty (struct ufs_buffer_head * ubh)
 	return result;
 }
 
-void _ubh_ubhcpymem_(struct ufs_sb_private_info * uspi, 
-	unsigned char * mem, struct ufs_buffer_head * ubh, unsigned size)
-{
-	unsigned len, bhno;
-	if (size > (ubh->count << uspi->s_fshift))
-		size = ubh->count << uspi->s_fshift;
-	bhno = 0;
-	while (size) {
-		len = min_t(unsigned int, size, uspi->s_fsize);
-		memcpy (mem, ubh->bh[bhno]->b_data, len);
-		mem += uspi->s_fsize;
-		size -= len;
-		bhno++;
-	}
-}
-
-void _ubh_memcpyubh_(struct ufs_sb_private_info * uspi, 
-	struct ufs_buffer_head * ubh, unsigned char * mem, unsigned size)
-{
-	unsigned len, bhno;
-	if (size > (ubh->count << uspi->s_fshift))
-		size = ubh->count << uspi->s_fshift;
-	bhno = 0;
-	while (size) {
-		len = min_t(unsigned int, size, uspi->s_fsize);
-		memcpy (ubh->bh[bhno]->b_data, mem, len);
-		mem += uspi->s_fsize;
-		size -= len;
-		bhno++;
-	}
-}
-
 dev_t
 ufs_get_inode_dev(struct super_block *sb, struct ufs_inode_info *ufsi)
 {
diff --git a/fs/ufs/util.h b/fs/ufs/util.h
index fafae166ee55..391bb4f11d74 100644
--- a/fs/ufs/util.h
+++ b/fs/ufs/util.h
@@ -263,14 +263,9 @@ extern struct ufs_buffer_head * ubh_bread_uspi(struct ufs_sb_private_info *, str
 extern void ubh_brelse (struct ufs_buffer_head *);
 extern void ubh_brelse_uspi (struct ufs_sb_private_info *);
 extern void ubh_mark_buffer_dirty (struct ufs_buffer_head *);
-extern void ubh_mark_buffer_uptodate (struct ufs_buffer_head *, int);
 extern void ubh_sync_block(struct ufs_buffer_head *);
 extern void ubh_bforget (struct ufs_buffer_head *);
 extern int  ubh_buffer_dirty (struct ufs_buffer_head *);
-#define ubh_ubhcpymem(mem,ubh,size) _ubh_ubhcpymem_(uspi,mem,ubh,size)
-extern void _ubh_ubhcpymem_(struct ufs_sb_private_info *, unsigned char *, struct ufs_buffer_head *, unsigned);
-#define ubh_memcpyubh(ubh,mem,size) _ubh_memcpyubh_(uspi,ubh,mem,size)
-extern void _ubh_memcpyubh_(struct ufs_sb_private_info *, struct ufs_buffer_head *, unsigned char *, unsigned);
 
 /* This functions works with cache pages*/
 struct folio *ufs_get_locked_folio(struct address_space *mapping, pgoff_t index);
-- 
2.39.5


