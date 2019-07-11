Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA4AF659BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 16:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfGKO7R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 10:59:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2262 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729269AbfGKO65 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 10:58:57 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A26FFA6A8BC3D698BDCF;
        Thu, 11 Jul 2019 22:58:53 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 11 Jul
 2019 22:58:46 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 22/24] erofs: introduce the decompression frontend
Date:   Thu, 11 Jul 2019 22:57:53 +0800
Message-ID: <20190711145755.33908-23-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190711145755.33908-1-gaoxiang25@huawei.com>
References: <20190711145755.33908-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces the basic inplace fixed-sized
output decompression implementation for erofs
filesystem.

In constant to fixed-sized input compression, it has
fixed-sized capacity for each compressed cluster to
contain compressed data with the following advantages:
 1) improved storage density;
 2) decompression inplace support;
 3) all data in a compressed physical cluster can be
    decompressed and utilized.

The key point of inplace refers to one of all erofs
decompression strategies: Instead of allocating extra
compressed pages and data management structures, it
reuses the allocated file cache pages as much as
possible to store its compressed data (called inplace
I/O) and the corresponding pagevec in a time-sharing
approach, which is particularly useful for low memory
scenario.

In addition, decompression inplace technology is based
on inplace I/O, which eliminates page allocation and
all extra compressed data memcpy.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/Kconfig    |    1 +
 fs/erofs/Makefile   |    2 +-
 fs/erofs/internal.h |   16 +-
 fs/erofs/super.c    |    9 +
 fs/erofs/zdata.c    | 1268 +++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/zdata.h    |  192 +++++++
 fs/erofs/zmap.c     |    4 +-
 7 files changed, 1488 insertions(+), 4 deletions(-)
 create mode 100644 fs/erofs/zdata.c
 create mode 100644 fs/erofs/zdata.h

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 9cefecec3194..45a81ebeb023 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -94,6 +94,7 @@ config EROFS_FS_ZIP
 	bool "EROFS Data Compresssion Support"
 	depends on EROFS_FS
 	select LZ4_DECOMPRESS
+	default y
 	help
 	  Enable fixed-sized output compression for EROFS.
 
diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index afb7c6556bf9..ac627823e6b8 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -7,5 +7,5 @@ ccflags-y += -DEROFS_VERSION=\"$(EROFS_VERSION)\"
 obj-$(CONFIG_EROFS_FS) += erofs.o
 erofs-objs := super.o inode.o data.o namei.o dir.o utils.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
-erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o
+erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 7e6ac4642593..73892162f494 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -68,6 +68,9 @@ struct erofs_sb_info {
 	/* the dedicated workstation for compression */
 	struct radix_tree_root workstn_tree;
 
+	/* threshold for decompression synchronously */
+	unsigned int max_sync_decompress_pages;
+
 	unsigned int shrinker_run_no;
 #endif
 	u32 blocks;
@@ -223,6 +226,8 @@ static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
 }
 #endif
 
+#define DEFAULT_MAX_SYNC_DECOMPRESS_PAGES	3
+
 #ifdef CONFIG_EROFS_FS_CLUSTER_PAGE_LIMIT
 #define Z_EROFS_CLUSTER_MAX_PAGES       (CONFIG_EROFS_FS_CLUSTER_PAGE_LIMIT)
 #else
@@ -328,6 +333,9 @@ static inline bool is_inode_flat_inline(struct inode *inode)
 extern const struct super_operations erofs_sops;
 
 extern const struct address_space_operations erofs_raw_access_aops;
+#ifdef CONFIG_EROFS_FS_ZIP
+extern const struct address_space_operations z_erofs_vle_normalaccess_aops;
+#endif
 
 /*
  * Logical to physical block mapping, used by erofs_map_blocks()
@@ -494,7 +502,7 @@ int erofs_namei(struct inode *dir, struct qstr *name,
 /* dir.c */
 extern const struct file_operations erofs_dir_fops;
 
-/* utils.c */
+/* utils.c / zdata.c */
 struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp, bool nofail);
 
 #if (EROFS_PCPUBUF_NR_PAGES > 0)
@@ -520,17 +528,21 @@ int erofs_register_workgroup(struct super_block *sb,
 			     struct erofs_workgroup *grp, bool tag);
 unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
 				       unsigned long nr_shrink, bool cleanup);
-static inline void erofs_workgroup_free_rcu(struct erofs_workgroup *grp) {}
+void erofs_workgroup_free_rcu(struct erofs_workgroup *grp);
 
 void erofs_shrinker_register(struct super_block *sb);
 void erofs_shrinker_unregister(struct super_block *sb);
 int __init erofs_init_shrinker(void);
 void erofs_exit_shrinker(void);
+int __init z_erofs_init_zip_subsystem(void);
+void z_erofs_exit_zip_subsystem(void);
 #else
 static inline void erofs_shrinker_register(struct super_block *sb) {}
 static inline void erofs_shrinker_unregister(struct super_block *sb) {}
 static inline int erofs_init_shrinker(void) { return 0; }
 static inline void erofs_exit_shrinker(void) {}
+static inline int z_erofs_init_zip_subsystem(void) { return 0; }
+static inline void z_erofs_exit_zip_subsystem(void) {}
 #endif
 
 #endif
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index acb60553b586..80e1a9b6d855 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -200,6 +200,9 @@ static unsigned int erofs_get_fault_rate(struct erofs_sb_info *sbi)
 /* set up default EROFS parameters */
 static void default_options(struct erofs_sb_info *sbi)
 {
+#ifdef CONFIG_EROFS_FS_ZIP
+	sbi->max_sync_decompress_pages = DEFAULT_MAX_SYNC_DECOMPRESS_PAGES;
+#endif
 #ifdef CONFIG_EROFS_FS_XATTR
 	set_opt(sbi, XATTR_USER);
 #endif
@@ -481,6 +484,9 @@ static int __init erofs_module_init(void)
 	err = erofs_init_shrinker();
 	if (err)
 		goto shrinker_err;
+	err = z_erofs_init_zip_subsystem();
+	if (err)
+		goto zip_err;
 	err = register_filesystem(&erofs_fs_type);
 	if (err)
 		goto fs_err;
@@ -489,6 +495,8 @@ static int __init erofs_module_init(void)
 	return 0;
 
 fs_err:
+	z_erofs_exit_zip_subsystem();
+zip_err:
 	erofs_exit_shrinker();
 shrinker_err:
 	erofs_exit_inode_cache();
@@ -499,6 +507,7 @@ static int __init erofs_module_init(void)
 static void __exit erofs_module_exit(void)
 {
 	unregister_filesystem(&erofs_fs_type);
+	z_erofs_exit_zip_subsystem();
 	erofs_exit_shrinker();
 	erofs_exit_inode_cache();
 	infoln("successfully finalize erofs");
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
new file mode 100644
index 000000000000..bebbd45bf08e
--- /dev/null
+++ b/fs/erofs/zdata.c
@@ -0,0 +1,1268 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * linux/fs/erofs/zdata.c
+ *
+ * Copyright (C) 2018 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Gao Xiang <gaoxiang25@huawei.com>
+ */
+#include "zdata.h"
+#include "compress.h"
+#include <linux/prefetch.h>
+
+#include <trace/events/erofs.h>
+
+/*
+ * a compressed_pages[] placeholder in order to avoid
+ * being filled with file pages for in-place decompression.
+ */
+#define PAGE_UNALLOCATED     ((void *)0x5F0E4B1D)
+
+/* how to allocate cached pages for a pcluster */
+enum z_erofs_cache_alloctype {
+	DONTALLOC,	/* don't allocate any cached pages */
+	DELAYEDALLOC,	/* delayed allocation (at the time of submitting io) */
+};
+
+/*
+ * tagged pointer with 1-bit tag for all compressed pages
+ * tag 0 - the page is just found with an extra page reference
+ */
+typedef tagptr1_t compressed_page_t;
+
+#define tag_compressed_page_justfound(page) \
+	tagptr_fold(compressed_page_t, page, 1)
+
+static struct workqueue_struct *z_erofs_workqueue __read_mostly;
+static struct kmem_cache *pcluster_cachep __read_mostly;
+
+void z_erofs_exit_zip_subsystem(void)
+{
+	destroy_workqueue(z_erofs_workqueue);
+	kmem_cache_destroy(pcluster_cachep);
+}
+
+static inline int init_unzip_workqueue(void)
+{
+	const unsigned int onlinecpus = num_possible_cpus();
+	const unsigned int flags = WQ_UNBOUND | WQ_HIGHPRI | WQ_CPU_INTENSIVE;
+
+	/*
+	 * no need to spawn too many threads, limiting threads could minimum
+	 * scheduling overhead, perhaps per-CPU threads should be better?
+	 */
+	z_erofs_workqueue = alloc_workqueue("erofs_unzipd", flags,
+					    onlinecpus + onlinecpus / 4);
+	return z_erofs_workqueue ? 0 : -ENOMEM;
+}
+
+static void init_once(void *ptr)
+{
+	struct z_erofs_pcluster *pcl = ptr;
+	struct z_erofs_collection *cl = z_erofs_primarycollection(pcl);
+	unsigned int i;
+
+	mutex_init(&cl->lock);
+	cl->nr_pages = 0;
+	cl->vcnt = 0;
+	for (i = 0; i < Z_EROFS_CLUSTER_MAX_PAGES; ++i)
+		pcl->compressed_pages[i] = NULL;
+}
+
+static void init_always(struct z_erofs_pcluster *pcl)
+{
+	struct z_erofs_collection *cl = z_erofs_primarycollection(pcl);
+
+	atomic_set(&pcl->obj.refcount, 1);
+
+	DBG_BUGON(cl->nr_pages);
+	DBG_BUGON(cl->vcnt);
+}
+
+int __init z_erofs_init_zip_subsystem(void)
+{
+	pcluster_cachep = kmem_cache_create("erofs_compress",
+					    Z_EROFS_WORKGROUP_SIZE, 0,
+					    SLAB_RECLAIM_ACCOUNT, init_once);
+	if (pcluster_cachep) {
+		if (!init_unzip_workqueue())
+			return 0;
+
+		kmem_cache_destroy(pcluster_cachep);
+	}
+	return -ENOMEM;
+}
+
+enum z_erofs_collectmode {
+	COLLECT_SECONDARY,
+	COLLECT_PRIMARY,
+	/*
+	 * The current collection was the tail of an exist chain, in addition
+	 * that the previous processed chained collections are all decided to
+	 * be hooked up to it.
+	 * A new chain will be created for the remaining collections which are
+	 * not processed yet, therefore different from COLLECT_PRIMARY_FOLLOWED,
+	 * the next collection cannot reuse the whole page safely in
+	 * the following scenario:
+	 *  ________________________________________________________________
+	 * |      tail (partial) page     |       head (partial) page       |
+	 * |   (belongs to the next cl)   |   (belongs to the current cl)   |
+	 * |_______PRIMARY_FOLLOWED_______|________PRIMARY_HOOKED___________|
+	 */
+	COLLECT_PRIMARY_HOOKED,
+	COLLECT_PRIMARY_FOLLOWED_NOINPLACE,
+	/*
+	 * The current collection has been linked with the owned chain, and
+	 * could also be linked with the remaining collections, which means
+	 * if the processing page is the tail page of the collection, thus
+	 * the current collection can safely use the whole page (since
+	 * the previous collection is under control) for in-place I/O, as
+	 * illustrated below:
+	 *  ________________________________________________________________
+	 * |  tail (partial) page |          head (partial) page           |
+	 * |  (of the current cl) |      (of the previous collection)      |
+	 * |  PRIMARY_FOLLOWED or |                                        |
+	 * |_____PRIMARY_HOOKED___|____________PRIMARY_FOLLOWED____________|
+	 *
+	 * [  (*) the above page can be used as inplace I/O.               ]
+	 */
+	COLLECT_PRIMARY_FOLLOWED,
+};
+
+struct z_erofs_collector {
+	struct z_erofs_pagevec_ctor vector;
+
+	struct z_erofs_pcluster *pcl;
+	struct z_erofs_collection *cl;
+	struct page **compressedpages;
+	z_erofs_next_pcluster_t owned_head;
+
+	enum z_erofs_collectmode mode;
+};
+
+struct z_erofs_decompress_frontend {
+	struct inode *const inode;
+
+	struct z_erofs_collector clt;
+	struct erofs_map_blocks map;
+
+	/* used for applying cache strategy on the fly */
+	bool backmost;
+	erofs_off_t headoffset;
+};
+
+#define COLLECTOR_INIT() { \
+	.owned_head = Z_EROFS_PCLUSTER_TAIL, \
+	.mode = COLLECT_PRIMARY_FOLLOWED }
+
+#define DECOMPRESS_FRONTEND_INIT(__i) { \
+	.inode = __i, .clt = COLLECTOR_INIT(), \
+	.backmost = true, }
+
+static struct page *z_pagemap_global[Z_EROFS_VMAP_GLOBAL_PAGES];
+static DEFINE_MUTEX(z_pagemap_global_lock);
+
+static void preload_compressed_pages(struct z_erofs_collector *clt,
+				     struct address_space *mc,
+				     enum z_erofs_cache_alloctype type,
+				     struct list_head *pagepool)
+{
+	/* nowhere to load compressed pages from */
+}
+
+/* page_type must be Z_EROFS_PAGE_TYPE_EXCLUSIVE */
+static inline bool try_inplace_io(struct z_erofs_collector *clt,
+				  struct page *page)
+{
+	struct z_erofs_pcluster *const pcl = clt->pcl;
+	const unsigned int clusterpages = BIT(pcl->clusterbits);
+
+	while (clt->compressedpages < pcl->compressed_pages + clusterpages) {
+		if (!cmpxchg(clt->compressedpages++, NULL, page))
+			return true;
+	}
+	return false;
+}
+
+/* callers must be with collection lock held */
+static int z_erofs_attach_page(struct z_erofs_collector *clt,
+			       struct page *page,
+			       enum z_erofs_page_type type)
+{
+	int ret;
+	bool occupied;
+
+	/* give priority for inplaceio */
+	if (clt->mode >= COLLECT_PRIMARY &&
+	    type == Z_EROFS_PAGE_TYPE_EXCLUSIVE &&
+	    try_inplace_io(clt, page))
+		return 0;
+
+	ret = z_erofs_pagevec_enqueue(&clt->vector,
+				      page, type, &occupied);
+	clt->cl->vcnt += (unsigned int)ret;
+
+	return ret ? 0 : -EAGAIN;
+}
+
+static enum z_erofs_collectmode
+try_to_claim_pcluster(struct z_erofs_pcluster *pcl,
+		      z_erofs_next_pcluster_t *owned_head)
+{
+	/* let's claim these following types of pclusters */
+retry:
+	if (pcl->next == Z_EROFS_PCLUSTER_NIL) {
+		/* type 1, nil pcluster */
+		if (cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_NIL,
+			    *owned_head) != Z_EROFS_PCLUSTER_NIL)
+			goto retry;
+
+		*owned_head = &pcl->next;
+		/* lucky, I am the followee :) */
+		return COLLECT_PRIMARY_FOLLOWED;
+	} else if (pcl->next == Z_EROFS_PCLUSTER_TAIL) {
+		/*
+		 * type 2, link to the end of a existing open chain,
+		 * be careful that its submission itself is governed
+		 * by the original owned chain.
+		 */
+		if (cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
+			    *owned_head) != Z_EROFS_PCLUSTER_TAIL)
+			goto retry;
+		*owned_head = Z_EROFS_PCLUSTER_TAIL;
+		return COLLECT_PRIMARY_HOOKED;
+	}
+	return COLLECT_PRIMARY;	/* :( better luck next time */
+}
+
+static struct z_erofs_collection *cllookup(struct z_erofs_collector *clt,
+					   struct inode *inode,
+					   struct erofs_map_blocks *map)
+{
+	struct erofs_workgroup *grp;
+	struct z_erofs_pcluster *pcl;
+	struct z_erofs_collection *cl;
+	unsigned int length;
+	bool tag;
+
+	grp = erofs_find_workgroup(inode->i_sb, map->m_pa >> PAGE_SHIFT, &tag);
+	if (!grp)
+		return NULL;
+
+	pcl = container_of(grp, struct z_erofs_pcluster, obj);
+
+	cl = z_erofs_primarycollection(pcl);
+	if (unlikely(cl->pageofs != (map->m_la & ~PAGE_MASK))) {
+		DBG_BUGON(1);
+		return ERR_PTR(-EIO);
+	}
+
+	length = READ_ONCE(pcl->length);
+	if (length & Z_EROFS_PCLUSTER_FULL_LENGTH) {
+		if ((map->m_llen << Z_EROFS_PCLUSTER_LENGTH_BIT) > length) {
+			DBG_BUGON(1);
+			return ERR_PTR(-EIO);
+		}
+	} else {
+		unsigned int llen = map->m_llen << Z_EROFS_PCLUSTER_LENGTH_BIT;
+
+		if (map->m_flags & EROFS_MAP_FULL_MAPPED)
+			llen |= Z_EROFS_PCLUSTER_FULL_LENGTH;
+
+		while (llen > length &&
+		       length != cmpxchg_relaxed(&pcl->length, length, llen)) {
+			cpu_relax();
+			length = READ_ONCE(pcl->length);
+		}
+	}
+	mutex_lock(&cl->lock);
+	clt->mode = try_to_claim_pcluster(pcl, &clt->owned_head);
+	clt->pcl = pcl;
+	clt->cl = cl;
+	return cl;
+}
+
+static struct z_erofs_collection *clregister(struct z_erofs_collector *clt,
+					     struct inode *inode,
+					     struct erofs_map_blocks *map)
+{
+	struct z_erofs_pcluster *pcl;
+	struct z_erofs_collection *cl;
+	int err;
+
+	/* no available workgroup, let's allocate one */
+	pcl = kmem_cache_alloc(pcluster_cachep, GFP_NOFS);
+	if (unlikely(!pcl))
+		return ERR_PTR(-ENOMEM);
+
+	init_always(pcl);
+	pcl->obj.index = map->m_pa >> PAGE_SHIFT;
+
+	pcl->length = (map->m_llen << Z_EROFS_PCLUSTER_LENGTH_BIT) |
+		(map->m_flags & EROFS_MAP_FULL_MAPPED ?
+			Z_EROFS_PCLUSTER_FULL_LENGTH : 0);
+
+	if (map->m_flags & EROFS_MAP_ZIPPED)
+		pcl->algorithmformat = Z_EROFS_COMPRESSION_LZ4;
+	else
+		pcl->algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
+
+	pcl->clusterbits = EROFS_V(inode)->z_physical_clusterbits[0];
+	pcl->clusterbits -= PAGE_SHIFT;
+
+	/* new pclusters should be claimed as type 1, primary and followed */
+	pcl->next = clt->owned_head;
+	clt->mode = COLLECT_PRIMARY_FOLLOWED;
+
+	cl = z_erofs_primarycollection(pcl);
+	cl->pageofs = map->m_la & ~PAGE_MASK;
+
+	/*
+	 * lock all primary followed works before visible to others
+	 * and mutex_trylock *never* fails for a new pcluster.
+	 */
+	mutex_trylock(&cl->lock);
+
+	err = erofs_register_workgroup(inode->i_sb, &pcl->obj, 0);
+	if (err) {
+		mutex_unlock(&cl->lock);
+		kmem_cache_free(pcluster_cachep, pcl);
+		return ERR_PTR(-EAGAIN);
+	}
+	clt->owned_head = &pcl->next;
+	clt->pcl = pcl;
+	clt->cl = cl;
+	return cl;
+}
+
+static int z_erofs_collector_begin(struct z_erofs_collector *clt,
+				   struct inode *inode,
+				   struct erofs_map_blocks *map)
+{
+	struct z_erofs_collection *cl;
+
+	DBG_BUGON(clt->cl);
+
+	/* must be Z_EROFS_PCLUSTER_TAIL or pointed to previous collection */
+	DBG_BUGON(clt->owned_head == Z_EROFS_PCLUSTER_NIL);
+	DBG_BUGON(clt->owned_head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
+
+	if (!PAGE_ALIGNED(map->m_pa)) {
+		DBG_BUGON(1);
+		return -EINVAL;
+	}
+
+repeat:
+	cl = cllookup(clt, inode, map);
+	if (!cl) {
+		cl = clregister(clt, inode, map);
+
+		if (unlikely(cl == ERR_PTR(-EAGAIN)))
+			goto repeat;
+	}
+
+	if (IS_ERR(cl))
+		return PTR_ERR(cl);
+
+	z_erofs_pagevec_ctor_init(&clt->vector, Z_EROFS_NR_INLINE_PAGEVECS,
+				  cl->pagevec, cl->vcnt);
+
+	clt->compressedpages = clt->pcl->compressed_pages;
+	if (clt->mode <= COLLECT_PRIMARY) /* cannot do in-place I/O */
+		clt->compressedpages += Z_EROFS_CLUSTER_MAX_PAGES;
+	return 0;
+}
+
+/*
+ * keep in mind that no referenced pclusters will be freed
+ * only after a RCU grace period.
+ */
+static void z_erofs_rcu_callback(struct rcu_head *head)
+{
+	struct z_erofs_collection *const cl =
+		container_of(head, struct z_erofs_collection, rcu);
+
+	kmem_cache_free(pcluster_cachep,
+			container_of(cl, struct z_erofs_pcluster,
+				     primary_collection));
+}
+
+void erofs_workgroup_free_rcu(struct erofs_workgroup *grp)
+{
+	struct z_erofs_pcluster *const pcl =
+		container_of(grp, struct z_erofs_pcluster, obj);
+	struct z_erofs_collection *const cl = z_erofs_primarycollection(pcl);
+
+	call_rcu(&cl->rcu, z_erofs_rcu_callback);
+}
+
+static void z_erofs_collection_put(struct z_erofs_collection *cl)
+{
+	struct z_erofs_pcluster *const pcl =
+		container_of(cl, struct z_erofs_pcluster, primary_collection);
+
+	erofs_workgroup_put(&pcl->obj);
+}
+
+static bool z_erofs_collector_end(struct z_erofs_collector *clt)
+{
+	struct z_erofs_collection *cl = clt->cl;
+
+	if (!cl)
+		return false;
+
+	z_erofs_pagevec_ctor_exit(&clt->vector, false);
+	mutex_unlock(&cl->lock);
+
+	/*
+	 * if all pending pages are added, don't hold its reference
+	 * any longer if the pcluster isn't hosted by ourselves.
+	 */
+	if (clt->mode < COLLECT_PRIMARY_FOLLOWED_NOINPLACE)
+		z_erofs_collection_put(cl);
+
+	clt->cl = NULL;
+	return true;
+}
+
+static inline struct page *__stagingpage_alloc(struct list_head *pagepool,
+					       gfp_t gfp)
+{
+	struct page *page = erofs_allocpage(pagepool, gfp, true);
+
+	if (unlikely(!page))
+		return NULL;
+
+	page->mapping = Z_EROFS_MAPPING_STAGING;
+	return page;
+}
+
+static bool should_alloc_managed_pages(struct z_erofs_decompress_frontend *fe,
+				       erofs_off_t la)
+{
+	return false;
+}
+
+static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
+				struct page *page,
+				struct list_head *pagepool)
+{
+	struct inode *const inode = fe->inode;
+	struct erofs_sb_info *const sbi __maybe_unused = EROFS_I_SB(inode);
+	struct erofs_map_blocks *const map = &fe->map;
+	struct z_erofs_collector *const clt = &fe->clt;
+	const loff_t offset = page_offset(page);
+	bool tight = (clt->mode >= COLLECT_PRIMARY_HOOKED);
+
+	enum z_erofs_cache_alloctype cache_strategy;
+	enum z_erofs_page_type page_type;
+	unsigned int cur, end, spiltted, index;
+	int err = 0;
+
+	/* register locked file pages as online pages in pack */
+	z_erofs_onlinepage_init(page);
+
+	spiltted = 0;
+	end = PAGE_SIZE;
+repeat:
+	cur = end - 1;
+
+	/* lucky, within the range of the current map_blocks */
+	if (offset + cur >= map->m_la &&
+	    offset + cur < map->m_la + map->m_llen) {
+		/* didn't get a valid collection previously (very rare) */
+		if (!clt->cl)
+			goto restart_now;
+		goto hitted;
+	}
+
+	/* go ahead the next map_blocks */
+	debugln("%s: [out-of-range] pos %llu", __func__, offset + cur);
+
+	if (z_erofs_collector_end(clt))
+		fe->backmost = false;
+
+	map->m_la = offset + cur;
+	map->m_llen = 0;
+	err = z_erofs_map_blocks_iter(inode, map, 0);
+	if (unlikely(err))
+		goto err_out;
+
+restart_now:
+	if (unlikely(!(map->m_flags & EROFS_MAP_MAPPED)))
+		goto hitted;
+
+	err = z_erofs_collector_begin(clt, inode, map);
+	if (unlikely(err))
+		goto err_out;
+
+	/* preload all compressed pages (maybe downgrade role if necessary) */
+	if (should_alloc_managed_pages(fe, map->m_la))
+		cache_strategy = DELAYEDALLOC;
+	else
+		cache_strategy = DONTALLOC;
+
+	preload_compressed_pages(clt, MNGD_MAPPING(sbi),
+				 cache_strategy, pagepool);
+
+	tight &= (clt->mode >= COLLECT_PRIMARY_HOOKED);
+hitted:
+	cur = end - min_t(unsigned int, offset + end - map->m_la, end);
+	if (unlikely(!(map->m_flags & EROFS_MAP_MAPPED))) {
+		zero_user_segment(page, cur, end);
+		goto next_part;
+	}
+
+	/* let's derive page type */
+	page_type = cur ? Z_EROFS_VLE_PAGE_TYPE_HEAD :
+		(!spiltted ? Z_EROFS_PAGE_TYPE_EXCLUSIVE :
+			(tight ? Z_EROFS_PAGE_TYPE_EXCLUSIVE :
+				Z_EROFS_VLE_PAGE_TYPE_TAIL_SHARED));
+
+	if (cur)
+		tight &= (clt->mode >= COLLECT_PRIMARY_FOLLOWED);
+
+retry:
+	err = z_erofs_attach_page(clt, page, page_type);
+	/* should allocate an additional staging page for pagevec */
+	if (err == -EAGAIN) {
+		struct page *const newpage =
+			__stagingpage_alloc(pagepool, GFP_NOFS);
+
+		err = z_erofs_attach_page(clt, newpage,
+					  Z_EROFS_PAGE_TYPE_EXCLUSIVE);
+		if (likely(!err))
+			goto retry;
+	}
+
+	if (unlikely(err))
+		goto err_out;
+
+	index = page->index - (map->m_la >> PAGE_SHIFT);
+
+	z_erofs_onlinepage_fixup(page, index, true);
+
+	/* bump up the number of spiltted parts of a page */
+	++spiltted;
+	/* also update nr_pages */
+	clt->cl->nr_pages = max_t(pgoff_t, clt->cl->nr_pages, index + 1);
+next_part:
+	/* can be used for verification */
+	map->m_llen = offset + cur - map->m_la;
+
+	end = cur;
+	if (end > 0)
+		goto repeat;
+
+out:
+	z_erofs_onlinepage_endio(page);
+
+	debugln("%s, finish page: %pK spiltted: %u map->m_llen %llu",
+		__func__, page, spiltted, map->m_llen);
+	return err;
+
+	/* if some error occurred while processing this page */
+err_out:
+	SetPageError(page);
+	goto out;
+}
+
+static void z_erofs_vle_unzip_kickoff(void *ptr, int bios)
+{
+	tagptr1_t t = tagptr_init(tagptr1_t, ptr);
+	struct z_erofs_unzip_io *io = tagptr_unfold_ptr(t);
+	bool background = tagptr_unfold_tags(t);
+
+	if (!background) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&io->u.wait.lock, flags);
+		if (!atomic_add_return(bios, &io->pending_bios))
+			wake_up_locked(&io->u.wait);
+		spin_unlock_irqrestore(&io->u.wait.lock, flags);
+		return;
+	}
+
+	if (!atomic_add_return(bios, &io->pending_bios))
+		queue_work(z_erofs_workqueue, &io->u.work);
+}
+
+static inline void z_erofs_vle_read_endio(struct bio *bio)
+{
+	struct erofs_sb_info *sbi = NULL;
+	blk_status_t err = bio->bi_status;
+	struct bio_vec *bvec;
+	struct bvec_iter_all iter_all;
+
+	bio_for_each_segment_all(bvec, bio, iter_all) {
+		struct page *page = bvec->bv_page;
+		bool cachemngd = false;
+
+		DBG_BUGON(PageUptodate(page));
+		DBG_BUGON(!page->mapping);
+
+		if (unlikely(!sbi && !z_erofs_page_is_staging(page))) {
+			sbi = EROFS_SB(page->mapping->host->i_sb);
+
+			if (time_to_inject(sbi, FAULT_READ_IO)) {
+				erofs_show_injection_info(FAULT_READ_IO);
+				err = BLK_STS_IOERR;
+			}
+		}
+
+		/* sbi should already be gotten if the page is managed */
+		if (sbi)
+			cachemngd = erofs_page_is_managed(sbi, page);
+
+		if (unlikely(err))
+			SetPageError(page);
+		else if (cachemngd)
+			SetPageUptodate(page);
+
+		if (cachemngd)
+			unlock_page(page);
+	}
+
+	z_erofs_vle_unzip_kickoff(bio->bi_private, -1);
+	bio_put(bio);
+}
+
+static int z_erofs_decompress_pcluster(struct super_block *sb,
+				       struct z_erofs_pcluster *pcl,
+				       struct list_head *pagepool)
+{
+	struct erofs_sb_info *const sbi = EROFS_SB(sb);
+	const unsigned int clusterpages = BIT(pcl->clusterbits);
+	struct z_erofs_pagevec_ctor ctor;
+	unsigned int i, outputsize, llen, nr_pages;
+	struct page *pages_onstack[Z_EROFS_VMAP_ONSTACK_PAGES];
+	struct page **pages, **compressed_pages, *page;
+
+	enum z_erofs_page_type page_type;
+	bool overlapped, partial;
+	struct z_erofs_collection *cl;
+	int err;
+
+	might_sleep();
+	cl = z_erofs_primarycollection(pcl);
+	DBG_BUGON(!READ_ONCE(cl->nr_pages));
+
+	mutex_lock(&cl->lock);
+	nr_pages = cl->nr_pages;
+
+	if (likely(nr_pages <= Z_EROFS_VMAP_ONSTACK_PAGES)) {
+		pages = pages_onstack;
+	} else if (nr_pages <= Z_EROFS_VMAP_GLOBAL_PAGES &&
+		   mutex_trylock(&z_pagemap_global_lock)) {
+		pages = z_pagemap_global;
+	} else {
+repeat:
+		pages = kvmalloc_array(nr_pages, sizeof(struct page *),
+				       GFP_KERNEL);
+
+		/* fallback to global pagemap for the lowmem scenario */
+		if (unlikely(!pages)) {
+			if (nr_pages > Z_EROFS_VMAP_GLOBAL_PAGES)
+				goto repeat;
+
+			mutex_lock(&z_pagemap_global_lock);
+			pages = z_pagemap_global;
+		}
+	}
+
+	for (i = 0; i < nr_pages; ++i)
+		pages[i] = NULL;
+
+	z_erofs_pagevec_ctor_init(&ctor, Z_EROFS_NR_INLINE_PAGEVECS,
+				  cl->pagevec, 0);
+
+	for (i = 0; i < cl->vcnt; ++i) {
+		unsigned int pagenr;
+
+		page = z_erofs_pagevec_dequeue(&ctor, &page_type);
+
+		/* all pages in pagevec ought to be valid */
+		DBG_BUGON(!page);
+		DBG_BUGON(!page->mapping);
+
+		if (z_erofs_put_stagingpage(pagepool, page))
+			continue;
+
+		if (page_type == Z_EROFS_VLE_PAGE_TYPE_HEAD)
+			pagenr = 0;
+		else
+			pagenr = z_erofs_onlinepage_index(page);
+
+		DBG_BUGON(pagenr >= nr_pages);
+		DBG_BUGON(pages[pagenr]);
+
+		pages[pagenr] = page;
+	}
+	z_erofs_pagevec_ctor_exit(&ctor, true);
+
+	overlapped = false;
+	compressed_pages = pcl->compressed_pages;
+
+	err = 0;
+	for (i = 0; i < clusterpages; ++i) {
+		unsigned int pagenr;
+
+		page = compressed_pages[i];
+
+		/* all compressed pages ought to be valid */
+		DBG_BUGON(!page);
+		DBG_BUGON(!page->mapping);
+
+		if (!z_erofs_page_is_staging(page)) {
+			if (erofs_page_is_managed(sbi, page)) {
+				if (unlikely(!PageUptodate(page)))
+					err = -EIO;
+				continue;
+			}
+
+			/*
+			 * only if non-head page can be selected
+			 * for inplace decompression
+			 */
+			pagenr = z_erofs_onlinepage_index(page);
+
+			DBG_BUGON(pagenr >= nr_pages);
+			DBG_BUGON(pages[pagenr]);
+			pages[pagenr] = page;
+
+			overlapped = true;
+		}
+
+		/* PG_error needs checking for inplaced and staging pages */
+		if (unlikely(PageError(page))) {
+			DBG_BUGON(PageUptodate(page));
+			err = -EIO;
+		}
+	}
+
+	if (unlikely(err))
+		goto out;
+
+	llen = pcl->length >> Z_EROFS_PCLUSTER_LENGTH_BIT;
+	if (nr_pages << PAGE_SHIFT >= cl->pageofs + llen) {
+		outputsize = llen;
+		partial = !(pcl->length & Z_EROFS_PCLUSTER_FULL_LENGTH);
+	} else {
+		outputsize = (nr_pages << PAGE_SHIFT) - cl->pageofs;
+		partial = true;
+	}
+
+	err = z_erofs_decompress(&(struct z_erofs_decompress_req) {
+					.sb = sb,
+					.in = compressed_pages,
+					.out = pages,
+					.pageofs_out = cl->pageofs,
+					.inputsize = PAGE_SIZE,
+					.outputsize = outputsize,
+					.alg = pcl->algorithmformat,
+					.inplace_io = overlapped,
+					.partial_decoding = partial
+				 }, pagepool);
+
+out:
+	/* must handle all compressed pages before endding pages */
+	for (i = 0; i < clusterpages; ++i) {
+		page = compressed_pages[i];
+
+		if (erofs_page_is_managed(sbi, page))
+			continue;
+
+		/* recycle all individual staging pages */
+		(void)z_erofs_put_stagingpage(pagepool, page);
+
+		WRITE_ONCE(compressed_pages[i], NULL);
+	}
+
+	for (i = 0; i < nr_pages; ++i) {
+		page = pages[i];
+		if (!page)
+			continue;
+
+		DBG_BUGON(!page->mapping);
+
+		/* recycle all individual staging pages */
+		if (z_erofs_put_stagingpage(pagepool, page))
+			continue;
+
+		if (unlikely(err < 0))
+			SetPageError(page);
+
+		z_erofs_onlinepage_endio(page);
+	}
+
+	if (pages == z_pagemap_global)
+		mutex_unlock(&z_pagemap_global_lock);
+	else if (unlikely(pages != pages_onstack))
+		kvfree(pages);
+
+	cl->nr_pages = 0;
+	cl->vcnt = 0;
+
+	/* all cl locks MUST be taken before the following line */
+	WRITE_ONCE(pcl->next, Z_EROFS_PCLUSTER_NIL);
+
+	/* all cl locks SHOULD be released right now */
+	mutex_unlock(&cl->lock);
+
+	z_erofs_collection_put(cl);
+	return err;
+}
+
+static void z_erofs_vle_unzip_all(struct super_block *sb,
+				  struct z_erofs_unzip_io *io,
+				  struct list_head *pagepool)
+{
+	z_erofs_next_pcluster_t owned = io->head;
+
+	while (owned != Z_EROFS_PCLUSTER_TAIL_CLOSED) {
+		struct z_erofs_pcluster *pcl;
+
+		/* no possible that 'owned' equals Z_EROFS_WORK_TPTR_TAIL */
+		DBG_BUGON(owned == Z_EROFS_PCLUSTER_TAIL);
+
+		/* no possible that 'owned' equals NULL */
+		DBG_BUGON(owned == Z_EROFS_PCLUSTER_NIL);
+
+		pcl = container_of(owned, struct z_erofs_pcluster, next);
+		owned = READ_ONCE(pcl->next);
+
+		z_erofs_decompress_pcluster(sb, pcl, pagepool);
+	}
+}
+
+static void z_erofs_vle_unzip_wq(struct work_struct *work)
+{
+	struct z_erofs_unzip_io_sb *iosb =
+		container_of(work, struct z_erofs_unzip_io_sb, io.u.work);
+	LIST_HEAD(pagepool);
+
+	DBG_BUGON(iosb->io.head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
+	z_erofs_vle_unzip_all(iosb->sb, &iosb->io, &pagepool);
+
+	put_pages_list(&pagepool);
+	kvfree(iosb);
+}
+
+static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
+					       unsigned int nr,
+					       struct list_head *pagepool,
+					       struct address_space *mc,
+					       gfp_t gfp)
+{
+	/* determined at compile time to avoid too many #ifdefs */
+	const bool nocache = __builtin_constant_p(mc) ? !mc : false;
+	const pgoff_t index = pcl->obj.index;
+	bool tocache = false;
+
+	struct address_space *mapping;
+	struct page *oldpage, *page;
+
+	compressed_page_t t;
+	int justfound;
+
+repeat:
+	page = READ_ONCE(pcl->compressed_pages[nr]);
+	oldpage = page;
+
+	if (!page)
+		goto out_allocpage;
+
+	/*
+	 * the cached page has not been allocated and
+	 * an placeholder is out there, prepare it now.
+	 */
+	if (!nocache && page == PAGE_UNALLOCATED) {
+		tocache = true;
+		goto out_allocpage;
+	}
+
+	/* process the target tagged pointer */
+	t = tagptr_init(compressed_page_t, page);
+	justfound = tagptr_unfold_tags(t);
+	page = tagptr_unfold_ptr(t);
+
+	mapping = READ_ONCE(page->mapping);
+
+	/*
+	 * if managed cache is disabled, it's no way to
+	 * get such a cached-like page.
+	 */
+	if (nocache) {
+		/* if managed cache is disabled, it is impossible `justfound' */
+		DBG_BUGON(justfound);
+
+		/* and it should be locked, not uptodate, and not truncated */
+		DBG_BUGON(!PageLocked(page));
+		DBG_BUGON(PageUptodate(page));
+		DBG_BUGON(!mapping);
+		goto out;
+	}
+
+	/*
+	 * unmanaged (file) pages are all locked solidly,
+	 * therefore it is impossible for `mapping' to be NULL.
+	 */
+	if (mapping && mapping != mc)
+		/* ought to be unmanaged pages */
+		goto out;
+
+	lock_page(page);
+
+	/* only true if page reclaim goes wrong, should never happen */
+	DBG_BUGON(justfound && PagePrivate(page));
+
+	/* the page is still in manage cache */
+	if (page->mapping == mc) {
+		WRITE_ONCE(pcl->compressed_pages[nr], page);
+
+		ClearPageError(page);
+		if (!PagePrivate(page)) {
+			/*
+			 * impossible to be !PagePrivate(page) for
+			 * the current restriction as well if
+			 * the page is already in compressed_pages[].
+			 */
+			DBG_BUGON(!justfound);
+
+			justfound = 0;
+			set_page_private(page, (unsigned long)pcl);
+			SetPagePrivate(page);
+		}
+
+		/* no need to submit io if it is already up-to-date */
+		if (PageUptodate(page)) {
+			unlock_page(page);
+			page = NULL;
+		}
+		goto out;
+	}
+
+	/*
+	 * the managed page has been truncated, it's unsafe to
+	 * reuse this one, let's allocate a new cache-managed page.
+	 */
+	DBG_BUGON(page->mapping);
+	DBG_BUGON(!justfound);
+
+	tocache = true;
+	unlock_page(page);
+	put_page(page);
+out_allocpage:
+	page = __stagingpage_alloc(pagepool, gfp);
+	if (oldpage != cmpxchg(&pcl->compressed_pages[nr], oldpage, page)) {
+		list_add(&page->lru, pagepool);
+		cpu_relax();
+		goto repeat;
+	}
+	if (nocache || !tocache)
+		goto out;
+	if (add_to_page_cache_lru(page, mc, index + nr, gfp)) {
+		page->mapping = Z_EROFS_MAPPING_STAGING;
+		goto out;
+	}
+
+	set_page_private(page, (unsigned long)pcl);
+	SetPagePrivate(page);
+out:	/* the only exit (for tracing and debugging) */
+	return page;
+}
+
+static struct z_erofs_unzip_io *jobqueue_init(struct super_block *sb,
+					      struct z_erofs_unzip_io *io,
+					      bool foreground)
+{
+	struct z_erofs_unzip_io_sb *iosb;
+
+	if (foreground) {
+		/* waitqueue available for foreground io */
+		DBG_BUGON(!io);
+
+		init_waitqueue_head(&io->u.wait);
+		atomic_set(&io->pending_bios, 0);
+		goto out;
+	}
+
+	iosb = kvzalloc(sizeof(*iosb), GFP_KERNEL | __GFP_NOFAIL);
+	DBG_BUGON(!iosb);
+
+	/* initialize fields in the allocated descriptor */
+	io = &iosb->io;
+	iosb->sb = sb;
+	INIT_WORK(&io->u.work, z_erofs_vle_unzip_wq);
+out:
+	io->head = Z_EROFS_PCLUSTER_TAIL_CLOSED;
+	return io;
+}
+
+/* define decompression jobqueue types */
+enum {
+	JQ_SUBMIT,
+	NR_JOBQUEUES,
+};
+
+static void *jobqueueset_init(struct super_block *sb,
+			      z_erofs_next_pcluster_t qtail[],
+			      struct z_erofs_unzip_io *q[],
+			      struct z_erofs_unzip_io *fgq,
+			      bool forcefg)
+{
+	q[JQ_SUBMIT] = jobqueue_init(sb, fgq + JQ_SUBMIT, forcefg);
+	qtail[JQ_SUBMIT] = &q[JQ_SUBMIT]->head;
+
+	return tagptr_cast_ptr(tagptr_fold(tagptr1_t, q[JQ_SUBMIT], !forcefg));
+}
+
+static void move_to_bypass_jobqueue(struct z_erofs_pcluster *pcl,
+				    z_erofs_next_pcluster_t qtail[],
+				    z_erofs_next_pcluster_t owned_head)
+{
+	/* impossible to bypass submission for managed cache disabled */
+	DBG_BUGON(1);
+}
+
+static bool postsubmit_is_all_bypassed(struct z_erofs_unzip_io *q[],
+				       unsigned int nr_bios,
+				       bool force_fg)
+{
+	/* bios should be >0 if managed cache is disabled */
+	DBG_BUGON(!nr_bios);
+	return false;
+}
+
+static bool z_erofs_vle_submit_all(struct super_block *sb,
+				   z_erofs_next_pcluster_t owned_head,
+				   struct list_head *pagepool,
+				   struct z_erofs_unzip_io *fgq,
+				   bool force_fg)
+{
+	struct erofs_sb_info *const sbi __maybe_unused = EROFS_SB(sb);
+	z_erofs_next_pcluster_t qtail[NR_JOBQUEUES];
+	struct z_erofs_unzip_io *q[NR_JOBQUEUES];
+	struct bio *bio;
+	void *bi_private;
+	/* since bio will be NULL, no need to initialize last_index */
+	pgoff_t uninitialized_var(last_index);
+	bool force_submit = false;
+	unsigned int nr_bios;
+
+	if (unlikely(owned_head == Z_EROFS_PCLUSTER_TAIL))
+		return false;
+
+	force_submit = false;
+	bio = NULL;
+	nr_bios = 0;
+	bi_private = jobqueueset_init(sb, qtail, q, fgq, force_fg);
+
+	/* by default, all need io submission */
+	q[JQ_SUBMIT]->head = owned_head;
+
+	do {
+		struct z_erofs_pcluster *pcl;
+		unsigned int clusterpages;
+		pgoff_t first_index;
+		struct page *page;
+		unsigned int i = 0, bypass = 0;
+		int err;
+
+		/* no possible 'owned_head' equals the following */
+		DBG_BUGON(owned_head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
+		DBG_BUGON(owned_head == Z_EROFS_PCLUSTER_NIL);
+
+		pcl = container_of(owned_head, struct z_erofs_pcluster, next);
+
+		clusterpages = BIT(pcl->clusterbits);
+
+		/* close the main owned chain at first */
+		owned_head = cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
+				     Z_EROFS_PCLUSTER_TAIL_CLOSED);
+
+		first_index = pcl->obj.index;
+		force_submit |= (first_index != last_index + 1);
+
+repeat:
+		page = pickup_page_for_submission(pcl, i, pagepool,
+						  MNGD_MAPPING(sbi),
+						  GFP_NOFS);
+		if (!page) {
+			force_submit = true;
+			++bypass;
+			goto skippage;
+		}
+
+		if (bio && force_submit) {
+submit_bio_retry:
+			__submit_bio(bio, REQ_OP_READ, 0);
+			bio = NULL;
+		}
+
+		if (!bio) {
+			bio = erofs_grab_bio(sb, first_index + i,
+					     BIO_MAX_PAGES, bi_private,
+					     z_erofs_vle_read_endio, true);
+			++nr_bios;
+		}
+
+		err = bio_add_page(bio, page, PAGE_SIZE, 0);
+		if (err < PAGE_SIZE)
+			goto submit_bio_retry;
+
+		force_submit = false;
+		last_index = first_index + i;
+skippage:
+		if (++i < clusterpages)
+			goto repeat;
+
+		if (bypass < clusterpages)
+			qtail[JQ_SUBMIT] = &pcl->next;
+		else
+			move_to_bypass_jobqueue(pcl, qtail, owned_head);
+	} while (owned_head != Z_EROFS_PCLUSTER_TAIL);
+
+	if (bio)
+		__submit_bio(bio, REQ_OP_READ, 0);
+
+	if (postsubmit_is_all_bypassed(q, nr_bios, force_fg))
+		return true;
+
+	z_erofs_vle_unzip_kickoff(bi_private, nr_bios);
+	return true;
+}
+
+static void z_erofs_submit_and_unzip(struct super_block *sb,
+				     struct z_erofs_collector *clt,
+				     struct list_head *pagepool,
+				     bool force_fg)
+{
+	struct z_erofs_unzip_io io[NR_JOBQUEUES];
+
+	if (!z_erofs_vle_submit_all(sb, clt->owned_head,
+				    pagepool, io, force_fg))
+		return;
+
+	if (!force_fg)
+		return;
+
+	/* wait until all bios are completed */
+	wait_event(io[JQ_SUBMIT].u.wait,
+		   !atomic_read(&io[JQ_SUBMIT].pending_bios));
+
+	/* let's synchronous decompression */
+	z_erofs_vle_unzip_all(sb, &io[JQ_SUBMIT], pagepool);
+}
+
+static int z_erofs_vle_normalaccess_readpage(struct file *file,
+					     struct page *page)
+{
+	struct inode *const inode = page->mapping->host;
+	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
+	int err;
+	LIST_HEAD(pagepool);
+
+	trace_erofs_readpage(page, false);
+
+	f.headoffset = (erofs_off_t)page->index << PAGE_SHIFT;
+
+	err = z_erofs_do_read_page(&f, page, &pagepool);
+	(void)z_erofs_collector_end(&f.clt);
+
+	if (err) {
+		errln("%s, failed to read, err [%d]", __func__, err);
+		goto out;
+	}
+
+	z_erofs_submit_and_unzip(inode->i_sb, &f.clt, &pagepool, true);
+out:
+	if (f.map.mpage)
+		put_page(f.map.mpage);
+
+	/* clean up the remaining free pages */
+	put_pages_list(&pagepool);
+	return 0;
+}
+
+static bool should_decompress_synchronously(struct erofs_sb_info *sbi,
+					    unsigned int nr)
+{
+	return nr <= sbi->max_sync_decompress_pages;
+}
+
+static int z_erofs_vle_normalaccess_readpages(struct file *filp,
+					      struct address_space *mapping,
+					      struct list_head *pages,
+					      unsigned int nr_pages)
+{
+	struct inode *const inode = mapping->host;
+	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
+
+	bool sync = should_decompress_synchronously(sbi, nr_pages);
+	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
+	gfp_t gfp = mapping_gfp_constraint(mapping, GFP_KERNEL);
+	struct page *head = NULL;
+	LIST_HEAD(pagepool);
+
+	trace_erofs_readpages(mapping->host, lru_to_page(pages),
+			      nr_pages, false);
+
+	f.headoffset = (erofs_off_t)lru_to_page(pages)->index << PAGE_SHIFT;
+
+	for (; nr_pages; --nr_pages) {
+		struct page *page = lru_to_page(pages);
+
+		prefetchw(&page->flags);
+		list_del(&page->lru);
+
+		/*
+		 * A pure asynchronous readahead is indicated if
+		 * a PG_readahead marked page is hitted at first.
+		 * Let's also do asynchronous decompression for this case.
+		 */
+		sync &= !(PageReadahead(page) && !head);
+
+		if (add_to_page_cache_lru(page, mapping, page->index, gfp)) {
+			list_add(&page->lru, &pagepool);
+			continue;
+		}
+
+		set_page_private(page, (unsigned long)head);
+		head = page;
+	}
+
+	while (head) {
+		struct page *page = head;
+		int err;
+
+		/* traversal in reverse order */
+		head = (void *)page_private(page);
+
+		err = z_erofs_do_read_page(&f, page, &pagepool);
+		if (err) {
+			struct erofs_vnode *vi = EROFS_V(inode);
+
+			errln("%s, readahead error at page %lu of nid %llu",
+			      __func__, page->index, vi->nid);
+		}
+		put_page(page);
+	}
+
+	(void)z_erofs_collector_end(&f.clt);
+
+	z_erofs_submit_and_unzip(inode->i_sb, &f.clt, &pagepool, sync);
+
+	if (f.map.mpage)
+		put_page(f.map.mpage);
+
+	/* clean up the remaining free pages */
+	put_pages_list(&pagepool);
+	return 0;
+}
+
+const struct address_space_operations z_erofs_vle_normalaccess_aops = {
+	.readpage = z_erofs_vle_normalaccess_readpage,
+	.readpages = z_erofs_vle_normalaccess_readpages,
+};
+
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
new file mode 100644
index 000000000000..53297d1811dd
--- /dev/null
+++ b/fs/erofs/zdata.h
@@ -0,0 +1,192 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * linux/fs/erofs/zdata.h
+ *
+ * Copyright (C) 2018 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Gao Xiang <gaoxiang25@huawei.com>
+ */
+#ifndef __EROFS_FS_UNZIP_VLE_H
+#define __EROFS_FS_UNZIP_VLE_H
+
+#include "internal.h"
+#include "zpvec.h"
+
+#define Z_EROFS_NR_INLINE_PAGEVECS      3
+
+/*
+ * Structure fields follow one of the following exclusion rules.
+ *
+ * I: Modifiable by initialization/destruction paths and read-only
+ *    for everyone else;
+ *
+ * L: Field protected by pageset lock;
+ *
+ * A: Field accessed / updated in atomic.
+ */
+struct z_erofs_collection {
+	struct mutex lock;
+
+	/* I: page offset of start position of decompression */
+	unsigned short pageofs;
+
+	/* L: maximum relative page index in pagevec[] */
+	unsigned short nr_pages;
+
+	/* L: total number of pages in pagevec[] */
+	unsigned int vcnt;
+
+	union {
+		/* L: inline a certain number of pagevecs for bootstrap */
+		erofs_vtptr_t pagevec[Z_EROFS_NR_INLINE_PAGEVECS];
+
+		/* I: can be used to free the pcluster by RCU. */
+		struct rcu_head rcu;
+	};
+};
+
+#define Z_EROFS_PCLUSTER_FULL_LENGTH    0x00000001
+#define Z_EROFS_PCLUSTER_LENGTH_BIT     1
+
+/*
+ * let's leave a type here in case of introducing
+ * another tagged pointer later.
+ */
+typedef void *z_erofs_next_pcluster_t;
+
+struct z_erofs_pcluster {
+	struct erofs_workgroup obj;
+	struct z_erofs_collection primary_collection;
+
+	/* point to next chained pcluster or TAILs */
+	z_erofs_next_pcluster_t next;
+
+	/* compressed pages (including multi-usage pages) */
+	struct page *compressed_pages[Z_EROFS_CLUSTER_MAX_PAGES];
+
+	/* A: lower limit of decompressed length and if full length or not */
+	unsigned int length;
+
+	/* I: compression algorithm format */
+	unsigned char algorithmformat;
+	/* I: bit shift of physical cluster size */
+	unsigned char clusterbits;
+};
+
+#define z_erofs_primarycollection(pcluster) (&(pcluster)->primary_collection)
+
+/* let's avoid the valid 32-bit kernel addresses */
+
+/* the chained workgroup has't submitted io (still open) */
+#define Z_EROFS_PCLUSTER_TAIL           ((void *)0x5F0ECAFE)
+/* the chained workgroup has already submitted io */
+#define Z_EROFS_PCLUSTER_TAIL_CLOSED    ((void *)0x5F0EDEAD)
+
+#define Z_EROFS_PCLUSTER_NIL            (NULL)
+
+#define Z_EROFS_WORKGROUP_SIZE  sizeof(struct z_erofs_pcluster)
+
+struct z_erofs_unzip_io {
+	atomic_t pending_bios;
+	z_erofs_next_pcluster_t head;
+
+	union {
+		wait_queue_head_t wait;
+		struct work_struct work;
+	} u;
+};
+
+struct z_erofs_unzip_io_sb {
+	struct z_erofs_unzip_io io;
+	struct super_block *sb;
+};
+
+#define MNGD_MAPPING(sbi)	(NULL)
+static inline bool erofs_page_is_managed(const struct erofs_sb_info *sbi,
+					 struct page *page) { return false; }
+
+#define Z_EROFS_ONLINEPAGE_COUNT_BITS   2
+#define Z_EROFS_ONLINEPAGE_COUNT_MASK   ((1 << Z_EROFS_ONLINEPAGE_COUNT_BITS) - 1)
+#define Z_EROFS_ONLINEPAGE_INDEX_SHIFT  (Z_EROFS_ONLINEPAGE_COUNT_BITS)
+
+/*
+ * waiters (aka. ongoing_packs): # to unlock the page
+ * sub-index: 0 - for partial page, >= 1 full page sub-index
+ */
+typedef atomic_t z_erofs_onlinepage_t;
+
+/* type punning */
+union z_erofs_onlinepage_converter {
+	z_erofs_onlinepage_t *o;
+	unsigned long *v;
+};
+
+static inline unsigned z_erofs_onlinepage_index(struct page *page)
+{
+	union z_erofs_onlinepage_converter u;
+
+	DBG_BUGON(!PagePrivate(page));
+	u.v = &page_private(page);
+
+	return atomic_read(u.o) >> Z_EROFS_ONLINEPAGE_INDEX_SHIFT;
+}
+
+static inline void z_erofs_onlinepage_init(struct page *page)
+{
+	union {
+		z_erofs_onlinepage_t o;
+		unsigned long v;
+	/* keep from being unlocked in advance */
+	} u = { .o = ATOMIC_INIT(1) };
+
+	set_page_private(page, u.v);
+	smp_wmb();
+	SetPagePrivate(page);
+}
+
+static inline void z_erofs_onlinepage_fixup(struct page *page,
+	uintptr_t index, bool down)
+{
+	unsigned long *p, o, v, id;
+repeat:
+	p = &page_private(page);
+	o = READ_ONCE(*p);
+
+	id = o >> Z_EROFS_ONLINEPAGE_INDEX_SHIFT;
+	if (id) {
+		if (!index)
+			return;
+
+		DBG_BUGON(id != index);
+	}
+
+	v = (index << Z_EROFS_ONLINEPAGE_INDEX_SHIFT) |
+		((o & Z_EROFS_ONLINEPAGE_COUNT_MASK) + (unsigned)down);
+	if (cmpxchg(p, o, v) != o)
+		goto repeat;
+}
+
+static inline void z_erofs_onlinepage_endio(struct page *page)
+{
+	union z_erofs_onlinepage_converter u;
+	unsigned v;
+
+	DBG_BUGON(!PagePrivate(page));
+	u.v = &page_private(page);
+
+	v = atomic_dec_return(u.o);
+	if (!(v & Z_EROFS_ONLINEPAGE_COUNT_MASK)) {
+		ClearPagePrivate(page);
+		if (!PageError(page))
+			SetPageUptodate(page);
+		unlock_page(page);
+	}
+	debugln("%s, page %p value %x", __func__, page, atomic_read(u.o));
+}
+
+#define Z_EROFS_VMAP_ONSTACK_PAGES	\
+	min_t(unsigned int, THREAD_SIZE / 8 / sizeof(struct page *), 96U)
+#define Z_EROFS_VMAP_GLOBAL_PAGES	2048
+
+#endif
+
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 006f09ce83a1..61e18322d804 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -23,7 +23,9 @@ int z_erofs_fill_inode(struct inode *inode)
 		vi->z_physical_clusterbits[1] = vi->z_logical_clusterbits;
 		set_bit(EROFS_V_Z_INITED_BIT, &vi->flags);
 	}
-	return -ENOTSUPP;
+
+	inode->i_mapping->a_ops = &z_erofs_vle_normalaccess_aops;
+	return 0;
 }
 
 static int fill_inode_lazy(struct inode *inode)
-- 
2.17.1

