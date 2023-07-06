Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FE37499CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 12:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjGFKvn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 06:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjGFKva (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:51:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16681BC3;
        Thu,  6 Jul 2023 03:51:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 27A8521DB3;
        Thu,  6 Jul 2023 10:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688640684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3s3yRs5TXM/W7jLheOlVLSgcrV0rob/GkxFroIWbl04=;
        b=zC0eUjHjCPJiT1tGbSMHRWeLIu0/LotOTgqhW7lclhF2AXElBEZA+ZkvZ7RwA4nVp/qZVo
        VcjGUR+brLtdbHkIj730Y607d2+kDzIDXe/C81zmlRVW8AhuCSXVTcIzhbbGAjUNyu0QPd
        vh1Z9bf8SyjckGVXSh8VDfNW8XYaLa0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688640684;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3s3yRs5TXM/W7jLheOlVLSgcrV0rob/GkxFroIWbl04=;
        b=HC8Gsielyfb5TPM7u81rSY2hSCagliA1HCBKglK/u/uRJ59Feu3NAqBC1rinmwJMT9rykd
        61AZhlxMsbe9W9CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 09F4E138EE;
        Thu,  6 Jul 2023 10:51:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TO1hAqycpmQXAwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 10:51:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2C36AA0707; Thu,  6 Jul 2023 12:51:23 +0200 (CEST)
Date:   Thu, 6 Jul 2023 12:51:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 29/92] btrfs: convert to ctime accessor functions
Message-ID: <20230706105123.5amvnhf3x4ocfjxd@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-27-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-27-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:00:54, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/btrfs/delayed-inode.c |  8 ++++----
>  fs/btrfs/file.c          | 21 +++++++++------------
>  fs/btrfs/inode.c         | 39 ++++++++++++++++-----------------------
>  fs/btrfs/ioctl.c         |  2 +-
>  fs/btrfs/reflink.c       |  3 +--
>  fs/btrfs/transaction.c   |  3 +--
>  fs/btrfs/tree-log.c      |  4 ++--
>  fs/btrfs/xattr.c         |  4 ++--
>  8 files changed, 36 insertions(+), 48 deletions(-)
> 
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index c0a6a1784697..e2753d228037 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -1808,9 +1808,9 @@ static void fill_stack_inode_item(struct btrfs_trans_handle *trans,
>  				      inode->i_mtime.tv_nsec);
>  
>  	btrfs_set_stack_timespec_sec(&inode_item->ctime,
> -				     inode->i_ctime.tv_sec);
> +				     inode_get_ctime(inode).tv_sec);
>  	btrfs_set_stack_timespec_nsec(&inode_item->ctime,
> -				      inode->i_ctime.tv_nsec);
> +				      inode_get_ctime(inode).tv_nsec);
>  
>  	btrfs_set_stack_timespec_sec(&inode_item->otime,
>  				     BTRFS_I(inode)->i_otime.tv_sec);
> @@ -1861,8 +1861,8 @@ int btrfs_fill_inode(struct inode *inode, u32 *rdev)
>  	inode->i_mtime.tv_sec = btrfs_stack_timespec_sec(&inode_item->mtime);
>  	inode->i_mtime.tv_nsec = btrfs_stack_timespec_nsec(&inode_item->mtime);
>  
> -	inode->i_ctime.tv_sec = btrfs_stack_timespec_sec(&inode_item->ctime);
> -	inode->i_ctime.tv_nsec = btrfs_stack_timespec_nsec(&inode_item->ctime);
> +	inode_set_ctime(inode, btrfs_stack_timespec_sec(&inode_item->ctime),
> +			btrfs_stack_timespec_nsec(&inode_item->ctime));
>  
>  	BTRFS_I(inode)->i_otime.tv_sec =
>  		btrfs_stack_timespec_sec(&inode_item->otime);
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index fd03e689a6be..d7a9ece7a40b 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1108,7 +1108,7 @@ void btrfs_check_nocow_unlock(struct btrfs_inode *inode)
>  
>  static void update_time_for_write(struct inode *inode)
>  {
> -	struct timespec64 now;
> +	struct timespec64 now, ctime;
>  
>  	if (IS_NOCMTIME(inode))
>  		return;
> @@ -1117,8 +1117,9 @@ static void update_time_for_write(struct inode *inode)
>  	if (!timespec64_equal(&inode->i_mtime, &now))
>  		inode->i_mtime = now;
>  
> -	if (!timespec64_equal(&inode->i_ctime, &now))
> -		inode->i_ctime = now;
> +	ctime = inode_get_ctime(inode);
> +	if (!timespec64_equal(&ctime, &now))
> +		inode_set_ctime_to_ts(inode, now);
>  
>  	if (IS_I_VERSION(inode))
>  		inode_inc_iversion(inode);
> @@ -2459,10 +2460,8 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
>  		 */
>  		inode_inc_iversion(&inode->vfs_inode);
>  
> -		if (!extent_info || extent_info->update_times) {
> -			inode->vfs_inode.i_mtime = current_time(&inode->vfs_inode);
> -			inode->vfs_inode.i_ctime = inode->vfs_inode.i_mtime;
> -		}
> +		if (!extent_info || extent_info->update_times)
> +			inode->vfs_inode.i_mtime = inode_set_ctime_current(&inode->vfs_inode);
>  
>  		ret = btrfs_update_inode(trans, root, inode);
>  		if (ret)
> @@ -2703,8 +2702,7 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
>  
>  	ASSERT(trans != NULL);
>  	inode_inc_iversion(inode);
> -	inode->i_mtime = current_time(inode);
> -	inode->i_ctime = inode->i_mtime;
> +	inode->i_mtime = inode_set_ctime_current(inode);
>  	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
>  	updated_inode = true;
>  	btrfs_end_transaction(trans);
> @@ -2721,11 +2719,10 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
>  		 * for detecting, at fsync time, if the inode isn't yet in the
>  		 * log tree or it's there but not up to date.
>  		 */
> -		struct timespec64 now = current_time(inode);
> +		struct timespec64 now = inode_set_ctime_current(inode);
>  
>  		inode_inc_iversion(inode);
>  		inode->i_mtime = now;
> -		inode->i_ctime = now;
>  		trans = btrfs_start_transaction(root, 1);
>  		if (IS_ERR(trans)) {
>  			ret = PTR_ERR(trans);
> @@ -2796,7 +2793,7 @@ static int btrfs_fallocate_update_isize(struct inode *inode,
>  	if (IS_ERR(trans))
>  		return PTR_ERR(trans);
>  
> -	inode->i_ctime = current_time(inode);
> +	inode_set_ctime_current(inode);
>  	i_size_write(inode, end);
>  	btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), 0);
>  	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 521c08b8ad04..daa47a2238bd 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3901,8 +3901,8 @@ static int btrfs_read_locked_inode(struct inode *inode,
>  	inode->i_mtime.tv_sec = btrfs_timespec_sec(leaf, &inode_item->mtime);
>  	inode->i_mtime.tv_nsec = btrfs_timespec_nsec(leaf, &inode_item->mtime);
>  
> -	inode->i_ctime.tv_sec = btrfs_timespec_sec(leaf, &inode_item->ctime);
> -	inode->i_ctime.tv_nsec = btrfs_timespec_nsec(leaf, &inode_item->ctime);
> +	inode_set_ctime(inode, btrfs_timespec_sec(leaf, &inode_item->ctime),
> +			btrfs_timespec_nsec(leaf, &inode_item->ctime));
>  
>  	BTRFS_I(inode)->i_otime.tv_sec =
>  		btrfs_timespec_sec(leaf, &inode_item->otime);
> @@ -4073,9 +4073,9 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
>  				      inode->i_mtime.tv_nsec);
>  
>  	btrfs_set_token_timespec_sec(&token, &item->ctime,
> -				     inode->i_ctime.tv_sec);
> +				     inode_get_ctime(inode).tv_sec);
>  	btrfs_set_token_timespec_nsec(&token, &item->ctime,
> -				      inode->i_ctime.tv_nsec);
> +				      inode_get_ctime(inode).tv_nsec);
>  
>  	btrfs_set_token_timespec_sec(&token, &item->otime,
>  				     BTRFS_I(inode)->i_otime.tv_sec);
> @@ -4273,9 +4273,8 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
>  	btrfs_i_size_write(dir, dir->vfs_inode.i_size - name->len * 2);
>  	inode_inc_iversion(&inode->vfs_inode);
>  	inode_inc_iversion(&dir->vfs_inode);
> -	inode->vfs_inode.i_ctime = current_time(&inode->vfs_inode);
> -	dir->vfs_inode.i_mtime = inode->vfs_inode.i_ctime;
> -	dir->vfs_inode.i_ctime = inode->vfs_inode.i_ctime;
> +	inode_set_ctime_current(&inode->vfs_inode);
> +	dir->vfs_inode.i_mtime = inode_set_ctime_current(&dir->vfs_inode);
>  	ret = btrfs_update_inode(trans, root, dir);
>  out:
>  	return ret;
> @@ -4448,8 +4447,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
>  
>  	btrfs_i_size_write(dir, dir->vfs_inode.i_size - fname.disk_name.len * 2);
>  	inode_inc_iversion(&dir->vfs_inode);
> -	dir->vfs_inode.i_mtime = current_time(&dir->vfs_inode);
> -	dir->vfs_inode.i_ctime = dir->vfs_inode.i_mtime;
> +	dir->vfs_inode.i_mtime = inode_set_ctime_current(&dir->vfs_inode);
>  	ret = btrfs_update_inode_fallback(trans, root, dir);
>  	if (ret)
>  		btrfs_abort_transaction(trans, ret);
> @@ -5091,8 +5089,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
>  	if (newsize != oldsize) {
>  		inode_inc_iversion(inode);
>  		if (!(mask & (ATTR_CTIME | ATTR_MTIME))) {
> -			inode->i_mtime = current_time(inode);
> -			inode->i_ctime = inode->i_mtime;
> +			inode->i_mtime = inode_set_ctime_current(inode);
>  		}
>  	}
>  
> @@ -5736,9 +5733,8 @@ static struct inode *new_simple_dir(struct super_block *s,
>  	inode->i_opflags &= ~IOP_XATTR;
>  	inode->i_fop = &simple_dir_operations;
>  	inode->i_mode = S_IFDIR | S_IRUGO | S_IWUSR | S_IXUGO;
> -	inode->i_mtime = current_time(inode);
> +	inode->i_mtime = inode_set_ctime_current(inode);
>  	inode->i_atime = inode->i_mtime;
> -	inode->i_ctime = inode->i_mtime;
>  	BTRFS_I(inode)->i_otime = inode->i_mtime;
>  
>  	return inode;
> @@ -6075,7 +6071,7 @@ static int btrfs_update_time(struct inode *inode, struct timespec64 *now,
>  	if (flags & S_VERSION)
>  		dirty |= inode_maybe_inc_iversion(inode, dirty);
>  	if (flags & S_CTIME)
> -		inode->i_ctime = *now;
> +		inode_set_ctime_to_ts(inode, *now);
>  	if (flags & S_MTIME)
>  		inode->i_mtime = *now;
>  	if (flags & S_ATIME)
> @@ -6378,9 +6374,8 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
>  		goto discard;
>  	}
>  
> -	inode->i_mtime = current_time(inode);
> +	inode->i_mtime = inode_set_ctime_current(inode);
>  	inode->i_atime = inode->i_mtime;
> -	inode->i_ctime = inode->i_mtime;
>  	BTRFS_I(inode)->i_otime = inode->i_mtime;
>  
>  	/*
> @@ -6545,12 +6540,10 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
>  	 * log replay procedure is responsible for setting them to their correct
>  	 * values (the ones it had when the fsync was done).
>  	 */
> -	if (!test_bit(BTRFS_FS_LOG_RECOVERING, &root->fs_info->flags)) {
> -		struct timespec64 now = current_time(&parent_inode->vfs_inode);
> +	if (!test_bit(BTRFS_FS_LOG_RECOVERING, &root->fs_info->flags))
> +		parent_inode->vfs_inode.i_mtime =
> +			inode_set_ctime_current(&parent_inode->vfs_inode);
>  
> -		parent_inode->vfs_inode.i_mtime = now;
> -		parent_inode->vfs_inode.i_ctime = now;
> -	}
>  	ret = btrfs_update_inode(trans, root, parent_inode);
>  	if (ret)
>  		btrfs_abort_transaction(trans, ret);
> @@ -6690,7 +6683,7 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
>  	BTRFS_I(inode)->dir_index = 0ULL;
>  	inc_nlink(inode);
>  	inode_inc_iversion(inode);
> -	inode->i_ctime = current_time(inode);
> +	inode_set_ctime_current(inode);
>  	ihold(inode);
>  	set_bit(BTRFS_INODE_COPY_EVERYTHING, &BTRFS_I(inode)->runtime_flags);
>  
> @@ -9733,7 +9726,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
>  		*alloc_hint = ins.objectid + ins.offset;
>  
>  		inode_inc_iversion(inode);
> -		inode->i_ctime = current_time(inode);
> +		inode_set_ctime_current(inode);
>  		BTRFS_I(inode)->flags |= BTRFS_INODE_PREALLOC;
>  		if (!(mode & FALLOC_FL_KEEP_SIZE) &&
>  		    (actual_len > inode->i_size) &&
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index a895d105464b..a18ee7b5a166 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -384,7 +384,7 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
>  	binode->flags = binode_flags;
>  	btrfs_sync_inode_flags_to_i_flags(inode);
>  	inode_inc_iversion(inode);
> -	inode->i_ctime = current_time(inode);
> +	inode_set_ctime_current(inode);
>  	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
>  
>   out_end_trans:
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index 0474bbe39da7..65d2bd6910f2 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -30,8 +30,7 @@ static int clone_finish_inode_update(struct btrfs_trans_handle *trans,
>  
>  	inode_inc_iversion(inode);
>  	if (!no_time_update) {
> -		inode->i_mtime = current_time(inode);
> -		inode->i_ctime = inode->i_mtime;
> +		inode->i_mtime = inode_set_ctime_current(inode);
>  	}
>  	/*
>  	 * We round up to the block size at eof when determining which
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index e7cfc992e02a..d8d20ea5a41f 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1831,8 +1831,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
>  
>  	btrfs_i_size_write(BTRFS_I(parent_inode), parent_inode->i_size +
>  						  fname.disk_name.len * 2);
> -	parent_inode->i_mtime = current_time(parent_inode);
> -	parent_inode->i_ctime = parent_inode->i_mtime;
> +	parent_inode->i_mtime = inode_set_ctime_current(parent_inode);
>  	ret = btrfs_update_inode_fallback(trans, parent_root, BTRFS_I(parent_inode));
>  	if (ret) {
>  		btrfs_abort_transaction(trans, ret);
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 365a1cc0a3c3..ffcff7188170 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -4148,9 +4148,9 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
>  				      inode->i_mtime.tv_nsec);
>  
>  	btrfs_set_token_timespec_sec(&token, &item->ctime,
> -				     inode->i_ctime.tv_sec);
> +				     inode_get_ctime(inode).tv_sec);
>  	btrfs_set_token_timespec_nsec(&token, &item->ctime,
> -				      inode->i_ctime.tv_nsec);
> +				      inode_get_ctime(inode).tv_nsec);
>  
>  	/*
>  	 * We do not need to set the nbytes field, in fact during a fast fsync
> diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
> index fc4b20c2688a..96828a13dd43 100644
> --- a/fs/btrfs/xattr.c
> +++ b/fs/btrfs/xattr.c
> @@ -264,7 +264,7 @@ int btrfs_setxattr_trans(struct inode *inode, const char *name,
>  		goto out;
>  
>  	inode_inc_iversion(inode);
> -	inode->i_ctime = current_time(inode);
> +	inode_set_ctime_current(inode);
>  	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
>  	if (ret)
>  		btrfs_abort_transaction(trans, ret);
> @@ -407,7 +407,7 @@ static int btrfs_xattr_handler_set_prop(const struct xattr_handler *handler,
>  	ret = btrfs_set_prop(trans, inode, name, value, size, flags);
>  	if (!ret) {
>  		inode_inc_iversion(inode);
> -		inode->i_ctime = current_time(inode);
> +		inode_set_ctime_current(inode);
>  		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
>  		if (ret)
>  			btrfs_abort_transaction(trans, ret);
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
