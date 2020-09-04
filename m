Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0B925D761
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 13:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbgIDLcI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 07:32:08 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:15789 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730076AbgIDLYA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 07:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599218645; x=1630754645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8NFbwJj/qu2RnzEkGzAI7J/vEZCVBuM/vR4lpleySKs=;
  b=RGQInqHPzzcVqybyUHGoU5uOua1oKuHSn/ORMKaF9bJ5yXjpkMZkbXJY
   XFoVKoOHnbRDJJ5EsnC3owVrXVe08fHCXQ8TRi13yp6ocCrqgxKphl0dh
   z2maSNDTJ9fk2LklVaFBgnjTdK+7FO/9TGSNpnMauLIOIDtDpGlAHz2fo
   pYBM4uf7DkUg4Ay/UgmVrOD4vUQn0Hzr4/PVib0ilTUpPzUxoSDBSzw91
   30kVU0l3T9jCwn+WrJiXiA/GDyrZwNjpwAEYTCVPQNYJWHE5ED+BYR89/
   ldB9HEG4QfkgrhChi/t3cRcAmciyRyJ+9I4cMIVWxWTkaCXlUXOx8FhWG
   g==;
IronPort-SDR: ZUniM5WmS7Xx3MoDrX41s1MR5Dz4R4zHYqKlLYvqAd7aBlFFrM47+gHFe//a0Msft4w4QvJ3ap
 MSM7rCnTkcQWIDgxm1fJCEG4Fb/IK+LCngq470pF6/7Lkug7xkdiDv7jLlBW3dgmcXa0A5v6Z+
 AG76v1egz5HankV9uId+vfYtP5AKKD4asDB4rI9usPoq4ofDggrsRmMKlmQhV+LOhCNLnh3Jj/
 ygNHMNFSJIwsp+jJNPa0La5uHdDI4/zQYXH8ra2Zo7u+UQEHunC0JDoqcfNFD30CpbtrHNHk66
 8eE=
X-IronPort-AV: E=Sophos;i="5.76,389,1592841600"; 
   d="scan'208";a="249852276"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2020 19:24:13 +0800
IronPort-SDR: om7JpJO5S4louXNbRl6NBEHjFy2deQciC5aEhHxN5DtYFgBm0/or5xdC5imtdvchPzC7NEP3oD
 cUWP2kJ9k/mQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 04:10:08 -0700
IronPort-SDR: fKpOtxn/XdzSsWi7ajGwMgVdW0Z4QIYellAyJKrRMFWzJ7v/GtwsrspfUiIgP0UMX9b55wJJLW
 kRoHZj/IWofg==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Sep 2020 04:23:34 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/3] zonefs: introduce helper for zone management
Date:   Fri,  4 Sep 2020 20:23:26 +0900
Message-Id: <20200904112328.28887-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904112328.28887-1-johannes.thumshirn@wdc.com>
References: <20200904112328.28887-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a helper function for sending zone management commands to the
block device.

As zone management commands can change a zone write pointer position
reflected in the size of the zone file, this function expects the truncate
mutex to be held.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/zonefs/super.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 8ec7c8f109d7..9573aebee146 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -24,6 +24,26 @@
 
 #include "zonefs.h"
 
+static inline int zonefs_zone_mgmt(struct inode *inode,
+				   enum req_opf op)
+{
+	struct zonefs_inode_info *zi = ZONEFS_I(inode);
+	int ret;
+
+	lockdep_assert_held(&zi->i_truncate_mutex);
+
+	ret = blkdev_zone_mgmt(inode->i_sb->s_bdev, op, zi->i_zsector,
+			       zi->i_zone_size >> SECTOR_SHIFT, GFP_NOFS);
+	if (ret) {
+		zonefs_err(inode->i_sb,
+			   "Zone management operation %d at %llu failed %d",
+			   op, zi->i_zsector, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int zonefs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 			      unsigned int flags, struct iomap *iomap,
 			      struct iomap *srcmap)
@@ -397,12 +417,11 @@ static int zonefs_file_truncate(struct inode *inode, loff_t isize)
 	if (isize == old_isize)
 		goto unlock;
 
-	ret = blkdev_zone_mgmt(inode->i_sb->s_bdev, op, zi->i_zsector,
-			       zi->i_zone_size >> SECTOR_SHIFT, GFP_NOFS);
+	ret = zonefs_zone_mgmt(inode, op);
 	if (ret) {
 		zonefs_err(inode->i_sb,
-			   "Zone management operation at %llu failed %d",
-			   zi->i_zsector, ret);
+			   "Zone management operation %s at %llu failed %d",
+			   blk_op_str(op), zi->i_zsector, ret);
 		goto unlock;
 	}
 
-- 
2.26.2

