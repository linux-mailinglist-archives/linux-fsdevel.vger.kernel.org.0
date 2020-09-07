Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27B025F7E4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 12:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgIGKWc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Sep 2020 06:22:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:35998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728658AbgIGKWb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:22:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 77D7AAB0E;
        Mon,  7 Sep 2020 10:22:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5F40C1E12D1; Mon,  7 Sep 2020 12:22:29 +0200 (CEST)
Date:   Mon, 7 Sep 2020 12:22:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] quotatools: support grace period expirations past y2038
 in userspace
Message-ID: <20200907102229.GB18556@quack2.suse.cz>
References: <20200905164703.GC7955@magnolia>
 <20200905165026.GD7955@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905165026.GD7955@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 05-09-20 09:50:26, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Add the ability to interpret the larger quota grace period expiration
> timestamps that the kernel can export via struct xfs_kern_dqblk.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Thanks. I've added the patch to quota-tools tree. I've just extended it a
bit so that xfs_util2kerndqblk() checks whether the passed time fits into
the 40-bit field and returns error otherwise instead of silently truncating
the timestamp...

								Honza

> ---
>  quotaio_xfs.c |   33 +++++++++++++++++++++++++++++----
>  quotaio_xfs.h |   11 ++++++++++-
>  2 files changed, 39 insertions(+), 5 deletions(-)
> 
> diff --git a/quotaio_xfs.c b/quotaio_xfs.c
> index 3333bb1..9854ec2 100644
> --- a/quotaio_xfs.c
> +++ b/quotaio_xfs.c
> @@ -42,6 +42,29 @@ scan_dquots:	xfs_scan_dquots,
>  report:		xfs_report
>  };
>  
> +static inline time_t xfs_kern2utildqblk_ts(const struct xfs_kern_dqblk *k,
> +		__s32 timer, __s8 timer_hi)
> +{
> +	if (k->d_fieldmask & FS_DQ_BIGTIME)
> +		return (__u32)timer | (__s64)timer_hi << 32;
> +	return timer;
> +}
> +
> +static inline void xfs_util2kerndqblk_ts(const struct xfs_kern_dqblk *k,
> +		__s32 *timer_lo, __s8 *timer_hi, time_t timer)
> +{
> +	*timer_lo = timer;
> +	if (k->d_fieldmask & FS_DQ_BIGTIME)
> +		*timer_hi = timer >> 32;
> +	else
> +		*timer_hi = 0;
> +}
> +
> +static inline int want_bigtime(time_t timer)
> +{
> +	return timer > INT32_MAX || timer < INT32_MIN;
> +}
> +
>  /*
>   *	Convert XFS kernel quota format to utility format
>   */
> @@ -53,8 +76,8 @@ static inline void xfs_kern2utildqblk(struct util_dqblk *u, struct xfs_kern_dqbl
>  	u->dqb_bsoftlimit = k->d_blk_softlimit >> 1;
>  	u->dqb_curinodes = k->d_icount;
>  	u->dqb_curspace = ((qsize_t)k->d_bcount) << 9;
> -	u->dqb_itime = k->d_itimer;
> -	u->dqb_btime = k->d_btimer;
> +	u->dqb_itime = xfs_kern2utildqblk_ts(k, k->d_itimer, k->d_itimer_hi);
> +	u->dqb_btime = xfs_kern2utildqblk_ts(k, k->d_btimer, k->d_btimer_hi);
>  }
>  
>  /*
> @@ -69,8 +92,10 @@ static inline void xfs_util2kerndqblk(struct xfs_kern_dqblk *k, struct util_dqbl
>  	k->d_blk_softlimit = u->dqb_bsoftlimit << 1;
>  	k->d_icount = u->dqb_curinodes;
>  	k->d_bcount = u->dqb_curspace >> 9;
> -	k->d_itimer = u->dqb_itime;
> -	k->d_btimer = u->dqb_btime;
> +	if (want_bigtime(u->dqb_itime) || want_bigtime(u->dqb_btime))
> +		k->d_fieldmask |= FS_DQ_BIGTIME;
> +	xfs_util2kerndqblk_ts(k, &k->d_itimer, &k->d_itimer_hi, u->dqb_itime);
> +	xfs_util2kerndqblk_ts(k, &k->d_btimer, &k->d_btimer_hi, u->dqb_btime);
>  }
>  
>  /*
> diff --git a/quotaio_xfs.h b/quotaio_xfs.h
> index be7f86f..e0c2a62 100644
> --- a/quotaio_xfs.h
> +++ b/quotaio_xfs.h
> @@ -72,7 +72,10 @@ typedef struct fs_disk_quota {
>  	__s32 d_btimer;		/* similar to above; for disk blocks */
>  	__u16 d_iwarns;		/* # warnings issued wrt num inodes */
>  	__u16 d_bwarns;		/* # warnings issued wrt disk blocks */
> -	__s32 d_padding2;	/* padding2 - for future use */
> +	__s8 d_itimer_hi;	/* upper 8 bits of timer values */
> +	__s8 d_btimer_hi;
> +	__s8 d_rtbtimer_hi;
> +	__s8 d_padding2;	/* padding2 - for future use */
>  	__u64 d_rtb_hardlimit;	/* absolute limit on realtime blks */
>  	__u64 d_rtb_softlimit;	/* preferred limit on RT disk blks */
>  	__u64 d_rtbcount;	/* # realtime blocks owned */
> @@ -114,6 +117,12 @@ typedef struct fs_disk_quota {
>  #define FS_DQ_RTBCOUNT          (1<<14)
>  #define FS_DQ_ACCT_MASK         (FS_DQ_BCOUNT | FS_DQ_ICOUNT | FS_DQ_RTBCOUNT)
>  
> +/*
> + * Quota expiration timestamps are 40-bit signed integers, with the upper 8
> + * bits encoded in the _hi fields.
> + */
> +#define FS_DQ_BIGTIME		(1<<15)
> +
>  /*
>   * Various flags related to quotactl(2).  Only relevant to XFS filesystems.
>   */
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
