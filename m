Return-Path: <linux-fsdevel+bounces-14856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EA388096C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 03:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD882852FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 02:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B1D14A96;
	Wed, 20 Mar 2024 02:06:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE462125BF;
	Wed, 20 Mar 2024 02:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710900371; cv=none; b=lsSwS5bnF0JbQqVyB2wt/9CVFffq1sG6nJRRNEfGs5yuCCO+paa6xmcg7C7G7R75qL98u9rc5B/i/oa1+Gz1JPYXG+Kpj4drmv+n3DfDPlukAsLVxbIZPYlpm6COws6qOngMYrZRrF8p206+URUp+9ZbQfGkY76BqCFjJV+L3g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710900371; c=relaxed/simple;
	bh=qvYOhg0Z86+7p6sXbgCcPm6ntyHxDWHUCmVkBumS6bY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A7rgpPF4Mj/s/zbAPrgXBc6jsI5vHBjAr54SHHJM8I9707Ld8LEEq/vGnhDVR6ubRnXHiuCaeBYoAFF0NNUnRStLv2mbOqIIXHMivio24mff5ZrIzZ8VL9oynenm73VW07hZE7paVltoueZxmf9L7juPBQSp+X+V+0MIuLFnhoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TzsPx5jV2z4f3lfR;
	Wed, 20 Mar 2024 10:05:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B36E91A0BE2;
	Wed, 20 Mar 2024 10:06:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP3 (Coremail) with SMTP id _Ch0CgAHFZ2KRPplVj2CHQ--.18626S4;
	Wed, 20 Mar 2024 10:06:05 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	tj@kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	bfoster@redhat.com,
	jack@suse.cz,
	dsterba@suse.com,
	mjguzik@gmail.com,
	dhowells@redhat.com,
	peterz@infradead.org
Subject: [PATCH 2/6] writeback: support retrieving per group debug writeback stats of bdi
Date: Wed, 20 Mar 2024 19:02:18 +0800
Message-Id: <20240320110222.6564-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240320110222.6564-1-shikemeng@huaweicloud.com>
References: <20240320110222.6564-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHFZ2KRPplVj2CHQ--.18626S4
X-Coremail-Antispam: 1UD129KBjvJXoWxur1rCr4xKFWUtFWrAFWfGrg_yoWruw4kpF
	sxGw1rJrWUZr17WFZxAFZrXry3Jw4FqrW2qF97ZayrKFnrKF1aqFyxury0yr1UJrWfAFya
	vws0kry8urW8KrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
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

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 include/linux/writeback.h |  1 +
 mm/backing-dev.c          | 66 +++++++++++++++++++++++++++++++++++++++
 mm/page-writeback.c       | 19 +++++++++++
 3 files changed, 86 insertions(+)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 9845cb62e40b..bb1ce1123b52 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -355,6 +355,7 @@ int dirtytime_interval_handler(struct ctl_table *table, int write,
 
 void global_dirty_limits(unsigned long *pbackground, unsigned long *pdirty);
 unsigned long wb_calc_thresh(struct bdi_writeback *wb, unsigned long thresh);
+unsigned long wb_calc_cg_thresh(struct bdi_writeback *wb);
 
 void wb_update_bandwidth(struct bdi_writeback *wb);
 
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 788702b6c5dd..bfc4079dc7fe 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -95,12 +95,77 @@ static void bdi_collect_stats(struct backing_dev_info *bdi,
 		collect_wb_stats(stats, wb);
 	mutex_unlock(&bdi->cgwb_release_mutex);
 }
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
+	struct backing_dev_info *bdi = m->private;
+	unsigned long background_thresh;
+	unsigned long dirty_thresh;
+	struct bdi_writeback *wb;
+	struct wb_stats stats;
+
+	global_dirty_limits(&background_thresh, &dirty_thresh);
+
+	mutex_lock(&bdi->cgwb_release_mutex);
+	list_for_each_entry(wb, &bdi->wb_list, bdi_node) {
+		memset(&stats, 0, sizeof(stats));
+		stats.dirty_thresh = dirty_thresh;
+		collect_wb_stats(&stats, wb);
+
+		if (mem_cgroup_wb_domain(wb) != NULL)
+			stats.wb_thresh = min(stats.wb_thresh, wb_calc_cg_thresh(wb));
+
+		wb_stats_show(m, wb, &stats);
+	}
+	mutex_unlock(&bdi->cgwb_release_mutex);
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
 #else
 static void bdi_collect_stats(struct backing_dev_info *bdi,
 			      struct wb_stats *stats)
 {
 	collect_wb_stats(stats, &bdi->wb);
 }
+
+static inline void cgwb_debug_register(struct backing_dev_info *bdi) { }
 #endif
 
 static int bdi_debug_stats_show(struct seq_file *m, void *v)
@@ -158,6 +223,7 @@ static void bdi_debug_register(struct backing_dev_info *bdi, const char *name)
 
 	debugfs_create_file("stats", 0444, bdi->debug_dir, bdi,
 			    &bdi_debug_stats_fops);
+	cgwb_debug_register(bdi);
 }
 
 static void bdi_debug_unregister(struct backing_dev_info *bdi)
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 0e20467367fe..ba1b6b5ae5d6 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -893,6 +893,25 @@ unsigned long wb_calc_thresh(struct bdi_writeback *wb, unsigned long thresh)
 	return __wb_calc_thresh(&gdtc, thresh);
 }
 
+unsigned long wb_calc_cg_thresh(struct bdi_writeback *wb)
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


