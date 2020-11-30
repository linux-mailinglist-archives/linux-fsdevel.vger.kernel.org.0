Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EA52C8AE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 18:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387520AbgK3R0X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 12:26:23 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52422 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387399AbgK3R0X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:26:23 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AUHIvjJ007232;
        Mon, 30 Nov 2020 17:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=zxEYQxWkeioI23EP3tXuuM/cn+rrt2LlzfWd+JCPeBg=;
 b=kP4J/iQFAYitxa5dhwf3SLOQJEF7nOWtdj3FzxScLSXPU6GB8ZnauunklmiyaeBmq0Im
 1091zsECJDm/iUPe0BCUf5iPtGa4tf/r5y1XMbUF+pidYHlb2dMPPNI9vWTLJTrvyhE2
 PADrx4r5aquDUWiG8YS4zb2gzdpZPfGiY+w4kWD+i0Kh3OSL9qnwr4D3BvxQcjadDTrr
 3OVS5FJfBxID3BxsrHG77sp2nzZlxJU1Aj0DYtR5JqnUbXHvqT68b/KfLOqM3v4j8R7H
 hn3ye6tMPJpBe1OguKgxmAAykc1E8icWceixbSs5J0SRSt601bwRgtGxL9YjVUo3F1yr Ew== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 353egke8kg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Nov 2020 17:24:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AUHFGeO001413;
        Mon, 30 Nov 2020 17:22:25 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 3540fvdryn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Nov 2020 17:22:25 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AUHMKjf019059;
        Mon, 30 Nov 2020 17:22:20 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Nov 2020 09:22:19 -0800
Date:   Mon, 30 Nov 2020 09:22:18 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     chenlei0x@gmail.com
Cc:     hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lei Chen <lennychen@tencent.com>
Subject: Re: [PATCH] fs: iomap: Replace bio_add_page with __bio_add_page in
 iomap_add_to_ioend
Message-ID: <20201130172218.GA143045@magnolia>
References: <1606721331-4211-1-git-send-email-lennychen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606721331-4211-1-git-send-email-lennychen@tencent.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=3
 phishscore=0 mlxlogscore=743 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=3
 phishscore=0 mlxlogscore=726 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011300112
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 30, 2020 at 03:28:51PM +0800, chenlei0x@gmail.com wrote:
> From: Lei Chen <lennychen@tencent.com>
> 
> iomap_add_to_ioend append page on wpc->ioend->io_bio. If io_bio is full,
> iomap_chain_bio will allocate a new bio. So when bio_add_page is called,
> pages is guaranteed to be appended into wpc->ioend->io_bio. So we do not
> need to check if page can be merged. Thus it's a faster way to directly
> call __bio_add_page.

How much faster?

--D

> Signed-off-by: Lei Chen <lennychen@tencent.com>
> ---
>  fs/iomap/buffered-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 10cc797..7a0631a 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1310,7 +1310,7 @@ static void iomap_writepage_end_bio(struct bio *bio)
>  			wpc->ioend->io_bio =
>  				iomap_chain_bio(wpc->ioend->io_bio);
>  		}
> -		bio_add_page(wpc->ioend->io_bio, page, len, poff);
> +		__bio_add_page(wpc->ioend->io_bio, page, len, poff);
>  	}
>  
>  	wpc->ioend->io_size += len;
> -- 
> 1.8.3.1
> 
