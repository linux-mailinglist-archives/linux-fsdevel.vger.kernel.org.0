Return-Path: <linux-fsdevel+bounces-72108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3535CDE906
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 10:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEF93304C15E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 09:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE1D3161B1;
	Fri, 26 Dec 2025 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HPUT9OYH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A2F31328B;
	Fri, 26 Dec 2025 09:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766742343; cv=none; b=LJGF6fnAfWHpRTbd35hEfWjGhGTzsOdVOU7h9tnoulhmliWiYj/vIABa46VyNQy+rAs02MBpstHeCPrtI/tZ9SR3RejB5K2JOCE94bJ43CDJQIYyGthlLW0KOYpTAJZXLyXCKpjbdoZnrXiuBnLovnxutt99koUsJTuddQZQk3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766742343; c=relaxed/simple;
	bh=QV3tmKsVrQB7Eux4rAx18e/5Tsm/yQOndaXeLh4Utr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oV6FdbhuTUzOsaWCtXOObob97SONnCDo26CHBCFgoio4Ge4+UMkM4Y9D8TgN8NSz9kavMY9zhA2OGnSCwjwuZa10MJgDt51L/rLnx6DakyAm3BLh6/GR8w7mvUAQBwDJcz3xZv6JdPlMgfrAyJZaNuNiLqSUbL4LPK9SZ/r7H9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HPUT9OYH; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=EB
	aNGS1nr6TdvpG1M4Ssyj0BII1bSbsHnPJMwETv0k0=; b=HPUT9OYHNiVpnPTy2+
	pslvldUSba7jokGwmLsjkIQE/UUeZoGpxqrCKRtimFWz+11tVOhR79SFPIWuY+J8
	SGF9+FSIyFry9OBw5qb7/4A+QAuPUe5p76Bel+i3Cm/bHXs9dxPng9ovesfqlyjh
	+a9tTTNb4DNZZPdZbK3eoY+V4=
Received: from chi-Redmi-Book.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCnlXIPWU5p9JFCJA--.53S6;
	Fri, 26 Dec 2025 17:44:52 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v1 4/9] exfat: improve exfat_count_num_clusters
Date: Fri, 26 Dec 2025 17:44:35 +0800
Message-ID: <20251226094440.455563-5-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251226094440.455563-1-chizhiling@163.com>
References: <20251226094440.455563-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCnlXIPWU5p9JFCJA--.53S6
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw4UAryfAw48WF4fGryxGrg_yoWDuFb_CF
	1IvryDWr4jyF1Syr1vk3yakFy2qa1xCryqvrW2yFyDW34DJrW7XFWUXFy7CwsFkrsxJr98
	JrZ3Arn3Ga10yjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbvtC3UUUUU==
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3BRJ5mlOWRS7wAAA32

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


