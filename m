Return-Path: <linux-fsdevel+bounces-72102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FE8CDE8F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 10:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39C083029233
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 09:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A01316907;
	Fri, 26 Dec 2025 09:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="k4dvT9tj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ADA1DFDA1;
	Fri, 26 Dec 2025 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766742340; cv=none; b=gumLCSEjZnGZ4RTQPN6fCRG9QMz2uyxPwtaR538ytICV82x10s2qVgGJxsLaTm08a44MrofbkuubqOEm2wg9QsZiBYctBtiUE/ZIDmP41QDy8SniWEJsvrEizwO0HLG0bMIc/VaSfWZLUJTBvn5ygqNQMXmuCBq9jd6ZZZA4JOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766742340; c=relaxed/simple;
	bh=74LmjYwnmMRYJeOzGKk4SXKJbvlpLqWqPXWpNTKPxQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFUljxx1yysxRoRhY3CywJdgr3vhiAsqhCqfYPn5MYOw4OexHkt5EaEzd/Cmxr5tVXMI7y4S6ECBkOjx6z2s/2kGPOtvMeNGC6UktGrj6l+tyNGrgffTRaMtYpvlHDvecIL6vhf4ckxEqp9qQR8np30j4ZPlSKgsVDpUe+B42mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=k4dvT9tj; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=hZ
	X2IgCzqm8k95ZX1haEGmr3IocE/hgTRQBbaXgIu2o=; b=k4dvT9tj3xdR5rEiRS
	G+y4TPyB4UqyheMKdTrXBMt8PUK+T4cKJuTqPtudrtrnoiI9B8lO0+1A4N79dDRd
	3z5+Xw+LxFOpvtsSH3ozIPyGQNDUZ5CBjeSCQcV1PnY6HP5Xf4NHEX9vYd6Tdsvq
	1FzoJy8coXQCJxW5qML1VyqIo=
Received: from chi-Redmi-Book.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCnlXIPWU5p9JFCJA--.53S7;
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
Subject: [PATCH v1 5/9] exfat: improve exfat_find_last_cluster
Date: Fri, 26 Dec 2025 17:44:36 +0800
Message-ID: <20251226094440.455563-6-chizhiling@163.com>
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
X-CM-TRANSID:QCgvCgCnlXIPWU5p9JFCJA--.53S7
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw4UAryfCr15ZFy8Cw1xKrg_yoWkZFc_uw
	1xKrykWryYyrWSyr1DC3yayFWSya1kZ3yxury7tr9Fq3s8J39rZF4DXF9rCr4jkr1kAF95
	Jr95Ar93Ga48ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbveHPUUUUU==
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9xRJ5mlOWRSHHgAA3-

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


