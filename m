Return-Path: <linux-fsdevel+bounces-18046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5CA8B5009
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 05:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B148D1C21275
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 03:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1CC18E0E;
	Mon, 29 Apr 2024 03:47:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCE211702;
	Mon, 29 Apr 2024 03:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714362478; cv=none; b=fFJUah0K34hrJT+gbqFBJjXpn28gkdv89HqMMPS1Iq5whizX6rFZtfFevBxwH/w2j7kq+PxiE8o5sxLnf4BdwKDf9fv6VJNeKNBfSK4Ho5DgopP31mkwHcyPnl1z9bU5faRB+7XvMJVp2nXp+9rumSX09wUEDmkgu8xqgkyuFQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714362478; c=relaxed/simple;
	bh=MFXfDXwPp1vmE3PRkfhD4/1qYjJgiU5TSSokgcxSxW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WvxagNDBLSok3uL8bkguIu7zJRQNf5DLWjZcf472qjHxbvQRAaPa1PODHqz5kgP7OZ9b6Mf3VQr/H9V+feGPXMGa8yBVMsqvZ+/pMNfW81YjHaCfqeCfM2/lHZUGwAtyjFbqNMNFTvXPzZaYUCQ1E+nsgBmw7RRhSL/2kADE3AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VSTmp5Ptkz4f3nJl;
	Mon, 29 Apr 2024 11:47:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2D3091A0179;
	Mon, 29 Apr 2024 11:47:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP1 (Coremail) with SMTP id cCh0CgA3UwxgGC9m24__LA--.38879S9;
	Mon, 29 Apr 2024 11:47:48 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: willy@infradead.org,
	akpm@linux-foundation.org,
	jack@suse.cz,
	tj@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] writeback: factor out wb_dirty_freerun to remove more repeated freerun code
Date: Mon, 29 Apr 2024 11:47:35 +0800
Message-Id: <20240429034738.138609-8-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgA3UwxgGC9m24__LA--.38879S9
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1xWrWUuryUXF45GrW7Arb_yoW5GFy5pF
	WSyw43Cr4DJr1IqrsIyF9FvFWftrsavrWfC34Uuwnxtw1Sgr1Igry7tryrZF42kFy7Jrs0
	vFs0vF97G34UJFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Factor out wb_dirty_freerun to remove more repeated freerun code.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page-writeback.c | 55 +++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index b49ca82380a5..e38beb680742 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1753,6 +1753,27 @@ static void domain_dirty_freerun(struct dirty_throttle_control *dtc,
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
@@ -1845,19 +1866,9 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
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
@@ -1872,20 +1883,10 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
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


