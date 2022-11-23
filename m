Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FA5635788
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 10:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238056AbiKWJmP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 04:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238045AbiKWJl4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:41:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5EB2D1F7
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 01:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669196305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nfwwsc3yZi5B8fS+p3U4qSxn5EjVAmPvxjDGJOfktv0=;
        b=NcvnEeXLN7EsSWpp+Bq2I0qEkjzfnw1+jPO9RSIF+oGgQbIRIMjOPYg5cW4KqSM509yCvs
        Dg9rpfMD3YUP6zcLkCdXdGJt2HokhQRvkMBe8dqJplzOqNRZBfqtOB1QYS02E6sfaR4MEL
        FRlKgodnBKyHZoiphNBEaDN+YenWOQQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-MLBzwqj0NNKEwiDKAuPDog-1; Wed, 23 Nov 2022 04:38:22 -0500
X-MC-Unique: MLBzwqj0NNKEwiDKAuPDog-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E955C85A5A6;
        Wed, 23 Nov 2022 09:38:21 +0000 (UTC)
Received: from fedora (ovpn-193-217.brq.redhat.com [10.40.193.217])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 91EBEC1912A;
        Wed, 23 Nov 2022 09:38:20 +0000 (UTC)
Date:   Wed, 23 Nov 2022 10:38:13 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.com>,
        Eric Sandeen <sandeen@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v2 3/3] shmem: implement mount options for global quota
 limits
Message-ID: <20221123093813.d42ytx3zaoolmgpa@fedora>
References: <20221121142854.91109-1-lczerner@redhat.com>
 <20221121142854.91109-4-lczerner@redhat.com>
 <Y305HR5ZModyqtLz@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y305HR5ZModyqtLz@bfoster>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 22, 2022 at 04:03:25PM -0500, Brian Foster wrote:
> On Mon, Nov 21, 2022 at 03:28:54PM +0100, Lukas Czerner wrote:
> > Implement a set of mount options for setting glopbal quota limits on
> > tmpfs.
> > 
> > usrquota_block_hardlimit - global user quota block hard limit
> > usrquota_inode_hardlimit - global user quota inode hard limit
> > grpquota_block_hardlimit - global group quota block hard limit
> > grpquota_inode_hardlimit - global group quota inode hard limit
> > 
> > Quota limit parameters accept a suffix k, m or g for kilo, mega and giga
> > and can't be changed on remount. Default global quota limits are taking
> > effect for any and all user/group except root the first time the quota
> > entry for user/group id is being accessed - typically the first time an
> > inode with a particular id ownership is being created after the mount. In
> > other words, instead of the limits being initialized to zero, they are
> > initialized with the particular value provided with these mount options.
> > The limits can be changed for any user/group id at any time as it normally
> > can.
> > 
> > When any of the default quota limits are set, quota enforcement is enabled
> > automatically as well.
> > 
> > None of the quota related mount options can be set or changed on remount.
> > 
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > ---
> > v2: Rename mount option to something more sensible.
> >     Improve documentation.
> >     Check if the user provided limit isn't too large.
> > 
> >  Documentation/filesystems/tmpfs.rst |  36 +++++--
> >  include/linux/shmem_fs.h            |  10 ++
> >  mm/shmem.c                          | 162 ++++++++++++++++++++++++++--
> >  3 files changed, 190 insertions(+), 18 deletions(-)
> > 
> ...
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 26f2effd8f7c..a66a1e4cd0cb 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> ...
> > @@ -271,6 +273,57 @@ static DEFINE_MUTEX(shmem_swaplist_mutex);
> >  
> >  #define SHMEM_MAXQUOTAS 2
> >  
> > +int shmem_dquot_acquire(struct dquot *dquot)
> > +{
> > +	int type, ret = 0;
> > +	unsigned int memalloc;
> > +	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
> > +	struct shmem_sb_info *sbinfo = SHMEM_SB(dquot->dq_sb);
> > +
> > +
> > +	mutex_lock(&dquot->dq_lock);
> > +	memalloc = memalloc_nofs_save();
> > +	if (test_bit(DQ_READ_B, &dquot->dq_flags)) {
> > +		smp_mb__before_atomic();
> > +		set_bit(DQ_ACTIVE_B, &dquot->dq_flags);
> > +		goto out_iolock;
> > +	}
> > +
> > +	type = dquot->dq_id.type;
> > +	ret = dqopt->ops[type]->read_dqblk(dquot);
> 
> So according to patch 1, this callback would alloc the quota id and set
> DQ_FAKE_B and DQ_NO_SHRINK_B on the dquot. The shrinker will skip dquots
> that are (noshrink && !fake). So as of this point the dquot would be
> reclaimable if it were ultimately freed with no other changes, right?

Right, the flags are set in read_dqblk() of quota-mem; which is
mem_read_dquot()

> 
> > +	if (ret < 0)
> > +		goto out_iolock;
> > +	/* Set the defaults */
> > +	if (type == USRQUOTA) {
> > +		dquot->dq_dqb.dqb_bhardlimit =
> > +			(sbinfo->usrquota_block_hardlimit << PAGE_SHIFT);
> > +		dquot->dq_dqb.dqb_ihardlimit = sbinfo->usrquota_inode_hardlimit;
> > +	} else if (type == GRPQUOTA) {
> > +		dquot->dq_dqb.dqb_bhardlimit =
> > +			(sbinfo->grpquota_block_hardlimit << PAGE_SHIFT);
> > +		dquot->dq_dqb.dqb_ihardlimit = sbinfo->grpquota_inode_hardlimit;
> > +	}
> 
> Then we set default limits from the mount option on the dquot. The dquot
> is still has DQ_FAKE_B, so presumably the dquot would remain reclaimable
> (once freed) even though it has a limit set (the mount default).
> 
> AFAICS the only place that clears DQ_FAKE_B is the setquota path, so I
> take it that means the dquot becomes ultimately unreclaimable if/when
> the user sets a non-zero quota limit, and then it only becomes
> reclaimable again when quota limits are explicitly set to zero. Is that
> the case?
> 
> If so, a couple questions:
> 
> 1. Can a dquot ever be reclaimed if the user explicitly sets a quota
> limit that matches the mount default?
> 
> 2. How does enforcement of default limits actually work? For example, it
> looks like dquot_add_inodes() skips enforcement when DQ_FAKE_B is set.
> Have I missed somewhere where this flag should be cleared in this case?

Sigh, you're righ. This won't work. My test script didn't catch this,
but setting DQ_FAKE_B will make the quota infrastructure think there are
no limits and just bail out of testing them.

Better solution might be to make a custom ->set_dqblk() and set
DQ_NO_SHRINK_B only if it differs from the defaults in shmem. This would
solve your question 1. as well.

I'll think about it some more and resend.

Thanks!
-Lukas

> 
> Brian
> 
> > +	/* Make sure flags update is visible after dquot has been filled */
> > +	smp_mb__before_atomic();
> > +	set_bit(DQ_READ_B, &dquot->dq_flags);
> > +	set_bit(DQ_ACTIVE_B, &dquot->dq_flags);
> > +out_iolock:
> > +	memalloc_nofs_restore(memalloc);
> > +	mutex_unlock(&dquot->dq_lock);
> > +	return ret;
> > +}
> > +
> > +const struct dquot_operations shmem_dquot_operations = {
> > +	.write_dquot	= dquot_commit,
> > +	.acquire_dquot	= shmem_dquot_acquire,
> > +	.release_dquot	= dquot_release,
> > +	.mark_dirty	= dquot_mark_dquot_dirty,
> > +	.write_info	= dquot_commit_info,
> > +	.alloc_dquot	= dquot_alloc,
> > +	.destroy_dquot	= dquot_destroy,
> > +	.get_next_id	= dquot_get_next_id,
> > +};
> > +
> >  /*
> >   * We don't have any quota files to read, or write to/from, but quota code
> >   * requires .quota_read and .quota_write to exist.
> > @@ -288,14 +341,14 @@ static ssize_t shmem_quota_read(struct super_block *sb, int type, char *data,
> >  }
> >  
> >  
> > -static int shmem_enable_quotas(struct super_block *sb)
> > +static int shmem_enable_quotas(struct super_block *sb, unsigned int dquot_flags)
> >  {
> >  	int type, err = 0;
> >  
> >  	sb_dqopt(sb)->flags |= DQUOT_QUOTA_SYS_FILE | DQUOT_NOLIST_DIRTY;
> >  	for (type = 0; type < SHMEM_MAXQUOTAS; type++) {
> >  		err = dquot_load_quota_sb(sb, type, QFMT_MEM_ONLY,
> > -					  DQUOT_USAGE_ENABLED);
> > +					  dquot_flags);
> >  		if (err)
> >  			goto out_err;
> >  	}
> > @@ -3559,6 +3612,10 @@ enum shmem_param {
> >  	Opt_inode32,
> >  	Opt_inode64,
> >  	Opt_quota,
> > +	Opt_usrquota_block_hardlimit,
> > +	Opt_usrquota_inode_hardlimit,
> > +	Opt_grpquota_block_hardlimit,
> > +	Opt_grpquota_inode_hardlimit,
> >  };
> >  
> >  static const struct constant_table shmem_param_enums_huge[] = {
> > @@ -3583,6 +3640,10 @@ const struct fs_parameter_spec shmem_fs_parameters[] = {
> >  	fsparam_flag  ("quota",		Opt_quota),
> >  	fsparam_flag  ("usrquota",	Opt_quota),
> >  	fsparam_flag  ("grpquota",	Opt_quota),
> > +	fsparam_string("usrquota_block_hardlimit",	Opt_usrquota_block_hardlimit),
> > +	fsparam_string("usrquota_inode_hardlimit",	Opt_usrquota_inode_hardlimit),
> > +	fsparam_string("grpquota_block_hardlimit",	Opt_grpquota_block_hardlimit),
> > +	fsparam_string("grpquota_inode_hardlimit",	Opt_grpquota_inode_hardlimit),
> >  	{}
> >  };
> >  
> > @@ -3666,13 +3727,60 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
> >  		ctx->full_inums = true;
> >  		ctx->seen |= SHMEM_SEEN_INUMS;
> >  		break;
> > -	case Opt_quota:
> >  #ifdef CONFIG_QUOTA
> > +	case Opt_quota:
> > +		ctx->seen |= SHMEM_SEEN_QUOTA;
> > +		break;
> > +	case Opt_usrquota_block_hardlimit:
> > +		size = memparse(param->string, &rest);
> > +		if (*rest || !size)
> > +			goto bad_value;
> > +		size = DIV_ROUND_UP(size, PAGE_SIZE);
> > +		if (size > ULONG_MAX)
> > +			return invalfc(fc,
> > +				       "User quota block hardlimit too large.");
> > +		ctx->usrquota_block_hardlimit = size;
> > +		ctx->seen |=  SHMEM_SEEN_QUOTA;
> > +		break;
> > +	case Opt_grpquota_block_hardlimit:
> > +		size = memparse(param->string, &rest);
> > +		if (*rest || !size)
> > +			goto bad_value;
> > +		size = DIV_ROUND_UP(size, PAGE_SIZE);
> > +		if (size > ULONG_MAX)
> > +			return invalfc(fc,
> > +				       "Group quota block hardlimit too large.");
> > +		ctx->grpquota_block_hardlimit = size;
> > +		ctx->seen |= SHMEM_SEEN_QUOTA;
> > +		break;
> > +	case Opt_usrquota_inode_hardlimit:
> > +		size = memparse(param->string, &rest);
> > +		if (*rest || !size)
> > +			goto bad_value;
> > +		if (size > ULONG_MAX)
> > +			return invalfc(fc,
> > +				       "User quota inode hardlimit too large.");
> > +		ctx->usrquota_inode_hardlimit = size;
> > +		ctx->seen |= SHMEM_SEEN_QUOTA;
> > +		break;
> > +	case Opt_grpquota_inode_hardlimit:
> > +		size = memparse(param->string, &rest);
> > +		if (*rest || !size)
> > +			goto bad_value;
> > +		if (size > ULONG_MAX)
> > +			return invalfc(fc,
> > +				       "Group quota inode hardlimit too large.");
> > +		ctx->grpquota_inode_hardlimit = size;
> >  		ctx->seen |= SHMEM_SEEN_QUOTA;
> > +		break;
> >  #else
> > +	case Opt_quota:
> > +	case Opt_usrquota_block_hardlimit:
> > +	case Opt_grpquota_block_hardlimit:
> > +	case Opt_usrquota_inode_hardlimit:
> > +	case Opt_grpquota_inode_hardlimit:
> >  		goto unsupported_parameter;
> >  #endif
> > -		break;
> >  	}
> >  	return 0;
> >  
> > @@ -3778,6 +3886,18 @@ static int shmem_reconfigure(struct fs_context *fc)
> >  		goto out;
> >  	}
> >  
> > +#ifdef CONFIG_QUOTA
> > +#define CHANGED_LIMIT(name)						\
> > +	(ctx->name## _hardlimit &&					\
> > +	(ctx->name## _hardlimit != sbinfo->name## _hardlimit))
> > +
> > +	if (CHANGED_LIMIT(usrquota_block) || CHANGED_LIMIT(usrquota_inode) ||
> > +	    CHANGED_LIMIT(grpquota_block) || CHANGED_LIMIT(grpquota_inode)) {
> > +		err = "Cannot change global quota limit on remount";
> > +		goto out;
> > +	}
> > +#endif /* CONFIG_QUOTA */
> > +
> >  	if (ctx->seen & SHMEM_SEEN_HUGE)
> >  		sbinfo->huge = ctx->huge;
> >  	if (ctx->seen & SHMEM_SEEN_INUMS)
> > @@ -3942,11 +4062,22 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
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
> > +		if (ctx->usrquota_block_hardlimit || ctx->usrquota_inode_hardlimit ||
> > +		    ctx->grpquota_block_hardlimit || ctx->grpquota_inode_hardlimit)
> > +			dquot_flags |= DQUOT_LIMITS_ENABLED;
> > +
> > +		if (shmem_enable_quotas(sb, dquot_flags))
> >  			goto failed;
> >  	}
> >  #endif  /* SHMEM_QUOTA_TMPFS */
> > @@ -3960,6 +4091,17 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
> >  	if (!sb->s_root)
> >  		goto failed;
> >  
> > +#ifdef SHMEM_QUOTA_TMPFS
> > +	/*
> > +	 * Set quota hard limits after shmem_get_inode() to avoid setting
> > +	 * it for root
> > +	 */
> > +	sbinfo->usrquota_block_hardlimit = ctx->usrquota_block_hardlimit;
> > +	sbinfo->usrquota_inode_hardlimit = ctx->usrquota_inode_hardlimit;
> > +	sbinfo->grpquota_block_hardlimit = ctx->grpquota_block_hardlimit;
> > +	sbinfo->grpquota_inode_hardlimit = ctx->grpquota_inode_hardlimit;
> > +#endif  /* SHMEM_QUOTA_TMPFS */
> > +
> >  	return 0;
> >  
> >  failed:
> > -- 
> > 2.38.1
> > 
> > 
> 

