Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521094EA7B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 08:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbiC2GQW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 02:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbiC2GQV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 02:16:21 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF354247C33;
        Mon, 28 Mar 2022 23:14:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V8XENYr_1648534472;
Received: from 30.225.24.46(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V8XENYr_1648534472)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 29 Mar 2022 14:14:34 +0800
Message-ID: <597372bf-06dc-defa-0628-a1c140235c1e@linux.alibaba.com>
Date:   Tue, 29 Mar 2022 14:14:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [Linux-cachefs] [PATCH v6 03/22] cachefiles: notify user daemon
 with anon_fd when looking up cookie
Content-Language: en-US
From:   JeffleXu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     gregkh@linuxfoundation.org, fannaihao@baidu.com,
        tao.peng@linux.alibaba.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, tianzichen@kuaishou.com,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
        eguan@linux.alibaba.com, gerry@linux.alibaba.com,
        torvalds@linux-foundation.org
References: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
 <20220325122223.102958-4-jefflexu@linux.alibaba.com>
In-Reply-To: <20220325122223.102958-4-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/25/22 8:22 PM, Jeffle Xu wrote:

> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
> index e80673d0ab97..8a0f1b691aca 100644
> --- a/fs/cachefiles/internal.h
> +++ b/fs/cachefiles/internal.h
> @@ -15,6 +15,8 @@
>  
> +/*
> + * ondemand.c
> + */
> +#ifdef CONFIG_CACHEFILES_ONDEMAND
> +extern ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
> +					       char __user *_buffer,
> +					       size_t buflen);
> +
> +extern int cachefiles_ondemand_cinit(struct cachefiles_cache *cache,
> +				     char *args);
> +
> +extern int cachefiles_ondemand_init_object(struct cachefiles_object *object);
> +
> +#else

> +ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
> +					char __user *_buffer, size_t buflen)

Needs to be declared as static inline ...

> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int cachefiles_ondemand_init_object(struct cachefiles_object *object)
> +{
> +	return 0;
> +}
> +#endif


-- 
Thanks,
Jeffle
