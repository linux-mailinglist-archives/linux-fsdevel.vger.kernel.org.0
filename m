Return-Path: <linux-fsdevel+bounces-68458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCA8C5C88B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 11:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C11A4F3333
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 10:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E36F31326B;
	Fri, 14 Nov 2025 10:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="zhgrjLX0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E4B3112DC;
	Fri, 14 Nov 2025 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763114829; cv=none; b=hV1drxoQLGdB/WhxyiWdNtjDCSx21h/xACVyOLEgkRZdhvMX/+LiiTObFpyiK2EFQza5K8iv8mbcypYYuwdWrlGuZey6mSW2XyDJ/M6MAHLHKa8G6fdbs9fMQK3R4ZDooyChqfIz5V4QlsNFrSF5bzGdq2MbUd7pmwooKALHryE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763114829; c=relaxed/simple;
	bh=6riCg433t7qB+ILg890ziYT/4uKm9DGv5PIHAzbHdcc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dx2EnCXMZp7zO2QSjjQDQ3vVdb6BrPt7DycpqznYBJ6GTXa0MaN+NkFf3Bcj/9uCjt1RvcECZUmdyxWh+6BWMDEIHFpVhQiToffS3q2doEGxEXCc/v23aWF6h+XUM+g4Q50RyBbysXLJt2rfl/Zkwj7q3QetmDhK+DTAhQZLhGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=zhgrjLX0; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5SLCY9E4I2eWPgxD26E2VWjjMx+WOcMowunKXjSKJWw=;
	b=zhgrjLX0Ib+b8Gec24sgIFt5T9xCuOX4EVC0Icwhkk/rC229+yaqDr/yS0WGmnIUtF+oWCDeU
	AUoMjik1tEh5wkTZq3kCitpAf/rChIkE3Pr6kx4XSg74ShiYmRIZ6msDXjjf8chMB33OxOGKIFt
	dXyqLkysfqyZt8yFq7MS740=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4d7CSX0knTz1T4g8;
	Fri, 14 Nov 2025 18:05:32 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 384DA180488;
	Fri, 14 Nov 2025 18:06:58 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 14 Nov
 2025 18:06:57 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <joannelkoong@gmail.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 7/9] erofs: support unencoded inodes for page cache share
Date: Fri, 14 Nov 2025 09:55:14 +0000
Message-ID: <20251114095516.207555-8-lihongbo22@huawei.com>
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

This patch adds inode page cache sharing functionality for unencoded
files.

I conducted experiments in the container environment. Below is the
memory usage for reading all files in two different minor versions
of container images:

+-------------------+------------------+-------------+---------------+
|       Image       | Page Cache Share | Memory (MB) |    Memory     |
|                   |                  |             | Reduction (%) |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     241     |       -       |
|       redis       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |     163     |      33%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     872     |       -       |
|      postgres     +------------------+-------------+---------------+
|    16.1 & 16.2    |        Yes       |     630     |      28%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     2771    |       -       |
|     tensorflow    +------------------+-------------+---------------+
|  2.11.0 & 2.11.1  |        Yes       |     2340    |      16%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     926     |       -       |
|       mysql       +------------------+-------------+---------------+
|  8.0.11 & 8.0.12  |        Yes       |     735     |      21%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     390     |       -       |
|       nginx       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |     219     |      44%      |
+-------------------+------------------+-------------+---------------+
|       tomcat      |        No        |     924     |       -       |
| 10.1.25 & 10.1.26 +------------------+-------------+---------------+
|                   |        Yes       |     474     |      49%      |
+-------------------+------------------+-------------+---------------+

Additionally, the table below shows the runtime memory usage of the
container:

+-------------------+------------------+-------------+---------------+
|       Image       | Page Cache Share | Memory (MB) |    Memory     |
|                   |                  |             | Reduction (%) |
+-------------------+------------------+-------------+---------------+
|                   |        No        |      35     |       -       |
|       redis       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |      28     |      20%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     149     |       -       |
|      postgres     +------------------+-------------+---------------+
|    16.1 & 16.2    |        Yes       |      95     |      37%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     1028    |       -       |
|     tensorflow    +------------------+-------------+---------------+
|  2.11.0 & 2.11.1  |        Yes       |     930     |      10%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     155     |       -       |
|       mysql       +------------------+-------------+---------------+
|  8.0.11 & 8.0.12  |        Yes       |     132     |      15%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |      25     |       -       |
|       nginx       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |      20     |      20%      |
+-------------------+------------------+-------------+---------------+
|       tomcat      |        No        |     186     |       -       |
| 10.1.25 & 10.1.26 +------------------+-------------+---------------+
|                   |        Yes       |      98     |      48%      |
+-------------------+------------------+-------------+---------------+

Co-developed-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/data.c     | 38 +++++++++++++++---
 fs/erofs/inode.c    |  5 +++
 fs/erofs/internal.h |  4 ++
 fs/erofs/ishare.c   | 98 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/erofs/ishare.h   | 18 +++++++++
 fs/erofs/super.c    | 11 +++--
 6 files changed, 163 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index bd3d85c61341..c459104e4734 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021, Alibaba Cloud
  */
 #include "internal.h"
+#include "ishare.h"
 #include <linux/sched/mm.h>
 #include <trace/events/erofs.h>
 
@@ -269,23 +270,27 @@ void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
 struct erofs_iomap_iter_ctx {
 	struct page *page;
 	void *base;
+	struct inode *realinode;
 };
 
 static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
 {
-	int ret;
 	struct erofs_iomap_iter_ctx *ctx;
-	struct super_block *sb = inode->i_sb;
 	struct erofs_map_blocks map;
 	struct erofs_map_dev mdev;
 	struct iomap_iter *iter;
+	struct inode *realinode;
+	struct super_block *sb;
+	int ret;
 
 	iter = container_of(iomap, struct iomap_iter, iomap);
 	ctx = iter->private;
+	realinode = ctx ? ctx->realinode : inode;
+	sb = realinode->i_sb;
 	map.m_la = offset;
 	map.m_llen = length;
-	ret = erofs_map_blocks(inode, &map);
+	ret = erofs_map_blocks(realinode, &map);
 	if (ret < 0)
 		return ret;
 
@@ -300,7 +305,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		return 0;
 	}
 
-	if (!(map.m_flags & EROFS_MAP_META) || !erofs_inode_in_metabox(inode)) {
+	if (!(map.m_flags & EROFS_MAP_META) || !erofs_inode_in_metabox(realinode)) {
 		mdev = (struct erofs_map_dev) {
 			.m_deviceid = map.m_deviceid,
 			.m_pa = map.m_pa,
@@ -326,7 +331,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 			struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 
 			ptr = erofs_read_metabuf(&buf, sb, map.m_pa,
-						 erofs_inode_in_metabox(inode));
+						 erofs_inode_in_metabox(realinode));
 			if (IS_ERR(ptr))
 				return PTR_ERR(ptr);
 			iomap->inline_data = ptr;
@@ -384,6 +389,7 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
  */
 static int erofs_read_folio(struct file *file, struct folio *folio)
 {
+	struct inode *inode = folio_inode(folio);
 	struct iomap_read_folio_ctx read_ctx = {
 		.ops		= &iomap_bio_read_ops,
 		.cur_folio	= folio,
@@ -391,16 +397,27 @@ static int erofs_read_folio(struct file *file, struct folio *folio)
 	struct erofs_iomap_iter_ctx iter_ctx = {
 		.page		= NULL,
 		.base		= NULL,
+		.realinode	= erofs_ishare_iget(inode),
+	};
+	struct erofs_read_ctx rdctx = {
+		.file		= file,
+		.inode		= inode,
 	};
 
+	if (!iter_ctx.realinode)
+		return -EIO;
 	trace_erofs_read_folio(folio, true);
 
+	erofs_read_begin(&rdctx);
 	iomap_read_folio(&erofs_iomap_ops, &read_ctx, &iter_ctx);
+	erofs_read_end(&rdctx);
+	erofs_ishare_iput(iter_ctx.realinode);
 	return 0;
 }
 
 static void erofs_readahead(struct readahead_control *rac)
 {
+	struct inode *inode = rac->mapping->host;
 	struct iomap_read_folio_ctx read_ctx = {
 		.ops		= &iomap_bio_read_ops,
 		.rac		= rac,
@@ -408,12 +425,22 @@ static void erofs_readahead(struct readahead_control *rac)
 	struct erofs_iomap_iter_ctx iter_ctx = {
 		.page		= NULL,
 		.base		= NULL,
+		.realinode	= erofs_ishare_iget(inode),
+	};
+	struct erofs_read_ctx rdctx = {
+		.file		= rac->file,
+		.inode		= inode,
 	};
 
+	if (!iter_ctx.realinode)
+		return;
 	trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
 					readahead_count(rac), true);
 
+	erofs_read_begin(&rdctx);
 	iomap_readahead(&erofs_iomap_ops, &read_ctx, &iter_ctx);
+	erofs_read_end(&rdctx);
+	erofs_ishare_iput(iter_ctx.realinode);
 }
 
 static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
@@ -437,6 +464,7 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		struct erofs_iomap_iter_ctx iter_ctx = {
 			.page = NULL,
 			.base = NULL,
+			.realinode = inode,
 		};
 
 		return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index cb780c095d28..fe45e6c18f8e 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021, Alibaba Cloud
  */
 #include "xattr.h"
+#include "ishare.h"
 #include <linux/compat.h>
 #include <trace/events/erofs.h>
 
@@ -215,6 +216,10 @@ static int erofs_fill_inode(struct inode *inode)
 	case S_IFREG:
 		inode->i_op = &erofs_generic_iops;
 		inode->i_fop = &erofs_file_fops;
+#ifdef CONFIG_EROFS_FS_INODE_SHARE
+		if (erofs_ishare_fill_inode(inode))
+			inode->i_fop = &erofs_ishare_fops;
+#endif
 		break;
 	case S_IFDIR:
 		inode->i_op = &erofs_dir_iops;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 26772458fda7..6f7d441955c6 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -331,11 +331,15 @@ struct erofs_inode {
 			spinlock_t lock;
 			/* all backing inodes */
 			struct list_head backing_head;
+			/* processing list */
+			struct list_head processing_head;
 		};
 
 		struct {
 			struct inode *ishare;
 			struct list_head backing_link;
+			struct list_head processing_link;
+			atomic_t processing_count;
 		};
 	};
 #endif
diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index 910b732bf8e7..14b2690055c5 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -72,6 +72,7 @@ static int erofs_ishare_iget5_set(struct inode *inode, void *data)
 
 	vi->fingerprint = data;
 	INIT_LIST_HEAD(&vi->backing_head);
+	INIT_LIST_HEAD(&vi->processing_head);
 	spin_lock_init(&vi->lock);
 	return 0;
 }
@@ -124,7 +125,9 @@ bool erofs_ishare_fill_inode(struct inode *inode)
 	}
 
 	INIT_LIST_HEAD(&vi->backing_link);
+	INIT_LIST_HEAD(&vi->processing_link);
 	vi->ishare = idedup;
+
 	spin_lock(&EROFS_I(idedup)->lock);
 	list_add(&vi->backing_link, &EROFS_I(idedup)->backing_head);
 	spin_unlock(&EROFS_I(idedup)->lock);
@@ -163,17 +166,28 @@ static int erofs_ishare_file_open(struct inode *inode, struct file *file)
 {
 	struct file *realfile;
 	struct inode *dedup;
+	char *buf, *filepath;
 
 	dedup = EROFS_I(inode)->ishare;
 	if (!dedup)
 		return -EINVAL;
 
-	realfile = alloc_file_pseudo(dedup, erofs_ishare_mnt, "erofs_ishare_file",
+	buf = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	filepath = file_path(file, buf, PATH_MAX);
+	if (IS_ERR(filepath)) {
+		kfree(buf);
+		return -PTR_ERR(filepath);
+	}
+	realfile = alloc_file_pseudo(dedup, erofs_ishare_mnt, filepath + 1,
 				     O_RDONLY, &erofs_file_fops);
+	kfree(buf);
 	if (IS_ERR(realfile))
 		return PTR_ERR(realfile);
 
 	file_ra_state_init(&realfile->f_ra, file->f_mapping);
+	ihold(dedup);
 	realfile->private_data = EROFS_I(inode);
 	file->private_data = realfile;
 	return 0;
@@ -185,8 +199,8 @@ static int erofs_ishare_file_release(struct inode *inode, struct file *file)
 
 	if (!realfile)
 		return -EINVAL;
+	file->private_data = NULL;
 	fput(realfile);
-	realfile->private_data = NULL;
 	return 0;
 }
 
@@ -234,3 +248,83 @@ const struct file_operations erofs_ishare_fops = {
 	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= filemap_splice_read,
 };
+
+void erofs_read_begin(struct erofs_read_ctx *rdctx)
+{
+	struct erofs_inode *vi, *vi_dedup;
+
+	if (!rdctx->file || !erofs_is_ishare_inode(rdctx->inode))
+		return;
+
+	vi = rdctx->file->private_data;
+	vi_dedup = EROFS_I(file_inode(rdctx->file));
+
+	spin_lock(&vi_dedup->lock);
+	if (!list_empty(&vi->processing_link)) {
+		atomic_inc(&vi->processing_count);
+	} else {
+		list_add(&vi->processing_link,
+			 &vi_dedup->processing_head);
+		atomic_set(&vi->processing_count, 1);
+	}
+	spin_unlock(&vi_dedup->lock);
+}
+
+void erofs_read_end(struct erofs_read_ctx *rdctx)
+{
+	struct erofs_inode *vi, *vi_dedup;
+
+	if (!rdctx->file || !erofs_is_ishare_inode(rdctx->inode))
+		return;
+
+	vi = rdctx->file->private_data;
+	vi_dedup = EROFS_I(file_inode(rdctx->file));
+
+	spin_lock(&vi_dedup->lock);
+	if (atomic_dec_and_test(&vi->processing_count))
+		list_del_init(&vi->processing_link);
+	spin_unlock(&vi_dedup->lock);
+}
+
+/*
+ * erofs_ishare_iget - find the backing inode.
+ */
+struct inode *erofs_ishare_iget(struct inode *inode)
+{
+	struct erofs_inode *vi, *vi_dedup;
+	struct inode *realinode;
+
+	if (!erofs_is_ishare_inode(inode))
+		return igrab(inode);
+
+	vi_dedup = EROFS_I(inode);
+	spin_lock(&vi_dedup->lock);
+	/* try processing inodes first */
+	if (!list_empty(&vi_dedup->processing_head)) {
+		list_for_each_entry(vi, &vi_dedup->processing_head,
+				    processing_link) {
+			realinode = igrab(&vi->vfs_inode);
+			if (realinode) {
+				spin_unlock(&vi_dedup->lock);
+				return realinode;
+			}
+		}
+	}
+
+	/* fall back to all backing inodes */
+	DBG_BUGON(list_empty(&vi_dedup->backing_head));
+	list_for_each_entry(vi, &vi_dedup->backing_head, backing_link) {
+		realinode = igrab(&vi->vfs_inode);
+		if (realinode)
+			break;
+	}
+	spin_unlock(&vi_dedup->lock);
+
+	DBG_BUGON(!realinode);
+	return realinode;
+}
+
+void erofs_ishare_iput(struct inode *realinode)
+{
+	iput(realinode);
+}
diff --git a/fs/erofs/ishare.h b/fs/erofs/ishare.h
index 54f2251c8179..b85fa240507b 100644
--- a/fs/erofs/ishare.h
+++ b/fs/erofs/ishare.h
@@ -9,6 +9,11 @@
 #include <linux/spinlock.h>
 #include "internal.h"
 
+struct erofs_read_ctx {
+	struct file *file; /* may be NULL */
+	struct inode *inode;
+};
+
 #ifdef CONFIG_EROFS_FS_INODE_SHARE
 
 int erofs_ishare_init(struct super_block *sb);
@@ -16,6 +21,13 @@ void erofs_ishare_exit(struct super_block *sb);
 bool erofs_ishare_fill_inode(struct inode *inode);
 void erofs_ishare_free_inode(struct inode *inode);
 
+/* read/readahead */
+void erofs_read_begin(struct erofs_read_ctx *rdctx);
+void erofs_read_end(struct erofs_read_ctx *rdctx);
+
+struct inode *erofs_ishare_iget(struct inode *inode);
+void erofs_ishare_iput(struct inode *realinode);
+
 #else
 
 static inline int erofs_ishare_init(struct super_block *sb) { return 0; }
@@ -23,6 +35,12 @@ static inline void erofs_ishare_exit(struct super_block *sb) {}
 static inline bool erofs_ishare_fill_inode(struct inode *inode) { return false; }
 static inline void erofs_ishare_free_inode(struct inode *inode) {}
 
+static inline void erofs_read_begin(struct erofs_read_ctx *rdctx) {}
+static inline void erofs_read_end(struct erofs_read_ctx *rdctx) {}
+
+static inline struct inode *erofs_ishare_iget(struct inode *inode) { return inode; }
+static inline void erofs_ishare_iput(struct inode *realinode) {}
+
 #endif // CONFIG_EROFS_FS_INODE_SHARE
 
 #endif
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 613dfbe988de..2af82171dd78 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -82,10 +82,6 @@ static void erofs_free_inode(struct inode *inode)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
 
-	if (erofs_is_ishare_inode(inode)) {
-		erofs_free_dedup_inode(vi);
-		return;
-	}
 	if (inode->i_op == &erofs_fast_symlink_iops)
 		kfree(inode->i_link);
 	kfree(vi->xattr_shared_xattrs);
@@ -753,6 +749,10 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
+	err = erofs_ishare_init(sb);
+	if (err)
+		return err;
+
 	sbi->dir_ra_bytes = EROFS_DIR_RA_BYTES;
 	erofs_info(sb, "mounted with root inode @ nid %llu.", sbi->root_nid);
 	return 0;
@@ -902,6 +902,7 @@ static void erofs_kill_sb(struct super_block *sb)
 		kill_anon_super(sb);
 	else
 		kill_block_super(sb);
+
 	erofs_drop_internal_inodes(sbi);
 	fs_put_dax(sbi->dif0.dax_dev, NULL);
 	erofs_fscache_unregister_fs(sb);
@@ -913,6 +914,7 @@ static void erofs_put_super(struct super_block *sb)
 {
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 
+	erofs_ishare_exit(sb);
 	erofs_unregister_sysfs(sb);
 	erofs_shrinker_unregister(sb);
 	erofs_xattr_prefixes_cleanup(sb);
@@ -1081,6 +1083,7 @@ static void erofs_evict_inode(struct inode *inode)
 		dax_break_layout_final(inode);
 #endif
 
+	erofs_ishare_free_inode(inode);
 	truncate_inode_pages_final(&inode->i_data);
 	clear_inode(inode);
 }
-- 
2.22.0


