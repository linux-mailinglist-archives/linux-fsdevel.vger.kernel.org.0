Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BBF2806EF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733135AbgJASjL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:39:11 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24779 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732535AbgJASjH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577547; x=1633113547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TfRgsWxDDWA55YSwMrVFURcqO616WdoBQprPhxawU5s=;
  b=d8GfwRmBO+hNZpAmlzA5BgjvHIk3tKrs+BCZFSO/JWveBhaxR1aASd3s
   zErs5CibOgRtGWH+ww2cZfMXH0Bw5ae6ImnoLX0Ve+D/mjDRjBkBBQ1rI
   zU5jgzTF12vc5PvoeqG5RPMR4/Yrf5DxxgQlidz/wW2aBDuSt9LHjYTjn
   sGFg0OGFCGmIDcySmQF3J3C+qEFPcYLgDIqgF0ome3KVfDzQrPumAhNLk
   HUZIExYI39jtKPd3LK3uSm9X0D2zWqkIz7kRfhEgVdKwkByz6BEJTF7aY
   NfCp2bZBODtYHWlZhFAzUlXh49QzwezjTV2bM/VNZxCnp2hnit3oa2HW/
   Q==;
IronPort-SDR: JsCMTlwjObn5LKApu8qaQrClx2xZIW1f12qYwRotKPY8uxdxTC8bP0N5KE9qqBTG5kq+/zv0jN
 Sqdj9cX5PSbWCLG3JHjVHTvsq1ovJJh1fYRJHfy0yz+aaYUM7yRffYuFyI7X/fAGz28WUFXxTz
 QH5NVsqvCQEJeGfC5Ju8YWWnuG1Mqa6Oono3xgEqLcJCDpZPLy3bQeSzeGVl07NlkDmmpKXs/G
 bkxJoiOUHbhtvq9wJ8bAvUQrAIJpm1jqKeJs99sfsz/fOiA8w3yDZuLLIMoZBeTNyZMbfqWvEP
 Udc=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036831"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:41 +0800
IronPort-SDR: TAP9jWvUMetq6rPDlrqSWDDwurEHaImCLjET8G1pxZ5t81sCNBYM2tazuerBaFZYNRUmLdJeU2
 8d9meT+Jzhhg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:24:38 -0700
IronPort-SDR: ejNEcENoDjKmASXuYdPBOAorsijezNjMWcCy63eq4QjPx8Ya8RLulaWgx73aT/0duYeVRZvXVW
 9rhvZE0XMd/A==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:41 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v8 34/41] btrfs: support dev-replace in ZONED mode
Date:   Fri,  2 Oct 2020 03:36:41 +0900
Message-Id: <b2e3485645132a247fe73698b73d54f954f2b33d.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
References: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is 4/4 patch to implement device-replace on ZONED mode.

Even after the copying is done, the write pointers of the source device and
the destination device may not be synchronized. For example, when the last
allocated extent is freed before device-replace process, the extent is not
copied, leaving a hole there.

This patch synchronize the write pointers by writing zeros to the
destination device.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/scrub.c | 36 +++++++++++++++++++++++++
 fs/btrfs/zoned.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h |  8 ++++++
 3 files changed, 113 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 65e460670160..2e607caa5ab9 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3019,6 +3019,31 @@ static void sync_replace_for_zoned(struct scrub_ctx *sctx)
 		   atomic_read(&sctx->bios_in_flight) == 0);
 }
 
+static int sync_write_pointer_for_zoned(struct scrub_ctx *sctx, u64 logical,
+					u64 physical, u64 physical_end)
+{
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	int ret = 0;
+
+	if (!btrfs_fs_incompat(fs_info, ZONED))
+		return 0;
+
+	wait_event(sctx->list_wait, atomic_read(&sctx->bios_in_flight) == 0);
+
+	mutex_lock(&sctx->wr_lock);
+	if (sctx->write_pointer < physical_end) {
+		ret = btrfs_sync_zone_write_pointer(sctx->wr_tgtdev, logical,
+						    physical,
+						    sctx->write_pointer);
+		if (ret)
+			btrfs_err(fs_info, "failed to recover write pointer");
+	}
+	mutex_unlock(&sctx->wr_lock);
+	btrfs_dev_clear_zone_empty(sctx->wr_tgtdev, physical);
+
+	return ret;
+}
+
 static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 					   struct map_lookup *map,
 					   struct btrfs_device *scrub_dev,
@@ -3416,6 +3441,17 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	blk_finish_plug(&plug);
 	btrfs_free_path(path);
 	btrfs_free_path(ppath);
+
+	if (sctx->is_dev_replace && ret >= 0) {
+		int ret2;
+
+		ret2 = sync_write_pointer_for_zoned(sctx, base + offset,
+						    map->stripes[num].physical,
+						    physical_end);
+		if (ret2)
+			ret = ret2;
+	}
+
 	return ret < 0 ? ret : 0;
 }
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 7ff2a590c93f..f28a70eaa20a 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -18,6 +18,7 @@
 #include "block-group.h"
 #include "transaction.h"
 #include "dev-replace.h"
+#include "space-info.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -1195,3 +1196,71 @@ int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical,
 				    length >> SECTOR_SHIFT,
 				    GFP_NOFS, 0);
 }
+
+static int read_zone_info(struct btrfs_fs_info *fs_info, u64 logical,
+			  struct blk_zone *zone)
+{
+	struct btrfs_bio *bbio = NULL;
+	u64 mapped_length = PAGE_SIZE;
+	unsigned int nofs_flag;
+	int nmirrors;
+	int i, ret;
+
+	ret = btrfs_map_sblock(fs_info, BTRFS_MAP_GET_READ_MIRRORS, logical,
+			       &mapped_length, &bbio);
+	if (ret || !bbio || mapped_length < PAGE_SIZE) {
+		btrfs_put_bbio(bbio);
+		return -EIO;
+	}
+
+	if (bbio->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK)
+		return -EINVAL;
+
+	nofs_flag = memalloc_nofs_save();
+	nmirrors = (int)bbio->num_stripes;
+	for (i = 0; i < nmirrors; i++) {
+		u64 physical = bbio->stripes[i].physical;
+		struct btrfs_device *dev = bbio->stripes[i].dev;
+
+		/* missing device */
+		if (!dev->bdev)
+			continue;
+
+		ret = btrfs_get_dev_zone(dev, physical, zone);
+		/* failing device */
+		if (ret == -EIO || ret == -EOPNOTSUPP)
+			continue;
+		break;
+	}
+	memalloc_nofs_restore(nofs_flag);
+
+	return ret;
+}
+
+int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
+				    u64 physical_start, u64 physical_pos)
+{
+	struct btrfs_fs_info *fs_info = tgt_dev->fs_info;
+	struct blk_zone zone;
+	u64 length;
+	u64 wp;
+	int ret;
+
+	if (!btrfs_dev_is_sequential(tgt_dev, physical_pos))
+		return 0;
+
+	ret = read_zone_info(fs_info, logical, &zone);
+	if (ret)
+		return ret;
+
+	wp = physical_start + ((zone.wp - zone.start) << SECTOR_SHIFT);
+
+	if (physical_pos == wp)
+		return 0;
+
+	if (physical_pos > wp)
+		return -EUCLEAN;
+
+	length = wp - physical_pos;
+	return btrfs_zoned_issue_zeroout(tgt_dev, physical_pos, length);
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index d5b2d31e6c91..d857538660f1 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -60,6 +60,8 @@ void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
 				     struct extent_buffer *eb);
 int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical,
 			      u64 length);
+int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
+				  u64 physical_start, u64 physical_pos);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -152,6 +154,12 @@ static inline int btrfs_zoned_issue_zeroout(struct btrfs_device *device,
 {
 	return -EOPNOTSUPP;
 }
+static inline int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev,
+						u64 logical, u64 physical_start,
+						u64 physical_pos)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.27.0

