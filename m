Return-Path: <linux-fsdevel+bounces-19769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2368C9A3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 11:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05091C20E72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 09:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B328A1CA81;
	Mon, 20 May 2024 09:19:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5352137F;
	Mon, 20 May 2024 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716196798; cv=none; b=SMSggfRLh6OHHQZlYB8rm3HAzZJZNdoLlWNwkOBpSH25XE5lc7INVQXSFN0O2USFTEWus+sszrnW4RfdckKtvyqm8eMgqdAn14GvfAc14gRv59DRThfIEQTz7YbmZHSfkDpx40cM5q2g5K/Gel23NiuM9PA3etUj8QPL9hKem1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716196798; c=relaxed/simple;
	bh=v1mCRc4Cyw1bo9jvOSa3ltHdkaf7YQ1Ul8qqdJDs2Vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mCvZQzNolDG9NxpcTk0eLML4rQNhr4j9uGSZNWjqzL9hEn2s5igV0jMuFd0pIRBvXK1abZCouPCa7Y7Yl/nBsgz+DUlCeIAUeRhIZoFJbXh8HutxE6mfMxTw1B/a/3IvTIKTKUHLEr/DS7B2OemaFUWpN7fVCTAeMEVZc4T0Fk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VjX8L0FhNz4f3jqB;
	Mon, 20 May 2024 17:19:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B927D1A0A82;
	Mon, 20 May 2024 17:19:51 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g6zFUtmP6KzNA--.3807S3;
	Mon, 20 May 2024 17:19:51 +0800 (CST)
Message-ID: <5e3716d1-379a-a052-2ecf-8df497efafef@huaweicloud.com>
Date: Mon, 20 May 2024 17:19:47 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 03/12] cachefiles: fix slab-use-after-free in
 cachefiles_ondemand_get_fd()
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, netfs@lists.linux.dev,
 dhowells@redhat.com, jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>,
 libaokun@huaweicloud.com
References: <20240515084601.3240503-1-libaokun@huaweicloud.com>
 <20240515084601.3240503-4-libaokun@huaweicloud.com>
 <35561c99-c978-4cf6-82e9-d1308c82a7ff@linux.alibaba.com>
 <d8154eed-98d0-9cb7-4a2c-6b68ed75b7a2@huaweicloud.com>
 <d0e6d1f6-002f-4255-a481-6bd17f3da7fc@linux.alibaba.com>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <d0e6d1f6-002f-4255-a481-6bd17f3da7fc@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g6zFUtmP6KzNA--.3807S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtF4rXrW5Kw48KF4kKw4fAFb_yoW3Ar43pF
	Z3tFyxtry5GrykJr1Utr1UJryUtr1UJ3WDXr18JF18Ar4DAr1Yqr1UXr1qgryUGr48Ar4U
	Jr1UJry7Zr1UJr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
	Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjfUouWlDUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

On 2024/5/20 17:10, Jingbo Xu wrote:
>
> On 5/20/24 4:38 PM, Baokun Li wrote:
>> Hi Jingbo,
>>
>> Thanks for your review!
>>
>> On 2024/5/20 15:24, Jingbo Xu wrote:
>>> On 5/15/24 4:45 PM, libaokun@huaweicloud.com wrote:
>>>> From: Baokun Li <libaokun1@huawei.com>
>>>>
>>>> We got the following issue in a fuzz test of randomly issuing the
>>>> restore
>>>> command:
>>>>
>>>> ==================================================================
>>>> BUG: KASAN: slab-use-after-free in
>>>> cachefiles_ondemand_daemon_read+0x609/0xab0
>>>> Write of size 4 at addr ffff888109164a80 by task ondemand-04-dae/4962
>>>>
>>>> CPU: 11 PID: 4962 Comm: ondemand-04-dae Not tainted 6.8.0-rc7-dirty #542
>>>> Call Trace:
>>>>    kasan_report+0x94/0xc0
>>>>    cachefiles_ondemand_daemon_read+0x609/0xab0
>>>>    vfs_read+0x169/0xb50
>>>>    ksys_read+0xf5/0x1e0
>>>>
>>>> Allocated by task 626:
>>>>    __kmalloc+0x1df/0x4b0
>>>>    cachefiles_ondemand_send_req+0x24d/0x690
>>>>    cachefiles_create_tmpfile+0x249/0xb30
>>>>    cachefiles_create_file+0x6f/0x140
>>>>    cachefiles_look_up_object+0x29c/0xa60
>>>>    cachefiles_lookup_cookie+0x37d/0xca0
>>>>    fscache_cookie_state_machine+0x43c/0x1230
>>>>    [...]
>>>>
>>>> Freed by task 626:
>>>>    kfree+0xf1/0x2c0
>>>>    cachefiles_ondemand_send_req+0x568/0x690
>>>>    cachefiles_create_tmpfile+0x249/0xb30
>>>>    cachefiles_create_file+0x6f/0x140
>>>>    cachefiles_look_up_object+0x29c/0xa60
>>>>    cachefiles_lookup_cookie+0x37d/0xca0
>>>>    fscache_cookie_state_machine+0x43c/0x1230
>>>>    [...]
>>>> ==================================================================
>>>>
>>>> Following is the process that triggers the issue:
>>>>
>>>>        mount  |   daemon_thread1    |    daemon_thread2
>>>> ------------------------------------------------------------
>>>>    cachefiles_ondemand_init_object
>>>>     cachefiles_ondemand_send_req
>>>>      REQ_A = kzalloc(sizeof(*req) + data_len)
>>>>      wait_for_completion(&REQ_A->done)
>>>>
>>>>               cachefiles_daemon_read
>>>>                cachefiles_ondemand_daemon_read
>>>>                 REQ_A = cachefiles_ondemand_select_req
>>>>                 cachefiles_ondemand_get_fd
>>>>                 copy_to_user(_buffer, msg, n)
>>>>               process_open_req(REQ_A)
>>>>                                     ------ restore ------
>>>>                                     cachefiles_ondemand_restore
>>>>                                     xas_for_each(&xas, req, ULONG_MAX)
>>>>                                      xas_set_mark(&xas,
>>>> CACHEFILES_REQ_NEW);
>>>>
>>>>                                     cachefiles_daemon_read
>>>>                                      cachefiles_ondemand_daemon_read
>>>>                                       REQ_A =
>>>> cachefiles_ondemand_select_req
>>>>
>>>>                write(devfd, ("copen %u,%llu", msg->msg_id, size));
>>>>                cachefiles_ondemand_copen
>>>>                 xa_erase(&cache->reqs, id)
>>>>                 complete(&REQ_A->done)
>>>>      kfree(REQ_A)
>>>>                                       cachefiles_ondemand_get_fd(REQ_A)
>>>>                                        fd = get_unused_fd_flags
>>>>                                        file = anon_inode_getfile
>>>>                                        fd_install(fd, file)
>>>>                                        load = (void *)REQ_A->msg.data;
>>>>                                        load->fd = fd;
>>>>                                        // load UAF !!!
>>>>
>>>> This issue is caused by issuing a restore command when the daemon is
>>>> still
>>>> alive, which results in a request being processed multiple times thus
>>>> triggering a UAF. So to avoid this problem, add an additional reference
>>>> count to cachefiles_req, which is held while waiting and reading, and
>>>> then
>>>> released when the waiting and reading is over.
>>>>
>>>>
>>>> Note that since there is only one reference count for waiting, we
>>>> need to
>>>> avoid the same request being completed multiple times, so we can only
>>>> complete the request if it is successfully removed from the xarray.
>>> Sorry the above description makes me confused.  As the same request may
>>> be got by different daemon threads multiple times, the introduced
>>> refcount mechanism can't protect it from being completed multiple times
>>> (which is expected).  The refcount only protects it from being freed
>>> multiple times.
>> The idea here is that because the wait only holds one reference count,
>> complete(&req->done) can only be called when the req has been
>> successfully removed from the xarry, otherwise the following UAF may
>> occur:
>
> "complete(&req->done) can only be called when the req has been
> successfully removed from the xarry ..."
>
> How this is done? since the following xarray_erase() following the first
> xarray_erase() will fail as the xarray slot referred by the same id has
> already been erased?
>
>
>>>> @@ -455,7 +459,7 @@ static int cachefiles_ondemand_send_req(struct
>>>> cachefiles_object *object,
>>>>        wake_up_all(&cache->daemon_pollwq);
>>>>        wait_for_completion(&req->done);
>>>>        ret = req->error;
>>>> -    kfree(req);
>>>> +    cachefiles_req_put(req);
>>>>        return ret;
>>>>    out:
>>>>        /* Reset the object to close state in error handling path.
>>> Don't we need to also convert "kfree(req)" to cachefiles_req_put(req)
>>> for the error path of cachefiles_ondemand_send_req()?
>>>
>>> ```
>>> out:
>>>      /* Reset the object to close state in error handling path.
>>>       * If error occurs after creating the anonymous fd,
>>>       * cachefiles_ondemand_fd_release() will set object to close.
>>>       */
>>>      if (opcode == CACHEFILES_OP_OPEN)
>>>          cachefiles_ondemand_set_object_close(object);
>>>      kfree(req);
>>>      return ret;
>>> ```
>> When "goto out;" is called in cachefiles_ondemand_send_req(),
>> it means that the req is unallocated/failed to be allocated/failed to
>> be inserted into the xarry, and therefore the req can only be accessed
>> by the current function, so there is no need to consider concurrency
>> and reference counting.
> Okay I understand. But this is indeed quite confusing. I see no cost of
> also converting to cachefiles_req_put(req).
>
>
Yes, kfree(req) converts to cachefiles_req_put(req) at no cost,
but may trigger a NULL pointer dereference in cachefiles_req_put(req)
if the req has not been initialised.

-- 
With Best Regards,
Baokun Li


