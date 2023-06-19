Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DDC734BD6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 08:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjFSGoM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 02:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjFSGoL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 02:44:11 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AB9E5A;
        Sun, 18 Jun 2023 23:44:08 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ql0bg4SFKzqTnB;
        Mon, 19 Jun 2023 14:43:59 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 19 Jun 2023 14:44:04 +0800
Message-ID: <c8daf4a0-769f-f769-50f6-8b7063542499@huawei.com>
Date:   Mon, 19 Jun 2023 14:44:03 +0800
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
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230616152824.ndpgvkegvvip2ahh@quack3>
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

Hello Honza !

On 2023/6/16 23:28, Jan Kara wrote:
> Hello Baokun!
>
> On Fri 16-06-23 16:56:08, Baokun Li wrote:
>> To solve this problem, it is similar to the way dqget() avoids racing with
>> dquot_release(). First set the DQ_MOD_B flag, then execute wait_on_dquot(),
>> after this we know that either dquot_release() is already finished or it
>> will be canceled due to DQ_MOD_B flag test, at this point if the quota is
>> DQ_ACTIVE_B, then we can safely add the dquot to the dqi_dirty_list,
>> otherwise clear the DQ_MOD_B flag and exit directly.
>>
>> Fixes: 4580b30ea887 ("quota: Do not dirty bad dquots")
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>
>> Hello Honza,
>>
>> This problem can also be solved by modifying the reference count mechanism,
>> where dquots hold a reference count after they are allocated until they are
>> destroyed, i.e. the dquots in the free_dquots list have dq_count == 1. This
>> allows us to reduce the reference count as soon as we enter the dqput(),
>> and then add the dquot to the dqi_dirty_list only when dq_count > 1. This
>> also prevents the dquot in the dqi_dirty_list from not having the
>> DQ_ACTIVE_B flag, but this is a more impactful modification, so we chose to
>> refer to dqget() to avoid racing with dquot_release(). If you prefer this
>> solution by modifying the dq_count mechanism, I would be happy to send
>> another version of the patch.
> The way this *should* work is that dquot_mark_dquot_dirty() using dquot
> references from the inode should be protected by dquot_srcu. quota_off
> code takes care to call synchronize_srcu(&dquot_srcu) to not drop dquot
> references while they are used by other users. But you are right
> dquot_transfer() breaks this assumption. Most callers are fine since they
> are also protected by inode->i_lock but still I'd prefer to fix
> dquot_transfer() to follow the guarantees dquot_srcu should provide.
Indeed!
Operation accessing dquots via inode pointers shuould be protectedby 
dquot_srcu.
And inode->i_lock ensures that we do not record usage changes in a 
deprecated
dquota pointer, even when concurrent with dquot_transfer().
> Now calling synchronize_srcu() directly from dquot_transfer() is too
> expensive (and mostly unnecessary) so what I would rather suggest is to
> create another dquot list (use dq_free list_head inside struct dquot for
> it) and add dquot whose last reference should be dropped there. We'd then
> queue work item which would call synchronize_srcu() and after that perform
> the final cleanup of all the dquots on the list.
>
> Now this also needs some modifications to dqget() and to quotaoff code to
> handle various races with the new dqput() code so if you feel it is too
> complex for your taste, I can implement this myself.
>
> 								Honza
I see what you mean, what we are doing here is very similar to 
drop_dquot_ref(),
and if we have to modify it this way, I am happy to implement it.

But as you said, calling synchronize_srcu() is too expensive and it 
blocks almost all
mark dirty processes, so we only call it now in performance insensitive 
scenarios
like dquot_disable(). And how do we control how often synchronize_srcu() 
is called?
Are there more than a certain number of dquots in releasing_dquots or 
are they
executed at regular intervals? And it would introduce various new 
competitions.
Is it worthwhile to do this for a corner scenario like this one?

I think we can simply focus on the race between the DQ_ACTIVE_B flag and the
DQ_MOD_B flag, which is the core problem, because the same quota should not
have both flags. These two flags are protected by dq_list_lock and 
dquot->dq_lock
respectively, so it makes sense to add a wait_on_dquot() to ensure the 
accuracy of
DQ_ACTIVE_B.

The addition of wait_on_dquot() to this solution also seems very 
expensive, and I had
similar concerns before, but testing found no performance impact due to 
the fast path
without any locks. We returns 1 directly when the current dquot is 
already dirty, so there
is no locking involved after dquot is dirty until DQ_MOD_B is cleared. 
And clear the
dirtying of the dqi_dirty_list only happens in last dqput and 
dquot_writeback_dquots(),
both of which occur very infrequently.

And if we don't care about the harmless warning in 
dquot_writeback_dquots() in the
second function graph (just skip it), wait_on_dquot() in the solution 
can be removed.
We only need to determine again whether dquot is DQ_ACTIVE_B under 
dq_list_lock
protection to solve the problem in the first function graph. This is why 
there are two
function graphs in the patch description, because with the second 
problem, we have
to be more careful if we want to keep the warning.

Thanks!
-- 
With Best Regards,
Baokun Li
.
