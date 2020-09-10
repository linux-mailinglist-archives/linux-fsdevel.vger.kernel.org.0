Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2D1263F39
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 10:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgIJIAV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 04:00:21 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:52846 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgIJIAM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599724813; x=1631260813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LIjT3rUT2m3DEjN9OM4NqiMjfSDKAUCzJ1GT1Ca7P3A=;
  b=RgfNe2bZZTwar+TicTO4F8mEtPr3JfFE3uyVTuyGOv+UKWSfOM5k0jEc
   ldgl8Dtqdp50iraF/8zhlz59BxZYq2BMxzPQ4MUQHt+msZFSrVcYVDPXt
   Z6b+GzzkZ9EyZkZGusQSeetsILQ9Dkgvnzt25MfecprX9iG2Q+r9MYvVU
   v31BhBRv1at5a5PhUU9ITKm9TMP7fRZZUYnpy+/OfWu4cZvJw011Mr64R
   iW6MN4qyB4qcl0GsvZZyf6BSattFcB9kmnRhgbZNIBX3EX8CrGuy1fVW5
   o1NHG2Rv+Kckkoz+Bdo/Eo++hDe4Iwphqgfo2iiWsfjGyUuAKG/w5rxfq
   A==;
IronPort-SDR: c4RWI4fJWqwBrnB8tetfccuqVfIpgMMcgZrVgdfZNJ+pZHZ3wNgEB24sk7GSZzDykjnQIJohHC
 /sRCzBzpnw3u5CM+nI4DRwaSvEottQ7fzmCJWimZVztRjQgSujQhmy11H5kRhAtCqklij9YR1h
 dYxLDL6o60z5ah4rfvWZyDAza47svkvmTJ3XdXuNK3NGzQ9b1mCmVy7a7+kfABthswbp9AMFtv
 YoD5OQZEApzE1mUe1KuN0adqVddP9GFQbc39r/TC4ECFCEWcmQYp6FSFhiIv39IPI3SrlZinjL
 Oyc=
X-IronPort-AV: E=Sophos;i="5.76,412,1592841600"; 
   d="scan'208";a="148233435"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2020 16:00:12 +0800
IronPort-SDR: v9yOl9V8Vkoz3EdK2cSG5W1kYKYKfrmqPAJQz6/n/yEH9gHILV7VV1xoeQZjR7XQc3S+2BHQ7q
 9840eh2i5+yA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 00:47:28 -0700
IronPort-SDR: /gbMXRA+rdRyk+4QR5QXEF2zaMlpTtmQm+jm6qaPUHq7IzWKb/hdoYhf8N8Q48DDBliCQMbTC3
 lqvORid3la7w==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2020 01:00:11 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 1/3] zonefs: introduce helper for zone management
Date:   Thu, 10 Sep 2020 16:59:55 +0900
Message-Id: <20200910075957.7307-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910075957.7307-1-johannes.thumshirn@wdc.com>
References: <20200910075957.7307-1-johannes.thumshirn@wdc.com>
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
Changes to v2:
- add missing '\n'

Changes to v1:
- centralize failure logging
---
 fs/zonefs/super.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 8ec7c8f109d7..6e13a5127b01 100644
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
+			   "Zone management operation %s at %llu failed %d\n",
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

