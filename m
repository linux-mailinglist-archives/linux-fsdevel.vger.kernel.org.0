Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 122142CC27
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 18:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfE1QfH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 12:35:07 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:58890 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfE1QfH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 12:35:07 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SGYJWI187947;
        Tue, 28 May 2019 16:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=1gJ0uvEYSFe2yjsy5/Ae0sjxvIglWNNdveqoj9UKrws=;
 b=j86Z5uRWYUJSniwW0mvXbv+uQlZmAfaweW2K/40BsXvjBldv9NV9IdDJqoptq0Pr3xvp
 MWcKg2OWyhaPuTZETQPko38E2tr9mu0IYu0jlmaPRWvllBJNcYyEiAempArkQstWWe7r
 7dzUjs87BjQzheYSAPJnFTHOI19Wgx5nTFT2O0dBsQL5yGdrI9m6Ur2bqPYcIMExzdIL
 Jdjy4rk75ytr2p14rUlTZPr6OB9pnbYaTxtSgrBYAcCqwJu+mZql1/j55NNTLraOG9js
 7DKWRGUxyiuT8WSiqIA1W6P/akQ7JjnFJRyY7+otnemkitsl7qxm6WQAJljxZBQhH58J Sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2spu7dcnvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 16:34:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SGXwdB167639;
        Tue, 28 May 2019 16:34:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2sr31us0ah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 16:34:28 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4SGYRIB019657;
        Tue, 28 May 2019 16:34:27 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 May 2019 09:34:27 -0700
Date:   Tue, 28 May 2019 09:34:25 -0700
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
Subject: Re: [PATCH v2 7/8] vfs: allow copy_file_range to copy across devices
Message-ID: <20190528163425.GH5221@magnolia>
References: <20190526061100.21761-1-amir73il@gmail.com>
 <20190526061100.21761-8-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526061100.21761-8-amir73il@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905280106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905280106
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 26, 2019 at 09:10:58AM +0300, Amir Goldstein wrote:
> We want to enable cross-filesystem copy_file_range functionality
> where possible, so push the "same superblock only" checks down to
> the individual filesystem callouts so they can make their own
> decisions about cross-superblock copy offload and fallack to
> generic_copy_file_range() for cross-superblock copy.
> 
> [Amir] We do not call ->remap_file_range() in case the inodes are not
> on the same sb and do not call ->copy_file_range() in case the inodes
> are not on the same filesystem type.
> 
> This changes behavior of the copy_file_range(2) syscall, which will
> now allow cross filesystem in-kernel copy.  CIFS already supports
> cross-superblock copy, between two shares to the same server. This
> functionality will now be available via the copy_file_range(2) syscall.
> 
> Cc: Steve French <stfrench@microsoft.com>
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/ceph/file.c    |  4 +++-
>  fs/cifs/cifsfs.c  |  2 +-
>  fs/fuse/file.c    |  5 ++++-
>  fs/nfs/nfs4file.c |  5 ++++-
>  fs/read_write.c   | 20 ++++++++++++++------
>  5 files changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 54cfc877a6ef..adf99557c46c 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1909,6 +1909,8 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
>  
>  	if (src_inode == dst_inode)
>  		return -EINVAL;
> +	if (src_inode->i_sb != dst_inode->i_sb)
> +		return -EXDEV;
>  	if (ceph_snap(dst_inode) != CEPH_NOSNAP)
>  		return -EROFS;
>  
> @@ -2118,7 +2120,7 @@ static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
>  	ret = __ceph_copy_file_range(src_file, src_off, dst_file, dst_off,
>  				     len, flags);
>  
> -	if (ret == -EOPNOTSUPP)
> +	if (ret == -EOPNOTSUPP || ret == -EXDEV)
>  		ret = generic_copy_file_range(src_file, src_off, dst_file,
>  					      dst_off, len, flags);
>  	return ret;
> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index e103b499aaa8..7bde046110ce 100644
> --- a/fs/cifs/cifsfs.c
> +++ b/fs/cifs/cifsfs.c
> @@ -1152,7 +1152,7 @@ static ssize_t cifs_copy_file_range(struct file *src_file, loff_t off,
>  					len, flags);
>  	free_xid(xid);
>  
> -	if (rc == -EOPNOTSUPP)
> +	if (rc == -EOPNOTSUPP || rc == -EXDEV)
>  		rc = generic_copy_file_range(src_file, off, dst_file,
>  					     destoff, len, flags);
>  	return rc;
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 3531d4a3d9ec..180161f6f0bd 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -3126,6 +3126,9 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
>  	if (fc->no_copy_file_range)
>  		return -EOPNOTSUPP;
>  
> +	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
> +		return -EXDEV;
> +
>  	inode_lock(inode_out);
>  
>  	err = generic_copy_file_range_prep(file_in, file_out);
> @@ -3186,7 +3189,7 @@ static ssize_t fuse_copy_file_range(struct file *src_file, loff_t src_off,
>  	ret = __fuse_copy_file_range(src_file, src_off, dst_file, dst_off,
>  				     len, flags);
>  
> -	if (ret == -EOPNOTSUPP)
> +	if (ret == -EOPNOTSUPP || ret == -EXDEV)
>  		ret = generic_copy_file_range(src_file, src_off, dst_file,
>  					      dst_off, len, flags);
>  	return ret;
> diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
> index 4842f3ab3161..f4157eb1f69d 100644
> --- a/fs/nfs/nfs4file.c
> +++ b/fs/nfs/nfs4file.c
> @@ -133,6 +133,9 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
>  				      struct file *file_out, loff_t pos_out,
>  				      size_t count, unsigned int flags)
>  {
> +	/* Only offload copy if superblock is the same */
> +	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
> +		return -EXDEV;
>  	if (!nfs_server_capable(file_inode(file_out), NFS_CAP_COPY))
>  		return -EOPNOTSUPP;
>  	if (file_inode(file_in) == file_inode(file_out))
> @@ -148,7 +151,7 @@ static ssize_t nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
>  
>  	ret = __nfs4_copy_file_range(file_in, pos_in, file_out, pos_out, count,
>  				     flags);
> -	if (ret == -EOPNOTSUPP)
> +	if (ret == -EOPNOTSUPP || ret == -EXDEV)
>  		ret = generic_copy_file_range(file_in, pos_in, file_out,
>  					      pos_out, count, flags);
>  	return ret;
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 4b23a86aacd9..283ec30d2136 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1640,7 +1640,18 @@ static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
>  				  struct file *file_out, loff_t pos_out,
>  				  size_t len, unsigned int flags)
>  {
> -	if (file_out->f_op->copy_file_range)
> +	/*
> +	 * Although we now allow filesystems to handle cross sb copy, passing
> +	 * an inode of the wrong filesystem type to filesystem operation can
> +	 * often result in an attempt to dereference the wrong concrete inode
> +	 * struct, so avoid doing that until we really have a good reason.
> +	 * The incentive for passing inode from different sb to filesystem is
> +	 * NFS cross server copy and for that use case, enforcing same
> +	 * filesystem type is acceptable.
> +	 */
> +	if (file_out->f_op->copy_file_range &&
> +	    file_inode(file_in)->i_sb->s_type ==
> +	    file_inode(file_out)->i_sb->s_type)
>  		return file_out->f_op->copy_file_range(file_in, pos_in,
>  						       file_out, pos_out,
>  						       len, flags);
> @@ -1663,10 +1674,6 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>  	if (flags != 0)
>  		return -EINVAL;
>  
> -	/* this could be relaxed once a method supports cross-fs copies */
> -	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
> -		return -EXDEV;
> -
>  	ret = generic_copy_file_checks(file_in, pos_in, file_out, pos_out, &len,
>  				       flags);
>  	if (unlikely(ret))
> @@ -1689,7 +1696,8 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>  	 * Try cloning first, this is supported by more file systems, and
>  	 * more efficient if both clone and copy are supported (e.g. NFS).
>  	 */
> -	if (file_in->f_op->remap_file_range) {
> +	if (file_in->f_op->remap_file_range &&
> +	    file_inode(file_in)->i_sb == file_inode(file_out)->i_sb) {

For the fs/read_write.c bits,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

(I'm not going to pass judgement on whether or not cifs/nfs should be
doing cross-sb copies, as I know nothing about how well that works in
practice.)

--D

>  		loff_t cloned;
>  
>  		cloned = file_in->f_op->remap_file_range(file_in, pos_in,
> -- 
> 2.17.1
> 
