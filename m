Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A685375242E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 15:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjGMNtQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 09:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjGMNtM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:49:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4691BF4
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 06:49:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4523161542
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 13:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFD3C433C7;
        Thu, 13 Jul 2023 13:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689256149;
        bh=7ujiWzBqUHHMtvILuGdMIIGD3amWSSvl55kgym4kt2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XpJYwMYDUtSESTN7q8TnoIJi78aI7FAhNnKbEI7ZbQgpB0mSl+R9FbNfVttDkwQQw
         JdRPiDVMPnIpOAmBDrgPW5CC2ElN/UEgHR8jwVZD4V5r4jf/JdZA2v6qAI2zNm1r4m
         NAcsc0ugJU42e7wZjO9rIBECwN8nXDw+u5//seQhTWyiPe/Mxf8XnBcPKvx2uA/3IH
         VfowPIN3yIjwRKWusAFecpruGFsOohejD+1/1g7HJrfiR07PCxdPr3u2pp8lkwcC0N
         K8gu21AxIsmwm1SF7qe+4vnQjaFC+q2TtCvLgfda9yAADgnMC846PND0O4Frb67M3U
         nmZPCjHrDDk0Q==
From:   cem@kernel.org
To:     linux-fsdevel@vger.kernel.org
Cc:     jack@suse.cz, akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, djwong@kernel.org, hughd@google.com,
        brauner@kernel.org, mcgrof@kernel.org
Subject: [PATCH 4/6] shmem: prepare shmem quota infrastructure
Date:   Thu, 13 Jul 2023 15:48:46 +0200
Message-Id: <20230713134848.249779-5-cem@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230713134848.249779-1-cem@kernel.org>
References: <20230713134848.249779-1-cem@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Carlos Maiolino <cem@kernel.org>

Add new shmem quota format, its quota_format_ops together with
dquot_operations

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/Kconfig                 |  12 ++
 include/linux/shmem_fs.h   |  12 ++
 include/uapi/linux/quota.h |   1 +
 mm/Makefile                |   2 +-
 mm/shmem_quota.c           | 318 +++++++++++++++++++++++++++++++++++++
 5 files changed, 344 insertions(+), 1 deletion(-)
 create mode 100644 mm/shmem_quota.c

diff --git a/fs/Kconfig b/fs/Kconfig
index 18d034ec7953..8218a71933f9 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -233,6 +233,18 @@ config TMPFS_INODE64
 
 	  If unsure, say N.
 
+config TMPFS_QUOTA
+	bool "Tmpfs quota support"
+	depends on TMPFS
+	select QUOTA
+	help
+	  Quota support allows to set per user and group limits for tmpfs
+	  usage.  Say Y to enable quota support. Once enabled you can control
+	  user and group quota enforcement with quota, usrquota and grpquota
+	  mount options.
+
+	  If unsure, say N.
+
 config ARCH_SUPPORTS_HUGETLBFS
 	def_bool n
 
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 9029abd29b1c..7abfaf70b58a 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -13,6 +13,10 @@
 
 /* inode in-kernel data */
 
+#ifdef CONFIG_TMPFS_QUOTA
+#define SHMEM_MAXQUOTAS 2
+#endif
+
 struct shmem_inode_info {
 	spinlock_t		lock;
 	unsigned int		seals;		/* shmem seals */
@@ -172,4 +176,12 @@ extern int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 #endif /* CONFIG_SHMEM */
 #endif /* CONFIG_USERFAULTFD */
 
+/*
+ * Used space is stored as unsigned 64-bit value in bytes but
+ * quota core supports only signed 64-bit values so use that
+ * as a limit
+ */
+#define SHMEM_QUOTA_MAX_SPC_LIMIT 0x7fffffffffffffffLL /* 2^63-1 */
+#define SHMEM_QUOTA_MAX_INO_LIMIT 0x7fffffffffffffffLL
+
 #endif
diff --git a/include/uapi/linux/quota.h b/include/uapi/linux/quota.h
index f17c9636a859..52090105b828 100644
--- a/include/uapi/linux/quota.h
+++ b/include/uapi/linux/quota.h
@@ -77,6 +77,7 @@
 #define	QFMT_VFS_V0 2
 #define QFMT_OCFS2 3
 #define	QFMT_VFS_V1 4
+#define	QFMT_SHMEM 5
 
 /* Size of block in which space limits are passed through the quota
  * interface */
diff --git a/mm/Makefile b/mm/Makefile
index 678530a07326..d4ee20988dd1 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -51,7 +51,7 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 			   readahead.o swap.o truncate.o vmscan.o shmem.o \
 			   util.o mmzone.o vmstat.o backing-dev.o \
 			   mm_init.o percpu.o slab_common.o \
-			   compaction.o show_mem.o\
+			   compaction.o show_mem.o shmem_quota.o\
 			   interval_tree.o list_lru.o workingset.o \
 			   debug.o gup.o mmap_lock.o $(mmu-y)
 
diff --git a/mm/shmem_quota.c b/mm/shmem_quota.c
new file mode 100644
index 000000000000..c0b531e2ef68
--- /dev/null
+++ b/mm/shmem_quota.c
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * In memory quota format relies on quota infrastructure to store dquot
+ * information for us. While conventional quota formats for file systems
+ * with persistent storage can load quota information into dquot from the
+ * storage on-demand and hence quota dquot shrinker can free any dquot
+ * that is not currently being used, it must be avoided here. Otherwise we
+ * can lose valuable information, user provided limits, because there is
+ * no persistent storage to load the information from afterwards.
+ *
+ * One information that in-memory quota format needs to keep track of is
+ * a sorted list of ids for each quota type. This is done by utilizing
+ * an rb tree which root is stored in mem_dqinfo->dqi_priv for each quota
+ * type.
+ *
+ * This format can be used to support quota on file system without persistent
+ * storage such as tmpfs.
+ *
+ * Author:	Lukas Czerner <lczerner@redhat.com>
+ *		Carlos Maiolino <cmaiolino@redhat.com>
+ *
+ * Copyright (C) 2023 Red Hat, Inc.
+ */
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/rbtree.h>
+#include <linux/shmem_fs.h>
+
+#include <linux/quotaops.h>
+#include <linux/quota.h>
+
+#ifdef CONFIG_TMPFS_QUOTA
+
+/*
+ * The following constants define the amount of time given a user
+ * before the soft limits are treated as hard limits (usually resulting
+ * in an allocation failure). The timer is started when the user crosses
+ * their soft limit, it is reset when they go below their soft limit.
+ */
+#define SHMEM_MAX_IQ_TIME 604800	/* (7*24*60*60) 1 week */
+#define SHMEM_MAX_DQ_TIME 604800	/* (7*24*60*60) 1 week */
+
+struct quota_id {
+	struct rb_node	node;
+	qid_t		id;
+	qsize_t		bhardlimit;
+	qsize_t		bsoftlimit;
+	qsize_t		ihardlimit;
+	qsize_t		isoftlimit;
+};
+
+static int shmem_check_quota_file(struct super_block *sb, int type)
+{
+	/* There is no real quota file, nothing to do */
+	return 1;
+}
+
+/*
+ * There is no real quota file. Just allocate rb_root for quota ids and
+ * set limits
+ */
+static int shmem_read_file_info(struct super_block *sb, int type)
+{
+	struct quota_info *dqopt = sb_dqopt(sb);
+	struct mem_dqinfo *info = &dqopt->info[type];
+
+	info->dqi_priv = kzalloc(sizeof(struct rb_root), GFP_NOFS);
+	if (!info->dqi_priv)
+		return -ENOMEM;
+
+	info->dqi_max_spc_limit = SHMEM_QUOTA_MAX_SPC_LIMIT;
+	info->dqi_max_ino_limit = SHMEM_QUOTA_MAX_INO_LIMIT;
+
+	info->dqi_bgrace = SHMEM_MAX_DQ_TIME;
+	info->dqi_igrace = SHMEM_MAX_IQ_TIME;
+	info->dqi_flags = 0;
+
+	return 0;
+}
+
+static int shmem_write_file_info(struct super_block *sb, int type)
+{
+	/* There is no real quota file, nothing to do */
+	return 0;
+}
+
+/*
+ * Free all the quota_id entries in the rb tree and rb_root.
+ */
+static int shmem_free_file_info(struct super_block *sb, int type)
+{
+	struct mem_dqinfo *info = &sb_dqopt(sb)->info[type];
+	struct rb_root *root = info->dqi_priv;
+	struct quota_id *entry;
+	struct rb_node *node;
+
+	info->dqi_priv = NULL;
+	node = rb_first(root);
+	while (node) {
+		entry = rb_entry(node, struct quota_id, node);
+		node = rb_next(&entry->node);
+
+		rb_erase(&entry->node, root);
+		kfree(entry);
+	}
+
+	kfree(root);
+	return 0;
+}
+
+static int shmem_get_next_id(struct super_block *sb, struct kqid *qid)
+{
+	struct mem_dqinfo *info = sb_dqinfo(sb, qid->type);
+	struct rb_node *node = ((struct rb_root *)info->dqi_priv)->rb_node;
+	qid_t id = from_kqid(&init_user_ns, *qid);
+	struct quota_info *dqopt = sb_dqopt(sb);
+	struct quota_id *entry = NULL;
+	int ret = 0;
+
+	if (!sb_has_quota_active(sb, qid->type))
+		return -ESRCH;
+
+	down_read(&dqopt->dqio_sem);
+	while (node) {
+		entry = rb_entry(node, struct quota_id, node);
+
+		if (id < entry->id)
+			node = node->rb_left;
+		else if (id > entry->id)
+			node = node->rb_right;
+		else
+			goto got_next_id;
+	}
+
+	if (!entry) {
+		ret = -ENOENT;
+		goto out_unlock;
+	}
+
+	if (id > entry->id) {
+		node = rb_next(&entry->node);
+		if (!node) {
+			ret = -ENOENT;
+			goto out_unlock;
+		}
+		entry = rb_entry(node, struct quota_id, node);
+	}
+
+got_next_id:
+	*qid = make_kqid(&init_user_ns, qid->type, entry->id);
+out_unlock:
+	up_read(&dqopt->dqio_sem);
+	return ret;
+}
+
+/*
+ * Load dquot with limits from existing entry, or create the new entry if
+ * it does not exist.
+ */
+static int shmem_acquire_dquot(struct dquot *dquot)
+{
+	struct mem_dqinfo *info = sb_dqinfo(dquot->dq_sb, dquot->dq_id.type);
+	struct rb_node **n = &((struct rb_root *)info->dqi_priv)->rb_node;
+	struct rb_node *parent = NULL, *new_node = NULL;
+	struct quota_id *new_entry, *entry;
+	qid_t id = from_kqid(&init_user_ns, dquot->dq_id);
+	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
+	int ret = 0;
+
+	mutex_lock(&dquot->dq_lock);
+
+	down_write(&dqopt->dqio_sem);
+	while (*n) {
+		parent = *n;
+		entry = rb_entry(parent, struct quota_id, node);
+
+		if (id < entry->id)
+			n = &(*n)->rb_left;
+		else if (id > entry->id)
+			n = &(*n)->rb_right;
+		else
+			goto found;
+	}
+
+	/* We don't have entry for this id yet, create it */
+	new_entry = kzalloc(sizeof(struct quota_id), GFP_NOFS);
+	if (!new_entry) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
+	new_entry->id = id;
+	new_node = &new_entry->node;
+	rb_link_node(new_node, parent, n);
+	rb_insert_color(new_node, (struct rb_root *)info->dqi_priv);
+	entry = new_entry;
+
+found:
+	/* Load the stored limits from the tree */
+	spin_lock(&dquot->dq_dqb_lock);
+	dquot->dq_dqb.dqb_bhardlimit = entry->bhardlimit;
+	dquot->dq_dqb.dqb_bsoftlimit = entry->bsoftlimit;
+	dquot->dq_dqb.dqb_ihardlimit = entry->ihardlimit;
+	dquot->dq_dqb.dqb_isoftlimit = entry->isoftlimit;
+
+	if (!dquot->dq_dqb.dqb_bhardlimit &&
+	    !dquot->dq_dqb.dqb_bsoftlimit &&
+	    !dquot->dq_dqb.dqb_ihardlimit &&
+	    !dquot->dq_dqb.dqb_isoftlimit)
+		set_bit(DQ_FAKE_B, &dquot->dq_flags);
+	spin_unlock(&dquot->dq_dqb_lock);
+
+	/* Make sure flags update is visible after dquot has been filled */
+	smp_mb__before_atomic();
+	set_bit(DQ_ACTIVE_B, &dquot->dq_flags);
+out_unlock:
+	up_write(&dqopt->dqio_sem);
+	mutex_unlock(&dquot->dq_lock);
+	return ret;
+}
+
+/*
+ * Store limits from dquot in the tree unless it's fake. If it is fake
+ * remove the id from the tree since there is no useful information in
+ * there.
+ */
+static int shmem_release_dquot(struct dquot *dquot)
+{
+	struct mem_dqinfo *info = sb_dqinfo(dquot->dq_sb, dquot->dq_id.type);
+	struct rb_node *node = ((struct rb_root *)info->dqi_priv)->rb_node;
+	qid_t id = from_kqid(&init_user_ns, dquot->dq_id);
+	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
+	struct quota_id *entry = NULL;
+
+	mutex_lock(&dquot->dq_lock);
+	/* Check whether we are not racing with some other dqget() */
+	if (dquot_is_busy(dquot))
+		goto out_dqlock;
+
+	down_write(&dqopt->dqio_sem);
+	while (node) {
+		entry = rb_entry(node, struct quota_id, node);
+
+		if (id < entry->id)
+			node = node->rb_left;
+		else if (id > entry->id)
+			node = node->rb_right;
+		else
+			goto found;
+	}
+
+	/* We should always find the entry in the rb tree */
+	WARN_ONCE(1, "quota id %u from dquot %p, not in rb tree!\n", id, dquot);
+	up_write(&dqopt->dqio_sem);
+	mutex_unlock(&dquot->dq_lock);
+	return -ENOENT;
+
+found:
+	if (test_bit(DQ_FAKE_B, &dquot->dq_flags)) {
+		/* Remove entry from the tree */
+		rb_erase(&entry->node, info->dqi_priv);
+		kfree(entry);
+	} else {
+		/* Store the limits in the tree */
+		spin_lock(&dquot->dq_dqb_lock);
+		entry->bhardlimit = dquot->dq_dqb.dqb_bhardlimit;
+		entry->bsoftlimit = dquot->dq_dqb.dqb_bsoftlimit;
+		entry->ihardlimit = dquot->dq_dqb.dqb_ihardlimit;
+		entry->isoftlimit = dquot->dq_dqb.dqb_isoftlimit;
+		spin_unlock(&dquot->dq_dqb_lock);
+	}
+
+	clear_bit(DQ_ACTIVE_B, &dquot->dq_flags);
+	up_write(&dqopt->dqio_sem);
+
+out_dqlock:
+	mutex_unlock(&dquot->dq_lock);
+	return 0;
+}
+
+int shmem_mark_dquot_dirty(struct dquot *dquot)
+{
+	return 0;
+}
+
+int shmem_dquot_write_info(struct super_block *sb, int type)
+{
+	return 0;
+}
+
+static const struct quota_format_ops shmem_format_ops = {
+	.check_quota_file	= shmem_check_quota_file,
+	.read_file_info		= shmem_read_file_info,
+	.write_file_info	= shmem_write_file_info,
+	.free_file_info		= shmem_free_file_info,
+};
+
+struct quota_format_type shmem_quota_format = {
+	.qf_fmt_id = QFMT_SHMEM,
+	.qf_ops = &shmem_format_ops,
+	.qf_owner = THIS_MODULE
+};
+
+const struct dquot_operations shmem_quota_operations = {
+	.acquire_dquot		= shmem_acquire_dquot,
+	.release_dquot		= shmem_release_dquot,
+	.alloc_dquot		= dquot_alloc,
+	.destroy_dquot		= dquot_destroy,
+	.write_info		= shmem_dquot_write_info,
+	.mark_dirty		= shmem_mark_dquot_dirty,
+	.get_next_id		= shmem_get_next_id,
+};
+#endif /* CONFIG_TMPFS_QUOTA */
-- 
2.39.2

