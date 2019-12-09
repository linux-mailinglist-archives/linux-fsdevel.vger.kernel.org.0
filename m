Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0648D116BE8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfLILJo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:09:44 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60074 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfLILJl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:09:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QTLqtswB1TE8Uq5cR7/hFTCe/EhXaOHygJT8ApuwzWQ=; b=YYehtPBP8NtTyeiOiawDTUwAu/
        sW8a9c/ZJwV4nObdu1buEky9yhjrAeRbpLok2zA07vjr6x2a6Y1R70832PN5gvwm9TP2db+H/e3lf
        v2/sIs4dBE4/OV2AO7Ta7sD/oaz95AQ2m+2LtG/6PpizCLSdYk5rOP5T4hwB7w7Pc0zadMrNseWkG
        /ONkqsQJ+VSFFfiQjWMVVCNmGAahBZtsTqn1lGh1cknv7v9E5nw2UW4PJQ0QG/sdpgDU2VJlxCOel
        GXM0ShuxBjBRtRs0AGcG9BVvAa8UkBRW3ZYHlT+CZjejcm89jUC/PO8NN6lFwDe+VPKf6LfDL5GLp
        nkonNHhA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:37640 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGv2-0002UZ-TH; Mon, 09 Dec 2019 11:09:37 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGv1-0004bO-LI; Mon, 09 Dec 2019 11:09:35 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 16/41] fs/adfs: dir: add generic directory reading
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGv1-0004bO-LI@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:09:35 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Both directory formats code the mechanics of fetching the directory
buffers using their own implementations.  Consolidate these into one
implementation.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/adfs.h      |  2 ++
 fs/adfs/dir.c       | 49 +++++++++++++++++++++++++++++
 fs/adfs/dir_f.c     | 24 +++-----------
 fs/adfs/dir_fplus.c | 76 ++++++++++++---------------------------------
 4 files changed, 74 insertions(+), 77 deletions(-)

diff --git a/fs/adfs/adfs.h b/fs/adfs/adfs.h
index 92cbc4b1d902..01d065937c01 100644
--- a/fs/adfs/adfs.h
+++ b/fs/adfs/adfs.h
@@ -170,6 +170,8 @@ int adfs_dir_copyfrom(void *dst, struct adfs_dir *dir, unsigned int offset,
 int adfs_dir_copyto(struct adfs_dir *dir, unsigned int offset, const void *src,
 		    size_t len);
 void adfs_dir_relse(struct adfs_dir *dir);
+int adfs_dir_read_buffers(struct super_block *sb, u32 indaddr,
+			  unsigned int size, struct adfs_dir *dir);
 void adfs_object_fixup(struct adfs_dir *dir, struct object_info *obj);
 extern int adfs_dir_update(struct super_block *sb, struct object_info *obj,
 			   int wait);
diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index 3c303074aa5e..b8e2a909fa3f 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -78,6 +78,55 @@ void adfs_dir_relse(struct adfs_dir *dir)
 	dir->sb = NULL;
 }
 
+int adfs_dir_read_buffers(struct super_block *sb, u32 indaddr,
+			  unsigned int size, struct adfs_dir *dir)
+{
+	struct buffer_head **bhs;
+	unsigned int i, num;
+	int block;
+
+	num = ALIGN(size, sb->s_blocksize) >> sb->s_blocksize_bits;
+	if (num > ARRAY_SIZE(dir->bh)) {
+		/* We only allow one extension */
+		if (dir->bhs != dir->bh)
+			return -EINVAL;
+
+		bhs = kcalloc(num, sizeof(*bhs), GFP_KERNEL);
+		if (!bhs)
+			return -ENOMEM;
+
+		if (dir->nr_buffers)
+			memcpy(bhs, dir->bhs, dir->nr_buffers * sizeof(*bhs));
+
+		dir->bhs = bhs;
+	}
+
+	for (i = dir->nr_buffers; i < num; i++) {
+		block = __adfs_block_map(sb, indaddr, i);
+		if (!block) {
+			adfs_error(sb, "dir %06x has a hole at offset %u",
+				   indaddr, i);
+			goto error;
+		}
+
+		dir->bhs[i] = sb_bread(sb, block);
+		if (!dir->bhs[i]) {
+			adfs_error(sb,
+				   "dir %06x failed read at offset %u, mapped block 0x%08x",
+				   indaddr, i, block);
+			goto error;
+		}
+
+		dir->nr_buffers++;
+	}
+	return 0;
+
+error:
+	adfs_dir_relse(dir);
+
+	return -EIO;
+}
+
 static int adfs_dir_read(struct super_block *sb, u32 indaddr,
 			 unsigned int size, struct adfs_dir *dir)
 {
diff --git a/fs/adfs/dir_f.c b/fs/adfs/dir_f.c
index 3c3b423577d2..027ee714f42b 100644
--- a/fs/adfs/dir_f.c
+++ b/fs/adfs/dir_f.c
@@ -126,7 +126,7 @@ static int adfs_dir_read(struct super_block *sb, u32 indaddr,
 			 unsigned int size, struct adfs_dir *dir)
 {
 	const unsigned int blocksize_bits = sb->s_blocksize_bits;
-	int blk;
+	int ret;
 
 	/*
 	 * Directories which are not a multiple of 2048 bytes
@@ -135,24 +135,9 @@ static int adfs_dir_read(struct super_block *sb, u32 indaddr,
 	if (size & 2047)
 		goto bad_dir;
 
-	size >>= blocksize_bits;
-
-	for (blk = 0; blk < size; blk++) {
-		int phys;
-
-		phys = __adfs_block_map(sb, indaddr, blk);
-		if (!phys) {
-			adfs_error(sb, "dir %06x has a hole at offset %d",
-				   indaddr, blk);
-			goto release_buffers;
-		}
-
-		dir->bh[blk] = sb_bread(sb, phys);
-		if (!dir->bh[blk])
-			goto release_buffers;
-
-		dir->nr_buffers += 1;
-	}
+	ret = adfs_dir_read_buffers(sb, indaddr, size, dir);
+	if (ret)
+		return ret;
 
 	memcpy(&dir->dirhead, bufoff(dir->bh, 0), sizeof(dir->dirhead));
 	memcpy(&dir->dirtail, bufoff(dir->bh, 2007), sizeof(dir->dirtail));
@@ -172,7 +157,6 @@ static int adfs_dir_read(struct super_block *sb, u32 indaddr,
 
 bad_dir:
 	adfs_error(sb, "dir %06x is corrupted", indaddr);
-release_buffers:
 	adfs_dir_relse(dir);
 
 	return -EIO;
diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index 6a07c0dfcc93..ae11236515d0 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -4,87 +4,49 @@
  *
  *  Copyright (C) 1997-1999 Russell King
  */
-#include <linux/slab.h>
 #include "adfs.h"
 #include "dir_fplus.h"
 
-static int
-adfs_fplus_read(struct super_block *sb, unsigned int id, unsigned int sz, struct adfs_dir *dir)
+static int adfs_fplus_read(struct super_block *sb, u32 indaddr,
+			   unsigned int size, struct adfs_dir *dir)
 {
 	struct adfs_bigdirheader *h;
 	struct adfs_bigdirtail *t;
-	unsigned long block;
-	unsigned int blk, size;
-	int ret = -EIO;
-
-	block = __adfs_block_map(sb, id, 0);
-	if (!block) {
-		adfs_error(sb, "dir object %X has a hole at offset 0", id);
-		goto out;
-	}
+	unsigned int dirsize;
+	int ret;
 
-	dir->bhs[0] = sb_bread(sb, block);
-	if (!dir->bhs[0])
-		goto out;
-	dir->nr_buffers += 1;
+	/* Read first buffer */
+	ret = adfs_dir_read_buffers(sb, indaddr, sb->s_blocksize, dir);
+	if (ret)
+		return ret;
 
 	h = (struct adfs_bigdirheader *)dir->bhs[0]->b_data;
-	size = le32_to_cpu(h->bigdirsize);
-	if (size != sz) {
+	dirsize = le32_to_cpu(h->bigdirsize);
+	if (dirsize != size) {
 		adfs_msg(sb, KERN_WARNING,
-			 "directory header size %X does not match directory size %X",
-			 size, sz);
+			 "dir %06x header size %X does not match directory size %X",
+			 indaddr, dirsize, size);
 	}
 
 	if (h->bigdirversion[0] != 0 || h->bigdirversion[1] != 0 ||
 	    h->bigdirversion[2] != 0 || size & 2047 ||
 	    h->bigdirstartname != cpu_to_le32(BIGDIRSTARTNAME)) {
-		adfs_error(sb, "dir %06x has malformed header", id);
+		adfs_error(sb, "dir %06x has malformed header", indaddr);
 		goto out;
 	}
 
-	size >>= sb->s_blocksize_bits;
-	if (size > ARRAY_SIZE(dir->bh)) {
-		/* this directory is too big for fixed bh set, must allocate */
-		struct buffer_head **bhs =
-			kcalloc(size, sizeof(struct buffer_head *),
-				GFP_KERNEL);
-		if (!bhs) {
-			adfs_msg(sb, KERN_ERR,
-				 "not enough memory for dir object %X (%d blocks)",
-				 id, size);
-			ret = -ENOMEM;
-			goto out;
-		}
-		dir->bhs = bhs;
-		/* copy over the pointer to the block that we've already read */
-		dir->bhs[0] = dir->bh[0];
-	}
-
-	for (blk = 1; blk < size; blk++) {
-		block = __adfs_block_map(sb, id, blk);
-		if (!block) {
-			adfs_error(sb, "dir object %X has a hole at offset %d", id, blk);
-			goto out;
-		}
-
-		dir->bhs[blk] = sb_bread(sb, block);
-		if (!dir->bhs[blk]) {
-			adfs_error(sb,	"dir object %x failed read for offset %d, mapped block %lX",
-				   id, blk, block);
-			goto out;
-		}
-
-		dir->nr_buffers += 1;
-	}
+	/* Read remaining buffers */
+	ret = adfs_dir_read_buffers(sb, indaddr, dirsize, dir);
+	if (ret)
+		return ret;
 
 	t = (struct adfs_bigdirtail *)
-		(dir->bhs[size - 1]->b_data + (sb->s_blocksize - 8));
+		(dir->bhs[dir->nr_buffers - 1]->b_data + (sb->s_blocksize - 8));
 
 	if (t->bigdirendname != cpu_to_le32(BIGDIRENDNAME) ||
 	    t->bigdirendmasseq != h->startmasseq ||
 	    t->reserved[0] != 0 || t->reserved[1] != 0) {
-		adfs_error(sb, "dir %06x has malformed tail", id);
+		adfs_error(sb, "dir %06x has malformed tail", indaddr);
 		goto out;
 	}
 
-- 
2.20.1

