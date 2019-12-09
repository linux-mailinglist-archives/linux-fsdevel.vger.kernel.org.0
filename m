Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5FB0116BEA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfLILJr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:09:47 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60054 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfLILJb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:09:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5ovRiPBjyGAp5F+gmLbik58Yiqz+UDQb9qP6pGQGcGQ=; b=SJMG4rbqosMym0HPAzrfY9kJYO
        TLr3CFDWujj3VpdBS57vHI4zR56uafG4oLyoz25aWeC/gKGs/zKltuv1LY5qm3K19KCRsw5GbCD7d
        BAvSmZKQBwS2JIOqRGFMTeSmT63BWuvn2yHNNQU6Kk0MdYA6Hql8+MJpFtNrl9BFrmxe7+TL4n/Py
        z6eaIakfhVnATwO99fmLm4TVYjfuC7lt68VwZyGQPrSE8IChvf+B4QCn48JcKb/YEtOf2FOiuzMHU
        rdEB3XTQLSvMPat/ggy0Kx+BXmZ1owuKRE7FF6vEcs9JYhj5xPFIhym5QKVAKZuE5YaSz7AfTfVEJ
        r0q1rvBw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54064 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGuo-0002UA-Ft; Mon, 09 Dec 2019 11:09:22 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGum-0004b3-8C; Mon, 09 Dec 2019 11:09:20 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/41] fs/adfs: dir: add common directory buffer release
 method
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGum-0004b3-8C@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:09:20 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With the bhs pointer in place, we have no need for separate per-format
free() methods, since a generic version will do.  Provide a generic
implementation, remove the format specific implementations and the
method function pointer.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/adfs.h      |  2 +-
 fs/adfs/dir.c       | 21 ++++++++++++++++++---
 fs/adfs/dir_f.c     | 28 ++++------------------------
 fs/adfs/dir_fplus.c | 34 ++--------------------------------
 4 files changed, 25 insertions(+), 60 deletions(-)

diff --git a/fs/adfs/adfs.h b/fs/adfs/adfs.h
index 956ac0bd53e1..3bb6fd5b5eb0 100644
--- a/fs/adfs/adfs.h
+++ b/fs/adfs/adfs.h
@@ -126,7 +126,6 @@ struct adfs_dir_ops {
 	int	(*create)(struct adfs_dir *dir, struct object_info *obj);
 	int	(*remove)(struct adfs_dir *dir, struct object_info *obj);
 	int	(*sync)(struct adfs_dir *dir);
-	void	(*free)(struct adfs_dir *dir);
 };
 
 struct adfs_discmap {
@@ -167,6 +166,7 @@ extern const struct dentry_operations adfs_dentry_operations;
 extern const struct adfs_dir_ops adfs_f_dir_ops;
 extern const struct adfs_dir_ops adfs_fplus_dir_ops;
 
+void adfs_dir_relse(struct adfs_dir *dir);
 void adfs_object_fixup(struct adfs_dir *dir, struct object_info *obj);
 extern int adfs_dir_update(struct super_block *sb, struct object_info *obj,
 			   int wait);
diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index c1b8b5bccbec..f50302775504 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -6,6 +6,7 @@
  *
  *  Common directory handling for ADFS
  */
+#include <linux/slab.h>
 #include "adfs.h"
 
 /*
@@ -13,6 +14,20 @@
  */
 static DEFINE_RWLOCK(adfs_dir_lock);
 
+void adfs_dir_relse(struct adfs_dir *dir)
+{
+	unsigned int i;
+
+	for (i = 0; i < dir->nr_buffers; i++)
+		brelse(dir->bhs[i]);
+	dir->nr_buffers = 0;
+
+	if (dir->bhs != dir->bh)
+		kfree(dir->bhs);
+	dir->bhs = NULL;
+	dir->sb = NULL;
+}
+
 static int adfs_dir_read(struct super_block *sb, u32 indaddr,
 			 unsigned int size, struct adfs_dir *dir)
 {
@@ -105,7 +120,7 @@ adfs_readdir(struct file *file, struct dir_context *ctx)
 	read_unlock(&adfs_dir_lock);
 
 free_out:
-	ops->free(&dir);
+	adfs_dir_relse(&dir);
 	return ret;
 }
 
@@ -139,7 +154,7 @@ adfs_dir_update(struct super_block *sb, struct object_info *obj, int wait)
 			ret = err;
 	}
 
-	ops->free(&dir);
+	adfs_dir_relse(&dir);
 out:
 #endif
 	return ret;
@@ -211,7 +226,7 @@ static int adfs_dir_lookup_byname(struct inode *inode, const struct qstr *qstr,
 	read_unlock(&adfs_dir_lock);
 
 free_out:
-	ops->free(&dir);
+	adfs_dir_relse(&dir);
 out:
 	return ret;
 }
diff --git a/fs/adfs/dir_f.c b/fs/adfs/dir_f.c
index e62f35eb7789..e249fdb915fa 100644
--- a/fs/adfs/dir_f.c
+++ b/fs/adfs/dir_f.c
@@ -9,8 +9,6 @@
 #include "adfs.h"
 #include "dir_f.h"
 
-static void adfs_f_free(struct adfs_dir *dir);
-
 /*
  * Read an (unaligned) value of length 1..4 bytes
  */
@@ -128,7 +126,7 @@ static int adfs_dir_read(struct super_block *sb, u32 indaddr,
 			 unsigned int size, struct adfs_dir *dir)
 {
 	const unsigned int blocksize_bits = sb->s_blocksize_bits;
-	int blk = 0;
+	int blk;
 
 	/*
 	 * Directories which are not a multiple of 2048 bytes
@@ -152,6 +150,8 @@ static int adfs_dir_read(struct super_block *sb, u32 indaddr,
 		dir->bh[blk] = sb_bread(sb, phys);
 		if (!dir->bh[blk])
 			goto release_buffers;
+
+		dir->nr_buffers += 1;
 	}
 
 	memcpy(&dir->dirhead, bufoff(dir->bh, 0), sizeof(dir->dirhead));
@@ -168,17 +168,12 @@ static int adfs_dir_read(struct super_block *sb, u32 indaddr,
 	if (adfs_dir_checkbyte(dir) != dir->dirtail.new.dircheckbyte)
 		goto bad_dir;
 
-	dir->nr_buffers = blk;
-
 	return 0;
 
 bad_dir:
 	adfs_error(sb, "dir %06x is corrupted", indaddr);
 release_buffers:
-	for (blk -= 1; blk >= 0; blk -= 1)
-		brelse(dir->bh[blk]);
-
-	dir->sb = NULL;
+	adfs_dir_relse(dir);
 
 	return -EIO;
 }
@@ -435,25 +430,10 @@ adfs_f_sync(struct adfs_dir *dir)
 	return err;
 }
 
-static void
-adfs_f_free(struct adfs_dir *dir)
-{
-	int i;
-
-	for (i = dir->nr_buffers - 1; i >= 0; i--) {
-		brelse(dir->bh[i]);
-		dir->bh[i] = NULL;
-	}
-
-	dir->nr_buffers = 0;
-	dir->sb = NULL;
-}
-
 const struct adfs_dir_ops adfs_f_dir_ops = {
 	.read		= adfs_f_read,
 	.setpos		= adfs_f_setpos,
 	.getnext	= adfs_f_getnext,
 	.update		= adfs_f_update,
 	.sync		= adfs_f_sync,
-	.free		= adfs_f_free
 };
diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index 52c42a9986d9..25308b334dd3 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -15,7 +15,7 @@ adfs_fplus_read(struct super_block *sb, unsigned int id, unsigned int sz, struct
 	struct adfs_bigdirtail *t;
 	unsigned long block;
 	unsigned int blk, size;
-	int i, ret = -EIO;
+	int ret = -EIO;
 
 	block = __adfs_block_map(sb, id, 0);
 	if (!block) {
@@ -92,18 +92,8 @@ adfs_fplus_read(struct super_block *sb, unsigned int id, unsigned int sz, struct
 	return 0;
 
 out:
-	if (dir->bhs) {
-		for (i = 0; i < dir->nr_buffers; i++)
-			brelse(dir->bhs[i]);
+	adfs_dir_relse(dir);
 
-		if (&dir->bh[0] != dir->bhs)
-			kfree(dir->bhs);
-
-		dir->bhs = NULL;
-	}
-
-	dir->nr_buffers = 0;
-	dir->sb = NULL;
 	return ret;
 }
 
@@ -205,29 +195,9 @@ adfs_fplus_sync(struct adfs_dir *dir)
 	return err;
 }
 
-static void
-adfs_fplus_free(struct adfs_dir *dir)
-{
-	int i;
-
-	if (dir->bhs) {
-		for (i = 0; i < dir->nr_buffers; i++)
-			brelse(dir->bhs[i]);
-
-		if (&dir->bh[0] != dir->bhs)
-			kfree(dir->bhs);
-
-		dir->bhs = NULL;
-	}
-
-	dir->nr_buffers = 0;
-	dir->sb = NULL;
-}
-
 const struct adfs_dir_ops adfs_fplus_dir_ops = {
 	.read		= adfs_fplus_read,
 	.setpos		= adfs_fplus_setpos,
 	.getnext	= adfs_fplus_getnext,
 	.sync		= adfs_fplus_sync,
-	.free		= adfs_fplus_free
 };
-- 
2.20.1

