Return-Path: <linux-fsdevel+bounces-72107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF852CDE903
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 10:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1DD13042808
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 09:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B6A31960C;
	Fri, 26 Dec 2025 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RZzh4Jhu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ACE31576D;
	Fri, 26 Dec 2025 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766742342; cv=none; b=mL+l0lG1v8+CXNOlvJHxX0l7kSZUs6K8zc9+OWqj24J+o3fHXi6s+9XsvV8p2Y33kuYsMrro3c0A7qnvFcl+TltNePSFlaWgCUJY2LHfz1WgCy6Shc0xn1Vq2eQORQVj6SF4l8PJrsnNWJYHJ0TkA1IUTHp2NY4FyETgJUxJFEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766742342; c=relaxed/simple;
	bh=m8VAlUB9Ouq9dJggFfY52aVdUdWKdTiZu9urVGJLxbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iU+5+AXWAvEgMZukkmFtVwcyhb7wQ04ek6lIMrnd4Zj+hvOz56YHDM5jWxDbZuIbBsJhjjsGr3/HTxDz+VFdbKzOF76oh/YrImgf557GVUwmvlBIfSQpj0lGCqsCatGctfFJre42QcnjeNQv5GS4LEpM7q7RbMr9jSUAPdv4ymM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RZzh4Jhu; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=OL
	z45/biIqsJRdyUEJ63VpvHd0PioSptcgwR0uanzps=; b=RZzh4JhufGIcr//OuB
	i6mBrlVev8V2Ep3ctDH3Eds6JCqxsH0pHV9HaCyz2bJuhJZhWrTiV7yalJp5eQx5
	iLWFlWiSXhWWWCtenP6HqHagDR/bKmYQU42EDhg6ktAMx5IG9pTD1l/W5z8P1ZkW
	WJ58+UmyapNTQkR3AeW4zrynw=
Received: from chi-Redmi-Book.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCnlXIPWU5p9JFCJA--.53S11;
	Fri, 26 Dec 2025 17:44:54 +0800 (CST)
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
Subject: [PATCH v1 9/9] exfat: support multi-cluster for exfat_get_cluster
Date: Fri, 26 Dec 2025 17:44:40 +0800
Message-ID: <20251226094440.455563-10-chizhiling@163.com>
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
X-CM-TRANSID:QCgvCgCnlXIPWU5p9JFCJA--.53S11
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw1fJw4kAF4UuFWkCF1rJFb_yoW7JFyrpr
	WxKayrtrZxXasruw4xtrs5ZryS93Z7GFW5J347Jry5Crn0yr4F9r1Dt3s0yF18Gw4kua1j
	vr1Fgw1UurnxGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Um2NNUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3BdJ5mlOWRe78QAA3H

From: Chi Zhiling <chizhiling@kylinos.cn>

This patch introduces a count parameter to exfat_get_cluster, which
serves as an input parameter for the caller to specify the desired
number of clusters, and as an output parameter to store the length
of consecutive clusters.

This patch can improve read performance by reducing the number of
get_block calls in sequential read scenarios. speacially in small
cluster size.

According to my test data, the performance improvement is
approximately 10% when read FAT_CHAIN file with 512 bytes of
cluster size.

454 MB/s -> 511 MB/s

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/cache.c    | 51 +++++++++++++++++++++++++++++++++++++++++----
 fs/exfat/exfat_fs.h |  2 +-
 fs/exfat/inode.c    |  5 +++--
 3 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/fs/exfat/cache.c b/fs/exfat/cache.c
index 57a66c067394..80efe2e0393d 100644
--- a/fs/exfat/cache.c
+++ b/fs/exfat/cache.c
@@ -234,7 +234,8 @@ static inline void cache_init(struct exfat_cache_id *cid,
 }
 
 int exfat_get_cluster(struct inode *inode, unsigned int cluster,
-		unsigned int *dclus, unsigned int *last_dclus)
+		unsigned int *dclus, unsigned int *count,
+		unsigned int *last_dclus)
 {
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
@@ -243,6 +244,7 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
 	struct buffer_head *bh = NULL;
 	struct exfat_cache_id cid;
 	unsigned int content, fclus;
+	unsigned int end = (*count <= 1) ? cluster : cluster + *count - 1;
 
 	if (ei->start_clu == EXFAT_FREE_CLUSTER) {
 		exfat_fs_error(sb,
@@ -256,17 +258,33 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
 	*last_dclus = *dclus;
 
 	/*
-	 * Don`t use exfat_cache if zero offset or non-cluster allocation
+	 * This case should not exist, as exfat_map_cluster function doesn't
+	 * call this routine when start_clu == EXFAT_EOF_CLUSTER.
+	 * This case is retained here for routine completeness.
 	 */
-	if (cluster == 0 || *dclus == EXFAT_EOF_CLUSTER)
+	if (*dclus == EXFAT_EOF_CLUSTER) {
+		*count = 0;
+		return 0;
+	}
+
+	/* If only the first cluster is needed, return now. */
+	if (fclus == cluster && *count == 1)
 		return 0;
 
 	cache_init(&cid, fclus, *dclus);
 	exfat_cache_lookup(inode, cluster, &cid, &fclus, dclus);
 
-	if (fclus == cluster)
+	/*
+	 * Return on cache hit to keep the code simple.
+	 */
+	if (fclus == cluster) {
+		*count = cid.fcluster + cid.nr_contig - fclus + 1;
 		return 0;
+	}
 
+	/*
+	 * Find the first cluster we need.
+	 */
 	while (fclus < cluster) {
 		/* prevent the infinite loop of cluster chain */
 		if (fclus > limit) {
@@ -290,6 +308,31 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
 			cache_init(&cid, fclus, *dclus);
 	}
 
+	/*
+	 * Collect the remaining clusters of this contiguous extent.
+	 */
+	if (*dclus != EXFAT_EOF_CLUSTER) {
+		unsigned int clu = *dclus;
+
+		/*
+		 * Now the cid cache contains the first cluster requested,
+		 * Advance the fclus to the last cluster of contiguous
+		 * extent, then update the count and cid cache accordingly.
+		 */
+		while (fclus < end) {
+			if (exfat_ent_get(sb, clu, &content, &bh))
+				goto err;
+			if (++clu != content) {
+				/* TODO: read ahead if content valid */
+				break;
+			}
+			fclus++;
+		}
+		cid.nr_contig = fclus - cid.fcluster;
+		*count = fclus - cluster + 1;
+	} else {
+		*count = 0;
+	}
 	brelse(bh);
 	exfat_cache_add(inode, &cid);
 	return 0;
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index e58d8eed5495..2dbed5f8ec26 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -486,7 +486,7 @@ int exfat_cache_init(void);
 void exfat_cache_shutdown(void);
 void exfat_cache_inval_inode(struct inode *inode);
 int exfat_get_cluster(struct inode *inode, unsigned int cluster,
-		unsigned int *dclus, unsigned int *last_dclus);
+		unsigned int *dclus, unsigned int *count, unsigned int *last_dclus);
 
 /* dir.c */
 extern const struct inode_operations exfat_dir_inode_operations;
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 8c49ab15eafe..317bc363f7d9 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -134,6 +134,7 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 	unsigned int local_clu_offset = clu_offset;
 	unsigned int num_to_be_allocated = 0, num_clusters;
+	unsigned int hint_count = max(*count, 1);
 
 	num_clusters = EXFAT_B_TO_CLU(exfat_ondisk_size(inode), sbi);
 
@@ -159,11 +160,11 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 			*count = 0;
 		}
 	} else if (ei->type == TYPE_FILE) {
+		*count = hint_count;
 		int err = exfat_get_cluster(inode, clu_offset,
-				clu, &last_clu);
+				clu, count, &last_clu);
 		if (err)
 			return -EIO;
-		*count = (*clu == EXFAT_EOF_CLUSTER) ? 0 : 1;
 	} else {
 		unsigned int fclus = 0;
 		/* hint information */
-- 
2.43.0


