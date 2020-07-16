Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226B4222063
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 12:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgGPKQZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 06:16:25 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:17296 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgGPKQY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 06:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594894584; x=1626430584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZimvbAtOodbC+Wj+vWrgGscBAIioe4CPmOgrCTLikNE=;
  b=M6wphAkKuZXCsk7byu0rlkQlcH8JvsUWWu/R0pPVWPZePcBgz+zYKVS9
   +KvWAE3yqzwFTfUhnXEYoncZdyq0Qaz68UNuxkVSaZGOBwUuNdDHtP28H
   Iig3Oh2P66fzFE0v2RSPrb/RXMH+ZOn2nn3yuOvxWhmolOhzJ+3KRVMky
   1EOc7BUdkGLPFcNCZnjdXV3uemyxBjhduMSg415R6uw+AQyP1dwn5bjMy
   ePMpUVLiplWs/wQ2aDpBemOVbHlsv0j/Tx8SVxf4UV5iES0KHcC3ivVS+
   Gs8PX0F7jxZwV9s1byVsoHXqMW1I3kdGIKtm10N9MOaRlM7RSC/b/VkZo
   A==;
IronPort-SDR: 8nBfoAMZF6tn5l6XVkCAlvcenNqv2aj//7zJgRJ2y59tk5VAXqhyMYxJJEjFCeVPRduMZGAWPd
 5Z/ENgDGNn5t3+fHY9LKrQwz9YUkpbpuUSsBaLvRK+sI0ZZcnrIeO95K2cRgseaiV2KF2NR0/3
 lv+jcw3Wi5F5oAcYZbDc0Jkcmu6pnMjFDKCMTGUEWWaoxJIUu2rRxYy87yZ4fB0isQ1Rt5/luJ
 fpIfGQDL45A7pPYsBD4FFLNYErUep5+bH/azohAa507qm71lD4n+0tkkiyIPb/5fbYA0ColDPe
 0Io=
X-IronPort-AV: E=Sophos;i="5.75,358,1589212800"; 
   d="scan'208";a="146905373"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2020 18:16:23 +0800
IronPort-SDR: /vzLDTiH35qOZ0pb+vcuHJb80n6e9gjwVr0UjkN6uYFh0SrBhBl+59MZu6ovwHlSg8gTqL/Zad
 SE1+WXBGw1C5L/nziL2Q7eHrx6vS7fH0Y=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 03:04:47 -0700
IronPort-SDR: R3Qsqhi5nOyF2iOO/ti2ZcIft4v9PuY5yUA2HsQ3qda9qIJPicFTOYznV8zPVQIWLYh+GAO1P/
 UO6yU4Ftwf+g==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Jul 2020 03:16:23 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/2] zonefs: add zone-capacity support
Date:   Thu, 16 Jul 2020 19:16:13 +0900
Message-Id: <20200716101614.3468-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200716101614.3468-1-johannes.thumshirn@wdc.com>
References: <20200716101614.3468-1-johannes.thumshirn@wdc.com>
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
device. For other zoned block devices like ZBC or null_blk in zoned-mode
the zone capacity is always equal to the zone size.

Use the zone capacity field instead from blk_zone for determining the
maximum inode size and inode blocks in zonefs.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/zonefs/super.c  | 9 +++++----
 fs/zonefs/zonefs.h | 3 +++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 07bc42d62673..5b7ced5c643b 100644
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
@@ -1050,14 +1050,15 @@ static void zonefs_init_file_inode(struct inode *inode, struct blk_zone *zone,
 
 	zi->i_ztype = type;
 	zi->i_zsector = zone->start;
+	zi->i_zone_size = zone->len << SECTOR_SHIFT;
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

