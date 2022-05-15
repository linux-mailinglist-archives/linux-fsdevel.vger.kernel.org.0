Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE8F5277EA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 May 2022 16:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbiEOOAM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 May 2022 10:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiEOOAK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 May 2022 10:00:10 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C27811A0B
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 May 2022 07:00:08 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 1D51920A3062;
        Sun, 15 May 2022 23:00:08 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 24FE01MP069311
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 15 May 2022 23:00:02 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 24FE01AV327956
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 15 May 2022 23:00:01 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 24FE01FS327955;
        Sun, 15 May 2022 23:00:01 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Chung-Chiang Cheng <cccheng@synology.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, shepjeng@gmail.com,
        kernel@cccheng.net
Subject: Re: [PATCH v6 2/4] fat: ignore ctime updates, and keep ctime
 identical to mtime in memory
References: <20220503152536.2503003-1-cccheng@synology.com>
        <20220503152536.2503003-2-cccheng@synology.com>
Date:   Sun, 15 May 2022 23:00:01 +0900
In-Reply-To: <20220503152536.2503003-2-cccheng@synology.com> (Chung-Chiang
        Cheng's message of "Tue, 3 May 2022 23:25:34 +0800")
Message-ID: <87pmkelwv2.fsf@mail.parknet.co.jp>
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
> To address this issue, this patch changes the behavior of ctime. It
> will no longer be loaded and stored from the creation time on disk.
> Instead of that, it'll be consistent with the in-memory mtime and share
> the same on-disk field. All updates to mtime will also be applied to
> ctime in memory, while all updates to ctime will be ignored.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Thanks.

> Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
> ---
>  fs/fat/inode.c | 11 ++++-------
>  fs/fat/misc.c  |  9 ++++++---
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> index bf6051bdf1d1..16d5a52116d3 100644
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
> +		inode->i_atime = fat_truncate_atime(sbi, &inode->i_mtime);
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
> index 63160e47be00..85bb9dc3af2d 100644
> --- a/fs/fat/misc.c
> +++ b/fs/fat/misc.c
> @@ -341,10 +341,13 @@ int fat_truncate_time(struct inode *inode, struct timespec64 *now, int flags)
>  
>  	if (flags & S_ATIME)
>  		inode->i_atime = fat_truncate_atime(sbi, now);
> -	if (flags & S_CTIME)
> -		inode->i_ctime = fat_truncate_crtime(sbi, now);
> +	/*
> +	 * ctime and mtime share the same on-disk field, and should be
> +	 * identical in memory. all mtime updates will be applied to ctime,
> +	 * but ctime updates are ignored.
> +	 */
>  	if (flags & S_MTIME)
> -		inode->i_mtime = fat_truncate_mtime(sbi, now);
> +		inode->i_mtime = inode->i_ctime = fat_truncate_mtime(sbi, now);
>  
>  	return 0;
>  }

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
