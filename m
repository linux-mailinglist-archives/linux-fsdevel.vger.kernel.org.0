Return-Path: <linux-fsdevel+bounces-34224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADB19C3EEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 13:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5114428532C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 12:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470C61AB6E2;
	Mon, 11 Nov 2024 12:55:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F9119DF4F;
	Mon, 11 Nov 2024 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731329702; cv=none; b=hXUOz4q45GYVEPbbSAAQhugRwaTAPDKsd5tDsoxMzpnw77/d/c83UxvKUEI0lH3pKMn/olRKxwAakBsJJ/PpZ4xIkoomLcrLQZb6QbeuIg3dPzmhkp3fNWaDKhRiRuoUrQhdv+Z7bxvC5VQhmuEkYwI2fdfiUQuyv09jwTXXLfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731329702; c=relaxed/simple;
	bh=Un+aOYer2H0EjCL7FIwb3OBpemTJ7mwcK/NY6x1Qrwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AQZ//T1/9YkfTzsIQDGwefAHoMMqsrZ/r/czY/GC8ovEnCYTzQlayBLeEXtjlvhete0ZrK+9ZO7jS39ORjwx3GdpBfmqZelworNsWkeJuGIWOVHW/pYxYCfEdjo5vdReKxKShkennXRHF8x/GTLmLeNXF74MrZhHrS/XQwi5Id0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xn8db4W2qz4f3kk5;
	Mon, 11 Nov 2024 20:54:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AF66D1A07B6;
	Mon, 11 Nov 2024 20:54:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgB3n4Oe_jFnllryBQ--.36628S4;
	Mon, 11 Nov 2024 20:54:56 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH RESEND V2 2/5] Xarray: distinguish large entries correctly in xas_split_alloc()
Date: Tue, 12 Nov 2024 05:53:56 +0800
Message-Id: <20241111215359.246937-3-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgB3n4Oe_jFnllryBQ--.36628S4
X-Coremail-Antispam: 1UD129KBjvdXoW7GF1rGr4kJF1DCr4DJw1fZwb_yoWfZFc_ur
	1FqF4kZrW5CFs7WwnxCFsYy34FkFs0kF9ruFW8JF9xW34UJwsrZw1kWrZrWa4rAFyqyFy7
	CFs5Jry093yjyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbDAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
	xGYIkIc2x26280x7IE14v26r15M28IrcIa0xkI8VCY1x0267AKxVWUCVW8JwA2ocxC64kI
	II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7
	xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxV
	WUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jhxhLU
	UUUU=
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


