Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B4640841A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 07:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237112AbhIMFyl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 01:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237033AbhIMFyk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:54:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DDDC061574;
        Sun, 12 Sep 2021 22:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zd0DRhhoJ1Ji0oazcpnhPtHKb9ndmDfjDzthXEnQj4Y=; b=vOWbnf3Jmf77lRt4hfoX9Q52S6
        pQdhjHBrkdAmOMivrGxVn/8reBt+LTzhRBLgs26BOGXpO4/f+LL9OYvLBtm4kOiEOfF9BiB59yttS
        stoovZwyCxfy94cXE19sYK5IHqszfxtRMGB2LWxnFHsZup6eVA89Bz6z1SpN4P3Nnryc/zOxIWNng
        IHv2nGLxuDb3WNOkXQkpKGGuYV2wXEwaBCXs3C0MwZcLDFaPkSCd+rLGBHHyZzTwkabKrveBrtShr
        oRaOOoxVfax4rUJP1gngo5zjgdXpSMlNVtKhA9EES26li5kCfPqFvEvw7ALTR8+9bGp2ciRQWtE1j
        aqEsf/9A==;
Received: from 089144214237.atnat0023.highway.a1.net ([89.144.214.237] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPerq-00DCxU-SQ; Mon, 13 Sep 2021 05:51:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] block: convert the request_queue attrs to use ->seq_show
Date:   Mon, 13 Sep 2021 07:41:18 +0200
Message-Id: <20210913054121.616001-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913054121.616001-1-hch@lst.de>
References: <20210913054121.616001-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Trivial conversion to the seq_file based sysfs attributes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-sysfs.c        | 209 ++++++++++++++++++++++-----------------
 block/blk-throttle.c     |   5 +-
 block/blk.h              |   2 +-
 block/elevator.c         |  21 ++--
 include/linux/elevator.h |   2 +-
 5 files changed, 134 insertions(+), 105 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 614d9d47de36b..ac57256db8710 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -20,14 +20,14 @@
 
 struct queue_sysfs_entry {
 	struct attribute attr;
-	ssize_t (*show)(struct request_queue *, char *);
+	int (*show)(struct request_queue *q, struct seq_file *sf);
 	ssize_t (*store)(struct request_queue *, const char *, size_t);
 };
 
-static ssize_t
-queue_var_show(unsigned long var, char *page)
+static int queue_var_show(unsigned long var, struct seq_file *sf)
 {
-	return sprintf(page, "%lu\n", var);
+	seq_printf(sf, "%lu\n", var);
+	return 0;
 }
 
 static ssize_t
@@ -58,9 +58,9 @@ static ssize_t queue_var_store64(s64 *var, const char *page)
 	return 0;
 }
 
-static ssize_t queue_requests_show(struct request_queue *q, char *page)
+static int queue_requests_show(struct request_queue *q, struct seq_file *sf)
 {
-	return queue_var_show(q->nr_requests, page);
+	return queue_var_show(q->nr_requests, sf);
 }
 
 static ssize_t
@@ -86,14 +86,14 @@ queue_requests_store(struct request_queue *q, const char *page, size_t count)
 	return ret;
 }
 
-static ssize_t queue_ra_show(struct request_queue *q, char *page)
+static int queue_ra_show(struct request_queue *q, struct seq_file *sf)
 {
 	unsigned long ra_kb;
 
 	if (!q->disk)
 		return -EINVAL;
 	ra_kb = q->disk->bdi->ra_pages << (PAGE_SHIFT - 10);
-	return queue_var_show(ra_kb, page);
+	return queue_var_show(ra_kb, sf);
 }
 
 static ssize_t
@@ -111,75 +111,83 @@ queue_ra_store(struct request_queue *q, const char *page, size_t count)
 	return ret;
 }
 
-static ssize_t queue_max_sectors_show(struct request_queue *q, char *page)
+static int queue_max_sectors_show(struct request_queue *q, struct seq_file *sf)
 {
 	int max_sectors_kb = queue_max_sectors(q) >> 1;
 
-	return queue_var_show(max_sectors_kb, page);
+	return queue_var_show(max_sectors_kb, sf);
 }
 
-static ssize_t queue_max_segments_show(struct request_queue *q, char *page)
+static int queue_max_segments_show(struct request_queue *q, struct seq_file *sf)
 {
-	return queue_var_show(queue_max_segments(q), page);
+	return queue_var_show(queue_max_segments(q), sf);
 }
 
-static ssize_t queue_max_discard_segments_show(struct request_queue *q,
-		char *page)
+static int queue_max_discard_segments_show(struct request_queue *q,
+		struct seq_file *sf)
 {
-	return queue_var_show(queue_max_discard_segments(q), page);
+	return queue_var_show(queue_max_discard_segments(q), sf);
 }
 
-static ssize_t queue_max_integrity_segments_show(struct request_queue *q, char *page)
+static int queue_max_integrity_segments_show(struct request_queue *q,
+		struct seq_file *sf)
 {
-	return queue_var_show(q->limits.max_integrity_segments, page);
+	return queue_var_show(q->limits.max_integrity_segments, sf);
 }
 
-static ssize_t queue_max_segment_size_show(struct request_queue *q, char *page)
+static int queue_max_segment_size_show(struct request_queue *q,
+		struct seq_file *sf)
 {
-	return queue_var_show(queue_max_segment_size(q), page);
+	return queue_var_show(queue_max_segment_size(q), sf);
 }
 
-static ssize_t queue_logical_block_size_show(struct request_queue *q, char *page)
+static int queue_logical_block_size_show(struct request_queue *q,
+		struct seq_file *sf)
 {
-	return queue_var_show(queue_logical_block_size(q), page);
+	return queue_var_show(queue_logical_block_size(q), sf);
 }
 
-static ssize_t queue_physical_block_size_show(struct request_queue *q, char *page)
+static int queue_physical_block_size_show(struct request_queue *q,
+		struct seq_file *sf)
 {
-	return queue_var_show(queue_physical_block_size(q), page);
+	return queue_var_show(queue_physical_block_size(q), sf);
 }
 
-static ssize_t queue_chunk_sectors_show(struct request_queue *q, char *page)
+static int queue_chunk_sectors_show(struct request_queue *q,
+		struct seq_file *sf)
 {
-	return queue_var_show(q->limits.chunk_sectors, page);
+	return queue_var_show(q->limits.chunk_sectors, sf);
 }
 
-static ssize_t queue_io_min_show(struct request_queue *q, char *page)
+static int queue_io_min_show(struct request_queue *q, struct seq_file *sf)
 {
-	return queue_var_show(queue_io_min(q), page);
+	return queue_var_show(queue_io_min(q), sf);
 }
 
-static ssize_t queue_io_opt_show(struct request_queue *q, char *page)
+static int queue_io_opt_show(struct request_queue *q, struct seq_file *sf)
 {
-	return queue_var_show(queue_io_opt(q), page);
+	return queue_var_show(queue_io_opt(q), sf);
 }
 
-static ssize_t queue_discard_granularity_show(struct request_queue *q, char *page)
+static int queue_discard_granularity_show(struct request_queue *q,
+		struct seq_file *sf)
 {
-	return queue_var_show(q->limits.discard_granularity, page);
+	return queue_var_show(q->limits.discard_granularity, sf);
 }
 
-static ssize_t queue_discard_max_hw_show(struct request_queue *q, char *page)
+static int queue_discard_max_hw_show(struct request_queue *q,
+		struct seq_file *sf)
 {
-
-	return sprintf(page, "%llu\n",
+	seq_printf(sf, "%llu\n",
 		(unsigned long long)q->limits.max_hw_discard_sectors << 9);
+	return 0;
 }
 
-static ssize_t queue_discard_max_show(struct request_queue *q, char *page)
+static int queue_discard_max_show(struct request_queue *q, struct seq_file *sf)
 {
-	return sprintf(page, "%llu\n",
-		       (unsigned long long)q->limits.max_discard_sectors << 9);
+	seq_printf(sf, "%llu\n",
+		(unsigned long long)q->limits.max_discard_sectors << 9);
+	return 0;
 }
 
 static ssize_t queue_discard_max_store(struct request_queue *q,
@@ -205,34 +213,41 @@ static ssize_t queue_discard_max_store(struct request_queue *q,
 	return ret;
 }
 
-static ssize_t queue_discard_zeroes_data_show(struct request_queue *q, char *page)
+static int queue_discard_zeroes_data_show(struct request_queue *q,
+		struct seq_file *sf)
 {
-	return queue_var_show(0, page);
+	return queue_var_show(0, sf);
 }
 
-static ssize_t queue_write_same_max_show(struct request_queue *q, char *page)
+static int queue_write_same_max_show(struct request_queue *q,
+		struct seq_file *sf)
 {
-	return sprintf(page, "%llu\n",
+	seq_printf(sf, "%llu\n",
 		(unsigned long long)q->limits.max_write_same_sectors << 9);
+	return 0;
 }
 
-static ssize_t queue_write_zeroes_max_show(struct request_queue *q, char *page)
+static int queue_write_zeroes_max_show(struct request_queue *q,
+		struct seq_file *sf)
 {
-	return sprintf(page, "%llu\n",
+	seq_printf(sf, "%llu\n",
 		(unsigned long long)q->limits.max_write_zeroes_sectors << 9);
+	return 0;
 }
 
-static ssize_t queue_zone_write_granularity_show(struct request_queue *q,
-						 char *page)
+static int queue_zone_write_granularity_show(struct request_queue *q,
+		struct seq_file *sf)
 {
-	return queue_var_show(queue_zone_write_granularity(q), page);
+	return queue_var_show(queue_zone_write_granularity(q), sf);
 }
 
-static ssize_t queue_zone_append_max_show(struct request_queue *q, char *page)
+static int queue_zone_append_max_show(struct request_queue *q,
+		struct seq_file *sf)
 {
 	unsigned long long max_sectors = q->limits.max_zone_append_sectors;
 
-	return sprintf(page, "%llu\n", max_sectors << SECTOR_SHIFT);
+	seq_printf(sf, "%llu\n", max_sectors << SECTOR_SHIFT);
+	return 0;
 }
 
 static ssize_t
@@ -261,25 +276,27 @@ queue_max_sectors_store(struct request_queue *q, const char *page, size_t count)
 	return ret;
 }
 
-static ssize_t queue_max_hw_sectors_show(struct request_queue *q, char *page)
+static int queue_max_hw_sectors_show(struct request_queue *q,
+		struct seq_file *sf)
 {
 	int max_hw_sectors_kb = queue_max_hw_sectors(q) >> 1;
 
-	return queue_var_show(max_hw_sectors_kb, page);
+	return queue_var_show(max_hw_sectors_kb, sf);
 }
 
-static ssize_t queue_virt_boundary_mask_show(struct request_queue *q, char *page)
+static int queue_virt_boundary_mask_show(struct request_queue *q,
+		struct seq_file *sf)
 {
-	return queue_var_show(q->limits.virt_boundary_mask, page);
+	return queue_var_show(q->limits.virt_boundary_mask, sf);
 }
 
 #define QUEUE_SYSFS_BIT_FNS(name, flag, neg)				\
-static ssize_t								\
-queue_##name##_show(struct request_queue *q, char *page)		\
+static int								\
+queue_##name##_show(struct request_queue *q, struct seq_file *sf)	\
 {									\
 	int bit;							\
 	bit = test_bit(QUEUE_FLAG_##flag, &q->queue_flags);		\
-	return queue_var_show(neg ? !bit : bit, page);			\
+	return queue_var_show(neg ? !bit : bit, sf);			\
 }									\
 static ssize_t								\
 queue_##name##_store(struct request_queue *q, const char *page, size_t count) \
@@ -305,37 +322,43 @@ QUEUE_SYSFS_BIT_FNS(iostats, IO_STAT, 0);
 QUEUE_SYSFS_BIT_FNS(stable_writes, STABLE_WRITES, 0);
 #undef QUEUE_SYSFS_BIT_FNS
 
-static ssize_t queue_zoned_show(struct request_queue *q, char *page)
+static int queue_zoned_show(struct request_queue *q,
+		struct seq_file *sf)
 {
 	switch (blk_queue_zoned_model(q)) {
 	case BLK_ZONED_HA:
-		return sprintf(page, "host-aware\n");
+		seq_printf(sf, "host-aware\n");
+		return 0;
 	case BLK_ZONED_HM:
-		return sprintf(page, "host-managed\n");
+		seq_printf(sf, "host-managed\n");
+		return 0;
 	default:
-		return sprintf(page, "none\n");
+		seq_printf(sf, "none\n");
+		return 0;
 	}
 }
 
-static ssize_t queue_nr_zones_show(struct request_queue *q, char *page)
+static int queue_nr_zones_show(struct request_queue *q, struct seq_file *sf)
 {
-	return queue_var_show(blk_queue_nr_zones(q), page);
+	return queue_var_show(blk_queue_nr_zones(q), sf);
 }
 
-static ssize_t queue_max_open_zones_show(struct request_queue *q, char *page)
+static int queue_max_open_zones_show(struct request_queue *q,
+		struct seq_file *sf)
 {
-	return queue_var_show(queue_max_open_zones(q), page);
+	return queue_var_show(queue_max_open_zones(q), sf);
 }
 
-static ssize_t queue_max_active_zones_show(struct request_queue *q, char *page)
+static int queue_max_active_zones_show(struct request_queue *q,
+		struct seq_file *sf)
 {
-	return queue_var_show(queue_max_active_zones(q), page);
+	return queue_var_show(queue_max_active_zones(q), sf);
 }
 
-static ssize_t queue_nomerges_show(struct request_queue *q, char *page)
+static int queue_nomerges_show(struct request_queue *q, struct seq_file *sf)
 {
 	return queue_var_show((blk_queue_nomerges(q) << 1) |
-			       blk_queue_noxmerges(q), page);
+			       blk_queue_noxmerges(q), sf);
 }
 
 static ssize_t queue_nomerges_store(struct request_queue *q, const char *page,
@@ -357,12 +380,12 @@ static ssize_t queue_nomerges_store(struct request_queue *q, const char *page,
 	return ret;
 }
 
-static ssize_t queue_rq_affinity_show(struct request_queue *q, char *page)
+static int queue_rq_affinity_show(struct request_queue *q, struct seq_file *sf)
 {
 	bool set = test_bit(QUEUE_FLAG_SAME_COMP, &q->queue_flags);
 	bool force = test_bit(QUEUE_FLAG_SAME_FORCE, &q->queue_flags);
 
-	return queue_var_show(set << force, page);
+	return queue_var_show(set << force, sf);
 }
 
 static ssize_t
@@ -390,7 +413,7 @@ queue_rq_affinity_store(struct request_queue *q, const char *page, size_t count)
 	return ret;
 }
 
-static ssize_t queue_poll_delay_show(struct request_queue *q, char *page)
+static int queue_poll_delay_show(struct request_queue *q, struct seq_file *sf)
 {
 	int val;
 
@@ -399,7 +422,8 @@ static ssize_t queue_poll_delay_show(struct request_queue *q, char *page)
 	else
 		val = q->poll_nsec / 1000;
 
-	return sprintf(page, "%d\n", val);
+	seq_printf(sf, "%d\n", val);
+	return 0;
 }
 
 static ssize_t queue_poll_delay_store(struct request_queue *q, const char *page,
@@ -424,9 +448,9 @@ static ssize_t queue_poll_delay_store(struct request_queue *q, const char *page,
 	return count;
 }
 
-static ssize_t queue_poll_show(struct request_queue *q, char *page)
+static int queue_poll_show(struct request_queue *q, struct seq_file *sf)
 {
-	return queue_var_show(test_bit(QUEUE_FLAG_POLL, &q->queue_flags), page);
+	return queue_var_show(test_bit(QUEUE_FLAG_POLL, &q->queue_flags), sf);
 }
 
 static ssize_t queue_poll_store(struct request_queue *q, const char *page,
@@ -454,9 +478,10 @@ static ssize_t queue_poll_store(struct request_queue *q, const char *page,
 	return ret;
 }
 
-static ssize_t queue_io_timeout_show(struct request_queue *q, char *page)
+static int queue_io_timeout_show(struct request_queue *q, struct seq_file *sf)
 {
-	return sprintf(page, "%u\n", jiffies_to_msecs(q->rq_timeout));
+	seq_printf(sf, "%u\n", jiffies_to_msecs(q->rq_timeout));
+	return 0;
 }
 
 static ssize_t queue_io_timeout_store(struct request_queue *q, const char *page,
@@ -474,12 +499,12 @@ static ssize_t queue_io_timeout_store(struct request_queue *q, const char *page,
 	return count;
 }
 
-static ssize_t queue_wb_lat_show(struct request_queue *q, char *page)
+static int queue_wb_lat_show(struct request_queue *q, struct seq_file *sf)
 {
 	if (!wbt_rq_qos(q))
 		return -EINVAL;
-
-	return sprintf(page, "%llu\n", div_u64(wbt_get_min_lat(q), 1000));
+	seq_printf(sf, "%llu\n", div_u64(wbt_get_min_lat(q), 1000));
+	return 0;
 }
 
 static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
@@ -526,12 +551,13 @@ static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
 	return count;
 }
 
-static ssize_t queue_wc_show(struct request_queue *q, char *page)
+static int queue_wc_show(struct request_queue *q, struct seq_file *sf)
 {
 	if (test_bit(QUEUE_FLAG_WC, &q->queue_flags))
-		return sprintf(page, "write back\n");
-
-	return sprintf(page, "write through\n");
+		seq_printf(sf, "write back\n");
+	else
+		seq_printf(sf, "write through\n");
+	return 0;
 }
 
 static ssize_t queue_wc_store(struct request_queue *q, const char *page,
@@ -556,14 +582,15 @@ static ssize_t queue_wc_store(struct request_queue *q, const char *page,
 	return count;
 }
 
-static ssize_t queue_fua_show(struct request_queue *q, char *page)
+static int queue_fua_show(struct request_queue *q, struct seq_file *sf)
 {
-	return sprintf(page, "%u\n", test_bit(QUEUE_FLAG_FUA, &q->queue_flags));
+	seq_printf(sf, "%u\n", test_bit(QUEUE_FLAG_FUA, &q->queue_flags));
+	return 0;
 }
 
-static ssize_t queue_dax_show(struct request_queue *q, char *page)
+static int queue_dax_show(struct request_queue *q, struct seq_file *sf)
 {
-	return queue_var_show(blk_queue_dax(q), page);
+	return queue_var_show(blk_queue_dax(q), sf);
 }
 
 #define QUEUE_RO_ENTRY(_prefix, _name)			\
@@ -710,8 +737,8 @@ static struct attribute_group queue_attr_group = {
 
 #define to_queue(atr) container_of((atr), struct queue_sysfs_entry, attr)
 
-static ssize_t
-queue_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
+static int queue_attr_seq_show(struct kobject *kobj, struct attribute *attr,
+		struct seq_file *sf)
 {
 	struct queue_sysfs_entry *entry = to_queue(attr);
 	struct request_queue *q =
@@ -721,7 +748,7 @@ queue_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
 	if (!entry->show)
 		return -EIO;
 	mutex_lock(&q->sysfs_lock);
-	res = entry->show(q, page);
+	res = entry->show(q, sf);
 	mutex_unlock(&q->sysfs_lock);
 	return res;
 }
@@ -837,8 +864,8 @@ static void blk_release_queue(struct kobject *kobj)
 }
 
 static const struct sysfs_ops queue_sysfs_ops = {
-	.show	= queue_attr_show,
-	.store	= queue_attr_store,
+	.seq_show	= queue_attr_seq_show,
+	.store		= queue_attr_store,
 };
 
 struct kobj_type blk_queue_ktype = {
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 7c4e7993ba970..579d31f0269bf 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2496,11 +2496,12 @@ void blk_throtl_register_queue(struct request_queue *q)
 }
 
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-ssize_t blk_throtl_sample_time_show(struct request_queue *q, char *page)
+int blk_throtl_sample_time_show(struct request_queue *q, struct seq_file *sf)
 {
 	if (!q->td)
 		return -EINVAL;
-	return sprintf(page, "%u\n", jiffies_to_msecs(q->td->throtl_slice));
+	seq_printf(sf, "%u\n", jiffies_to_msecs(q->td->throtl_slice));
+	return 0;
 }
 
 ssize_t blk_throtl_sample_time_store(struct request_queue *q,
diff --git a/block/blk.h b/block/blk.h
index 7d2a0ba7ed21d..69b9b6b3b2169 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -300,7 +300,7 @@ static inline void blk_throtl_charge_bio_split(struct bio *bio) { }
 static inline bool blk_throtl_bio(struct bio *bio) { return false; }
 #endif /* CONFIG_BLK_DEV_THROTTLING */
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-extern ssize_t blk_throtl_sample_time_show(struct request_queue *q, char *page);
+int blk_throtl_sample_time_show(struct request_queue *q, struct seq_file *sf);
 extern ssize_t blk_throtl_sample_time_store(struct request_queue *q,
 	const char *page, size_t count);
 extern void blk_throtl_bio_endio(struct bio *bio);
diff --git a/block/elevator.c b/block/elevator.c
index ff45d8388f487..f068585f2f9b8 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -782,39 +782,40 @@ ssize_t elv_iosched_store(struct request_queue *q, const char *name,
 	return ret;
 }
 
-ssize_t elv_iosched_show(struct request_queue *q, char *name)
+int elv_iosched_show(struct request_queue *q, struct seq_file *sf)
 {
 	struct elevator_queue *e = q->elevator;
 	struct elevator_type *elv = NULL;
 	struct elevator_type *__e;
-	int len = 0;
 
-	if (!queue_is_mq(q))
-		return sprintf(name, "none\n");
+	if (!queue_is_mq(q)) {
+		seq_printf(sf, "none\n");
+		return 0;
+	}
 
 	if (!q->elevator)
-		len += sprintf(name+len, "[none] ");
+		seq_printf(sf, "[none] ");
 	else
 		elv = e->type;
 
 	spin_lock(&elv_list_lock);
 	list_for_each_entry(__e, &elv_list, list) {
 		if (elv && elevator_match(elv, __e->elevator_name, 0)) {
-			len += sprintf(name+len, "[%s] ", elv->elevator_name);
+			seq_printf(sf, "[%s] ", elv->elevator_name);
 			continue;
 		}
 		if (elv_support_iosched(q) &&
 		    elevator_match(__e, __e->elevator_name,
 				   q->required_elevator_features))
-			len += sprintf(name+len, "%s ", __e->elevator_name);
+			seq_printf(sf, "%s ", __e->elevator_name);
 	}
 	spin_unlock(&elv_list_lock);
 
 	if (q->elevator)
-		len += sprintf(name+len, "none");
+		seq_printf(sf, "none");
 
-	len += sprintf(len+name, "\n");
-	return len;
+	seq_printf(sf, "\n");
+	return 0;
 }
 
 struct request *elv_rb_former_request(struct request_queue *q,
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index ef9ceead3db13..deecf7f9ff21a 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -132,7 +132,7 @@ extern void elv_unregister(struct elevator_type *);
 /*
  * io scheduler sysfs switching
  */
-extern ssize_t elv_iosched_show(struct request_queue *, char *);
+int elv_iosched_show(struct request_queue *q, struct seq_file *sf);
 extern ssize_t elv_iosched_store(struct request_queue *, const char *, size_t);
 
 extern bool elv_bio_merge_ok(struct request *, struct bio *);
-- 
2.30.2

