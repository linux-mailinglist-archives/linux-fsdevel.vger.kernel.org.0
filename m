Return-Path: <linux-fsdevel+bounces-55792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43475B0EDFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 11:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911B03AED93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 09:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE0B28153A;
	Wed, 23 Jul 2025 09:03:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAED723C51B;
	Wed, 23 Jul 2025 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261423; cv=none; b=sa9ubL6CUutx1qAb8wq2aLbffMiE0wM4F0ACkFo9TqH84UtjCzfQbHepB7q0mzH5aw/8blZTuvZSFfj3euUPXvttVrsye0vpcipyCU8YsHlKWSYl/CxRBMcURHQ9J+dLtbFw7oBuAbybz3SHt0+z807UTAKqq/nyWGQ4M3qdolM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261423; c=relaxed/simple;
	bh=nE+gf4V+eeaoDrErzU4FGCqcMfHvTfIsnoLh5Oa1g6E=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SQBA5QZbnXuCcDjIAVSVteb2NKivahcST2QXEbMxP2kQzPR0qMAy2gZzV8TSJZa4U2xAwzvx3G+zM7+qr7EF48/d/ELU9j6xHrSdCtDCS51osByR3Qg4HBnw2xjCOskNnEe2qODZNRmcWTT8cBsrx6XZ20i80IbwD7KV23sjckc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bn7Tj0L83zKHMtl;
	Wed, 23 Jul 2025 17:03:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C17291A1A93;
	Wed, 23 Jul 2025 17:03:35 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP1 (Coremail) with SMTP id cCh0CgBn2LNlpYBov6W_BA--.5952S3;
	Wed, 23 Jul 2025 17:03:35 +0800 (CST)
Subject: Re: [PATCH RFC] mm/readahead: improve randread performance with
 readahead disabled
To: Yu Kuai <yukuai1@huaweicloud.com>, willy@infradead.org,
 akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250701110834.3237307-1-yukuai1@huaweicloud.com>
 <19b73b35-1e16-cb7d-d32f-d054d3e66fa0@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <416d00a2-1530-3ee7-be31-2a58f5fc70e2@huaweicloud.com>
Date: Wed, 23 Jul 2025 17:03:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <19b73b35-1e16-cb7d-d32f-d054d3e66fa0@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBn2LNlpYBov6W_BA--.5952S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyfXw4kCFyUWFy3AF4Dtwb_yoW5JFy8pF
	s5JFWUtryUWrn3Ary7J34UJFyrGr48X3W5JryrJFyUAr43Gr4a9ryUXr1qgF1UJr4xJw1U
	Zr4DZr9xZr1Yvr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/07/14 9:42, Yu Kuai 写道:
> Hi,
> 
> 在 2025/07/01 19:08, Yu Kuai 写道:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> We have a workload of random 4k-128k read on a HDD, from iostat we 
>> observed
>> that average request size is 256k+ and bandwidth is 100MB+, this is 
>> because
>> readahead waste lots of disk bandwidth. Hence we disable readahead and
>> performance from user side is indeed much better(2x+), however, from
>> iostat we observed request size is just 4k and bandwidth is just around
>> 40MB.
>>
>> Then we do a simple dd test and found out if readahead is disabled,
>> page_cache_sync_ra() will force to read one page at a time, and this
>> really doesn't make sense because we can just issue user requested size
>> request to disk.
>>
>> Fix this problem by removing the limit to read one page at a time from
>> page_cache_sync_ra(), this way the random read workload can get better
>> performance with readahead disabled.
>>
>> PS: I'm not sure if I miss anything, so this version is RFC
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   mm/readahead.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
> 
> Friendly ping ...
> 

Friendly ping again ...

>> diff --git a/mm/readahead.c b/mm/readahead.c
>> index 20d36d6b055e..1df85ccba575 100644
>> --- a/mm/readahead.c
>> +++ b/mm/readahead.c
>> @@ -561,13 +561,21 @@ void page_cache_sync_ra(struct readahead_control 
>> *ractl,
>>        * Even if readahead is disabled, issue this request as readahead
>>        * as we'll need it to satisfy the requested range. The forced
>>        * readahead will do the right thing and limit the read to just the
>> -     * requested range, which we'll set to 1 page for this case.
>> +     * requested range.
>>        */
>> -    if (!ra->ra_pages || blk_cgroup_congested()) {
>> +    if (blk_cgroup_congested()) {
>>           if (!ractl->file)
>>               return;
>> +        /*
>> +         * If the cgroup is congested, ensure to do at least 1 page of
>> +         * readahead to make progress on the read.
>> +         */
>>           req_count = 1;
>>           do_forced_ra = true;
>> +    } else if (!ra->ra_pages) {
>> +        if (!ractl->file)
>> +            return;
>> +        do_forced_ra = true;
>>       }
>>       /* be dumb */
>>
> 
> .
> 


