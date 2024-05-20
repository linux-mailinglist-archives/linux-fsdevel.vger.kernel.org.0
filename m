Return-Path: <linux-fsdevel+bounces-19764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885F78C9A18
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 11:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA4A1C20AA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 09:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075621CAA2;
	Mon, 20 May 2024 09:07:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172D03FBB2;
	Mon, 20 May 2024 09:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716196054; cv=none; b=iG9nT/7cOJhN8HeVmZXUXpe7oA/yvaGBRpntyFVQumxqCnoRB8K82QxiNpmQMh4PWdYao/tDQg1Zp17VvNfZSaGGoIi68mtEeKZ7d8Tl1j8UM6UJiagCCpUf8LBZ6ukRUTGpfvMWe2RZcW0SljfY9LYkxum91RVvVKpjwIjXyM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716196054; c=relaxed/simple;
	bh=ib5CLMDc2aaE4jFTePgzuTCNvu8mWqSWyEWzHG2rmYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V4ClhHGeQzzSsIUTYZZ5IOx5wJmWHJ5Ervz8SBVqjaZRBG8KVcyEX3V0vxkxh4IvkX4FxakG5DCgE60B96pIVaiRPMsJ0y0gmjxh4PfmjdTQfDg0Oo/vgRPSmTTi89EnGT98PojFA0nN06lo9THSeNAZXPRghqa5Seibo58icEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VjWsz6Tkqz4f3jct;
	Mon, 20 May 2024 17:07:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BF4D71A017F;
	Mon, 20 May 2024 17:07:28 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ7MEktmDtmyNA--.20085S3;
	Mon, 20 May 2024 17:07:28 +0800 (CST)
Message-ID: <d62b162d-acb3-2fa7-085e-79da3278091a@huaweicloud.com>
Date: Mon, 20 May 2024 17:07:24 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 08/12] cachefiles: never get a new anonymous fd if
 ondemand_id is valid
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, netfs@lists.linux.dev,
 dhowells@redhat.com, jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>,
 libaokun@huaweicloud.com
References: <20240515084601.3240503-1-libaokun@huaweicloud.com>
 <20240515084601.3240503-9-libaokun@huaweicloud.com>
 <f4d24738-76a2-4998-9a28-493599cd7eae@linux.alibaba.com>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <f4d24738-76a2-4998-9a28-493599cd7eae@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBHZQ7MEktmDtmyNA--.20085S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKw18JFyUZFykZw4kAryxXwb_yoW7Kr47pF
	Waya43KFyxWF1xGrZ7ZFs8XryFy3y8ZFnrWw1aga48Arn8ur1rur17tr1SvF98Ar9agrs7
	ta1UuF9xK34qy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWU
	JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbE_M3UUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

On 2024/5/20 16:43, Jingbo Xu wrote:
>
> On 5/15/24 4:45 PM, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> Now every time the daemon reads an open request, it gets a new anonymous fd
>> and ondemand_id. With the introduction of "restore", it is possible to read
>> the same open request more than once, and therefore an object can have more
>> than one anonymous fd.
>>
>> If the anonymous fd is not unique, the following concurrencies will result
>> in an fd leak:
>>
>>       t1     |         t2         |          t3
>> ------------------------------------------------------------
>>   cachefiles_ondemand_init_object
>>    cachefiles_ondemand_send_req
>>     REQ_A = kzalloc(sizeof(*req) + data_len)
>>     wait_for_completion(&REQ_A->done)
>>              cachefiles_daemon_read
>>               cachefiles_ondemand_daemon_read
>>                REQ_A = cachefiles_ondemand_select_req
>>                cachefiles_ondemand_get_fd
>>                  load->fd = fd0
>>                  ondemand_id = object_id0
>>                                    ------ restore ------
>>                                    cachefiles_ondemand_restore
>>                                     // restore REQ_A
>>                                    cachefiles_daemon_read
>>                                     cachefiles_ondemand_daemon_read
>>                                      REQ_A = cachefiles_ondemand_select_req
>>                                        cachefiles_ondemand_get_fd
>>                                          load->fd = fd1
>>                                          ondemand_id = object_id1
>>               process_open_req(REQ_A)
>>               write(devfd, ("copen %u,%llu", msg->msg_id, size))
>>               cachefiles_ondemand_copen
>>                xa_erase(&cache->reqs, id)
>>                complete(&REQ_A->done)
>>     kfree(REQ_A)
>>                                    process_open_req(REQ_A)
>>                                    // copen fails due to no req
>>                                    // daemon close(fd1)
>>                                    cachefiles_ondemand_fd_release
>>                                     // set object closed
>>   -- umount --
>>   cachefiles_withdraw_cookie
>>    cachefiles_ondemand_clean_object
>>     cachefiles_ondemand_init_close_req
>>      if (!cachefiles_ondemand_object_is_open(object))
>>        return -ENOENT;
>>      // The fd0 is not closed until the daemon exits.
>>
>> However, the anonymous fd holds the reference count of the object and the
>> object holds the reference count of the cookie. So even though the cookie
>> has been relinquished, it will not be unhashed and freed until the daemon
>> exits.
>>
>> In fscache_hash_cookie(), when the same cookie is found in the hash list,
>> if the cookie is set with the FSCACHE_COOKIE_RELINQUISHED bit, then the new
>> cookie waits for the old cookie to be unhashed, while the old cookie is
>> waiting for the leaked fd to be closed, if the daemon does not exit in time
>> it will trigger a hung task.
>>
>> To avoid this, allocate a new anonymous fd only if no anonymous fd has
>> been allocated (ondemand_id == 0) or if the previously allocated anonymous
>> fd has been closed (ondemand_id == -1). Moreover, returns an error if
>> ondemand_id is valid, letting the daemon know that the current userland
>> restore logic is abnormal and needs to be checked.
>>
>> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> The LOCs of this fix is quite under control.  But still it seems that
> the worst consequence is that the (potential) malicious daemon gets
> hung.  No more effect to the system or other processes.  Or does a
> non-malicious daemon have any chance having the same issue?
If we enable hung_task_panic, it may cause panic to crash the server.
>> ---
>>   fs/cachefiles/ondemand.c | 34 ++++++++++++++++++++++++++++------
>>   1 file changed, 28 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
>> index d04ddc6576e3..d2d4e27fca6f 100644
>> --- a/fs/cachefiles/ondemand.c
>> +++ b/fs/cachefiles/ondemand.c
>> @@ -14,11 +14,18 @@ static int cachefiles_ondemand_fd_release(struct inode *inode,
>>   					  struct file *file)
>>   {
>>   	struct cachefiles_object *object = file->private_data;
>> -	struct cachefiles_cache *cache = object->volume->cache;
>> -	struct cachefiles_ondemand_info *info = object->ondemand;
>> +	struct cachefiles_cache *cache;
>> +	struct cachefiles_ondemand_info *info;
>>   	int object_id;
>>   	struct cachefiles_req *req;
>> -	XA_STATE(xas, &cache->reqs, 0);
>> +	XA_STATE(xas, NULL, 0);
>> +
>> +	if (!object)
>> +		return 0;
>> +
>> +	info = object->ondemand;
>> +	cache = object->volume->cache;
>> +	xas.xa = &cache->reqs;
>>   
>>   	xa_lock(&cache->reqs);
>>   	spin_lock(&info->lock);
>> @@ -288,22 +295,39 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
>>   		goto err_put_fd;
>>   	}
>>   
>> +	spin_lock(&object->ondemand->lock);
>> +	if (object->ondemand->ondemand_id > 0) {
>> +		spin_unlock(&object->ondemand->lock);
>> +		/* Pair with check in cachefiles_ondemand_fd_release(). */
>> +		file->private_data = NULL;
>> +		ret = -EEXIST;
>> +		goto err_put_file;
>> +	}
>> +
>>   	file->f_mode |= FMODE_PWRITE | FMODE_LSEEK;
>>   	fd_install(fd, file);
>>   
>>   	load = (void *)req->msg.data;
>>   	load->fd = fd;
>>   	object->ondemand->ondemand_id = object_id;
>> +	spin_unlock(&object->ondemand->lock);
>>   
>>   	cachefiles_get_unbind_pincount(cache);
>>   	trace_cachefiles_ondemand_open(object, &req->msg, load);
>>   	return 0;
>>   
>> +err_put_file:
>> +	fput(file);
>>   err_put_fd:
>>   	put_unused_fd(fd);
>>   err_free_id:
>>   	xa_erase(&cache->ondemand_ids, object_id);
>>   err:
>> +	spin_lock(&object->ondemand->lock);
>> +	/* Avoid marking an opened object as closed. */
>> +	if (object->ondemand->ondemand_id <= 0)
>> +		cachefiles_ondemand_set_object_close(object);
>> +	spin_unlock(&object->ondemand->lock);
>>   	cachefiles_put_object(object, cachefiles_obj_put_ondemand_fd);
>>   	return ret;
>>   }
>> @@ -386,10 +410,8 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>>   
>>   	if (msg->opcode == CACHEFILES_OP_OPEN) {
>>   		ret = cachefiles_ondemand_get_fd(req);
>> -		if (ret) {
>> -			cachefiles_ondemand_set_object_close(req->object);
>> +		if (ret)
>>   			goto out;
>> -		}
>>   	}
>>   
>>   	msg->msg_id = xas.xa_index;

-- 
With Best Regards,
Baokun Li


