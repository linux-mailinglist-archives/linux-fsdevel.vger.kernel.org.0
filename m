Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E8F1BCCF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 22:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgD1UGX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 16:06:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49668 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgD1UGW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 16:06:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SJxW2s007443;
        Tue, 28 Apr 2020 20:06:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=lS1jt9qUhtYP/TsyQs7xYd6MSkddoMnKFatL19J2soU=;
 b=hxK9Pf5nAUBUa3vs+r8wovvjXaG1/b8oqIVFBeUY4Y7qneFajxRWlfOkBmB7QV7VEqAA
 qgXIqyItr11TYS68TdXbHQ/PdJZYHlKeYWL5SehzjFLDjWAoRWaZk6zeCz171RaHXY58
 OpjmzlmOSuwrTXTsY9E8ZhlpnbDRDRrkICvVomtjKC4JHiR29YXsxbgT/2cohXjKQsXb
 iwpOAXE/8mrg7RWDhRBlua8x58J7IGa0K+Pstj8CzDYsxfnjNoCCTaBc18RC0MEzEKfW
 QuraLYLjcStpuh0n/C4Leqw04NAw7BUItSGd7pIoI2cDv2qssEHpv80H5gZvlmMdunl/ ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 30p2p07hjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 20:06:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SJv056001225;
        Tue, 28 Apr 2020 20:06:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 30my0e7h7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 20:06:07 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03SK63Sx013414;
        Tue, 28 Apr 2020 20:06:03 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 13:06:02 -0700
Date:   Tue, 28 Apr 2020 13:06:00 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH V11 09/11] fs: Lift XFS_IDONTCACHE to the VFS layer
Message-ID: <20200428200600.GA6742@magnolia>
References: <20200428002142.404144-1-ira.weiny@intel.com>
 <20200428002142.404144-10-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428002142.404144-10-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=3 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 clxscore=1011
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=3 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280157
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 27, 2020 at 05:21:40PM -0700, ira.weiny@intel.com wrote:
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
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Looks ok to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> 
> ---
> Changes from V9:
> 	Fix misspelling in commit subject
> 	move XFS_IEOFBLOCKS to '9'
> 
> Changes from V8:
> 	Remove XFS_IDONTCACHE
> ---
>  fs/xfs/xfs_icache.c | 4 ++--
>  fs/xfs/xfs_inode.h  | 3 +--
>  fs/xfs/xfs_super.c  | 2 +-
>  include/linux/fs.h  | 6 +++++-
>  4 files changed, 9 insertions(+), 6 deletions(-)
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
> index 83073c883fbf..d8ce3eaa246e 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -218,8 +218,7 @@ static inline bool xfs_inode_has_cow_data(struct xfs_inode *ip)
>  #define XFS_IFLOCK		(1 << __XFS_IFLOCK_BIT)
>  #define __XFS_IPINNED_BIT	8	 /* wakeup key for zero pin count */
>  #define XFS_IPINNED		(1 << __XFS_IPINNED_BIT)
> -#define XFS_IDONTCACHE		(1 << 9) /* don't cache the inode long term */
> -#define XFS_IEOFBLOCKS		(1 << 10)/* has the preallocblocks tag set */
> +#define XFS_IEOFBLOCKS		(1 << 9) /* has the preallocblocks tag set */
>  /*
>   * If this unlinked inode is in the middle of recovery, don't let drop_inode
>   * truncate and free the inode.  This can happen if we iget the inode during
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index e80bd2c4c279..6f91c13fb6ea 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -737,7 +737,7 @@ xfs_fs_drop_inode(
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
