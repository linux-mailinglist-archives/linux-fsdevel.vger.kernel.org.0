Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83DD4E39B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 08:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237593AbiCVHfA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 03:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237603AbiCVHey (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 03:34:54 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC1E1245BC
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 00:33:16 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 1669515F93A;
        Tue, 22 Mar 2022 16:33:16 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 22M7XEdP077028
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 16:33:15 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 22M7XElM265656
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 16:33:14 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 22M7XETr265653;
        Tue, 22 Mar 2022 16:33:14 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Chung-Chiang Cheng <cccheng@synology.com>
Cc:     linux-fsdevel@vger.kernel.org, shepjeng@gmail.com,
        kernel@cccheng.net
Subject: Re: [PATCH 2/2] fat: introduce creation time
References: <20220321095814.175891-1-cccheng@synology.com>
        <20220321095814.175891-2-cccheng@synology.com>
Date:   Tue, 22 Mar 2022 16:33:14 +0900
In-Reply-To: <20220321095814.175891-2-cccheng@synology.com> (Chung-Chiang
        Cheng's message of "Mon, 21 Mar 2022 17:58:14 +0800")
Message-ID: <87lex2e91h.fsf@mail.parknet.co.jp>
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

> In the old days, FAT supports creation time, but there's no corresponding
> timestamp in VFS. The implementation mixed the meaning of change time and
> creation time into a single ctime field.
>
> This patch introduces a new field for creation time, and reports it in
> statx. The original ctime doesn't stand for create time any more. All
> the behaviors of ctime (change time) follow mtime, as exfat does.

Yes, ctime is issue (include compatibility issue when changing) from
original author of this driver. And there is no perfect solution and
subtle issue I think.

I'm not against about this change though, this behavior makes utimes(2)
behavior strange, e.g. user can change ctime, but FAT forget it anytime,
because FAT can't save it.

Did you consider about those behavior and choose this?

Thanks.

> Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
> ---
>  fs/fat/fat.h   |  1 +
>  fs/fat/file.c  |  6 ++++++
>  fs/fat/inode.c | 15 ++++++++++-----
>  fs/fat/misc.c  |  6 +++---
>  4 files changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/fs/fat/fat.h b/fs/fat/fat.h
> index 508b4f2a1ffb..e4409ee82ea9 100644
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
> index 13855ba49cd9..184fa0375152 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -405,6 +405,12 @@ int fat_getattr(struct user_namespace *mnt_userns, const struct path *path,
>  		/* Use i_pos for ino. This is used as fileid of nfs. */
>  		stat->ino = fat_i_pos_read(MSDOS_SB(inode->i_sb), inode);
>  	}
> +
> +	if (request_mask & STATX_BTIME) {
> +		stat->result_mask |= STATX_BTIME;
> +		stat->btime = MSDOS_I(inode)->i_crtime;
> +	}
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(fat_getattr);
> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> index a6f1c6d426d1..41b85b95ee9d 100644
> --- a/fs/fat/inode.c
> +++ b/fs/fat/inode.c
> @@ -566,12 +566,15 @@ int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
>  			   & ~((loff_t)sbi->cluster_size - 1)) >> 9;
>  
>  	fat_time_fat2unix(sbi, &inode->i_mtime, de->time, de->date, 0);
> +	inode->i_ctime = inode->i_mtime;
>  	if (sbi->options.isvfat) {
> -		fat_time_fat2unix(sbi, &inode->i_ctime, de->ctime,
> -				  de->cdate, de->ctime_cs);
>  		fat_time_fat2unix(sbi, &inode->i_atime, 0, de->adate, 0);
> -	} else
> -		fat_truncate_time(inode, &inode->i_mtime, S_ATIME|S_CTIME);
> +		fat_time_fat2unix(sbi, &MSDOS_I(inode)->i_crtime, de->ctime,
> +				  de->cdate, de->ctime_cs);
> +	} else {
> +		fat_truncate_atime(sbi, &inode->i_mtime, &inode->i_atime);
> +		fat_truncate_crtime(sbi, &inode->i_mtime, &MSDOS_I(inode)->i_crtime);
> +	}
>  
>  	return 0;
>  }
> @@ -756,6 +759,8 @@ static struct inode *fat_alloc_inode(struct super_block *sb)
>  	ei->i_logstart = 0;
>  	ei->i_attrs = 0;
>  	ei->i_pos = 0;
> +	ei->i_crtime.tv_sec = 0;
> +	ei->i_crtime.tv_nsec = 0;
>  
>  	return &ei->vfs_inode;
>  }
> @@ -887,7 +892,7 @@ static int __fat_write_inode(struct inode *inode, int wait)
>  			  &raw_entry->date, NULL);
>  	if (sbi->options.isvfat) {
>  		__le16 atime;
> -		fat_time_unix2fat(sbi, &inode->i_ctime, &raw_entry->ctime,
> +		fat_time_unix2fat(sbi, &MSDOS_I(inode)->i_crtime, &raw_entry->ctime,
>  				  &raw_entry->cdate, &raw_entry->ctime_cs);
>  		fat_time_unix2fat(sbi, &inode->i_atime, &atime,
>  				  &raw_entry->adate, NULL);
> diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> index c87df64f8b2b..36b6da6461cc 100644
> --- a/fs/fat/misc.c
> +++ b/fs/fat/misc.c
> @@ -341,10 +341,10 @@ int fat_truncate_time(struct inode *inode, struct timespec64 *now, int flags)
>  
>  	if (flags & S_ATIME)
>  		fat_truncate_atime(sbi, now, &inode->i_atime);
> -	if (flags & S_CTIME)
> -		fat_truncate_crtime(sbi, now, &inode->i_ctime);
> -	if (flags & S_MTIME)
> +	if (flags & (S_CTIME | S_MTIME)) {
>  		fat_truncate_mtime(sbi, now, &inode->i_mtime);
> +		inode->i_ctime = inode->i_mtime;
> +	}
>  
>  	return 0;
>  }

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
