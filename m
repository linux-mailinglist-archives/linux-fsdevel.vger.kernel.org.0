Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC5A438B7A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbfFGNSY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:18:24 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:56479 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbfFGNSX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913540; x=1591449540;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iPnY+83avGj3yJ6GvVf5GDtpfB2HkmMtBeQYtYkFtCA=;
  b=dhkfs/yCkxli/vSL4lI561yxGXW8nsuaC6bbtH2QtgpvlfnzTdandgN1
   WMchXRpHwv/LR29QLhwmyzZ4U79bWv+ESrU1bGyP5NhquBDBL1cdiJdlV
   iNSgJG7H9CeKCjqDez415Ov5XjYEXi0T6HyQYnQTxhfD3E2a+MfWI3f8p
   WVSZV+ppqJ2Quw74RFwPrwK/NF62p1rk+lIL4vyaT+oz4N9WZ2Lh5J0PK
   jRbaq9AzocK0LsqYTG2S7vgT/5W1GIUziE0KYnsg4YR7tPzla11UYCVu1
   OxLHPLJw420bNGBZ4g3uenMdFomE2i452HPkIfU7iEDmBQUk6bnfjlGK5
   w==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="209675029"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:19:00 +0800
IronPort-SDR: vJUeiJMjh7t5JmiMPjQ+lH1OhAaVFWIC4Vvx6UM4KWCDwySbrj7DSmgKksbZALyvz5TDpbBAad
 OXIqeKbmme67tlZbxEx1tHaPj37QOTDLLZb+OgoKRM1DvQenVz8spBIlMU4k8MvcI3FryjRXo9
 SKaE707xwV4PI1xSSN3EKz+qr4iEA0Pkl9Roay/fkOajNh6WZaCNlAnC8kigMnE9kFY+83L+zV
 ARVA5On+/mUA6fPQGYjX06PhzSSQOcNsNzz+cD5LYRLwK+f0Jp7so+T4davJqpnrBcJUlx9hfn
 KpcTE+6xPtcn5ySF+DMPmW18
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:55:40 -0700
IronPort-SDR: zYF9CF8Fzm1lHiV3A3KmeqXQyik2i6J5T3nJ/725Knt6b6kkQXFan4nNmEL9aMiLdPiCO17qeh
 CV/7PmRS3oGke77YGXDan9iyuDX62Mnanh70ID+EhhKXKOwLKS4ctRdlCgMz66lqsSfdxiXvYO
 V3Mz2QE35cSRsMIbO7Nzua8It+xVqCDWLZVlo/n79y3VKupDcjOpAJHB9OOp0MseBXpQLvuC4e
 fx46fUkwzdf16Jh91P7AmT8GdZwUMgpI+AIZgJwfydQig4+mGpnpxUpFJjrfsDY4F/1e7u///w
 S/Y=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:18:21 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 10/12] btrfs-progs: mkfs: Zoned block device support
Date:   Fri,  7 Jun 2019 22:17:49 +0900
Message-Id: <20190607131751.5359-10-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607131751.5359-1-naohiro.aota@wdc.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131751.5359-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch makes the size of the temporary system group chunk equal to the
device zone size. It also enables PREP_DEVICE_HMZONED if the user enables
the HMZONED feature.

Enabling HMZONED feature is done using option "-O hmzoned". This feature is
incompatible for now with source directory setup.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 mkfs/common.c | 12 +++++++-----
 mkfs/common.h |  1 +
 mkfs/main.c   | 45 +++++++++++++++++++++++++++++++++++++++------
 3 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index f7e3badcf2b9..12af54c1d886 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -152,6 +152,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	int skinny_metadata = !!(cfg->features &
 				 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA);
 	u64 num_bytes;
+	u64 system_group_size;
 
 	buf = malloc(sizeof(*buf) + max(cfg->sectorsize, cfg->nodesize));
 	if (!buf)
@@ -312,12 +313,14 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_item_offset(buf, btrfs_item_nr(nritems), itemoff);
 	btrfs_set_item_size(buf, btrfs_item_nr(nritems), item_size);
 
+	system_group_size = (cfg->features & BTRFS_FEATURE_INCOMPAT_HMZONED) ?
+		cfg->zone_size : BTRFS_MKFS_SYSTEM_GROUP_SIZE;
+
 	dev_item = btrfs_item_ptr(buf, nritems, struct btrfs_dev_item);
 	btrfs_set_device_id(buf, dev_item, 1);
 	btrfs_set_device_generation(buf, dev_item, 0);
 	btrfs_set_device_total_bytes(buf, dev_item, num_bytes);
-	btrfs_set_device_bytes_used(buf, dev_item,
-				    BTRFS_MKFS_SYSTEM_GROUP_SIZE);
+	btrfs_set_device_bytes_used(buf, dev_item, system_group_size);
 	btrfs_set_device_io_align(buf, dev_item, cfg->sectorsize);
 	btrfs_set_device_io_width(buf, dev_item, cfg->sectorsize);
 	btrfs_set_device_sector_size(buf, dev_item, cfg->sectorsize);
@@ -345,7 +348,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_item_size(buf, btrfs_item_nr(nritems), item_size);
 
 	chunk = btrfs_item_ptr(buf, nritems, struct btrfs_chunk);
-	btrfs_set_chunk_length(buf, chunk, BTRFS_MKFS_SYSTEM_GROUP_SIZE);
+	btrfs_set_chunk_length(buf, chunk, system_group_size);
 	btrfs_set_chunk_owner(buf, chunk, BTRFS_EXTENT_TREE_OBJECTID);
 	btrfs_set_chunk_stripe_len(buf, chunk, BTRFS_STRIPE_LEN);
 	btrfs_set_chunk_type(buf, chunk, BTRFS_BLOCK_GROUP_SYSTEM);
@@ -411,8 +414,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 		    (unsigned long)btrfs_dev_extent_chunk_tree_uuid(dev_extent),
 		    BTRFS_UUID_SIZE);
 
-	btrfs_set_dev_extent_length(buf, dev_extent,
-				    BTRFS_MKFS_SYSTEM_GROUP_SIZE);
+	btrfs_set_dev_extent_length(buf, dev_extent, system_group_size);
 	nritems++;
 
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_DEV_TREE]);
diff --git a/mkfs/common.h b/mkfs/common.h
index 28912906d0a9..d0e4c7b2c906 100644
--- a/mkfs/common.h
+++ b/mkfs/common.h
@@ -53,6 +53,7 @@ struct btrfs_mkfs_config {
 	u64 features;
 	/* Size of the filesystem in bytes */
 	u64 num_bytes;
+	u64 zone_size;
 
 	/* Output fields, set during creation */
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 93c0b71c864e..cbfd45bee836 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -61,8 +61,12 @@ static int create_metadata_block_groups(struct btrfs_root *root, int mixed,
 	u64 bytes_used;
 	u64 chunk_start = 0;
 	u64 chunk_size = 0;
+	u64 system_group_size = 0;
 	int ret;
 
+	system_group_size = fs_info->fs_devices->hmzoned ?
+		fs_info->fs_devices->zone_size : BTRFS_MKFS_SYSTEM_GROUP_SIZE;
+
 	trans = btrfs_start_transaction(root, 1);
 	BUG_ON(IS_ERR(trans));
 	bytes_used = btrfs_super_bytes_used(fs_info->super_copy);
@@ -75,8 +79,8 @@ static int create_metadata_block_groups(struct btrfs_root *root, int mixed,
 	ret = btrfs_make_block_group(trans, fs_info, bytes_used,
 				     BTRFS_BLOCK_GROUP_SYSTEM,
 				     BTRFS_BLOCK_RESERVED_1M_FOR_SUPER,
-				     BTRFS_MKFS_SYSTEM_GROUP_SIZE);
-	allocation->system += BTRFS_MKFS_SYSTEM_GROUP_SIZE;
+				     system_group_size);
+	allocation->system += system_group_size;
 	if (ret)
 		return ret;
 
@@ -761,6 +765,7 @@ int main(int argc, char **argv)
 	int metadata_profile_opt = 0;
 	int discard = 1;
 	int ssd = 0;
+	int hmzoned = 0;
 	int force_overwrite = 0;
 	char *source_dir = NULL;
 	bool source_dir_set = false;
@@ -774,6 +779,7 @@ int main(int argc, char **argv)
 	u64 features = BTRFS_MKFS_DEFAULT_FEATURES;
 	struct mkfs_allocation allocation = { 0 };
 	struct btrfs_mkfs_config mkfs_cfg;
+	u64 system_group_size;
 
 	while(1) {
 		int c;
@@ -896,6 +902,8 @@ int main(int argc, char **argv)
 	if (dev_cnt == 0)
 		print_usage(1);
 
+	hmzoned = features & BTRFS_FEATURE_INCOMPAT_HMZONED;
+
 	if (source_dir_set && dev_cnt > 1) {
 		error("the option -r is limited to a single device");
 		goto error;
@@ -905,6 +913,11 @@ int main(int argc, char **argv)
 		goto error;
 	}
 
+	if (source_dir_set && hmzoned) {
+		error("The -r and hmzoned feature are incompatible\n");
+		exit(1);
+	}
+
 	if (*fs_uuid) {
 		uuid_t dummy_uuid;
 
@@ -936,6 +949,16 @@ int main(int argc, char **argv)
 
 	file = argv[optind++];
 	ssd = is_ssd(file);
+	if (hmzoned) {
+		if (zoned_model(file) == ZONED_NONE) {
+			error("%s: not a zoned block device\n", file);
+			exit(1);
+		}
+		if (!zone_size(file)) {
+			error("%s: zone size undefined\n", file);
+			exit(1);
+		}
+	}
 
 	/*
 	* Set default profiles according to number of added devices.
@@ -1087,7 +1110,8 @@ int main(int argc, char **argv)
 	ret = btrfs_prepare_device(fd, file, &dev_block_count, block_count,
 			(zero_end ? PREP_DEVICE_ZERO_END : 0) |
 			(discard ? PREP_DEVICE_DISCARD : 0) |
-			(verbose ? PREP_DEVICE_VERBOSE : 0));
+			(verbose ? PREP_DEVICE_VERBOSE : 0) |
+			(hmzoned ? PREP_DEVICE_HMZONED : 0));
 	if (ret)
 		goto error;
 	if (block_count && block_count > dev_block_count) {
@@ -1098,9 +1122,11 @@ int main(int argc, char **argv)
 	}
 
 	/* To create the first block group and chunk 0 in make_btrfs */
-	if (dev_block_count < BTRFS_MKFS_SYSTEM_GROUP_SIZE) {
+	system_group_size = hmzoned ?
+		zone_size(file) : BTRFS_MKFS_SYSTEM_GROUP_SIZE;
+	if (dev_block_count < system_group_size) {
 		error("device is too small to make filesystem, must be at least %llu",
-				(unsigned long long)BTRFS_MKFS_SYSTEM_GROUP_SIZE);
+				(unsigned long long)system_group_size);
 		goto error;
 	}
 
@@ -1116,6 +1142,7 @@ int main(int argc, char **argv)
 	mkfs_cfg.sectorsize = sectorsize;
 	mkfs_cfg.stripesize = stripesize;
 	mkfs_cfg.features = features;
+	mkfs_cfg.zone_size = zone_size(file);
 
 	ret = make_btrfs(fd, &mkfs_cfg);
 	if (ret) {
@@ -1126,6 +1153,7 @@ int main(int argc, char **argv)
 
 	fs_info = open_ctree_fs_info(file, 0, 0, 0,
 			OPEN_CTREE_WRITES | OPEN_CTREE_TEMPORARY_SUPER);
+
 	if (!fs_info) {
 		error("open ctree failed");
 		goto error;
@@ -1199,7 +1227,8 @@ int main(int argc, char **argv)
 				block_count,
 				(verbose ? PREP_DEVICE_VERBOSE : 0) |
 				(zero_end ? PREP_DEVICE_ZERO_END : 0) |
-				(discard ? PREP_DEVICE_DISCARD : 0));
+				(discard ? PREP_DEVICE_DISCARD : 0) |
+				(hmzoned ? PREP_DEVICE_HMZONED : 0));
 		if (ret) {
 			goto error;
 		}
@@ -1296,6 +1325,10 @@ raid_groups:
 			btrfs_group_profile_str(metadata_profile),
 			pretty_size(allocation.system));
 		printf("SSD detected:       %s\n", ssd ? "yes" : "no");
+		printf("Zoned device:       %s\n", hmzoned ? "yes" : "no");
+		if (hmzoned)
+			printf("Zone size:          %s\n",
+			       pretty_size(fs_info->fs_devices->zone_size));
 		btrfs_parse_features_to_string(features_buf, features);
 		printf("Incompat features:  %s", features_buf);
 		printf("\n");
-- 
2.21.0

