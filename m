Return-Path: <linux-fsdevel+bounces-69066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A1BC6DCB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 10:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEB2C4FA2D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 09:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E70634029C;
	Wed, 19 Nov 2025 09:37:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E1E248891;
	Wed, 19 Nov 2025 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763545024; cv=none; b=NSNmPwXu76t1Rq9EGoEy6rd9TSq6SA8IrEX7phAkeMwksZbZIyMf+xRF4aFHDGkqrsHGZ0zk4OuGvyPIazVYkT33bAGTj43Uwj+9VjBNJjwAfeK5nMrZPHHMf222gloZtfbRfcrFtlv65uFMfOHItdirLRz/614gh5TdDxsNUUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763545024; c=relaxed/simple;
	bh=kqWNjoB+eZLiJw0AujDsCdYR4UvmHoy+wTkZsCNgc+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pco0AaqnQBhsBgInOQYP7ZSDNJrxr4eEh+nRlk8J4GpMUImpKGkAdjRziRwoVXIacQQSIYA+uwEf+UFdP50DM+Sr7LYCB3eOUnRUHeznPdej8q+rgq35Q9H9yNrG0KnCMyOatTHmFjwoDhCZzE8MqL845sbUF8yhDVDYoRwgp8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dBGZZ5y7xzKHMsR;
	Wed, 19 Nov 2025 17:36:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C46861A13F1;
	Wed, 19 Nov 2025 17:36:50 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgCHMXiwjx1p2FgcBQ--.35909S3;
	Wed, 19 Nov 2025 17:36:50 +0800 (CST)
Message-ID: <cfd95673-d0e6-44e6-86af-04bf2e0a9a8f@huaweicloud.com>
Date: Wed, 19 Nov 2025 17:36:48 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ext4: make ext4_es_cache_extent() support overwrite
 existing extents
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 yi.zhang@huawei.com, libaokun1@huawei.com, yangerkun@huawei.com
References: <20251031062905.4135909-1-yi.zhang@huaweicloud.com>
 <20251031062905.4135909-2-yi.zhang@huaweicloud.com>
 <l7tb75bsk52ybeok737b7o4ag4zeleowtddf3v6wcbnhbom4tx@xv643wp5wp6a>
 <ee200d75-6f3e-4514-8fd4-8cdcbd3754d4@huaweicloud.com>
 <hmfdz3arnmmmrvar2266ye4vb64txvxsa4hrpzppb4sp354b25@tnpvja7o7uww>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <hmfdz3arnmmmrvar2266ye4vb64txvxsa4hrpzppb4sp354b25@tnpvja7o7uww>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCHMXiwjx1p2FgcBQ--.35909S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWr4kuryUuF4UGF1fXFy8AFb_yoWrZr1rpF
	ZrCa17Kr4kJw1vya4Iy3W0qFyS9w48JrW7Jry7Gr17CF98uFyIgF1xtayj9Fyxurs2gw4Y
	vFW8K347Z3s8A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 11/11/2025 6:33 PM, Jan Kara wrote:
> Hi!
> 
> On Thu 06-11-25 21:02:35, Zhang Yi wrote:
>> On 11/6/2025 5:15 PM, Jan Kara wrote:
>>> On Fri 31-10-25 14:29:02, Zhang Yi wrote:
>>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>>
>>>> Currently, ext4_es_cache_extent() is used to load extents into the
>>>> extent status tree when reading on-disk extent blocks. Since it may be
>>>> called while moving or modifying the extent tree, so it does not
>>>> overwrite existing extents in the extent status tree and is only used
>>>> for the initial loading.
>>>>
>>>> There are many other places in ext4 where on-disk extents are inserted
>>>> into the extent status tree, such as in ext4_map_query_blocks().
>>>> Currently, they call ext4_es_insert_extent() to perform the insertion,
>>>> but they don't modify the extents, so ext4_es_cache_extent() would be a
>>>> more appropriate choice. However, when ext4_map_query_blocks() inserts
>>>> an extent, it may overwrite a short existing extent of the same type.
>>>> Therefore, to prepare for the replacements, we need to extend
>>>> ext4_es_cache_extent() to allow it to overwrite existing extents with
>>>> the same type.
>>>>
>>>> In addition, since cached extents can be more lenient than the extents
>>>> they modify and do not involve modifying reserved blocks, it is not
>>>> necessary to ensure that the insertion operation succeeds as strictly as
>>>> in the ext4_es_insert_extent() function.
>>>>
>>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>>>
>>> Thanks for writing this series! I think we can actually simplify things
>>> event further. Extent status tree operations can be divided into three
>>> groups:
>>> 1) Lookups in es tree - protected only by i_es_lock.
>>> 2) Caching of on-disk state into es tree - protected by i_es_lock and
>>>    i_data_sem (at least in read mode).
>>> 3) Modification of existing state - protected by i_es_lock and i_data_sem
>>>    in write mode.
>>
>> Yeah.
>>
>>>
>>> Now because 2) has exclusion vs 3) due to i_data_sem, the observation is
>>> that 2) should never see a real conflict - i.e., all intersecting entries
>>> in es tree have the same status, otherwise this is a bug.
>>
>> While I was debugging, I observed two exceptions here.
>>
>> A. The first exceptions is about the delay extent. Since there is no actual
>>    extent present in the extent tree on the disk, if a delayed extent
>>    already exists in the extent status tree and someone calls
>>    ext4_find_extent()->ext4_cache_extents() to cache an extent at the same
>>    location, then a status mismatch will occur (attempting to replace
>>    the delayed extent with a hole). This is not a bug.
>> B. I also observed that ext4_find_extent()->ext4_cache_extents() is called
>>    during splitting and conversion between unwritten and written states (in
>>    most scenarios, EXT4_EX_NOCACHE is not added). However, because the
>>    process is in an intermediate state of handling extents, there can be
>>    cases where the status do not match. I did not analyze this scenario in
>>    detail, but since ext4_es_insert_extent() is called at the end of the
>>    processing to ensure the final state is correct, I don't think this is a
>>    practical issue either.
> 
> Thanks for bringing this up. I didn't think about these two cases. As for
> case A that is easy to deal with as you write below. A hole insertion can
> be deemed compatible with existing delalloc extent.
> 

Yeah.

> Case B is more difficult and I think I need to better understand the
> details there to decide what to do. Only extent splitting (as it happens
> e.g. with EXT4_GET_BLOCKS_PRE_IO) should keep extents in the extent tree and
> extent status tree compatible. So it has to be something like
> EXT4_GET_BLOCKS_CONVERT case. There indeed after we call
> ext4_ext_mark_initialized() we have initialized extent on disk but in
> extent status tree it is still as unwritten. But I just didn't find a place
> in the extent conversion path that would modify extent state on disk and
> then call ext4_find_extent(). Can you perhaps share a stacktrace where the
> extent incompatibility was hit from ext4_cache_extents()? Thanks!
> 
> 								Honza
> 

Sorry for the late. I have found several real issues during debugging this
case, the situation is a bit complicated and will take some time, I will
address these in the next iteration.

Cheers,
Yi.




