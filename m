Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61AA5A26DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 13:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244975AbiHZLcG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 07:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiHZLcF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 07:32:05 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECD9C6943;
        Fri, 26 Aug 2022 04:32:02 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VNIv.gp_1661513519;
Received: from 192.168.31.65(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VNIv.gp_1661513519)
          by smtp.aliyun-inc.com;
          Fri, 26 Aug 2022 19:32:00 +0800
Message-ID: <10116646-a12b-05b2-5364-17e078649fab@linux.alibaba.com>
Date:   Fri, 26 Aug 2022 19:31:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v4] cachefiles: fix error return code in
 cachefiles_ondemand_copen()
Content-Language: en-US
To:     Sun Ke <sunke32@huawei.com>, dhowells@redhat.com
Cc:     linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dan.carpenter@oracle.com, hsiangkao@linux.alibaba.com
References: <20220826023515.3437469-1-sunke32@huawei.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220826023515.3437469-1-sunke32@huawei.com>
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



On 8/26/22 10:35 AM, Sun Ke wrote:
> The cache_size field of copen is specified by the user daemon.
> If cache_size < 0, then the OPEN request is expected to fail,
> while copen itself shall succeed. However, returning 0 is indeed
> unexpected when cache_size is an invalid error code.
> 
> Fix this by returning error when cache_size is an invalid error code.
> 
> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> Suggested-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Thanks Sun. Also thanks Dan for the suggestion.


Jingbo Xu

> ---
> v4: update the code suggested by Dan
> v3: update the commit log suggested by Jingbo.
>  fs/cachefiles/ondemand.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 1fee702d5529..7e1586bd5cf3 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -158,9 +158,13 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>  
>  	/* fail OPEN request if daemon reports an error */
>  	if (size < 0) {
> -		if (!IS_ERR_VALUE(size))
> -			size = -EINVAL;
> -		req->error = size;
> +		if (!IS_ERR_VALUE(size)) {
> +			req->error = -EINVAL;
> +			ret = -EINVAL;
> +		} else {
> +			req->error = size;
> +			ret = 0;
> +		}
>  		goto out;
>  	}
>  

-- 
Thanks,
Jingbo
