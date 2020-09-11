Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85E0266771
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgIKRnf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:43:35 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38451 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgIKMgW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599827781; x=1631363781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mDo+HKwXNeAZJE0Xbr0L93QnHHI6yjzP7MX0jDGrGr0=;
  b=ik2lNvU4ziqxdPXEOFe4LBWed7unnlGFQF41cb/2+78oTLri7ApWtf/V
   N5Il2A+q/rJIzduF/JCIB2BwSwfcJxd3ovhxB+WWKOkdV3HYMCm9q6/ye
   d9jfn5talHD6fj3pbCPy6XRP7ps8feXhr3esrJLsvHWT35Q0K2M/jL/58
   9q0j1WXYIahpSpFQIEOPIfLLp1rnKjwizN6iJnH873MFfZ6EoNVI4mhbF
   rzk7Qi0O31kkC3+/BPSLFcQ6tRk7UBcg4g7D9RvUSn9IrZ2MNQcmnkb3T
   6W8F7KcoJiEhw0qoK50YOz6b8ghTDZbirkwL3PCtA84SlmOblAIyxq9YG
   A==;
IronPort-SDR: Sfll7DxlVcZyU8CJiL5gh85ZoTYuNAgkQ93CXmFhdXvoMDtS8aI98E0cOUC35DI1RkypWnODo7
 k+V3hLCBJJjRiHcpqWcXOGW+SpYswDjCwQRiUunUmKORnyPGBFcqvnmdfNG+/+Ycf84RTOJJK0
 PBHf7JLadvIpfpZOQIZ82pavNX+X/NSa0y+7OhIAHXmBI+60MTFOASpjPoE7wVXVSLpvxwkj5a
 8JEPTllDXjrYXTJ47xixStJFgnsO143+EDAcstI6ysTonNotMGuvZvX+tmQ8Hvva044k2bOyA7
 nIw=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147125992"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:33 +0800
IronPort-SDR: scneKJlsRzQ+1jwN6njBKpLl/lrYmIduu8Tk7Ia/SPBB/1gjRQLzKIa5H8vf2g1ynF9B5wChZr
 CdkXTK8WPgUQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:19:53 -0700
IronPort-SDR: c/lVz5UFELd/rIiYtDFzc1XHwjs30oNuaWiyNibAPPvmurE+0UAou83GCFJi8yWfybZD6DaboN
 VJYFgEhTbqSQ==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:30 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 17/39] btrfs: reset zones of unused block groups
Date:   Fri, 11 Sep 2020 21:32:37 +0900
Message-Id: <20200911123259.3782926-18-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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
index 9df83e687b92..fbc22f0a6744 100644
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
index 5f86d552c6cb..7fe5b6e3b207 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1317,6 +1317,9 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 
 		stripe = bbio->stripes;
 		for (i = 0; i < bbio->num_stripes; i++, stripe++) {
+			struct btrfs_device *dev = stripe->dev;
+			u64 physical = stripe->physical;
+			u64 length = stripe->length;
 			u64 bytes;
 			struct request_queue *req_q;
 
@@ -1324,14 +1327,18 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
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
index 3e3eff8dd0b4..ccfb63a455dc 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -201,4 +201,20 @@ static inline u64 btrfs_zone_align(struct btrfs_device *device, u64 pos)
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

