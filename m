Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C51E5F8487
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 11:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJHJGj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 05:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiJHJGg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 05:06:36 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9324E401;
        Sat,  8 Oct 2022 02:06:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VRc0d2._1665219991;
Received: from 30.221.130.66(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VRc0d2._1665219991)
          by smtp.aliyun-inc.com;
          Sat, 08 Oct 2022 17:06:32 +0800
Message-ID: <4fbf60f5-4ed1-3dd8-e4d3-de796e701956@linux.alibaba.com>
Date:   Sat, 8 Oct 2022 17:06:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [RFC PATCH 2/5] cachefiles: extract ondemand info field from
 cachefiles_object
Content-Language: en-US
To:     Jia Zhu <zhujia.zj@bytedance.com>, dhowells@redhat.com,
        xiang@kernel.org
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com
References: <20220818135204.49878-1-zhujia.zj@bytedance.com>
 <20220818135204.49878-3-zhujia.zj@bytedance.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220818135204.49878-3-zhujia.zj@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/18/22 9:52 PM, Jia Zhu wrote:

>  /*
>   * Backing file state.
>   */
> @@ -67,8 +73,7 @@ struct cachefiles_object {
>  	unsigned long			flags;
>  #define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
>  #ifdef CONFIG_CACHEFILES_ONDEMAND
> -	int				ondemand_id;
> -	enum cachefiles_object_state	state;
> +	void				*private;
>  #endif
>  };

Personally I would prefer

	struct cachefiles_object {
		...
	#ifdef CONFIG_CACHEFILES_ONDEMAND
		struct cachefiles_ondemand_info *private;
	#endif
	}

and

> @@ -88,6 +93,7 @@ void cachefiles_put_object(struct cachefiles_object
*object,
>  		ASSERTCMP(object->file, ==, NULL);
>
>  		kfree(object->d_name);
> + #ifdef CONFIG_CACHEFILES_ONDEMAND
> +		kfree(object->private);
> + #endif
>
>  		cache = object->volume->cache->cache;
>  		fscache_put_cookie(object->cookie,

so that we can get rid of CACHEFILES_ONDEMAND_OBJINFO() stuff, to make
the code more readable.



-- 
Thanks,
Jingbo
