Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F47138B71
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfFGNSR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:18:17 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:56479 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbfFGNSR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913530; x=1591449530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R36dF+7nZi2WAiLjfSgK/nhq+RPyynPLz4Nk77Mne08=;
  b=ORCf4r26XpD8cowvkyz5uSHJSYmlO6YJd7h0z3ixDRrbKcZOPxadKw30
   TWeowZGuHUGhJk8xWV2XtOHPX8ZK+rovWI2R+oOPwQm0OdMMbM86mBZDa
   SDyoraSJwRw/+NpuDBLWxeyNp+oo4gUMOTosLXTZ0xwkfZ0d7TvLn+h0v
   3+opRaEKyA+cD2NmzOshggI+mCKi66ZaJt9ogGI7vtTwEYFGu1qbJZtur
   7rIOvmzLnAl61ET6cCBOUbOz/6OH0rrdjZbsixQlm3IIclLrLvVenPnWK
   lW7X9F7R56Jwk2QMHrC1y+ACpLp12CtlnBHyi5sMoAka+24c/VsiP+TGa
   g==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="209675011"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:18:49 +0800
IronPort-SDR: TSp0czc6XgGVtJw41zWmdI3JZINXupRRMQDuZssPw6thlG57X5DbJxChz4v+pmnCZSxv22XWYQ
 GL3zzmhztjOZKpmsjYa2H7O+cEEGfU8SSQZsY1uGMozbw26mvzsULf8hftWfqZGtcbXR5VCmwn
 z9gYa5tQtxcHFnM2VF6khiSe9kF3ZTdNH6vnXGPzNwpz7AgpZDffjSc+TngpIkpKD+BkcznDFh
 uLwYzEX9CYuiUhvq9+5uslwB1lz2Csgh8YT8JUlgLZZdzq35B3Q9Hs10qaVSRkWIonP3Xmu7Xy
 Owy4FF6bQKcu39VeNqMWvC08
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:55:33 -0700
IronPort-SDR: yGleyCxwzuT+RVjVyFlh1DV8xHaWda2b8IxHb2Ai7z3KXVw3UUCtkZEnVt+LbdM5v4QdGZQTVN
 bfufgj2QUAkWFxAYAveIHT5pJnW+4tdoZrHu9XBpPZeYh62AArkzIVyU82XO4gM2Q0fdbwmvKS
 nYVgsCOMycZ/BKvtkk5GTr8NNdrw4ufQKB5gs0QE+uAUboNzVGEZXsJ+yXfJr3wBuAjg5QyvJ+
 wo/MnNyKsU+oDSHwlhngOmcwx6/x2RZsmbwSfGcVp1SrYbTLPF/JEHpXoUWLvboP/26CQWtFH/
 9fA=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:18:15 -0700
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
Subject: [PATCH 07/12] btrfs-progs: support discarding zoned device
Date:   Fri,  7 Jun 2019 22:17:46 +0900
Message-Id: <20190607131751.5359-7-naohiro.aota@wdc.com>
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

All zones of zoned block devices should be reset before writing. Support
this by considering zone reset as a special case of block discard and block
zeroing. Of note is that only zones accepting random writes can be zeroed.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 utils.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 88 insertions(+), 6 deletions(-)

diff --git a/utils.c b/utils.c
index a26fe7a5743c..c375b32953f7 100644
--- a/utils.c
+++ b/utils.c
@@ -123,6 +123,37 @@ static int discard_range(int fd, u64 start, u64 len)
 	return 0;
 }
 
+/*
+ * Discard blocks in the zones of a zoned block device.
+ * Process this with zone size granularity so that blocks in
+ * conventional zones are discarded using discard_range and
+ * blocks in sequential zones are discarded though a zone reset.
+ */
+static int discard_zones(int fd, struct btrfs_zone_info *zinfo)
+{
+#ifdef BTRFS_ZONED
+	unsigned int i;
+
+	/* Zone size granularity */
+	for (i = 0; i < zinfo->nr_zones; i++) {
+		if (zinfo->zones[i].type == BLK_ZONE_TYPE_CONVENTIONAL) {
+			discard_range(fd, zinfo->zones[i].start << 9,
+				      zinfo->zone_size);
+		} else if (zinfo->zones[i].cond != BLK_ZONE_COND_EMPTY) {
+			struct blk_zone_range range = {
+				zinfo->zones[i].start,
+				zinfo->zone_size >> 9 };
+			if (ioctl(fd, BLKRESETZONE, &range) < 0)
+				return errno;
+		}
+	}
+
+	return 0;
+#else
+	return -EIO;
+#endif
+}
+
 /*
  * Discard blocks in the given range in 1G chunks, the process is interruptible
  */
@@ -205,8 +236,38 @@ static int zero_blocks(int fd, off_t start, size_t len)
 
 #define ZERO_DEV_BYTES SZ_2M
 
+static int zero_zone_blocks(int fd, struct btrfs_zone_info *zinfo,
+			    off_t start, size_t len)
+{
+	size_t zone_len = zinfo->zone_size;
+	off_t ofst = start;
+	size_t count;
+	int ret;
+
+	/* Make sure that zero_blocks does not write sequential zones */
+	while (len > 0) {
+
+		/* Limit zero_blocks to a single zone */
+		count = min_t(size_t, len, zone_len);
+		if (count > zone_len - (ofst & (zone_len - 1)))
+			count = zone_len - (ofst & (zone_len - 1));
+
+		if (zone_is_random_write(zinfo, ofst)) {
+			ret = zero_blocks(fd, ofst, count);
+			if (ret != 0)
+				return ret;
+		}
+
+		len -= count;
+		ofst += count;
+	}
+
+	return 0;
+}
+
 /* don't write outside the device by clamping the region to the device size */
-static int zero_dev_clamped(int fd, off_t start, ssize_t len, u64 dev_size)
+static int zero_dev_clamped(int fd, struct btrfs_zone_info *zinfo,
+			    off_t start, ssize_t len, u64 dev_size)
 {
 	off_t end = max(start, start + len);
 
@@ -219,6 +280,9 @@ static int zero_dev_clamped(int fd, off_t start, ssize_t len, u64 dev_size)
 	start = min_t(u64, start, dev_size);
 	end = min_t(u64, end, dev_size);
 
+	if (zinfo->model != ZONED_NONE)
+		return zero_zone_blocks(fd, zinfo, start, end - start);
+
 	return zero_blocks(fd, start, end - start);
 }
 
@@ -566,6 +630,7 @@ int btrfs_get_zone_info(int fd, const char *file, int hmzoned,
 int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 		u64 max_block_count, unsigned opflags)
 {
+	struct btrfs_zone_info zinfo;
 	u64 block_count;
 	struct stat st;
 	int i, ret;
@@ -584,13 +649,30 @@ int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 	if (max_block_count)
 		block_count = min(block_count, max_block_count);
 
+	ret = btrfs_get_zone_info(fd, file, opflags & PREP_DEVICE_HMZONED,
+				  &zinfo);
+	if (ret < 0)
+		return 1;
+
 	if (opflags & PREP_DEVICE_DISCARD) {
 		/*
 		 * We intentionally ignore errors from the discard ioctl.  It
 		 * is not necessary for the mkfs functionality but just an
-		 * optimization.
+		 * optimization. However, we cannot ignore zone discard (reset)
+		 * errors for a zoned block device as this could result in the
+		 * inability to write to non-empty sequential zones of the
+		 * device.
 		 */
-		if (discard_range(fd, 0, 0) == 0) {
+		if (zinfo.model != ZONED_NONE) {
+			printf("Resetting device zones %s (%u zones) ...\n",
+				file, zinfo.nr_zones);
+			if (discard_zones(fd, &zinfo)) {
+				fprintf(stderr,
+					"ERROR: failed to reset device '%s' zones\n",
+					file);
+				return 1;
+			}
+		} else if (discard_range(fd, 0, 0) == 0) {
 			if (opflags & PREP_DEVICE_VERBOSE)
 				printf("Performing full device TRIM %s (%s) ...\n",
 						file, pretty_size(block_count));
@@ -598,12 +680,12 @@ int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 		}
 	}
 
-	ret = zero_dev_clamped(fd, 0, ZERO_DEV_BYTES, block_count);
+	ret = zero_dev_clamped(fd, &zinfo, 0, ZERO_DEV_BYTES, block_count);
 	for (i = 0 ; !ret && i < BTRFS_SUPER_MIRROR_MAX; i++)
-		ret = zero_dev_clamped(fd, btrfs_sb_offset(i),
+		ret = zero_dev_clamped(fd, &zinfo, btrfs_sb_offset(i),
 				       BTRFS_SUPER_INFO_SIZE, block_count);
 	if (!ret && (opflags & PREP_DEVICE_ZERO_END))
-		ret = zero_dev_clamped(fd, block_count - ZERO_DEV_BYTES,
+		ret = zero_dev_clamped(fd, &zinfo, block_count - ZERO_DEV_BYTES,
 				       ZERO_DEV_BYTES, block_count);
 
 	if (ret < 0) {
-- 
2.21.0

