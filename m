Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B379159823B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 13:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244419AbiHRL2J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 07:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiHRL2F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 07:28:05 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2AF5E337;
        Thu, 18 Aug 2022 04:28:02 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4M7jJM30FDzGpc5;
        Thu, 18 Aug 2022 19:26:27 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 19:28:00 +0800
Received: from [10.174.178.31] (10.174.178.31) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 19:28:00 +0800
Subject: Re: [v2] cachefiles: fix error return code in
 cachefiles_ondemand_copen()
To:     JeffleXu <jefflexu@linux.alibaba.com>, <dhowells@redhat.com>
CC:     <linux-cachefs@redhat.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20220818111935.1683062-1-sunke32@huawei.com>
 <e4e18421-7820-f1e3-6762-5959c2bd7ea4@linux.alibaba.com>
From:   Sun Ke <sunke32@huawei.com>
Message-ID: <adf4b4c2-75a2-705d-8870-df130fb583fb@huawei.com>
Date:   Thu, 18 Aug 2022 19:27:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <e4e18421-7820-f1e3-6762-5959c2bd7ea4@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.31]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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



在 2022/8/18 19:14, JeffleXu 写道:
> 
> 
> On 8/18/22 7:19 PM, Sun Ke wrote:
>> If size < 0; open request will fail, but cachefiles_ondemand_copen return 0.
>> Fix to return a negative error code.
> 
> Could you please also update the commit log?

The cache_size field of copen is specified by the user daemon. If 
cache_size < 0, then the OPEN request is expected to fail, while copen 
itself shall succeed. However, return 0 is indeed unexpected when 
cache_size is an invalid error code.
Fix to return a negative error code.

right?
> 
> Otherwise LGTM.
> 
> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> 
> 
> BTW, also cc linux-fsdevel@vger.kernel.org
> 
>>
>> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>> ---
>>   fs/cachefiles/ondemand.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
>> index 1fee702d5529..ea8a1e8317d9 100644
>> --- a/fs/cachefiles/ondemand.c
>> +++ b/fs/cachefiles/ondemand.c
>> @@ -159,7 +159,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>>   	/* fail OPEN request if daemon reports an error */
>>   	if (size < 0) {
>>   		if (!IS_ERR_VALUE(size))
>> -			size = -EINVAL;
>> +			ret = size = -EINVAL;
>>   		req->error = size;
>>   		goto out;
>>   	}
> 
