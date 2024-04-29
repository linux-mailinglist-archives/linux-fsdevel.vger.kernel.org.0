Return-Path: <linux-fsdevel+bounces-18048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF978B500E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 05:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8895A2829FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 03:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86DD2561D;
	Mon, 29 Apr 2024 03:48:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D8C210E9;
	Mon, 29 Apr 2024 03:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714362481; cv=none; b=ZNZxOdluCMbEPmapAHjkynG3EwfUZEf9lukflHkhZP3+7zkyJ+W2vq4U4axSmmbDUN3Zm8jlkP8HDtLCRw0XmfgmRYYdCIx1YF7lhgR3CEOpb93wUmIsdIzfRLBNh9hAfmF0t2178BzYmOyAX46YIr0OL4otjObJu9YppjVvgsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714362481; c=relaxed/simple;
	bh=aMvuzdkorgTSU70l2pwX1IXtuF84vkBsJNWDHJXe1IM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d8LApUozhd8kvy62jItEF7LB6mJ2MjHpfu/ye3JsN57Gb6zNq/EVn2B7NSM9yjQjTP9RtWIsccXMemTTikViBdI6e5MzzWhjbi7b6RMuyYyiuFmVNE1WfW806FPTu8Vv7nH6UrPAH0YZvcnxiUPHi3PN5nwq4K91UFqtEQerIa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VSTmq5BpSz4f3nK5;
	Mon, 29 Apr 2024 11:47:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 23A891A0179;
	Mon, 29 Apr 2024 11:47:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP1 (Coremail) with SMTP id cCh0CgA3UwxgGC9m24__LA--.38879S12;
	Mon, 29 Apr 2024 11:47:48 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: willy@infradead.org,
	akpm@linux-foundation.org,
	jack@suse.cz,
	tj@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] writeback: factor out balance_wb_limits to remove repeated code
Date: Mon, 29 Apr 2024 11:47:38 +0800
Message-Id: <20240429034738.138609-11-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240429034738.138609-1-shikemeng@huaweicloud.com>
References: <20240429034738.138609-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3UwxgGC9m24__LA--.38879S12
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1kKw4kCFWfXr1UCryfWFg_yoW8AFyrpF
	Z2kw40kr4kJF1Sqa9akFW7urWaqrs3tFWfG348Wws3tF4fKr12gFy2vry0qr17ArnrGrW3
	Zr4DtF97Gw1rCFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Factor out balance_wb_limits to remove repeated code

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page-writeback.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 26b638cc58c5..4949036e6286 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1790,6 +1790,17 @@ static inline void wb_dirty_exceeded(struct dirty_throttle_control *dtc,
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
@@ -1875,12 +1886,9 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
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
@@ -1890,12 +1898,9 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
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


