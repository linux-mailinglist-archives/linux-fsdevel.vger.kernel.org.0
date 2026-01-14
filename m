Return-Path: <linux-fsdevel+bounces-73684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0176DD1EAE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 13:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88E7F3068BC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 12:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865F9396D36;
	Wed, 14 Jan 2026 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="E83Cd5eC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A15396D03;
	Wed, 14 Jan 2026 12:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768392823; cv=none; b=GUwpRQAmIxx/tRBp468EKOvf8qmBQK/LojGbWRxtIopcAq3NXHvrxZrSk/Zu7LsRzOp/sthkV9ZtrYoby+yPL2z59QqcSge8y/P9bCsORBTIx4uW54FU4wakVasyzUa7GtpGi0jYR9aI7KJ8YHtswcra4lSZ56M4IRtzhKYpWXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768392823; c=relaxed/simple;
	bh=vXzeN87ZPW40M96npQ9uC2SA7mDPJUHl1+tWE7gw+NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnM96g2jLp7VTpQzWPMb1pUsxbaIiDbcQKTsuO97XNFphFZl2NhhcvCHs5Ie8ZGY4r4BJR0yF2Y2TeOFDP/KhgWRZQHDDcERkFujNhpEiRSUPy3TNdjKYrwmrwN6u2+6lYRumTXT74sp6Zw8ynor4amyfRc3XnrIn9tC/aPWHBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=E83Cd5eC; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=/q
	6tTTqoj7s86leMp+s+1zFKx0nK5ToPirbKiCDB7lA=; b=E83Cd5eC5vKKFH5tC6
	945ZRdjnxoHUktlWbJ5Bg2zuAwqTN6qOznCEiBv6GhwkQHSdRUAjggIE+rs0Yar7
	0ISQqirOlOzhm/43ViRpJI9ScMF6cXYFR3UxmOIRWegOUDFcCxdn1SagIrv42QVY
	4oR8FGebv5oVNr2Nq314ta+y0=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAXybtbiGdpFdouGQ--.5056S4;
	Wed, 14 Jan 2026 20:13:18 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v3 02/13] exfat: support reuse buffer head for exfat_ent_get
Date: Wed, 14 Jan 2026 20:12:38 +0800
Message-ID: <20260114121250.615064-3-chizhiling@163.com>
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
X-CM-TRANSID:_____wAXybtbiGdpFdouGQ--.5056S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFW7WFykJr45WF4fCw4Durg_yoWrCFWrpF
	4DKa95JrW8t3W7uwnrtrs7Z3WS93yxWFykGa15A3Z0yryDtrn5ur17tryayFWrA3y8C3Wa
	kF1jgF1Uu3sxWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jDEf5UUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+B5tC2lniF5ykwAA35

From: Chi Zhiling <chizhiling@kylinos.cn>

This patch is part 2 of cached buffer head for exfat_ent_get,
it introduces an argument for exfat_ent_get, and make sure this
routine releases buffer head refcount when any error return.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
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


