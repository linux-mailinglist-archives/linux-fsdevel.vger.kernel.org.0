Return-Path: <linux-fsdevel+bounces-15378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E5B88D6E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 08:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD8629B514
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 07:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365052869B;
	Wed, 27 Mar 2024 07:01:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B8E22EF4;
	Wed, 27 Mar 2024 07:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711522913; cv=none; b=FZSDZ6j9Pci9qFSg5RUbmF4MXaXWYbj+5eXq3x4dBfDYERmw6qntLFMX8U+x4R7510vbQNz9eiBrw2BdiToisslqFBnnevbG9BzDx49g0TQNl8n2orbxZachJxEyQKvEsQB54jZ8+PAZHztJkFY7Z4gPQaOwrTzUoLrpZbu/bR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711522913; c=relaxed/simple;
	bh=Da6WKkdwXEW3Uy5MxJK9kmVZJKTBr2ijuXv5dLTTo2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=azoVjl4/3eBhc92qFU2pykTZDqGVkF8xZXUo+8grDh6UAQmwVW5JFxVLAue62jN+wwJOxy1fYwxphfrppie8iY0KNSSyu4zuDqIl5fBrqwQypYNUkU4GJZ10t6FddSCxYrAALoxxCM9XCgL4IIOsJ6CfhvMQAcXsWd2MFfEhNng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V4Hdv3H6Cz4f3n6M;
	Wed, 27 Mar 2024 15:01:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 93C3E1A0572;
	Wed, 27 Mar 2024 15:01:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgAnSQxYxANmi6+LIQ--.50310S3;
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
Subject: [PATCH v2 1/6] writeback: protect race between bdi release and bdi_debug_stats_show
Date: Wed, 27 Mar 2024 23:57:46 +0800
Message-Id: <20240327155751.3536-2-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgAnSQxYxANmi6+LIQ--.50310S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyxtw4DKF4UJry7XFyDtrb_yoW8uFy5pa
	1Ykas8Gr48X347Wr13ZFWDurZaq3ySqwnrWF97uws3Cr1kA34akFyxCFyjyr1rArZ5C34Y
	qan0qrWUCrWUAaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
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
	3Xo2DUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

There is a race between bdi release and bdi_debug_stats_show:
/* get debug info */		/* bdi release */
bdi_debug_stats_show
  bdi = m->private;
  wb = &bdi->wb;
				bdi_unregister
				bdi_put
				  release_bdi
				    kfree(bdi)
  /* use after free */
  spin_lock(&wb->list_lock);

Search bdi on bdi_list under rcu lock in bdi_debug_stats_show to ensure
the bdi is not freed to fix the issue.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/backing-dev.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 5f2be8c8df11..70f02959f3bd 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -46,16 +46,44 @@ static void bdi_debug_init(void)
 	bdi_debug_root = debugfs_create_dir("bdi", NULL);
 }
 
-static int bdi_debug_stats_show(struct seq_file *m, void *v)
+static struct backing_dev_info *lookup_bdi(struct seq_file *m)
 {
+	const struct file *file = m->file;
 	struct backing_dev_info *bdi = m->private;
-	struct bdi_writeback *wb = &bdi->wb;
+	struct backing_dev_info *exist;
+
+	list_for_each_entry_rcu(exist, &bdi_list, bdi_list) {
+		if (exist != bdi)
+			continue;
+
+		if (exist->debug_dir == file->f_path.dentry->d_parent)
+			return bdi;
+		else
+			return NULL;
+	}
+
+	return NULL;
+}
+
+
+static int bdi_debug_stats_show(struct seq_file *m, void *v)
+{
+	struct backing_dev_info *bdi;
+	struct bdi_writeback *wb;
 	unsigned long background_thresh;
 	unsigned long dirty_thresh;
 	unsigned long wb_thresh;
 	unsigned long nr_dirty, nr_io, nr_more_io, nr_dirty_time;
 	struct inode *inode;
 
+	rcu_read_lock();
+	bdi = lookup_bdi(m);
+	if (!bdi) {
+		rcu_read_unlock();
+		return -EEXIST;
+	}
+
+	wb = &bdi->wb;
 	nr_dirty = nr_io = nr_more_io = nr_dirty_time = 0;
 	spin_lock(&wb->list_lock);
 	list_for_each_entry(inode, &wb->b_dirty, i_io_list)
@@ -101,6 +129,7 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
 		   nr_dirty_time,
 		   !list_empty(&bdi->bdi_list), bdi->wb.state);
 
+	rcu_read_unlock();
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(bdi_debug_stats);
-- 
2.30.0


