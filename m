Return-Path: <linux-fsdevel+bounces-17379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F1F8AC604
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 09:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1F51C20B27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 07:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70A75029D;
	Mon, 22 Apr 2024 07:52:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB474D11D;
	Mon, 22 Apr 2024 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713772370; cv=none; b=TAaXcP9Q0+krniBIpZ1ROsDbpD4EfPv51ioLYCzngUpgEkxzJjIGeiiRqVhwbYvIYAy0T0RG9RIYuQG0NJTqfuXHgC7bu5E/N02SPpC8VmL4a9NqZ91rZ1Sc/MQqeEjcxy//KKRVAbNG3In/qvlcCapiZFEcpYQ+9xQwj0csuP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713772370; c=relaxed/simple;
	bh=bW9HjX4LaZVpuu6vQpERXglqt9TH4x6tPuuX5ujB2H0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mTVh3tf9q5ZfnaRSJ1pXHToBA8pJGfXaqTTdo5P2rdgcAl4R32/WlGw8DLoRECO4k0iMkIstEazmsgqHA0/QBI9fQBhMKGwPkrTwqT26fMopX9mAreA/eXlg7GYuYELh9ZL1RBTIc0M6knu8V+TiNJ1tmRuZD7oZIn5AdfDUJGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VNHXf6Lb0z4f3mJL;
	Mon, 22 Apr 2024 15:52:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 041571A0572;
	Mon, 22 Apr 2024 15:52:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgCHqg1JFyZmCViLKw--.3978S4;
	Mon, 22 Apr 2024 15:52:43 +0800 (CST)
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
Subject: [PATCH v4 2/4] writeback: support retrieving per group debug writeback stats of bdi
Date: Tue, 23 Apr 2024 00:48:06 +0800
Message-Id: <20240422164808.13627-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240422164808.13627-1-shikemeng@huaweicloud.com>
References: <20240422164808.13627-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCHqg1JFyZmCViLKw--.3978S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw15uFyfXw1UKFWkCF1xZrb_yoW7uw15pa
	98Gw15Jr4UZr17WFZxAay2qry5tw48trW7X3s7Z3yftFnrtry3tFy8ury8Ary5AF93AFy3
	Jan8Cry8GrWkKrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK
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
	ImhFDUUUU
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
 mm/backing-dev.c          | 78 ++++++++++++++++++++++++++++++++++++++-
 mm/page-writeback.c       | 19 ++++++++++
 3 files changed, 96 insertions(+), 2 deletions(-)

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
index 089146feb830..6ecd11bdce6e 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -155,19 +155,93 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(bdi_debug_stats);
 
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
+		   "state:             %10lx\n\n",
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
+	struct backing_dev_info *bdi = m->private;
+	unsigned long background_thresh;
+	unsigned long dirty_thresh;
+	struct bdi_writeback *wb;
+	struct wb_stats stats;
+
+	global_dirty_limits(&background_thresh, &dirty_thresh);
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(wb, &bdi->wb_list, bdi_node) {
+		struct wb_stats stats = { .dirty_thresh = dirty_thresh };
+
+		if (!wb_tryget(wb))
+			continue;
+
+		collect_wb_stats(&stats, wb);
+
+		/*
+		 * Calculate thresh of wb in writeback cgroup which is min of
+		 * thresh in global domain and thresh in cgroup domain. Drop
+		 * rcu lock because cgwb_calc_thresh may sleep in
+		 * cgroup_rstat_flush. We can do so here because we have a ref.
+		 */
+		if (mem_cgroup_wb_domain(wb)) {
+			rcu_read_unlock();
+			stats.wb_thresh = min(stats.wb_thresh, cgwb_calc_thresh(wb));
+			rcu_read_lock();
+		}
+
+		wb_stats_show(m, wb, &stats);
+
+		wb_put(wb);
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(cgwb_debug_stats);
+
 static void bdi_debug_register(struct backing_dev_info *bdi, const char *name)
 {
 	bdi->debug_dir = debugfs_create_dir(name, bdi_debug_root);
 
 	debugfs_create_file("stats", 0444, bdi->debug_dir, bdi,
 			    &bdi_debug_stats_fops);
+	debugfs_create_file("wb_stats", 0444, bdi->debug_dir, bdi,
+			    &cgwb_debug_stats_fops);
 }
 
 static void bdi_debug_unregister(struct backing_dev_info *bdi)
 {
 	debugfs_remove_recursive(bdi->debug_dir);
 }
-#else
+#else /* CONFIG_DEBUG_FS */
 static inline void bdi_debug_init(void)
 {
 }
@@ -178,7 +252,7 @@ static inline void bdi_debug_register(struct backing_dev_info *bdi,
 static inline void bdi_debug_unregister(struct backing_dev_info *bdi)
 {
 }
-#endif
+#endif /* CONFIG_DEBUG_FS */
 
 static ssize_t read_ahead_kb_store(struct device *dev,
 				  struct device_attribute *attr,
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 3e19b87049db..3bb3bed102ef 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -892,6 +892,25 @@ unsigned long wb_calc_thresh(struct bdi_writeback *wb, unsigned long thresh)
 	return __wb_calc_thresh(&gdtc);
 }
 
+unsigned long cgwb_calc_thresh(struct bdi_writeback *wb)
+{
+	struct dirty_throttle_control gdtc = { GDTC_INIT_NO_WB };
+	struct dirty_throttle_control mdtc = { MDTC_INIT(wb, &gdtc) };
+	unsigned long filepages = 0, headroom = 0, writeback = 0;
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
+	return __wb_calc_thresh(&mdtc);
+}
+
 /*
  *                           setpoint - dirty 3
  *        f(dirty) := 1.0 + (----------------)
-- 
2.30.0


