Return-Path: <linux-fsdevel+bounces-18887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5038BDE62
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 11:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A1CB2866DF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 09:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E9414EC41;
	Tue,  7 May 2024 09:32:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6FF14E2E4;
	Tue,  7 May 2024 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074370; cv=none; b=ljj0O4Znom4JSJ5ENlfjr9FWpcGKKye/4Fz/J9zvDhlyB0LLp1QIcqf8J5aMwTmUuiSRs4/k7xu/lOXz11Kc/WzF3m/rlNib/L4XjjGASNCG8nOgKZ9XTyE3gSbX64Z/wG7Pm1zL6qN7f+Bm1ymoxgsU0Ywj2bZFhizuox++Z5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074370; c=relaxed/simple;
	bh=QWEBtmOnxBgInrUWtYXy54jN0BcfjzLNlCGWLtloyVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LppMt1UTSLaQxtIdZNbi18BY+gjdhuiY27J7gJtyyGtU0iMhX9UW5r7+ZtbVBuc/QPDlv6Etg5KEEWzSP+aE/xVnStPvCEJM/r/VTLEm8+Rr0oLdXKZsuWASRYuDeLvCLXG0Wox8Yi9Sh73AACs5oILkUPC6TWwKIOzv9vnOFv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VYY381TfDz4f3xsJ;
	Tue,  7 May 2024 17:32:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 77FA51A016E;
	Tue,  7 May 2024 17:32:41 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBE19Tlmph79Lw--.16187S3;
	Tue, 07 May 2024 17:32:41 +0800 (CST)
Message-ID: <e0c5708c-67c0-770b-6dd4-d85102bf6600@huaweicloud.com>
Date: Tue, 7 May 2024 17:32:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 08/12] cachefiles: never get a new anon fd if ondemand_id
 is valid
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun <yangerkun@huawei.com>,
 libaokun@huaweicloud.com
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-9-libaokun@huaweicloud.com>
 <625acc9e-b871-4912-965e-82fe3f9228d7@linux.alibaba.com>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <625acc9e-b871-4912-965e-82fe3f9228d7@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCXaBE19Tlmph79Lw--.16187S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAFW5Zr4kXFy8Zw4fZr1fZwb_yoWrur4DpF
	Way3W3KFyxWF1xWrZ7AFs5WFyFy34kZFnrWa4aga4UArn09r1fZr17trnxZFn8A3s7Wrsr
	tF4UWr9xKw1qk3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

Hi Jingbo,

On 2024/5/6 11:09, Jingbo Xu wrote:
>
> On 4/24/24 11:39 AM, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> Now every time the daemon reads an open request, it requests a new anon fd
>> and ondemand_id. With the introduction of "restore", it is possible to read
>> the same open request more than once, and therefore have multiple anon fd's
>> for the same object.
>>
>> To avoid this, allocate a new anon fd only if no anon fd has been allocated
>> (ondemand_id == 0) or if the previously allocated anon fd has been closed
>> (ondemand_id == -1). Returns an error if ondemand_id is valid, letting the
>> daemon know that the current userland restore logic is abnormal and needs
>> to be checked.
> I have no obvious preference on strengthening this on kernel side or
> not.  Could you explain more about what will happen if the daemon gets
> several distinct anon fd corresponding to one same object?  IMHO the
> daemon should expect the side effect if it issues a 'restore' command
> when the daemon doesn't crash.  IOW, it's something that shall be fixed
> or managed either on the kernel side, or on the daemon side.
If the anon_fd is not unique, the daemon will only close the anon_fd
corresponding to the newest object_id during drop_object, and the
other anon_fds will not be closed until the daemon exits.

However, the anon_fd holds the reference count of the object, so the
object will not be freed, and the cookie will also not be freed. So
mounting a same-named image at this point will cause a hung task
in fscache_hash_cookie() by waiting for the cookie to unhash.

The object_id and anon_fd of an object are supposed to be unique
under normal circumstances, this patch just provides that guarantee
even in the case of an exception.

Thank you very much for the review!

Regards,
Baokun
>> ---
>>   fs/cachefiles/ondemand.c | 34 ++++++++++++++++++++++++++++------
>>   1 file changed, 28 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
>> index b5e6a851ef04..0cf63bfedc9e 100644
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
>> @@ -269,22 +276,39 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
>>   		goto err_put_fd;
>>   	}
>>   
>> +	spin_lock(&object->ondemand->lock);
>> +	if (object->ondemand->ondemand_id > 0) {
>> +		spin_unlock(&object->ondemand->lock);
>> +		ret = -EEXIST;
>> +		/* Avoid performing cachefiles_ondemand_fd_release(). */
>> +		file->private_data = NULL;
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
>> @@ -367,10 +391,8 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
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



