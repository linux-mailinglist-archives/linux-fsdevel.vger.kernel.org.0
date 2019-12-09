Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76264116BFE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfLILK4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:10:56 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60178 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfLILK4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:10:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZhjB1PIUEBR2mcqDrigJG6bX4rlkn/rBhvZBKc+i9VE=; b=KnO7BSePdIhQItqJ8+6mE0fcUT
        ytPvDmYEzT9ho50oQG8E6jHVsx4+34ljyRbnru1xKQ+K2Vu4XxMzviBqpE0LX3D/KRyry3z+MgXaW
        hVdEgEsMfyxsFcav/9nN8yaIONh1e0jz4byvwIFrGllnhL0QxN5tRzuiQDrJsVGQg5O1rDVJr2Go0
        crGQpC8TlVF2f7t5k1FyM0SarcJrRS4dMom7959X7HV4kVqOcMZB6e0k5XIQ2RNurCtgZvfiDuWrX
        ilOpMXTGiTFw9ccAEBJZwHAJ0Y3dTdQuYUzJCh8VsOpvY05ovCnu/oDS0dcmnLK5wNgz0Ivc7ZWQ+
        9eLxe94w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:49858 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGwH-0002Wv-6o; Mon, 09 Dec 2019 11:10:53 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGwG-0004dO-MD; Mon, 09 Dec 2019 11:10:52 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 31/41] fs/adfs: bigdir: factor out directory entry offset
 calculation
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGwG-0004dO-MD@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:10:52 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out the directory entry byte offset calculation.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/dir_fplus.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index 6f2dbcf6819b..393921f5121e 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -7,6 +7,15 @@
 #include "adfs.h"
 #include "dir_fplus.h"
 
+/* Return the byte offset to directory entry pos */
+static unsigned int adfs_fplus_offset(const struct adfs_bigdirheader *h,
+				      unsigned int pos)
+{
+	return offsetof(struct adfs_bigdirheader, bigdirname) +
+	       ALIGN(le32_to_cpu(h->bigdirnamelen), 4) +
+	       pos * sizeof(struct adfs_bigdirentry);
+}
+
 static int adfs_fplus_read(struct super_block *sb, u32 indaddr,
 			   unsigned int size, struct adfs_dir *dir)
 {
@@ -83,9 +92,7 @@ adfs_fplus_getnext(struct adfs_dir *dir, struct object_info *obj)
 	if (dir->pos >= le32_to_cpu(h->bigdirentries))
 		return -ENOENT;
 
-	offset = offsetof(struct adfs_bigdirheader, bigdirname);
-	offset += ((le32_to_cpu(h->bigdirnamelen) + 4) & ~3);
-	offset += dir->pos * sizeof(struct adfs_bigdirentry);
+	offset = adfs_fplus_offset(h, dir->pos);
 
 	ret = adfs_dir_copyfrom(&bde, dir, offset,
 				sizeof(struct adfs_bigdirentry));
@@ -99,9 +106,7 @@ adfs_fplus_getnext(struct adfs_dir *dir, struct object_info *obj)
 	obj->attr     = le32_to_cpu(bde.bigdirattr);
 	obj->name_len = le32_to_cpu(bde.bigdirobnamelen);
 
-	offset = offsetof(struct adfs_bigdirheader, bigdirname);
-	offset += ((le32_to_cpu(h->bigdirnamelen) + 4) & ~3);
-	offset += le32_to_cpu(h->bigdirentries) * sizeof(struct adfs_bigdirentry);
+	offset = adfs_fplus_offset(h, le32_to_cpu(h->bigdirentries));
 	offset += le32_to_cpu(bde.bigdirobnameptr);
 
 	ret = adfs_dir_copyfrom(obj->name, dir, offset, obj->name_len);
-- 
2.20.1

