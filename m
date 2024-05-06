Return-Path: <linux-fsdevel+bounces-18794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 229F08BC630
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 05:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61BB9B212D2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 03:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564E843144;
	Mon,  6 May 2024 03:23:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725E03F9EC;
	Mon,  6 May 2024 03:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714965827; cv=none; b=ftV6qqWU9Lj3dQxhRwin90hIt9Gkywi06QU29lllI4L7HDt8bLgGO68dYZERSs5LMO9XP4Wg27d8gH+xYU2GeZjzM3eZIugB1Fh2DJjkJbznh5xq5LypUbI1eIABoOnp/chl2W6voVHWo8hj/yNlZ8q2E+e72otkT+M5JMR4Bd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714965827; c=relaxed/simple;
	bh=UZMWj0o8HJjobUzCMwhoUcqFCcq5NUQ2GcZ27PWTaOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rR0qFOrFyVj7jFj1od0/sAt7Xjs500BTVeuCNKG5XW5fHmxo2akBvbFhNP2Q2WCQ0sND7QCrgJSxW2M3WFbqyXaheLzlVZKthFwexKKEfGYCHh0D6LoYMQUx3U55UjA0lw/834DGTLLTzsbAzO6ZsNqHVzL2OS5uowBeHBtDZG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VXmvm339yz4f3jXv;
	Mon,  6 May 2024 11:23:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 946CB1A016E;
	Mon,  6 May 2024 11:23:40 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBE4TThmwQSJLw--.25496S3;
	Mon, 06 May 2024 11:23:40 +0800 (CST)
Message-ID: <18cc6974-b47d-f9fd-2576-366382d0e8d0@huaweicloud.com>
Date: Mon, 6 May 2024 11:23:36 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 07/12] cachefiles: add spin_lock for
 cachefiles_ondemand_info
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, libaokun@huaweicloud.com,
 yangerkun <yangerkun@huawei.com>
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-8-libaokun@huaweicloud.com>
 <1fef9ab5-ec33-4a14-beb3-ada41a8652b3@linux.alibaba.com>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <1fef9ab5-ec33-4a14-beb3-ada41a8652b3@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBXKBE4TThmwQSJLw--.25496S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCr18uw17tw47Xr43Jw4ktFb_yoW7JF13pF
	WayFy3KryxWF1xur97Aan8WrWFy34jvFnrWr1aga4rA3s09ryrZr17tryrZF98AryfKrs7
	tw48Casrtryqy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
	Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUZa9-UUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

On 2024/5/6 10:55, Jingbo Xu wrote:
>
> On 4/24/24 11:39 AM, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> The following concurrency may cause a read request to fail to be completed
>> and result in a hung:
>>
>>             t1             |             t2
>> ---------------------------------------------------------
>>                              cachefiles_ondemand_copen
>>                                req = xa_erase(&cache->reqs, id)
>> // Anon fd is maliciously closed.
>> cachefiles_ondemand_fd_release
>>    xa_lock(&cache->reqs)
>>    cachefiles_ondemand_set_object_close(object)
>>    xa_unlock(&cache->reqs)
>>                                cachefiles_ondemand_set_object_open
>>                                // No one will ever close it again.
>> cachefiles_ondemand_daemon_read
>>    cachefiles_ondemand_select_req
>>    // Get a read req but its fd is already closed.
>>    // The daemon can't issue a cread ioctl with an closed fd, then hung.
>>
>> So add spin_lock for cachefiles_ondemand_info to protect ondemand_id and
>> state, thus we can avoid the above problem in cachefiles_ondemand_copen()
>> by using ondemand_id to determine if fd has been released.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> This indeed looks like a reasonable scenario where the kernel side
> should fix, as a non-malicious daemon could also run into this.
>
> How about reusing &cache->reqs spinlock rather than introducing a new
> spinlock, as &cache->reqs spinlock is already held when setting object
> to close state in cachefiles_ondemand_fd_release()?
We've considered reusing &cache->reqs spinlock before, but their
uses don't exactly overlap, and there are patches coming that will
use the new spin_lock,. In addition, this reduces competition for
&cache->reqs spinlock.
>> ---
>>   fs/cachefiles/internal.h |  1 +
>>   fs/cachefiles/ondemand.c | 16 +++++++++++++++-
>>   2 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
>> index 7745b8abc3aa..45c8bed60538 100644
>> --- a/fs/cachefiles/internal.h
>> +++ b/fs/cachefiles/internal.h
>> @@ -55,6 +55,7 @@ struct cachefiles_ondemand_info {
>>   	int				ondemand_id;
>>   	enum cachefiles_object_state	state;
>>   	struct cachefiles_object	*object;
>> +	spinlock_t			lock;
>>   };
>>   
>>   /*
>> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
>> index 898fab68332b..b5e6a851ef04 100644
>> --- a/fs/cachefiles/ondemand.c
>> +++ b/fs/cachefiles/ondemand.c
>> @@ -16,13 +16,16 @@ static int cachefiles_ondemand_fd_release(struct inode *inode,
>>   	struct cachefiles_object *object = file->private_data;
>>   	struct cachefiles_cache *cache = object->volume->cache;
>>   	struct cachefiles_ondemand_info *info = object->ondemand;
>> -	int object_id = info->ondemand_id;
>> +	int object_id;
>>   	struct cachefiles_req *req;
>>   	XA_STATE(xas, &cache->reqs, 0);
>>   
>>   	xa_lock(&cache->reqs);
>> +	spin_lock(&info->lock);
>> +	object_id = info->ondemand_id;
>>   	info->ondemand_id = CACHEFILES_ONDEMAND_ID_CLOSED;
>>   	cachefiles_ondemand_set_object_close(object);
>> +	spin_unlock(&info->lock);
>>   
>>   	/* Only flush CACHEFILES_REQ_NEW marked req to avoid race with daemon_read */
>>   	xas_for_each_marked(&xas, req, ULONG_MAX, CACHEFILES_REQ_NEW) {
>> @@ -127,6 +130,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>>   {
>>   	struct cachefiles_req *req;
>>   	struct fscache_cookie *cookie;
>> +	struct cachefiles_ondemand_info *info;
>>   	char *pid, *psize;
>>   	unsigned long id;
>>   	long size;
>> @@ -185,6 +189,14 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>>   		goto out;
>>   	}
>>   
>> +	info = req->object->ondemand;
>> +	spin_lock(&info->lock);
>> +	/* The anonymous fd was closed before copen ? */
> I would like describe more details in the comment, e.g. put the time
> sequence described in the commit message here.
OK, thanks for your suggestion, I will describe it in more detail
in the next revision.

Thanks,
Baokun
>
>> +	if (info->ondemand_id == CACHEFILES_ONDEMAND_ID_CLOSED) {
>> +		spin_unlock(&info->lock);
>> +		req->error = -EBADFD;
>> +		goto out;
>> +	}
>>   	cookie = req->object->cookie;
>>   	cookie->object_size = size;
>>   	if (size)
>> @@ -194,6 +206,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>>   	trace_cachefiles_ondemand_copen(req->object, id, size);
>>   
>>   	cachefiles_ondemand_set_object_open(req->object);
>> +	spin_unlock(&info->lock);
>>   	wake_up_all(&cache->daemon_pollwq);
>>   
>>   out:
>> @@ -596,6 +609,7 @@ int cachefiles_ondemand_init_obj_info(struct cachefiles_object *object,
>>   		return -ENOMEM;
>>   
>>   	object->ondemand->object = object;
>> +	spin_lock_init(&object->ondemand->lock);
>>   	INIT_WORK(&object->ondemand->ondemand_work, ondemand_object_worker);
>>   	return 0;
>>   }



