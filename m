Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA15284465
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Oct 2020 05:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgJFDzn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Oct 2020 23:55:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36890 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgJFDzn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Oct 2020 23:55:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0963nP1i005587;
        Tue, 6 Oct 2020 03:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=wmXOrnqYXdHY1pAqwzTq81Zb/Ng9Tq7aFUOngA1EnmY=;
 b=aAJGJ9Ff494modY6O1H1cSthFGM2spN7xUCHne+svH2585nd0xLRpxSQA1y/caQHXoH+
 ekUnPf3EUj96kq8xaJxDmeq+1i/QcBhQ7Ka/tU4knapSFW+Hgifzx5OmPLZJFVm8M+pK
 fnx88TEoC+ZijUMAxrhg5sKau/9YdMpYU9Hvf9V7qC+wdz3bAhmoZ3V7v423gMUDqRLY
 y68ek1F1AWKc+xAbcWX3itVz6kSXoMD1XYi7eT8d54NBgX/SRFnCjgjIRPt9HBE/h90s
 U0GgkcYOWGS2Ye2tXVok2QURqBy/KJuNKcjdDSX60D+mV5D8jSsw3iG5N8g+fEeg/HOw ug== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 33xhxmsng6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 06 Oct 2020 03:55:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0963j6IL104195;
        Tue, 6 Oct 2020 03:55:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 33yyjewfmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Oct 2020 03:55:39 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0963tcvX031630;
        Tue, 6 Oct 2020 03:55:38 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Oct 2020 20:55:38 -0700
Date:   Mon, 5 Oct 2020 20:55:37 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] xfs: kick extra large ioends to completion
 workqueue
Message-ID: <20201006035537.GD49524@magnolia>
References: <20201002153357.56409-3-bfoster@redhat.com>
 <20201005152102.15797-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005152102.15797-1-bfoster@redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010060021
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=1 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010060021
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 05, 2020 at 11:21:02AM -0400, Brian Foster wrote:
> We've had reports of soft lockup warnings in the iomap ioend
> completion path due to very large bios and/or bio chains. Divert any
> ioends with 256k or more pages to process to the workqueue so
> completion occurs in non-atomic context and can reschedule to avoid
> soft lockup warnings.

Hmmmm... is there any way we can just make end_page_writeback faster?

TBH it still strikes me as odd that we'd cap ioends this way just to
cover for the fact that we have to poke each and every page.

(Also, those 'bool atomic' in the other patch make me kind of nervous --
how do we make sure (from a QA perspective) that nobody gets that wrong?)

--D

> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
> 
> v2:
> - Fix type in macro.
> 
>  fs/xfs/xfs_aops.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 3e061ea99922..c00cc0624986 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -30,6 +30,13 @@ XFS_WPC(struct iomap_writepage_ctx *ctx)
>  	return container_of(ctx, struct xfs_writepage_ctx, ctx);
>  }
>  
> +/*
> + * Kick extra large ioends off to the workqueue. Completion will process a lot
> + * of pages for a large bio or bio chain and a non-atomic context is required to
> + * reschedule and avoid soft lockup warnings.
> + */
> +#define XFS_LARGE_IOEND	(262144ULL << PAGE_SHIFT)
> +
>  /*
>   * Fast and loose check if this write could update the on-disk inode size.
>   */
> @@ -239,7 +246,8 @@ static inline bool xfs_ioend_needs_workqueue(struct iomap_ioend *ioend)
>  {
>  	return ioend->io_private ||
>  		ioend->io_type == IOMAP_UNWRITTEN ||
> -		(ioend->io_flags & IOMAP_F_SHARED);
> +		(ioend->io_flags & IOMAP_F_SHARED) ||
> +		(ioend->io_size >= XFS_LARGE_IOEND);
>  }
>  
>  STATIC void
> -- 
> 2.25.4
> 
