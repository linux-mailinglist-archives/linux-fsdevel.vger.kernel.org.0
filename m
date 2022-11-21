Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93572631832
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 02:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiKUBin (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Nov 2022 20:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiKUBin (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Nov 2022 20:38:43 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5062CDC8;
        Sun, 20 Nov 2022 17:38:41 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NFqgp3vzCzqSYt;
        Mon, 21 Nov 2022 09:34:46 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 09:38:39 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 09:38:38 +0800
Subject: Re: [PATCH] fs: Clear a UBSAN shift-out-of-bounds warning
To:     Eric Biggers <ebiggers@kernel.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221110031024.204-1-thunder.leizhen@huawei.com>
 <Y3kw4IP2BVcbFoGT@sol.localdomain>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5dbf72b4-e596-8954-4d8d-1e92edf46b90@huawei.com>
Date:   Mon, 21 Nov 2022 09:38:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Y3kw4IP2BVcbFoGT@sol.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/11/20 3:39, Eric Biggers wrote:
> On Thu, Nov 10, 2022 at 11:10:24AM +0800, Zhen Lei wrote:
>> UBSAN: shift-out-of-bounds in fs/locks.c:2572:16
>> left shift of 1 by 63 places cannot be represented in type 'long long int'
>>
>> Switch the calculation method to ((quarter - 1) * 2 + 1) can help us
>> eliminate this false positive.
>>
>> On the other hand, the old implementation has problems with char and
>> short types, although not currently involved.
>> printf("%d: %x\n", sizeof(char),  INT_LIMIT(char));
>> printf("%d: %x\n", sizeof(short), INT_LIMIT(short));
>> 1: ffffff7f
>> 2: ffff7fff
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  include/linux/fs.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index e654435f16512c1..88d42e2daed9f6c 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -1131,7 +1131,7 @@ struct file_lock_context {
>>  
>>  /* The following constant reflects the upper bound of the file/locking space */
>>  #ifndef OFFSET_MAX
>> -#define INT_LIMIT(x)	(~((x)1 << (sizeof(x)*8 - 1)))
>> +#define INT_LIMIT(x)	((((x)1 << (sizeof(x) * 8 - 2)) - 1) * 2  + 1)
>>  #define OFFSET_MAX	INT_LIMIT(loff_t)
>>  #define OFFT_OFFSET_MAX	INT_LIMIT(off_t)
>>  #endif
> 
> This problem has already been solved by type_max() in include/linux/overflow.h.
> How about removing INT_LIMIT() and using type_max() instead?

It's better to use type_max(). INT_LIMIT() is currently valid only for signed type.
Besides, my method is actually the same as type_max(). Using type_max() does not
result in code duplication.

> 
> - Eric
> .
> 

-- 
Regards,
  Zhen Lei
