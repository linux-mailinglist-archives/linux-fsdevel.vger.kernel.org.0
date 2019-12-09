Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC97A116BEF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfLILJW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:09:22 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60040 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfLILJW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SYFQioMwaI1M1QW9q40glc6RwXzosr2pEFnvgZot8HM=; b=YLboJOF2LjCx1pXsvp98xdc2U3
        QvA+OxpOd/7a2ngiutujwiw6rZDuTunlZWlJelO9qYF6uXyGOQsdjdTMD0ZVyuRZ/M0z0Q0euzi+U
        aND4bjhzrU88s/NrElsEBtu6SCj2zc4R8TACP6AJ3wiFXsNTwvh4awq9AqLmbI0tveNA+dpPYNGmd
        PY1lMklQdJcieAvQAkwnQ0WPFH2iIe9mw/kddRF2mpr76BfNmXlnlvTh7pLbWLk0RjcQOFeLUaOZW
        akMmD5lxpfGWA4SYSj7BPqUdB14ISmosVbHUYqo5SHw1INL9g0ZJbBsGI9Utk8wLjZ0a1xo2pzfFt
        N26Kyn+g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:49818 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGue-0002Tn-3d; Mon, 09 Dec 2019 11:09:12 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGuc-0004ap-06; Mon, 09 Dec 2019 11:09:10 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/41] fs/adfs: dir: rename bh_fplus to bhs
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGuc-0004ap-06@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:09:10 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename bh_fplus to bhs in preparation to make some of the directory
handling code sharable between implementations.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/adfs.h      |  4 +---
 fs/adfs/dir_fplus.c | 54 ++++++++++++++++++++++-----------------------
 2 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/fs/adfs/adfs.h b/fs/adfs/adfs.h
index 6497da8a2c8a..956ac0bd53e1 100644
--- a/fs/adfs/adfs.h
+++ b/fs/adfs/adfs.h
@@ -93,9 +93,7 @@ struct adfs_dir {
 
 	int			nr_buffers;
 	struct buffer_head	*bh[4];
-
-	/* big directories need allocated buffers */
-	struct buffer_head	**bh_fplus;
+	struct buffer_head	**bhs;
 
 	unsigned int		pos;
 	__u32			parent_id;
diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index d56924c11b17..5f5420c9b943 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -20,7 +20,7 @@ adfs_fplus_read(struct super_block *sb, unsigned int id, unsigned int sz, struct
 	dir->nr_buffers = 0;
 
 	/* start off using fixed bh set - only alloc for big dirs */
-	dir->bh_fplus = &dir->bh[0];
+	dir->bhs = &dir->bh[0];
 
 	block = __adfs_block_map(sb, id, 0);
 	if (!block) {
@@ -28,12 +28,12 @@ adfs_fplus_read(struct super_block *sb, unsigned int id, unsigned int sz, struct
 		goto out;
 	}
 
-	dir->bh_fplus[0] = sb_bread(sb, block);
-	if (!dir->bh_fplus[0])
+	dir->bhs[0] = sb_bread(sb, block);
+	if (!dir->bhs[0])
 		goto out;
 	dir->nr_buffers += 1;
 
-	h = (struct adfs_bigdirheader *)dir->bh_fplus[0]->b_data;
+	h = (struct adfs_bigdirheader *)dir->bhs[0]->b_data;
 	size = le32_to_cpu(h->bigdirsize);
 	if (size != sz) {
 		adfs_msg(sb, KERN_WARNING,
@@ -51,19 +51,19 @@ adfs_fplus_read(struct super_block *sb, unsigned int id, unsigned int sz, struct
 	size >>= sb->s_blocksize_bits;
 	if (size > ARRAY_SIZE(dir->bh)) {
 		/* this directory is too big for fixed bh set, must allocate */
-		struct buffer_head **bh_fplus =
+		struct buffer_head **bhs =
 			kcalloc(size, sizeof(struct buffer_head *),
 				GFP_KERNEL);
-		if (!bh_fplus) {
+		if (!bhs) {
 			adfs_msg(sb, KERN_ERR,
 				 "not enough memory for dir object %X (%d blocks)",
 				 id, size);
 			ret = -ENOMEM;
 			goto out;
 		}
-		dir->bh_fplus = bh_fplus;
+		dir->bhs = bhs;
 		/* copy over the pointer to the block that we've already read */
-		dir->bh_fplus[0] = dir->bh[0];
+		dir->bhs[0] = dir->bh[0];
 	}
 
 	for (blk = 1; blk < size; blk++) {
@@ -73,8 +73,8 @@ adfs_fplus_read(struct super_block *sb, unsigned int id, unsigned int sz, struct
 			goto out;
 		}
 
-		dir->bh_fplus[blk] = sb_bread(sb, block);
-		if (!dir->bh_fplus[blk]) {
+		dir->bhs[blk] = sb_bread(sb, block);
+		if (!dir->bhs[blk]) {
 			adfs_error(sb,	"dir object %x failed read for offset %d, mapped block %lX",
 				   id, blk, block);
 			goto out;
@@ -84,7 +84,7 @@ adfs_fplus_read(struct super_block *sb, unsigned int id, unsigned int sz, struct
 	}
 
 	t = (struct adfs_bigdirtail *)
-		(dir->bh_fplus[size - 1]->b_data + (sb->s_blocksize - 8));
+		(dir->bhs[size - 1]->b_data + (sb->s_blocksize - 8));
 
 	if (t->bigdirendname != cpu_to_le32(BIGDIRENDNAME) ||
 	    t->bigdirendmasseq != h->startmasseq ||
@@ -98,14 +98,14 @@ adfs_fplus_read(struct super_block *sb, unsigned int id, unsigned int sz, struct
 	return 0;
 
 out:
-	if (dir->bh_fplus) {
+	if (dir->bhs) {
 		for (i = 0; i < dir->nr_buffers; i++)
-			brelse(dir->bh_fplus[i]);
+			brelse(dir->bhs[i]);
 
-		if (&dir->bh[0] != dir->bh_fplus)
-			kfree(dir->bh_fplus);
+		if (&dir->bh[0] != dir->bhs)
+			kfree(dir->bhs);
 
-		dir->bh_fplus = NULL;
+		dir->bhs = NULL;
 	}
 
 	dir->nr_buffers = 0;
@@ -117,7 +117,7 @@ static int
 adfs_fplus_setpos(struct adfs_dir *dir, unsigned int fpos)
 {
 	struct adfs_bigdirheader *h =
-		(struct adfs_bigdirheader *) dir->bh_fplus[0]->b_data;
+		(struct adfs_bigdirheader *) dir->bhs[0]->b_data;
 	int ret = -ENOENT;
 
 	if (fpos <= le32_to_cpu(h->bigdirentries)) {
@@ -140,18 +140,18 @@ dir_memcpy(struct adfs_dir *dir, unsigned int offset, void *to, int len)
 	partial = sb->s_blocksize - offset;
 
 	if (partial >= len)
-		memcpy(to, dir->bh_fplus[buffer]->b_data + offset, len);
+		memcpy(to, dir->bhs[buffer]->b_data + offset, len);
 	else {
 		char *c = (char *)to;
 
 		remainder = len - partial;
 
 		memcpy(c,
-			dir->bh_fplus[buffer]->b_data + offset,
+			dir->bhs[buffer]->b_data + offset,
 			partial);
 
 		memcpy(c + partial,
-			dir->bh_fplus[buffer + 1]->b_data,
+			dir->bhs[buffer + 1]->b_data,
 			remainder);
 	}
 }
@@ -160,7 +160,7 @@ static int
 adfs_fplus_getnext(struct adfs_dir *dir, struct object_info *obj)
 {
 	struct adfs_bigdirheader *h =
-		(struct adfs_bigdirheader *) dir->bh_fplus[0]->b_data;
+		(struct adfs_bigdirheader *) dir->bhs[0]->b_data;
 	struct adfs_bigdirentry bde;
 	unsigned int offset;
 	int ret = -ENOENT;
@@ -202,7 +202,7 @@ adfs_fplus_sync(struct adfs_dir *dir)
 	int i;
 
 	for (i = dir->nr_buffers - 1; i >= 0; i--) {
-		struct buffer_head *bh = dir->bh_fplus[i];
+		struct buffer_head *bh = dir->bhs[i];
 		sync_dirty_buffer(bh);
 		if (buffer_req(bh) && !buffer_uptodate(bh))
 			err = -EIO;
@@ -216,14 +216,14 @@ adfs_fplus_free(struct adfs_dir *dir)
 {
 	int i;
 
-	if (dir->bh_fplus) {
+	if (dir->bhs) {
 		for (i = 0; i < dir->nr_buffers; i++)
-			brelse(dir->bh_fplus[i]);
+			brelse(dir->bhs[i]);
 
-		if (&dir->bh[0] != dir->bh_fplus)
-			kfree(dir->bh_fplus);
+		if (&dir->bh[0] != dir->bhs)
+			kfree(dir->bhs);
 
-		dir->bh_fplus = NULL;
+		dir->bhs = NULL;
 	}
 
 	dir->nr_buffers = 0;
-- 
2.20.1

