Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A7D265C0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 10:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgIKI5M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 04:57:12 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:58877 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgIKI47 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599814619; x=1631350619;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eWTIxp/RmEqVjo//4W1v8lFGYCXvB0lWyzCjmwLgssQ=;
  b=h466maQg+JWtxSUEZThwWeNmByMaeyl5gCtoyV1ykrVOLAlC61mUnTbe
   dCZc5v3HxMcUo5lJbDXMw3ZQ8J2cwYRAChLnjwwbabSRYv0se1dUF7P0F
   SVKVxlReS3Ngd/AJThTvzS2LGiZ06jPmDlIbavm3HTyHP5maTG1qg+UcX
   k+z9+FCqFl0fzDH2qGtLc1Yi7MP3c0qsq5hBJXoiQR1MjUandDiXbbluR
   bzRnAhOkf/2y9KO5CTzy5S/i43hUoMaOxZ9O5J88/V/Ns30XCH36jTBdB
   Ky2MKDldDTi1FXd8BGXY5GFdvLwjEDfpJYPTFJk3s/qt2WTWhZYgpUxYF
   A==;
IronPort-SDR: 8GxdoOYe1dyDbUjI8l8i9XbdwOd5M9T+Ggzp0OFYqplOPZlKlrULUUbYD6wkqMNQ7CNz5jfnGC
 45MPbwYW0JwywLt7I4mSPlyBCf/5yY56Ca9GPLmXwhr7cxjBr7nh49EsiqXAtCOegD/2r094dk
 zL0zVO8A6yZ6ym9ty39MX6IOmeSg2cJ3qjWOpZSt+AWtQYBopHk5NYKONsvzRTNUX2MLYHprgS
 T8nKQxEEahOrIZ6CY+dNfiHPU3mUFbmyIsBX2Phr4XZPmtjdqPD55WencZAS2jlSq5uPrdkuFc
 mDQ=
X-IronPort-AV: E=Sophos;i="5.76,414,1592841600"; 
   d="scan'208";a="147041238"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 16:56:58 +0800
IronPort-SDR: Uja5UuRU+VS/6mAa3B0QpVSZhliuObIUFImvrOMdYEpsFJQ2lPQQJuYHwtzzL0pcOJqRs+Kztx
 QM2CuFzXoUKg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 01:44:15 -0700
IronPort-SDR: 6eQNwI1ncrYWuoPGTXz9u+ED9CmIi7SIRnI23c0DiO488MA7WlokYqh8akhYN9K5qSdClWi0Hl
 VIpzQqQOK8Yw==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Sep 2020 01:56:57 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v5 1/4] zonefs: introduce helper for zone management
Date:   Fri, 11 Sep 2020 17:56:48 +0900
Message-Id: <20200911085651.23526-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200911085651.23526-1-johannes.thumshirn@wdc.com>
References: <20200911085651.23526-1-johannes.thumshirn@wdc.com>
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
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
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

