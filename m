Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4D4116BC8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfLILIi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:08:38 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:59980 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbfLILIi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:08:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ESwsXP7AYAG1f5qcAfMQsl5eX/MKBUlBFrnO1pq4Oxo=; b=Wcev6noWcFCWjjOe4db2oFM6Sh
        mqlWSwuxCW+JCLeIuZIiaCHuFnS+an+KVQFj+Dlh9/W6pVuTPpcWIHXd/CdhnsjvFbTwaVM4/Ym29
        xMMl8Yf+LmleUdyi4FDmH5j2g8Zt/1wPQjZO+XVmjFWq9cE2lQu4F5ruTUuxCbeMF/hr5/3/bB1BG
        k1yRuPf6tgP6KltfloKh4lKnQ9N00ZGB2T4D8+vqFx/MxBHXIaCTtSZnOdh6xwn4q+MgKBBWOQWCQ
        lFc0ToZmaxIISQ2R+MyoJP6P07yVzKjywRvnKbvflq5aYRkKopwfLPwE96u1CAjbZ67OaJsVQxCrv
        QWXeezvw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:37614 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGu2-0002So-Lx; Mon, 09 Dec 2019 11:08:34 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGu2-0004Zz-2q; Mon, 09 Dec 2019 11:08:34 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/41] fs/adfs: map: rename adfs_map_free() to
 adfs_map_statfs()
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGu2-0004Zz-2q@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:08:34 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

adfs_map_free() is not obvious whether it is freeing the map or
returning the number of free blocks on the filesystem.  Rename it to
the more generic statfs() to make it clear that it's a statistic
function.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/adfs.h  |  2 +-
 fs/adfs/map.c   | 10 +++++++---
 fs/adfs/super.c |  7 ++-----
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/adfs/adfs.h b/fs/adfs/adfs.h
index d23c84aeb6dd..45fd48fbd5e0 100644
--- a/fs/adfs/adfs.h
+++ b/fs/adfs/adfs.h
@@ -145,7 +145,7 @@ int adfs_notify_change(struct dentry *dentry, struct iattr *attr);
 
 /* map.c */
 int adfs_map_lookup(struct super_block *sb, u32 frag_id, unsigned int offset);
-extern unsigned int adfs_map_free(struct super_block *sb);
+void adfs_map_statfs(struct super_block *sb, struct kstatfs *buf);
 struct adfs_discmap *adfs_read_map(struct super_block *sb, struct adfs_discrecord *dr);
 
 /* Misc */
diff --git a/fs/adfs/map.c b/fs/adfs/map.c
index 120e01451e75..c322d37e8f91 100644
--- a/fs/adfs/map.c
+++ b/fs/adfs/map.c
@@ -5,6 +5,7 @@
  *  Copyright (C) 1997-2002 Russell King
  */
 #include <linux/slab.h>
+#include <linux/statfs.h>
 #include <asm/unaligned.h>
 #include "adfs.h"
 
@@ -221,10 +222,10 @@ static int scan_map(struct adfs_sb_info *asb, unsigned int zone,
  *  total_free = E(free_in_zone_n)
  *              nzones
  */
-unsigned int
-adfs_map_free(struct super_block *sb)
+void adfs_map_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	struct adfs_sb_info *asb = ADFS_SB(sb);
+	struct adfs_discrecord *dr = adfs_map_discrecord(asb->s_map);
 	struct adfs_discmap *dm;
 	unsigned int total = 0;
 	unsigned int zone;
@@ -236,7 +237,10 @@ adfs_map_free(struct super_block *sb)
 		total += scan_free_map(asb, dm++);
 	} while (--zone > 0);
 
-	return signed_asl(total, asb->s_map2blk);
+	buf->f_blocks  = adfs_disc_size(dr) >> sb->s_blocksize_bits;
+	buf->f_files   = asb->s_ids_per_zone * asb->s_map_size;
+	buf->f_bavail  =
+	buf->f_bfree   = signed_asl(total, asb->s_map2blk);
 }
 
 int adfs_map_lookup(struct super_block *sb, u32 frag_id, unsigned int offset)
diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index 4091adb2c7ff..458824e0ca83 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -204,16 +204,13 @@ static int adfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct super_block *sb = dentry->d_sb;
 	struct adfs_sb_info *sbi = ADFS_SB(sb);
-	struct adfs_discrecord *dr = adfs_map_discrecord(sbi->s_map);
 	u64 id = huge_encode_dev(sb->s_bdev->bd_dev);
 
+	adfs_map_statfs(sb, buf);
+
 	buf->f_type    = ADFS_SUPER_MAGIC;
 	buf->f_namelen = sbi->s_namelen;
 	buf->f_bsize   = sb->s_blocksize;
-	buf->f_blocks  = adfs_disc_size(dr) >> sb->s_blocksize_bits;
-	buf->f_files   = sbi->s_ids_per_zone * sbi->s_map_size;
-	buf->f_bavail  =
-	buf->f_bfree   = adfs_map_free(sb);
 	buf->f_ffree   = (long)(buf->f_bfree * buf->f_files) / (long)buf->f_blocks;
 	buf->f_fsid.val[0] = (u32)id;
 	buf->f_fsid.val[1] = (u32)(id >> 32);
-- 
2.20.1

