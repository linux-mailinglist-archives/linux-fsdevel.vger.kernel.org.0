Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104FE225A67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 10:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgGTIwN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 04:52:13 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:15083 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgGTIwN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595235132; x=1626771132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yOoJjsAFN66v8mfd33lh+d+eraORihFxqJaL6thhbIw=;
  b=gSO5YRZwcJdRNax3gia+uzEC5oTz/gwjuWtnMARq3/6yHNKPrycV7YIh
   J+g8szRaLTs2KKKcUaLummUZcbtL2JtvdbBlYKrd8hLdI6qrq2lriOU5J
   4f/OxiGLpYAk5J/VojJukmT4LlRuDKp49pK8xG4XQGjkp/XvtFlkmGv3g
   n2n8Xh6zw+q2FrH3kyadbIV8bfmJ3KC+CVHoxWp7eQ6KubAGjmAYt8gqW
   z+zzWOhkWEgsw0HnCj52hW6ZnHHvYoWsQBEFf1hEGAo5e/Iazdyotlnal
   30gKGWFWJZuHAZpOvNvQNIGbsfrewrRiCY93TP+omhVbSCvtzu5X6gH1s
   w==;
IronPort-SDR: O/seQZWZ6dGsPbdLKT8gICQKMkOXQ1opt0Y214bkj+WmjmA2fEGvlAEJrLdcEpz7dBLzuwAo3d
 KISg30sVFlwGLLHEPyo3hxxueDF1EVag5vUXjiHlzeWzpIhYZON+8DAmBZ+SDSe0vlqtS9PhRK
 rw1fMuFjKwr+OW1HEgOdKnHnN3WIlY/JQRY+x6r74PsGV/5HDlTafJk1zFlMQH/o6ay8ktmGtP
 TdlJ22ONX1pI/oLy1AVK5cNtdq1Oarpz/V5w/aBxbWYfUaXDnkg1hkyczlY807xfgNNnNdPuST
 n7o=
X-IronPort-AV: E=Sophos;i="5.75,374,1589212800"; 
   d="scan'208";a="252171862"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2020 16:52:12 +0800
IronPort-SDR: S23q9Mcp036CC0mhJOQfR4k0rVBpGNtIGtJuXYzLI2/BHEr86nW/cvjszmC/v957g2caZylB0i
 bEmezbp/UxyX9a45p0KrwuK6FvhjB9ADA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 01:40:31 -0700
IronPort-SDR: zLi5XZ1neqO8oxZ7b3Sey3H4hoZsjAMcz9yVBaFl/PLJtB4uQEF2mUMWsHNDgYOxGoIMHQHJpz
 cBFIJgZCHqyA==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Jul 2020 01:52:12 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 1/2] zonefs: add zone-capacity support
Date:   Mon, 20 Jul 2020 17:52:07 +0900
Message-Id: <20200720085208.27347-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720085208.27347-1-johannes.thumshirn@wdc.com>
References: <20200720085208.27347-1-johannes.thumshirn@wdc.com>
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
 fs/zonefs/super.c  | 11 +++++++----
 fs/zonefs/zonefs.h |  3 +++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index b13c332a3513..337249f98cae 100644
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
@@ -1051,14 +1051,16 @@ static void zonefs_init_file_inode(struct inode *inode, struct blk_zone *zone,
 
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
@@ -1169,6 +1171,7 @@ static int zonefs_create_zgroup(struct zonefs_zone_data *zd,
 				else if (next->cond == BLK_ZONE_COND_OFFLINE)
 					zone->cond = BLK_ZONE_COND_OFFLINE;
 			}
+			zone->capacity = zone->len;
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

