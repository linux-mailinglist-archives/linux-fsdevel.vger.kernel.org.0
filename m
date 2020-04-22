Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C481B3A6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 10:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgDVIl1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 04:41:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:45282 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbgDVIl0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 04:41:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 63498AF2C;
        Wed, 22 Apr 2020 08:41:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 736CC1E0E5A; Wed, 22 Apr 2020 10:41:23 +0200 (CEST)
Date:   Wed, 22 Apr 2020 10:41:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V9 08/11] fs: Lift XFS_IDONTCACNE to the VFS layer
Message-ID: <20200422084123.GB8775@quack2.suse.cz>
References: <20200421191754.3372370-1-ira.weiny@intel.com>
 <20200421191754.3372370-9-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421191754.3372370-9-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 21-04-20 12:17:50, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> DAX effective mode (S_DAX) changes requires inode eviction.
> 
> XFS has an advisory flag (XFS_IDONTCACHE) to prevent caching of the
> inode if no other additional references are taken.  We lift this flag to
> the VFS layer and change the behavior slightly by allowing the flag to
> remain even if multiple references are taken.
> 
> This will expedite the eviction of inodes to change S_DAX.
> 
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Besides the two nits Darrick had I didn't find any other problem so feel
free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

to the fixed up version.

								Honza


> 
> ---
> Changes from V8:
> 	Remove XFS_IDONTCACHE
> ---
>  fs/xfs/xfs_icache.c | 4 ++--
>  fs/xfs/xfs_inode.h  | 2 +-
>  fs/xfs/xfs_super.c  | 2 +-
>  include/linux/fs.h  | 6 +++++-
>  4 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index 17a0b86fe701..de76f7f60695 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -477,7 +477,7 @@ xfs_iget_cache_hit(
>  		xfs_ilock(ip, lock_flags);
>  
>  	if (!(flags & XFS_IGET_INCORE))
> -		xfs_iflags_clear(ip, XFS_ISTALE | XFS_IDONTCACHE);
> +		xfs_iflags_clear(ip, XFS_ISTALE);
>  	XFS_STATS_INC(mp, xs_ig_found);
>  
>  	return 0;
> @@ -559,7 +559,7 @@ xfs_iget_cache_miss(
>  	 */
>  	iflags = XFS_INEW;
>  	if (flags & XFS_IGET_DONTCACHE)
> -		iflags |= XFS_IDONTCACHE;
> +		VFS_I(ip)->i_state |= I_DONTCACHE;
>  	ip->i_udquot = NULL;
>  	ip->i_gdquot = NULL;
>  	ip->i_pdquot = NULL;
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index 83073c883fbf..52b8ee21a0b1 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -218,7 +218,7 @@ static inline bool xfs_inode_has_cow_data(struct xfs_inode *ip)
>  #define XFS_IFLOCK		(1 << __XFS_IFLOCK_BIT)
>  #define __XFS_IPINNED_BIT	8	 /* wakeup key for zero pin count */
>  #define XFS_IPINNED		(1 << __XFS_IPINNED_BIT)
> -#define XFS_IDONTCACHE		(1 << 9) /* don't cache the inode long term */
> +/* Was XFS_IDONTCACHE 9 */
>  #define XFS_IEOFBLOCKS		(1 << 10)/* has the preallocblocks tag set */
>  /*
>   * If this unlinked inode is in the middle of recovery, don't let drop_inode
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 0d0f74786799..2e165e226e15 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -742,7 +742,7 @@ xfs_fs_drop_inode(
>  		return 0;
>  	}
>  
> -	return generic_drop_inode(inode) || (ip->i_flags & XFS_IDONTCACHE);
> +	return generic_drop_inode(inode);
>  }
>  
>  static void
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index a87cc5845a02..44bd45af760f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2156,6 +2156,8 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
>   *
>   * I_CREATING		New object's inode in the middle of setting up.
>   *
> + * I_DONTCACHE		Evict inode as soon as it is not used anymore.
> + *
>   * Q: What is the difference between I_WILL_FREE and I_FREEING?
>   */
>  #define I_DIRTY_SYNC		(1 << 0)
> @@ -2178,6 +2180,7 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
>  #define I_WB_SWITCH		(1 << 13)
>  #define I_OVL_INUSE		(1 << 14)
>  #define I_CREATING		(1 << 15)
> +#define I_DONTCACHE		(1 << 16)
>  
>  #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
>  #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
> @@ -3049,7 +3052,8 @@ extern int inode_needs_sync(struct inode *inode);
>  extern int generic_delete_inode(struct inode *inode);
>  static inline int generic_drop_inode(struct inode *inode)
>  {
> -	return !inode->i_nlink || inode_unhashed(inode);
> +	return !inode->i_nlink || inode_unhashed(inode) ||
> +		(inode->i_state & I_DONTCACHE);
>  }
>  
>  extern struct inode *ilookup5_nowait(struct super_block *sb,
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
