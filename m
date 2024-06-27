Return-Path: <linux-fsdevel+bounces-22618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0164291A4F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 13:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333521C2194A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 11:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D9A149C60;
	Thu, 27 Jun 2024 11:20:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95991487FF;
	Thu, 27 Jun 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719487232; cv=none; b=jHJZ5XmB7o7H2q2tdlSXUH4REc3UBOBWcO/rA2JcOuZkU08bEQeS12Ykhdacai+VdZQ6Q3idu+mTIZywRiFMItXIk/sCeoMFyHeFx5zciytevVpufHPedh54r1jsa7wmJGx0067lY3uW1aMg6811DWrB0/FIntSqHZug6z3f/ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719487232; c=relaxed/simple;
	bh=PvUpyOjvw1mgG8WG6FE7OGft/N0VBjo1rF+T7smm0d4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YRTR3gJlkFNkoXEG0jNgpy8af9JpA/rGzdWMzOKzafKQJr1TL05tntwjslGL19qKpvnLm0toHwk3NgKKj5qYBDifUBbMUqkiTVOUXULnRPT7dJWe6s5p5cqhJwrH2GY3ymVqS6DFkKhp/ff8sZA3KUqywC3FWF4ZiH4daQS/vuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W8x1h0dMCz4f3kvd;
	Thu, 27 Jun 2024 19:20:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4A7F31A0572;
	Thu, 27 Jun 2024 19:20:20 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgAHMn7wSn1mf_TkAQ--.45094S3;
	Thu, 27 Jun 2024 19:20:20 +0800 (CST)
Message-ID: <e40b80fc-52b8-4f89-800a-3ffa0034a072@huaweicloud.com>
Date: Thu, 27 Jun 2024 19:20:16 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] cachefiles: flush all requests for the object that
 is being dropped
To: Jeff Layton <jlayton@kernel.org>
Cc: netfs@lists.linux.dev, dhowells@redhat.com, hsiangkao@linux.alibaba.com,
 jefflexu@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>,
 Baokun Li <libaokun@huaweicloud.com>
References: <20240515125136.3714580-1-libaokun@huaweicloud.com>
 <20240515125136.3714580-3-libaokun@huaweicloud.com>
 <5bb711c4bbc59ea9fff486a86acce13880823e7b.camel@kernel.org>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <5bb711c4bbc59ea9fff486a86acce13880823e7b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAHMn7wSn1mf_TkAQ--.45094S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CF45KrW5JFy3Kw4rtF4rAFb_yoW8Kw4rpF
	Waya4akFy8uFsrKrs7XFZ8ZrySy3ykZFnrXF1aqa4jyrn0qrnY9r1UKr1DWF1UArs3Jr4x
	tr4UuF93Kryqq3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
	UUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAHBV1jkHqw9wABsS

On 2024/6/27 19:01, Jeff Layton wrote:
> On Wed, 2024-05-15 at 20:51 +0800, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> Because after an object is dropped, requests for that object are
>> useless,
>> flush them to avoid causing other problems.
>>
>> This prepares for the later addition of cancel_work_sync(). After the
>> reopen requests is generated, flush it to avoid cancel_work_sync()
>> blocking by waiting for daemon to complete the reopen requests.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/cachefiles/ondemand.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
>> index 73da4d4eaa9b..d24bff43499b 100644
>> --- a/fs/cachefiles/ondemand.c
>> +++ b/fs/cachefiles/ondemand.c
>> @@ -564,12 +564,31 @@ int cachefiles_ondemand_init_object(struct
>> cachefiles_object *object)
>>   
>>   void cachefiles_ondemand_clean_object(struct cachefiles_object
>> *object)
>>   {
>> +	unsigned long index;
>> +	struct cachefiles_req *req;
>> +	struct cachefiles_cache *cache;
>> +
>>   	if (!object->ondemand)
>>   		return;
>>   
>>   	cachefiles_ondemand_send_req(object, CACHEFILES_OP_CLOSE, 0,
>>   			cachefiles_ondemand_init_close_req, NULL);
>> +
>> +	if (!object->ondemand->ondemand_id)
>> +		return;
>> +
>> +	/* Flush all requests for the object that is being dropped.
>> */
> I wouldn't call this a "Flush". In the context of writeback, that
> usually means that we're writing out pages now in order to do something
> else. In this case, it looks like you're more canceling these requests
> since you're marking them with an error and declaring them complete.
Makes sense, I'll update 'flush' to 'cancel' in the comment and subject.

I am not a native speaker of English, so some of the expressions may
not be accurate, thank you for correcting me.

Thanks,
Baokun
>> +	cache = object->volume->cache;
>> +	xa_lock(&cache->reqs);
>>   	cachefiles_ondemand_set_object_dropping(object);
>> +	xa_for_each(&cache->reqs, index, req) {
>> +		if (req->object == object) {
>> +			req->error = -EIO;
>> +			complete(&req->done);
>> +			__xa_erase(&cache->reqs, index);
>> +		}
>> +	}
>> +	xa_unlock(&cache->reqs);
>>   }
>>   
>>   int cachefiles_ondemand_init_obj_info(struct cachefiles_object
>> *object,


