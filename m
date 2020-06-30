Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77A020FBB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 20:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732459AbgF3SaK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 14:30:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34386 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729718AbgF3SaK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 14:30:10 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05UIIAt3081146;
        Tue, 30 Jun 2020 18:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=GSuk1z+UXouJstt+zpAQYF0bKxIqA3H5G/b1ZKaCWR0=;
 b=ZnhQy/BxAWppqyWiDqRbIsuczsDR5krjRyGGblOikR+TuZl7kGsJaIQ/AprigjoEy7jF
 3nb/Ao5jhqO2BWvwRHe9jVMtUROEj6hl8JShcOaWaCaGYM0M/oIn5VJtN0z+UasZOsOt
 KHhEveWnJEg44INVLbNvzGDWmy/wy/vzZHBHsCXJC/bDHukU37kLDkP/TbHSbxMbfZbO
 2F9qthXffQxvjCmb/9HFDEmzxR8GxQhmjLzHX2gtnHCBjcsdwrHXyH6O3A2Z0OUonI9v
 s3URMUOymntr859S3lho+tWln/EQD0UIMRVlnUsascNX1fy7I2PUvVV8pucjiF0CQiH1 dA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31wxrn676n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Jun 2020 18:30:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05UIHl3Y059759;
        Tue, 30 Jun 2020 18:30:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 31xg1x6gq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 18:30:07 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05UIU67U005638;
        Tue, 30 Jun 2020 18:30:06 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Jun 2020 18:30:06 +0000
Date:   Tue, 30 Jun 2020 11:30:04 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] iomap: Make sure iomap_end is called after iomap_begin
Message-ID: <20200630183004.GS7606@magnolia>
References: <20200629095118.1366261-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629095118.1366261-1-agruenba@redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9668 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9668 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 adultscore=0 cotscore=-2147483648
 lowpriorityscore=0 suspectscore=1 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300126
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 29, 2020 at 11:51:18AM +0200, Andreas Gruenbacher wrote:
> Make sure iomap_end is always called when iomap_begin succeeds.
> 
> Without this fix, iomap_end won't be called when a filesystem's
> iomap_begin operation returns an invalid mapping, bypassing any
> unlocking done in iomap_end.  With this fix, the unlocking will still
> happen.
> 
> This bug was found by Bob Peterson during code review.  It's unlikely
> that such iomap_begin bugs will survive to affect users, so backporting
> this fix seems unnecessary.
> 
> Fixes: ae259a9c8593 ("fs: introduce iomap infrastructure")
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/apply.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
> index 76925b40b5fd..26ab6563181f 100644
> --- a/fs/iomap/apply.c
> +++ b/fs/iomap/apply.c
> @@ -46,10 +46,14 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
>  	ret = ops->iomap_begin(inode, pos, length, flags, &iomap, &srcmap);
>  	if (ret)
>  		return ret;
> -	if (WARN_ON(iomap.offset > pos))
> -		return -EIO;
> -	if (WARN_ON(iomap.length == 0))
> -		return -EIO;
> +	if (WARN_ON(iomap.offset > pos)) {
> +		written = -EIO;
> +		goto out;
> +	}
> +	if (WARN_ON(iomap.length == 0)) {
> +		written = -EIO;
> +		goto out;
> +	}
>  
>  	trace_iomap_apply_dstmap(inode, &iomap);
>  	if (srcmap.type != IOMAP_HOLE)
> @@ -80,6 +84,7 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
>  	written = actor(inode, pos, length, data, &iomap,
>  			srcmap.type != IOMAP_HOLE ? &srcmap : &iomap);
>  
> +out:
>  	/*
>  	 * Now the data has been copied, commit the range we've copied.  This
>  	 * should not fail unless the filesystem has had a fatal error.
> 
> base-commit: 69119673bd50b176ded34032fadd41530fb5af21
> -- 
> 2.26.2
> 
