Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5A6BEF126
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 00:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbfKDXVR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 18:21:17 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46588 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbfKDXVR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 18:21:17 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4NJYTA045505;
        Mon, 4 Nov 2019 23:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=cMrpcm51otgeL8Re+g3qAXBEuLWi0XsR5qH01HB4h+U=;
 b=XVxuk3+VkgptV3dSxv2tl03MO7LxC14L6bl/oJDyrVamwZjGvtogHsnOVfHw0FbHieqg
 JAB1nttbJCoh7zAF90B4zlj6MpADbK2JevENtY0Ad+JsnQLWGDv+SMGGMaflEBOYe5S3
 chzygh9kvnrEth7oTt5sDYGFJsJLd/YckOB8OnD3UV1FV7kLQSJhL0jxJkLHTkwg6GJR
 tpIgNTakvi6HnWH88pka1TjZ4gxvDfflEDqKqrWMZmm5H8vY6JMDyLw+yk0QJi6SScoe
 +z6NSS+eiu8+nzIXkT/PmJJogzqtCP/1TLcz+DM55UkxFGgjs8fvSJTzPM+hmriGfD5X fQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2w12er2fsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 23:21:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4NJVC0102226;
        Mon, 4 Nov 2019 23:21:12 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2w1kxn7qv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 23:21:12 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA4NLCTF020486;
        Mon, 4 Nov 2019 23:21:12 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 15:21:11 -0800
Date:   Mon, 4 Nov 2019 15:21:10 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/28] xfs: Improve metadata buffer reclaim accountability
Message-ID: <20191104232110.GS4153244@magnolia>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-5-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031234618.15403-5-david@fromorbit.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=836
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911040221
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=921 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911040222
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 01, 2019 at 10:45:54AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> The buffer cache shrinker frees more than just the xfs_buf slab
> objects - it also frees the pages attached to the buffers. Make sure
> the memory reclaim code accounts for this memory being freed
> correctly, similar to how the inode shrinker accounts for pages
> freed from the page cache due to mapping invalidation.
> 
> We also need to make sure that the mm subsystem knows these are
> reclaimable objects. We provide the memory reclaim subsystem with a
> a shrinker to reclaim xfs_bufs, so we should really mark the slab
> that way.
> 
> We also have a lot of xfs_bufs in a busy system, spread them around
> like we do inodes.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  fs/xfs/xfs_buf.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index 1e63dd3d1257..d34e5d2edacd 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -324,6 +324,9 @@ xfs_buf_free(
>  
>  			__free_page(page);
>  		}
> +		if (current->reclaim_state)
> +			current->reclaim_state->reclaimed_slab +=
> +							bp->b_page_count;
>  	} else if (bp->b_flags & _XBF_KMEM)
>  		kmem_free(bp->b_addr);
>  	_xfs_buf_free_pages(bp);
> @@ -2061,7 +2064,8 @@ int __init
>  xfs_buf_init(void)
>  {
>  	xfs_buf_zone = kmem_zone_init_flags(sizeof(xfs_buf_t), "xfs_buf",
> -						KM_ZONE_HWALIGN, NULL);
> +			KM_ZONE_HWALIGN | KM_ZONE_SPREAD | KM_ZONE_RECLAIM,

As discussed on the previous iteration of this series, I'd like to
capture the reasons for adding KM_ZONE_SPREAD as a separate patch.

--D

> +			NULL);
>  	if (!xfs_buf_zone)
>  		goto out;
>  
> -- 
> 2.24.0.rc0
> 
