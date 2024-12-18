Return-Path: <linux-fsdevel+bounces-37705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EB29F5ECB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 07:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31ACB1884719
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 06:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958571552FD;
	Wed, 18 Dec 2024 06:48:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFE6154435;
	Wed, 18 Dec 2024 06:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734504494; cv=none; b=R3KQAIFGYSnNnob9pzr2+x/YlvkL/eUQVzINI2XT+o8bwhmNNtKPARLzNjYEiH26mJcEKgy+fvgOCluSt9ukNO3Bz6vsNcD/olmzQojardJ/gQdMprmj6GTq6T26MOLehsWGKKBRWSMIpuQ9Ty/m4xuhR7ZRAl7n+ZOiiCinN8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734504494; c=relaxed/simple;
	bh=XtlA+Aq0rbUEYLB0kd7+wNs8u/7jCZVEWBvDzDhooDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ima338SUijosbfSW6xUS6KDu7nYi3PPNSdF6ruyx6A//dEDlEjcUIYbzVtaWrmIfwpkKmfxot3oaNy1TAKvRD3MEimF8YNqnOzqPt3igDwnq6OL/DlDME8eX9zeEcExFQVO1DLOQ75cHtWlmQJQ0NfqemXFgxqkg/oL8FbMaeC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YCklG55tFz4f3jq4;
	Wed, 18 Dec 2024 14:47:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2A7011A0196;
	Wed, 18 Dec 2024 14:48:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP1 (Coremail) with SMTP id cCh0CgA33a4mcGJnxKU7Ew--.4083S6;
	Wed, 18 Dec 2024 14:48:08 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v4 4/5] Xarray: remove repeat check in xas_squash_marks()
Date: Wed, 18 Dec 2024 23:46:12 +0800
Message-Id: <20241218154613.58754-5-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgA33a4mcGJnxKU7Ew--.4083S6
X-Coremail-Antispam: 1UD129KBjvdXoWrtFWxKF1Dtr4kXFy7Xw4kCrg_yoWxtwb_Za
	10yr1vyr1UCrn7XwsIkFs8tryjkryvqF9rKFW8Ja43ur10qry5WF4vqr15Aa4kZw4ayFy7
	JF45Zr1Y9r15GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbqkYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
	xGYIkIc2x26280x7IE14v26r126s0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC
	64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM2
	8EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq
	3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7
	AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07ja
	g4hUUUUU=
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


