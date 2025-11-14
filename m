Return-Path: <linux-fsdevel+bounces-68455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C95CC5C7C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 11:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9E63E356B1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 10:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F56F3101DB;
	Fri, 14 Nov 2025 10:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="5Sv2DVfY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E3030F7EA;
	Fri, 14 Nov 2025 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763114826; cv=none; b=jPKUWhwLugh1h4hVuOEPWyAqIXe4cVCFuzyLz32XYcmI3yqCCERCaZ/cdSUvO6QXr8xB/Hr+jhK7lDjDP0UNcolaiGrFqz3rvh8itI9T6SbRpfzGE9KdAA+zJD7ohZ5BvlDOue+ZYb95nw5JW5kpN+t2oCjeu8biJ7BwMMgggzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763114826; c=relaxed/simple;
	bh=S+i9I/UqevohlXSVPtPcsSZNYaIQ8MBY912CHMWdSwI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mG1QXFq1YkBzf4wxwlUFTMcXW2stkzgudjLgwnwUcGYOCgiaLwvfEO8QPKKEi/MLA+dya22oPK9sdQKDchpMk6CdR3hY6vf/+74o28ZX8Am8iVcDAP+cSOf/PMJ+tIRCuIqQmoZPTVf+8LCI1lz+jSFUGOLsZc74PafFLejW4Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=5Sv2DVfY; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=K0Uha1E1AoTTdsUqS8ogAzLegDGAzEZvOWEH95Tolb8=;
	b=5Sv2DVfYlUO5XY0hrSs5KJkDBSjT4n4BjyMTqeRgBOCu/hEpoWKoDtvPeyeiwpN7ITrrKdI+H
	SUkDpdCFVlqGPxDYdg+28EA8YS0U5/89lTWDTFLCX/kAs7UOW2z69706j/87dD0m2QBL+m40TIX
	1BM+x9kwrSfbkY4tKSv0d+Q=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4d7CST1Rt2z1T4LW;
	Fri, 14 Nov 2025 18:05:29 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 4FA03180478;
	Fri, 14 Nov 2025 18:06:55 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 14 Nov
 2025 18:06:54 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <joannelkoong@gmail.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 1/9] iomap: stash iomap read ctx in the private field of iomap_iter
Date: Fri, 14 Nov 2025 09:55:08 +0000
Message-ID: <20251114095516.207555-2-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251114095516.207555-1-lihongbo22@huawei.com>
References: <20251114095516.207555-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/fuse/file.c         | 4 ++--
 fs/iomap/buffered-io.c | 6 ++++--
 include/linux/iomap.h  | 8 ++++----
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8275b6681b9b..98dd20f0bb53 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -973,7 +973,7 @@ static int fuse_read_folio(struct file *file, struct folio *folio)
 		return -EIO;
 	}
 
-	iomap_read_folio(&fuse_iomap_ops, &ctx);
+	iomap_read_folio(&fuse_iomap_ops, &ctx, NULL);
 	fuse_invalidate_atime(inode);
 	return 0;
 }
@@ -1075,7 +1075,7 @@ static void fuse_readahead(struct readahead_control *rac)
 	if (fuse_is_bad(inode))
 		return;
 
-	iomap_readahead(&fuse_iomap_ops, &ctx);
+	iomap_readahead(&fuse_iomap_ops, &ctx, NULL);
 }
 
 static ssize_t fuse_cache_read_iter(struct kiocb *iocb, struct iov_iter *to)
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6ae031ac8058..8e79303c074e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -496,13 +496,14 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
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
 	size_t bytes_pending = 0;
 	int ret;
@@ -560,13 +561,14 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
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
 	size_t cur_bytes_pending;
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8b1ac08c7474..c3ecbbdb14e8 100644
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
@@ -594,7 +594,7 @@ static inline void iomap_bio_read_folio(struct folio *folio,
 		.cur_folio	= folio,
 	};
 
-	iomap_read_folio(ops, &ctx);
+	iomap_read_folio(ops, &ctx, NULL);
 }
 
 static inline void iomap_bio_readahead(struct readahead_control *rac,
@@ -605,7 +605,7 @@ static inline void iomap_bio_readahead(struct readahead_control *rac,
 		.rac		= rac,
 	};
 
-	iomap_readahead(ops, &ctx);
+	iomap_readahead(ops, &ctx, NULL);
 }
 #endif /* CONFIG_BLOCK */
 
-- 
2.22.0


