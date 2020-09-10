Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5864C263E37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 09:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgIJHM7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 03:12:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:46658 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729005AbgIJHLI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 03:11:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 806CEB311;
        Thu, 10 Sep 2020 07:11:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 61B471E12EB; Thu, 10 Sep 2020 09:11:05 +0200 (CEST)
Date:   Thu, 10 Sep 2020 09:11:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>, hch@lst.de
Subject: Re: [PATCH v4] quota: widen timestamps for the fs_disk_quota
 structure
Message-ID: <20200910071105.GB17540@quack2.suse.cz>
References: <20200909163413.GJ7955@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909163413.GJ7955@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 09-09-20 09:34:13, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Soon, XFS will support quota grace period expiration timestamps beyond
> the year 2038, widen the timestamp fields to handle the extra time bits.
> Internally, XFS now stores unsigned 34-bit quantities, so the extra 8
> bits here should work fine.  (Note that XFS is the only user of this
> structure.)
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Thanks for the patch. I've updated the version I carry in my tree with this
patch.

								Honza

> ---
> v4: don't set timer_hi if !DQ_BIGTIME
> v3: remove the old rt_spc_timer assignment statement
> v2: fix calling conventions, widen timestamps
> ---
>  fs/quota/quota.c               |   42 ++++++++++++++++++++++++++++++++++------
>  include/uapi/linux/dqblk_xfs.h |   11 ++++++++++
>  2 files changed, 46 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/quota/quota.c b/fs/quota/quota.c
> index 47f9e151988b..52362eeaea94 100644
> --- a/fs/quota/quota.c
> +++ b/fs/quota/quota.c
> @@ -481,6 +481,14 @@ static inline u64 quota_btobb(u64 bytes)
>  	return (bytes + (1 << XFS_BB_SHIFT) - 1) >> XFS_BB_SHIFT;
>  }
>  
> +static inline s64 copy_from_xfs_dqblk_ts(const struct fs_disk_quota *d,
> +		__s32 timer, __s8 timer_hi)
> +{
> +	if (d->d_fieldmask & FS_DQ_BIGTIME)
> +		return (u32)timer | (s64)timer_hi << 32;
> +	return timer;
> +}
> +
>  static void copy_from_xfs_dqblk(struct qc_dqblk *dst, struct fs_disk_quota *src)
>  {
>  	dst->d_spc_hardlimit = quota_bbtob(src->d_blk_hardlimit);
> @@ -489,14 +497,17 @@ static void copy_from_xfs_dqblk(struct qc_dqblk *dst, struct fs_disk_quota *src)
>  	dst->d_ino_softlimit = src->d_ino_softlimit;
>  	dst->d_space = quota_bbtob(src->d_bcount);
>  	dst->d_ino_count = src->d_icount;
> -	dst->d_ino_timer = src->d_itimer;
> -	dst->d_spc_timer = src->d_btimer;
> +	dst->d_ino_timer = copy_from_xfs_dqblk_ts(src, src->d_itimer,
> +						  src->d_itimer_hi);
> +	dst->d_spc_timer = copy_from_xfs_dqblk_ts(src, src->d_btimer,
> +						  src->d_btimer_hi);
>  	dst->d_ino_warns = src->d_iwarns;
>  	dst->d_spc_warns = src->d_bwarns;
>  	dst->d_rt_spc_hardlimit = quota_bbtob(src->d_rtb_hardlimit);
>  	dst->d_rt_spc_softlimit = quota_bbtob(src->d_rtb_softlimit);
>  	dst->d_rt_space = quota_bbtob(src->d_rtbcount);
> -	dst->d_rt_spc_timer = src->d_rtbtimer;
> +	dst->d_rt_spc_timer = copy_from_xfs_dqblk_ts(src, src->d_rtbtimer,
> +						     src->d_rtbtimer_hi);
>  	dst->d_rt_spc_warns = src->d_rtbwarns;
>  	dst->d_fieldmask = 0;
>  	if (src->d_fieldmask & FS_DQ_ISOFT)
> @@ -588,10 +599,26 @@ static int quota_setxquota(struct super_block *sb, int type, qid_t id,
>  	return sb->s_qcop->set_dqblk(sb, qid, &qdq);
>  }
>  
> +static inline void copy_to_xfs_dqblk_ts(const struct fs_disk_quota *d,
> +		__s32 *timer_lo, __s8 *timer_hi, s64 timer)
> +{
> +	*timer_lo = timer;
> +	if (d->d_fieldmask & FS_DQ_BIGTIME)
> +		*timer_hi = timer >> 32;
> +}
> +
> +static inline bool want_bigtime(s64 timer)
> +{
> +	return timer > S32_MAX || timer < S32_MIN;
> +}
> +
>  static void copy_to_xfs_dqblk(struct fs_disk_quota *dst, struct qc_dqblk *src,
>  			      int type, qid_t id)
>  {
>  	memset(dst, 0, sizeof(*dst));
> +	if (want_bigtime(src->d_ino_timer) || want_bigtime(src->d_spc_timer) ||
> +	    want_bigtime(src->d_rt_spc_timer))
> +		dst->d_fieldmask |= FS_DQ_BIGTIME;
>  	dst->d_version = FS_DQUOT_VERSION;
>  	dst->d_id = id;
>  	if (type == USRQUOTA)
> @@ -606,14 +633,17 @@ static void copy_to_xfs_dqblk(struct fs_disk_quota *dst, struct qc_dqblk *src,
>  	dst->d_ino_softlimit = src->d_ino_softlimit;
>  	dst->d_bcount = quota_btobb(src->d_space);
>  	dst->d_icount = src->d_ino_count;
> -	dst->d_itimer = src->d_ino_timer;
> -	dst->d_btimer = src->d_spc_timer;
> +	copy_to_xfs_dqblk_ts(dst, &dst->d_itimer, &dst->d_itimer_hi,
> +			     src->d_ino_timer);
> +	copy_to_xfs_dqblk_ts(dst, &dst->d_btimer, &dst->d_btimer_hi,
> +			     src->d_spc_timer);
>  	dst->d_iwarns = src->d_ino_warns;
>  	dst->d_bwarns = src->d_spc_warns;
>  	dst->d_rtb_hardlimit = quota_btobb(src->d_rt_spc_hardlimit);
>  	dst->d_rtb_softlimit = quota_btobb(src->d_rt_spc_softlimit);
>  	dst->d_rtbcount = quota_btobb(src->d_rt_space);
> -	dst->d_rtbtimer = src->d_rt_spc_timer;
> +	copy_to_xfs_dqblk_ts(dst, &dst->d_rtbtimer, &dst->d_rtbtimer_hi,
> +			     src->d_rt_spc_timer);
>  	dst->d_rtbwarns = src->d_rt_spc_warns;
>  }
>  
> diff --git a/include/uapi/linux/dqblk_xfs.h b/include/uapi/linux/dqblk_xfs.h
> index 03d890b80ebc..16d73f54376d 100644
> --- a/include/uapi/linux/dqblk_xfs.h
> +++ b/include/uapi/linux/dqblk_xfs.h
> @@ -66,7 +66,10 @@ typedef struct fs_disk_quota {
>  	__s32		d_btimer;	/* similar to above; for disk blocks */
>  	__u16	  	d_iwarns;       /* # warnings issued wrt num inodes */
>  	__u16	  	d_bwarns;       /* # warnings issued wrt disk blocks */
> -	__s32		d_padding2;	/* padding2 - for future use */
> +	__s8		d_itimer_hi;	/* upper 8 bits of timer values */
> +	__s8		d_btimer_hi;
> +	__s8		d_rtbtimer_hi;
> +	__s8		d_padding2;	/* padding2 - for future use */
>  	__u64		d_rtb_hardlimit;/* absolute limit on realtime blks */
>  	__u64		d_rtb_softlimit;/* preferred limit on RT disk blks */
>  	__u64		d_rtbcount;	/* # realtime blocks owned */
> @@ -121,6 +124,12 @@ typedef struct fs_disk_quota {
>  #define FS_DQ_RTBCOUNT		(1<<14)
>  #define FS_DQ_ACCT_MASK		(FS_DQ_BCOUNT | FS_DQ_ICOUNT | FS_DQ_RTBCOUNT)
>  
> +/*
> + * Quota expiration timestamps are 40-bit signed integers, with the upper 8
> + * bits encoded in the _hi fields.
> + */
> +#define FS_DQ_BIGTIME		(1<<15)
> +
>  /*
>   * Various flags related to quotactl(2).
>   */
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
