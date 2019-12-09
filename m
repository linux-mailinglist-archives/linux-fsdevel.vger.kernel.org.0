Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0914D116BCB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfLILIn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:08:43 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:59986 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbfLILIn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:08:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/Wcogdj7yLXeYm6PyHH4xsLmTf4UVS1AuLmpoSwQ8M0=; b=xcN8uBvkbZP7C/i0UPqlgVdi8o
        u8+kzXUZtdXwzKFRxfJY4LnnXVeawmMDnVf52/Av0zWYyLZoxA6q7W7FqGtsrfBH6Py0smUeOgq2n
        gB4lMuVgq8kbe/pPIzqUYilU4yfseiKXevDJiSNmUJEO7olg/FDyBzcxiJKEH9sh75nETOalasAL6
        OBEL5sGXIoI6X37W8/yKdFYT3/RhnvXOu0n5hkYHT97fYVTzUaJdcVJ+b3xcajzvndKPd8dEFEY7d
        AJPDyHvzyGaxaiALjmU4GPrKq7L1pFwEJM8SJRXBGwYVKbPwcBdxyuM+3Xd0rBWEg4vIEyXQY28Cs
        9lkNQ1vA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:49804 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGu7-0002Sv-Ny; Mon, 09 Dec 2019 11:08:39 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGu7-0004a6-6q; Mon, 09 Dec 2019 11:08:39 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/41] fs/adfs: map: break up adfs_read_map()
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGu7-0004a6-6q@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:08:39 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split up adfs_read_map() into separate helpers to layout the map,
read the map, and release the map buffers.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/map.c | 80 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 59 insertions(+), 21 deletions(-)

diff --git a/fs/adfs/map.c b/fs/adfs/map.c
index c322d37e8f91..4b677cd5d015 100644
--- a/fs/adfs/map.c
+++ b/fs/adfs/map.c
@@ -331,12 +331,63 @@ static int adfs_checkmap(struct super_block *sb, struct adfs_discmap *dm)
 	return crosscheck == 0xff && zonecheck;
 }
 
+/*
+ * Layout the map - the first zone contains a copy of the disc record,
+ * and the last zone must be limited to the size of the filesystem.
+ */
+static void adfs_map_layout(struct adfs_discmap *dm, unsigned int nzones,
+			    struct adfs_discrecord *dr)
+{
+	unsigned int zone, zone_size;
+	u64 size;
+
+	zone_size = (8 << dr->log2secsize) - le16_to_cpu(dr->zone_spare);
+
+	dm[0].dm_bh       = NULL;
+	dm[0].dm_startblk = 0;
+	dm[0].dm_startbit = ADFS_DR_SIZE_BITS;
+	dm[0].dm_endbit   = zone_size;
+
+	for (zone = 1; zone < nzones; zone++) {
+		dm[zone].dm_bh       = NULL;
+		dm[zone].dm_startblk = zone * zone_size - ADFS_DR_SIZE_BITS;
+		dm[zone].dm_startbit = 0;
+		dm[zone].dm_endbit   = zone_size;
+	}
+
+	size = adfs_disc_size(dr) >> dr->log2bpmb;
+	size -= (nzones - 1) * zone_size - ADFS_DR_SIZE_BITS;
+	dm[nzones - 1].dm_endbit = size;
+}
+
+static int adfs_map_read(struct adfs_discmap *dm, struct super_block *sb,
+			 unsigned int map_addr, unsigned int nzones)
+{
+	unsigned int zone;
+
+	for (zone = 0; zone < nzones; zone++) {
+		dm[zone].dm_bh = sb_bread(sb, map_addr + zone);
+		if (!dm[zone].dm_bh)
+			return -EIO;
+	}
+
+	return 0;
+}
+
+static void adfs_map_relse(struct adfs_discmap *dm, unsigned int nzones)
+{
+	unsigned int zone;
+
+	for (zone = 0; zone < nzones; zone++)
+		brelse(dm[zone].dm_bh);
+}
+
 struct adfs_discmap *adfs_read_map(struct super_block *sb, struct adfs_discrecord *dr)
 {
+	struct adfs_sb_info *asb = ADFS_SB(sb);
 	struct adfs_discmap *dm;
 	unsigned int map_addr, zone_size, nzones;
-	int i, zone;
-	struct adfs_sb_info *asb = ADFS_SB(sb);
+	int ret;
 
 	nzones    = asb->s_map_size;
 	zone_size = (8 << dr->log2secsize) - le16_to_cpu(dr->zone_spare);
@@ -352,34 +403,21 @@ struct adfs_discmap *adfs_read_map(struct super_block *sb, struct adfs_discrecor
 		return ERR_PTR(-ENOMEM);
 	}
 
-	for (zone = 0; zone < nzones; zone++, map_addr++) {
-		dm[zone].dm_startbit = 0;
-		dm[zone].dm_endbit   = zone_size;
-		dm[zone].dm_startblk = zone * zone_size - ADFS_DR_SIZE_BITS;
-		dm[zone].dm_bh       = sb_bread(sb, map_addr);
+	adfs_map_layout(dm, nzones, dr);
 
-		if (!dm[zone].dm_bh) {
-			adfs_error(sb, "unable to read map");
-			goto error_free;
-		}
+	ret = adfs_map_read(dm, sb, map_addr, nzones);
+	if (ret) {
+		adfs_error(sb, "unable to read map");
+		goto error_free;
 	}
 
-	/* adjust the limits for the first and last map zones */
-	i = zone - 1;
-	dm[0].dm_startblk = 0;
-	dm[0].dm_startbit = ADFS_DR_SIZE_BITS;
-	dm[i].dm_endbit   = (adfs_disc_size(dr) >> dr->log2bpmb) +
-			    (ADFS_DR_SIZE_BITS - i * zone_size);
-
 	if (adfs_checkmap(sb, dm))
 		return dm;
 
 	adfs_error(sb, "map corrupted");
 
 error_free:
-	while (--zone >= 0)
-		brelse(dm[zone].dm_bh);
-
+	adfs_map_relse(dm, nzones);
 	kfree(dm);
 	return ERR_PTR(-EIO);
 }
-- 
2.20.1

