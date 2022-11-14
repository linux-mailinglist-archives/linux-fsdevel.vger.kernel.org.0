Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD91627757
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 09:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbiKNIUE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 03:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235846AbiKNIUD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:20:03 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6DFB860
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 00:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668414002; x=1699950002;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4XYjJf9R79mlhpgXE7IyxAaK2xbiWAJxR7CsGg+iqoc=;
  b=IxcDywGF6UX4p+1apI+2X7kNgVhHqBcXlMCEbh5Mh50CTnp9WOOQ+NKY
   ukMaZcf34g5fhn5jfx4aZqkGpu8G1+KPo/sIU9Iqi/jkgJsnPg6psgZ/G
   +lAB4GOigHS+A+gwEMcYPwaDIgBxn6qxBA0ethhzBWywhl5hl+GdvRGLA
   aF3lGsA2GPdlq+XHGWSrEcKddbZbHk9eP8SQRinI1LnyQrcFjHKFKKKso
   +e2FejQSCi4IFAskjbHlzG9A6nRagmcTRuEu08lPG1SG7zPWgLSkOqwVU
   QPQsi4B+E1mFWSyWLGAVT+ri8adtayIq9rdcTKO0QxYMEvzq8kc1UAN//
   g==;
X-IronPort-AV: E=Sophos;i="5.96,161,1665417600"; 
   d="scan'208";a="328302851"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2022 16:20:02 +0800
IronPort-SDR: Wr2o8aEVdJjxuaqK8YeohDiHJu9HBHtIUPzz0OZPaV45P4Lf4igSYrgcItKFUeHLATm1e9BTfi
 4+vTgVFTGBeumGZ1DTq0LuqwnTT7xpwpS1pfXepXtvSdmPSIqvlKJSOyhZGHlH892rrafEXZIC
 IG8rTVEsSC8hKNuLnmkzWFKu8g6vTIiwTKUCLsFGPBAat+P7WblLeh44m9f/Cw2c698/RXe+Xb
 F/G7HTg80FLNf0XxxP0NCmHHtMGeeCA/FJ38gpL+psuXSUgKp8P8e6+KiSvx+9krKibFTu6JvI
 BcA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2022 23:33:17 -0800
IronPort-SDR: MTIorvSYg93JLLWxHcLu35lG4KRP5kZakr+3Fc52zHeGlCIDjBC4hEgg0GqJCxk9aI7F5RbLkS
 mhSPYBTVcMaME9lok8yo/ANDlKLoXlrRDgTBxhJb40lwMQzxHjmyoxnkML8c2mABrwx5ItUc4E
 GZnB5BQXwdvvRbiTGhnEdicCCaV1jBUQYyCyMVxdW0vKp30w3zV1fVOfskIs8LY6RG+rj66BZi
 qSO0JB/OoMMu8w7BgFh6Rn5KS8BWhiyGTuxTy3FmySQkIwlOErijoFavAJfPTjrkdoymmxTRAp
 hRM=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Nov 2022 00:20:03 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@opensource.wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2] zonefs: add sanity check for aggregated conventional zones
Date:   Mon, 14 Nov 2022 00:19:56 -0800
Message-Id: <fe0e42b533442766d941740697cd8e33fcad99ad.1668413972.git.johannes.thumshirn@wdc.com>
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
Changes to v1:
- Change IS_ERR_OR_NULL() to IS_ERR() (Damien)
- Add parentheses around 'sbi->s_features & ZONEFS_F_AGGRCNV' (Dan)
---
 fs/zonefs/super.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 860f0b1032c6..143bd018acd2 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1407,6 +1407,14 @@ static int zonefs_init_file_inode(struct inode *inode, struct blk_zone *zone,
 	zi->i_ztype = type;
 	zi->i_zsector = zone->start;
 	zi->i_zone_size = zone->len << SECTOR_SHIFT;
+	if (zi->i_zone_size > bdev_zone_sectors(sb->s_bdev) << SECTOR_SHIFT &&
+	    !(sbi->s_features & ZONEFS_F_AGGRCNV)) {
+		zonefs_err(sb,
+			   "zone size %llu doesn't match device's zone sectors %llu\n",
+			   zi->i_zone_size,
+			   bdev_zone_sectors(sb->s_bdev) << SECTOR_SHIFT);
+		return -EINVAL;
+	}
 
 	zi->i_max_size = min_t(loff_t, MAX_LFS_FILESIZE,
 			       zone->capacity << SECTOR_SHIFT);
@@ -1456,11 +1464,11 @@ static struct dentry *zonefs_create_inode(struct dentry *parent,
 	struct inode *dir = d_inode(parent);
 	struct dentry *dentry;
 	struct inode *inode;
-	int ret;
+	int ret = -ENOMEM;
 
 	dentry = d_alloc_name(parent, name);
 	if (!dentry)
-		return NULL;
+		return ERR_PTR(ret);
 
 	inode = new_inode(parent->d_sb);
 	if (!inode)
@@ -1485,7 +1493,7 @@ static struct dentry *zonefs_create_inode(struct dentry *parent,
 dput:
 	dput(dentry);
 
-	return NULL;
+	return ERR_PTR(ret);
 }
 
 struct zonefs_zone_data {
@@ -1523,8 +1531,8 @@ static int zonefs_create_zgroup(struct zonefs_zone_data *zd,
 		zgroup_name = "seq";
 
 	dir = zonefs_create_inode(sb->s_root, zgroup_name, NULL, type);
-	if (!dir) {
-		ret = -ENOMEM;
+	if (IS_ERR(dir)) {
+		ret = PTR_ERR(dir);
 		goto free;
 	}
 
@@ -1570,8 +1578,9 @@ static int zonefs_create_zgroup(struct zonefs_zone_data *zd,
 		 * Use the file number within its group as file name.
 		 */
 		snprintf(file_name, ZONEFS_NAME_MAX - 1, "%u", n);
-		if (!zonefs_create_inode(dir, file_name, zone, type)) {
-			ret = -ENOMEM;
+		dir = zonefs_create_inode(dir, file_name, zone, type);
+		if (IS_ERR(dir)) {
+			ret = PTR_ERR(dir);
 			goto free;
 		}
 
-- 
2.37.3

