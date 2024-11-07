Return-Path: <linux-fsdevel+bounces-33874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B44A79BFF26
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 08:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 719D22834EB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 07:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270D81DB362;
	Thu,  7 Nov 2024 07:30:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32467194AD1;
	Thu,  7 Nov 2024 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730964624; cv=none; b=MXe1fps84EMA+Grfj1aTJZzbN6HgNGg8G1/981xnvnAG9ALsJCbcPkltWKAZmJrQLsHUce6DgPp75n4vx3iI5ezhGcr/+G2BmgqZrSVnJVtJIt4Ba4ozMIRIx9Ty3PktfSDK3lnLKZgpMRlBVbbqBpGj6pK1XrD1OfKXmD0nlTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730964624; c=relaxed/simple;
	bh=WL+VTvKdCZu8KF3VGHdzLA4DPkzH0GCIHPSj7kp9giA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B51XXyJOXocTH9PxzovXFDwmp3V4Odc5Gt6bnxGHC3bVag9A+wNPoQdkuH8yd4cG6tD6e4VBWSN+Rp25P7XNxmenlNwSLQEq63j5gsRBAGOfdmHq/OuR6qfUQKeeQeiQXqnHG79OhTDfFHRHk7tgCm6yddS6PuYt5o2VFH85VK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XkYcd3g3qz4f3jsM;
	Thu,  7 Nov 2024 15:29:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 845851A058E;
	Thu,  7 Nov 2024 15:30:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP1 (Coremail) with SMTP id cCh0CgB3Ha+BbCxnnlhABA--.55387S5;
	Thu, 07 Nov 2024 15:30:11 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/5] Xarray: move forward index correctly in xas_pause()
Date: Fri,  8 Nov 2024 00:29:18 +0800
Message-Id: <20241107162920.208796-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241107162920.208796-1-shikemeng@huaweicloud.com>
References: <20241107162920.208796-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgB3Ha+BbCxnnlhABA--.55387S5
X-Coremail-Antispam: 1UD129KBjvJXoWxuFyUWFWxCF4fJFyrAFy5Arb_yoW5Gr1UpF
	WDGryFyw18Jr1I9rnIqa18uw1Fg3WrKa13trWfGr1ftrZxGr9Fy3Wjkr98XF9xWa18Aa47
	CF4rWrn8Ga1DJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3G-eDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

After xas_load(), xas->index could point to mid of found multi-index entry
and xas->index's bits under node->shift maybe non-zero. The afterward
xas_pause() will move forward xas->index with xa->node->shift with bits
under node->shift un-masked and thus skip some index unexpectedly.

Consider following case:
Assume XA_CHUNK_SHIFT is 4.
xa_store_range(xa, 16, 31, ...)
xa_store(xa, 32, ...)
XA_STATE(xas, xa, 17);
xas_for_each(&xas,...)
xas_load(&xas)
/* xas->index = 17, xas->xa_offset = 1, xas->xa_node->xa_shift = 4 */
xas_pause()
/* xas->index = 33, xas->xa_offset = 2, xas->xa_node->xa_shift = 4 */
As we can see, index of 32 is skipped unexpectedly.

Fix this by mask bit under node->xa_shift when move forward index in
xas_pause().

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 lib/test_xarray.c | 35 +++++++++++++++++++++++++++++++++++
 lib/xarray.c      |  1 +
 2 files changed, 36 insertions(+)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index d5c5cbba33ed..6932a26f4927 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1448,6 +1448,41 @@ static noinline void check_pause(struct xarray *xa)
 	XA_BUG_ON(xa, count != order_limit);
 
 	xa_destroy(xa);
+
+	index = 0;
+	for (order = XA_CHUNK_SHIFT; order > 0; order--) {
+		XA_BUG_ON(xa, xa_store_order(xa, index, order,
+					xa_mk_index(index), GFP_KERNEL));
+		index += 1UL << order;
+	}
+
+	index = 0;
+	count = 0;
+	xas_set(&xas, 0);
+	rcu_read_lock();
+	xas_for_each(&xas, entry, ULONG_MAX) {
+		XA_BUG_ON(xa, entry != xa_mk_index(index));
+		index += 1UL << (XA_CHUNK_SHIFT - count);
+		count++;
+	}
+	rcu_read_unlock();
+	XA_BUG_ON(xa, count != XA_CHUNK_SHIFT);
+
+	index = 0;
+	count = 0;
+	xas_set(&xas, XA_CHUNK_SIZE / 2 + 1);
+	rcu_read_lock();
+	xas_for_each(&xas, entry, ULONG_MAX) {
+		XA_BUG_ON(xa, entry != xa_mk_index(index));
+		index += 1UL << (XA_CHUNK_SHIFT - count);
+		count++;
+		xas_pause(&xas);
+	}
+	rcu_read_unlock();
+	XA_BUG_ON(xa, count != XA_CHUNK_SHIFT);
+
+	xa_destroy(xa);
+
 }
 
 static noinline void check_move_tiny(struct xarray *xa)
diff --git a/lib/xarray.c b/lib/xarray.c
index b9fd321a02ad..3fac3f2cea9d 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1147,6 +1147,7 @@ void xas_pause(struct xa_state *xas)
 			if (!xa_is_sibling(xa_entry(xas->xa, node, offset)))
 				break;
 		}
+		xas->xa_index &= ~0UL << node->shift;
 		xas->xa_index += (offset - xas->xa_offset) << node->shift;
 		if (xas->xa_index == 0)
 			xas->xa_node = XAS_BOUNDS;
-- 
2.30.0


