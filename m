Return-Path: <linux-fsdevel+bounces-74094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 993ABD2F4D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 11:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39A163076F18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 10:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B85635EDD9;
	Fri, 16 Jan 2026 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="H0/fNF4h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4145B35F8C7;
	Fri, 16 Jan 2026 10:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768558140; cv=none; b=aOmey+0Klm/17+lvyT0Kh6xAOoO8DjqIkGwoDAV/NJ5ZLO1v4VwAxQASLuB3m7JJOtuPJpjf7jIH7qOFUHDlET9+HiA6EiVve6rGPNqqwi88Xp2lz3EXAPLSllaN5yaysjcVtC6TDzYYuGYBkDADSPaoyRrXrlO+eJ+0LNd5hh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768558140; c=relaxed/simple;
	bh=Y4+k2W4PvoiQR0mAU4aBnFx1KuJtI3DhdaRPnAxwKIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FVZE42sTrrzC9bxh6PnQQ2yzf9KALwJFdRVgnERZ63SQaeMo6IJX4L/gi9phPB52KZ5L8w0pXU3jdvqMWG01O7qqdQfs4DkixyYr6hkdagcuMWM82XrJcHHCGw9NiX7xKJCkFzGsNNT0dWFxe+j87lwSVNtCnLBC4HRGChP0qjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=H0/fNF4h; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=w5l/foA3H/NaILmQeWPwMekoYDv7cqxU2HTgGg9vx6c=;
	b=H0/fNF4hpN+0SC2rSuMO2cBtZBmjBEWbbtlzbt9MRdJkoQ44j6HPdSUvbbJYqJpJGmDF8RhNj
	PG/yJERC7MTXOKAAwoM0GBseLXOiNrO0DBmDH+42UkkLtBD4dmDtFbqGQ84e82XLTSZikTaa8YZ
	Xxr6Qxn7PM0jO+0+UXezd1k=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dswTg6jL8znTVZ;
	Fri, 16 Jan 2026 18:05:43 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id F41F040536;
	Fri, 16 Jan 2026 18:08:42 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 16 Jan
 2026 18:08:42 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v15 7/9] erofs: support unencoded inodes for page cache share
Date: Fri, 16 Jan 2026 09:55:48 +0000
Message-ID: <20260116095550.627082-8-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20260116095550.627082-1-lihongbo22@huawei.com>
References: <20260116095550.627082-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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
 fs/erofs/data.c     | 32 +++++++++++++++++++++++---------
 fs/erofs/fileio.c   | 25 ++++++++++++++++---------
 fs/erofs/inode.c    |  3 ++-
 fs/erofs/internal.h |  6 ++++++
 fs/erofs/ishare.c   | 34 ++++++++++++++++++++++++++++++++++
 5 files changed, 81 insertions(+), 19 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index ea198defb531..3a4eb0dececd 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -269,6 +269,7 @@ void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
 struct erofs_iomap_iter_ctx {
 	struct page *page;
 	void *base;
+	struct inode *realinode;
 };
 
 static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
@@ -276,14 +277,15 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 {
 	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
 	struct erofs_iomap_iter_ctx *ctx = iter->private;
-	struct super_block *sb = inode->i_sb;
+	struct inode *realinode = ctx ? ctx->realinode : inode;
+	struct super_block *sb = realinode->i_sb;
 	struct erofs_map_blocks map;
 	struct erofs_map_dev mdev;
 	int ret;
 
 	map.m_la = offset;
 	map.m_llen = length;
-	ret = erofs_map_blocks(inode, &map);
+	ret = erofs_map_blocks(realinode, &map);
 	if (ret < 0)
 		return ret;
 
@@ -296,7 +298,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		return 0;
 	}
 
-	if (!(map.m_flags & EROFS_MAP_META) || !erofs_inode_in_metabox(inode)) {
+	if (!(map.m_flags & EROFS_MAP_META) || !erofs_inode_in_metabox(realinode)) {
 		mdev = (struct erofs_map_dev) {
 			.m_deviceid = map.m_deviceid,
 			.m_pa = map.m_pa,
@@ -322,7 +324,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 			void *ptr;
 
 			ptr = erofs_read_metabuf(&buf, sb, map.m_pa,
-						 erofs_inode_in_metabox(inode));
+						 erofs_inode_in_metabox(realinode));
 			if (IS_ERR(ptr))
 				return PTR_ERR(ptr);
 			iomap->inline_data = ptr;
@@ -383,10 +385,15 @@ static int erofs_read_folio(struct file *file, struct folio *folio)
 		.ops		= &iomap_bio_read_ops,
 		.cur_folio	= folio,
 	};
-	struct erofs_iomap_iter_ctx iter_ctx = {};
+	bool need_iput;
+	struct erofs_iomap_iter_ctx iter_ctx = {
+		.realinode = erofs_real_inode(folio_inode(folio), &need_iput),
+	};
 
-	trace_erofs_read_folio(folio_inode(folio), folio, true);
+	trace_erofs_read_folio(iter_ctx.realinode, folio, true);
 	iomap_read_folio(&erofs_iomap_ops, &read_ctx, &iter_ctx);
+	if (need_iput)
+		iput(iter_ctx.realinode);
 	return 0;
 }
 
@@ -396,11 +403,16 @@ static void erofs_readahead(struct readahead_control *rac)
 		.ops		= &iomap_bio_read_ops,
 		.rac		= rac,
 	};
-	struct erofs_iomap_iter_ctx iter_ctx = {};
+	bool need_iput;
+	struct erofs_iomap_iter_ctx iter_ctx = {
+		.realinode = erofs_real_inode(rac->mapping->host, &need_iput),
+	};
 
-	trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
+	trace_erofs_readahead(iter_ctx.realinode, readahead_index(rac),
 			      readahead_count(rac), true);
 	iomap_readahead(&erofs_iomap_ops, &read_ctx, &iter_ctx);
+	if (need_iput)
+		iput(iter_ctx.realinode);
 }
 
 static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
@@ -421,7 +433,9 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		return dax_iomap_rw(iocb, to, &erofs_iomap_ops);
 #endif
 	if ((iocb->ki_flags & IOCB_DIRECT) && inode->i_sb->s_bdev) {
-		struct erofs_iomap_iter_ctx iter_ctx = {};
+		struct erofs_iomap_iter_ctx iter_ctx = {
+			.realinode = inode,
+		};
 
 		return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
 				    NULL, 0, &iter_ctx, 0);
diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index d07dc248d264..c1d0081609dc 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -88,9 +88,9 @@ void erofs_fileio_submit_bio(struct bio *bio)
 						   bio));
 }
 
-static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
+static int erofs_fileio_scan_folio(struct erofs_fileio *io,
+				   struct inode *inode, struct folio *folio)
 {
-	struct inode *inode = folio_inode(folio);
 	struct erofs_map_blocks *map = &io->map;
 	unsigned int cur = 0, end = folio_size(folio), len, attached = 0;
 	loff_t pos = folio_pos(folio), ofs;
@@ -158,31 +158,38 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
 
 static int erofs_fileio_read_folio(struct file *file, struct folio *folio)
 {
+	bool need_iput;
+	struct inode *realinode = erofs_real_inode(folio_inode(folio), &need_iput);
 	struct erofs_fileio io = {};
 	int err;
 
-	trace_erofs_read_folio(folio_inode(folio), folio, true);
-	err = erofs_fileio_scan_folio(&io, folio);
+	trace_erofs_read_folio(realinode, folio, true);
+	err = erofs_fileio_scan_folio(&io, realinode, folio);
 	erofs_fileio_rq_submit(io.rq);
+	if (need_iput)
+		iput(realinode);
 	return err;
 }
 
 static void erofs_fileio_readahead(struct readahead_control *rac)
 {
-	struct inode *inode = rac->mapping->host;
+	bool need_iput;
+	struct inode *realinode = erofs_real_inode(rac->mapping->host, &need_iput);
 	struct erofs_fileio io = {};
 	struct folio *folio;
 	int err;
 
-	trace_erofs_readahead(inode, readahead_index(rac),
+	trace_erofs_readahead(realinode, readahead_index(rac),
 			      readahead_count(rac), true);
 	while ((folio = readahead_folio(rac))) {
-		err = erofs_fileio_scan_folio(&io, folio);
+		err = erofs_fileio_scan_folio(&io, realinode, folio);
 		if (err && err != -EINTR)
-			erofs_err(inode->i_sb, "readahead error at folio %lu @ nid %llu",
-				  folio->index, EROFS_I(inode)->nid);
+			erofs_err(realinode->i_sb, "readahead error at folio %lu @ nid %llu",
+				  folio->index, EROFS_I(realinode)->nid);
 	}
 	erofs_fileio_rq_submit(io.rq);
+	if (need_iput)
+		iput(realinode);
 }
 
 const struct address_space_operations erofs_fileio_aops = {
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 202cbbb4eada..d33816cff813 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -213,7 +213,8 @@ static int erofs_fill_inode(struct inode *inode)
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFREG:
 		inode->i_op = &erofs_generic_iops;
-		inode->i_fop = &erofs_file_fops;
+		inode->i_fop = erofs_ishare_fill_inode(inode) ?
+			       &erofs_ishare_fops : &erofs_file_fops;
 		break;
 	case S_IFDIR:
 		inode->i_op = &erofs_dir_iops;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 15945e3308b8..d38e63e361c1 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -591,11 +591,17 @@ int __init erofs_init_ishare(void);
 void erofs_exit_ishare(void);
 bool erofs_ishare_fill_inode(struct inode *inode);
 void erofs_ishare_free_inode(struct inode *inode);
+struct inode *erofs_real_inode(struct inode *inode, bool *need_iput);
 #else
 static inline int erofs_init_ishare(void) { return 0; }
 static inline void erofs_exit_ishare(void) {}
 static inline bool erofs_ishare_fill_inode(struct inode *inode) { return false; }
 static inline void erofs_ishare_free_inode(struct inode *inode) {}
+static inline struct inode *erofs_real_inode(struct inode *inode, bool *need_iput)
+{
+	*need_iput = false;
+	return inode;
+}
 #endif
 
 long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index 6b710c935afb..affa34ac5b2e 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -11,6 +11,12 @@
 
 static struct vfsmount *erofs_ishare_mnt;
 
+static inline bool erofs_is_ishare_inode(struct inode *inode)
+{
+	/* assumed FS_ONDEMAND is excluded with FS_PAGE_CACHE_SHARE feature */
+	return inode->i_sb->s_type == &erofs_anon_fs_type;
+}
+
 static int erofs_ishare_iget5_eq(struct inode *inode, void *data)
 {
 	struct erofs_inode_fingerprint *fp1 = &EROFS_I(inode)->fingerprint;
@@ -38,6 +44,8 @@ bool erofs_ishare_fill_inode(struct inode *inode)
 	struct inode *sharedinode;
 	unsigned long hash;
 
+	if (erofs_inode_is_data_compressed(vi->datalayout))
+		return false;
 	if (erofs_xattr_fill_inode_fingerprint(&fp, inode, sbi->domain_id))
 		return false;
 	hash = xxh32(fp.opaque, fp.size, 0);
@@ -149,6 +157,32 @@ const struct file_operations erofs_ishare_fops = {
 	.splice_read	= filemap_splice_read,
 };
 
+struct inode *erofs_real_inode(struct inode *inode, bool *need_iput)
+{
+	struct erofs_inode *vi, *vi_share;
+	struct inode *realinode;
+
+	*need_iput = false;
+	if (!erofs_is_ishare_inode(inode))
+		return inode;
+
+	vi_share = EROFS_I(inode);
+	spin_lock(&vi_share->ishare_lock);
+	/* fetch any one as real inode */
+	DBG_BUGON(list_empty(&vi_share->ishare_list));
+	list_for_each_entry(vi, &vi_share->ishare_list, ishare_list) {
+		realinode = igrab(&vi->vfs_inode);
+		if (realinode) {
+			*need_iput = true;
+			break;
+		}
+	}
+	spin_unlock(&vi_share->ishare_lock);
+
+	DBG_BUGON(!realinode);
+	return realinode;
+}
+
 int __init erofs_init_ishare(void)
 {
 	erofs_ishare_mnt = kern_mount(&erofs_anon_fs_type);
-- 
2.22.0


