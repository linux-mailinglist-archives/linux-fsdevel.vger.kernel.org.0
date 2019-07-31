Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71CB77D1BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 01:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfGaXO4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 19:14:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50876 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfGaXOz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 19:14:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6VMtPDi163625;
        Wed, 31 Jul 2019 23:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=VqrC0dv2rldIjHEktgmXA9XzbzbwEbUPiJTSmpX/yTU=;
 b=fLHo5SyFnVaRLgiyVDwDvVWvZgqgZcliugl2KAe36G/GR5r8iy9B2K/nvmRoA4+Yu5tw
 9Mo90JiLZLbV44/X4bF9DpwZHOjgXM4Ouvj0BZ+lMawRgrTAvkaVKQDkjvirGF4ERYAR
 9OW89IC2V3WVR6XNDMP2iSmJOk3GJvePqR409NZmXrPnyVI/JCK6xIUkbo8dylhTd0nq
 Li9treND9/uzXliTlLvcZnYUMZRT2UbyXrGP56KWr3Lnwdnbw2RqDefrgJBPGbVJt2tK
 QSZJgUALaws5OIadcgM7B7sqk0WvdbnwgAsWnvPK2da3jBNqmFrkfQF/9r6JrzcqHP1P 1w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2u0f8r846x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 23:14:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6VN5Gw1074172;
        Wed, 31 Jul 2019 23:12:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2u3mbtg5hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 23:12:23 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6VNCJWE024377;
        Wed, 31 Jul 2019 23:12:19 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 31 Jul 2019 16:12:19 -0700
Date:   Wed, 31 Jul 2019 16:12:17 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Carlos Maiolino <cmaiolino@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/9] fibmap: Use bmap instead of ->bmap method in
 ioctl_fibmap
Message-ID: <20190731231217.GV1561054@magnolia>
References: <20190731141245.7230-1-cmaiolino@redhat.com>
 <20190731141245.7230-5-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731141245.7230-5-cmaiolino@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9335 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907310229
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9335 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907310229
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 31, 2019 at 04:12:40PM +0200, Carlos Maiolino wrote:
> Now we have the possibility of proper error return in bmap, use bmap()
> function in ioctl_fibmap() instead of calling ->bmap method directly.
> 
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> ---
> 
> Changelog:
> 
> V4:
> 	- Ensure ioctl_fibmap() returns 0 in case of error returned from
> 	  bmap(). Otherwise we'll be changing the user interface (which
> 	  returns 0 in case of error)
> V3:
> 	- Rename usr_blk to ur_block
> 
> V2:
> 	- Use a local sector_t variable to asign the block number
> 	  instead of using direct casting.
> 
>  fs/ioctl.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index fef3a6bf7c78..6b589c873bc2 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -53,19 +53,28 @@ EXPORT_SYMBOL(vfs_ioctl);
>  
>  static int ioctl_fibmap(struct file *filp, int __user *p)
>  {
> -	struct address_space *mapping = filp->f_mapping;
> -	int res, block;
> +	struct inode *inode = file_inode(filp);
> +	int error, ur_block;
> +	sector_t block;
>  
> -	/* do we support this mess? */
> -	if (!mapping->a_ops->bmap)
> -		return -EINVAL;
>  	if (!capable(CAP_SYS_RAWIO))
>  		return -EPERM;
> -	res = get_user(block, p);
> -	if (res)
> -		return res;
> -	res = mapping->a_ops->bmap(mapping, block);
> -	return put_user(res, p);
> +
> +	error = get_user(ur_block, p);
> +	if (error)
> +		return error;
> +
> +	block = ur_block;
> +	error = bmap(inode, &block);
> +
> +	if (error)
> +		ur_block = 0;
> +	else
> +		ur_block = block;

What happens if ur_block > INT_MAX?  Shouldn't we return zero (i.e.
error) instead of truncating the value?  Maybe the code does this
somewhere else?  Here seemed like the obvious place for an overflow
check as we go from sector_t to int.

--D

> +
> +	error = put_user(ur_block, p);
> +
> +	return error;
>  }
>  
>  /**
> -- 
> 2.20.1
> 
