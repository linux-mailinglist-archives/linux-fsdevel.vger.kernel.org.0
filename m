Return-Path: <linux-fsdevel+bounces-72789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D750D01EF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 10:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A89037E80E4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 08:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F62B37F74D;
	Thu,  8 Jan 2026 07:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EVr48/JV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40C637E2E2;
	Thu,  8 Jan 2026 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767858650; cv=none; b=oBehjqCj6c9V4E17PNftL1sa8Inyrkz/gK+fOtpe07XkZepjwtOurxupCMiY/fJn3Sru8sONg6Lk0tkIVcDpDc927wv95DoWnZEQ8ku6jorn62vSZIxOyfLaNrYAPrGSFqu379Im3nQ3FbnJhwrZUb6NgeXWocQaWRvrHtFeqT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767858650; c=relaxed/simple;
	bh=QV3tmKsVrQB7Eux4rAx18e/5Tsm/yQOndaXeLh4Utr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDlqmoemH6IcFbUKj534LSpZ7AH1TxewcJEq2FnBOiI4JD9ms9SYNFooiLQuriheE4glhYpCcEgKItp/R/ftOWPQHmKifdzGxVq29lMivzmWFZZ7KdqbCkuoeUUsfewZ5eDl3vAn3ivU/llHAsnLrp7M1c96PrP6ZTLnxj0jAZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EVr48/JV; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=EB
	aNGS1nr6TdvpG1M4Ssyj0BII1bSbsHnPJMwETv0k0=; b=EVr48/JVj16UKpUtki
	NBax2DP+4vz5AtoE3mNKQeMkPEUBdivTJIt+Hp+2tDyM/2U9+ZCT+/fE1AfMALaA
	n7Qy5B/+BFGmW/QmPAomZADHSJ8LbI8mzhpYGswt0SQ9C8rr2/MEFdEFx7j34Ks0
	XIt3y2Xr5WQPx+OeLDpCN87LA=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBH6+WpYV9pdSx_Eg--.889S5;
	Thu, 08 Jan 2026 15:50:06 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v2 03/13] exfat: improve exfat_count_num_clusters
Date: Thu,  8 Jan 2026 15:49:19 +0800
Message-ID: <20260108074929.356683-4-chizhiling@163.com>
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
X-CM-TRANSID:_____wBH6+WpYV9pdSx_Eg--.889S5
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw4UAryfAw48WF4fGryxGrg_yoWDuFb_CF
	1IvryDWr4jyF1Syr1vk3yakFy2qa1xCryqvrW2yFyDW34DJrW7XFWUXFy7CwsFkrsxJr98
	JrZ3Arn3Ga10yjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0l_M7UUUUU==
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3A61U2lfYa4AqQAA3k

From: Chi Zhiling <chizhiling@kylinos.cn>

Since exfat_ent_get support cache buffer head, let's apply it to
exfat_count_num_clusters.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
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


