Return-Path: <linux-fsdevel+bounces-15381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8901A88D6ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 08:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB0D29EDD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 07:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655E52C69F;
	Wed, 27 Mar 2024 07:01:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C873A241E9;
	Wed, 27 Mar 2024 07:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711522915; cv=none; b=i/+vJ/hihVPsEOQoFXpLjh9reQWqwgatBiWMAid6FvnjdnFekpvy+yCWc2YxRpLSfZb06jfGcK+ub+4ZANLgXhVTbNZvm9DHXNqnubGq3Qu/UDMpe2iGqcRkbDrPX0ndwzNXMawvZDGGINdJJ3yKwZeqomSFIPWhO1I1TuzZdmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711522915; c=relaxed/simple;
	bh=yvIHuZnHS3P1w7wQs5ybBMz5fYwyrHDai0b/LPWjpiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bFrnBpn2pXABf7Zt7kJccqKJwd2H+4r8FrVEImnJs9RYTY7mL4LQ/dJbDAonFkPlheOQ89M8SLnr5Z7qB/5I+5VbPcYWOQD2FtMsxxF+DtqZwJn4QZHodi2gDwMorxvoSxsSZ7OIQ/rl+PYEUINYjboBlQ7v/roTgF7OQqOUtgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V4Hdv6RHHz4f3nJN;
	Wed, 27 Mar 2024 15:01:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 0DF671A01A7;
	Wed, 27 Mar 2024 15:01:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgAnSQxYxANmi6+LIQ--.50310S4;
	Wed, 27 Mar 2024 15:01:47 +0800 (CST)
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
Subject: [PATCH v2 2/6] writeback: collect stats of all wb of bdi in bdi_debug_stats_show
Date: Wed, 27 Mar 2024 23:57:47 +0800
Message-Id: <20240327155751.3536-3-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgAnSQxYxANmi6+LIQ--.50310S4
X-Coremail-Antispam: 1UD129KBjvJXoWxKFWrtw43Ar13CF1rAFWUJwb_yoW7ZrW3pF
	ZxK34xJrW8ZFyfWFZxAFWDWrW5tw40q342qF97C3yFk3WDZr9xtFyfCa40yry5CFZ7GF13
	Jan5Ary8CrWDK3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

/sys/kernel/debug/bdi/xxx/stats is supposed to show writeback information
of whole bdi, but only writeback information of bdi in root cgroup is
collected. So writeback information in non-root cgroup are missing now.
To be more specific, considering following case:

/* create writeback cgroup */
cd /sys/fs/cgroup
echo "+memory +io" > cgroup.subtree_control
mkdir group1
cd group1
echo $$ > cgroup.procs
/* do writeback in cgroup */
fio -name test -filename=/dev/vdb ...
/* get writeback info of bdi */
cat /sys/kernel/debug/bdi/xxx/stats
The cat result unexpectedly implies that there is no writeback on target
bdi.

Fix this by collecting stats of all wb in bdi instead of only wb in
root cgroup.

Following domain hierarchy is tested:
                global domain (320G)
                /                 \
        cgroup domain1(10G)     cgroup domain2(10G)
                |                 |
bdi            wb1               wb2

/* all writeback info of bdi is successfully collected */
cat stats
BdiWriteback:             2912 kB
BdiReclaimable:        1598464 kB
BdiDirtyThresh:      167479028 kB
DirtyThresh:         195038532 kB
BackgroundThresh:     32466728 kB
BdiDirtied:           19141696 kB
BdiWritten:           17543456 kB
BdiWriteBandwidth:     1136172 kBps
b_dirty:                     2
b_io:                        0
b_more_io:                   1
b_dirty_time:                0
bdi_list:                    1
state:                       1

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/backing-dev.c | 100 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 71 insertions(+), 29 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 70f02959f3bd..8daf950e6855 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -39,6 +39,19 @@ struct workqueue_struct *bdi_wq;
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 
+struct wb_stats {
+	unsigned long nr_dirty;
+	unsigned long nr_io;
+	unsigned long nr_more_io;
+	unsigned long nr_dirty_time;
+	unsigned long nr_writeback;
+	unsigned long nr_reclaimable;
+	unsigned long nr_dirtied;
+	unsigned long nr_written;
+	unsigned long dirty_thresh;
+	unsigned long wb_thresh;
+};
+
 static struct dentry *bdi_debug_root;
 
 static void bdi_debug_init(void)
@@ -65,16 +78,54 @@ static struct backing_dev_info *lookup_bdi(struct seq_file *m)
 	return NULL;
 }
 
+static void collect_wb_stats(struct wb_stats *stats,
+			     struct bdi_writeback *wb)
+{
+	struct inode *inode;
+
+	spin_lock(&wb->list_lock);
+	list_for_each_entry(inode, &wb->b_dirty, i_io_list)
+		stats->nr_dirty++;
+	list_for_each_entry(inode, &wb->b_io, i_io_list)
+		stats->nr_io++;
+	list_for_each_entry(inode, &wb->b_more_io, i_io_list)
+		stats->nr_more_io++;
+	list_for_each_entry(inode, &wb->b_dirty_time, i_io_list)
+		if (inode->i_state & I_DIRTY_TIME)
+			stats->nr_dirty_time++;
+	spin_unlock(&wb->list_lock);
+
+	stats->nr_writeback += wb_stat(wb, WB_WRITEBACK);
+	stats->nr_reclaimable += wb_stat(wb, WB_RECLAIMABLE);
+	stats->nr_dirtied += wb_stat(wb, WB_DIRTIED);
+	stats->nr_written += wb_stat(wb, WB_WRITTEN);
+	stats->wb_thresh += wb_calc_thresh(wb, stats->dirty_thresh);
+}
+
+#ifdef CONFIG_CGROUP_WRITEBACK
+static void bdi_collect_stats(struct backing_dev_info *bdi,
+			      struct wb_stats *stats)
+{
+	struct bdi_writeback *wb;
+
+	list_for_each_entry_rcu(wb, &bdi->wb_list, bdi_node)
+		collect_wb_stats(stats, wb);
+}
+#else
+static void bdi_collect_stats(struct backing_dev_info *bdi,
+			      struct wb_stats *stats)
+{
+	collect_wb_stats(stats, &bdi->wb);
+}
+#endif
 
 static int bdi_debug_stats_show(struct seq_file *m, void *v)
 {
 	struct backing_dev_info *bdi;
-	struct bdi_writeback *wb;
 	unsigned long background_thresh;
 	unsigned long dirty_thresh;
-	unsigned long wb_thresh;
-	unsigned long nr_dirty, nr_io, nr_more_io, nr_dirty_time;
-	struct inode *inode;
+	struct wb_stats stats;
+	unsigned long tot_bw;
 
 	rcu_read_lock();
 	bdi = lookup_bdi(m);
@@ -83,22 +134,13 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
 		return -EEXIST;
 	}
 
-	wb = &bdi->wb;
-	nr_dirty = nr_io = nr_more_io = nr_dirty_time = 0;
-	spin_lock(&wb->list_lock);
-	list_for_each_entry(inode, &wb->b_dirty, i_io_list)
-		nr_dirty++;
-	list_for_each_entry(inode, &wb->b_io, i_io_list)
-		nr_io++;
-	list_for_each_entry(inode, &wb->b_more_io, i_io_list)
-		nr_more_io++;
-	list_for_each_entry(inode, &wb->b_dirty_time, i_io_list)
-		if (inode->i_state & I_DIRTY_TIME)
-			nr_dirty_time++;
-	spin_unlock(&wb->list_lock);
-
 	global_dirty_limits(&background_thresh, &dirty_thresh);
-	wb_thresh = wb_calc_thresh(wb, dirty_thresh);
+
+	memset(&stats, 0, sizeof(stats));
+	stats.dirty_thresh = dirty_thresh;
+	bdi_collect_stats(bdi, &stats);
+
+	tot_bw = atomic_long_read(&bdi->tot_write_bandwidth);
 
 	seq_printf(m,
 		   "BdiWriteback:       %10lu kB\n"
@@ -115,18 +157,18 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
 		   "b_dirty_time:       %10lu\n"
 		   "bdi_list:           %10u\n"
 		   "state:              %10lx\n",
-		   (unsigned long) K(wb_stat(wb, WB_WRITEBACK)),
-		   (unsigned long) K(wb_stat(wb, WB_RECLAIMABLE)),
-		   K(wb_thresh),
+		   K(stats.nr_writeback),
+		   K(stats.nr_reclaimable),
+		   K(stats.wb_thresh),
 		   K(dirty_thresh),
 		   K(background_thresh),
-		   (unsigned long) K(wb_stat(wb, WB_DIRTIED)),
-		   (unsigned long) K(wb_stat(wb, WB_WRITTEN)),
-		   (unsigned long) K(wb->write_bandwidth),
-		   nr_dirty,
-		   nr_io,
-		   nr_more_io,
-		   nr_dirty_time,
+		   K(stats.nr_dirtied),
+		   K(stats.nr_written),
+		   K(tot_bw),
+		   stats.nr_dirty,
+		   stats.nr_io,
+		   stats.nr_more_io,
+		   stats.nr_dirty_time,
 		   !list_empty(&bdi->bdi_list), bdi->wb.state);
 
 	rcu_read_unlock();
-- 
2.30.0


