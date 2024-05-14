Return-Path: <linux-fsdevel+bounces-19412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E23D38C563F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 14:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CC761F21E5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 12:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DFA74427;
	Tue, 14 May 2024 12:53:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0613D6CDC0;
	Tue, 14 May 2024 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715691214; cv=none; b=M1358ExaPSPtGs8z5KpF4NdtPTcHLhORIXc5NHrMqqV1SolYZdO6sDDe6SdKC4v7A2e4ncQvWP0yPNgmgPqF3jbgGmDSTmjgyYE8iuk039eBfRsFGf3lOQUorCKLRsZnYQvrvWvrKXcKfljrdKVaopP1afrKCG+IDd/BeNwSMlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715691214; c=relaxed/simple;
	bh=wL3d664mDU1HVC0pRhtomSWM7sdch4OtuxtPcyH9YoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dWllFswd6g0kUeAlkscIRk4w1bpaPxzX1EoKdF0UsjM1mzomu7s8Ixi31xIeYoJRGFDgP62z1dMSNQBP3wtn/xQVepY2Dykslq6hSulNX7b9M63m6KYYoOYoIpbFuPEJPxelHQ9gtZq3P7A/VwZjI7Ki05/sltN6fEC9akIVV7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vdx9V5Kjvz4f3jM0;
	Tue, 14 May 2024 20:53:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5BCE61A017F;
	Tue, 14 May 2024 20:53:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgDHzG7EXkNmCyyLMw--.6596S6;
	Tue, 14 May 2024 20:53:27 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: willy@infradead.org,
	akpm@linux-foundation.org,
	tj@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] writeback: Factor out code of freerun to remove repeated code
Date: Tue, 14 May 2024 20:52:50 +0800
Message-Id: <20240514125254.142203-5-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDHzG7EXkNmCyyLMw--.6596S6
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1kAFWDuw43KFyDZrWfAFb_yoWrur13pF
	WxJw4Yy3yDXa4IqrZxCF9rZrW3trsrW3y3XasrCw1Yqr13KF12gFy2yF95Ar17CFyxJF15
	Za1aqF97J34kKFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Factor out code of freerun into new helper functions domain_poll_intv and
domain_dirty_freerun to remove repeated code.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 mm/page-writeback.c | 89 +++++++++++++++++++++++++--------------------
 1 file changed, 49 insertions(+), 40 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index e7c6ad48f738..b7478eacd3ff 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -139,6 +139,7 @@ struct dirty_throttle_control {
 	unsigned long		wb_bg_thresh;
 
 	unsigned long		pos_ratio;
+	bool			freerun;
 };
 
 /*
@@ -1702,6 +1703,49 @@ static inline void wb_dirty_limits(struct dirty_throttle_control *dtc)
 	}
 }
 
+static unsigned long domain_poll_intv(struct dirty_throttle_control *dtc,
+				      bool strictlimit)
+{
+	unsigned long dirty, thresh;
+
+	if (strictlimit) {
+		dirty = dtc->wb_dirty;
+		thresh = dtc->wb_thresh;
+	} else {
+		dirty = dtc->dirty;
+		thresh = dtc->thresh;
+	}
+
+	return dirty_poll_interval(dirty, thresh);
+}
+
+/*
+ * Throttle it only when the background writeback cannot catch-up. This avoids
+ * (excessively) small writeouts when the wb limits are ramping up in case of
+ * !strictlimit.
+ *
+ * In strictlimit case make decision based on the wb counters and limits. Small
+ * writeouts when the wb limits are ramping up are the price we consciously pay
+ * for strictlimit-ing.
+ */
+static void domain_dirty_freerun(struct dirty_throttle_control *dtc,
+				 bool strictlimit)
+{
+	unsigned long dirty, thresh, bg_thresh;
+
+	if (unlikely(strictlimit)) {
+		wb_dirty_limits(dtc);
+		dirty = dtc->wb_dirty;
+		thresh = dtc->wb_thresh;
+		bg_thresh = dtc->wb_bg_thresh;
+	} else {
+		dirty = dtc->dirty;
+		thresh = dtc->thresh;
+		bg_thresh = dtc->bg_thresh;
+	}
+	dtc->freerun = dirty <= dirty_freerun_ceiling(thresh, bg_thresh);
+}
+
 /*
  * balance_dirty_pages() must be called by processes which are generating dirty
  * data.  It looks at the number of dirty pages in the machine and will force
@@ -1734,27 +1778,12 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 
 	for (;;) {
 		unsigned long now = jiffies;
-		unsigned long dirty, thresh, bg_thresh;
-		unsigned long m_dirty = 0;	/* stop bogus uninit warnings */
-		unsigned long m_thresh = 0;
-		unsigned long m_bg_thresh = 0;
 
 		nr_dirty = global_node_page_state(NR_FILE_DIRTY);
 
 		domain_dirty_avail(gdtc, true);
 		domain_dirty_limits(gdtc);
-
-		if (unlikely(strictlimit)) {
-			wb_dirty_limits(gdtc);
-
-			dirty = gdtc->wb_dirty;
-			thresh = gdtc->wb_thresh;
-			bg_thresh = gdtc->wb_bg_thresh;
-		} else {
-			dirty = gdtc->dirty;
-			thresh = gdtc->thresh;
-			bg_thresh = gdtc->bg_thresh;
-		}
+		domain_dirty_freerun(gdtc, strictlimit);
 
 		if (mdtc) {
 			/*
@@ -1763,17 +1792,7 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 			 */
 			domain_dirty_avail(mdtc, true);
 			domain_dirty_limits(mdtc);
-
-			if (unlikely(strictlimit)) {
-				wb_dirty_limits(mdtc);
-				m_dirty = mdtc->wb_dirty;
-				m_thresh = mdtc->wb_thresh;
-				m_bg_thresh = mdtc->wb_bg_thresh;
-			} else {
-				m_dirty = mdtc->dirty;
-				m_thresh = mdtc->thresh;
-				m_bg_thresh = mdtc->bg_thresh;
-			}
+			domain_dirty_freerun(mdtc, strictlimit);
 		}
 
 		/*
@@ -1790,31 +1809,21 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 			wb_start_background_writeback(wb);
 
 		/*
-		 * Throttle it only when the background writeback cannot
-		 * catch-up. This avoids (excessively) small writeouts
-		 * when the wb limits are ramping up in case of !strictlimit.
-		 *
-		 * In strictlimit case make decision based on the wb counters
-		 * and limits. Small writeouts when the wb limits are ramping
-		 * up are the price we consciously pay for strictlimit-ing.
-		 *
 		 * If memcg domain is in effect, @dirty should be under
 		 * both global and memcg freerun ceilings.
 		 */
-		if (dirty <= dirty_freerun_ceiling(thresh, bg_thresh) &&
-		    (!mdtc ||
-		     m_dirty <= dirty_freerun_ceiling(m_thresh, m_bg_thresh))) {
+		if (gdtc->freerun && (!mdtc || mdtc->freerun)) {
 			unsigned long intv;
 			unsigned long m_intv;
 
 free_running:
-			intv = dirty_poll_interval(dirty, thresh);
+			intv = domain_poll_intv(gdtc, strictlimit);
 			m_intv = ULONG_MAX;
 
 			current->dirty_paused_when = now;
 			current->nr_dirtied = 0;
 			if (mdtc)
-				m_intv = dirty_poll_interval(m_dirty, m_thresh);
+				m_intv = domain_poll_intv(mdtc, strictlimit);
 			current->nr_dirtied_pause = min(intv, m_intv);
 			break;
 		}
-- 
2.30.0


