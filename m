Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C60262CB4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 18:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfE1QM2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 12:12:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38256 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfE1QM2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 12:12:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SG9M3L157752;
        Tue, 28 May 2019 16:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=U6Ank61cE1j5C/2zsHGM+gzAjN2xtHvKBEaw6n2xqdk=;
 b=hxP0GGutN2UbKtMuQkZMf00Cap5tw4QsCecOw3JNgvFUTEbiyL4wkWmMJKqhVDGSHn13
 lTP3iX4d2OZsVAjc2YohnI232q/HMN62wbsMR/+CUm+T8DtXcwRQsyZD8g1OeFILCH2N
 VMoCaffxO8a2o1y9D4aCew4LC6uKu9jWxkyhAM10BP5DgZTk1563LHN+sbAXv8tZZ77u
 XoqcLrkua9QscUg2RqGOF0SXhrpMW5W++gvjbM3KMg1TARvY/yeU/x+gBwfotfBWBqhW
 rfsjDMjD7Qsirfu3jdqmwH94O5rIKdHXVO91dghSuWaNAS1MYYo3RT/P9JIDNnPdpnha GA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2spxbq47w8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 16:11:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SGAL18114192;
        Tue, 28 May 2019 16:11:48 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2sqh736wk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 16:11:48 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4SGBlUq018808;
        Tue, 28 May 2019 16:11:47 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 May 2019 09:11:46 -0700
Date:   Tue, 28 May 2019 09:11:45 -0700
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
Subject: Re: [PATCH v2 1/8] vfs: introduce generic_copy_file_range()
Message-ID: <20190528161144.GB5221@magnolia>
References: <20190526061100.21761-1-amir73il@gmail.com>
 <20190526061100.21761-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526061100.21761-2-amir73il@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905280103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905280103
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 26, 2019 at 09:10:52AM +0300, Amir Goldstein wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Right now if vfs_copy_file_range() does not use any offload
> mechanism, it falls back to calling do_splice_direct(). This fails
> to do basic sanity checks on the files being copied. Before we
> start adding this necessarily functionality to the fallback path,
> separate it out into generic_copy_file_range().
> 
> generic_copy_file_range() has the same prototype as
> ->copy_file_range() so that filesystems can use it in their custom
> ->copy_file_range() method if they so choose.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

>  fs/read_write.c    | 35 ++++++++++++++++++++++++++++++++---
>  include/linux/fs.h |  3 +++
>  2 files changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index c543d965e288..676b02fae589 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1565,6 +1565,36 @@ COMPAT_SYSCALL_DEFINE4(sendfile64, int, out_fd, int, in_fd,
>  }
>  #endif
>  
> +/**
> + * generic_copy_file_range - copy data between two files
> + * @file_in:	file structure to read from
> + * @pos_in:	file offset to read from
> + * @file_out:	file structure to write data to
> + * @pos_out:	file offset to write data to
> + * @len:	amount of data to copy
> + * @flags:	copy flags
> + *
> + * This is a generic filesystem helper to copy data from one file to another.
> + * It has no constraints on the source or destination file owners - the files
> + * can belong to different superblocks and different filesystem types. Short
> + * copies are allowed.
> + *
> + * This should be called from the @file_out filesystem, as per the
> + * ->copy_file_range() method.
> + *
> + * Returns the number of bytes copied or a negative error indicating the
> + * failure.
> + */
> +
> +ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
> +				struct file *file_out, loff_t pos_out,
> +				size_t len, unsigned int flags)
> +{
> +	return do_splice_direct(file_in, &pos_in, file_out, &pos_out,
> +				len > MAX_RW_COUNT ? MAX_RW_COUNT : len, 0);
> +}
> +EXPORT_SYMBOL(generic_copy_file_range);
> +
>  /*
>   * copy_file_range() differs from regular file read and write in that it
>   * specifically allows return partial success.  When it does so is up to
> @@ -1632,9 +1662,8 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>  			goto done;
>  	}
>  
> -	ret = do_splice_direct(file_in, &pos_in, file_out, &pos_out,
> -			len > MAX_RW_COUNT ? MAX_RW_COUNT : len, 0);
> -
> +	ret = generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
> +				      flags);
>  done:
>  	if (ret > 0) {
>  		fsnotify_access(file_in);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index f7fdfe93e25d..ea17858310ff 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1889,6 +1889,9 @@ extern ssize_t vfs_readv(struct file *, const struct iovec __user *,
>  		unsigned long, loff_t *, rwf_t);
>  extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
>  				   loff_t, size_t, unsigned int);
> +extern ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
> +				       struct file *file_out, loff_t pos_out,
> +				       size_t len, unsigned int flags);
>  extern int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
>  					 struct file *file_out, loff_t pos_out,
>  					 loff_t *count,
> -- 
> 2.17.1
> 
