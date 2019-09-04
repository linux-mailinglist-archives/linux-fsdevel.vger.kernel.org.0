Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB902A7865
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 04:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfIDCK2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 22:10:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59892 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727891AbfIDCK1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 22:10:27 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 78FD46BE553995AD2095;
        Wed,  4 Sep 2019 10:10:25 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 4 Sep 2019
 10:10:14 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>, <devel@driverdev.osuosl.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 09/25] erofs: use erofs_inode naming
Date:   Wed, 4 Sep 2019 10:08:56 +0800
Message-ID: <20190904020912.63925-10-gaoxiang25@huawei.com>
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

As Christoph suggested [1], "Why is this called vnode instead
of inode?  That seems like a rather odd naming for a Linux
file system."

[1] https://lore.kernel.org/r/20190829101545.GC20598@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/data.c              |  8 ++++----
 fs/erofs/dir.c               |  6 +++---
 fs/erofs/inode.c             | 12 ++++++------
 fs/erofs/internal.h          | 14 +++++++-------
 fs/erofs/namei.c             |  2 +-
 fs/erofs/super.c             | 10 +++++-----
 fs/erofs/xattr.c             | 18 +++++++++---------
 fs/erofs/xattr.h             |  4 ++--
 fs/erofs/zdata.c             |  9 +++------
 fs/erofs/zmap.c              | 28 ++++++++++++++--------------
 include/trace/events/erofs.h | 14 +++++++-------
 11 files changed, 61 insertions(+), 64 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 4d9b07991d07..be11b5ea9d2e 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -112,7 +112,7 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 	int err = 0;
 	erofs_blk_t nblocks, lastblk;
 	u64 offset = map->m_la;
-	struct erofs_vnode *vi = EROFS_V(inode);
+	struct erofs_inode *vi = EROFS_I(inode);
 	bool tailendpacking = (vi->datalayout == EROFS_INODE_FLAT_INLINE);
 
 	trace_erofs_map_blocks_flatmode_enter(inode, map, flags);
@@ -170,7 +170,7 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 int erofs_map_blocks(struct inode *inode,
 		     struct erofs_map_blocks *map, int flags)
 {
-	if (erofs_inode_is_data_compressed(EROFS_V(inode)->datalayout)) {
+	if (erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout)) {
 		int err = z_erofs_map_blocks_iter(inode, map, flags);
 
 		if (map->mpage) {
@@ -365,7 +365,7 @@ static int erofs_raw_access_readpages(struct file *filp,
 			if (IS_ERR(bio)) {
 				pr_err("%s, readahead error at page %lu of nid %llu\n",
 				       __func__, page->index,
-				       EROFS_V(mapping->host)->nid);
+				       EROFS_I(mapping->host)->nid);
 
 				bio = NULL;
 			}
@@ -404,7 +404,7 @@ static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
 {
 	struct inode *inode = mapping->host;
 
-	if (EROFS_V(inode)->datalayout == EROFS_INODE_FLAT_INLINE) {
+	if (EROFS_I(inode)->datalayout == EROFS_INODE_FLAT_INLINE) {
 		erofs_blk_t blks = i_size_read(inode) >> LOG_BLOCK_SIZE;
 
 		if (block >> LOG_SECTORS_PER_BLOCK >= blks)
diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index 6a5b43f7fb29..a032c8217071 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -47,7 +47,7 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
 		/* a corrupted entry is found */
 		if (nameoff + de_namelen > maxsize ||
 		    de_namelen > EROFS_NAME_LEN) {
-			errln("bogus dirent @ nid %llu", EROFS_V(dir)->nid);
+			errln("bogus dirent @ nid %llu", EROFS_I(dir)->nid);
 			DBG_BUGON(1);
 			return -EFSCORRUPTED;
 		}
@@ -85,7 +85,7 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 			break;
 		} else if (IS_ERR(dentry_page)) {
 			errln("fail to readdir of logical block %u of nid %llu",
-			      i, EROFS_V(dir)->nid);
+			      i, EROFS_I(dir)->nid);
 			err = -EFSCORRUPTED;
 			break;
 		}
@@ -97,7 +97,7 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 		if (nameoff < sizeof(struct erofs_dirent) ||
 		    nameoff >= PAGE_SIZE) {
 			errln("%s, invalid de[0].nameoff %u @ nid %llu",
-			      __func__, nameoff, EROFS_V(dir)->nid);
+			      __func__, nameoff, EROFS_I(dir)->nid);
 			err = -EFSCORRUPTED;
 			goto skip_this;
 		}
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 494b35e5830a..f6dfd0271261 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -11,7 +11,7 @@
 /* no locking */
 static int read_inode(struct inode *inode, void *data)
 {
-	struct erofs_vnode *vi = EROFS_V(inode);
+	struct erofs_inode *vi = EROFS_I(inode);
 	struct erofs_inode_compact *dic = data;
 	struct erofs_inode_extended *die;
 
@@ -140,7 +140,7 @@ static int read_inode(struct inode *inode, void *data)
 static int fill_inline_data(struct inode *inode, void *data,
 			    unsigned int m_pofs)
 {
-	struct erofs_vnode *vi = EROFS_V(inode);
+	struct erofs_inode *vi = EROFS_I(inode);
 	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
 
 	/* should be tail-packing data inline */
@@ -178,7 +178,7 @@ static int fill_inline_data(struct inode *inode, void *data,
 static int fill_inode(struct inode *inode, int isdir)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
-	struct erofs_vnode *vi = EROFS_V(inode);
+	struct erofs_inode *vi = EROFS_I(inode);
 	struct page *page;
 	void *data;
 	int err;
@@ -260,7 +260,7 @@ static int erofs_ilookup_test_actor(struct inode *inode, void *opaque)
 {
 	const erofs_nid_t nid = *(erofs_nid_t *)opaque;
 
-	return EROFS_V(inode)->nid == nid;
+	return EROFS_I(inode)->nid == nid;
 }
 
 static int erofs_iget_set_actor(struct inode *inode, void *opaque)
@@ -297,7 +297,7 @@ struct inode *erofs_iget(struct super_block *sb,
 
 	if (inode->i_state & I_NEW) {
 		int err;
-		struct erofs_vnode *vi = EROFS_V(inode);
+		struct erofs_inode *vi = EROFS_I(inode);
 
 		vi->nid = nid;
 
@@ -317,7 +317,7 @@ int erofs_getattr(const struct path *path, struct kstat *stat,
 {
 	struct inode *const inode = d_inode(path->dentry);
 
-	if (erofs_inode_is_data_compressed(EROFS_V(inode)->datalayout))
+	if (erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout))
 		stat->attributes |= STATX_ATTR_COMPRESSED;
 
 	stat->attributes |= STATX_ATTR_IMMUTABLE;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 0f5cbf0a7570..10497ee07cae 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -272,14 +272,14 @@ static inline erofs_off_t iloc(struct erofs_sb_info *sbi, erofs_nid_t nid)
 }
 
 /* atomic flag definitions */
-#define EROFS_V_EA_INITED_BIT	0
-#define EROFS_V_Z_INITED_BIT	1
+#define EROFS_I_EA_INITED_BIT	0
+#define EROFS_I_Z_INITED_BIT	1
 
 /* bitlock definitions (arranged in reverse order) */
-#define EROFS_V_BL_XATTR_BIT	(BITS_PER_LONG - 1)
-#define EROFS_V_BL_Z_BIT	(BITS_PER_LONG - 2)
+#define EROFS_I_BL_XATTR_BIT	(BITS_PER_LONG - 1)
+#define EROFS_I_BL_Z_BIT	(BITS_PER_LONG - 2)
 
-struct erofs_vnode {
+struct erofs_inode {
 	erofs_nid_t nid;
 
 	/* atomic flags (including bitlocks) */
@@ -307,8 +307,8 @@ struct erofs_vnode {
 	struct inode vfs_inode;
 };
 
-#define EROFS_V(ptr)	\
-	container_of(ptr, struct erofs_vnode, vfs_inode)
+#define EROFS_I(ptr)	\
+	container_of(ptr, struct erofs_inode, vfs_inode)
 
 static inline unsigned long inode_datablocks(struct inode *inode)
 {
diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index c1068ad0535e..a6b6a4ab1403 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -117,7 +117,7 @@ static struct page *find_target_block_classic(struct inode *dir,
 				kunmap_atomic(de);
 				put_page(page);
 				errln("corrupted dir block %d @ nid %llu",
-				      mid, EROFS_V(dir)->nid);
+				      mid, EROFS_I(dir)->nid);
 				DBG_BUGON(1);
 				page = ERR_PTR(-EFSCORRUPTED);
 				goto out;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 499dc7f5d0e6..3986be582dbb 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -18,27 +18,27 @@ static struct kmem_cache *erofs_inode_cachep __read_mostly;
 
 static void init_once(void *ptr)
 {
-	struct erofs_vnode *vi = ptr;
+	struct erofs_inode *vi = ptr;
 
 	inode_init_once(&vi->vfs_inode);
 }
 
 static struct inode *alloc_inode(struct super_block *sb)
 {
-	struct erofs_vnode *vi =
+	struct erofs_inode *vi =
 		kmem_cache_alloc(erofs_inode_cachep, GFP_KERNEL);
 
 	if (!vi)
 		return NULL;
 
 	/* zero out everything except vfs_inode */
-	memset(vi, 0, offsetof(struct erofs_vnode, vfs_inode));
+	memset(vi, 0, offsetof(struct erofs_inode, vfs_inode));
 	return &vi->vfs_inode;
 }
 
 static void free_inode(struct inode *inode)
 {
-	struct erofs_vnode *vi = EROFS_V(inode);
+	struct erofs_inode *vi = EROFS_I(inode);
 
 	/* be careful RCU symlink path (see ext4_inode_info->i_data)! */
 	if (is_inode_fast_symlink(inode))
@@ -517,7 +517,7 @@ static int __init erofs_module_init(void)
 	infoln("initializing erofs " EROFS_VERSION);
 
 	erofs_inode_cachep = kmem_cache_create("erofs_inode",
-					       sizeof(struct erofs_vnode), 0,
+					       sizeof(struct erofs_inode), 0,
 					       SLAB_RECLAIM_ACCOUNT,
 					       init_once);
 	if (!erofs_inode_cachep) {
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 620cbc15f4d0..d5b7fe0bee45 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -38,7 +38,7 @@ static inline void xattr_iter_end_final(struct xattr_iter *it)
 
 static int init_inode_xattrs(struct inode *inode)
 {
-	struct erofs_vnode *const vi = EROFS_V(inode);
+	struct erofs_inode *const vi = EROFS_I(inode);
 	struct xattr_iter it;
 	unsigned int i;
 	struct erofs_xattr_ibody_header *ih;
@@ -48,14 +48,14 @@ static int init_inode_xattrs(struct inode *inode)
 	int ret = 0;
 
 	/* the most case is that xattrs of this inode are initialized. */
-	if (test_bit(EROFS_V_EA_INITED_BIT, &vi->flags))
+	if (test_bit(EROFS_I_EA_INITED_BIT, &vi->flags))
 		return 0;
 
-	if (wait_on_bit_lock(&vi->flags, EROFS_V_BL_XATTR_BIT, TASK_KILLABLE))
+	if (wait_on_bit_lock(&vi->flags, EROFS_I_BL_XATTR_BIT, TASK_KILLABLE))
 		return -ERESTARTSYS;
 
 	/* someone has initialized xattrs for us? */
-	if (test_bit(EROFS_V_EA_INITED_BIT, &vi->flags))
+	if (test_bit(EROFS_I_EA_INITED_BIT, &vi->flags))
 		goto out_unlock;
 
 	/*
@@ -136,10 +136,10 @@ static int init_inode_xattrs(struct inode *inode)
 	}
 	xattr_iter_end(&it, atomic_map);
 
-	set_bit(EROFS_V_EA_INITED_BIT, &vi->flags);
+	set_bit(EROFS_I_EA_INITED_BIT, &vi->flags);
 
 out_unlock:
-	clear_and_wake_up_bit(EROFS_V_BL_XATTR_BIT, &vi->flags);
+	clear_and_wake_up_bit(EROFS_I_BL_XATTR_BIT, &vi->flags);
 	return ret;
 }
 
@@ -184,7 +184,7 @@ static inline int xattr_iter_fixup(struct xattr_iter *it)
 static int inline_xattr_iter_begin(struct xattr_iter *it,
 				   struct inode *inode)
 {
-	struct erofs_vnode *const vi = EROFS_V(inode);
+	struct erofs_inode *const vi = EROFS_I(inode);
 	struct erofs_sb_info *const sbi = EROFS_SB(inode->i_sb);
 	unsigned int xattr_header_sz, inline_xattr_ofs;
 
@@ -385,7 +385,7 @@ static int inline_getxattr(struct inode *inode, struct getxattr_iter *it)
 
 static int shared_getxattr(struct inode *inode, struct getxattr_iter *it)
 {
-	struct erofs_vnode *const vi = EROFS_V(inode);
+	struct erofs_inode *const vi = EROFS_I(inode);
 	struct super_block *const sb = inode->i_sb;
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 	unsigned int i;
@@ -608,7 +608,7 @@ static int inline_listxattr(struct listxattr_iter *it)
 static int shared_listxattr(struct listxattr_iter *it)
 {
 	struct inode *const inode = d_inode(it->dentry);
-	struct erofs_vnode *const vi = EROFS_V(inode);
+	struct erofs_inode *const vi = EROFS_I(inode);
 	struct super_block *const sb = inode->i_sb;
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 	unsigned int i;
diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
index c5ca47d814dd..3585b84d2f20 100644
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -16,8 +16,8 @@
 
 static inline unsigned int inlinexattr_header_size(struct inode *inode)
 {
-	return sizeof(struct erofs_xattr_ibody_header)
-		+ sizeof(u32) * EROFS_V(inode)->xattr_shared_count;
+	return sizeof(struct erofs_xattr_ibody_header) +
+		sizeof(u32) * EROFS_I(inode)->xattr_shared_count;
 }
 
 static inline erofs_blk_t xattrblock_addr(struct erofs_sb_info *sbi,
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 653bde0a619a..f06a2fad7af2 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -421,7 +421,7 @@ static struct z_erofs_collection *clregister(struct z_erofs_collector *clt,
 	else
 		pcl->algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
 
-	pcl->clusterbits = EROFS_V(inode)->z_physical_clusterbits[0];
+	pcl->clusterbits = EROFS_I(inode)->z_physical_clusterbits[0];
 	pcl->clusterbits -= PAGE_SHIFT;
 
 	/* new pclusters should be claimed as type 1, primary and followed */
@@ -1404,12 +1404,9 @@ static int z_erofs_vle_normalaccess_readpages(struct file *filp,
 		head = (void *)page_private(page);
 
 		err = z_erofs_do_read_page(&f, page, &pagepool);
-		if (err) {
-			struct erofs_vnode *vi = EROFS_V(inode);
-
+		if (err)
 			errln("%s, readahead error at page %lu of nid %llu",
-			      __func__, page->index, vi->nid);
-		}
+			      __func__, page->index, EROFS_I(inode)->nid);
 		put_page(page);
 	}
 
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 6a06fb80ef3f..30a5171637d7 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -10,7 +10,7 @@
 
 int z_erofs_fill_inode(struct inode *inode)
 {
-	struct erofs_vnode *const vi = EROFS_V(inode);
+	struct erofs_inode *const vi = EROFS_I(inode);
 
 	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
 		vi->z_advise = 0;
@@ -19,7 +19,7 @@ int z_erofs_fill_inode(struct inode *inode)
 		vi->z_logical_clusterbits = LOG_BLOCK_SIZE;
 		vi->z_physical_clusterbits[0] = vi->z_logical_clusterbits;
 		vi->z_physical_clusterbits[1] = vi->z_logical_clusterbits;
-		set_bit(EROFS_V_Z_INITED_BIT, &vi->flags);
+		set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
 	}
 
 	inode->i_mapping->a_ops = &z_erofs_vle_normalaccess_aops;
@@ -28,7 +28,7 @@ int z_erofs_fill_inode(struct inode *inode)
 
 static int fill_inode_lazy(struct inode *inode)
 {
-	struct erofs_vnode *const vi = EROFS_V(inode);
+	struct erofs_inode *const vi = EROFS_I(inode);
 	struct super_block *const sb = inode->i_sb;
 	int err;
 	erofs_off_t pos;
@@ -36,14 +36,14 @@ static int fill_inode_lazy(struct inode *inode)
 	void *kaddr;
 	struct z_erofs_map_header *h;
 
-	if (test_bit(EROFS_V_Z_INITED_BIT, &vi->flags))
+	if (test_bit(EROFS_I_Z_INITED_BIT, &vi->flags))
 		return 0;
 
-	if (wait_on_bit_lock(&vi->flags, EROFS_V_BL_Z_BIT, TASK_KILLABLE))
+	if (wait_on_bit_lock(&vi->flags, EROFS_I_BL_Z_BIT, TASK_KILLABLE))
 		return -ERESTARTSYS;
 
 	err = 0;
-	if (test_bit(EROFS_V_Z_INITED_BIT, &vi->flags))
+	if (test_bit(EROFS_I_Z_INITED_BIT, &vi->flags))
 		goto out_unlock;
 
 	DBG_BUGON(vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
@@ -83,13 +83,13 @@ static int fill_inode_lazy(struct inode *inode)
 
 	vi->z_physical_clusterbits[1] = vi->z_logical_clusterbits +
 					((h->h_clusterbits >> 5) & 7);
-	set_bit(EROFS_V_Z_INITED_BIT, &vi->flags);
+	set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
 unmap_done:
 	kunmap_atomic(kaddr);
 	unlock_page(page);
 	put_page(page);
 out_unlock:
-	clear_and_wake_up_bit(EROFS_V_BL_Z_BIT, &vi->flags);
+	clear_and_wake_up_bit(EROFS_I_BL_Z_BIT, &vi->flags);
 	return err;
 }
 
@@ -142,7 +142,7 @@ static int vle_legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 					     unsigned long lcn)
 {
 	struct inode *const inode = m->inode;
-	struct erofs_vnode *const vi = EROFS_V(inode);
+	struct erofs_inode *const vi = EROFS_I(inode);
 	const erofs_off_t ibase = iloc(EROFS_I_SB(inode), vi->nid);
 	const erofs_off_t pos =
 		Z_EROFS_VLE_LEGACY_INDEX_ALIGN(ibase + vi->inode_isize +
@@ -196,7 +196,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 				  unsigned int amortizedshift,
 				  unsigned int eofs)
 {
-	struct erofs_vnode *const vi = EROFS_V(m->inode);
+	struct erofs_inode *const vi = EROFS_I(m->inode);
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
 	const unsigned int lomask = (1 << lclusterbits) - 1;
 	unsigned int vcnt, base, lo, encodebits, nblk;
@@ -260,7 +260,7 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 					    unsigned long lcn)
 {
 	struct inode *const inode = m->inode;
-	struct erofs_vnode *const vi = EROFS_V(inode);
+	struct erofs_inode *const vi = EROFS_I(inode);
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
 	const erofs_off_t ebase = ALIGN(iloc(EROFS_I_SB(inode), vi->nid) +
 					vi->inode_isize + vi->xattr_isize, 8) +
@@ -314,7 +314,7 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 static int vle_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 				      unsigned int lcn)
 {
-	const unsigned int datamode = EROFS_V(m->inode)->datalayout;
+	const unsigned int datamode = EROFS_I(m->inode)->datalayout;
 
 	if (datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY)
 		return vle_legacy_load_cluster_from_disk(m, lcn);
@@ -328,7 +328,7 @@ static int vle_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 static int vle_extent_lookback(struct z_erofs_maprecorder *m,
 			       unsigned int lookback_distance)
 {
-	struct erofs_vnode *const vi = EROFS_V(m->inode);
+	struct erofs_inode *const vi = EROFS_I(m->inode);
 	struct erofs_map_blocks *const map = m->map;
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
 	unsigned long lcn = m->lcn;
@@ -374,7 +374,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 			    struct erofs_map_blocks *map,
 			    int flags)
 {
-	struct erofs_vnode *const vi = EROFS_V(inode);
+	struct erofs_inode *const vi = EROFS_I(inode);
 	struct z_erofs_maprecorder m = {
 		.inode = inode,
 		.map = map,
diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index d239f39cbc8c..27f5caa6299a 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -41,7 +41,7 @@ TRACE_EVENT(erofs_lookup,
 
 	TP_fast_assign(
 		__entry->dev	= dir->i_sb->s_dev;
-		__entry->nid	= EROFS_V(dir)->nid;
+		__entry->nid	= EROFS_I(dir)->nid;
 		__entry->name	= dentry->d_name.name;
 		__entry->flags	= flags;
 	),
@@ -66,7 +66,7 @@ TRACE_EVENT(erofs_fill_inode,
 
 	TP_fast_assign(
 		__entry->dev		= inode->i_sb->s_dev;
-		__entry->nid		= EROFS_V(inode)->nid;
+		__entry->nid		= EROFS_I(inode)->nid;
 		__entry->blkaddr	= erofs_blknr(iloc(EROFS_I_SB(inode), __entry->nid));
 		__entry->ofs		= erofs_blkoff(iloc(EROFS_I_SB(inode), __entry->nid));
 		__entry->isdir		= isdir;
@@ -95,7 +95,7 @@ TRACE_EVENT(erofs_readpage,
 
 	TP_fast_assign(
 		__entry->dev	= page->mapping->host->i_sb->s_dev;
-		__entry->nid	= EROFS_V(page->mapping->host)->nid;
+		__entry->nid	= EROFS_I(page->mapping->host)->nid;
 		__entry->dir	= S_ISDIR(page->mapping->host->i_mode);
 		__entry->index	= page->index;
 		__entry->uptodate = PageUptodate(page);
@@ -128,7 +128,7 @@ TRACE_EVENT(erofs_readpages,
 
 	TP_fast_assign(
 		__entry->dev	= inode->i_sb->s_dev;
-		__entry->nid	= EROFS_V(inode)->nid;
+		__entry->nid	= EROFS_I(inode)->nid;
 		__entry->start	= page->index;
 		__entry->nrpage	= nrpage;
 		__entry->raw	= raw;
@@ -157,7 +157,7 @@ DECLARE_EVENT_CLASS(erofs__map_blocks_enter,
 
 	TP_fast_assign(
 		__entry->dev    = inode->i_sb->s_dev;
-		__entry->nid    = EROFS_V(inode)->nid;
+		__entry->nid    = EROFS_I(inode)->nid;
 		__entry->la	= map->m_la;
 		__entry->llen	= map->m_llen;
 		__entry->flags	= flags;
@@ -203,7 +203,7 @@ DECLARE_EVENT_CLASS(erofs__map_blocks_exit,
 
 	TP_fast_assign(
 		__entry->dev    = inode->i_sb->s_dev;
-		__entry->nid    = EROFS_V(inode)->nid;
+		__entry->nid    = EROFS_I(inode)->nid;
 		__entry->flags	= flags;
 		__entry->la	= map->m_la;
 		__entry->pa	= map->m_pa;
@@ -247,7 +247,7 @@ TRACE_EVENT(erofs_destroy_inode,
 
 	TP_fast_assign(
 		__entry->dev	= inode->i_sb->s_dev;
-		__entry->nid	= EROFS_V(inode)->nid;
+		__entry->nid	= EROFS_I(inode)->nid;
 	),
 
 	TP_printk("dev = (%d,%d), nid = %llu", show_dev_nid(__entry))
-- 
2.17.1

