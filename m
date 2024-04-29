Return-Path: <linux-fsdevel+bounces-18039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6FE8B4FF8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 05:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7ED1C21227
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 03:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06267D26D;
	Mon, 29 Apr 2024 03:47:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E578C09;
	Mon, 29 Apr 2024 03:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714362472; cv=none; b=gfxau5rJ6lOusZ5Vy15nCu085r2JxJ5f4hsSoQ5v8cbNQmtDEbMJYcomm1WIgF9cczWGPjKaSXDvtlMH1hn5zTK6un4mSKNut3S6ACoahQGHia2T4mVT1uOmySdMe8WkNg1N7pPyTQIL5Dt3/GH/SbM67DTA1oVDZq/G7Q0f4qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714362472; c=relaxed/simple;
	bh=yAXdeJMrm/45+bl8XeH9T5SPYLus9SJhuz9kTD90QM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZElSrjEhMsm4aHcWXWA9dG2DX1/zaAX7DDaTlRrNVCtAc54AyTRi0FAwc4JpSKGQ6wR71EbI8EpMyoe5c0F4b6tfNi05QJcKsnMgAVp8cdlZrhBnYkg3hGrwtbVBehhhShw6BeS7C3WzZ6l3Y6rYZMrPWxXDWEdgmAkYqqKM7m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VSTmq2yDFz4f3jcx;
	Mon, 29 Apr 2024 11:47:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 378751A0B9A;
	Mon, 29 Apr 2024 11:47:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP1 (Coremail) with SMTP id cCh0CgA3UwxgGC9m24__LA--.38879S6;
	Mon, 29 Apr 2024 11:47:47 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: willy@infradead.org,
	akpm@linux-foundation.org,
	jack@suse.cz,
	tj@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] writeback use [global/wb]_domain_dirty_avail helper in cgwb_calc_thresh
Date: Mon, 29 Apr 2024 11:47:32 +0800
Message-Id: <20240429034738.138609-5-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgA3UwxgGC9m24__LA--.38879S6
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr45urWxZr1fWw1rWFyUJrb_yoWktrc_ua
	yUKrykur9rCF45Gay2v3Z3ZrykKw4ku3WDta1SkF9xCFn29rykXFs7XwsxJry7ZFWUXFy7
	GrsrZa1akws7GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
	0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Use [global/wb]_domain_dirty_avail helper in cgwb_calc_thresh to remove
repeated code.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page-writeback.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 28a29180fc9f..a1d48e8387ed 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -934,16 +934,9 @@ unsigned long cgwb_calc_thresh(struct bdi_writeback *wb)
 {
 	struct dirty_throttle_control gdtc = { GDTC_INIT_NO_WB };
 	struct dirty_throttle_control mdtc = { MDTC_INIT(wb, &gdtc) };
-	unsigned long filepages = 0, headroom = 0, writeback = 0;
-
-	gdtc.avail = global_dirtyable_memory();
-	gdtc.dirty = global_node_page_state(NR_FILE_DIRTY) +
-		     global_node_page_state(NR_WRITEBACK);
 
-	mem_cgroup_wb_stats(wb, &filepages, &headroom,
-			    &mdtc.dirty, &writeback);
-	mdtc.dirty += writeback;
-	mdtc_calc_avail(&mdtc, filepages, headroom);
+	global_domain_dirty_avail(&gdtc, false);
+	wb_domain_dirty_avail(&mdtc, false);
 	domain_dirty_limits(&mdtc);
 
 	return __wb_calc_thresh(&mdtc, mdtc.thresh);
-- 
2.30.0


