Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6CD749C7A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 14:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjGFMti (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 08:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjGFMt0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:49:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5380E2113;
        Thu,  6 Jul 2023 05:49:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E52FC21A09;
        Thu,  6 Jul 2023 12:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688647741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O9Iz3ZNG190IHqyYubwQqM5KddSrFr4od49jRunlzxM=;
        b=bIv0xpFmRr8u9GLnXU+wFzJDpdplMsjMKQ8mza9HVGv2rZOEBWz9v3W0KKe3zOkUy2qLz7
        Q/JCoTqMq1sd1sIveP9jgp858gqZnufoYH6/FEp//SZ9KWPo4VeLt3QCrlZxS1SLUtgHW0
        gCQ2ENdx2RzDcwAxZJpNQYVvcJgsMY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688647741;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O9Iz3ZNG190IHqyYubwQqM5KddSrFr4od49jRunlzxM=;
        b=iBD9WGeE1V3icpkGsabzq0XVXpnDMXXd90zHbjejHSjO8PRtd1AVBL0kcSEi2IlwYwS+NK
        efwa8Te/5NBRw0AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5EF6138FC;
        Thu,  6 Jul 2023 12:49:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AME4ND24pmStQgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 12:49:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7A2F1A0707; Thu,  6 Jul 2023 14:49:01 +0200 (CEST)
Date:   Thu, 6 Jul 2023 14:49:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 49/92] hfsplus: convert to ctime accessor functions
Message-ID: <20230706124901.2xciykc7zncfryhx@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-47-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-47-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:14, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/hfsplus/catalog.c |  8 ++++----
>  fs/hfsplus/dir.c     |  6 +++---
>  fs/hfsplus/inode.c   | 16 +++++++++-------
>  3 files changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
> index 35472cba750e..e71ae2537eaa 100644
> --- a/fs/hfsplus/catalog.c
> +++ b/fs/hfsplus/catalog.c
> @@ -312,7 +312,7 @@ int hfsplus_create_cat(u32 cnid, struct inode *dir,
>  	dir->i_size++;
>  	if (S_ISDIR(inode->i_mode))
>  		hfsplus_subfolders_inc(dir);
> -	dir->i_mtime = dir->i_ctime = current_time(dir);
> +	dir->i_mtime = inode_set_ctime_current(dir);
>  	hfsplus_mark_inode_dirty(dir, HFSPLUS_I_CAT_DIRTY);
>  
>  	hfs_find_exit(&fd);
> @@ -417,7 +417,7 @@ int hfsplus_delete_cat(u32 cnid, struct inode *dir, const struct qstr *str)
>  	dir->i_size--;
>  	if (type == HFSPLUS_FOLDER)
>  		hfsplus_subfolders_dec(dir);
> -	dir->i_mtime = dir->i_ctime = current_time(dir);
> +	dir->i_mtime = inode_set_ctime_current(dir);
>  	hfsplus_mark_inode_dirty(dir, HFSPLUS_I_CAT_DIRTY);
>  
>  	if (type == HFSPLUS_FILE || type == HFSPLUS_FOLDER) {
> @@ -494,7 +494,7 @@ int hfsplus_rename_cat(u32 cnid,
>  	dst_dir->i_size++;
>  	if (type == HFSPLUS_FOLDER)
>  		hfsplus_subfolders_inc(dst_dir);
> -	dst_dir->i_mtime = dst_dir->i_ctime = current_time(dst_dir);
> +	dst_dir->i_mtime = inode_set_ctime_current(dst_dir);
>  
>  	/* finally remove the old entry */
>  	err = hfsplus_cat_build_key(sb, src_fd.search_key,
> @@ -511,7 +511,7 @@ int hfsplus_rename_cat(u32 cnid,
>  	src_dir->i_size--;
>  	if (type == HFSPLUS_FOLDER)
>  		hfsplus_subfolders_dec(src_dir);
> -	src_dir->i_mtime = src_dir->i_ctime = current_time(src_dir);
> +	src_dir->i_mtime = inode_set_ctime_current(src_dir);
>  
>  	/* remove old thread entry */
>  	hfsplus_cat_build_key_with_cnid(sb, src_fd.search_key, cnid);
> diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
> index 56fb5f1312e7..f5c4b3e31a1c 100644
> --- a/fs/hfsplus/dir.c
> +++ b/fs/hfsplus/dir.c
> @@ -346,7 +346,7 @@ static int hfsplus_link(struct dentry *src_dentry, struct inode *dst_dir,
>  	inc_nlink(inode);
>  	hfsplus_instantiate(dst_dentry, inode, cnid);
>  	ihold(inode);
> -	inode->i_ctime = current_time(inode);
> +	inode_set_ctime_current(inode);
>  	mark_inode_dirty(inode);
>  	sbi->file_count++;
>  	hfsplus_mark_mdb_dirty(dst_dir->i_sb);
> @@ -405,7 +405,7 @@ static int hfsplus_unlink(struct inode *dir, struct dentry *dentry)
>  			hfsplus_delete_inode(inode);
>  	} else
>  		sbi->file_count--;
> -	inode->i_ctime = current_time(inode);
> +	inode_set_ctime_current(inode);
>  	mark_inode_dirty(inode);
>  out:
>  	mutex_unlock(&sbi->vh_mutex);
> @@ -426,7 +426,7 @@ static int hfsplus_rmdir(struct inode *dir, struct dentry *dentry)
>  	if (res)
>  		goto out;
>  	clear_nlink(inode);
> -	inode->i_ctime = current_time(inode);
> +	inode_set_ctime_current(inode);
>  	hfsplus_delete_inode(inode);
>  	mark_inode_dirty(inode);
>  out:
> diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
> index 7d1a675e037d..40c61ab4a918 100644
> --- a/fs/hfsplus/inode.c
> +++ b/fs/hfsplus/inode.c
> @@ -267,7 +267,7 @@ static int hfsplus_setattr(struct mnt_idmap *idmap,
>  		}
>  		truncate_setsize(inode, attr->ia_size);
>  		hfsplus_file_truncate(inode);
> -		inode->i_mtime = inode->i_ctime = current_time(inode);
> +		inode->i_mtime = inode_set_ctime_current(inode);
>  	}
>  
>  	setattr_copy(&nop_mnt_idmap, inode, attr);
> @@ -392,7 +392,7 @@ struct inode *hfsplus_new_inode(struct super_block *sb, struct inode *dir,
>  	inode->i_ino = sbi->next_cnid++;
>  	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
>  	set_nlink(inode, 1);
> -	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> +	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
>  
>  	hip = HFSPLUS_I(inode);
>  	INIT_LIST_HEAD(&hip->open_dir_list);
> @@ -523,7 +523,8 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
>  		inode->i_size = 2 + be32_to_cpu(folder->valence);
>  		inode->i_atime = hfsp_mt2ut(folder->access_date);
>  		inode->i_mtime = hfsp_mt2ut(folder->content_mod_date);
> -		inode->i_ctime = hfsp_mt2ut(folder->attribute_mod_date);
> +		inode_set_ctime_to_ts(inode,
> +				      hfsp_mt2ut(folder->attribute_mod_date));
>  		HFSPLUS_I(inode)->create_date = folder->create_date;
>  		HFSPLUS_I(inode)->fs_blocks = 0;
>  		if (folder->flags & cpu_to_be16(HFSPLUS_HAS_FOLDER_COUNT)) {
> @@ -564,7 +565,8 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
>  		}
>  		inode->i_atime = hfsp_mt2ut(file->access_date);
>  		inode->i_mtime = hfsp_mt2ut(file->content_mod_date);
> -		inode->i_ctime = hfsp_mt2ut(file->attribute_mod_date);
> +		inode_set_ctime_to_ts(inode,
> +				      hfsp_mt2ut(file->attribute_mod_date));
>  		HFSPLUS_I(inode)->create_date = file->create_date;
>  	} else {
>  		pr_err("bad catalog entry used to create inode\n");
> @@ -609,7 +611,7 @@ int hfsplus_cat_write_inode(struct inode *inode)
>  		hfsplus_cat_set_perms(inode, &folder->permissions);
>  		folder->access_date = hfsp_ut2mt(inode->i_atime);
>  		folder->content_mod_date = hfsp_ut2mt(inode->i_mtime);
> -		folder->attribute_mod_date = hfsp_ut2mt(inode->i_ctime);
> +		folder->attribute_mod_date = hfsp_ut2mt(inode_get_ctime(inode));
>  		folder->valence = cpu_to_be32(inode->i_size - 2);
>  		if (folder->flags & cpu_to_be16(HFSPLUS_HAS_FOLDER_COUNT)) {
>  			folder->subfolders =
> @@ -644,7 +646,7 @@ int hfsplus_cat_write_inode(struct inode *inode)
>  			file->flags &= cpu_to_be16(~HFSPLUS_FILE_LOCKED);
>  		file->access_date = hfsp_ut2mt(inode->i_atime);
>  		file->content_mod_date = hfsp_ut2mt(inode->i_mtime);
> -		file->attribute_mod_date = hfsp_ut2mt(inode->i_ctime);
> +		file->attribute_mod_date = hfsp_ut2mt(inode_get_ctime(inode));
>  		hfs_bnode_write(fd.bnode, &entry, fd.entryoffset,
>  					 sizeof(struct hfsplus_cat_file));
>  	}
> @@ -700,7 +702,7 @@ int hfsplus_fileattr_set(struct mnt_idmap *idmap,
>  	else
>  		hip->userflags &= ~HFSPLUS_FLG_NODUMP;
>  
> -	inode->i_ctime = current_time(inode);
> +	inode_set_ctime_current(inode);
>  	mark_inode_dirty(inode);
>  
>  	return 0;
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
