Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C3B749A28
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 13:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjGFLDS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 07:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjGFLDR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:03:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548DFDC;
        Thu,  6 Jul 2023 04:03:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0DE7820540;
        Thu,  6 Jul 2023 11:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688641394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Rxs4LWmkhj0b9R1MhEn+qLcVOlphQJ/+uzFKEEqkG4=;
        b=b7YFT1vHhmkk1HtJEJoGZRndYechby4Bjznmvi6XmEj5VFysrIghfm1dUCJK+1O8spvhbj
        Dc2DtwUsAtiMJC3Y4OzuHloNw8teSf44AUHC6zeSTmn0p2hwXrDjMt5TnzGboepypNtDdn
        u2GfsRLA3mMdInay1EjxnJuCIQHZFiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688641394;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Rxs4LWmkhj0b9R1MhEn+qLcVOlphQJ/+uzFKEEqkG4=;
        b=H3DylN8BV70mVVN/53nsytAg8zlC+SAnRRrm96kmzXijljHwz4RD3UDlaPk4/So6JPPkRl
        5nAhA2Zdbu2HdyBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA8DF138EE;
        Thu,  6 Jul 2023 11:03:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v9BCOXGfpmTECQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 11:03:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 78115A0707; Thu,  6 Jul 2023 13:03:13 +0200 (CEST)
Date:   Thu, 6 Jul 2023 13:03:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 41/92] ext2: convert to ctime accessor functions
Message-ID: <20230706110313.kxiesbruvzrdsxzo@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-39-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-39-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:06, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext2/acl.c    |  2 +-
>  fs/ext2/dir.c    |  6 +++---
>  fs/ext2/ialloc.c |  2 +-
>  fs/ext2/inode.c  | 10 +++++-----
>  fs/ext2/ioctl.c  |  4 ++--
>  fs/ext2/namei.c  |  8 ++++----
>  fs/ext2/super.c  |  2 +-
>  fs/ext2/xattr.c  |  2 +-
>  8 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/ext2/acl.c b/fs/ext2/acl.c
> index 82b17d7fc93f..7e54c31589c7 100644
> --- a/fs/ext2/acl.c
> +++ b/fs/ext2/acl.c
> @@ -237,7 +237,7 @@ ext2_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>  	error = __ext2_set_acl(inode, acl, type);
>  	if (!error && update_mode) {
>  		inode->i_mode = mode;
> -		inode->i_ctime = current_time(inode);
> +		inode_set_ctime_current(inode);
>  		mark_inode_dirty(inode);
>  	}
>  	return error;
> diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
> index 42db804794bd..b335f17f682f 100644
> --- a/fs/ext2/dir.c
> +++ b/fs/ext2/dir.c
> @@ -468,7 +468,7 @@ int ext2_set_link(struct inode *dir, struct ext2_dir_entry_2 *de,
>  	ext2_set_de_type(de, inode);
>  	ext2_commit_chunk(page, pos, len);
>  	if (update_times)
> -		dir->i_mtime = dir->i_ctime = current_time(dir);
> +		dir->i_mtime = inode_set_ctime_current(dir);
>  	EXT2_I(dir)->i_flags &= ~EXT2_BTREE_FL;
>  	mark_inode_dirty(dir);
>  	return ext2_handle_dirsync(dir);
> @@ -555,7 +555,7 @@ int ext2_add_link (struct dentry *dentry, struct inode *inode)
>  	de->inode = cpu_to_le32(inode->i_ino);
>  	ext2_set_de_type (de, inode);
>  	ext2_commit_chunk(page, pos, rec_len);
> -	dir->i_mtime = dir->i_ctime = current_time(dir);
> +	dir->i_mtime = inode_set_ctime_current(dir);
>  	EXT2_I(dir)->i_flags &= ~EXT2_BTREE_FL;
>  	mark_inode_dirty(dir);
>  	err = ext2_handle_dirsync(dir);
> @@ -606,7 +606,7 @@ int ext2_delete_entry(struct ext2_dir_entry_2 *dir, struct page *page)
>  		pde->rec_len = ext2_rec_len_to_disk(to - from);
>  	dir->inode = 0;
>  	ext2_commit_chunk(page, pos, to - from);
> -	inode->i_ctime = inode->i_mtime = current_time(inode);
> +	inode->i_mtime = inode_set_ctime_current(inode);
>  	EXT2_I(inode)->i_flags &= ~EXT2_BTREE_FL;
>  	mark_inode_dirty(inode);
>  	return ext2_handle_dirsync(inode);
> diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
> index 34cd5dc1da23..c24d0de95a83 100644
> --- a/fs/ext2/ialloc.c
> +++ b/fs/ext2/ialloc.c
> @@ -546,7 +546,7 @@ struct inode *ext2_new_inode(struct inode *dir, umode_t mode,
>  
>  	inode->i_ino = ino;
>  	inode->i_blocks = 0;
> -	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> +	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
>  	memset(ei->i_data, 0, sizeof(ei->i_data));
>  	ei->i_flags =
>  		ext2_mask_flags(mode, EXT2_I(dir)->i_flags & EXT2_FL_INHERITED);
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index 75983215c7a1..1259995977d2 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -595,7 +595,7 @@ static void ext2_splice_branch(struct inode *inode,
>  	if (where->bh)
>  		mark_buffer_dirty_inode(where->bh, inode);
>  
> -	inode->i_ctime = current_time(inode);
> +	inode_set_ctime_current(inode);
>  	mark_inode_dirty(inode);
>  }
>  
> @@ -1287,7 +1287,7 @@ static int ext2_setsize(struct inode *inode, loff_t newsize)
>  	__ext2_truncate_blocks(inode, newsize);
>  	filemap_invalidate_unlock(inode->i_mapping);
>  
> -	inode->i_mtime = inode->i_ctime = current_time(inode);
> +	inode->i_mtime = inode_set_ctime_current(inode);
>  	if (inode_needs_sync(inode)) {
>  		sync_mapping_buffers(inode->i_mapping);
>  		sync_inode_metadata(inode, 1);
> @@ -1409,9 +1409,9 @@ struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
>  	set_nlink(inode, le16_to_cpu(raw_inode->i_links_count));
>  	inode->i_size = le32_to_cpu(raw_inode->i_size);
>  	inode->i_atime.tv_sec = (signed)le32_to_cpu(raw_inode->i_atime);
> -	inode->i_ctime.tv_sec = (signed)le32_to_cpu(raw_inode->i_ctime);
> +	inode_set_ctime(inode, (signed)le32_to_cpu(raw_inode->i_ctime), 0);
>  	inode->i_mtime.tv_sec = (signed)le32_to_cpu(raw_inode->i_mtime);
> -	inode->i_atime.tv_nsec = inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec = 0;
> +	inode->i_atime.tv_nsec = inode->i_mtime.tv_nsec = 0;
>  	ei->i_dtime = le32_to_cpu(raw_inode->i_dtime);
>  	/* We now have enough fields to check if the inode was active or not.
>  	 * This is needed because nfsd might try to access dead inodes
> @@ -1541,7 +1541,7 @@ static int __ext2_write_inode(struct inode *inode, int do_sync)
>  	raw_inode->i_links_count = cpu_to_le16(inode->i_nlink);
>  	raw_inode->i_size = cpu_to_le32(inode->i_size);
>  	raw_inode->i_atime = cpu_to_le32(inode->i_atime.tv_sec);
> -	raw_inode->i_ctime = cpu_to_le32(inode->i_ctime.tv_sec);
> +	raw_inode->i_ctime = cpu_to_le32(inode_get_ctime(inode).tv_sec);
>  	raw_inode->i_mtime = cpu_to_le32(inode->i_mtime.tv_sec);
>  
>  	raw_inode->i_blocks = cpu_to_le32(inode->i_blocks);
> diff --git a/fs/ext2/ioctl.c b/fs/ext2/ioctl.c
> index cc87d413eb43..44e04484e570 100644
> --- a/fs/ext2/ioctl.c
> +++ b/fs/ext2/ioctl.c
> @@ -44,7 +44,7 @@ int ext2_fileattr_set(struct mnt_idmap *idmap,
>  		(fa->flags & EXT2_FL_USER_MODIFIABLE);
>  
>  	ext2_set_inode_flags(inode);
> -	inode->i_ctime = current_time(inode);
> +	inode_set_ctime_current(inode);
>  	mark_inode_dirty(inode);
>  
>  	return 0;
> @@ -77,7 +77,7 @@ long ext2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		}
>  
>  		inode_lock(inode);
> -		inode->i_ctime = current_time(inode);
> +		inode_set_ctime_current(inode);
>  		inode->i_generation = generation;
>  		inode_unlock(inode);
>  
> diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
> index 937dd8f60f96..059517068adc 100644
> --- a/fs/ext2/namei.c
> +++ b/fs/ext2/namei.c
> @@ -211,7 +211,7 @@ static int ext2_link (struct dentry * old_dentry, struct inode * dir,
>  	if (err)
>  		return err;
>  
> -	inode->i_ctime = current_time(inode);
> +	inode_set_ctime_current(inode);
>  	inode_inc_link_count(inode);
>  	ihold(inode);
>  
> @@ -291,7 +291,7 @@ static int ext2_unlink(struct inode *dir, struct dentry *dentry)
>  	if (err)
>  		goto out;
>  
> -	inode->i_ctime = dir->i_ctime;
> +	inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
>  	inode_dec_link_count(inode);
>  	err = 0;
>  out:
> @@ -367,7 +367,7 @@ static int ext2_rename (struct mnt_idmap * idmap,
>  		ext2_put_page(new_page, new_de);
>  		if (err)
>  			goto out_dir;
> -		new_inode->i_ctime = current_time(new_inode);
> +		inode_set_ctime_current(new_inode);
>  		if (dir_de)
>  			drop_nlink(new_inode);
>  		inode_dec_link_count(new_inode);
> @@ -383,7 +383,7 @@ static int ext2_rename (struct mnt_idmap * idmap,
>  	 * Like most other Unix systems, set the ctime for inodes on a
>   	 * rename.
>  	 */
> -	old_inode->i_ctime = current_time(old_inode);
> +	inode_set_ctime_current(old_inode);
>  	mark_inode_dirty(old_inode);
>  
>  	err = ext2_delete_entry(old_de, old_page);
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index 2959afc7541c..aaf3e3e88cb2 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -1572,7 +1572,7 @@ static ssize_t ext2_quota_write(struct super_block *sb, int type,
>  	if (inode->i_size < off+len-towrite)
>  		i_size_write(inode, off+len-towrite);
>  	inode_inc_iversion(inode);
> -	inode->i_mtime = inode->i_ctime = current_time(inode);
> +	inode->i_mtime = inode_set_ctime_current(inode);
>  	mark_inode_dirty(inode);
>  	return len - towrite;
>  }
> diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> index 8906ba479aaf..1c9187188d68 100644
> --- a/fs/ext2/xattr.c
> +++ b/fs/ext2/xattr.c
> @@ -773,7 +773,7 @@ ext2_xattr_set2(struct inode *inode, struct buffer_head *old_bh,
>  
>  	/* Update the inode. */
>  	EXT2_I(inode)->i_file_acl = new_bh ? new_bh->b_blocknr : 0;
> -	inode->i_ctime = current_time(inode);
> +	inode_set_ctime_current(inode);
>  	if (IS_SYNC(inode)) {
>  		error = sync_inode_metadata(inode, 1);
>  		/* In case sync failed due to ENOSPC the inode was actually
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
