Return-Path: <linux-fsdevel+bounces-18874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0010B8BDBE6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 08:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229701C2194C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 06:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FA878C92;
	Tue,  7 May 2024 06:52:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3396178C7D;
	Tue,  7 May 2024 06:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715064747; cv=none; b=hUsv8sqL8Lzb6mcSx+wRDol32/4ULJgejPx07dLDhxCGVifaMJDQux5eBYz025k48sQl4ZhM0EG9QaNPMQABUT0XZcrnZR6MwKFwBYQP86HYnh7igx7yREJssxYYvPQWtNnLBgNnHW81kXMkSDJgaobSdJ62lSXnawn7N5vJ7eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715064747; c=relaxed/simple;
	bh=NXFA2n7R8fudSZ/3T2nEa5Ke4g54M+TnC5DNvRyOtkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0FiZz/UKuLaF49GsFcncMEG+7eowegWZXF0jZ0zJtQPIx7ri07FVjOiZXoMX3WQ6M5vvMX1wJkV7vH2CYHBdZ2+p0BsF8W1yuFmV04of8w4npYx2sFDLYjqpwDZov+ye8JWCILDxNWQFuaON27gNthX3H0wbgZYMe17kkcnu60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VYTV73X47z4f3jkr;
	Tue,  7 May 2024 14:52:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BEF1B1A0179;
	Tue,  7 May 2024 14:52:20 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g6gzzlmdMbyLw--.9131S3;
	Tue, 07 May 2024 14:52:20 +0800 (CST)
Message-ID: <7c5f0e28-100f-621e-61e2-65e5071f6a22@huaweicloud.com>
Date: Tue, 7 May 2024 14:52:16 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 01/12] cachefiles: remove request from xarry during flush
 requests
To: Jingbo Xu <jefflexu@linux.alibaba.com>, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun <yangerkun@huawei.com>,
 libaokun@huaweicloud.com
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-2-libaokun@huaweicloud.com>
 <6e4a20f7-263a-46be-81cc-2667353c452d@linux.alibaba.com>
 <ba40eb22-dc28-54b6-a8cb-7a8ba4464c9a@huaweicloud.com>
 <876cd180-6268-4f1a-a3bc-6b7b2aa3279f@linux.alibaba.com>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <876cd180-6268-4f1a-a3bc-6b7b2aa3279f@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g6gzzlmdMbyLw--.9131S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJFW7Ary3ZF4DCr13Xr47Arb_yoWrCr48pr
	ySyFy7Jry8Gr1kJr1UJr1UJryUJr1UJ3WUXr1UJF18Ar1UAr1Yqr4UXr1vgryUJrW8Jr4U
	Jr1UJr17Zr1UJr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCT
	nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

Hi Jingbo,

Sorry for the late reply.

On 2024/5/6 13:50, Jingbo Xu wrote:
>
> On 5/6/24 11:57 AM, Baokun Li wrote:
>> On 2024/5/6 11:48, Jingbo Xu wrote:
>>> On 4/24/24 11:39 AM, libaokun@huaweicloud.com wrote:
>>>> From: Baokun Li <libaokun1@huawei.com>
>>>>
>>>> This prevents concurrency from causing access to a freed req.
>>> Could you give more details on how the concurrent access will happen?
>>> How could another process access the &cache->reqs xarray after it has
>>> been flushed?
>> Similar logic to restore leading to UAF:
>>
>>       mount  |   daemon_thread1    |    daemon_thread2
>> ------------------------------------------------------------
>>   cachefiles_ondemand_init_object
>>    cachefiles_ondemand_send_req
>>     REQ_A = kzalloc(sizeof(*req) + data_len)
>>     wait_for_completion(&REQ_A->done)
>>
>>              cachefiles_daemon_read
>>               cachefiles_ondemand_daemon_read
>>                REQ_A = cachefiles_ondemand_select_req
>>                cachefiles_ondemand_get_fd
>>                copy_to_user(_buffer, msg, n)
>>              process_open_req(REQ_A)
>>                                    // close dev fd
>>                                    cachefiles_flush_reqs
>>                                     complete(&REQ_A->done)
>>     kfree(REQ_A)
>
>>               cachefiles_ondemand_get_fd(REQ_A)
>>                fd = get_unused_fd_flags
>>                file = anon_inode_getfile
>>                fd_install(fd, file)
>>                load = (void *)REQ_A->msg.data;
>>                load->fd = fd;
>>                // load UAF !!!
> How could the second cachefiles_ondemand_get_fd() get called here, given
> the cache has been flushed and flagged as DEAD?
>
I was in a bit of a rush to reply earlier, and that graph above is
wrong. Please see the one below:

      mount  |   daemon_thread1    |    daemon_thread2
------------------------------------------------------------
  cachefiles_ondemand_init_object
   cachefiles_ondemand_send_req
    REQ_A = kzalloc(sizeof(*req) + data_len)
    wait_for_completion(&REQ_A->done)
             cachefiles_daemon_read
              cachefiles_ondemand_daemon_read
                                   // close dev fd
                                   cachefiles_flush_reqs
                                    complete(&REQ_A->done)
    kfree(REQ_A)
               xa_lock(&cache->reqs);
               cachefiles_ondemand_select_req
                 req->msg.opcode != CACHEFILES_OP_READ
                 // req use-after-free !!!
               xa_unlock(&cache->reqs);
                                    xa_destroy(&cache->reqs)

Even with CACHEFILES_DEAD set, we can still read the requests, so
accessing it after the request has been freed will trigger use-after-free.

Thanks,
Baokun
>>>> ---
>>>>    fs/cachefiles/daemon.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
>>>> index 6465e2574230..ccb7b707ea4b 100644
>>>> --- a/fs/cachefiles/daemon.c
>>>> +++ b/fs/cachefiles/daemon.c
>>>> @@ -159,6 +159,7 @@ static void cachefiles_flush_reqs(struct
>>>> cachefiles_cache *cache)
>>>>        xa_for_each(xa, index, req) {
>>>>            req->error = -EIO;
>>>>            complete(&req->done);
>>>> +        __xa_erase(xa, index);
>>>>        }
>>>>        xa_unlock(xa);
>>>>    



