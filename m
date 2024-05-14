Return-Path: <linux-fsdevel+bounces-19416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790CF8C5648
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 14:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C5EE1C21BA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 12:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A93D85C41;
	Tue, 14 May 2024 12:53:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D8C76035;
	Tue, 14 May 2024 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715691218; cv=none; b=Up6+klPQW4lScGafFWkGnThoJ50MNaJQ0ULzpb5HFFw4R21z98PjM1WB5wIrhskb5LRCdXYucST6+7gdnz/hbgZKzhKk4j9amae3OwqrOtzddS0e9qGTc/smmSIWpu9v0Ye5qo/U2p2ItXWEVgrB0sb8eY32k1OJKi9cZHUsExs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715691218; c=relaxed/simple;
	bh=NRDTDHLUm7pZjnlC/jsn16oLYrs73tYuOYKYXva2V/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZZZ/b1cOnZu+OvRtzzDffsT80naqSAuM0DR8UHuDha3vcaoAwAovqsD2d77hJ8mh54N/VnMcAWWvazIiRpZ8hfw6JBNnSICY+9UYl6+ZCv+ic/sc7dZ2/l2tgJfRlq3wzA2QrhcNbwMLvOm7lAgktdsfrDhWacI84D07rdXlXuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vdx9T3zZrz4f3n5l;
	Tue, 14 May 2024 20:53:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AAB1B1A1142;
	Tue, 14 May 2024 20:53:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgDHzG7EXkNmCyyLMw--.6596S7;
	Tue, 14 May 2024 20:53:27 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: willy@infradead.org,
	akpm@linux-foundation.org,
	tj@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] writeback: factor out wb_dirty_freerun to remove more repeated freerun code
Date: Tue, 14 May 2024 20:52:51 +0800
Message-Id: <20240514125254.142203-6-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDHzG7EXkNmCyyLMw--.6596S7
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1fXr18ZrWUKrW7Wr15urg_yoW5GFy5pF
	WfAw4akr4DJr1IqrsxAF9FvFWftrsavrWfC34Uuwn3tw1fKr1Igry2yryrZFW2yFy7Jrs0
	vFs0vF97G34UtFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Factor out wb_dirty_freerun to remove more repeated freerun code.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page-writeback.c | 55 +++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index b7478eacd3ff..b9c8db7089ef 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1746,6 +1746,27 @@ static void domain_dirty_freerun(struct dirty_throttle_control *dtc,
 	dtc->freerun = dirty <= dirty_freerun_ceiling(thresh, bg_thresh);
 }
 
+static void wb_dirty_freerun(struct dirty_throttle_control *dtc,
+			     bool strictlimit)
+{
+	dtc->freerun = false;
+
+	/* was already handled in domain_dirty_freerun */
+	if (strictlimit)
+		return;
+
+	wb_dirty_limits(dtc);
+	/*
+	 * LOCAL_THROTTLE tasks must not be throttled when below the per-wb
+	 * freerun ceiling.
+	 */
+	if (!(current->flags & PF_LOCAL_THROTTLE))
+		return;
+
+	dtc->freerun = dtc->wb_dirty <
+		       dirty_freerun_ceiling(dtc->wb_thresh, dtc->wb_bg_thresh);
+}
+
 /*
  * balance_dirty_pages() must be called by processes which are generating dirty
  * data.  It looks at the number of dirty pages in the machine and will force
@@ -1838,19 +1859,9 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 		 * Calculate global domain's pos_ratio and select the
 		 * global dtc by default.
 		 */
-		if (!strictlimit) {
-			wb_dirty_limits(gdtc);
-
-			if ((current->flags & PF_LOCAL_THROTTLE) &&
-			    gdtc->wb_dirty <
-			    dirty_freerun_ceiling(gdtc->wb_thresh,
-						  gdtc->wb_bg_thresh))
-				/*
-				 * LOCAL_THROTTLE tasks must not be throttled
-				 * when below the per-wb freerun ceiling.
-				 */
-				goto free_running;
-		}
+		wb_dirty_freerun(gdtc, strictlimit);
+		if (gdtc->freerun)
+			goto free_running;
 
 		dirty_exceeded = (gdtc->wb_dirty > gdtc->wb_thresh) &&
 			((gdtc->dirty > gdtc->thresh) || strictlimit);
@@ -1865,20 +1876,10 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 			 * both global and memcg domains.  Choose the one
 			 * w/ lower pos_ratio.
 			 */
-			if (!strictlimit) {
-				wb_dirty_limits(mdtc);
-
-				if ((current->flags & PF_LOCAL_THROTTLE) &&
-				    mdtc->wb_dirty <
-				    dirty_freerun_ceiling(mdtc->wb_thresh,
-							  mdtc->wb_bg_thresh))
-					/*
-					 * LOCAL_THROTTLE tasks must not be
-					 * throttled when below the per-wb
-					 * freerun ceiling.
-					 */
-					goto free_running;
-			}
+			wb_dirty_freerun(mdtc, strictlimit);
+			if (mdtc->freerun)
+				goto free_running;
+
 			dirty_exceeded |= (mdtc->wb_dirty > mdtc->wb_thresh) &&
 				((mdtc->dirty > mdtc->thresh) || strictlimit);
 
-- 
2.30.0


