Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498EC51E603
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 May 2022 11:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354899AbiEGJ3F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 May 2022 05:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384118AbiEGJ25 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 May 2022 05:28:57 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2176E3C4B8
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 May 2022 02:25:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VCW4ecF_1651915507;
Received: from 30.225.24.82(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VCW4ecF_1651915507)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 07 May 2022 17:25:08 +0800
Message-ID: <85cbe786-c701-a298-0fd3-77559fce1037@linux.alibaba.com>
Date:   Sat, 7 May 2022 17:25:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH] erofs: change to use asyncronous io for fscache
 readpage/readahead
Content-Language: en-US
To:     Xin Yin <yinxin.x@bytedance.com>, hsiangkao@linux.alibaba.com,
        dhowells@redhat.com
Cc:     linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
References: <20220507044809.16129-1-yinxin.x@bytedance.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220507044809.16129-1-yinxin.x@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Xin,

On 5/7/22 12:48 PM, Xin Yin wrote:
> Use asyncronous io to read data from fscache may greatly improve IO
> bandwidth for sequential buffer read scenario.
> 
> Change erofs_fscache_read_folios to erofs_fscache_read_folios_async,
> and read data from fscache asyncronously. Make .readpage()/.readahead()
> to use this new helper.
> 
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> ---
> changes from RFC:
> 1.rebase to fscache,erofs: fscache-based on-demand read semantics v10.
> 2.fix issues pointed out by Jeffle.
> 3.simplify parameters, add debug messages for erofs_fscache_read_folios_async.
> 4.also change .readpage() to use new helper to avoid code duplication.
> 
> I verified this patch introduces no regressions with tests in
> https://github.com/lostjeffle/demand-read-cachefilesd.
> ---
>  fs/erofs/fscache.c | 267 +++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 227 insertions(+), 40 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index a402d8f0a063..2606bf4145f8 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -5,57 +5,231 @@
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
> +	if (rreq->cache_resources.ops)
> +		rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
> +	kfree(rreq);
> +}
> +
> +static void erofs_fscache_put_request(struct netfs_io_request *rreq)
> +{
> +	if (refcount_dec_and_test(&rreq->ref))
> +		erofs_fscache_free_request(rreq);
> +}
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

Yeah, as suggested by Gao Xaing, we'd better fold this function in.
Besides, we could use "erofs_fscache_put_request(subreq->rreq)" instead
to avoid the definition of the local variable @rreq, so that the code
arrangement could be more compact :)

> +
> +static void erofs_fscache_put_subrequest(struct netfs_io_subrequest *subreq)
> +{
> +	if (refcount_dec_and_test(&subreq->ref))
> +		erofs_fscache_free_subrequest(subreq);
> +}
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
>  /*
>   * Read data from fscache and fill the read data into page cache described by
> - * @start/len, which shall be both aligned with PAGE_SIZE. @pstart describes
> + * @rreq, which shall be both aligned with PAGE_SIZE. @pstart describes
>   * the start physical address in the cache file.
>   */
> -static int erofs_fscache_read_folios(struct fscache_cookie *cookie,
> -				     struct address_space *mapping,
> -				     loff_t start, size_t len,
> +static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
> +				     struct netfs_io_request *rreq,
>  				     loff_t pstart)
>  {
>  	enum netfs_io_source source;
> -	struct netfs_io_request rreq = {};
> -	struct netfs_io_subrequest subreq = { .rreq = &rreq, };
> -	struct netfs_cache_resources *cres = &rreq.cache_resources;
> -	struct super_block *sb = mapping->host->i_sb;
> +	struct super_block *sb = rreq->mapping->host->i_sb;
> +	struct netfs_io_subrequest *subreq;
> +	struct netfs_cache_resources *cres;
	^
How about assigning "cres = &rreq->cache_resources" directly here?

>  	struct iov_iter iter;
> +	loff_t start = rreq->start;
> +	size_t len = rreq->len;
>  	size_t done = 0;
>  	int ret;
>  
> +	atomic_set(&rreq->nr_outstanding, 1);
> +
> +	cres = &rreq->cache_resources;
	^
As described, could be folded.


>  	ret = fscache_begin_read_operation(cres, cookie);
>  	if (ret)
> -		return ret;
> +		goto out;
>  
>  	while (done < len) {
> -		subreq.start = pstart + done;
> -		subreq.len = len - done;
> -		subreq.flags = 1 << NETFS_SREQ_ONDEMAND;
> +		subreq = erofs_fscache_alloc_subrequest(rreq);
> +		if (!subreq) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		subreq->start = pstart + done;
> +		subreq->len	=  len - done;
> +		subreq->flags = 1 << NETFS_SREQ_ONDEMAND;
>  
> -		source = cres->ops->prepare_read(&subreq, LLONG_MAX);
> -		if (WARN_ON(subreq.len == 0))
> +		list_add_tail(&subreq->rreq_link, &rreq->subrequests);
> +
> +		source = cres->ops->prepare_read(subreq, LLONG_MAX);
> +		if (WARN_ON(subreq->len == 0))
>  			source = NETFS_INVALID_READ;
>  		if (source != NETFS_READ_FROM_CACHE) {
>  			erofs_err(sb, "failed to fscache prepare_read (source %d)",
>  				  source);
>  			ret = -EIO;
> +			subreq->error = ret;
> +			erofs_fscache_put_subrequest(subreq);
>  			goto out;
>  		}
>  
> -		iov_iter_xarray(&iter, READ, &mapping->i_pages,
> -				start + done, subreq.len);
> -		ret = fscache_read(cres, subreq.start, &iter,
> -				   NETFS_READ_HOLE_FAIL, NULL, NULL);
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
>  		if (ret) {
>  			erofs_err(sb, "failed to fscache_read (ret %d)", ret);
>  			goto out;
>  		}
>  
> -		done += subreq.len;
> +		done += subreq->len;
>  	}
>  out:
> -	fscache_end_operation(cres);
> +	if (atomic_dec_and_test(&rreq->nr_outstanding))
> +		erofs_fscache_rreq_complete(rreq);
> +
>  	return ret;
>  }
>  
> @@ -64,6 +238,7 @@ static int erofs_fscache_meta_readpage(struct file *data, struct page *page)
>  	int ret;
>  	struct folio *folio = page_folio(page);
>  	struct super_block *sb = folio_mapping(folio)->host->i_sb;
> +	struct netfs_io_request *rreq;
>  	struct erofs_map_dev mdev = {
>  		.m_deviceid = 0,
>  		.m_pa = folio_pos(folio),
> @@ -73,11 +248,13 @@ static int erofs_fscache_meta_readpage(struct file *data, struct page *page)
>  	if (ret)
>  		goto out;
>  
> -	ret = erofs_fscache_read_folios(mdev.m_fscache->cookie,
> -			folio_mapping(folio), folio_pos(folio),
> -			folio_size(folio), mdev.m_pa);
> -	if (!ret)
> -		folio_mark_uptodate(folio);
> +	rreq = erofs_fscache_alloc_request(folio_mapping(folio),
> +				folio_pos(folio), folio_size(folio));
> +	if (IS_ERR(rreq))
> +		goto out;
> +
> +	return erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
> +				rreq, mdev.m_pa);
>  out:
>  	folio_unlock(folio);
>  	return ret;
> @@ -117,6 +294,7 @@ static int erofs_fscache_readpage(struct file *file, struct page *page)
>  	struct super_block *sb = inode->i_sb;
>  	struct erofs_map_blocks map;
>  	struct erofs_map_dev mdev;
> +	struct netfs_io_request *rreq;
>  	erofs_off_t pos;
>  	loff_t pstart;
>  	int ret;
> @@ -149,10 +327,15 @@ static int erofs_fscache_readpage(struct file *file, struct page *page)
>  	if (ret)
>  		goto out_unlock;
>  
> +
> +	rreq = erofs_fscache_alloc_request(folio_mapping(folio),
> +				folio_pos(folio), folio_size(folio));
> +	if (IS_ERR(rreq))
> +		goto out_unlock;
> +
>  	pstart = mdev.m_pa + (pos - map.m_la);
> -	ret = erofs_fscache_read_folios(mdev.m_fscache->cookie,
> -			folio_mapping(folio), folio_pos(folio),
> -			folio_size(folio), pstart);
> +	return erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
> +				rreq, pstart);
>  
>  out_uptodate:
>  	if (!ret)
> @@ -162,15 +345,16 @@ static int erofs_fscache_readpage(struct file *file, struct page *page)
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

How about renaming this function into "erofs_fscache_advance_folios"?
Since people may misunderstand that erofs_fscache_readahead_folios() is
the main body of .readahead().

>  
> @@ -192,6 +376,7 @@ static void erofs_fscache_readahead(struct readahead_control *rac)
>  	do {
>  		struct erofs_map_blocks map;
>  		struct erofs_map_dev mdev;
> +		struct netfs_io_request *rreq;
>  
>  		pos = start + done;
>  		map.m_la = pos;
> @@ -211,7 +396,7 @@ static void erofs_fscache_readahead(struct readahead_control *rac)
>  					offset, count);
>  			iov_iter_zero(count, &iter);
>  
> -			erofs_fscache_unlock_folios(rac, count);
> +			erofs_fscache_readahead_folios(rac, count, true);
>  			ret = count;
>  			continue;
>  		}
> @@ -237,15 +422,17 @@ static void erofs_fscache_readahead(struct readahead_control *rac)
>  		if (ret)
>  			return;
>  
> -		ret = erofs_fscache_read_folios(mdev.m_fscache->cookie,
> -				rac->mapping, offset, count,
> -				mdev.m_pa + (pos - map.m_la));
> +		rreq = erofs_fscache_alloc_request(rac->mapping, offset, count);
> +		if (IS_ERR(rreq))
> +			return;
>  		/*
> -		 * For the error cases, the folios will be unlocked when
> -		 * .readahead() returns.
> +		 * Drop the ref of folios here. Unlock them in
> +		 * rreq_unlock_folios() when rreq complete.
>  		 */
> +		erofs_fscache_readahead_folios(rac, count, false);
> +		ret = erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
> +					rreq, mdev.m_pa + (pos - map.m_la));
>  		if (!ret) {
> -			erofs_fscache_unlock_folios(rac, count);
>  			ret = count;
>  		}
>  	} while (ret > 0 && ((done += ret) < len));

-- 
Thanks,
Jeffle
