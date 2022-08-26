Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52265A1DFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 03:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244040AbiHZBLm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 21:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243910AbiHZBLj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 21:11:39 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB28FC6CC1;
        Thu, 25 Aug 2022 18:11:37 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MDMFG0RkJzGprF;
        Fri, 26 Aug 2022 09:09:54 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 09:11:35 +0800
Received: from [10.174.178.31] (10.174.178.31) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 09:11:34 +0800
Subject: Re: [Linux-cachefs] [PATCH v3] cachefiles: fix error return code in
 cachefiles_ondemand_copen()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-cachefs@redhat.com>, <linux-fsdevel@vger.kernel.org>
References: <20220818125038.2247720-1-sunke32@huawei.com>
 <3700079.1661336363@warthog.procyon.org.uk>
 <c6fd70dd-2b0b-ea9f-f0f8-9d727cde2718@linux.alibaba.com>
 <20220825133620.GB2071@kadam> <YweAGTuBw1hWm8PW@B-P7TQMD6M-0146.local>
From:   Sun Ke <sunke32@huawei.com>
Message-ID: <a9e7f60a-61a6-bceb-2f5a-07438f7bb8e8@huawei.com>
Date:   Fri, 26 Aug 2022 09:11:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YweAGTuBw1hWm8PW@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.31]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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



在 2022/8/25 21:58, Gao Xiang 写道:
> On Thu, Aug 25, 2022 at 04:36:20PM +0300, Dan Carpenter wrote:
>> I spent a long time looking at this as well...  It's really inscrutable
>> code.  It would be more readable if we just spelled things out in the
>> most pedantic way possible:
>>
> 
> Yeah, the following code looks much better. Ke, would you mind
> sending a version like below instead?

OK, I will update it.
> 
> Thanks,
> Gao Xiang
> 
>> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
>> index 1fee702d5529..7e1586bd5cf3 100644
>> --- a/fs/cachefiles/ondemand.c
>> +++ b/fs/cachefiles/ondemand.c
>> @@ -158,9 +158,13 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>>   
>>   	/* fail OPEN request if daemon reports an error */
>>   	if (size < 0) {
>> -		if (!IS_ERR_VALUE(size))
>> -			size = -EINVAL;
>> -		req->error = size;
>> +		if (!IS_ERR_VALUE(size)) {
>> +			req->error = -EINVAL;
>> +			ret = -EINVAL;
>> +		} else {
>> +			req->error = size;
>> +			ret = 0;
>> +		}
>>   		goto out;
>>   	}
>>   
>>
>> --
>> Linux-cachefs mailing list
>> Linux-cachefs@redhat.com
>> https://listman.redhat.com/mailman/listinfo/linux-cachefs
> .
> 
