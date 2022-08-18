Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6D5598303
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 14:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244582AbiHRMPr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 08:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244575AbiHRMPq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:15:46 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBE7A00C0;
        Thu, 18 Aug 2022 05:15:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VMal8Wq_1660824937;
Received: from 30.227.66.106(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VMal8Wq_1660824937)
          by smtp.aliyun-inc.com;
          Thu, 18 Aug 2022 20:15:38 +0800
Message-ID: <b98cb85c-cac2-9117-12fd-570d246b20d3@linux.alibaba.com>
Date:   Thu, 18 Aug 2022 20:15:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [v2] cachefiles: fix error return code in
 cachefiles_ondemand_copen()
Content-Language: en-US
To:     Sun Ke <sunke32@huawei.com>, dhowells@redhat.com
Cc:     linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20220818111935.1683062-1-sunke32@huawei.com>
 <e4e18421-7820-f1e3-6762-5959c2bd7ea4@linux.alibaba.com>
 <adf4b4c2-75a2-705d-8870-df130fb583fb@huawei.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <adf4b4c2-75a2-705d-8870-df130fb583fb@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/18/22 7:27 PM, Sun Ke wrote:
> 
> 
> 在 2022/8/18 19:14, JeffleXu 写道:
>>
>>
>> On 8/18/22 7:19 PM, Sun Ke wrote:
>>> If size < 0; open request will fail, but cachefiles_ondemand_copen
>>> return 0.
>>> Fix to return a negative error code.
>>
>> Could you please also update the commit log?
> 
> The cache_size field of copen is specified by the user daemon. If
> cache_size < 0, then the OPEN request is expected to fail, while copen
> itself shall succeed. However, return 0 is indeed unexpected when
				   ^
				returning

> cache_size is an invalid error code.

> Fix to return a negative error code.

Fix this by returning error when cache_size is an invalid error code.


>>
>> Otherwise LGTM.
>>
>> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>>
>>
>> BTW, also cc linux-fsdevel@vger.kernel.org
>>
>>>
>>> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking
>>> up cookie")
>>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>>> ---
>>>   fs/cachefiles/ondemand.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
>>> index 1fee702d5529..ea8a1e8317d9 100644
>>> --- a/fs/cachefiles/ondemand.c
>>> +++ b/fs/cachefiles/ondemand.c
>>> @@ -159,7 +159,7 @@ int cachefiles_ondemand_copen(struct
>>> cachefiles_cache *cache, char *args)
>>>       /* fail OPEN request if daemon reports an error */
>>>       if (size < 0) {
>>>           if (!IS_ERR_VALUE(size))
>>> -            size = -EINVAL;
>>> +            ret = size = -EINVAL;
>>>           req->error = size;
>>>           goto out;
>>>       }
>>

-- 
Thanks,
Jingbo
