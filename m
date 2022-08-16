Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7DB595B2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 14:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbiHPMDS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 08:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbiHPMCd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:02:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0896EA193;
        Tue, 16 Aug 2022 04:48:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 529CB1FB19;
        Tue, 16 Aug 2022 11:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660650530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x7XuRpg70onHzHH/0NLoStyQXuVqqKuPGgEtAMsKHFs=;
        b=tWZ7WrwqUHQB2HFNIMAaXTECyVyERJVKPwMyBqltazhM7AGOCZZMqkmvqIYpzhxaqww028
        YK+NbZN1Ik9Rjj20Tm25mTS9VP21yv+ZkZE7Vp8rAdM3+zGBw62k3T9XojT4+dFMpHQdpC
        bR+nzR2e34AiJU60wflcmvDKLvqB7EQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660650530;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x7XuRpg70onHzHH/0NLoStyQXuVqqKuPGgEtAMsKHFs=;
        b=BBPJdJH0Ii8WJ2Mb/2dM5aKY8ipM79++KkpZvxb3vRadSuo9lxcZ+7tC3Fc4KbgsEBJYnV
        HVCwpqA6sRvp6mAw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2991B2C149;
        Tue, 16 Aug 2022 11:48:50 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 86D75A066C; Tue, 16 Aug 2022 13:48:49 +0200 (CEST)
Date:   Tue, 16 Aug 2022 13:48:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jlayton@kernel.org,
        jack@suse.cz, linux-fsdevel@vger.kernel.org, ebiggers@kernel.org,
        david@fromorbit.com, Benjamin Coddington <bcodding@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v4 3/3] ext4: unconditionally enable the i_version counter
Message-ID: <20220816114849.ichamnx53yxahvhy@quack3>
References: <20220812123727.46397-1-lczerner@redhat.com>
 <20220812123727.46397-3-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812123727.46397-3-lczerner@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 12-08-22 14:37:27, Lukas Czerner wrote:
> From: Jeff Layton <jlayton@kernel.org>
> 
> The original i_version implementation was pretty expensive, requiring a
> log flush on every change. Because of this, it was gated behind a mount
> option (implemented via the MS_I_VERSION mountoption flag).
> 
> Commit ae5e165d855d (fs: new API for handling inode->i_version) made the
> i_version flag much less expensive, so there is no longer a performance
> penalty from enabling it. xfs and btrfs already enable it
> unconditionally when the on-disk format can support it.
> 
> Have ext4 ignore the SB_I_VERSION flag, and just enable it
> unconditionally. While we're in here, remove the handling of
> Opt_i_version as well, since we're almost to 5.20 anyway.
> 
> Ideally, we'd couple this change with a way to disable the i_version
> counter (just in case), but the way the iversion mount option was
> implemented makes that difficult to do. We'd need to add a new mount
> option altogether or do something with tune2fs. That's probably best
> left to later patches if it turns out to be needed.
> 
> [ Removed leftover bits of i_version from ext4_apply_options() since it
> now can't ever be set in ctx->mask_s_flags -- lczerner ]
> 
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Benjamin Coddington <bcodding@redhat.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v3: Removed leftover bits of i_version from ext4_apply_options
> v4: no change
> 
>  fs/ext4/inode.c |  5 ++---
>  fs/ext4/super.c | 21 ++++-----------------
>  2 files changed, 6 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 2a220be34caa..c77d40f05763 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5425,7 +5425,7 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>  			return -EINVAL;
>  		}
>  
> -		if (IS_I_VERSION(inode) && attr->ia_size != inode->i_size)
> +		if (attr->ia_size != inode->i_size)
>  			inode_inc_iversion(inode);
>  
>  		if (shrink) {
> @@ -5735,8 +5735,7 @@ int ext4_mark_iloc_dirty(handle_t *handle,
>  	 * ea_inodes are using i_version for storing reference count, don't
>  	 * mess with it
>  	 */
> -	if (IS_I_VERSION(inode) &&
> -	    !(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
> +	if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
>  		inode_inc_iversion(inode);
>  
>  	/* the do_update_inode consumes one bh->b_count */
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 9a66abcca1a8..1c953f6d400e 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1585,7 +1585,7 @@ enum {
>  	Opt_inlinecrypt,
>  	Opt_usrjquota, Opt_grpjquota, Opt_quota,
>  	Opt_noquota, Opt_barrier, Opt_nobarrier, Opt_err,
> -	Opt_usrquota, Opt_grpquota, Opt_prjquota, Opt_i_version,
> +	Opt_usrquota, Opt_grpquota, Opt_prjquota,
>  	Opt_dax, Opt_dax_always, Opt_dax_inode, Opt_dax_never,
>  	Opt_stripe, Opt_delalloc, Opt_nodelalloc, Opt_warn_on_error,
>  	Opt_nowarn_on_error, Opt_mblk_io_submit, Opt_debug_want_extra_isize,
> @@ -1694,7 +1694,6 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
>  	fsparam_flag	("barrier",		Opt_barrier),
>  	fsparam_u32	("barrier",		Opt_barrier),
>  	fsparam_flag	("nobarrier",		Opt_nobarrier),
> -	fsparam_flag	("i_version",		Opt_i_version),
>  	fsparam_flag	("dax",			Opt_dax),
>  	fsparam_enum	("dax",			Opt_dax_type, ext4_param_dax),
>  	fsparam_u32	("stripe",		Opt_stripe),
> @@ -2140,11 +2139,6 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  	case Opt_abort:
>  		ctx_set_mount_flag(ctx, EXT4_MF_FS_ABORTED);
>  		return 0;
> -	case Opt_i_version:
> -		ext4_msg(NULL, KERN_WARNING, deprecated_msg, param->key, "5.20");
> -		ext4_msg(NULL, KERN_WARNING, "Use iversion instead\n");
> -		ctx_set_flags(ctx, SB_I_VERSION);
> -		return 0;
>  	case Opt_inlinecrypt:
>  #ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
>  		ctx_set_flags(ctx, SB_INLINECRYPT);
> @@ -2814,14 +2808,6 @@ static void ext4_apply_options(struct fs_context *fc, struct super_block *sb)
>  	sb->s_flags &= ~ctx->mask_s_flags;
>  	sb->s_flags |= ctx->vals_s_flags;
>  
> -	/*
> -	 * i_version differs from common mount option iversion so we have
> -	 * to let vfs know that it was set, otherwise it would get cleared
> -	 * on remount
> -	 */
> -	if (ctx->mask_s_flags & SB_I_VERSION)
> -		fc->sb_flags |= SB_I_VERSION;
> -
>  #define APPLY(X) ({ if (ctx->spec & EXT4_SPEC_##X) sbi->X = ctx->X; })
>  	APPLY(s_commit_interval);
>  	APPLY(s_stripe);
> @@ -2970,8 +2956,6 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
>  		SEQ_OPTS_PRINT("min_batch_time=%u", sbi->s_min_batch_time);
>  	if (nodefs || sbi->s_max_batch_time != EXT4_DEF_MAX_BATCH_TIME)
>  		SEQ_OPTS_PRINT("max_batch_time=%u", sbi->s_max_batch_time);
> -	if (sb->s_flags & SB_I_VERSION)
> -		SEQ_OPTS_PUTS("i_version");
>  	if (nodefs || sbi->s_stripe)
>  		SEQ_OPTS_PRINT("stripe=%lu", sbi->s_stripe);
>  	if (nodefs || EXT4_MOUNT_DATA_FLAGS &
> @@ -4640,6 +4624,9 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
>  		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
>  
> +	/* i_version is always enabled now */
> +	sb->s_flags |= SB_I_VERSION;
> +
>  	if (le32_to_cpu(es->s_rev_level) == EXT4_GOOD_OLD_REV &&
>  	    (ext4_has_compat_features(sb) ||
>  	     ext4_has_ro_compat_features(sb) ||
> -- 
> 2.37.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
