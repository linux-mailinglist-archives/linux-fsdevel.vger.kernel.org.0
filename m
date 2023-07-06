Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7599749E91
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 16:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjGFOGM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 10:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjGFOGL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:06:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0151BF9;
        Thu,  6 Jul 2023 07:05:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 740D91F85D;
        Thu,  6 Jul 2023 14:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688652347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=37TkHVpRaQOws2Z6T7ZF3WK41nacPF9PuTgpjRRMHAI=;
        b=eHcfOlD85IhkdfaYTSEwl4nv13cFmX0hE/et0hMHFKZyoRK5yofOkevWnv2pZ+7lwHYi9k
        2BYYH5wpWfQ5+LFw1HOtWN6rY1q8ksTVTSsgTnGYqWQLa2A4KS5y2QIiYJQG0oN/VbAHF9
        QddtzhsYrV7lWEfM1VEDz/OrG7Ex+d4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688652347;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=37TkHVpRaQOws2Z6T7ZF3WK41nacPF9PuTgpjRRMHAI=;
        b=GCNLpPx0qfMh+eX+tPRlbQNPDTg3tpfGCEadJ2D8R4fPR1KCRUQfXHUZNF0PMaDD3ofxfC
        Zs6y/YWgLvbe+6BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 62637138EE;
        Thu,  6 Jul 2023 14:05:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id K1cEGDvKpmRIagAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 14:05:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EC72CA0707; Thu,  6 Jul 2023 16:05:46 +0200 (CEST)
Date:   Thu, 6 Jul 2023 16:05:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 76/92] sysv: convert to ctime accessor functions
Message-ID: <20230706140546.monu3i55buhq62p4@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-74-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-74-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:41, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/sysv/dir.c    | 6 +++---
>  fs/sysv/ialloc.c | 2 +-
>  fs/sysv/inode.c  | 5 ++---
>  fs/sysv/itree.c  | 4 ++--
>  fs/sysv/namei.c  | 6 +++---
>  5 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
> index 0140010aa0c3..2f5ead88d00b 100644
> --- a/fs/sysv/dir.c
> +++ b/fs/sysv/dir.c
> @@ -224,7 +224,7 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
>  	memset (de->name + namelen, 0, SYSV_DIRSIZE - namelen - 2);
>  	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
>  	dir_commit_chunk(page, pos, SYSV_DIRSIZE);
> -	dir->i_mtime = dir->i_ctime = current_time(dir);
> +	dir->i_mtime = inode_set_ctime_current(dir);
>  	mark_inode_dirty(dir);
>  	err = sysv_handle_dirsync(dir);
>  out_page:
> @@ -249,7 +249,7 @@ int sysv_delete_entry(struct sysv_dir_entry *de, struct page *page)
>  	}
>  	de->inode = 0;
>  	dir_commit_chunk(page, pos, SYSV_DIRSIZE);
> -	inode->i_ctime = inode->i_mtime = current_time(inode);
> +	inode->i_mtime = inode_set_ctime_current(inode);
>  	mark_inode_dirty(inode);
>  	return sysv_handle_dirsync(inode);
>  }
> @@ -346,7 +346,7 @@ int sysv_set_link(struct sysv_dir_entry *de, struct page *page,
>  	}
>  	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
>  	dir_commit_chunk(page, pos, SYSV_DIRSIZE);
> -	dir->i_mtime = dir->i_ctime = current_time(dir);
> +	dir->i_mtime = inode_set_ctime_current(dir);
>  	mark_inode_dirty(dir);
>  	return sysv_handle_dirsync(inode);
>  }
> diff --git a/fs/sysv/ialloc.c b/fs/sysv/ialloc.c
> index e732879036ab..6719da5889d9 100644
> --- a/fs/sysv/ialloc.c
> +++ b/fs/sysv/ialloc.c
> @@ -165,7 +165,7 @@ struct inode * sysv_new_inode(const struct inode * dir, umode_t mode)
>  	dirty_sb(sb);
>  	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
>  	inode->i_ino = fs16_to_cpu(sbi, ino);
> -	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> +	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
>  	inode->i_blocks = 0;
>  	memset(SYSV_I(inode)->i_data, 0, sizeof(SYSV_I(inode)->i_data));
>  	SYSV_I(inode)->i_dir_start_lookup = 0;
> diff --git a/fs/sysv/inode.c b/fs/sysv/inode.c
> index 9e8d4a6fb2f3..0aa3827d8178 100644
> --- a/fs/sysv/inode.c
> +++ b/fs/sysv/inode.c
> @@ -202,8 +202,7 @@ struct inode *sysv_iget(struct super_block *sb, unsigned int ino)
>  	inode->i_size = fs32_to_cpu(sbi, raw_inode->i_size);
>  	inode->i_atime.tv_sec = fs32_to_cpu(sbi, raw_inode->i_atime);
>  	inode->i_mtime.tv_sec = fs32_to_cpu(sbi, raw_inode->i_mtime);
> -	inode->i_ctime.tv_sec = fs32_to_cpu(sbi, raw_inode->i_ctime);
> -	inode->i_ctime.tv_nsec = 0;
> +	inode_set_ctime(inode, fs32_to_cpu(sbi, raw_inode->i_ctime), 0);
>  	inode->i_atime.tv_nsec = 0;
>  	inode->i_mtime.tv_nsec = 0;
>  	inode->i_blocks = 0;
> @@ -256,7 +255,7 @@ static int __sysv_write_inode(struct inode *inode, int wait)
>  	raw_inode->i_size = cpu_to_fs32(sbi, inode->i_size);
>  	raw_inode->i_atime = cpu_to_fs32(sbi, inode->i_atime.tv_sec);
>  	raw_inode->i_mtime = cpu_to_fs32(sbi, inode->i_mtime.tv_sec);
> -	raw_inode->i_ctime = cpu_to_fs32(sbi, inode->i_ctime.tv_sec);
> +	raw_inode->i_ctime = cpu_to_fs32(sbi, inode_get_ctime(inode).tv_sec);
>  
>  	si = SYSV_I(inode);
>  	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
> diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
> index 58d7f43a1371..dba6a2ef26f1 100644
> --- a/fs/sysv/itree.c
> +++ b/fs/sysv/itree.c
> @@ -183,7 +183,7 @@ static inline int splice_branch(struct inode *inode,
>  	*where->p = where->key;
>  	write_unlock(&pointers_lock);
>  
> -	inode->i_ctime = current_time(inode);
> +	inode_set_ctime_current(inode);
>  
>  	/* had we spliced it onto indirect block? */
>  	if (where->bh)
> @@ -423,7 +423,7 @@ void sysv_truncate (struct inode * inode)
>  		}
>  		n++;
>  	}
> -	inode->i_mtime = inode->i_ctime = current_time(inode);
> +	inode->i_mtime = inode_set_ctime_current(inode);
>  	if (IS_SYNC(inode))
>  		sysv_sync_inode (inode);
>  	else
> diff --git a/fs/sysv/namei.c b/fs/sysv/namei.c
> index fcf163fea3ad..d6b73798071b 100644
> --- a/fs/sysv/namei.c
> +++ b/fs/sysv/namei.c
> @@ -103,7 +103,7 @@ static int sysv_link(struct dentry * old_dentry, struct inode * dir,
>  {
>  	struct inode *inode = d_inode(old_dentry);
>  
> -	inode->i_ctime = current_time(inode);
> +	inode_set_ctime_current(inode);
>  	inode_inc_link_count(inode);
>  	ihold(inode);
>  
> @@ -161,7 +161,7 @@ static int sysv_unlink(struct inode * dir, struct dentry * dentry)
>  
>  	err = sysv_delete_entry(de, page);
>  	if (!err) {
> -		inode->i_ctime = dir->i_ctime;
> +		inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
>  		inode_dec_link_count(inode);
>  	}
>  	unmap_and_put_page(page, de);
> @@ -230,7 +230,7 @@ static int sysv_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>  		unmap_and_put_page(new_page, new_de);
>  		if (err)
>  			goto out_dir;
> -		new_inode->i_ctime = current_time(new_inode);
> +		inode_set_ctime_current(new_inode);
>  		if (dir_de)
>  			drop_nlink(new_inode);
>  		inode_dec_link_count(new_inode);
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
