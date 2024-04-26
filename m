Return-Path: <linux-fsdevel+bounces-17895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD62F8B383B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 15:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9C7BB20F75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 13:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B11147C7F;
	Fri, 26 Apr 2024 13:19:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BA91474AF;
	Fri, 26 Apr 2024 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714137596; cv=none; b=TkYNu8RJp72ROZ1zvfqhpm9qtlRZaSQBcBptyCW0llZFp4nzDvABbzVPjW0eZdNvn4gIsbYUusjHZJafS5yJimaZdVeNOI/fD1D0kwZtzvGDe96OcBN0OAaYXvCYMkSSWIFVlX2GGPt1ANl0M3i/qP2P9Ou+6mHlJ+zeu3OiJUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714137596; c=relaxed/simple;
	bh=NKjz8r5HSyZhQ50FE2JFyZ6dA1RrN866bEN9EqQbW38=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WFoF2BIb+wXxoDpgeDO+F3GGgw3vi8qlR3m3MMcNWkbL/phYe7EFs6+KdYtlQbHidAeor6EnSumeYkC7LTL3Tk+WRvwP+mY7XRIkqa1biu4NmVjQPXNyvAY4l33hcPmWraIlpv7N5Lr2KtO+EyTkILh7FTosm90d1aZmgFVhIvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VQtcJ65hmz4f3jkL;
	Fri, 26 Apr 2024 21:19:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BE7B01A0572;
	Fri, 26 Apr 2024 21:19:49 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxDzqStmn1MRLA--.12428S3;
	Fri, 26 Apr 2024 21:19:49 +0800 (CST)
Subject: Re: [PATCH v4 02/34] ext4: check the extent status again before
 inserting delalloc block
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, hch@infradead.org, djwong@kernel.org, david@fromorbit.com,
 willy@infradead.org, zokeefe@google.com, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, wangkefeng.wang@huawei.com
References: <87frv8z3gl.fsf@gmail.com>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <185a0d75-558e-a1ae-9415-c3eed4def60f@huaweicloud.com>
Date: Fri, 26 Apr 2024 21:19:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87frv8z3gl.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDHlxDzqStmn1MRLA--.12428S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw47Ar4UKF4rXw4Dur43GFg_yoW7urykpa
	9IkF45Grs5Ww1kCanagF1UXr10gw18XrW2gr9xKr1jvFZ0kFyfWF12qFyY9FySkrs7G3W0
	vF4jqa4xu3WjyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 2024/4/26 20:57, Ritesh Harjani (IBM) wrote:
> Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:
> 
>> Zhang Yi <yi.zhang@huaweicloud.com> writes:
>>
>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>
>>> Now we lookup extent status entry without holding the i_data_sem before
>>> inserting delalloc block, it works fine in buffered write path and
>>> because it holds i_rwsem and folio lock, and the mmap path holds folio
>>> lock, so the found extent locklessly couldn't be modified concurrently.
>>> But it could be raced by fallocate since it allocate block whitout
>>> holding i_rwsem and folio lock.
>>>
>>> ext4_page_mkwrite()             ext4_fallocate()
>>>  block_page_mkwrite()
>>>   ext4_da_map_blocks()
>>>    //find hole in extent status tree
>>>                                  ext4_alloc_file_blocks()
>>>                                   ext4_map_blocks()
>>>                                    //allocate block and unwritten extent
>>>    ext4_insert_delayed_block()
>>>     ext4_da_reserve_space()
>>>      //reserve one more block
>>>     ext4_es_insert_delayed_block()
>>>      //drop unwritten extent and add delayed extent by mistake
>>>
>>> Then, the delalloc extent is wrong until writeback, the one more
>>> reserved block can't be release any more and trigger below warning:
>>>
>>>  EXT4-fs (pmem2): Inode 13 (00000000bbbd4d23): i_reserved_data_blocks(1) not cleared!
>>>
>>> Hold i_data_sem in write mode directly can fix the problem, but it's
>>> expansive, we should keep the lockless check and check the extent again
>>> once we need to add an new delalloc block.
>>
>> Hi Zhang, 
>>
>> It's a nice finding. I was wondering if this was caught in any of the
>> xfstests?
>>

Hi, Ritesh

I caught this issue when I tested my iomap series in generic/344 and
generic/346. It's easy to reproduce because the iomap's buffered write path
doesn't hold folio lock while inserting delalloc blocks, so it could be raced
by the mmap page fault path. But the buffer_head's buffered write path can't
trigger this problem, the race between buffered write path and fallocate path
was discovered while I was analyzing the code, so I'm not sure if it could
be caught by xfstests now, at least I haven't noticed this problem so far.

>> I have reworded some of the commit message, feel free to use it if you
>> think this version is better. The use of which path uses which locks was
>> a bit confusing in the original commit message.
>>

Thanks for the message improvement, it looks more clear then mine, I will
use it.

Thanks,
Yi.

>> <reworded from your original commit msg>
>>
>> ext4_da_map_blocks(), first looks up the extent status tree for any
>> extent entry with i_data_sem held in read mode. It then unlocks
>> i_data_sem, if it can't find an entry and take this lock in write
>> mode for inserting a new da entry.
> 
> Sorry about this above paragraph. I messed this paragraph.
> Here is the correct version of this.
> 
> ext4_da_map_blocks looks up for any extent entry in the extent status
> tree (w/o i_data_sem) and then the looks up for any ondisk extent
> mapping (with i_data_sem in read mode).
> 
> If it finds a hole in the extent status tree or if it couldn't find any
> entry at all, it then takes the i_data_sem in write mode to add a da entry
> into the extent status tree. This can actually race with page mkwrite
> & fallocate path. 
> 
> Note that this is ok between...  <and the rest can remain same>
> 
>>
>> This is ok between -
>> 1. ext4 buffered-write path v/s ext4_page_mkwrite(), because of the
>> folio lock
>> 2. ext4 buffered write path v/s ext4 fallocate because of the inode
>> lock.
>>
> 
> 
>> But this can race between ext4_page_mkwrite() & ext4 fallocate path - 
>>
>>  ext4_page_mkwrite()             ext4_fallocate()
>>   block_page_mkwrite()
>>    ext4_da_map_blocks()
>>     //find hole in extent status tree
>>                                   ext4_alloc_file_blocks()
>>                                    ext4_map_blocks()
>>                                     //allocate block and unwritten extent
>>     ext4_insert_delayed_block()
>>      ext4_da_reserve_space()
>>       //reserve one more block
>>      ext4_es_insert_delayed_block()
>>       //drop unwritten extent and add delayed extent by mistake
>>
>> Then, the delalloc extent is wrong until writeback and the extra
>> reserved block can't be released any more and it triggers below warning:
>>
>>   EXT4-fs (pmem2): Inode 13 (00000000bbbd4d23): i_reserved_data_blocks(1) not cleared!
>>
>> This patch fixes the problem by looking up extent status tree again
>> while the i_data_sem is held in write mode. If it still can't find
>> any entry, then we insert a new da entry into the extent status tree.
>>
>>>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>>> ---
>>>  fs/ext4/inode.c | 19 +++++++++++++++++++
>>>  1 file changed, 19 insertions(+)
>>>
>>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>>> index 6a41172c06e1..118b0497a954 100644
>>> --- a/fs/ext4/inode.c
>>> +++ b/fs/ext4/inode.c
>>> @@ -1737,6 +1737,7 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
>>>  		if (ext4_es_is_hole(&es))
>>>  			goto add_delayed;
>>>  
>>> +found:
>>>  		/*
>>>  		 * Delayed extent could be allocated by fallocate.
>>>  		 * So we need to check it.
>>> @@ -1781,6 +1782,24 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
>>>  
>>>  add_delayed:
>>>  	down_write(&EXT4_I(inode)->i_data_sem);
>>> +	/*
>>> +	 * Lookup extents tree again under i_data_sem, make sure this
>>> +	 * inserting delalloc range haven't been delayed or allocated
>>> +	 * whitout holding i_rwsem and folio lock.
>>> +	 */
>>
>> page fault path (ext4_page_mkwrite does not take i_rwsem) and fallocate
>> path (no folio lock) can race. Make sure we lookup the extent status
>> tree here again while i_data_sem is held in write mode, before inserting
>> a new da entry in the extent status tree.
>>
>>
> 
> 
> -ritesh
> 


