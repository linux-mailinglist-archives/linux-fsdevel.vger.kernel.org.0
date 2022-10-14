Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A2E5FE8DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 08:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJNGbi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 02:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJNGbh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:31:37 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F36C32B9D;
        Thu, 13 Oct 2022 23:31:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VS6WuA7_1665729090;
Received: from 30.221.130.30(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VS6WuA7_1665729090)
          by smtp.aliyun-inc.com;
          Fri, 14 Oct 2022 14:31:32 +0800
Message-ID: <5ca5d4bd-63b4-12e9-39cd-7580958980db@linux.alibaba.com>
Date:   Fri, 14 Oct 2022 14:31:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH V2 3/5] cachefiles: resend an open request if the read
 request's object is closed
Content-Language: en-US
To:     Jia Zhu <zhujia.zj@bytedance.com>, dhowells@redhat.com,
        xiang@kernel.org
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com
References: <20221014030745.25748-1-zhujia.zj@bytedance.com>
 <20221014030745.25748-4-zhujia.zj@bytedance.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20221014030745.25748-4-zhujia.zj@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/14/22 11:07 AM, Jia Zhu wrote:

> +/*
> + * Reopen the closed object with associated read request.

I think "Reopen the closed object if there's any inflight or subsequent
READ request on this object" would be better?

> + * Skip read requests whose related object are reopening.
					       ^
					      is ?


> @@ -277,14 +308,18 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  	xa_unlock(&cache->reqs);
>  
>  	id = xas.xa_index;
> -	msg->msg_id = id;
>  
>  	if (msg->opcode == CACHEFILES_OP_OPEN) {
>  		ret = cachefiles_ondemand_get_fd(req);
> -		if (ret)
> +		if (ret) {
> +			cachefiles_ondemand_set_object_close(req->object);
>  			goto error;
> +		}
>  	}
>  
> +	msg->msg_id = id;
> +	msg->object_id = req->object->private->ondemand_id;

Since currently msg->object_id is always assigned in
cachefiles_ondemand_daemon_read(), we can remove the assignment in
cachefiles_ondemand_get_fd().


Otherwise LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jingbo
