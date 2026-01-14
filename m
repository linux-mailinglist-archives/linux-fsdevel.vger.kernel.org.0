Return-Path: <linux-fsdevel+bounces-73696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C96CAD1EB8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 13:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D703330F0AB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 12:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03787397ACC;
	Wed, 14 Jan 2026 12:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IMchwroI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AC039901C;
	Wed, 14 Jan 2026 12:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768393115; cv=none; b=pOIezsNS4fB+dw1KksS/tY2PzVoNUbp5tZltzHg1Yh+7YwVhxqzz6YiRDffjFNQBcoe0X4UiCuBJpyv4WCqTZVOGX2gOdsYXUjFVUUGo97lYDv8BPLCVvbEUFOkC5ug/KlXOfsel0MKIzUSf6fNJN5YQVvzn2HvFgmTU3IfUKX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768393115; c=relaxed/simple;
	bh=vhbO/+aBxW/vPqdx9L19jZqvSjNM1xaBM6Ja0kJ8RtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGAQIBoc8O2LIz6MLpihSbpUiBkfG94WY5h2gYgNfD7h/1Ld972Ij6dzUUfFytha9nTfE7xnoofhPya/9VL5wsTksm/CT3CbRrD9bQyfP1tKgAY4MqUeM5dCWbCKda13vkqPZ2Qse5J461qIOuSXIhB3gMhS5BjbD9wx/kSyV0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IMchwroI; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=jf
	9MOLjnXyA3xixjpSo2YcZ4xdjbYE/iej+10bxKbYo=; b=IMchwroIJGwvK9jRGg
	clI+ZEysYumWwEsB9Iaq6QuNK+htqPqZHHOs+h2LM7e3PhT6m5/qySkxS2Su8eVH
	fjCvTeYATMwhwMDh9Z6Y7Jv1EhJhscvruZwlLig0L1gvZQIxeXYGiz7IDcdsmk4B
	d+aXohOeuQzIDyjw9zYuIBkJg=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDHK3aCiWdpxg+ELQ--.67S2;
	Wed, 14 Jan 2026 20:18:13 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v3 13/13] exfat: support multi-cluster for exfat_get_cluster
Date: Wed, 14 Jan 2026 20:18:08 +0800
Message-ID: <20260114121808.616139-1-chizhiling@163.com>
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
X-CM-TRANSID:QCgvCgDHK3aCiWdpxg+ELQ--.67S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw1fJw4kAF4UuFWkCF1rJFb_yoWrtF1Dpr
	W7KayrtrZxXa9ruw4xtr4kZFyS93Z7GFW7J347Jr98Crn0yr4F9rnFy3s0yF48Gw4kua1j
	vr1rKw1UurnrGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UXNV9UUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+AW3VWlniYWDqQAA33

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

Suggested-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/cache.c    | 56 +++++++++++++++++++++++++++++++++++++++++----
 fs/exfat/exfat_fs.h |  2 +-
 fs/exfat/inode.c    |  3 +--
 3 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/fs/exfat/cache.c b/fs/exfat/cache.c
index 5cdeac014a3d..7c8b4182f5de 100644
--- a/fs/exfat/cache.c
+++ b/fs/exfat/cache.c
@@ -259,13 +259,15 @@ static inline void cache_init(struct exfat_cache_id *cid,
 }
 
 int exfat_get_cluster(struct inode *inode, unsigned int cluster,
-		unsigned int *dclus, unsigned int *last_dclus)
+		unsigned int *dclus, unsigned int *count,
+		unsigned int *last_dclus)
 {
 	struct super_block *sb = inode->i_sb;
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 	struct buffer_head *bh = NULL;
 	struct exfat_cache_id cid;
 	unsigned int content, fclus;
+	unsigned int end = cluster + *count - 1;
 
 	if (ei->start_clu == EXFAT_FREE_CLUSTER) {
 		exfat_fs_error(sb,
@@ -279,17 +281,33 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
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
-	exfat_cache_lookup(inode, &cid, cluster, cluster, &fclus, dclus);
+	/*
+	 * Update the 'end' to exclude the next cache range, as clusters in
+	 * different cache are typically not contiguous.
+	 */
+	end = exfat_cache_lookup(inode, &cid, cluster, end, &fclus, dclus);
 
-	if (fclus == cluster)
+	/* Return if the cache covers the entire range. */
+	if (cid.fcluster + cid.nr_contig >= end) {
+		*count = end - cluster + 1;
 		return 0;
+	}
 
+	/* Find the first cluster we need. */
 	while (fclus < cluster) {
 		if (exfat_ent_get(sb, *dclus, &content, &bh))
 			return -EIO;
@@ -305,6 +323,34 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
 			cache_init(&cid, fclus, *dclus);
 	}
 
+	/*
+	 * Now the cid cache contains the first cluster requested, collect
+	 * the remaining clusters of this contiguous extent.
+	 */
+	if (*dclus != EXFAT_EOF_CLUSTER) {
+		unsigned int clu = *dclus;
+
+		while (fclus < end) {
+			if (exfat_ent_get(sb, clu, &content, &bh))
+				return -EIO;
+			if (++clu != content)
+				break;
+			fclus++;
+		}
+		cid.nr_contig = fclus - cid.fcluster;
+		*count = fclus - cluster + 1;
+
+		/*
+		 * Cache this discontiguous cluster, we'll definitely need
+		 * it later
+		 */
+		if (fclus < end && content != EXFAT_EOF_CLUSTER) {
+			exfat_cache_add(inode, &cid);
+			cache_init(&cid, fclus + 1, content);
+		}
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
index 410f9c98b8dc..86bce7ea2725 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -160,10 +160,9 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 		}
 	} else {
 		int err = exfat_get_cluster(inode, clu_offset,
-				clu, &last_clu);
+				clu, count, &last_clu);
 		if (err)
 			return -EIO;
-		*count = (*clu == EXFAT_EOF_CLUSTER) ? 0 : 1;
 	}
 
 	if (*clu == EXFAT_EOF_CLUSTER) {
-- 
2.43.0


