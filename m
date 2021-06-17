Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B803AB95D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 18:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhFQQS7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 12:18:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231176AbhFQQS6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 12:18:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A60761003;
        Thu, 17 Jun 2021 16:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623946610;
        bh=T4lfd5wWirPw8T9WGSgtzyj6zWPbiu0ej+98GK+qMfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d14K5ONqGwFTZC0h6Gutyhw6/NHGiWbCZnX1Vvi0P3Enobb5ffk6+rfuYIrbGA9XP
         f5HNfhWRWF3bLVIv4VrIt8qVvjbTkPKKq/65ZbsFhbwRTJSYWbqAuxMs+0urbKDZCQ
         H32GuuYU8ENi1iMhoa4yTKRWPX15ngUes52vo6rgSQvS3/BTGHYUMWFtkQAb6198rx
         j7Npvb/c2ysaIQBe0MovR3bfmlqLqy1PrfmZZgin6gfY7wK+WFvfUkF4D6Kl7s0Nv5
         u5aMpcrC5S0ncy9G9HXuZTypVo4C7KRLpbzyo47jC8HRA090z1McTPNYYolsJjxyqF
         f+pc12AyTkRBQ==
Date:   Thu, 17 Jun 2021 09:16:49 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>, ceph-devel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Reichl <preichl@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH 07/14] xfs: Refactor xfs_isilocked()
Message-ID: <20210617161649.GO158209@locust>
References: <20210615090844.6045-1-jack@suse.cz>
 <20210615091814.28626-7-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615091814.28626-7-jack@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 11:17:57AM +0200, Jan Kara wrote:
> From: Pavel Reichl <preichl@redhat.com>
> 
> Refactor xfs_isilocked() to use newly introduced __xfs_rwsem_islocked().
> __xfs_rwsem_islocked() is a helper function which encapsulates checking
> state of rw_semaphores hold by inode.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> Suggested-by: Dave Chinner <dchinner@redhat.com>
> Suggested-by: Eric Sandeen <sandeen@redhat.com>
> Suggested-by: Darrick J. Wong <darrick.wong@oracle.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

With the commit message updated,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_inode.c | 34 ++++++++++++++++++++++++++--------
>  fs/xfs/xfs_inode.h |  2 +-
>  2 files changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index e4c2da4566f1..ffd47217a8fa 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -342,9 +342,29 @@ xfs_ilock_demote(
>  }
>  
>  #if defined(DEBUG) || defined(XFS_WARN)
> -int
> +static inline bool
> +__xfs_rwsem_islocked(
> +	struct rw_semaphore	*rwsem,
> +	bool			shared)
> +{
> +	if (!debug_locks)
> +		return rwsem_is_locked(rwsem);
> +
> +	if (!shared)
> +		return lockdep_is_held_type(rwsem, 0);
> +
> +	/*
> +	 * We are checking that the lock is held at least in shared
> +	 * mode but don't care that it might be held exclusively
> +	 * (i.e. shared | excl). Hence we check if the lock is held
> +	 * in any mode rather than an explicit shared mode.
> +	 */
> +	return lockdep_is_held_type(rwsem, -1);
> +}
> +
> +bool
>  xfs_isilocked(
> -	xfs_inode_t		*ip,
> +	struct xfs_inode	*ip,
>  	uint			lock_flags)
>  {
>  	if (lock_flags & (XFS_ILOCK_EXCL|XFS_ILOCK_SHARED)) {
> @@ -359,15 +379,13 @@ xfs_isilocked(
>  		return rwsem_is_locked(&ip->i_mmaplock.mr_lock);
>  	}
>  
> -	if (lock_flags & (XFS_IOLOCK_EXCL|XFS_IOLOCK_SHARED)) {
> -		if (!(lock_flags & XFS_IOLOCK_SHARED))
> -			return !debug_locks ||
> -				lockdep_is_held_type(&VFS_I(ip)->i_rwsem, 0);
> -		return rwsem_is_locked(&VFS_I(ip)->i_rwsem);
> +	if (lock_flags & (XFS_IOLOCK_EXCL | XFS_IOLOCK_SHARED)) {
> +		return __xfs_rwsem_islocked(&VFS_I(ip)->i_rwsem,
> +				(lock_flags & XFS_IOLOCK_SHARED));
>  	}
>  
>  	ASSERT(0);
> -	return 0;
> +	return false;
>  }
>  #endif
>  
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index ca826cfba91c..4659e1568966 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -410,7 +410,7 @@ void		xfs_ilock(xfs_inode_t *, uint);
>  int		xfs_ilock_nowait(xfs_inode_t *, uint);
>  void		xfs_iunlock(xfs_inode_t *, uint);
>  void		xfs_ilock_demote(xfs_inode_t *, uint);
> -int		xfs_isilocked(xfs_inode_t *, uint);
> +bool		xfs_isilocked(struct xfs_inode *, uint);
>  uint		xfs_ilock_data_map_shared(struct xfs_inode *);
>  uint		xfs_ilock_attr_map_shared(struct xfs_inode *);
>  
> -- 
> 2.26.2
> 
