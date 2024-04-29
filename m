Return-Path: <linux-fsdevel+bounces-18047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF5D8B500B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 05:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DDDE1C21279
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 03:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879BB111BB;
	Mon, 29 Apr 2024 03:48:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0B5200CD;
	Mon, 29 Apr 2024 03:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714362481; cv=none; b=MBmPSg7a+DPBcSfQZANJjxB4nTppjEA1Gm+9kMgvF4dpXHjwCUlK/pu5nyGeFYUh/dbiU18sebuDlD5mZkiSt7L83jm+ro/Q3aIGUgc3kY9D61H8T3m+ppiLUu4mtoR2oPTpVGWRNhr/frdMUwBbjv0LRqj6H2xI7/N736TNDXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714362481; c=relaxed/simple;
	bh=/rNwyfdAP8bbQElnR2CpvbW8upwOIeYxWG9L1OnsP2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c4+uw69aNPi4lDVk6J2eGo0XGFz9/m43T2j7ybbdCIAGGPzon0H7ss3B251UDB5EO3FdM3Dw0/6cwwXAXKJJIDeR/JzPl7Cd8aCUhBjbgpJL5mhRyCan6yp95BuhRE61gLzduI8bWdJWxHREmYpx1NVY7E8vamVEfFODyKNgDFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VSTmq2pG7z4f3nJw;
	Mon, 29 Apr 2024 11:47:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C89951A0568;
	Mon, 29 Apr 2024 11:47:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP1 (Coremail) with SMTP id cCh0CgA3UwxgGC9m24__LA--.38879S11;
	Mon, 29 Apr 2024 11:47:48 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: willy@infradead.org,
	akpm@linux-foundation.org,
	jack@suse.cz,
	tj@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] writeback: factor out wb_dirty_exceeded to remove repeated code
Date: Mon, 29 Apr 2024 11:47:37 +0800
Message-Id: <20240429034738.138609-10-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgA3UwxgGC9m24__LA--.38879S11
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw45Jr4Dtr17ur4fXr45GFg_yoW8KF17pF
	ZrJw12krWUJa1Sg3ZxJFWDur43trsrArWxJ34UWw15ta13KF12gr92qFWFvr17ArZxJFs0
	yrW5t34xGw18Kr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Factor out wb_dirty_exceeded to remove repeated code

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page-writeback.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 68ae4c90ce8b..26b638cc58c5 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -140,6 +140,7 @@ struct dirty_throttle_control {
 
 	unsigned long		pos_ratio;
 	bool			freerun;
+	bool			dirty_exceeded;
 };
 
 /*
@@ -1782,6 +1783,13 @@ static void wb_dirty_freerun(struct dirty_throttle_control *dtc,
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
@@ -1804,7 +1812,6 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 	long max_pause;
 	long min_pause;
 	int nr_dirtied_pause;
-	bool dirty_exceeded = false;
 	unsigned long task_ratelimit;
 	unsigned long dirty_ratelimit;
 	struct backing_dev_info *bdi = wb->bdi;
@@ -1872,9 +1879,7 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 		if (gdtc->freerun)
 			goto free_running;
 
-		dirty_exceeded = (gdtc->wb_dirty > gdtc->wb_thresh) &&
-			((gdtc->dirty > gdtc->thresh) || strictlimit);
-
+		wb_dirty_exceeded(gdtc, strictlimit);
 		wb_position_ratio(gdtc);
 		sdtc = gdtc;
 
@@ -1889,17 +1894,13 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
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
+		wb->dirty_exceeded = gdtc->dirty_exceeded || mdtc->dirty_exceeded;
 		if (time_is_before_jiffies(READ_ONCE(wb->bw_time_stamp) +
 					   BANDWIDTH_INTERVAL))
 			__wb_update_bandwidth(gdtc, mdtc, true);
-- 
2.30.0


