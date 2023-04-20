Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375C96E8C12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 10:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbjDTIEZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 04:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbjDTIEU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:04:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8372D63
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 01:04:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D06B5645D4
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 08:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D890AC433D2;
        Thu, 20 Apr 2023 08:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681977854;
        bh=Bz8jWy6uy3k4tfiy7uX5cXZN1fsySJ/ofRKbKLBLucE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wk0NlYzXYFgyCkuhOZqEaAYWO6DJcIVRADIOLz7GeB0+abymjo6yl4y9ZgJYW6hty
         OpAZkauPc1COQnhOBGLiYXZcfPlRQ6vq7DkE0l0rnrxu+SYCMAWh+Ts3doXKs5SSbl
         PE7eMookyNnZwDbVsBS2K3aFYjUj3dBwMVmYlRXFPWSWzdw+/XGEPlmV2rF4k3QoaR
         Ghs4RDQgNk2v+fGmvIVeIj/hkpIZ/hYUeYJ8C5j7cGl9wOheGELuZrw5wa8Pj7YaBL
         fjfbvK4ysnk+hgMTULEs73n/lsNIaXOQxbOnWs9yhqXNJXVOGZ3YSD7Tk6T3fbGK9e
         Eib9ren8AKV8w==
From:   cem@kernel.org
To:     hughd@google.com
Cc:     jack@suse.cz, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        djwong@kernel.org
Subject: [PATCH V2 5/6] shmem: quota support
Date:   Thu, 20 Apr 2023 10:03:58 +0200
Message-Id: <20230420080359.2551150-6-cem@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230420080359.2551150-1-cem@kernel.org>
References: <20230420080359.2551150-1-cem@kernel.org>
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

From: Lukas Czerner <lczerner@redhat.com>

Now the basic infra-structure is in place, enable quota support for tmpfs.

This offers user and group quotas to tmpfs (project quotas will be added
later). Also, as other filesystems, the tmpfs quota is not supported
within user namespaces yet, so idmapping is not translated.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>

---
V2:	- remove SHMEM_MAXQUOTAS definition from this patch, as it has
	  been added to a previous patch
	- Don't use assignments within conditions
	- add a call to is_quota_modification() within shmem_setattr()
	- Add a note to the documentation describing user namespaces are
	  not supported.
	- Refactor shmem_get_inode, and add a new inlined version if TMPFS_QUOTA
	  is not enabled. This prevents quota-specific helpers from
	  being called when CONFIG_TMPFS_QUOTA is not set.

 Documentation/filesystems/tmpfs.rst |  15 +++
 include/linux/shmem_fs.h            |   8 ++
 mm/shmem.c                          | 180 ++++++++++++++++++++++++++--
 3 files changed, 195 insertions(+), 8 deletions(-)

diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
index 0408c245785e3..1d4ef4f7cca7e 100644
--- a/Documentation/filesystems/tmpfs.rst
+++ b/Documentation/filesystems/tmpfs.rst
@@ -86,6 +86,21 @@ use up all the memory on the machine; but enhances the scalability of
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
+Note that tmpfs quotas do not support user namespaces so no uid/gid
+translation is done if quotas are enable inside user namespaces.
+
 tmpfs has a mount option to set the NUMA memory allocation policy for
 all files in that instance (if CONFIG_NUMA is enabled) - which can be
 adjusted on the fly via 'mount -o remount ...'
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 92db49ebd5452..b8e421e349868 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -30,6 +30,9 @@ struct shmem_inode_info {
 	atomic_t		stop_eviction;	/* hold when working on inode */
 	struct timespec64	i_crtime;	/* file creation time */
 	unsigned int		fsflags;	/* flags for FS_IOC_[SG]ETFLAGS */
+#ifdef CONFIG_TMPFS_QUOTA
+	struct dquot		*i_dquot[MAXQUOTAS];
+#endif
 	struct inode		vfs_inode;
 };
 
@@ -175,4 +178,9 @@ extern int shmem_mfill_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 #define SHMEM_QUOTA_MAX_SPC_LIMIT 0x7fffffffffffffffLL /* 2^63-1 */
 #define SHMEM_QUOTA_MAX_INO_LIMIT 0x7fffffffffffffffLL
 
+#ifdef CONFIG_TMPFS_QUOTA
+extern const struct dquot_operations shmem_quota_operations;
+extern struct quota_format_type shmem_quota_format;
+#endif /* CONFIG_TMPFS_QUOTA */
+
 #endif
diff --git a/mm/shmem.c b/mm/shmem.c
index afa1985230166..dd9faf2c5c875 100644
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
@@ -211,7 +214,16 @@ static inline int shmem_inode_acct_block(struct inode *inode, long pages)
 		if (percpu_counter_compare(&sbinfo->used_blocks,
 					   sbinfo->max_blocks - pages) > 0)
 			goto unacct;
+
+		err = dquot_alloc_block_nodirty(inode, pages);
+		if (err)
+			goto unacct;
+
 		percpu_counter_add(&sbinfo->used_blocks, pages);
+	} else {
+		err = dquot_alloc_block_nodirty(inode, pages);
+		if (err)
+			goto unacct;
 	}
 
 	return 0;
@@ -226,6 +238,8 @@ static inline void shmem_inode_unacct_blocks(struct inode *inode, long pages)
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 
+	dquot_free_block_nodirty(inode, pages);
+
 	if (sbinfo->max_blocks)
 		percpu_counter_sub(&sbinfo->used_blocks, pages);
 	shmem_unacct_blocks(info->flags, pages);
@@ -254,6 +268,47 @@ bool vma_is_shmem(struct vm_area_struct *vma)
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
@@ -360,7 +415,6 @@ static void shmem_recalc_inode(struct inode *inode)
 	freed = info->alloced - info->swapped - inode->i_mapping->nrpages;
 	if (freed > 0) {
 		info->alloced -= freed;
-		inode->i_blocks -= freed * BLOCKS_PER_PAGE;
 		shmem_inode_unacct_blocks(inode, freed);
 	}
 }
@@ -378,7 +432,6 @@ bool shmem_charge(struct inode *inode, long pages)
 
 	spin_lock_irqsave(&info->lock, flags);
 	info->alloced += pages;
-	inode->i_blocks += pages * BLOCKS_PER_PAGE;
 	shmem_recalc_inode(inode);
 	spin_unlock_irqrestore(&info->lock, flags);
 
@@ -394,7 +447,6 @@ void shmem_uncharge(struct inode *inode, long pages)
 
 	spin_lock_irqsave(&info->lock, flags);
 	info->alloced -= pages;
-	inode->i_blocks -= pages * BLOCKS_PER_PAGE;
 	shmem_recalc_inode(inode);
 	spin_unlock_irqrestore(&info->lock, flags);
 
@@ -1133,6 +1185,21 @@ static int shmem_setattr(struct mnt_idmap *idmap,
 		}
 	}
 
+	if (is_quota_modification(idmap, inode, attr)) {
+		error = dquot_initialize(inode);
+		if (error)
+			return error;
+	}
+
+	/* Transfer quota accounting */
+	if (i_uid_needs_update(idmap, attr, inode) ||
+	    i_gid_needs_update(idmap, attr, inode)) {
+		error = dquot_transfer(idmap, inode, attr);
+
+		if (error)
+			return error;
+	}
+
 	setattr_copy(idmap, inode, attr);
 	if (attr->ia_valid & ATTR_MODE)
 		error = posix_acl_chmod(idmap, dentry, inode->i_mode);
@@ -1179,6 +1246,10 @@ static void shmem_evict_inode(struct inode *inode)
 	WARN_ON(inode->i_blocks);
 	shmem_free_inode(inode->i_sb);
 	clear_inode(inode);
+#ifdef CONFIG_TMPFS_QUOTA
+	dquot_free_inode(inode);
+	dquot_drop(inode);
+#endif
 }
 
 static int shmem_find_swap_entries(struct address_space *mapping,
@@ -1975,7 +2046,6 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 
 	spin_lock_irq(&info->lock);
 	info->alloced += folio_nr_pages(folio);
-	inode->i_blocks += (blkcnt_t)BLOCKS_PER_PAGE << folio_order(folio);
 	shmem_recalc_inode(inode);
 	spin_unlock_irq(&info->lock);
 	alloced = true;
@@ -2346,9 +2416,10 @@ static void shmem_set_inode_flags(struct inode *inode, unsigned int fsflags)
 #define shmem_initxattrs NULL
 #endif
 
-static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block *sb,
-				     struct inode *dir, umode_t mode, dev_t dev,
-				     unsigned long flags)
+static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
+					     struct super_block *sb,
+					     struct inode *dir, umode_t mode,
+					     dev_t dev, unsigned long flags)
 {
 	struct inode *inode;
 	struct shmem_inode_info *info;
@@ -2422,6 +2493,43 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block
 	return inode;
 }
 
+#ifdef CONFIG_TMPFS_QUOTA
+static struct inode *shmem_get_inode(struct mnt_idmap *idmap,
+				     struct super_block *sb, struct inode *dir,
+				     umode_t mode, dev_t dev, unsigned long flags)
+{
+	int err;
+	struct inode *inode;
+
+	inode = __shmem_get_inode(idmap, sb, dir, mode, dev, flags);
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
+	return ERR_PTR(err);
+}
+#else
+static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
+				     struct super_block *sb, struct inode *dir,
+				     umode_t mode, dev_t dev, unsigned long flags)
+{
+	return __shmem_get_inode(idmap, sb, dir, mode, dev, flags);
+}
+#endif /* CONFIG_TMPFS_QUOTA */
+
 #ifdef CONFIG_USERFAULTFD
 int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 			   pmd_t *dst_pmd,
@@ -2525,7 +2633,6 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 
 	spin_lock_irq(&info->lock);
 	info->alloced++;
-	inode->i_blocks += BLOCKS_PER_PAGE;
 	shmem_recalc_inode(inode);
 	spin_unlock_irq(&info->lock);
 
@@ -3375,6 +3482,7 @@ static ssize_t shmem_listxattr(struct dentry *dentry, char *buffer, size_t size)
 
 static const struct inode_operations shmem_short_symlink_operations = {
 	.getattr	= shmem_getattr,
+	.setattr	= shmem_setattr,
 	.get_link	= simple_get_link,
 #ifdef CONFIG_TMPFS_XATTR
 	.listxattr	= shmem_listxattr,
@@ -3383,6 +3491,7 @@ static const struct inode_operations shmem_short_symlink_operations = {
 
 static const struct inode_operations shmem_symlink_inode_operations = {
 	.getattr	= shmem_getattr,
+	.setattr	= shmem_setattr,
 	.get_link	= shmem_get_link,
 #ifdef CONFIG_TMPFS_XATTR
 	.listxattr	= shmem_listxattr,
@@ -3481,6 +3590,9 @@ enum shmem_param {
 	Opt_uid,
 	Opt_inode32,
 	Opt_inode64,
+	Opt_quota,
+	Opt_usrquota,
+	Opt_grpquota,
 };
 
 static const struct constant_table shmem_param_enums_huge[] = {
@@ -3502,6 +3614,11 @@ const struct fs_parameter_spec shmem_fs_parameters[] = {
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
 
@@ -3585,6 +3702,18 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
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
 
@@ -3684,6 +3813,12 @@ static int shmem_reconfigure(struct fs_context *fc)
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
@@ -3766,6 +3901,9 @@ static void shmem_put_super(struct super_block *sb)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 
+#ifdef CONFIG_TMPFS_QUOTA
+	shmem_disable_quotas(sb);
+#endif
 	free_percpu(sbinfo->ino_batch);
 	percpu_counter_destroy(&sbinfo->used_blocks);
 	mpol_put(sbinfo->mpol);
@@ -3844,6 +3982,17 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
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
@@ -4019,6 +4168,9 @@ static const struct super_operations shmem_ops = {
 #ifdef CONFIG_TMPFS
 	.statfs		= shmem_statfs,
 	.show_options	= shmem_show_options,
+#endif
+#ifdef CONFIG_TMPFS_QUOTA
+	.get_dquots	= shmem_get_dquots,
 #endif
 	.evict_inode	= shmem_evict_inode,
 	.drop_inode	= generic_delete_inode,
@@ -4085,6 +4237,14 @@ void __init shmem_init(void)
 
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
@@ -4109,6 +4269,10 @@ void __init shmem_init(void)
 out1:
 	unregister_filesystem(&shmem_fs_type);
 out2:
+#ifdef CONFIG_TMPFS_QUOTA
+	unregister_quota_format(&shmem_quota_format);
+out3:
+#endif
 	shmem_destroy_inodecache();
 	shm_mnt = ERR_PTR(error);
 }
-- 
2.30.2

