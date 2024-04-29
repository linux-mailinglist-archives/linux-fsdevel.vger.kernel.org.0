Return-Path: <linux-fsdevel+bounces-18038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2433A8B4FF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 05:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E791F2112E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 03:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFB09449;
	Mon, 29 Apr 2024 03:47:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D462E257B;
	Mon, 29 Apr 2024 03:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714362472; cv=none; b=AmbPqLgqGqJUEx4bLiGuH64ScFETF9HwK3KzjiktChxLyPz5AoRaHv15ztF1uOQqKvEozhIHBiQjAyN9mqWLe7D4iSDIn3a1rAcygWNAWWI+0Fpn/vjEUpb7yPKy3ZYKll+ZlJtT248jB3rJCZhzrldrU3n7hP5OX3v97OOkDtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714362472; c=relaxed/simple;
	bh=WUOSMOEhEqXfZblYjcc5gfPDzoz/TkrM/Tr7MvgCuwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MVEwb3A4VZRrJCtDkY0JyycCW29hHHs5I3N3h6/b7EAfmtqzPDWvfKoSGyaW7a+KESqmmFU6haOpgnQDj6w4T2gR9lrZG8ispSGNK8kuaoDa33I3tVTyPdX6RqeEear6N1QefVDAznU6ks7/Fe+NYZFXVLBQajZYJxdls5ikwb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VSTmp2xFdz4f3jJK;
	Mon, 29 Apr 2024 11:47:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 3638F1A0175;
	Mon, 29 Apr 2024 11:47:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP1 (Coremail) with SMTP id cCh0CgA3UwxgGC9m24__LA--.38879S3;
	Mon, 29 Apr 2024 11:47:46 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: willy@infradead.org,
	akpm@linux-foundation.org,
	jack@suse.cz,
	tj@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] writeback: factor out wb_bg_dirty_limits to remove repeated code
Date: Mon, 29 Apr 2024 11:47:29 +0800
Message-Id: <20240429034738.138609-2-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgA3UwxgGC9m24__LA--.38879S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCw43ZF1rCw18Aw1kuFyDKFg_yoW5GF13pF
	ZrAw12vrW8Jr13trsxJFWUZr43tan3trW7Xr93CwnIyw17GryYgFyIkFZYvFyfGFW7Ja4f
	Zw4Yv34xJ34DKr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxUzoGQUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Similar to wb_dirty_limits which calculates dirty and thresh of wb,
wb_bg_dirty_limits calculates background dirty and background thresh of
wb. With wb_bg_dirty_limits, we could remove repeated code in
wb_over_bg_thresh.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page-writeback.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 692c0da04cbd..e1f73643aca1 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2087,6 +2087,21 @@ void balance_dirty_pages_ratelimited(struct address_space *mapping)
 }
 EXPORT_SYMBOL(balance_dirty_pages_ratelimited);
 
+/*
+ * Similar to wb_dirty_limits, wb_bg_dirty_limits also calculates dirty
+ * and thresh, but it's for background writeback.
+ */
+static void wb_bg_dirty_limits(struct dirty_throttle_control *dtc)
+{
+	struct bdi_writeback *wb = dtc->wb;
+
+	dtc->wb_bg_thresh = __wb_calc_thresh(dtc, dtc->bg_thresh);
+	if (dtc->wb_bg_thresh < 2 * wb_stat_error())
+		dtc->wb_dirty = wb_stat_sum(wb, WB_RECLAIMABLE);
+	else
+		dtc->wb_dirty = wb_stat(wb, WB_RECLAIMABLE);
+}
+
 /**
  * wb_over_bg_thresh - does @wb need to be written back?
  * @wb: bdi_writeback of interest
@@ -2103,8 +2118,6 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
 	struct dirty_throttle_control * const gdtc = &gdtc_stor;
 	struct dirty_throttle_control * const mdtc = mdtc_valid(&mdtc_stor) ?
 						     &mdtc_stor : NULL;
-	unsigned long reclaimable;
-	unsigned long thresh;
 
 	/*
 	 * Similar to balance_dirty_pages() but ignores pages being written
@@ -2117,13 +2130,8 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
 	if (gdtc->dirty > gdtc->bg_thresh)
 		return true;
 
-	thresh = __wb_calc_thresh(gdtc, gdtc->bg_thresh);
-	if (thresh < 2 * wb_stat_error())
-		reclaimable = wb_stat_sum(wb, WB_RECLAIMABLE);
-	else
-		reclaimable = wb_stat(wb, WB_RECLAIMABLE);
-
-	if (reclaimable > thresh)
+	wb_bg_dirty_limits(gdtc);
+	if (gdtc->wb_dirty > gdtc->wb_bg_thresh)
 		return true;
 
 	if (mdtc) {
@@ -2137,13 +2145,8 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
 		if (mdtc->dirty > mdtc->bg_thresh)
 			return true;
 
-		thresh = __wb_calc_thresh(mdtc, mdtc->bg_thresh);
-		if (thresh < 2 * wb_stat_error())
-			reclaimable = wb_stat_sum(wb, WB_RECLAIMABLE);
-		else
-			reclaimable = wb_stat(wb, WB_RECLAIMABLE);
-
-		if (reclaimable > thresh)
+		wb_bg_dirty_limits(mdtc);
+		if (mdtc->wb_dirty > mdtc->wb_bg_thresh)
 			return true;
 	}
 
-- 
2.30.0


