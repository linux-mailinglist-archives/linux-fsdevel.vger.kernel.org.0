Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2605A5981DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 13:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244236AbiHRLCy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 07:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243220AbiHRLCx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 07:02:53 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0D898D09;
        Thu, 18 Aug 2022 04:02:51 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4M7hlJ2JbxzGpc4;
        Thu, 18 Aug 2022 19:01:16 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 19:02:47 +0800
Received: from [10.174.178.31] (10.174.178.31) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 19:02:47 +0800
Subject: Re: [PATCH] cachefiles: fix error return code in
 cachefiles_ondemand_copen()
To:     JeffleXu <jefflexu@linux.alibaba.com>, <dhowells@redhat.com>
CC:     <linux-cachefs@redhat.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20220818094939.1548183-1-sunke32@huawei.com>
 <0cc3f6d6-ac89-05f6-23f3-68446a32d8b2@linux.alibaba.com>
From:   Sun Ke <sunke32@huawei.com>
Message-ID: <1ee8458c-9200-7ad8-8497-a142df2bbe0b@huawei.com>
Date:   Thu, 18 Aug 2022 19:02:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <0cc3f6d6-ac89-05f6-23f3-68446a32d8b2@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.31]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/8/18 18:47, JeffleXu 写道:
> 
> 
> On 8/18/22 5:49 PM, Sun Ke wrote:
>> If size < 0; open request will fail, but cachefiles_ondemand_copen return 0.
> 
> Hi, this is a deliberate design. The cache_size field of copen is
> specified by the user daemon. If cache_size < 0, then the OPEN request
> is expected to fail, while copen itself shall succeed.
> 
>> Fix to return a negative error code.
>>
>> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>> ---
>>   fs/cachefiles/ondemand.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
>> index 1fee702d5529..a31d3ff0ce5f 100644
>> --- a/fs/cachefiles/ondemand.c
>> +++ b/fs/cachefiles/ondemand.c
>> @@ -161,6 +161,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>>   		if (!IS_ERR_VALUE(size))
>>   			size = -EINVAL;
> 
> However, it is indeed unexpected when cache_size is an invalid error
> code. How about:
> 
> 		if (!IS_ERR_VALUE(size))
> -			size= -EINVAL;
> +			ret = size = -EINVAL;
> 		req->error = size;
> 		goto out;
> 	}

OK, I will send a v2 patch.

Thanks,
Sun Ke
> 
>>   		req->error = size;
>> +		ret = -EINVAL;
>>   		goto out;
>>   	}
>>   
> 
