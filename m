Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4D074A019
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 16:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjGFO4v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 10:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbjGFO4t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:56:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0284E2103;
        Thu,  6 Jul 2023 07:56:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 47D941F747;
        Thu,  6 Jul 2023 14:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688655384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4FDv8PFxGVHoEmGa8pg7R3F8HxY9lLeyFj125JbMca8=;
        b=ZBMuSMTPwXhf4fLC7+Z1bgABXpQG3fS5ksNt68iJ8mCHMA7n99mpeSoH/Dq2Q8gm6R2NnQ
        3ks7fdyw/cLbXmii60OzFFuWNLZ0scDYmp7sdNs2TYa71aBJErbjzb1UEwsfuo9icIifNH
        5+u9OnEuFaSfe6KAhZ9L/vTIB6ZoI0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688655384;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4FDv8PFxGVHoEmGa8pg7R3F8HxY9lLeyFj125JbMca8=;
        b=lgq/dkwyAmpv1OM8X/CD2btj9FXw+PgBJNCka1ETBmz91ZAlk7NSzKtCR9dfjYi+yOldu2
        DElbpUfuiK5OBqCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 39E22138FC;
        Thu,  6 Jul 2023 14:56:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TnkvDhjWpmRaBQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 14:56:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BC007A0707; Thu,  6 Jul 2023 16:56:23 +0200 (CEST)
Date:   Thu, 6 Jul 2023 16:56:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 87/92] shmem: convert to ctime accessor functions
Message-ID: <20230706145623.jkgc7awfs4xhioqy@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-85-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-85-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:52, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/shmem.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 1693134959c5..51aaaf479437 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1064,7 +1064,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
>  void shmem_truncate_range(struct inode *inode, loff_t lstart, loff_t lend)
>  {
>  	shmem_undo_range(inode, lstart, lend, false);
> -	inode->i_ctime = inode->i_mtime = current_time(inode);
> +	inode->i_mtime = inode_set_ctime_current(inode);
>  	inode_inc_iversion(inode);
>  }
>  EXPORT_SYMBOL_GPL(shmem_truncate_range);
> @@ -1161,9 +1161,9 @@ static int shmem_setattr(struct mnt_idmap *idmap,
>  	if (attr->ia_valid & ATTR_MODE)
>  		error = posix_acl_chmod(idmap, dentry, inode->i_mode);
>  	if (!error && update_ctime) {
> -		inode->i_ctime = current_time(inode);
> +		inode_set_ctime_current(inode);
>  		if (update_mtime)
> -			inode->i_mtime = inode->i_ctime;
> +			inode->i_mtime = inode_get_ctime(inode);
>  		inode_inc_iversion(inode);
>  	}
>  	return error;
> @@ -2394,7 +2394,7 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block
>  		inode->i_ino = ino;
>  		inode_init_owner(idmap, inode, dir, mode);
>  		inode->i_blocks = 0;
> -		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> +		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
>  		inode->i_generation = get_random_u32();
>  		info = SHMEM_I(inode);
>  		memset(info, 0, (char *)inode - (char *)info);
> @@ -3110,7 +3110,7 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
>  			goto out_iput;
>  
>  		dir->i_size += BOGO_DIRENT_SIZE;
> -		dir->i_ctime = dir->i_mtime = current_time(dir);
> +		dir->i_mtime = inode_set_ctime_current(dir);
>  		inode_inc_iversion(dir);
>  		d_instantiate(dentry, inode);
>  		dget(dentry); /* Extra count - pin the dentry in core */
> @@ -3193,7 +3193,8 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentr
>  	}
>  
>  	dir->i_size += BOGO_DIRENT_SIZE;
> -	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
> +	dir->i_mtime = inode_set_ctime_to_ts(dir,
> +					     inode_set_ctime_current(inode));
>  	inode_inc_iversion(dir);
>  	inc_nlink(inode);
>  	ihold(inode);	/* New dentry reference */
> @@ -3213,7 +3214,8 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
>  	simple_offset_remove(shmem_get_offset_ctx(dir), dentry);
>  
>  	dir->i_size -= BOGO_DIRENT_SIZE;
> -	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
> +	dir->i_mtime = inode_set_ctime_to_ts(dir,
> +					     inode_set_ctime_current(inode));
>  	inode_inc_iversion(dir);
>  	drop_nlink(inode);
>  	dput(dentry);	/* Undo the count from "create" - this does all the work */
> @@ -3360,7 +3362,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  		folio_put(folio);
>  	}
>  	dir->i_size += BOGO_DIRENT_SIZE;
> -	dir->i_ctime = dir->i_mtime = current_time(dir);
> +	dir->i_mtime = inode_set_ctime_current(dir);
>  	inode_inc_iversion(dir);
>  	d_instantiate(dentry, inode);
>  	dget(dentry);
> @@ -3438,7 +3440,7 @@ static int shmem_fileattr_set(struct mnt_idmap *idmap,
>  		(fa->flags & SHMEM_FL_USER_MODIFIABLE);
>  
>  	shmem_set_inode_flags(inode, info->fsflags);
> -	inode->i_ctime = current_time(inode);
> +	inode_set_ctime_current(inode);
>  	inode_inc_iversion(inode);
>  	return 0;
>  }
> @@ -3508,7 +3510,7 @@ static int shmem_xattr_handler_set(const struct xattr_handler *handler,
>  	name = xattr_full_name(handler, name);
>  	err = simple_xattr_set(&info->xattrs, name, value, size, flags, NULL);
>  	if (!err) {
> -		inode->i_ctime = current_time(inode);
> +		inode_set_ctime_current(inode);
>  		inode_inc_iversion(inode);
>  	}
>  	return err;
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
