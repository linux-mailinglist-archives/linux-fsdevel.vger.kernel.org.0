Return-Path: <linux-fsdevel+bounces-8532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30674838C34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 11:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 629351C21B1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 10:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E825D8F2;
	Tue, 23 Jan 2024 10:35:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D608E5C8E1;
	Tue, 23 Jan 2024 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006157; cv=none; b=q1509Fv8YXOszU0WShviCONGC375PkFoPdDqcVhfeNqpu3GrKRr1dHX9DKgI1wqdR95wvAkig3HJ9xrKSOSwjCYgz/YdqfLlc6JUcZyqAhP+luK37rphoWRjiWPv5kZ2j9Tonzp7PNffGe2hgMXW3XeZgc8h2DBqX3uQzXWHmIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006157; c=relaxed/simple;
	bh=mHficx9kFuMhJ2DpL4mOmqjZNB40K9NGs1JBodalvv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cGc5y3a1Br9ImDlfEAzEgn0yvsYjy0eacDvV39rwJzU9FiphzsQSm2XIKMOzCK8hdzz8+Pcz2jWzHQlUCIZlO6qQpvs5GsURmh/SJWxtfkK1D+ftSgBgh8ZN63ooUXSX8c14e0eDcp74u7x89AXcB3dXulQn8dN5MoyVeNewTgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TK3QX60h7z4f3khg;
	Tue, 23 Jan 2024 18:35:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BAD261A0171;
	Tue, 23 Jan 2024 18:35:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgA3Bg+Flq9ly6DjBg--.30161S6;
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
Subject: [PATCH 4/5] mm: remove redundant check in wb_min_max_ratio
Date: Wed, 24 Jan 2024 02:33:31 +0800
Message-Id: <20240123183332.876854-5-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgA3Bg+Flq9ly6DjBg--.30161S6
X-Coremail-Antispam: 1UD129KBjvdXoWrKFy5XrW7Jw1fXF4kXr4UXFb_yoWfXrc_XF
	nxtr95A3W7WFy3Ga1I9as0yrs7Kws5Cryxuw4j9an3tFyrKr1FvFs5ZF1DAw1UWF42qasx
	Gws8uF45ZrsrWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbS8YFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
	xGYIkIc2x26280x7IE14v26r126s0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC
	64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM2
	8EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq
	3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jstxDUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

We initialize bdi->max_ratio with a valid value (100 * BDI_RATIO_SCALE)
in bdi_init and we always set bdi->max_ratio with a valid value (< 100 *
BDI_RATIO_SCALE) in __bdi_set_max_ratio. So the validation of max_ratio
in wb_min_max_ratio is redundant. Just remove it.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page-writeback.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 5c19ebffe5be..f25393034c76 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -198,10 +198,8 @@ static void wb_min_max_ratio(struct bdi_writeback *wb,
 			min *= this_bw;
 			min = div64_ul(min, tot_bw);
 		}
-		if (max < 100 * BDI_RATIO_SCALE) {
-			max *= this_bw;
-			max = div64_ul(max, tot_bw);
-		}
+		max *= this_bw;
+		max = div64_ul(max, tot_bw);
 	}
 
 	*minp = min;
-- 
2.30.0


