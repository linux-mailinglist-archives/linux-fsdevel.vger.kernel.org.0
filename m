Return-Path: <linux-fsdevel+bounces-19413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86FD8C5644
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 14:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3AA7282C40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 12:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6234C7E116;
	Tue, 14 May 2024 12:53:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96FD5A79B;
	Tue, 14 May 2024 12:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715691217; cv=none; b=uGTePoeXGi3IHboAeZD9mvSB5GUIaevgp/1GkOEmOFsJ2qvwApMBRnY9gBGY32pg3zyK4OLmZoXuyeKte74KTiowlFQOgsGQo0y1ZJjfDJQoW3jjHPw4sCRn9YGztIYV5xMBdUsE0ZU9LAaI/GnS270MCZMR2koe8N618ypgI3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715691217; c=relaxed/simple;
	bh=vWswYOtOKee83p9WXuM212GKlL0PcUyQ2Hmy8L13w3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iBYiCgcKrYb70akEEzk9HCQJIMabYUSHQqZyNDdxxEE5QG7K3dDEwaqBrj0mi6jYhkU1rHxuXfCKjS1nHAdiiC6hA2KFKNTNLhroKee9dg/+iCosSBetfdlfa2Cr8gyE0C9sW5aoHxdVUJi+HrHv/xDt8eS675adxnFM8gWiVAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vdx9S24lJz4f3n5l;
	Tue, 14 May 2024 20:53:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6C62C1A0D06;
	Tue, 14 May 2024 20:53:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgDHzG7EXkNmCyyLMw--.6596S3;
	Tue, 14 May 2024 20:53:26 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: willy@infradead.org,
	akpm@linux-foundation.org,
	tj@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] writeback: factor out wb_bg_dirty_limits to remove repeated code
Date: Tue, 14 May 2024 20:52:47 +0800
Message-Id: <20240514125254.142203-2-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDHzG7EXkNmCyyLMw--.6596S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCw43Kr15Zr45XFWkCFyfWFg_yoW5GFWDpF
	ZrAw12vrW8Jr1ayrsxGFWUZr45tan3trW7Xr93CwnIyw43GryYgFyIkFZYvFyfGFW7Ja4f
	Zw4YvryxJw1DKrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxUzoGQUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Similar to wb_dirty_limits which calculates dirty and thresh of wb,
wb_bg_dirty_limits calculates background dirty and background thresh of
wb. With wb_bg_dirty_limits, we could remove repeated code in
wb_over_bg_thresh.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Acked-by: Tejun Heo <tj@kernel.org>
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


