Return-Path: <linux-fsdevel+bounces-73686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4894AD1EAFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 13:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7BE530B46AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 12:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C797397AC2;
	Wed, 14 Jan 2026 12:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YEbUg+24"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E013815E8;
	Wed, 14 Jan 2026 12:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768392824; cv=none; b=dTNjD6wXOqsuM0+Qq4lq1eWBUPxXvS67hvO1w8RvR2vJA+xRGq3doLoj9fEqay3TqhiIJdCSxGCHlEcZtdnb4Fp9PCK8BoMLVXqSOIV7OdOvBDj13Kj0GciQehkCcdsFVQvD/KxwXDY3Q5Kv3VbR8nZf7OuNg5rd/X9D6z8OyDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768392824; c=relaxed/simple;
	bh=lZ9o5twc++xSajO9MlRYLn+/RHkWGVkj3/AO8HpzkXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QaM1YYr3fsGbXadtrEte0nMLJG3D+KNYJmiAhgWZe1ArbzNbnqsC6IzFGHlkFsSFiRT9zY76+p8E4llpF6r70xdDJth8TiaY8zLI4t2gd2K8QnAmsREVJ5P/C1AKlMGE/H4EtV0UKOFkUgLJlky1z+oGLhXc++ZqE31/dXxtqlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YEbUg+24; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=DL
	+NcNIHLjMqkOTOK0OmVh7vEY80d2pJzl/dTNfgNAs=; b=YEbUg+24uV7pMO3E2W
	7iCjVyZOwasz+Di9Ml2MQCbB1fQFW3e0vRkcQEDZcIDOESIT61lBNqW+CIamAvPG
	SuROdLZUECobKSjtOc0APyhijdDYdiVIUKgp6cwRq01Dn09dKo8C44viyi78Q1o1
	TX36JGAnrLZ6vOd1YNeLtdJoU=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAXybtbiGdpFdouGQ--.5056S5;
	Wed, 14 Jan 2026 20:13:18 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v3 03/13] exfat: improve exfat_count_num_clusters
Date: Wed, 14 Jan 2026 20:12:39 +0800
Message-ID: <20260114121250.615064-4-chizhiling@163.com>
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
X-CM-TRANSID:_____wAXybtbiGdpFdouGQ--.5056S5
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw4UAryfAFWDJr17Jr43ZFb_yoWkGwb_CF
	1IvryDWr4jyF1Syr1vk3yakFy2qa1xCrWqvrW2yFyDW3s8JrW7XFyUXFy7Cws2krsrJr98
	ArZ3Arn3Ga10yjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0l_M7UUUUU==
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9x5tC2lniF56WwAA32

From: Chi Zhiling <chizhiling@kylinos.cn>

Since exfat_ent_get support cache buffer head, let's apply it to
exfat_count_num_clusters.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
---
 fs/exfat/fatent.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index 679688cfea01..f060eab2f2f2 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -484,6 +484,7 @@ int exfat_count_num_clusters(struct super_block *sb,
 	unsigned int i, count;
 	unsigned int clu;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct buffer_head *bh = NULL;
 
 	if (!p_chain->dir || p_chain->dir == EXFAT_EOF_CLUSTER) {
 		*ret_count = 0;
@@ -499,12 +500,13 @@ int exfat_count_num_clusters(struct super_block *sb,
 	count = 0;
 	for (i = EXFAT_FIRST_CLUSTER; i < sbi->num_clusters; i++) {
 		count++;
-		if (exfat_ent_get(sb, clu, &clu, NULL))
+		if (exfat_ent_get(sb, clu, &clu, &bh))
 			return -EIO;
 		if (clu == EXFAT_EOF_CLUSTER)
 			break;
 	}
 
+	brelse(bh);
 	*ret_count = count;
 
 	/*
-- 
2.43.0


