Return-Path: <linux-fsdevel+bounces-73692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A11D1EB3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 13:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EFC830A32F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 12:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403B739900E;
	Wed, 14 Jan 2026 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XZP+JyNF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF05397AA1;
	Wed, 14 Jan 2026 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768392843; cv=none; b=k5tNntGVn6w8WHuaOWPU5IVmIMZHL2MdHOM5RQ6OhvxcuNtiB8Y4TDPEw9VbrUCNNnpapW23p3LjqxnoU3IX3nZmoMdYnVGTarCu7AU5b9wQHgCa02yob7auWhmiGFg4TAdB1tBSdDmwT58QEjoQ9wkMIaQh9ujB9gIxouPpwxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768392843; c=relaxed/simple;
	bh=QOyXc4xe3hljiE5sVG55Bk9d8ZWEcfuxI1ERmTZgumU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqzuWIRyXdVSzbSLI5snwQ2FQ4mD4379C2XUpZnUFO0I02L/2frTGez5qAAZwxlC93FaW8BkaE5Nsq6F4EW+cARVdCsjJmPRd4+lPKZlcA6G+jwHDiPxitSo3OVBLCP5RSNJWbYgC+ttOwg4uj87rMYQi+iS/zpNmo46mmMXMIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XZP+JyNF; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=H1
	PWdIvYYxqZSIKwGYx+IvVqayAKgIUIe9EptT3n8fY=; b=XZP+JyNFZs3A8RV4n8
	3WEBNn9F0iGgGzocv7C+Fgp+punkPPq8AOiV+faNwkgAniN6eNeeM3FyOKtzS1fS
	3XGKrVDyq6N6tSD0bINcb4MlrevVVW5dmVQJ/dCM2aOQWzNTTWwfCklsz0udTSjY
	CsBOJFLHax1eE4I0cu9Hor//g=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAXybtbiGdpFdouGQ--.5056S8;
	Wed, 14 Jan 2026 20:13:19 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v3 06/13] exfat: remove the unreachable warning for cache miss cases
Date: Wed, 14 Jan 2026 20:12:42 +0800
Message-ID: <20260114121250.615064-7-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260114121250.615064-1-chizhiling@163.com>
References: <20260114121250.615064-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXybtbiGdpFdouGQ--.5056S8
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFyUAw1rZr4kKFyxZry7Wrg_yoWkZrc_uF
	y0yFy8WFWa9w48tr4vyanI9ryYva10kF1Yyw1fArySq347Jr4Dt3ZrJa429r47Kr4xKF95
	JFWFyFn3t3W09jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0eOJUUUUUU==
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9wBuDGlniGB6dwAA3+

From: Chi Zhiling <chizhiling@kylinos.cn>

The cache_id remains unchanged on a cache miss; its value is always
exactly what was set by cache_init. Therefore, checking this value
again is meaningless.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
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


