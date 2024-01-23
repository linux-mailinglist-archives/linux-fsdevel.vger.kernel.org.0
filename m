Return-Path: <linux-fsdevel+bounces-8530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C0A838C30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 11:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5EC1F233CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 10:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAAF5C91A;
	Tue, 23 Jan 2024 10:35:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FC95C619;
	Tue, 23 Jan 2024 10:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006156; cv=none; b=HkFbRUxMKTLhKD36rvngdiInLtXgMfe8iQYI3FRBFMY3l+0UEk+huwCQXlxO8vtlly8mZRMV8N8Kh6a83xA3VQ/zScZpjT5ZQQHiSp63b/RoeD7K8ghmGTfm28JhM4Wi3SZsgWu5W5HxSjj9RRYMxKHU6Kwdo09i6tG4eb/QcHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006156; c=relaxed/simple;
	bh=t6jBg3pMH2UPw5fopr4M7LYUMgCMan9VjdEWKSOqnUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z6lusV4Uk40WS8jXEn7rBJK3BoSjj6viXNboR2PM0qYmZHwHDbeRV11il6FEnRfDHcN3ERRTXltgwOYTQp0yEgu+OeYPNsspchSWTmfaS46eoS/z1qudSzqXCyA4LlqCr5pMV7sx08jLQ2zWWtuKt+7PesylECeYLWwvtGuH3R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TK3QW70zwz4f3khP;
	Tue, 23 Jan 2024 18:35:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DED491A0199;
	Tue, 23 Jan 2024 18:35:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgA3Bg+Flq9ly6DjBg--.30161S4;
	Tue, 23 Jan 2024 18:35:51 +0800 (CST)
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
Subject: [PATCH 2/5] mm: correct calculation of cgroup wb's bg_thresh in wb_over_bg_thresh
Date: Wed, 24 Jan 2024 02:33:29 +0800
Message-Id: <20240123183332.876854-3-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgA3Bg+Flq9ly6DjBg--.30161S4
X-Coremail-Antispam: 1UD129KBjvdXoW7JF45ZFy8tFWUKF1xZr1UJrb_yoWfZwb_uw
	18tr47GrW7J3WDGay8uas3Jr1jk3yDuF1rCa1rKFy7tay0vr1DZF18Cw4kZr9Fva4j9rZI
	934SqrW5XwsrKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfxYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
	xGYIkIc2x26280x7IE14v26r15M28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kI
	II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7
	xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jguciUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

The wb_calc_thresh will calculate wb's share in global wb domain. We need
to wb's share in mem_cgroup_wb_domain for mdtc. Call __wb_calc_thresh
instead of wb_calc_thresh to fix this.

Fixes: 74d369443325 ("writeback: Fix performance regression in wb_over_bg_thresh()")
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 9268859722c4..f6c7f3b0f495 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2118,7 +2118,7 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
 		if (mdtc->dirty > mdtc->bg_thresh)
 			return true;
 
-		thresh = wb_calc_thresh(mdtc->wb, mdtc->bg_thresh);
+		thresh = __wb_calc_thresh(mdtc, mdtc->bg_thresh);
 		if (thresh < 2 * wb_stat_error())
 			reclaimable = wb_stat_sum(wb, WB_RECLAIMABLE);
 		else
-- 
2.30.0


