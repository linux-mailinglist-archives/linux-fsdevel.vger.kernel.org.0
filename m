Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3125277EB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 May 2022 16:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbiEOOAa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 May 2022 10:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiEOOA2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 May 2022 10:00:28 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3036C11A0B
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 May 2022 07:00:27 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id ABF9F20A3062;
        Sun, 15 May 2022 23:00:26 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 24FE0KkT069321
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 15 May 2022 23:00:21 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 24FE0Ktn327973
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 15 May 2022 23:00:20 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 24FE0KRI327972;
        Sun, 15 May 2022 23:00:20 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Chung-Chiang Cheng <cccheng@synology.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, shepjeng@gmail.com,
        kernel@cccheng.net
Subject: Re: [PATCH v6 3/4] fat: report creation time in statx
References: <20220503152536.2503003-1-cccheng@synology.com>
        <20220503152536.2503003-3-cccheng@synology.com>
Date:   Sun, 15 May 2022 23:00:20 +0900
In-Reply-To: <20220503152536.2503003-3-cccheng@synology.com> (Chung-Chiang
        Cheng's message of "Tue, 3 May 2022 23:25:35 +0800")
Message-ID: <87lev2lwuj.fsf@mail.parknet.co.jp>
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

> creation time is no longer mixed with change time. Add an in-memory
> field for it, and report it in statx if supported.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Thanks.

> Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
> ---
>  fs/fat/fat.h   |  1 +
>  fs/fat/file.c  | 14 +++++++++++---
>  fs/fat/inode.c | 10 ++++++++--
>  3 files changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/fs/fat/fat.h b/fs/fat/fat.h
> index 6b04aa623b3b..f3bbf17ee352 100644
> --- a/fs/fat/fat.h
> +++ b/fs/fat/fat.h
> @@ -126,6 +126,7 @@ struct msdos_inode_info {
>  	struct hlist_node i_fat_hash;	/* hash by i_location */
>  	struct hlist_node i_dir_hash;	/* hash by i_logstart */
>  	struct rw_semaphore truncate_lock; /* protect bmap against truncate */
> +	struct timespec64 i_crtime;	/* File creation (birth) time */
>  	struct inode vfs_inode;
>  };
>  
> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index a5a309fcc7fa..8f5218450a3a 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -399,13 +399,21 @@ int fat_getattr(struct user_namespace *mnt_userns, const struct path *path,
>  		struct kstat *stat, u32 request_mask, unsigned int flags)
>  {
>  	struct inode *inode = d_inode(path->dentry);
> +	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
> +
>  	generic_fillattr(mnt_userns, inode, stat);
> -	stat->blksize = MSDOS_SB(inode->i_sb)->cluster_size;
> +	stat->blksize = sbi->cluster_size;
>  
> -	if (MSDOS_SB(inode->i_sb)->options.nfs == FAT_NFS_NOSTALE_RO) {
> +	if (sbi->options.nfs == FAT_NFS_NOSTALE_RO) {
>  		/* Use i_pos for ino. This is used as fileid of nfs. */
> -		stat->ino = fat_i_pos_read(MSDOS_SB(inode->i_sb), inode);
> +		stat->ino = fat_i_pos_read(sbi, inode);
>  	}
> +
> +	if (sbi->options.isvfat && request_mask & STATX_BTIME) {
> +		stat->result_mask |= STATX_BTIME;
> +		stat->btime = MSDOS_I(inode)->i_crtime;
> +	}
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(fat_getattr);
> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> index 16d5a52116d3..2472a357198a 100644
> --- a/fs/fat/inode.c
> +++ b/fs/fat/inode.c
> @@ -568,9 +568,11 @@ int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
>  
>  	fat_time_fat2unix(sbi, &inode->i_mtime, de->time, de->date, 0);
>  	inode->i_ctime = inode->i_mtime;
> -	if (sbi->options.isvfat)
> +	if (sbi->options.isvfat) {
>  		fat_time_fat2unix(sbi, &inode->i_atime, 0, de->adate, 0);
> -	else
> +		fat_time_fat2unix(sbi, &MSDOS_I(inode)->i_crtime, de->ctime,
> +				  de->cdate, de->ctime_cs);
> +	} else
>  		inode->i_atime = fat_truncate_atime(sbi, &inode->i_mtime);
>  
>  	return 0;
> @@ -756,6 +758,8 @@ static struct inode *fat_alloc_inode(struct super_block *sb)
>  	ei->i_logstart = 0;
>  	ei->i_attrs = 0;
>  	ei->i_pos = 0;
> +	ei->i_crtime.tv_sec = 0;
> +	ei->i_crtime.tv_nsec = 0;
>  
>  	return &ei->vfs_inode;
>  }
> @@ -889,6 +893,8 @@ static int __fat_write_inode(struct inode *inode, int wait)
>  		__le16 atime;
>  		fat_time_unix2fat(sbi, &inode->i_atime, &atime,
>  				  &raw_entry->adate, NULL);
> +		fat_time_unix2fat(sbi, &MSDOS_I(inode)->i_crtime, &raw_entry->ctime,
> +				  &raw_entry->cdate, &raw_entry->ctime_cs);
>  	}
>  	spin_unlock(&sbi->inode_hash_lock);
>  	mark_buffer_dirty(bh);

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
