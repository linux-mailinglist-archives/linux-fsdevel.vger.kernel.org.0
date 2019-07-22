Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19ACC6F754
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 04:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfGVCvc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Jul 2019 22:51:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2295 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728912AbfGVCvb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Jul 2019 22:51:31 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 631B318A6D770272F0D4;
        Mon, 22 Jul 2019 10:51:29 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 22 Jul
 2019 10:51:21 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
CC:     <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v3 23/24] erofs: introduce cached decompression
Date:   Mon, 22 Jul 2019 10:50:42 +0800
Message-ID: <20190722025043.166344-24-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190722025043.166344-1-gaoxiang25@huawei.com>
References: <20190722025043.166344-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds strategies which can be selected
by users in order to cache both incomplete ends of
compressed physical clusters as a complement of
in-place I/O in order to boost random read, but
it costs more memory than the in-place I/O only.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/Kconfig    |  38 ++++++++++
 fs/erofs/internal.h |  17 +++++
 fs/erofs/super.c    |  15 +++-
 fs/erofs/utils.c    | 104 ++++++++++++++++++++++++++-
 fs/erofs/zdata.c    | 171 ++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/zdata.h    |   9 +++
 6 files changed, 352 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 5eb5cf1148a5..7fde54f76d5b 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -114,3 +114,41 @@ config EROFS_FS_CLUSTER_PAGE_LIMIT
 	  less than 2. Otherwise, the image will be refused
 	  to mount on this kernel.
 
+choice
+	prompt "EROFS Data Decompression mode"
+	depends on EROFS_FS_ZIP
+	default EROFS_FS_ZIP_CACHE_READAROUND
+	help
+	  EROFS supports three options for decompression.
+	  "In-place I/O Only" consumes the minimum memory
+	  with lowest random read.
+
+	  "Cached Decompression for readaround" consumes
+	  the maximum memory with highest random read.
+
+	  If unsure, select "Cached Decompression for readaround"
+
+config EROFS_FS_ZIP_CACHE_DISABLED
+	bool "In-place I/O Only"
+	help
+	  Read compressed data into page cache and do in-place
+	  I/O decompression directly.
+
+config EROFS_FS_ZIP_CACHE_READAHEAD
+	bool "Cached Decompression for readahead"
+	help
+	  For each request, it caches the last compressed page
+	  for further reading.
+	  It still does in-place I/O for the rest compressed pages.
+
+config EROFS_FS_ZIP_CACHE_READAROUND
+	bool "Cached Decompression for readaround"
+	help
+	  For each request, it caches the both end compressed pages
+	  for further reading.
+	  It still does in-place I/O for the rest compressed pages.
+
+	  Recommended for performance priority.
+
+endchoice
+
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 1092a80a212e..91a4608499af 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -52,6 +52,11 @@ struct erofs_fault_info {
 };
 #endif
 
+#ifdef CONFIG_EROFS_FS_ZIP_CACHE_READAROUND
+#define EROFS_FS_HAS_MANAGED_CACHE	(2)
+#elif defined(CONFIG_EROFS_FS_ZIP_CACHE_READAHEAD)
+#define EROFS_FS_HAS_MANAGED_CACHE	(1)
+#endif
 /* EROFS_SUPER_MAGIC_V1 to represent the whole file system */
 #define EROFS_SUPER_MAGIC   EROFS_SUPER_MAGIC_V1
 
@@ -74,6 +79,10 @@ struct erofs_sb_info {
 
 	unsigned int shrinker_run_no;
 #endif
+
+#ifdef EROFS_FS_HAS_MANAGED_CACHE
+	struct inode *managed_cache;
+#endif
 	u32 blocks;
 	u32 meta_blkaddr;
 #ifdef CONFIG_EROFS_FS_XATTR
@@ -545,5 +554,13 @@ static inline int z_erofs_init_zip_subsystem(void) { return 0; }
 static inline void z_erofs_exit_zip_subsystem(void) {}
 #endif
 
+#ifdef EROFS_FS_HAS_MANAGED_CACHE
+struct inode *erofs_init_managed_cache(struct super_block *sb);
+int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
+				       struct erofs_workgroup *egrp);
+int erofs_try_to_free_cached_page(struct address_space *mapping,
+				  struct page *page);
+#endif
+
 #endif
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index bd45a674dea9..aa4bbfde6f8e 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -327,7 +327,6 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
 #ifdef CONFIG_EROFS_FS_XATTR
 	sb->s_xattr = erofs_xattr_handlers;
 #endif
-
 	/* set erofs default mount options */
 	default_options(sbi);
 
@@ -364,6 +363,12 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
 		return -ENOMEM;
 
 	erofs_shrinker_register(sb);
+#ifdef EROFS_FS_HAS_MANAGED_CACHE
+	/* sb->s_umount is locked here, SB_ACTIVE and SB_BORN are not set */
+	sbi->managed_cache = erofs_init_managed_cache(sb);
+	if (unlikely(!sbi->managed_cache))
+		return -ENOMEM;
+#endif
 
 	if (!silent)
 		infoln("mounted on %s with opts: %s.", sb->s_id, (char *)data);
@@ -399,6 +404,14 @@ static void erofs_kill_sb(struct super_block *sb)
 /* called when ->s_root is non-NULL */
 static void erofs_put_super(struct super_block *sb)
 {
+	struct erofs_sb_info *const sbi = EROFS_SB(sb);
+
+	DBG_BUGON(!sbi);
+
+#ifdef EROFS_FS_HAS_MANAGED_CACHE
+	iput(sbi->managed_cache);
+	sbi->managed_cache = NULL;
+#endif
 	erofs_shrinker_unregister(sb);
 }
 
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index 53ee6daa3f70..359d3357701d 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -145,6 +145,53 @@ int erofs_workgroup_put(struct erofs_workgroup *grp)
 	return count;
 }
 
+#ifdef EROFS_FS_HAS_MANAGED_CACHE
+/* for cache-managed case, customized reclaim paths exist */
+static void erofs_workgroup_unfreeze_final(struct erofs_workgroup *grp)
+{
+	erofs_workgroup_unfreeze(grp, 0);
+	__erofs_workgroup_free(grp);
+}
+
+static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
+					   struct erofs_workgroup *grp,
+					   bool cleanup)
+{
+	/*
+	 * for managed cache enabled, the refcount of workgroups
+	 * themselves could be < 0 (freezed). So there is no guarantee
+	 * that all refcount > 0 if managed cache is enabled.
+	 */
+	if (!erofs_workgroup_try_to_freeze(grp, 1))
+		return false;
+
+	/*
+	 * note that all cached pages should be unlinked
+	 * before delete it from the radix tree.
+	 * Otherwise some cached pages of an orphan old workgroup
+	 * could be still linked after the new one is available.
+	 */
+	if (erofs_try_to_free_all_cached_pages(sbi, grp)) {
+		erofs_workgroup_unfreeze(grp, 1);
+		return false;
+	}
+
+	/*
+	 * it is impossible to fail after the workgroup is freezed,
+	 * however in order to avoid some race conditions, add a
+	 * DBG_BUGON to observe this in advance.
+	 */
+	DBG_BUGON(xa_untag_pointer(radix_tree_delete(&sbi->workstn_tree,
+						     grp->index)) != grp);
+
+	/*
+	 * if managed cache is enable, the last refcount
+	 * should indicate the related workstation.
+	 */
+	erofs_workgroup_unfreeze_final(grp);
+	return true;
+}
+#else
 /* for nocache case, no customized reclaim path at all */
 static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
 					   struct erofs_workgroup *grp,
@@ -165,7 +212,7 @@ static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
 	erofs_workgroup_put(grp);
 	return true;
 }
-
+#endif
 
 unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
 				       unsigned long nr_shrink,
@@ -312,3 +359,58 @@ void erofs_exit_shrinker(void)
 
 #endif
 
+#ifdef EROFS_FS_HAS_MANAGED_CACHE
+static const struct address_space_operations managed_cache_aops;
+
+struct inode *erofs_init_managed_cache(struct super_block *sb)
+{
+	struct inode *const inode = new_inode(sb);
+
+	if (unlikely(!inode))
+		return NULL;
+
+	set_nlink(inode, 1);
+	inode->i_size = OFFSET_MAX;
+
+	inode->i_mapping->a_ops = &managed_cache_aops;
+	mapping_set_gfp_mask(inode->i_mapping,
+			     GFP_NOFS | __GFP_HIGHMEM | __GFP_MOVABLE);
+	return inode;
+}
+
+static int erofs_managed_cache_releasepage(struct page *page, gfp_t gfp_mask)
+{
+	int ret = 1;	/* 0 - busy */
+	struct address_space *const mapping = page->mapping;
+
+	DBG_BUGON(!PageLocked(page));
+	DBG_BUGON(mapping->a_ops != &managed_cache_aops);
+
+	if (PagePrivate(page))
+		ret = erofs_try_to_free_cached_page(mapping, page);
+
+	return ret;
+}
+
+static void erofs_managed_cache_invalidatepage(struct page *page,
+					       unsigned int offset,
+					       unsigned int length)
+{
+	const unsigned int stop = length + offset;
+
+	DBG_BUGON(!PageLocked(page));
+
+	/* Check for potential overflow in debug mode */
+	DBG_BUGON(stop > PAGE_SIZE || stop < length);
+
+	if (offset == 0 && stop == PAGE_SIZE)
+		while (!erofs_managed_cache_releasepage(page, GFP_NOFS))
+			cond_resched();
+}
+
+static const struct address_space_operations managed_cache_aops = {
+	.releasepage = erofs_managed_cache_releasepage,
+	.invalidatepage = erofs_managed_cache_invalidatepage,
+};
+#endif
+
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index a3e4de0f9c64..7bf25efae53c 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -162,6 +162,118 @@ struct z_erofs_decompress_frontend {
 static struct page *z_pagemap_global[Z_EROFS_VMAP_GLOBAL_PAGES];
 static DEFINE_MUTEX(z_pagemap_global_lock);
 
+#ifdef EROFS_FS_HAS_MANAGED_CACHE
+static void preload_compressed_pages(struct z_erofs_collector *clt,
+				     struct address_space *mc,
+				     enum z_erofs_cache_alloctype type,
+				     struct list_head *pagepool)
+{
+	const struct z_erofs_pcluster *pcl = clt->pcl;
+	const unsigned int clusterpages = BIT(pcl->clusterbits);
+	struct page **pages = clt->compressedpages;
+	pgoff_t index = pcl->obj.index + (pages - pcl->compressed_pages);
+	bool standalone = true;
+
+	if (clt->mode < COLLECT_PRIMARY_FOLLOWED)
+		return;
+
+	for (; pages < pcl->compressed_pages + clusterpages; ++pages) {
+		struct page *page;
+		compressed_page_t t;
+
+		/* the compressed page was loaded before */
+		if (READ_ONCE(*pages))
+			continue;
+
+		page = find_get_page(mc, index);
+
+		if (page) {
+			t = tag_compressed_page_justfound(page);
+		} else if (type == DELAYEDALLOC) {
+			t = tagptr_init(compressed_page_t, PAGE_UNALLOCATED);
+		} else {	/* DONTALLOC */
+			if (standalone)
+				clt->compressedpages = pages;
+			standalone = false;
+			continue;
+		}
+
+		if (!cmpxchg_relaxed(pages, NULL, tagptr_cast_ptr(t)))
+			continue;
+
+		if (page)
+			put_page(page);
+	}
+
+	if (standalone)		/* downgrade to PRIMARY_FOLLOWED_NOINPLACE */
+		clt->mode = COLLECT_PRIMARY_FOLLOWED_NOINPLACE;
+}
+
+/* called by erofs_shrinker to get rid of all compressed_pages */
+int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
+				       struct erofs_workgroup *grp)
+{
+	struct z_erofs_pcluster *const pcl =
+		container_of(grp, struct z_erofs_pcluster, obj);
+	struct address_space *const mapping = MNGD_MAPPING(sbi);
+	const unsigned int clusterpages = BIT(pcl->clusterbits);
+	int i;
+
+	/*
+	 * refcount of workgroup is now freezed as 1,
+	 * therefore no need to worry about available decompression users.
+	 */
+	for (i = 0; i < clusterpages; ++i) {
+		struct page *page = pcl->compressed_pages[i];
+
+		if (!page)
+			continue;
+
+		/* block other users from reclaiming or migrating the page */
+		if (!trylock_page(page))
+			return -EBUSY;
+
+		if (unlikely(page->mapping != mapping))
+			continue;
+
+		/* barrier is implied in the following 'unlock_page' */
+		pcl->compressed_pages[i] = NULL;
+		set_page_private(page, 0);
+		ClearPagePrivate(page);
+
+		unlock_page(page);
+		put_page(page);
+	}
+	return 0;
+}
+
+int erofs_try_to_free_cached_page(struct address_space *mapping,
+				  struct page *page)
+{
+	struct z_erofs_pcluster *const pcl = (void *)page_private(page);
+	const unsigned int clusterpages = BIT(pcl->clusterbits);
+	int ret = 0;	/* 0 - busy */
+
+	if (erofs_workgroup_try_to_freeze(&pcl->obj, 1)) {
+		unsigned int i;
+
+		for (i = 0; i < clusterpages; ++i) {
+			if (pcl->compressed_pages[i] == page) {
+				pcl->compressed_pages[i] = NULL;
+				ret = 1;
+				break;
+			}
+		}
+		erofs_workgroup_unfreeze(&pcl->obj, 1);
+
+		if (ret) {
+			ClearPagePrivate(page);
+			put_page(page);
+		}
+	}
+	return ret;
+}
+#else
 static void preload_compressed_pages(struct z_erofs_collector *clt,
 				     struct address_space *mc,
 				     enum z_erofs_cache_alloctype type,
@@ -169,6 +281,7 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
 {
 	/* nowhere to load compressed pages from */
 }
+#endif
 
 /* page_type must be Z_EROFS_PAGE_TYPE_EXCLUSIVE */
 static inline bool try_inplace_io(struct z_erofs_collector *clt,
@@ -440,6 +553,13 @@ static inline struct page *__stagingpage_alloc(struct list_head *pagepool,
 static bool should_alloc_managed_pages(struct z_erofs_decompress_frontend *fe,
 				       erofs_off_t la)
 {
+#ifdef EROFS_FS_HAS_MANAGED_CACHE
+	if (fe->backmost)
+		return true;
+#if (EROFS_FS_HAS_MANAGED_CACHE >= 2)
+	return la < fe->headoffset;
+#endif
+#endif
 	return false;
 }
 
@@ -1002,6 +1122,9 @@ static struct z_erofs_unzip_io *jobqueue_init(struct super_block *sb,
 
 /* define decompression jobqueue types */
 enum {
+#ifdef EROFS_FS_HAS_MANAGED_CACHE
+	JQ_BYPASS,
+#endif
 	JQ_SUBMIT,
 	NR_JOBQUEUES,
 };
@@ -1012,12 +1135,56 @@ static void *jobqueueset_init(struct super_block *sb,
 			      struct z_erofs_unzip_io *fgq,
 			      bool forcefg)
 {
+#ifdef EROFS_FS_HAS_MANAGED_CACHE
+	/*
+	 * if managed cache is enabled, bypass jobqueue is needed,
+	 * no need to read from device for all pclusters in this queue.
+	 */
+	q[JQ_BYPASS] = jobqueue_init(sb, fgq + JQ_BYPASS, true);
+	qtail[JQ_BYPASS] = &q[JQ_BYPASS]->head;
+#endif
+
 	q[JQ_SUBMIT] = jobqueue_init(sb, fgq + JQ_SUBMIT, forcefg);
 	qtail[JQ_SUBMIT] = &q[JQ_SUBMIT]->head;
 
 	return tagptr_cast_ptr(tagptr_fold(tagptr1_t, q[JQ_SUBMIT], !forcefg));
 }
 
+#ifdef EROFS_FS_HAS_MANAGED_CACHE
+static void move_to_bypass_jobqueue(struct z_erofs_pcluster *pcl,
+				    z_erofs_next_pcluster_t qtail[],
+				    z_erofs_next_pcluster_t owned_head)
+{
+	z_erofs_next_pcluster_t *const submit_qtail = qtail[JQ_SUBMIT];
+	z_erofs_next_pcluster_t *const bypass_qtail = qtail[JQ_BYPASS];
+
+	DBG_BUGON(owned_head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
+	if (owned_head == Z_EROFS_PCLUSTER_TAIL)
+		owned_head = Z_EROFS_PCLUSTER_TAIL_CLOSED;
+
+	WRITE_ONCE(pcl->next, Z_EROFS_PCLUSTER_TAIL_CLOSED);
+
+	WRITE_ONCE(*submit_qtail, owned_head);
+	WRITE_ONCE(*bypass_qtail, &pcl->next);
+
+	qtail[JQ_BYPASS] = &pcl->next;
+}
+
+static bool postsubmit_is_all_bypassed(struct z_erofs_unzip_io *q[],
+				       unsigned int nr_bios,
+				       bool force_fg)
+{
+	/*
+	 * although background is preferred, no one is pending for submission.
+	 * don't issue workqueue for decompression but drop it directly instead.
+	 */
+	if (force_fg || nr_bios)
+		return false;
+
+	kvfree(container_of(q[JQ_SUBMIT], struct z_erofs_unzip_io_sb, io));
+	return true;
+}
+#else
 static void move_to_bypass_jobqueue(struct z_erofs_pcluster *pcl,
 				    z_erofs_next_pcluster_t qtail[],
 				    z_erofs_next_pcluster_t owned_head)
@@ -1034,6 +1201,7 @@ static bool postsubmit_is_all_bypassed(struct z_erofs_unzip_io *q[],
 	DBG_BUGON(!nr_bios);
 	return false;
 }
+#endif
 
 static bool z_erofs_vle_submit_all(struct super_block *sb,
 				   z_erofs_next_pcluster_t owned_head,
@@ -1145,6 +1313,9 @@ static void z_erofs_submit_and_unzip(struct super_block *sb,
 				    pagepool, io, force_fg))
 		return;
 
+#ifdef EROFS_FS_HAS_MANAGED_CACHE
+	z_erofs_vle_unzip_all(sb, &io[JQ_BYPASS], pagepool);
+#endif
 	if (!force_fg)
 		return;
 
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index d07a7aa9a1a8..1e89dcea6b93 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -101,9 +101,18 @@ struct z_erofs_unzip_io_sb {
 	struct super_block *sb;
 };
 
+#ifdef EROFS_FS_HAS_MANAGED_CACHE
+#define MNGD_MAPPING(sbi)	((sbi)->managed_cache->i_mapping)
+static inline bool erofs_page_is_managed(const struct erofs_sb_info *sbi,
+					 struct page *page)
+{
+	return page->mapping == MNGD_MAPPING(sbi);
+}
+#else
 #define MNGD_MAPPING(sbi)	(NULL)
 static inline bool erofs_page_is_managed(const struct erofs_sb_info *sbi,
 					 struct page *page) { return false; }
+#endif
 
 #define Z_EROFS_ONLINEPAGE_COUNT_BITS   2
 #define Z_EROFS_ONLINEPAGE_COUNT_MASK   ((1 << Z_EROFS_ONLINEPAGE_COUNT_BITS) - 1)
-- 
2.17.1

