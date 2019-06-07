Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A05038B88
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbfFGNTH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:19:07 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:56467 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbfFGNSO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913527; x=1591449527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QZ/1/rNX3/3n7cc4vvS1dkFdK6HEV83hxR0tcxXdqV8=;
  b=gbnTZDa94dvjfbCoCSQ7ir/4EqqeBTtYJtiONx9rJZ4t59lPz7WUaTFC
   VpsNPn4G+VtlNoO5MuNuWNHxU6mMYQzxlAAElCmf6HT2zOkk5NiQZCKQ9
   tCXA7kSE9MxTdy841smkU7Mb7utXVl5KvWlWuaLAGXdMEddVZMSDWyJIO
   udJO9VC8ot0vo6jIzMWvCGqR0RE3tNYsR2ycFD/eR5Z5ifJeUEFhtyn4K
   QcuivAV0w7mab2nYn/B9kzptJ/AQl4dAHKjku8Ugm6kGlfc+fDmIz+W1I
   N+gZpfoWQQMsfENI/EGVRxUONvAS3bBxDlSVX03CcOFiJFrrN942krN9/
   w==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="209674998"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:18:43 +0800
IronPort-SDR: 977dDIxHZD/vuTaoSyqWmLjV7G2jG2z4l/2DNIG8RIji2BhvI5gZMlrFfBfUXmbbrMzqVQx1WV
 w5rsaEv5oQqRvTUAUI8EsFKS3DYsECyZeZArPATuGZspwPdLKyyhkhEmEMBl/91xbs5298PgME
 iFnLA5iu2FNv5MERSqcCh+xdGdBWf6NfB0U2XAD5oaXTTzW6Ll69/VXRREQ2j0Q700SNoA5Xsy
 wXzPgir7MW1NOChBgJ9YO4NX2/QMXDYHqWxvMo6pw6uspX9+LHOWMYVr8Ng1nfyzYM24UglhRU
 jTzDyGMDwxshYfDyN/hKbdkz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:55:29 -0700
IronPort-SDR: FzKJnxM8QyGDUNjyTLrZeFo/pnqqCte9zBMugrZeI2BgIKRGZx6g2NJMGMeIx2ounariG6vD/F
 kifFaoiCi+s3h/Ewp+1DliFFHKsV43ftPvPtdNVX5h9XFdA/ZL0GMIVXNzmAZdlhiM+rW13MN3
 D1ACy4kUyr+RWhBmEfLq7ETLtJdnjQiY3EyQ4BFhPUAyM30xpwTskmobAUW6bA/nanT6U2XUTW
 7oqN9G9NcbBFGNGsGRuEszEplcTCEbDCPEcRwSUOr47xnWRDcSg1D6ZUM80zUmPyF6DwZLfbSd
 7Qs=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:18:10 -0700
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
Subject: [PATCH 05/12] btrfs-progs: load and check zone information
Date:   Fri,  7 Jun 2019 22:17:44 +0900
Message-Id: <20190607131751.5359-5-naohiro.aota@wdc.com>
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

This patch checks if a device added to btrfs is a zoned block device. If it
is, load zones information and the zone size for the device.

For a btrfs volume composed of multiple zoned block devices, all devices
must have the same zone size.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 utils.c   | 10 ++++++++++
 volumes.c | 18 ++++++++++++++++++
 volumes.h |  3 +++
 3 files changed, 31 insertions(+)

diff --git a/utils.c b/utils.c
index d50304b1be80..a26fe7a5743c 100644
--- a/utils.c
+++ b/utils.c
@@ -250,6 +250,16 @@ int btrfs_add_to_fsid(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
+	ret = btrfs_get_zone_info(fd, path, fs_info->fs_devices->hmzoned,
+				  &device->zinfo);
+	if (ret)
+		goto out;
+	if (device->zinfo.zone_size != fs_info->fs_devices->zone_size) {
+		error("Device zone size differ\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
 	disk_super = (struct btrfs_super_block *)buf;
 	dev_item = &disk_super->dev_item;
 
diff --git a/volumes.c b/volumes.c
index 3a91b43b378b..f6d1b1e9dc7f 100644
--- a/volumes.c
+++ b/volumes.c
@@ -168,6 +168,8 @@ static int device_list_add(const char *path,
 	u64 found_transid = btrfs_super_generation(disk_super);
 	bool metadata_uuid = (btrfs_super_incompat_flags(disk_super) &
 		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
+	int hmzoned = btrfs_super_incompat_flags(disk_super) &
+			BTRFS_FEATURE_INCOMPAT_HMZONED;
 
 	if (metadata_uuid)
 		fs_devices = find_fsid(disk_super->fsid,
@@ -257,6 +259,8 @@ static int device_list_add(const char *path,
 	if (fs_devices->lowest_devid > devid) {
 		fs_devices->lowest_devid = devid;
 	}
+	if (hmzoned)
+		fs_devices->hmzoned = 1;
 	*fs_devices_ret = fs_devices;
 	return 0;
 }
@@ -327,6 +331,8 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices, int flags)
 	struct btrfs_device *device;
 	int ret;
 
+	fs_devices->zone_size = 0;
+
 	list_for_each_entry(device, &fs_devices->devices, dev_list) {
 		if (!device->name) {
 			printk("no name for device %llu, skip it now\n", device->devid);
@@ -350,6 +356,18 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices, int flags)
 		device->fd = fd;
 		if (flags & O_RDWR)
 			device->writeable = 1;
+
+		ret = btrfs_get_zone_info(fd, device->name, fs_devices->hmzoned,
+					  &device->zinfo);
+		if (ret != 0)
+			goto fail;
+		if (!fs_devices->zone_size) {
+			fs_devices->zone_size = device->zinfo.zone_size;
+		} else if (device->zinfo.zone_size != fs_devices->zone_size) {
+			fprintf(stderr, "Device zone size differ\n");
+			ret = -EINVAL;
+			goto fail;
+		}
 	}
 	return 0;
 fail:
diff --git a/volumes.h b/volumes.h
index c9262ceaea93..6ec83fe43cfe 100644
--- a/volumes.h
+++ b/volumes.h
@@ -115,6 +115,9 @@ struct btrfs_fs_devices {
 
 	int seeding;
 	struct btrfs_fs_devices *seed;
+
+	u64 zone_size;
+	unsigned int hmzoned:1;
 };
 
 struct btrfs_bio_stripe {
-- 
2.21.0

