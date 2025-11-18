Return-Path: <linux-fsdevel+bounces-68910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A746C68327
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 09:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 790B24E425B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 08:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E533D30DEBC;
	Tue, 18 Nov 2025 08:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dwUzS+cq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3BE28853E;
	Tue, 18 Nov 2025 08:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763454399; cv=none; b=koSe+cYxdIcgs6+WKFMY/+gmMejKpE0n+MLizJ1A0TSSured3fSM5HMtm9VIteNQ6KwyGJuewN/UsTxtKm+JtYENLrOALIvcmsBcevLLj/ThjaMG49/7Ds7QEE/2SdUb3VJkgj/Q6l0Bi3QdxgZI0dw9GzZobP5GIicpWK0i9ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763454399; c=relaxed/simple;
	bh=LrHdiqncaiGkqgbMxf7vpgk5u6IgsktQ7bpm8tDO5hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cC6I9yw07LLctiM+OZJu1DgGnK4Mtu3DE+owJ9ZgdadrLbR8VVpE9adm4WUdwPuvJoRXAIwqZuAuTy64Guiu1xLCOTQmbg+6MgaWXYU6q4hI2eQUrusj+jD4FjpMe1HyhvBjwnafpZcrNiGsqTYt8DC5L0sJo19XsYOnuzO5guo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dwUzS+cq; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=i0
	pTdxSxY6ivc8rRFGVjO1a7BjENNltMxXKjdwWAtSg=; b=dwUzS+cqx1GiOABNLc
	VlpVv7mxaoEicOgoOrbKowzZoZRIGpzLEXkVCqPD0zl58YfN4e1rYno9M13EFdWy
	ugAPbTbBlQHtJrPJwyqf5PbFrtRbOvZZGNebp2Zao8ZrMg4Tzl2YJ0Tr8aNi7uw6
	xHA19t+XR7yM+YZCGraVVPR6Q=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAnu_KILRxpyC6zEQ--.29019S6;
	Tue, 18 Nov 2025 16:25:45 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [RFC PATCH 4/7] exfat: improve exfat_count_num_clusters
Date: Tue, 18 Nov 2025 16:22:05 +0800
Message-ID: <20251118082208.1034186-5-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118082208.1034186-1-chizhiling@163.com>
References: <20251118082208.1034186-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAnu_KILRxpyC6zEQ--.29019S6
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw4UAryfAw48WF4fGryxGrg_yoWDuFbEkF
	1IvryDWr4jyF1Syr1vy3yakFy2qa1xC34qvrW2yFyqg3srJ3y7XFyUJFy7Cw42krs3Jr98
	JrZ3Jrn3G3W0yjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUb9mR5UUUUU==
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbBcxEKnWkcJZTfwgABst

From: Chi Zhiling <chizhiling@kylinos.cn>

Since exfat_ent_get support cache buffer head, let's apply it to
exfat_count_num_clusters.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/fatent.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index a3a19c8d2e05..08f9a817af28 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -486,6 +486,7 @@ int exfat_count_num_clusters(struct super_block *sb,
 	unsigned int i, count;
 	unsigned int clu;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct buffer_head *bh = NULL;
 
 	if (!p_chain->dir || p_chain->dir == EXFAT_EOF_CLUSTER) {
 		*ret_count = 0;
@@ -501,12 +502,13 @@ int exfat_count_num_clusters(struct super_block *sb,
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


