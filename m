Return-Path: <linux-fsdevel+bounces-17766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF958B2269
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 15:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B4561C21157
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 13:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425E5149E04;
	Thu, 25 Apr 2024 13:17:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08CC149C45;
	Thu, 25 Apr 2024 13:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714051052; cv=none; b=KRGE8gWLEzHfp2AVu7HHyN+fO79RXVQiwFsVFJwPfLZEUzNe19aWLx+mSx98Ume0FgcJWXfkJpwdYywFbny3H/8DdzXogYdEwMpzcYy+p4bL5cx/dZyccCpq90f3H7DiQNsEN3vtenrhqRZ5e8H79omZ3+TKHJwxM87REmCtG+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714051052; c=relaxed/simple;
	bh=2mQyv+czoMfeo7HocdqAOv/+Zzdyx7J+5vy2DUJOPqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n4qAjDfQP/SBPB9N4ZC6wIcfG9wZiEHlrFdlTZTgfLZUUz+sFuJf3rsHhuwSKEQungzrsXRvv6cLlAeaCOUwSRcwo5I/eY0w9CGed+294md5DuZllxBw9pIjjgvyrwYh5/zULB+L0Z0EKVSmYOipbYXiGxaGHCzIFedPz1fiXMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VQGc14lznz4f3kKm;
	Thu, 25 Apr 2024 21:17:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 8A95F1A0EB0;
	Thu, 25 Apr 2024 21:17:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP3 (Coremail) with SMTP id _Ch0CgA3+J_kVypmFDcOKw--.42283S3;
	Thu, 25 Apr 2024 21:17:26 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: willy@infradead.org,
	akpm@linux-foundation.org
Cc: tj@kernel.org,
	jack@suse.cz,
	hcochran@kernelspring.com,
	axboe@kernel.dk,
	mszeredi@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] mm: enable __wb_calc_thresh to calculate dirty background threshold
Date: Thu, 25 Apr 2024 21:17:21 +0800
Message-Id: <20240425131724.36778-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240425131724.36778-1-shikemeng@huaweicloud.com>
References: <20240425131724.36778-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgA3+J_kVypmFDcOKw--.42283S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4rZF1rJryUtr1UCr1kAFb_yoWrAr4fpF
	W3Xw17CF4UJrZ7ZrsxAFyruFWavws7JrW2qa97Gw1rtwnIkryUKF12kF4vyFy5AF93JFy3
	AFWYqryxXF1qyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUzl1vUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Originally, __wb_calc_thresh always calculate wb's share of dirty
throttling threshold. By getting thresh of wb_domain from caller,
__wb_calc_thresh could be used for both dirty throttling and dirty
background threshold.

This is a preparation to correct threshold calculation of wb in cgroup.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page-writeback.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index db5769cb12fd..2a3b68aae336 100644
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
 
 unsigned long cgwb_calc_thresh(struct bdi_writeback *wb)
@@ -908,7 +911,7 @@ unsigned long cgwb_calc_thresh(struct bdi_writeback *wb)
 	mdtc_calc_avail(&mdtc, filepages, headroom);
 	domain_dirty_limits(&mdtc);
 
-	return __wb_calc_thresh(&mdtc);
+	return __wb_calc_thresh(&mdtc, mdtc.thresh);
 }
 
 /*
@@ -1655,7 +1658,7 @@ static inline void wb_dirty_limits(struct dirty_throttle_control *dtc)
 	 *   wb_position_ratio() will let the dirtier task progress
 	 *   at some rate <= (write_bw / 2) for bringing down wb_dirty.
 	 */
-	dtc->wb_thresh = __wb_calc_thresh(dtc);
+	dtc->wb_thresh = __wb_calc_thresh(dtc, dtc->thresh);
 	dtc->wb_bg_thresh = dtc->thresh ?
 		div64_u64(dtc->wb_thresh * dtc->bg_thresh, dtc->thresh) : 0;
 
-- 
2.30.0


