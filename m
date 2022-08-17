Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D7E596E47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 14:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239035AbiHQMQA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 08:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbiHQMP7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:15:59 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E6C861F1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 05:15:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VMVTaVT_1660738553;
Received: from 30.227.73.176(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VMVTaVT_1660738553)
          by smtp.aliyun-inc.com;
          Wed, 17 Aug 2022 20:15:54 +0800
Message-ID: <107223ba-f125-9a09-758d-893bf33b629f@linux.alibaba.com>
Date:   Wed, 17 Aug 2022 20:15:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH] cachefiles: make on-demand request distribution fairer
Content-Language: en-US
To:     Xin Yin <yinxin.x@bytedance.com>, dhowells@redhat.com,
        xiang@kernel.org
Cc:     linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        zhujia.zj@bytedance.com, Yongqing Li <liyongqing@bytedance.com>
References: <20220817065200.11543-1-yinxin.x@bytedance.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220817065200.11543-1-yinxin.x@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/17/22 2:52 PM, Xin Yin wrote:
> For now, enqueuing and dequeuing on-demand requests all start from
> idx 0, this makes request distribution unfair. In the weighty
> concurrent I/O scenario, the request stored in higher idx will starve.
> 
> Searching requests cyclically in cachefiles_ondemand_daemon_read,
> makes distribution fairer.
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
> +		xas_set(&xas, 0);> +		req = xas_find_marked(&xas, cache->req_id_next - 1,
CACHEFILES_REQ_NEW);


LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

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

-- 
Thanks,
Jingbo
