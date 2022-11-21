Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B126325CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 15:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiKUOaZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 09:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKUOaW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:30:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E25059853
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 06:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669040963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WXmc7II3otsSobbP8bGfU4JjoN1zWalo0oRGUBn1RE8=;
        b=eW89sd9wUcjkJbRvV6XrjwW02S/yzh30UEJ83awZzfNl0BSXCNzOOYfpnIcr+iEoa0kpGK
        ZVM6uxucxQc5S5K5sa7G9SbMiTop5tJoY8ub4Sey8Nro4+22o4EWXExoQu4EaIWM4ibRm9
        ANawwIpOzz+oX0iRyLzkWq6as86IsRQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-mmElv-ZHNz2EEjqD-ClyXw-1; Mon, 21 Nov 2022 09:29:19 -0500
X-MC-Unique: mmElv-ZHNz2EEjqD-ClyXw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 44DD886C14D;
        Mon, 21 Nov 2022 14:29:19 +0000 (UTC)
Received: from ovpn-193-186.brq.redhat.com (ovpn-193-186.brq.redhat.com [10.40.193.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C5942166B26;
        Mon, 21 Nov 2022 14:29:17 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Jan Kara <jack@suse.com>, Eric Sandeen <sandeen@redhat.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        djwong@kernel.org
Subject: [PATCH v2 2/3] shmem: implement user/group quota support for tmpfs
Date:   Mon, 21 Nov 2022 15:28:53 +0100
Message-Id: <20221121142854.91109-3-lczerner@redhat.com>
In-Reply-To: <20221121142854.91109-1-lczerner@redhat.com>
References: <20221121142854.91109-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement user and group quota support for tmpfs using system quota file
in vfsv0 quota format. Because everything in tmpfs is temporary and as a
result is lost on umount, the quota files are initialized on every
mount. This also goes for quota limits, that needs to be set up after
every mount.

The quota support in tmpfs is well separated from the rest of the
filesystem and is only enabled using mount option -o quota (and
usrquota and grpquota for compatibility reasons). Only quota accounting
is enabled this way, enforcement needs to be enable by regular quota
tools (using Q_QUOTAON ioctl).

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
v2: Use the newly introduced in-memory only quota foramt QFMT_MEM_ONLY

 Documentation/filesystems/tmpfs.rst |  12 ++
 fs/quota/dquot.c                    |  10 +-
 include/linux/shmem_fs.h            |   3 +
 mm/shmem.c                          | 200 ++++++++++++++++++++++++----
 4 files changed, 197 insertions(+), 28 deletions(-)

diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
index 0408c245785e..9c4f228ef4f3 100644
--- a/Documentation/filesystems/tmpfs.rst
+++ b/Documentation/filesystems/tmpfs.rst
@@ -86,6 +86,18 @@ use up all the memory on the machine; but enhances the scalability of
 that instance in a system with many CPUs making intensive use of it.
 
 
+tmpfs also supports quota with the following mount options
+
+========  =============================================================
+quota     Quota accounting is enabled on the mount. Tmpfs is using
+          hidden system quota files that are initialized on mount.
+          Quota limits can quota enforcement can be enabled using
+          standard quota tools.
+usrquota  Same as quota option. Exists for compatibility reasons.
+grpquota  Same as quota option. Exists for compatibility reasons.
+========  =============================================================
+
+
 tmpfs has a mount option to set the NUMA memory allocation policy for
 all files in that instance (if CONFIG_NUMA is enabled) - which can be
 adjusted on the fly via 'mount -o remount ...'
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index f1a7a03632a2..007604e7eb09 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -716,11 +716,11 @@ int dquot_quota_sync(struct super_block *sb, int type)
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		if (type != -1 && cnt != type)
 			continue;
-		if (!sb_has_quota_active(sb, cnt))
-			continue;
-		inode_lock(dqopt->files[cnt]);
-		truncate_inode_pages(&dqopt->files[cnt]->i_data, 0);
-		inode_unlock(dqopt->files[cnt]);
+		if (sb_has_quota_active(sb, cnt) && dqopt->files[cnt]) {
+			inode_lock(dqopt->files[cnt]);
+			truncate_inode_pages(&dqopt->files[cnt]->i_data, 0);
+			inode_unlock(dqopt->files[cnt]);
+		}
 	}
 
 	return 0;
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index d500ea967dc7..02a328c98d3a 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -26,6 +26,9 @@ struct shmem_inode_info {
 	atomic_t		stop_eviction;	/* hold when working on inode */
 	struct timespec64	i_crtime;	/* file creation time */
 	unsigned int		fsflags;	/* flags for FS_IOC_[SG]ETFLAGS */
+#ifdef CONFIG_QUOTA
+	struct dquot		*i_dquot[MAXQUOTAS];
+#endif
 	struct inode		vfs_inode;
 };
 
diff --git a/mm/shmem.c b/mm/shmem.c
index c1d8b8a1aa3b..26f2effd8f7c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -79,6 +79,7 @@ static struct vfsmount *shm_mnt;
 #include <linux/userfaultfd_k.h>
 #include <linux/rmap.h>
 #include <linux/uuid.h>
+#include <linux/quotaops.h>
 
 #include <linux/uaccess.h>
 
@@ -120,8 +121,13 @@ struct shmem_options {
 #define SHMEM_SEEN_INODES 2
 #define SHMEM_SEEN_HUGE 4
 #define SHMEM_SEEN_INUMS 8
+#define SHMEM_SEEN_QUOTA 16
 };
 
+static void shmem_set_inode_flags(struct inode *, unsigned int);
+static struct inode *shmem_get_inode_noquota(struct super_block *,
+			struct inode *, umode_t, dev_t, unsigned long);
+
 #ifdef CONFIG_TMPFS
 static unsigned long shmem_default_max_blocks(void)
 {
@@ -136,6 +142,10 @@ static unsigned long shmem_default_max_inodes(void)
 }
 #endif
 
+#if defined(CONFIG_TMPFS) && defined(CONFIG_QUOTA)
+#define SHMEM_QUOTA_TMPFS
+#endif
+
 static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			     struct folio **foliop, enum sgp_type sgp,
 			     gfp_t gfp, struct vm_area_struct *vma,
@@ -198,26 +208,34 @@ static inline void shmem_unacct_blocks(unsigned long flags, long pages)
 		vm_unacct_memory(pages * VM_ACCT(PAGE_SIZE));
 }
 
-static inline bool shmem_inode_acct_block(struct inode *inode, long pages)
+static inline int shmem_inode_acct_block(struct inode *inode, long pages)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+	int err = -ENOSPC;
 
 	if (shmem_acct_block(info->flags, pages))
-		return false;
+		return err;
 
 	if (sbinfo->max_blocks) {
 		if (percpu_counter_compare(&sbinfo->used_blocks,
 					   sbinfo->max_blocks - pages) > 0)
 			goto unacct;
+		if (dquot_alloc_block_nodirty(inode, pages)) {
+			err = -EDQUOT;
+			goto unacct;
+		}
 		percpu_counter_add(&sbinfo->used_blocks, pages);
+	} else if (dquot_alloc_block_nodirty(inode, pages)) {
+		err = -EDQUOT;
+		goto unacct;
 	}
 
-	return true;
+	return 0;
 
 unacct:
 	shmem_unacct_blocks(info->flags, pages);
-	return false;
+	return err;
 }
 
 static inline void shmem_inode_unacct_blocks(struct inode *inode, long pages)
@@ -225,6 +243,8 @@ static inline void shmem_inode_unacct_blocks(struct inode *inode, long pages)
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 
+	dquot_free_block_nodirty(inode, pages);
+
 	if (sbinfo->max_blocks)
 		percpu_counter_sub(&sbinfo->used_blocks, pages);
 	shmem_unacct_blocks(info->flags, pages);
@@ -247,6 +267,62 @@ bool vma_is_shmem(struct vm_area_struct *vma)
 static LIST_HEAD(shmem_swaplist);
 static DEFINE_MUTEX(shmem_swaplist_mutex);
 
+#ifdef SHMEM_QUOTA_TMPFS
+
+#define SHMEM_MAXQUOTAS 2
+
+/*
+ * We don't have any quota files to read, or write to/from, but quota code
+ * requires .quota_read and .quota_write to exist.
+ */
+static ssize_t shmem_quota_write(struct super_block *sb, int type,
+				const char *data, size_t len, loff_t off)
+{
+	return len;
+}
+
+static ssize_t shmem_quota_read(struct super_block *sb, int type, char *data,
+			       size_t len, loff_t off)
+{
+	return len;
+}
+
+
+static int shmem_enable_quotas(struct super_block *sb)
+{
+	int type, err = 0;
+
+	sb_dqopt(sb)->flags |= DQUOT_QUOTA_SYS_FILE | DQUOT_NOLIST_DIRTY;
+	for (type = 0; type < SHMEM_MAXQUOTAS; type++) {
+		err = dquot_load_quota_sb(sb, type, QFMT_MEM_ONLY,
+					  DQUOT_USAGE_ENABLED);
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
+#endif /* SHMEM_QUOTA_TMPFS */
+
 /*
  * shmem_reserve_inode() performs bookkeeping to reserve a shmem inode, and
  * produces a novel ino for the newly allocated inode.
@@ -353,7 +429,6 @@ static void shmem_recalc_inode(struct inode *inode)
 	freed = info->alloced - info->swapped - inode->i_mapping->nrpages;
 	if (freed > 0) {
 		info->alloced -= freed;
-		inode->i_blocks -= freed * BLOCKS_PER_PAGE;
 		shmem_inode_unacct_blocks(inode, freed);
 	}
 }
@@ -363,7 +438,7 @@ bool shmem_charge(struct inode *inode, long pages)
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	unsigned long flags;
 
-	if (!shmem_inode_acct_block(inode, pages))
+	if (shmem_inode_acct_block(inode, pages))
 		return false;
 
 	/* nrpages adjustment first, then shmem_recalc_inode() when balanced */
@@ -371,7 +446,6 @@ bool shmem_charge(struct inode *inode, long pages)
 
 	spin_lock_irqsave(&info->lock, flags);
 	info->alloced += pages;
-	inode->i_blocks += pages * BLOCKS_PER_PAGE;
 	shmem_recalc_inode(inode);
 	spin_unlock_irqrestore(&info->lock, flags);
 
@@ -387,7 +461,6 @@ void shmem_uncharge(struct inode *inode, long pages)
 
 	spin_lock_irqsave(&info->lock, flags);
 	info->alloced -= pages;
-	inode->i_blocks -= pages * BLOCKS_PER_PAGE;
 	shmem_recalc_inode(inode);
 	spin_unlock_irqrestore(&info->lock, flags);
 
@@ -1119,6 +1192,13 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
 		}
 	}
 
+	 /* Transfer quota accounting */
+	if (i_uid_needs_update(mnt_userns, attr, inode) ||
+	    i_gid_needs_update(mnt_userns, attr, inode))
+		error = dquot_transfer(mnt_userns, inode, attr);
+	if (error)
+		return error;
+
 	setattr_copy(&init_user_ns, inode, attr);
 	if (attr->ia_valid & ATTR_MODE)
 		error = posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
@@ -1164,7 +1244,9 @@ static void shmem_evict_inode(struct inode *inode)
 	simple_xattrs_free(&info->xattrs);
 	WARN_ON(inode->i_blocks);
 	shmem_free_inode(inode->i_sb);
+	dquot_free_inode(inode);
 	clear_inode(inode);
+	dquot_drop(inode);
 }
 
 static int shmem_find_swap_entries(struct address_space *mapping,
@@ -1569,14 +1651,14 @@ static struct folio *shmem_alloc_and_acct_folio(gfp_t gfp, struct inode *inode,
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct folio *folio;
-	int nr;
-	int err = -ENOSPC;
+	int nr, err;
 
 	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
 		huge = false;
 	nr = huge ? HPAGE_PMD_NR : 1;
 
-	if (!shmem_inode_acct_block(inode, nr))
+	err = shmem_inode_acct_block(inode, nr);
+	if (err)
 		goto failed;
 
 	if (huge)
@@ -1949,7 +2031,6 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 
 	spin_lock_irq(&info->lock);
 	info->alloced += folio_nr_pages(folio);
-	inode->i_blocks += (blkcnt_t)BLOCKS_PER_PAGE << folio_order(folio);
 	shmem_recalc_inode(inode);
 	spin_unlock_irq(&info->lock);
 	alloced = true;
@@ -2315,8 +2396,10 @@ static void shmem_set_inode_flags(struct inode *inode, unsigned int fsflags)
 #define shmem_initxattrs NULL
 #endif
 
-static struct inode *shmem_get_inode(struct super_block *sb, struct inode *dir,
-				     umode_t mode, dev_t dev, unsigned long flags)
+static struct inode *shmem_get_inode_noquota(struct super_block *sb,
+					     struct inode *dir,
+					     umode_t mode, dev_t dev,
+					     unsigned long flags)
 {
 	struct inode *inode;
 	struct shmem_inode_info *info;
@@ -2384,6 +2467,35 @@ static struct inode *shmem_get_inode(struct super_block *sb, struct inode *dir,
 	return inode;
 }
 
+static struct inode *shmem_get_inode(struct super_block *sb, struct inode *dir,
+				     umode_t mode, dev_t dev, unsigned long flags)
+{
+	int err;
+	struct inode *inode;
+
+	inode = shmem_get_inode_noquota(sb, dir, mode, dev, flags);
+	if (inode) {
+		err = dquot_initialize(inode);
+		if (err)
+			goto errout;
+
+		err = dquot_alloc_inode(inode);
+		if (err) {
+			dquot_drop(inode);
+			goto errout;
+		}
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
@@ -2403,7 +2515,7 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	int ret;
 	pgoff_t max_off;
 
-	if (!shmem_inode_acct_block(inode, 1)) {
+	if (shmem_inode_acct_block(inode, 1)) {
 		/*
 		 * We may have got a page, returned -ENOENT triggering a retry,
 		 * and now we find ourselves with -ENOMEM. Release the page, to
@@ -2487,7 +2599,6 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 
 	spin_lock_irq(&info->lock);
 	info->alloced++;
-	inode->i_blocks += BLOCKS_PER_PAGE;
 	shmem_recalc_inode(inode);
 	spin_unlock_irq(&info->lock);
 
@@ -2908,7 +3019,7 @@ shmem_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	int error = -ENOSPC;
 
 	inode = shmem_get_inode(dir->i_sb, dir, mode, dev, VM_NORESERVE);
-	if (inode) {
+	if (!IS_ERR_OR_NULL(inode)) {
 		error = simple_acl_create(dir, inode);
 		if (error)
 			goto out_iput;
@@ -2924,7 +3035,8 @@ shmem_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 		inode_inc_iversion(dir);
 		d_instantiate(dentry, inode);
 		dget(dentry); /* Extra count - pin the dentry in core */
-	}
+	} else if (IS_ERR(inode))
+		error = PTR_ERR(inode);
 	return error;
 out_iput:
 	iput(inode);
@@ -2939,7 +3051,7 @@ shmem_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 	int error = -ENOSPC;
 
 	inode = shmem_get_inode(dir->i_sb, dir, mode, 0, VM_NORESERVE);
-	if (inode) {
+	if (!IS_ERR_OR_NULL(inode)) {
 		error = security_inode_init_security(inode, dir,
 						     NULL,
 						     shmem_initxattrs, NULL);
@@ -2949,7 +3061,8 @@ shmem_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 		if (error)
 			goto out_iput;
 		d_tmpfile(file, inode);
-	}
+	} else if (IS_ERR(inode))
+		error = PTR_ERR(inode);
 	return finish_open_simple(file, error);
 out_iput:
 	iput(inode);
@@ -3126,6 +3239,8 @@ static int shmem_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 				VM_NORESERVE);
 	if (!inode)
 		return -ENOSPC;
+	else if (IS_ERR(inode))
+		return PTR_ERR(inode);
 
 	error = security_inode_init_security(inode, dir, &dentry->d_name,
 					     shmem_initxattrs, NULL);
@@ -3443,6 +3558,7 @@ enum shmem_param {
 	Opt_uid,
 	Opt_inode32,
 	Opt_inode64,
+	Opt_quota,
 };
 
 static const struct constant_table shmem_param_enums_huge[] = {
@@ -3464,6 +3580,9 @@ const struct fs_parameter_spec shmem_fs_parameters[] = {
 	fsparam_u32   ("uid",		Opt_uid),
 	fsparam_flag  ("inode32",	Opt_inode32),
 	fsparam_flag  ("inode64",	Opt_inode64),
+	fsparam_flag  ("quota",		Opt_quota),
+	fsparam_flag  ("usrquota",	Opt_quota),
+	fsparam_flag  ("grpquota",	Opt_quota),
 	{}
 };
 
@@ -3547,6 +3666,13 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 		ctx->full_inums = true;
 		ctx->seen |= SHMEM_SEEN_INUMS;
 		break;
+	case Opt_quota:
+#ifdef CONFIG_QUOTA
+		ctx->seen |= SHMEM_SEEN_QUOTA;
+#else
+		goto unsupported_parameter;
+#endif
+		break;
 	}
 	return 0;
 
@@ -3646,6 +3772,12 @@ static int shmem_reconfigure(struct fs_context *fc)
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
@@ -3728,6 +3860,9 @@ static void shmem_put_super(struct super_block *sb)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 
+#ifdef SHMEM_QUOTA_TMPFS
+	shmem_disable_quotas(sb);
+#endif
 	free_percpu(sbinfo->ino_batch);
 	percpu_counter_destroy(&sbinfo->used_blocks);
 	mpol_put(sbinfo->mpol);
@@ -3805,14 +3940,26 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 #endif
 	uuid_gen(&sb->s_uuid);
 
+#ifdef SHMEM_QUOTA_TMPFS
+	if (ctx->seen & SHMEM_SEEN_QUOTA) {
+		sb->dq_op = &dquot_operations;
+		sb->s_qcop = &dquot_quotactl_sysfile_ops;
+		sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP;
+
+		if (shmem_enable_quotas(sb))
+			goto failed;
+	}
+#endif  /* SHMEM_QUOTA_TMPFS */
+
 	inode = shmem_get_inode(sb, NULL, S_IFDIR | sbinfo->mode, 0, VM_NORESERVE);
-	if (!inode)
+	if (IS_ERR_OR_NULL(inode))
 		goto failed;
 	inode->i_uid = sbinfo->uid;
 	inode->i_gid = sbinfo->gid;
 	sb->s_root = d_make_root(inode);
 	if (!sb->s_root)
 		goto failed;
+
 	return 0;
 
 failed:
@@ -3976,7 +4123,12 @@ static const struct super_operations shmem_ops = {
 #ifdef CONFIG_TMPFS
 	.statfs		= shmem_statfs,
 	.show_options	= shmem_show_options,
-#endif
+#ifdef CONFIG_QUOTA
+	.quota_read	= shmem_quota_read,
+	.quota_write	= shmem_quota_write,
+	.get_dquots	= shmem_get_dquots,
+#endif /* CONFIG_QUOTA */
+#endif /* CONFIG_TMPFS */
 	.evict_inode	= shmem_evict_inode,
 	.drop_inode	= generic_delete_inode,
 	.put_super	= shmem_put_super,
@@ -4196,8 +4348,10 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name, l
 
 	inode = shmem_get_inode(mnt->mnt_sb, NULL, S_IFREG | S_IRWXUGO, 0,
 				flags);
-	if (unlikely(!inode)) {
+	if (IS_ERR_OR_NULL(inode)) {
 		shmem_unacct_size(flags, size);
+		if (IS_ERR(inode))
+			return (struct file *)inode;
 		return ERR_PTR(-ENOSPC);
 	}
 	inode->i_flags |= i_flags;
-- 
2.38.1

