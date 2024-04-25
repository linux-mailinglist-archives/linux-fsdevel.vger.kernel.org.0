Return-Path: <linux-fsdevel+bounces-17698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C847B8B1877
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 03:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 533EF28466D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 01:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A78F9F5;
	Thu, 25 Apr 2024 01:33:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE90E5672;
	Thu, 25 Apr 2024 01:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714008834; cv=none; b=WRflkUoBpJ5i8GGwds56xEC+mh7pBFhQKn35OpWdpizJFi6fQ0qgnerTCuOlcJf76D+p0CLuUje64lPcu0aiN0it0Va34cMz/z803ceM3luYA3cVHqPUtYK3Y3QBvKfUmqbnr6eM9efzQMnKx/+7KuhspM+fWgNBZ5/0+HcfB9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714008834; c=relaxed/simple;
	bh=DcnxWmmVrEIylMJfh7DRC8qVuxH3wDzB1vf+74ofhAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZyLSTUg8hMpW65EsYRBdRlCjtl0tKmeuOMMtqMXkd7Gsqk1bN/Ag7/sPH1pB+HIZrafD4SeJvjGJFt4jSr28Wr/lX1buwzDo1XBFfncYmA+z0bOb67B4Z9HtxQ9OljOqEM2+xeEMcHAv+f6ewagbI8xXFu0OpbxOB5EUX8MTDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VPz0720PBz4f3jZ6;
	Thu, 25 Apr 2024 09:33:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2699A1A0568;
	Thu, 25 Apr 2024 09:33:48 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBH4silm_UuKKw--.41818S3;
	Thu, 25 Apr 2024 09:33:47 +0800 (CST)
Message-ID: <178d23c8-40cc-f975-7043-68c0d5e15786@huaweicloud.com>
Date: Thu, 25 Apr 2024 09:33:44 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 03/12] cachefiles: fix slab-use-after-free in
 cachefiles_ondemand_get_fd()
Content-Language: en-US
To: Jia Zhu <zhujia.zj@bytedance.com>, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>,
 Hou Tao <houtao1@huawei.com>, libaokun@huaweicloud.com
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-4-libaokun@huaweicloud.com>
 <34ba3b5c-638c-4622-8bcb-a2ef74b22f69@bytedance.com>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <34ba3b5c-638c-4622-8bcb-a2ef74b22f69@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnOBH4silm_UuKKw--.41818S3
X-Coremail-Antispam: 1UD129KBjvJXoW3ZrWDWw48tF4ftw18uF1Utrb_yoWDuryDpF
	ZayFy7Jry8WrykGr1UJr1UJryrJryUJ3WDXr18XFy8Ar4DAr1Yqr1UXr1jgF1UGr48Ar4U
	Jr1UGr9rZr17JrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUWVWUuwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

Hi Jia,

On 2024/4/24 22:55, Jia Zhu wrote:
>
>
> 在 2024/4/24 11:39, libaokun@huaweicloud.com 写道:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> We got the following issue in a fuzz test of randomly issuing the 
>> restore
>> command:
>>
>> ==================================================================
>> BUG: KASAN: slab-use-after-free in 
>> cachefiles_ondemand_daemon_read+0x609/0xab0
>> Write of size 4 at addr ffff888109164a80 by task ondemand-04-dae/4962
>>
>> CPU: 11 PID: 4962 Comm: ondemand-04-dae Not tainted 6.8.0-rc7-dirty #542
>> Call Trace:
>>   kasan_report+0x94/0xc0
>>   cachefiles_ondemand_daemon_read+0x609/0xab0
>>   vfs_read+0x169/0xb50
>>   ksys_read+0xf5/0x1e0
>>
>> Allocated by task 626:
>>   __kmalloc+0x1df/0x4b0
>>   cachefiles_ondemand_send_req+0x24d/0x690
>>   cachefiles_create_tmpfile+0x249/0xb30
>>   cachefiles_create_file+0x6f/0x140
>>   cachefiles_look_up_object+0x29c/0xa60
>>   cachefiles_lookup_cookie+0x37d/0xca0
>>   fscache_cookie_state_machine+0x43c/0x1230
>>   [...]
>>
>> Freed by task 626:
>>   kfree+0xf1/0x2c0
>>   cachefiles_ondemand_send_req+0x568/0x690
>>   cachefiles_create_tmpfile+0x249/0xb30
>>   cachefiles_create_file+0x6f/0x140
>>   cachefiles_look_up_object+0x29c/0xa60
>>   cachefiles_lookup_cookie+0x37d/0xca0
>>   fscache_cookie_state_machine+0x43c/0x1230
>>   [...]
>> ==================================================================
>>
>> Following is the process that triggers the issue:
>>
>>       mount  |   daemon_thread1    |    daemon_thread2
>> ------------------------------------------------------------
>>   cachefiles_ondemand_init_object
>>    cachefiles_ondemand_send_req
>>     REQ_A = kzalloc(sizeof(*req) + data_len)
>>     wait_for_completion(&REQ_A->done)
>>
>>              cachefiles_daemon_read
>>               cachefiles_ondemand_daemon_read
>>                REQ_A = cachefiles_ondemand_select_req
>>                cachefiles_ondemand_get_fd
>>                copy_to_user(_buffer, msg, n)
>>              process_open_req(REQ_A)
>>                                    ------ restore ------
>>                                    cachefiles_ondemand_restore
>>                                    xas_for_each(&xas, req, ULONG_MAX)
>>                                     xas_set_mark(&xas, 
>> CACHEFILES_REQ_NEW);
>>
>>                                    cachefiles_daemon_read
>> cachefiles_ondemand_daemon_read
>>                                      REQ_A = 
>> cachefiles_ondemand_select_req
>>
>>               write(devfd, ("copen %u,%llu", msg->msg_id, size));
>>               cachefiles_ondemand_copen
>>                xa_erase(&cache->reqs, id)
>>                complete(&REQ_A->done)
>>     kfree(REQ_A)
>> cachefiles_ondemand_get_fd(REQ_A)
>>                                       fd = get_unused_fd_flags
>>                                       file = anon_inode_getfile
>>                                       fd_install(fd, file)
>>                                       load = (void *)REQ_A->msg.data;
>>                                       load->fd = fd;
>>                                       // load UAF !!!
>>
>> This issue is caused by issuing a restore command when the daemon is 
>> still
>> alive, which results in a request being processed multiple times thus
>> triggering a UAF. So to avoid this problem, add an additional reference
>> count to cachefiles_req, which is held while waiting and reading, and 
>> then
>> released when the waiting and reading is over.
>
> Hi Baokun,
> Thank you for catching this issue. Shall we fix this by following steps:
> cachefiles_ondemand_fd_release()
>     xas_for_each(req)
>         if req is not CACHEFILES_OP_READ
>             flush
>
> cachefiles_ondemand_restore()
>     xas_for_each(req)
>         if req is not CACHEFILES_REQ_NEW && op is (OPEN or CLOSE)
>             reset req to CACHEFILES_REQ_NEW
>
> By implementing these steps:
> 1. In real daemon failover case： only pending read reqs will be
> reserved. cachefiles_ondemand_select_req will reopen the object by
> processing READ req.
> 2. In daemon alive case： Only read reqs will be reset to
> CACHEFILES_REQ_NEW.
>
This way, in the fialover case, some processes that are being mounted
will fail, which is contrary to our intention of making the user senseless.
In my opinion, it's better to keep making users senseless.

Thanks,
Baokun
>
>>
>> Note that since there is only one reference count for waiting, we 
>> need to
>> avoid the same request being completed multiple times, so we can only
>> complete the request if it is successfully removed from the xarray.
>>
>> Fixes: e73fa11a356c ("cachefiles: add restore command to recover 
>> inflight ondemand read requests")
>> Suggested-by: Hou Tao <houtao1@huawei.com>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/cachefiles/internal.h |  1 +
>>   fs/cachefiles/ondemand.c | 44 ++++++++++++++++++++++------------------
>>   2 files changed, 25 insertions(+), 20 deletions(-)
>>
>> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
>> index d33169f0018b..7745b8abc3aa 100644
>> --- a/fs/cachefiles/internal.h
>> +++ b/fs/cachefiles/internal.h
>> @@ -138,6 +138,7 @@ static inline bool 
>> cachefiles_in_ondemand_mode(struct cachefiles_cache *cache)
>>   struct cachefiles_req {
>>       struct cachefiles_object *object;
>>       struct completion done;
>> +    refcount_t ref;
>>       int error;
>>       struct cachefiles_msg msg;
>>   };
>> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
>> index fd49728d8bae..56d12fe4bf73 100644
>> --- a/fs/cachefiles/ondemand.c
>> +++ b/fs/cachefiles/ondemand.c
>> @@ -4,6 +4,12 @@
>>   #include <linux/uio.h>
>>   #include "internal.h"
>>   +static inline void cachefiles_req_put(struct cachefiles_req *req)
>> +{
>> +    if (refcount_dec_and_test(&req->ref))
>> +        kfree(req);
>> +}
>> +
>>   static int cachefiles_ondemand_fd_release(struct inode *inode,
>>                         struct file *file)
>>   {
>> @@ -299,7 +305,6 @@ ssize_t cachefiles_ondemand_daemon_read(struct 
>> cachefiles_cache *cache,
>>   {
>>       struct cachefiles_req *req;
>>       struct cachefiles_msg *msg;
>> -    unsigned long id = 0;
>>       size_t n;
>>       int ret = 0;
>>       XA_STATE(xas, &cache->reqs, cache->req_id_next);
>> @@ -330,41 +335,39 @@ ssize_t cachefiles_ondemand_daemon_read(struct 
>> cachefiles_cache *cache,
>>         xas_clear_mark(&xas, CACHEFILES_REQ_NEW);
>>       cache->req_id_next = xas.xa_index + 1;
>> +    refcount_inc(&req->ref);
>>       xa_unlock(&cache->reqs);
>>   -    id = xas.xa_index;
>> -
>>       if (msg->opcode == CACHEFILES_OP_OPEN) {
>>           ret = cachefiles_ondemand_get_fd(req);
>>           if (ret) {
>> cachefiles_ondemand_set_object_close(req->object);
>> -            goto error;
>> +            goto out;
>>           }
>>       }
>>   -    msg->msg_id = id;
>> +    msg->msg_id = xas.xa_index;
>>       msg->object_id = req->object->ondemand->ondemand_id;
>>         if (copy_to_user(_buffer, msg, n) != 0) {
>>           ret = -EFAULT;
>>           if (msg->opcode == CACHEFILES_OP_OPEN)
>>               close_fd(((struct cachefiles_open *)msg->data)->fd);
>> -        goto error;
>>       }
>> -
>> -    /* CLOSE request has no reply */
>> -    if (msg->opcode == CACHEFILES_OP_CLOSE) {
>> -        xa_erase(&cache->reqs, id);
>> -        complete(&req->done);
>> +out:
>> +    /* Remove error request and CLOSE request has no reply */
>> +    if (ret || msg->opcode == CACHEFILES_OP_CLOSE) {
>> +        xas_reset(&xas);
>> +        xas_lock(&xas);
>> +        if (xas_load(&xas) == req) {
>> +            req->error = ret;
>> +            complete(&req->done);
>> +            xas_store(&xas, NULL);
>> +        }
>> +        xas_unlock(&xas);
>>       }
>> -
>> -    return n;
>> -
>> -error:
>> -    xa_erase(&cache->reqs, id);
>> -    req->error = ret;
>> -    complete(&req->done);
>> -    return ret;
>> +    cachefiles_req_put(req);
>> +    return ret ? ret : n;
>>   }
>>     typedef int (*init_req_fn)(struct cachefiles_req *req, void 
>> *private);
>> @@ -394,6 +397,7 @@ static int cachefiles_ondemand_send_req(struct 
>> cachefiles_object *object,
>>           goto out;
>>       }
>>   +    refcount_set(&req->ref, 1);
>>       req->object = object;
>>       init_completion(&req->done);
>>       req->msg.opcode = opcode;
>> @@ -455,7 +459,7 @@ static int cachefiles_ondemand_send_req(struct 
>> cachefiles_object *object,
>>       wake_up_all(&cache->daemon_pollwq);
>>       wait_for_completion(&req->done);
>>       ret = req->error;
>> -    kfree(req);
>> +    cachefiles_req_put(req);
>>       return ret;
>>   out:
>>       /* Reset the object to close state in error handling path.



