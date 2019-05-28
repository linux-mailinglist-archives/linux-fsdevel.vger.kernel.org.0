Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD0D92CB30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 18:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfE1QK2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 12:10:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47054 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfE1QK1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 12:10:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SG9PEU148139;
        Tue, 28 May 2019 16:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=qorUMK1v9HhQ+q//nWQ7Plmkh7GZi4VQt8I7/SEfPrY=;
 b=jH+b4g2nTntOFebAnpi4wB7tlIlzdHYPo+Da6JJMm3EEYCfDbSBGUSRsoNaRXaAh5Pln
 k97b4lWSPjHiFNL3NbCi5aIACFERjlBzjPzf0lHXWJ4CjSZXwl/VFiduQY8jg12lTFpL
 PAKacYtO/wF5l/KUAg2KEK6oCLEK3oLykd5Afgyian8UOkey7G61TehxV9FiI3qXc6RJ
 NgABsOMx3spQz7+kzip/6hBglOTeKdkviVFOyw0P+sgt9fAhjMdQrUxCv1f3gzSXem6i
 bSjmYN9Z7sc3y4hOJ8v7lNnFrYqOxdZ1w3Cim49m5pHR7x+a2MbQOVKWcFOM1+8giH85 dw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2spw4tcahr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 16:09:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SG84TR094641;
        Tue, 28 May 2019 16:09:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2sr31urhxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 16:09:35 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4SG9W3w017148;
        Tue, 28 May 2019 16:09:33 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 May 2019 09:09:32 -0700
Date:   Tue, 28 May 2019 09:09:30 -0700
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
Subject: Re: [PATCH v2 2/8] vfs: no fallback for ->copy_file_range
Message-ID: <20190528160930.GA5221@magnolia>
References: <20190526061100.21761-1-amir73il@gmail.com>
 <20190526061100.21761-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526061100.21761-3-amir73il@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905280103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905280103
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 26, 2019 at 09:10:53AM +0300, Amir Goldstein wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Now that we have generic_copy_file_range(), remove it as a fallback
> case when offloads fail. This puts the responsibility for executing
> fallbacks on the filesystems that implement ->copy_file_range and
> allows us to add operational validity checks to
> generic_copy_file_range().
> 
> Rework vfs_copy_file_range() to call a new do_copy_file_range()
> helper to exceute the copying callout, and move calls to

    execute ^^^^^^^

> generic_file_copy_range() into filesystem methods where they
> currently return failures.
> 
> [Amir] overlayfs is not responsible of executing the fallback.
> It is the responsibility of the underlying filesystem.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Seems fine to me otherwise...
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/ceph/file.c    | 21 ++++++++++++++++++---
>  fs/cifs/cifsfs.c  |  4 ++++
>  fs/fuse/file.c    | 21 ++++++++++++++++++---
>  fs/nfs/nfs4file.c | 20 +++++++++++++++++---
>  fs/read_write.c   | 25 ++++++++++++++++---------
>  5 files changed, 73 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 305daf043eb0..e87f7b2023af 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1889,9 +1889,9 @@ static int is_file_size_ok(struct inode *src_inode, struct inode *dst_inode,
>  	return 0;
>  }
>  
> -static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
> -				    struct file *dst_file, loff_t dst_off,
> -				    size_t len, unsigned int flags)
> +static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
> +				      struct file *dst_file, loff_t dst_off,
> +				      size_t len, unsigned int flags)
>  {
>  	struct inode *src_inode = file_inode(src_file);
>  	struct inode *dst_inode = file_inode(dst_file);
> @@ -2100,6 +2100,21 @@ static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
>  	return ret;
>  }
>  
> +static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
> +				    struct file *dst_file, loff_t dst_off,
> +				    size_t len, unsigned int flags)
> +{
> +	ssize_t ret;
> +
> +	ret = __ceph_copy_file_range(src_file, src_off, dst_file, dst_off,
> +				     len, flags);
> +
> +	if (ret == -EOPNOTSUPP)
> +		ret = generic_copy_file_range(src_file, src_off, dst_file,
> +					      dst_off, len, flags);
> +	return ret;
> +}
> +
>  const struct file_operations ceph_file_fops = {
>  	.open = ceph_open,
>  	.release = ceph_release,
> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index f5fcd6360056..c65823270313 100644
> --- a/fs/cifs/cifsfs.c
> +++ b/fs/cifs/cifsfs.c
> @@ -1148,6 +1148,10 @@ static ssize_t cifs_copy_file_range(struct file *src_file, loff_t off,
>  	rc = cifs_file_copychunk_range(xid, src_file, off, dst_file, destoff,
>  					len, flags);
>  	free_xid(xid);
> +
> +	if (rc == -EOPNOTSUPP)
> +		rc = generic_copy_file_range(src_file, off, dst_file,
> +					     destoff, len, flags);
>  	return rc;
>  }
>  
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 3959f08279e6..e03901ae729b 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -3097,9 +3097,9 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
>  	return err;
>  }
>  
> -static ssize_t fuse_copy_file_range(struct file *file_in, loff_t pos_in,
> -				    struct file *file_out, loff_t pos_out,
> -				    size_t len, unsigned int flags)
> +static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
> +				      struct file *file_out, loff_t pos_out,
> +				      size_t len, unsigned int flags)
>  {
>  	struct fuse_file *ff_in = file_in->private_data;
>  	struct fuse_file *ff_out = file_out->private_data;
> @@ -3173,6 +3173,21 @@ static ssize_t fuse_copy_file_range(struct file *file_in, loff_t pos_in,
>  	return err;
>  }
>  
> +static ssize_t fuse_copy_file_range(struct file *src_file, loff_t src_off,
> +				    struct file *dst_file, loff_t dst_off,
> +				    size_t len, unsigned int flags)
> +{
> +	ssize_t ret;
> +
> +	ret = __fuse_copy_file_range(src_file, src_off, dst_file, dst_off,
> +				     len, flags);
> +
> +	if (ret == -EOPNOTSUPP)
> +		ret = generic_copy_file_range(src_file, src_off, dst_file,
> +					      dst_off, len, flags);
> +	return ret;
> +}
> +
>  static const struct file_operations fuse_file_operations = {
>  	.llseek		= fuse_file_llseek,
>  	.read_iter	= fuse_file_read_iter,
> diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
> index cf42a8b939e3..4842f3ab3161 100644
> --- a/fs/nfs/nfs4file.c
> +++ b/fs/nfs/nfs4file.c
> @@ -129,9 +129,9 @@ nfs4_file_flush(struct file *file, fl_owner_t id)
>  }
>  
>  #ifdef CONFIG_NFS_V4_2
> -static ssize_t nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
> -				    struct file *file_out, loff_t pos_out,
> -				    size_t count, unsigned int flags)
> +static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
> +				      struct file *file_out, loff_t pos_out,
> +				      size_t count, unsigned int flags)
>  {
>  	if (!nfs_server_capable(file_inode(file_out), NFS_CAP_COPY))
>  		return -EOPNOTSUPP;
> @@ -140,6 +140,20 @@ static ssize_t nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
>  	return nfs42_proc_copy(file_in, pos_in, file_out, pos_out, count);
>  }
>  
> +static ssize_t nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
> +				    struct file *file_out, loff_t pos_out,
> +				    size_t count, unsigned int flags)
> +{
> +	ssize_t ret;
> +
> +	ret = __nfs4_copy_file_range(file_in, pos_in, file_out, pos_out, count,
> +				     flags);
> +	if (ret == -EOPNOTSUPP)
> +		ret = generic_copy_file_range(file_in, pos_in, file_out,
> +					      pos_out, count, flags);
> +	return ret;
> +}
> +
>  static loff_t nfs4_file_llseek(struct file *filep, loff_t offset, int whence)
>  {
>  	loff_t ret;
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 676b02fae589..b63dcb4e4fe9 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1595,6 +1595,19 @@ ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
>  }
>  EXPORT_SYMBOL(generic_copy_file_range);
>  
> +static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
> +				  struct file *file_out, loff_t pos_out,
> +				  size_t len, unsigned int flags)
> +{
> +	if (file_out->f_op->copy_file_range)
> +		return file_out->f_op->copy_file_range(file_in, pos_in,
> +						       file_out, pos_out,
> +						       len, flags);
> +
> +	return generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
> +				       flags);
> +}
> +
>  /*
>   * copy_file_range() differs from regular file read and write in that it
>   * specifically allows return partial success.  When it does so is up to
> @@ -1655,15 +1668,9 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>  		}
>  	}
>  
> -	if (file_out->f_op->copy_file_range) {
> -		ret = file_out->f_op->copy_file_range(file_in, pos_in, file_out,
> -						      pos_out, len, flags);
> -		if (ret != -EOPNOTSUPP)
> -			goto done;
> -	}
> -
> -	ret = generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
> -				      flags);
> +	ret = do_copy_file_range(file_in, pos_in, file_out, pos_out, len,
> +				flags);
> +	WARN_ON_ONCE(ret == -EOPNOTSUPP);
>  done:
>  	if (ret > 0) {
>  		fsnotify_access(file_in);
> -- 
> 2.17.1
> 
