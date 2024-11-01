Return-Path: <linux-fsdevel+bounces-33431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A23AF9B8B70
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 07:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EC451F2311B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 06:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58959156F55;
	Fri,  1 Nov 2024 06:51:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E131531C2;
	Fri,  1 Nov 2024 06:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730443882; cv=none; b=myn/WxXj5tJCg3fe+e5m3ZR9OJnBihPm0GZjNi6l3Qyf7xQqfZEASVYLdXZyWVrwIxZleSY73QPfRbrQMWdgfwTpfswXC1/rSCwz2xyIXLK2vpfBE6nZoz1BvF3quu+fnRrDJzNbkQwqOUjOucaITVB1M7HjYh4wTYRrRIWKWzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730443882; c=relaxed/simple;
	bh=Un+aOYer2H0EjCL7FIwb3OBpemTJ7mwcK/NY6x1Qrwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mOxH0DYp2yfAgEna2KwWXxcpGGwPLJsJEJ6Kc6ftn3YPaC+QHlc5t74r3l2Rao8vC7UbgyM55oZs61uIf0hm5+D+ARj/g8t6/K5iTtVp/gSYcCsG29TIf4CFDMh/oIxqLgTGDgHLhYSM5Bs3y7oqxMo7n8ff9QCANCjAkI5GqpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xfs2T6Hpzz4f3jtT;
	Fri,  1 Nov 2024 14:50:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 8AFF11A0568;
	Fri,  1 Nov 2024 14:51:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP3 (Coremail) with SMTP id _Ch0CgAHmcVceiRnzhcPAg--.62749S4;
	Fri, 01 Nov 2024 14:51:10 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/6] Xarray: distinguish large entries correctly in xas_split_alloc()
Date: Fri,  1 Nov 2024 23:50:24 +0800
Message-Id: <20241101155028.11702-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241101155028.11702-1-shikemeng@huaweicloud.com>
References: <20241101155028.11702-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHmcVceiRnzhcPAg--.62749S4
X-Coremail-Antispam: 1UD129KBjvdXoW7GF1rGr4kJF1DCr4DJw1fZwb_yoWfZFc_ur
	1FqF4kZrW5CFs7WwnxCFsYy34FkFs0kF9ruFW8JF9xW34UJwsrZw1kWrZrWa4rAFyqyFy7
	CFs5Jry093yjyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
	xGYIkIc2x26280x7IE14v26r15M28IrcIa0xkI8VCY1x0267AKxVWUCVW8JwA2ocxC64kI
	II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7
	xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j-BMNUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

We don't support large entries which expand two more level xa_node in
split. For case "xas->xa_shift + 2 * XA_CHUNK_SHIFT == order", we also
need two level of xa_node to expand. Distinguish entry as large entry in
case "xas->xa_shift + 2 * XA_CHUNK_SHIFT == order".

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 lib/xarray.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index fa87949719a0..b9fd321a02ad 100644
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


