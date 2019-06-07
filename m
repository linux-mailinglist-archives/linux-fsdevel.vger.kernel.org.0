Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB3E238B45
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfFGNNL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:13:11 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53156 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbfFGNLS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913079; x=1591449079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mzpyOljqlLkDcZETtYWI1q1h4uahN9tSbBV7ZSiRpqM=;
  b=rJn6Z3EhEcsyQXhS1Y8rn62B6H63hT4QcNCmVcgc+je7Am/EOmTpn8Za
   mvQXAZi6ERvvnxgZ3PyQsj3bEydY4mKMFrjmcPnDGkYBMpynD5oS0+QYi
   ACBjAiM6gdyZZP2PwDRVdo48ho+/22uk5QbCHGWzAx5j33tZK+nMdxvrP
   moeCI15expwKTrBoMK2DrLCiLZ9Va6obPwgH9OZofnLVnFY08HSKMLcpV
   tWBq6A84bbZ/p2OfdeKGM2tsagZMksBtwU1NKpcwZQaowX3+T3fwKRSSb
   +dTm/zUX0cm8A9MICjw8+b1Eyn5mYnr7VaIkKP0IQcMa3RCEC6FjepVQb
   w==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="110027772"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:11:19 +0800
IronPort-SDR: ldUrL+XqF7ew5p3xe8HCnXy28Wv9pr9wQdjnFE1yOwdJcRCEI7nXXKh9YfFfj48qG2PQR/XqBA
 nlUVOTETsI9RFy0gU/Dmb88cpMESMOm/3iee6s9rfzUYU0GQ5NEGrm+D6SyLN3boXSm494omT2
 zbtmeCss57KS8TU7sVKFrT/lYxoA4FsbUCeDQ9vPRzNcap027RCvhkgj1BQixL+QvOlCvbMOY5
 KkfeHC3cl/+zut27e/3AbHU2T+CMFQ+0NTJMQa/RDEzG4A8oe4ndVdBbhyt9+Bt4VDpGgYxyDq
 V3WY+APzDpVZGF73IJbvDCEk
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:48:35 -0700
IronPort-SDR: YPG82Uull4FiZKkSrx8jlsCgFqVnBtA0+4BQFCuPGHKdSCK8aLQtOhKRUAmsD2hmCyQfxKcI+i
 d45qXn2jeIpV6OKzk2nD4b3GYfOQ+qSwOqmwAncAquYJD0dG4/bSWqk4NyZElO8Gu0rLb8gkLA
 3bf9I1aXcw5aFnV8RD3hRK5vq/vFofSkSowsfjT6hnpqK3cShiESmZVlhdmrFweqxjDSFYVz4R
 ub8Jjok4yiEjzxxSOw1rdWn5Whh+65c940KOPqfxO+CXPcNnSdQl92i2lmju2KrD418Dj35EI2
 On8=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:11:17 -0700
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
Subject: [PATCH 03/19] btrfs: Check and enable HMZONED mode
Date:   Fri,  7 Jun 2019 22:10:09 +0900
Message-Id: <20190607131025.31996-4-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607131025.31996-1-naohiro.aota@wdc.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

HMZONED mode cannot be used together with the RAID5/6 profile for now.
Introduce the function btrfs_check_hmzoned_mode() to check this. This
function will also check if HMZONED flag is enabled on the file system and
if the file system consists of zoned devices with equal zone size.

Additionally, as updates to the space cache are in-place, the space cache
cannot be located over sequential zones and there is no guarantees that the
device will have enough conventional zones to store this cache. Resolve
this problem by disabling completely the space cache.  This does not
introduces any problems with sequential block groups: all the free space is
located after the allocation pointer and no free space before the pointer.
There is no need to have such cache.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ctree.h       |  3 ++
 fs/btrfs/dev-replace.c |  7 +++
 fs/btrfs/disk-io.c     |  7 +++
 fs/btrfs/super.c       | 12 ++---
 fs/btrfs/volumes.c     | 99 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h     |  1 +
 6 files changed, 124 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b81c331b28fa..6c00101407e4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -806,6 +806,9 @@ struct btrfs_fs_info {
 	struct btrfs_root *uuid_root;
 	struct btrfs_root *free_space_root;
 
+	/* Zone size when in HMZONED mode */
+	u64 zone_size;
+
 	/* the log root tree is a directory of all the other log roots */
 	struct btrfs_root *log_root_tree;
 
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index ee0989c7e3a9..fbe5ea2a04ed 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -201,6 +201,13 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 		return PTR_ERR(bdev);
 	}
 
+	if ((bdev_zoned_model(bdev) == BLK_ZONED_HM &&
+	     !btrfs_fs_incompat(fs_info, HMZONED)) ||
+	    (!bdev_is_zoned(bdev) && btrfs_fs_incompat(fs_info, HMZONED))) {
+		ret = -EINVAL;
+		goto error;
+	}
+
 	filemap_write_and_wait(bdev->bd_inode->i_mapping);
 
 	devices = &fs_info->fs_devices->devices;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 663efce22d98..7c1404c76768 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3086,6 +3086,13 @@ int open_ctree(struct super_block *sb,
 
 	btrfs_free_extra_devids(fs_devices, 1);
 
+	ret = btrfs_check_hmzoned_mode(fs_info);
+	if (ret) {
+		btrfs_err(fs_info, "failed to init hmzoned mode: %d",
+				ret);
+		goto fail_block_groups;
+	}
+
 	ret = btrfs_sysfs_add_fsid(fs_devices, NULL);
 	if (ret) {
 		btrfs_err(fs_info, "failed to init sysfs fsid interface: %d",
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 2c66d9ea6a3b..740a701f16c5 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -435,11 +435,13 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	bool saved_compress_force;
 	int no_compress = 0;
 
-	cache_gen = btrfs_super_cache_generation(info->super_copy);
-	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
-		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
-	else if (cache_gen)
-		btrfs_set_opt(info->mount_opt, SPACE_CACHE);
+	if (!btrfs_fs_incompat(info, HMZONED)) {
+		cache_gen = btrfs_super_cache_generation(info->super_copy);
+		if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
+			btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
+		else if (cache_gen)
+			btrfs_set_opt(info->mount_opt, SPACE_CACHE);
+	}
 
 	/*
 	 * Even the options are empty, we still need to do extra check
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b673178718e3..b6f367d19dc9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1524,6 +1524,83 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 	return ret;
 }
 
+int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_device *device;
+	u64 hmzoned_devices = 0;
+	u64 nr_devices = 0;
+	u64 zone_size = 0;
+	int incompat_hmzoned = btrfs_fs_incompat(fs_info, HMZONED);
+	int ret = 0;
+
+	/* Count zoned devices */
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		if (!device->bdev)
+			continue;
+		if (bdev_zoned_model(device->bdev) == BLK_ZONED_HM ||
+		    (bdev_zoned_model(device->bdev) == BLK_ZONED_HA &&
+		     incompat_hmzoned)) {
+			hmzoned_devices++;
+			if (!zone_size) {
+				zone_size = device->zone_size;
+			} else if (device->zone_size != zone_size) {
+				btrfs_err(fs_info,
+					  "Zoned block devices must have equal zone sizes");
+				ret = -EINVAL;
+				goto out;
+			}
+		}
+		nr_devices++;
+	}
+
+	if (!hmzoned_devices && incompat_hmzoned) {
+		/* No zoned block device, disable HMZONED */
+		btrfs_err(fs_info, "HMZONED enabled file system should have zoned devices");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (!hmzoned_devices && !incompat_hmzoned)
+		goto out;
+
+	fs_info->zone_size = zone_size;
+
+	if (hmzoned_devices != nr_devices) {
+		btrfs_err(fs_info,
+			  "zoned devices mixed with regular devices");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* RAID56 is not allowed */
+	if (btrfs_fs_incompat(fs_info, RAID56)) {
+		btrfs_err(fs_info, "HMZONED mode does not support RAID56");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * SPACE CACHE writing is not cowed. Disable that to avoid
+	 * write errors in sequential zones.
+	 */
+	if (btrfs_test_opt(fs_info, SPACE_CACHE)) {
+		btrfs_info(fs_info,
+			   "disabling disk space caching with HMZONED mode");
+		btrfs_clear_opt(fs_info->mount_opt, SPACE_CACHE);
+	}
+
+	btrfs_set_and_info(fs_info, NOTREELOG,
+			   "disabling tree log with HMZONED  mode");
+
+	btrfs_info(fs_info, "HMZONED mode enabled, zone size %llu B",
+		   fs_info->zone_size);
+
+out:
+
+	return ret;
+}
+
 static void btrfs_release_disk_super(struct page *page)
 {
 	kunmap(page);
@@ -2695,6 +2772,13 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 
+	if ((bdev_zoned_model(bdev) == BLK_ZONED_HM &&
+	     !btrfs_fs_incompat(fs_info, HMZONED)) ||
+	    (!bdev_is_zoned(bdev) && btrfs_fs_incompat(fs_info, HMZONED))) {
+		ret = -EINVAL;
+		goto error;
+	}
+
 	if (fs_devices->seeding) {
 		seeding_dev = 1;
 		down_write(&sb->s_umount);
@@ -2816,6 +2900,21 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 		}
 	}
 
+	/* Get zone type information of zoned block devices */
+	if (bdev_is_zoned(bdev)) {
+		ret = btrfs_get_dev_zonetypes(device);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			goto error_sysfs;
+		}
+	}
+
+	ret = btrfs_check_hmzoned_mode(fs_info);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto error_sysfs;
+	}
+
 	ret = btrfs_add_dev_item(trans, device);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 1599641e216c..f66755e43669 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -432,6 +432,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path,
 					   fmode_t flags, void *holder);
 int btrfs_forget_devices(const char *path);
 int btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
+int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info);
 void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices, int step);
 void btrfs_assign_next_active_device(struct btrfs_device *device,
 				     struct btrfs_device *this_dev);
-- 
2.21.0

