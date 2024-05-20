Return-Path: <linux-fsdevel+bounces-19747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 540D78C989A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 06:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC18C1F21DC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 04:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9802511CAB;
	Mon, 20 May 2024 04:11:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657E58BEA;
	Mon, 20 May 2024 04:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716178304; cv=none; b=TpOb5OIF9hnIUyIbRV/aqrWqDcAukLynUH3sbcx1GwWRtpCJHW8gv/JUcUwAilDcGDoC8JHF9BmTe8ibd7iRkqLeGU0eOzxV7UfnBOnSFbvDFV8J85dllxWVBX/jYq8fRyFtiXT3B+nv3xwvfMoeJg/imhZ5T+9d7+oxs6V1C+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716178304; c=relaxed/simple;
	bh=tC9LDlard4zMxRtR34xcZn5d3Ak4zn3+EvL0kLQG+Dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HSgF1e/4Qy+AQXMxqHfn5akoM1uYS5mj0mW8NM1phe0/Tm2d6ypPTzVX61yKx6aI9XnqcxYoyaA+guAT4LMfbXY6CI1GutpOGFca3FxVCuwMq7NsjKyL+LH6O9BjwvgwB0u0NzkofYHUDzqUJgzIPObgstFfnoukBYtvWPB3t0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VjPJj0JWMz4f3jLf;
	Mon, 20 May 2024 12:11:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BA2751A0C77;
	Mon, 20 May 2024 12:11:38 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBF3zUpmeOWfNA--.60503S3;
	Mon, 20 May 2024 12:11:38 +0800 (CST)
Message-ID: <0867a1de-12c5-5e0f-c9e9-0d24cab37512@huaweicloud.com>
Date: Mon, 20 May 2024 12:11:35 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 01/12] cachefiles: remove request from xarry during
 flush requests
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, netfs@lists.linux.dev,
 dhowells@redhat.com, jlayton@kernel.org
Cc: jefflexu@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>,
 libaokun@huaweicloud.com
References: <20240515084601.3240503-1-libaokun@huaweicloud.com>
 <20240515084601.3240503-2-libaokun@huaweicloud.com>
 <a440cd35-18ce-4943-b370-c92f761d9bcf@linux.alibaba.com>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <a440cd35-18ce-4943-b370-c92f761d9bcf@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnOBF3zUpmeOWfNA--.60503S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4kuF1DXr4fKrW5XF45GFg_yoW5Gw1rpF
	WSyFy7Gry8Wr1kGr1DJF1UJry8J348J3WUXr1UXF18Jr4DAr1Yqr47Xr10gryUJrW8Jr4U
	Jr1UGr9rZryUJw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWU
	JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUF9a9DUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

On 2024/5/20 10:20, Gao Xiang wrote:
>
>
> On 2024/5/15 16:45, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>
>
> The subject line can be
> "cachefiles: remove requests from xarray during flushing requests"
Thank you very much for the correction! I will update my patch.
>
>>
>> Even with CACHEFILES_DEAD set, we can still read the requests, so in the
>> following concurrency the request may be used after it has been freed:
>>
>>       mount  |   daemon_thread1    |    daemon_thread2
>> ------------------------------------------------------------
>>   cachefiles_ondemand_init_object
>>    cachefiles_ondemand_send_req
>>     REQ_A = kzalloc(sizeof(*req) + data_len)
>>     wait_for_completion(&REQ_A->done)
>>              cachefiles_daemon_read
>>               cachefiles_ondemand_daemon_read
>>                                    // close dev fd
>>                                    cachefiles_flush_reqs
>> complete(&REQ_A->done)
>>     kfree(REQ_A)
>>                xa_lock(&cache->reqs);
>>                cachefiles_ondemand_select_req
>>                  req->msg.opcode != CACHEFILES_OP_READ
>>                  // req use-after-free !!!
>>                xa_unlock(&cache->reqs);
>> xa_destroy(&cache->reqs)
>>
>> Hence remove requests from cache->reqs when flushing them to avoid
>> accessing freed requests.
>>
>> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking 
>> up cookie")
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>
> Thanks,
> Gao Xiang
Thanks a lot for the review!

Cheers,
Baokun
>
>> ---
>>   fs/cachefiles/daemon.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
>> index 6465e2574230..ccb7b707ea4b 100644
>> --- a/fs/cachefiles/daemon.c
>> +++ b/fs/cachefiles/daemon.c
>> @@ -159,6 +159,7 @@ static void cachefiles_flush_reqs(struct 
>> cachefiles_cache *cache)
>>       xa_for_each(xa, index, req) {
>>           req->error = -EIO;
>>           complete(&req->done);
>> +        __xa_erase(xa, index);
>>       }
>>       xa_unlock(xa);

-- 
With Best Regards,
Baokun Li


