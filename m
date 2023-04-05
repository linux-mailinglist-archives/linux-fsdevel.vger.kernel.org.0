Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21C86D7BB7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 13:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237291AbjDELnP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 07:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbjDELnO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:43:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32E55BAB
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 04:42:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AABDA1FD84;
        Wed,  5 Apr 2023 11:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680694965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kx3+Og+BqjworQfE0Cgco0zEE9jQhWPtk2eUyIEG25I=;
        b=KMPaH074dFHBKxXJiv5UDB4WPI/iSbAXVIlo3jCMGkJyCwBgVQW1aHSTSd20gfMb69/U4P
        z5F15mP1kBixdvS8PMy5xJFt9DLmUAwm5vglvMZdp/2eztQVaAyiynfsBku5I18kAAXSWI
        oxLv3+fIEsP4zYxclOcU7WNq6RfhoRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680694965;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kx3+Og+BqjworQfE0Cgco0zEE9jQhWPtk2eUyIEG25I=;
        b=7fDrp4t4F3np8uaMTCjV+A2SiNccZbq+gl2f76FtZUckb2G8vvSZO/MzTEihHqZadTI/Ng
        AjidqYstPf6CxACg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A73C13A31;
        Wed,  5 Apr 2023 11:42:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZpqpJbVeLWTrLAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 05 Apr 2023 11:42:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0FE9FA0729; Wed,  5 Apr 2023 13:42:45 +0200 (CEST)
Date:   Wed, 5 Apr 2023 13:42:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     cem@kernel.org
Cc:     hughd@google.com, jack@suse.cz, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 5/6] shmem: quota support
Message-ID: <20230405114245.nnzorjm5nlr4l4g6@quack3>
References: <20230403084759.884681-1-cem@kernel.org>
 <20230403084759.884681-6-cem@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403084759.884681-6-cem@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 03-04-23 10:47:58, cem@kernel.org wrote:
> From: Lukas Czerner <lczerner@redhat.com>
> 
> Now the basic infra-structure is in place, enable quota support for tmpfs.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>

Some comments below...

> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index cf38381bdb4c1..3e7e18726feb5 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -26,6 +26,9 @@ struct shmem_inode_info {
>  	atomic_t		stop_eviction;	/* hold when working on inode */
>  	struct timespec64	i_crtime;	/* file creation time */
>  	unsigned int		fsflags;	/* flags for FS_IOC_[SG]ETFLAGS */
> +#ifdef CONFIG_TMPFS_QUOTA
> +	struct dquot		*i_dquot[MAXQUOTAS];
> +#endif
>  	struct inode		vfs_inode;
>  };
>  
> @@ -171,4 +174,10 @@ extern int shmem_mfill_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
>  #define SHMEM_QUOTA_MAX_SPC_LIMIT 0x7fffffffffffffffLL /* 2^63-1 */
>  #define SHMEM_QUOTA_MAX_INO_LIMIT 0x7fffffffffffffffLL
>  
> +#ifdef CONFIG_TMPFS_QUOTA
> +#define SHMEM_MAXQUOTAS 2

You have this definition already in mm/shmem_quota.c.

> +extern const struct dquot_operations shmem_quota_operations;
> +extern struct quota_format_type shmem_quota_format;
> +#endif /* CONFIG_TMPFS_QUOTA */
> +
>  #endif
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 88e13930fc013..d7529c883eaf5 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -79,6 +79,7 @@ static struct vfsmount *shm_mnt;
>  #include <linux/userfaultfd_k.h>
>  #include <linux/rmap.h>
>  #include <linux/uuid.h>
> +#include <linux/quotaops.h>
>  
>  #include <linux/uaccess.h>
>  
> @@ -116,10 +117,12 @@ struct shmem_options {
>  	bool full_inums;
>  	int huge;
>  	int seen;
> +	unsigned short quota_types;
>  #define SHMEM_SEEN_BLOCKS 1
>  #define SHMEM_SEEN_INODES 2
>  #define SHMEM_SEEN_HUGE 4
>  #define SHMEM_SEEN_INUMS 8
> +#define SHMEM_SEEN_QUOTA 16
>  };
>  
>  #ifdef CONFIG_TMPFS
> @@ -211,8 +214,11 @@ static inline int shmem_inode_acct_block(struct inode *inode, long pages)
>  		if (percpu_counter_compare(&sbinfo->used_blocks,
>  					   sbinfo->max_blocks - pages) > 0)
>  			goto unacct;
> +		if ((err = dquot_alloc_block_nodirty(inode, pages)) != 0)
> +			goto unacct;

We generally try to avoid assignments in conditions so I'd do:

		err = dquot_alloc_block_nodirty(inode, pages);
		if (err)
			goto unacct;

>  		percpu_counter_add(&sbinfo->used_blocks, pages);
> -	}
> +	} else if ((err = dquot_alloc_block_nodirty(inode, pages)) != 0)
> +		goto unacct;
>  

The same here...

> @@ -1133,6 +1179,15 @@ static int shmem_setattr(struct mnt_idmap *idmap,
>  		}
>  	}
>  
> +	/* Transfer quota accounting */
> +	if (i_uid_needs_update(idmap, attr, inode) ||
> +	    i_gid_needs_update(idmap, attr,inode)) {
> +		error = dquot_transfer(idmap, inode, attr);
> +
> +		if (error)
> +			return error;
> +	}
> +

I think you also need to add:

        if (is_quota_modification(idmap, inode, attr)) {
                error = dquot_initialize(inode);
                if (error)
                        return error;
        }

to shmem_setattr().

>  	setattr_copy(idmap, inode, attr);
>  	if (attr->ia_valid & ATTR_MODE)
>  		error = posix_acl_chmod(idmap, dentry, inode->i_mode);
> @@ -1178,7 +1233,9 @@ static void shmem_evict_inode(struct inode *inode)
>  	simple_xattrs_free(&info->xattrs);
>  	WARN_ON(inode->i_blocks);
>  	shmem_free_inode(inode->i_sb);
> +	dquot_free_inode(inode);
>  	clear_inode(inode);
> +	dquot_drop(inode);
>  }
>  
>  static int shmem_find_swap_entries(struct address_space *mapping,
> @@ -1975,7 +2032,6 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>  
>  	spin_lock_irq(&info->lock);
>  	info->alloced += folio_nr_pages(folio);
> -	inode->i_blocks += (blkcnt_t)BLOCKS_PER_PAGE << folio_order(folio);
>  	shmem_recalc_inode(inode);
>  	spin_unlock_irq(&info->lock);
>  	alloced = true;
> @@ -2346,9 +2402,10 @@ static void shmem_set_inode_flags(struct inode *inode, unsigned int fsflags)
>  #define shmem_initxattrs NULL
>  #endif
>  
> -static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block *sb,
> -				     struct inode *dir, umode_t mode, dev_t dev,
> -				     unsigned long flags)
> +static struct inode *shmem_get_inode_noquota(struct mnt_idmap *idmap,
> +					     struct super_block *sb,
> +					     struct inode *dir, umode_t mode,
> +					     dev_t dev, unsigned long flags)
>  {
>  	struct inode *inode;
>  	struct shmem_inode_info *info;
> @@ -2422,6 +2479,37 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block
>  	return inode;
>  }
>  
> +static struct inode *shmem_get_inode(struct mnt_idmap *idmap,
> +				     struct super_block *sb, struct inode *dir,
> +				     umode_t mode, dev_t dev, unsigned long flags)
> +{
> +	int err;
> +	struct inode *inode;
> +
> +	inode = shmem_get_inode_noquota(idmap, sb, dir, mode, dev, flags);
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
> +	shmem_free_inode(sb);

I think shmem_free_inode() is superfluous here. iput() above should already
unaccount the inode...

> +	if (err)

How could err be possibly unset here?

> +		return ERR_PTR(err);
> +	return NULL;
> +}
> +

> @@ -3582,6 +3679,18 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
>  		ctx->full_inums = true;
>  		ctx->seen |= SHMEM_SEEN_INUMS;
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
>  
> @@ -3681,6 +3790,12 @@ static int shmem_reconfigure(struct fs_context *fc)
>  		goto out;
>  	}
>  
> +	if (ctx->seen & SHMEM_SEEN_QUOTA &&
> +	    !sb_any_quota_loaded(fc->root->d_sb)) {
> +		err = "Cannot enable quota on remount";
> +		goto out;
> +	}
> +
>  	if (ctx->seen & SHMEM_SEEN_HUGE)
>  		sbinfo->huge = ctx->huge;
>  	if (ctx->seen & SHMEM_SEEN_INUMS)
> @@ -3763,6 +3878,9 @@ static void shmem_put_super(struct super_block *sb)
>  {
>  	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
>  
> +#ifdef CONFIG_TMPFS_QUOTA
> +	shmem_disable_quotas(sb);
> +#endif
>  	free_percpu(sbinfo->ino_batch);
>  	percpu_counter_destroy(&sbinfo->used_blocks);
>  	mpol_put(sbinfo->mpol);
> @@ -3841,6 +3959,17 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
>  #endif
>  	uuid_gen(&sb->s_uuid);
>  
> +#ifdef CONFIG_TMPFS_QUOTA
> +	if (ctx->seen & SHMEM_SEEN_QUOTA) {
> +		sb->dq_op = &shmem_quota_operations;
> +		sb->s_qcop = &dquot_quotactl_sysfile_ops;
> +		sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP;

s_quota_types should rather be copied from ctx, shouldn't it? Or why is
s_quota_types inconsistent with ctx->quota_types?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
