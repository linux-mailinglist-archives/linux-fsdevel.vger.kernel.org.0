Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3F31BCD15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 22:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgD1UKP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 16:10:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36486 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgD1UJr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 16:09:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SJwkYu141282;
        Tue, 28 Apr 2020 20:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=R6CZhV28M+6lk4C99qksrUjkNq5T+6h8siYr5Mc47RE=;
 b=vhUsyv6dFrltgGFh65povAe65d9OfwYvkpKoUhiBq4ARoipLBZu298DR1015+6u2bo71
 AbMDRdIhQNwWrPnBQmLpTBrskwBsMSKUjbId6W4E/0pVy6tDvITDLUsmk0P6SF3TbHoh
 lljmrQilNDxNvSUHVGz0cLbjyV2yJWO1akgyhpFeDPeaLw9krVcpgmnIOwhIa1quP/TE
 RD/j7uyZIieDgmwLyxcdKoXdOrvmscNNULPZXymvc+Bmsxe3nPKswzjxaH+PUN5i8eOH
 fOBJaijoEehNKNmXp/HHC2808DVImDe9CQMeOacCVaM6gNw8ZI+1zg8Uzycn6w/7TBlV UQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30nucg25jc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 20:09:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SK85x7194362;
        Tue, 28 Apr 2020 20:09:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30mxx0nnkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 20:09:35 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03SK9X0o016090;
        Tue, 28 Apr 2020 20:09:33 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 13:09:32 -0700
Date:   Tue, 28 Apr 2020 13:09:30 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH V11 10/11] fs: Introduce DCACHE_DONTCACHE
Message-ID: <20200428200930.GC6742@magnolia>
References: <20200428002142.404144-1-ira.weiny@intel.com>
 <20200428002142.404144-11-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428002142.404144-11-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=1 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=1 malwarescore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280157
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 27, 2020 at 05:21:41PM -0700, ira.weiny@intel.com wrote:
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

Seems reasonable to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> 
> ---
> Changes from V10:
> 	rename to d_mark_dontcache()
> 	Move function to fs/dcache.c
> 
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
>  fs/dcache.c            | 19 +++++++++++++++++++
>  fs/xfs/xfs_icache.c    |  2 +-
>  include/linux/dcache.h |  2 ++
>  include/linux/fs.h     |  1 +
>  4 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index b280e07e162b..0d07fb335b78 100644
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
> @@ -656,6 +660,21 @@ static inline bool retain_dentry(struct dentry *dentry)
>  	return true;
>  }
>  
> +void d_mark_dontcache(struct inode *inode)
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
> +EXPORT_SYMBOL(d_mark_dontcache);
> +
>  /*
>   * Finish off a dentry we've decided to kill.
>   * dentry->d_lock must be held, returns with it unlocked.
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index de76f7f60695..888646d74d7d 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -559,7 +559,7 @@ xfs_iget_cache_miss(
>  	 */
>  	iflags = XFS_INEW;
>  	if (flags & XFS_IGET_DONTCACHE)
> -		VFS_I(ip)->i_state |= I_DONTCACHE;
> +		d_mark_dontcache(VFS_I(ip));
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
> index 44bd45af760f..7c3e8c0306e0 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3055,6 +3055,7 @@ static inline int generic_drop_inode(struct inode *inode)
>  	return !inode->i_nlink || inode_unhashed(inode) ||
>  		(inode->i_state & I_DONTCACHE);
>  }
> +extern void d_mark_dontcache(struct inode *inode);
>  
>  extern struct inode *ilookup5_nowait(struct super_block *sb,
>  		unsigned long hashval, int (*test)(struct inode *, void *),
> -- 
> 2.25.1
> 
