Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF5B224595
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 23:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgGQVE3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 17:04:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47424 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgGQVE2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 17:04:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06HL3IG2013698;
        Fri, 17 Jul 2020 21:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=MM7mdGykqks3yBttHdwzGPDw1wP4s4tokF4UONjrXBE=;
 b=n4fd1huMLf1/ZFaqGiKLnSpsN1AKpxfbcOPLORjsQ1jTnuax6a8kAhM0qenRPHn184XB
 DUGASgisVnyApaMTNVrY6i1tsnocOzuLC1Uj8xQQrbFr0Az+pV2nEmcRWqkmtrb/CRvS
 mRRvIRbh4bz/ovWi/V+tnw4DVS6ZFCXmG/NkASGMKDYwMdweDADF+mD1FgoKqP0lYJfV
 yHA9/jlnBelOUJlMRFAZXd1lVZTPG+BspfOlD55wmJ9zbJr3snWSjX2UvqxUPiUou/D8
 pr8LNIEaSiTEHwrBB7/oivGhiVg1RZvLXlz+4L83e2dR66fLraWOI1QHhUn/3VL7RiqI uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 3275cmsfnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jul 2020 21:04:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06HL3tqK025230;
        Fri, 17 Jul 2020 21:04:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 32bj2d3hdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jul 2020 21:04:25 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06HL4O0N002782;
        Fri, 17 Jul 2020 21:04:24 GMT
Received: from localhost (/10.159.159.76)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Jul 2020 14:04:24 -0700
Date:   Fri, 17 Jul 2020 14:04:23 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] fs/direct-io: fix one-time init of ->s_dio_done_wq
Message-ID: <20200717210423.GP3151642@magnolia>
References: <20200717050510.95832-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717050510.95832-1-ebiggers@kernel.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9685 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007170142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9685 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007170142
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 10:05:10PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Correctly implement the "one-time" init pattern for ->s_dio_done_wq.
> This fixes the following issues:
> 
> - The LKMM doesn't guarantee that the workqueue will be seen initialized
>   before being used, if another CPU allocated it.  With regards to
>   specific CPU architectures, this is true on at least Alpha, but it may
>   be true on other architectures too if the internal implementation of
>   workqueues causes use of the workqueue to involve a control
>   dependency.  (There doesn't appear to be a control dependency
>   currently, but it's hard to tell and it could change in the future.)
> 
> - The preliminary checks for sb->s_dio_done_wq are a data race, since
>   they do a plain load of a concurrently modified variable.  According
>   to the C standard, this undefined behavior.  In practice, the kernel
>   does sometimes makes assumptions about data races might be okay in
>   practice, but these rules are undocumented and not uniformly agreed
>   upon, so it's best to avoid cases where they might come into play.
> 
> Following the guidance for one-time init I've proposed at
> https://lkml.kernel.org/r/20200717044427.68747-1-ebiggers@kernel.org,

It might be a good idea to combine these two patches into a series so
that we can leave a breadcrumb in sb_init_dio_done_wq explaining why it
does what it does.

> replace it with the simplest implementation that is guaranteed to be
> correct while still achieving the following properties:
> 
>     - Doesn't make direct I/O users contend on a mutex in the fast path.
> 
>     - Doesn't allocate the workqueue when it will never be used.
> 
> Fixes: 7b7a8665edd8 ("direct-io: Implement generic deferred AIO completions")
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> 
> v2: new implementation using smp_load_acquire() + smp_store_release()
>     and a mutex.
> 
>  fs/direct-io.c       | 42 ++++++++++++++++++++++++------------------
>  fs/iomap/direct-io.c |  3 +--
>  2 files changed, 25 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 6d5370eac2a8..c03c2204aadf 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -592,20 +592,28 @@ static inline int dio_bio_reap(struct dio *dio, struct dio_submit *sdio)
>   */
>  int sb_init_dio_done_wq(struct super_block *sb)
>  {
> -	struct workqueue_struct *old;
> -	struct workqueue_struct *wq = alloc_workqueue("dio/%s",
> -						      WQ_MEM_RECLAIM, 0,
> -						      sb->s_id);
> -	if (!wq)
> -		return -ENOMEM;
> -	/*
> -	 * This has to be atomic as more DIOs can race to create the workqueue
> -	 */
> -	old = cmpxchg(&sb->s_dio_done_wq, NULL, wq);
> -	/* Someone created workqueue before us? Free ours... */
> -	if (old)
> -		destroy_workqueue(wq);
> -	return 0;
> +	static DEFINE_MUTEX(sb_init_dio_done_mutex);
> +	struct workqueue_struct *wq;
> +	int err = 0;
> +
> +	/* Pairs with the smp_store_release() below */
> +	if (smp_load_acquire(&sb->s_dio_done_wq))
> +		return 0;
> +
> +	mutex_lock(&sb_init_dio_done_mutex);
> +	if (sb->s_dio_done_wq)
> +		goto out;
> +
> +	wq = alloc_workqueue("dio/%s", WQ_MEM_RECLAIM, 0, sb->s_id);
> +	if (!wq) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +	/* Pairs with the smp_load_acquire() above */
> +	smp_store_release(&sb->s_dio_done_wq, wq);

Why not use cmpxchg_release here?  Is the mutex actually required here,
or is this merely following the "don't complicate it up" guidelines in
the "One-Time Init" recipe that say not to use cmpxchg_release unless
you have a strong justification for it?

The code changes look ok to me, fwiw.

--D

> +out:
> +	mutex_unlock(&sb_init_dio_done_mutex);
> +	return err;
>  }
>  
>  static int dio_set_defer_completion(struct dio *dio)
> @@ -615,9 +623,7 @@ static int dio_set_defer_completion(struct dio *dio)
>  	if (dio->defer_completion)
>  		return 0;
>  	dio->defer_completion = true;
> -	if (!sb->s_dio_done_wq)
> -		return sb_init_dio_done_wq(sb);
> -	return 0;
> +	return sb_init_dio_done_wq(sb);
>  }
>  
>  /*
> @@ -1250,7 +1256,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  		retval = 0;
>  		if (iocb->ki_flags & IOCB_DSYNC)
>  			retval = dio_set_defer_completion(dio);
> -		else if (!dio->inode->i_sb->s_dio_done_wq) {
> +		else {
>  			/*
>  			 * In case of AIO write racing with buffered read we
>  			 * need to defer completion. We can't decide this now,
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index ec7b78e6feca..dc7fe898dab8 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -487,8 +487,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		dio_warn_stale_pagecache(iocb->ki_filp);
>  	ret = 0;
>  
> -	if (iov_iter_rw(iter) == WRITE && !wait_for_completion &&
> -	    !inode->i_sb->s_dio_done_wq) {
> +	if (iov_iter_rw(iter) == WRITE && !wait_for_completion) {
>  		ret = sb_init_dio_done_wq(inode->i_sb);
>  		if (ret < 0)
>  			goto out_free_dio;
> -- 
> 2.27.0
> 
