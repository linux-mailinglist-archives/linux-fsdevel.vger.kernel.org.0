Return-Path: <linux-fsdevel+bounces-34226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 530D59C3EF5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 13:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1DE1F23A49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 12:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468BB1B4F2D;
	Mon, 11 Nov 2024 12:55:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AEC19DF48;
	Mon, 11 Nov 2024 12:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731329703; cv=none; b=t+S8p6mVpNkQ9pQSHOwtuRgc2qgYRgB41lIg0lCIbOqrhQLGzgXcqZlZSZY14Gig0VmaJYEhPo5l5/gWUc8ufhLeD9wxErKUwQT7fA/2FsCFxj9ZZSsL+DGTm5vPpzh7csfLUwpubgHFxGTDcoyJrFTSWUio5q5UTWISQphRK+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731329703; c=relaxed/simple;
	bh=XtlA+Aq0rbUEYLB0kd7+wNs8u/7jCZVEWBvDzDhooDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LlCWYqXsUOtVTNB9UCFdEBKpJ7WvwFn4T0eDtj3WaroZrOcRd5KqVmwSxDPLusOKONVTX/x9DPTw0ys7PZEnaACXn7dfBQB8CvKyicG3DRQEkct4uatwVP7xlqG1q9TFgA+p4IDFk0r5bX2puqjjUTtQ5Rqkx4Df3Oy2n70FB3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xn8dW12JFz4f3jcx;
	Mon, 11 Nov 2024 20:54:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 49A721A08DC;
	Mon, 11 Nov 2024 20:54:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgB3n4Oe_jFnllryBQ--.36628S6;
	Mon, 11 Nov 2024 20:54:57 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH RESEND V2 4/5] Xarray: remove repeat check in xas_squash_marks()
Date: Tue, 12 Nov 2024 05:53:58 +0800
Message-Id: <20241111215359.246937-5-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241111215359.246937-1-shikemeng@huaweicloud.com>
References: <20241111215359.246937-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3n4Oe_jFnllryBQ--.36628S6
X-Coremail-Antispam: 1UD129KBjvdXoWrtFWxKF1Dtr4kXFy7Xw4kCrg_yoWxtwb_Za
	10yr1vyr1UCrn7XwsIkFs8tryjkryvqF9rKFW8Ja43ur10qry5WF4vqr15Aa4kZw4ayFy7
	JF45Zr1Y9r15GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbqkYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
	xGYIkIc2x26280x7IE14v26r126s0DM28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC
	64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM2
	8EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq
	3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7
	AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jv
	Wl9UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Caller of xas_squash_marks() has ensured xas->xa_sibs is non-zero. Just
remove repeat check of xas->xa_sibs in xas_squash_marks().

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 lib/xarray.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index 3fac3f2cea9d..4231af284bd8 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -128,9 +128,6 @@ static void xas_squash_marks(const struct xa_state *xas)
 	unsigned int mark = 0;
 	unsigned int limit = xas->xa_offset + xas->xa_sibs + 1;
 
-	if (!xas->xa_sibs)
-		return;
-
 	do {
 		unsigned long *marks = xas->xa_node->marks[mark];
 		if (find_next_bit(marks, limit, xas->xa_offset + 1) == limit)
-- 
2.30.0


