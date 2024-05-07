Return-Path: <linux-fsdevel+bounces-18870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A7A8BD9A2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 05:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E301F22C1E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 03:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A978F41C7C;
	Tue,  7 May 2024 03:15:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931B34A12;
	Tue,  7 May 2024 03:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715051717; cv=none; b=O3VMQ5Yyny5wFv3nuWAZlkAd3XSWqkKzFLl12N8BHYukjtLPnfwHNGxTMuebRpJJiriaLyz2YrcYfolgdOx3lApJEnP1nx73aTikXV5+XogteIKoiYF278YjtN+C8VThRJG3nkJtM9EN5OyR7rq6IUlx4P0H2M/RUOTkxFUVF4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715051717; c=relaxed/simple;
	bh=sYMRNLGFH8M2XSpeWih6wO1nUxL8O7OcAQ6JFojQ9YM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IjgDNl/UcFd5sIGxeXthC3GXB2gGzmPWYLyXnQUVF0MDy0hLwBHNJWV5SF53y2d60Iw+WUCh0CCWaRb0MtifisfiQ7GRoQwDj4LEHXa5IUxAVoNG1XwlKy65+zbmklibttWn0oM3lTX0BlMycx56NR1rMbuZPPJ49oH3ebo4aNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VYNgN6hLXz4f3knj;
	Tue,  7 May 2024 11:14:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 28A851A058D;
	Tue,  7 May 2024 11:15:05 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgDnCw+2nDlmJ7EJMQ--.2963S3;
	Tue, 07 May 2024 11:15:04 +0800 (CST)
Subject: Re: [PATCH v4 02/34] ext4: check the extent status again before
 inserting delalloc block
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, hch@infradead.org, djwong@kernel.org, david@fromorbit.com,
 willy@infradead.org, zokeefe@google.com, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, wangkefeng.wang@huawei.com
References: <87o79sxlid.fsf@gmail.com>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <429df377-87d9-3287-34ce-48bd2be13836@huaweicloud.com>
Date: Tue, 7 May 2024 11:15:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87o79sxlid.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDnCw+2nDlmJ7EJMQ--.2963S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw4xXryUWrWDWw1kJFy3XFb_yoWxWrW3pF
	WYk3WUKr4kJr1kCFs7t3WDXr10ga18tF43Wr1UKr1UZFZ0yF1fWF1IqFyUuFyFkrs7Xr1j
	vrWDWFy7uFyUX3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UZ18PUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/4/29 22:59, Ritesh Harjani (IBM) wrote:
> Zhang Yi <yi.zhang@huaweicloud.com> writes:
> 
>> On 2024/4/27 0:39, Ritesh Harjani (IBM) wrote:
>>> Zhang Yi <yi.zhang@huaweicloud.com> writes:
>>>
>>>> On 2024/4/26 20:57, Ritesh Harjani (IBM) wrote:
>>>>> Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:
>>>>>
>>>>>> Zhang Yi <yi.zhang@huaweicloud.com> writes:
>>>>>>
>>>>>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>>>>>
>>>>>>> Now we lookup extent status entry without holding the i_data_sem before
>>>>>>> inserting delalloc block, it works fine in buffered write path and
>>>>>>> because it holds i_rwsem and folio lock, and the mmap path holds folio
>>>>>>> lock, so the found extent locklessly couldn't be modified concurrently.
>>>>>>> But it could be raced by fallocate since it allocate block whitout
>>>>>>> holding i_rwsem and folio lock.
>>>>>>>
>>>>>>> ext4_page_mkwrite()             ext4_fallocate()
>>>>>>>  block_page_mkwrite()
>>>>>>>   ext4_da_map_blocks()
>>>>>>>    //find hole in extent status tree
>>>>>>>                                  ext4_alloc_file_blocks()
>>>>>>>                                   ext4_map_blocks()
>>>>>>>                                    //allocate block and unwritten extent
>>>>>>>    ext4_insert_delayed_block()
>>>>>>>     ext4_da_reserve_space()
>>>>>>>      //reserve one more block
>>>>>>>     ext4_es_insert_delayed_block()
>>>>>>>      //drop unwritten extent and add delayed extent by mistake
>>>>>>>
>>>>>>> Then, the delalloc extent is wrong until writeback, the one more
>>>>>>> reserved block can't be release any more and trigger below warning:
>>>>>>>
>>>>>>>  EXT4-fs (pmem2): Inode 13 (00000000bbbd4d23): i_reserved_data_blocks(1) not cleared!
>>>>>>>
>>>>>>> Hold i_data_sem in write mode directly can fix the problem, but it's
>>>>>>> expansive, we should keep the lockless check and check the extent again
>>>>>>> once we need to add an new delalloc block.
>>>>>>
>>>>>> Hi Zhang, 
>>>>>>
>>>>>> It's a nice finding. I was wondering if this was caught in any of the
>>>>>> xfstests?
>>>>>>
>>>>
>>>> Hi, Ritesh
>>>>
>>>> I caught this issue when I tested my iomap series in generic/344 and
>>>> generic/346. It's easy to reproduce because the iomap's buffered write path
>>>> doesn't hold folio lock while inserting delalloc blocks, so it could be raced
>>>> by the mmap page fault path. But the buffer_head's buffered write path can't
>>>> trigger this problem,
>>>
>>> ya right! That's the difference between how ->map_blocks() is called
>>> between buffer_head v/s iomap path. In iomap the ->map_blocks() call
>>> happens first to map a large extent and then it iterate over all the
>>> locked folios covering the mapped extent for doing writes.
>>> Whereas in buffer_head while iterating, we first instantiate/lock the
>>> folio and then call ->map_blocks() to map an extent for the given folio.
>>>
>>> ... So this opens up this window for a race between iomap buffered write
>>> path v/s page mkwrite path for inserting delalloc blocks entries.
>>>
>>>> the race between buffered write path and fallocate path
>>>> was discovered while I was analyzing the code, so I'm not sure if it could
>>>> be caught by xfstests now, at least I haven't noticed this problem so far.
>>>>
>>>
>>> Did you mean the race between page fault path and fallocate path here?
>>> Because buffered write path and fallocate path should not have any race
>>> since both takes the inode_lock. I guess you meant page fault path and
>>> fallocate path for which you wrote this patch too :)
>>
>> Yep.
>>
>>>
>>> I am surprised, why we cannot see the this race between page mkwrite and
>>> fallocate in fstests for inserting da entries to extent status cache.
>>> Because the race you identified looks like a legitimate race and is
>>> mostly happening since ext4_da_map_blocks() was not doing the right
>>> thing.
>>> ... looking at the src/holetest, it doesn't really excercise this path.
>>> So maybe we can writing such fstest to trigger this race.
>>>
>>
>> I guess the stress tests and smoke tests in fstests have caught it,
>> e.g. generic/476. Since there is only one error message in ext4_destroy_inode()
>> when the race issue happened, we can't detect it unless we go and check the logs
>> manually.
> 
> Hi Zhang,
> 
> I wasn't able to reproduce the any error messages with generic/476.
> 
>>
>> I suppose we need to add more warnings, something like this, how does it sound?
>>
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index c8b691e605f1..4b6fd9b63b12 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -1255,6 +1255,8 @@ static void ext4_percpu_param_destroy(struct ext4_sb_info *sbi)
>>  	percpu_counter_destroy(&sbi->s_freeclusters_counter);
>>  	percpu_counter_destroy(&sbi->s_freeinodes_counter);
>>  	percpu_counter_destroy(&sbi->s_dirs_counter);
>> +	WARN_ON_ONCE(!ext4_forced_shutdown(sbi->s_sb) &&
>> +		     percpu_counter_sum(&sbi->s_dirtyclusters_counter));
>>  	percpu_counter_destroy(&sbi->s_dirtyclusters_counter);
>>  	percpu_counter_destroy(&sbi->s_sra_exceeded_retry_limit);
>>  	percpu_free_rwsem(&sbi->s_writepages_rwsem);
>> @@ -1476,7 +1478,8 @@ static void ext4_destroy_inode(struct inode *inode)
>>  		dump_stack();
>>  	}
>>
>> -	if (EXT4_I(inode)->i_reserved_data_blocks)
>> +	if (!ext4_forced_shutdown(inode->i_sb) &&
>> +	    WARN_ON_ONCE(EXT4_I(inode)->i_reserved_data_blocks))
>>  		ext4_msg(inode->i_sb, KERN_ERR,
>>  			 "Inode %lu (%p): i_reserved_data_blocks (%u) not cleared!",
>>  			 inode->i_ino, EXT4_I(inode),
>>
> 
> I also ran ext4 -g auto and I couldn't reproduce anything with above
> patch. Please note that I didn't use this patch series for testing. I was running
> xfstests on upstream kernel with above diff (because that's what the
> idea was that the problem even exists in upstream kernel and are we able
> to observe the race with page mkwrite and fallocate path)
> 

I also ran fstests -g smoke about 2 days and I couldn't reproduce this issue too,
even if I modified generic/476 fstress to only run mmap write and fallocate. It's
pretty hard to reproduce this issue through stress tests. Now, it could only be
reproduced on my machine if I add a strategic delay in ext4_da_map_blocks()
before holding i_data_sem in write mode, but ext4's error injection infrastructure
doesn't support adding delay like xfs. So I guess there still has a lot of work
to do if we want to reproduce it reliably on fstests.

Thanks,
Yi.


