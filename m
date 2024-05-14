Return-Path: <linux-fsdevel+bounces-19418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E80A58C564C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 14:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125841C21B85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 12:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1B3128375;
	Tue, 14 May 2024 12:53:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72EB7581B;
	Tue, 14 May 2024 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715691218; cv=none; b=PzQHCHVKv9zpTzNT1ifLrXdgAGqHpPaAhZKpUaTu5SAXDbiyGanulIEXutYgw54uaLQ+CR2F+PS7iYv/99v9ti/YrdPva6nQnUBGhz6mSGuQDntBApz+kLQELSqj8mq3ksTJB9KlVauk3+DFmm1zuqQNSdcJuTntSIrXuGV934o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715691218; c=relaxed/simple;
	bh=JieJwHXIHm8GxrRSX0MECA7nb/crEB3vwh7kTMl6aPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iJFjgVAigr7fPUqEts9y1d06fKT0YZTrjIMXmtdozNL2eIIKWE/Na2NfZUtU82EwHJKExth17IBBTOBpWWyP3QqPXsAmVU+gMG1H6XlWf6uu2x5+4j/U+qI4mEx8U96xecmR5lXkl08SDCQhNFIvKxnYliIa2/u8LlNBSXMhOaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vdx9Y1cSpz4f3kKp;
	Tue, 14 May 2024 20:53:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B9EB61A0D53;
	Tue, 14 May 2024 20:53:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgDHzG7EXkNmCyyLMw--.6596S4;
	Tue, 14 May 2024 20:53:26 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: willy@infradead.org,
	akpm@linux-foundation.org,
	tj@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] writeback: add general function domain_dirty_avail to calculate dirty and avail of domain
Date: Tue, 14 May 2024 20:52:48 +0800
Message-Id: <20240514125254.142203-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240514125254.142203-1-shikemeng@huaweicloud.com>
References: <20240514125254.142203-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHzG7EXkNmCyyLMw--.6596S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGrW3tFyxGw45Xr47ZFW3Awb_yoWrCrW8pF
	43Jws0kayUtF47Xrs3AFWq9rW3K397GrW7t34xCaySqFnFkr1UKFyI9ryvvr1xAF97Jry3
	ArsIvr97Gr40kr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxU2_MaUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Add general function domain_dirty_avail to calculate dirty and avail for
either dirty limit or background writeback in either global domain or wb
domain.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page-writeback.c | 65 ++++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index e1f73643aca1..16a94c7df260 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -837,6 +837,34 @@ static void mdtc_calc_avail(struct dirty_throttle_control *mdtc,
 	mdtc->avail = filepages + min(headroom, other_clean);
 }
 
+static inline bool dtc_is_global(struct dirty_throttle_control *dtc)
+{
+	return mdtc_gdtc(dtc) == NULL;
+}
+
+/*
+ * Dirty background will ignore pages being written as we're trying to
+ * decide whether to put more under writeback.
+ */
+static void domain_dirty_avail(struct dirty_throttle_control *dtc,
+			       bool include_writeback)
+{
+	if (dtc_is_global(dtc)) {
+		dtc->avail = global_dirtyable_memory();
+		dtc->dirty = global_node_page_state(NR_FILE_DIRTY);
+		if (include_writeback)
+			dtc->dirty += global_node_page_state(NR_WRITEBACK);
+	} else {
+		unsigned long filepages = 0, headroom = 0, writeback = 0;
+
+		mem_cgroup_wb_stats(dtc->wb, &filepages, &headroom, &dtc->dirty,
+				    &writeback);
+		if (include_writeback)
+			dtc->dirty += writeback;
+		mdtc_calc_avail(dtc, filepages, headroom);
+	}
+}
+
 /**
  * __wb_calc_thresh - @wb's share of dirty threshold
  * @dtc: dirty_throttle_context of interest
@@ -899,16 +927,9 @@ unsigned long cgwb_calc_thresh(struct bdi_writeback *wb)
 {
 	struct dirty_throttle_control gdtc = { GDTC_INIT_NO_WB };
 	struct dirty_throttle_control mdtc = { MDTC_INIT(wb, &gdtc) };
-	unsigned long filepages = 0, headroom = 0, writeback = 0;
 
-	gdtc.avail = global_dirtyable_memory();
-	gdtc.dirty = global_node_page_state(NR_FILE_DIRTY) +
-		     global_node_page_state(NR_WRITEBACK);
-
-	mem_cgroup_wb_stats(wb, &filepages, &headroom,
-			    &mdtc.dirty, &writeback);
-	mdtc.dirty += writeback;
-	mdtc_calc_avail(&mdtc, filepages, headroom);
+	domain_dirty_avail(&gdtc, true);
+	domain_dirty_avail(&mdtc, true);
 	domain_dirty_limits(&mdtc);
 
 	return __wb_calc_thresh(&mdtc, mdtc.thresh);
@@ -1719,9 +1740,8 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 		unsigned long m_bg_thresh = 0;
 
 		nr_dirty = global_node_page_state(NR_FILE_DIRTY);
-		gdtc->avail = global_dirtyable_memory();
-		gdtc->dirty = nr_dirty + global_node_page_state(NR_WRITEBACK);
 
+		domain_dirty_avail(gdtc, true);
 		domain_dirty_limits(gdtc);
 
 		if (unlikely(strictlimit)) {
@@ -1737,17 +1757,11 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 		}
 
 		if (mdtc) {
-			unsigned long filepages, headroom, writeback;
-
 			/*
 			 * If @wb belongs to !root memcg, repeat the same
 			 * basic calculations for the memcg domain.
 			 */
-			mem_cgroup_wb_stats(wb, &filepages, &headroom,
-					    &mdtc->dirty, &writeback);
-			mdtc->dirty += writeback;
-			mdtc_calc_avail(mdtc, filepages, headroom);
-
+			domain_dirty_avail(mdtc, true);
 			domain_dirty_limits(mdtc);
 
 			if (unlikely(strictlimit)) {
@@ -2119,14 +2133,8 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
 	struct dirty_throttle_control * const mdtc = mdtc_valid(&mdtc_stor) ?
 						     &mdtc_stor : NULL;
 
-	/*
-	 * Similar to balance_dirty_pages() but ignores pages being written
-	 * as we're trying to decide whether to put more under writeback.
-	 */
-	gdtc->avail = global_dirtyable_memory();
-	gdtc->dirty = global_node_page_state(NR_FILE_DIRTY);
+	domain_dirty_avail(gdtc, false);
 	domain_dirty_limits(gdtc);
-
 	if (gdtc->dirty > gdtc->bg_thresh)
 		return true;
 
@@ -2135,13 +2143,8 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
 		return true;
 
 	if (mdtc) {
-		unsigned long filepages, headroom, writeback;
-
-		mem_cgroup_wb_stats(wb, &filepages, &headroom, &mdtc->dirty,
-				    &writeback);
-		mdtc_calc_avail(mdtc, filepages, headroom);
+		domain_dirty_avail(mdtc, false);
 		domain_dirty_limits(mdtc);	/* ditto, ignore writeback */
-
 		if (mdtc->dirty > mdtc->bg_thresh)
 			return true;
 
-- 
2.30.0


