Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CABE7589DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 20:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfF0SXl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 14:23:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48560 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfF0SXk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:23:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5RIA7rA019301;
        Thu, 27 Jun 2019 18:23:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=0G6Y8m5n5DfJQPYFH33nWqg2UCy4HW55ipBD/Rtat5M=;
 b=Xilmx0Vox9z6yWX6MHNl5wonE71OK7Ov/XTfsykPivZ29kYudcH6a72ZMAaFQ6gjUx9i
 mVDJ8Jx2darKIcFVwEqEs/xAm9tPdVT1TOYHjYK0r6sofcj7FQeZ9lIYil0mBVf6oDqp
 t9V/of3+k4zx5i3i2YoTNGUKMr8/rOD2WkJtOkC9F402FVQihLwSo5VlpQjgAsB+Nwu2
 KcXh5r9EPgagzmB+JbJiw59nBL2Ha5FiPft03j85I8fukLgRqWDlSMs/C3Qb1jNeID87
 oJQyTkLgXxT0528p4rJuQqo763BLvpzvRZqZ9l36ScBbcfRY4N+FUnZmvXcQv/QF2WTw Lg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2t9cyqssgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 18:23:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5RIMUTH180896;
        Thu, 27 Jun 2019 18:23:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2tat7dhq0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 18:23:19 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5RINHKR014156;
        Thu, 27 Jun 2019 18:23:17 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Jun 2019 11:23:17 -0700
Date:   Thu, 27 Jun 2019 11:23:09 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] xfs: allow merging ioends over append boundaries
Message-ID: <20190627182309.GP5171@magnolia>
References: <20190627104836.25446-1-hch@lst.de>
 <20190627104836.25446-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627104836.25446-8-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906270209
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906270208
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 27, 2019 at 12:48:30PM +0200, Christoph Hellwig wrote:
> There is no real problem merging ioends that go beyond i_size into an
> ioend that doesn't.  We just need to move the append transaction to the
> base ioend.  Also use the opportunity to use a real error code instead
> of the magic 1 to cancel the transactions, and write a comment
> explaining the scheme.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reading through this patch, I have a feeling it fixes the crash that
Zorro has been seeing occasionally with generic/475...

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_aops.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 8b3070a40245..4ef8343c3759 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -314,11 +314,28 @@ xfs_ioend_can_merge(
>  		return false;
>  	if (ioend->io_offset + ioend->io_size != next->io_offset)
>  		return false;
> -	if (xfs_ioend_is_append(ioend) != xfs_ioend_is_append(next))
> -		return false;
>  	return true;
>  }
>  
> +/*
> + * If the to be merged ioend has a preallocated transaction for file
> + * size updates we need to ensure the ioend it is merged into also
> + * has one.  If it already has one we can simply cancel the transaction
> + * as it is guaranteed to be clean.
> + */
> +static void
> +xfs_ioend_merge_append_transactions(
> +	struct xfs_ioend	*ioend,
> +	struct xfs_ioend	*next)
> +{
> +	if (!ioend->io_append_trans) {
> +		ioend->io_append_trans = next->io_append_trans;
> +		next->io_append_trans = NULL;
> +	} else {
> +		xfs_setfilesize_ioend(next, -ECANCELED);
> +	}
> +}
> +
>  /* Try to merge adjacent completions. */
>  STATIC void
>  xfs_ioend_try_merge(
> @@ -327,7 +344,6 @@ xfs_ioend_try_merge(
>  {
>  	struct xfs_ioend	*next_ioend;
>  	int			ioend_error;
> -	int			error;
>  
>  	if (list_empty(more_ioends))
>  		return;
> @@ -341,10 +357,8 @@ xfs_ioend_try_merge(
>  			break;
>  		list_move_tail(&next_ioend->io_list, &ioend->io_list);
>  		ioend->io_size += next_ioend->io_size;
> -		if (ioend->io_append_trans) {
> -			error = xfs_setfilesize_ioend(next_ioend, 1);
> -			ASSERT(error == 1);
> -		}
> +		if (next_ioend->io_append_trans)
> +			xfs_ioend_merge_append_transactions(ioend, next_ioend);
>  	}
>  }
>  
> -- 
> 2.20.1
> 
