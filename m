Return-Path: <linux-fsdevel+bounces-19767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C678C9A24
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 11:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 226E9B20BAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 09:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DD11CA87;
	Mon, 20 May 2024 09:10:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A29249E8;
	Mon, 20 May 2024 09:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716196228; cv=none; b=S4kvQyTLJuXv01fOkk/JMd21MfgzkO1wosplJWGDtNouI0vQwwWZv5uBxqHXQDI6QGlAxoslqws+5FlDzdlm8pBQRqzqFfgO5f0Il2ouasK/7iXvSJb1XcTNJBXv6Ay36LYd40OMdLElt4vhoKEBa7E0/WtHdud5Xq2r05KejsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716196228; c=relaxed/simple;
	bh=dkc9SeriLESIPD8Vy3bcYCEZpLyCaXbyMfHcy6i2hVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=urmqe70ojNlVo56KpHeblQq153khu5V40H24R53vTDRVey8rCGg4q9+4SwxEBKvU2gmyId+RmNwhNIob2MqDCMtKRL7P1zNRU9/WBDQ3uJ6MrvPzX4staryWZwFC1aLVxd+pIuhkKjCzWrDUFjBi3y3VksfeIZL4XYLj1ytqRck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VjWxL5MHrz4f3jMv;
	Mon, 20 May 2024 17:10:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9AA5D1A01D2;
	Mon, 20 May 2024 17:10:23 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RF8E0tmgwizNA--.16021S3;
	Mon, 20 May 2024 17:10:23 +0800 (CST)
Message-ID: <51c0154a-608f-1d96-1292-d2b01b184ade@huaweicloud.com>
Date: Mon, 20 May 2024 17:10:20 +0800
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
 <7d24fa89-0995-4104-84f1-dac6c8bf4477@linux.alibaba.com>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <7d24fa89-0995-4104-84f1-dac6c8bf4477@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAX6RF8E0tmgwizNA--.16021S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZF1UAFyruw43CryUuw43GFg_yoWrJFWxpF
	ZIya4IyFy8WrW8Crs7ZF15Jr1rJ3y8AFnrWr10qFyIyr4qkr1Fvr17tr1FqF98Cr9FkF4q
	q3WDuF9rX34qy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWr
	Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUp6wZUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

On 2024/5/20 16:06, Jingbo Xu wrote:
>
> On 5/15/24 4:45 PM, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> We got the following issue in a fuzz test of randomly issuing the restore
>> command:
>>
>> ==================================================================
>> BUG: KASAN: slab-use-after-free in cachefiles_ondemand_daemon_read+0x609/0xab0
>> Write of size 4 at addr ffff888109164a80 by task ondemand-04-dae/4962
>>
>> CPU: 11 PID: 4962 Comm: ondemand-04-dae Not tainted 6.8.0-rc7-dirty #542
>> Call Trace:
>>   kasan_report+0x94/0xc0
>>   cachefiles_ondemand_daemon_read+0x609/0xab0
>>   vfs_read+0x169/0xb50
>>   ksys_read+0xf5/0x1e0
>>
>> Allocated by task 626:
>>   __kmalloc+0x1df/0x4b0
>>   cachefiles_ondemand_send_req+0x24d/0x690
>>   cachefiles_create_tmpfile+0x249/0xb30
>>   cachefiles_create_file+0x6f/0x140
>>   cachefiles_look_up_object+0x29c/0xa60
>>   cachefiles_lookup_cookie+0x37d/0xca0
>>   fscache_cookie_state_machine+0x43c/0x1230
>>   [...]
>>
>> Freed by task 626:
>>   kfree+0xf1/0x2c0
>>   cachefiles_ondemand_send_req+0x568/0x690
>>   cachefiles_create_tmpfile+0x249/0xb30
>>   cachefiles_create_file+0x6f/0x140
>>   cachefiles_look_up_object+0x29c/0xa60
>>   cachefiles_lookup_cookie+0x37d/0xca0
>>   fscache_cookie_state_machine+0x43c/0x1230
>>   [...]
>> ==================================================================
>>
>> Following is the process that triggers the issue:
>>
>>       mount  |   daemon_thread1    |    daemon_thread2
>> ------------------------------------------------------------
>>   cachefiles_ondemand_init_object
>>    cachefiles_ondemand_send_req
>>     REQ_A = kzalloc(sizeof(*req) + data_len)
>>     wait_for_completion(&REQ_A->done)
>>
>>              cachefiles_daemon_read
>>               cachefiles_ondemand_daemon_read
>>                REQ_A = cachefiles_ondemand_select_req
>>                cachefiles_ondemand_get_fd
>>                copy_to_user(_buffer, msg, n)
>>              process_open_req(REQ_A)
>>                                    ------ restore ------
>>                                    cachefiles_ondemand_restore
>>                                    xas_for_each(&xas, req, ULONG_MAX)
>>                                     xas_set_mark(&xas, CACHEFILES_REQ_NEW);
>>
>>                                    cachefiles_daemon_read
>>                                     cachefiles_ondemand_daemon_read
>>                                      REQ_A = cachefiles_ondemand_select_req
>>
>>               write(devfd, ("copen %u,%llu", msg->msg_id, size));
>>               cachefiles_ondemand_copen
>>                xa_erase(&cache->reqs, id)
>>                complete(&REQ_A->done)
>>     kfree(REQ_A)
>>                                      cachefiles_ondemand_get_fd(REQ_A)
>>                                       fd = get_unused_fd_flags
>>                                       file = anon_inode_getfile
>>                                       fd_install(fd, file)
>>                                       load = (void *)REQ_A->msg.data;
>>                                       load->fd = fd;
>>                                       // load UAF !!!
>>
>> This issue is caused by issuing a restore command when the daemon is still
>> alive, which results in a request being processed multiple times thus
>> triggering a UAF. So to avoid this problem, add an additional reference
>> count to cachefiles_req, which is held while waiting and reading, and then
>> released when the waiting and reading is over.
>>
>> Note that since there is only one reference count for waiting, we need to
>> avoid the same request being completed multiple times, so we can only
>> complete the request if it is successfully removed from the xarray.
>>
>> Fixes: e73fa11a356c ("cachefiles: add restore command to recover inflight ondemand read requests")
>> Suggested-by: Hou Tao <houtao1@huawei.com>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
> How could we protect it from being erased from the xarray with the same
> message id in this case?

We will hold xa_lock while erasing the id to avoid concurrency.

-- 
With Best Regards,
Baokun Li


