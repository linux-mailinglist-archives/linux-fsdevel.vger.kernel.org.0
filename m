Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72400116BC7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfLILId (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:08:33 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:59974 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbfLILIc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:08:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EIlvbM4MqXW73IoiKthCeiENH7tbiLGZdrP4c2G5SOo=; b=HtigAvRfscPTvdgnFdFNv5asqT
        2F+dioF5zzQ0tCdTHIjSF2Zresha2WmWeCjmI0CwGQJYtpbXdF+f0EAC5SZxwaZ0ncr+m2kMAGk1D
        I1Re2+VV4lp9vB5Yi9Q+eZlHy+/0yg6ghudD/Lb47RkNu0XXpijpsj28DhuSTn1waLG4JmPrJTqf8
        0GNpPw95WeU3YBVVsZikiPBYpORZtsYbsa5NAzgr431OnHnyQ25iYC+Ac+33NChM9MlEzvN6MVCDc
        NM6A39IjFlkAlpY4WYDOKf4zhk9E5Jv4g8jNIveYQ5PqBx2dPrdc107U5c5P97gI8NoCRbhi6yyYs
        VAdQ8l6g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:49800 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGtx-0002Sh-GF; Mon, 09 Dec 2019 11:08:29 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGtw-0004Zn-V7; Mon, 09 Dec 2019 11:08:29 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/41] fs/adfs: map: move map reading and validation to map.c
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGtw-0004Zn-V7@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:08:28 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Keep all the map code together in map.c, rather than having some in
super.c

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/adfs.h  |  1 +
 fs/adfs/map.c   | 99 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/adfs/super.c | 98 ------------------------------------------------
 3 files changed, 100 insertions(+), 98 deletions(-)

diff --git a/fs/adfs/adfs.h b/fs/adfs/adfs.h
index b7e844d2f321..d23c84aeb6dd 100644
--- a/fs/adfs/adfs.h
+++ b/fs/adfs/adfs.h
@@ -146,6 +146,7 @@ int adfs_notify_change(struct dentry *dentry, struct iattr *attr);
 /* map.c */
 int adfs_map_lookup(struct super_block *sb, u32 frag_id, unsigned int offset);
 extern unsigned int adfs_map_free(struct super_block *sb);
+struct adfs_discmap *adfs_read_map(struct super_block *sb, struct adfs_discrecord *dr);
 
 /* Misc */
 __printf(3, 4)
diff --git a/fs/adfs/map.c b/fs/adfs/map.c
index f44d12cef5be..120e01451e75 100644
--- a/fs/adfs/map.c
+++ b/fs/adfs/map.c
@@ -4,6 +4,7 @@
  *
  *  Copyright (C) 1997-2002 Russell King
  */
+#include <linux/slab.h>
 #include <asm/unaligned.h>
 #include "adfs.h"
 
@@ -280,3 +281,101 @@ int adfs_map_lookup(struct super_block *sb, u32 frag_id, unsigned int offset)
 		   frag_id, zone, asb->s_map_size);
 	return 0;
 }
+
+static unsigned char adfs_calczonecheck(struct super_block *sb, unsigned char *map)
+{
+	unsigned int v0, v1, v2, v3;
+	int i;
+
+	v0 = v1 = v2 = v3 = 0;
+	for (i = sb->s_blocksize - 4; i; i -= 4) {
+		v0 += map[i]     + (v3 >> 8);
+		v3 &= 0xff;
+		v1 += map[i + 1] + (v0 >> 8);
+		v0 &= 0xff;
+		v2 += map[i + 2] + (v1 >> 8);
+		v1 &= 0xff;
+		v3 += map[i + 3] + (v2 >> 8);
+		v2 &= 0xff;
+	}
+	v0 +=           v3 >> 8;
+	v1 += map[1] + (v0 >> 8);
+	v2 += map[2] + (v1 >> 8);
+	v3 += map[3] + (v2 >> 8);
+
+	return v0 ^ v1 ^ v2 ^ v3;
+}
+
+static int adfs_checkmap(struct super_block *sb, struct adfs_discmap *dm)
+{
+	unsigned char crosscheck = 0, zonecheck = 1;
+	int i;
+
+	for (i = 0; i < ADFS_SB(sb)->s_map_size; i++) {
+		unsigned char *map;
+
+		map = dm[i].dm_bh->b_data;
+
+		if (adfs_calczonecheck(sb, map) != map[0]) {
+			adfs_error(sb, "zone %d fails zonecheck", i);
+			zonecheck = 0;
+		}
+		crosscheck ^= map[3];
+	}
+	if (crosscheck != 0xff)
+		adfs_error(sb, "crosscheck != 0xff");
+	return crosscheck == 0xff && zonecheck;
+}
+
+struct adfs_discmap *adfs_read_map(struct super_block *sb, struct adfs_discrecord *dr)
+{
+	struct adfs_discmap *dm;
+	unsigned int map_addr, zone_size, nzones;
+	int i, zone;
+	struct adfs_sb_info *asb = ADFS_SB(sb);
+
+	nzones    = asb->s_map_size;
+	zone_size = (8 << dr->log2secsize) - le16_to_cpu(dr->zone_spare);
+	map_addr  = (nzones >> 1) * zone_size -
+		     ((nzones > 1) ? ADFS_DR_SIZE_BITS : 0);
+	map_addr  = signed_asl(map_addr, asb->s_map2blk);
+
+	asb->s_ids_per_zone = zone_size / (asb->s_idlen + 1);
+
+	dm = kmalloc_array(nzones, sizeof(*dm), GFP_KERNEL);
+	if (dm == NULL) {
+		adfs_error(sb, "not enough memory");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	for (zone = 0; zone < nzones; zone++, map_addr++) {
+		dm[zone].dm_startbit = 0;
+		dm[zone].dm_endbit   = zone_size;
+		dm[zone].dm_startblk = zone * zone_size - ADFS_DR_SIZE_BITS;
+		dm[zone].dm_bh       = sb_bread(sb, map_addr);
+
+		if (!dm[zone].dm_bh) {
+			adfs_error(sb, "unable to read map");
+			goto error_free;
+		}
+	}
+
+	/* adjust the limits for the first and last map zones */
+	i = zone - 1;
+	dm[0].dm_startblk = 0;
+	dm[0].dm_startbit = ADFS_DR_SIZE_BITS;
+	dm[i].dm_endbit   = (adfs_disc_size(dr) >> dr->log2bpmb) +
+			    (ADFS_DR_SIZE_BITS - i * zone_size);
+
+	if (adfs_checkmap(sb, dm))
+		return dm;
+
+	adfs_error(sb, "map corrupted");
+
+error_free:
+	while (--zone >= 0)
+		brelse(dm[zone].dm_bh);
+
+	kfree(dm);
+	return ERR_PTR(-EIO);
+}
diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index e0eea9adb4e6..4091adb2c7ff 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -88,51 +88,6 @@ static int adfs_checkdiscrecord(struct adfs_discrecord *dr)
 	return 0;
 }
 
-static unsigned char adfs_calczonecheck(struct super_block *sb, unsigned char *map)
-{
-	unsigned int v0, v1, v2, v3;
-	int i;
-
-	v0 = v1 = v2 = v3 = 0;
-	for (i = sb->s_blocksize - 4; i; i -= 4) {
-		v0 += map[i]     + (v3 >> 8);
-		v3 &= 0xff;
-		v1 += map[i + 1] + (v0 >> 8);
-		v0 &= 0xff;
-		v2 += map[i + 2] + (v1 >> 8);
-		v1 &= 0xff;
-		v3 += map[i + 3] + (v2 >> 8);
-		v2 &= 0xff;
-	}
-	v0 +=           v3 >> 8;
-	v1 += map[1] + (v0 >> 8);
-	v2 += map[2] + (v1 >> 8);
-	v3 += map[3] + (v2 >> 8);
-
-	return v0 ^ v1 ^ v2 ^ v3;
-}
-
-static int adfs_checkmap(struct super_block *sb, struct adfs_discmap *dm)
-{
-	unsigned char crosscheck = 0, zonecheck = 1;
-	int i;
-
-	for (i = 0; i < ADFS_SB(sb)->s_map_size; i++) {
-		unsigned char *map;
-
-		map = dm[i].dm_bh->b_data;
-
-		if (adfs_calczonecheck(sb, map) != map[0]) {
-			adfs_error(sb, "zone %d fails zonecheck", i);
-			zonecheck = 0;
-		}
-		crosscheck ^= map[3];
-	}
-	if (crosscheck != 0xff)
-		adfs_error(sb, "crosscheck != 0xff");
-	return crosscheck == 0xff && zonecheck;
-}
-
 static void adfs_put_super(struct super_block *sb)
 {
 	int i;
@@ -322,59 +277,6 @@ static const struct super_operations adfs_sops = {
 	.show_options	= adfs_show_options,
 };
 
-static struct adfs_discmap *adfs_read_map(struct super_block *sb, struct adfs_discrecord *dr)
-{
-	struct adfs_discmap *dm;
-	unsigned int map_addr, zone_size, nzones;
-	int i, zone;
-	struct adfs_sb_info *asb = ADFS_SB(sb);
-
-	nzones    = asb->s_map_size;
-	zone_size = (8 << dr->log2secsize) - le16_to_cpu(dr->zone_spare);
-	map_addr  = (nzones >> 1) * zone_size -
-		     ((nzones > 1) ? ADFS_DR_SIZE_BITS : 0);
-	map_addr  = signed_asl(map_addr, asb->s_map2blk);
-
-	asb->s_ids_per_zone = zone_size / (asb->s_idlen + 1);
-
-	dm = kmalloc_array(nzones, sizeof(*dm), GFP_KERNEL);
-	if (dm == NULL) {
-		adfs_error(sb, "not enough memory");
-		return ERR_PTR(-ENOMEM);
-	}
-
-	for (zone = 0; zone < nzones; zone++, map_addr++) {
-		dm[zone].dm_startbit = 0;
-		dm[zone].dm_endbit   = zone_size;
-		dm[zone].dm_startblk = zone * zone_size - ADFS_DR_SIZE_BITS;
-		dm[zone].dm_bh       = sb_bread(sb, map_addr);
-
-		if (!dm[zone].dm_bh) {
-			adfs_error(sb, "unable to read map");
-			goto error_free;
-		}
-	}
-
-	/* adjust the limits for the first and last map zones */
-	i = zone - 1;
-	dm[0].dm_startblk = 0;
-	dm[0].dm_startbit = ADFS_DR_SIZE_BITS;
-	dm[i].dm_endbit   = (adfs_disc_size(dr) >> dr->log2bpmb) +
-			    (ADFS_DR_SIZE_BITS - i * zone_size);
-
-	if (adfs_checkmap(sb, dm))
-		return dm;
-
-	adfs_error(sb, "map corrupted");
-
-error_free:
-	while (--zone >= 0)
-		brelse(dm[zone].dm_bh);
-
-	kfree(dm);
-	return ERR_PTR(-EIO);
-}
-
 static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct adfs_discrecord *dr;
-- 
2.20.1

