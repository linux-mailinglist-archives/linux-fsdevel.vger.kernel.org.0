Return-Path: <linux-fsdevel+bounces-37022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EC29EC645
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 09:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1045A166486
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 08:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9561D2B0E;
	Wed, 11 Dec 2024 08:00:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4071CC899;
	Wed, 11 Dec 2024 07:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904001; cv=none; b=krNj0fS4D2kq7l3yFXLb/EI3bzmurfffExuFCkJy3aIuxQlZczqqbhj1ca4HHWGs9poeN+BpbXjmJG4y2Wr7O3x4sjNIohUyabKqQCAisiCB5qnIAI3JWGypr8HWUd4Ld/bgH78LltpsgxvtnCa6L7+8mkVyDUEbnHtLle+2Ppo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904001; c=relaxed/simple;
	bh=/IwYFzKNd0b6j4iDPjr/CsH45uaj06J3itphBQ3Zp+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QY4oH6Cfp9q07mjvWo03sFfwzCBbvp/E513f1CIecSf9amhbfMwX3qT5y6+BLq33+dGwnIBLZz8UvtaMQkry9CzqdI4mEKhnTy/Cf3Pq5CTxoLpHoKjvXphLWn4h7V5QqudC6yJRBOdNIv6Jbh+RHzWSpcprgunlvUnHkpxuPvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Y7SgB10Nnz4f3jXr;
	Wed, 11 Dec 2024 15:59:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6000E1A058E;
	Wed, 11 Dec 2024 15:59:53 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDH7oJ3RllnncMdEQ--.13860S3;
	Wed, 11 Dec 2024 15:59:53 +0800 (CST)
Message-ID: <95c631d7-84da-412b-b7dc-f4785739f41a@huaweicloud.com>
Date: Wed, 11 Dec 2024 15:59:51 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/27] ext4: introduce seq counter for the extent status
 entry
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ritesh.list@gmail.com, hch@infradead.org, djwong@kernel.org,
 david@fromorbit.com, zokeefe@google.com, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
 <20241022111059.2566137-13-yi.zhang@huaweicloud.com>
 <20241204124221.aix7qxjl2n4ya3b7@quack3>
 <c831732e-38c5-4a82-ab30-de17cff29584@huaweicloud.com>
 <20241206162102.w4hw35ims5sdf4ik@quack3>
 <5049c794-9a92-462c-a455-2bdf94cdebef@huaweicloud.com>
 <20241210125726.gzcx6mpuecifqdwe@quack3>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20241210125726.gzcx6mpuecifqdwe@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDH7oJ3RllnncMdEQ--.13860S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw48XryDCr1xtrWxZFyxKrg_yoWxGFy3pF
	ZFkF43Kr4DJ34rXry7t3W2qFyrKw45JrW7XFnIg347AFn8KFyIgr1YkayjkFyxWrsaqr4j
	vF40v347Xa98ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/12/10 20:57, Jan Kara wrote:
> On Mon 09-12-24 16:32:41, Zhang Yi wrote:
>> On 2024/12/7 0:21, Jan Kara wrote:
>>>>> I think you'll need to use atomic_t and appropriate functions here.
>>>>>
>>>>>> @@ -872,6 +879,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>>>>>>  	BUG_ON(end < lblk);
>>>>>>  	WARN_ON_ONCE(status & EXTENT_STATUS_DELAYED);
>>>>>>  
>>>>>> +	ext4_es_inc_seq(inode);
>>>>>
>>>>> I'm somewhat wondering: Are extent status tree modifications the right
>>>>> place to advance the sequence counter? The counter needs to advance
>>>>> whenever the mapping information changes. This means that we'd be
>>>>> needlessly advancing the counter (and thus possibly forcing retries) when
>>>>> we are just adding new information from ordinary extent tree into cache.
>>>>> Also someone can be doing extent tree manipulations without touching extent
>>>>> status tree (if the information was already pruned from there). 
>>>>
>>>> Sorry, I don't quite understand here. IIUC, we can't modify the extent
>>>> tree without also touching extent status tree; otherwise, the extent
>>>> status tree will become stale, potentially leading to undesirable and
>>>> unexpected outcomes later on, as the extent lookup paths rely on and
>>>> always trust the status tree. If this situation happens, would it be
>>>> considered a bug? Additionally, I have checked the code but didn't find
>>>> any concrete cases where this could happen. Was I overlooked something?
>>>
>>> What I'm worried about is that this seems a bit fragile because e.g. in
>>> ext4_collapse_range() we do:
>>>
>>> ext4_es_remove_extent(inode, start, EXT_MAX_BLOCKS - start)
>>> <now go and manipulate the extent tree>
>>>
>>> So if somebody managed to sneak in between ext4_es_remove_extent() and
>>> the extent tree manipulation, he could get a block mapping which is shortly
>>> after invalidated by the extent tree changes. And as I'm checking now,
>>> writeback code *can* sneak in there because during extent tree
>>> manipulations we call ext4_datasem_ensure_credits() which can drop
>>> i_data_sem to restart a transaction.
>>>
>>> Now we do writeout & invalidate page cache before we start to do these
>>> extent tree dances so I don't see how this could lead to *actual* use
>>> after free issues but it makes me somewhat nervous. So that's why I'd like
>>> to have some clear rules from which it is obvious that the counter makes
>>> sure we do not use stale mappings.
>>
>> Yes, I see. I think the rule should be as follows:
>>
>> First, when the iomap infrastructure is creating or querying file
>> mapping information, we must ensure that the mapping information
>> always passes through the extent status tree, which means
>> ext4_map_blocks(), ext4_map_query_blocks(), and
>> ext4_map_create_blocks() should cache the extent status entries that
>> we intend to use.
> 
> OK, this currently holds. There's just one snag that during fastcommit
> replay ext4_es_insert_extent() doesn't do anything. I don't think there's
> any race possible during that stage but it's another case to think about.

OK.

> 
>> Second, when updating the extent tree, we must hold the i_data_sem in
>> write mode and update the extent status tree atomically.
> 
> Fine.
> 
>> Additionally,
>> if we cannot update the extent tree while holding a single i_data_sem,
>> we should first remove all related extent status entries within the
>> specified range, then manipulate the extent tree, ensuring that the
>> extent status entries are always up-to-date if they exist (as
>> ext4_collapse_range() does).
> 
> In this case, I think we need to provide more details. In particular I
> would require that in all such cases we must:
> a) hold i_rwsem exclusively and hold invalidate_lock exclusively ->
>    provides exclusion against page faults, reads, writes

Yes.

> b) evict all page cache in the affected range -> should stop writeback -
>    *but* currently there's one case which could be problematic. Assume we
>    do punch hole 0..N and the page at N+1 is dirty. Punch hole does all of
>    the above and starts removing blocks, needs to restart transaction so it
>    drops i_data_sem. Writeback starts for page N+1, needs to load extent
>    block into memory, ext4_cache_extents() now loads back some extents
>    covering range 0..N into extent status tree. 

This completely confuses me. Do you mention the case below,

There are many extent entries in the page range 0..N+1, for example,

   0                                  N N+1
   |                                  |/
  [www][wwwwww][wwwwwwww]...[wwwww][wwww]...
                |      |
                N-a    N-b

Punch hole is removing each extent entries from N..0
(ext4_ext_remove_space() removes blocks from end to start), and could
drop i_data_sem just after manipulating(removing) the extent entry
[N-a,N-b], At the same time, a concurrent writeback start write back
page N+1 since the writeback only hold page lock, doesn't hold i_rwsem
and invalidate_lock. It may load back the extents 0..N-a into the
extent status tree again while finding extent that contains N+1?
Finally it may left some stale extent status entries after punch hole
is done?

If my understanding is correct, isn't that a problem that exists now?
I mean without this patch series.

>    So the only protection
>    against using freed blocks is that nobody should be mapping anything in
>    the range 0..N because we hold those locks & have evicted page cache.
> 
> So I think we need to also document, that anybody mapping blocks needs to
> hold i_rwsem or invalidate_lock or a page lock, ideally asserting that in
> ext4_map_blocks() to catch cases we missed. Asserting for page lock will
> not be really doable but luckily only page writeback needs that so that can
> get some extemption from the assert.

In the case above, it seems that merely holding a page lock is
insufficient?

> 
>> Finally, if we want to manipulate the extent tree without caching, we
>> should also remove the extent status entries first.
> 
> Based on the above, I don't think this is really needed. We only must make
> sure that after all extent tree updates are done and before we release
> invalidate_lock, all extents from extent status tree in the modified range
> must be evicted / replaced to match reality.
> 
Yeah, I agree with you.

Thanks,
Yi.


