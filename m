Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD9A203E12
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 19:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbgFVRds (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 13:33:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40956 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbgFVRdr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:33:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05MHCXtE002085;
        Mon, 22 Jun 2020 17:33:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=XCSGLlj0hNwdfuHXSruwKODZ5SrWXU3tvzhTvjRgtZM=;
 b=oV6XFIdbyQ49nRzq/Co5i8IMLzrZSMC+gE3wGFAF0zWRH4KMSNo1rn9x4AluXAsPLZ+r
 8iXmFMok4dXUDf0e2pjMgSVvti+sXwT/D6eIWe7RPYJRREW0dygDvwaliSkUylE4/oE+
 3nhxMPbPVj6OllytYFrNZcl+O9UvnKsBG0ig/aDfizDIEM/QOMAukxZYxE++oRRDEt9H
 7nDhru46fJDe+GpK2o2MLX1xeFX9RrUJ160m8wmbYLDKy9vh1p+TCSDBGZFJmIviAlsT
 HBiyeH0So4PNxs1lpU+JTKWL4zowoiVjQQQpiAdrF60V8Wv8m+OfBykRTZFohhDg2WL+ gA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 31sebbgqp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Jun 2020 17:33:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05MHXKhP001691;
        Mon, 22 Jun 2020 17:33:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 31svcve1yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jun 2020 17:33:35 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05MHXWoO023039;
        Mon, 22 Jun 2020 17:33:33 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Jun 2020 17:33:31 +0000
Date:   Mon, 22 Jun 2020 10:33:30 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        hch@lst.de, david@fromorbit.com, dsterba@suse.cz,
        jthumshirn@suse.de, fdmanana@gmail.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 2/6] iomap: IOMAP_DIOF_PGINVALID_FAIL return if page
 invalidation fails
Message-ID: <20200622173330.GA11239@magnolia>
References: <20200622152457.7118-1-rgoldwyn@suse.de>
 <20200622152457.7118-3-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622152457.7118-3-rgoldwyn@suse.de>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9660 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=5 phishscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006220121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9660 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 cotscore=-2147483648 mlxscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=5 clxscore=1011
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006220120
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 22, 2020 at 10:24:53AM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> The flag indicates that if the page invalidation fails, it should return
> back control to the filesystem so it may fallback to buffered mode.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Looks reasonable enough, I suppose...

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/direct-io.c  | 8 +++++++-
>  include/linux/iomap.h | 5 +++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 7ed857196a39..20c4370e6b1b 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -484,8 +484,14 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	 */
>  	ret = invalidate_inode_pages2_range(mapping,
>  			pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
> -	if (ret)
> +	if (ret) {
> +		if (dio_flags & IOMAP_DIOF_PGINVALID_FAIL) {
> +			if (ret == -EBUSY)
> +				ret = 0;
> +			goto out_free_dio;
> +		}
>  		dio_warn_stale_pagecache(iocb->ki_filp);
> +	}
>  	ret = 0;
>  
>  	if (iov_iter_rw(iter) == WRITE && !wait_for_completion &&
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index f6230446b08d..95024e28dec5 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -261,6 +261,11 @@ struct iomap_dio_ops {
>  
>  /* Wait for completion of DIO */
>  #define IOMAP_DIOF_WAIT_FOR_COMPLETION 		0x1
> +/*
> + * Return zero if page invalidation fails, so caller filesystem may fallback
> + * to buffered I/O
> + */
> +#define IOMAP_DIOF_PGINVALID_FAIL		0x2
>  
>  ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
> -- 
> 2.25.0
> 
