Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1D2749CAE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 14:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjGFMvM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 08:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjGFMvJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:51:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14411BDC;
        Thu,  6 Jul 2023 05:50:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 805101FE6D;
        Thu,  6 Jul 2023 12:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688647845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m0tmldPz0+dDTJ2s0T/DzEzZUGUbqrRg9hgSmSJ6FUs=;
        b=t/K5CbfjbtMsIk0e2qX/C9kdtDTiaTsp6pSw/9TNgEllEgBlWL+vK6JKTb0yWMjD0riYgJ
        9MaHIHPgD+UXb4bxvDDrTEqVHZ+bUxxvOYQ3+CShw6Eb5n4u1xetjmrlvR1QwhC0gCxB+l
        vnjE0qS2eIV5HBceEmYUwqs4jY4Gkmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688647845;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m0tmldPz0+dDTJ2s0T/DzEzZUGUbqrRg9hgSmSJ6FUs=;
        b=+uUJJQHKLUNtq0CM9IqsZNdKDm3jMq+Vqoau3+T9Lf8zrg4rAf7woCOYryWSkhKgj0s5dP
        ve+ojBv9a2EDUxAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A0EB138FC;
        Thu,  6 Jul 2023 12:50:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9Wj/FaW4pmTBQwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 12:50:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DAF8BA0707; Thu,  6 Jul 2023 14:50:44 +0200 (CEST)
Date:   Thu, 6 Jul 2023 14:50:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 48/92] hfs: convert to ctime accessor functions
Message-ID: <20230706125044.yuder555eqh3acjx@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-46-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-46-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:13, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/hfs/catalog.c |  8 ++++----
>  fs/hfs/dir.c     |  2 +-
>  fs/hfs/inode.c   | 13 ++++++-------
>  fs/hfs/sysdep.c  |  4 +++-
>  4 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
> index d365bf0b8c77..632c226a3972 100644
> --- a/fs/hfs/catalog.c
> +++ b/fs/hfs/catalog.c
> @@ -133,7 +133,7 @@ int hfs_cat_create(u32 cnid, struct inode *dir, const struct qstr *str, struct i
>  		goto err1;
>  
>  	dir->i_size++;
> -	dir->i_mtime = dir->i_ctime = current_time(dir);
> +	dir->i_mtime = inode_set_ctime_current(dir);
>  	mark_inode_dirty(dir);
>  	hfs_find_exit(&fd);
>  	return 0;
> @@ -269,7 +269,7 @@ int hfs_cat_delete(u32 cnid, struct inode *dir, const struct qstr *str)
>  	}
>  
>  	dir->i_size--;
> -	dir->i_mtime = dir->i_ctime = current_time(dir);
> +	dir->i_mtime = inode_set_ctime_current(dir);
>  	mark_inode_dirty(dir);
>  	res = 0;
>  out:
> @@ -337,7 +337,7 @@ int hfs_cat_move(u32 cnid, struct inode *src_dir, const struct qstr *src_name,
>  	if (err)
>  		goto out;
>  	dst_dir->i_size++;
> -	dst_dir->i_mtime = dst_dir->i_ctime = current_time(dst_dir);
> +	dst_dir->i_mtime = inode_set_ctime_current(dst_dir);
>  	mark_inode_dirty(dst_dir);
>  
>  	/* finally remove the old entry */
> @@ -349,7 +349,7 @@ int hfs_cat_move(u32 cnid, struct inode *src_dir, const struct qstr *src_name,
>  	if (err)
>  		goto out;
>  	src_dir->i_size--;
> -	src_dir->i_mtime = src_dir->i_ctime = current_time(src_dir);
> +	src_dir->i_mtime = inode_set_ctime_current(src_dir);
>  	mark_inode_dirty(src_dir);
>  
>  	type = entry.type;
> diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
> index 3e1e3dcf0b48..b75c26045df4 100644
> --- a/fs/hfs/dir.c
> +++ b/fs/hfs/dir.c
> @@ -263,7 +263,7 @@ static int hfs_remove(struct inode *dir, struct dentry *dentry)
>  	if (res)
>  		return res;
>  	clear_nlink(inode);
> -	inode->i_ctime = current_time(inode);
> +	inode_set_ctime_current(inode);
>  	hfs_delete_inode(inode);
>  	mark_inode_dirty(inode);
>  	return 0;
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index 441d7fc952e3..ee349b72cfb3 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -200,7 +200,7 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
>  	inode->i_uid = current_fsuid();
>  	inode->i_gid = current_fsgid();
>  	set_nlink(inode, 1);
> -	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> +	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
>  	HFS_I(inode)->flags = 0;
>  	HFS_I(inode)->rsrc_inode = NULL;
>  	HFS_I(inode)->fs_blocks = 0;
> @@ -355,8 +355,8 @@ static int hfs_read_inode(struct inode *inode, void *data)
>  			inode->i_mode |= S_IWUGO;
>  		inode->i_mode &= ~hsb->s_file_umask;
>  		inode->i_mode |= S_IFREG;
> -		inode->i_ctime = inode->i_atime = inode->i_mtime =
> -				hfs_m_to_utime(rec->file.MdDat);
> +		inode->i_atime = inode->i_mtime = inode_set_ctime_to_ts(inode,
> +									hfs_m_to_utime(rec->file.MdDat));
>  		inode->i_op = &hfs_file_inode_operations;
>  		inode->i_fop = &hfs_file_operations;
>  		inode->i_mapping->a_ops = &hfs_aops;
> @@ -366,8 +366,8 @@ static int hfs_read_inode(struct inode *inode, void *data)
>  		inode->i_size = be16_to_cpu(rec->dir.Val) + 2;
>  		HFS_I(inode)->fs_blocks = 0;
>  		inode->i_mode = S_IFDIR | (S_IRWXUGO & ~hsb->s_dir_umask);
> -		inode->i_ctime = inode->i_atime = inode->i_mtime =
> -				hfs_m_to_utime(rec->dir.MdDat);
> +		inode->i_atime = inode->i_mtime = inode_set_ctime_to_ts(inode,
> +									hfs_m_to_utime(rec->dir.MdDat));
>  		inode->i_op = &hfs_dir_inode_operations;
>  		inode->i_fop = &hfs_dir_operations;
>  		break;
> @@ -654,8 +654,7 @@ int hfs_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  
>  		truncate_setsize(inode, attr->ia_size);
>  		hfs_file_truncate(inode);
> -		inode->i_atime = inode->i_mtime = inode->i_ctime =
> -						  current_time(inode);
> +		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
>  	}
>  
>  	setattr_copy(&nop_mnt_idmap, inode, attr);
> diff --git a/fs/hfs/sysdep.c b/fs/hfs/sysdep.c
> index 2875961fdc10..dc27d418fbcd 100644
> --- a/fs/hfs/sysdep.c
> +++ b/fs/hfs/sysdep.c
> @@ -28,7 +28,9 @@ static int hfs_revalidate_dentry(struct dentry *dentry, unsigned int flags)
>  	/* fix up inode on a timezone change */
>  	diff = sys_tz.tz_minuteswest * 60 - HFS_I(inode)->tz_secondswest;
>  	if (diff) {
> -		inode->i_ctime.tv_sec += diff;
> +		struct timespec64 ctime = inode_get_ctime(inode);
> +
> +		inode_set_ctime(inode, ctime.tv_sec + diff, ctime.tv_nsec);
>  		inode->i_atime.tv_sec += diff;
>  		inode->i_mtime.tv_sec += diff;
>  		HFS_I(inode)->tz_secondswest += diff;
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
