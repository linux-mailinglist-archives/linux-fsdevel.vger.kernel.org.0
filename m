Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381E36D3F66
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 10:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjDCIsl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 04:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjDCIs2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:48:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973EE8A61
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 01:48:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25400B815CF
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 08:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88739C4339B;
        Mon,  3 Apr 2023 08:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680511702;
        bh=wqi/g8+nYJW5dWKPT/jj73GeiD/W48gxOqllJwPVhkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DnaszmaIclWp+5FSgpgJBPZ34XcEbh1rtT+kCsF1JUv/PTDGJ3iBXfnojBzgEvuLj
         VbuDAXUUhRxRCw1qNxx8SMzBcNqR7nnZn6/cQxTWJL3saq80IPENaJcrKZD8YIw0Q0
         k7vrHxK+jjU9xKvfMEpgqzbj7IiZft+DIO8ElCd6szPOnjnzEzSsQyoH7atFWzA4vD
         6raCQta9Gqw8CnW6IUw07j0d207JKUBZ3BtlcMEC3Oiql/HUSf92fRBF2Vu+SNHAo7
         gu/youuXGCb0JgjpRXj1C9KZqfRGSgNgT6ZfP7vwr9GDlNSuPF5Pg/VHGHG/nKekJI
         wQQbRzBgGc0Lg==
From:   cem@kernel.org
To:     hughd@google.com
Cc:     jack@suse.cz, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        djwong@kernel.org
Subject: [PATCH 5/6] shmem: quota support
Date:   Mon,  3 Apr 2023 10:47:58 +0200
Message-Id: <20230403084759.884681-6-cem@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230403084759.884681-1-cem@kernel.org>
References: <20230403084759.884681-1-cem@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Lukas Czerner <lczerner@redhat.com>

Now the basic infra-structure is in place, enable quota support for tmpfs.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 Documentation/filesystems/tmpfs.rst |  12 +++
 include/linux/shmem_fs.h            |   9 ++
 mm/shmem.c                          | 162 ++++++++++++++++++++++++++--
 3 files changed, 174 insertions(+), 9 deletions(-)

diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
index 0408c245785e3..3f8d89bb7e1a5 100644
--- a/Documentation/filesystems/tmpfs.rst
+++ b/Documentation/filesystems/tmpfs.rst
@@ -86,6 +86,18 @@ use up all the memory on the machine; but enhances the scalability of
 that instance in a system with many CPUs making intensive use of it.
 
 
+tmpfs also supports quota with the following mount options
+
+========  =============================================================
+quota     User and group quota accounting and enforcement is enabled on
+          the mount. Tmpfs is using hidden system quota files that are
+          initialized on mount.
+usrquota  User quota accounting and enforcement is enabled on the
+          mount.
+grpquota  Group quota accounting and enforcement is enabled on the
+          mount.
+========  =============================================================
+
 tmpfs has a mount option to set the NUMA memory allocation policy for
 all files in that instance (if CONFIG_NUMA is enabled) - which can be
 adjusted on the fly via 'mount -o remount ...'
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index cf38381bdb4c1..3e7e18726feb5 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -26,6 +26,9 @@ struct shmem_inode_info {
 	atomic_t		stop_eviction;	/* hold when working on inode */
 	struct timespec64	i_crtime;	/* file creation time */
 	unsigned int		fsflags;	/* flags for FS_IOC_[SG]ETFLAGS */
+#ifdef CONFIG_TMPFS_QUOTA
+	struct dquot		*i_dquot[MAXQUOTAS];
+#endif
 	struct inode		vfs_inode;
 };
 
@@ -171,4 +174,10 @@ extern int shmem_mfill_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 #define SHMEM_QUOTA_MAX_SPC_LIMIT 0x7fffffffffffffffLL /* 2^63-1 */
 #define SHMEM_QUOTA_MAX_INO_LIMIT 0x7fffffffffffffffLL
 
+#ifdef CONFIG_TMPFS_QUOTA
+#define SHMEM_MAXQUOTAS 2
+extern const struct dquot_operations shmem_quota_operations;
+extern struct quota_format_type shmem_quota_format;
+#endif /* CONFIG_TMPFS_QUOTA */
+
 #endif
diff --git a/mm/shmem.c b/mm/shmem.c
index 88e13930fc013..d7529c883eaf5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -79,6 +79,7 @@ static struct vfsmount *shm_mnt;
 #include <linux/userfaultfd_k.h>
 #include <linux/rmap.h>
 #include <linux/uuid.h>
+#include <linux/quotaops.h>
 
 #include <linux/uaccess.h>
 
@@ -116,10 +117,12 @@ struct shmem_options {
 	bool full_inums;
 	int huge;
 	int seen;
+	unsigned short quota_types;
 #define SHMEM_SEEN_BLOCKS 1
 #define SHMEM_SEEN_INODES 2
 #define SHMEM_SEEN_HUGE 4
 #define SHMEM_SEEN_INUMS 8
+#define SHMEM_SEEN_QUOTA 16
 };
 
 #ifdef CONFIG_TMPFS
@@ -211,8 +214,11 @@ static inline int shmem_inode_acct_block(struct inode *inode, long pages)
 		if (percpu_counter_compare(&sbinfo->used_blocks,
 					   sbinfo->max_blocks - pages) > 0)
 			goto unacct;
+		if ((err = dquot_alloc_block_nodirty(inode, pages)) != 0)
+			goto unacct;
 		percpu_counter_add(&sbinfo->used_blocks, pages);
-	}
+	} else if ((err = dquot_alloc_block_nodirty(inode, pages)) != 0)
+		goto unacct;
 
 	return 0;
 
@@ -226,6 +232,8 @@ static inline void shmem_inode_unacct_blocks(struct inode *inode, long pages)
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 
+	dquot_free_block_nodirty(inode, pages);
+
 	if (sbinfo->max_blocks)
 		percpu_counter_sub(&sbinfo->used_blocks, pages);
 	shmem_unacct_blocks(info->flags, pages);
@@ -254,6 +262,47 @@ bool vma_is_shmem(struct vm_area_struct *vma)
 static LIST_HEAD(shmem_swaplist);
 static DEFINE_MUTEX(shmem_swaplist_mutex);
 
+#ifdef CONFIG_TMPFS_QUOTA
+
+static int shmem_enable_quotas(struct super_block *sb,
+			       unsigned short quota_types)
+{
+	int type, err = 0;
+
+	sb_dqopt(sb)->flags |= DQUOT_QUOTA_SYS_FILE | DQUOT_NOLIST_DIRTY;
+	for (type = 0; type < SHMEM_MAXQUOTAS; type++) {
+		if (!(quota_types & (1 << type)))
+			continue;
+		err = dquot_load_quota_sb(sb, type, QFMT_SHMEM,
+					  DQUOT_USAGE_ENABLED |
+					  DQUOT_LIMITS_ENABLED);
+		if (err)
+			goto out_err;
+	}
+	return 0;
+
+out_err:
+	pr_warn("tmpfs: failed to enable quota tracking (type=%d, err=%d)\n",
+		type, err);
+	for (type--; type >= 0; type--)
+		dquot_quota_off(sb, type);
+	return err;
+}
+
+static void shmem_disable_quotas(struct super_block *sb)
+{
+	int type;
+
+	for (type = 0; type < SHMEM_MAXQUOTAS; type++)
+		dquot_quota_off(sb, type);
+}
+
+static struct dquot **shmem_get_dquots(struct inode *inode)
+{
+	return SHMEM_I(inode)->i_dquot;
+}
+#endif /* CONFIG_TMPFS_QUOTA */
+
 /*
  * shmem_reserve_inode() performs bookkeeping to reserve a shmem inode, and
  * produces a novel ino for the newly allocated inode.
@@ -360,7 +409,6 @@ static void shmem_recalc_inode(struct inode *inode)
 	freed = info->alloced - info->swapped - inode->i_mapping->nrpages;
 	if (freed > 0) {
 		info->alloced -= freed;
-		inode->i_blocks -= freed * BLOCKS_PER_PAGE;
 		shmem_inode_unacct_blocks(inode, freed);
 	}
 }
@@ -378,7 +426,6 @@ bool shmem_charge(struct inode *inode, long pages)
 
 	spin_lock_irqsave(&info->lock, flags);
 	info->alloced += pages;
-	inode->i_blocks += pages * BLOCKS_PER_PAGE;
 	shmem_recalc_inode(inode);
 	spin_unlock_irqrestore(&info->lock, flags);
 
@@ -394,7 +441,6 @@ void shmem_uncharge(struct inode *inode, long pages)
 
 	spin_lock_irqsave(&info->lock, flags);
 	info->alloced -= pages;
-	inode->i_blocks -= pages * BLOCKS_PER_PAGE;
 	shmem_recalc_inode(inode);
 	spin_unlock_irqrestore(&info->lock, flags);
 
@@ -1133,6 +1179,15 @@ static int shmem_setattr(struct mnt_idmap *idmap,
 		}
 	}
 
+	/* Transfer quota accounting */
+	if (i_uid_needs_update(idmap, attr, inode) ||
+	    i_gid_needs_update(idmap, attr,inode)) {
+		error = dquot_transfer(idmap, inode, attr);
+
+		if (error)
+			return error;
+	}
+
 	setattr_copy(idmap, inode, attr);
 	if (attr->ia_valid & ATTR_MODE)
 		error = posix_acl_chmod(idmap, dentry, inode->i_mode);
@@ -1178,7 +1233,9 @@ static void shmem_evict_inode(struct inode *inode)
 	simple_xattrs_free(&info->xattrs);
 	WARN_ON(inode->i_blocks);
 	shmem_free_inode(inode->i_sb);
+	dquot_free_inode(inode);
 	clear_inode(inode);
+	dquot_drop(inode);
 }
 
 static int shmem_find_swap_entries(struct address_space *mapping,
@@ -1975,7 +2032,6 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 
 	spin_lock_irq(&info->lock);
 	info->alloced += folio_nr_pages(folio);
-	inode->i_blocks += (blkcnt_t)BLOCKS_PER_PAGE << folio_order(folio);
 	shmem_recalc_inode(inode);
 	spin_unlock_irq(&info->lock);
 	alloced = true;
@@ -2346,9 +2402,10 @@ static void shmem_set_inode_flags(struct inode *inode, unsigned int fsflags)
 #define shmem_initxattrs NULL
 #endif
 
-static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block *sb,
-				     struct inode *dir, umode_t mode, dev_t dev,
-				     unsigned long flags)
+static struct inode *shmem_get_inode_noquota(struct mnt_idmap *idmap,
+					     struct super_block *sb,
+					     struct inode *dir, umode_t mode,
+					     dev_t dev, unsigned long flags)
 {
 	struct inode *inode;
 	struct shmem_inode_info *info;
@@ -2422,6 +2479,37 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block
 	return inode;
 }
 
+static struct inode *shmem_get_inode(struct mnt_idmap *idmap,
+				     struct super_block *sb, struct inode *dir,
+				     umode_t mode, dev_t dev, unsigned long flags)
+{
+	int err;
+	struct inode *inode;
+
+	inode = shmem_get_inode_noquota(idmap, sb, dir, mode, dev, flags);
+	if (IS_ERR(inode))
+		return inode;
+
+	err = dquot_initialize(inode);
+	if (err)
+		goto errout;
+
+	err = dquot_alloc_inode(inode);
+	if (err) {
+		dquot_drop(inode);
+		goto errout;
+	}
+	return inode;
+
+errout:
+	inode->i_flags |= S_NOQUOTA;
+	iput(inode);
+	shmem_free_inode(sb);
+	if (err)
+		return ERR_PTR(err);
+	return NULL;
+}
+
 #ifdef CONFIG_USERFAULTFD
 int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 			   pmd_t *dst_pmd,
@@ -2525,7 +2613,6 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 
 	spin_lock_irq(&info->lock);
 	info->alloced++;
-	inode->i_blocks += BLOCKS_PER_PAGE;
 	shmem_recalc_inode(inode);
 	spin_unlock_irq(&info->lock);
 
@@ -3372,6 +3459,7 @@ static ssize_t shmem_listxattr(struct dentry *dentry, char *buffer, size_t size)
 
 static const struct inode_operations shmem_short_symlink_operations = {
 	.getattr	= shmem_getattr,
+	.setattr	= shmem_setattr,
 	.get_link	= simple_get_link,
 #ifdef CONFIG_TMPFS_XATTR
 	.listxattr	= shmem_listxattr,
@@ -3380,6 +3468,7 @@ static const struct inode_operations shmem_short_symlink_operations = {
 
 static const struct inode_operations shmem_symlink_inode_operations = {
 	.getattr	= shmem_getattr,
+	.setattr	= shmem_setattr,
 	.get_link	= shmem_get_link,
 #ifdef CONFIG_TMPFS_XATTR
 	.listxattr	= shmem_listxattr,
@@ -3478,6 +3567,9 @@ enum shmem_param {
 	Opt_uid,
 	Opt_inode32,
 	Opt_inode64,
+	Opt_quota,
+	Opt_usrquota,
+	Opt_grpquota,
 };
 
 static const struct constant_table shmem_param_enums_huge[] = {
@@ -3499,6 +3591,11 @@ const struct fs_parameter_spec shmem_fs_parameters[] = {
 	fsparam_u32   ("uid",		Opt_uid),
 	fsparam_flag  ("inode32",	Opt_inode32),
 	fsparam_flag  ("inode64",	Opt_inode64),
+#ifdef CONFIG_TMPFS_QUOTA
+	fsparam_flag  ("quota",		Opt_quota),
+	fsparam_flag  ("usrquota",	Opt_usrquota),
+	fsparam_flag  ("grpquota",	Opt_grpquota),
+#endif
 	{}
 };
 
@@ -3582,6 +3679,18 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 		ctx->full_inums = true;
 		ctx->seen |= SHMEM_SEEN_INUMS;
 		break;
+	case Opt_quota:
+		ctx->seen |= SHMEM_SEEN_QUOTA;
+		ctx->quota_types |= (QTYPE_MASK_USR | QTYPE_MASK_GRP);
+		break;
+	case Opt_usrquota:
+		ctx->seen |= SHMEM_SEEN_QUOTA;
+		ctx->quota_types |= QTYPE_MASK_USR;
+		break;
+	case Opt_grpquota:
+		ctx->seen |= SHMEM_SEEN_QUOTA;
+		ctx->quota_types |= QTYPE_MASK_GRP;
+		break;
 	}
 	return 0;
 
@@ -3681,6 +3790,12 @@ static int shmem_reconfigure(struct fs_context *fc)
 		goto out;
 	}
 
+	if (ctx->seen & SHMEM_SEEN_QUOTA &&
+	    !sb_any_quota_loaded(fc->root->d_sb)) {
+		err = "Cannot enable quota on remount";
+		goto out;
+	}
+
 	if (ctx->seen & SHMEM_SEEN_HUGE)
 		sbinfo->huge = ctx->huge;
 	if (ctx->seen & SHMEM_SEEN_INUMS)
@@ -3763,6 +3878,9 @@ static void shmem_put_super(struct super_block *sb)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 
+#ifdef CONFIG_TMPFS_QUOTA
+	shmem_disable_quotas(sb);
+#endif
 	free_percpu(sbinfo->ino_batch);
 	percpu_counter_destroy(&sbinfo->used_blocks);
 	mpol_put(sbinfo->mpol);
@@ -3841,6 +3959,17 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 #endif
 	uuid_gen(&sb->s_uuid);
 
+#ifdef CONFIG_TMPFS_QUOTA
+	if (ctx->seen & SHMEM_SEEN_QUOTA) {
+		sb->dq_op = &shmem_quota_operations;
+		sb->s_qcop = &dquot_quotactl_sysfile_ops;
+		sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP;
+
+		if (shmem_enable_quotas(sb, ctx->quota_types))
+			goto failed;
+	}
+#endif /* CONFIG_TMPFS_QUOTA */
+
 	inode = shmem_get_inode(&nop_mnt_idmap, sb, NULL, S_IFDIR | sbinfo->mode, 0,
 				VM_NORESERVE);
 	if (IS_ERR(inode)) {
@@ -4016,6 +4145,9 @@ static const struct super_operations shmem_ops = {
 #ifdef CONFIG_TMPFS
 	.statfs		= shmem_statfs,
 	.show_options	= shmem_show_options,
+#endif
+#ifdef CONFIG_TMPFS_QUOTA
+	.get_dquots	= shmem_get_dquots,
 #endif
 	.evict_inode	= shmem_evict_inode,
 	.drop_inode	= generic_delete_inode,
@@ -4082,6 +4214,14 @@ void __init shmem_init(void)
 
 	shmem_init_inodecache();
 
+#ifdef CONFIG_TMPFS_QUOTA
+	error = register_quota_format(&shmem_quota_format);
+	if (error < 0) {
+		pr_err("Could not register quota format\n");
+		goto out3;
+	}
+#endif
+
 	error = register_filesystem(&shmem_fs_type);
 	if (error) {
 		pr_err("Could not register tmpfs\n");
@@ -4106,6 +4246,10 @@ void __init shmem_init(void)
 out1:
 	unregister_filesystem(&shmem_fs_type);
 out2:
+#ifdef CONFIG_TMPFS_QUOTA
+	unregister_quota_format(&shmem_quota_format);
+#endif
+out3:
 	shmem_destroy_inodecache();
 	shm_mnt = ERR_PTR(error);
 }
-- 
2.30.2

