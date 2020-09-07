Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155FC25F72D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 12:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgIGKCU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Sep 2020 06:02:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:52018 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728434AbgIGKCU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:02:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 133DDAD39;
        Mon,  7 Sep 2020 10:02:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0B57B1E12D1; Mon,  7 Sep 2020 12:02:18 +0200 (CEST)
Date:   Mon, 7 Sep 2020 12:02:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v2] quota: widen timestamps for the fs_disk_quota
 structure
Message-ID: <20200907100218.GA18556@quack2.suse.cz>
References: <20200905164703.GC7955@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905164703.GC7955@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 05-09-20 09:47:03, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Soon, XFS will support quota grace period expiration timestamps beyond
> the year 2038, widen the timestamp fields to handle the extra time bits.
> Internally, XFS now stores unsigned 34-bit quantities, so the extra 8
> bits here should work fine.  (Note that XFS is the only user of this
> structure.)
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Looks good to me. Just one question below:

> diff --git a/fs/quota/quota.c b/fs/quota/quota.c
> index 5444d3c4d93f..eefac57c52fd 100644
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

So this doesn't do any checks that the resulting time fits into 34-bits you
speak about in the changelog. So how will XFS react if malicious / buggy
userspace will pass too big timestamp? I suppose xfs_fs_set_dqblk() should
return EFBIG or EINVAL or something like that which I'm not sure it does...

For record I've checked VFS quota implementation and it doesn't need any
checks because VFS in memory structures and on-disk format use 64-bit
timestamps. The ancient quota format uses 32-bit timestamps for 32-bit
archs so these would get silently truncated when stored on disk but
honestly I don't think I care (that format was deprecated some 20 years
ago).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
