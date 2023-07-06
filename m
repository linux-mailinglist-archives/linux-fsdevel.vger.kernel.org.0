Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DFB749A7E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 13:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjGFLUe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 07:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjGFLUd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:20:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BBE171D;
        Thu,  6 Jul 2023 04:20:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0C9101FF02;
        Thu,  6 Jul 2023 11:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688642431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MdreY2UcENZj/GS0VKcCp5q5UdGRlxxJIxjArPM0WoY=;
        b=yMD3YuH/igP47Bt6uxftwQzGhKxUQRugUwshN7UrunkPZK4hk8DoETNNn3FhIImQiLrL50
        YrM5SuKZZz6WZwEePxQOEs6xiSwOf43av8d2uY6vD6F+CYAVa1TBhyCxDmLZiS+Z8diFCi
        ljfItpMRr3QdLKpogH2vtua1TKa72Eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688642431;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MdreY2UcENZj/GS0VKcCp5q5UdGRlxxJIxjArPM0WoY=;
        b=HtO+uIVXmhpM/cCZyH3Ruet+pJsWeQJvC9+FRSxkZXeHC1QMe5KpcTIvzldKZh/ZKCLGMF
        IwvGpkGKu5cIxxCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1A16138EE;
        Thu,  6 Jul 2023 11:20:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BpoiN36jpmRIEwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 11:20:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2B156A0707; Thu,  6 Jul 2023 13:20:30 +0200 (CEST)
Date:   Thu, 6 Jul 2023 13:20:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 46/92] fuse: convert to ctime accessor functions
Message-ID: <20230706112030.of4nqx5vfxg7tiud@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-44-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-44-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:11, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fuse/control.c |  2 +-
>  fs/fuse/dir.c     |  8 ++++----
>  fs/fuse/inode.c   | 16 ++++++++--------
>  3 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> index 247ef4f76761..ab62e4624256 100644
> --- a/fs/fuse/control.c
> +++ b/fs/fuse/control.c
> @@ -235,7 +235,7 @@ static struct dentry *fuse_ctl_add_dentry(struct dentry *parent,
>  	inode->i_mode = mode;
>  	inode->i_uid = fc->user_id;
>  	inode->i_gid = fc->group_id;
> -	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> +	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
>  	/* setting ->i_op to NULL is not allowed */
>  	if (iop)
>  		inode->i_op = iop;
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index f67bef9d83c4..672245ee0394 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -933,7 +933,7 @@ void fuse_flush_time_update(struct inode *inode)
>  static void fuse_update_ctime_in_cache(struct inode *inode)
>  {
>  	if (!IS_NOCMTIME(inode)) {
> -		inode->i_ctime = current_time(inode);
> +		inode_set_ctime_current(inode);
>  		mark_inode_dirty_sync(inode);
>  		fuse_flush_time_update(inode);
>  	}
> @@ -1715,8 +1715,8 @@ int fuse_flush_times(struct inode *inode, struct fuse_file *ff)
>  	inarg.mtimensec = inode->i_mtime.tv_nsec;
>  	if (fm->fc->minor >= 23) {
>  		inarg.valid |= FATTR_CTIME;
> -		inarg.ctime = inode->i_ctime.tv_sec;
> -		inarg.ctimensec = inode->i_ctime.tv_nsec;
> +		inarg.ctime = inode_get_ctime(inode).tv_sec;
> +		inarg.ctimensec = inode_get_ctime(inode).tv_nsec;
>  	}
>  	if (ff) {
>  		inarg.valid |= FATTR_FH;
> @@ -1857,7 +1857,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
>  		if (attr->ia_valid & ATTR_MTIME)
>  			inode->i_mtime = attr->ia_mtime;
>  		if (attr->ia_valid & ATTR_CTIME)
> -			inode->i_ctime = attr->ia_ctime;
> +			inode_set_ctime_to_ts(inode, attr->ia_ctime);
>  		/* FIXME: clear I_DIRTY_SYNC? */
>  	}
>  
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index f19d748890f0..549358ffea8b 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -194,8 +194,7 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
>  		inode->i_mtime.tv_nsec  = attr->mtimensec;
>  	}
>  	if (!(cache_mask & STATX_CTIME)) {
> -		inode->i_ctime.tv_sec   = attr->ctime;
> -		inode->i_ctime.tv_nsec  = attr->ctimensec;
> +		inode_set_ctime(inode, attr->ctime, attr->ctimensec);
>  	}
>  
>  	if (attr->blksize != 0)
> @@ -259,8 +258,8 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
>  		attr->mtimensec = inode->i_mtime.tv_nsec;
>  	}
>  	if (cache_mask & STATX_CTIME) {
> -		attr->ctime = inode->i_ctime.tv_sec;
> -		attr->ctimensec = inode->i_ctime.tv_nsec;
> +		attr->ctime = inode_get_ctime(inode).tv_sec;
> +		attr->ctimensec = inode_get_ctime(inode).tv_nsec;
>  	}
>  
>  	if ((attr_version != 0 && fi->attr_version > attr_version) ||
> @@ -318,8 +317,7 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
>  	inode->i_size = attr->size;
>  	inode->i_mtime.tv_sec  = attr->mtime;
>  	inode->i_mtime.tv_nsec = attr->mtimensec;
> -	inode->i_ctime.tv_sec  = attr->ctime;
> -	inode->i_ctime.tv_nsec = attr->ctimensec;
> +	inode_set_ctime(inode, attr->ctime, attr->ctimensec);
>  	if (S_ISREG(inode->i_mode)) {
>  		fuse_init_common(inode);
>  		fuse_init_file_inode(inode, attr->flags);
> @@ -1401,16 +1399,18 @@ EXPORT_SYMBOL_GPL(fuse_dev_free);
>  static void fuse_fill_attr_from_inode(struct fuse_attr *attr,
>  				      const struct fuse_inode *fi)
>  {
> +	struct timespec64 ctime = inode_get_ctime(&fi->inode);
> +
>  	*attr = (struct fuse_attr){
>  		.ino		= fi->inode.i_ino,
>  		.size		= fi->inode.i_size,
>  		.blocks		= fi->inode.i_blocks,
>  		.atime		= fi->inode.i_atime.tv_sec,
>  		.mtime		= fi->inode.i_mtime.tv_sec,
> -		.ctime		= fi->inode.i_ctime.tv_sec,
> +		.ctime		= ctime.tv_sec,
>  		.atimensec	= fi->inode.i_atime.tv_nsec,
>  		.mtimensec	= fi->inode.i_mtime.tv_nsec,
> -		.ctimensec	= fi->inode.i_ctime.tv_nsec,
> +		.ctimensec	= ctime.tv_nsec,
>  		.mode		= fi->inode.i_mode,
>  		.nlink		= fi->inode.i_nlink,
>  		.uid		= fi->inode.i_uid.val,
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
