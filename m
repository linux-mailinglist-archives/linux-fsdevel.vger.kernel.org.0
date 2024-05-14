Return-Path: <linux-fsdevel+bounces-19420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E2D8C5653
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 14:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE062844F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 12:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D419A12AAF8;
	Tue, 14 May 2024 12:53:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8018E7EEE1;
	Tue, 14 May 2024 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715691219; cv=none; b=t7qQdXef+YVCw3PqbXno9YkNCf6W5miEnEMZFjjrhUddKpTlr4fQB27X+I3J6HNkMFveO0WQtmWX3lgNmW7iUHKtp2tr7vKqK/GSzFfTmU/6Dn0HeVTsPxQGscmtRvcUq1Jkz7ZEGt/LNLebjxNHXrz9gzM8oJqbHriYoaNgI2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715691219; c=relaxed/simple;
	bh=Se7P5OClo4IT4IEEGW67kvZN2x2arctGyw8vXG+eF3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IEDRP5kIjGd1BMDNFvRPv6naghQQqszX2BkwDXu/AbLtskZz/CVG4/58VDR4XOlvD/EOmz48Z5F2TpuS8jHiykyQJvBeBcirvNgZb0vVLJ6PMAFoQjbvxAc6JAD73kwD6W6va50DKB5R6qQ4CLadwHfXrC58tDlvcFcTkWVNWxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vdx9V36DYz4f3m78;
	Tue, 14 May 2024 20:53:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8F19E1A0D6A;
	Tue, 14 May 2024 20:53:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgDHzG7EXkNmCyyLMw--.6596S10;
	Tue, 14 May 2024 20:53:28 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: willy@infradead.org,
	akpm@linux-foundation.org,
	tj@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] writeback: factor out balance_wb_limits to remove repeated code
Date: Tue, 14 May 2024 20:52:54 +0800
Message-Id: <20240514125254.142203-9-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDHzG7EXkNmCyyLMw--.6596S10
X-Coremail-Antispam: 1UD129KBjvJXoWxJryxXr4rXFW8CrW8Jr1DJrb_yoW8AFyrpF
	Z2kw40yr1kJF1IqanayFZF9rWaqrs3tFWfJ348Gws3tF4fKr12gFy2vry0qr17ArnrGrW5
	Zr4DtF97Gw1rCFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU90b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIda
	VFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Factor out balance_wb_limits to remove repeated code

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page-writeback.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 0f1f3e179be2..d1d385373c5b 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1783,6 +1783,17 @@ static inline void wb_dirty_exceeded(struct dirty_throttle_control *dtc,
 		((dtc->dirty > dtc->thresh) || strictlimit);
 }
 
+static void balance_wb_limits(struct dirty_throttle_control *dtc,
+			      bool strictlimit)
+{
+	wb_dirty_freerun(dtc, strictlimit);
+	if (dtc->freerun)
+		return;
+
+	wb_dirty_exceeded(dtc, strictlimit);
+	wb_position_ratio(dtc);
+}
+
 /*
  * balance_dirty_pages() must be called by processes which are generating dirty
  * data.  It looks at the number of dirty pages in the machine and will force
@@ -1869,12 +1880,9 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 		 * Calculate global domain's pos_ratio and select the
 		 * global dtc by default.
 		 */
-		wb_dirty_freerun(gdtc, strictlimit);
+		balance_wb_limits(gdtc, strictlimit);
 		if (gdtc->freerun)
 			goto free_running;
-
-		wb_dirty_exceeded(gdtc, strictlimit);
-		wb_position_ratio(gdtc);
 		sdtc = gdtc;
 
 		if (mdtc) {
@@ -1884,12 +1892,9 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 			 * both global and memcg domains.  Choose the one
 			 * w/ lower pos_ratio.
 			 */
-			wb_dirty_freerun(mdtc, strictlimit);
+			balance_wb_limits(mdtc, strictlimit);
 			if (mdtc->freerun)
 				goto free_running;
-
-			wb_dirty_exceeded(mdtc, strictlimit);
-			wb_position_ratio(mdtc);
 			if (mdtc->pos_ratio < gdtc->pos_ratio)
 				sdtc = mdtc;
 		}
-- 
2.30.0


