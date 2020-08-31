Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DEC257136
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 02:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgHaAan (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Aug 2020 20:30:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38614 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgHaAam (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Aug 2020 20:30:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07V0P2TH047948;
        Mon, 31 Aug 2020 00:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=5tC/wlNp0puD7zLA31pTRgiOEnDcLFU5sUbJV8KxuXM=;
 b=uKscBZWhSvshBAPv2PtL4Yu6Jd1xQS0miJM5DBl2CS1NoZjFK1cuIzIOqpK3KzU5sEma
 NdXkgjbIvsao7PmWWAM7yrHwKRCS8M5K7rilMvwkhUsg/hR20xZnv0PiMreBkATk4cpC
 X/tg8FlbJNnBskybbXh+i5CC/eWMPEAJ1bDiWmoFdoZ1LDuBweB1Y5r0Lc71E8sP5Ktm
 6phRhBpYHzI7JSKuxuayY9glVHh7R9adxBNtam0Q7egYKX1pvzeHmhrkMcLl+08IxJ+v
 dO6N3Ahu3RcymviBhoWg+3clSP0CwA4z7z/e/0wFEogiejlC+KK4O6PoPWDiS5zmTnhj RQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 337eeqknmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Aug 2020 00:30:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07V0QVv0016374;
        Mon, 31 Aug 2020 00:30:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 3380wxrrs2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Aug 2020 00:30:32 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07V0UUSV028133;
        Mon, 31 Aug 2020 00:30:30 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 30 Aug 2020 17:30:30 -0700
Date:   Sun, 30 Aug 2020 17:30:33 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Qian Cai <cai@lca.pw>
Cc:     hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomap: fix WARN_ON_ONCE() from unprivileged users
Message-ID: <20200831003033.GZ6096@magnolia>
References: <20200830013057.14664-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200830013057.14664-1-cai@lca.pw>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=56 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008310001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=56
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008310001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 29, 2020 at 09:30:57PM -0400, Qian Cai wrote:
> It is trivial to trigger a WARN_ON_ONCE(1) in iomap_dio_actor() by
> unprivileged users which would taint the kernel, or worse - panic if
> panic_on_warn or panic_on_taint is set. Hence, just convert it to
> pr_warn_ratelimited() to let users know their workloads are racing.
> Thanks Dave Chinner for the initial analysis of the racing reproducers.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  fs/iomap/direct-io.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index c1aafb2ab990..6a6b4bc13269 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -389,7 +389,14 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
>  	case IOMAP_INLINE:
>  		return iomap_dio_inline_actor(inode, pos, length, dio, iomap);
>  	default:
> -		WARN_ON_ONCE(1);
> +		/*
> +		 * DIO is not serialised against mmap() access at all, and so
> +		 * if the page_mkwrite occurs between the writeback and the
> +		 * iomap_apply() call in the DIO path, then it will see the
> +		 * DELALLOC block that the page-mkwrite allocated.
> +		 */
> +		pr_warn_ratelimited("page_mkwrite() is racing with DIO read (iomap->type = %u).\n",
> +				    iomap->type);

Shouldn't we log the name of triggering process and the file path?  Sort
of like what dio_warn_stale_pagecache does?

--D

>  		return -EIO;
>  	}
>  }
> -- 
> 2.18.4
> 
