Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B821659BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 16:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbfGKO73 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 10:59:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2258 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728892AbfGKO6r (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 10:58:47 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8678AE94A6E078841A25;
        Thu, 11 Jul 2019 22:58:43 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 11 Jul
 2019 22:58:37 +0800
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
Subject: [PATCH v2 16/24] erofs: introduce workstation for decompression
Date:   Thu, 11 Jul 2019 22:57:47 +0800
Message-ID: <20190711145755.33908-17-gaoxiang25@huawei.com>
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

This patch introduces another concept used by decompress
subsystem called 'workstation'. It can be seen as
a sparse array that stores pointers pointed to data
structures related to the corresponding physical clusters.

All lookups are protected by RCU read lock. Besides,
reference count and spin_lock are also introduced
to manage its lifetime and serialize all update
operations.

`workstation' is currently implemented on the in-kernel
radix tree approach for backward compatibility. With the
evolution of linux kernel, it will be migrated into
new XArray implementation in the future.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/internal.h |  83 ++++++++++++++++++++++
 fs/erofs/super.c    |   4 ++
 fs/erofs/utils.c    | 168 +++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 253 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 75e82fcdee08..f603ae8aa9b1 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -65,6 +65,9 @@ struct erofs_sb_info {
 	struct list_head list;
 	struct mutex umount_mutex;
 
+	/* the dedicated workstation for compression */
+	struct radix_tree_root workstn_tree;
+
 	unsigned int shrinker_run_no;
 #endif
 	u32 blocks;
@@ -150,6 +153,77 @@ static inline void *erofs_kmalloc(struct erofs_sb_info *sbi,
 #define set_opt(sbi, option)	((sbi)->mount_opt |= EROFS_MOUNT_##option)
 #define test_opt(sbi, option)	((sbi)->mount_opt & EROFS_MOUNT_##option)
 
+#ifdef CONFIG_EROFS_FS_ZIP
+#define EROFS_LOCKED_MAGIC     (INT_MIN | 0xE0F510CCL)
+
+/* basic unit of the workstation of a super_block */
+struct erofs_workgroup {
+	/* the workgroup index in the workstation */
+	pgoff_t index;
+
+	/* overall workgroup reference count */
+	atomic_t refcount;
+};
+
+#if defined(CONFIG_SMP)
+static inline bool erofs_workgroup_try_to_freeze(struct erofs_workgroup *grp,
+						 int val)
+{
+	preempt_disable();
+	if (val != atomic_cmpxchg(&grp->refcount, val, EROFS_LOCKED_MAGIC)) {
+		preempt_enable();
+		return false;
+	}
+	return true;
+}
+
+static inline void erofs_workgroup_unfreeze(struct erofs_workgroup *grp,
+					    int orig_val)
+{
+	/*
+	 * other observers should notice all modifications
+	 * in the freezing period.
+	 */
+	smp_mb();
+	atomic_set(&grp->refcount, orig_val);
+	preempt_enable();
+}
+
+static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
+{
+	return atomic_cond_read_relaxed(&grp->refcount,
+					VAL != EROFS_LOCKED_MAGIC);
+}
+#else
+static inline bool erofs_workgroup_try_to_freeze(struct erofs_workgroup *grp,
+						 int val)
+{
+	preempt_disable();
+	/* no need to spin on UP platforms, let's just disable preemption. */
+	if (val != atomic_read(&grp->refcount)) {
+		preempt_enable();
+		return false;
+	}
+	return true;
+}
+
+static inline void erofs_workgroup_unfreeze(struct erofs_workgroup *grp,
+					    int orig_val)
+{
+	preempt_enable();
+}
+
+static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
+{
+	int v = atomic_read(&grp->refcount);
+
+	/* workgroup is never freezed on uniprocessor systems */
+	DBG_BUGON(v == EROFS_LOCKED_MAGIC);
+	return v;
+}
+#endif
+#endif
+
 /* we strictly follow PAGE_SIZE and no buffer head yet */
 #define LOG_BLOCK_SIZE		PAGE_SHIFT
 
@@ -413,6 +487,15 @@ extern const struct file_operations erofs_dir_fops;
 
 /* utils.c */
 #ifdef CONFIG_EROFS_FS_ZIP
+int erofs_workgroup_put(struct erofs_workgroup *grp);
+struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
+					     pgoff_t index, bool *tag);
+int erofs_register_workgroup(struct super_block *sb,
+			     struct erofs_workgroup *grp, bool tag);
+unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
+				       unsigned long nr_shrink, bool cleanup);
+static inline void erofs_workgroup_free_rcu(struct erofs_workgroup *grp) {}
+
 void erofs_shrinker_register(struct super_block *sb);
 void erofs_shrinker_unregister(struct super_block *sb);
 int __init erofs_init_shrinker(void);
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index ab9d0ad94afb..acb60553b586 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -343,6 +343,10 @@ static int erofs_read_super(struct super_block *sb,
 	else
 		sb->s_flags &= ~SB_POSIXACL;
 
+#ifdef CONFIG_EROFS_FS_ZIP
+	INIT_RADIX_TREE(&sbi->workstn_tree, GFP_ATOMIC);
+#endif
+
 	/* get the root inode */
 	inode = erofs_iget(sb, ROOT_NID(sbi), true);
 	if (IS_ERR(inode)) {
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index 727d3831b5c9..45fd780e6429 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -7,11 +7,175 @@
  * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #include "internal.h"
+#include <linux/pagevec.h>
 
 #ifdef CONFIG_EROFS_FS_ZIP
 /* global shrink count (for all mounted EROFS instances) */
 static atomic_long_t erofs_global_shrink_cnt;
 
+#define __erofs_workgroup_get(grp)	atomic_inc(&(grp)->refcount)
+#define __erofs_workgroup_put(grp)	atomic_dec(&(grp)->refcount)
+
+static int erofs_workgroup_get(struct erofs_workgroup *grp)
+{
+	int o;
+
+repeat:
+	o = erofs_wait_on_workgroup_freezed(grp);
+	if (unlikely(o <= 0))
+		return -1;
+
+	if (unlikely(atomic_cmpxchg(&grp->refcount, o, o + 1) != o))
+		goto repeat;
+
+	/* decrease refcount paired by erofs_workgroup_put */
+	if (unlikely(o == 1))
+		atomic_long_dec(&erofs_global_shrink_cnt);
+	return 0;
+}
+
+struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
+					     pgoff_t index, bool *tag)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct erofs_workgroup *grp;
+
+repeat:
+	rcu_read_lock();
+	grp = radix_tree_lookup(&sbi->workstn_tree, index);
+	if (grp) {
+		*tag = xa_pointer_tag(grp);
+		grp = xa_untag_pointer(grp);
+
+		if (erofs_workgroup_get(grp)) {
+			/* prefer to relax rcu read side */
+			rcu_read_unlock();
+			goto repeat;
+		}
+
+		DBG_BUGON(index != grp->index);
+	}
+	rcu_read_unlock();
+	return grp;
+}
+
+int erofs_register_workgroup(struct super_block *sb,
+			     struct erofs_workgroup *grp,
+			     bool tag)
+{
+	struct erofs_sb_info *sbi;
+	int err;
+
+	/* grp shouldn't be broken or used before */
+	if (unlikely(atomic_read(&grp->refcount) != 1)) {
+		DBG_BUGON(1);
+		return -EINVAL;
+	}
+
+	err = radix_tree_preload(GFP_NOFS);
+	if (err)
+		return err;
+
+	sbi = EROFS_SB(sb);
+
+	xa_lock(&sbi->workstn_tree);
+	grp = xa_tag_pointer(grp, tag);
+
+	/*
+	 * Bump up reference count before making this workgroup
+	 * visible to other users in order to avoid potential UAF
+	 * without serialized by erofs_workstn_lock.
+	 */
+	__erofs_workgroup_get(grp);
+
+	err = radix_tree_insert(&sbi->workstn_tree,
+				grp->index, grp);
+	if (unlikely(err))
+		/*
+		 * it's safe to decrease since the workgroup isn't visible
+		 * and refcount >= 2 (cannot be freezed).
+		 */
+		__erofs_workgroup_put(grp);
+
+	xa_unlock(&sbi->workstn_tree);
+	radix_tree_preload_end();
+	return err;
+}
+
+static void  __erofs_workgroup_free(struct erofs_workgroup *grp)
+{
+	atomic_long_dec(&erofs_global_shrink_cnt);
+	erofs_workgroup_free_rcu(grp);
+}
+
+int erofs_workgroup_put(struct erofs_workgroup *grp)
+{
+	int count = atomic_dec_return(&grp->refcount);
+
+	if (count == 1)
+		atomic_long_inc(&erofs_global_shrink_cnt);
+	else if (!count)
+		__erofs_workgroup_free(grp);
+	return count;
+}
+
+/* for nocache case, no customized reclaim path at all */
+static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
+					   struct erofs_workgroup *grp,
+					   bool cleanup)
+{
+	int cnt = atomic_read(&grp->refcount);
+
+	DBG_BUGON(cnt <= 0);
+	DBG_BUGON(cleanup && cnt != 1);
+
+	if (cnt > 1)
+		return false;
+
+	DBG_BUGON(xa_untag_pointer(radix_tree_delete(&sbi->workstn_tree,
+						     grp->index)) != grp);
+
+	/* (rarely) could be grabbed again when freeing */
+	erofs_workgroup_put(grp);
+	return true;
+}
+
+
+unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
+				       unsigned long nr_shrink,
+				       bool cleanup)
+{
+	pgoff_t first_index = 0;
+	void *batch[PAGEVEC_SIZE];
+	unsigned int freed = 0;
+
+	int i, found;
+repeat:
+	xa_lock(&sbi->workstn_tree);
+
+	found = radix_tree_gang_lookup(&sbi->workstn_tree,
+				       batch, first_index, PAGEVEC_SIZE);
+
+	for (i = 0; i < found; ++i) {
+		struct erofs_workgroup *grp = xa_untag_pointer(batch[i]);
+
+		first_index = grp->index + 1;
+
+		/* try to shrink each valid workgroup */
+		if (!erofs_try_to_release_workgroup(sbi, grp, cleanup))
+			continue;
+
+		++freed;
+		if (unlikely(!--nr_shrink))
+			break;
+	}
+	xa_unlock(&sbi->workstn_tree);
+
+	if (i && nr_shrink)
+		goto repeat;
+	return freed;
+}
+
 /* protected by 'erofs_sb_list_lock' */
 static unsigned int shrinker_run_no;
 
@@ -35,7 +199,7 @@ void erofs_shrinker_unregister(struct super_block *sb)
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 
 	mutex_lock(&sbi->umount_mutex);
-	/* will add shrink final handler here */
+	erofs_shrink_workstation(EROFS_SB(sb), ~0UL, true);
 
 	spin_lock(&erofs_sb_list_lock);
 	list_del(&sbi->list);
@@ -84,7 +248,7 @@ static unsigned long erofs_shrink_scan(struct shrinker *shrink,
 		spin_unlock(&erofs_sb_list_lock);
 		sbi->shrinker_run_no = run_no;
 
-		/* will add shrink handler here */
+		freed += erofs_shrink_workstation(sbi, nr, false);
 
 		spin_lock(&erofs_sb_list_lock);
 		/* Get the next list element before we move this one */
-- 
2.17.1

