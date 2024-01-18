Return-Path: <linux-fsdevel+bounces-8242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A978831935
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 13:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B83E281B0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 12:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628F424B3F;
	Thu, 18 Jan 2024 12:35:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78B3241E2;
	Thu, 18 Jan 2024 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705581357; cv=none; b=C36MNhYe+fPLIT2DuSylRZRIVEGkaIzFf1BjOlSuDI/Gn2kJkk6dYnSF0xU9OFPF53Pg+L4DrKU0vrJYWNuJ1Qt6t5eO1sz2DBAkBr8an9ncM1esqyFcAjGrdieeqWU3n/9uw4G23ypYwYoVlXmuyHS34AGBGCZVyvKO3r+Ga1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705581357; c=relaxed/simple;
	bh=9A1ZUxsy/AB+rOw07Sr8ohg0qHFUf+8+K2LosBjInkU=;
	h=Received:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo; b=GQdffU+44hBtARWPJbn9je7baFK2ysISUUltaNRxskZaTEHSgGL2FOR1j10ykhAuWOwA+PSaGxbhhWYuIlECtTl/8/BJFwEEh+dViw/QP7K3yOfitVsERJu0fLDDh5Ngm3L5uspwmjuVeiLROyCyDSv16kAaA79nawzxPRbLzYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TG2KH3xJdz4f3kFk;
	Thu, 18 Jan 2024 20:35:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5072C1A017A;
	Thu, 18 Jan 2024 20:35:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAHWmwmG6lle9LlBA--.42947S2;
	Thu, 18 Jan 2024 20:35:51 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	akpm@linux-foundation.org
Cc: tj@kernel.org,
	xiujianfeng@huawei.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] writeback: move wb_wakeup_delayed defination to fs-writeback.c
Date: Fri, 19 Jan 2024 04:33:39 +0800
Message-Id: <20240118203339.764093-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHWmwmG6lle9LlBA--.42947S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFy3ur1kKw4UJFWDury5CFg_yoWrJw17pF
	y3K3sxJF48Zry7WrsxWay2gr1Yg3ykKr47GFyxWFs7tr9rua1Y9FWvgry0yF1UCrZ3ZFW3
	ur4FvrW8urW0yr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_
	tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gc
	CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxI
	r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87
	Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
	vE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU01mh7UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

The wb_wakeup_delayed is only used in fs-writeback.c. Move it to
fs-writeback.c after defination of wb_wakeup and make it static.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/fs-writeback.c           | 25 +++++++++++++++++++++++++
 include/linux/backing-dev.h |  1 -
 mm/backing-dev.c            | 25 -------------------------
 3 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 1767493dffda..5ab1aaf805f7 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -141,6 +141,31 @@ static void wb_wakeup(struct bdi_writeback *wb)
 	spin_unlock_irq(&wb->work_lock);
 }
 
+/*
+ * This function is used when the first inode for this wb is marked dirty. It
+ * wakes-up the corresponding bdi thread which should then take care of the
+ * periodic background write-out of dirty inodes. Since the write-out would
+ * starts only 'dirty_writeback_interval' centisecs from now anyway, we just
+ * set up a timer which wakes the bdi thread up later.
+ *
+ * Note, we wouldn't bother setting up the timer, but this function is on the
+ * fast-path (used by '__mark_inode_dirty()'), so we save few context switches
+ * by delaying the wake-up.
+ *
+ * We have to be careful not to postpone flush work if it is scheduled for
+ * earlier. Thus we use queue_delayed_work().
+ */
+static void wb_wakeup_delayed(struct bdi_writeback *wb)
+{
+	unsigned long timeout;
+
+	timeout = msecs_to_jiffies(dirty_writeback_interval * 10);
+	spin_lock_irq(&wb->work_lock);
+	if (test_bit(WB_registered, &wb->state))
+		queue_delayed_work(bdi_wq, &wb->dwork, timeout);
+	spin_unlock_irq(&wb->work_lock);
+}
+
 static void finish_writeback_work(struct bdi_writeback *wb,
 				  struct wb_writeback_work *work)
 {
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 1a97277f99b1..8e7af9a03b41 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -38,7 +38,6 @@ struct backing_dev_info *bdi_alloc(int node_id);
 
 void wb_start_background_writeback(struct bdi_writeback *wb);
 void wb_workfn(struct work_struct *work);
-void wb_wakeup_delayed(struct bdi_writeback *wb);
 
 void wb_wait_for_completion(struct wb_completion *done);
 
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 1e3447bccdb1..039dc74b505a 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -372,31 +372,6 @@ static int __init default_bdi_init(void)
 }
 subsys_initcall(default_bdi_init);
 
-/*
- * This function is used when the first inode for this wb is marked dirty. It
- * wakes-up the corresponding bdi thread which should then take care of the
- * periodic background write-out of dirty inodes. Since the write-out would
- * starts only 'dirty_writeback_interval' centisecs from now anyway, we just
- * set up a timer which wakes the bdi thread up later.
- *
- * Note, we wouldn't bother setting up the timer, but this function is on the
- * fast-path (used by '__mark_inode_dirty()'), so we save few context switches
- * by delaying the wake-up.
- *
- * We have to be careful not to postpone flush work if it is scheduled for
- * earlier. Thus we use queue_delayed_work().
- */
-void wb_wakeup_delayed(struct bdi_writeback *wb)
-{
-	unsigned long timeout;
-
-	timeout = msecs_to_jiffies(dirty_writeback_interval * 10);
-	spin_lock_irq(&wb->work_lock);
-	if (test_bit(WB_registered, &wb->state))
-		queue_delayed_work(bdi_wq, &wb->dwork, timeout);
-	spin_unlock_irq(&wb->work_lock);
-}
-
 static void wb_update_bandwidth_workfn(struct work_struct *work)
 {
 	struct bdi_writeback *wb = container_of(to_delayed_work(work),
-- 
2.30.0


