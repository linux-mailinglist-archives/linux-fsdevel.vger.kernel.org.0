Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C7D266758
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgIKRlr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:41:47 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38372 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgIKMkS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599828017; x=1631364017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hl1Mk7GiUaQozrKkjvg3GEP31lE8h2AxbsjOnT0dDCg=;
  b=YMX3Ql70qBZxyaS1Y/ekxwPLOB/ZGi3P4p7/s0OmtBDLbcfBsXEYOv1S
   pAmFW0L8cWbxTwtIy80xUcvU1b+dC4cY7DktJtSiA/fzbK1/yrKh4OnIC
   FZ09TZzugNjjB/DjYxgc3GX+vtHw/EwreT+iTVEo0HlB73mM+QMj9C8Pn
   MIVXNf4vQn1IZywcpDNsFM2ezlxk3aTzNhMBUMfCOqTyYQoJ9LgRco07X
   mexJ7nPXQLjV33dgAYkXtYiNkrJE4kF9P8+l7qZocUO9ZwhhU1L4/f1z2
   s8qEh4l5Cp9VAo8eRrFni1dWI122T2U2PHOpw38lRKga1KivWjTuNH7Ff
   A==;
IronPort-SDR: fjGgn002fjWWludwdmT0KoPzaKVKPxHnthfwhqbDswlZ52iVJ2THjHlDUZsKrjxPT3+gCS6L/J
 TpM9BZ7QXlilKoe5EJWwg3Ik0azyW2K0PL8l2xAlYpx+CcJV6ZywZ0ifHYvCK7SStxWqN1podG
 bLJMipz3JpZmE42EAmmBZmxvZbqXFGLastnUmEykzizrkBZHfrNavoFn1uK6VUfTBcZvGFPuQl
 PZLqp1+AM2VUO0pfvBw3dVshtOqE+XSDR4EVVHIz3X3/4POaJvlRU1sch3Oyvn/u9ch+4Luz9E
 eq4=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147126029"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:54 +0800
IronPort-SDR: RM1WGxUBpsaI2VluhK993JYaLSdZSGlkJYvxZ5lBiLiM0ykHLi1huBqEaJaUyF7zlL/2YlwVsC
 MMWjMCa4D3Rw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:20:14 -0700
IronPort-SDR: Ip7WD3WEsdtnXSHgSfPBHq5+k36A4ZTe/ElZZpp6tsrK+dkjpWuzC5k9JKTkq26tSp3nhxVLk/
 dw10/hEjgyuQ==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:52 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 32/39] btrfs: support dev-replace in ZONED mode
Date:   Fri, 11 Sep 2020 21:32:52 +0900
Message-Id: <20200911123259.3782926-33-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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
index 568d90214446..2356e6d90690 100644
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
index ac88d26f1119..576f8e333f16 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -20,6 +20,7 @@
 #include "block-group.h"
 #include "transaction.h"
 #include "dev-replace.h"
+#include "space-info.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -1208,3 +1209,71 @@ int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical,
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
index dea313a61a3e..61388381c679 100644
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
@@ -154,6 +156,12 @@ static inline int btrfs_zoned_issue_zeroout(struct btrfs_device *device,
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

