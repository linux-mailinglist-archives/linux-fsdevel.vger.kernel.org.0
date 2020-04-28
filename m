Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD971BC348
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 17:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgD1PXm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 11:23:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54062 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgD1PXl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:23:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SFJJr9181560;
        Tue, 28 Apr 2020 15:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Z2ByN2+MzbIvs0i2Y/PXaDFEWIhqTsq4ZPKwwAXgEC4=;
 b=GnATZk6osQ0axdXkK25YJ6R1BHG1+9bZCAPkxdNwXatJWlcbZoVpRL2u1vL2N6KxGYbN
 hH8AKcST5YB8JwIWQm0LPKDNzJNEwgxy8XJiI2DGS6areUsg3hrlBf/VUopaLQ7MgAHm
 hHXwGNvThgw8iylSha/Xf3bCxCW9sUUw6JTZeDV93ufO5NvZ/3ERHUohIDVs10sudc8p
 DPPZ3qcSmNKvE52YJCGdxa72tBeWbU/rUa7MK2K2NGeG62eaq33b3H1bG8OqamOfHTp2
 C/V0DA3+rLzzs+JebL6zY/GpJciEc7rG/znqRoklWmbZOjmwuvv9puhd6vQLKY9wPwRf kA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30p01nq5wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 15:23:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SFBu2L005614;
        Tue, 28 Apr 2020 15:21:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 30mxx01gg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 15:21:28 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03SFLQ36004084;
        Tue, 28 Apr 2020 15:21:26 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 08:21:26 -0700
Date:   Tue, 28 Apr 2020 08:21:24 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        tytso@mit.edu, adilger@dilger.ca, riteshh@linux.ibm.com,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 10/11] fs: remove the access_ok() check in ioctl_fiemap
Message-ID: <20200428152124.GL6741@magnolia>
References: <20200427181957.1606257-1-hch@lst.de>
 <20200427181957.1606257-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427181957.1606257-11-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280120
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 27, 2020 at 08:19:56PM +0200, Christoph Hellwig wrote:
> access_ok just checks we are fed a proper user pointer.  We also do that
> in copy_to_user itself, so no need to do this early.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Hmm.  It's a minor behavioral change that we no longer require the
entire extent array to be accessible at the start even if parts of it
would never have gotten accessed, but I don't think that matters, so:

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/ioctl.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index ae0d228d18a16..d24afce649037 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -209,13 +209,9 @@ static int ioctl_fiemap(struct file *filp, struct fiemap __user *ufiemap)
>  	fieinfo.fi_extents_max = fiemap.fm_extent_count;
>  	fieinfo.fi_extents_start = ufiemap->fm_extents;
>  
> -	if (fiemap.fm_extent_count != 0 &&
> -	    !access_ok(fieinfo.fi_extents_start,
> -		       fieinfo.fi_extents_max * sizeof(struct fiemap_extent)))
> -		return -EFAULT;
> -
>  	error = inode->i_op->fiemap(inode, &fieinfo, fiemap.fm_start,
>  			fiemap.fm_length);
> +
>  	fiemap.fm_flags = fieinfo.fi_flags;
>  	fiemap.fm_mapped_extents = fieinfo.fi_extents_mapped;
>  	if (copy_to_user(ufiemap, &fiemap, sizeof(fiemap)))
> -- 
> 2.26.1
> 
