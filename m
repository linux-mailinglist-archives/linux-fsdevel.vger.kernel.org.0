Return-Path: <linux-fsdevel+bounces-15379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A3788D6E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 08:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B09C229C385
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 07:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FED286AF;
	Wed, 27 Mar 2024 07:01:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61E7241EC;
	Wed, 27 Mar 2024 07:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711522913; cv=none; b=PWJ2qKm1tXWYLHTWvjwC16EZ25lulsxkVaw34aL4yW18O4bSaZ+V2+UtJKu6KPAKaYrscad6Hyde0VH27q7j1LyzAP1AXWUnNO33YfdtTeG/CnU+VLDky/NKajRbClHQfj12GaXqkc7Sgk59U8aQPN6t7qxtD1V7Iqd5pOBIZYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711522913; c=relaxed/simple;
	bh=mqq18b4mQKglezFVLisOv8Kd4Je1aKnrKE6RZYPumWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n3oCpbBU5jTNT5eGSMcPK9VvbQm2pKbDzYJDrz50Xairh53EgKI8+4boM+An2e11yjXhgqk6tuAb2jj3Rnlw4A/pCdBoILXmCVOVC3wAEf7Hejd29SWOBoL0Qr72Gk8tzXWCV36Z5IlEPwgqkYIz6Lbip9UuESDGQ2qEhc9HYLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V4Hdy2Ht5z4f3knS;
	Wed, 27 Mar 2024 15:01:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 86CD21A0232;
	Wed, 27 Mar 2024 15:01:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgAnSQxYxANmi6+LIQ--.50310S5;
	Wed, 27 Mar 2024 15:01:48 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	willy@infradead.org,
	jack@suse.cz,
	bfoster@redhat.com,
	tj@kernel.org
Cc: dsterba@suse.com,
	mjguzik@gmail.com,
	dhowells@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/6] writeback: support retrieving per group debug writeback stats of bdi
Date: Wed, 27 Mar 2024 23:57:48 +0800
Message-Id: <20240327155751.3536-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240327155751.3536-1-shikemeng@huaweicloud.com>
References: <20240327155751.3536-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnSQxYxANmi6+LIQ--.50310S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw15uFW7Xw43XF45tF1rCrg_yoW7tFWUpF
	43Jw1rJr4UZr17WFZxAay2qry5tw4rtrW7XF97Z3yrKF1DKry3tFy8CryFyry5AF93AFy3
	Aws0krW8urW8trJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxV
	A2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
	Iq2MUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Add /sys/kernel/debug/bdi/xxx/wb_stats to show per group writeback stats
of bdi.

Following domain hierarchy is tested:
                global domain (320G)
                /                 \
        cgroup domain1(10G)     cgroup domain2(10G)
                |                 |
bdi            wb1               wb2

/* per wb writeback info of bdi is collected */
cat /sys/kernel/debug/bdi/252:16/wb_stats
WbCgIno:                    1
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                  0 kB
WbWritten:                  0 kB
WbWriteBandwidth:      102400 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      1
WbCgIno:                 4094
WbWriteback:            54432 kB
WbReclaimable:         766080 kB
WbDirtyThresh:        3094760 kB
WbDirtied:            1656480 kB
WbWritten:             837088 kB
WbWriteBandwidth:      132772 kBps
b_dirty:                    1
b_io:                       1
b_more_io:                  0
b_dirty_time:               0
state:                      7
WbCgIno:                 4135
WbWriteback:            15232 kB
WbReclaimable:         786688 kB
WbDirtyThresh:        2909984 kB
WbDirtied:            1482656 kB
WbWritten:             681408 kB
WbWriteBandwidth:      124848 kBps
b_dirty:                    0
b_io:                       1
b_more_io:                  0
b_dirty_time:               0
state:                      7

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 include/linux/writeback.h |  1 +
 mm/backing-dev.c          | 88 +++++++++++++++++++++++++++++++++++++++
 mm/page-writeback.c       | 19 +++++++++
 3 files changed, 108 insertions(+)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 9845cb62e40b..112d806ddbe4 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -355,6 +355,7 @@ int dirtytime_interval_handler(struct ctl_table *table, int write,
 
 void global_dirty_limits(unsigned long *pbackground, unsigned long *pdirty);
 unsigned long wb_calc_thresh(struct bdi_writeback *wb, unsigned long thresh);
+unsigned long cgwb_calc_thresh(struct bdi_writeback *wb);
 
 void wb_update_bandwidth(struct bdi_writeback *wb);
 
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 8daf950e6855..e3953db7d88d 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -103,6 +103,91 @@ static void collect_wb_stats(struct wb_stats *stats,
 }
 
 #ifdef CONFIG_CGROUP_WRITEBACK
+static void wb_stats_show(struct seq_file *m, struct bdi_writeback *wb,
+			  struct wb_stats *stats)
+{
+
+	seq_printf(m,
+		   "WbCgIno:           %10lu\n"
+		   "WbWriteback:       %10lu kB\n"
+		   "WbReclaimable:     %10lu kB\n"
+		   "WbDirtyThresh:     %10lu kB\n"
+		   "WbDirtied:         %10lu kB\n"
+		   "WbWritten:         %10lu kB\n"
+		   "WbWriteBandwidth:  %10lu kBps\n"
+		   "b_dirty:           %10lu\n"
+		   "b_io:              %10lu\n"
+		   "b_more_io:         %10lu\n"
+		   "b_dirty_time:      %10lu\n"
+		   "state:             %10lx\n",
+		   cgroup_ino(wb->memcg_css->cgroup),
+		   K(stats->nr_writeback),
+		   K(stats->nr_reclaimable),
+		   K(stats->wb_thresh),
+		   K(stats->nr_dirtied),
+		   K(stats->nr_written),
+		   K(wb->avg_write_bandwidth),
+		   stats->nr_dirty,
+		   stats->nr_io,
+		   stats->nr_more_io,
+		   stats->nr_dirty_time,
+		   wb->state);
+}
+
+static int cgwb_debug_stats_show(struct seq_file *m, void *v)
+{
+	struct backing_dev_info *bdi;
+	unsigned long background_thresh;
+	unsigned long dirty_thresh;
+	struct bdi_writeback *wb;
+	struct wb_stats stats;
+
+	rcu_read_lock();
+	bdi = lookup_bdi(m);
+	if (!bdi) {
+		rcu_read_unlock();
+		return -EEXIST;
+	}
+
+	global_dirty_limits(&background_thresh, &dirty_thresh);
+
+	list_for_each_entry_rcu(wb, &bdi->wb_list, bdi_node) {
+		memset(&stats, 0, sizeof(stats));
+		stats.dirty_thresh = dirty_thresh;
+		collect_wb_stats(&stats, wb);
+
+		if (mem_cgroup_wb_domain(wb) == NULL) {
+			wb_stats_show(m, wb, &stats);
+			continue;
+		}
+
+		/*
+		 * cgwb_release will destroy wb->memcg_completions which
+		 * will be ued in cgwb_calc_thresh. Use wb_tryget to prevent
+		 * memcg_completions destruction from cgwb_release.
+		 */
+		if (!wb_tryget(wb))
+			continue;
+
+		rcu_read_unlock();
+		/* cgwb_calc_thresh may sleep in cgroup_rstat_flush */
+		stats.wb_thresh = min(stats.wb_thresh, cgwb_calc_thresh(wb));
+		wb_stats_show(m, wb, &stats);
+		rcu_read_lock();
+		wb_put(wb);
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(cgwb_debug_stats);
+
+static void cgwb_debug_register(struct backing_dev_info *bdi)
+{
+	debugfs_create_file("wb_stats", 0444, bdi->debug_dir, bdi,
+			    &cgwb_debug_stats_fops);
+}
+
 static void bdi_collect_stats(struct backing_dev_info *bdi,
 			      struct wb_stats *stats)
 {
@@ -117,6 +202,8 @@ static void bdi_collect_stats(struct backing_dev_info *bdi,
 {
 	collect_wb_stats(stats, &bdi->wb);
 }
+
+static inline void cgwb_debug_register(struct backing_dev_info *bdi) { }
 #endif
 
 static int bdi_debug_stats_show(struct seq_file *m, void *v)
@@ -182,6 +269,7 @@ static void bdi_debug_register(struct backing_dev_info *bdi, const char *name)
 
 	debugfs_create_file("stats", 0444, bdi->debug_dir, bdi,
 			    &bdi_debug_stats_fops);
+	cgwb_debug_register(bdi);
 }
 
 static void bdi_debug_unregister(struct backing_dev_info *bdi)
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 0e20467367fe..3724c7525316 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -893,6 +893,25 @@ unsigned long wb_calc_thresh(struct bdi_writeback *wb, unsigned long thresh)
 	return __wb_calc_thresh(&gdtc, thresh);
 }
 
+unsigned long cgwb_calc_thresh(struct bdi_writeback *wb)
+{
+	struct dirty_throttle_control gdtc = { GDTC_INIT_NO_WB };
+	struct dirty_throttle_control mdtc = { MDTC_INIT(wb, &gdtc) };
+	unsigned long filepages, headroom, writeback;
+
+	gdtc.avail = global_dirtyable_memory();
+	gdtc.dirty = global_node_page_state(NR_FILE_DIRTY) +
+		     global_node_page_state(NR_WRITEBACK);
+
+	mem_cgroup_wb_stats(wb, &filepages, &headroom,
+			    &mdtc.dirty, &writeback);
+	mdtc.dirty += writeback;
+	mdtc_calc_avail(&mdtc, filepages, headroom);
+	domain_dirty_limits(&mdtc);
+
+	return __wb_calc_thresh(&mdtc, mdtc.thresh);
+}
+
 /*
  *                           setpoint - dirty 3
  *        f(dirty) := 1.0 + (----------------)
-- 
2.30.0


