Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7962F738BB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 18:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjFUQkj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 12:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjFUQj7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:39:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249B926A6;
        Wed, 21 Jun 2023 09:39:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E281721B83;
        Wed, 21 Jun 2023 16:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687365571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zHga/LRrqLjZgX4k+fSqGnmtc9CGIrSD0m9LcPimypM=;
        b=N3tk2Wmc+SYFgMM+dA4h2nOXph+49ayIstST0lIXCahEpNYtSl3xTMk3pkYAOTgR3ZnkRD
        dmjnq7M4NS6UnjLneurcOi1CKR19PVDV0g9Mt8hNJZF+rD33vawGHr/yaO9PYOgVhDv9ca
        m0qWqh6ujp2kIQVJ8G/cqXq5uOWWukI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687365571;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zHga/LRrqLjZgX4k+fSqGnmtc9CGIrSD0m9LcPimypM=;
        b=i9BZXEqL9M+ivYH0wYckmckTpUwnQQhvDk7AUsopKslH6FnBDX2SbF5HDtsuNnjCGTyKIB
        auOMogOQSqCUE+DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D47D8133E6;
        Wed, 21 Jun 2023 16:39:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ljDeM8Mnk2R+RQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 21 Jun 2023 16:39:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6072AA075D; Wed, 21 Jun 2023 18:39:31 +0200 (CEST)
Date:   Wed, 21 Jun 2023 18:39:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/79] affs: switch to new ctime accessors
Message-ID: <20230621163931.2ni7bzmwiyw5swrx@quack3>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-9-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621144735.55953-9-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 21-06-23 10:45:23, Jeff Layton wrote:
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/affs/amigaffs.c |  6 +++---
>  fs/affs/inode.c    | 17 +++++++++--------
>  2 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/affs/amigaffs.c b/fs/affs/amigaffs.c
> index 29f11e10a7c7..2b508aa6707e 100644
> --- a/fs/affs/amigaffs.c
> +++ b/fs/affs/amigaffs.c
> @@ -60,7 +60,7 @@ affs_insert_hash(struct inode *dir, struct buffer_head *bh)
>  	mark_buffer_dirty_inode(dir_bh, dir);
>  	affs_brelse(dir_bh);
>  
> -	dir->i_mtime = dir->i_ctime = current_time(dir);
> +	dir->i_mtime = inode_ctime_set_current(dir);
>  	inode_inc_iversion(dir);
>  	mark_inode_dirty(dir);
>  
> @@ -114,7 +114,7 @@ affs_remove_hash(struct inode *dir, struct buffer_head *rem_bh)
>  
>  	affs_brelse(bh);
>  
> -	dir->i_mtime = dir->i_ctime = current_time(dir);
> +	dir->i_mtime = inode_ctime_set_current(dir);
>  	inode_inc_iversion(dir);
>  	mark_inode_dirty(dir);
>  
> @@ -315,7 +315,7 @@ affs_remove_header(struct dentry *dentry)
>  	else
>  		clear_nlink(inode);
>  	affs_unlock_link(inode);
> -	inode->i_ctime = current_time(inode);
> +	inode_ctime_set_current(inode);
>  	mark_inode_dirty(inode);
>  
>  done:
> diff --git a/fs/affs/inode.c b/fs/affs/inode.c
> index 27f77a52c5c8..177bac4def5e 100644
> --- a/fs/affs/inode.c
> +++ b/fs/affs/inode.c
> @@ -19,6 +19,7 @@ struct inode *affs_iget(struct super_block *sb, unsigned long ino)
>  {
>  	struct affs_sb_info	*sbi = AFFS_SB(sb);
>  	struct buffer_head	*bh;
> +	struct timespec64	ctime;
>  	struct affs_tail	*tail;
>  	struct inode		*inode;
>  	u32			 block;
> @@ -149,13 +150,13 @@ struct inode *affs_iget(struct super_block *sb, unsigned long ino)
>  		break;
>  	}
>  
> -	inode->i_mtime.tv_sec = inode->i_atime.tv_sec = inode->i_ctime.tv_sec
> -		       = (be32_to_cpu(tail->change.days) * 86400LL +
> -		         be32_to_cpu(tail->change.mins) * 60 +
> -			 be32_to_cpu(tail->change.ticks) / 50 +
> -			 AFFS_EPOCH_DELTA) +
> -			 sys_tz.tz_minuteswest * 60;
> -	inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec = inode->i_atime.tv_nsec = 0;
> +	ctime.tv_sec = (be32_to_cpu(tail->change.days) * 86400LL +
> +		        be32_to_cpu(tail->change.mins) * 60 +
> +			be32_to_cpu(tail->change.ticks) / 50 +
> +			AFFS_EPOCH_DELTA) +
> +			sys_tz.tz_minuteswest * 60;
> +	ctime.tv_nsec = 0;
> +	inode->i_atime = inode->i_mtime = inode_ctime_set(inode, ctime);
>  	affs_brelse(bh);
>  	unlock_new_inode(inode);
>  	return inode;
> @@ -314,7 +315,7 @@ affs_new_inode(struct inode *dir)
>  	inode->i_gid     = current_fsgid();
>  	inode->i_ino     = block;
>  	set_nlink(inode, 1);
> -	inode->i_mtime   = inode->i_atime = inode->i_ctime = current_time(inode);
> +	inode->i_mtime   = inode->i_atime = inode_ctime_set_current(inode);
>  	atomic_set(&AFFS_I(inode)->i_opencnt, 0);
>  	AFFS_I(inode)->i_blkcnt = 0;
>  	AFFS_I(inode)->i_lc = NULL;
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
