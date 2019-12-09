Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4505116BD2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfLILIz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:08:55 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60000 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbfLILIy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DTv94ZRvaL+8o6wjVGic3U5bVQTO2FaCpWDKaT5kNCM=; b=vTSDyZTctTriwQvyL9iC5qfBSs
        knotlih1Uc3CZSQ1HcCoN39uRva5I76lj1jxwniC8SP4l8MIoKJMQtMqQYKWf1qCA4g/G/70Z3PLd
        jwS69YXYgBER9xptXHtP7JyU4LsWa4mt8cJUfTVEqBfO+bYG8AAyv+XYEtpLm84JEUVDxmpwNPFA1
        Y5YxGy9hNb9PsFRvT0oobr+bgI50kfh4hCZJWrJjysann5ojw2yOrshbJrEIkMkmmLc5Kb18+/XG/
        6S/H7Amyyb96AYEo2HpxP7YRg0WvhpWJxIK/26aaTnpN/G9alB/L8f+KmjtdzobvwZzB6OzKa4Wke
        uSfwenEw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54050 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGuI-0002TA-1E; Mon, 09 Dec 2019 11:08:50 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGuH-0004aL-Fa; Mon, 09 Dec 2019 11:08:49 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/41] fs/adfs: map: incorporate map offsets into layout
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGuH-0004aL-Fa@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:08:49 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

lookup_zone() and scan_free_map() cope in different ways with the
location of the map data within a zone:

1. lookup_zone() adds a four byte offset to the map data pointer to
   skip over the check and free link bytes.

2. scan_free_map() needs to use the free link pointer, which is an
   offset from itself, so we end up adding a 32-bit offset to the
   end pointer (aka mapsize) which is really confusing.

Rename mapsize to endbit as this is really what it is, and incorporate
the 32-bit offset into the map layout.  This means that both dm_startbit
and dm_endbit are now bit offsets from the start of the buffer, rather
than four bytes in to the buffer.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/map.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/adfs/map.c b/fs/adfs/map.c
index 8ba8877110ff..55bd7c20158c 100644
--- a/fs/adfs/map.c
+++ b/fs/adfs/map.c
@@ -68,9 +68,9 @@ static DEFINE_RWLOCK(adfs_map_lock);
 static int lookup_zone(const struct adfs_discmap *dm, const unsigned int idlen,
 		       const u32 frag_id, unsigned int *offset)
 {
-	const unsigned int mapsize = dm->dm_endbit;
+	const unsigned int endbit = dm->dm_endbit;
 	const u32 idmask = (1 << idlen) - 1;
-	unsigned char *map = dm->dm_bh->b_data + 4;
+	unsigned char *map = dm->dm_bh->b_data;
 	unsigned int start = dm->dm_startbit;
 	unsigned int mapptr;
 	u32 frag;
@@ -87,7 +87,7 @@ static int lookup_zone(const struct adfs_discmap *dm, const unsigned int idlen,
 			u32 v = le32_to_cpu(_map[mapptr >> 5]) >> (mapptr & 31);
 			while (v == 0) {
 				mapptr = (mapptr & ~31) + 32;
-				if (mapptr >= mapsize)
+				if (mapptr >= endbit)
 					goto error;
 				v = le32_to_cpu(_map[mapptr >> 5]);
 			}
@@ -99,7 +99,7 @@ static int lookup_zone(const struct adfs_discmap *dm, const unsigned int idlen,
 			goto found;
 again:
 		start = mapptr;
-	} while (mapptr < mapsize);
+	} while (mapptr < endbit);
 	return -1;
 
 error:
@@ -127,7 +127,7 @@ static int lookup_zone(const struct adfs_discmap *dm, const unsigned int idlen,
 static unsigned int
 scan_free_map(struct adfs_sb_info *asb, struct adfs_discmap *dm)
 {
-	const unsigned int mapsize = dm->dm_endbit + 32;
+	const unsigned int endbit = dm->dm_endbit;
 	const unsigned int idlen  = asb->s_idlen;
 	const unsigned int frag_idlen = idlen <= 15 ? idlen : 15;
 	const u32 idmask = (1 << frag_idlen) - 1;
@@ -165,7 +165,7 @@ scan_free_map(struct adfs_sb_info *asb, struct adfs_discmap *dm)
 			u32 v = le32_to_cpu(_map[mapptr >> 5]) >> (mapptr & 31);
 			while (v == 0) {
 				mapptr = (mapptr & ~31) + 32;
-				if (mapptr >= mapsize)
+				if (mapptr >= endbit)
 					goto error;
 				v = le32_to_cpu(_map[mapptr >> 5]);
 			}
@@ -345,19 +345,19 @@ static void adfs_map_layout(struct adfs_discmap *dm, unsigned int nzones,
 
 	dm[0].dm_bh       = NULL;
 	dm[0].dm_startblk = 0;
-	dm[0].dm_startbit = ADFS_DR_SIZE_BITS;
-	dm[0].dm_endbit   = zone_size;
+	dm[0].dm_startbit = 32 + ADFS_DR_SIZE_BITS;
+	dm[0].dm_endbit   = 32 + zone_size;
 
 	for (zone = 1; zone < nzones; zone++) {
 		dm[zone].dm_bh       = NULL;
 		dm[zone].dm_startblk = zone * zone_size - ADFS_DR_SIZE_BITS;
-		dm[zone].dm_startbit = 0;
-		dm[zone].dm_endbit   = zone_size;
+		dm[zone].dm_startbit = 32;
+		dm[zone].dm_endbit   = 32 + zone_size;
 	}
 
 	size = adfs_disc_size(dr) >> dr->log2bpmb;
 	size -= (nzones - 1) * zone_size - ADFS_DR_SIZE_BITS;
-	dm[nzones - 1].dm_endbit = size;
+	dm[nzones - 1].dm_endbit = 32 + size;
 }
 
 static int adfs_map_read(struct adfs_discmap *dm, struct super_block *sb,
-- 
2.20.1

