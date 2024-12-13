Return-Path: <linux-fsdevel+bounces-37260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ECC9F0310
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 04:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33791696D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 03:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399F5156F3C;
	Fri, 13 Dec 2024 03:27:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15B782866;
	Fri, 13 Dec 2024 03:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734060435; cv=none; b=N/KTwMYojCGFcSB3gM79A7iwCKv+aZEfiEcuzXEXNRvVm6xrhRJMRSvGOc0aUYwekQbh23fhjyGtVh9/febFE0IP3hAyRdEL2ShgvE1WCCVnLOCN3TrcfLfOoA2Hrl4mfaDYbhcPoZLnWPldEg5VdBluiIFIGDWpsmde4waHq2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734060435; c=relaxed/simple;
	bh=XtlA+Aq0rbUEYLB0kd7+wNs8u/7jCZVEWBvDzDhooDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MYiUeouEXn3SULg+7mAM78FgezIYX9AsEEZHpz52JTbiTLqE+3yRKJV8Kfm7g8YWJCvEUTK8xfudNDHgBCUZnRjdN2SJbzQ/71mdqS4VynuS93TZ/YaCzBE5rZw8Q2cbLSdyGlvLyzY5WrEFK8ubYm39Q0i4Hi8IT4j7fs82sCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Y8ZWb40pTz4f3jrm;
	Fri, 13 Dec 2024 11:26:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DB27C1A0359;
	Fri, 13 Dec 2024 11:27:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgBHcISMqVtnfJ3KEQ--.55430S6;
	Fri, 13 Dec 2024 11:27:10 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 4/5] Xarray: remove repeat check in xas_squash_marks()
Date: Fri, 13 Dec 2024 20:25:22 +0800
Message-Id: <20241213122523.12764-5-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241213122523.12764-1-shikemeng@huaweicloud.com>
References: <20241213122523.12764-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHcISMqVtnfJ3KEQ--.55430S6
X-Coremail-Antispam: 1UD129KBjvdXoWrtFWxKF1Dtr4kXFy7Xw4kCrg_yoWxtwb_Za
	10yr1vyr1UCrn7XwsIkFs8tryjkryvqF9rKFW8Ja43ur10qry5WF4vqr15Aa4kZw4ayFy7
	JF45Zr1Y9r15GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbqxYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
	xGYIkIc2x26280x7IE14v26r126s0DM28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC
	64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM2
	8EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0D
	M28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14
	v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUnVw
	Z3UUUUU==
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


