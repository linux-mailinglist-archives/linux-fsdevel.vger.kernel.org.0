Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8836EEB925
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 22:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfJaVkh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 17:40:37 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:50486 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728597AbfJaVkh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 17:40:37 -0400
Received: from dread.disaster.area (pa49-180-67-183.pa.nsw.optusnet.com.au [49.180.67.183])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 747133A21D2;
        Fri,  1 Nov 2019 08:40:32 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQIBD-0006Ta-8P; Fri, 01 Nov 2019 08:40:31 +1100
Date:   Fri, 1 Nov 2019 08:40:31 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Brian Foster <bfoster@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] xfs/log: protect the logging content under xc_ctx_lock
Message-ID: <20191031214031.GV4614@dread.disaster.area>
References: <20191030133327.GA29340@mypc>
 <1572442631-4472-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572442631-4472-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=3wLbm4YUAFX2xaPZIabsgw==:117 a=3wLbm4YUAFX2xaPZIabsgw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=MeAgGD-zjQ4A:10
        a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8
        a=7-415B0cAAAA:8 a=-Yl8LpvAQeRDc2ysGZcA:9 a=8r_vt1YVzNHERcdx:21
        a=9OWIANwV6qZq4Njx:21 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
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

TL;DR: 1. log vectors. 2. CIL context lock exclusion.

When CPU A formats the item during commit, it copies all the changes
into a list of log vectors, and that is attached to the log item
and the item is added to the CIL. The item is then unlocked. This is
done with the CIL context lock held excluding CIL pushes.

When CPU C pushes on the CIL, it detatches the -log vectors- from
the log item and removes the item from the CIL. This is done hold
the CIL context lock, excluding transaction commits from modifying
the CIL log vector list. It then formats the -log vectors- into the
journal by passing them to xlog_write().  It does not use log items
for this, and because the log vector list has been isolated and is
now private to the push context, we don't need to hold any locks
anymore to call xlog_write....

When CPU B modifies item1, it modifies the item and logs the new
changes to the log item. It does not modify the log vector that
might be attached to the log item from a previous change. The log
vector is only updated during transaction commit, so the changes
being made in transaction on CPU B are private to that transaction
until they are committed, formatted into log vectors and inserted
into the CIL under the CIL context lock.

> Survive this race issue by putting under the protection of xc_ctx_lock.
> Meanwhile the xc_cil_lock can be dropped as xc_ctx_lock does it against
> xlog_cil_insert_items()
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
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

We don't hold the CIL context lock anymore....

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

So this is completely unserialised now. i.e. even if there was a
problem like you suggest, this modification doesn't do what you say
it does.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
