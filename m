Return-Path: <linux-fsdevel+bounces-72015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B767CDB4D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 05:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3312301985A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 04:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29008329E44;
	Wed, 24 Dec 2025 04:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Fy+/BaOt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04D7311587;
	Wed, 24 Dec 2025 04:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766550138; cv=none; b=rJW6VkL5FVmCZbWgzRYB0cCIrFe6++Frr8lyFtJ+JTlq6UiZlmLS40LyB0wn2+CCLY1gPjyCYizdR4fBFih3GQZEk4jphH9rKeYWd758c4QVsj7Cn3Vuz1fq8LDqOmgqm3e9uTbeXjzrtYSVJwY/LE4mIxv2gmlFsUX2VbFch1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766550138; c=relaxed/simple;
	bh=mkHbphnDyLE59gNHi2m8RytMc7MvoR1YldZHf1IDj/o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZARNQJbm/rHoA8PuSAs4H+5knhCUIMBXys7CR1f6DUAnl5pdnevHdFPANNQXBNuTtgo5YbI7EKGDALbxZKz4nREnKPHvwwWNJAZ91tiocnTlYFanaL8Nx706t1Jv+arf10nrVf5Gqn2FlfJ0J5zBSXlcnIWZ7VOsbodcTloNrns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Fy+/BaOt; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=S4ky3qPhxQ6nD97kES0tbuLLeaS9g2egO93O+q5sd9M=;
	b=Fy+/BaOtRk+rOTk1prKMq95ysd/0Y5FLrJAJBf36kqIQy2zyXdmu3PWsqAUCJwpehaYqHqVJd
	X7HMAwaEB9rWlZ8OYDSz8/LjGydVGAX4aXGEXQyH/utgHQy1U6am2FXkIcPQf8zjsh9E/BxQc8+
	D3cbQTRmcrCJVN1NOFihuao=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dbdtD6XcTznTWN;
	Wed, 24 Dec 2025 12:19:00 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 6853940563;
	Wed, 24 Dec 2025 12:22:13 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 24 Dec
 2025 12:22:12 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v11 01/10] iomap: stash iomap read ctx in the private field of iomap_iter
Date: Wed, 24 Dec 2025 04:09:23 +0000
Message-ID: <20251224040932.496478-2-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251224040932.496478-1-lihongbo22@huawei.com>
References: <20251224040932.496478-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr500015.china.huawei.com (7.202.195.162)

It's useful to get filesystem-specific information using the
existing private field in the @iomap_iter passed to iomap_{begin,end}
for advanced usage for iomap buffered reads, which is much like the
current iomap DIO.

For example, EROFS needs it to:

 - implement an efficient page cache sharing feature, since iomap
   needs to apply to anon inode page cache but we'd like to get the
   backing inode/fs instead, so filesystem-specific private data is
   needed to keep such information;

 - pass in both struct page * and void * for inline data to avoid
   kmap_to_page() usage (which is bogus).

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/fuse/file.c         | 4 ++--
 fs/iomap/buffered-io.c | 6 ++++--
 include/linux/iomap.h  | 8 ++++----
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 01bc894e9c2b..f5d8887c1922 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -979,7 +979,7 @@ static int fuse_read_folio(struct file *file, struct folio *folio)
 		return -EIO;
 	}
 
-	iomap_read_folio(&fuse_iomap_ops, &ctx);
+	iomap_read_folio(&fuse_iomap_ops, &ctx, NULL);
 	fuse_invalidate_atime(inode);
 	return 0;
 }
@@ -1081,7 +1081,7 @@ static void fuse_readahead(struct readahead_control *rac)
 	if (fuse_is_bad(inode))
 		return;
 
-	iomap_readahead(&fuse_iomap_ops, &ctx);
+	iomap_readahead(&fuse_iomap_ops, &ctx, NULL);
 }
 
 static ssize_t fuse_cache_read_iter(struct kiocb *iocb, struct iov_iter *to)
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index e5c1ca440d93..5f7dcbabbda3 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -555,13 +555,14 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 }
 
 void iomap_read_folio(const struct iomap_ops *ops,
-		struct iomap_read_folio_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx, void *private)
 {
 	struct folio *folio = ctx->cur_folio;
 	struct iomap_iter iter = {
 		.inode		= folio->mapping->host,
 		.pos		= folio_pos(folio),
 		.len		= folio_size(folio),
+		.private	= private,
 	};
 	size_t bytes_submitted = 0;
 	int ret;
@@ -620,13 +621,14 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
  * the filesystem to be reentered.
  */
 void iomap_readahead(const struct iomap_ops *ops,
-		struct iomap_read_folio_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx, void *private)
 {
 	struct readahead_control *rac = ctx->rac;
 	struct iomap_iter iter = {
 		.inode	= rac->mapping->host,
 		.pos	= readahead_pos(rac),
 		.len	= readahead_length(rac),
+		.private = private,
 	};
 	size_t cur_bytes_submitted;
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 520e967cb501..441d614e9fdf 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -341,9 +341,9 @@ ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops,
 		const struct iomap_write_ops *write_ops, void *private);
 void iomap_read_folio(const struct iomap_ops *ops,
-		struct iomap_read_folio_ctx *ctx);
+		struct iomap_read_folio_ctx *ctx, void *private);
 void iomap_readahead(const struct iomap_ops *ops,
-		struct iomap_read_folio_ctx *ctx);
+		struct iomap_read_folio_ctx *ctx, void *private);
 bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
 struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len);
 bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
@@ -595,7 +595,7 @@ static inline void iomap_bio_read_folio(struct folio *folio,
 		.cur_folio	= folio,
 	};
 
-	iomap_read_folio(ops, &ctx);
+	iomap_read_folio(ops, &ctx, NULL);
 }
 
 static inline void iomap_bio_readahead(struct readahead_control *rac,
@@ -606,7 +606,7 @@ static inline void iomap_bio_readahead(struct readahead_control *rac,
 		.rac		= rac,
 	};
 
-	iomap_readahead(ops, &ctx);
+	iomap_readahead(ops, &ctx, NULL);
 }
 #endif /* CONFIG_BLOCK */
 
-- 
2.22.0


