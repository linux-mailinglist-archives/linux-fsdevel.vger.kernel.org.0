Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91AC72651DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 23:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgIJVEB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 17:04:01 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:23583 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731182AbgIJOhw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599748672; x=1631284672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4dvtpnlF8NyvTG0ZdGem9mJZVnPNlT6Y5RwZitHG5FM=;
  b=VrI4rW/fBcs1h+1Zf4HgdZbYKW6PdFdd6WaJJ4+ReQmKiiKc0Xlw16F9
   aSQXFgpdq5PozMdmDusTOoZN622KvMOXbZxyLEKzQPRC8nKSggFEk+DwD
   qhEnafJMLPVAkaOcarVhuY/g0J1s8l1PnjCF2K10FOSykD/gmgRzvbN5b
   KFDdhBHb2W48pvau6Sg1SbPayq/U58hzD11B2Ryley29D6b9WzKqo8UQC
   70g91jwXzXKzhX0s0F/ArwvNjhglt0fh1BQWa9NtTe2HLQBXd4IZCaAR7
   G43kZBYl72Lv9Hj7tU0Ooi+aC4AEPChVApRBj+ICWzxLlDkllvhlWis3z
   g==;
IronPort-SDR: bedegj7Fo5UFwfehhUqjoD0yZdGHCOTGTaOR6zn0KChE24HUgRo5B+OVQc86WW45wdaxYF7t9A
 sMqFcahYQyJ1XFj8AvqaAU6YHXaXJ6hn/zBr97ccjOI2mdaImrEwDGWPf1n1UdHcDWOWQ1IS0N
 exfKUuzmwIcUbf/+O7GUaUqaatP7uAfCnzj1KiICGFuXj362lavIo9bCvNuCyeHOtiMpq0BG/c
 uX6M7ytbuBUdnva/r/4g2PPhAQv7lliId6Bi8Qh/px0ixM6Q/OIaFN0QASbPbN504r+Rc8dOrS
 9NU=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; 
   d="scan'208";a="148261187"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2020 22:37:51 +0800
IronPort-SDR: YjXnQcuJv/KN2nXS/w+Q21pCsrmAkRuZwuu2HDGPvzn4rOHmairEpyR4w0CQ/pB9OvvUQvUqmS
 357BI9bFioMg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 07:24:14 -0700
IronPort-SDR: YozpOQOSWbyJkvWybaSEtfmE6rmcvYK+q3kCNa8GT94xYxd5Z6ja3OivBoOBvCVhmPxx64VI2+
 T3rAlBxdJQvQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Sep 2020 07:37:50 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v4 1/4] zonefs: introduce helper for zone management
Date:   Thu, 10 Sep 2020 23:37:41 +0900
Message-Id: <20200910143744.17295-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910143744.17295-1-johannes.thumshirn@wdc.com>
References: <20200910143744.17295-1-johannes.thumshirn@wdc.com>
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

