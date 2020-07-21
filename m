Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF218227FA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 14:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgGUMKe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 08:10:34 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:65330 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgGUMKd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 08:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595333473; x=1626869473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=21U3k5R5p+DeIPo1lNwTTf+Gk6af6jg2wzmt/sFHPko=;
  b=HykO7/7Y8Q+d2paSHPMidBNCXTFN9k4RBfL9gfUzzMHjZ1ZfLx/aPQZ1
   /qZE6fQLlvb0ESHNeaEVG5EnYjzMFSCwCyJmul8KMDaFcAV5Fs4ATEYDX
   FMDcnAEwsZeOV+6AnDG9BRNzEw1odpiplsJ7DS0pGIFQScEjS1Nv8tBcz
   VCw0xrpYd7hyvKtM6B5Hyj0t4+EEZrdAM4xiX/pt7GSdydArn4k2jV7sk
   IPnQ4H+Y1DBY0E8Xy3GGwsxdPyuC6uUKRFizBtCy11MgJIfjBgWHi5/A7
   krGzpqc/rQ1AL6OBuOf5BoQ4YRqCHyU6Nz9K+FhakD8oUXC3/viHPHCB2
   g==;
IronPort-SDR: CPkDoYrELHRZUuwYFDZfrB+8WGlxov37tZ7NAmeu9xZ+0fMSgVVctbhe5pdARM/JzKD4na5OBe
 WJvfI6NCOZGC9Nm7moBCbxl5u1+pB56q+6wqWGJC/oTd3KXBilZTWT7Xk5W3NhO4JHWe1NWIJm
 TfSLJyM0Bcwy8U3jTIm4t5d61eK90gpzkuf9bqkahftHJOA+oEl1KR1llpyLVMMz0hEGlkJkdR
 wMDt64J+nT+XXaFGQxFN4bmyAdDvbGP/Khp4Jui1jWBQcRsJvghswPrp85J7tdoqtOthGIyK8T
 5I0=
X-IronPort-AV: E=Sophos;i="5.75,378,1589212800"; 
   d="scan'208";a="246053969"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jul 2020 20:11:13 +0800
IronPort-SDR: UONeiopjBIHIlqUxqH1ZT4oKPZc7Wvos8d5HrME9kHylNnnhoelsuyZVP9DD6RbvoU1g3yLhmt
 7X4Tw6TWIc/pwzN3jRC48Q1ypn7wWpyXk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 04:58:15 -0700
IronPort-SDR: Rs4FY9SZIvR2u2/t7MANyPkMZGe3C46XHd/sAvufodxypTwJv3cPNM62Ebb3rzuOIdigz9/oU8
 Pc3gjRNTFbZg==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Jul 2020 05:10:33 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 1/2] zonefs: add zone-capacity support
Date:   Tue, 21 Jul 2020 21:10:26 +0900
Message-Id: <20200721121027.23451-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200721121027.23451-1-johannes.thumshirn@wdc.com>
References: <20200721121027.23451-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the zoned storage model, the sectors within a zone are typically all
writeable. With the introduction of the Zoned Namespace (ZNS) Command
Set in the NVM Express organization, the model was extended to have a
specific writeable capacity.

This zone capacity can be less than the overall zone size for a NVMe ZNS
device or null_blk in zoned-mode. For other ZBC/ZAC devices the zone
capacity is always equal to the zone size.

Use the zone capacity field instead from blk_zone for determining the
maximum inode size and inode blocks in zonefs.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/zonefs/super.c  | 16 ++++++++++++----
 fs/zonefs/zonefs.h |  3 +++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index abfb17f88f9a..9215ef9e0571 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -335,7 +335,7 @@ static void zonefs_io_error(struct inode *inode, bool write)
 	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
 	unsigned int noio_flag;
 	unsigned int nr_zones =
-		zi->i_max_size >> (sbi->s_zone_sectors_shift + SECTOR_SHIFT);
+		zi->i_zone_size >> (sbi->s_zone_sectors_shift + SECTOR_SHIFT);
 	struct zonefs_ioerr_data err = {
 		.inode = inode,
 		.write = write,
@@ -398,7 +398,7 @@ static int zonefs_file_truncate(struct inode *inode, loff_t isize)
 		goto unlock;
 
 	ret = blkdev_zone_mgmt(inode->i_sb->s_bdev, op, zi->i_zsector,
-			       zi->i_max_size >> SECTOR_SHIFT, GFP_NOFS);
+			       zi->i_zone_size >> SECTOR_SHIFT, GFP_NOFS);
 	if (ret) {
 		zonefs_err(inode->i_sb,
 			   "Zone management operation at %llu failed %d",
@@ -1050,14 +1050,16 @@ static void zonefs_init_file_inode(struct inode *inode, struct blk_zone *zone,
 
 	zi->i_ztype = type;
 	zi->i_zsector = zone->start;
+	zi->i_zone_size = zone->len << SECTOR_SHIFT;
+
 	zi->i_max_size = min_t(loff_t, MAX_LFS_FILESIZE,
-			       zone->len << SECTOR_SHIFT);
+			       zone->capacity << SECTOR_SHIFT);
 	zi->i_wpoffset = zonefs_check_zone_condition(inode, zone, true, true);
 
 	inode->i_uid = sbi->s_uid;
 	inode->i_gid = sbi->s_gid;
 	inode->i_size = zi->i_wpoffset;
-	inode->i_blocks = zone->len;
+	inode->i_blocks = zi->i_max_size >> SECTOR_SHIFT;
 
 	inode->i_op = &zonefs_file_inode_operations;
 	inode->i_fop = &zonefs_file_operations;
@@ -1164,12 +1166,18 @@ static int zonefs_create_zgroup(struct zonefs_zone_data *zd,
 				if (zonefs_zone_type(next) != type)
 					break;
 				zone->len += next->len;
+				zone->capacity += next->capacity;
 				if (next->cond == BLK_ZONE_COND_READONLY &&
 				    zone->cond != BLK_ZONE_COND_OFFLINE)
 					zone->cond = BLK_ZONE_COND_READONLY;
 				else if (next->cond == BLK_ZONE_COND_OFFLINE)
 					zone->cond = BLK_ZONE_COND_OFFLINE;
 			}
+			if (zone->capacity != zone->len) {
+				zonefs_err(sb, "Invalid conventional zone capacity\n");
+				ret = -EINVAL;
+				goto free;
+			}
 		}
 
 		/*
diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
index ad17fef7ce91..55b39970acb2 100644
--- a/fs/zonefs/zonefs.h
+++ b/fs/zonefs/zonefs.h
@@ -56,6 +56,9 @@ struct zonefs_inode_info {
 	/* File maximum size */
 	loff_t			i_max_size;
 
+	/* File zone size */
+	loff_t			i_zone_size;
+
 	/*
 	 * To serialise fully against both syscall and mmap based IO and
 	 * sequential file truncation, two locks are used. For serializing
-- 
2.26.2

