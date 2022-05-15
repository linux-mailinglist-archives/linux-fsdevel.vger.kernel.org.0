Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D235277E8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 May 2022 15:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbiEON7p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 May 2022 09:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiEON7n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 May 2022 09:59:43 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E900F11A0B
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 May 2022 06:59:41 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id C03AC20A3062;
        Sun, 15 May 2022 22:59:40 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 24FDxYLF069300
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 15 May 2022 22:59:35 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 24FDxYkq327929
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 15 May 2022 22:59:34 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 24FDxYZw327928;
        Sun, 15 May 2022 22:59:34 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Chung-Chiang Cheng <cccheng@synology.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, shepjeng@gmail.com,
        kernel@cccheng.net
Subject: Re: [PATCH v6 1/4] fat: split fat_truncate_time() into separate
 functions
References: <20220503152536.2503003-1-cccheng@synology.com>
Date:   Sun, 15 May 2022 22:59:34 +0900
In-Reply-To: <20220503152536.2503003-1-cccheng@synology.com> (Chung-Chiang
        Cheng's message of "Tue, 3 May 2022 23:25:33 +0800")
Message-ID: <87tu9qlwvt.fsf@mail.parknet.co.jp>
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

> Separate fat_truncate_time() to each timestamps for later creation time
> work.
>
> This patch does not introduce any functional changes, it's merely
> refactoring change.

It seems working as expected. However, this is more or less incompatible
change with previous behavior, so let's start testing.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Thanks.

> Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
> ---
>  fs/fat/fat.h  |  6 +++++
>  fs/fat/misc.c | 74 ++++++++++++++++++++++++++++++++-------------------
>  2 files changed, 53 insertions(+), 27 deletions(-)
>
> diff --git a/fs/fat/fat.h b/fs/fat/fat.h
> index 02d4d4234956..6b04aa623b3b 100644
> --- a/fs/fat/fat.h
> +++ b/fs/fat/fat.h
> @@ -446,6 +446,12 @@ extern void fat_time_fat2unix(struct msdos_sb_info *sbi, struct timespec64 *ts,
>  			      __le16 __time, __le16 __date, u8 time_cs);
>  extern void fat_time_unix2fat(struct msdos_sb_info *sbi, struct timespec64 *ts,
>  			      __le16 *time, __le16 *date, u8 *time_cs);
> +extern struct timespec64 fat_truncate_atime(const struct msdos_sb_info *sbi,
> +					    const struct timespec64 *ts);
> +extern struct timespec64 fat_truncate_crtime(const struct msdos_sb_info *sbi,
> +					     const struct timespec64 *ts);
> +extern struct timespec64 fat_truncate_mtime(const struct msdos_sb_info *sbi,
> +					    const struct timespec64 *ts);
>  extern int fat_truncate_time(struct inode *inode, struct timespec64 *now,
>  			     int flags);
>  extern int fat_update_time(struct inode *inode, struct timespec64 *now,
> diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> index 91ca3c304211..63160e47be00 100644
> --- a/fs/fat/misc.c
> +++ b/fs/fat/misc.c
> @@ -187,7 +187,7 @@ static long days_in_year[] = {
>  	0,   0,  31,  59,  90, 120, 151, 181, 212, 243, 273, 304, 334, 0, 0, 0,
>  };
>  
> -static inline int fat_tz_offset(struct msdos_sb_info *sbi)
> +static inline int fat_tz_offset(const struct msdos_sb_info *sbi)
>  {
>  	return (sbi->options.tz_set ?
>  	       -sbi->options.time_offset :
> @@ -282,16 +282,49 @@ static inline struct timespec64 fat_timespec64_trunc_10ms(struct timespec64 ts)
>  	return ts;
>  }
>  
> +/*
> + * truncate atime to 24 hour granularity (00:00:00 in local timezone)
> + */
> +struct timespec64 fat_truncate_atime(const struct msdos_sb_info *sbi,
> +				     const struct timespec64 *ts)
> +{
> +	/* to localtime */
> +	time64_t seconds = ts->tv_sec - fat_tz_offset(sbi);
> +	s32 remainder;
> +
> +	div_s64_rem(seconds, SECS_PER_DAY, &remainder);
> +	/* to day boundary, and back to unix time */
> +	seconds = seconds + fat_tz_offset(sbi) - remainder;
> +
> +	return (struct timespec64){ seconds, 0 };
> +}
> +
> +/*
> + * truncate creation time with appropriate granularity:
> + *   msdos - 2 seconds
> + *   vfat  - 10 milliseconds
> + */
> +struct timespec64 fat_truncate_crtime(const struct msdos_sb_info *sbi,
> +				      const struct timespec64 *ts)
> +{
> +	if (sbi->options.isvfat)
> +		return fat_timespec64_trunc_10ms(*ts);
> +	else
> +		return fat_timespec64_trunc_2secs(*ts);
> +}
> +
> +/*
> + * truncate mtime to 2 second granularity
> + */
> +struct timespec64 fat_truncate_mtime(const struct msdos_sb_info *sbi,
> +				     const struct timespec64 *ts)
> +{
> +	return fat_timespec64_trunc_2secs(*ts);
> +}
> +
>  /*
>   * truncate the various times with appropriate granularity:
> - *   root inode:
> - *     all times always 0
> - *   all other inodes:
> - *     mtime - 2 seconds
> - *     ctime
> - *       msdos - 2 seconds
> - *       vfat  - 10 milliseconds
> - *     atime - 24 hours (00:00:00 in local timezone)
> + *   all times in root node are always 0
>   */
>  int fat_truncate_time(struct inode *inode, struct timespec64 *now, int flags)
>  {
> @@ -306,25 +339,12 @@ int fat_truncate_time(struct inode *inode, struct timespec64 *now, int flags)
>  		ts = current_time(inode);
>  	}
>  
> -	if (flags & S_ATIME) {
> -		/* to localtime */
> -		time64_t seconds = now->tv_sec - fat_tz_offset(sbi);
> -		s32 remainder;
> -
> -		div_s64_rem(seconds, SECS_PER_DAY, &remainder);
> -		/* to day boundary, and back to unix time */
> -		seconds = seconds + fat_tz_offset(sbi) - remainder;
> -
> -		inode->i_atime = (struct timespec64){ seconds, 0 };
> -	}
> -	if (flags & S_CTIME) {
> -		if (sbi->options.isvfat)
> -			inode->i_ctime = fat_timespec64_trunc_10ms(*now);
> -		else
> -			inode->i_ctime = fat_timespec64_trunc_2secs(*now);
> -	}
> +	if (flags & S_ATIME)
> +		inode->i_atime = fat_truncate_atime(sbi, now);
> +	if (flags & S_CTIME)
> +		inode->i_ctime = fat_truncate_crtime(sbi, now);
>  	if (flags & S_MTIME)
> -		inode->i_mtime = fat_timespec64_trunc_2secs(*now);
> +		inode->i_mtime = fat_truncate_mtime(sbi, now);
>  
>  	return 0;
>  }

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
