Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1586617AD9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 11:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiKCKcj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 06:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiKCKcg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:32:36 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7862610542
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 03:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667471555; x=1699007555;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E1ItmCFHI9QBXk8Gssm1anKLmICcLfK+mW/u6S3ac2I=;
  b=k3B9qSZDV4a3aLXqrvWlrxZcgA43UgEbR0mdGOorcGcEWUeb9jtYr0ou
   wuqgNUqDlyJB57H2/vc+MGYC2ZOin1m2Ca+n3GuLQfqeWnBxYl4eZ7UfM
   vY00PJCYfwxR3kxxMIwxKIZ8VtejX6M9+cNVZydVI/ctAQ5iZNUezMGkb
   kfkDXbve3sDjqGHmg/9Y3HaRZZanaPsfhz/ktsHcHg0d9a5U3I+Ba8kRv
   a1dJip0PifCFaagzNQZul2obZJtxAXhBL2cnl+gNiwbcl9IRC4ESYnIEa
   K57l69aTVDt080umxxO5I31YqdQMqlakZTeY6DwUakhZF++czQo2QmsTD
   w==;
X-IronPort-AV: E=Sophos;i="5.95,235,1661788800"; 
   d="scan'208";a="327495610"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2022 18:32:34 +0800
IronPort-SDR: zbTkSizoXhSYDshavkDSB0kaMYi9Vgsey0ksqrd4cj579ePRDEHXzf6tFhmfajMH+menIZHUeO
 PUCeBWnPeICnlA3fZd1qi8raxKD+wvkbmVHYXqhLpx8RjLWX+6wnszwfNMccJEp4CobDkkQRyZ
 ARnsmANd1LVtnVif97ZRVr74D7P1Y3VYEDYybDBwg0MwFA4sKiI2Zzu95cUkhkR2c16R3B/vy1
 dNYrAHCjE652Pvy5g5IAgXYZKcgoVxaUHgyR9ysbHxJORnvjG6AYkdqNREeBDRPjjJ3fSq/T4X
 yl4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Nov 2022 02:46:02 -0700
IronPort-SDR: bPincNDoR++Yv9dDp9m1190jFIhtK5C4Vl1b4uM5KMgXWUnXqnot2CwM3uIgtEL8TKChZXUL22
 R152kdq+cbaruK+Qssy5XvKONa0BD0ZPQvDox+t5KlopCnSnDvbmBTz+gAOMJ36TXYmxW8Qw03
 P8gfJEk8p8Hi2a5v+bnkAdhwoM3hAHegFquzBbwb3W2X/BOUvJxNMxo99YZ05iuyV64NJPXQdE
 khOyXQDMOCE1qV5WzGchbW2HzeEgmQOXUpksfL9lvFkqQK2m9lyDYFH4NPY/P4oLr/i6lxBJGB
 OuE=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Nov 2022 03:32:34 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@opensource.wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] zonefs: add sanity check for aggregated conventional zones
Date:   Thu,  3 Nov 2022 03:32:25 -0700
Message-Id: <f7e4afaca0eb337bf18231358b7e764d4cdf5c5a.1667471410.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When initializing a file inode, check if the zone's size if bigger than
the number of device zone sectors. This can only be the case if we mount
the filesystem with the -oaggr_cnv mount option.

Emit an error in case this case happens and fail the mount.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/zonefs/super.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 860f0b1032c6..605364638720 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1407,6 +1407,14 @@ static int zonefs_init_file_inode(struct inode *inode, struct blk_zone *zone,
 	zi->i_ztype = type;
 	zi->i_zsector = zone->start;
 	zi->i_zone_size = zone->len << SECTOR_SHIFT;
+	if (zi->i_zone_size > bdev_zone_sectors(sb->s_bdev) << SECTOR_SHIFT &&
+	    !sbi->s_features & ZONEFS_F_AGGRCNV) {
+		zonefs_err(sb,
+			   "zone size %llu doesn't match device's zone sectors %llu\n",
+			   zi->i_zone_size,
+			   bdev_zone_sectors(sb->s_bdev) << SECTOR_SHIFT);
+		return -EINVAL;
+	}
 
 	zi->i_max_size = min_t(loff_t, MAX_LFS_FILESIZE,
 			       zone->capacity << SECTOR_SHIFT);
@@ -1485,7 +1493,7 @@ static struct dentry *zonefs_create_inode(struct dentry *parent,
 dput:
 	dput(dentry);
 
-	return NULL;
+	return ERR_PTR(ret);
 }
 
 struct zonefs_zone_data {
@@ -1505,7 +1513,7 @@ static int zonefs_create_zgroup(struct zonefs_zone_data *zd,
 	struct blk_zone *zone, *next, *end;
 	const char *zgroup_name;
 	char *file_name;
-	struct dentry *dir;
+	struct dentry *dir, *ret2;
 	unsigned int n = 0;
 	int ret;
 
@@ -1523,8 +1531,11 @@ static int zonefs_create_zgroup(struct zonefs_zone_data *zd,
 		zgroup_name = "seq";
 
 	dir = zonefs_create_inode(sb->s_root, zgroup_name, NULL, type);
-	if (!dir) {
-		ret = -ENOMEM;
+	if (IS_ERR_OR_NULL(dir)) {
+		if (!dir)
+			ret = -ENOMEM;
+		else
+			ret = PTR_ERR(dir);
 		goto free;
 	}
 
@@ -1570,8 +1581,12 @@ static int zonefs_create_zgroup(struct zonefs_zone_data *zd,
 		 * Use the file number within its group as file name.
 		 */
 		snprintf(file_name, ZONEFS_NAME_MAX - 1, "%u", n);
-		if (!zonefs_create_inode(dir, file_name, zone, type)) {
-			ret = -ENOMEM;
+		ret2 = zonefs_create_inode(dir, file_name, zone, type);
+		if (IS_ERR_OR_NULL(ret2)) {
+			if (!ret2)
+				ret = -ENOMEM;
+			else
+				ret = PTR_ERR(ret2);
 			goto free;
 		}
 
-- 
2.37.3

