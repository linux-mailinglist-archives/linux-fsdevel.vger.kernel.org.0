Return-Path: <linux-fsdevel+bounces-18044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3102F8B5005
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 05:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59331F2107B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 03:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5488817559;
	Mon, 29 Apr 2024 03:47:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D401171A;
	Mon, 29 Apr 2024 03:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714362477; cv=none; b=gJbm6JioolHZ/bL8YJC41zA48T1hpzCUgcAA/ld8FoJ2CT2+7pgqT8M4aH/CjDbimU5yTLN8pEvfzYve2qgjNIWPMmw2EUPFwhzif0hxOQtRSnv20gepTbMVO33CLiIyIZDRZLvKYru2tg4m2TreKd7MfCYyDwL0xLc8pLxDT24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714362477; c=relaxed/simple;
	bh=eLstEXrAcFhbiMIH2kART1OT4kPSAcpJFuPdBefUYCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T/vf8yW5mlLFpZf7h0JXkMy6r3Q15+HuHKkgzrmZaE55BiQkLUBKliYwpXJBKPnwRUJSeD047vBOHky/RxsX2aMVZIaVRqch96+HdCVKJG+b2++ha+N93qultRo/Ie7IJaTjEyivABXAHKKfsf4EVsJJlgfMK36MejwYs/vUusY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VSTmq0ZDJz4f3nJp;
	Mon, 29 Apr 2024 11:47:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7B6D21A0572;
	Mon, 29 Apr 2024 11:47:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP1 (Coremail) with SMTP id cCh0CgA3UwxgGC9m24__LA--.38879S10;
	Mon, 29 Apr 2024 11:47:48 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: willy@infradead.org,
	akpm@linux-foundation.org,
	jack@suse.cz,
	tj@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] writeback: factor out balance_domain_limits to remove repeated code
Date: Mon, 29 Apr 2024 11:47:36 +0800
Message-Id: <20240429034738.138609-9-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgA3UwxgGC9m24__LA--.38879S10
X-Coremail-Antispam: 1UD129KBjvJXoW7AFW5ZFyDKry5uF1DKF43GFg_yoW8Xw1kpF
	4Iyay29r4DJ3WjqrsakFW7u3y3KrZ7ta12q34rCwsIvr1xKr1qgFy7Zry0vF17Ar1fJr90
	yFsFqas7Gw48CFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Factor out balance_domain_limits to remove repeated code.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page-writeback.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index e38beb680742..68ae4c90ce8b 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1753,6 +1753,14 @@ static void domain_dirty_freerun(struct dirty_throttle_control *dtc,
 	dtc->freerun = dirty <= dirty_freerun_ceiling(thresh, bg_thresh);
 }
 
+static void balance_domain_limits(struct dirty_throttle_control *dtc,
+				  bool strictlimit)
+{
+	domain_dirty_avail(dtc, false);
+	domain_dirty_limits(dtc);
+	domain_dirty_freerun(dtc, strictlimit);
+}
+
 static void wb_dirty_freerun(struct dirty_throttle_control *dtc,
 			     bool strictlimit)
 {
@@ -1809,19 +1817,13 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 
 		nr_dirty = global_node_page_state(NR_FILE_DIRTY);
 
-		domain_dirty_avail(gdtc, false);
-		domain_dirty_limits(gdtc);
-		domain_dirty_freerun(gdtc, strictlimit);
-
-		if (mdtc) {
+		balance_domain_limits(gdtc, strictlimit);
+		if (mdtc)
 			/*
 			 * If @wb belongs to !root memcg, repeat the same
 			 * basic calculations for the memcg domain.
 			 */
-			domain_dirty_avail(mdtc, false);
-			domain_dirty_limits(mdtc);
-			domain_dirty_freerun(mdtc, strictlimit);
-		}
+			balance_domain_limits(mdtc, strictlimit);
 
 		/*
 		 * In laptop mode, we wait until hitting the higher threshold
-- 
2.30.0


