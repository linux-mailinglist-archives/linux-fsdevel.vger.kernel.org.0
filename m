Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC867279607
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Sep 2020 03:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgIZBuB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Sep 2020 21:50:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39458 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIZBuB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Sep 2020 21:50:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08Q1kTwm027956;
        Sat, 26 Sep 2020 01:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=sXjGsOTMBrrIPiwb3LmvY804JrcHel7QixYSuvHz8QY=;
 b=XIMaeajgjX4WwKB1B/xfyFW5w/i97L1kq70QYmIAbifnI40nnA/4ui4o2TMc+h6u9z8Z
 ciwGv2wgI2gvCc2iD2ITVZ8Sh//prUIqNAU47fkqOg6yhJsUQ3XFqtVzjHg0uelBcAX9
 Ntc/IN+7eC0K6cEjkBPEkPRRAWIT/5Q3XtyHzk7HGS1Iu2RCbfYv/7d/80zj2CZrCjmP
 P2KbjDESZWLEE/frP7G08kPfNu6jkl9UU6UeRvT/gn2S9t2N0+j+73OgRsFSsSn0VbhE
 eFjLd+4s6tFYWd35RhTRNI/R3klH2DmqH20vWp7e0JyZWIuXIr5gDa5xLs7xXVWWuY4r 6w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 33ndnv0ayw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 26 Sep 2020 01:49:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08Q1iXVM008056;
        Sat, 26 Sep 2020 01:49:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 33nuryjdnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Sep 2020 01:49:46 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08Q1nfUI020995;
        Sat, 26 Sep 2020 01:49:41 GMT
Received: from localhost (/10.159.232.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Sep 2020 18:49:40 -0700
Date:   Fri, 25 Sep 2020 18:49:39 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        david@fromorbit.com, hch@lst.de, johannes.thumshirn@wdc.com,
        dsterba@suse.com, josef@toxicpanda.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 03/14] iomap: Allow filesystem to call iomap_dio_complete
 without i_rwsem
Message-ID: <20200926014939.GP7964@magnolia>
References: <20200924163922.2547-1-rgoldwyn@suse.de>
 <20200924163922.2547-4-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924163922.2547-4-rgoldwyn@suse.de>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=5
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009260011
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=5 bulkscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009260011
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 24, 2020 at 11:39:10AM -0500, Goldwyn Rodrigues wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> This is to avoid the deadlock caused in btrfs because of O_DIRECT |
> O_DSYNC.
> 
> Filesystems such as btrfs require i_rwsem while performing sync on a
> file. iomap_dio_rw() is called under i_rw_sem. This leads to a
> deadlock because of:
> 
> iomap_dio_complete()
>   generic_write_sync()
>     btrfs_sync_file()
> 
> Separate out iomap_dio_complete() from iomap_dio_rw(), so filesystems
> can call iomap_dio_complete() after unlocking i_rwsem.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Seems clunky, but then I don't understand btrfs locking either. :)

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/direct-io.c  | 35 ++++++++++++++++++++++++++---------
>  include/linux/iomap.h |  5 +++++
>  2 files changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index c1aafb2ab990..b88dbfe15118 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -76,7 +76,7 @@ static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
>  		dio->submit.cookie = submit_bio(bio);
>  }
>  
> -static ssize_t iomap_dio_complete(struct iomap_dio *dio)
> +ssize_t iomap_dio_complete(struct iomap_dio *dio)
>  {
>  	const struct iomap_dio_ops *dops = dio->dops;
>  	struct kiocb *iocb = dio->iocb;
> @@ -130,6 +130,7 @@ static ssize_t iomap_dio_complete(struct iomap_dio *dio)
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(iomap_dio_complete);
>  
>  static void iomap_dio_complete_work(struct work_struct *work)
>  {
> @@ -406,8 +407,8 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
>   * Returns -ENOTBLK In case of a page invalidation invalidation failure for
>   * writes.  The callers needs to fall back to buffered I/O in this case.
>   */
> -ssize_t
> -iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> +struct iomap_dio *
> +__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
>  		bool wait_for_completion)
>  {
> @@ -421,14 +422,14 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	struct iomap_dio *dio;
>  
>  	if (!count)
> -		return 0;
> +		return NULL;
>  
>  	if (WARN_ON(is_sync_kiocb(iocb) && !wait_for_completion))
> -		return -EIO;
> +		return ERR_PTR(-EIO);
>  
>  	dio = kmalloc(sizeof(*dio), GFP_KERNEL);
>  	if (!dio)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  
>  	dio->iocb = iocb;
>  	atomic_set(&dio->ref, 1);
> @@ -558,7 +559,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	dio->wait_for_completion = wait_for_completion;
>  	if (!atomic_dec_and_test(&dio->ref)) {
>  		if (!wait_for_completion)
> -			return -EIOCBQUEUED;
> +			return ERR_PTR(-EIOCBQUEUED);
>  
>  		for (;;) {
>  			set_current_state(TASK_UNINTERRUPTIBLE);
> @@ -574,10 +575,26 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		__set_current_state(TASK_RUNNING);
>  	}
>  
> -	return iomap_dio_complete(dio);
> +	return dio;
>  
>  out_free_dio:
>  	kfree(dio);
> -	return ret;
> +	if (ret)
> +		return ERR_PTR(ret);
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(__iomap_dio_rw);
> +
> +ssize_t
> +iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> +		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
> +		bool wait_for_completion)
> +{
> +	struct iomap_dio *dio;
> +
> +	dio = __iomap_dio_rw(iocb, iter, ops, dops, wait_for_completion);
> +	if (IS_ERR_OR_NULL(dio))
> +		return PTR_ERR_OR_ZERO(dio);
> +	return iomap_dio_complete(dio);
>  }
>  EXPORT_SYMBOL_GPL(iomap_dio_rw);
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 4d1d3c3469e9..172b3397a1a3 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -13,6 +13,7 @@
>  struct address_space;
>  struct fiemap_extent_info;
>  struct inode;
> +struct iomap_dio;
>  struct iomap_writepage_ctx;
>  struct iov_iter;
>  struct kiocb;
> @@ -258,6 +259,10 @@ struct iomap_dio_ops {
>  ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
>  		bool wait_for_completion);
> +struct iomap_dio *__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> +		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
> +		bool wait_for_completion);
> +ssize_t iomap_dio_complete(struct iomap_dio *dio);
>  int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
>  
>  #ifdef CONFIG_SWAP
> -- 
> 2.26.2
> 
