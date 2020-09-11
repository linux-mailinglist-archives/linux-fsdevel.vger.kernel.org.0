Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DAD26678C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgIKRos (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:44:48 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38372 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgIKMeC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599827642; x=1631363642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AY/cM6eADnWn7IOOlrHMYTwSa/tNP6WiNcR2++d82VA=;
  b=pupBtSx4EJ2JzeZ/xPfHyxhL5h8BzcMkJWUbwWB7eeetl8gRpe3sEWN4
   wJK2zft7l2qEN1K2n3NEGq5yY44J9THX6YIDxv6W3i11371EC1aNqY6Bi
   iSq0r1v+CzO1V6RMP6uhbkJENYRM6Z9EvIFj06kUxaELF0ugYcQcuh2dK
   me0d2bsICTWNHmhiDNAgi1k+eEIv8lEEhVtNiOurOWt57mGuL7BA4Vgx3
   MMKdGXSAEenj+Lo9p3yccm//roSMrMeWR8td9hhSdxPrIwlzecALHrgk3
   FYPABJ9aMTlIeokXOsquzBStNT0pyqE1iBeKl9kzUYeLOtW2wseSHeo2w
   A==;
IronPort-SDR: 7/6/cs1/MgvlF7/mqHCOZjwboG7DtTiBPL8iQ8vGHh3eiawF4xUgGYNQgtuIeBiRt9gbgsXGE2
 SdxCmtzKp8wJyN0sdTpDHYopejoT+KSsdyRBX4a2NVPqInEckUTnrEmt5Oioef4FiCv1HgiYBL
 XLMY0la98ROXPBusMxVDHpB/stuTwqHgRN7nHhhqNzNGEwMy1X8p5tCpzbKRgH3Q9StJj4X+hj
 gC77VObI3Nr+1rpyjcU2J7xF1FoFJ8gIf2WLbnZ4xBUvxsYRyQc8dqbGPkxJN0la9qObRztD/3
 L1o=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147125960"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:15 +0800
IronPort-SDR: yNT3U271bslXZGV3kGmeqoxroFQceNx9IOQTWjb0hP7BzXUVU4uLNgRAZScb2wnEZe7mHFTklb
 Oj4gl2Y2QXJQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:19:36 -0700
IronPort-SDR: bljYaH2LKVnELLxvnb+cMJT5P42CXjDHKdbgRJYVQspBSLMX7DucDqbuEE7E3CrQSAyilkZDf9
 q4CuVGWIawkg==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:13 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 05/39] btrfs: disallow space_cache in ZONED mode
Date:   Fri, 11 Sep 2020 21:32:25 +0900
Message-Id: <20200911123259.3782926-6-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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
index 27a3a053f330..3fbffc7ce42b 100644
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

