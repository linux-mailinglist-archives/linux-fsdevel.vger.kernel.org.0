Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589E3749E19
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 15:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjGFNrP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 09:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjGFNrO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:47:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B9C1995;
        Thu,  6 Jul 2023 06:47:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8C7D41F747;
        Thu,  6 Jul 2023 13:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688651230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zpW8zB4IcfKFCE2R67lhTAOH/KOPK/cZuvtR2VN2Yto=;
        b=MIZTgAt60w1QkNPUAMbkVgwtICMO55v/QUqm7JaVusDwFuDzh2D89L4PGmVbsW4Efdk0mP
        mnCLLl7nTdQyhSANyNcsp6gA8Uw9dOpfc/gMrZ/nzeFli6kjXvXtsSxexVNg6pTcRHzTA9
        9bVMhwwX3eqkQ4QdVnHlF9Q1psaBGjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688651230;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zpW8zB4IcfKFCE2R67lhTAOH/KOPK/cZuvtR2VN2Yto=;
        b=gYkKJ9ORBERVSho0g3CGWkzEOHcwKvcXfZtNx1XHsu7RrhoGeVCwyL/eEQZjujDP2QZNnH
        lc07/I/GmmJlyCDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D771138EE;
        Thu,  6 Jul 2023 13:47:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gySUHt7FpmSjYAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 13:47:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 00C39A0707; Thu,  6 Jul 2023 15:47:09 +0200 (CEST)
Date:   Thu, 6 Jul 2023 15:47:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev
Subject: Re: [PATCH v2 61/92] ntfs3: convert to ctime accessor functions
Message-ID: <20230706134709.26ryxceirc6hctfb@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-59-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-59-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:26, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ntfs3/file.c    |  6 +++---
>  fs/ntfs3/frecord.c |  3 ++-
>  fs/ntfs3/inode.c   | 14 ++++++++------
>  fs/ntfs3/namei.c   |  4 ++--
>  fs/ntfs3/xattr.c   |  4 ++--
>  5 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> index 1d6c824246c4..12788601dc84 100644
> --- a/fs/ntfs3/file.c
> +++ b/fs/ntfs3/file.c
> @@ -342,7 +342,7 @@ static int ntfs_extend(struct inode *inode, loff_t pos, size_t count,
>  		err = 0;
>  	}
>  
> -	inode->i_ctime = inode->i_mtime = current_time(inode);
> +	inode->i_mtime = inode_set_ctime_current(inode);
>  	mark_inode_dirty(inode);
>  
>  	if (IS_SYNC(inode)) {
> @@ -400,7 +400,7 @@ static int ntfs_truncate(struct inode *inode, loff_t new_size)
>  	ni_unlock(ni);
>  
>  	ni->std_fa |= FILE_ATTRIBUTE_ARCHIVE;
> -	inode->i_ctime = inode->i_mtime = current_time(inode);
> +	inode->i_mtime = inode_set_ctime_current(inode);
>  	if (!IS_DIRSYNC(inode)) {
>  		dirty = 1;
>  	} else {
> @@ -642,7 +642,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
>  		filemap_invalidate_unlock(mapping);
>  
>  	if (!err) {
> -		inode->i_ctime = inode->i_mtime = current_time(inode);
> +		inode->i_mtime = inode_set_ctime_current(inode);
>  		mark_inode_dirty(inode);
>  	}
>  
> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
> index 16bd9faa2d28..2b85cb10f0be 100644
> --- a/fs/ntfs3/frecord.c
> +++ b/fs/ntfs3/frecord.c
> @@ -3265,6 +3265,7 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
>  	if (is_rec_inuse(ni->mi.mrec) &&
>  	    !(sbi->flags & NTFS_FLAGS_LOG_REPLAYING) && inode->i_nlink) {
>  		bool modified = false;
> +		struct timespec64 ctime = inode_get_ctime(inode);
>  
>  		/* Update times in standard attribute. */
>  		std = ni_std(ni);
> @@ -3280,7 +3281,7 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
>  			modified = true;
>  		}
>  
> -		dup.c_time = kernel2nt(&inode->i_ctime);
> +		dup.c_time = kernel2nt(&ctime);
>  		if (std->c_time != dup.c_time) {
>  			std->c_time = dup.c_time;
>  			modified = true;
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index dc7e7ab701c6..4123e126c4d0 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -44,6 +44,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
>  	u64 t64;
>  	struct MFT_REC *rec;
>  	struct runs_tree *run;
> +	struct timespec64 ctime;
>  
>  	inode->i_op = NULL;
>  	/* Setup 'uid' and 'gid' */
> @@ -169,7 +170,8 @@ static struct inode *ntfs_read_mft(struct inode *inode,
>  		nt2kernel(std5->cr_time, &ni->i_crtime);
>  #endif
>  		nt2kernel(std5->a_time, &inode->i_atime);
> -		nt2kernel(std5->c_time, &inode->i_ctime);
> +		ctime = inode_get_ctime(inode);
> +		nt2kernel(std5->c_time, &ctime);
>  		nt2kernel(std5->m_time, &inode->i_mtime);
>  
>  		ni->std_fa = std5->fa;
> @@ -958,7 +960,7 @@ int ntfs_write_end(struct file *file, struct address_space *mapping, loff_t pos,
>  
>  	if (err >= 0) {
>  		if (!(ni->std_fa & FILE_ATTRIBUTE_ARCHIVE)) {
> -			inode->i_ctime = inode->i_mtime = current_time(inode);
> +			inode->i_mtime = inode_set_ctime_current(inode);
>  			ni->std_fa |= FILE_ATTRIBUTE_ARCHIVE;
>  			dirty = true;
>  		}
> @@ -1658,8 +1660,8 @@ struct inode *ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
>  	d_instantiate(dentry, inode);
>  
>  	/* Set original time. inode times (i_ctime) may be changed in ntfs_init_acl. */
> -	inode->i_atime = inode->i_mtime = inode->i_ctime = dir->i_mtime =
> -		dir->i_ctime = ni->i_crtime;
> +	inode->i_atime = inode->i_mtime = inode_set_ctime_to_ts(inode, ni->i_crtime);
> +	dir->i_mtime = inode_set_ctime_to_ts(dir, ni->i_crtime);
>  
>  	mark_inode_dirty(dir);
>  	mark_inode_dirty(inode);
> @@ -1765,9 +1767,9 @@ int ntfs_unlink_inode(struct inode *dir, const struct dentry *dentry)
>  
>  	if (!err) {
>  		drop_nlink(inode);
> -		dir->i_mtime = dir->i_ctime = current_time(dir);
> +		dir->i_mtime = inode_set_ctime_current(dir);
>  		mark_inode_dirty(dir);
> -		inode->i_ctime = dir->i_ctime;
> +		inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
>  		if (inode->i_nlink)
>  			mark_inode_dirty(inode);
>  	} else if (!ni_remove_name_undo(dir_ni, ni, de, de2, undo_remove)) {
> diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
> index bfd986699f9e..ad430d50bd79 100644
> --- a/fs/ntfs3/namei.c
> +++ b/fs/ntfs3/namei.c
> @@ -156,8 +156,8 @@ static int ntfs_link(struct dentry *ode, struct inode *dir, struct dentry *de)
>  	err = ntfs_link_inode(inode, de);
>  
>  	if (!err) {
> -		dir->i_ctime = dir->i_mtime = inode->i_ctime =
> -			current_time(dir);
> +		dir->i_mtime = inode_set_ctime_to_ts(inode,
> +						     inode_set_ctime_current(dir));
>  		mark_inode_dirty(inode);
>  		mark_inode_dirty(dir);
>  		d_instantiate(de, inode);
> diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
> index 023f314e8950..29fd391899e5 100644
> --- a/fs/ntfs3/xattr.c
> +++ b/fs/ntfs3/xattr.c
> @@ -637,7 +637,7 @@ static noinline int ntfs_set_acl_ex(struct mnt_idmap *idmap,
>  	if (!err) {
>  		set_cached_acl(inode, type, acl);
>  		inode->i_mode = mode;
> -		inode->i_ctime = current_time(inode);
> +		inode_set_ctime_current(inode);
>  		mark_inode_dirty(inode);
>  	}
>  
> @@ -924,7 +924,7 @@ static noinline int ntfs_setxattr(const struct xattr_handler *handler,
>  			  NULL);
>  
>  out:
> -	inode->i_ctime = current_time(inode);
> +	inode_set_ctime_current(inode);
>  	mark_inode_dirty(inode);
>  
>  	return err;
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
