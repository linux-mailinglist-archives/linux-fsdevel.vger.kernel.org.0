Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8255DE4308
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 07:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393262AbfJYFpf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Oct 2019 01:45:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58390 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393217AbfJYFpf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Oct 2019 01:45:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9P5ix8X128088;
        Fri, 25 Oct 2019 05:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=c96OdjzfbnoW9i7STuu1ddQwGZnupkbhzfZXdsseyRs=;
 b=iI5uzXaTa8I6t4znSc5F9eLJHW3lFaqRFm88d6n2mEnce9cqEyucF0kPbpPe4aP0Wuve
 V3xAZpNYASBEVfY6y1TENX9SNuzbLTibkuhSgBoSyWgkXEo9MBDlAawwqgfnex3GaElg
 Lxffljed87thrbgF/NUXELSdYNsUbOnbcqzl2UCwZWVGouy4FRoQ33d0/ycJOLfcjfZ2
 +GZlN2+KFNXtoNJrwcXZHFu9NlpJQUwpusJJbCMfjm8WFn7oyYfywKGvZpRTYwIO587M
 /npphhcyY+m/pp29abb29WfIQhYoPavZGw+3VhVUa9yfHcDCEDSxYsin03dTKXtClzP+ uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vqu4r847m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 05:45:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9P5hvUm140790;
        Fri, 25 Oct 2019 05:45:30 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2vtsk6wfxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 05:45:30 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9P5jTWF021490;
        Fri, 25 Oct 2019 05:45:29 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Oct 2019 22:45:29 -0700
Date:   Thu, 24 Oct 2019 22:45:26 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] xfs: disable xfs_ioc_space for always COW inodes
Message-ID: <20191025054526.GG913374@magnolia>
References: <20191025023609.22295-1-hch@lst.de>
 <20191025023609.22295-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025023609.22295-4-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=869
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910250056
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=949 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910250056
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 25, 2019 at 11:36:08AM +0900, Christoph Hellwig wrote:
> If we always have to write out of place preallocating blocks is
> pointless.  We already check for this in the normal falloc path, but
> the check was missig in the legacy ALLOCSP path.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_ioctl.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index 3fe1543f9f02..552034325991 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -33,6 +33,7 @@
>  #include "xfs_sb.h"
>  #include "xfs_ag.h"
>  #include "xfs_health.h"
> +#include "xfs_reflink.h"
>  
>  #include <linux/mount.h>
>  #include <linux/namei.h>
> @@ -606,6 +607,9 @@ xfs_ioc_space(
>  	if (!S_ISREG(inode->i_mode))
>  		return -EINVAL;
>  
> +	if (xfs_is_always_cow_inode(ip))
> +		return -EOPNOTSUPP;
> +
>  	if (filp->f_flags & O_DSYNC)
>  		flags |= XFS_PREALLOC_SYNC;
>  	if (filp->f_mode & FMODE_NOCMTIME)
> -- 
> 2.20.1
> 
