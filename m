Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1DB1B5761
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 10:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgDWIk5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 04:40:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:44290 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgDWIk4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 04:40:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EA591AFDC;
        Thu, 23 Apr 2020 08:40:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id ED3521E0E61; Thu, 23 Apr 2020 10:40:51 +0200 (CEST)
Date:   Thu, 23 Apr 2020 10:40:51 +0200
From:   Jan Kara <jack@suse.cz>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH V10 10/11] fs: Introduce DCACHE_DONTCACHE
Message-ID: <20200423084051.GC3737@quack2.suse.cz>
References: <20200422212102.3757660-1-ira.weiny@intel.com>
 <20200422212102.3757660-11-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422212102.3757660-11-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 22-04-20 14:21:01, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> DCACHE_DONTCACHE indicates a dentry should not be cached on final
> dput().
> 
> Also add a helper function to mark DCACHE_DONTCACHE on all dentries
> pointing to a specific inode when that inode is being set I_DONTCACHE.
> 
> This facilitates dropping dentry references to inodes sooner which
> require eviction to swap S_DAX mode.
> 
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> ---
> Changes from V9:
> 	modify i_state under i_lock
> 	Update comment
> 		"Purge from memory on final dput()"
> 
> Changes from V8:
> 	Update commit message
> 	Use mark_inode_dontcache in XFS
> 	Fix locking...  can't use rcu here.
> 	Change name to mark_inode_dontcache
> ---
>  fs/dcache.c            |  4 ++++
>  fs/inode.c             | 15 +++++++++++++++
>  fs/xfs/xfs_icache.c    |  2 +-
>  include/linux/dcache.h |  2 ++
>  include/linux/fs.h     |  1 +
>  5 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index b280e07e162b..0030fabab2c4 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -647,6 +647,10 @@ static inline bool retain_dentry(struct dentry *dentry)
>  		if (dentry->d_op->d_delete(dentry))
>  			return false;
>  	}
> +
> +	if (unlikely(dentry->d_flags & DCACHE_DONTCACHE))
> +		return false;
> +
>  	/* retain; LRU fodder */
>  	dentry->d_lockref.count--;
>  	if (unlikely(!(dentry->d_flags & DCACHE_LRU_LIST)))
> diff --git a/fs/inode.c b/fs/inode.c
> index 93d9252a00ab..316355433797 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1526,6 +1526,21 @@ int generic_delete_inode(struct inode *inode)
>  }
>  EXPORT_SYMBOL(generic_delete_inode);
>  
> +void mark_inode_dontcache(struct inode *inode)
> +{
> +	struct dentry *de;
> +
> +	spin_lock(&inode->i_lock);
> +	hlist_for_each_entry(de, &inode->i_dentry, d_u.d_alias) {
> +		spin_lock(&de->d_lock);
> +		de->d_flags |= DCACHE_DONTCACHE;
> +		spin_unlock(&de->d_lock);
> +	}
> +	inode->i_state |= I_DONTCACHE;
> +	spin_unlock(&inode->i_lock);
> +}
> +EXPORT_SYMBOL(mark_inode_dontcache);
> +
>  /*
>   * Called when we're dropping the last reference
>   * to an inode.
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index de76f7f60695..3c8f44477804 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -559,7 +559,7 @@ xfs_iget_cache_miss(
>  	 */
>  	iflags = XFS_INEW;
>  	if (flags & XFS_IGET_DONTCACHE)
> -		VFS_I(ip)->i_state |= I_DONTCACHE;
> +		mark_inode_dontcache(VFS_I(ip));
>  	ip->i_udquot = NULL;
>  	ip->i_gdquot = NULL;
>  	ip->i_pdquot = NULL;
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index c1488cc84fd9..a81f0c3cf352 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -177,6 +177,8 @@ struct dentry_operations {
>  
>  #define DCACHE_REFERENCED		0x00000040 /* Recently used, don't discard. */
>  
> +#define DCACHE_DONTCACHE		0x00000080 /* Purge from memory on final dput() */
> +
>  #define DCACHE_CANT_MOUNT		0x00000100
>  #define DCACHE_GENOCIDE			0x00000200
>  #define DCACHE_SHRINK_LIST		0x00000400
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 44bd45af760f..064168ec2e0b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3055,6 +3055,7 @@ static inline int generic_drop_inode(struct inode *inode)
>  	return !inode->i_nlink || inode_unhashed(inode) ||
>  		(inode->i_state & I_DONTCACHE);
>  }
> +extern void mark_inode_dontcache(struct inode *inode);
>  
>  extern struct inode *ilookup5_nowait(struct super_block *sb,
>  		unsigned long hashval, int (*test)(struct inode *, void *),
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
