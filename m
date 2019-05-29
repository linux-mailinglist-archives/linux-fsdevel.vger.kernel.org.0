Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47D912E46E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 20:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfE2SZe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 14:25:34 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43174 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfE2SZd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 14:25:33 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4TIO1m6061503;
        Wed, 29 May 2019 18:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Id2h4/LUEmkIwtGMeQrsxQRh2WfTng2MUmJNlVZJqjg=;
 b=YsWW5FsGZfyCAeeNvk4lGeT4g8EFkAkUsErDxtHwVvVsehawm51m3KSBg+UixAoC49L8
 aqY747FUfjIIwEP62j9fYZEOcRBV9AiXwzJFaxjzZvK3pXWvbfUIEJV4QP3DoxVhoF8w
 lelTGQpLOhUXR/l6ZjgzgAulm6mIOHLX6GM4yEcLth5IiXW2YTnkBx+ja86o4vv5+kVY
 RQNDf4ouHWIFSNPt5nlvqAlvszJv4xg2Thv07pZ+7hEmWS4uARAkqNW9FdXTYb1nIvlu
 OJHmxF/BFXTynmbK/rr4mF5a1Fbk2CSyLulqfR8ZacSbjlN7RFp+4yF1wr6rWyLpb28t Dg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2spu7dky8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 18:24:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4TIO13V007852;
        Wed, 29 May 2019 18:24:51 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2sr31ve1p7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 18:24:51 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4TIOnkH011817;
        Wed, 29 May 2019 18:24:49 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 11:24:48 -0700
Date:   Wed, 29 May 2019 11:24:47 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        linux-xfs@vger.kernel.org,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH v3 05/13] vfs: add missing checks to copy_file_range
Message-ID: <20190529182447.GE5231@magnolia>
References: <20190529174318.22424-1-amir73il@gmail.com>
 <20190529174318.22424-6-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529174318.22424-6-amir73il@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905290118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905290119
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 29, 2019 at 08:43:09PM +0300, Amir Goldstein wrote:
> Like the clone and dedupe interfaces we've recently fixed, the
> copy_file_range() implementation is missing basic sanity, limits and
> boundary condition tests on the parameters that are passed to it
> from userspace. Create a new "generic_copy_file_checks()" function
> modelled on the generic_remap_checks() function to provide this
> missing functionality.
> 
> [Amir] Shorten copy length instead of checking pos_in limits
> because input file size already abides by the limits.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/read_write.c    |  3 ++-
>  include/linux/fs.h |  3 +++
>  mm/filemap.c       | 53 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index f1900bdb3127..b0fb1176b628 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1626,7 +1626,8 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>  	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
>  		return -EXDEV;
>  
> -	ret = generic_file_rw_checks(file_in, file_out);
> +	ret = generic_copy_file_checks(file_in, pos_in, file_out, pos_out, &len,
> +				       flags);
>  	if (unlikely(ret))
>  		return ret;
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 89b9b73eb581..e4d382c4342a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3050,6 +3050,9 @@ extern int generic_remap_checks(struct file *file_in, loff_t pos_in,
>  				struct file *file_out, loff_t pos_out,
>  				loff_t *count, unsigned int remap_flags);
>  extern int generic_file_rw_checks(struct file *file_in, struct file *file_out);
> +extern int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
> +				    struct file *file_out, loff_t pos_out,
> +				    size_t *count, unsigned int flags);
>  extern ssize_t generic_file_read_iter(struct kiocb *, struct iov_iter *);
>  extern ssize_t __generic_file_write_iter(struct kiocb *, struct iov_iter *);
>  extern ssize_t generic_file_write_iter(struct kiocb *, struct iov_iter *);
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 44361928bbb0..aac71aef4c61 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3056,6 +3056,59 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
>  	return 0;
>  }
>  
> +/*
> + * Performs necessary checks before doing a file copy
> + *
> + * Can adjust amount of bytes to copy via @req_count argument.
> + * Returns appropriate error code that caller should return or
> + * zero in case the copy should be allowed.
> + */
> +int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
> +			     struct file *file_out, loff_t pos_out,
> +			     size_t *req_count, unsigned int flags)
> +{
> +	struct inode *inode_in = file_inode(file_in);
> +	struct inode *inode_out = file_inode(file_out);
> +	uint64_t count = *req_count;
> +	loff_t size_in;
> +	int ret;
> +
> +	ret = generic_file_rw_checks(file_in, file_out);
> +	if (ret)
> +		return ret;
> +
> +	/* Don't touch certain kinds of inodes */
> +	if (IS_IMMUTABLE(inode_out))
> +		return -EPERM;
> +
> +	if (IS_SWAPFILE(inode_in) || IS_SWAPFILE(inode_out))
> +		return -ETXTBSY;
> +
> +	/* Ensure offsets don't wrap. */
> +	if (pos_in + count < pos_in || pos_out + count < pos_out)
> +		return -EOVERFLOW;
> +
> +	/* Shorten the copy to EOF */
> +	size_in = i_size_read(inode_in);
> +	if (pos_in >= size_in)
> +		count = 0;
> +	else
> +		count = min(count, size_in - (uint64_t)pos_in);
> +
> +	ret = generic_write_check_limits(file_out, pos_out, &count);
> +	if (ret)
> +		return ret;
> +
> +	/* Don't allow overlapped copying within the same file. */
> +	if (inode_in == inode_out &&
> +	    pos_out + count > pos_in &&
> +	    pos_out < pos_in + count)
> +		return -EINVAL;
> +
> +	*req_count = count;
> +	return 0;
> +}
> +
>  int pagecache_write_begin(struct file *file, struct address_space *mapping,
>  				loff_t pos, unsigned len, unsigned flags,
>  				struct page **pagep, void **fsdata)
> -- 
> 2.17.1
> 
