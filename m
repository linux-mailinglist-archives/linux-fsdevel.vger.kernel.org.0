Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD07C2806CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732952AbgJASiU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:38:20 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24684 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbgJASiK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577490; x=1633113490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nt5RvzrKncyCwRonsGkKjpSvnmNJRAz+NkVdMTQ33Do=;
  b=JMV7tSvdj40lCEbmZPE/i6fIaCl7NKWzSpGJA5Q+OR/hJ/0YBRJLJ3Vk
   sJCHaLGOZZExGH15VHxq4WbTWKfo64XDx1a5eSonYdqLZUKNnLPuW4Mzn
   7zj0wbNBhxZ95wPnGOTujdGaOdyr7oeKUsWkmPmwrReMsbWxgYdKIkuF5
   0XsPWx/arCGK5KXlJbUzUX9AO3C7zmLtba7X8nqLE7Fn6WvK6vSVdf2Xo
   kRKF9OHluXta1l9Ghl7xxdWACwMggUoKBcnu4MSN4dRzzyCv2VAtyjzxB
   Whw+mkJZcBDPBtz4MAWpBL3oid7KIQH+e8hC2UeUb45PbufU1aihIEV7A
   w==;
IronPort-SDR: tn3FRS82hCci8o2FaL97h/JQV42b35yE7ZhoKIAkoWHcv5K2iH35OIf61e54zOspqRYOzkWRPy
 JWK2j8XjiQBp07XXqsybfPcES+1epEdPx1nz+O15af1Cbj+SeIqTOeUBJynCblvqb4nCSPlThy
 ryDnNN3hR53OPVoFZGhrhmS3eNa68kpU2uuj6cCLzB4uTNgrNuA1X7Xf4Uw707Ep5yHIPgbc+m
 ieEk4t060Wf857u2Uk7zsm1qhawJamUAK0uBuOi253UZO0wIbEPBYQ6dPoEnxyTe/+gsSBTrPB
 8Cc=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036778"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:08 +0800
IronPort-SDR: bf794fw+aBZsDY88/2tPNY5ym5+OFj0HPGRo4DWuXzgcUfvhIdS9hKRB8YHyy2pSLEW+Rm69HK
 Uwn9EamdP2Tw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:24:04 -0700
IronPort-SDR: 7IRGwnfewwsAEDD05qfTyQF+VX+UONahpyegvFo6FZoP/NJYURunourDkaW86XybvSjMX2hc6Q
 YAuhS41A8eOQ==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:07 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v8 06/41] btrfs: disallow space_cache in ZONED mode
Date:   Fri,  2 Oct 2020 03:36:13 +0900
Message-Id: <74608b65bb5c80387169b21b7b4e7c58f06883d6.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
References: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As updates to the space cache v1 are in-place, the space cache cannot be
located over sequential zones and there is no guarantees that the device
will have enough conventional zones to store this cache. Resolve this
problem by disabling completely the space cache v1.  This does not
introduces any problems with sequential block groups: all the free space is
located after the allocation pointer and no free space before the pointer.
There is no need to have such cache.

Note: we can technically use free-space-tree (space cache v2) on ZONED
mode. But, since ZONED mode now always allocate extents in a block group
sequentially regardless of underlying device zone type, it's no use to
enable and maintain the tree.

For the same reason, NODATACOW is also disabled.

Also INODE_MAP_CACHE is also disabled to avoid preallocation in the
INODE_MAP_CACHE inode.

In summary, ZONED will disable:

| Disabled features | Reason                                              |
|-------------------+-----------------------------------------------------|
| RAID/Dup          | Cannot handle two zone append writes to different   |
|                   | zones                                               |
|-------------------+-----------------------------------------------------|
| space_cache (v1)  | In-place updating                                   |
| NODATACOW         | In-place updating                                   |
|-------------------+-----------------------------------------------------|
| fallocate         | Reserved extent will be a write hole                |
| INODE_MAP_CACHE   | Need pre-allocation. (and will be deprecated?)      |
|-------------------+-----------------------------------------------------|
| MIXED_BG          | Allocated metadata region will be write holes for   |
|                   | data writes                                         |

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/super.c | 12 ++++++++++--
 fs/btrfs/zoned.c | 18 ++++++++++++++++++
 fs/btrfs/zoned.h |  5 +++++
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 1b2399c9c94e..dfdd4f161d16 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -525,8 +525,14 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	cache_gen = btrfs_super_cache_generation(info->super_copy);
 	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
 		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
-	else if (cache_gen)
-		btrfs_set_opt(info->mount_opt, SPACE_CACHE);
+	else if (cache_gen) {
+		if (btrfs_fs_incompat(info, ZONED)) {
+			btrfs_info(info,
+			"clearring existing space cache in ZONED mode");
+			btrfs_set_super_cache_generation(info->super_copy, 0);
+		} else
+			btrfs_set_opt(info->mount_opt, SPACE_CACHE);
+	}
 
 	/*
 	 * Even the options are empty, we still need to do extra check
@@ -985,6 +991,8 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 		ret = -EINVAL;
 
 	}
+	if (!ret)
+		ret = btrfs_check_mountopts_zoned(info);
 	if (!ret && btrfs_test_opt(info, SPACE_CACHE))
 		btrfs_info(info, "disk space caching is enabled");
 	if (!ret && btrfs_test_opt(info, FREE_SPACE_TREE))
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 2e12fce81abf..1629e585ba8c 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -268,3 +268,21 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 out:
 	return ret;
 }
+
+int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
+{
+	if (!btrfs_fs_incompat(info, ZONED))
+		return 0;
+
+	/*
+	 * SPACE CACHE writing is not CoWed. Disable that to avoid write
+	 * errors in sequential zones.
+	 */
+	if (btrfs_test_opt(info, SPACE_CACHE)) {
+		btrfs_err(info,
+			  "space cache v1 not supportted in ZONED mode");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index f200b46a71fb..2e1983188e6f 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -30,6 +30,7 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 int btrfs_get_dev_zone_info(struct btrfs_device *device);
 void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
 int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info);
+int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -49,6 +50,10 @@ static inline int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	btrfs_err(fs_info, "Zoned block devices support is not enabled");
 	return -EOPNOTSUPP;
 }
+static inline int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
+{
+	return 0;
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.27.0

