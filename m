Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAAD515A0D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Apr 2022 05:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbiD3DTX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 23:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbiD3DTW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 23:19:22 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDA795A25
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 20:15:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VBlilYd_1651288551;
Received: from 30.47.241.146(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VBlilYd_1651288551)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 30 Apr 2022 11:15:52 +0800
Message-ID: <e054bee7-88a8-65c3-5390-84ff46ef36f2@linux.alibaba.com>
Date:   Sat, 30 Apr 2022 11:15:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [RFC PATCH 1/1] erofs: change to use asynchronous io for fscache
 readahead
Content-Language: en-US
To:     Xin Yin <yinxin.x@bytedance.com>, xiang@kernel.org,
        dhowells@redhat.com
Cc:     linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
References: <20220428233849.321495-1-yinxin.x@bytedance.com>
 <20220428233849.321495-2-yinxin.x@bytedance.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220428233849.321495-2-yinxin.x@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Xin,

Thanks for the awsome work, which is exacly what we need.



On 4/29/22 7:38 AM, Xin Yin wrote:
> Add erofs_fscache_read_folios_async helper which has same on-demand
> read logic with erofs_fscache_read_folios, also support asynchronously
> read data from fscache.And change .readahead() to use this new helper.
> 
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> ---
>  fs/erofs/fscache.c | 256 ++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 245 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index eaa50692ddba..4241f1cdc30b 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -5,6 +5,231 @@
>  #include <linux/fscache.h>
>  #include "internal.h"
>  
> +static void erofs_fscache_put_subrequest(struct netfs_io_subrequest *subreq);
> +
> +static struct netfs_io_request *erofs_fscache_alloc_request(struct address_space *mapping,
> +					     loff_t start, size_t len)
> +{
> +	struct netfs_io_request *rreq;
> +
> +	rreq = kzalloc(sizeof(struct netfs_io_request), GFP_KERNEL);
> +	if (!rreq)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rreq->start	= start;
> +	rreq->len	= len;
> +	rreq->mapping	= mapping;
> +	INIT_LIST_HEAD(&rreq->subrequests);
> +	refcount_set(&rreq->ref, 1);
> +
> +	return rreq;
> +}
> +
> +static void erofs_fscache_clear_subrequests(struct netfs_io_request *rreq)
> +{
> +	struct netfs_io_subrequest *subreq;
> +
> +	while (!list_empty(&rreq->subrequests)) {
> +		subreq = list_first_entry(&rreq->subrequests,
> +					  struct netfs_io_subrequest, rreq_link);
> +		list_del(&subreq->rreq_link);
> +		erofs_fscache_put_subrequest(subreq);
> +	}
> +}
> +


> +static void erofs_fscache_free_request(struct netfs_io_request *rreq)
> +{
> +	erofs_fscache_clear_subrequests(rreq);

Actually I don't underdtand why erofs_fscache_clear_subrequests() is
needed here. erofs_fscache_free_request() is called only when rreq->ref
has been decreased to 0. That means there's already no subrequest, or
rreq->ref won't be 0 since each subrequest maintains one refcount of
rreq. Though I know it's a copy from netfs_free_request()...


> +	if (rreq->cache_resources.ops)
> +		rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
> +	kfree(rreq);
> +}
> +
> +static void erofs_fscache_put_request(struct netfs_io_request *rreq)
> +{
> +	bool dead;
> +
> +	dead = refcount_dec_and_test(&rreq->ref);
> +	if (dead)
> +		erofs_fscache_free_request(rreq);
> +}

How about making erofs_fscache_free_request() folded inside
erofs_fscache_put_request(), since here each function is quite short?

Besides, how about

if (refcount_dec_and_test(&rreq->ref)) {
	/* erofs_fscache_free_request */
}


> +
> +
> +static struct netfs_io_subrequest *
> +	erofs_fscache_alloc_subrequest(struct netfs_io_request *rreq)
> +{
> +	struct netfs_io_subrequest *subreq;
> +
> +	subreq = kzalloc(sizeof(struct netfs_io_subrequest), GFP_KERNEL);
> +	if (subreq) {
> +		INIT_LIST_HEAD(&subreq->rreq_link);
> +		refcount_set(&subreq->ref, 2);
> +		subreq->rreq = rreq;
> +		refcount_inc(&rreq->ref);
> +	}
> +
> +	return subreq;
> +}
> +


> +static void erofs_fscache_free_subrequest(struct netfs_io_subrequest *subreq)
> +{
> +	struct netfs_io_request *rreq = subreq->rreq;
> +
> +	kfree(subreq);
> +	erofs_fscache_put_request(rreq);
> +}
> +
> +static void erofs_fscache_put_subrequest(struct netfs_io_subrequest *subreq)
> +{
> +	bool dead;
> +
> +	dead = refcount_dec_and_test(&subreq->ref);
> +	if (dead)
> +		erofs_fscache_free_subrequest(subreq);
> +}

Similar to the issue of erofs_fscache_put_request().


> +
> +
> +static void erofs_fscache_rreq_unlock_folios(struct netfs_io_request *rreq)
> +{
> +	struct netfs_io_subrequest *subreq;
> +	struct folio *folio;
> +	unsigned int iopos;
> +	pgoff_t start_page = rreq->start / PAGE_SIZE;
> +	pgoff_t last_page = ((rreq->start + rreq->len) / PAGE_SIZE) - 1;
> +	bool subreq_failed = false;
> +
> +	XA_STATE(xas, &rreq->mapping->i_pages, start_page);
> +
> +	subreq = list_first_entry(&rreq->subrequests,
> +				  struct netfs_io_subrequest, rreq_link);
> +	iopos = 0;
> +	subreq_failed = (subreq->error < 0);
> +
> +	rcu_read_lock();
> +	xas_for_each(&xas, folio, last_page) {
> +		unsigned int pgpos = (folio_index(folio) - start_page) * PAGE_SIZE;
> +		unsigned int pgend = pgpos + folio_size(folio);
> +		bool pg_failed = false;
> +
> +		for (;;) {
> +			if (!subreq) {
> +				pg_failed = true;
> +				break;
> +			}
> +
> +			pg_failed |= subreq_failed;
> +			if (pgend < iopos + subreq->len)
> +				break;
> +
> +			iopos += subreq->len;
> +			if (!list_is_last(&subreq->rreq_link, &rreq->subrequests)) {
> +				subreq = list_next_entry(subreq, rreq_link);
> +				subreq_failed = (subreq->error < 0);
> +			} else {
> +				subreq = NULL;
> +				subreq_failed = false;
> +			}
> +			if (pgend == iopos)
> +				break;
> +		}
> +
> +		if (!pg_failed)
> +			folio_mark_uptodate(folio);
> +
> +		folio_unlock(folio);
> +	}
> +	rcu_read_unlock();
> +}
> +
> +
> +static void erofs_fscache_rreq_complete(struct netfs_io_request *rreq)
> +{
> +	erofs_fscache_rreq_unlock_folios(rreq);
> +	erofs_fscache_clear_subrequests(rreq);
> +	erofs_fscache_put_request(rreq);
> +}
> +
> +static void erofc_fscache_subreq_complete(void *priv, ssize_t transferred_or_error,
> +					bool was_async)
> +{
> +	struct netfs_io_subrequest *subreq = priv;
> +	struct netfs_io_request *rreq = subreq->rreq;
> +
> +	if (IS_ERR_VALUE(transferred_or_error))
> +		subreq->error = transferred_or_error;
> +
> +	if (atomic_dec_and_test(&rreq->nr_outstanding))
> +		erofs_fscache_rreq_complete(rreq);
> +
> +	erofs_fscache_put_subrequest(subreq);
> +}
> +
> +static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
> +				     struct netfs_io_request *rreq,
> +				     loff_t start, size_t len,
> +				     loff_t pstart)
> +{
> +	enum netfs_io_source source;
> +	struct netfs_io_subrequest *subreq;
> +	struct netfs_cache_resources *cres;
> +	struct iov_iter iter;
> +	size_t done = 0;
> +	int ret;
> +
> +	atomic_set(&rreq->nr_outstanding, 1);
> +
> +	cres = &rreq->cache_resources;
> +	ret = fscache_begin_read_operation(cres, cookie);
> +	if (ret)
> +		goto out;
> +
> +	while (done < len) {
> +		subreq = erofs_fscache_alloc_subrequest(rreq);
> +		if (!subreq) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		subreq->start = pstart + done;
> +		subreq->len	=  len - done;
> +		subreq->flags = 1 << NETFS_SREQ_ONDEMAND;
> +
> +		list_add_tail(&subreq->rreq_link, &rreq->subrequests);
> +
> +		source = cres->ops->prepare_read(subreq, LLONG_MAX);
> +		if (WARN_ON(subreq->len == 0))
> +			source = NETFS_INVALID_READ;
> +		if (source != NETFS_READ_FROM_CACHE) {
> +			ret = -EIO;
> +			erofs_fscache_put_subrequest(subreq);
> +			goto out;

Need to set subreq->error here before going to out?


> +		}
> +
> +		atomic_inc(&rreq->nr_outstanding);
> +
> +		iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages,
> +				start + done, subreq->len);
> +
> +		ret = fscache_read(cres, subreq->start, &iter,
> +				   NETFS_READ_HOLE_FAIL, erofc_fscache_subreq_complete, subreq);
> +
> +		if (ret == -EIOCBQUEUED)
> +			ret = 0;
> +
> +		if (ret) {
> +			erofs_fscache_put_subrequest(subreq);

I think erofs_fscache_put_subrequest() here is not needed, since when
error encountered, erofc_fscache_subreq_complete() will be called inside
fscache_read(), in which erofs_fscache_put_subrequest() will be called
already.

> +			goto out;
> +		}
> +
> +		done += subreq->len;
> +	}
> +out:
> +	if (atomic_dec_and_test(&rreq->nr_outstanding))
> +		erofs_fscache_rreq_complete(rreq);
> +
> +	return ret;
> +}
BTW, could you please also help covert the original synchronous
erofs_fscache_read_folios() to calling erofs_fscache_read_folios_async()
to avoid code duplication?

> +
>  /*
>   * Read data from fscache and fill the read data into page cache described by
>   * @start/len, which shall be both aligned with PAGE_SIZE. @pstart describes
> @@ -163,15 +388,16 @@ static int erofs_fscache_readpage(struct file *file, struct page *page)
>  	return ret;
>  }
>  
> -static void erofs_fscache_unlock_folios(struct readahead_control *rac,
> -					size_t len)
> +static void erofs_fscache_readahead_folios(struct readahead_control *rac,
> +					size_t len, bool unlock)
>  {
>  	while (len) {
>  		struct folio *folio = readahead_folio(rac);
> -
>  		len -= folio_size(folio);
> -		folio_mark_uptodate(folio);
> -		folio_unlock(folio);
> +		if (unlock) {
> +			folio_mark_uptodate(folio);
> +			folio_unlock(folio);
> +		}
>  	}
>  }
>  
> @@ -193,6 +419,7 @@ static void erofs_fscache_readahead(struct readahead_control *rac)
>  	do {
>  		struct erofs_map_blocks map;
>  		struct erofs_map_dev mdev;
> +		struct netfs_io_request *rreq;
>  
>  		pos = start + done;
>  		map.m_la = pos;
> @@ -212,7 +439,7 @@ static void erofs_fscache_readahead(struct readahead_control *rac)
>  					offset, count);
>  			iov_iter_zero(count, &iter);
>  
> -			erofs_fscache_unlock_folios(rac, count);
> +			erofs_fscache_readahead_folios(rac, count, true);
>  			ret = count;
>  			continue;
>  		}
> @@ -238,13 +465,20 @@ static void erofs_fscache_readahead(struct readahead_control *rac)
>  		if (ret)
>  			return;
>  
> -		ret = erofs_fscache_read_folios(mdev.m_fscache->cookie,
> -				rac->mapping, offset, count,
> +		rreq = erofs_fscache_alloc_request(rac->mapping, offset, count);
> +		if (IS_ERR(rreq))
> +			return;
> +		/*
> +		 * Drop the ref of folios here. Unlock them in
> +		 * rreq_unlock_folios() when rreq complete.
> +		 */
> +		erofs_fscache_readahead_folios(rac, count, false);
> +		ret = erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
> +				rreq, offset, count,
>  				mdev.m_pa + (pos - map.m_la));
> -		if (!ret) {
> -			erofs_fscache_unlock_folios(rac, count);
> +
> +		if (!ret)
>  			ret = count;
> -		}
>  	} while (ret > 0 && ((done += ret) < len));
>  }
>  



-- 
Thanks,
Jeffle
