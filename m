Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5EF116BE2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfLILJa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:09:30 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60046 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfLILJ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:09:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=S1nMEserksNs1jdlWVfoPbG/cC0jAQdxgCU+XUMphps=; b=Ax9XtiskIcH9WosBmjeeGXvp+O
        lXQxPfYlp3pFUJiE3V2MPWeDPGdUSJJlOQWIDEzmEU8/+1BgrO6pZriqoYXf6d2/8JX7J1yVLHHrd
        q3mdPlz4JeZY/06/4bSJzedThKYnsx8OS1Yf+ZCf96+H3Ww9Su/aWbAQNmrwR16rGy9W+oletWnj7
        l0b1FJ8MBvJpaPUP5yw2GH6B2SWQqy11F02XrkMKQ0k3DfUgnrjzrSIbwTEKrq/xdWkMDLzHC4h+P
        Tm+KO5zQsiKmWopUfgJ7R5RDscRrZuVQMfNx4qTbIj4+qfOeSbWEQjqZzdR7rdHic6Rxqk6tiimBU
        iQlysz2Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:37632 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGuj-0002Tv-GY; Mon, 09 Dec 2019 11:09:17 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGuh-0004aw-4Q; Mon, 09 Dec 2019 11:09:15 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/41] fs/adfs: dir: add common dir object initialisation
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGuh-0004aw-4Q@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:09:15 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Initialise the dir object before we pass it down to the directory format
specific read handler.  This allows us to get rid of the initialisation
inside those handlers.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/dir.c       | 16 +++++++++++++---
 fs/adfs/dir_f.c     |  3 ---
 fs/adfs/dir_fplus.c |  6 ------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index a54c53244992..c1b8b5bccbec 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -13,6 +13,16 @@
  */
 static DEFINE_RWLOCK(adfs_dir_lock);
 
+static int adfs_dir_read(struct super_block *sb, u32 indaddr,
+			 unsigned int size, struct adfs_dir *dir)
+{
+	dir->sb = sb;
+	dir->bhs = dir->bh;
+	dir->nr_buffers = 0;
+
+	return ADFS_SB(sb)->s_dir->read(sb, indaddr, size, dir);
+}
+
 void adfs_object_fixup(struct adfs_dir *dir, struct object_info *obj)
 {
 	unsigned int dots, i;
@@ -64,7 +74,7 @@ adfs_readdir(struct file *file, struct dir_context *ctx)
 	if (ctx->pos >> 32)
 		return 0;
 
-	ret = ops->read(sb, inode->i_ino, inode->i_size, &dir);
+	ret = adfs_dir_read(sb, inode->i_ino, inode->i_size, &dir);
 	if (ret)
 		return ret;
 
@@ -115,7 +125,7 @@ adfs_dir_update(struct super_block *sb, struct object_info *obj, int wait)
 		goto out;
 	}
 
-	ret = ops->read(sb, obj->parent_id, 0, &dir);
+	ret = adfs_dir_read(sb, obj->parent_id, 0, &dir);
 	if (ret)
 		goto out;
 
@@ -167,7 +177,7 @@ static int adfs_dir_lookup_byname(struct inode *inode, const struct qstr *qstr,
 	u32 name_len;
 	int ret;
 
-	ret = ops->read(sb, inode->i_ino, inode->i_size, &dir);
+	ret = adfs_dir_read(sb, inode->i_ino, inode->i_size, &dir);
 	if (ret)
 		goto out;
 
diff --git a/fs/adfs/dir_f.c b/fs/adfs/dir_f.c
index c1a950c7400a..e62f35eb7789 100644
--- a/fs/adfs/dir_f.c
+++ b/fs/adfs/dir_f.c
@@ -139,9 +139,6 @@ static int adfs_dir_read(struct super_block *sb, u32 indaddr,
 
 	size >>= blocksize_bits;
 
-	dir->nr_buffers = 0;
-	dir->sb = sb;
-
 	for (blk = 0; blk < size; blk++) {
 		int phys;
 
diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index 5f5420c9b943..52c42a9986d9 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -17,11 +17,6 @@ adfs_fplus_read(struct super_block *sb, unsigned int id, unsigned int sz, struct
 	unsigned int blk, size;
 	int i, ret = -EIO;
 
-	dir->nr_buffers = 0;
-
-	/* start off using fixed bh set - only alloc for big dirs */
-	dir->bhs = &dir->bh[0];
-
 	block = __adfs_block_map(sb, id, 0);
 	if (!block) {
 		adfs_error(sb, "dir object %X has a hole at offset 0", id);
@@ -94,7 +89,6 @@ adfs_fplus_read(struct super_block *sb, unsigned int id, unsigned int sz, struct
 	}
 
 	dir->parent_id = le32_to_cpu(h->bigdirparent);
-	dir->sb = sb;
 	return 0;
 
 out:
-- 
2.20.1

