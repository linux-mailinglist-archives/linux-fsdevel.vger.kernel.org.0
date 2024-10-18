Return-Path: <linux-fsdevel+bounces-32398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877829A49F0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 01:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 037F6B2340A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 23:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C64192581;
	Fri, 18 Oct 2024 23:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FRhTFX0V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9349C190664
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 23:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293562; cv=none; b=FdJ6Q6NINZ9t4P3IzxLDz09H8UR3AuoDl19CEyBhXLnhMYqg8/OhO2fQuwJLRuZ9qQUYR+ZHHsJ/hQpixHEhxKRXui8VylRp3EiNDBJQ2eQNHrMhnOV1iwMrGLudPOxD73bjbxFgXHRuOdTHGg6PYRFT76avjEbX0GBeeZi239Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293562; c=relaxed/simple;
	bh=eQndQ09DAc2J8GGvQ93NPkyDtJQFhZeqP0Ulf+KbLpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dkb2b9JtNP058BYaI/fp8zD/KhJaXIEfob+KvW/1xi1bmxu9oRKUeouaSUDZOl07jh1oG8H9DMtESluO2R5w/Hx7UkunmdrJPfoy7zCQJLNxH74+xg6LXIW2bZbxMlBJQ7guv41oX2GIETahSWCv9ef7QNCQeA4IENfnFiwR8es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FRhTFX0V; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9xxw3Kf+3TKqZMPub9ymqN2QOj3B++Fc5yMmws2tJOQ=; b=FRhTFX0VCRX/CeFYRqMStAcp/6
	lFQyF/BI+iiImhcuYCcLkkf6EuRrWEKcXYSVqSqz/FfxME757oNWRU7Dqfi4F/tVXcNLAIuxJj6m2
	pqCjv7eMjstII3m2Uohnjzw0/M7yAsJoqy+u0Qt5JlGB/Jq7x3UWnJSWv7zzhI11AUGPoufajHhWf
	Ej0zCBtJYGrDvPWXmosglIgCOz+XYiJM6UIASGSkpItr1Xk0qE5Ez8WJBDfRqEzLrVLVK6JGbeEPp
	BMoj6kP11XMigap8wTt8VI0Xv48ZWAiInLY0PuEu04OGYmEyyepn9X7j62+kzzGzVo24X1PSpRY64
	RKPIZnCQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1wFZ-00000005E7G-3cix;
	Fri, 18 Oct 2024 23:19:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Evgeniy Dushistov <dushistov@mail.ru>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 12/17] ufs: take the handling of free block counters into a helper
Date: Sat, 19 Oct 2024 00:19:11 +0100
Message-ID: <20241018231916.1245836-12-viro@zeniv.linux.org.uk>
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

There are 3 places where those counters (many and varied...) are
adjusted - when we are freeing fragments and get an entire block
freed, when we are freeing blocks and (in opposite direction) when
we are grabbing a block.  The logics is identical (modulo the
sign of adjustment) in all three; better take it into a helper -
less duplication and less clutter in the callers that way.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ufs/balloc.c | 66 +++++++++++++++++++------------------------------
 1 file changed, 26 insertions(+), 40 deletions(-)

diff --git a/fs/ufs/balloc.c b/fs/ufs/balloc.c
index 82f1a4a128a2..c60006c5806c 100644
--- a/fs/ufs/balloc.c
+++ b/fs/ufs/balloc.c
@@ -33,6 +33,29 @@ static u64 ufs_bitmap_search (struct super_block *, struct ufs_cg_private_info *
 static unsigned char ufs_fragtable_8fpb[], ufs_fragtable_other[];
 static void ufs_clusteracct(struct super_block *, struct ufs_cg_private_info *, unsigned, int);
 
+static void adjust_free_blocks(struct super_block *sb,
+			       struct ufs_cylinder_group *ucg,
+			       struct ufs_cg_private_info *ucpi,
+			       unsigned fragment, int delta)
+{
+	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
+
+	if ((UFS_SB(sb)->s_flags & UFS_CG_MASK) == UFS_CG_44BSD)
+		ufs_clusteracct(sb, ucpi, fragment, delta);
+
+	fs32_add(sb, &ucg->cg_cs.cs_nbfree, delta);
+	uspi->cs_total.cs_nbfree += delta;
+	fs32_add(sb, &UFS_SB(sb)->fs_cs(ucpi->c_cgx).cs_nbfree, delta);
+
+	if (uspi->fs_magic != UFS2_MAGIC) {
+		unsigned cylno = ufs_cbtocylno(fragment);
+
+		fs16_add(sb, &ubh_cg_blks(ucpi, cylno,
+					  ufs_cbtorpos(fragment)), delta);
+		fs32_add(sb, &ubh_cg_blktot(ucpi, cylno), delta);
+	}
+}
+
 /*
  * Free 'count' fragments from fragment number 'fragment'
  */
@@ -97,18 +120,7 @@ void ufs_free_fragments(struct inode *inode, u64 fragment, unsigned count)
 		fs32_sub(sb, &ucg->cg_cs.cs_nffree, uspi->s_fpb);
 		uspi->cs_total.cs_nffree -= uspi->s_fpb;
 		fs32_sub(sb, &UFS_SB(sb)->fs_cs(cgno).cs_nffree, uspi->s_fpb);
-		if ((UFS_SB(sb)->s_flags & UFS_CG_MASK) == UFS_CG_44BSD)
-			ufs_clusteracct(sb, ucpi, bbase, 1);
-		fs32_add(sb, &ucg->cg_cs.cs_nbfree, 1);
-		uspi->cs_total.cs_nbfree++;
-		fs32_add(sb, &UFS_SB(sb)->fs_cs(cgno).cs_nbfree, 1);
-		if (uspi->fs_magic != UFS2_MAGIC) {
-			unsigned cylno = ufs_cbtocylno (bbase);
-
-			fs16_add(sb, &ubh_cg_blks(ucpi, cylno,
-						  ufs_cbtorpos(bbase)), 1);
-			fs32_add(sb, &ubh_cg_blktot(ucpi, cylno), 1);
-		}
+		adjust_free_blocks(sb, ucg, ucpi, bbase, 1);
 	}
 	
 	ubh_mark_buffer_dirty (USPI_UBH(uspi));
@@ -183,20 +195,7 @@ void ufs_free_blocks(struct inode *inode, u64 fragment, unsigned count)
 		}
 		ubh_setblock(uspi, ucpi, i);
 		inode_sub_bytes(inode, uspi->s_fpb << uspi->s_fshift);
-		if ((UFS_SB(sb)->s_flags & UFS_CG_MASK) == UFS_CG_44BSD)
-			ufs_clusteracct(sb, ucpi, i, 1);
-
-		fs32_add(sb, &ucg->cg_cs.cs_nbfree, 1);
-		uspi->cs_total.cs_nbfree++;
-		fs32_add(sb, &UFS_SB(sb)->fs_cs(cgno).cs_nbfree, 1);
-
-		if (uspi->fs_magic != UFS2_MAGIC) {
-			unsigned cylno = ufs_cbtocylno(i);
-
-			fs16_add(sb, &ubh_cg_blks(ucpi, cylno,
-						  ufs_cbtorpos(i)), 1);
-			fs32_add(sb, &ubh_cg_blktot(ucpi, cylno), 1);
-		}
+		adjust_free_blocks(sb, ucg, ucpi, i, 1);
 	}
 
 	ubh_mark_buffer_dirty (USPI_UBH(uspi));
@@ -726,20 +725,7 @@ static u64 ufs_alloccg_block(struct inode *inode,
 	if (!try_add_frags(inode, uspi->s_fpb))
 		return 0;
 	ubh_clrblock(uspi, ucpi, result);
-	if ((UFS_SB(sb)->s_flags & UFS_CG_MASK) == UFS_CG_44BSD)
-		ufs_clusteracct(sb, ucpi, result, -1);
-
-	fs32_sub(sb, &ucg->cg_cs.cs_nbfree, 1);
-	uspi->cs_total.cs_nbfree--;
-	fs32_sub(sb, &UFS_SB(sb)->fs_cs(ucpi->c_cgx).cs_nbfree, 1);
-
-	if (uspi->fs_magic != UFS2_MAGIC) {
-		unsigned cylno = ufs_cbtocylno((unsigned)result);
-
-		fs16_sub(sb, &ubh_cg_blks(ucpi, cylno,
-					  ufs_cbtorpos((unsigned)result)), 1);
-		fs32_sub(sb, &ubh_cg_blktot(ucpi, cylno), 1);
-	}
+	adjust_free_blocks(sb, ucg, ucpi, result, -1);
 	
 	UFSD("EXIT, result %llu\n", (unsigned long long)result);
 
-- 
2.39.5


