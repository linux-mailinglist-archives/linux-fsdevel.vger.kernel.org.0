Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D327A262D04
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 12:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgIIK1D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 06:27:03 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:43807 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgIIK0e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 06:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599647194; x=1631183194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WII/fNe9AqpyUS4G2Rrf4+UgqqJabIxQGisG0W1rEJ0=;
  b=KwXsGz1Dgsd+Zix+3qgDwrWH1jPfK1Vk8cq+p0/ASR7bxJB5ivnV+TJp
   9VZaN7ObA6wEDZ2wdr8jtNmaM0QYMJMIOXLttfIvAnQBniu+AxsV2xv8c
   vKZmoDWCypjGs4k9qbWlQcpHd2pqSFfKHtMQvKT+dVtsjmqMAoWBy3tui
   bi6p7Cs5Xm3ikGE7LQl3uhrf+g5DXFYV3VTgpUlnrX/1RT/nDV5LnQptu
   72CHd8L0qH/s5jWmjUbVIBfqMscsNyhJ9sMdiEGparWMs1V396sjX/Cnx
   QATzP6Yccu68ND6EsF9T025IdqPRUF7VFwGyDmAF57DSqcNquw+OavAge
   w==;
IronPort-SDR: pC8apetMp/Vzn6gPTGJ7q7hH2Hon1SPHqakr8kec1Hny4Rwe9C3a3/TArEmu/k2KBbfXZt2nyD
 MFMBfBHbHBabOe4tBsu7wEyRLTUzDszJz9iJkG8aAOMWmr/wGBFWv7Xuz9/ImhctoOyr3Lywve
 G83IXznHuI0U6jO164T5Wwq2MOlLkRmaBHkVB2+rPyt5qLdI5P/ovnvWzFSG71eAVZ4Ab3iI1M
 fAx8Owqml023CVNzlblCt5P+xuOjdoYmC7V65GbDbARjBdGgPj+epGfp51z20doyxrnrw9dCv9
 B6s=
X-IronPort-AV: E=Sophos;i="5.76,409,1592841600"; 
   d="scan'208";a="256500002"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2020 18:26:32 +0800
IronPort-SDR: /zRgzl5/K8OivQgTKu/wfqmKiHxVJDLNscQ+Uw9esH9pXO8jlUkSeBGYyeaNDtY6fIQ0YMoZOR
 kaDNXOhjjYHQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 03:13:50 -0700
IronPort-SDR: iAfwNAX0M4VpdNDHpfmR6U84DIQ4pAwPt9nGQUV4pGkmz5fYkE3dwCOWyLcmFKI+Ry4c//LTbg
 ws4mefrQ4Olg==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Sep 2020 03:26:31 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 1/3] zonefs: introduce helper for zone management
Date:   Wed,  9 Sep 2020 19:26:12 +0900
Message-Id: <20200909102614.40585-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909102614.40585-1-johannes.thumshirn@wdc.com>
References: <20200909102614.40585-1-johannes.thumshirn@wdc.com>
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
Changes to v1:
- centralize failure logging
---
 fs/zonefs/super.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 8ec7c8f109d7..dc828bd1210b 100644
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
+			   "Zone management operation %s at %llu failed %d",
+			   blk_op_str(op), zi->i_zsector, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int zonefs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 			      unsigned int flags, struct iomap *iomap,
 			      struct iomap *srcmap)
@@ -397,14 +417,9 @@ static int zonefs_file_truncate(struct inode *inode, loff_t isize)
 	if (isize == old_isize)
 		goto unlock;
 
-	ret = blkdev_zone_mgmt(inode->i_sb->s_bdev, op, zi->i_zsector,
-			       zi->i_zone_size >> SECTOR_SHIFT, GFP_NOFS);
-	if (ret) {
-		zonefs_err(inode->i_sb,
-			   "Zone management operation at %llu failed %d",
-			   zi->i_zsector, ret);
+	ret = zonefs_zone_mgmt(inode, op);
+	if (ret)
 		goto unlock;
-	}
 
 	zonefs_update_stats(inode, isize);
 	truncate_setsize(inode, isize);
-- 
2.26.2

