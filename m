Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76236116BE9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfLILJq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:09:46 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60080 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbfLILJp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:09:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KmJZ536s8AvaD+oMJnynrn/JHuYCdQg9xQBXxY7QTXU=; b=Ra4u3X0BU1BOXyqHtITs9at7qR
        bArM7Vg9BFfAb3W18H2AwRvHxP48qE/Gw1I8k9Oj4qM8F3Cd+PaRV8rDrb0HN+DG/J5wtuWbrtb3U
        UhRfn9VFSOgfDarYgw2CXLNeVmHO1HgC0Kg/N54A6qQ5Y8QYdI2DtiBcWz9EF5Y+NW0IBuNJGWtOF
        E341MDc6XZ4hrFOFJaSlRBfZXTEND1QJ0LSYh/KRsNy9nZF3rfjLcbl+JLMgOhIGxmHDPRlXVraOP
        TdjoMRE9Xx1gtNOF4hsiEHi/wLACiQids7lMRroc4GMiIQuWiowcYCO3XCV4lbrJPcnwpnSBvKA6c
        Tct6N/Og==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:37642 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGv7-0002Uk-P7; Mon, 09 Dec 2019 11:09:41 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGv6-0004bV-PH; Mon, 09 Dec 2019 11:09:40 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 17/41] fs/adfs: dir: add helper to read directory using inode
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGv6-0004bV-PH@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:09:40 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a helper to read a directory using the inode, which we do in two
places.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/dir.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index b8e2a909fa3f..882377e86041 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -137,6 +137,26 @@ static int adfs_dir_read(struct super_block *sb, u32 indaddr,
 	return ADFS_SB(sb)->s_dir->read(sb, indaddr, size, dir);
 }
 
+static int adfs_dir_read_inode(struct super_block *sb, struct inode *inode,
+			       struct adfs_dir *dir)
+{
+	int ret;
+
+	ret = adfs_dir_read(sb, inode->i_ino, inode->i_size, dir);
+	if (ret)
+		return ret;
+
+	if (ADFS_I(inode)->parent_id != dir->parent_id) {
+		adfs_error(sb,
+			   "parent directory id changed under me! (%06x but got %06x)\n",
+			   ADFS_I(inode)->parent_id, dir->parent_id);
+		adfs_dir_relse(dir);
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
 static int adfs_dir_sync(struct adfs_dir *dir)
 {
 	int err = 0;
@@ -203,7 +223,7 @@ adfs_readdir(struct file *file, struct dir_context *ctx)
 	if (ctx->pos >> 32)
 		return 0;
 
-	ret = adfs_dir_read(sb, inode->i_ino, inode->i_size, &dir);
+	ret = adfs_dir_read_inode(sb, inode, &dir);
 	if (ret)
 		return ret;
 
@@ -304,18 +324,10 @@ static int adfs_dir_lookup_byname(struct inode *inode, const struct qstr *qstr,
 	u32 name_len;
 	int ret;
 
-	ret = adfs_dir_read(sb, inode->i_ino, inode->i_size, &dir);
+	ret = adfs_dir_read_inode(sb, inode, &dir);
 	if (ret)
 		goto out;
 
-	if (ADFS_I(inode)->parent_id != dir.parent_id) {
-		adfs_error(sb,
-			   "parent directory changed under me! (%06x but got %06x)\n",
-			   ADFS_I(inode)->parent_id, dir.parent_id);
-		ret = -EIO;
-		goto free_out;
-	}
-
 	obj->parent_id = inode->i_ino;
 
 	read_lock(&adfs_dir_lock);
-- 
2.20.1

