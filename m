Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7EC743612
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 09:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjF3HqJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 03:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjF3HqI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 03:46:08 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34089E5E;
        Fri, 30 Jun 2023 00:46:05 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QsnR30KHhzTlRC;
        Fri, 30 Jun 2023 15:45:03 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 15:45:57 +0800
Message-ID: <5b1751af-9109-68bc-7fca-62cd665663c2@huawei.com>
Date:   Fri, 30 Jun 2023 15:45:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 5/7] quota: fix dqput() to follow the guarantees
 dquot_srcu should provide
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
        <yukuai3@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20230628132155.1560425-1-libaokun1@huawei.com>
 <20230628132155.1560425-6-libaokun1@huawei.com>
 <20230629105954.5cpqpch46ik4bg27@quack3>
 <9ac4fdcf-f236-8a05-bb96-b0b85a63b54e@huawei.com>
 <20230629143304.2t45zta3f57imowa@quack3>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230629143304.2t45zta3f57imowa@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2023/6/29 22:33, Jan Kara wrote:
> On Thu 29-06-23 19:47:08, Baokun Li wrote:
>> On 2023/6/29 18:59, Jan Kara wrote:
>>> On Wed 28-06-23 21:21:53, Baokun Li wrote:
>>>> @@ -760,6 +771,8 @@ dqcache_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>>>>    	struct dquot *dquot;
>>>>    	unsigned long freed = 0;
>>>> +	flush_delayed_work(&quota_release_work);
>>>> +
>>> I would not flush the work here. Sure, it can make more dquots available
>>> for reclaim but I think it is more important for the shrinker to not wait
>>> on srcu period as shrinker can be called very frequently under memory
>>> pressure.
>> This is because I want to use remove_free_dquot() directly, and if I don't
>> do
>> flush here anymore, then DQST_FREE_DQUOTS will not be accurate.
>> Since that's the case, I'll remove the flush here and add a determination
>> to remove_free_dquot() whether to increase DQST_FREE_DQUOTS.
> OK.
>
>>>>    	spin_lock(&dq_list_lock);
>>>>    	while (!list_empty(&free_dquots) && sc->nr_to_scan) {
>>>>    		dquot = list_first_entry(&free_dquots, struct dquot, dq_free);
>>>> @@ -787,6 +800,60 @@ static struct shrinker dqcache_shrinker = {
>>>>    	.seeks = DEFAULT_SEEKS,
>>>>    };
>>>> +/*
>>>> + * Safely release dquot and put reference to dquot.
>>>> + */
>>>> +static void quota_release_workfn(struct work_struct *work)
>>>> +{
>>>> +	struct dquot *dquot;
>>>> +	struct list_head rls_head;
>>>> +
>>>> +	spin_lock(&dq_list_lock);
>>>> +	/* Exchange the list head to avoid livelock. */
>>>> +	list_replace_init(&releasing_dquots, &rls_head);
>>>> +	spin_unlock(&dq_list_lock);
>>>> +
>>>> +restart:
>>>> +	synchronize_srcu(&dquot_srcu);
>>>> +	spin_lock(&dq_list_lock);
>>>> +	while (!list_empty(&rls_head)) {
>>> I think the logic below needs a bit more work. Firstly, I think that
>>> dqget() should removing dquots from releasing_dquots list - basically just
>>> replace the:
>>> 	if (!atomic_read(&dquot->dq_count))
>>> 		remove_free_dquot(dquot);
>>> with
>>> 	/* Dquot on releasing_dquots list? Drop ref kept by that list. */
>>> 	if (atomic_read(&dquot->dq_count) == 1 && !list_empty(&dquot->dq_free))
>>> 		atomic_dec(&dquot->dq_count);
>>> 	remove_free_dquot(dquot);
>>> 	atomic_inc(&dquot->dq_count);
>>>
>>> That way we are sure that while we are holding dq_list_lock, all dquots on
>>> rls_head list have dq_count == 1.
>> I wrote it this way at first, but that would have been problematic, so I
>> ended up dropping the dq_count == 1 constraint for dquots on
>> releasing_dquots.  Like the following, we will get a bad dquot directly:
>>
>> quota_release_workfn
>>   spin_lock(&dq_list_lock)
>>   dquot = list_first_entry(&rls_head, struct dquot, dq_free)
>>   spin_unlock(&dq_list_lock)
>>   dquot->dq_sb->dq_op->release_dquot(dquot)
>>   release_dquot
>>         dqget
>>          atomic_dec(&dquot->dq_count)
>>          remove_free_dquot(dquot)
>>          atomic_inc(&dquot->dq_count)
>>          spin_unlock(&dq_list_lock)
>>          wait_on_dquot(dquot)
>>          if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
>>          // still active
>>   mutex_lock(&dquot->dq_lock)
>>   dquot_is_busy(dquot)
>>    atomic_read(&dquot->dq_count) > 1
>>   clear_bit(DQ_ACTIVE_B, &dquot->dq_flags)
>>   mutex_unlock(&dquot->dq_lock)
>>
>> Removing dquot from releasing_dquots and its reduced reference count
>> will cause dquot_is_busy() in dquot_release to fail. wait_on_dquot(dquot)
>> in dqget would have no effect. This is also the reason why I did not restart
>> at dquot_active. Adding dquot to releasing_dquots only in dqput() and
>> removing dquot from releasing_dquots only in quota_release_workfn() is
>> a simple and effective way to ensure consistency.
> Indeed, that's a good point. Still cannot we simplify the loop like:
>
> 	while (!list_empty(&rls_head)) {
> 		dquot = list_first_entry(&rls_head, struct dquot, dq_free);
> 		/* Dquot got used again? */
> 		if (atomic_read(&dquot->dq_count) > 1) {
> 			atomic_dec(&dquot->dq_count);
> 			remove_free_dquot(dquot);
> 			continue;
> 		}
> 		if (dquot_dirty(dquot)) {
> 			keep what you had
> 		}
> 		if (dquot_active(dquot)) {
> 			spin_unlock(&dq_list_lock);
> 			dquot->dq_sb->dq_op->release_dquot(dquot);
> 			goto restart;
> 		}
> 		/* Dquot is inactive and clean, we can move it to free list */
> 		atomic_dec(&dquot->dq_count);
> 		remove_free_dquot(dquot);
> 		put_dquot_last(dquot);
> 	}
>
> What do you think?
> 								Honza
This looks great, and the code looks much cleaner, and I'll send out the
next version later containing your suggested changes!

Thank you so much for your patient review!
-- 
With Best Regards,
Baokun Li
.
