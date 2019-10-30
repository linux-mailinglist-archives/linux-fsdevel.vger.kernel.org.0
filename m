Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B54DFEA261
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 18:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfJ3RRC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 13:17:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53606 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfJ3RRC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 13:17:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9UHE6Qx125547;
        Wed, 30 Oct 2019 17:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=HnYBKi8E4gNg2qfIN5QrSzd+/XILkKitewLsYt4TmCU=;
 b=mWmW0lOm14uPQ2bgtaBze6qS/3Z0BfVatiyUhyWjQf1EnJehCBnSga7WhQdWgtg6DDhY
 /bkJv9MJOd+ts/l+fFN8kONkMvHJiUQdHKQCYDIIBJPucvvPIZD6uLgAsbylo5h9OFTm
 kOJ0iM5qVJx+TOIT9ttdf9m275lDFQh8C7/yTSWBhFkD5IWq3MscDtqmjapH/9qm6QYL
 BkZdfPvR1PfBGcPqo4obzqBnkURVs+pPB3CQmxbn/71+KfhywAmG+m7igjPNFmmdlith
 J+6x5+yRWJ15f8cG7VJ6IeqH07Cv0LTA/EtXRx4Gu3VD+aOzOGmAdtnrBM5OlBTB+UwQ KQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vxwhfdtbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 17:16:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9UHDtte176508;
        Wed, 30 Oct 2019 17:16:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vxwjabg5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 17:16:58 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9UHGvLr031830;
        Wed, 30 Oct 2019 17:16:57 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 10:16:57 -0700
Date:   Wed, 30 Oct 2019 10:16:52 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/26] xfs: correctly acount for reclaimable slabs
Message-ID: <20191030171652.GN15222@magnolia>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-6-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009032124.10541-6-david@fromorbit.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910300152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910300152
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 02:21:03PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> The XFS inode item slab actually reclaimed by inode shrinker
> callbacks from the memory reclaim subsystem. These should be marked
> as reclaimable so the mm subsystem has the full picture of how much
> memory it can actually reclaim from the XFS slab caches.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Seems fine to me...
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 8d1df9f8be07..f0aff1f034e6 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1919,7 +1919,7 @@ xfs_init_zones(void)
>  
>  	xfs_ili_zone =
>  		kmem_zone_init_flags(sizeof(xfs_inode_log_item_t), "xfs_ili",
> -					KM_ZONE_SPREAD, NULL);
> +					KM_ZONE_SPREAD | KM_ZONE_RECLAIM, NULL);
>  	if (!xfs_ili_zone)
>  		goto out_destroy_inode_zone;
>  	xfs_icreate_zone = kmem_zone_init(sizeof(struct xfs_icreate_item),
> -- 
> 2.23.0.rc1
> 
