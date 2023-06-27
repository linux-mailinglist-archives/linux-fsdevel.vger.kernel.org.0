Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E48B73F84C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 11:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjF0JI4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 05:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjF0JIh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:08:37 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D782715;
        Tue, 27 Jun 2023 02:08:30 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QqzNJ14vvzLmwW;
        Tue, 27 Jun 2023 17:06:24 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 17:08:27 +0800
Message-ID: <fe7d3b03-4d08-34ac-a695-a5c57c751aeb@huawei.com>
Date:   Tue, 27 Jun 2023 17:08:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] quota: fix race condition between dqput() and
 dquot_mark_dquot_dirty()
To:     Jan Kara <jack@suse.cz>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
        <yukuai3@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20230616085608.42435-1-libaokun1@huawei.com>
 <20230616152824.ndpgvkegvvip2ahh@quack3>
 <c8daf4a0-769f-f769-50f6-8b7063542499@huawei.com>
 <20230622145620.hk3bdjxtlr64gtzl@quack3>
 <b73894fc-0c7a-0503-25ad-ab5a9dfbd852@huawei.com>
 <20230626130957.kvfli23djxc2opkq@quack3>
 <2486ec73-55e0-00cb-fc76-97b9b285a9ce@huawei.com>
 <20230627083406.hhjf55e2tqnwqaf6@quack3>
Content-Language: en-US
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230627083406.hhjf55e2tqnwqaf6@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On 2023/6/27 16:34, Jan Kara wrote:
> Hello!
>
> On Mon 26-06-23 21:55:49, Baokun Li wrote:
>> On 2023/6/26 21:09, Jan Kara wrote:
>>> On Sun 25-06-23 15:56:10, Baokun Li wrote:
>>>>>> I think we can simply focus on the race between the DQ_ACTIVE_B flag and
>>>>>> the DQ_MOD_B flag, which is the core problem, because the same quota
>>>>>> should not have both flags. These two flags are protected by dq_list_lock
>>>>>> and dquot->dq_lock respectively, so it makes sense to add a
>>>>>> wait_on_dquot() to ensure the accuracy of DQ_ACTIVE_B.
>>>>> But the fundamental problem is not only the race with DQ_MOD_B setting. The
>>>>> dquot structure can be completely freed by the time
>>>>> dquot_claim_space_nodirty() calls dquot_mark_dquot_dirty() on it. That's
>>>>> why I think making __dquot_transfer() obey dquot_srcu rules is the right
>>>>> solution.
>>>> Yes, now I also think that making __dquot_transfer() obey dquot_srcu
>>>> rules is a better solution. But with inode->i_lock protection, why would
>>>> the dquot structure be completely freed?
>>> Well, when dquot_claim_space_nodirty() calls mark_all_dquot_dirty() it does
>>> not hold any locks (only dquot_srcu). So nothing prevents dquot_transfer()
>>> to go, swap dquot structure pointers and drop dquot references and after
>>> that mark_all_dquot_dirty() can use a stale pointer to call
>>> mark_dquot_dirty() on already freed memory.
>>>
>> No, this doesn't look like it's going to happen.  The
>> mark_all_dquot_dirty() uses a pointer array pointer, the dquot in the
>> array is dynamically changing, so after swap dquot structure pointers,
>> mark_all_dquot_dirty() uses the new pointer, and the stale pointer is
>> always destroyed after swap, so there is no case of using the stale
>> pointer here.
> There is a case - CPU0 can prefetch the values from dquots[] array into its
> local cache, then CPU1 can update the dquots[] array (these writes can
> happily stay in CPU1 store cache invisible to other CPUs) and free the
> dquots via dqput(). Then CPU0 can pass the prefetched dquot pointers to
> mark_dquot_dirty(). There are no locks or memory barries preventing CPUs
> from ordering instructions and memory operations like this in the code...
> You can read Documentation/memory-barriers.txt about all the perils current
> CPU architecture brings wrt coordination of memory accesses among CPUs ;)
>
> 								Honza

Got it!

Sorry for misunderstanding you (I thought "completely freed" meant
dquot_destroy(), but you should have meant dquot_release()).
Then this is exactly the scenario in the first function graph in my patch
description. In this scenario the data from the old dquot has been moved
to the new dquot. The old dquot may set DQ_MOD_B bit after it has been
cleared of DQ_ACTIVE_B bit.

We want to do exactly the thing to avoid this situation.

-- 
With Best Regards,
Baokun Li
.
