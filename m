Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49EB1749CD1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 14:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjGFM5g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 08:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGFM5f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:57:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870E91986;
        Thu,  6 Jul 2023 05:57:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 41B19219A6;
        Thu,  6 Jul 2023 12:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688648253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DaB1i/eVjGm82CcOaGtLXHKjYlR+vBQyld2q2wv94SI=;
        b=T1nQESGafOfkoRRRhaJm/poP14mik5DvUOE1rH9aI93vyUdn/ZZ3bxetgzuKbit43Fs3rQ
        nWKIt5gyRT52tTHed5zkLRftO2GMD2jRd5m0dD8dyMT35HCViDQEQIui9n4bxUVc+iODpz
        /WnwK+Ien9gBIVKkX80Nv/rrkk/elKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688648253;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DaB1i/eVjGm82CcOaGtLXHKjYlR+vBQyld2q2wv94SI=;
        b=2LVJpl4XlOHL60QqrV7MkIDkNOVeoZLN8Kg9iutwYXOhBc0Dv3H6YUOkmYalAsVVpxucF/
        Jol7iowA2RHNtGDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2AABF138FC;
        Thu,  6 Jul 2023 12:57:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OSBmCj26pmQ7RwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 12:57:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B5994A0707; Thu,  6 Jul 2023 14:57:32 +0200 (CEST)
Date:   Thu, 6 Jul 2023 14:57:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 79/92] udf: convert to ctime accessor functions
Message-ID: <20230706125732.efftdv4ydag3qvrw@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-77-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-77-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:44, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/udf/ialloc.c |  2 +-
>  fs/udf/inode.c  | 17 ++++++++++-------
>  fs/udf/namei.c  | 24 ++++++++++++------------
>  3 files changed, 23 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/udf/ialloc.c b/fs/udf/ialloc.c
> index 5f7ac8c84798..6b558cbbeb6b 100644
> --- a/fs/udf/ialloc.c
> +++ b/fs/udf/ialloc.c
> @@ -100,7 +100,7 @@ struct inode *udf_new_inode(struct inode *dir, umode_t mode)
>  		iinfo->i_alloc_type = ICBTAG_FLAG_AD_SHORT;
>  	else
>  		iinfo->i_alloc_type = ICBTAG_FLAG_AD_LONG;
> -	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> +	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
>  	iinfo->i_crtime = inode->i_mtime;
>  	if (unlikely(insert_inode_locked(inode) < 0)) {
>  		make_bad_inode(inode);
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index 28cdfc57d946..d089795074e8 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -910,7 +910,7 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
>  	map->oflags = UDF_BLK_NEW | UDF_BLK_MAPPED;
>  	iinfo->i_next_alloc_block = map->lblk + 1;
>  	iinfo->i_next_alloc_goal = newblocknum + 1;
> -	inode->i_ctime = current_time(inode);
> +	inode_set_ctime_current(inode);
>  
>  	if (IS_SYNC(inode))
>  		udf_sync_inode(inode);
> @@ -1298,7 +1298,7 @@ int udf_setsize(struct inode *inode, loff_t newsize)
>  			goto out_unlock;
>  	}
>  update_time:
> -	inode->i_mtime = inode->i_ctime = current_time(inode);
> +	inode->i_mtime = inode_set_ctime_current(inode);
>  	if (IS_SYNC(inode))
>  		udf_sync_inode(inode);
>  	else
> @@ -1329,6 +1329,7 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
>  	int bs = inode->i_sb->s_blocksize;
>  	int ret = -EIO;
>  	uint32_t uid, gid;
> +	struct timespec64 ctime;
>  
>  reread:
>  	if (iloc->partitionReferenceNum >= sbi->s_partitions) {
> @@ -1507,7 +1508,8 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
>  
>  		udf_disk_stamp_to_time(&inode->i_atime, fe->accessTime);
>  		udf_disk_stamp_to_time(&inode->i_mtime, fe->modificationTime);
> -		udf_disk_stamp_to_time(&inode->i_ctime, fe->attrTime);
> +		udf_disk_stamp_to_time(&ctime, fe->attrTime);
> +		inode_set_ctime_to_ts(inode, ctime);
>  
>  		iinfo->i_unique = le64_to_cpu(fe->uniqueID);
>  		iinfo->i_lenEAttr = le32_to_cpu(fe->lengthExtendedAttr);
> @@ -1522,7 +1524,8 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
>  		udf_disk_stamp_to_time(&inode->i_atime, efe->accessTime);
>  		udf_disk_stamp_to_time(&inode->i_mtime, efe->modificationTime);
>  		udf_disk_stamp_to_time(&iinfo->i_crtime, efe->createTime);
> -		udf_disk_stamp_to_time(&inode->i_ctime, efe->attrTime);
> +		udf_disk_stamp_to_time(&ctime, efe->attrTime);
> +		inode_set_ctime_to_ts(inode, ctime);
>  
>  		iinfo->i_unique = le64_to_cpu(efe->uniqueID);
>  		iinfo->i_lenEAttr = le32_to_cpu(efe->lengthExtendedAttr);
> @@ -1799,7 +1802,7 @@ static int udf_update_inode(struct inode *inode, int do_sync)
>  
>  		udf_time_to_disk_stamp(&fe->accessTime, inode->i_atime);
>  		udf_time_to_disk_stamp(&fe->modificationTime, inode->i_mtime);
> -		udf_time_to_disk_stamp(&fe->attrTime, inode->i_ctime);
> +		udf_time_to_disk_stamp(&fe->attrTime, inode_get_ctime(inode));
>  		memset(&(fe->impIdent), 0, sizeof(struct regid));
>  		strcpy(fe->impIdent.ident, UDF_ID_DEVELOPER);
>  		fe->impIdent.identSuffix[0] = UDF_OS_CLASS_UNIX;
> @@ -1830,12 +1833,12 @@ static int udf_update_inode(struct inode *inode, int do_sync)
>  
>  		udf_adjust_time(iinfo, inode->i_atime);
>  		udf_adjust_time(iinfo, inode->i_mtime);
> -		udf_adjust_time(iinfo, inode->i_ctime);
> +		udf_adjust_time(iinfo, inode_get_ctime(inode));
>  
>  		udf_time_to_disk_stamp(&efe->accessTime, inode->i_atime);
>  		udf_time_to_disk_stamp(&efe->modificationTime, inode->i_mtime);
>  		udf_time_to_disk_stamp(&efe->createTime, iinfo->i_crtime);
> -		udf_time_to_disk_stamp(&efe->attrTime, inode->i_ctime);
> +		udf_time_to_disk_stamp(&efe->attrTime, inode_get_ctime(inode));
>  
>  		memset(&(efe->impIdent), 0, sizeof(efe->impIdent));
>  		strcpy(efe->impIdent.ident, UDF_ID_DEVELOPER);
> diff --git a/fs/udf/namei.c b/fs/udf/namei.c
> index a95579b043ab..ae55ab8859b6 100644
> --- a/fs/udf/namei.c
> +++ b/fs/udf/namei.c
> @@ -365,7 +365,7 @@ static int udf_add_nondir(struct dentry *dentry, struct inode *inode)
>  	*(__le32 *)((struct allocDescImpUse *)iter.fi.icb.impUse)->impUse =
>  		cpu_to_le32(iinfo->i_unique & 0x00000000FFFFFFFFUL);
>  	udf_fiiter_write_fi(&iter, NULL);
> -	dir->i_ctime = dir->i_mtime = current_time(dir);
> +	dir->i_mtime = inode_set_ctime_current(dir);
>  	mark_inode_dirty(dir);
>  	udf_fiiter_release(&iter);
>  	udf_add_fid_counter(dir->i_sb, false, 1);
> @@ -471,7 +471,7 @@ static int udf_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	udf_fiiter_release(&iter);
>  	udf_add_fid_counter(dir->i_sb, true, 1);
>  	inc_nlink(dir);
> -	dir->i_ctime = dir->i_mtime = current_time(dir);
> +	dir->i_mtime = inode_set_ctime_current(dir);
>  	mark_inode_dirty(dir);
>  	d_instantiate_new(dentry, inode);
>  
> @@ -523,8 +523,8 @@ static int udf_rmdir(struct inode *dir, struct dentry *dentry)
>  	inode->i_size = 0;
>  	inode_dec_link_count(dir);
>  	udf_add_fid_counter(dir->i_sb, true, -1);
> -	inode->i_ctime = dir->i_ctime = dir->i_mtime =
> -						current_time(inode);
> +	dir->i_mtime = inode_set_ctime_to_ts(dir,
> +					     inode_set_ctime_current(inode));
>  	mark_inode_dirty(dir);
>  	ret = 0;
>  end_rmdir:
> @@ -555,11 +555,11 @@ static int udf_unlink(struct inode *dir, struct dentry *dentry)
>  		set_nlink(inode, 1);
>  	}
>  	udf_fiiter_delete_entry(&iter);
> -	dir->i_ctime = dir->i_mtime = current_time(dir);
> +	dir->i_mtime = inode_set_ctime_current(dir);
>  	mark_inode_dirty(dir);
>  	inode_dec_link_count(inode);
>  	udf_add_fid_counter(dir->i_sb, false, -1);
> -	inode->i_ctime = dir->i_ctime;
> +	inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
>  	ret = 0;
>  end_unlink:
>  	udf_fiiter_release(&iter);
> @@ -746,9 +746,9 @@ static int udf_link(struct dentry *old_dentry, struct inode *dir,
>  
>  	inc_nlink(inode);
>  	udf_add_fid_counter(dir->i_sb, false, 1);
> -	inode->i_ctime = current_time(inode);
> +	inode_set_ctime_current(inode);
>  	mark_inode_dirty(inode);
> -	dir->i_ctime = dir->i_mtime = current_time(dir);
> +	dir->i_mtime = inode_set_ctime_current(dir);
>  	mark_inode_dirty(dir);
>  	ihold(inode);
>  	d_instantiate(dentry, inode);
> @@ -833,7 +833,7 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>  	 * Like most other Unix systems, set the ctime for inodes on a
>  	 * rename.
>  	 */
> -	old_inode->i_ctime = current_time(old_inode);
> +	inode_set_ctime_current(old_inode);
>  	mark_inode_dirty(old_inode);
>  
>  	/*
> @@ -861,13 +861,13 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>  	}
>  
>  	if (new_inode) {
> -		new_inode->i_ctime = current_time(new_inode);
> +		inode_set_ctime_current(new_inode);
>  		inode_dec_link_count(new_inode);
>  		udf_add_fid_counter(old_dir->i_sb, S_ISDIR(new_inode->i_mode),
>  				    -1);
>  	}
> -	old_dir->i_ctime = old_dir->i_mtime = current_time(old_dir);
> -	new_dir->i_ctime = new_dir->i_mtime = current_time(new_dir);
> +	old_dir->i_mtime = inode_set_ctime_current(old_dir);
> +	new_dir->i_mtime = inode_set_ctime_current(new_dir);
>  	mark_inode_dirty(old_dir);
>  	mark_inode_dirty(new_dir);
>  
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
