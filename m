Return-Path: <linux-fsdevel+bounces-18040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672C08B4FFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 05:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F7A1C2120E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 03:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C03DF6B;
	Mon, 29 Apr 2024 03:47:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF018C1D;
	Mon, 29 Apr 2024 03:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714362473; cv=none; b=eS9L4xcoVfssD5Me4C9TNX3Og9d8FoL30LcB/CrHKSqbLYPTFGZnSAUtkgwGjvNjSQB0eYoyQ8oGTa43JgKLeBawZLA7nZzRGPPO+3JN26UWZHEsAWkpA56MDx1re2pgUYVRpua8Zxh3aAMD684oAmZv5mT/eZRbLwiQDQJtGaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714362473; c=relaxed/simple;
	bh=T/yxCnveBAZtO4SJ3hrX+mSnNojCYLn5mhA9OsM6IAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tKHJ2dgvlyMYCCJTPqQfgjdYeFXhoyfp9Xgd/diYmTuQuY82AOG5e7dZCE85Y1Vp10fyzExt08T2rCxx/MM+butdZ7RgkME7OuOTEJlrA7OVwwLou4w3kS+U6oGHUpNLfLbYhnO1AKgXcWGD1xifPfKW2LPYcxQoC95O1nhEu9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VSTmq5HWjz4f3jd4;
	Mon, 29 Apr 2024 11:47:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 865691A016E;
	Mon, 29 Apr 2024 11:47:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP1 (Coremail) with SMTP id cCh0CgA3UwxgGC9m24__LA--.38879S7;
	Mon, 29 Apr 2024 11:47:47 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: willy@infradead.org,
	akpm@linux-foundation.org,
	jack@suse.cz,
	tj@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] writeback: call domain_dirty_avail in balance_dirty_pages
Date: Mon, 29 Apr 2024 11:47:33 +0800
Message-Id: <20240429034738.138609-6-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgA3UwxgGC9m24__LA--.38879S7
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyrCF1kJw48ZrW8Gr4kWFg_yoW8GFWxpF
	Z3tan0kayUtF12qrn7Aa9F9rW3Kan7KrWxJryxC3yavF42kF1UKFyI9ryvvr1Ikry3Jr9I
	v3y2qrykJw10gr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Call domain_dirty_avail in balance_dirty_pages to remove repeated code.
This is also a preparation to factor out repeated code calculating
dirty limits in balance_dirty_pages.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page-writeback.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index a1d48e8387ed..c41db87f4e98 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1747,9 +1747,8 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 		unsigned long m_bg_thresh = 0;
 
 		nr_dirty = global_node_page_state(NR_FILE_DIRTY);
-		gdtc->avail = global_dirtyable_memory();
-		gdtc->dirty = nr_dirty + global_node_page_state(NR_WRITEBACK);
 
+		domain_dirty_avail(gdtc, false);
 		domain_dirty_limits(gdtc);
 
 		if (unlikely(strictlimit)) {
@@ -1765,17 +1764,11 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 		}
 
 		if (mdtc) {
-			unsigned long filepages, headroom, writeback;
-
 			/*
 			 * If @wb belongs to !root memcg, repeat the same
 			 * basic calculations for the memcg domain.
 			 */
-			mem_cgroup_wb_stats(wb, &filepages, &headroom,
-					    &mdtc->dirty, &writeback);
-			mdtc->dirty += writeback;
-			mdtc_calc_avail(mdtc, filepages, headroom);
-
+			domain_dirty_avail(mdtc, false);
 			domain_dirty_limits(mdtc);
 
 			if (unlikely(strictlimit)) {
-- 
2.30.0


