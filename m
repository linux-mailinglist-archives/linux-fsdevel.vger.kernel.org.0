Return-Path: <linux-fsdevel+bounces-37708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 887C29F5ED4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 07:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A639188C936
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 06:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A930C176FB4;
	Wed, 18 Dec 2024 06:48:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADE3154BE2;
	Wed, 18 Dec 2024 06:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734504495; cv=none; b=VpAc6M0fSU8D6qMlykZJ4P6f9rSD8VMS/PeLifWoqjtyjliksdm+AJbdvc0343/X6ccyTyBUGHKTbiAd01yTHVfM3hRVneSJX/LolGu+R8sQz32zzXPa0LGg727O28aOh2BoR9RSoj9IfAsmd79x+DSrZGKHWgAt75SLvRsS+fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734504495; c=relaxed/simple;
	bh=zdZBNspTvRi8E6yLFupvWXoyriecBilryOejiKh9q3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dTtagvwQ0/tJVEXTroEVhXb2O9L86dtNV/HUlfc2Etgm0t1txwhZnJ5rCm5mp4LKNMJBocvmTuFegrHb4sWtKgPcIZCEQ/C1QGbQsFh5q+jIZhX9eghvuP3+XbEKl6D7PhxYxHGTHld6xnXQL6zotT9GyPzKZVXCgLfPas+Eqjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YCkl92Jc2z4f3kFv;
	Wed, 18 Dec 2024 14:47:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C8A791A0196;
	Wed, 18 Dec 2024 14:48:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP1 (Coremail) with SMTP id cCh0CgA33a4mcGJnxKU7Ew--.4083S5;
	Wed, 18 Dec 2024 14:48:08 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v4 3/5] Xarray: distinguish large entries correctly in xas_split_alloc()
Date: Wed, 18 Dec 2024 23:46:11 +0800
Message-Id: <20241218154613.58754-4-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgA33a4mcGJnxKU7Ew--.4083S5
X-Coremail-Antispam: 1UD129KBjvdXoW7GF1rGr4kJF1DCr4DJw1fZwb_yoWDurg_ur
	4FgF4kZr45GF4kXwnxCF4rt340kFn0kF9ruFWUJr9xW34UJrsrtr1kWrsrXa4rAFyjyFy7
	AFs5Jry093yUKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbDAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
	xGYIkIc2x26280x7IE14v26r1rM28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kI
	II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7
	xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxV
	WUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jvUDXU
	UUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

We don't support large entries which expand two more level xa_node in
split. For case "xas->xa_shift + 2 * XA_CHUNK_SHIFT == order", we also
need two level of xa_node to expand. Distinguish entry as large entry in
case "xas->xa_shift + 2 * XA_CHUNK_SHIFT == order".

As max order of folio in pagecache (MAX_PAGECACHE_ORDER) is <=
(XA_CHUNK_SHIFT * 2 - 1), this change is more likely a cleanup...

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 lib/xarray.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index d0732c5b8403..3fac3f2cea9d 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1022,7 +1022,7 @@ void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int order,
 	unsigned int mask = xas->xa_sibs;
 
 	/* XXX: no support for splitting really large entries yet */
-	if (WARN_ON(xas->xa_shift + 2 * XA_CHUNK_SHIFT < order))
+	if (WARN_ON(xas->xa_shift + 2 * XA_CHUNK_SHIFT <= order))
 		goto nomem;
 	if (xas->xa_shift + XA_CHUNK_SHIFT > order)
 		return;
-- 
2.30.0


