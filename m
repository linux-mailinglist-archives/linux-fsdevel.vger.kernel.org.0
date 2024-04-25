Return-Path: <linux-fsdevel+bounces-17763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B508B2263
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 15:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0561E1C21230
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 13:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6A4149C64;
	Thu, 25 Apr 2024 13:17:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E090C149C4B;
	Thu, 25 Apr 2024 13:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714051052; cv=none; b=WFXa9co2L2UMOlLOp7iVCnkTFSXX1zdYcFaWDObfDzIW+FMGN4M+Kz6wcB4zr+Pub3yrHYEyP37wUHO1kdWfGps15d3mF773wE2shVA9h5k5DHKOjV0jEBIzPOKRVfvxAoejCmE1xkkVUWYn36JXPwjpS8qsz5qkMbEkIP0vL0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714051052; c=relaxed/simple;
	bh=VpxmnRAZj2qhsDjNee4F9fWraIRUq42RqpYTy4ermGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GiPZho7f0BcAE3RscGWRemmZoLYFYD0tbtJavPXnOiF+ghxcP6+QhKB74p1ngA8iByQcSjPFp6+40KLEoRckprZPjFLP016Xuz0ECThzLAHGEsY4Z9+RsHPiVwJIZhz28ZOTQvQtH5Ai27ianLu0Fsfqvtsh6jD7nQHLp1KtH98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VQGby1SD4z4f3n6m;
	Thu, 25 Apr 2024 21:17:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 728FA1A0179;
	Thu, 25 Apr 2024 21:17:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP3 (Coremail) with SMTP id _Ch0CgA3+J_kVypmFDcOKw--.42283S5;
	Thu, 25 Apr 2024 21:17:27 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: willy@infradead.org,
	akpm@linux-foundation.org
Cc: tj@kernel.org,
	jack@suse.cz,
	hcochran@kernelspring.com,
	axboe@kernel.dk,
	mszeredi@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] mm: call __wb_calc_thresh instead of wb_calc_thresh in wb_over_bg_thresh
Date: Thu, 25 Apr 2024 21:17:23 +0800
Message-Id: <20240425131724.36778-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240425131724.36778-1-shikemeng@huaweicloud.com>
References: <20240425131724.36778-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgA3+J_kVypmFDcOKw--.42283S5
X-Coremail-Antispam: 1UD129KBjvdXoWrZF4rCF1UXFWDur1fKryfJFb_yoW3ArgEga
	1ftry7CrW3JFyDKa4UC3Z3GFyjkrWDuF1rua1rKFy7JF1jvryDZF1Ikw4kZr9FyF1j9rsI
	kr93Xr4YqanrGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfxYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r1rM2
	8IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Call __wb_calc_thresh to calculate wb bg_thresh of gdtc in
wb_over_bg_thresh to remove unnecessary wrap in wb_calc_thresh.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 14893b20d38c..22e1acec899e 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2117,7 +2117,7 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
 	if (gdtc->dirty > gdtc->bg_thresh)
 		return true;
 
-	thresh = wb_calc_thresh(gdtc->wb, gdtc->bg_thresh);
+	thresh = __wb_calc_thresh(gdtc, gdtc->bg_thresh);
 	if (thresh < 2 * wb_stat_error())
 		reclaimable = wb_stat_sum(wb, WB_RECLAIMABLE);
 	else
-- 
2.30.0


