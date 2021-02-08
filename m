Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82997313067
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 12:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbhBHLN6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 06:13:58 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:61902 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232882AbhBHLHY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:07:24 -0500
X-IronPort-AV: E=Sophos;i="5.81,161,1610380800"; 
   d="scan'208";a="104328077"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 Feb 2021 18:55:47 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 5CF2A4CE6F80;
        Mon,  8 Feb 2021 18:55:42 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 8 Feb 2021 18:55:44 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 8 Feb 2021 18:55:44 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <dm-devel@redhat.com>
CC:     <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <agk@redhat.com>,
        <snitzer@redhat.com>, <rgoldwyn@suse.de>, <qi.fuli@fujitsu.com>,
        <y-goto@fujitsu.com>
Subject: [PATCH v3 08/11] dm: Introduce ->rmap() to find bdev offset
Date:   Mon, 8 Feb 2021 18:55:27 +0800
Message-ID: <20210208105530.3072869-9-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com>
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 5CF2A4CE6F80.AE3E8
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pmem device could be a target of mapped device.  In order to obtain
superblock on the mapped device, we introduce this to translate offset
from target device to md device.

Currently, we implement it on linear target, which is easy to do the
translation.  Other targets will be supported in the future.  However,
some targets may not support it because of the non-linear mapping.

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 drivers/md/dm-linear.c        | 20 ++++++++++++++++++++
 include/linux/device-mapper.h |  5 +++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 00774b5d7668..90fdb4700afd 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -5,6 +5,7 @@
  */
 
 #include "dm.h"
+#include "dm-core.h"
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/blkdev.h>
@@ -119,6 +120,24 @@ static void linear_status(struct dm_target *ti, status_type_t type,
 	}
 }
 
+static int linear_rmap(struct dm_target *ti, sector_t offset,
+		       rmap_callout_fn fn, void *data)
+{
+	struct linear_c *lc = (struct linear_c *) ti->private;
+	struct mapped_device *md = ti->table->md;
+	struct block_device *bdev;
+	sector_t disk_sect = offset - dm_target_offset(ti, lc->start);
+	int rc = -ENODEV;
+
+	bdev = bdget_disk_sector(md->disk, offset);
+	if (!bdev)
+		return rc;
+
+	rc = fn(ti, bdev, disk_sect, data);
+	bdput(bdev);
+	return rc;
+}
+
 static int linear_prepare_ioctl(struct dm_target *ti, struct block_device **bdev)
 {
 	struct linear_c *lc = (struct linear_c *) ti->private;
@@ -238,6 +257,7 @@ static struct target_type linear_target = {
 	.ctr    = linear_ctr,
 	.dtr    = linear_dtr,
 	.map    = linear_map,
+	.rmap   = linear_rmap,
 	.status = linear_status,
 	.prepare_ioctl = linear_prepare_ioctl,
 	.iterate_devices = linear_iterate_devices,
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 61a66fb8ebb3..c5cd1009a08d 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -58,6 +58,10 @@ typedef void (*dm_dtr_fn) (struct dm_target *ti);
  * = 2: The target wants to push back the io
  */
 typedef int (*dm_map_fn) (struct dm_target *ti, struct bio *bio);
+typedef int (*rmap_callout_fn) (struct dm_target *ti, struct block_device *bdev,
+				sector_t sect, void *data);
+typedef int (*dm_rmap_fn) (struct dm_target *ti, sector_t offset,
+			   rmap_callout_fn fn, void *data);
 typedef int (*dm_clone_and_map_request_fn) (struct dm_target *ti,
 					    struct request *rq,
 					    union map_info *map_context,
@@ -175,6 +179,7 @@ struct target_type {
 	dm_ctr_fn ctr;
 	dm_dtr_fn dtr;
 	dm_map_fn map;
+	dm_rmap_fn rmap;
 	dm_clone_and_map_request_fn clone_and_map_rq;
 	dm_release_clone_request_fn release_clone_rq;
 	dm_endio_fn end_io;
-- 
2.30.0



