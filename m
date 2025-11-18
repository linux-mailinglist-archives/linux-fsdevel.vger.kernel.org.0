Return-Path: <linux-fsdevel+bounces-68916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA81C68354
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 09:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 547A14F2C5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 08:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2442030DD09;
	Tue, 18 Nov 2025 08:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="H02QeOsm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD3F308F23;
	Tue, 18 Nov 2025 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763454413; cv=none; b=AWy66Bbn2r9wwEiYUngEBJMEnoiR3Cqt75uqQtAW9qiqTS1ovJfMONOJtBBvpz69kfEWOwNJQVFfLxt4pn5Yt8FjdyNE7PSspvjJsSLGr8nDI8vc1RdPyIbuZ/rKm2sz66QOMXPxCikPBY14y6sI7d6/qFRhV7mOk4ggdD5/D8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763454413; c=relaxed/simple;
	bh=9brJRpO1ekzNPHLdh5MFnRxahxgUUYXD/RRKBpc5xTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abkeehkt7MUiGJjdhfMNwIWPjUdeoghdmEknEh1raScx0ZwJri0cKK2KXePDjrkwFFVYFvlcu5ZpbV8+nwf2ALn2IZ+Kjy5NbJKhl4eC2vodqYTCNGn9JNllJLHabXlhN5o381S0uiHjY1RJ88JxgVzxipJUEwi32G7QcjEYH5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=H02QeOsm; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ba
	/0h4T7IHoa/OO1DwEEs6NptrDdaZ/Jmk1LQMzpQX4=; b=H02QeOsm7CQ5NmaGHg
	mHdSPoA6vrKonN3K5Nxoll9aLryV8LFyZyCy8z8r86rq6r4nWkBWVCSEo/rA/dDQ
	/+smUvSl4wywQ5d3UMpWSOCmJNjanlkMg0eleqKKr2ZvWD9aL0hSe3udA8ahKjNp
	AGhf0T7XxshPukM3VpBnq6gmY=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAnu_KILRxpyC6zEQ--.29019S4;
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
Subject: [RFC PATCH 2/7] exfat: support reuse buffer head for exfat_ent_get
Date: Tue, 18 Nov 2025 16:22:03 +0800
Message-ID: <20251118082208.1034186-3-chizhiling@163.com>
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
X-CM-TRANSID:PigvCgAnu_KILRxpyC6zEQ--.29019S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFW7WFykJr45AF1DKr4rKrg_yoWrCry3pF
	4DKa95JrWUJ3W7uwnrtF4kZ3WS93yxWFykGa15A3ZIyryktrn5ur17tryayFWrA3y8C3WY
	kF1jgF1Uur9xWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7a9-UUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbBgAkKnWkcJ5WpfwAAsP

From: Chi Zhiling <chizhiling@kylinos.cn>

This patch is part 2 of cached buffer head for exfat_ent_get,
it introduces an argument for exfat_ent_get, and make sure this
routine releases buffer head refcount when any error return.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/cache.c    |  2 +-
 fs/exfat/exfat_fs.h |  4 ++--
 fs/exfat/fatent.c   | 35 +++++++++++++++++++++++------------
 3 files changed, 26 insertions(+), 15 deletions(-)

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
index 329697c89d09..d52893276e9a 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -433,13 +433,13 @@ int exfat_set_volume_dirty(struct super_block *sb);
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
index f9c5d3485865..a3a19c8d2e05 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -88,8 +88,11 @@ int exfat_ent_set(struct super_block *sb, unsigned int loc,
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
 	int err;
@@ -98,39 +101,47 @@ int exfat_ent_get(struct super_block *sb, unsigned int loc,
 		exfat_fs_error_ratelimit(sb,
 			"invalid access to FAT (entry 0x%08x)",
 			loc);
-		return -EIO;
+		goto err;
 	}
 
-	err = __exfat_ent_get(sb, loc, content, NULL);
-	if (err) {
+	err = __exfat_ent_get(sb, loc, content, last);
+	if (unlikely(err)) {
 		exfat_fs_error_ratelimit(sb,
 			"failed to access to FAT (entry 0x%08x, err:%d)",
 			loc, err);
-		return err;
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
+	return err;
 }
 
 int exfat_chain_cont_cluster(struct super_block *sb, unsigned int chain,
@@ -299,7 +310,7 @@ int exfat_find_last_cluster(struct super_block *sb, struct exfat_chain *p_chain,
 	do {
 		count++;
 		clu = next;
-		if (exfat_ent_get(sb, clu, &next))
+		if (exfat_ent_get(sb, clu, &next, NULL))
 			return -EIO;
 	} while (next != EXFAT_EOF_CLUSTER && count <= p_chain->size);
 
@@ -490,7 +501,7 @@ int exfat_count_num_clusters(struct super_block *sb,
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


