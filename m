Return-Path: <linux-fsdevel+bounces-72283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F422CEBA9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 10:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 784D630433E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 09:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0E231AF3F;
	Wed, 31 Dec 2025 09:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hDPirPbx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D571831960E;
	Wed, 31 Dec 2025 09:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767172452; cv=none; b=cIE5jvwxzUOhxi2oAdgk55N/3s3rzF9TmA2Pw4moLh2tF8GwdX3N2xkj85YIoFYT7YxPCyNKjry+kgY0ADcW4Zl6srhrQ/g2Dmw/hCD42VKzsgKSYEbVf/IQRh+4cLroyiEMVLud00RkYv3QzDf7hLZQzA766bZ3a+zRYjA8mLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767172452; c=relaxed/simple;
	bh=GIG0iVEeSaYWSb9UOeG6A4TW0TzFA2hTW6WDyaPChPs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+gWGnjeaDUYVMTG/iG2oV1enVWhxKNxstB2irfBajme6h0tXmBhqViZqScV5ORyKYJULi2eQnwoW6aM+wNyRMymTjY9KOK3jWyZyYpbmyxlQ+rIAHlTcsW4rtxTy00Wm1f+Oa1JZhz2Ga/MOeKm5VJbchW74KSBZQGSnrQOy40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hDPirPbx; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=GMiG3KxyMRrDcExhh2zKYwP+YiMVAseTuuCZp2tTRO0=;
	b=hDPirPbxVDQuKp01p2DNZl+buDOy3ab1lSG7hTWnEYHAoMWsq5JNoa2iAlAKSfml9SRsJQPtD
	SjjEEa/uVi/RJDqnk5YxToqDDuK0kq9uVDcP+i0eORJ5Abmld7TR/4kKCRQKQN74myXaNF2WDmG
	m7SA24qGQvEAADFb083dgV8=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dh41X0JGVzcb0w;
	Wed, 31 Dec 2025 17:10:40 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 0CFA94056A;
	Wed, 31 Dec 2025 17:13:59 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 31 Dec
 2025 17:13:58 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<lihongbo22@huawei.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 02/10] erofs: hold read context in iomap_iter if needed
Date: Wed, 31 Dec 2025 09:01:10 +0000
Message-ID: <20251231090118.541061-3-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251231090118.541061-1-lihongbo22@huawei.com>
References: <20251231090118.541061-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500015.china.huawei.com (7.202.195.162)

Introduce `struct erofs_iomap_iter_ctx` to hold both `struct page *`
and `void *base`, avoiding bogus use of `kmap_to_page()` in
`erofs_iomap_end()`.

With this change, fiemap and bmap no longer need to read inline data.

Additionally, the upcoming page cache sharing mechanism requires
passing the backing inode pointer to `erofs_iomap_{begin,end}()`, as
I/O accesses must apply to backing inodes rather than anon inodes.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c | 67 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 21 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index bb13c4cb8455..71e23d91123d 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -266,13 +266,20 @@ void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
 	folio_end_read(folio, !(v & BIT(EROFS_ONLINEFOLIO_EIO)));
 }
 
+struct erofs_iomap_iter_ctx {
+	struct page *page;
+	void *base;
+};
+
 static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
 {
-	int ret;
+	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
+	struct erofs_iomap_iter_ctx *ctx = iter->private;
 	struct super_block *sb = inode->i_sb;
 	struct erofs_map_blocks map;
 	struct erofs_map_dev mdev;
+	int ret;
 
 	map.m_la = offset;
 	map.m_llen = length;
@@ -283,7 +290,6 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	iomap->offset = map.m_la;
 	iomap->length = map.m_llen;
 	iomap->flags = 0;
-	iomap->private = NULL;
 	iomap->addr = IOMAP_NULL_ADDR;
 	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
 		iomap->type = IOMAP_HOLE;
@@ -309,16 +315,20 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	}
 
 	if (map.m_flags & EROFS_MAP_META) {
-		void *ptr;
-		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
-
 		iomap->type = IOMAP_INLINE;
-		ptr = erofs_read_metabuf(&buf, sb, map.m_pa,
-					 erofs_inode_in_metabox(inode));
-		if (IS_ERR(ptr))
-			return PTR_ERR(ptr);
-		iomap->inline_data = ptr;
-		iomap->private = buf.base;
+		/* read context should read the inlined data */
+		if (ctx) {
+			struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
+			void *ptr;
+
+			ptr = erofs_read_metabuf(&buf, sb, map.m_pa,
+						 erofs_inode_in_metabox(inode));
+			if (IS_ERR(ptr))
+				return PTR_ERR(ptr);
+			iomap->inline_data = ptr;
+			ctx->page = buf.page;
+			ctx->base = buf.base;
+		}
 	} else {
 		iomap->type = IOMAP_MAPPED;
 	}
@@ -328,18 +338,18 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 static int erofs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 		ssize_t written, unsigned int flags, struct iomap *iomap)
 {
-	void *ptr = iomap->private;
+	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
+	struct erofs_iomap_iter_ctx *ctx = iter->private;
 
-	if (ptr) {
+	if (ctx && ctx->base) {
 		struct erofs_buf buf = {
-			.page = kmap_to_page(ptr),
-			.base = ptr,
+			.page = ctx->page,
+			.base = ctx->base,
 		};
 
 		DBG_BUGON(iomap->type != IOMAP_INLINE);
 		erofs_put_metabuf(&buf);
-	} else {
-		DBG_BUGON(iomap->type == IOMAP_INLINE);
+		ctx->base = NULL;
 	}
 	return written;
 }
@@ -369,18 +379,30 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
  */
 static int erofs_read_folio(struct file *file, struct folio *folio)
 {
+	struct iomap_read_folio_ctx read_ctx = {
+		.ops		= &iomap_bio_read_ops,
+		.cur_folio	= folio,
+	};
+	struct erofs_iomap_iter_ctx iter_ctx = {};
+
 	trace_erofs_read_folio(folio, true);
 
-	iomap_bio_read_folio(folio, &erofs_iomap_ops);
+	iomap_read_folio(&erofs_iomap_ops, &read_ctx, &iter_ctx);
 	return 0;
 }
 
 static void erofs_readahead(struct readahead_control *rac)
 {
+	struct iomap_read_folio_ctx read_ctx = {
+		.ops		= &iomap_bio_read_ops,
+		.rac		= rac,
+	};
+	struct erofs_iomap_iter_ctx iter_ctx = {};
+
 	trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
 					readahead_count(rac), true);
 
-	iomap_bio_readahead(rac, &erofs_iomap_ops);
+	iomap_readahead(&erofs_iomap_ops, &read_ctx, &iter_ctx);
 }
 
 static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
@@ -400,9 +422,12 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (IS_DAX(inode))
 		return dax_iomap_rw(iocb, to, &erofs_iomap_ops);
 #endif
-	if ((iocb->ki_flags & IOCB_DIRECT) && inode->i_sb->s_bdev)
+	if ((iocb->ki_flags & IOCB_DIRECT) && inode->i_sb->s_bdev) {
+		struct erofs_iomap_iter_ctx iter_ctx = {};
+
 		return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
-				    NULL, 0, NULL, 0);
+				    NULL, 0, &iter_ctx, 0);
+	}
 	return filemap_read(iocb, to, 0);
 }
 
-- 
2.22.0


