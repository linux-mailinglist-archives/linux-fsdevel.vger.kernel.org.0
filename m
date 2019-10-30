Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B20F1EA257
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 18:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfJ3RO3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 13:14:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35338 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfJ3RO3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 13:14:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9UHE38M143031;
        Wed, 30 Oct 2019 17:14:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=JmEPbmabBjkGnbawFsZk0vs5RMVmXMj2aa8Zbi5xXIw=;
 b=oImHE+D4stjg1g8M72NqucHbw9hmMDVV7FjJmSzuT0+hzdkf2UyG7z54kU6mx5YepuYn
 e3pVATbReZgK1dLryyiIrUw6sdAjODboiXytsC9XgTeWQxLGd6ts4Nty/KPPztg6H/q3
 S9K7OqaiHE44YylgybN99exa9Bf0BBlJ+9ZxGG9w8SRSuQ9FfZpexKqEFNVsmQvZQSRL
 QlGIDcFN1GDupm1QHxhnm3w/fn94C0Ci+OW51bp4abc6LLTyMVSQeYQzM/zH/vMFB/Es
 +N9zcOVYBi8Q5gG8QoFdFU8YJ1iILJXQRu+5nBL1Z9Oc/KxJNao4v/5LPqEC00ulM3JR aA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2vxwhfnrwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 17:14:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9UHDxhi012925;
        Wed, 30 Oct 2019 17:14:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2vxwj9pce1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 17:14:24 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9UHENmX032218;
        Wed, 30 Oct 2019 17:14:23 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 10:14:23 -0700
Date:   Wed, 30 Oct 2019 10:14:22 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/26] xfs: don't allow log IO to be throttled
Message-ID: <20191030171422.GM15222@magnolia>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-4-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009032124.10541-4-david@fromorbit.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=924
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

On Wed, Oct 09, 2019 at 02:21:01PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Running metadata intensive workloads, I've been seeing the AIL
> pushing getting stuck on pinned buffers and triggering log forces.
> The log force is taking a long time to run because the log IO is
> getting throttled by wbt_wait() - the block layer writeback
> throttle. It's being throttled because there is a huge amount of
> metadata writeback going on which is filling the request queue.
> 
> IOWs, we have a priority inversion problem here.
> 
> Mark the log IO bios with REQ_IDLE so they don't get throttled
> by the block layer writeback throttle. When we are forcing the CIL,
> we are likely to need to to tens of log IOs, and they are issued as
> fast as they can be build and IO completed. Hence REQ_IDLE is
> appropriate - it's an indication that more IO will follow shortly.
> 
> And because we also set REQ_SYNC, the writeback throttle will no
> treat log IO the same way it treats direct IO writes - it will not
> throttle them at all. Hence we solve the priority inversion problem
> caused by the writeback throttle being unable to distinguish between
> high priority log IO and background metadata writeback.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_log.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
> index 6f99d6eae6a4..cf098e19967e 100644
> --- a/fs/xfs/xfs_log.c
> +++ b/fs/xfs/xfs_log.c
> @@ -1751,7 +1751,15 @@ xlog_write_iclog(
>  	iclog->ic_bio.bi_iter.bi_sector = log->l_logBBstart + bno;
>  	iclog->ic_bio.bi_end_io = xlog_bio_end_io;
>  	iclog->ic_bio.bi_private = iclog;
> -	iclog->ic_bio.bi_opf = REQ_OP_WRITE | REQ_META | REQ_SYNC | REQ_FUA;
> +
> +	/*
> +	 * We use REQ_SYNC | REQ_IDLE here to tell the block layer the are more
> +	 * IOs coming immediately after this one. This prevents the block layer
> +	 * writeback throttle from throttling log writes behind background
> +	 * metadata writeback and causing priority inversions.
> +	 */
> +	iclog->ic_bio.bi_opf = REQ_OP_WRITE | REQ_META | REQ_SYNC |
> +				REQ_IDLE | REQ_FUA;
>  	if (need_flush)
>  		iclog->ic_bio.bi_opf |= REQ_PREFLUSH;
>  
> -- 
> 2.23.0.rc1
> 
