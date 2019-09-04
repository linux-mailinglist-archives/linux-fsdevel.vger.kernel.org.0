Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70E97A7872
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 04:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfIDCKl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 22:10:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60186 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727949AbfIDCKk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 22:10:40 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0AD1CC69E5F9172E0EE3;
        Wed,  4 Sep 2019 10:10:39 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 4 Sep 2019
 10:10:25 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>, <devel@driverdev.osuosl.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 18/25] erofs: add "erofs_" prefix for common and short functions
Date:   Wed, 4 Sep 2019 10:09:05 +0800
Message-ID: <20190904020912.63925-19-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904020912.63925-1-gaoxiang25@huawei.com>
References: <20190901055130.30572-1-hsiangkao@aol.com>
 <20190904020912.63925-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add erofs_ prefix to free_inode, alloc_inode, ...

Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/data.c         |  4 ++--
 fs/erofs/decompressor.c | 22 +++++++++++-----------
 fs/erofs/inode.c        |  8 ++++----
 fs/erofs/internal.h     |  2 +-
 fs/erofs/namei.c        | 12 ++++++------
 fs/erofs/super.c        | 40 ++++++++++++++++++++--------------------
 fs/erofs/zdata.c        | 19 ++++++++++---------
 7 files changed, 54 insertions(+), 53 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 70b1e353756e..3ce87a88452a 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -9,7 +9,7 @@
 
 #include <trace/events/erofs.h>
 
-static inline void read_endio(struct bio *bio)
+static void erofs_readendio(struct bio *bio)
 {
 	struct super_block *const sb = bio->bi_private;
 	struct bio_vec *bvec;
@@ -45,7 +45,7 @@ static struct bio *erofs_grab_raw_bio(struct super_block *sb,
 {
 	struct bio *bio = bio_alloc(GFP_NOIO, nr_pages);
 
-	bio->bi_end_io = read_endio;
+	bio->bi_end_io = erofs_readendio;
 	bio_set_dev(bio, sb->s_bdev);
 	bio->bi_iter.bi_sector = (sector_t)blkaddr << LOG_SECTORS_PER_BLOCK;
 	bio->bi_private = sb;
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 555c04730f87..8ed38504a9f1 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -32,8 +32,8 @@ static bool use_vmap;
 module_param(use_vmap, bool, 0444);
 MODULE_PARM_DESC(use_vmap, "Use vmap() instead of vm_map_ram() (default 0)");
 
-static int lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
-				 struct list_head *pagepool)
+static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
+					 struct list_head *pagepool)
 {
 	const unsigned int nr =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
@@ -114,7 +114,7 @@ static void *generic_copy_inplace_data(struct z_erofs_decompress_req *rq,
 	return tmp;
 }
 
-static int lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
+static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 {
 	unsigned int inputmargin, inlen;
 	u8 *src;
@@ -188,8 +188,8 @@ static struct z_erofs_decompressor decompressors[] = {
 		.name = "shifted"
 	},
 	[Z_EROFS_COMPRESSION_LZ4] = {
-		.prepare_destpages = lz4_prepare_destpages,
-		.decompress = lz4_decompress,
+		.prepare_destpages = z_erofs_lz4_prepare_destpages,
+		.decompress = z_erofs_lz4_decompress,
 		.name = "lz4"
 	},
 };
@@ -247,8 +247,8 @@ static void erofs_vunmap(const void *mem, unsigned int count)
 		vunmap(mem);
 }
 
-static int decompress_generic(struct z_erofs_decompress_req *rq,
-			      struct list_head *pagepool)
+static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
+				      struct list_head *pagepool)
 {
 	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
@@ -308,8 +308,8 @@ static int decompress_generic(struct z_erofs_decompress_req *rq,
 	return ret;
 }
 
-static int shifted_decompress(const struct z_erofs_decompress_req *rq,
-			      struct list_head *pagepool)
+static int z_erofs_shifted_transform(const struct z_erofs_decompress_req *rq,
+				     struct list_head *pagepool)
 {
 	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
@@ -353,7 +353,7 @@ int z_erofs_decompress(struct z_erofs_decompress_req *rq,
 		       struct list_head *pagepool)
 {
 	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED)
-		return shifted_decompress(rq, pagepool);
-	return decompress_generic(rq, pagepool);
+		return z_erofs_shifted_transform(rq, pagepool);
+	return z_erofs_decompress_generic(rq, pagepool);
 }
 
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 8d496adbeaea..384905e0677c 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -9,7 +9,7 @@
 #include <trace/events/erofs.h>
 
 /* no locking */
-static int read_inode(struct inode *inode, void *data)
+static int erofs_read_inode(struct inode *inode, void *data)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
 	struct erofs_inode_compact *dic = data;
@@ -163,7 +163,7 @@ static int erofs_fill_symlink(struct inode *inode, void *data,
 	return 0;
 }
 
-static int fill_inode(struct inode *inode, int isdir)
+static int erofs_fill_inode(struct inode *inode, int isdir)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
 	struct erofs_inode *vi = EROFS_I(inode);
@@ -193,7 +193,7 @@ static int fill_inode(struct inode *inode, int isdir)
 	DBG_BUGON(!PageUptodate(page));
 	data = page_address(page);
 
-	err = read_inode(inode, data + ofs);
+	err = erofs_read_inode(inode, data + ofs);
 	if (!err) {
 		/* setup the new inode */
 		switch (inode->i_mode & S_IFMT) {
@@ -286,7 +286,7 @@ struct inode *erofs_iget(struct super_block *sb,
 
 		vi->nid = nid;
 
-		err = fill_inode(inode, isdir);
+		err = erofs_fill_inode(inode, isdir);
 		if (!err)
 			unlock_new_inode(inode);
 		else {
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 13c8d841c43a..881eb2ee18b5 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -308,7 +308,7 @@ struct erofs_inode {
 #define EROFS_I(ptr)	\
 	container_of(ptr, struct erofs_inode, vfs_inode)
 
-static inline unsigned long inode_datablocks(struct inode *inode)
+static inline unsigned long erofs_inode_datablocks(struct inode *inode)
 {
 	/* since i_size cannot be changed */
 	return DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index a6b6a4ab1403..6debc1d88282 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -14,9 +14,9 @@ struct erofs_qstr {
 };
 
 /* based on the end of qn is accurate and it must have the trailing '\0' */
-static inline int dirnamecmp(const struct erofs_qstr *qn,
-			     const struct erofs_qstr *qd,
-			     unsigned int *matched)
+static inline int erofs_dirnamecmp(const struct erofs_qstr *qn,
+				   const struct erofs_qstr *qd,
+				   unsigned int *matched)
 {
 	unsigned int i = *matched;
 
@@ -71,7 +71,7 @@ static struct erofs_dirent *find_target_dirent(struct erofs_qstr *name,
 		};
 
 		/* string comparison without already matched prefix */
-		int ret = dirnamecmp(name, &dname, &matched);
+		int ret = erofs_dirnamecmp(name, &dname, &matched);
 
 		if (!ret) {
 			return de + mid;
@@ -98,7 +98,7 @@ static struct page *find_target_block_classic(struct inode *dir,
 
 	startprfx = endprfx = 0;
 	head = 0;
-	back = inode_datablocks(dir) - 1;
+	back = erofs_inode_datablocks(dir) - 1;
 
 	while (head <= back) {
 		const int mid = head + (back - head) / 2;
@@ -134,7 +134,7 @@ static struct page *find_target_block_classic(struct inode *dir,
 							  EROFS_BLKSIZ);
 
 			/* string comparison without already matched prefix */
-			diff = dirnamecmp(name, &dname, &matched);
+			diff = erofs_dirnamecmp(name, &dname, &matched);
 			kunmap_atomic(de);
 
 			if (!diff) {
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index b64d69f18270..36e569a79172 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -16,14 +16,14 @@
 
 static struct kmem_cache *erofs_inode_cachep __read_mostly;
 
-static void init_once(void *ptr)
+static void erofs_inode_init_once(void *ptr)
 {
 	struct erofs_inode *vi = ptr;
 
 	inode_init_once(&vi->vfs_inode);
 }
 
-static struct inode *alloc_inode(struct super_block *sb)
+static struct inode *erofs_alloc_inode(struct super_block *sb)
 {
 	struct erofs_inode *vi =
 		kmem_cache_alloc(erofs_inode_cachep, GFP_KERNEL);
@@ -36,7 +36,7 @@ static struct inode *alloc_inode(struct super_block *sb)
 	return &vi->vfs_inode;
 }
 
-static void free_inode(struct inode *inode)
+static void erofs_free_inode(struct inode *inode)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
 
@@ -64,7 +64,7 @@ static bool check_layout_compatibility(struct super_block *sb,
 	return true;
 }
 
-static int superblock_read(struct super_block *sb)
+static int erofs_read_superblock(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi;
 	struct buffer_head *bh;
@@ -218,7 +218,7 @@ static int erofs_build_cache_strategy(struct erofs_sb_info *sbi,
 #endif
 
 /* set up default EROFS parameters */
-static void default_options(struct erofs_sb_info *sbi)
+static void erofs_default_options(struct erofs_sb_info *sbi)
 {
 #ifdef CONFIG_EROFS_FS_ZIP
 	sbi->cache_strategy = EROFS_ZIP_CACHE_READAROUND;
@@ -252,7 +252,7 @@ static match_table_t erofs_tokens = {
 	{Opt_err, NULL}
 };
 
-static int parse_options(struct super_block *sb, char *options)
+static int erofs_parse_options(struct super_block *sb, char *options)
 {
 	substring_t args[MAX_OPT_ARGS];
 	char *p;
@@ -322,7 +322,7 @@ static int parse_options(struct super_block *sb, char *options)
 #ifdef CONFIG_EROFS_FS_ZIP
 static const struct address_space_operations managed_cache_aops;
 
-static int managed_cache_releasepage(struct page *page, gfp_t gfp_mask)
+static int erofs_managed_cache_releasepage(struct page *page, gfp_t gfp_mask)
 {
 	int ret = 1;	/* 0 - busy */
 	struct address_space *const mapping = page->mapping;
@@ -336,9 +336,9 @@ static int managed_cache_releasepage(struct page *page, gfp_t gfp_mask)
 	return ret;
 }
 
-static void managed_cache_invalidatepage(struct page *page,
-					 unsigned int offset,
-					 unsigned int length)
+static void erofs_managed_cache_invalidatepage(struct page *page,
+					       unsigned int offset,
+					       unsigned int length)
 {
 	const unsigned int stop = length + offset;
 
@@ -348,13 +348,13 @@ static void managed_cache_invalidatepage(struct page *page,
 	DBG_BUGON(stop > PAGE_SIZE || stop < length);
 
 	if (offset == 0 && stop == PAGE_SIZE)
-		while (!managed_cache_releasepage(page, GFP_NOFS))
+		while (!erofs_managed_cache_releasepage(page, GFP_NOFS))
 			cond_resched();
 }
 
 static const struct address_space_operations managed_cache_aops = {
-	.releasepage = managed_cache_releasepage,
-	.invalidatepage = managed_cache_invalidatepage,
+	.releasepage = erofs_managed_cache_releasepage,
+	.invalidatepage = erofs_managed_cache_invalidatepage,
 };
 
 static int erofs_init_managed_cache(struct super_block *sb)
@@ -396,7 +396,7 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
 		return -ENOMEM;
 
 	sb->s_fs_info = sbi;
-	err = superblock_read(sb);
+	err = erofs_read_superblock(sb);
 	if (err)
 		return err;
 
@@ -410,9 +410,9 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_xattr = erofs_xattr_handlers;
 #endif
 	/* set erofs default mount options */
-	default_options(sbi);
+	erofs_default_options(sbi);
 
-	err = parse_options(sb, data);
+	err = erofs_parse_options(sb, data);
 	if (err)
 		return err;
 
@@ -512,7 +512,7 @@ static int __init erofs_module_init(void)
 	erofs_inode_cachep = kmem_cache_create("erofs_inode",
 					       sizeof(struct erofs_inode), 0,
 					       SLAB_RECLAIM_ACCOUNT,
-					       init_once);
+					       erofs_inode_init_once);
 	if (!erofs_inode_cachep) {
 		err = -ENOMEM;
 		goto icache_err;
@@ -619,7 +619,7 @@ static int erofs_remount(struct super_block *sb, int *flags, char *data)
 	int err;
 
 	DBG_BUGON(!sb_rdonly(sb));
-	err = parse_options(sb, data);
+	err = erofs_parse_options(sb, data);
 	if (err)
 		goto out;
 
@@ -639,8 +639,8 @@ static int erofs_remount(struct super_block *sb, int *flags, char *data)
 
 const struct super_operations erofs_sops = {
 	.put_super = erofs_put_super,
-	.alloc_inode = alloc_inode,
-	.free_inode = free_inode,
+	.alloc_inode = erofs_alloc_inode,
+	.free_inode = erofs_free_inode,
 	.statfs = erofs_statfs,
 	.show_options = erofs_show_options,
 	.remount_fs = erofs_remount,
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 3010fa3d1ac3..8587d6751c48 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -40,7 +40,7 @@ void z_erofs_exit_zip_subsystem(void)
 	kmem_cache_destroy(pcluster_cachep);
 }
 
-static inline int init_unzip_workqueue(void)
+static inline int z_erofs_init_workqueue(void)
 {
 	const unsigned int onlinecpus = num_possible_cpus();
 	const unsigned int flags = WQ_UNBOUND | WQ_HIGHPRI | WQ_CPU_INTENSIVE;
@@ -54,7 +54,7 @@ static inline int init_unzip_workqueue(void)
 	return z_erofs_workqueue ? 0 : -ENOMEM;
 }
 
-static void init_once(void *ptr)
+static void z_erofs_pcluster_init_once(void *ptr)
 {
 	struct z_erofs_pcluster *pcl = ptr;
 	struct z_erofs_collection *cl = z_erofs_primarycollection(pcl);
@@ -67,7 +67,7 @@ static void init_once(void *ptr)
 		pcl->compressed_pages[i] = NULL;
 }
 
-static void init_always(struct z_erofs_pcluster *pcl)
+static void z_erofs_pcluster_init_always(struct z_erofs_pcluster *pcl)
 {
 	struct z_erofs_collection *cl = z_erofs_primarycollection(pcl);
 
@@ -81,9 +81,10 @@ int __init z_erofs_init_zip_subsystem(void)
 {
 	pcluster_cachep = kmem_cache_create("erofs_compress",
 					    Z_EROFS_WORKGROUP_SIZE, 0,
-					    SLAB_RECLAIM_ACCOUNT, init_once);
+					    SLAB_RECLAIM_ACCOUNT,
+					    z_erofs_pcluster_init_once);
 	if (pcluster_cachep) {
-		if (!init_unzip_workqueue())
+		if (!z_erofs_init_workqueue())
 			return 0;
 
 		kmem_cache_destroy(pcluster_cachep);
@@ -272,8 +273,8 @@ int erofs_try_to_free_cached_page(struct address_space *mapping,
 }
 
 /* page_type must be Z_EROFS_PAGE_TYPE_EXCLUSIVE */
-static inline bool try_inplace_io(struct z_erofs_collector *clt,
-				  struct page *page)
+static inline bool z_erofs_try_inplace_io(struct z_erofs_collector *clt,
+					  struct page *page)
 {
 	struct z_erofs_pcluster *const pcl = clt->pcl;
 	const unsigned int clusterpages = BIT(pcl->clusterbits);
@@ -296,7 +297,7 @@ static int z_erofs_attach_page(struct z_erofs_collector *clt,
 	/* give priority for inplaceio */
 	if (clt->mode >= COLLECT_PRIMARY &&
 	    type == Z_EROFS_PAGE_TYPE_EXCLUSIVE &&
-	    try_inplace_io(clt, page))
+	    z_erofs_try_inplace_io(clt, page))
 		return 0;
 
 	ret = z_erofs_pagevec_enqueue(&clt->vector,
@@ -409,7 +410,7 @@ static struct z_erofs_collection *clregister(struct z_erofs_collector *clt,
 	if (!pcl)
 		return ERR_PTR(-ENOMEM);
 
-	init_always(pcl);
+	z_erofs_pcluster_init_always(pcl);
 	pcl->obj.index = map->m_pa >> PAGE_SHIFT;
 
 	pcl->length = (map->m_llen << Z_EROFS_PCLUSTER_LENGTH_BIT) |
-- 
2.17.1

