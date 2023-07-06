Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A292749E26
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 15:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjGFNvS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 09:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjGFNvQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:51:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1892D1BE9;
        Thu,  6 Jul 2023 06:51:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C73C81F85D;
        Thu,  6 Jul 2023 13:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688651470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H6W1tGe7Yzlmp14Vzeitpym5BAFvcBUu5sNtjPDdJ3A=;
        b=ETjVa+93vEIU7csKWYAR20SJb5Ecvc0q50i28lXZVGb7krWyMvudHr31UOQf9ZZn5adn7h
        ez6z04MaM4bg5BdxVr2haxBVOFkpG0yrfe4kr6JujdmrOL/wwDYtnUwPSCHwHkA5ae2PWq
        5fXyHiqusdiVvodHJfrFd/KaHdCQeVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688651470;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H6W1tGe7Yzlmp14Vzeitpym5BAFvcBUu5sNtjPDdJ3A=;
        b=td0xFaN72PY8DzezAZ42YqstgpTHV6GpGDzo3yT4wGDEPyYwZN/m6J//fmprPbRxZL+nzR
        D5Uu1rM8fGR2W7AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5460138EE;
        Thu,  6 Jul 2023 13:51:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GN9AKM7GpmS8YgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 13:51:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2FBDAA0707; Thu,  6 Jul 2023 15:51:10 +0200 (CEST)
Date:   Thu, 6 Jul 2023 15:51:10 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@lists.linux.dev
Subject: Re: [PATCH v2 62/92] ocfs2: convert to ctime accessor functions
Message-ID: <20230706135110.tptjnok24olk6m5y@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-60-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-60-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:27, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ocfs2/acl.c          |  6 +++---
>  fs/ocfs2/alloc.c        |  6 +++---
>  fs/ocfs2/aops.c         |  2 +-
>  fs/ocfs2/dir.c          |  8 ++++----
>  fs/ocfs2/dlmfs/dlmfs.c  |  4 ++--
>  fs/ocfs2/dlmglue.c      |  7 +++++--
>  fs/ocfs2/file.c         | 16 +++++++++-------
>  fs/ocfs2/inode.c        | 12 ++++++------
>  fs/ocfs2/move_extents.c |  6 +++---
>  fs/ocfs2/namei.c        | 21 +++++++++++----------
>  fs/ocfs2/refcounttree.c | 14 +++++++-------
>  fs/ocfs2/xattr.c        |  6 +++---
>  12 files changed, 57 insertions(+), 51 deletions(-)
> 
> diff --git a/fs/ocfs2/acl.c b/fs/ocfs2/acl.c
> index 9fd03eaf15f8..e75137a8e7cb 100644
> --- a/fs/ocfs2/acl.c
> +++ b/fs/ocfs2/acl.c
> @@ -191,10 +191,10 @@ static int ocfs2_acl_set_mode(struct inode *inode, struct buffer_head *di_bh,
>  	}
>  
>  	inode->i_mode = new_mode;
> -	inode->i_ctime = current_time(inode);
> +	inode_set_ctime_current(inode);
>  	di->i_mode = cpu_to_le16(inode->i_mode);
> -	di->i_ctime = cpu_to_le64(inode->i_ctime.tv_sec);
> -	di->i_ctime_nsec = cpu_to_le32(inode->i_ctime.tv_nsec);
> +	di->i_ctime = cpu_to_le64(inode_get_ctime(inode).tv_sec);
> +	di->i_ctime_nsec = cpu_to_le32(inode_get_ctime(inode).tv_nsec);
>  	ocfs2_update_inode_fsync_trans(handle, inode, 0);
>  
>  	ocfs2_journal_dirty(handle, di_bh);
> diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
> index 51c93929a146..aef58f1395c8 100644
> --- a/fs/ocfs2/alloc.c
> +++ b/fs/ocfs2/alloc.c
> @@ -7436,10 +7436,10 @@ int ocfs2_truncate_inline(struct inode *inode, struct buffer_head *di_bh,
>  	}
>  
>  	inode->i_blocks = ocfs2_inode_sector_count(inode);
> -	inode->i_ctime = inode->i_mtime = current_time(inode);
> +	inode->i_mtime = inode_set_ctime_current(inode);
>  
> -	di->i_ctime = di->i_mtime = cpu_to_le64(inode->i_ctime.tv_sec);
> -	di->i_ctime_nsec = di->i_mtime_nsec = cpu_to_le32(inode->i_ctime.tv_nsec);
> +	di->i_ctime = di->i_mtime = cpu_to_le64(inode_get_ctime(inode).tv_sec);
> +	di->i_ctime_nsec = di->i_mtime_nsec = cpu_to_le32(inode_get_ctime(inode).tv_nsec);
>  
>  	ocfs2_update_inode_fsync_trans(handle, inode, 1);
>  	ocfs2_journal_dirty(handle, di_bh);
> diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
> index 8dfc284e85f0..0fdba30740ab 100644
> --- a/fs/ocfs2/aops.c
> +++ b/fs/ocfs2/aops.c
> @@ -2048,7 +2048,7 @@ int ocfs2_write_end_nolock(struct address_space *mapping,
>  		}
>  		inode->i_blocks = ocfs2_inode_sector_count(inode);
>  		di->i_size = cpu_to_le64((u64)i_size_read(inode));
> -		inode->i_mtime = inode->i_ctime = current_time(inode);
> +		inode->i_mtime = inode_set_ctime_current(inode);
>  		di->i_mtime = di->i_ctime = cpu_to_le64(inode->i_mtime.tv_sec);
>  		di->i_mtime_nsec = di->i_ctime_nsec = cpu_to_le32(inode->i_mtime.tv_nsec);
>  		if (handle)
> diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
> index 694471fc46b8..8b123d543e6e 100644
> --- a/fs/ocfs2/dir.c
> +++ b/fs/ocfs2/dir.c
> @@ -1658,7 +1658,7 @@ int __ocfs2_add_entry(handle_t *handle,
>  				offset, ocfs2_dir_trailer_blk_off(dir->i_sb));
>  
>  		if (ocfs2_dirent_would_fit(de, rec_len)) {
> -			dir->i_mtime = dir->i_ctime = current_time(dir);
> +			dir->i_mtime = inode_set_ctime_current(dir);
>  			retval = ocfs2_mark_inode_dirty(handle, dir, parent_fe_bh);
>  			if (retval < 0) {
>  				mlog_errno(retval);
> @@ -2962,11 +2962,11 @@ static int ocfs2_expand_inline_dir(struct inode *dir, struct buffer_head *di_bh,
>  	ocfs2_dinode_new_extent_list(dir, di);
>  
>  	i_size_write(dir, sb->s_blocksize);
> -	dir->i_mtime = dir->i_ctime = current_time(dir);
> +	dir->i_mtime = inode_set_ctime_current(dir);
>  
>  	di->i_size = cpu_to_le64(sb->s_blocksize);
> -	di->i_ctime = di->i_mtime = cpu_to_le64(dir->i_ctime.tv_sec);
> -	di->i_ctime_nsec = di->i_mtime_nsec = cpu_to_le32(dir->i_ctime.tv_nsec);
> +	di->i_ctime = di->i_mtime = cpu_to_le64(inode_get_ctime(dir).tv_sec);
> +	di->i_ctime_nsec = di->i_mtime_nsec = cpu_to_le32(inode_get_ctime(dir).tv_nsec);
>  	ocfs2_update_inode_fsync_trans(handle, dir, 1);
>  
>  	/*
> diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
> index ba26c5567cff..81265123ce6c 100644
> --- a/fs/ocfs2/dlmfs/dlmfs.c
> +++ b/fs/ocfs2/dlmfs/dlmfs.c
> @@ -337,7 +337,7 @@ static struct inode *dlmfs_get_root_inode(struct super_block *sb)
>  	if (inode) {
>  		inode->i_ino = get_next_ino();
>  		inode_init_owner(&nop_mnt_idmap, inode, NULL, mode);
> -		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> +		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
>  		inc_nlink(inode);
>  
>  		inode->i_fop = &simple_dir_operations;
> @@ -360,7 +360,7 @@ static struct inode *dlmfs_get_inode(struct inode *parent,
>  
>  	inode->i_ino = get_next_ino();
>  	inode_init_owner(&nop_mnt_idmap, inode, parent, mode);
> -	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> +	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
>  
>  	ip = DLMFS_I(inode);
>  	ip->ip_conn = DLMFS_I(parent)->ip_conn;
> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
> index c28bc983a7b1..c3e2961ee5db 100644
> --- a/fs/ocfs2/dlmglue.c
> +++ b/fs/ocfs2/dlmglue.c
> @@ -2162,6 +2162,7 @@ static void __ocfs2_stuff_meta_lvb(struct inode *inode)
>  	struct ocfs2_inode_info *oi = OCFS2_I(inode);
>  	struct ocfs2_lock_res *lockres = &oi->ip_inode_lockres;
>  	struct ocfs2_meta_lvb *lvb;
> +	struct timespec64 ctime = inode_get_ctime(inode);
>  
>  	lvb = ocfs2_dlm_lvb(&lockres->l_lksb);
>  
> @@ -2185,7 +2186,7 @@ static void __ocfs2_stuff_meta_lvb(struct inode *inode)
>  	lvb->lvb_iatime_packed  =
>  		cpu_to_be64(ocfs2_pack_timespec(&inode->i_atime));
>  	lvb->lvb_ictime_packed =
> -		cpu_to_be64(ocfs2_pack_timespec(&inode->i_ctime));
> +		cpu_to_be64(ocfs2_pack_timespec(&ctime));
>  	lvb->lvb_imtime_packed =
>  		cpu_to_be64(ocfs2_pack_timespec(&inode->i_mtime));
>  	lvb->lvb_iattr    = cpu_to_be32(oi->ip_attr);
> @@ -2208,6 +2209,7 @@ static int ocfs2_refresh_inode_from_lvb(struct inode *inode)
>  	struct ocfs2_inode_info *oi = OCFS2_I(inode);
>  	struct ocfs2_lock_res *lockres = &oi->ip_inode_lockres;
>  	struct ocfs2_meta_lvb *lvb;
> +	struct timespec64 ctime;
>  
>  	mlog_meta_lvb(0, lockres);
>  
> @@ -2238,8 +2240,9 @@ static int ocfs2_refresh_inode_from_lvb(struct inode *inode)
>  			      be64_to_cpu(lvb->lvb_iatime_packed));
>  	ocfs2_unpack_timespec(&inode->i_mtime,
>  			      be64_to_cpu(lvb->lvb_imtime_packed));
> -	ocfs2_unpack_timespec(&inode->i_ctime,
> +	ocfs2_unpack_timespec(&ctime,
>  			      be64_to_cpu(lvb->lvb_ictime_packed));
> +	inode_set_ctime_to_ts(inode, ctime);
>  	spin_unlock(&oi->ip_lock);
>  	return 0;
>  }
> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
> index 9e417cd4fd16..e8c78d16e815 100644
> --- a/fs/ocfs2/file.c
> +++ b/fs/ocfs2/file.c
> @@ -232,8 +232,10 @@ int ocfs2_should_update_atime(struct inode *inode,
>  		return 0;
>  
>  	if (vfsmnt->mnt_flags & MNT_RELATIME) {
> +		struct timespec64 ctime = inode_get_ctime(inode);
> +
>  		if ((timespec64_compare(&inode->i_atime, &inode->i_mtime) <= 0) ||
> -		    (timespec64_compare(&inode->i_atime, &inode->i_ctime) <= 0))
> +		    (timespec64_compare(&inode->i_atime, &ctime) <= 0))
>  			return 1;
>  
>  		return 0;
> @@ -294,7 +296,7 @@ int ocfs2_set_inode_size(handle_t *handle,
>  
>  	i_size_write(inode, new_i_size);
>  	inode->i_blocks = ocfs2_inode_sector_count(inode);
> -	inode->i_ctime = inode->i_mtime = current_time(inode);
> +	inode->i_mtime = inode_set_ctime_current(inode);
>  
>  	status = ocfs2_mark_inode_dirty(handle, inode, fe_bh);
>  	if (status < 0) {
> @@ -415,12 +417,12 @@ static int ocfs2_orphan_for_truncate(struct ocfs2_super *osb,
>  	}
>  
>  	i_size_write(inode, new_i_size);
> -	inode->i_ctime = inode->i_mtime = current_time(inode);
> +	inode->i_mtime = inode_set_ctime_current(inode);
>  
>  	di = (struct ocfs2_dinode *) fe_bh->b_data;
>  	di->i_size = cpu_to_le64(new_i_size);
> -	di->i_ctime = di->i_mtime = cpu_to_le64(inode->i_ctime.tv_sec);
> -	di->i_ctime_nsec = di->i_mtime_nsec = cpu_to_le32(inode->i_ctime.tv_nsec);
> +	di->i_ctime = di->i_mtime = cpu_to_le64(inode_get_ctime(inode).tv_sec);
> +	di->i_ctime_nsec = di->i_mtime_nsec = cpu_to_le32(inode_get_ctime(inode).tv_nsec);
>  	ocfs2_update_inode_fsync_trans(handle, inode, 0);
>  
>  	ocfs2_journal_dirty(handle, fe_bh);
> @@ -819,7 +821,7 @@ static int ocfs2_write_zero_page(struct inode *inode, u64 abs_from,
>  	i_size_write(inode, abs_to);
>  	inode->i_blocks = ocfs2_inode_sector_count(inode);
>  	di->i_size = cpu_to_le64((u64)i_size_read(inode));
> -	inode->i_mtime = inode->i_ctime = current_time(inode);
> +	inode->i_mtime = inode_set_ctime_current(inode);
>  	di->i_mtime = di->i_ctime = cpu_to_le64(inode->i_mtime.tv_sec);
>  	di->i_ctime_nsec = cpu_to_le32(inode->i_mtime.tv_nsec);
>  	di->i_mtime_nsec = di->i_ctime_nsec;
> @@ -2038,7 +2040,7 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
>  		goto out_inode_unlock;
>  	}
>  
> -	inode->i_ctime = inode->i_mtime = current_time(inode);
> +	inode->i_mtime = inode_set_ctime_current(inode);
>  	ret = ocfs2_mark_inode_dirty(handle, inode, di_bh);
>  	if (ret < 0)
>  		mlog_errno(ret);
> diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> index bb116c39b581..e8771600b930 100644
> --- a/fs/ocfs2/inode.c
> +++ b/fs/ocfs2/inode.c
> @@ -306,8 +306,8 @@ void ocfs2_populate_inode(struct inode *inode, struct ocfs2_dinode *fe,
>  	inode->i_atime.tv_nsec = le32_to_cpu(fe->i_atime_nsec);
>  	inode->i_mtime.tv_sec = le64_to_cpu(fe->i_mtime);
>  	inode->i_mtime.tv_nsec = le32_to_cpu(fe->i_mtime_nsec);
> -	inode->i_ctime.tv_sec = le64_to_cpu(fe->i_ctime);
> -	inode->i_ctime.tv_nsec = le32_to_cpu(fe->i_ctime_nsec);
> +	inode_set_ctime(inode, le64_to_cpu(fe->i_ctime),
> +		        le32_to_cpu(fe->i_ctime_nsec));
>  
>  	if (OCFS2_I(inode)->ip_blkno != le64_to_cpu(fe->i_blkno))
>  		mlog(ML_ERROR,
> @@ -1314,8 +1314,8 @@ int ocfs2_mark_inode_dirty(handle_t *handle,
>  	fe->i_mode = cpu_to_le16(inode->i_mode);
>  	fe->i_atime = cpu_to_le64(inode->i_atime.tv_sec);
>  	fe->i_atime_nsec = cpu_to_le32(inode->i_atime.tv_nsec);
> -	fe->i_ctime = cpu_to_le64(inode->i_ctime.tv_sec);
> -	fe->i_ctime_nsec = cpu_to_le32(inode->i_ctime.tv_nsec);
> +	fe->i_ctime = cpu_to_le64(inode_get_ctime(inode).tv_sec);
> +	fe->i_ctime_nsec = cpu_to_le32(inode_get_ctime(inode).tv_nsec);
>  	fe->i_mtime = cpu_to_le64(inode->i_mtime.tv_sec);
>  	fe->i_mtime_nsec = cpu_to_le32(inode->i_mtime.tv_nsec);
>  
> @@ -1352,8 +1352,8 @@ void ocfs2_refresh_inode(struct inode *inode,
>  	inode->i_atime.tv_nsec = le32_to_cpu(fe->i_atime_nsec);
>  	inode->i_mtime.tv_sec = le64_to_cpu(fe->i_mtime);
>  	inode->i_mtime.tv_nsec = le32_to_cpu(fe->i_mtime_nsec);
> -	inode->i_ctime.tv_sec = le64_to_cpu(fe->i_ctime);
> -	inode->i_ctime.tv_nsec = le32_to_cpu(fe->i_ctime_nsec);
> +	inode_set_ctime(inode, le64_to_cpu(fe->i_ctime),
> +			le32_to_cpu(fe->i_ctime_nsec));
>  
>  	spin_unlock(&OCFS2_I(inode)->ip_lock);
>  }
> diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
> index b1e32ec4a9d4..05d67968a3a9 100644
> --- a/fs/ocfs2/move_extents.c
> +++ b/fs/ocfs2/move_extents.c
> @@ -950,9 +950,9 @@ static int ocfs2_move_extents(struct ocfs2_move_extents_context *context)
>  	}
>  
>  	di = (struct ocfs2_dinode *)di_bh->b_data;
> -	inode->i_ctime = current_time(inode);
> -	di->i_ctime = cpu_to_le64(inode->i_ctime.tv_sec);
> -	di->i_ctime_nsec = cpu_to_le32(inode->i_ctime.tv_nsec);
> +	inode_set_ctime_current(inode);
> +	di->i_ctime = cpu_to_le64(inode_get_ctime(inode).tv_sec);
> +	di->i_ctime_nsec = cpu_to_le32(inode_get_ctime(inode).tv_nsec);
>  	ocfs2_update_inode_fsync_trans(handle, inode, 0);
>  
>  	ocfs2_journal_dirty(handle, di_bh);
> diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
> index 17c52225b87d..e4a684d45308 100644
> --- a/fs/ocfs2/namei.c
> +++ b/fs/ocfs2/namei.c
> @@ -793,10 +793,10 @@ static int ocfs2_link(struct dentry *old_dentry,
>  	}
>  
>  	inc_nlink(inode);
> -	inode->i_ctime = current_time(inode);
> +	inode_set_ctime_current(inode);
>  	ocfs2_set_links_count(fe, inode->i_nlink);
> -	fe->i_ctime = cpu_to_le64(inode->i_ctime.tv_sec);
> -	fe->i_ctime_nsec = cpu_to_le32(inode->i_ctime.tv_nsec);
> +	fe->i_ctime = cpu_to_le64(inode_get_ctime(inode).tv_sec);
> +	fe->i_ctime_nsec = cpu_to_le32(inode_get_ctime(inode).tv_nsec);
>  	ocfs2_journal_dirty(handle, fe_bh);
>  
>  	err = ocfs2_add_entry(handle, dentry, inode,
> @@ -995,7 +995,7 @@ static int ocfs2_unlink(struct inode *dir,
>  	ocfs2_set_links_count(fe, inode->i_nlink);
>  	ocfs2_journal_dirty(handle, fe_bh);
>  
> -	dir->i_ctime = dir->i_mtime = current_time(dir);
> +	dir->i_mtime = inode_set_ctime_current(dir);
>  	if (S_ISDIR(inode->i_mode))
>  		drop_nlink(dir);
>  
> @@ -1537,7 +1537,7 @@ static int ocfs2_rename(struct mnt_idmap *idmap,
>  					 new_dir_bh, &target_insert);
>  	}
>  
> -	old_inode->i_ctime = current_time(old_inode);
> +	inode_set_ctime_current(old_inode);
>  	mark_inode_dirty(old_inode);
>  
>  	status = ocfs2_journal_access_di(handle, INODE_CACHE(old_inode),
> @@ -1546,8 +1546,8 @@ static int ocfs2_rename(struct mnt_idmap *idmap,
>  	if (status >= 0) {
>  		old_di = (struct ocfs2_dinode *) old_inode_bh->b_data;
>  
> -		old_di->i_ctime = cpu_to_le64(old_inode->i_ctime.tv_sec);
> -		old_di->i_ctime_nsec = cpu_to_le32(old_inode->i_ctime.tv_nsec);
> +		old_di->i_ctime = cpu_to_le64(inode_get_ctime(old_inode).tv_sec);
> +		old_di->i_ctime_nsec = cpu_to_le32(inode_get_ctime(old_inode).tv_nsec);
>  		ocfs2_journal_dirty(handle, old_inode_bh);
>  	} else
>  		mlog_errno(status);
> @@ -1586,9 +1586,9 @@ static int ocfs2_rename(struct mnt_idmap *idmap,
>  
>  	if (new_inode) {
>  		drop_nlink(new_inode);
> -		new_inode->i_ctime = current_time(new_inode);
> +		inode_set_ctime_current(new_inode);
>  	}
> -	old_dir->i_ctime = old_dir->i_mtime = current_time(old_dir);
> +	old_dir->i_mtime = inode_set_ctime_current(old_dir);
>  
>  	if (update_dot_dot) {
>  		status = ocfs2_update_entry(old_inode, handle,
> @@ -1610,7 +1610,8 @@ static int ocfs2_rename(struct mnt_idmap *idmap,
>  
>  	if (old_dir != new_dir) {
>  		/* Keep the same times on both directories.*/
> -		new_dir->i_ctime = new_dir->i_mtime = old_dir->i_ctime;
> +		new_dir->i_mtime = inode_set_ctime_to_ts(new_dir,
> +							 inode_get_ctime(old_dir));
>  
>  		/*
>  		 * This will also pick up the i_nlink change from the
> diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
> index 564ab48d03ef..25c8ec3c8c3a 100644
> --- a/fs/ocfs2/refcounttree.c
> +++ b/fs/ocfs2/refcounttree.c
> @@ -3750,9 +3750,9 @@ static int ocfs2_change_ctime(struct inode *inode,
>  		goto out_commit;
>  	}
>  
> -	inode->i_ctime = current_time(inode);
> -	di->i_ctime = cpu_to_le64(inode->i_ctime.tv_sec);
> -	di->i_ctime_nsec = cpu_to_le32(inode->i_ctime.tv_nsec);
> +	inode_set_ctime_current(inode);
> +	di->i_ctime = cpu_to_le64(inode_get_ctime(inode).tv_sec);
> +	di->i_ctime_nsec = cpu_to_le32(inode_get_ctime(inode).tv_nsec);
>  
>  	ocfs2_journal_dirty(handle, di_bh);
>  
> @@ -4073,10 +4073,10 @@ static int ocfs2_complete_reflink(struct inode *s_inode,
>  		 * we want mtime to appear identical to the source and
>  		 * update ctime.
>  		 */
> -		t_inode->i_ctime = current_time(t_inode);
> +		inode_set_ctime_current(t_inode);
>  
> -		di->i_ctime = cpu_to_le64(t_inode->i_ctime.tv_sec);
> -		di->i_ctime_nsec = cpu_to_le32(t_inode->i_ctime.tv_nsec);
> +		di->i_ctime = cpu_to_le64(inode_get_ctime(t_inode).tv_sec);
> +		di->i_ctime_nsec = cpu_to_le32(inode_get_ctime(t_inode).tv_nsec);
>  
>  		t_inode->i_mtime = s_inode->i_mtime;
>  		di->i_mtime = s_di->i_mtime;
> @@ -4456,7 +4456,7 @@ int ocfs2_reflink_update_dest(struct inode *dest,
>  	if (newlen > i_size_read(dest))
>  		i_size_write(dest, newlen);
>  	spin_unlock(&OCFS2_I(dest)->ip_lock);
> -	dest->i_ctime = dest->i_mtime = current_time(dest);
> +	dest->i_mtime = inode_set_ctime_current(dest);
>  
>  	ret = ocfs2_mark_inode_dirty(handle, dest, d_bh);
>  	if (ret) {
> diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
> index 4ac77ff6e676..6510ad783c91 100644
> --- a/fs/ocfs2/xattr.c
> +++ b/fs/ocfs2/xattr.c
> @@ -3421,9 +3421,9 @@ static int __ocfs2_xattr_set_handle(struct inode *inode,
>  			goto out;
>  		}
>  
> -		inode->i_ctime = current_time(inode);
> -		di->i_ctime = cpu_to_le64(inode->i_ctime.tv_sec);
> -		di->i_ctime_nsec = cpu_to_le32(inode->i_ctime.tv_nsec);
> +		inode_set_ctime_current(inode);
> +		di->i_ctime = cpu_to_le64(inode_get_ctime(inode).tv_sec);
> +		di->i_ctime_nsec = cpu_to_le32(inode_get_ctime(inode).tv_nsec);
>  		ocfs2_journal_dirty(ctxt->handle, xis->inode_bh);
>  	}
>  out:
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
