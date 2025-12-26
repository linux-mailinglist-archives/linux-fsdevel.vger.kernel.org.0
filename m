Return-Path: <linux-fsdevel+bounces-72106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C46CDE8EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 10:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17436301CC58
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 09:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229073195FB;
	Fri, 26 Dec 2025 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="K6ke+9RX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ECE314D3F;
	Fri, 26 Dec 2025 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766742342; cv=none; b=K55M2hdQlQfa4TSByhEL8Alh6J4DZ8geoqk0sbePeYT89FVgSPgSrGkDoHrwLCcHPSkjoyQ1ZatcTR091qCfFTFgS0lQGHtCgqvD7FtLpd7XhxV/XAXhRWqoKZ/Neu0C+SkWq3foVEfXK/pfhG5L6+ZWt+i2JK4X7lPNKtIrZ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766742342; c=relaxed/simple;
	bh=1B+lE2U3eAYn+bEmF8/XAwLuFOqS0i95Q+IJTMt1yXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auUrRwQK7RqkTzbUwWen1Z+PrZe/Ph02YRDainikBy5lTDYWe5bexVsMArKXwKaCurm6BlhncxaEjxdvzSL7qkFjVdgHhFggVv1euTNMxeqdEzsZdibE8t6NycKkC6O8/8haI1ZvDwwjJlMTjn0B17ASwdgEAyXGogBQGJaLPaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=K6ke+9RX; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=W8
	Dd4uKOqtugp8rh1JHuRfCfqK66RWhGo/RX+lV/P7o=; b=K6ke+9RXPEhzKJ0ZKT
	F/ES+xKMBXJND7+H1ZbLp2dEsxnDii/nhb/vN/OpriUw0dgU5p/+SlyhnzpreoRU
	6W/cqjMYTX1yCTWY/zl12XNe6OusmtouZUOh1QqwBKwRA4BePrLNYVyZLctpsKTg
	X+Htz/A731LO+I7BFlMu2VhFM=
Received: from chi-Redmi-Book.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCnlXIPWU5p9JFCJA--.53S4;
	Fri, 26 Dec 2025 17:44:51 +0800 (CST)
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
Subject: [PATCH v1 2/9] exfat: support reuse buffer head for exfat_ent_get
Date: Fri, 26 Dec 2025 17:44:33 +0800
Message-ID: <20251226094440.455563-3-chizhiling@163.com>
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
X-CM-TRANSID:QCgvCgCnlXIPWU5p9JFCJA--.53S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFW7WFykJr45AF1DZw1DZFb_yoWrCrykpF
	4DKas5JrWUt3W7uwnrtr4kZ3WS93yxWFykGa15A3Z0yryDtrn5ur17tryayFWrA3y8C3Wa
	kF1jgF1Uur9xWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j72-5UUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+BNI5WlOWROBQAAA3q

From: Chi Zhiling <chizhiling@kylinos.cn>

This patch is part 2 of cached buffer head for exfat_ent_get,
it introduces an argument for exfat_ent_get, and make sure this
routine releases buffer head refcount when any error return.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/cache.c    |  2 +-
 fs/exfat/exfat_fs.h |  4 ++--
 fs/exfat/fatent.c   | 39 ++++++++++++++++++++++++---------------
 3 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/fs/exfat/cache.c b/fs/exfat/cache.c
index d5ce0ae660ba..61af3fa05ab7 100644
--- a/fs/exfat/cache.c
+++ b/fs/exfat/cache.c
@@ -287,7 +287,7 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
 			return -EIO;
 		}
 
-		if (exfat_ent_get(sb, *dclus, &content))
+		if (exfat_ent_get(sb, *dclus, &content, NULL))
 			return -EIO;
 
 		*last_dclus = *dclus;
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 176fef62574c..f7f25e0600c7 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -432,13 +432,13 @@ int exfat_set_volume_dirty(struct super_block *sb);
 int exfat_clear_volume_dirty(struct super_block *sb);
 
 /* fatent.c */
-#define exfat_get_next_cluster(sb, pclu) exfat_ent_get(sb, *(pclu), pclu)
+#define exfat_get_next_cluster(sb, pclu) exfat_ent_get(sb, *(pclu), pclu, NULL)
 
 int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
 		struct exfat_chain *p_chain, bool sync_bmap);
 int exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain);
 int exfat_ent_get(struct super_block *sb, unsigned int loc,
-		unsigned int *content);
+		unsigned int *content, struct buffer_head **last);
 int exfat_ent_set(struct super_block *sb, unsigned int loc,
 		unsigned int content);
 int exfat_chain_cont_cluster(struct super_block *sb, unsigned int chain,
diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index 0cfbc0b435bd..679688cfea01 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -88,49 +88,58 @@ int exfat_ent_set(struct super_block *sb, unsigned int loc,
 	return 0;
 }
 
+/*
+ * Caller must release the buffer_head if no error return.
+ */
 int exfat_ent_get(struct super_block *sb, unsigned int loc,
-		unsigned int *content)
+		unsigned int *content, struct buffer_head **last)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	int err;
 
 	if (!is_valid_cluster(sbi, loc)) {
 		exfat_fs_error_ratelimit(sb,
 			"invalid access to FAT (entry 0x%08x)",
 			loc);
-		return -EIO;
+		goto err;
 	}
 
-	err = __exfat_ent_get(sb, loc, content, NULL);
-	if (err) {
+	if (unlikely(__exfat_ent_get(sb, loc, content, last))) {
 		exfat_fs_error_ratelimit(sb,
-			"failed to access to FAT (entry 0x%08x, err:%d)",
-			loc, err);
-		return err;
+			"failed to access to FAT (entry 0x%08x)",
+			loc);
+		goto err;
 	}
 
-	if (*content == EXFAT_FREE_CLUSTER) {
+	if (unlikely(*content == EXFAT_FREE_CLUSTER)) {
 		exfat_fs_error_ratelimit(sb,
 			"invalid access to FAT free cluster (entry 0x%08x)",
 			loc);
-		return -EIO;
+		goto err;
 	}
 
-	if (*content == EXFAT_BAD_CLUSTER) {
+	if (unlikely(*content == EXFAT_BAD_CLUSTER)) {
 		exfat_fs_error_ratelimit(sb,
 			"invalid access to FAT bad cluster (entry 0x%08x)",
 			loc);
-		return -EIO;
+		goto err;
 	}
 
 	if (*content != EXFAT_EOF_CLUSTER && !is_valid_cluster(sbi, *content)) {
 		exfat_fs_error_ratelimit(sb,
 			"invalid access to FAT (entry 0x%08x) bogus content (0x%08x)",
 			loc, *content);
-		return -EIO;
+		goto err;
 	}
 
 	return 0;
+err:
+	if (last) {
+		brelse(*last);
+
+		/* Avoid double release */
+		*last = NULL;
+	}
+	return -EIO;
 }
 
 int exfat_chain_cont_cluster(struct super_block *sb, unsigned int chain,
@@ -299,7 +308,7 @@ int exfat_find_last_cluster(struct super_block *sb, struct exfat_chain *p_chain,
 	do {
 		count++;
 		clu = next;
-		if (exfat_ent_get(sb, clu, &next))
+		if (exfat_ent_get(sb, clu, &next, NULL))
 			return -EIO;
 	} while (next != EXFAT_EOF_CLUSTER && count <= p_chain->size);
 
@@ -490,7 +499,7 @@ int exfat_count_num_clusters(struct super_block *sb,
 	count = 0;
 	for (i = EXFAT_FIRST_CLUSTER; i < sbi->num_clusters; i++) {
 		count++;
-		if (exfat_ent_get(sb, clu, &clu))
+		if (exfat_ent_get(sb, clu, &clu, NULL))
 			return -EIO;
 		if (clu == EXFAT_EOF_CLUSTER)
 			break;
-- 
2.43.0


