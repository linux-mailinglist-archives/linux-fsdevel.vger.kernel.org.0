Return-Path: <linux-fsdevel+bounces-37707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E749F5ED0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 07:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0373B16734A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 06:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143501607B7;
	Wed, 18 Dec 2024 06:48:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2CB15380A;
	Wed, 18 Dec 2024 06:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734504494; cv=none; b=DxKjngc4JjTVfv2rf5Jk2Ckb9XogHIf/Zjt0CIjte+eNxyXagZdcxDemHjcPT7WYAxJnJH7KKrkHE76yXKR/63rnxV0qSd7IFqUyhNscR5zQMYOq1qe5dp/MTziI9xbsqFAhc9GVmYiKtzGm4dM7z30Y7P+4M6xUYvZ+uf9PJ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734504494; c=relaxed/simple;
	bh=gZg9AaSBKuhbiYiSdlwcny91/4iuqVBuhZMsgswIRDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TLtCqndEGprKB9h2E4xXUyaXx8gNr2Cj8exmHAYsjGeHTAJze9neVy5gNKOLaO3TRVwZOYl/iyREyP4iERoJg31E2YKLDHUS3fko3S26cHpkJZrAi/YcenZTMc+wjGymDZyxfz8pex6x5Sr2t+cRlG0o7AfswsPfCr8+t1afu6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YCkl76bcRz4f3lVs;
	Wed, 18 Dec 2024 14:47:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 73DED1A0194;
	Wed, 18 Dec 2024 14:48:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP1 (Coremail) with SMTP id cCh0CgA33a4mcGJnxKU7Ew--.4083S4;
	Wed, 18 Dec 2024 14:48:08 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v4 2/5] Xarray: move forward index correctly in xas_pause()
Date: Wed, 18 Dec 2024 23:46:10 +0800
Message-Id: <20241218154613.58754-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241218154613.58754-1-shikemeng@huaweicloud.com>
References: <20241218154613.58754-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA33a4mcGJnxKU7Ew--.4083S4
X-Coremail-Antispam: 1UD129KBjvJXoWxuFyUWFWxCF4fJF4DAw43Jrb_yoW5Xr1DpF
	WDKryFyw18Jr4I9rnIqa109w1Fg3WrKa1aqrWfGr1ftrZxGryqy3WjkrZ8ZF9xGa18Za47
	CF48Wr1DGa1DJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxV
	WUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j9739U
	UUUU=
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

For now, this will not cause serious problems. Only minor problem
like cachestat return less number of page status could happen.

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
index fa87949719a0..d0732c5b8403 100644
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


