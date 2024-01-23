Return-Path: <linux-fsdevel+bounces-8531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C59B838C32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 11:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6801C22C3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 10:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AD45D730;
	Tue, 23 Jan 2024 10:35:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458255C61A;
	Tue, 23 Jan 2024 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006156; cv=none; b=W7Aqed+CAia1N4Vvzit4cRQ02nwXr05dF020NYJmwxuvMIJocfXWtKS0ysOXHYGcU2eabQVwS5x6t9TJYE5tVvVPe85fuVG96GgO/XjafT91XPwlegyovEprENh2S6ESFBqCXuA7MAinhSer5U2qQLQHJdUCQJnO/ZkTHFYjHnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006156; c=relaxed/simple;
	bh=8gwRNvwSwzCZCLaee1qjuw4RvCn4ypVe18AI/ayWNVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ukxXTSkf2TvKs+1unh+/fQNXT1Dndjy4OI4WeY8Fu3GLh13y8ZciHxA5vb2wjN9Mlsh68qRJVcHlCcwdU8K9m4IG3P5eq2YXVTKKG3IngVvBYakbOJioBMqVno5ydMllVSFxjrUtxMsUnIf9Uxk2OvfLxiAfdXlz/0Oi5Sx+wk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TK3QX30Tkz4f3khb;
	Tue, 23 Jan 2024 18:35:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5376B1A0173;
	Tue, 23 Jan 2024 18:35:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgA3Bg+Flq9ly6DjBg--.30161S5;
	Tue, 23 Jan 2024 18:35:52 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: willy@infradead.org,
	akpm@linux-foundation.org
Cc: tj@kernel.org,
	hcochran@kernelspring.com,
	mszeredi@redhat.com,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] mm: call __wb_calc_thresh instead of wb_calc_thresh in wb_over_bg_thresh
Date: Wed, 24 Jan 2024 02:33:30 +0800
Message-Id: <20240123183332.876854-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240123183332.876854-1-shikemeng@huaweicloud.com>
References: <20240123183332.876854-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3Bg+Flq9ly6DjBg--.30161S5
X-Coremail-Antispam: 1UD129KBjvdXoWrtw4fGFykGFy7WFyfKryxuFg_yoW3JrXEg3
	W8trnrGrW3JFyUGa4xCas3Gr1jkrWkuF1rZa1rGFy7JFy0vrykXFy0kw4kZr9FvFyj93sI
	krySqr4YqanrWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfxYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
	xGYIkIc2x26280x7IE14v26r1rM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kI
	II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7
	xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07js0edUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Call __wb_calc_thresh directly to remove unnecessary wrap of
wb_calc_thresh.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index f6c7f3b0f495..5c19ebffe5be 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2098,7 +2098,7 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
 	if (gdtc->dirty > gdtc->bg_thresh)
 		return true;
 
-	thresh = wb_calc_thresh(gdtc->wb, gdtc->bg_thresh);
+	thresh = __wb_calc_thresh(gdtc, gdtc->bg_thresh);
 	if (thresh < 2 * wb_stat_error())
 		reclaimable = wb_stat_sum(wb, WB_RECLAIMABLE);
 	else
-- 
2.30.0


