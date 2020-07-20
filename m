Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A7D225E88
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 14:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgGTM3K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 08:29:10 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:47819 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbgGTM3J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 08:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595248149; x=1626784149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cD3MeoEIMIB0q/wYOlKOlaGoZEb1Ib0D2oLnuh3P1JI=;
  b=dHPkxL4iCkTCSTCXv8kGpWDTLLKCLztQwDqnIwsoG0lf3m+O4Kwp0e4M
   jOT0XSTpRxujrx+Xn776fltmB/hy5Ho+jAYu54JX8lz2jgMBZY3v1pZZp
   3U/5I0pLxBfmg+T04N6/dmz/LMwtMB63dDYNv/Za6NHE+9VJ34gANOEfI
   XPfuFFaWn1hdBJc8SZmU0DnNvAQzC1H4Gcj+cdejrA7WVSdHJvZcU5VIs
   425tIuGEBCyKHvlqx2rAk+C2A/XSVO39Upqsk0xBWqHcBRQGtrVZUz1T0
   cvc9VGAR3A2BVJwbn/YGf5uE67kH+qSRwgO0zT2XVlSTuLNIoqdtUu2s2
   w==;
IronPort-SDR: dBItijofkJjVK2EBTvsiJVqMoizJMMupzZtMYU9CPU0kFG2VXzFOKoKWJF86BGH2Q0H+kxhSnd
 HLDO4cmkbZ8urqZ15azwigBPQ5eZE8qAv+3+MMYrw34Hect/RdOv/WLGN0q1iMooh7aZ7Fkwhd
 ZoUOV00re8Pnd/cvCOfyZAuXRRmgwahCVrvlKb46KDKsyMQOEYPY5AGeBYi4Z/YCKnFGgifAvZ
 KYWnI1GGV1weuS1hFE6U938j2GrPOkL2m2UqOG6HhfJ/85CaW1BcnjebANiZ/tJsNHtBIzjOTl
 cHY=
X-IronPort-AV: E=Sophos;i="5.75,375,1589212800"; 
   d="scan'208";a="142913128"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2020 20:29:08 +0800
IronPort-SDR: Jo+sWW9EZhli25rVav0l3EbTziHatuRbJRDOFPyzP1E9wBjB293iq0uYD2oSPUDlCE5GBjN7Ov
 ZBMdgEiKPZ1qu8UeWtoCjsPt1Zlm1etHM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 05:16:53 -0700
IronPort-SDR: 6wVYjeZfCDnTQItoXPIBqmFT74wIFo23AFds1h3hTfMlUX2+J1j58lQIiPB83ksYP2LjGH9mq/
 sDLJ+tEV6Aew==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Jul 2020 05:29:08 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 1/2] zonefs: add zone-capacity support
Date:   Mon, 20 Jul 2020 21:29:02 +0900
Message-Id: <20200720122903.6221-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720122903.6221-1-johannes.thumshirn@wdc.com>
References: <20200720122903.6221-1-johannes.thumshirn@wdc.com>
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
 fs/zonefs/super.c  | 15 +++++++++++----
 fs/zonefs/zonefs.h |  3 +++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index abfb17f88f9a..b7aefb1b896f 100644
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
@@ -1164,12 +1166,17 @@ static int zonefs_create_zgroup(struct zonefs_zone_data *zd,
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

