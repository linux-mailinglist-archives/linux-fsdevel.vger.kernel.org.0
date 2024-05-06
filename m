Return-Path: <linux-fsdevel+bounces-18796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8B68BC63A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 05:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A092428238B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 03:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817A64315D;
	Mon,  6 May 2024 03:35:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD1738DC8;
	Mon,  6 May 2024 03:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714966504; cv=none; b=ecwYcoEjvSVpf28g6zKFH+J9KhJLaCS9R3Ps7jE1XtWIRJmX3JCPHqNM+DjbZkfXUcuz50BeC91ad4mB9GDp/yTFLbUjYMJU2HGVdw7ht+Mxjb4LWZpB15scgmG9dPZg5rfG3rDH+chZuI0o6UHl4EWFwVdxc4+8GV1voMpL+9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714966504; c=relaxed/simple;
	bh=bd/kel1UuMZLy0E/HQSnHCm4N7IeSChL7qKLK/qeVkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oI3rpuoYQ33iuTg0G005wXbAJds6UBc+CdFMh+1LtEBfTk+WAzKwzDcT+TvG9Lg7LIUseO2mezFcqNBuvYSKyYxs6GJB1gjGvKvtzO3HN8jO86lLNnF+0CpM1R+ZCHPIZt4DuQrpHDpOOHP6Kikorck18ypSWYOWxi/ScK7jNfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VXn8m0KG2z4f3nTw;
	Mon,  6 May 2024 11:34:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C1E031A0179;
	Mon,  6 May 2024 11:34:57 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g7dTzhmNL6JLw--.30952S3;
	Mon, 06 May 2024 11:34:57 +0800 (CST)
Message-ID: <8b6d5c37-69ed-0554-069e-209ce2ead016@huaweicloud.com>
Date: Mon, 6 May 2024 11:34:53 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 09/12] cachefiles: defer exposing anon_fd until after
 copy_to_user() succeeds
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hou Tao <houtao1@huawei.com>,
 libaokun@huaweicloud.com, yangerkun <yangerkun@huawei.com>
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-10-libaokun@huaweicloud.com>
 <e0fc24d5-49c5-4a75-86f9-43adc763066f@linux.alibaba.com>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <e0fc24d5-49c5-4a75-86f9-43adc763066f@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAX5g7dTzhmNL6JLw--.30952S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww4fXryxXFWUWry5Gw1Dtrb_yoW7Cr1fpF
	ZIkFW3KFy8WFW8ur97AFZ8XFySy3y8AFnrW34Fga4rArnFgr1F9r10kr98uF1rAr97Grs3
	tF4UC3s3Gr1jyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl
	6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
	04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyU
	JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUF9a9DUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

On 2024/5/6 11:24, Jingbo Xu wrote:
>
> On 4/24/24 11:39 AM, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> After installing the anonymous fd, we can now see it in userland and close
>> it. However, at this point we may not have gotten the reference count of
>> the cache, but we will put it during colse fd, so this may cause a cache
>> UAF.
> Good catch!
>
>> To avoid this, we will make the anonymous fd accessible to the userland by
>> executing fd_install() after copy_to_user() has succeeded, and by this
>> point we must have already grabbed the reference count of the cache.
> Why we must execute fd_install() after copy_to_user() has succeeded?
> Why not grab a reference to the cache before fd_install()?
Two things are actually done here:
1) Grab a reference to the cache before fd_install()
2) By kernel convention, fd is taken over by the user land after
fd_install() is executed, and the kernel does not call close_fd() after
this, so fd_install() is called after everything is ready.

Thanks,
Baokun
>
>> Suggested-by: Hou Tao <houtao1@huawei.com>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/cachefiles/ondemand.c | 53 +++++++++++++++++++++++++---------------
>>   1 file changed, 33 insertions(+), 20 deletions(-)
>>
>> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
>> index 0cf63bfedc9e..7c2d43104120 100644
>> --- a/fs/cachefiles/ondemand.c
>> +++ b/fs/cachefiles/ondemand.c
>> @@ -4,6 +4,11 @@
>>   #include <linux/uio.h>
>>   #include "internal.h"
>>   
>> +struct anon_file {
>> +	struct file *file;
>> +	int fd;
>> +};
>> +
>>   static inline void cachefiles_req_put(struct cachefiles_req *req)
>>   {
>>   	if (refcount_dec_and_test(&req->ref))
>> @@ -244,14 +249,14 @@ int cachefiles_ondemand_restore(struct cachefiles_cache *cache, char *args)
>>   	return 0;
>>   }
>>   
>> -static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
>> +static int cachefiles_ondemand_get_fd(struct cachefiles_req *req,
>> +				      struct anon_file *anon_file)
>>   {
>>   	struct cachefiles_object *object;
>>   	struct cachefiles_cache *cache;
>>   	struct cachefiles_open *load;
>> -	struct file *file;
>>   	u32 object_id;
>> -	int ret, fd;
>> +	int ret;
>>   
>>   	object = cachefiles_grab_object(req->object,
>>   			cachefiles_obj_get_ondemand_fd);
>> @@ -263,16 +268,16 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
>>   	if (ret < 0)
>>   		goto err;
>>   
>> -	fd = get_unused_fd_flags(O_WRONLY);
>> -	if (fd < 0) {
>> -		ret = fd;
>> +	anon_file->fd = get_unused_fd_flags(O_WRONLY);
>> +	if (anon_file->fd < 0) {
>> +		ret = anon_file->fd;
>>   		goto err_free_id;
>>   	}
>>   
>> -	file = anon_inode_getfile("[cachefiles]", &cachefiles_ondemand_fd_fops,
>> -				  object, O_WRONLY);
>> -	if (IS_ERR(file)) {
>> -		ret = PTR_ERR(file);
>> +	anon_file->file = anon_inode_getfile("[cachefiles]",
>> +				&cachefiles_ondemand_fd_fops, object, O_WRONLY);
>> +	if (IS_ERR(anon_file->file)) {
>> +		ret = PTR_ERR(anon_file->file);
>>   		goto err_put_fd;
>>   	}
>>   
>> @@ -281,15 +286,14 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
>>   		spin_unlock(&object->ondemand->lock);
>>   		ret = -EEXIST;
>>   		/* Avoid performing cachefiles_ondemand_fd_release(). */
>> -		file->private_data = NULL;
>> +		anon_file->file->private_data = NULL;
>>   		goto err_put_file;
>>   	}
>>   
>> -	file->f_mode |= FMODE_PWRITE | FMODE_LSEEK;
>> -	fd_install(fd, file);
>> +	anon_file->file->f_mode |= FMODE_PWRITE | FMODE_LSEEK;
>>   
>>   	load = (void *)req->msg.data;
>> -	load->fd = fd;
>> +	load->fd = anon_file->fd;
>>   	object->ondemand->ondemand_id = object_id;
>>   	spin_unlock(&object->ondemand->lock);
>>   
>> @@ -298,9 +302,11 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
>>   	return 0;
>>   
>>   err_put_file:
>> -	fput(file);
>> +	fput(anon_file->file);
>> +	anon_file->file = NULL;
>>   err_put_fd:
>> -	put_unused_fd(fd);
>> +	put_unused_fd(anon_file->fd);
>> +	anon_file->fd = ret;
>>   err_free_id:
>>   	xa_erase(&cache->ondemand_ids, object_id);
>>   err:
>> @@ -357,6 +363,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>>   	struct cachefiles_msg *msg;
>>   	size_t n;
>>   	int ret = 0;
>> +	struct anon_file anon_file;
>>   	XA_STATE(xas, &cache->reqs, cache->req_id_next);
>>   
>>   	xa_lock(&cache->reqs);
>> @@ -390,7 +397,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>>   	xa_unlock(&cache->reqs);
>>   
>>   	if (msg->opcode == CACHEFILES_OP_OPEN) {
>> -		ret = cachefiles_ondemand_get_fd(req);
>> +		ret = cachefiles_ondemand_get_fd(req, &anon_file);
>>   		if (ret)
>>   			goto out;
>>   	}
>> @@ -398,10 +405,16 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>>   	msg->msg_id = xas.xa_index;
>>   	msg->object_id = req->object->ondemand->ondemand_id;
>>   
>> -	if (copy_to_user(_buffer, msg, n) != 0) {
>> +	if (copy_to_user(_buffer, msg, n) != 0)
>>   		ret = -EFAULT;
>> -		if (msg->opcode == CACHEFILES_OP_OPEN)
>> -			close_fd(((struct cachefiles_open *)msg->data)->fd);
>> +
>> +	if (msg->opcode == CACHEFILES_OP_OPEN) {
>> +		if (ret < 0) {
>> +			fput(anon_file.file);
>> +			put_unused_fd(anon_file.fd);
>> +			goto out;
>> +		}
>> +		fd_install(anon_file.fd, anon_file.file);
>>   	}
>>   out:
>>   	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);



