Return-Path: <linux-fsdevel+bounces-18802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7653C8BC659
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 05:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55922815EF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 03:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1362843ABC;
	Mon,  6 May 2024 03:57:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C29F17D2;
	Mon,  6 May 2024 03:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714967864; cv=none; b=oZa9TvApQgTgLcw0Ig2yOmOiefGWBAbIFeGprBBqmdcsr3m8HUrfifc2u6lnQS5VO8WoIqgu3+YFAvWBfWoWext8VfWKM7MPpMD7p5nwakPSZ56nUAeVVvA5RTF1rqLgv1JylVlEtNXdwZmfeCf/tDGhzo5CtN56QkxTHr0QQVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714967864; c=relaxed/simple;
	bh=wuEfHvCP7lJMWyGu+Q2nUgqPLMxEwZ062UxM5FhQrro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRkwq2FmiQWLXryqSzV3Dokmox0jrezLH6gxjpqjRNGbJEj74MzbMmMlM+zAPRO9ZGwDXPs+NsWPp5AwJj7sFZA8cWXjSR2VkrKGZ5CWJUpx2hwby+1tTz/hjG3rUR95Php+aRkEphb1uJrXg+dLZrTQb7FOe0y48e0z1Nx73IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VXnfx5hc8z4f3jMn;
	Mon,  6 May 2024 11:57:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id F22801A0568;
	Mon,  6 May 2024 11:57:37 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBEuVThmsjKLLw--.17036S3;
	Mon, 06 May 2024 11:57:37 +0800 (CST)
Message-ID: <ba40eb22-dc28-54b6-a8cb-7a8ba4464c9a@huaweicloud.com>
Date: Mon, 6 May 2024 11:57:34 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 01/12] cachefiles: remove request from xarry during flush
 requests
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun <yangerkun@huawei.com>,
 libaokun@huaweicloud.com
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-2-libaokun@huaweicloud.com>
 <6e4a20f7-263a-46be-81cc-2667353c452d@linux.alibaba.com>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <6e4a20f7-263a-46be-81cc-2667353c452d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBEuVThmsjKLLw--.17036S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWUCr1fuw4UGFyxCrykZrb_yoW8Kry8pF
	WSyF17Jry8Jr18Jr1UJr1UJry8J34UJ3WUXr1UJF18Ar1DAr1Yqr1UXr10gry5JrW8Jr4U
	Jr1UGryUZr1UJr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
	Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

On 2024/5/6 11:48, Jingbo Xu wrote:
>
> On 4/24/24 11:39 AM, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> This prevents concurrency from causing access to a freed req.
> Could you give more details on how the concurrent access will happen?
> How could another process access the &cache->reqs xarray after it has
> been flushed?

Similar logic to restore leading to UAF:

      mount  |   daemon_thread1    |    daemon_thread2
------------------------------------------------------------
  cachefiles_ondemand_init_object
   cachefiles_ondemand_send_req
    REQ_A = kzalloc(sizeof(*req) + data_len)
    wait_for_completion(&REQ_A->done)

             cachefiles_daemon_read
              cachefiles_ondemand_daemon_read
               REQ_A = cachefiles_ondemand_select_req
               cachefiles_ondemand_get_fd
               copy_to_user(_buffer, msg, n)
             process_open_req(REQ_A)
                                   // close dev fd
                                   cachefiles_flush_reqs
                                    complete(&REQ_A->done)
    kfree(REQ_A)
              cachefiles_ondemand_get_fd(REQ_A)
               fd = get_unused_fd_flags
               file = anon_inode_getfile
               fd_install(fd, file)
               load = (void *)REQ_A->msg.data;
               load->fd = fd;
               // load UAF !!!

>> ---
>>   fs/cachefiles/daemon.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
>> index 6465e2574230..ccb7b707ea4b 100644
>> --- a/fs/cachefiles/daemon.c
>> +++ b/fs/cachefiles/daemon.c
>> @@ -159,6 +159,7 @@ static void cachefiles_flush_reqs(struct cachefiles_cache *cache)
>>   	xa_for_each(xa, index, req) {
>>   		req->error = -EIO;
>>   		complete(&req->done);
>> +		__xa_erase(xa, index);
>>   	}
>>   	xa_unlock(xa);
>>   



