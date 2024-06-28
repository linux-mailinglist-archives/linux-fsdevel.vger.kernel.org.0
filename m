Return-Path: <linux-fsdevel+bounces-22717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3904591B488
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 03:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9F11C208E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 01:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E05C12B72;
	Fri, 28 Jun 2024 01:09:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E06182B9;
	Fri, 28 Jun 2024 01:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719536964; cv=none; b=kw0LJWq0cX1/zhB1O50flHNG+RwGY4Jrj0D9je8xGUlIaOIGQVW0icf24OO98s+u06Md+h13ogPjuYWhVUCk1Q8jVg1U+bO9aIfUNAIl+w6ZCqw6yjff5H0TdXW6xt4LBTMfrvvV0A2uvt6vUgNc1kRKF3NmQkuI1aBl433JnXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719536964; c=relaxed/simple;
	bh=FJBS0qNoYdakN29J3gj/ZaHV91m7vyqEgcjmwOvd7w8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WYmDlkeS2T+LkjeutY1sgNEP6V3RG0YXGcOb7qbYVKC3Ee/2gmnykUgBX9ERdXdHhrTAwons/7YKF2lNnmvZG8OYUEFZpj32IPiWIeDT+3oW+yGc7QyI4eeGm4LaqWfTtwMdMvPhEkN5VeyrFWX8a5VXxLVF6mdrZWcQsd+gqL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4W9HQC0lClz4f3jHy;
	Fri, 28 Jun 2024 09:09:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 05BDB1A0568;
	Fri, 28 Jun 2024 09:09:18 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgAnUn45DX5mgaIaAg--.2390S3;
	Fri, 28 Jun 2024 09:09:17 +0800 (CST)
Message-ID: <b68920cc-28ab-4e8b-994a-93f4148b4b8b@huaweicloud.com>
Date: Fri, 28 Jun 2024 09:09:13 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] cachefiles: flush all requests for the object that
 is being dropped
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev,
 dhowells@redhat.com, hsiangkao@linux.alibaba.com,
 jefflexu@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>,
 Baokun Li <libaokun@huaweicloud.com>
References: <20240515125136.3714580-1-libaokun@huaweicloud.com>
 <20240515125136.3714580-3-libaokun@huaweicloud.com>
 <5bb711c4bbc59ea9fff486a86acce13880823e7b.camel@kernel.org>
 <e40b80fc-52b8-4f89-800a-3ffa0034a072@huaweicloud.com>
 <20240627-beizeiten-hecht-0efad69e0e38@brauner>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <20240627-beizeiten-hecht-0efad69e0e38@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAnUn45DX5mgaIaAg--.2390S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KFy3Gr1rZr18AFy3XFyUAwb_yoW8KFyUpF
	Waya4akFW8ur17Crn2vF1YvrySy3s3ArnrXr1aqryjyrs0qrna9r1Iqr1DuF1DJrs3Gr4I
	qr4UWF93GryqyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQvt
	AUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAHBV1jkHrAYQABs0

On 2024/6/27 23:18, Christian Brauner wrote:
> On Thu, Jun 27, 2024 at 07:20:16PM GMT, Baokun Li wrote:
>> On 2024/6/27 19:01, Jeff Layton wrote:
>>> On Wed, 2024-05-15 at 20:51 +0800, libaokun@huaweicloud.com wrote:
>>>> From: Baokun Li <libaokun1@huawei.com>
>>>>
>>>> Because after an object is dropped, requests for that object are
>>>> useless,
>>>> flush them to avoid causing other problems.
>>>>
>>>> This prepares for the later addition of cancel_work_sync(). After the
>>>> reopen requests is generated, flush it to avoid cancel_work_sync()
>>>> blocking by waiting for daemon to complete the reopen requests.
>>>>
>>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>>> ---
>>>>    fs/cachefiles/ondemand.c | 19 +++++++++++++++++++
>>>>    1 file changed, 19 insertions(+)
>>>>
>>>> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
>>>> index 73da4d4eaa9b..d24bff43499b 100644
>>>> --- a/fs/cachefiles/ondemand.c
>>>> +++ b/fs/cachefiles/ondemand.c
>>>> @@ -564,12 +564,31 @@ int cachefiles_ondemand_init_object(struct
>>>> cachefiles_object *object)
>>>>    void cachefiles_ondemand_clean_object(struct cachefiles_object
>>>> *object)
>>>>    {
>>>> +	unsigned long index;
>>>> +	struct cachefiles_req *req;
>>>> +	struct cachefiles_cache *cache;
>>>> +
>>>>    	if (!object->ondemand)
>>>>    		return;
>>>>    	cachefiles_ondemand_send_req(object, CACHEFILES_OP_CLOSE, 0,
>>>>    			cachefiles_ondemand_init_close_req, NULL);
>>>> +
>>>> +	if (!object->ondemand->ondemand_id)
>>>> +		return;
>>>> +
>>>> +	/* Flush all requests for the object that is being dropped.
>>>> */
>>> I wouldn't call this a "Flush". In the context of writeback, that
>>> usually means that we're writing out pages now in order to do something
>>> else. In this case, it looks like you're more canceling these requests
>>> since you're marking them with an error and declaring them complete.
>> Makes sense, I'll update 'flush' to 'cancel' in the comment and subject.
>>
>> I am not a native speaker of English, so some of the expressions may
>> not be accurate, thank you for correcting me.
> Can you please resend all patch series that we're supposed to take for
> this cycle, please?
Sure, I'm organising to combine the two patch series today and
send it out as v3.

-- 
With Best Regards,
Baokun Li


