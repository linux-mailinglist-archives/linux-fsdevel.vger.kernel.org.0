Return-Path: <linux-fsdevel+bounces-19419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 072288C564D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 14:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A528D1F22098
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 12:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22697129A66;
	Tue, 14 May 2024 12:53:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E067603F;
	Tue, 14 May 2024 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715691218; cv=none; b=KxBKyyFb1qz3Z6COgtEPJJCCID3gdG6Svp4lOnEGOzFGSNlr+vynrcQjnmeZM4T28ImI9w3vf/zewyfJ2iwzwfDf6pZ/0XSCmLjAs5Bs4QBUciXhi/Hpkogfk/8tSbmJYGzPclUUS1waKSquOb+kdEAKarMeltH1HfJnr3fLJgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715691218; c=relaxed/simple;
	bh=KbrxBobCPNdYA9YZr6GfSsQNEx69sqbLVN8FdjTP6ls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f8Zpn6di1eVJVAfhoPlsKsSYbsZ+YiStESg3sLtm+339T19GJHJ8t6P/1tQcUday7PsKh+OGNYlAFx730PSf/a2bd+MwLX9PSvSO5Rt/9OmzP9QMSsy9cos8YDyv+6rgXNkje39BPvmQBmey7gw+geIWyTRstu376LiwQzWmaEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vdx9V0zdRz4f3n5t;
	Tue, 14 May 2024 20:53:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4568F1A0181;
	Tue, 14 May 2024 20:53:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgDHzG7EXkNmCyyLMw--.6596S9;
	Tue, 14 May 2024 20:53:28 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: willy@infradead.org,
	akpm@linux-foundation.org,
	tj@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] writeback: factor out wb_dirty_exceeded to remove repeated code
Date: Tue, 14 May 2024 20:52:53 +0800
Message-Id: <20240514125254.142203-8-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDHzG7EXkNmCyyLMw--.6596S9
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWfZr4xKF4rJr4kJw4fZrb_yoW8KF47pF
	ZrJw4Ik3yUJa1SgasxJFWDur43trs7JrWxJryUWw15ta13KF12gr92qFWFvr17ArZxJF4Y
	vrZ5t34xGw18Kr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Factor out wb_dirty_exceeded to remove repeated code

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page-writeback.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 97ee5b32b4ef..0f1f3e179be2 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -140,6 +140,7 @@ struct dirty_throttle_control {
 
 	unsigned long		pos_ratio;
 	bool			freerun;
+	bool			dirty_exceeded;
 };
 
 /*
@@ -1775,6 +1776,13 @@ static void wb_dirty_freerun(struct dirty_throttle_control *dtc,
 		       dirty_freerun_ceiling(dtc->wb_thresh, dtc->wb_bg_thresh);
 }
 
+static inline void wb_dirty_exceeded(struct dirty_throttle_control *dtc,
+				     bool strictlimit)
+{
+	dtc->dirty_exceeded = (dtc->wb_dirty > dtc->wb_thresh) &&
+		((dtc->dirty > dtc->thresh) || strictlimit);
+}
+
 /*
  * balance_dirty_pages() must be called by processes which are generating dirty
  * data.  It looks at the number of dirty pages in the machine and will force
@@ -1797,7 +1805,6 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 	long max_pause;
 	long min_pause;
 	int nr_dirtied_pause;
-	bool dirty_exceeded = false;
 	unsigned long task_ratelimit;
 	unsigned long dirty_ratelimit;
 	struct backing_dev_info *bdi = wb->bdi;
@@ -1866,9 +1873,7 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 		if (gdtc->freerun)
 			goto free_running;
 
-		dirty_exceeded = (gdtc->wb_dirty > gdtc->wb_thresh) &&
-			((gdtc->dirty > gdtc->thresh) || strictlimit);
-
+		wb_dirty_exceeded(gdtc, strictlimit);
 		wb_position_ratio(gdtc);
 		sdtc = gdtc;
 
@@ -1883,17 +1888,14 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 			if (mdtc->freerun)
 				goto free_running;
 
-			dirty_exceeded |= (mdtc->wb_dirty > mdtc->wb_thresh) &&
-				((mdtc->dirty > mdtc->thresh) || strictlimit);
-
+			wb_dirty_exceeded(mdtc, strictlimit);
 			wb_position_ratio(mdtc);
 			if (mdtc->pos_ratio < gdtc->pos_ratio)
 				sdtc = mdtc;
 		}
 
-		if (dirty_exceeded != wb->dirty_exceeded)
-			wb->dirty_exceeded = dirty_exceeded;
-
+		wb->dirty_exceeded = gdtc->dirty_exceeded ||
+				     (mdtc && mdtc->dirty_exceeded);
 		if (time_is_before_jiffies(READ_ONCE(wb->bw_time_stamp) +
 					   BANDWIDTH_INTERVAL))
 			__wb_update_bandwidth(gdtc, mdtc, true);
-- 
2.30.0


