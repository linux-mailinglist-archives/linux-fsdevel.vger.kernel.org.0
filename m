Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F13B7499A0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 12:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjGFKou (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 06:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGFKot (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:44:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA5B1BC2;
        Thu,  6 Jul 2023 03:44:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ED999229E6;
        Thu,  6 Jul 2023 10:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688640286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B9t1yX8QtWH+Q8UoCt6rkOESZQWw8jliHIlvo7XWN7Q=;
        b=JjaoaPL3qffj88F1KesDyv91xqs+6qLDjhr515N9rL+h7IU0C0zmjbOFTOn0hAC8ltH4OJ
        OsevYl8nqhEE2AuWTCZX42mbdJS2BBzcFL8YifbJqD93FIxzg68gVNbfZFWXSLHUaWNuJx
        ab0XV8dh/mSXzFVpyw2iV8QokTkWf2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688640286;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B9t1yX8QtWH+Q8UoCt6rkOESZQWw8jliHIlvo7XWN7Q=;
        b=6wnvT5/J5ovpk4p4zs560RCATS2EtWTQxu9QZ8KS308olyPVEJ/1piFaIid07SV+2B9lKt
        SqVe4Mv2MXtJnwCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DDBF2138EE;
        Thu,  6 Jul 2023 10:44:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FgQWNh6bpmT1fQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 10:44:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 73C55A0707; Thu,  6 Jul 2023 12:44:46 +0200 (CEST)
Date:   Thu, 6 Jul 2023 12:44:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 28/92] bfs: convert to ctime accessor functions
Message-ID: <20230706104446.gyx4d7msxoi5v377@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-26-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-26-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:00:53, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/bfs/dir.c   | 16 ++++++++--------
>  fs/bfs/inode.c |  5 ++---
>  2 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/bfs/dir.c b/fs/bfs/dir.c
> index d2e8a2a56b05..12b8af04dcb3 100644
> --- a/fs/bfs/dir.c
> +++ b/fs/bfs/dir.c
> @@ -97,7 +97,7 @@ static int bfs_create(struct mnt_idmap *idmap, struct inode *dir,
>  	set_bit(ino, info->si_imap);
>  	info->si_freei--;
>  	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
> -	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> +	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
>  	inode->i_blocks = 0;
>  	inode->i_op = &bfs_file_inops;
>  	inode->i_fop = &bfs_file_operations;
> @@ -158,7 +158,7 @@ static int bfs_link(struct dentry *old, struct inode *dir,
>  		return err;
>  	}
>  	inc_nlink(inode);
> -	inode->i_ctime = current_time(inode);
> +	inode_set_ctime_current(inode);
>  	mark_inode_dirty(inode);
>  	ihold(inode);
>  	d_instantiate(new, inode);
> @@ -187,9 +187,9 @@ static int bfs_unlink(struct inode *dir, struct dentry *dentry)
>  	}
>  	de->ino = 0;
>  	mark_buffer_dirty_inode(bh, dir);
> -	dir->i_ctime = dir->i_mtime = current_time(dir);
> +	dir->i_mtime = inode_set_ctime_current(dir);
>  	mark_inode_dirty(dir);
> -	inode->i_ctime = dir->i_ctime;
> +	inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
>  	inode_dec_link_count(inode);
>  	error = 0;
>  
> @@ -240,10 +240,10 @@ static int bfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>  			goto end_rename;
>  	}
>  	old_de->ino = 0;
> -	old_dir->i_ctime = old_dir->i_mtime = current_time(old_dir);
> +	old_dir->i_mtime = inode_set_ctime_current(old_dir);
>  	mark_inode_dirty(old_dir);
>  	if (new_inode) {
> -		new_inode->i_ctime = current_time(new_inode);
> +		inode_set_ctime_current(new_inode);
>  		inode_dec_link_count(new_inode);
>  	}
>  	mark_buffer_dirty_inode(old_bh, old_dir);
> @@ -292,9 +292,9 @@ static int bfs_add_entry(struct inode *dir, const struct qstr *child, int ino)
>  				pos = (block - sblock) * BFS_BSIZE + off;
>  				if (pos >= dir->i_size) {
>  					dir->i_size += BFS_DIRENT_SIZE;
> -					dir->i_ctime = current_time(dir);
> +					inode_set_ctime_current(dir);
>  				}
> -				dir->i_mtime = dir->i_ctime = current_time(dir);
> +				dir->i_mtime = inode_set_ctime_current(dir);
>  				mark_inode_dirty(dir);
>  				de->ino = cpu_to_le16((u16)ino);
>  				for (i = 0; i < BFS_NAMELEN; i++)
> diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
> index 1926bec2c850..e6a76ae9eb44 100644
> --- a/fs/bfs/inode.c
> +++ b/fs/bfs/inode.c
> @@ -82,10 +82,9 @@ struct inode *bfs_iget(struct super_block *sb, unsigned long ino)
>  	inode->i_blocks = BFS_FILEBLOCKS(di);
>  	inode->i_atime.tv_sec =  le32_to_cpu(di->i_atime);
>  	inode->i_mtime.tv_sec =  le32_to_cpu(di->i_mtime);
> -	inode->i_ctime.tv_sec =  le32_to_cpu(di->i_ctime);
> +	inode_set_ctime(inode, le32_to_cpu(di->i_ctime), 0);
>  	inode->i_atime.tv_nsec = 0;
>  	inode->i_mtime.tv_nsec = 0;
> -	inode->i_ctime.tv_nsec = 0;
>  
>  	brelse(bh);
>  	unlock_new_inode(inode);
> @@ -143,7 +142,7 @@ static int bfs_write_inode(struct inode *inode, struct writeback_control *wbc)
>  	di->i_nlink = cpu_to_le32(inode->i_nlink);
>  	di->i_atime = cpu_to_le32(inode->i_atime.tv_sec);
>  	di->i_mtime = cpu_to_le32(inode->i_mtime.tv_sec);
> -	di->i_ctime = cpu_to_le32(inode->i_ctime.tv_sec);
> +	di->i_ctime = cpu_to_le32(inode_get_ctime(inode).tv_sec);
>  	i_sblock = BFS_I(inode)->i_sblock;
>  	di->i_sblock = cpu_to_le32(i_sblock);
>  	di->i_eblock = cpu_to_le32(BFS_I(inode)->i_eblock);
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
