Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD547424D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 13:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjF2LK4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 07:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjF2LKx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 07:10:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B79C10CF;
        Thu, 29 Jun 2023 04:10:51 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QsFzl64BgzqVFd;
        Thu, 29 Jun 2023 19:08:03 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 19:10:48 +0800
Message-ID: <e2b328fa-f5ed-c1ec-2b20-60ed53c9b8a7@huawei.com>
Date:   Thu, 29 Jun 2023 19:10:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 2/7] quota: add new global dquot list releasing_dquots
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
        <yukuai3@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20230628132155.1560425-1-libaokun1@huawei.com>
 <20230628132155.1560425-3-libaokun1@huawei.com>
 <20230629102952.ifn3qdoh632ybsb5@quack3>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230629102952.ifn3qdoh632ybsb5@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/6/29 18:29, Jan Kara wrote:
> On Wed 28-06-23 21:21:50, Baokun Li wrote:
>> Add a new global dquot list that obeys the following rules:
>>
>>   1). A dquot is added to this list when its last reference count is about
>>       to be dropped.
>>   2). The reference count of the dquot in the list is greater than or equal
>>       to 1 ( due to possible race with dqget()).
>>   3). When a dquot is removed from this list, a reference count is always
>>       subtracted, and if the reference count is then 0, the dquot is added
>>       to the free_dquots list.
>>
>> This list is used to safely perform the final cleanup before releasing
>> the last reference count, to avoid various contention issues caused by
>> performing cleanup directly in dqput(), and to avoid the performance impact
>> caused by calling synchronize_srcu(&dquot_srcu) directly in dqput(). Here
>> it is just defining the list and implementing the corresponding operation
>> function, which we will use later.
>>
>> Suggested-by: Jan Kara <jack@suse.cz>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> I think you can merge this patch with patch 5. It is not like separating
> this bit helps in review or anything...
OK, I just don't want to cram a lot of stuff into patch 5, I will merge 
this patch
into patch 5 in the next version.
>> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
>> index 108ba9f1e420..a8b43b5b5623 100644
>> --- a/fs/quota/dquot.c
>> +++ b/fs/quota/dquot.c
>> @@ -226,12 +226,21 @@ static void put_quota_format(struct quota_format_type *fmt)
>>   /*
>>    * Dquot List Management:
>>    * The quota code uses four lists for dquot management: the inuse_list,
>                            ^^^ five now :)
Yes, indeed, I forgot to correct here.
>
>> - * free_dquots, dqi_dirty_list, and dquot_hash[] array. A single dquot
>> - * structure may be on some of those lists, depending on its current state.
>> + * releasing_dquots, free_dquots, dqi_dirty_list, and dquot_hash[] array.
>> + * A single dquot structure may be on some of those lists, depending on
>> + * its current state.
>>    *
>>    * All dquots are placed to the end of inuse_list when first created, and this
>>    * list is used for invalidate operation, which must look at every dquot.
>>    *
>> + * When the last reference of a dquot will be dropped, the dquot will be
>> + * added to releasing_dquots. We'd then queue work item which would call
>> + * synchronize_srcu() and after that perform the final cleanup of all the
>> + * dquots on the list. Both releasing_dquots and free_dquots use the
>> + * dq_free list_head in the dquot struct. when a dquot is removed from
> 					     ^^^ Capital W please
Good catch！Very sorry for the oversight here.
>> + * releasing_dquots, a reference count is always subtracted, and if
>> + * dq_count == 0 at that point, the dquot will be added to the free_dquots.
>> + *
> 								Honza
Thank you very much for your careful REVIEW! I will fix those in the 
next version!

-- 
With Best Regards,
Baokun Li
.
