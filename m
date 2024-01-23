Return-Path: <linux-fsdevel+bounces-8529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1F7838C2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 11:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04BC1C22A29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 10:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B762B5C909;
	Tue, 23 Jan 2024 10:35:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D995C618;
	Tue, 23 Jan 2024 10:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006156; cv=none; b=XAjXUsW5W5Os5huM+o+zt12DkgJpGi0tAj2DPteCwlGfdbfwjA4urdKxdxcPmgY339k8ZJ+JTb+xzqQqVqJvBFUpz3a0ME6CUmxZSTs5/Pr/kAL6wB6vPjNciSxta5S4/soNkxM3vpJ5mig9NMFoWDNJm/kd5a7pnw3MxIwwB3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006156; c=relaxed/simple;
	bh=2cNP4Yx5S2UVM++084bf4o4tRbc7pSIPr9tRrCFa0TQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nX71XBgDqrw2/xMpiRBiHWPxett+SBrbA0SfxJZMg3DpWqyqm02RvjXaMHBBicwKMj3Frk8h0W5aATfj5Ai+Y46ncBjHaWPFTJCcrTXI44J5ygVql1vyFWVYib2P3mzMSe8DnaeymnuwU/J8FHkOeVPBXC3pfhdg1fvfaIWvSbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TK3QT1SSgz4f3lfn;
	Tue, 23 Jan 2024 18:35:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 778851A0232;
	Tue, 23 Jan 2024 18:35:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgA3Bg+Flq9ly6DjBg--.30161S3;
	Tue, 23 Jan 2024 18:35:51 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: willy@infradead.org,
	akpm@linux-foundation.org
Cc: tj@kernel.org,
	hcochran@kernelspring.com,
	mszeredi@redhat.com,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] mm: enable __wb_calc_thresh to calculate dirty background threshold
Date: Wed, 24 Jan 2024 02:33:28 +0800
Message-Id: <20240123183332.876854-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240123183332.876854-1-shikemeng@huaweicloud.com>
References: <20240123183332.876854-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3Bg+Flq9ly6DjBg--.30161S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4rZrWfJr45Gw1rWrWkCrg_yoWrGF47pF
	W3Xw17CF4UJrZ7ZrsxAFyruFWavws7JFW2q3s7Jw15tw1akryUKr12kF4vyFy5AF93JFy3
	AFWYqr97XF1qyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUsWrWDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Originally, __wb_calc_thresh always calculate wb's share of dirty
throttling threshold. By getting thresh of wb_domain from caller,
__wb_calc_thresh could be used for both dirty throttling and dirty
background threshold.

This is a preparation to correct threshold calculation of wb in cgroup.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page-writeback.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index cd4e4ae77c40..9268859722c4 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -838,13 +838,15 @@ static void mdtc_calc_avail(struct dirty_throttle_control *mdtc,
 }
 
 /**
- * __wb_calc_thresh - @wb's share of dirty throttling threshold
+ * __wb_calc_thresh - @wb's share of dirty threshold
  * @dtc: dirty_throttle_context of interest
+ * @thresh: dirty throttling or dirty background threshold of wb_domain in @dtc
  *
- * Note that balance_dirty_pages() will only seriously take it as a hard limit
- * when sleeping max_pause per page is not enough to keep the dirty pages under
- * control. For example, when the device is completely stalled due to some error
- * conditions, or when there are 1000 dd tasks writing to a slow 10MB/s USB key.
+ * Note that balance_dirty_pages() will only seriously take dirty throttling
+ * threshold as a hard limit when sleeping max_pause per page is not enough
+ * to keep the dirty pages under control. For example, when the device is
+ * completely stalled due to some error conditions, or when there are 1000
+ * dd tasks writing to a slow 10MB/s USB key.
  * In the other normal situations, it acts more gently by throttling the tasks
  * more (rather than completely block them) when the wb dirty pages go high.
  *
@@ -855,19 +857,20 @@ static void mdtc_calc_avail(struct dirty_throttle_control *mdtc,
  * The wb's share of dirty limit will be adapting to its throughput and
  * bounded by the bdi->min_ratio and/or bdi->max_ratio parameters, if set.
  *
- * Return: @wb's dirty limit in pages. The term "dirty" in the context of
- * dirty balancing includes all PG_dirty and PG_writeback pages.
+ * Return: @wb's dirty limit in pages. For dirty throttling limit, the term
+ * "dirty" in the context of dirty balancing includes all PG_dirty and
+ * PG_writeback pages.
  */
-static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc)
+static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
+				      unsigned long thresh)
 {
 	struct wb_domain *dom = dtc_dom(dtc);
-	unsigned long thresh = dtc->thresh;
 	u64 wb_thresh;
 	unsigned long numerator, denominator;
 	unsigned long wb_min_ratio, wb_max_ratio;
 
 	/*
-	 * Calculate this BDI's share of the thresh ratio.
+	 * Calculate this wb's share of the thresh ratio.
 	 */
 	fprop_fraction_percpu(&dom->completions, dtc->wb_completions,
 			      &numerator, &denominator);
@@ -887,9 +890,9 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc)
 
 unsigned long wb_calc_thresh(struct bdi_writeback *wb, unsigned long thresh)
 {
-	struct dirty_throttle_control gdtc = { GDTC_INIT(wb),
-					       .thresh = thresh };
-	return __wb_calc_thresh(&gdtc);
+	struct dirty_throttle_control gdtc = { GDTC_INIT(wb) };
+
+	return __wb_calc_thresh(&gdtc, thresh);
 }
 
 /*
@@ -1636,7 +1639,7 @@ static inline void wb_dirty_limits(struct dirty_throttle_control *dtc)
 	 *   wb_position_ratio() will let the dirtier task progress
 	 *   at some rate <= (write_bw / 2) for bringing down wb_dirty.
 	 */
-	dtc->wb_thresh = __wb_calc_thresh(dtc);
+	dtc->wb_thresh = __wb_calc_thresh(dtc, dtc->thresh);
 	dtc->wb_bg_thresh = dtc->thresh ?
 		div_u64((u64)dtc->wb_thresh * dtc->bg_thresh, dtc->thresh) : 0;
 
-- 
2.30.0


