Return-Path: <linux-fsdevel+bounces-17452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6848ADC62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 05:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772841F21A44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 03:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BED1C6A4;
	Tue, 23 Apr 2024 03:46:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE34101E6;
	Tue, 23 Apr 2024 03:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713844012; cv=none; b=jRBp4wpLxXXjLNhO4RTzAGv2LchROY7UXN1ivFIS83TGJKNwDAtvzE0ZglPoOmWhAk5CTDNyALe+gWzhauBCgQkJpZrhYdU6boM/qGudgdlezcujLfPEs05YGarcNiPPEl6f0klOxaWzLn+tO7UjxNmXpi0sWV7r01moo7qbEzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713844012; c=relaxed/simple;
	bh=j3b+l71XmEBZWE0mleGdqs57RH6jOc6jg31shEkpV4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KF0uCRrGONX0cipfuMz1GgmouDxbhirm8ZWzLiDGNNb6lkhRAL+AtwIF357IY2D6De3ejGO5iMBwBl9teNHjEM7kCi3yGZPm9e/Mgw/htkAduLvW7G/+BkT09J0JfqsPvTy2UXokt8FME3yy5K4G5pySbUE1rogPSwG8WAyLgLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VNp2Q5j07z4f3kpC;
	Tue, 23 Apr 2024 11:46:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 452A31A0568;
	Tue, 23 Apr 2024 11:46:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgA3Ww4kLydmKkDYKw--.11241S3;
	Tue, 23 Apr 2024 11:46:46 +0800 (CST)
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
Subject: [PATCH v5 1/5] writeback: collect stats of all wb of bdi in bdi_debug_stats_show
Date: Tue, 23 Apr 2024 11:46:39 +0800
Message-Id: <20240423034643.141219-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240423034643.141219-1-shikemeng@huaweicloud.com>
References: <20240423034643.141219-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgA3Ww4kLydmKkDYKw--.11241S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr4kKF15Jw13GF4rGF13twb_yoW7AFyfpF
	ZxGw1fJrWxZFyfWasxZFWDXrW5tw40q342qF97C3y5G3WDAFy3KFyfua4jyr1UGFZ7JFy3
	Jan8ArykC3yUKF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2CD7DUUUU
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
Acked-by: Tejun Heo <tj@kernel.org>
---
 mm/backing-dev.c | 96 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 73 insertions(+), 23 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 5fa3666356f9..089146feb830 100644
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
@@ -46,31 +59,68 @@ static void bdi_debug_init(void)
 	bdi_debug_root = debugfs_create_dir("bdi", NULL);
 }
 
-static int bdi_debug_stats_show(struct seq_file *m, void *v)
+static void collect_wb_stats(struct wb_stats *stats,
+			     struct bdi_writeback *wb)
 {
-	struct backing_dev_info *bdi = m->private;
-	struct bdi_writeback *wb = &bdi->wb;
-	unsigned long background_thresh;
-	unsigned long dirty_thresh;
-	unsigned long wb_thresh;
-	unsigned long nr_dirty, nr_io, nr_more_io, nr_dirty_time;
 	struct inode *inode;
 
-	nr_dirty = nr_io = nr_more_io = nr_dirty_time = 0;
 	spin_lock(&wb->list_lock);
 	list_for_each_entry(inode, &wb->b_dirty, i_io_list)
-		nr_dirty++;
+		stats->nr_dirty++;
 	list_for_each_entry(inode, &wb->b_io, i_io_list)
-		nr_io++;
+		stats->nr_io++;
 	list_for_each_entry(inode, &wb->b_more_io, i_io_list)
-		nr_more_io++;
+		stats->nr_more_io++;
 	list_for_each_entry(inode, &wb->b_dirty_time, i_io_list)
 		if (inode->i_state & I_DIRTY_TIME)
-			nr_dirty_time++;
+			stats->nr_dirty_time++;
 	spin_unlock(&wb->list_lock);
 
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
+	rcu_read_lock();
+	list_for_each_entry_rcu(wb, &bdi->wb_list, bdi_node) {
+		if (!wb_tryget(wb))
+			continue;
+
+		collect_wb_stats(stats, wb);
+		wb_put(wb);
+	}
+	rcu_read_unlock();
+}
+#else
+static void bdi_collect_stats(struct backing_dev_info *bdi,
+			      struct wb_stats *stats)
+{
+	collect_wb_stats(stats, &bdi->wb);
+}
+#endif
+
+static int bdi_debug_stats_show(struct seq_file *m, void *v)
+{
+	struct backing_dev_info *bdi = m->private;
+	unsigned long background_thresh;
+	unsigned long dirty_thresh;
+	struct wb_stats stats;
+	unsigned long tot_bw;
+
 	global_dirty_limits(&background_thresh, &dirty_thresh);
-	wb_thresh = wb_calc_thresh(wb, dirty_thresh);
+
+	memset(&stats, 0, sizeof(stats));
+	stats.dirty_thresh = dirty_thresh;
+	bdi_collect_stats(bdi, &stats);
+	tot_bw = atomic_long_read(&bdi->tot_write_bandwidth);
 
 	seq_printf(m,
 		   "BdiWriteback:       %10lu kB\n"
@@ -87,18 +137,18 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
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
 
 	return 0;
-- 
2.30.0


