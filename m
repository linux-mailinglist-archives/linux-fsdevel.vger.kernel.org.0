Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7CF627D2D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 12:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbiKNL5d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 06:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237172AbiKNL5N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:57:13 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B542228B
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 03:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668426881; x=1699962881;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5o44m3XEJE6I1ZdcgsjAIXbmUn1VLlLSuJQk0HSe7V0=;
  b=AXoHWPPsGcfrHJXjqTz2FGda6TxsaLyAnjNRFfQzrHk+D0iytvwf1Can
   HLMdJ7J/3ct+Qz7X92LVZsufRWObVOEW+erkYj3EFkuwVqmPOUNvVdsG0
   IZQGgBVZhtEpWL8Xn+xFpwNOdSxW1pisef8RIUHS0XboV4slhU4ApVBlG
   hfwKuB9yojbhJ3HDZatdP/RfA/9TgfSFTq7G8TcJF96b+Qb0LQp1jS+f0
   zeQbePEd/5LfhfcamT5zXP3anjaA7RK9FCvTBXJPbnEhZOxv36Vsy8NwY
   dDAl1kSG40D5uVeWOP8M/1KkFPD89oMYdfzEaKmZgw+NLnEEDC2ZDfWcH
   w==;
X-IronPort-AV: E=Sophos;i="5.96,161,1665417600"; 
   d="scan'208";a="214486235"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2022 19:54:40 +0800
IronPort-SDR: SjJy/wGzinr1rNL8JQrZCr6OlLiCAValUM4H0sE+nOyrVxBFH+h08iq+ltxNLDZHRlDcomSegI
 d6NXI2nOGB/qrsiH3MCJ4qcuoCy0Bl4JfHWj2lU11gBz7+97mdSWCq9jvhQQUAVcgWMfdLFk4B
 1YT4DqjDKv7ee75QqpxECOruO0+UEnj/E/DfwcW6PNADC0pm9yfwunG4e+sjKhykVtkAthePH3
 DM8s7blzkatrD2r7J4IsXNN+Fj9MB1NpLAKWVy6JhH5Gva1v+4+K6xsoh/eMLFY8M4v9z2NHy7
 YK8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2022 03:13:39 -0800
IronPort-SDR: SPd4ShBpoNSMcuGT0aG33qTi8v5T8pCR6ij4Bk6TvyxuSM1XsBSTpjelaVYZkc1M2i5Ze8HZS0
 bfI6iUtp3cLUkFuJdx+Zokto32H/LyhF5kvLEUDdB+KqmtTTWD3O0DYGpCo/ThTuidnt/rmrBA
 M/rxpf+Q1X0oql+PhDbMaZcPbwrQSeVKs+CWJvm41hbJWUyAVClQdiRiAhx+g0xnpIzDmGmz6z
 LPZw6C6C2Ck7/5d6MlGgEXxDxSajira/D90sft0jGlp3N/fBn9yMUnNF0tAbv+CEFV7PEjuCdi
 VwY=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Nov 2022 03:54:40 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@opensource.wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3] zonefs: add sanity check for aggregated conventional zones
Date:   Mon, 14 Nov 2022 03:54:35 -0800
Message-Id: <9467a1aafb97779fad2288739f70082e5d65d00c.1668426869.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
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
Changes to v2:
- Don't overwrite directory for file inode creation (Damien)

Changes to v1:
- Change IS_ERR_OR_NULL() to IS_ERR() (Damien)
- Add parentheses around 'sbi->s_features & ZONEFS_F_AGGRCNV' (Dan)
---
 fs/zonefs/super.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 860f0b1032c6..d2472882bacc 100644
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
@@ -1505,7 +1513,7 @@ static int zonefs_create_zgroup(struct zonefs_zone_data *zd,
 	struct blk_zone *zone, *next, *end;
 	const char *zgroup_name;
 	char *file_name;
-	struct dentry *dir;
+	struct dentry *dir, *ret2;
 	unsigned int n = 0;
 	int ret;
 
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
+		ret2 = zonefs_create_inode(dir, file_name, zone, type);
+		if (IS_ERR(ret2)) {
+			ret = PTR_ERR(ret2);
 			goto free;
 		}
 
-- 
2.37.3

