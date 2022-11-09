Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D01622624
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Nov 2022 10:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiKIJDQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 04:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiKIJDL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:03:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2DA209BC
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Nov 2022 01:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667984528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W4vLYddQe8A+x9VebdXMUwKUjDdjKR8w8+5wG3Zpo94=;
        b=VADczbbsYgEdHWtEUvxarPzftM00K0bkwtpnrEQx1pZR6AzkrBTSZRjug4HyjhWLWzg/T9
        tenQS1I/M3cGyxb/N8S/nXYfjpaI1LaMH0CNreXzwc5wTtEWhpWdUai1PxT0RKvU/LbdPJ
        UuEjhIK5468d8eKf/5cMwXzX3jKArjk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-My9k-RgxM1O-IZisrxOHwA-1; Wed, 09 Nov 2022 04:02:07 -0500
X-MC-Unique: My9k-RgxM1O-IZisrxOHwA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E813B101B44C;
        Wed,  9 Nov 2022 09:02:06 +0000 (UTC)
Received: from fedora (ovpn-193-254.brq.redhat.com [10.40.193.254])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C5B618EB4;
        Wed,  9 Nov 2022 09:02:05 +0000 (UTC)
Date:   Wed, 9 Nov 2022 10:02:03 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.com>,
        Eric Sandeen <sandeen@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] shmem: implement mount options for global quota
 limits
Message-ID: <20221109090203.osyjkhgkzsffxqmm@fedora>
References: <20221108133010.75226-1-lczerner@redhat.com>
 <20221108133010.75226-3-lczerner@redhat.com>
 <Y2qFUIUB6Kwvbpdv@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2qFUIUB6Kwvbpdv@magnolia>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 08, 2022 at 08:35:28AM -0800, Darrick J. Wong wrote:
> On Tue, Nov 08, 2022 at 02:30:10PM +0100, Lukas Czerner wrote:
> > Implement a set of mount options for setting glopbal quota limits on
> > tmpfs.
> > 
> > quota_ubh_limit - global user quota block hard limit
> 
> Is this the default per-user limit until the sysadmin runs setquota -u
> or something to change a per-user limit?  Or is this a global limit for
> all users and it's never possible to change it?

This is a global limit for all users, except root. The way it works is
that the limit is applied when dquot is first allocated for the
user/group - this is typically the first time user/group allocates
blocks, or creates an inode. It can be changed the same way as it would
be normally.

> 
> (Are there any plans for a soft limit?)

I have no plans for soft limit, but I also don't want to make the naming
confusing once someone decides they'd like to have soft limits in future.

> 
> > quota_uih_limit - global user quota inode hard limit
> > quota_gbh_limit - global group quota block hard limit
> > quota_gih_limit - global group quota inode hard limit
> 
> I don't really like these names, only 2/15 letters in the whole name
> actually distinguish them.

Yes, exactly my feeling as well. I am bad at naming things ;) I was
hoping I'd get some suggestions here, and that exactly what I got.
Thanks!

> 
> usrquota_block_hardlimit?
> usrquota_inode_hardlimit?  8/24...

I like it.

> 
> usrquota_block_limit?
> usrquota_inode_limit?  8/20...

I like it even more, but with hypothetical introduction of soft limits
in future it wouldn't be as obvious it is a hard limit. But maybe it's
not an issue at all.

Thanks!
-Lukas

> 
> (The mechanical changes below here looked ok to me...)
> 
> --D
> 
> > 
> > All of the above mount options will take an effect for any and all
> > users/groups except for root and can be changed using standard ways of
> > setting quota limits. Along with setting the limits, quota enforcement
> > will be enabled as well.
> > 
> > None of the mount options can be set or changed on remount.
> 
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > ---
> >  Documentation/filesystems/tmpfs.rst |  23 ++--
> >  include/linux/shmem_fs.h            |   4 +
> >  mm/shmem.c                          | 166 +++++++++++++++++++++++++---
> >  3 files changed, 171 insertions(+), 22 deletions(-)
> > 
> > diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
> > index 9c4f228ef4f3..be4aa964863d 100644
> > --- a/Documentation/filesystems/tmpfs.rst
> > +++ b/Documentation/filesystems/tmpfs.rst
> > @@ -88,14 +88,21 @@ that instance in a system with many CPUs making intensive use of it.
> >  
> >  tmpfs also supports quota with the following mount options
> >  
> > -========  =============================================================
> > -quota     Quota accounting is enabled on the mount. Tmpfs is using
> > -          hidden system quota files that are initialized on mount.
> > -          Quota limits can quota enforcement can be enabled using
> > -          standard quota tools.
> > -usrquota  Same as quota option. Exists for compatibility reasons.
> > -grpquota  Same as quota option. Exists for compatibility reasons.
> > -========  =============================================================
> > +===============  ======================================================
> > +quota            Quota accounting is enabled on the mount. Tmpfs is
> > +                 using hidden system quota files that are initialized
> > +                 on mount. Quota limits can quota enforcement can be
> > +                 enabled using standard quota tools.
> > +usrquota         Same as quota option. Exists for compatibility.
> > +grpquota         Same as quota option. Exists for compatibility.
> > +quota_ubh_limit  Set global user quota block hard limit.
> > +quota_uih_limit  Set global user quota inode hard limit.
> > +quota_gbh_limit  Set global group quota block hard limit.
> > +quota_gih_limit  Set global group quota inode hard limit.
> > +===============  ======================================================
> > +
> > +Quota limit parameters accept a suffix k, m or g for kilo, mega and
> > +giga and can't be changed on remount.
> >  
> >  
> >  tmpfs has a mount option to set the NUMA memory allocation policy for
> > diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> > index 02a328c98d3a..eb5e2dc2dc4c 100644
> > --- a/include/linux/shmem_fs.h
> > +++ b/include/linux/shmem_fs.h
> > @@ -39,6 +39,10 @@ struct shmem_inode_info {
> >  
> >  struct shmem_sb_info {
> >  	unsigned long max_blocks;   /* How many blocks are allowed */
> > +	unsigned long quota_ubh_limit; /* Default user quota block hard limit */
> > +	unsigned long quota_uih_limit; /* Default user quota inode hard limit */
> > +	unsigned long quota_gbh_limit; /* Default group quota block hard limit */
> > +	unsigned long quota_gih_limit; /* Default group quota inode hard limit */
> >  	struct percpu_counter used_blocks;  /* How many are allocated */
> >  	unsigned long max_inodes;   /* How many inodes are allowed */
> >  	unsigned long free_inodes;  /* How many are left for allocation */
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index ec16659c2255..f1d6a3931b0a 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -99,6 +99,10 @@ static struct vfsmount *shm_mnt;
> >  /* Symlink up to this size is kmalloc'ed instead of using a swappable page */
> >  #define SHORT_SYMLINK_LEN 128
> >  
> > +#if defined(CONFIG_TMPFS) && defined(CONFIG_QUOTA)
> > +#define SHMEM_QUOTA_TMPFS
> > +#endif
> > +
> >  /*
> >   * shmem_fallocate communicates with shmem_fault or shmem_writepage via
> >   * inode->i_private (with i_rwsem making sure that it has only one user at
> > @@ -115,6 +119,12 @@ struct shmem_falloc {
> >  struct shmem_options {
> >  	unsigned long long blocks;
> >  	unsigned long long inodes;
> > +#ifdef SHMEM_QUOTA_TMPFS
> > +	unsigned long long quota_ubh_limit;
> > +	unsigned long long quota_uih_limit;
> > +	unsigned long long quota_gbh_limit;
> > +	unsigned long long quota_gih_limit;
> > +#endif
> >  	struct mempolicy *mpol;
> >  	kuid_t uid;
> >  	kgid_t gid;
> > @@ -147,10 +157,6 @@ static unsigned long shmem_default_max_inodes(void)
> >  }
> >  #endif
> >  
> > -#if defined(CONFIG_TMPFS) && defined(CONFIG_QUOTA)
> > -#define SHMEM_QUOTA_TMPFS
> > -#endif
> > -
> >  static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
> >  			     struct folio **foliop, enum sgp_type sgp,
> >  			     gfp_t gfp, struct vm_area_struct *vma,
> > @@ -285,6 +291,54 @@ static DEFINE_MUTEX(shmem_swaplist_mutex);
> >  #define QUOTABLOCK_BITS 10
> >  #define QUOTABLOCK_SIZE (1 << QUOTABLOCK_BITS)
> >  
> > +struct kmem_cache *shmem_dquot_cachep;
> > +
> > +struct dquot *shmem_dquot_alloc(struct super_block *sb, int type)
> > +{
> > +	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
> > +	struct dquot *dquot = NULL;
> > +
> > +	dquot = kmem_cache_zalloc(shmem_dquot_cachep, GFP_NOFS);
> > +	if (!dquot)
> > +		return NULL;
> > +
> > +	if (type == USRQUOTA) {
> > +		dquot->dq_dqb.dqb_bhardlimit =
> > +			(sbinfo->quota_ubh_limit << PAGE_SHIFT);
> > +		dquot->dq_dqb.dqb_ihardlimit = sbinfo->quota_uih_limit;
> > +	} else if (type == GRPQUOTA) {
> > +		dquot->dq_dqb.dqb_bhardlimit =
> > +			(sbinfo->quota_gbh_limit << PAGE_SHIFT);
> > +		dquot->dq_dqb.dqb_ihardlimit = sbinfo->quota_gih_limit;
> > +	}
> > +	/*
> > +	 * This is a bit a of a hack to allow setting global default
> > +	 * limits on new files, by setting the limits here and preventing
> > +	 * quota from initializing everything to zero. It won't ever be
> > +	 * read from quota file because existing inodes in tmpfs are always
> > +	 * kept in memory (or swap) so we know we're getting dquot for a
> > +	 * new inode with no pre-existing dquot.
> > +	 */
> > +	set_bit(DQ_READ_B, &dquot->dq_flags);
> > +	return dquot;
> > +}
> > +
> > +static void shmem_dquot_destroy(struct dquot *dquot)
> > +{
> > +	kmem_cache_free(shmem_dquot_cachep, dquot);
> > +}
> > +
> > +const struct dquot_operations shmem_dquot_operations = {
> > +	.write_dquot	= dquot_commit,
> > +	.acquire_dquot	= dquot_acquire,
> > +	.release_dquot	= dquot_release,
> > +	.mark_dirty	= dquot_mark_dquot_dirty,
> > +	.write_info	= dquot_commit_info,
> > +	.alloc_dquot	= shmem_dquot_alloc,
> > +	.destroy_dquot	= shmem_dquot_destroy,
> > +	.get_next_id	= dquot_get_next_id,
> > +};
> > +
> >  static ssize_t shmem_quota_write_inode(struct inode *inode, int type,
> >  				       const char *data, size_t len, loff_t off)
> >  {
> > @@ -343,7 +397,7 @@ static ssize_t shmem_quota_write(struct super_block *sb, int type,
> >  	return shmem_quota_write_inode(inode, type, data, len, off);
> >  }
> >  
> > -static int shmem_enable_quotas(struct super_block *sb)
> > +static int shmem_enable_quotas(struct super_block *sb, unsigned int dquot_flags)
> >  {
> >  	int type, err = 0;
> >  	struct inode *inode;
> > @@ -389,7 +443,7 @@ static int shmem_enable_quotas(struct super_block *sb)
> >  		shmem_set_inode_flags(inode, FS_NOATIME_FL | FS_IMMUTABLE_FL);
> >  
> >  		err = dquot_load_quota_inode(inode, type, QFMT_VFS_V1,
> > -					     DQUOT_USAGE_ENABLED);
> > +					     dquot_flags);
> >  		iput(inode);
> >  		if (err)
> >  			goto out_err;
> > @@ -3720,6 +3774,10 @@ enum shmem_param {
> >  	Opt_inode32,
> >  	Opt_inode64,
> >  	Opt_quota,
> > +	Opt_quota_ubh_limit,
> > +	Opt_quota_uih_limit,
> > +	Opt_quota_gbh_limit,
> > +	Opt_quota_gih_limit,
> >  };
> >  
> >  static const struct constant_table shmem_param_enums_huge[] = {
> > @@ -3744,6 +3802,10 @@ const struct fs_parameter_spec shmem_fs_parameters[] = {
> >  	fsparam_flag  ("quota",		Opt_quota),
> >  	fsparam_flag  ("usrquota",	Opt_quota),
> >  	fsparam_flag  ("grpquota",	Opt_quota),
> > +	fsparam_string("quota_ubh_limit",	Opt_quota_ubh_limit),
> > +	fsparam_string("quota_uih_limit",	Opt_quota_uih_limit),
> > +	fsparam_string("quota_gbh_limit",	Opt_quota_gbh_limit),
> > +	fsparam_string("quota_gih_limit",	Opt_quota_gih_limit),
> >  	{}
> >  };
> >  
> > @@ -3827,13 +3889,44 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
> >  		ctx->full_inums = true;
> >  		ctx->seen |= SHMEM_SEEN_INUMS;
> >  		break;
> > -	case Opt_quota:
> >  #ifdef CONFIG_QUOTA
> > +	case Opt_quota:
> > +		ctx->seen |= SHMEM_SEEN_QUOTA;
> > +		break;
> > +	case Opt_quota_ubh_limit:
> > +		size = memparse(param->string, &rest);
> > +		if (*rest || !size)
> > +			goto bad_value;
> > +		ctx->quota_ubh_limit = DIV_ROUND_UP(size, PAGE_SIZE);
> > +		ctx->seen |=  SHMEM_SEEN_QUOTA;
> > +		break;
> > +	case Opt_quota_gbh_limit:
> > +		size = memparse(param->string, &rest);
> > +		if (*rest || !size)
> > +			goto bad_value;
> > +		ctx->quota_gbh_limit = DIV_ROUND_UP(size, PAGE_SIZE);
> > +		ctx->seen |= SHMEM_SEEN_QUOTA;
> > +		break;
> > +	case Opt_quota_uih_limit:
> > +		ctx->quota_uih_limit = memparse(param->string, &rest);
> > +		if (*rest || !ctx->quota_uih_limit)
> > +			goto bad_value;
> > +		ctx->seen |= SHMEM_SEEN_QUOTA;
> > +		break;
> > +	case Opt_quota_gih_limit:
> > +		ctx->quota_gih_limit = memparse(param->string, &rest);
> > +		if (*rest || !ctx->quota_gih_limit)
> > +			goto bad_value;
> >  		ctx->seen |= SHMEM_SEEN_QUOTA;
> > +		break;
> >  #else
> > +	case Opt_quota:
> > +	case Opt_quota_ubh_limit:
> > +	case Opt_quota_gbh_limit:
> > +	case Opt_quota_uih_limit:
> > +	case Opt_quota_gih_limit:
> >  		goto unsupported_parameter;
> >  #endif
> > -		break;
> >  	}
> >  	return 0;
> >  
> > @@ -3933,12 +4026,24 @@ static int shmem_reconfigure(struct fs_context *fc)
> >  		goto out;
> >  	}
> >  
> > +#ifdef CONFIG_QUOTA
> >  	if (ctx->seen & SHMEM_SEEN_QUOTA &&
> >  	    !sb_any_quota_loaded(fc->root->d_sb)) {
> >  		err = "Cannot enable quota on remount";
> >  		goto out;
> >  	}
> >  
> > +#define CHANGED_LIMIT(name)						\
> > +	(ctx->quota_##name##_limit &&					\
> > +	(ctx->quota_##name##_limit != sbinfo->quota_ ##name##_limit))
> > +
> > +	if (CHANGED_LIMIT(ubh) || CHANGED_LIMIT(uih) ||
> > +	    CHANGED_LIMIT(gbh) || CHANGED_LIMIT(gih)) {
> > +		err = "Cannot change global quota limit on remount";
> > +		goto out;
> > +	}
> > +#endif /* CONFIG_QUOTA */
> > +
> >  	if (ctx->seen & SHMEM_SEEN_HUGE)
> >  		sbinfo->huge = ctx->huge;
> >  	if (ctx->seen & SHMEM_SEEN_INUMS)
> > @@ -4103,11 +4208,22 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
> >  
> >  #ifdef SHMEM_QUOTA_TMPFS
> >  	if (ctx->seen & SHMEM_SEEN_QUOTA) {
> > -		sb->dq_op = &dquot_operations;
> > +		unsigned int dquot_flags;
> > +
> > +		sb->dq_op = &shmem_dquot_operations;
> >  		sb->s_qcop = &dquot_quotactl_sysfile_ops;
> >  		sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP;
> >  
> > -		if (shmem_enable_quotas(sb))
> > +		dquot_flags = DQUOT_USAGE_ENABLED;
> > +		/*
> > +		 * If any of the global quota limits are set, enable
> > +		 * quota enforcement
> > +		 */
> > +		if (ctx->quota_ubh_limit || ctx->quota_uih_limit ||
> > +		    ctx->quota_gbh_limit || ctx->quota_gih_limit)
> > +			dquot_flags |= DQUOT_LIMITS_ENABLED;
> > +
> > +		if (shmem_enable_quotas(sb, dquot_flags))
> >  			goto failed;
> >  	}
> >  #endif  /* SHMEM_QUOTA_TMPFS */
> > @@ -4121,6 +4237,17 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
> >  	if (!sb->s_root)
> >  		goto failed;
> >  
> > +#ifdef SHMEM_QUOTA_TMPFS
> > +	/*
> > +	 * Set quota hard limits after shmem_get_inode() to avoid setting
> > +	 * it for root
> > +	 */
> > +	sbinfo->quota_ubh_limit = ctx->quota_ubh_limit;
> > +	sbinfo->quota_uih_limit = ctx->quota_uih_limit;
> > +	sbinfo->quota_gbh_limit = ctx->quota_gbh_limit;
> > +	sbinfo->quota_gih_limit = ctx->quota_gih_limit;
> > +#endif  /* SHMEM_QUOTA_TMPFS */
> > +
> >  	return 0;
> >  
> >  failed:
> > @@ -4183,16 +4310,27 @@ static void shmem_init_inode(void *foo)
> >  	inode_init_once(&info->vfs_inode);
> >  }
> >  
> > -static void shmem_init_inodecache(void)
> > +static void shmem_init_mem_caches(void)
> >  {
> >  	shmem_inode_cachep = kmem_cache_create("shmem_inode_cache",
> >  				sizeof(struct shmem_inode_info),
> >  				0, SLAB_PANIC|SLAB_ACCOUNT, shmem_init_inode);
> > +
> > +#ifdef SHMEM_QUOTA_TMPFS
> > +	shmem_dquot_cachep = kmem_cache_create("shmem_dquot",
> > +				sizeof(struct dquot), sizeof(unsigned long) * 4,
> > +				(SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
> > +					SLAB_MEM_SPREAD|SLAB_PANIC),
> > +				NULL);
> > +#endif
> >  }
> >  
> > -static void shmem_destroy_inodecache(void)
> > +static void shmem_destroy_mem_caches(void)
> >  {
> >  	kmem_cache_destroy(shmem_inode_cachep);
> > +#ifdef SHMEM_QUOTA_TMPFS
> > +	kmem_cache_destroy(shmem_dquot_cachep);
> > +#endif
> >  }
> >  
> >  /* Keep the page in page cache instead of truncating it */
> > @@ -4340,7 +4478,7 @@ void __init shmem_init(void)
> >  {
> >  	int error;
> >  
> > -	shmem_init_inodecache();
> > +	shmem_init_mem_caches();
> >  
> >  	error = register_filesystem(&shmem_fs_type);
> >  	if (error) {
> > @@ -4366,7 +4504,7 @@ void __init shmem_init(void)
> >  out1:
> >  	unregister_filesystem(&shmem_fs_type);
> >  out2:
> > -	shmem_destroy_inodecache();
> > +	shmem_destroy_mem_caches();
> >  	shm_mnt = ERR_PTR(error);
> >  }
> >  
> > -- 
> > 2.38.1
> > 
> 

