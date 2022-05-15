Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BF15277EC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 May 2022 16:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbiEOOAo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 May 2022 10:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiEOOAn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 May 2022 10:00:43 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4B5411A27
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 May 2022 07:00:41 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 22D7D20A3062;
        Sun, 15 May 2022 23:00:41 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 24FE0Ylt069331
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 15 May 2022 23:00:36 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 24FE0Ym4327987
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 15 May 2022 23:00:34 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 24FE0YT4327986;
        Sun, 15 May 2022 23:00:34 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Chung-Chiang Cheng <cccheng@synology.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, shepjeng@gmail.com,
        kernel@cccheng.net
Subject: Re: [PATCH v6 4/4] fat: remove time truncations in
 vfat_create/vfat_mkdir
References: <20220503152536.2503003-1-cccheng@synology.com>
        <20220503152536.2503003-4-cccheng@synology.com>
Date:   Sun, 15 May 2022 23:00:34 +0900
In-Reply-To: <20220503152536.2503003-4-cccheng@synology.com> (Chung-Chiang
        Cheng's message of "Tue, 3 May 2022 23:25:36 +0800")
Message-ID: <87h75qlwu5.fsf@mail.parknet.co.jp>
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

> All the timestamps in vfat_create() and vfat_mkdir() come from
> fat_time_fat2unix() which ensures time granularity. We don't need to
> truncate them to fit FAT's format.
>
> Moreover, fat_truncate_crtime() and fat_timespec64_trunc_10ms() are
> also removed because there is no caller anymore.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Thanks.

> Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
> ---
>  fs/fat/fat.h        |  2 --
>  fs/fat/misc.c       | 21 ---------------------
>  fs/fat/namei_vfat.c |  4 ----
>  3 files changed, 27 deletions(-)
>
> diff --git a/fs/fat/fat.h b/fs/fat/fat.h
> index f3bbf17ee352..47b90deef284 100644
> --- a/fs/fat/fat.h
> +++ b/fs/fat/fat.h
> @@ -449,8 +449,6 @@ extern void fat_time_unix2fat(struct msdos_sb_info *sbi, struct timespec64 *ts,
>  			      __le16 *time, __le16 *date, u8 *time_cs);
>  extern struct timespec64 fat_truncate_atime(const struct msdos_sb_info *sbi,
>  					    const struct timespec64 *ts);
> -extern struct timespec64 fat_truncate_crtime(const struct msdos_sb_info *sbi,
> -					     const struct timespec64 *ts);
>  extern struct timespec64 fat_truncate_mtime(const struct msdos_sb_info *sbi,
>  					    const struct timespec64 *ts);
>  extern int fat_truncate_time(struct inode *inode, struct timespec64 *now,
> diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> index 85bb9dc3af2d..010865dfc46b 100644
> --- a/fs/fat/misc.c
> +++ b/fs/fat/misc.c
> @@ -275,13 +275,6 @@ static inline struct timespec64 fat_timespec64_trunc_2secs(struct timespec64 ts)
>  	return (struct timespec64){ ts.tv_sec & ~1ULL, 0 };
>  }
>  
> -static inline struct timespec64 fat_timespec64_trunc_10ms(struct timespec64 ts)
> -{
> -	if (ts.tv_nsec)
> -		ts.tv_nsec -= ts.tv_nsec % 10000000UL;
> -	return ts;
> -}
> -
>  /*
>   * truncate atime to 24 hour granularity (00:00:00 in local timezone)
>   */
> @@ -299,20 +292,6 @@ struct timespec64 fat_truncate_atime(const struct msdos_sb_info *sbi,
>  	return (struct timespec64){ seconds, 0 };
>  }
>  
> -/*
> - * truncate creation time with appropriate granularity:
> - *   msdos - 2 seconds
> - *   vfat  - 10 milliseconds
> - */
> -struct timespec64 fat_truncate_crtime(const struct msdos_sb_info *sbi,
> -				      const struct timespec64 *ts)
> -{
> -	if (sbi->options.isvfat)
> -		return fat_timespec64_trunc_10ms(*ts);
> -	else
> -		return fat_timespec64_trunc_2secs(*ts);
> -}
> -
>  /*
>   * truncate mtime to 2 second granularity
>   */
> diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
> index 5369d82e0bfb..c573314806cf 100644
> --- a/fs/fat/namei_vfat.c
> +++ b/fs/fat/namei_vfat.c
> @@ -780,8 +780,6 @@ static int vfat_create(struct user_namespace *mnt_userns, struct inode *dir,
>  		goto out;
>  	}
>  	inode_inc_iversion(inode);
> -	fat_truncate_time(inode, &ts, S_ATIME|S_CTIME|S_MTIME);
> -	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
>  
>  	d_instantiate(dentry, inode);
>  out:
> @@ -878,8 +876,6 @@ static int vfat_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>  	}
>  	inode_inc_iversion(inode);
>  	set_nlink(inode, 2);
> -	fat_truncate_time(inode, &ts, S_ATIME|S_CTIME|S_MTIME);
> -	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
>  
>  	d_instantiate(dentry, inode);

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
