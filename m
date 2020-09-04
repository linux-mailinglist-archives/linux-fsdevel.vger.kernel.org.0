Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F3125D3B1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 10:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbgIDIb2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 04:31:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:48616 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbgIDIbZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:31:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3847FB654;
        Fri,  4 Sep 2020 08:31:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 048131E12D1; Fri,  4 Sep 2020 10:31:24 +0200 (CEST)
Date:   Fri, 4 Sep 2020 10:31:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] quota: widen timestamps for the fs_disk_quota structure
Message-ID: <20200904083123.GE2867@quack2.suse.cz>
References: <20200904053931.GB6096@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904053931.GB6096@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 03-09-20 22:39:31, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Widen the timestamp fields in struct fs_disk_quota to handle quota grace
> expiration times beyond 2038.  Since the only filesystem that's going to
> use this (XFS) only supports unsigned 34-bit quantities, adding an extra
> 5 bits here should work fine.  We can rev the structure again in 350
> years.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Some comments below...

> @@ -588,10 +600,27 @@ static int quota_setxquota(struct super_block *sb, int type, qid_t id,
>  	return sb->s_qcop->set_dqblk(sb, qid, &qdq);
>  }
>  
> +static inline __s8 copy_to_xfs_dqblk_ts(const struct fs_disk_quota *d,
> +		__s32 *timer_lo, s64 timer)
> +{
> +	*timer_lo = timer;
> +	if (d->d_fieldmask & FS_DQ_BIGTIME)
> +		return timer >> 32;
> +	return 0;
> +}

Hum, this function API looks a bit strange to me - directly store timer_lo
and just return timer_hi... Why not having timer_hi as another function
argument?

> @@ -606,6 +635,10 @@ static void copy_to_xfs_dqblk(struct fs_disk_quota *dst, struct qc_dqblk *src,
>  	dst->d_ino_softlimit = src->d_ino_softlimit;
>  	dst->d_bcount = quota_btobb(src->d_space);
>  	dst->d_icount = src->d_ino_count;
> +	dst->d_itimer_hi = copy_to_xfs_dqblk_ts(dst, &dst->d_itimer,
> +						src->d_ino_timer);
> +	dst->d_btimer_hi = copy_to_xfs_dqblk_ts(dst, &dst->d_btimer,
> +						src->d_spc_timer);
>  	dst->d_itimer = src->d_ino_timer;
>  	dst->d_btimer = src->d_spc_timer;

Also it seems pointless (if not outright buggy due to sign-extension rules)
to store to say d_itimer when copy_to_xfs_dqblk_ts() already did it...

>  	dst->d_iwarns = src->d_ino_warns;
> @@ -613,7 +646,8 @@ static void copy_to_xfs_dqblk(struct fs_disk_quota *dst, struct qc_dqblk *src,
>  	dst->d_rtb_hardlimit = quota_btobb(src->d_rt_spc_hardlimit);
>  	dst->d_rtb_softlimit = quota_btobb(src->d_rt_spc_softlimit);
>  	dst->d_rtbcount = quota_btobb(src->d_rt_space);
> -	dst->d_rtbtimer = src->d_rt_spc_timer;
> +	dst->d_rtbtimer_hi = copy_to_xfs_dqblk_ts(dst, &dst->d_rtbtimer,
> +						  src->d_rt_spc_timer);
>  	dst->d_rtbwarns = src->d_rt_spc_warns;
>  }
>  
> diff --git a/include/uapi/linux/dqblk_xfs.h b/include/uapi/linux/dqblk_xfs.h
> index 03d890b80ebc..a684f64d9cc0 100644
> --- a/include/uapi/linux/dqblk_xfs.h
> +++ b/include/uapi/linux/dqblk_xfs.h
> @@ -71,8 +71,11 @@ typedef struct fs_disk_quota {
>  	__u64		d_rtb_softlimit;/* preferred limit on RT disk blks */
>  	__u64		d_rtbcount;	/* # realtime blocks owned */
>  	__s32		d_rtbtimer;	/* similar to above; for RT disk blks */
> -	__u16	  	d_rtbwarns;     /* # warnings issued wrt RT disk blks */
> -	__s16		d_padding3;	/* padding3 - for future use */	
> +	__u16		d_rtbwarns;     /* # warnings issued wrt RT disk blks */
> +	__s8		d_itimer_hi:5;	/* upper 5 bits of timers */
> +	__s8		d_btimer_hi:5;
> +	__s8		d_rtbtimer_hi:5;
> +	__u8		d_padding3:1;	/* padding3 - for future use */
>  	char		d_padding4[8];	/* yet more padding */
>  } fs_disk_quota_t;

I'm a bit nervous about passing bitfields through kernel-userspace
interface. It *should* work OK but I'm not sure rules for bitfield packing
between different compilers are always compatible. E.g. in this case will
the compiler emit three 1-byte fields (as __s8 kind of suggests), just
masking 5-bits out of each or will it use 16-bit wide memory location with
all four fields packed together? And if this is even defined? I didn't find
anything definitive. Also I've found some notes that the order of bit
fields in a word is implementation defined...

So to save us some headaches, I'd prefer to use just three times __s8 for
the _hi fields and then check whether userspace didn't pass too big values
(more than 5 significant bits) when copying from userspace.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
