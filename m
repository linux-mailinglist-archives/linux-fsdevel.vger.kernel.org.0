Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36108596A1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 09:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiHQHOK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 03:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiHQHOJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:14:09 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73F23ECE9
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 00:14:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VMUXCj0_1660720441;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VMUXCj0_1660720441)
          by smtp.aliyun-inc.com;
          Wed, 17 Aug 2022 15:14:03 +0800
Date:   Wed, 17 Aug 2022 15:14:01 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Xin Yin <yinxin.x@bytedance.com>
Cc:     dhowells@redhat.com, xiang@kernel.org, jefflexu@linux.alibaba.com,
        linux-fsdevel@vger.kernel.org, zhujia.zj@bytedance.com,
        linux-cachefs@redhat.com, Yongqing Li <liyongqing@bytedance.com>
Subject: Re: [Linux-cachefs] [PATCH] cachefiles: make on-demand request
 distribution fairer
Message-ID: <YvyVOfzkITlvgtQ6@B-P7TQMD6M-0146.local>
Mail-Followup-To: Xin Yin <yinxin.x@bytedance.com>, dhowells@redhat.com,
        xiang@kernel.org, jefflexu@linux.alibaba.com,
        linux-fsdevel@vger.kernel.org, zhujia.zj@bytedance.com,
        linux-cachefs@redhat.com, Yongqing Li <liyongqing@bytedance.com>
References: <20220817065200.11543-1-yinxin.x@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220817065200.11543-1-yinxin.x@bytedance.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Yin,

On Wed, Aug 17, 2022 at 02:52:00PM +0800, Xin Yin wrote:
> For now, enqueuing and dequeuing on-demand requests all start from
> idx 0, this makes request distribution unfair. In the weighty
> concurrent I/O scenario, the request stored in higher idx will starve.
> 
> Searching requests cyclically in cachefiles_ondemand_daemon_read,
> makes distribution fairer.

Yeah, thanks for the catch.  The previous approach could cause somewhat
unfairness and make some requests starving... But we don't need strict
FIFO here.

> 
> Reported-by: Yongqing Li <liyongqing@bytedance.com>
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> ---
>  fs/cachefiles/internal.h |  1 +
>  fs/cachefiles/ondemand.c | 12 +++++++++---
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
> index 6cba2c6de2f9..2ad58c465208 100644
> --- a/fs/cachefiles/internal.h
> +++ b/fs/cachefiles/internal.h
> @@ -111,6 +111,7 @@ struct cachefiles_cache {
>  	char				*tag;		/* cache binding tag */
>  	refcount_t			unbind_pincount;/* refcount to do daemon unbind */
>  	struct xarray			reqs;		/* xarray of pending on-demand requests */
> +	unsigned long			req_id_next;

	unsigned long			ondemand_req_id_next; ?

Otherwise it looks good to me,

Thanks,
Gao Xiang

>  	struct xarray			ondemand_ids;	/* xarray for ondemand_id allocation */
>  	u32				ondemand_id_next;
>  };
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 1fee702d5529..247961d65369 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -238,14 +238,19 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  	unsigned long id = 0;
>  	size_t n;
>  	int ret = 0;
> -	XA_STATE(xas, &cache->reqs, 0);
> +	XA_STATE(xas, &cache->reqs, cache->req_id_next);
>  
>  	/*
> -	 * Search for a request that has not ever been processed, to prevent
> -	 * requests from being processed repeatedly.
> +	 * Cyclically search for a request that has not ever been processed,
> +	 * to prevent requests from being processed repeatedly, and make
> +	 * request distribution fair.
>  	 */
>  	xa_lock(&cache->reqs);
>  	req = xas_find_marked(&xas, UINT_MAX, CACHEFILES_REQ_NEW);
> +	if (!req && cache->req_id_next > 0) {
> +		xas_set(&xas, 0);
> +		req = xas_find_marked(&xas, cache->req_id_next - 1, CACHEFILES_REQ_NEW);
> +	}
>  	if (!req) {
>  		xa_unlock(&cache->reqs);
>  		return 0;
> @@ -260,6 +265,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  	}
>  
>  	xas_clear_mark(&xas, CACHEFILES_REQ_NEW);
> +	cache->req_id_next = xas.xa_index + 1;
>  	xa_unlock(&cache->reqs);
>  
>  	id = xas.xa_index;
> -- 
> 2.25.1
> 
> --
> Linux-cachefs mailing list
> Linux-cachefs@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-cachefs
