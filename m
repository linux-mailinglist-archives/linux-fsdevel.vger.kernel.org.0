Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D01B5EA20C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 17:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfJ3Qsp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 12:48:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35940 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfJ3Qsp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 12:48:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9UGYgaa106916;
        Wed, 30 Oct 2019 16:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=CEaVZyeZjKoMAljaxyja7VfInrqBUnmMzIB87sgjGL0=;
 b=Pvqz/ea8C3BrsVWxcChE13ypqvb4TodEUreVrVhdkz9qce0zApaGmYKsyHLR+r6Hgujm
 gAjOiyuwHw24Ns0D4IZX86g1TLoiwTyaFQPS7zTZnvG+nNyZipTMbMC2YD80GDSHqRpx
 lZIyk9CDWiIQaZUYHaRaurhGQPmRWbE2xTZ1Tc1fU9kEVMhzMFDVm/N0DZxIF8zvXFV7
 dFwF+nBR1PYzNGx2iTIWI/T1fT5JDN2+yh+efY1YD8mte5Rxi0Ik/dIaplS4NzNjOkG4
 rPz06Zzovk5dgPAI94pP614Nx/dLg+TtYEkYIDBU48D3qj1pDeyTtxS/plaz2iw+m3y1 4Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vxwhfnm2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 16:48:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9UGXd0m166468;
        Wed, 30 Oct 2019 16:48:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2vxwhwdt1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 16:48:27 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9UGmRKC006190;
        Wed, 30 Oct 2019 16:48:27 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 09:48:26 -0700
Date:   Wed, 30 Oct 2019 09:48:25 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-xfs@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] xfs/log: protect the logging content under xc_ctx_lock
Message-ID: <20191030164825.GJ15222@magnolia>
References: <20191030133327.GA29340@mypc>
 <1572442631-4472-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572442631-4472-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910300150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910300150
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 30, 2019 at 09:37:11PM +0800, Pingfan Liu wrote:
> xc_cil_lock is not enough to protect the integrity of a trans logging.
> Taking the scenario:
>   cpuA                                 cpuB                          cpuC
> 
>   xlog_cil_insert_format_items()
> 
>   spin_lock(&cil->xc_cil_lock)
>   link transA's items to xc_cil,
>      including item1
>   spin_unlock(&cil->xc_cil_lock)
>                                                                       xlog_cil_push() fetches transA's item under xc_cil_lock
>                                        issue transB, modify item1
>                                                                       xlog_write(), but now, item1 contains content from transB and we have a broken transA
> 
> Survive this race issue by putting under the protection of xc_ctx_lock.
> Meanwhile the xc_cil_lock can be dropped as xc_ctx_lock does it against
> xlog_cil_insert_items()

How did you trigger this race?  Is there a test case to reproduce, or
did you figure this out via code inspection?

--D

> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
> Cc: Brian Foster <bfoster@redhat.com>
> To: linux-xfs@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/xfs/xfs_log_cil.c | 35 +++++++++++++++++++----------------
>  1 file changed, 19 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
> index 004af09..f8df3b5 100644
> --- a/fs/xfs/xfs_log_cil.c
> +++ b/fs/xfs/xfs_log_cil.c
> @@ -723,22 +723,6 @@ xlog_cil_push(
>  	 */
>  	lv = NULL;
>  	num_iovecs = 0;
> -	spin_lock(&cil->xc_cil_lock);
> -	while (!list_empty(&cil->xc_cil)) {
> -		struct xfs_log_item	*item;
> -
> -		item = list_first_entry(&cil->xc_cil,
> -					struct xfs_log_item, li_cil);
> -		list_del_init(&item->li_cil);
> -		if (!ctx->lv_chain)
> -			ctx->lv_chain = item->li_lv;
> -		else
> -			lv->lv_next = item->li_lv;
> -		lv = item->li_lv;
> -		item->li_lv = NULL;
> -		num_iovecs += lv->lv_niovecs;
> -	}
> -	spin_unlock(&cil->xc_cil_lock);
>  
>  	/*
>  	 * initialise the new context and attach it to the CIL. Then attach
> @@ -783,6 +767,25 @@ xlog_cil_push(
>  	up_write(&cil->xc_ctx_lock);
>  
>  	/*
> +	 * cil->xc_cil_lock around this loop can be dropped, since xc_ctx_lock
> +	 * protects us against xlog_cil_insert_items().
> +	 */
> +	while (!list_empty(&cil->xc_cil)) {
> +		struct xfs_log_item	*item;
> +
> +		item = list_first_entry(&cil->xc_cil,
> +					struct xfs_log_item, li_cil);
> +		list_del_init(&item->li_cil);
> +		if (!ctx->lv_chain)
> +			ctx->lv_chain = item->li_lv;
> +		else
> +			lv->lv_next = item->li_lv;
> +		lv = item->li_lv;
> +		item->li_lv = NULL;
> +		num_iovecs += lv->lv_niovecs;
> +	}
> +
> +	/*
>  	 * Build a checkpoint transaction header and write it to the log to
>  	 * begin the transaction. We need to account for the space used by the
>  	 * transaction header here as it is not accounted for in xlog_write().
> -- 
> 2.7.5
> 
