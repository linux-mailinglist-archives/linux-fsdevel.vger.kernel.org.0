Return-Path: <linux-fsdevel+bounces-61590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42A5B58A0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26C12A592B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BF91DE8AF;
	Tue, 16 Sep 2025 00:49:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B045C96;
	Tue, 16 Sep 2025 00:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983765; cv=none; b=gQBZ2ZrJHc/mVo4UyXnnOl3puSXwrhOxXpWgW1n3hIBZK5s6dGXXY6vezvtuIfgOuqgL13L6muQFfT85em36tWNGB7HwvYPPPPdmgaDIqbkKzZYo7EI4mC1+x/jnT7GsTyv4ljFoiZneR8z/P/Elok8oAl3OgDGsXBVFm+VJhOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983765; c=relaxed/simple;
	bh=X/pFC3va19rRg+gk9IqHnYcd8NlNCqdJD2INmemQlIQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QfKqVOg8AIKAtt7xptEf3Pe3cZiaoptQESXo1SFs8wTzeE2jY9SVEfzOKMH/+NkEFvQvZo7d2W7tGwcLMe3DC+1aZJbxn4EKMcwGZrIGBGsvD58nO9oyn2/dJS9IELt6H98qAQ7pD9ZAm8/1/qgOjfkcj0nixKx7SbgJMYolWgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cQjvx38XNzKHMVH;
	Tue, 16 Sep 2025 08:49:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0DF5E1A0FC4;
	Tue, 16 Sep 2025 08:49:18 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDXIY4JtMhoI46ZCg--.11965S3;
	Tue, 16 Sep 2025 08:49:15 +0800 (CST)
Subject: Re: [PATCH v2 0/2] Fix the initialization of
 max_hw_wzeroes_unmap_sectors for stacking drivers
To: John Garry <john.g.garry@oracle.com>, Zhang Yi
 <yi.zhang@huaweicloud.com>, axboe@kernel.dk, linux-raid@vger.kernel.org
Cc: linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 pmenzel@molgen.mpg.de, hch@lst.de, martin.petersen@oracle.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250910111107.3247530-1-yi.zhang@huaweicloud.com>
 <c7dd117e-6e3e-4b2d-a890-20f5c4bade2f@huaweicloud.com>
 <370ca2e5-a4b2-4b5d-9fd1-a931dc2d1a6b@oracle.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <44590d08-2127-e44d-d4f8-6ae9237dd53c@huaweicloud.com>
Date: Tue, 16 Sep 2025 08:49:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <370ca2e5-a4b2-4b5d-9fd1-a931dc2d1a6b@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXIY4JtMhoI46ZCg--.11965S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WFy3Gw4fXw1DGry7Gw1xZrb_yoW8Cw4xpF
	Z7Wa4jyryUKr48Ar1jqF12vFy5tw1fJ347XrW5Xan3XrWqvFyIgF409FZ0grnrXw4rGa4j
	qF1UG3s3uw13trDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/15 18:43, John Garry 写道:
> On 12/09/2025 07:16, Zhang Yi wrote:
>> Hi, Jens!
>>
>> Can you take this patch set through the linux-block tree?
> 
> 
> md raid maintainers,
> 
> please try to get this picked up ASAP. As things stand, all these RAID 
> personalities will be broken for 6.17 on drives supporting/reporting 
> write zeroes.
> 

Not sure if Jens missed this, I'll pick patch 1 later today if Jens
doesn't apply.

Thanks,
Kuai

> Thanks
> 
>>
>> Thanks,
>> Yi.
>>
>> On 9/10/2025 7:11 PM, Zhang Yi wrote:
>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>
>>> Changes since v1:
>>>   - Improve commit messages in patch 1 by adding a simple reproduction
>>>     case as Paul suggested and explaining the implementation differences
>>>     between RAID 0 and RAID 1/10/5, no code changes.
>>>
>>> v1: 
>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-block/20250825083320.797165-1-yi.zhang@huaweicloud.com/__;!!ACWV5N9M2RV99hQ!JAN4eq3ePrspeto0Hn7563lg3392Lh44jM1oTbgxbDoClxVOh5B73QhGD53f9tiLxuxfJCr51PyAP55COV2TTZAt$ 
>>>
>>>
>>> This series fixes the initialization of max_hw_wzeroes_unmap_sectors in
>>> queue_limits for all md raid and drbd drivers, preventing
>>> blk_validate_limits() failures on underlying devices that support the
>>> unmap write zeroes command.
>>>
>>> Best regards,
>>> Yi.
>>>
>>> Zhang Yi (2):
>>>    md: init queue_limits->max_hw_wzeroes_unmap_sectors parameter
>>>    drbd: init queue_limits->max_hw_wzeroes_unmap_sectors parameter
>>>
>>>   drivers/block/drbd/drbd_nl.c | 1 +
>>>   drivers/md/md-linear.c       | 1 +
>>>   drivers/md/raid0.c           | 1 +
>>>   drivers/md/raid1.c           | 1 +
>>>   drivers/md/raid10.c          | 1 +
>>>   drivers/md/raid5.c           | 1 +
>>>   6 files changed, 6 insertions(+)
>>>
>>
>>
> 
> 
> .
> 


