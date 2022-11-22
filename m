Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09156348E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 22:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiKVVEZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 16:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKVVEX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 16:04:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E7A7AF70
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Nov 2022 13:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669151002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s0ZsQbmyknkwY3QJYrr9Uvy4flNesPvCNE4UcuCtQfc=;
        b=bOvdJTueuUdbbV9/4ghtQDyzgIetXCpWbOuWGGcZwrpXinOSZ/Lmbbs48/uou2ycWxGAsF
        ZKdthToL+pnCZ65md9QnWAdT2EtMCpr1jo9VWHa8NvfJkigFKmdkys8iADk0B8QVfHG6Af
        pqmeQixbfzxStzQOe5r6NiAndzORrbg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-646-dluhGYerMyeXtqqYFfuCyQ-1; Tue, 22 Nov 2022 16:03:21 -0500
X-MC-Unique: dluhGYerMyeXtqqYFfuCyQ-1
Received: by mail-qv1-f69.google.com with SMTP id g15-20020ad4510f000000b004c6ad31b146so5974830qvp.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Nov 2022 13:03:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0ZsQbmyknkwY3QJYrr9Uvy4flNesPvCNE4UcuCtQfc=;
        b=dOhLuxtiGJqq+TOifhmN3x2VxBa3cJgyHYooRurJoIbbhY0DD92nIBwvsgWTnyOu91
         6W/iiaqC97NWZUT1hLmmd0LVHuyPyxeEPtpTG+1DceKgjrxMf8xuBgPneftQ0tiV0bjX
         jug25woH9oD6HPCGN9eHjzqfqqE8uH8Vrvl4kClyHlzQJz7DhmYNgnmvWebi7VVvRDM+
         J3Oo4BTnT87XAwqrB2wcWuhWHObnn+u/OJ6qjws48tVNGIXmQ0FH7cBJcSXFgWBdW07e
         yXYGxDTKPN9KpbXR9qGP32X5RYnex6sBjIDLZ39JTMhDnHOVRGQfRWcAg45A+vQwuDnN
         vJ+w==
X-Gm-Message-State: ANoB5pnBiaQHkkb11Gxzq0Bdt/4yhxi7VZqO6ENyVIsMSazXY5KnpjC/
        EStZp7xCDe6vInA3YwcNxU0EAOrUUgWDPhox8wrFR/F/jF101kT27coMO3e5V9R4SZYFmz37z9e
        NLqt6bNNfPj9yz8DFxO9sZqIdrA==
X-Received: by 2002:ac8:4d46:0:b0:3a5:278d:d95e with SMTP id x6-20020ac84d46000000b003a5278dd95emr23575254qtv.125.1669150999902;
        Tue, 22 Nov 2022 13:03:19 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4KuCGUPhnzF8BMd3gWbu9lBzFumWYcp39G1rZjGJFwFJJolLpBtRk/qRKtWkFsukznNOKxmQ==
X-Received: by 2002:ac8:4d46:0:b0:3a5:278d:d95e with SMTP id x6-20020ac84d46000000b003a5278dd95emr23575233qtv.125.1669150999595;
        Tue, 22 Nov 2022 13:03:19 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id i5-20020a05620a404500b006fb11eee465sm10915312qko.64.2022.11.22.13.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 13:03:19 -0800 (PST)
Date:   Tue, 22 Nov 2022 16:03:25 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.com>,
        Eric Sandeen <sandeen@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v2 3/3] shmem: implement mount options for global quota
 limits
Message-ID: <Y305HR5ZModyqtLz@bfoster>
References: <20221121142854.91109-1-lczerner@redhat.com>
 <20221121142854.91109-4-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121142854.91109-4-lczerner@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 21, 2022 at 03:28:54PM +0100, Lukas Czerner wrote:
> Implement a set of mount options for setting glopbal quota limits on
> tmpfs.
> 
> usrquota_block_hardlimit - global user quota block hard limit
> usrquota_inode_hardlimit - global user quota inode hard limit
> grpquota_block_hardlimit - global group quota block hard limit
> grpquota_inode_hardlimit - global group quota inode hard limit
> 
> Quota limit parameters accept a suffix k, m or g for kilo, mega and giga
> and can't be changed on remount. Default global quota limits are taking
> effect for any and all user/group except root the first time the quota
> entry for user/group id is being accessed - typically the first time an
> inode with a particular id ownership is being created after the mount. In
> other words, instead of the limits being initialized to zero, they are
> initialized with the particular value provided with these mount options.
> The limits can be changed for any user/group id at any time as it normally
> can.
> 
> When any of the default quota limits are set, quota enforcement is enabled
> automatically as well.
> 
> None of the quota related mount options can be set or changed on remount.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> ---
> v2: Rename mount option to something more sensible.
>     Improve documentation.
>     Check if the user provided limit isn't too large.
> 
>  Documentation/filesystems/tmpfs.rst |  36 +++++--
>  include/linux/shmem_fs.h            |  10 ++
>  mm/shmem.c                          | 162 ++++++++++++++++++++++++++--
>  3 files changed, 190 insertions(+), 18 deletions(-)
> 
...
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 26f2effd8f7c..a66a1e4cd0cb 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
...
> @@ -271,6 +273,57 @@ static DEFINE_MUTEX(shmem_swaplist_mutex);
>  
>  #define SHMEM_MAXQUOTAS 2
>  
> +int shmem_dquot_acquire(struct dquot *dquot)
> +{
> +	int type, ret = 0;
> +	unsigned int memalloc;
> +	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
> +	struct shmem_sb_info *sbinfo = SHMEM_SB(dquot->dq_sb);
> +
> +
> +	mutex_lock(&dquot->dq_lock);
> +	memalloc = memalloc_nofs_save();
> +	if (test_bit(DQ_READ_B, &dquot->dq_flags)) {
> +		smp_mb__before_atomic();
> +		set_bit(DQ_ACTIVE_B, &dquot->dq_flags);
> +		goto out_iolock;
> +	}
> +
> +	type = dquot->dq_id.type;
> +	ret = dqopt->ops[type]->read_dqblk(dquot);

So according to patch 1, this callback would alloc the quota id and set
DQ_FAKE_B and DQ_NO_SHRINK_B on the dquot. The shrinker will skip dquots
that are (noshrink && !fake). So as of this point the dquot would be
reclaimable if it were ultimately freed with no other changes, right?

> +	if (ret < 0)
> +		goto out_iolock;
> +	/* Set the defaults */
> +	if (type == USRQUOTA) {
> +		dquot->dq_dqb.dqb_bhardlimit =
> +			(sbinfo->usrquota_block_hardlimit << PAGE_SHIFT);
> +		dquot->dq_dqb.dqb_ihardlimit = sbinfo->usrquota_inode_hardlimit;
> +	} else if (type == GRPQUOTA) {
> +		dquot->dq_dqb.dqb_bhardlimit =
> +			(sbinfo->grpquota_block_hardlimit << PAGE_SHIFT);
> +		dquot->dq_dqb.dqb_ihardlimit = sbinfo->grpquota_inode_hardlimit;
> +	}

Then we set default limits from the mount option on the dquot. The dquot
is still has DQ_FAKE_B, so presumably the dquot would remain reclaimable
(once freed) even though it has a limit set (the mount default).

AFAICS the only place that clears DQ_FAKE_B is the setquota path, so I
take it that means the dquot becomes ultimately unreclaimable if/when
the user sets a non-zero quota limit, and then it only becomes
reclaimable again when quota limits are explicitly set to zero. Is that
the case?

If so, a couple questions:

1. Can a dquot ever be reclaimed if the user explicitly sets a quota
limit that matches the mount default?

2. How does enforcement of default limits actually work? For example, it
looks like dquot_add_inodes() skips enforcement when DQ_FAKE_B is set.
Have I missed somewhere where this flag should be cleared in this case?

Brian

> +	/* Make sure flags update is visible after dquot has been filled */
> +	smp_mb__before_atomic();
> +	set_bit(DQ_READ_B, &dquot->dq_flags);
> +	set_bit(DQ_ACTIVE_B, &dquot->dq_flags);
> +out_iolock:
> +	memalloc_nofs_restore(memalloc);
> +	mutex_unlock(&dquot->dq_lock);
> +	return ret;
> +}
> +
> +const struct dquot_operations shmem_dquot_operations = {
> +	.write_dquot	= dquot_commit,
> +	.acquire_dquot	= shmem_dquot_acquire,
> +	.release_dquot	= dquot_release,
> +	.mark_dirty	= dquot_mark_dquot_dirty,
> +	.write_info	= dquot_commit_info,
> +	.alloc_dquot	= dquot_alloc,
> +	.destroy_dquot	= dquot_destroy,
> +	.get_next_id	= dquot_get_next_id,
> +};
> +
>  /*
>   * We don't have any quota files to read, or write to/from, but quota code
>   * requires .quota_read and .quota_write to exist.
> @@ -288,14 +341,14 @@ static ssize_t shmem_quota_read(struct super_block *sb, int type, char *data,
>  }
>  
>  
> -static int shmem_enable_quotas(struct super_block *sb)
> +static int shmem_enable_quotas(struct super_block *sb, unsigned int dquot_flags)
>  {
>  	int type, err = 0;
>  
>  	sb_dqopt(sb)->flags |= DQUOT_QUOTA_SYS_FILE | DQUOT_NOLIST_DIRTY;
>  	for (type = 0; type < SHMEM_MAXQUOTAS; type++) {
>  		err = dquot_load_quota_sb(sb, type, QFMT_MEM_ONLY,
> -					  DQUOT_USAGE_ENABLED);
> +					  dquot_flags);
>  		if (err)
>  			goto out_err;
>  	}
> @@ -3559,6 +3612,10 @@ enum shmem_param {
>  	Opt_inode32,
>  	Opt_inode64,
>  	Opt_quota,
> +	Opt_usrquota_block_hardlimit,
> +	Opt_usrquota_inode_hardlimit,
> +	Opt_grpquota_block_hardlimit,
> +	Opt_grpquota_inode_hardlimit,
>  };
>  
>  static const struct constant_table shmem_param_enums_huge[] = {
> @@ -3583,6 +3640,10 @@ const struct fs_parameter_spec shmem_fs_parameters[] = {
>  	fsparam_flag  ("quota",		Opt_quota),
>  	fsparam_flag  ("usrquota",	Opt_quota),
>  	fsparam_flag  ("grpquota",	Opt_quota),
> +	fsparam_string("usrquota_block_hardlimit",	Opt_usrquota_block_hardlimit),
> +	fsparam_string("usrquota_inode_hardlimit",	Opt_usrquota_inode_hardlimit),
> +	fsparam_string("grpquota_block_hardlimit",	Opt_grpquota_block_hardlimit),
> +	fsparam_string("grpquota_inode_hardlimit",	Opt_grpquota_inode_hardlimit),
>  	{}
>  };
>  
> @@ -3666,13 +3727,60 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
>  		ctx->full_inums = true;
>  		ctx->seen |= SHMEM_SEEN_INUMS;
>  		break;
> -	case Opt_quota:
>  #ifdef CONFIG_QUOTA
> +	case Opt_quota:
> +		ctx->seen |= SHMEM_SEEN_QUOTA;
> +		break;
> +	case Opt_usrquota_block_hardlimit:
> +		size = memparse(param->string, &rest);
> +		if (*rest || !size)
> +			goto bad_value;
> +		size = DIV_ROUND_UP(size, PAGE_SIZE);
> +		if (size > ULONG_MAX)
> +			return invalfc(fc,
> +				       "User quota block hardlimit too large.");
> +		ctx->usrquota_block_hardlimit = size;
> +		ctx->seen |=  SHMEM_SEEN_QUOTA;
> +		break;
> +	case Opt_grpquota_block_hardlimit:
> +		size = memparse(param->string, &rest);
> +		if (*rest || !size)
> +			goto bad_value;
> +		size = DIV_ROUND_UP(size, PAGE_SIZE);
> +		if (size > ULONG_MAX)
> +			return invalfc(fc,
> +				       "Group quota block hardlimit too large.");
> +		ctx->grpquota_block_hardlimit = size;
> +		ctx->seen |= SHMEM_SEEN_QUOTA;
> +		break;
> +	case Opt_usrquota_inode_hardlimit:
> +		size = memparse(param->string, &rest);
> +		if (*rest || !size)
> +			goto bad_value;
> +		if (size > ULONG_MAX)
> +			return invalfc(fc,
> +				       "User quota inode hardlimit too large.");
> +		ctx->usrquota_inode_hardlimit = size;
> +		ctx->seen |= SHMEM_SEEN_QUOTA;
> +		break;
> +	case Opt_grpquota_inode_hardlimit:
> +		size = memparse(param->string, &rest);
> +		if (*rest || !size)
> +			goto bad_value;
> +		if (size > ULONG_MAX)
> +			return invalfc(fc,
> +				       "Group quota inode hardlimit too large.");
> +		ctx->grpquota_inode_hardlimit = size;
>  		ctx->seen |= SHMEM_SEEN_QUOTA;
> +		break;
>  #else
> +	case Opt_quota:
> +	case Opt_usrquota_block_hardlimit:
> +	case Opt_grpquota_block_hardlimit:
> +	case Opt_usrquota_inode_hardlimit:
> +	case Opt_grpquota_inode_hardlimit:
>  		goto unsupported_parameter;
>  #endif
> -		break;
>  	}
>  	return 0;
>  
> @@ -3778,6 +3886,18 @@ static int shmem_reconfigure(struct fs_context *fc)
>  		goto out;
>  	}
>  
> +#ifdef CONFIG_QUOTA
> +#define CHANGED_LIMIT(name)						\
> +	(ctx->name## _hardlimit &&					\
> +	(ctx->name## _hardlimit != sbinfo->name## _hardlimit))
> +
> +	if (CHANGED_LIMIT(usrquota_block) || CHANGED_LIMIT(usrquota_inode) ||
> +	    CHANGED_LIMIT(grpquota_block) || CHANGED_LIMIT(grpquota_inode)) {
> +		err = "Cannot change global quota limit on remount";
> +		goto out;
> +	}
> +#endif /* CONFIG_QUOTA */
> +
>  	if (ctx->seen & SHMEM_SEEN_HUGE)
>  		sbinfo->huge = ctx->huge;
>  	if (ctx->seen & SHMEM_SEEN_INUMS)
> @@ -3942,11 +4062,22 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  #ifdef SHMEM_QUOTA_TMPFS
>  	if (ctx->seen & SHMEM_SEEN_QUOTA) {
> -		sb->dq_op = &dquot_operations;
> +		unsigned int dquot_flags;
> +
> +		sb->dq_op = &shmem_dquot_operations;
>  		sb->s_qcop = &dquot_quotactl_sysfile_ops;
>  		sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP;
>  
> -		if (shmem_enable_quotas(sb))
> +		dquot_flags = DQUOT_USAGE_ENABLED;
> +		/*
> +		 * If any of the global quota limits are set, enable
> +		 * quota enforcement
> +		 */
> +		if (ctx->usrquota_block_hardlimit || ctx->usrquota_inode_hardlimit ||
> +		    ctx->grpquota_block_hardlimit || ctx->grpquota_inode_hardlimit)
> +			dquot_flags |= DQUOT_LIMITS_ENABLED;
> +
> +		if (shmem_enable_quotas(sb, dquot_flags))
>  			goto failed;
>  	}
>  #endif  /* SHMEM_QUOTA_TMPFS */
> @@ -3960,6 +4091,17 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
>  	if (!sb->s_root)
>  		goto failed;
>  
> +#ifdef SHMEM_QUOTA_TMPFS
> +	/*
> +	 * Set quota hard limits after shmem_get_inode() to avoid setting
> +	 * it for root
> +	 */
> +	sbinfo->usrquota_block_hardlimit = ctx->usrquota_block_hardlimit;
> +	sbinfo->usrquota_inode_hardlimit = ctx->usrquota_inode_hardlimit;
> +	sbinfo->grpquota_block_hardlimit = ctx->grpquota_block_hardlimit;
> +	sbinfo->grpquota_inode_hardlimit = ctx->grpquota_inode_hardlimit;
> +#endif  /* SHMEM_QUOTA_TMPFS */
> +
>  	return 0;
>  
>  failed:
> -- 
> 2.38.1
> 
> 

