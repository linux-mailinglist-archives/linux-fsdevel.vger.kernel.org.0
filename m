Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776275A4FAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 16:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiH2Ov1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 10:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiH2OvZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:51:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DBB90839;
        Mon, 29 Aug 2022 07:51:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E7FD61F86C;
        Mon, 29 Aug 2022 14:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661784680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5LCtrszBdV+NVGN5QwWvJ7u/iDQSPpMJ9iYqsp0NIIM=;
        b=kDcD6vT81/U/Nuy1vB7RO9gscm9E7n+BbQjAish8tsMUyVGlai7OrnJZ7WUObk5E+ozoVv
        Ba1REghpocBzmAbvNvM+W8ax1J18VlvtsrvcCEhRrJCnB6a2yR+5ebzLNhh9k9PHwpwxYl
        gN5db5Ew89HF9SdoRCC682W4Z446pzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661784680;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5LCtrszBdV+NVGN5QwWvJ7u/iDQSPpMJ9iYqsp0NIIM=;
        b=Kga3/jsqDzRe01fFnuANlNYwO2dlgn4LX3Mkbmi7wXgFNT8F9EzlcAqAiAe9aBCpUwkwKr
        YxAIovn60f0xnRDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A4D33133A6;
        Mon, 29 Aug 2022 14:51:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4acyKGjSDGMQdwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 29 Aug 2022 14:51:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EA3A0A066D; Mon, 29 Aug 2022 16:51:19 +0200 (CEST)
Date:   Mon, 29 Aug 2022 16:51:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        brauner@kernel.org, linux-api@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ceph@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        Benjamin Coddington <bcodding@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 3/7] ext4: unconditionally enable the i_version counter
Message-ID: <20220829145119.wopmm2q6dldtfeqi@quack3>
References: <20220826214703.134870-1-jlayton@kernel.org>
 <20220826214703.134870-4-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826214703.134870-4-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 26-08-22 17:46:59, Jeff Layton wrote:
> The original i_version implementation was pretty expensive, requiring a
> log flush on every change. Because of this, it was gated behind a mount
> option (implemented via the MS_I_VERSION mountoption flag).

I don't think "log flush on every change" was really required. But "logging
an inode on every change" was required and even that can get expensive.

> Commit ae5e165d855d (fs: new API for handling inode->i_version) made the
> i_version flag much less expensive, so there is no longer a performance
> penalty from enabling it. xfs and btrfs already enable it
> unconditionally when the on-disk format can support it.
> 
> Have ext4 ignore the SB_I_VERSION flag, and just enable it
> unconditionally. While we're in here, remove the handling of
> Opt_i_version as well since it's due for deprecation anyway.
> 
> Ideally, we'd couple this change with a way to disable the i_version
> counter (just in case), but the way the iversion mount option was
> implemented makes that difficult to do. We'd need to add a new mount
> option altogether or do something with tune2fs. That's probably best
> left to later patches if it turns out to be needed.
> 
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Lukas Czerner <lczerner@redhat.com>
> Cc: Benjamin Coddington <bcodding@redhat.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Otherwise the change looks good to me so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c       |  2 +-
>  fs/ext4/ioctl.c       | 12 ++++--------
>  fs/ext4/move_extent.c |  6 ++----
>  fs/ext4/super.c       | 13 ++++---------
>  fs/ext4/xattr.c       |  3 +--
>  5 files changed, 12 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index aa37bce4c541..6ef37269e7c0 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5342,7 +5342,7 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>  	int error, rc = 0;
>  	int orphan = 0;
>  	const unsigned int ia_valid = attr->ia_valid;
> -	bool inc_ivers = IS_I_VERSION(inode);
> +	bool inc_ivers = true;
>  
>  	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
>  		return -EIO;
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 60e77ae9342d..ad3a294a88eb 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -452,8 +452,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
>  	swap_inode_data(inode, inode_bl);
>  
>  	inode->i_ctime = inode_bl->i_ctime = current_time(inode);
> -	if (IS_I_VERSION(inode))
> -		inode_inc_iversion(inode);
> +	inode_inc_iversion(inode);
>  
>  	inode->i_generation = prandom_u32();
>  	inode_bl->i_generation = prandom_u32();
> @@ -667,8 +666,7 @@ static int ext4_ioctl_setflags(struct inode *inode,
>  	ext4_set_inode_flags(inode, false);
>  
>  	inode->i_ctime = current_time(inode);
> -	if (IS_I_VERSION(inode))
> -		inode_inc_iversion(inode);
> +	inode_inc_iversion(inode);
>  
>  	err = ext4_mark_iloc_dirty(handle, inode, &iloc);
>  flags_err:
> @@ -779,8 +777,7 @@ static int ext4_ioctl_setproject(struct inode *inode, __u32 projid)
>  
>  	EXT4_I(inode)->i_projid = kprojid;
>  	inode->i_ctime = current_time(inode);
> -	if (IS_I_VERSION(inode))
> -		inode_inc_iversion(inode);
> +	inode_inc_iversion(inode);
>  out_dirty:
>  	rc = ext4_mark_iloc_dirty(handle, inode, &iloc);
>  	if (!err)
> @@ -1263,8 +1260,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		err = ext4_reserve_inode_write(handle, inode, &iloc);
>  		if (err == 0) {
>  			inode->i_ctime = current_time(inode);
> -			if (IS_I_VERSION(inode))
> -				inode_inc_iversion(inode);
> +			inode_inc_iversion(inode);
>  			inode->i_generation = generation;
>  			err = ext4_mark_iloc_dirty(handle, inode, &iloc);
>  		}
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index d73ab3153218..285700b00d38 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -687,10 +687,8 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
>  
>  		orig_inode->i_ctime = current_time(orig_inode);
>  		donor_inode->i_ctime = current_time(donor_inode);
> -		if (IS_I_VERSION(orig_inode))
> -			inode_inc_iversion(orig_inode);
> -		if (IS_I_VERSION(donor_inode))
> -			inode_inc_iversion(donor_inode);
> +		inode_inc_iversion(orig_inode);
> +		inode_inc_iversion(donor_inode);
>  	}
>  	*moved_len = o_start - orig_blk;
>  	if (*moved_len > len)
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 9a66abcca1a8..e7cf5361245a 100644
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
> @@ -2970,8 +2964,6 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
>  		SEQ_OPTS_PRINT("min_batch_time=%u", sbi->s_min_batch_time);
>  	if (nodefs || sbi->s_max_batch_time != EXT4_DEF_MAX_BATCH_TIME)
>  		SEQ_OPTS_PRINT("max_batch_time=%u", sbi->s_max_batch_time);
> -	if (sb->s_flags & SB_I_VERSION)
> -		SEQ_OPTS_PUTS("i_version");
>  	if (nodefs || sbi->s_stripe)
>  		SEQ_OPTS_PRINT("stripe=%lu", sbi->s_stripe);
>  	if (nodefs || EXT4_MOUNT_DATA_FLAGS &
> @@ -4640,6 +4632,9 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
>  		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
>  
> +	/* i_version is always enabled now */
> +	sb->s_flags |= SB_I_VERSION;
> +
>  	if (le32_to_cpu(es->s_rev_level) == EXT4_GOOD_OLD_REV &&
>  	    (ext4_has_compat_features(sb) ||
>  	     ext4_has_ro_compat_features(sb) ||
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index e975442e4ab2..36d6ba7190b6 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -2412,8 +2412,7 @@ ext4_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
>  	if (!error) {
>  		ext4_xattr_update_super_block(handle, inode->i_sb);
>  		inode->i_ctime = current_time(inode);
> -		if (IS_I_VERSION(inode))
> -			inode_inc_iversion(inode);
> +		inode_inc_iversion(inode);
>  		if (!value)
>  			no_expand = 0;
>  		error = ext4_mark_iloc_dirty(handle, inode, &is.iloc);
> -- 
> 2.37.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
