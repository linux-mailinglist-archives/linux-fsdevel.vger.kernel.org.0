Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 841E92CBE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 18:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfE1Q0s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 12:26:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52752 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfE1Q0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 12:26:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SGDgSS161106;
        Tue, 28 May 2019 16:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=hx2vbgFlPWg0pATA4dyIp86RZ6zf7/0wKbEWhZGmDvo=;
 b=efMbIJfOzK55xuUxc3yaBfW5u6VwnzkWf6wdE//yngZ2fA3fNktEWNxl4sKBd9VtCcY4
 ZvHTegR6hVVZkuZiLe4FuqltjYxxmVXYf50XB+NKVRncfV2Qh6QgOHwbDy0VO5qrBFNE
 p7+s6GtVyRLkX3sNWP/ZgCpaQ5Vs4Zpph1kny7YlYg6snAl935YpNXOgKuyLUb7G2n0g
 J76PqI4qw0U30xgh8zigyTi8lSl8k9bodUrVWdXRd5ptjtRqDrAJDebhaxSxzpYMsfd6
 FOIGWp6tswn90qa6Do9Z3sD6zTSOZEeie1u2BNX5FSMKqUORS8yXJjtQwvaTCoWrRdEI qg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2spxbq4aqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 16:25:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SGPnfU126357;
        Tue, 28 May 2019 16:25:56 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2srbdww1dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 16:25:56 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4SGPtM2013151;
        Tue, 28 May 2019 16:25:55 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 May 2019 09:25:55 -0700
Date:   Tue, 28 May 2019 09:25:53 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-api@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH v2 5/8] vfs: copy_file_range needs to strip setuid bits
Message-ID: <20190528162553.GE5221@magnolia>
References: <20190526061100.21761-1-amir73il@gmail.com>
 <20190526061100.21761-6-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526061100.21761-6-amir73il@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905280104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905280104
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 26, 2019 at 09:10:56AM +0300, Amir Goldstein wrote:
> The file we are copying data into needs to have its setuid bit
> stripped before we start the data copy so that unprivileged users
> can't copy data into executables that are run with root privs.
> 
> [Amir] Introduce the helper generic_copy_file_range_prep() modelled
> after generic_remap_file_range_prep(). Helper is called by filesystem
> before the copy_file_range operation and with output inode locked.
> 
> For ceph and for default generic_copy_file_range() implementation there
> is no inode lock held throughout the copy operation, so we do best
> effort and remove setuid bit before copy starts. This does not protect
> suid file from changing if suid bit is set after copy started.

Maybe we try to remove suid once more at the end of
generic_copy_file_range if the copy succeeds?  It'd still be racy, but I
can't (currently, having drank no coffee yet) think of a general way to
hold both inodes locked during the entire copy operation.

--D

> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/ceph/file.c     |  9 +++++++++
>  fs/cifs/cifsfs.c   |  9 ++++++---
>  fs/fuse/file.c     |  4 ++++
>  fs/nfs/nfs42proc.c |  8 +++++---
>  fs/read_write.c    | 31 +++++++++++++++++++++++++++++++
>  include/linux/fs.h |  2 ++
>  6 files changed, 57 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index e87f7b2023af..54cfc877a6ef 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1947,6 +1947,15 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
>  		goto out;
>  	}
>  
> +	/* Should inode lock be held throughout the copy operation? */
> +	inode_lock(dst_inode);
> +	ret = generic_copy_file_range_prep(src_file, dst_file);
> +	inode_unlock(dst_inode);
> +	if (ret < 0) {
> +		dout("failed to copy from src to dst file (%zd)\n", ret);
> +		goto out;
> +	}
> +
>  	/*
>  	 * We need FILE_WR caps for dst_ci and FILE_RD for src_ci as other
>  	 * clients may have dirty data in their caches.  And OSDs know nothing
> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index c65823270313..e103b499aaa8 100644
> --- a/fs/cifs/cifsfs.c
> +++ b/fs/cifs/cifsfs.c
> @@ -1096,6 +1096,10 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
>  		goto out;
>  	}
>  
> +	rc = -EOPNOTSUPP;
> +	if (!target_tcon->ses->server->ops->copychunk_range)
> +		goto out;
> +
>  	/*
>  	 * Note: cifs case is easier than btrfs since server responsible for
>  	 * checks for proper open modes and file type and if it wants
> @@ -1107,11 +1111,10 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
>  	/* should we flush first and last page first */
>  	truncate_inode_pages(&target_inode->i_data, 0);
>  
> -	if (target_tcon->ses->server->ops->copychunk_range)
> +	rc = generic_copy_file_range_prep(src_file, dst_file);
> +	if (!rc)
>  		rc = target_tcon->ses->server->ops->copychunk_range(xid,
>  			smb_file_src, smb_file_target, off, len, destoff);
> -	else
> -		rc = -EOPNOTSUPP;
>  
>  	/* force revalidate of size and timestamps of target file now
>  	 * that target is updated on the server
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index e03901ae729b..3531d4a3d9ec 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -3128,6 +3128,10 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
>  
>  	inode_lock(inode_out);
>  
> +	err = generic_copy_file_range_prep(file_in, file_out);
> +	if (err)
> +		goto out;
> +
>  	if (fc->writeback_cache) {
>  		err = filemap_write_and_wait_range(inode_out->i_mapping,
>  						   pos_out, pos_out + len);
> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> index 5196bfa7894d..b387951e1d86 100644
> --- a/fs/nfs/nfs42proc.c
> +++ b/fs/nfs/nfs42proc.c
> @@ -345,9 +345,11 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
>  
>  	do {
>  		inode_lock(file_inode(dst));
> -		err = _nfs42_proc_copy(src, src_lock,
> -				dst, dst_lock,
> -				&args, &res);
> +		err = generic_copy_file_range_prep(src, dst);
> +		if (!err)
> +			err = _nfs42_proc_copy(src, src_lock,
> +					       dst, dst_lock,
> +					       &args, &res);
>  		inode_unlock(file_inode(dst));
>  
>  		if (err >= 0)
> diff --git a/fs/read_write.c b/fs/read_write.c
> index b0fb1176b628..e16bcafc0da2 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1565,6 +1565,28 @@ COMPAT_SYSCALL_DEFINE4(sendfile64, int, out_fd, int, in_fd,
>  }
>  #endif
>  
> +/*
> + * Prepare inodes for copy from @file_in to @file_out.
> + *
> + * Caller must hold output inode lock.
> + */
> +int generic_copy_file_range_prep(struct file *file_in, struct file *file_out)
> +{
> +	int ret;
> +
> +	WARN_ON_ONCE(!inode_is_locked(file_inode(file_out)));
> +
> +	/*
> +	 * Clear the security bits if the process is not being run by root.
> +	 * This keeps people from modifying setuid and setgid binaries.
> +	 */
> +	ret = file_remove_privs(file_out);
> +
> +	return ret;
> +
> +}
> +EXPORT_SYMBOL(generic_copy_file_range_prep);
> +
>  /**
>   * generic_copy_file_range - copy data between two files
>   * @file_in:	file structure to read from
> @@ -1590,6 +1612,15 @@ ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
>  				struct file *file_out, loff_t pos_out,
>  				size_t len, unsigned int flags)
>  {
> +	int ret;
> +
> +	/* Should inode lock be held throughout the copy operation? */
> +	inode_lock(file_inode(file_out));
> +	ret = generic_copy_file_range_prep(file_in, file_out);
> +	inode_unlock(file_inode(file_out));
> +	if (ret)
> +		return ret;
> +
>  	return do_splice_direct(file_in, &pos_in, file_out, &pos_out,
>  				len > MAX_RW_COUNT ? MAX_RW_COUNT : len, 0);
>  }
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e4d382c4342a..3e03a96d9ab6 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1889,6 +1889,8 @@ extern ssize_t vfs_readv(struct file *, const struct iovec __user *,
>  		unsigned long, loff_t *, rwf_t);
>  extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
>  				   loff_t, size_t, unsigned int);
> +extern int generic_copy_file_range_prep(struct file *file_in,
> +					struct file *file_out);
>  extern ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
>  				       struct file *file_out, loff_t pos_out,
>  				       size_t len, unsigned int flags);
> -- 
> 2.17.1
> 
