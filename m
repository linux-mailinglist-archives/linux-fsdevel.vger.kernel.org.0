Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548B175372A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 11:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbjGNJyy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 05:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbjGNJyx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:54:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9BFA7
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 02:54:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53DAA61CC3
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 09:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0917C433C7;
        Fri, 14 Jul 2023 09:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689328490;
        bh=MnndG+64kR7REmcYPyi/J9o+3mXRGPft+wQsAz+qsBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eSKm4+WmYQegIDDpl36dlnbSiuxntgMwXyWztAAodM7gz+7d1Dr8G1dzXrd/IrYAu
         9OS+fudhQYZB4vKy+Vxupsm582en9ippcugwJYo01OQvZBIH/2gQ1MC8k6ih2CCvKd
         8nL56Y3vjHIEkwh2QugH0Tl1FpTqz7Q9D/DUYtD31RbDGdVjTHq1ny/hDSLCjeovE7
         UO4rGl/XwTuo9EwO6RnjOKAKlTpXXYD8TrCTL4YhndjtqISuk47dMw8tfiJj/9fmip
         Sc9vcuZhmIiDdK9R527AgrzrpcrCwV4QAEdDKgqsno+jLcovV7y/2MnQ0f7SkDZETW
         BRv37B9q2/aZA==
Date:   Fri, 14 Jul 2023 11:54:45 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     cem@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, jack@suse.cz,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, djwong@kernel.org, hughd@google.com,
        mcgrof@kernel.org
Subject: Re: [PATCH 5/6] shmem: quota support
Message-ID: <20230714-messtechnik-knieprobleme-5d0a3abb4413@brauner>
References: <20230713134848.249779-1-cem@kernel.org>
 <20230713134848.249779-6-cem@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230713134848.249779-6-cem@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 13, 2023 at 03:48:47PM +0200, cem@kernel.org wrote:
> From: Carlos Maiolino <cem@kernel.org>
> 
> Now the basic infra-structure is in place, enable quota support for tmpfs.
> 
> This offers user and group quotas to tmpfs (project quotas will be added
> later). Also, as other filesystems, the tmpfs quota is not supported
> within user namespaces yet, so idmapping is not translated.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  Documentation/filesystems/tmpfs.rst |  15 +++
>  include/linux/shmem_fs.h            |   8 ++
>  mm/shmem.c                          | 180 ++++++++++++++++++++++++++--
>  3 files changed, 195 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
> index f18f46be5c0c..0c7d8bd052f1 100644
> --- a/Documentation/filesystems/tmpfs.rst
> +++ b/Documentation/filesystems/tmpfs.rst
> @@ -130,6 +130,21 @@ for emergency or testing purposes. The values you can set for shmem_enabled are:
>      option, for testing
>  ==  ============================================================
>  
> +tmpfs also supports quota with the following mount options
> +
> +========  =============================================================
> +quota     User and group quota accounting and enforcement is enabled on
> +          the mount. Tmpfs is using hidden system quota files that are
> +          initialized on mount.
> +usrquota  User quota accounting and enforcement is enabled on the
> +          mount.
> +grpquota  Group quota accounting and enforcement is enabled on the
> +          mount.
> +========  =============================================================
> +
> +Note that tmpfs quotas do not support user namespaces so no uid/gid
> +translation is done if quotas are enabled inside user namespaces.
> +
>  tmpfs has a mount option to set the NUMA memory allocation policy for
>  all files in that instance (if CONFIG_NUMA is enabled) - which can be
>  adjusted on the fly via 'mount -o remount ...'
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 7abfaf70b58a..1a568a0f542f 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -31,6 +31,9 @@ struct shmem_inode_info {
>  	atomic_t		stop_eviction;	/* hold when working on inode */
>  	struct timespec64	i_crtime;	/* file creation time */
>  	unsigned int		fsflags;	/* flags for FS_IOC_[SG]ETFLAGS */
> +#ifdef CONFIG_TMPFS_QUOTA
> +	struct dquot		*i_dquot[MAXQUOTAS];
> +#endif
>  	struct inode		vfs_inode;
>  };
>  
> @@ -184,4 +187,9 @@ extern int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
>  #define SHMEM_QUOTA_MAX_SPC_LIMIT 0x7fffffffffffffffLL /* 2^63-1 */
>  #define SHMEM_QUOTA_MAX_INO_LIMIT 0x7fffffffffffffffLL
>  
> +#ifdef CONFIG_TMPFS_QUOTA
> +extern const struct dquot_operations shmem_quota_operations;
> +extern struct quota_format_type shmem_quota_format;
> +#endif /* CONFIG_TMPFS_QUOTA */
> +
>  #endif
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 2a7b8060b6f4..5022238dd68d 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -78,6 +78,7 @@ static struct vfsmount *shm_mnt;
>  #include <uapi/linux/memfd.h>
>  #include <linux/rmap.h>
>  #include <linux/uuid.h>
> +#include <linux/quotaops.h>
>  
>  #include <linux/uaccess.h>
>  
> @@ -116,11 +117,13 @@ struct shmem_options {
>  	int huge;
>  	int seen;
>  	bool noswap;
> +	unsigned short quota_types;
>  #define SHMEM_SEEN_BLOCKS 1
>  #define SHMEM_SEEN_INODES 2
>  #define SHMEM_SEEN_HUGE 4
>  #define SHMEM_SEEN_INUMS 8
>  #define SHMEM_SEEN_NOSWAP 16
> +#define SHMEM_SEEN_QUOTA 32
>  };
>  
>  #ifdef CONFIG_TMPFS
> @@ -212,7 +215,16 @@ static inline int shmem_inode_acct_block(struct inode *inode, long pages)
>  		if (percpu_counter_compare(&sbinfo->used_blocks,
>  					   sbinfo->max_blocks - pages) > 0)
>  			goto unacct;
> +
> +		err = dquot_alloc_block_nodirty(inode, pages);
> +		if (err)
> +			goto unacct;
> +
>  		percpu_counter_add(&sbinfo->used_blocks, pages);
> +	} else {
> +		err = dquot_alloc_block_nodirty(inode, pages);
> +		if (err)
> +			goto unacct;
>  	}
>  
>  	return 0;
> @@ -227,6 +239,8 @@ static inline void shmem_inode_unacct_blocks(struct inode *inode, long pages)
>  	struct shmem_inode_info *info = SHMEM_I(inode);
>  	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
>  
> +	dquot_free_block_nodirty(inode, pages);
> +
>  	if (sbinfo->max_blocks)
>  		percpu_counter_sub(&sbinfo->used_blocks, pages);
>  	shmem_unacct_blocks(info->flags, pages);
> @@ -255,6 +269,47 @@ bool vma_is_shmem(struct vm_area_struct *vma)
>  static LIST_HEAD(shmem_swaplist);
>  static DEFINE_MUTEX(shmem_swaplist_mutex);
>  
> +#ifdef CONFIG_TMPFS_QUOTA
> +
> +static int shmem_enable_quotas(struct super_block *sb,
> +			       unsigned short quota_types)
> +{
> +	int type, err = 0;
> +
> +	sb_dqopt(sb)->flags |= DQUOT_QUOTA_SYS_FILE | DQUOT_NOLIST_DIRTY;
> +	for (type = 0; type < SHMEM_MAXQUOTAS; type++) {
> +		if (!(quota_types & (1 << type)))
> +			continue;
> +		err = dquot_load_quota_sb(sb, type, QFMT_SHMEM,
> +					  DQUOT_USAGE_ENABLED |
> +					  DQUOT_LIMITS_ENABLED);
> +		if (err)
> +			goto out_err;
> +	}
> +	return 0;
> +
> +out_err:
> +	pr_warn("tmpfs: failed to enable quota tracking (type=%d, err=%d)\n",
> +		type, err);
> +	for (type--; type >= 0; type--)
> +		dquot_quota_off(sb, type);
> +	return err;
> +}
> +
> +static void shmem_disable_quotas(struct super_block *sb)
> +{
> +	int type;
> +
> +	for (type = 0; type < SHMEM_MAXQUOTAS; type++)
> +		dquot_quota_off(sb, type);
> +}
> +
> +static struct dquot **shmem_get_dquots(struct inode *inode)
> +{
> +	return SHMEM_I(inode)->i_dquot;
> +}
> +#endif /* CONFIG_TMPFS_QUOTA */
> +
>  /*
>   * shmem_reserve_inode() performs bookkeeping to reserve a shmem inode, and
>   * produces a novel ino for the newly allocated inode.
> @@ -361,7 +416,6 @@ static void shmem_recalc_inode(struct inode *inode)
>  	freed = info->alloced - info->swapped - inode->i_mapping->nrpages;
>  	if (freed > 0) {
>  		info->alloced -= freed;
> -		inode->i_blocks -= freed * BLOCKS_PER_PAGE;
>  		shmem_inode_unacct_blocks(inode, freed);
>  	}
>  }
> @@ -379,7 +433,6 @@ bool shmem_charge(struct inode *inode, long pages)
>  
>  	spin_lock_irqsave(&info->lock, flags);
>  	info->alloced += pages;
> -	inode->i_blocks += pages * BLOCKS_PER_PAGE;
>  	shmem_recalc_inode(inode);
>  	spin_unlock_irqrestore(&info->lock, flags);
>  
> @@ -395,7 +448,6 @@ void shmem_uncharge(struct inode *inode, long pages)
>  
>  	spin_lock_irqsave(&info->lock, flags);
>  	info->alloced -= pages;
> -	inode->i_blocks -= pages * BLOCKS_PER_PAGE;
>  	shmem_recalc_inode(inode);
>  	spin_unlock_irqrestore(&info->lock, flags);
>  
> @@ -1141,6 +1193,21 @@ static int shmem_setattr(struct mnt_idmap *idmap,
>  		}
>  	}
>  
> +	if (is_quota_modification(idmap, inode, attr)) {
> +		error = dquot_initialize(inode);
> +		if (error)
> +			return error;
> +	}
> +
> +	/* Transfer quota accounting */
> +	if (i_uid_needs_update(idmap, attr, inode) ||
> +	    i_gid_needs_update(idmap, attr, inode)) {
> +		error = dquot_transfer(idmap, inode, attr);
> +
> +		if (error)
> +			return error;
> +	}
> +
>  	setattr_copy(idmap, inode, attr);
>  	if (attr->ia_valid & ATTR_MODE)
>  		error = posix_acl_chmod(idmap, dentry, inode->i_mode);
> @@ -1187,6 +1254,10 @@ static void shmem_evict_inode(struct inode *inode)
>  	WARN_ON(inode->i_blocks);
>  	shmem_free_inode(inode->i_sb);
>  	clear_inode(inode);
> +#ifdef CONFIG_TMPFS_QUOTA
> +	dquot_free_inode(inode);
> +	dquot_drop(inode);
> +#endif
>  }
>  
>  static int shmem_find_swap_entries(struct address_space *mapping,
> @@ -1986,7 +2057,6 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>  
>  	spin_lock_irq(&info->lock);
>  	info->alloced += folio_nr_pages(folio);
> -	inode->i_blocks += (blkcnt_t)BLOCKS_PER_PAGE << folio_order(folio);
>  	shmem_recalc_inode(inode);
>  	spin_unlock_irq(&info->lock);
>  	alloced = true;
> @@ -2357,9 +2427,10 @@ static void shmem_set_inode_flags(struct inode *inode, unsigned int fsflags)
>  #define shmem_initxattrs NULL
>  #endif
>  
> -static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block *sb,
> -				     struct inode *dir, umode_t mode, dev_t dev,
> -				     unsigned long flags)
> +static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
> +					     struct super_block *sb,
> +					     struct inode *dir, umode_t mode,
> +					     dev_t dev, unsigned long flags)
>  {
>  	struct inode *inode;
>  	struct shmem_inode_info *info;
> @@ -2436,6 +2507,43 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block
>  	return inode;
>  }
>  
> +#ifdef CONFIG_TMPFS_QUOTA
> +static struct inode *shmem_get_inode(struct mnt_idmap *idmap,
> +				     struct super_block *sb, struct inode *dir,
> +				     umode_t mode, dev_t dev, unsigned long flags)
> +{
> +	int err;
> +	struct inode *inode;
> +
> +	inode = __shmem_get_inode(idmap, sb, dir, mode, dev, flags);
> +	if (IS_ERR(inode))
> +		return inode;
> +
> +	err = dquot_initialize(inode);
> +	if (err)
> +		goto errout;
> +
> +	err = dquot_alloc_inode(inode);
> +	if (err) {
> +		dquot_drop(inode);
> +		goto errout;
> +	}
> +	return inode;
> +
> +errout:
> +	inode->i_flags |= S_NOQUOTA;
> +	iput(inode);
> +	return ERR_PTR(err);
> +}
> +#else
> +static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
> +				     struct super_block *sb, struct inode *dir,
> +				     umode_t mode, dev_t dev, unsigned long flags)
> +{
> +	return __shmem_get_inode(idmap, sb, dir, mode, dev, flags);
> +}
> +#endif /* CONFIG_TMPFS_QUOTA */
> +
>  #ifdef CONFIG_USERFAULTFD
>  int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
>  			   struct vm_area_struct *dst_vma,
> @@ -2538,7 +2646,6 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
>  
>  	spin_lock_irq(&info->lock);
>  	info->alloced++;
> -	inode->i_blocks += BLOCKS_PER_PAGE;
>  	shmem_recalc_inode(inode);
>  	spin_unlock_irq(&info->lock);
>  
> @@ -3516,6 +3623,7 @@ static ssize_t shmem_listxattr(struct dentry *dentry, char *buffer, size_t size)
>  
>  static const struct inode_operations shmem_short_symlink_operations = {
>  	.getattr	= shmem_getattr,
> +	.setattr	= shmem_setattr,
>  	.get_link	= simple_get_link,
>  #ifdef CONFIG_TMPFS_XATTR
>  	.listxattr	= shmem_listxattr,
> @@ -3524,6 +3632,7 @@ static const struct inode_operations shmem_short_symlink_operations = {
>  
>  static const struct inode_operations shmem_symlink_inode_operations = {
>  	.getattr	= shmem_getattr,
> +	.setattr	= shmem_setattr,
>  	.get_link	= shmem_get_link,
>  #ifdef CONFIG_TMPFS_XATTR
>  	.listxattr	= shmem_listxattr,
> @@ -3623,6 +3732,9 @@ enum shmem_param {
>  	Opt_inode32,
>  	Opt_inode64,
>  	Opt_noswap,
> +	Opt_quota,
> +	Opt_usrquota,
> +	Opt_grpquota,
>  };
>  
>  static const struct constant_table shmem_param_enums_huge[] = {
> @@ -3645,6 +3757,11 @@ const struct fs_parameter_spec shmem_fs_parameters[] = {
>  	fsparam_flag  ("inode32",	Opt_inode32),
>  	fsparam_flag  ("inode64",	Opt_inode64),
>  	fsparam_flag  ("noswap",	Opt_noswap),
> +#ifdef CONFIG_TMPFS_QUOTA
> +	fsparam_flag  ("quota",		Opt_quota),
> +	fsparam_flag  ("usrquota",	Opt_usrquota),
> +	fsparam_flag  ("grpquota",	Opt_grpquota),
> +#endif
>  	{}
>  };
>  
> @@ -3736,6 +3853,18 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
>  		ctx->noswap = true;
>  		ctx->seen |= SHMEM_SEEN_NOSWAP;
>  		break;
> +	case Opt_quota:
> +		ctx->seen |= SHMEM_SEEN_QUOTA;
> +		ctx->quota_types |= (QTYPE_MASK_USR | QTYPE_MASK_GRP);
> +		break;
> +	case Opt_usrquota:
> +		ctx->seen |= SHMEM_SEEN_QUOTA;
> +		ctx->quota_types |= QTYPE_MASK_USR;
> +		break;
> +	case Opt_grpquota:
> +		ctx->seen |= SHMEM_SEEN_QUOTA;
> +		ctx->quota_types |= QTYPE_MASK_GRP;
> +		break;
>  	}
>  	return 0;

I mentioned this in an earlier review; following the sequence:

if (ctx->seen & SHMEM_SEEN_QUOTA)
-> shmem_enable_quotas()
   -> dquot_load_quota_sb()

to then figure out that in dquot_load_quota_sb() we fail if
sb->s_user_ns != &init_user_ns is too subtle for a filesystem that's
mountable by unprivileged users. Every few months someone will end up
stumbling upon this code and wonder where it's blocked. There isn't even
a comment in the code.

Aside from that it's also really unfriendly to users because they may go
through setting up a tmpfs instances in the following way:

        fd_fs = fsopen("tmpfs");

User now enables quota:

        fsconfig(fd_fs, ..., "quota", ...) = 0

and goes on to set a bunch of other options:

        fsconfig(fd_fs, ..., "inode64", ...) = 0
        fsconfig(fd_fs, ..., "nr_inodes", ...) = 0
        fsconfig(fd_fs, ..., "nr_blocks", ...) = 0
        fsconfig(fd_fs, ..., "huge", ...) = 0
        fsconfig(fd_fs, ..., "mode", ...) = 0
        fsconfig(fd_fs, ..., "gid", ...) = 0

everything seems dandy and they create the superblock:

        fsconfig(fd_fs, FSCONFIG_CMD_CREATE, ...) = -EINVAL

which fails.

The user has not just performed 9 useless system calls they also have
zero clue what mount option caused the failure.

What this code really really should do is fail at:

        fsconfig(fd_fs, ..., "quota", ...) = -EINVAL

and log an error that the user can retrieve from the fs context. IOW,

diff --git a/mm/shmem.c b/mm/shmem.c
index 083ce6b478e7..baca8bf44569 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3863,14 +3863,20 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
                ctx->seen |= SHMEM_SEEN_NOSWAP;
                break;
        case Opt_quota:
+               if (fc->user_ns != &init_user_ns)
+                       return invalfc(fc, "Quotas in unprivileged tmpfs mounts unsupported");
                ctx->seen |= SHMEM_SEEN_QUOTA;
                ctx->quota_types |= (QTYPE_MASK_USR | QTYPE_MASK_GRP);
                break;
        case Opt_usrquota:
+               if (fc->user_ns != &init_user_ns)
+                       return invalfc(fc, "Quotas in unprivileged tmpfs mounts unsupported");
                ctx->seen |= SHMEM_SEEN_QUOTA;
                ctx->quota_types |= QTYPE_MASK_USR;
                break;
        case Opt_grpquota:
+               if (fc->user_ns != &init_user_ns)
+                       return invalfc(fc, "Quotas in unprivileged tmpfs mounts unsupported");
                ctx->seen |= SHMEM_SEEN_QUOTA;
                ctx->quota_types |= QTYPE_MASK_GRP;
                break;

This exactly what we already to for the "noswap" option btw.

Could you fold these changes into the patch and resend, please?
I synced with Andrew earlier and I'll be taking this series.

---

And btw, the *_SEEN_* logic for mount options is broken - but that's not
specific to your patch. Imagine:

        fd_fs = fsopen("tmpfs");
        fsconfig(fd_fs, ..., "nr_inodes", 0, "1000") = 0

Now ctx->inodes == 1000 and ctx->seen |= SHMEM_SEEN_INODES.

Now the user does:

        fsconfig(fd_fs, ..., "nr_inodes", 0, "-1234") = -EINVAL

This fails, but:

        ctx->inodes = memparse(param->string, &rest);
        if (*rest)
                goto bad_value;

will set ctx->inodes to whatever memparse returns but leaves
SHMEM_SEEN_INODES raised in ctx->seen. Now superblock creation may
succeed with a garbage inode limit. This should affect other mount
options as well.
