Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 051D62E467
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 20:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfE2SYD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 14:24:03 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41622 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfE2SYD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 14:24:03 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4TIId0B057287;
        Wed, 29 May 2019 18:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=yN96siC97bGXA079KpRQnuL10xuxNSq6s0e4DVZw93g=;
 b=dm0D6anYXBe3K+MCrPSny+6dBQfMjrQSywoSfiBo+7YRlux+5udixTmWCQU2Kv8Ko5Op
 lzCZuyWjvRyHPtAyWmSMQgz4OzeVT4gbdTGsf+YhsMGUALgOrVLtR1SuH8SPA21kpd+E
 9VEaI1PfsAgINy3s6Iq+euau3Z0KOSpRUIAtwX/Vy+vIzwOoKLlHjnbzMTVP2hXavYFz
 c/uoqIDLaYFGpOc+iI8twzL/4the59e8ruSQ7EX+Aelv+pxR07Bxm9yrc9Z2y90YqdXX
 2z1TIYls/h1xntFYYk54HOUzHTIVMKDLxjSO/G/Ttlk2jNvIwe4ZSm5nu4sFzl3/DcK4 Ww== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2spu7dky0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 18:23:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4TIMNnZ014114;
        Wed, 29 May 2019 18:23:25 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2sqh73vccs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 18:23:25 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4TINMLW025084;
        Wed, 29 May 2019 18:23:22 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 11:23:22 -0700
Date:   Wed, 29 May 2019 11:23:19 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        linux-xfs@vger.kernel.org,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: Re: [PATCH v3 04/13] vfs: remove redundant checks from
 generic_remap_checks()
Message-ID: <20190529182319.GD5231@magnolia>
References: <20190529174318.22424-1-amir73il@gmail.com>
 <20190529174318.22424-5-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529174318.22424-5-amir73il@gmail.com>
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
 definitions=main-1905290118
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 29, 2019 at 08:43:08PM +0300, Amir Goldstein wrote:
> The access limit checks on input file range in generic_remap_checks()
> are redundant because the input file size is guaranteied to be within

"guaranteed"...

> limits and pos+len are already checked to be within input file size.
> 
> Beyond the fact that the check cannot fail, if it would have failed,
> it could return -EFBIG for input file range error. There is no precedent
> for that. -EFBIG is returned in syscalls that would change file length.
> 
> With that call removed, we can fold generic_access_check_limits() into
> generic_write_check_limits().
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Once the changelog is fixed,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  mm/filemap.c | 33 ++++++++++++---------------------
>  1 file changed, 12 insertions(+), 21 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index a38619a4a6af..44361928bbb0 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2895,24 +2895,11 @@ EXPORT_SYMBOL(read_cache_page_gfp);
>   * LFS limits.  If pos is under the limit it becomes a short access.  If it
>   * exceeds the limit we return -EFBIG.
>   */
> -static int generic_access_check_limits(struct file *file, loff_t pos,
> -				       loff_t *count)
> -{
> -	struct inode *inode = file->f_mapping->host;
> -	loff_t max_size = inode->i_sb->s_maxbytes;
> -
> -	if (!(file->f_flags & O_LARGEFILE))
> -		max_size = MAX_NON_LFS;
> -
> -	if (unlikely(pos >= max_size))
> -		return -EFBIG;
> -	*count = min(*count, max_size - pos);
> -	return 0;
> -}
> -
>  static int generic_write_check_limits(struct file *file, loff_t pos,
>  				      loff_t *count)
>  {
> +	struct inode *inode = file->f_mapping->host;
> +	loff_t max_size = inode->i_sb->s_maxbytes;
>  	loff_t limit = rlimit(RLIMIT_FSIZE);
>  
>  	if (limit != RLIM_INFINITY) {
> @@ -2923,7 +2910,15 @@ static int generic_write_check_limits(struct file *file, loff_t pos,
>  		*count = min(*count, limit - pos);
>  	}
>  
> -	return generic_access_check_limits(file, pos, count);
> +	if (!(file->f_flags & O_LARGEFILE))
> +		max_size = MAX_NON_LFS;
> +
> +	if (unlikely(pos >= max_size))
> +		return -EFBIG;
> +
> +	*count = min(*count, max_size - pos);
> +
> +	return 0;
>  }
>  
>  /*
> @@ -2963,7 +2958,7 @@ EXPORT_SYMBOL(generic_write_checks);
>  /*
>   * Performs necessary checks before doing a clone.
>   *
> - * Can adjust amount of bytes to clone.
> + * Can adjust amount of bytes to clone via @req_count argument.
>   * Returns appropriate error code that caller should return or
>   * zero in case the clone should be allowed.
>   */
> @@ -3001,10 +2996,6 @@ int generic_remap_checks(struct file *file_in, loff_t pos_in,
>  		return -EINVAL;
>  	count = min(count, size_in - (uint64_t)pos_in);
>  
> -	ret = generic_access_check_limits(file_in, pos_in, &count);
> -	if (ret)
> -		return ret;
> -
>  	ret = generic_write_check_limits(file_out, pos_out, &count);
>  	if (ret)
>  		return ret;
> -- 
> 2.17.1
> 
