Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC24B2DAD21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 13:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgLOMQV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 07:16:21 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:27794 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728861AbgLOMQM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 07:16:12 -0500
X-IronPort-AV: E=Sophos;i="5.78,420,1599494400"; 
   d="scan'208";a="102420202"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Dec 2020 20:15:00 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 7F9924CE6011;
        Tue, 15 Dec 2020 20:14:58 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 15 Dec 2020 20:14:57 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Tue, 15 Dec 2020 20:14:57 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <song@kernel.org>,
        <rgoldwyn@suse.de>, <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>
Subject: [RFC PATCH v3 7/9] dm: Introduce ->rmap() to find bdev offset
Date:   Tue, 15 Dec 2020 20:14:12 +0800
Message-ID: <20201215121414.253660-8-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
References: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 7F9924CE6011.AB196
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
 drivers/md/dm-linear.c        | 8 ++++++++
 include/linux/device-mapper.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 00774b5d7668..7a7719e9958d 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -119,6 +119,13 @@ static void linear_status(struct dm_target *ti, status_type_t type,
 	}
 }
 
+static sector_t linear_rmap(struct dm_target *ti, sector_t offset)
+{
+	struct linear_c *lc = (struct linear_c *) ti->private;
+
+	return offset - dm_target_offset(ti, lc->start);
+}
+
 static int linear_prepare_ioctl(struct dm_target *ti, struct block_device **bdev)
 {
 	struct linear_c *lc = (struct linear_c *) ti->private;
@@ -238,6 +245,7 @@ static struct target_type linear_target = {
 	.ctr    = linear_ctr,
 	.dtr    = linear_dtr,
 	.map    = linear_map,
+	.rmap   = linear_rmap,
 	.status = linear_status,
 	.prepare_ioctl = linear_prepare_ioctl,
 	.iterate_devices = linear_iterate_devices,
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 61a66fb8ebb3..4a2afff6937e 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -58,6 +58,7 @@ typedef void (*dm_dtr_fn) (struct dm_target *ti);
  * = 2: The target wants to push back the io
  */
 typedef int (*dm_map_fn) (struct dm_target *ti, struct bio *bio);
+typedef sector_t (*dm_rmap_fn) (struct dm_target *ti, sector_t offset);
 typedef int (*dm_clone_and_map_request_fn) (struct dm_target *ti,
 					    struct request *rq,
 					    union map_info *map_context,
@@ -175,6 +176,7 @@ struct target_type {
 	dm_ctr_fn ctr;
 	dm_dtr_fn dtr;
 	dm_map_fn map;
+	dm_rmap_fn rmap;
 	dm_clone_and_map_request_fn clone_and_map_rq;
 	dm_release_clone_request_fn release_clone_rq;
 	dm_endio_fn end_io;
-- 
2.29.2



