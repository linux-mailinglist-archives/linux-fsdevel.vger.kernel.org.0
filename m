Return-Path: <linux-fsdevel+bounces-72793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4A9D01A89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 09:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4586C3020492
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 08:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B9D37E31F;
	Thu,  8 Jan 2026 07:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BHPVjdb3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D2037C11B;
	Thu,  8 Jan 2026 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767858653; cv=none; b=buQ4nQFiyLkfM8dvctzrr5klypv9vpASeeROEdkPmznODE9WZBmT7k24zGoT/Dh54kd1I5tAVHL6IvVTYspjsQ+q48vfdjOV6CdBdodZzajM2FqPywwDjSEMy/sZCSlwPFPD4bIUupzEzhmUQVcCP2hlmaXAWy/sdTJ05/Ihtdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767858653; c=relaxed/simple;
	bh=zHjGsPyySRkAz260yLO7EcReptiygu1HIzJrpqNbqJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+NbHAou2FXNIY5bdU4meW5EEg4qHteq4tfYcWAWSvj2CmlSshVUKw6h+IFSWA5gE426UToVe7i9K3dRW0chV5YrLOw1HyemIQZkHmHuQHMq1bXwACDp9LSgBz60BjwJb5jhaV3GBbwSe5K0f2bDydDwdcFcKyqaQnnTZCNQP3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BHPVjdb3; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=yB
	dJnu8/sUDFI9XiLPV9fEsqpR4d1yNK8IYandtVTlY=; b=BHPVjdb3NXJ5NITMRj
	LCqxtjz/nkcF3+5pKypoi11xHKzn7vG114pLSD/20zzmrI2QfarYH9ZR/vQyu/b9
	6pAywGOlOdPO++cpL237IaYEEBY8Gi17h8us8en+J+m9jadec647htbOKrHoQcZ3
	AgkwXTCnfX9v2/JRt7aYwe6YM=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBH6+WpYV9pdSx_Eg--.889S8;
	Thu, 08 Jan 2026 15:50:07 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v2 06/13] exfat: remove the unreachable warning for cache miss cases
Date: Thu,  8 Jan 2026 15:49:22 +0800
Message-ID: <20260108074929.356683-7-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108074929.356683-1-chizhiling@163.com>
References: <20260108074929.356683-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBH6+WpYV9pdSx_Eg--.889S8
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFyUAw1rZr4kKFyxZry7Wrg_yoWkGFX_ua
	40yFy8WFWa9w18tr4kta1a9ryYvw48Cr1Yyw1fArySq347Gr4Dt3ZrJa429r4UKr4xKF98
	JrWFyFn3A3W09jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0eOJUUUUUU==
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC2w+1U2lfYa8AqwAA3h

From: Chi Zhiling <chizhiling@kylinos.cn>

The cache_id remains unchanged on a cache miss; its value is always
exactly what was set by cache_init. Therefore, checking this value
again is meaningless.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/cache.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/fs/exfat/cache.c b/fs/exfat/cache.c
index 0ee4bff1cb35..d51737498ee4 100644
--- a/fs/exfat/cache.c
+++ b/fs/exfat/cache.c
@@ -260,18 +260,7 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
 		return 0;
 
 	cache_init(&cid, EXFAT_EOF_CLUSTER, EXFAT_EOF_CLUSTER);
-
-	if (exfat_cache_lookup(inode, cluster, &cid, fclus, dclus) ==
-			EXFAT_EOF_CLUSTER) {
-		/*
-		 * dummy, always not contiguous
-		 * This is reinitialized by cache_init(), later.
-		 */
-		WARN_ON(cid.id != EXFAT_CACHE_VALID ||
-			cid.fcluster != EXFAT_EOF_CLUSTER ||
-			cid.dcluster != EXFAT_EOF_CLUSTER ||
-			cid.nr_contig != 0);
-	}
+	exfat_cache_lookup(inode, cluster, &cid, fclus, dclus);
 
 	if (*fclus == cluster)
 		return 0;
-- 
2.43.0


