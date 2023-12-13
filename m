Return-Path: <linux-fsdevel+bounces-5797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D32DA8108A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 04:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D9D1F21ACA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 03:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36584D53E;
	Wed, 13 Dec 2023 03:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="s36eGc5x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC30DB
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 19:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=RH4qiGVHnQ1pbKsNUICZdDNbrbx6uDfHTHWZOsm2ZEQ=; b=s36eGc5xMiG7Q3OPVNHdfbAJYx
	IhAMVtRts/+ng/a+CJiMp+HMZ5kp8I2lGHfQNVXVq7wPvS/ZD2yiMoq1AM3vBM04ysWQLbmYT3sU/
	gdbPXTBWBcnhtDlWMdKdmsvwcagZA6OLitNNSWc2hUPeW6K78DUh6q861uH0sUUAxGgXdYOdfOaDD
	fKaseZ3+H2GgVoi6x8EPuZBPY94lwD5JJRQl3fL6j+jzAy/Eh9qHAfhmGj6hUqWH1XTexaxdg3Cjf
	J7AQNzHA5ThdGD6WJOKH95gkFfgJjLkZgpWNVkqkq1LreA0D9TVSIEE7KKHTxo6d3wxH/ZDIp+L2n
	h6rsrThQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDFlV-00BbyM-1d;
	Wed, 13 Dec 2023 03:18:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Evgeniy Dushistov <dushistov@mail.ru>,
	"Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 11/12] ufs: get rid of ubh_{ubhcpymem,memcpyubh}()
Date: Wed, 13 Dec 2023 03:18:26 +0000
Message-Id: <20231213031827.2767531-11-viro@zeniv.linux.org.uk>
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
index a480810cd4e3..ccdfd4cb2682 100644
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
index 13ba34e6d64f..535c7ee80a10 100644
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
index 6fff3da93a66..eb6943fa7fa4 100644
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
2.39.2


