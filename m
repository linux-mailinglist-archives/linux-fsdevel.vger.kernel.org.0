Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28AD2817B2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Oct 2020 18:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388153AbgJBQT2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 12:19:28 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50194 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgJBQT2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:19:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 092GDfsZ139593;
        Fri, 2 Oct 2020 16:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=FcZy9PfJSVB0G83HZ7/BBIKBYKMNzfdXXN/tNf4sIh4=;
 b=uos+Sd1xbIzjzw0SecSy0gAEbW0tcBTSxHpLIMTrvHTjNyw2ZxwaeMQH+ZLWrBB0IaTq
 SkFx/P5Ikad2NZ9T+25NoatVKGzQQHahuQkcrQVMn0BBTpx8JBEwxz1f2LpsF7YQjBtZ
 Uwtna2YAX2VDK16W6Q2biu8Rgxc1D4W1fX3Ditl8wiIzBuB0JFYBa7LfrMAEhSQqh5C0
 emorv08+sJ/x8zKjjG41/2fwi1d9kfJULorBJ+xznuf6bvetmga7GSLEJEQWfcWbI8eh
 e7dntnZZTPSVgs/Zuxek39jDFSvyMdGGPekMiXj59qrTk0hrgG1ZzGGoE3j2XMomq6OK Rg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 33swkmbrpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 02 Oct 2020 16:19:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 092GF2xp036984;
        Fri, 2 Oct 2020 16:19:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 33uv2jhgby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Oct 2020 16:19:24 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 092GJNWU016768;
        Fri, 2 Oct 2020 16:19:23 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Oct 2020 09:19:23 -0700
Date:   Fri, 2 Oct 2020 09:19:23 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/2] xfs: kick extra large ioends to completion workqueue
Message-ID: <20201002161923.GB49524@magnolia>
References: <20201002153357.56409-1-bfoster@redhat.com>
 <20201002153357.56409-3-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002153357.56409-3-bfoster@redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9762 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=1 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010020123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9762 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=1 mlxlogscore=999 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010020123
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 02, 2020 at 11:33:57AM -0400, Brian Foster wrote:
> We've had reports of soft lockup warnings in the iomap ioend
> completion path due to very large bios and/or bio chains. Divert any
> ioends with 256k or more pages to process to the workqueue so
> completion occurs in non-atomic context and can reschedule to avoid
> soft lockup warnings.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>  fs/xfs/xfs_aops.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 3e061ea99922..84ee917014f1 100644
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
> +#define XFS_LARGE_IOEND	(262144 << PAGE_SHIFT)

Hm, shouldn't that 262144 have to be annoated with a 'ULL' so that a
dumb compiler won't turn that into a u32 and shift that all the way to
zero?

I still kind of wonder about the letting the limit hit 16G on power with
64k pages, but I guess the number of pages we have to whack is ... not
that high?

I dunno, if you fire up a 64k-page system with fantastical IO
capabilities, attach a realtime volume, fallocate a 32G file and then
try to write to that, will it actually turn that into one gigantic IO?

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
