Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C234D50FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 18:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238694AbiCJR4y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 12:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbiCJR4x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:56:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384A915DB17;
        Thu, 10 Mar 2022 09:55:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9A2BB82794;
        Thu, 10 Mar 2022 17:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276EFC340E8;
        Thu, 10 Mar 2022 17:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646934947;
        bh=8SokjuteknyPbDBElq0ySc4jhTHmTXxe/n+HWRjmBwI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TGC/PkBY+FjkX5N95DtfOHkkJzsvQ6RMc6hOqr1z8tvukharUP+1rAZR/ZggQLqc3
         N311M6elMSdFX5NADEPONwbt75bxhup2j9x60tG8G6V0KYFH/6xiryBca8lJEtVzn2
         1ywT8GT1zqNvbfMQPMiPmCkhSkxisxLoRg3gj5N6pYuQ0ypLPsviIT2iE1DzGpIrKx
         pWep7J4u53tUNMQp6c14DqgQMqB3Wi/UnYirc8Ij3VNlr0OOYBohToxaR13G0hs2kz
         T+XmBsA3DUPA+DuO6mlQMMAUD+nN8buPap9+TMqHD+SCxH1QvtEYSd7k+DmcvloIwN
         lEwhuk9FrI3gw==
Message-ID: <53541fbe950ac4a767e25177ba686b8fbbf371d4.camel@kernel.org>
Subject: Re: [PATCH v3 14/20] netfs: Add a function to consolidate beginning
 a read
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 10 Mar 2022 12:55:44 -0500
In-Reply-To: <164692911113.2099075.1060868473229451371.stgit@warthog.procyon.org.uk>
References: <164692883658.2099075.5745824552116419504.stgit@warthog.procyon.org.uk>
         <164692911113.2099075.1060868473229451371.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-03-10 at 16:18 +0000, David Howells wrote:
> Add a function to do the steps needed to begin a read request, allowing
> this code to be removed from several other functions and consolidated.
> 
> Changes
> =======
> ver #2)
>  - Move before the unstaticking patch so that some functions can be left
>    static.
>  - Set uninitialised return code in netfs_begin_read()[1][2].
>  - Fixed a refleak caused by non-removal of a get from netfs_write_begin()
>    when the request submission code got moved to netfs_begin_read().
>  - Use INIT_WORK() to (re-)init the request work_struct[3].
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-cachefs@redhat.com
> Link: https://lore.kernel.org/r/20220303163826.1120936-1-nathan@kernel.org/ [1]
> Link: https://lore.kernel.org/r/20220303235647.1297171-1-colin.i.king@gmail.com/ [2]
> Link: https://lore.kernel.org/r/9d69be49081bccff44260e4c6e0049c63d6d04a1.camel@redhat.com/ [3]
> Link: https://lore.kernel.org/r/164623004355.3564931.7275693529042495641.stgit@warthog.procyon.org.uk/ # v1
> Link: https://lore.kernel.org/r/164678214287.1200972.16734134007649832160.stgit@warthog.procyon.org.uk/ # v2
> ---
> 
>  fs/netfs/internal.h          |    2 -
>  fs/netfs/objects.c           |    1 
>  fs/netfs/read_helper.c       |  144 +++++++++++++++++++++---------------------
>  include/trace/events/netfs.h |    5 +
>  4 files changed, 76 insertions(+), 76 deletions(-)
> 
> diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
> index 5f9719409f21..937c2465943f 100644
> --- a/fs/netfs/internal.h
> +++ b/fs/netfs/internal.h
> @@ -39,7 +39,7 @@ static inline void netfs_see_request(struct netfs_io_request *rreq,
>   */
>  extern unsigned int netfs_debug;
>  
> -void netfs_rreq_work(struct work_struct *work);
> +int netfs_begin_read(struct netfs_io_request *rreq, bool sync);
>  
>  /*
>   * stats.c
> diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
> index 657b19e60118..e86107b30ba4 100644
> --- a/fs/netfs/objects.c
> +++ b/fs/netfs/objects.c
> @@ -35,7 +35,6 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
>  	rreq->i_size	= i_size_read(inode);
>  	rreq->debug_id	= atomic_inc_return(&debug_ids);
>  	INIT_LIST_HEAD(&rreq->subrequests);
> -	INIT_WORK(&rreq->work, netfs_rreq_work);
>  	refcount_set(&rreq->ref, 1);
>  	__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
>  	if (rreq->netfs_ops->init_request) {
> diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
> index 73be06c409bb..6864716cfcac 100644
> --- a/fs/netfs/read_helper.c
> +++ b/fs/netfs/read_helper.c
> @@ -443,7 +443,7 @@ static void netfs_rreq_assess(struct netfs_io_request *rreq, bool was_async)
>  	netfs_rreq_completed(rreq, was_async);
>  }
>  
> -void netfs_rreq_work(struct work_struct *work)
> +static void netfs_rreq_work(struct work_struct *work)
>  {
>  	struct netfs_io_request *rreq =
>  		container_of(work, struct netfs_io_request, work);
> @@ -688,6 +688,69 @@ static bool netfs_rreq_submit_slice(struct netfs_io_request *rreq,
>  	return false;
>  }
>  
> +/*
> + * Begin the process of reading in a chunk of data, where that data may be
> + * stitched together from multiple sources, including multiple servers and the
> + * local cache.
> + */
> +int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
> +{
> +	unsigned int debug_index = 0;
> +	int ret;
> +
> +	_enter("R=%x %llx-%llx",
> +	       rreq->debug_id, rreq->start, rreq->start + rreq->len - 1);
> +
> +	if (rreq->len == 0) {
> +		pr_err("Zero-sized read [R=%x]\n", rreq->debug_id);
> +		netfs_put_request(rreq, false, netfs_rreq_trace_put_zero_len);
> +		return -EIO;
> +	}
> +
> +	INIT_WORK(&rreq->work, netfs_rreq_work);
> +
> +	if (sync)
> +		netfs_get_request(rreq, netfs_rreq_trace_get_hold);
> +
> +	/* Chop the read into slices according to what the cache and the netfs
> +	 * want and submit each one.
> +	 */
> +	atomic_set(&rreq->nr_outstanding, 1);
> +	do {
> +		if (!netfs_rreq_submit_slice(rreq, &debug_index))
> +			break;
> +
> +	} while (rreq->submitted < rreq->len);
> +
> +	if (sync) {
> +		/* Keep nr_outstanding incremented so that the ref always belongs to
> +		 * us, and the service code isn't punted off to a random thread pool to
> +		 * process.
> +		 */
> +		for (;;) {
> +			wait_var_event(&rreq->nr_outstanding,
> +				       atomic_read(&rreq->nr_outstanding) == 1);
> +			netfs_rreq_assess(rreq, false);
> +			if (!test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags))
> +				break;
> +			cond_resched();
> +		}
> +
> +		ret = rreq->error;
> +		if (ret == 0 && rreq->submitted < rreq->len) {
> +			trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_read);
> +			ret = -EIO;
> +		}
> +		netfs_put_request(rreq, false, netfs_rreq_trace_put_hold);
> +	} else {
> +		/* If we decrement nr_outstanding to 0, the ref belongs to us. */
> +		if (atomic_dec_and_test(&rreq->nr_outstanding))
> +			netfs_rreq_assess(rreq, false);
> +		ret = 0;
> +	}
> +	return ret;
> +}
> +
>  static void netfs_cache_expand_readahead(struct netfs_io_request *rreq,
>  					 loff_t *_start, size_t *_len, loff_t i_size)
>  {
> @@ -750,7 +813,6 @@ void netfs_readahead(struct readahead_control *ractl)
>  {
>  	struct netfs_io_request *rreq;
>  	struct netfs_i_context *ctx = netfs_i_context(ractl->mapping->host);
> -	unsigned int debug_index = 0;
>  	int ret;
>  
>  	_enter("%lx,%x", readahead_index(ractl), readahead_count(ractl));
> @@ -777,22 +839,13 @@ void netfs_readahead(struct readahead_control *ractl)
>  
>  	netfs_rreq_expand(rreq, ractl);
>  
> -	atomic_set(&rreq->nr_outstanding, 1);
> -	do {
> -		if (!netfs_rreq_submit_slice(rreq, &debug_index))
> -			break;
> -
> -	} while (rreq->submitted < rreq->len);
> -
>  	/* Drop the refs on the folios here rather than in the cache or
>  	 * filesystem.  The locks will be dropped in netfs_rreq_unlock().
>  	 */
>  	while (readahead_folio(ractl))
>  		;
>  
> -	/* If we decrement nr_outstanding to 0, the ref belongs to us. */
> -	if (atomic_dec_and_test(&rreq->nr_outstanding))
> -		netfs_rreq_assess(rreq, false);
> +	netfs_begin_read(rreq, false);
>  	return;
>  
>  cleanup_free:
> @@ -821,7 +874,6 @@ int netfs_readpage(struct file *file, struct page *subpage)
>  	struct address_space *mapping = folio->mapping;
>  	struct netfs_io_request *rreq;
>  	struct netfs_i_context *ctx = netfs_i_context(mapping->host);
> -	unsigned int debug_index = 0;
>  	int ret;
>  
>  	_enter("%lx", folio_index(folio));
> @@ -836,42 +888,16 @@ int netfs_readpage(struct file *file, struct page *subpage)
>  
>  	if (ctx->ops->begin_cache_operation) {
>  		ret = ctx->ops->begin_cache_operation(rreq);
> -		if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS) {
> -			folio_unlock(folio);
> -			goto out;
> -		}
> +		if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS)
> +			goto discard;
>  	}
>  
>  	netfs_stat(&netfs_n_rh_readpage);
>  	trace_netfs_read(rreq, rreq->start, rreq->len, netfs_read_trace_readpage);
> +	return netfs_begin_read(rreq, true);
>  
> -	netfs_get_request(rreq, netfs_rreq_trace_get_hold);
> -
> -	atomic_set(&rreq->nr_outstanding, 1);
> -	do {
> -		if (!netfs_rreq_submit_slice(rreq, &debug_index))
> -			break;
> -
> -	} while (rreq->submitted < rreq->len);
> -
> -	/* Keep nr_outstanding incremented so that the ref always belongs to us, and
> -	 * the service code isn't punted off to a random thread pool to
> -	 * process.
> -	 */
> -	do {
> -		wait_var_event(&rreq->nr_outstanding,
> -			       atomic_read(&rreq->nr_outstanding) == 1);
> -		netfs_rreq_assess(rreq, false);
> -	} while (test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags));
> -
> -	ret = rreq->error;
> -	if (ret == 0 && rreq->submitted < rreq->len) {
> -		trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_readpage);
> -		ret = -EIO;
> -	}
> -out:
> -	netfs_put_request(rreq, false, netfs_rreq_trace_put_hold);
> -	return ret;
> +discard:
> +	netfs_put_request(rreq, false, netfs_rreq_trace_put_discard);
>  alloc_error:
>  	folio_unlock(folio);
>  	return ret;
> @@ -966,7 +992,7 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
>  	struct netfs_io_request *rreq;
>  	struct netfs_i_context *ctx = netfs_i_context(file_inode(file ));
>  	struct folio *folio;
> -	unsigned int debug_index = 0, fgp_flags;
> +	unsigned int fgp_flags;
>  	pgoff_t index = pos >> PAGE_SHIFT;
>  	int ret;
>  
> @@ -1029,39 +1055,13 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
>  	 */
>  	ractl._nr_pages = folio_nr_pages(folio);
>  	netfs_rreq_expand(rreq, &ractl);
> -	netfs_get_request(rreq, netfs_rreq_trace_get_hold);
>  
>  	/* We hold the folio locks, so we can drop the references */
>  	folio_get(folio);
>  	while (readahead_folio(&ractl))
>  		;
>  
> -	atomic_set(&rreq->nr_outstanding, 1);
> -	do {
> -		if (!netfs_rreq_submit_slice(rreq, &debug_index))
> -			break;
> -
> -	} while (rreq->submitted < rreq->len);
> -
> -	/* Keep nr_outstanding incremented so that the ref always belongs to
> -	 * us, and the service code isn't punted off to a random thread pool to
> -	 * process.
> -	 */
> -	for (;;) {
> -		wait_var_event(&rreq->nr_outstanding,
> -			       atomic_read(&rreq->nr_outstanding) == 1);
> -		netfs_rreq_assess(rreq, false);
> -		if (!test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags))
> -			break;
> -		cond_resched();
> -	}
> -
> -	ret = rreq->error;
> -	if (ret == 0 && rreq->submitted < rreq->len) {
> -		trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_write_begin);
> -		ret = -EIO;
> -	}
> -	netfs_put_request(rreq, false, netfs_rreq_trace_put_hold);
> +	ret = netfs_begin_read(rreq, true);
>  	if (ret < 0)
>  		goto error;
>  
> diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
> index f00e3e1821c8..beec534cbaab 100644
> --- a/include/trace/events/netfs.h
> +++ b/include/trace/events/netfs.h
> @@ -56,17 +56,18 @@
>  	EM(netfs_fail_check_write_begin,	"check-write-begin")	\
>  	EM(netfs_fail_copy_to_cache,		"copy-to-cache")	\
>  	EM(netfs_fail_read,			"read")			\
> -	EM(netfs_fail_short_readpage,		"short-readpage")	\
> -	EM(netfs_fail_short_write_begin,	"short-write-begin")	\
> +	EM(netfs_fail_short_read,		"short-read")		\
>  	E_(netfs_fail_prepare_write,		"prep-write")
>  
>  #define netfs_rreq_ref_traces					\
>  	EM(netfs_rreq_trace_get_hold,		"GET HOLD   ")	\
>  	EM(netfs_rreq_trace_get_subreq,		"GET SUBREQ ")	\
>  	EM(netfs_rreq_trace_put_complete,	"PUT COMPLT ")	\
> +	EM(netfs_rreq_trace_put_discard,	"PUT DISCARD")	\
>  	EM(netfs_rreq_trace_put_failed,		"PUT FAILED ")	\
>  	EM(netfs_rreq_trace_put_hold,		"PUT HOLD   ")	\
>  	EM(netfs_rreq_trace_put_subreq,		"PUT SUBREQ ")	\
> +	EM(netfs_rreq_trace_put_zero_len,	"PUT ZEROLEN")	\
>  	E_(netfs_rreq_trace_new,		"NEW        ")
>  
>  #define netfs_sreq_ref_traces					\
> 
> 

Reviewed-by: Jeff Layton <jlayton@kernel.org>
