Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D4C59819A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 12:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244134AbiHRKr1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 06:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbiHRKrY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 06:47:24 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFD7816BD;
        Thu, 18 Aug 2022 03:47:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VMabRlS_1660819636;
Received: from 30.227.66.106(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VMabRlS_1660819636)
          by smtp.aliyun-inc.com;
          Thu, 18 Aug 2022 18:47:17 +0800
Message-ID: <0cc3f6d6-ac89-05f6-23f3-68446a32d8b2@linux.alibaba.com>
Date:   Thu, 18 Aug 2022 18:47:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH] cachefiles: fix error return code in
 cachefiles_ondemand_copen()
Content-Language: en-US
To:     Sun Ke <sunke32@huawei.com>, dhowells@redhat.com
Cc:     linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20220818094939.1548183-1-sunke32@huawei.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220818094939.1548183-1-sunke32@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/18/22 5:49 PM, Sun Ke wrote:
> If size < 0; open request will fail, but cachefiles_ondemand_copen return 0.

Hi, this is a deliberate design. The cache_size field of copen is
specified by the user daemon. If cache_size < 0, then the OPEN request
is expected to fail, while copen itself shall succeed.

> Fix to return a negative error code.
> 
> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
>  fs/cachefiles/ondemand.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 1fee702d5529..a31d3ff0ce5f 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -161,6 +161,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>  		if (!IS_ERR_VALUE(size))
>  			size = -EINVAL;

However, it is indeed unexpected when cache_size is an invalid error
code. How about:

		if (!IS_ERR_VALUE(size))
-			size= -EINVAL;
+			ret = size = -EINVAL;
		req->error = size;
		goto out;
	}

>  		req->error = size;
> +		ret = -EINVAL;
>  		goto out;
>  	}
>  

-- 
Thanks,
Jingbo
