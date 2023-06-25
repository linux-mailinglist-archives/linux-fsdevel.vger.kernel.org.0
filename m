Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E627673CF0F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jun 2023 09:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjFYH4S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Jun 2023 03:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjFYH4Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Jun 2023 03:56:16 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E749DF;
        Sun, 25 Jun 2023 00:56:13 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QpjrY2gXKzMpSP;
        Sun, 25 Jun 2023 15:53:01 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 25 Jun 2023 15:56:10 +0800
Message-ID: <b73894fc-0c7a-0503-25ad-ab5a9dfbd852@huawei.com>
Date:   Sun, 25 Jun 2023 15:56:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] quota: fix race condition between dqput() and
 dquot_mark_dquot_dirty()
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
        <yukuai3@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20230616085608.42435-1-libaokun1@huawei.com>
 <20230616152824.ndpgvkegvvip2ahh@quack3>
 <c8daf4a0-769f-f769-50f6-8b7063542499@huawei.com>
 <20230622145620.hk3bdjxtlr64gtzl@quack3>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230622145620.hk3bdjxtlr64gtzl@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Hello!

Sorry for the late reply, just had a Dragon Boat holiday.

On 2023/6/22 22:56, Jan Kara wrote:
> Hello!
>
> On Mon 19-06-23 14:44:03, Baokun Li wrote:
>> On 2023/6/16 23:28, Jan Kara wrote:
>>> Now calling synchronize_srcu() directly from dquot_transfer() is too
>>> expensive (and mostly unnecessary) so what I would rather suggest is to
>>> create another dquot list (use dq_free list_head inside struct dquot for
>>> it) and add dquot whose last reference should be dropped there. We'd then
>>> queue work item which would call synchronize_srcu() and after that perform
>>> the final cleanup of all the dquots on the list.
>>>
>>> Now this also needs some modifications to dqget() and to quotaoff code to
>>> handle various races with the new dqput() code so if you feel it is too
>>> complex for your taste, I can implement this myself.
>>>
>>> 								Honza
>> I see what you mean, what we are doing here is very similar to
>> drop_dquot_ref(),
>> and if we have to modify it this way, I am happy to implement it.
>>
>> But as you said, calling synchronize_srcu() is too expensive and it blocks
>> almost all
>> mark dirty processes, so we only call it now in performance insensitive
>> scenarios
>> like dquot_disable(). And how do we control how often synchronize_srcu() is
>> called?
>> Are there more than a certain number of dquots in releasing_dquots or are
>> they
>> executed at regular intervals? And it would introduce various new
>> competitions.
>> Is it worthwhile to do this for a corner scenario like this one?
> So the way this is handled (e.g. in fsnotify subsystem) is that we just
> queue work item when we drop the last reference to the protected structure.
> The scheduling latency before the work item gets executed is enough to
> batch synchronize_srcu() calls and once synchronize_srcu() finishes, we add
> all items from the "staging list" to the free_dquots list.

Cool, thanks a lot for clearing up the confusion!

I will implement it in the next version.

>
>> I think we can simply focus on the race between the DQ_ACTIVE_B flag and
>> the DQ_MOD_B flag, which is the core problem, because the same quota
>> should not have both flags. These two flags are protected by dq_list_lock
>> and dquot->dq_lock respectively, so it makes sense to add a
>> wait_on_dquot() to ensure the accuracy of DQ_ACTIVE_B.
> But the fundamental problem is not only the race with DQ_MOD_B setting. The
> dquot structure can be completely freed by the time
> dquot_claim_space_nodirty() calls dquot_mark_dquot_dirty() on it. That's
> why I think making __dquot_transfer() obey dquot_srcu rules is the right
> solution.
>
> 								Honza
Yes, now I also think that making __dquot_transfer() obey dquot_srcu 
rules is
a better solution. But with inode->i_lock protection, why would the dquot
structure be completely freed?

Thanks!
-- 
With Best Regards,
Baokun Li
.
