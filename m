Return-Path: <linux-fsdevel+bounces-69674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 469CCC80E90
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 15:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9942F3AABCE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 14:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7953A30E0EB;
	Mon, 24 Nov 2025 14:06:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB6F28682;
	Mon, 24 Nov 2025 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763993169; cv=none; b=XBUYj7L0Aei6LpIkYvqprdQAe0ziruJj7tUAZ2bv8XmnHIrS2ojuxuPlfzoQS2K1txJ9gJ3hieGs3J9bJzQj5dVquUfEgRM85LfH/OzltHJPrPVMM+wBbZlioRhvsmTP7bhqyiyhGSwT9ZU6b9xsduaW+S6He3+7BltJ+otVn4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763993169; c=relaxed/simple;
	bh=km0c+mc4U3Ynk78C9IQQyuXGBV4fdlxghr6JFAvYhdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZCQtJ3qzzz7llpdjROSUgHUbi0SLEM9U/mJ2qSKF4xi9DKkbwQyf2d/QeCCYT2rwU6S5O7C5SVPiICXAoXVCidLZcwHdpNmWdR5k9Wp1bI/t4ysQPzCqjf2R9LWY3SsUwdVkXfxTd9cju9RHsCdgSS/I3nQ2jBxSx8uViE5aMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dFSJc5wNLzKHMlK;
	Mon, 24 Nov 2025 22:05:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 9C4451A0AB1;
	Mon, 24 Nov 2025 22:05:56 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgBnxHpBZiRpDz54Bw--.24257S3;
	Mon, 24 Nov 2025 22:05:55 +0800 (CST)
Message-ID: <646a8643-3d4e-4213-8922-34574a18231e@huaweicloud.com>
Date: Mon, 24 Nov 2025 22:05:53 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] ext4: replace ext4_es_insert_extent() when
 caching on-disk extents
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, yi.zhang@huawei.com, yizhang089@gmail.com,
 libaokun1@huawei.com, yangerkun@huawei.com
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <aSLoN-oEqS-OpLKE@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <9cef3b97-083e-48e6-aced-3e250df364e3@huaweicloud.com>
 <aSRUohHsq3MsiGv0@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <aSRUohHsq3MsiGv0@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBnxHpBZiRpDz54Bw--.24257S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKF4UWry8tFW7XFW8GrW5GFg_yoW3WFWDpr
	ZFkay5Kr4kX3s7trZ7t3Wjqr1Yg34fGr47Wr9aqw48AFyqyFy2grW7Ka4j9F97ur4kGw12
	vF48t3sxu3W5AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 11/24/2025 8:50 PM, Ojaswin Mujoo wrote:
> On Mon, Nov 24, 2025 at 01:04:04PM +0800, Zhang Yi wrote:
>> Hi, Ojaswin!
>>
>> On 11/23/2025 6:55 PM, Ojaswin Mujoo wrote:
>>> On Fri, Nov 21, 2025 at 02:07:58PM +0800, Zhang Yi wrote:
>>>> Changes since v1:
>>>>  - Rebase the codes based on the latest linux-next 20251120.
>>>>  - Add patches 01-05, fix two stale data problems caused by
>>>
>>> Hi Zhang, thanks for the patches.
>>>
>>
>> Thank you for take time to look at this series.
>>
>>> I've always felt uncomfortable with the ZEROOUT code here because it
>>> seems to have many such bugs as you pointed out in the series. Its very
>>> fragile and the bugs are easy to miss behind all the data valid and
>>> split flags mess. 
>>>
>>
>> Yes, I agree with you. The implementation of EXT4_EXT_MAY_ZEROOUT has
>> significantly increased the complexity of split extents and the
>> potential for bugs.
>>
>>> As per my understanding, ZEROOUT logic seems to be a special best-effort
>>> try to make the split/convert operation "work" when dealing with
>>> transient errors like ENOSPC etc. I was just wondering if it makes sense
>>> to just get rid of the whole ZEROOUT logic completely and just reset the
>>> extent to orig state if there is any error. This allows us to get rid of
>>> DATA_VALID* flags as well and makes the whole ext4_split_convert_extents() 
>>> slightly less messy.
>>>
>>> Maybe we can have a retry loop at the top level caller if we want to try
>>> again for say ENOSPC or ENOMEM. 
>>>
>>> Would love to hear your thoughts on it.
>>>
>>
>> I think this is a direction worth exploring. However, what I am
>> currently considering is that we need to address this scenario of
>> splitting extent during the I/O completion. Although the ZEROOUT logic
>> is fragile and has many issues recently, it currently serves as a
>> fallback solution for handling ENOSPC errors that arise when splitting
>> extents during I/O completion. It ensures that I/O operations do not
>> fail due to insufficient extent blocks.
>>
>> Please see ext4_convert_unwritten_extents_endio(). Although we have made
>> our best effort to tried to split extents using
>> EXT4_GET_BLOCKS_IO_CREATE_EXT before issuing I/Os, we still have not
>> covered all scenarios. Moreover, after converting the buffered I/O path
>> to the iomap infrastructure in the future, we may need to split extents
>> during the I/O completion worker[1].
>>
>> In most block allocation processes, we already have a retry loop to deal
>> with ENOSPC or ENOMEM, such as ext4_should_retry_alloc(). However, it
>> doesn't seem appropriate to place this logic into the I/O completion
>> handling process (I haven't thought this solution through deeply yet,
>> but I'm afraid it could introduce potential deadlock risks due to its
>> involvement with journal operations), and we can't just simply try again.
>> If we remove the ZEROOUT logic, we may lose our last line of defense
>> during the I/O completion.
>>
>> Currently, I am considering whether it is possible to completely remove
>> EXT4_GET_BLOCKS_IO_CREATE_EXT so that extents are not split before
>> submitting I/Os; instead, all splitting would be performed when
>> converting extents to written after the I/O completes. Based on my patch,
>> "ext4: use reserved metadata blocks when splitting extent on endio"[2],
>> and the ZEROOUT logic, this approach appears feasible, and xfstest-bld
>> shows no regressions.
>>
>> So I think the ZEROOUT logic remains somewhat useful until we find better
>> solution(e.g., making more precise reservations for metadata). Perhaps we
>> can refactor both the split extent and ZEROOUT logic to make them more
>> concise.
> 
> Hi Yi,
> 
> Okay it makese sense to keep the zeroout if iomap path is planning to
> shift the extent splitting to endio. Plus, I agree based on the comments
> in the ext4_convert_unwritte_extents_endio() that we might even today
> need to split in endio (although i cant recall when this happens) which
> would need a zeroout fallback.

A relatively common case is the concurrency between folio write-back and
fallocate. After an unwritten extent is allocated during the writeback
process, if fallocate is performed before the I/O completes, the unwritten
extent created by fallocate will merge with the writeback portion.
Consequently, a split operation is required once the I/O completes.

> 
> And yes, I think refactoring the whole logic to be less confusing would
> be better. I had an older unposted untested patch cleaning up some of
> this, I was looking at it again today and there seems to be a lot of
> cleanups we can do here but that becomes out of scope of this patchset I
> believe.
> 
> Sure then, lets keep it as it is for now. I'll review the changes you
> made and later I can post a patch refactoring this area.

OK, thank you a lot for your review and look forward to your patch.

Thanks,
Yi.

> 
> Regards,
> ojaswin
> 
>>
>> [1] https://lore.kernel.org/linux-ext4/20241022111059.2566137-18-yi.zhang@huaweicloud.com/
>> [2] https://lore.kernel.org/linux-ext4/20241022111059.2566137-12-yi.zhang@huaweicloud.com/
>>
>> Cheers,
>> Yi.
>>
>>> Thanks,
>>> Ojaswin
>>>
>>>>    EXT4_EXT_MAY_ZEROOUT when splitting extent.
>>>>  - Add patches 06-07, fix two stale extent status entries problems also
>>>>    caused by splitting extent.
>>>>  - Modify patches 08-10, extend __es_remove_extent() and
>>>>    ext4_es_cache_extent() to allow them to overwrite existing extents of
>>>>    the same status when caching on-disk extents, while also checking
>>>>    extents of different stauts and raising alarms to prevent misuse.
>>>>  - Add patch 13 to clear the usage of ext4_es_insert_extent(), and
>>>>    remove the TODO comment in it.
>>>>
>>>> v1: https://lore.kernel.org/linux-ext4/20251031062905.4135909-1-yi.zhang@huaweicloud.com/
>>>>
>>>> Original Description
>>>>
>>>> This series addresses the optimization that Jan pointed out [1]
>>>> regarding the introduction of a sequence number to
>>>> ext4_es_insert_extent(). The proposal is to replace all instances where
>>>> the cache of on-disk extents is updated by using ext4_es_cache_extent()
>>>> instead of ext4_es_insert_extent(). This change can prevent excessive
>>>> cache invalidations caused by unnecessarily increasing the extent
>>>> sequence number when reading from the on-disk extent tree.
>>>>
>>>> [1] https://lore.kernel.org/linux-ext4/ympvfypw3222g2k4xzd5pba4zhkz5jihw4td67iixvrqhuu43y@wse63ntv4s6u/
>>>>
>>>> Cheers,
>>>> Yi.
>>>>
>>>> Zhang Yi (13):
>>>>   ext4: cleanup zeroout in ext4_split_extent_at()
>>>>   ext4: subdivide EXT4_EXT_DATA_VALID1
>>>>   ext4: don't zero the entire extent if EXT4_EXT_DATA_PARTIAL_VALID1
>>>>   ext4: don't set EXT4_GET_BLOCKS_CONVERT when splitting before
>>>>     submitting I/O
>>>>   ext4: correct the mapping status if the extent has been zeroed
>>>>   ext4: don't cache extent during splitting extent
>>>>   ext4: drop extent cache before splitting extent
>>>>   ext4: cleanup useless out tag in __es_remove_extent()
>>>>   ext4: make __es_remove_extent() check extent status
>>>>   ext4: make ext4_es_cache_extent() support overwrite existing extents
>>>>   ext4: adjust the debug info in ext4_es_cache_extent()
>>>>   ext4: replace ext4_es_insert_extent() when caching on-disk extents
>>>>   ext4: drop the TODO comment in ext4_es_insert_extent()
>>>>
>>>>  fs/ext4/extents.c        | 127 +++++++++++++++++++++++----------------
>>>>  fs/ext4/extents_status.c | 121 ++++++++++++++++++++++++++++---------
>>>>  fs/ext4/inode.c          |  18 +++---
>>>>  3 files changed, 176 insertions(+), 90 deletions(-)
>>>>
>>>> -- 
>>>> 2.46.1
>>>>
>>


