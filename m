Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298C41B3122
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 22:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgDUUZf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 16:25:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41392 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgDUUZf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 16:25:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03LKITIK048607;
        Tue, 21 Apr 2020 20:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=yzLo5MF9PgEMTNjrL5wM+W+ag6Y+TYzagHurbKJwOiE=;
 b=Wg81oZOT8cBInti8GMRNl2MZIJSClpW35nbdOmufbb1hQAVckmhXR45U2SSK0RNwQIvh
 iDEndfhiQHyY0X1hWTUuUhzKWIVC+FpCEqD4ZrvvnBHV1W6PR8EKe4zuFfMWt3s1U/En
 QmcjGKz8+RnAC6Uh6t9On3ZY7MV2gl4klxW0gXodiUgNyDIXRkSYlEfyfrTFzN2A5atv
 0W7dfuMTJeXdfVZa2TKmWmBsWaGlQHv2U+COj23Ibnd/OV1lZL8spWceYIUZYWkXCen2
 FBYzsbuk1MGbeogpUNBrPiomFjZgCkxSYYqMV9KBxb7O4q2a1m6PAjqjKEcKRsgR+gjx TQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30grpgkmp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 20:25:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03LKCTxv162092;
        Tue, 21 Apr 2020 20:25:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 30gbbesmdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 20:25:22 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03LKPLn3015795;
        Tue, 21 Apr 2020 20:25:21 GMT
Received: from localhost (/10.159.227.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Apr 2020 13:25:21 -0700
Date:   Tue, 21 Apr 2020 13:25:19 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V9 09/11] fs: Introduce DCACHE_DONTCACHE
Message-ID: <20200421202519.GC6742@magnolia>
References: <20200421191754.3372370-1-ira.weiny@intel.com>
 <20200421191754.3372370-10-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421191754.3372370-10-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=1 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=1 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004210151
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 21, 2020 at 12:17:51PM -0700, ira.weiny@intel.com wrote:
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
> 
> ---
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
> index 93d9252a00ab..da7f3c4926cd 100644
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
> +	spin_unlock(&inode->i_lock);
> +	inode->i_state |= I_DONTCACHE;
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
> index c1488cc84fd9..56b1482d9223 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -177,6 +177,8 @@ struct dentry_operations {
>  
>  #define DCACHE_REFERENCED		0x00000040 /* Recently used, don't discard. */
>  
> +#define DCACHE_DONTCACHE		0x00000080 /* don't cache on final dput() */

"Purge from memory on final dput()"?

--D

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
