Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24EA0116BF7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfLILKX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:10:23 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60132 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfLILKX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wraR5utXbneuOpsmAzY4ORdxt0v1njp56IK7QpTngR4=; b=g1zJ2+6TM/2xfbM/OFi7I4s+A5
        5ZgaIoKuQnp4ukf6EIj57GMgtKZJZBrzDSBpL8/+cROtPPnqNhMBLB8uVFaMJGPpQtJTiMd4fNQda
        J05Pi5RzlBwCS5I9HCOh7CGyBaSfmUH/yKqcxi9HZttrGPCbGD2f8/+nucA82Lys2lHB/tJz0wYKD
        1aSF5o5rQO9f0zzocsDH79iZefFsRLGYLxxDoNbt+K2FoBbzI9Av9UrYsCvKzJf5VAsvL2FlOIzOB
        zP69DG+YrDJSusfzh7nV7aY7aKujo5YVzh7zyVtl/F8+06Cb73tAXGOv5xMh6tNN5m2TmGSn+uGDa
        SbbtYLdA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:49844 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGvi-0002W0-5F; Mon, 09 Dec 2019 11:10:18 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGvg-0004cJ-Ox; Mon, 09 Dec 2019 11:10:16 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 24/41] fs/adfs: dir: add more efficient iterate() per-format
 method
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGvg-0004cJ-Ox@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:10:16 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rather than using setpos + getnext to iterate through the directory
entries, pass iterate() down to the dir format code to populate the
dirents.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/adfs.h      |  1 +
 fs/adfs/dir.c       | 16 ++--------------
 fs/adfs/dir_f.c     | 18 ++++++++++++++++++
 fs/adfs/dir_fplus.c | 21 +++++++++++++++++++++
 4 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/fs/adfs/adfs.h b/fs/adfs/adfs.h
index 01d065937c01..cbf33f375e0b 100644
--- a/fs/adfs/adfs.h
+++ b/fs/adfs/adfs.h
@@ -120,6 +120,7 @@ struct object_info {
 struct adfs_dir_ops {
 	int	(*read)(struct super_block *sb, unsigned int indaddr,
 			unsigned int size, struct adfs_dir *dir);
+	int	(*iterate)(struct adfs_dir *dir, struct dir_context *ctx);
 	int	(*setpos)(struct adfs_dir *dir, unsigned int fpos);
 	int	(*getnext)(struct adfs_dir *dir, struct object_info *obj);
 	int	(*update)(struct adfs_dir *dir, struct object_info *obj);
diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index 2a8f5f1fd3d0..7fda44464121 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -240,12 +240,8 @@ static int adfs_iterate(struct file *file, struct dir_context *ctx)
 	struct inode *inode = file_inode(file);
 	struct super_block *sb = inode->i_sb;
 	const struct adfs_dir_ops *ops = ADFS_SB(sb)->s_dir;
-	struct object_info obj;
 	struct adfs_dir dir;
-	int ret = 0;
-
-	if (ctx->pos >> 32)
-		return 0;
+	int ret;
 
 	down_read(&adfs_dir_rwsem);
 	ret = adfs_dir_read_inode(sb, inode, &dir);
@@ -263,15 +259,7 @@ static int adfs_iterate(struct file *file, struct dir_context *ctx)
 		ctx->pos = 2;
 	}
 
-	ret = ops->setpos(&dir, ctx->pos - 2);
-	if (ret)
-		goto unlock_relse;
-	while (ops->getnext(&dir, &obj) == 0) {
-		if (!dir_emit(ctx, obj.name, obj.name_len,
-			      obj.indaddr, DT_UNKNOWN))
-			break;
-		ctx->pos++;
-	}
+	ret = ops->iterate(&dir, ctx);
 
 unlock_relse:
 	up_read(&adfs_dir_rwsem);
diff --git a/fs/adfs/dir_f.c b/fs/adfs/dir_f.c
index 682df46d8d33..2e342871d6df 100644
--- a/fs/adfs/dir_f.c
+++ b/fs/adfs/dir_f.c
@@ -302,6 +302,23 @@ adfs_f_getnext(struct adfs_dir *dir, struct object_info *obj)
 	return ret;
 }
 
+static int adfs_f_iterate(struct adfs_dir *dir, struct dir_context *ctx)
+{
+	struct object_info obj;
+	int pos = 5 + (ctx->pos - 2) * 26;
+
+	while (ctx->pos < 2 + ADFS_NUM_DIR_ENTRIES) {
+		if (__adfs_dir_get(dir, pos, &obj))
+			break;
+		if (!dir_emit(ctx, obj.name, obj.name_len,
+			      obj.indaddr, DT_UNKNOWN))
+			break;
+		pos += 26;
+		ctx->pos++;
+	}
+	return 0;
+}
+
 static int
 adfs_f_update(struct adfs_dir *dir, struct object_info *obj)
 {
@@ -359,6 +376,7 @@ adfs_f_update(struct adfs_dir *dir, struct object_info *obj)
 
 const struct adfs_dir_ops adfs_f_dir_ops = {
 	.read		= adfs_f_read,
+	.iterate	= adfs_f_iterate,
 	.setpos		= adfs_f_setpos,
 	.getnext	= adfs_f_getnext,
 	.update		= adfs_f_update,
diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index ae11236515d0..edcbaa94ecb9 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -118,8 +118,29 @@ adfs_fplus_getnext(struct adfs_dir *dir, struct object_info *obj)
 	return 0;
 }
 
+static int adfs_fplus_iterate(struct adfs_dir *dir, struct dir_context *ctx)
+{
+	struct object_info obj;
+
+	if ((ctx->pos - 2) >> 32)
+		return 0;
+
+	if (adfs_fplus_setpos(dir, ctx->pos - 2))
+		return 0;
+
+	while (!adfs_fplus_getnext(dir, &obj)) {
+		if (!dir_emit(ctx, obj.name, obj.name_len,
+			      obj.indaddr, DT_UNKNOWN))
+			break;
+		ctx->pos++;
+	}
+
+	return 0;
+}
+
 const struct adfs_dir_ops adfs_fplus_dir_ops = {
 	.read		= adfs_fplus_read,
+	.iterate	= adfs_fplus_iterate,
 	.setpos		= adfs_fplus_setpos,
 	.getnext	= adfs_fplus_getnext,
 };
-- 
2.20.1

