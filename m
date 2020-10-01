Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141B82806FD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbgJASjC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:39:02 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24728 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733019AbgJASij (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577519; x=1633113519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e3ZRvgpBpiKkHapBfHOfsgCp4wI4McFaHSm5NK2vFyc=;
  b=jvtk/ToHzWQaZfTXXtDTRTUgnNGjkY7dEGFTsbUHE4xGP1OwNKLkFtDd
   EJmAsE7UOsf8tAfcZa4amJImdA703bZjLC8emhhLRZtZvmZJdwYbSUQ6O
   TmOpwIAg9sZktIrz2NzcFQAPr05axlnX8yPK1wvMchnSNXJ0B5ck2PxEk
   p6sLebQopAe4t/6hzm9TWB4LEgO51gzwWpPOgKyATo+yoaYpnfM6SyxGu
   EFu4Zm4KbyuM9YSsD/nn2ShjNhJuPU92apkKpV7n/afFvz8b8tQRRx19X
   nPnWXmpnD9TrMBFj+vsyL2kbFVN5YsGrTumPRfohyl9qmU+68S8KC1+XY
   g==;
IronPort-SDR: UgzBMboBuYcFYZr9C+IYOtrucNQ3uOGojp17XqiCewazgJKbd9GmwjI0g4/PIFQXg/KxiItZLt
 VdxI3fi689s1bdw0PcXj30qkKW/OxJgFq+KH3Nvs2S3swO/vnvqavVek1uhDyFqqeL2v7LEqHA
 3rtmQTpn02BYT/0LAE8uu31+H8jdUxyxGHVyO7lN76NLqB3kZAAzxQuFyOD08Di2vatndhlDJV
 +WeW9sXc1HyV9jJj3563lfm/VqO08Lgtje6FLtUHPLSbMHVSnSarFvg3fAEE9P2/cxKI4BO/wE
 t/Y=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036806"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:23 +0800
IronPort-SDR: EnoYaXcVrxGdNJ7miS/RvSZo81lFp15Q55NUlMrh4/FyKmng9l2IyOuvFinj5CVkGN6cHaTAGH
 brGyalSolv6A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:24:19 -0700
IronPort-SDR: ZFXTKx4UVT9rRXEAwRn86DnwwvDOkFzabmhtYlDiTifzaXXX5cMsJlS1oiaT7ZgjLWVuuZjIJX
 WplZLfWSOVtQ==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:22 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v8 18/41] btrfs: reset zones of unused block groups
Date:   Fri,  2 Oct 2020 03:36:25 +0900
Message-Id: <118ef50059dbbef6ea9febb30949716a26da6ef3.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
References: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For an ZONED volume, a block group maps to a zone of the device. For
deleted unused block groups, the zone of the block group can be reset to
rewind the zone write pointer at the start of the zone.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c |  8 ++++++--
 fs/btrfs/extent-tree.c | 17 ++++++++++++-----
 fs/btrfs/zoned.h       | 16 ++++++++++++++++
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index f07c03445390..2241d04ad4aa 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1468,8 +1468,12 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		if (!async_trim_enabled && btrfs_test_opt(fs_info, DISCARD_ASYNC))
 			goto flip_async;
 
-		/* DISCARD can flip during remount */
-		trimming = btrfs_test_opt(fs_info, DISCARD_SYNC);
+		/*
+		 * DISCARD can flip during remount. In ZONED mode, we need
+		 * to reset sequential required zones.
+		 */
+		trimming = btrfs_test_opt(fs_info, DISCARD_SYNC) ||
+				btrfs_fs_incompat(fs_info, ZONED);
 
 		/* Implicit trim during transaction commit. */
 		if (trimming)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 2be93d0f5978..dbf178fee7c7 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1331,6 +1331,9 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 
 		stripe = bbio->stripes;
 		for (i = 0; i < bbio->num_stripes; i++, stripe++) {
+			struct btrfs_device *dev = stripe->dev;
+			u64 physical = stripe->physical;
+			u64 length = stripe->length;
 			u64 bytes;
 			struct request_queue *req_q;
 
@@ -1338,14 +1341,18 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 				ASSERT(btrfs_test_opt(fs_info, DEGRADED));
 				continue;
 			}
+
 			req_q = bdev_get_queue(stripe->dev->bdev);
-			if (!blk_queue_discard(req_q))
+			/* zone reset in ZONED mode */
+			if (btrfs_can_zone_reset(dev, physical, length))
+				ret = btrfs_reset_device_zone(dev, physical,
+							      length, &bytes);
+			else if (blk_queue_discard(req_q))
+				ret = btrfs_issue_discard(dev->bdev, physical,
+							  length, &bytes);
+			else
 				continue;
 
-			ret = btrfs_issue_discard(stripe->dev->bdev,
-						  stripe->physical,
-						  stripe->length,
-						  &bytes);
 			if (!ret) {
 				discarded_bytes += bytes;
 			} else if (ret != -EOPNOTSUPP) {
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index ab048176a397..e388189b28f0 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -199,4 +199,20 @@ static inline u64 btrfs_zone_align(struct btrfs_device *device, u64 pos)
 	return ALIGN(pos, device->zone_info->zone_size);
 }
 
+static inline bool btrfs_can_zone_reset(struct btrfs_device *device,
+					u64 physical, u64 length)
+{
+	u64 zone_size;
+
+	if (!btrfs_dev_is_sequential(device, physical))
+		return false;
+
+	zone_size = device->zone_info->zone_size;
+	if (!IS_ALIGNED(physical, zone_size) ||
+	    !IS_ALIGNED(length, zone_size))
+		return false;
+
+	return true;
+}
+
 #endif
-- 
2.27.0

