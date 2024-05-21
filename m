Return-Path: <linux-fsdevel+bounces-19859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6A08CA667
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 04:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADE211F221DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 02:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8CD182DB;
	Tue, 21 May 2024 02:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rGPQ+wVh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41B81BC46;
	Tue, 21 May 2024 02:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716260025; cv=none; b=emi9cM6PWlj7kW0xKp07Dti9RCWh8QJphrGGAFRLTGf5HQqc85O9mh2g0QeXC/DAgiXg194u8M9Z1mcTPNJhTSkg22IILH+3Z3tXOTczzh+n63rYJbUili9wj2xySnQ8iERfsuVv+l1QKMoKyslQn4Hjb0pSr0XEFJZZFlAMQEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716260025; c=relaxed/simple;
	bh=AaMch7EOgDmxXHW148dTxGAgT6ItbrjQugrNad3BlTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kKtpdJupVdN73rfgVEbz+XIpvuUiFBZidBa18DQUa0VqY2C0TAbCOuvoFJtCOaeNo891yfmUyWMs+tZsd3HF0bsgvAReeBARGL0DCG5+J5A/XVbXwUI7+nh0nSmJ66egqg6rE7VfjbmhC0S45tiuekq0R7jDSJ5jP6n3MS1GyYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rGPQ+wVh; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716260018; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=C6+2SGWtEsiv4yDPMdsLJIjpofJxi5cWwH1qGfi1jJc=;
	b=rGPQ+wVhH8W+wfH2Kf20T12Sbt1WrOG86I0yq9Oi9YIr/1moFZJX3WeRyo6XyUT+pQ+3mWYJkoWDnlnl0hGcx/mM6kovhIJ02q+BB3Hvtw5xO7Y0LKJJg/OuRCHOpS517UJXxLnANVWlpusi1DV6cX3ZVm/xoBLFHVmGKbBSS1w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W6vzjor_1716260012;
Received: from 30.97.48.219(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W6vzjor_1716260012)
          by smtp.aliyun-inc.com;
          Tue, 21 May 2024 10:53:37 +0800
Message-ID: <0702ac5b-4c25-440a-a877-bbb1b0afe949@linux.alibaba.com>
Date: Tue, 21 May 2024 10:53:31 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] cachefiles: cyclic allocation of msg_id to avoid
 reuse
To: Baokun Li <libaokun@huaweicloud.com>, Jeff Layton <jlayton@kernel.org>,
 netfs@lists.linux.dev, dhowells@redhat.com
Cc: jefflexu@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>
References: <20240515125136.3714580-1-libaokun@huaweicloud.com>
 <20240515125136.3714580-5-libaokun@huaweicloud.com>
 <f449f710b7e1ba725ec9f73cace6c1289b9225b6.camel@kernel.org>
 <d3f5d0c4-eda7-87e3-5938-487ab9ff6b81@huaweicloud.com>
 <4b1584787dd54bb95d700feae1ca498c40429551.camel@kernel.org>
 <a4d57830-2bde-901f-72c4-e1a3f714faa5@huaweicloud.com>
 <d82277a4-aeab-4eb7-bdfd-377edd8b8737@linux.alibaba.com>
 <bc76e529-7904-0650-7fa9-dc5561ff6668@huaweicloud.com>
 <b75ec357-4189-4ea6-8f16-b0e2923921fd@linux.alibaba.com>
 <f4319b36-0f94-d648-0fe6-7f279db5db5d@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <f4319b36-0f94-d648-0fe6-7f279db5db5d@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/5/21 10:36, Baokun Li wrote:
> On 2024/5/20 22:56, Gao Xiang wrote:
>> Hi Baokun,
>>
>> On 2024/5/20 21:24, Baokun Li wrote:
>>> On 2024/5/20 20:54, Gao Xiang wrote:
>>>>
>>>>
>>>> On 2024/5/20 20:42, Baokun Li wrote:
>>>>> On 2024/5/20 18:04, Jeff Layton wrote:
>>>>>> On Mon, 2024-05-20 at 12:06 +0800, Baokun Li wrote:
>>>>>>> Hi Jeff,
>>>>>>>
>>>>>>> Thank you very much for your review!
>>>>>>>
>>>>>>> On 2024/5/19 19:11, Jeff Layton wrote:
>>>>>>>> On Wed, 2024-05-15 at 20:51 +0800, libaokun@huaweicloud.com wrote:
>>>>>>>>> From: Baokun Li <libaokun1@huawei.com>
>>>>>>>>>
>>>>>>>>> Reusing the msg_id after a maliciously completed reopen request may cause
>>>>>>>>> a read request to remain unprocessed and result in a hung, as shown below:
>>>>>>>>>
>>>>>>>>>          t1       |      t2       |      t3
>>>>>>>>> -------------------------------------------------
>>>>>>>>> cachefiles_ondemand_select_req
>>>>>>>>>    cachefiles_ondemand_object_is_close(A)
>>>>>>>>>    cachefiles_ondemand_set_object_reopening(A)
>>>>>>>>>    queue_work(fscache_object_wq, &info->work)
>>>>>>>>>                   ondemand_object_worker
>>>>>>>>> cachefiles_ondemand_init_object(A)
>>>>>>>>> cachefiles_ondemand_send_req(OPEN)
>>>>>>>>>                       // get msg_id 6
>>>>>>>>> wait_for_completion(&req_A->done)
>>>>>>>>> cachefiles_ondemand_daemon_read
>>>>>>>>>    // read msg_id 6 req_A
>>>>>>>>>    cachefiles_ondemand_get_fd
>>>>>>>>>    copy_to_user
>>>>>>>>>                                   // Malicious completion msg_id 6
>>>>>>>>>                                   copen 6,-1
>>>>>>>>> cachefiles_ondemand_copen
>>>>>>>>> complete(&req_A->done)
>>>>>>>>>                                    // will not set the object to close
>>>>>>>>>                                    // because ondemand_id && fd is valid.
>>>>>>>>>
>>>>>>>>>                   // ondemand_object_worker() is done
>>>>>>>>>                   // but the object is still reopening.
>>>>>>>>>
>>>>>>>>>                                   // new open req_B
>>>>>>>>> cachefiles_ondemand_init_object(B)
>>>>>>>>> cachefiles_ondemand_send_req(OPEN)
>>>>>>>>>                                    // reuse msg_id 6
>>>>>>>>> process_open_req
>>>>>>>>>    copen 6,A.size
>>>>>>>>>    // The expected failed copen was executed successfully
>>>>>>>>>
>>>>>>>>> Expect copen to fail, and when it does, it closes fd, which sets the
>>>>>>>>> object to close, and then close triggers reopen again. However, due to
>>>>>>>>> msg_id reuse resulting in a successful copen, the anonymous fd is not
>>>>>>>>> closed until the daemon exits. Therefore read requests waiting for reopen
>>>>>>>>> to complete may trigger hung task.
>>>>>>>>>
>>>>>>>>> To avoid this issue, allocate the msg_id cyclically to avoid reusing the
>>>>>>>>> msg_id for a very short duration of time.
>>>>>>>>>
>>>>>>>>> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
>>>>>>>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>>>>>>>> ---
>>>>>>>>>    fs/cachefiles/internal.h |  1 +
>>>>>>>>>    fs/cachefiles/ondemand.c | 20 ++++++++++++++++----
>>>>>>>>>    2 files changed, 17 insertions(+), 4 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
>>>>>>>>> index 8ecd296cc1c4..9200c00f3e98 100644
>>>>>>>>> --- a/fs/cachefiles/internal.h
>>>>>>>>> +++ b/fs/cachefiles/internal.h
>>>>>>>>> @@ -128,6 +128,7 @@ struct cachefiles_cache {
>>>>>>>>>        unsigned long            req_id_next;
>>>>>>>>>        struct xarray            ondemand_ids;    /* xarray for ondemand_id allocation */
>>>>>>>>>        u32                ondemand_id_next;
>>>>>>>>> +    u32                msg_id_next;
>>>>>>>>>    };
>>>>>>>>>    static inline bool cachefiles_in_ondemand_mode(struct cachefiles_cache *cache)
>>>>>>>>> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
>>>>>>>>> index f6440b3e7368..b10952f77472 100644
>>>>>>>>> --- a/fs/cachefiles/ondemand.c
>>>>>>>>> +++ b/fs/cachefiles/ondemand.c
>>>>>>>>> @@ -433,20 +433,32 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>>>>>>>>>            smp_mb();
>>>>>>>>>            if (opcode == CACHEFILES_OP_CLOSE &&
>>>>>>>>> - !cachefiles_ondemand_object_is_open(object)) {
>>>>>>>>> + !cachefiles_ondemand_object_is_open(object)) {
>>>>>>>>> WARN_ON_ONCE(object->ondemand->ondemand_id == 0);
>>>>>>>>>                xas_unlock(&xas);
>>>>>>>>>                ret = -EIO;
>>>>>>>>>                goto out;
>>>>>>>>>            }
>>>>>>>>> -        xas.xa_index = 0;
>>>>>>>>> +        /*
>>>>>>>>> +         * Cyclically find a free xas to avoid msg_id reuse that would
>>>>>>>>> +         * cause the daemon to successfully copen a stale msg_id.
>>>>>>>>> +         */
>>>>>>>>> +        xas.xa_index = cache->msg_id_next;
>>>>>>>>>            xas_find_marked(&xas, UINT_MAX, XA_FREE_MARK);
>>>>>>>>> +        if (xas.xa_node == XAS_RESTART) {
>>>>>>>>> +            xas.xa_index = 0;
>>>>>>>>> +            xas_find_marked(&xas, cache->msg_id_next - 1, XA_FREE_MARK);
>>>>>>>>> +        }
>>>>>>>>>            if (xas.xa_node == XAS_RESTART)
>>>>>>>>>                xas_set_err(&xas, -EBUSY);
>>>>>>>>> +
>>>>>>>>>            xas_store(&xas, req);
>>>>>>>>> -        xas_clear_mark(&xas, XA_FREE_MARK);
>>>>>>>>> -        xas_set_mark(&xas, CACHEFILES_REQ_NEW);
>>>>>>>>> +        if (xas_valid(&xas)) {
>>>>>>>>> +            cache->msg_id_next = xas.xa_index + 1;
>>>>>>>> If you have a long-standing stuck request, could this counter wrap
>>>>>>>> around and you still end up with reuse?
>>>>>>> Yes, msg_id_next is declared to be of type u32 in the hope that when
>>>>>>> xa_index == UINT_MAX, a wrap around occurs so that msg_id_next
>>>>>>> goes to zero. Limiting xa_index to no more than UINT_MAX is to avoid
>>>>>>> the xarry being too deep.
>>>>>>>
>>>>>>> If msg_id_next is equal to the id of a long-standing stuck request
>>>>>>> after the wrap-around, it is true that the reuse in the above problem
>>>>>>> may also occur.
>>>>>>>
>>>>>>> But I feel that a long stuck request is problematic in itself, it means
>>>>>>> that after we have sent 4294967295 requests, the first one has not
>>>>>>> been processed yet, and even if we send a million requests per
>>>>>>> second, this one hasn't been completed for more than an hour.
>>>>>>>
>>>>>>> We have a keep-alive process that pulls the daemon back up as
>>>>>>> soon as it exits, and there is a timeout mechanism for requests in
>>>>>>> the daemon to prevent the kernel from waiting for long periods
>>>>>>> of time. In other words, we should avoid the situation where
>>>>>>> a request is stuck for a long period of time.
>>>>>>>
>>>>>>> If you think UINT_MAX is not enough, perhaps we could raise
>>>>>>> the maximum value of msg_id_next to ULONG_MAX?
>>>>>>>> Maybe this should be using
>>>>>>>> ida_alloc/free instead, which would prevent that too?
>>>>>>>>
>>>>>>> The id reuse here is that the kernel has finished the open request
>>>>>>> req_A and freed its id_A and used it again when sending the open
>>>>>>> request req_B, but the daemon is still working on req_A, so the
>>>>>>> copen id_A succeeds but operates on req_B.
>>>>>>>
>>>>>>> The id that is being used by the kernel will not be allocated here
>>>>>>> so it seems that ida _alloc/free does not prevent reuse either,
>>>>>>> could you elaborate a bit more how this works?
>>>>>>>
>>>>>> ida_alloc and free absolutely prevent reuse while the id is in use.
>>>>>> That's sort of the point of those functions. Basically it uses a set of
>>>>>> bitmaps in an xarray to track which IDs are in use, so ida_alloc only
>>>>>> hands out values which are not in use. See the comments over
>>>>>> ida_alloc_range() in lib/idr.c.
>>>>>>
>>>>> Thank you for the explanation!
>>>>>
>>>>> The logic now provides the same guarantees as ida_alloc/free.
>>>>> The "reused" id, indeed, is no longer in use in the kernel, but it is still
>>>>> in use in the userland, so a multi-threaded daemon could be handling
>>>>> two different requests for the same msg_id at the same time.
>>>>>
>>>>> Previously, the logic for allocating msg_ids was to start at 0 and look
>>>>> for a free xas.index, so it was possible for an id to be allocated to a
>>>>> new request just as the id was being freed.
>>>>>
>>>>> With the change to cyclic allocation, the kernel will not use the same
>>>>> id again until INT_MAX requests have been sent, and during the time
>>>>> it takes to send requests, the daemon has enough time to process
>>>>> requests whose ids are still in use by the daemon, but have already
>>>>> been freed in the kernel.
>>>>
>>>> Again, If I understand correctly, I think the main point
>>>> here is
>>>>
>>>> wait_for_completion(&req_A->done)
>>>>
>>>> which could hang due to some malicious deamon.  But I think it
>>>> should be switched to wait_for_completion_killable() instead. *
>>>> It's up to users to kill the mount instance if there is a
>>>> malicious user daemon.
>>>>
>>>> So in that case, hung task will not be triggered anymore, and
>>>> you don't need to care about cyclic allocation too.
>>>>
>>>> Thanks,
>>>> Gao Xiang
>>> Hi Xiang,
>>>
>>> The problem is not as simple as you think.
>>>
>>> If you make it killable, it just won't trigger a hung task in
>>> cachefiles_ondemand_send_req(), and the process waiting for the
>>> resource in question will also be hung.
>>>
>>> * When the open/read request in the mount process gets stuck,
>>>    the sync/drop cache will trigger a hung task panic in iterate_supers()
>>>    as it waits for sb->umount to be unlocked.
>>> * After umount, anonymous fd is not closed causing a hung task panic
>>>    in fscache_hash_cookie() because of waiting for cookie unhash.
>>> * The dentry is in a loop up state, because the read request is not being
>>>    processed, another process looking for the same dentry is waiting for
>>>    the previous lookup to finish, which triggers a hung task panic in
>>>    d_alloc_parallel().
>>
>>
>> As for your sb->umount, d_alloc_parallel() or even i_rwsem,
>> which are all currently unkillable, also see some previous
>> threads like:
>>
>> https://lore.kernel.org/linux-fsdevel/CAJfpegu6v1fRAyLvFLOPUSAhx5aAGvPGjBWv-TDQjugqjUA_hQ@mail.gmail.com/T/#u
>>
>> I don't think it's the issue of on-demand cachefiles, even
>> NVMe or virtio-blk or networking can be stuck in
>> .lookup, fill_sb or whatever.
>>
>> Which can makes sb->umount, d_alloc_parallel() or even
>> i_rwsem unkillable.
>>
> Everyone and every company has different requirements for quality,
> and if you don't think these hung_task_panic are problems, I respect
> your opinion.
> 
> But the company I work for has much higher requirements for quality,
> and it's not acceptable to leave these issues that have been tested out
> unresolved.
>>>
>>> Can all this be made killable?
>>
>> I can understand your hung_task_panic concern but it
>> sounds like a workaround to me anyway.
>>
>> Thanks,
>> Gao Xiang
>>
>  From the current perspective, cyclic allocation is a valid solution to
> the current msg_id collision problem, and it also makes it fairer to
> copy out requests than it was before.

Okay, for this patch, I agree it's better than none and it can
indeed cause fairer requests, so

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> 
> Thanks!
> 

