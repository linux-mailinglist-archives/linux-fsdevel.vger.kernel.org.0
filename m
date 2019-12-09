Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94E32116BE5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfLILJg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:09:36 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60062 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbfLILJe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:09:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7Ix0oHnqWYMGJjombZ6MSjEIvbH93bBkQkaOVwoV3QY=; b=UMPYszODOuCUzOlFzqrMNs6CDU
        eblsUTAniXR8lNUVDr5kC8vqUZQaK9CycnwnDr9/wXQvnSXMLXLBGNrfUfwkwDJUIbIlXSZBY2Xso
        k5GgeB51Z2tUFW97uF+fBRMv3r5yVwxA4bs32QvVQ75TcOPZLhpU8swFU1jAaRJ2vZxU1FuO2A2cb
        awd0g5f5xqcrY6Ep+IQKnCXvA1KTPHeacWvmbQT1w2NZNLOTgwT3UQwcFgywiiV2y/gedgtg0rtW/
        9zMjrb8V7YFu5RjErXwvrT4ECLq23Nh7/To2NtCsvXmmDoBRkw/de+8CXbss17hM1sq3NHf+bKFQ6
        eyBNVkOQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:37636 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGut-0002UK-I9; Mon, 09 Dec 2019 11:09:27 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGur-0004bA-CV; Mon, 09 Dec 2019 11:09:25 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/41] fs/adfs: dir: add common directory sync method
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGur-0004bA-CV@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:09:25 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

adfs_fplus_sync() can be used for both directory formats since we now
have a common way to access the buffer heads, so move it into dir.c
and appropriately rename it.  Remove the directory-format specific
implementations.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/adfs.h      |  1 -
 fs/adfs/dir.c       | 23 ++++++++++++++++++-----
 fs/adfs/dir_f.c     | 17 -----------------
 fs/adfs/dir_fplus.c | 17 -----------------
 4 files changed, 18 insertions(+), 40 deletions(-)

diff --git a/fs/adfs/adfs.h b/fs/adfs/adfs.h
index 3bb6fd5b5eb0..5f1acee768f5 100644
--- a/fs/adfs/adfs.h
+++ b/fs/adfs/adfs.h
@@ -125,7 +125,6 @@ struct adfs_dir_ops {
 	int	(*update)(struct adfs_dir *dir, struct object_info *obj);
 	int	(*create)(struct adfs_dir *dir, struct object_info *obj);
 	int	(*remove)(struct adfs_dir *dir, struct object_info *obj);
-	int	(*sync)(struct adfs_dir *dir);
 };
 
 struct adfs_discmap {
diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index f50302775504..16a2639d3ca5 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -38,6 +38,21 @@ static int adfs_dir_read(struct super_block *sb, u32 indaddr,
 	return ADFS_SB(sb)->s_dir->read(sb, indaddr, size, dir);
 }
 
+static int adfs_dir_sync(struct adfs_dir *dir)
+{
+	int err = 0;
+	int i;
+
+	for (i = dir->nr_buffers - 1; i >= 0; i--) {
+		struct buffer_head *bh = dir->bhs[i];
+		sync_dirty_buffer(bh);
+		if (buffer_req(bh) && !buffer_uptodate(bh))
+			err = -EIO;
+	}
+
+	return err;
+}
+
 void adfs_object_fixup(struct adfs_dir *dir, struct object_info *obj)
 {
 	unsigned int dots, i;
@@ -135,10 +150,8 @@ adfs_dir_update(struct super_block *sb, struct object_info *obj, int wait)
 	printk(KERN_INFO "adfs_dir_update: object %06x in dir %06x\n",
 		 obj->indaddr, obj->parent_id);
 
-	if (!ops->update) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!ops->update)
+		return -EINVAL;
 
 	ret = adfs_dir_read(sb, obj->parent_id, 0, &dir);
 	if (ret)
@@ -149,7 +162,7 @@ adfs_dir_update(struct super_block *sb, struct object_info *obj, int wait)
 	write_unlock(&adfs_dir_lock);
 
 	if (wait) {
-		int err = ops->sync(&dir);
+		int err = adfs_dir_sync(&dir);
 		if (!ret)
 			ret = err;
 	}
diff --git a/fs/adfs/dir_f.c b/fs/adfs/dir_f.c
index e249fdb915fa..80ac261b9ec4 100644
--- a/fs/adfs/dir_f.c
+++ b/fs/adfs/dir_f.c
@@ -414,26 +414,9 @@ adfs_f_update(struct adfs_dir *dir, struct object_info *obj)
 #endif
 }
 
-static int
-adfs_f_sync(struct adfs_dir *dir)
-{
-	int err = 0;
-	int i;
-
-	for (i = dir->nr_buffers - 1; i >= 0; i--) {
-		struct buffer_head *bh = dir->bh[i];
-		sync_dirty_buffer(bh);
-		if (buffer_req(bh) && !buffer_uptodate(bh))
-			err = -EIO;
-	}
-
-	return err;
-}
-
 const struct adfs_dir_ops adfs_f_dir_ops = {
 	.read		= adfs_f_read,
 	.setpos		= adfs_f_setpos,
 	.getnext	= adfs_f_getnext,
 	.update		= adfs_f_update,
-	.sync		= adfs_f_sync,
 };
diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index 25308b334dd3..1196c8962feb 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -179,25 +179,8 @@ adfs_fplus_getnext(struct adfs_dir *dir, struct object_info *obj)
 	return ret;
 }
 
-static int
-adfs_fplus_sync(struct adfs_dir *dir)
-{
-	int err = 0;
-	int i;
-
-	for (i = dir->nr_buffers - 1; i >= 0; i--) {
-		struct buffer_head *bh = dir->bhs[i];
-		sync_dirty_buffer(bh);
-		if (buffer_req(bh) && !buffer_uptodate(bh))
-			err = -EIO;
-	}
-
-	return err;
-}
-
 const struct adfs_dir_ops adfs_fplus_dir_ops = {
 	.read		= adfs_fplus_read,
 	.setpos		= adfs_fplus_setpos,
 	.getnext	= adfs_fplus_getnext,
-	.sync		= adfs_fplus_sync,
 };
-- 
2.20.1

