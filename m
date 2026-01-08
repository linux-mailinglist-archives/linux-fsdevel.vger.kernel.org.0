Return-Path: <linux-fsdevel+bounces-72796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3AFD01FAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 10:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF7B0345AECE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 08:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ACA389DFE;
	Thu,  8 Jan 2026 07:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iP3gChfb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C220E37C11E;
	Thu,  8 Jan 2026 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767858670; cv=none; b=fNFvJLDZI0ngTwLE/bVjKvx4hX0PZRrfpy2+dSvXKNxPotIcDLOlOKLGtXyrD6treNPJ5tzkAz82K/juwdSso5ZPn6MG9/A3mUl++tbTiZl/5sRkCFUTR/Z6uYLFKqYEYDEtQLfbJ3WAz8J5akr14HLnId1w/ZbXPskVPJELI2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767858670; c=relaxed/simple;
	bh=74LmjYwnmMRYJeOzGKk4SXKJbvlpLqWqPXWpNTKPxQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pyiOu0TiM8lwEsCmMCmdVDAxruJokEMEz4txaDsK2aEFGdrgs/uHofuoEG+RZER+0KVVY0zNGXDrCyM/J3ejUwk+I3cCOxq7mGhEcZXh8jla5hvKvhGP/t6UTRWaWssvfYmpGIAuel1KCHlknSyB3H7BI5fJhgtR9N+r0gO5BSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iP3gChfb; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=hZ
	X2IgCzqm8k95ZX1haEGmr3IocE/hgTRQBbaXgIu2o=; b=iP3gChfbb02HsEeDoM
	fJdyRGhiOpnitKnYvBhOx7FSFVjLfdHOm2bb3i2WdfQDpORWwx6znjNMGu2/E0cx
	bEH2vCq9/x5pr+5HOYxTWstFVVniijT6z9bopB8jRmRB7C352gDcYrwTXM2GhrAS
	OBvHjEP+WSMgfkULRAS1PyBn0=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBH6+WpYV9pdSx_Eg--.889S6;
	Thu, 08 Jan 2026 15:50:06 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v2 04/13] exfat: improve exfat_find_last_cluster
Date: Thu,  8 Jan 2026 15:49:20 +0800
Message-ID: <20260108074929.356683-5-chizhiling@163.com>
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
X-CM-TRANSID:_____wBH6+WpYV9pdSx_Eg--.889S6
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw4UAryfCr15ZFy8Cw1xKrg_yoWkZFc_uw
	1xKrykWryYyrWSyr1DC3yayFWSya1kZ3yxury7tr9Fq3s8J39rZF4DXF9rCr4jkr1kAF95
	Jr95Ar93Ga48ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1E_MDUUUUU==
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3A61U2lfYa4ArQAA3g

From: Chi Zhiling <chizhiling@kylinos.cn>

Since exfat_ent_get support cache buffer head, let's apply it to
exfat_find_last_cluster.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/fatent.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index f060eab2f2f2..71ee16479c43 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -296,6 +296,7 @@ int exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain)
 int exfat_find_last_cluster(struct super_block *sb, struct exfat_chain *p_chain,
 		unsigned int *ret_clu)
 {
+	struct buffer_head *bh = NULL;
 	unsigned int clu, next;
 	unsigned int count = 0;
 
@@ -308,10 +309,11 @@ int exfat_find_last_cluster(struct super_block *sb, struct exfat_chain *p_chain,
 	do {
 		count++;
 		clu = next;
-		if (exfat_ent_get(sb, clu, &next, NULL))
+		if (exfat_ent_get(sb, clu, &next, &bh))
 			return -EIO;
 	} while (next != EXFAT_EOF_CLUSTER && count <= p_chain->size);
 
+	brelse(bh);
 	if (p_chain->size != count) {
 		exfat_fs_error(sb,
 			"bogus directory size (clus : ondisk(%d) != counted(%d))",
-- 
2.43.0


