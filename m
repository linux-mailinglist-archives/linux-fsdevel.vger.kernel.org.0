Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8A9EA286
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 18:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfJ3R1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 13:27:24 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37298 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfJ3R1Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 13:27:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9UHE4MC125500;
        Wed, 30 Oct 2019 17:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=zNhDxwoRd8SAqkrYmsDk/cAryv8u0HvoW5BjK8ZzTv4=;
 b=FaVFKR5IJjPKXWa2UwV+7GOTCetOELbtsW3rVDwOsTbECZbMcDosRBd9Lh99vOHSSNrm
 6JLiXOrLlyNaVBysmcnlMVgh6mAv68j2KHrb9NOanrYA5/nOiWXnTW9zaA1k8mjVLrPI
 JUr294lI1TgaEGWC1a91S2x8oz/wJ+1C4kpxWUCZb5L4kwb0yU47fBabckaiPmEP59M0
 AKvgoCvM2MzGp3HrVQ4tvb86Uo2iuefan8X8XoRPY8IeU6A6iHry3ugc23WA+ZZq2Nsx
 53JcYAL28DskAoMokw+bj0NgH6F3t8rXx7hqS1cFxksB6DgHWqdGN3L8xbT2RjcXCDTz ZQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2vxwhfdv5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 17:27:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9UHE0E2093840;
        Wed, 30 Oct 2019 17:25:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vxwhwfu3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 17:25:19 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9UHPIqZ005569;
        Wed, 30 Oct 2019 17:25:18 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 10:25:18 -0700
Date:   Wed, 30 Oct 2019 10:25:17 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/26] xfs: Improve metadata buffer reclaim accountability
Message-ID: <20191030172517.GO15222@magnolia>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-5-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009032124.10541-5-david@fromorbit.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910300152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910300152
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 02:21:02PM +1100, Dave Chinner wrote:
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
> index e484f6bead53..45b470f55ad7 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -324,6 +324,9 @@ xfs_buf_free(
>  
>  			__free_page(page);
>  		}
> +		if (current->reclaim_state)
> +			current->reclaim_state->reclaimed_slab +=
> +							bp->b_page_count;

Hmm, ok, I see how ZONE_RECLAIM and reclaimed_slab fit together.

>  	} else if (bp->b_flags & _XBF_KMEM)
>  		kmem_free(bp->b_addr);
>  	_xfs_buf_free_pages(bp);
> @@ -2064,7 +2067,8 @@ int __init
>  xfs_buf_init(void)
>  {
>  	xfs_buf_zone = kmem_zone_init_flags(sizeof(xfs_buf_t), "xfs_buf",
> -						KM_ZONE_HWALIGN, NULL);
> +			KM_ZONE_HWALIGN | KM_ZONE_SPREAD | KM_ZONE_RECLAIM,

I guess I'm fine with ZONE_SPREAD too, insofar as it only seems to apply
to a particular "use another node" memory policy when slab is in use.
Was that your intent?

--D

> +			NULL);
>  	if (!xfs_buf_zone)
>  		goto out;
>  
> -- 
> 2.23.0.rc1
> 
