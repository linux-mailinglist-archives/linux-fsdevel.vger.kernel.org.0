Return-Path: <linux-fsdevel+bounces-18800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A65E8BC651
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 05:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6441C2040E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 03:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F73B44376;
	Mon,  6 May 2024 03:50:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696772D044;
	Mon,  6 May 2024 03:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714967401; cv=none; b=AaZKswzswszgcLYd+xZsuM1gCcetSeZbSOnd9IwWLzPFubnxFD4PzVrjxgV5o0raGWEzEg1tQY9DQXXZikeApaQwFtT6rxkVXEjCmsW4xuGep/7TX81FGWGvtYMWl48YENwK/CUgUDpmSs66lBmTMk6VPcaqWGYEeJzHGEi5ciQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714967401; c=relaxed/simple;
	bh=uteZV6mx6kHy6R6zLwPzs254Ngpb1ozsfdKXy5opjYQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hSt9V4pGrXE3TDCTGvGzZs7HFH1wsetQDfTvjmJ3LY6Yus1jNoedhOZxUbseaWwAscN25wHDkkmfhaV6TD7vFGJKvHbD+639bpX9HJ6pknxvTQXauKJFx65elhNzw6XE62jnZKDMrTO9S5/selbKuTz5deVGE588CsP4nI9G33w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VXnV24xYCz4f3kpQ;
	Mon,  6 May 2024 11:49:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id D53861A016E;
	Mon,  6 May 2024 11:49:54 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgBHaw5gUzhmcjOsMA--.8663S3;
	Mon, 06 May 2024 11:49:54 +0800 (CST)
Subject: Re: [PATCH v4 02/34] ext4: check the extent status again before
 inserting delalloc block
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Dave Chinner <david@fromorbit.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 adilger.kernel@dilger.ca, jack@suse.cz, hch@infradead.org,
 djwong@kernel.org, willy@infradead.org, zokeefe@google.com,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
 wangkefeng.wang@huawei.com
References: <87a5l8am4k.fsf@gmail.com>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <7fa1a8da-f335-b8b1-bfb6-fae88f20d598@huaweicloud.com>
Date: Mon, 6 May 2024 11:49:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87a5l8am4k.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBHaw5gUzhmcjOsMA--.8663S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGr1DAFWUWFWfGFWfKF4xtFb_yoWrtFy5pr
	W3C3WUKrZrGr4UAwn2qw1kJFyjg3y8GrW7JrsYgr1jvF9IgFyaq3W2qw1j9FZayr4xJF1j
	vw4jqF9rZ3W5ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 2024/5/2 12:11, Ritesh Harjani (IBM) wrote:
> Dave Chinner <david@fromorbit.com> writes:
> 
>> On Wed, May 01, 2024 at 05:49:50PM +0530, Ritesh Harjani wrote:
>>> Dave Chinner <david@fromorbit.com> writes:
>>>
>>>> On Wed, Apr 10, 2024 at 10:29:16PM +0800, Zhang Yi wrote:
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
>>>>
>>>> Shouldn't this be serialised by the file invalidation lock?  Hole
>>>> punching via fallocate must do this to avoid data use-after-free
>>>> bugs w.r.t racing page faults and all the other fallocate ops need
>>>> to serialise page faults to avoid page cache level data corruption.
>>>> Yet here we see a problem resulting from a fallocate operation
>>>> racing with a page fault....
>>>
>>> IIUC, fallocate operations which invalidates the page cache contents needs
>>> to take th invalidate_lock in exclusive mode to prevent page fault
>>> operations from loading pages for stale mappings (blocks which were
>>> marked free might get reused). This can cause stale data exposure.
>>>
>>> Here the fallocate operation require allocation of unwritten extents and
>>> does not require truncate of pagecache range. So I guess, it is not
>>> strictly necessary to hold the invalidate lock here.
>>
>> True, but you can make exactly the same argument for write() vs
>> fallocate(). Yet this path in ext4_fallocate() locks out 
>> concurrent write()s and waits for DIOs in flight to drain. What
>> makes buffered writes triggered by page faults special?
>>
>> i.e. if you are going to say "we don't need serialisation between
>> writes and fallocate() allocating unwritten extents", then why is it
>> still explicitly serialising against both buffered and direct IO and
>> not just truncate and other fallocate() operations?
>>
>>> But I see XFS does take IOLOCK_EXCL AND MMAPLOCK_EXCL even for this operation.
>>
>> Yes, that's the behaviour preallocation has had in XFS since we
>> introduced the MMAPLOCK almost a decade ago. This was long before
>> the file_invalidation_lock() was even a glimmer in Jan's eye.
>>
>> btrfs does the same thing, for the same reasons. COW support makes
>> extent tree manipulations excitingly complex at times...
>>
>>> I guess we could use the invalidate lock for fallocate operation in ext4
>>> too. However, I think we still require the current patch. The reason is
>>> ext4_da_map_blocks() call here first tries to lookup the extent status
>>> cache w/o any i_data_sem lock in the fastpath. If it finds a hole, it
>>> takes the i_data_sem in write mode and just inserts an entry into extent
>>> status cache w/o re-checking for the same under the exclusive lock. 
>>> ...So I believe we still should have this patch which re-verify under
>>> the write lock if whether any other operation has inserted any entry
>>> already or not.
>>
>> Yup, I never said the code in the patch is wrong or unnecessary; I'm
>> commenting on the high level race condition that lead to the bug
>> beting triggered. i.e. that racing data modification operations with
>> low level extent manipulations is often dangerous and a potential
>> source of very subtle, hard to trigger, reproduce and debug issues
>> like the one reported...
>>
> 
> Yes, thanks for explaining and commenting on the high level design.
> It was indeed helpful. And I agree with your comment on, we can refactor
> out the common operations from fallocate path and use invalidate lock to
> protect against data modification (page fault) and extent manipulation
> path (fallocate operations).
> 

Yeah, thanks for explanation and suggestion, too. After looking at your
discussion, I also suppose we could refactor a common helper and use the
file invalidation lock for the whole ext4 fallocate path, current code is
too scattered.

Thanks,
Yi.


