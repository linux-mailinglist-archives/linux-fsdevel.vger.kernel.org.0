Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9555F5FD2E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Oct 2022 03:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJMBrU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Oct 2022 21:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJMBrT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Oct 2022 21:47:19 -0400
Received: from out199-12.us.a.mail.aliyun.com (out199-12.us.a.mail.aliyun.com [47.90.199.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51416112ABF;
        Wed, 12 Oct 2022 18:47:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VS1VlX2_1665625631;
Received: from 30.221.130.192(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VS1VlX2_1665625631)
          by smtp.aliyun-inc.com;
          Thu, 13 Oct 2022 09:47:12 +0800
Message-ID: <3051133b-1408-2ccb-b22f-e5ee990bdc4f@linux.alibaba.com>
Date:   Thu, 13 Oct 2022 09:47:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [External] Re: [PATCH 3/5] cachefiles: resend an open request if
 the read request's object is closed
Content-Language: en-US
To:     Jia Zhu <zhujia.zj@bytedance.com>, dhowells@redhat.com,
        xiang@kernel.org
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com
References: <20221011131552.23833-1-zhujia.zj@bytedance.com>
 <20221011131552.23833-4-zhujia.zj@bytedance.com>
 <28d64f00-e408-9fc2-9506-63c1d8b08b9c@linux.alibaba.com>
 <c6f5d729-2083-817d-fe7d-b01bce27e39f@bytedance.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <c6f5d729-2083-817d-fe7d-b01bce27e39f@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/12/22 11:37 PM, Jia Zhu wrote:
> 
> 
> 在 2022/10/12 15:53, JeffleXu 写道:
>>
>>
>> On 10/11/22 9:15 PM, Jia Zhu wrote:
>>> @@ -254,12 +282,18 @@ ssize_t cachefiles_ondemand_daemon_read(struct
>>> cachefiles_cache *cache,
>>>        * request distribution fair.
>>>        */
>>>       xa_lock(&cache->reqs);
>>> -    req = xas_find_marked(&xas, UINT_MAX, CACHEFILES_REQ_NEW);
>>> -    if (!req && cache->req_id_next > 0) {
>>> -        xas_set(&xas, 0);
>>> -        req = xas_find_marked(&xas, cache->req_id_next - 1,
>>> CACHEFILES_REQ_NEW);
>>> +retry:
>>> +    xas_for_each_marked(&xas, req, xa_max, CACHEFILES_REQ_NEW) {
>>> +        if (cachefiles_ondemand_skip_req(req))
>>> +            continue;
>>> +        break;
>>>       }
>>>       if (!req) {
>>> +        if (cache->req_id_next > 0 && xa_max == ULONG_MAX) {
>>> +            xas_set(&xas, 0);
>>> +            xa_max = cache->req_id_next - 1;
>>> +            goto retry;
>>> +        }
>>
>> I would suggest abstracting the "xas_for_each_marked(...,
>> CACHEFILES_REQ_NEW)" part into a helper function to avoid the "goto
>> retry".
>>
> Hi JingBo,
> 
> Thanks for your advice. Are the following revises appropriate？
> 
> static struct cachefiles_req *cachefiles_ondemand_select_req(struct
> xa_state *xas, unsigned long xa_max)
> {
>     struct cachefiles_req *req;
>     struct cachefiles_ondemand_info *info;
> 
>     xas_for_each_marked(xas, req, xa_max, CACHEFILES_REQ_NEW) {
>         if (!req || req->msg.opcode != CACHEFILES_OP_READ)

xas_for_each_marked() will guarantee that @req won't be NULL, and thus
the NULL check here in unnecessary. Otherwise LGTM.

>             return req;
>         info = req->object->private;
>         if (info->state == CACHEFILES_ONDEMAND_OBJSTATE_close) {
>             cachefiles_ondemand_set_object_reopening(req->object);
>             queue_work(fscache_wq, &info->work);
>             continue;
>         } else if (info->state == CACHEFILES_ONDEMAND_OBJSTATE_reopening) {
>             continue;
>         }
>         return req;
>     }
>     return NULL;
> }
> 
> ...
> 
>  xa_lock(&cache->reqs);
>     req = cachefiles_ondemand_select_req(&xas, ULONG_MAX);
>     if (!req && cache->req_id_next > 0) {
>         xas_set(&xas, 0);
>         req = cachefiles_ondemand_select_req(&xas, cache->req_id_next - 1);
>     }
>     if (!req) {
>         xa_unlock(&cache->reqs);
>         return 0;
>     }
>>


-- 
Thanks,
Jingbo
