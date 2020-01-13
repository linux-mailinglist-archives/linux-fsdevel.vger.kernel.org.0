Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6DAD139C50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 23:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbgAMWUP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 17:20:15 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54154 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgAMWUP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 17:20:15 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DMJhdc168530;
        Mon, 13 Jan 2020 22:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=VZYxsSXDVLldKS6ulHYgDmVwH29KbO41TSGFOenq35A=;
 b=NKtY4G1YUMQ7X+PRtIGB6zQ6iXis6g9CUQp6sEP+ZEyliB/0m3GfPwdBgUOOHOpj0XWY
 YP0D2UQpwI+y3ABGxSdRrPBgKJ76wMRVZ15IYQx+LrI8bUEuZqDB62McZmjPLqQShl/m
 kKYnexVoitnD+qA9h+7sMlBbIuqPW+mRME2dg0gxiLqhVYc5nJFkwt4zcQtw1A8vZF/S
 f1YpXaLfyayBXv7pHcOelZYYHpuoDY/AnAF6eQiPM+xW0RlQfqxJim1uDJnKIttYU0dM
 XQxZEASmSnUdH7dT+lZeORjENGxhyscLurWNx5Y7qvU9HJRaRRYhV4rqLqe8vRDL3lzo Og== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2xf73y9xum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 22:20:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DMJZPE005957;
        Mon, 13 Jan 2020 22:20:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2xfqvtkbf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 22:20:03 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00DMK0N7022050;
        Mon, 13 Jan 2020 22:20:00 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jan 2020 14:19:59 -0800
Date:   Mon, 13 Jan 2020 14:19:57 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH V2 08/12] fs/xfs: Add lock/unlock mode to xfs
Message-ID: <20200113221957.GN8247@magnolia>
References: <20200110192942.25021-1-ira.weiny@intel.com>
 <20200110192942.25021-9-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110192942.25021-9-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001130181
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001130182
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 10, 2020 at 11:29:38AM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> XFS requires regular files to be locked while changing to/from DAX mode.
> 
> Define a new DAX lock type and implement the [un]lock_mode() inode
> operation callbacks.
> 
> We define a new XFS_DAX_* lock type to carry the lock through the
> transaction because we don't want to use IOLOCK as that would cause
> performance issues with locking of the inode itself.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  fs/xfs/xfs_icache.c |  2 ++
>  fs/xfs/xfs_inode.c  | 37 +++++++++++++++++++++++++++++++++++--
>  fs/xfs/xfs_inode.h  | 12 ++++++++++--
>  fs/xfs/xfs_iops.c   | 24 +++++++++++++++++++++++-
>  4 files changed, 70 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index 8dc2e5414276..0288672e8902 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -74,6 +74,8 @@ xfs_inode_alloc(
>  	INIT_LIST_HEAD(&ip->i_ioend_list);
>  	spin_lock_init(&ip->i_ioend_lock);
>  
> +	percpu_init_rwsem(&ip->i_dax_sem);
> +
>  	return ip;
>  }
>  
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 401da197f012..e8fd95b75e5b 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -142,12 +142,12 @@ xfs_ilock_attr_map_shared(
>   *
>   * Basic locking order:
>   *
> - * i_rwsem -> i_mmap_lock -> page_lock -> i_ilock
> + * i_rwsem -> i_dax_sem -> i_mmap_lock -> page_lock -> i_ilock

Mmmmmm, more locks.  Can we skip the extra lock if CONFIG_FSDAX=n or if
the filesystem devices don't support DAX at all?

Also, I don't think we're actually following the i_rwsem -> i_daxsem
order in fallocate, and possibly elsewhere too?

Does the vfs have to take the i_dax_sem to do remapping things like
reflink?  (Pretend that reflink and dax are compatible for the moment)

>   * mmap_sem locking order:
>   *
>   * i_rwsem -> page lock -> mmap_sem
> - * mmap_sem -> i_mmap_lock -> page_lock
> + * mmap_sem -> i_dax_sem -> i_mmap_lock -> page_lock
>   *
>   * The difference in mmap_sem locking order mean that we cannot hold the
>   * i_mmap_lock over syscall based read(2)/write(2) based IO. These IO paths can
> @@ -181,6 +181,13 @@ xfs_ilock(
>  	ASSERT((lock_flags & (XFS_ILOCK_SHARED | XFS_ILOCK_EXCL)) !=
>  	       (XFS_ILOCK_SHARED | XFS_ILOCK_EXCL));
>  	ASSERT((lock_flags & ~(XFS_LOCK_MASK | XFS_LOCK_SUBCLASS_MASK)) == 0);
> +	ASSERT((lock_flags & (XFS_DAX_SHARED | XFS_DAX_EXCL)) !=
> +	       (XFS_DAX_SHARED | XFS_DAX_EXCL));
> +
> +	if (lock_flags & XFS_DAX_EXCL)
> +		percpu_down_write(&ip->i_dax_sem);
> +	else if (lock_flags & XFS_DAX_SHARED)
> +		percpu_down_read(&ip->i_dax_sem);
>  
>  	if (lock_flags & XFS_IOLOCK_EXCL) {
>  		down_write_nested(&VFS_I(ip)->i_rwsem,
> @@ -224,6 +231,8 @@ xfs_ilock_nowait(
>  	 * You can't set both SHARED and EXCL for the same lock,
>  	 * and only XFS_IOLOCK_SHARED, XFS_IOLOCK_EXCL, XFS_ILOCK_SHARED,
>  	 * and XFS_ILOCK_EXCL are valid values to set in lock_flags.
> +	 *
> +	 * XFS_DAX_* is not allowed
>  	 */
>  	ASSERT((lock_flags & (XFS_IOLOCK_SHARED | XFS_IOLOCK_EXCL)) !=
>  	       (XFS_IOLOCK_SHARED | XFS_IOLOCK_EXCL));
> @@ -232,6 +241,7 @@ xfs_ilock_nowait(
>  	ASSERT((lock_flags & (XFS_ILOCK_SHARED | XFS_ILOCK_EXCL)) !=
>  	       (XFS_ILOCK_SHARED | XFS_ILOCK_EXCL));
>  	ASSERT((lock_flags & ~(XFS_LOCK_MASK | XFS_LOCK_SUBCLASS_MASK)) == 0);
> +	ASSERT((lock_flags & (XFS_DAX_SHARED | XFS_DAX_EXCL)) == 0);
>  
>  	if (lock_flags & XFS_IOLOCK_EXCL) {
>  		if (!down_write_trylock(&VFS_I(ip)->i_rwsem))
> @@ -302,6 +312,8 @@ xfs_iunlock(
>  	       (XFS_ILOCK_SHARED | XFS_ILOCK_EXCL));
>  	ASSERT((lock_flags & ~(XFS_LOCK_MASK | XFS_LOCK_SUBCLASS_MASK)) == 0);
>  	ASSERT(lock_flags != 0);
> +	ASSERT((lock_flags & (XFS_DAX_SHARED | XFS_DAX_EXCL)) !=
> +	       (XFS_DAX_SHARED | XFS_DAX_EXCL));
>  
>  	if (lock_flags & XFS_IOLOCK_EXCL)
>  		up_write(&VFS_I(ip)->i_rwsem);
> @@ -318,6 +330,11 @@ xfs_iunlock(
>  	else if (lock_flags & XFS_ILOCK_SHARED)
>  		mrunlock_shared(&ip->i_lock);
>  
> +	if (lock_flags & XFS_DAX_EXCL)
> +		percpu_up_write(&ip->i_dax_sem);
> +	else if (lock_flags & XFS_DAX_SHARED)
> +		percpu_up_read(&ip->i_dax_sem);
> +
>  	trace_xfs_iunlock(ip, lock_flags, _RET_IP_);
>  }
>  
> @@ -333,6 +350,8 @@ xfs_ilock_demote(
>  	ASSERT(lock_flags & (XFS_IOLOCK_EXCL|XFS_MMAPLOCK_EXCL|XFS_ILOCK_EXCL));
>  	ASSERT((lock_flags &
>  		~(XFS_IOLOCK_EXCL|XFS_MMAPLOCK_EXCL|XFS_ILOCK_EXCL)) == 0);
> +	/* XFS_DAX_* is not allowed */
> +	ASSERT((lock_flags & (XFS_DAX_SHARED | XFS_DAX_EXCL)) == 0);
>  
>  	if (lock_flags & XFS_ILOCK_EXCL)
>  		mrdemote(&ip->i_lock);
> @@ -369,6 +388,13 @@ xfs_isilocked(
>  		return rwsem_is_locked(&VFS_I(ip)->i_rwsem);
>  	}
>  
> +	if (lock_flags & (XFS_DAX_EXCL|XFS_DAX_SHARED)) {
> +		if (!(lock_flags & XFS_DAX_SHARED))
> +			return !debug_locks ||
> +				percpu_rwsem_is_held(&ip->i_dax_sem, 0);
> +		return rwsem_is_locked(&ip->i_dax_sem);
> +	}
> +
>  	ASSERT(0);
>  	return 0;
>  }
> @@ -465,6 +491,9 @@ xfs_lock_inodes(
>  	ASSERT(!(lock_mode & XFS_ILOCK_EXCL) ||
>  		inodes <= XFS_ILOCK_MAX_SUBCLASS + 1);
>  
> +	/* XFS_DAX_* is not allowed */
> +	ASSERT((lock_mode & (XFS_DAX_SHARED | XFS_DAX_EXCL)) == 0);
> +
>  	if (lock_mode & XFS_IOLOCK_EXCL) {
>  		ASSERT(!(lock_mode & (XFS_MMAPLOCK_EXCL | XFS_ILOCK_EXCL)));
>  	} else if (lock_mode & XFS_MMAPLOCK_EXCL)
> @@ -566,6 +595,10 @@ xfs_lock_two_inodes(
>  	ASSERT(!(ip0_mode & (XFS_MMAPLOCK_SHARED|XFS_MMAPLOCK_EXCL)) ||
>  	       !(ip1_mode & (XFS_ILOCK_SHARED|XFS_ILOCK_EXCL)));
>  
> +	/* XFS_DAX_* is not allowed */
> +	ASSERT((ip0_mode & (XFS_DAX_SHARED | XFS_DAX_EXCL)) == 0);
> +	ASSERT((ip1_mode & (XFS_DAX_SHARED | XFS_DAX_EXCL)) == 0);
> +
>  	ASSERT(ip0->i_ino != ip1->i_ino);
>  
>  	if (ip0->i_ino > ip1->i_ino) {
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index 492e53992fa9..693ca66bd89b 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -67,6 +67,9 @@ typedef struct xfs_inode {
>  	spinlock_t		i_ioend_lock;
>  	struct work_struct	i_ioend_work;
>  	struct list_head	i_ioend_list;
> +
> +	/* protect changing the mode to/from DAX */
> +	struct percpu_rw_semaphore i_dax_sem;
>  } xfs_inode_t;
>  
>  /* Convert from vfs inode to xfs inode */
> @@ -278,10 +281,13 @@ static inline void xfs_ifunlock(struct xfs_inode *ip)
>  #define	XFS_ILOCK_SHARED	(1<<3)
>  #define	XFS_MMAPLOCK_EXCL	(1<<4)
>  #define	XFS_MMAPLOCK_SHARED	(1<<5)
> +#define	XFS_DAX_EXCL		(1<<6)
> +#define	XFS_DAX_SHARED		(1<<7)
>  
>  #define XFS_LOCK_MASK		(XFS_IOLOCK_EXCL | XFS_IOLOCK_SHARED \
>  				| XFS_ILOCK_EXCL | XFS_ILOCK_SHARED \
> -				| XFS_MMAPLOCK_EXCL | XFS_MMAPLOCK_SHARED)
> +				| XFS_MMAPLOCK_EXCL | XFS_MMAPLOCK_SHARED \
> +				| XFS_DAX_EXCL | XFS_DAX_SHARED)
>  
>  #define XFS_LOCK_FLAGS \
>  	{ XFS_IOLOCK_EXCL,	"IOLOCK_EXCL" }, \
> @@ -289,7 +295,9 @@ static inline void xfs_ifunlock(struct xfs_inode *ip)
>  	{ XFS_ILOCK_EXCL,	"ILOCK_EXCL" }, \
>  	{ XFS_ILOCK_SHARED,	"ILOCK_SHARED" }, \
>  	{ XFS_MMAPLOCK_EXCL,	"MMAPLOCK_EXCL" }, \
> -	{ XFS_MMAPLOCK_SHARED,	"MMAPLOCK_SHARED" }
> +	{ XFS_MMAPLOCK_SHARED,	"MMAPLOCK_SHARED" }, \
> +	{ XFS_DAX_EXCL,   	"DAX_EXCL" }, \

Whitespace between the comma & string.

> +	{ XFS_DAX_SHARED,	"DAX_SHARED" }
>  
>  
>  /*
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index d6843cdb51d0..a2f2604c3187 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1158,6 +1158,16 @@ xfs_vn_tmpfile(
>  	return xfs_generic_create(dir, dentry, mode, 0, true);
>  }
>  
> +static void xfs_lock_mode(struct inode *inode)
> +{
> +	xfs_ilock(XFS_I(inode), XFS_DAX_SHARED);
> +}
> +
> +static void xfs_unlock_mode(struct inode *inode)
> +{
> +	xfs_iunlock(XFS_I(inode), XFS_DAX_SHARED);
> +}
> +
>  static const struct inode_operations xfs_inode_operations = {
>  	.get_acl		= xfs_get_acl,
>  	.set_acl		= xfs_set_acl,
> @@ -1168,6 +1178,18 @@ static const struct inode_operations xfs_inode_operations = {
>  	.update_time		= xfs_vn_update_time,
>  };
>  
> +static const struct inode_operations xfs_reg_inode_operations = {
> +	.get_acl		= xfs_get_acl,
> +	.set_acl		= xfs_set_acl,
> +	.getattr		= xfs_vn_getattr,
> +	.setattr		= xfs_vn_setattr,
> +	.listxattr		= xfs_vn_listxattr,
> +	.fiemap			= xfs_vn_fiemap,
> +	.update_time		= xfs_vn_update_time,
> +	.lock_mode              = xfs_lock_mode,
> +	.unlock_mode            = xfs_unlock_mode,
> +};
> +
>  static const struct inode_operations xfs_dir_inode_operations = {
>  	.create			= xfs_vn_create,
>  	.lookup			= xfs_vn_lookup,
> @@ -1372,7 +1394,7 @@ xfs_setup_iops(
>  
>  	switch (inode->i_mode & S_IFMT) {
>  	case S_IFREG:
> -		inode->i_op = &xfs_inode_operations;
> +		inode->i_op = &xfs_reg_inode_operations;

xfs_file_inode_operations?

--D

>  		inode->i_fop = &xfs_file_operations;
>  		if (IS_DAX(inode))
>  			inode->i_mapping->a_ops = &xfs_dax_aops;
> -- 
> 2.21.0
> 
