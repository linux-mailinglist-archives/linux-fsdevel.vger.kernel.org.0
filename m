Return-Path: <linux-fsdevel+bounces-19417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0168B8C5649
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 14:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B081F21E7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 12:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957FF85C5D;
	Tue, 14 May 2024 12:53:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73207581D;
	Tue, 14 May 2024 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715691218; cv=none; b=sIzSAh+n8kO8jap6su++JAS35I4WuHvIBX0tW6Xx2NjCroDLoeGEpS5zz8vqwxa6qo57Kln90g5HoGwhP7K1vfTdnLQqTsvfJrSuNJhvCDq5uvxONFkO2Lz3BTAlK3Xc6eLVbiCf6nW5TRkbZKDA2UDiFHsQZZT5gEjiSVSTgwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715691218; c=relaxed/simple;
	bh=H1mOSQBLW7TJigyhWTlPTYdU3slPuRIMWzgZfyXylig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=debL64ZllUrZeTcAHulZYrSo0Pbkw+RqRfbGorDUvqd1xLatbOzMZ3/7BXW3alwuejEpGB0qnFWGQ2FUQpT964JFt3xqg/XtJXCD5GYE7kX31UrS6oENcK6XG0BKBW9L3gmLHwEVYLm2UMhgAcu09QAmPwZWqiZBgAXx3ME8GIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vdx9Y3hsmz4f3kKy;
	Tue, 14 May 2024 20:53:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0FE981A0D06;
	Tue, 14 May 2024 20:53:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgDHzG7EXkNmCyyLMw--.6596S5;
	Tue, 14 May 2024 20:53:26 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: willy@infradead.org,
	akpm@linux-foundation.org,
	tj@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] writeback: factor out domain_over_bg_thresh to remove repeated code
Date: Tue, 14 May 2024 20:52:49 +0800
Message-Id: <20240514125254.142203-4-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDHzG7EXkNmCyyLMw--.6596S5
X-Coremail-Antispam: 1UD129KBjvJXoW7WrW8CrWxXFykGr4Duw43trb_yoW8tF4rpF
	4fAw1a9rWUJanrXFnxCFyUur43tFZ7t3yUJ3srCwn3Aw43Cr4UGFy7ArZYvFy8AFy7Xrya
	vr4ava4xGF10krJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxU2PEfUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Factor out domain_over_bg_thresh from wb_over_bg_thresh to remove
repeated code.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 mm/page-writeback.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 16a94c7df260..e7c6ad48f738 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2116,6 +2116,20 @@ static void wb_bg_dirty_limits(struct dirty_throttle_control *dtc)
 		dtc->wb_dirty = wb_stat(wb, WB_RECLAIMABLE);
 }
 
+static bool domain_over_bg_thresh(struct dirty_throttle_control *dtc)
+{
+	domain_dirty_avail(dtc, false);
+	domain_dirty_limits(dtc);
+	if (dtc->dirty > dtc->bg_thresh)
+		return true;
+
+	wb_bg_dirty_limits(dtc);
+	if (dtc->wb_dirty > dtc->wb_bg_thresh)
+		return true;
+
+	return false;
+}
+
 /**
  * wb_over_bg_thresh - does @wb need to be written back?
  * @wb: bdi_writeback of interest
@@ -2127,31 +2141,14 @@ static void wb_bg_dirty_limits(struct dirty_throttle_control *dtc)
  */
 bool wb_over_bg_thresh(struct bdi_writeback *wb)
 {
-	struct dirty_throttle_control gdtc_stor = { GDTC_INIT(wb) };
-	struct dirty_throttle_control mdtc_stor = { MDTC_INIT(wb, &gdtc_stor) };
-	struct dirty_throttle_control * const gdtc = &gdtc_stor;
-	struct dirty_throttle_control * const mdtc = mdtc_valid(&mdtc_stor) ?
-						     &mdtc_stor : NULL;
-
-	domain_dirty_avail(gdtc, false);
-	domain_dirty_limits(gdtc);
-	if (gdtc->dirty > gdtc->bg_thresh)
-		return true;
+	struct dirty_throttle_control gdtc = { GDTC_INIT(wb) };
+	struct dirty_throttle_control mdtc = { MDTC_INIT(wb, &gdtc) };
 
-	wb_bg_dirty_limits(gdtc);
-	if (gdtc->wb_dirty > gdtc->wb_bg_thresh)
+	if (domain_over_bg_thresh(&gdtc))
 		return true;
 
-	if (mdtc) {
-		domain_dirty_avail(mdtc, false);
-		domain_dirty_limits(mdtc);	/* ditto, ignore writeback */
-		if (mdtc->dirty > mdtc->bg_thresh)
-			return true;
-
-		wb_bg_dirty_limits(mdtc);
-		if (mdtc->wb_dirty > mdtc->wb_bg_thresh)
-			return true;
-	}
+	if (mdtc_valid(&mdtc))
+		return domain_over_bg_thresh(&mdtc);
 
 	return false;
 }
-- 
2.30.0


