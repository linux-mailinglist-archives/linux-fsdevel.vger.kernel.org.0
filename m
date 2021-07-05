Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B20D3BC19A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jul 2021 18:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhGEQ0J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jul 2021 12:26:09 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55192 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhGEQ0G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jul 2021 12:26:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8C0FE1FEC8;
        Mon,  5 Jul 2021 16:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625502208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mvs7mf+Do9fq5KKu7Y4VKMmqNqBaOkFIvFYcZ+dyeTw=;
        b=t5nh1y4PdZdOgEES+RC0K9YHrTKnzLguAA8brybwdizcapGx3eypjUSpi3b7Daxl2VrHq7
        YjrbXzlY6KxJIGgVsEszclGIIoAYDZylv1a7N21S0rIH2dES2etwx9JWVReJt1HRu5YQ3y
        fmWnMxhbnBfJg/IzttAjKcjWh+IyT1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625502208;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mvs7mf+Do9fq5KKu7Y4VKMmqNqBaOkFIvFYcZ+dyeTw=;
        b=zy94W6yj2cCz189yAa7Kwciyb7jyFLKKD1CbBO7w/GCXAZcTdtLfjgmuuDWicOhrpfO34/
        haXXvhRXLw5xbiAA==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 76F87A3BA9;
        Mon,  5 Jul 2021 16:23:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 425AD1F2CAF; Mon,  5 Jul 2021 18:23:28 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Michael Stapelberg <stapelberg+linux@google.com>,
        <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/5] writeback: Reliably update bandwidth estimation
Date:   Mon,  5 Jul 2021 18:23:16 +0200
Message-Id: <20210705162328.28366-2-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210705161610.19406-1-jack@suse.cz>
References: <20210705161610.19406-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6441; h=from:subject; bh=MAqbSRQHTYqrFQe1Bt2BYpSkOFmuyuvyfoYLeKQXwFE=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg4zH0CtLlTonpKlFvZqtvlceodXUXDwY/FxUaRrF3 CxHXElGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYOMx9AAKCRCcnaoHP2RA2cMJB/ 0ZKSRZme8f55e3Slb0tFjoZ+bB+/vR7VAcq7UVoQ+arRPiCEWqMrswaoZmyNi6aOC3uKspNkLXyBD7 vlAMbeb6L15yiNSFRFVZmxPQDYK7IjD2OkodPBmfIli6PYUIh67G6X3NWx0xPRRLLnoVhlvgFEq+Mz gbpwd3nxil+0DmSuf2iK9T2SpQTwFby4oM3XR3FkxTn6bJ4pSDv6uYRcEtczpBDE73vdHq9Ykp4knd /b8+GNs4IGipiugg19qPanaBTOSZ8pJbWFNkTkzsVtNvM5us8WKEa6Q43r4/2MUAvje+GZTfIFER+g Ney2M63cJCRGSwx4lfgEWRx+CSe6pg
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently we trigger writeback bandwidth estimation from
balance_dirty_pages() and from wb_writeback(). However neither of these
need to trigger when the system is relatively idle and writeback is
triggered e.g. from fsync(2). Make sure writeback estimates happen
reliably by triggering them from do_writepages().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c           |  3 ---
 include/linux/backing-dev.h | 19 ++++++++++++++++++
 include/linux/writeback.h   |  1 -
 mm/page-writeback.c         | 39 +++++++++++++++++++++++++------------
 4 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 475681362b1c..b53d1513e510 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1858,7 +1858,6 @@ static long writeback_inodes_wb(struct bdi_writeback *wb, long nr_pages,
 static long wb_writeback(struct bdi_writeback *wb,
 			 struct wb_writeback_work *work)
 {
-	unsigned long wb_start = jiffies;
 	long nr_pages = work->nr_pages;
 	unsigned long dirtied_before = jiffies;
 	struct inode *inode;
@@ -1912,8 +1911,6 @@ static long wb_writeback(struct bdi_writeback *wb,
 			progress = __writeback_inodes_wb(wb, work);
 		trace_writeback_written(wb, work);
 
-		wb_update_bandwidth(wb, wb_start);
-
 		/*
 		 * Did we write something? Try for more
 		 *
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 44df4fcef65c..a5d7d625dcc6 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -288,6 +288,17 @@ static inline struct bdi_writeback *inode_to_wb(const struct inode *inode)
 	return inode->i_wb;
 }
 
+static inline struct bdi_writeback *inode_to_wb_wbc(
+				struct inode *inode,
+				struct writeback_control *wbc)
+{
+	/*
+	 * If wbc does not have inode attached, it means cgroup writeback was
+ 	 * disabled when wbc started. Just use the default wb in that case.
+	 */
+	return wbc->wb ? wbc->wb : &inode_to_bdi(inode)->wb;
+}
+
 /**
  * unlocked_inode_to_wb_begin - begin unlocked inode wb access transaction
  * @inode: target inode
@@ -366,6 +377,14 @@ static inline struct bdi_writeback *inode_to_wb(struct inode *inode)
 	return &inode_to_bdi(inode)->wb;
 }
 
+static inline struct bdi_writeback *inode_to_wb_wbc(
+				struct inode *inode,
+				struct writeback_control *wbc)
+{
+	return inode_to_wb(inode);
+}
+
+
 static inline struct bdi_writeback *
 unlocked_inode_to_wb_begin(struct inode *inode, struct wb_lock_cookie *cookie)
 {
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 8e5c5bb16e2d..47cd732e012e 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -379,7 +379,6 @@ int dirty_writeback_centisecs_handler(struct ctl_table *table, int write,
 void global_dirty_limits(unsigned long *pbackground, unsigned long *pdirty);
 unsigned long wb_calc_thresh(struct bdi_writeback *wb, unsigned long thresh);
 
-void wb_update_bandwidth(struct bdi_writeback *wb, unsigned long start_time);
 void balance_dirty_pages_ratelimited(struct address_space *mapping);
 bool wb_over_bg_thresh(struct bdi_writeback *wb);
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 1560f6626a3b..1fecf8ebadb0 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1338,7 +1338,6 @@ static void wb_update_dirty_ratelimit(struct dirty_throttle_control *dtc,
 
 static void __wb_update_bandwidth(struct dirty_throttle_control *gdtc,
 				  struct dirty_throttle_control *mdtc,
-				  unsigned long start_time,
 				  bool update_ratelimit)
 {
 	struct bdi_writeback *wb = gdtc->wb;
@@ -1358,13 +1357,6 @@ static void __wb_update_bandwidth(struct dirty_throttle_control *gdtc,
 	dirtied = percpu_counter_read(&wb->stat[WB_DIRTIED]);
 	written = percpu_counter_read(&wb->stat[WB_WRITTEN]);
 
-	/*
-	 * Skip quiet periods when disk bandwidth is under-utilized.
-	 * (at least 1s idle time between two flusher runs)
-	 */
-	if (elapsed > HZ && time_before(wb->bw_time_stamp, start_time))
-		goto snapshot;
-
 	if (update_ratelimit) {
 		domain_update_bandwidth(gdtc, now);
 		wb_update_dirty_ratelimit(gdtc, dirtied, elapsed);
@@ -1380,17 +1372,36 @@ static void __wb_update_bandwidth(struct dirty_throttle_control *gdtc,
 	}
 	wb_update_write_bandwidth(wb, elapsed, written);
 
-snapshot:
 	wb->dirtied_stamp = dirtied;
 	wb->written_stamp = written;
 	wb->bw_time_stamp = now;
 }
 
-void wb_update_bandwidth(struct bdi_writeback *wb, unsigned long start_time)
+static void wb_update_bandwidth(struct bdi_writeback *wb)
 {
 	struct dirty_throttle_control gdtc = { GDTC_INIT(wb) };
 
-	__wb_update_bandwidth(&gdtc, NULL, start_time, false);
+	spin_lock(&wb->list_lock);
+	__wb_update_bandwidth(&gdtc, NULL, false);
+	spin_unlock(&wb->list_lock);
+}
+
+/* Interval after which we consider wb idle and don't estimate bandwidth */
+#define WB_BANDWIDTH_IDLE_JIF (HZ)
+
+static void wb_bandwidth_estimate_start(struct bdi_writeback *wb)
+{
+	unsigned long now = jiffies;
+	unsigned long elapsed = now - READ_ONCE(wb->bw_time_stamp);
+
+	if (elapsed > WB_BANDWIDTH_IDLE_JIF &&
+	    !atomic_read(&wb->writeback_inodes)) {
+		spin_lock(&wb->list_lock);
+		wb->dirtied_stamp = wb_stat(wb, WB_DIRTIED);
+		wb->written_stamp = wb_stat(wb, WB_WRITTEN);
+		wb->bw_time_stamp = now;
+		spin_unlock(&wb->list_lock);
+	}
 }
 
 /*
@@ -1719,7 +1730,7 @@ static void balance_dirty_pages(struct bdi_writeback *wb,
 		if (time_is_before_jiffies(wb->bw_time_stamp +
 					   BANDWIDTH_INTERVAL)) {
 			spin_lock(&wb->list_lock);
-			__wb_update_bandwidth(gdtc, mdtc, start_time, true);
+			__wb_update_bandwidth(gdtc, mdtc, true);
 			spin_unlock(&wb->list_lock);
 		}
 
@@ -2344,9 +2355,12 @@ EXPORT_SYMBOL(generic_writepages);
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
 	int ret;
+	struct bdi_writeback *wb;
 
 	if (wbc->nr_to_write <= 0)
 		return 0;
+	wb = inode_to_wb_wbc(mapping->host, wbc);
+	wb_bandwidth_estimate_start(wb);
 	while (1) {
 		if (mapping->a_ops->writepages)
 			ret = mapping->a_ops->writepages(mapping, wbc);
@@ -2357,6 +2371,7 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 		cond_resched();
 		congestion_wait(BLK_RW_ASYNC, HZ/50);
 	}
+	wb_update_bandwidth(wb);
 	return ret;
 }
 
-- 
2.26.2

