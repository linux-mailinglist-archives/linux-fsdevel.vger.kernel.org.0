Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6563722BF2A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 09:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgGXHdu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 03:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgGXHdj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:33:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B1EC0619E4;
        Fri, 24 Jul 2020 00:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fgrmtzY2RTn3uqEl7NE2KYNoJXb5Vjc7RCDyRtLWKlU=; b=G9W66i4Ka/mMRNz43F9jXrEr2L
        p1+VL2FI1hB4uPeYTynT9RYv6gUCZoXDXCQxY8b5RmBEQYCyn3rlvY1ZKcAkeEDes66A2qhIYYMqN
        0esCX+Lja4UmLRz0NaXpWgl9BRcGTBjsfmn0BP3uOvzNjbcAwDZZmLMPU+uDZcmbGG5AEubP3xHTu
        L0LGnntGbS+9PkTy9/BdMd2W3Tl17ZOzbXTJjagoVcSonoX2+nfbtgywf19fcw6h/6Sw5aV+8Ts1w
        59Ye2O0KhX1ag3LAeHuGC62ZOvVI5vm/e5wPSSWCjr3N2PRnc8vMGy+Tu85GRODAanq7vpO3czjwX
        d+1Z/9rA==;
Received: from [2001:4bb8:18c:2acc:8dfe:be3c:592c:efc5] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jysD0-0006D8-Gr; Fri, 24 Jul 2020 07:33:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 08/14] block: add helper macros for queue sysfs entries
Date:   Fri, 24 Jul 2020 09:33:07 +0200
Message-Id: <20200724073313.138789-9-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200724073313.138789-1-hch@lst.de>
References: <20200724073313.138789-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add two helpers macros to avoid boilerplate code for the queue sysfs
entries.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-sysfs.c | 248 +++++++++++-----------------------------------
 1 file changed, 58 insertions(+), 190 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index cfbb039da8751f..9bb4e42fb73265 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -551,201 +551,69 @@ static ssize_t queue_dax_show(struct request_queue *q, char *page)
 	return queue_var_show(blk_queue_dax(q), page);
 }
 
-static struct queue_sysfs_entry queue_requests_entry = {
-	.attr = {.name = "nr_requests", .mode = 0644 },
-	.show = queue_requests_show,
-	.store = queue_requests_store,
-};
-
-static struct queue_sysfs_entry queue_ra_entry = {
-	.attr = {.name = "read_ahead_kb", .mode = 0644 },
-	.show = queue_ra_show,
-	.store = queue_ra_store,
-};
-
-static struct queue_sysfs_entry queue_max_sectors_entry = {
-	.attr = {.name = "max_sectors_kb", .mode = 0644 },
-	.show = queue_max_sectors_show,
-	.store = queue_max_sectors_store,
-};
+#define QUEUE_RO_ENTRY(_prefix, _name)			\
+static struct queue_sysfs_entry _prefix##_entry = {	\
+	.attr	= { .name = _name, .mode = 0444 },	\
+	.show	= _prefix##_show,			\
+};
+
+#define QUEUE_RW_ENTRY(_prefix, _name)			\
+static struct queue_sysfs_entry _prefix##_entry = {	\
+	.attr	= { .name = _name, .mode = 0644 },	\
+	.show	= _prefix##_show,			\
+	.store	= _prefix##_store,			\
+};
+
+QUEUE_RW_ENTRY(queue_requests, "nr_requests");
+QUEUE_RW_ENTRY(queue_ra, "read_ahead_kb");
+QUEUE_RW_ENTRY(queue_max_sectors, "max_sectors_kb");
+QUEUE_RO_ENTRY(queue_max_hw_sectors, "max_hw_sectors_kb");
+QUEUE_RO_ENTRY(queue_max_segments, "max_segments");
+QUEUE_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
+QUEUE_RO_ENTRY(queue_max_segment_size, "max_segment_size");
+QUEUE_RW_ENTRY(elv_iosched, "scheduler");
+
+QUEUE_RO_ENTRY(queue_logical_block_size, "logical_block_size");
+QUEUE_RO_ENTRY(queue_physical_block_size, "physical_block_size");
+QUEUE_RO_ENTRY(queue_chunk_sectors, "chunk_sectors");
+QUEUE_RO_ENTRY(queue_io_min, "minimum_io_size");
+QUEUE_RO_ENTRY(queue_io_opt, "optimal_io_size");
+
+QUEUE_RO_ENTRY(queue_max_discard_segments, "max_discard_segments");
+QUEUE_RO_ENTRY(queue_discard_granularity, "discard_granularity");
+QUEUE_RO_ENTRY(queue_discard_max_hw, "discard_max_hw_bytes");
+QUEUE_RW_ENTRY(queue_discard_max, "discard_max_bytes");
+QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
+
+QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
+QUEUE_RO_ENTRY(queue_write_zeroes_max, "write_zeroes_max_bytes");
+QUEUE_RO_ENTRY(queue_zone_append_max, "zone_append_max_bytes");
+
+QUEUE_RO_ENTRY(queue_zoned, "zoned");
+QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
+QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
+QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
+
+QUEUE_RW_ENTRY(queue_nomerges, "nomerges");
+QUEUE_RW_ENTRY(queue_rq_affinity, "rq_affinity");
+QUEUE_RW_ENTRY(queue_poll, "io_poll");
+QUEUE_RW_ENTRY(queue_poll_delay, "io_poll_delay");
+QUEUE_RW_ENTRY(queue_wc, "write_cache");
+QUEUE_RO_ENTRY(queue_fua, "fua");
+QUEUE_RO_ENTRY(queue_dax, "dax");
+QUEUE_RW_ENTRY(queue_io_timeout, "io_timeout");
+QUEUE_RW_ENTRY(queue_wb_lat, "wbt_lat_usec");
 
-static struct queue_sysfs_entry queue_max_hw_sectors_entry = {
-	.attr = {.name = "max_hw_sectors_kb", .mode = 0444 },
-	.show = queue_max_hw_sectors_show,
-};
-
-static struct queue_sysfs_entry queue_max_segments_entry = {
-	.attr = {.name = "max_segments", .mode = 0444 },
-	.show = queue_max_segments_show,
-};
-
-static struct queue_sysfs_entry queue_max_discard_segments_entry = {
-	.attr = {.name = "max_discard_segments", .mode = 0444 },
-	.show = queue_max_discard_segments_show,
-};
-
-static struct queue_sysfs_entry queue_max_integrity_segments_entry = {
-	.attr = {.name = "max_integrity_segments", .mode = 0444 },
-	.show = queue_max_integrity_segments_show,
-};
-
-static struct queue_sysfs_entry queue_max_segment_size_entry = {
-	.attr = {.name = "max_segment_size", .mode = 0444 },
-	.show = queue_max_segment_size_show,
-};
-
-static struct queue_sysfs_entry queue_iosched_entry = {
-	.attr = {.name = "scheduler", .mode = 0644 },
-	.show = elv_iosched_show,
-	.store = elv_iosched_store,
-};
+#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
+QUEUE_RW_ENTRY(blk_throtl_sample, "throttle_sample_time");
+#endif
 
+/* legacy alias for logical_block_size: */
 static struct queue_sysfs_entry queue_hw_sector_size_entry = {
 	.attr = {.name = "hw_sector_size", .mode = 0444 },
 	.show = queue_logical_block_size_show,
 };
 
-static struct queue_sysfs_entry queue_logical_block_size_entry = {
-	.attr = {.name = "logical_block_size", .mode = 0444 },
-	.show = queue_logical_block_size_show,
-};
-
-static struct queue_sysfs_entry queue_physical_block_size_entry = {
-	.attr = {.name = "physical_block_size", .mode = 0444 },
-	.show = queue_physical_block_size_show,
-};
-
-static struct queue_sysfs_entry queue_chunk_sectors_entry = {
-	.attr = {.name = "chunk_sectors", .mode = 0444 },
-	.show = queue_chunk_sectors_show,
-};
-
-static struct queue_sysfs_entry queue_io_min_entry = {
-	.attr = {.name = "minimum_io_size", .mode = 0444 },
-	.show = queue_io_min_show,
-};
-
-static struct queue_sysfs_entry queue_io_opt_entry = {
-	.attr = {.name = "optimal_io_size", .mode = 0444 },
-	.show = queue_io_opt_show,
-};
-
-static struct queue_sysfs_entry queue_discard_granularity_entry = {
-	.attr = {.name = "discard_granularity", .mode = 0444 },
-	.show = queue_discard_granularity_show,
-};
-
-static struct queue_sysfs_entry queue_discard_max_hw_entry = {
-	.attr = {.name = "discard_max_hw_bytes", .mode = 0444 },
-	.show = queue_discard_max_hw_show,
-};
-
-static struct queue_sysfs_entry queue_discard_max_entry = {
-	.attr = {.name = "discard_max_bytes", .mode = 0644 },
-	.show = queue_discard_max_show,
-	.store = queue_discard_max_store,
-};
-
-static struct queue_sysfs_entry queue_discard_zeroes_data_entry = {
-	.attr = {.name = "discard_zeroes_data", .mode = 0444 },
-	.show = queue_discard_zeroes_data_show,
-};
-
-static struct queue_sysfs_entry queue_write_same_max_entry = {
-	.attr = {.name = "write_same_max_bytes", .mode = 0444 },
-	.show = queue_write_same_max_show,
-};
-
-static struct queue_sysfs_entry queue_write_zeroes_max_entry = {
-	.attr = {.name = "write_zeroes_max_bytes", .mode = 0444 },
-	.show = queue_write_zeroes_max_show,
-};
-
-static struct queue_sysfs_entry queue_zone_append_max_entry = {
-	.attr = {.name = "zone_append_max_bytes", .mode = 0444 },
-	.show = queue_zone_append_max_show,
-};
-
-static struct queue_sysfs_entry queue_zoned_entry = {
-	.attr = {.name = "zoned", .mode = 0444 },
-	.show = queue_zoned_show,
-};
-
-static struct queue_sysfs_entry queue_nr_zones_entry = {
-	.attr = {.name = "nr_zones", .mode = 0444 },
-	.show = queue_nr_zones_show,
-};
-
-static struct queue_sysfs_entry queue_max_open_zones_entry = {
-	.attr = {.name = "max_open_zones", .mode = 0444 },
-	.show = queue_max_open_zones_show,
-};
-
-static struct queue_sysfs_entry queue_max_active_zones_entry = {
-	.attr = {.name = "max_active_zones", .mode = 0444 },
-	.show = queue_max_active_zones_show,
-};
-
-static struct queue_sysfs_entry queue_nomerges_entry = {
-	.attr = {.name = "nomerges", .mode = 0644 },
-	.show = queue_nomerges_show,
-	.store = queue_nomerges_store,
-};
-
-static struct queue_sysfs_entry queue_rq_affinity_entry = {
-	.attr = {.name = "rq_affinity", .mode = 0644 },
-	.show = queue_rq_affinity_show,
-	.store = queue_rq_affinity_store,
-};
-
-static struct queue_sysfs_entry queue_poll_entry = {
-	.attr = {.name = "io_poll", .mode = 0644 },
-	.show = queue_poll_show,
-	.store = queue_poll_store,
-};
-
-static struct queue_sysfs_entry queue_poll_delay_entry = {
-	.attr = {.name = "io_poll_delay", .mode = 0644 },
-	.show = queue_poll_delay_show,
-	.store = queue_poll_delay_store,
-};
-
-static struct queue_sysfs_entry queue_wc_entry = {
-	.attr = {.name = "write_cache", .mode = 0644 },
-	.show = queue_wc_show,
-	.store = queue_wc_store,
-};
-
-static struct queue_sysfs_entry queue_fua_entry = {
-	.attr = {.name = "fua", .mode = 0444 },
-	.show = queue_fua_show,
-};
-
-static struct queue_sysfs_entry queue_dax_entry = {
-	.attr = {.name = "dax", .mode = 0444 },
-	.show = queue_dax_show,
-};
-
-static struct queue_sysfs_entry queue_io_timeout_entry = {
-	.attr = {.name = "io_timeout", .mode = 0644 },
-	.show = queue_io_timeout_show,
-	.store = queue_io_timeout_store,
-};
-
-static struct queue_sysfs_entry queue_wb_lat_entry = {
-	.attr = {.name = "wbt_lat_usec", .mode = 0644 },
-	.show = queue_wb_lat_show,
-	.store = queue_wb_lat_store,
-};
-
-#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-static struct queue_sysfs_entry throtl_sample_time_entry = {
-	.attr = {.name = "throttle_sample_time", .mode = 0644 },
-	.show = blk_throtl_sample_time_show,
-	.store = blk_throtl_sample_time_store,
-};
-#endif
-
 static struct attribute *queue_attrs[] = {
 	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
@@ -755,7 +623,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_max_discard_segments_entry.attr,
 	&queue_max_integrity_segments_entry.attr,
 	&queue_max_segment_size_entry.attr,
-	&queue_iosched_entry.attr,
+	&elv_iosched_entry.attr,
 	&queue_hw_sector_size_entry.attr,
 	&queue_logical_block_size_entry.attr,
 	&queue_physical_block_size_entry.attr,
@@ -786,7 +654,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_poll_delay_entry.attr,
 	&queue_io_timeout_entry.attr,
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-	&throtl_sample_time_entry.attr,
+	&blk_throtl_sample_time_entry.attr,
 #endif
 	NULL,
 };
-- 
2.27.0

