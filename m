Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7B138B22
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbfFGNMS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:12:18 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53172 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfFGNLr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913107; x=1591449107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4nLHyfI3fv6ZUFS/VY17ZQTSfHVHXl6J3Rsy55AAxfI=;
  b=bf491hq+/rKLt8/g+b4N48dghEfF3xe3USJYMWnD7ppMF6LQB8yTmc71
   neZPESzp/2wumT2NZT4Nsh6iR+OBt8fku88HbgzpJEzA7+CTE09+hupI+
   hYd4Kvs9Po1hI3mHMS9BQbxmNJXPYlkMeVxEm3Wxp9TdOhq9rE5EbrW5h
   ED8s/a2zZg+wURedhcVXYtl5k0vxdHtXDQXWFKLrbeeMD9t5THXGQqfyq
   1niVLdPmaLjNUobvSWPLJhcd0UJvb+BzpnBffPhZ7y07AYCLEaINn4yLh
   roujzsBYITr+4N++D3x6tHCa8Ha1Gb3Qvfvwmn13lIoUIW9i6jzRJdQOp
   g==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="110027828"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:11:47 +0800
IronPort-SDR: vAHs450dXNQmH+P7+KLM7Qjm+T+Um6g0Zom6PfpnvVIxDCgMey18KJNeHKoqTQs3OK4d0HOYmJ
 9F/Og9KPt5vsNctJXnlMmVBGcNiW8atEP0b7D4jApOGur+4Te5IsJgaTIlu/dhrAXgyCHG8+vv
 C5f3AnRMI8GFWFofVRGZbUVFfJMXmkBx8Zp3V6JqPnebHu+Hsx+qQGGDCKIhqKoPMIKS1LJIO6
 0eAIwRx8XGaGjp58CV5N8YOcD5M9Cr7+pUlJmKbX8WteLwoytbXPN46H7FNezBwXx+S3tlZWPb
 hqSxBAAHuSMis9yU/8dgmy+F
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:49:04 -0700
IronPort-SDR: G16LtUd5bpuNhdKAT+GJ64jCGJDCmSwixdGbkAjD/5aTmabaHr6g0WAuwCU2x2fTn64SgXiht6
 FeQRwPatSfUymMiWjfPDDSJ9uxFPy/TCJDAJVP5ogBrTg8hCVijGXwClBVICZPXiYwiR5j5JbR
 /ZL5kUv3H4f8z1jwvQFO4LtM9jZ3yNnkLtco4C1mRcmLhwEQfWLQS50T7EyD8xT7cdwKXlAV/w
 URI8YGhsb0RJJ4qffLiCffnlQlBQZ1MHrxDz35OJMFsR9RD0pFjTv6Nz4V7p9JUoREo83OqI6l
 gVY=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:11:45 -0700
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
Subject: [PATCH 15/19] btrfs: reset zones of unused block groups
Date:   Fri,  7 Jun 2019 22:10:21 +0900
Message-Id: <20190607131025.31996-16-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607131025.31996-1-naohiro.aota@wdc.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For an HMZONED volume, a block group maps to a zone of the device. For
deleted unused block groups, the zone of the block group can be reset to
rewind the zone write pointer at the start of the zone.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index cb29a96c226b..ff4d55d6ef04 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2018,6 +2018,26 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 				ASSERT(btrfs_test_opt(fs_info, DEGRADED));
 				continue;
 			}
+
+			if (btrfs_dev_is_sequential(stripe->dev,
+						    stripe->physical) &&
+			    stripe->length == stripe->dev->zone_size) {
+				ret = blkdev_reset_zones(stripe->dev->bdev,
+							 stripe->physical >>
+								 SECTOR_SHIFT,
+							 stripe->length >>
+								 SECTOR_SHIFT,
+							 GFP_NOFS);
+				if (!ret)
+					discarded_bytes += stripe->length;
+				else
+					break;
+				set_bit(stripe->physical >>
+						stripe->dev->zone_size_shift,
+					stripe->dev->empty_zones);
+				continue;
+			}
+
 			req_q = bdev_get_queue(stripe->dev->bdev);
 			if (!blk_queue_discard(req_q))
 				continue;
@@ -11430,7 +11450,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		spin_unlock(&space_info->lock);
 
 		/* DISCARD can flip during remount */
-		trimming = btrfs_test_opt(fs_info, DISCARD);
+		trimming = btrfs_test_opt(fs_info, DISCARD) ||
+				btrfs_fs_incompat(fs_info, HMZONED);
 
 		/* Implicit trim during transaction commit. */
 		if (trimming)
-- 
2.21.0

