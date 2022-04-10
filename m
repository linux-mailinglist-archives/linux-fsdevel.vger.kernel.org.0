Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2448E4FAE93
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Apr 2022 17:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237759AbiDJPpq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Apr 2022 11:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbiDJPpp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Apr 2022 11:45:45 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3EEEE34B9B
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Apr 2022 08:43:32 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 03D1215F93A;
        Mon, 11 Apr 2022 00:43:32 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 23AFhT3i044711
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 11 Apr 2022 00:43:30 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 23AFhTNt170953
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 11 Apr 2022 00:43:29 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 23AFhSLp170950;
        Mon, 11 Apr 2022 00:43:28 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Chung-Chiang Cheng <cccheng@synology.com>
Cc:     linux-fsdevel@vger.kernel.org, shepjeng@gmail.com,
        kernel@cccheng.net
Subject: Re: [PATCH v2 2/3] fat: make ctime and mtime identical explicitly
References: <20220406085459.102691-1-cccheng@synology.com>
        <20220406085459.102691-2-cccheng@synology.com>
Date:   Mon, 11 Apr 2022 00:43:28 +0900
In-Reply-To: <20220406085459.102691-2-cccheng@synology.com> (Chung-Chiang
        Cheng's message of "Wed, 6 Apr 2022 16:54:58 +0800")
Message-ID: <87h771ueov.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Chung-Chiang Cheng <cccheng@synology.com> writes:

> FAT supports creation time but not change time, and there was no
> corresponding timestamp for creation time in previous VFS. The
> original implementation took the compromise of saving the in-memory
> change time into the on-disk creation time field, but this would lead
> to compatibility issues with non-linux systems.
>
> In address this issue, this patch changes the behavior of ctime. ctime
> will no longer be loaded and stored from the creation time on disk.
> Instead of that, it'll be consistent with the in-memory mtime and
> share the same on-disk field.

Hm, this changes mtime includes ctime update. So, the question is, this
behavior is compatible with Windows's fatfs behavior? E.g. Windows
updates mtime on rename?

If not same behavior with Windows, new behavior is new incompatible
behavior, and looks break fundamental purpose of this.

I was thinking, we ignores ctime update (because fatfs doesn't have) and
always same with mtime. What behavior was actually compatible with
Windows?

Thanks.

> Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
> ---
>  fs/fat/dir.c         |  2 +-
>  fs/fat/file.c        |  4 ++++
>  fs/fat/inode.c       | 11 ++++-------
>  fs/fat/misc.c        | 11 ++++++++---
>  fs/fat/namei_msdos.c |  6 +++---
>  fs/fat/namei_vfat.c  |  6 +++---
>  6 files changed, 23 insertions(+), 17 deletions(-)
>
> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
> index 249825017da7..0ae0dfe278fb 100644
> --- a/fs/fat/dir.c
> +++ b/fs/fat/dir.c
> @@ -1068,7 +1068,7 @@ int fat_remove_entries(struct inode *dir, struct fat_slot_info *sinfo)
>  		}
>  	}
>  
> -	fat_truncate_time(dir, NULL, S_ATIME|S_MTIME);
> +	fat_truncate_time(dir, NULL, S_ATIME|S_CTIME|S_MTIME);
>  	if (IS_DIRSYNC(dir))
>  		(void)fat_sync_inode(dir);
>  	else
> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index a5a309fcc7fa..178c1dde3488 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -544,6 +544,10 @@ int fat_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>  	/*
>  	 * setattr_copy can't truncate these appropriately, so we'll
>  	 * copy them ourselves
> +	 *
> +	 * fat_truncate_time() keeps ctime and mtime the same. if both
> +	 * ctime and mtime are need to update here, mtime will overwrite
> +	 * ctime
>  	 */
>  	if (attr->ia_valid & ATTR_ATIME)
>  		fat_truncate_time(inode, &attr->ia_atime, S_ATIME);
> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> index bf6051bdf1d1..f2ac55cd4ea4 100644
> --- a/fs/fat/inode.c
> +++ b/fs/fat/inode.c
> @@ -567,12 +567,11 @@ int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
>  			   & ~((loff_t)sbi->cluster_size - 1)) >> 9;
>  
>  	fat_time_fat2unix(sbi, &inode->i_mtime, de->time, de->date, 0);
> -	if (sbi->options.isvfat) {
> -		fat_time_fat2unix(sbi, &inode->i_ctime, de->ctime,
> -				  de->cdate, de->ctime_cs);
> +	inode->i_ctime = inode->i_mtime;
> +	if (sbi->options.isvfat)
>  		fat_time_fat2unix(sbi, &inode->i_atime, 0, de->adate, 0);
> -	} else
> -		fat_truncate_time(inode, &inode->i_mtime, S_ATIME|S_CTIME);
> +	else
> +		fat_truncate_atime(sbi, &inode->i_mtime, &inode->i_atime);
>  
>  	return 0;
>  }
> @@ -888,8 +887,6 @@ static int __fat_write_inode(struct inode *inode, int wait)
>  			  &raw_entry->date, NULL);
>  	if (sbi->options.isvfat) {
>  		__le16 atime;
> -		fat_time_unix2fat(sbi, &inode->i_ctime, &raw_entry->ctime,
> -				  &raw_entry->cdate, &raw_entry->ctime_cs);
>  		fat_time_unix2fat(sbi, &inode->i_atime, &atime,
>  				  &raw_entry->adate, NULL);
>  	}
> diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> index c87df64f8b2b..71e6dadf12a2 100644
> --- a/fs/fat/misc.c
> +++ b/fs/fat/misc.c
> @@ -341,10 +341,15 @@ int fat_truncate_time(struct inode *inode, struct timespec64 *now, int flags)
>  
>  	if (flags & S_ATIME)
>  		fat_truncate_atime(sbi, now, &inode->i_atime);
> -	if (flags & S_CTIME)
> -		fat_truncate_crtime(sbi, now, &inode->i_ctime);
> -	if (flags & S_MTIME)
> +
> +	/*
> +	 * ctime and mtime share the same on-disk field, and should be
> +	 * identical in memory.
> +	 */
> +	if (flags & (S_CTIME|S_MTIME)) {
>  		fat_truncate_mtime(sbi, now, &inode->i_mtime);
> +		inode->i_ctime = inode->i_mtime;
> +	}
>  
>  	return 0;
>  }
> diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
> index efba301d68ae..b2760a716707 100644
> --- a/fs/fat/namei_msdos.c
> +++ b/fs/fat/namei_msdos.c
> @@ -328,7 +328,7 @@ static int msdos_rmdir(struct inode *dir, struct dentry *dentry)
>  	drop_nlink(dir);
>  
>  	clear_nlink(inode);
> -	fat_truncate_time(inode, NULL, S_CTIME);
> +	fat_truncate_time(inode, NULL, S_CTIME|S_MTIME);
>  	fat_detach(inode);
>  out:
>  	mutex_unlock(&MSDOS_SB(sb)->s_lock);
> @@ -415,7 +415,7 @@ static int msdos_unlink(struct inode *dir, struct dentry *dentry)
>  	if (err)
>  		goto out;
>  	clear_nlink(inode);
> -	fat_truncate_time(inode, NULL, S_CTIME);
> +	fat_truncate_time(inode, NULL, S_CTIME|S_MTIME);
>  	fat_detach(inode);
>  out:
>  	mutex_unlock(&MSDOS_SB(sb)->s_lock);
> @@ -550,7 +550,7 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
>  		drop_nlink(new_inode);
>  		if (is_dir)
>  			drop_nlink(new_inode);
> -		fat_truncate_time(new_inode, &ts, S_CTIME);
> +		fat_truncate_time(new_inode, &ts, S_CTIME|S_MTIME);
>  	}
>  out:
>  	brelse(sinfo.bh);
> diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
> index 5369d82e0bfb..b8deb859b2b5 100644
> --- a/fs/fat/namei_vfat.c
> +++ b/fs/fat/namei_vfat.c
> @@ -811,7 +811,7 @@ static int vfat_rmdir(struct inode *dir, struct dentry *dentry)
>  	drop_nlink(dir);
>  
>  	clear_nlink(inode);
> -	fat_truncate_time(inode, NULL, S_ATIME|S_MTIME);
> +	fat_truncate_time(inode, NULL, S_ATIME|S_CTIME|S_MTIME);
>  	fat_detach(inode);
>  	vfat_d_version_set(dentry, inode_query_iversion(dir));
>  out:
> @@ -837,7 +837,7 @@ static int vfat_unlink(struct inode *dir, struct dentry *dentry)
>  	if (err)
>  		goto out;
>  	clear_nlink(inode);
> -	fat_truncate_time(inode, NULL, S_ATIME|S_MTIME);
> +	fat_truncate_time(inode, NULL, S_ATIME|S_CTIME|S_MTIME);
>  	fat_detach(inode);
>  	vfat_d_version_set(dentry, inode_query_iversion(dir));
>  out:
> @@ -981,7 +981,7 @@ static int vfat_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  		drop_nlink(new_inode);
>  		if (is_dir)
>  			drop_nlink(new_inode);
> -		fat_truncate_time(new_inode, &ts, S_CTIME);
> +		fat_truncate_time(new_inode, &ts, S_CTIME|S_MTIME);
>  	}
>  out:
>  	brelse(sinfo.bh);

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
