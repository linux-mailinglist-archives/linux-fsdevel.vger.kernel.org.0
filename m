Return-Path: <linux-fsdevel+bounces-17993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDF98B4942
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 05:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3924D1C20B2A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 03:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B9928F0;
	Sun, 28 Apr 2024 03:00:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354E315A4;
	Sun, 28 Apr 2024 03:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714273245; cv=none; b=AtYHAVfTU51MnHV8H5gyhNoDSAEC6R7DjM9Jp5jvYT1zG2th7w89Kti5xVOfli1tPGs19WCDv8zJj1E3MFM95v2JuRUTYxWpe1xVxTCVA9MK8HW7Zx9mdkzK2adChWOEEibM50vubtpzt0GhZxPFFqCF/LHkv2hA3V0f2WSfIKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714273245; c=relaxed/simple;
	bh=41rAsJkcpFZicCZ5C/YdKJs+Eb6L27orELFLu/9Wo6A=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YRUZDENt3HfRBU6xJby8G5WcRxzqSggnG3ZMEmcum2sea0gca4rFDgwi+TkjTe93lSg2s0FhWg/S4tROdrNCv2iOYSqJUrUAbEXHIeKBX/y4JvWc6TEFLdykMyVafSCELBHJs5faAtYTmWtpk/atB29kRMET7odihojujjGnaII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VRrmv5HQZz4f3kjL;
	Sun, 28 Apr 2024 11:00:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 77C5F1A0905;
	Sun, 28 Apr 2024 11:00:39 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgBHaw7Uuy1mTwCoLQ--.14367S3;
	Sun, 28 Apr 2024 11:00:39 +0800 (CST)
Subject: Re: [PATCH v4 02/34] ext4: check the extent status again before
 inserting delalloc block
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, hch@infradead.org, djwong@kernel.org, david@fromorbit.com,
 willy@infradead.org, zokeefe@google.com, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, wangkefeng.wang@huawei.com
References: <87cyqcyt6t.fsf@gmail.com>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <3243c67d-e783-4ec5-998f-0b6170f36e35@huaweicloud.com>
Date: Sun, 28 Apr 2024 11:00:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87cyqcyt6t.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBHaw7Uuy1mTwCoLQ--.14367S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw47Gr1rXrW7tryxAFy7Wrg_yoW7Aw4Up3
	90k3WUKr4kXw1kCan7t3Z5Xr10ga18tF4agr13Kr1UZFZ0yFyxWFnFqF15uFyYkrs7Jr1j
	vayY9ryxua4UJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 2024/4/27 0:39, Ritesh Harjani (IBM) wrote:
> Zhang Yi <yi.zhang@huaweicloud.com> writes:
> 
>> On 2024/4/26 20:57, Ritesh Harjani (IBM) wrote:
>>> Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:
>>>
>>>> Zhang Yi <yi.zhang@huaweicloud.com> writes:
>>>>
>>>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>>>
>>>>> Now we lookup extent status entry without holding the i_data_sem before
>>>>> inserting delalloc block, it works fine in buffered write path and
>>>>> because it holds i_rwsem and folio lock, and the mmap path holds folio
>>>>> lock, so the found extent locklessly couldn't be modified concurrently.
>>>>> But it could be raced by fallocate since it allocate block whitout
>>>>> holding i_rwsem and folio lock.
>>>>>
>>>>> ext4_page_mkwrite()             ext4_fallocate()
>>>>>  block_page_mkwrite()
>>>>>   ext4_da_map_blocks()
>>>>>    //find hole in extent status tree
>>>>>                                  ext4_alloc_file_blocks()
>>>>>                                   ext4_map_blocks()
>>>>>                                    //allocate block and unwritten extent
>>>>>    ext4_insert_delayed_block()
>>>>>     ext4_da_reserve_space()
>>>>>      //reserve one more block
>>>>>     ext4_es_insert_delayed_block()
>>>>>      //drop unwritten extent and add delayed extent by mistake
>>>>>
>>>>> Then, the delalloc extent is wrong until writeback, the one more
>>>>> reserved block can't be release any more and trigger below warning:
>>>>>
>>>>>  EXT4-fs (pmem2): Inode 13 (00000000bbbd4d23): i_reserved_data_blocks(1) not cleared!
>>>>>
>>>>> Hold i_data_sem in write mode directly can fix the problem, but it's
>>>>> expansive, we should keep the lockless check and check the extent again
>>>>> once we need to add an new delalloc block.
>>>>
>>>> Hi Zhang, 
>>>>
>>>> It's a nice finding. I was wondering if this was caught in any of the
>>>> xfstests?
>>>>
>>
>> Hi, Ritesh
>>
>> I caught this issue when I tested my iomap series in generic/344 and
>> generic/346. It's easy to reproduce because the iomap's buffered write path
>> doesn't hold folio lock while inserting delalloc blocks, so it could be raced
>> by the mmap page fault path. But the buffer_head's buffered write path can't
>> trigger this problem,
> 
> ya right! That's the difference between how ->map_blocks() is called
> between buffer_head v/s iomap path. In iomap the ->map_blocks() call
> happens first to map a large extent and then it iterate over all the
> locked folios covering the mapped extent for doing writes.
> Whereas in buffer_head while iterating, we first instantiate/lock the
> folio and then call ->map_blocks() to map an extent for the given folio.
> 
> ... So this opens up this window for a race between iomap buffered write
> path v/s page mkwrite path for inserting delalloc blocks entries.
> 
>> the race between buffered write path and fallocate path
>> was discovered while I was analyzing the code, so I'm not sure if it could
>> be caught by xfstests now, at least I haven't noticed this problem so far.
>>
> 
> Did you mean the race between page fault path and fallocate path here?
> Because buffered write path and fallocate path should not have any race
> since both takes the inode_lock. I guess you meant page fault path and
> fallocate path for which you wrote this patch too :)

Yep.

> 
> I am surprised, why we cannot see the this race between page mkwrite and
> fallocate in fstests for inserting da entries to extent status cache.
> Because the race you identified looks like a legitimate race and is
> mostly happening since ext4_da_map_blocks() was not doing the right
> thing.
> ... looking at the src/holetest, it doesn't really excercise this path.
> So maybe we can writing such fstest to trigger this race.
> 

I guess the stress tests and smoke tests in fstests have caught it,
e.g. generic/476. Since there is only one error message in ext4_destroy_inode()
when the race issue happened, we can't detect it unless we go and check the logs
manually.

I suppose we need to add more warnings, something like this, how does it sound?

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c8b691e605f1..4b6fd9b63b12 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1255,6 +1255,8 @@ static void ext4_percpu_param_destroy(struct ext4_sb_info *sbi)
 	percpu_counter_destroy(&sbi->s_freeclusters_counter);
 	percpu_counter_destroy(&sbi->s_freeinodes_counter);
 	percpu_counter_destroy(&sbi->s_dirs_counter);
+	WARN_ON_ONCE(!ext4_forced_shutdown(sbi->s_sb) &&
+		     percpu_counter_sum(&sbi->s_dirtyclusters_counter));
 	percpu_counter_destroy(&sbi->s_dirtyclusters_counter);
 	percpu_counter_destroy(&sbi->s_sra_exceeded_retry_limit);
 	percpu_free_rwsem(&sbi->s_writepages_rwsem);
@@ -1476,7 +1478,8 @@ static void ext4_destroy_inode(struct inode *inode)
 		dump_stack();
 	}

-	if (EXT4_I(inode)->i_reserved_data_blocks)
+	if (!ext4_forced_shutdown(inode->i_sb) &&
+	    WARN_ON_ONCE(EXT4_I(inode)->i_reserved_data_blocks))
 		ext4_msg(inode->i_sb, KERN_ERR,
 			 "Inode %lu (%p): i_reserved_data_blocks (%u) not cleared!",
 			 inode->i_ino, EXT4_I(inode),


Thanks,
Yi.

> 
>>>> I have reworded some of the commit message, feel free to use it if you
>>>> think this version is better. The use of which path uses which locks was
>>>> a bit confusing in the original commit message.
>>>>
>>
>> Thanks for the message improvement, it looks more clear then mine, I will
>> use it.
>>
> 
> Glad, it was helpful.
> 
> -ritesh
> 


