Return-Path: <linux-fsdevel+bounces-36745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 451CB9E8D7A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 09:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19EFD18853E0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 08:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AD021518F;
	Mon,  9 Dec 2024 08:32:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5F212CDAE;
	Mon,  9 Dec 2024 08:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733733171; cv=none; b=AHayFVwGUFRFLMHhMIBBbZVn8AzVkWJniUubao16h1i/MvtoMij22PTSvj+V5pjXyTWBwh5/MQzP6gzURuVvrgpsC9h4A/vg2TS8Ogkb32wLX85z4hpI5XxH/b9mcWxsOqQmyJyrj4HcHtsSUW+/BCYYUXfxOwy121+nPI37sDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733733171; c=relaxed/simple;
	bh=VUUC3f3CJjdejIJiTZlLnStIkUpffnYCpassVttA12s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=os/cVX6NvvbEVt/huybMbDLu+1Qj3rbzMi4ipHICJc+G1axIVfd1/r2QbEcyI+KK8nO+K4xyCcDQJpxB0W99XulsochhUa1eGnW/fYsBG9uH2nP2E7GEgARkt2TDHvr+4iAkkeE4jqNenlLQkkgZvIUJdqwYYEp0rHh5HcVTFAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y6FTz3vwZz4f3lft;
	Mon,  9 Dec 2024 16:32:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B57CE1A0568;
	Mon,  9 Dec 2024 16:32:43 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCXc4cpq1ZnvytgEA--.16063S3;
	Mon, 09 Dec 2024 16:32:43 +0800 (CST)
Message-ID: <5049c794-9a92-462c-a455-2bdf94cdebef@huaweicloud.com>
Date: Mon, 9 Dec 2024 16:32:41 +0800
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
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20241206162102.w4hw35ims5sdf4ik@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCXc4cpq1ZnvytgEA--.16063S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtrW8tFyxJry5CFy3JFWfAFb_yoW3WryxpF
	ZIkF1DKF4DJ340kryIq3W7XFyrK34rGrW7GFnIgr10y3Z8WFyS9F1Ykayj9F18ur4vqw4j
	vF48K347WayYvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 2024/12/7 0:21, Jan Kara wrote:
> On Fri 06-12-24 16:55:01, Zhang Yi wrote:
>> On 2024/12/4 20:42, Jan Kara wrote:
>>> On Tue 22-10-24 19:10:43, Zhang Yi wrote:
>>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>>
>>>> In the iomap_write_iter(), the iomap buffered write frame does not hold
>>>> any locks between querying the inode extent mapping info and performing
>>>> page cache writes. As a result, the extent mapping can be changed due to
>>>> concurrent I/O in flight. Similarly, in the iomap_writepage_map(), the
>>>> write-back process faces a similar problem: concurrent changes can
>>>> invalidate the extent mapping before the I/O is submitted.
>>>>
>>>> Therefore, both of these processes must recheck the mapping info after
>>>> acquiring the folio lock. To address this, similar to XFS, we propose
>>>> introducing an extent sequence number to serve as a validity cookie for
>>>> the extent. We will increment this number whenever the extent status
>>>> tree changes, thereby preparing for the buffered write iomap conversion.
>>>> Besides, it also changes the trace code style to make checkpatch.pl
>>>> happy.
>>>>
>>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>>>
>>> Overall using some sequence counter makes sense.
>>>
>>>> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
>>>> index c786691dabd3..bea4f87db502 100644
>>>> --- a/fs/ext4/extents_status.c
>>>> +++ b/fs/ext4/extents_status.c
>>>> @@ -204,6 +204,13 @@ static inline ext4_lblk_t ext4_es_end(struct extent_status *es)
>>>>  	return es->es_lblk + es->es_len - 1;
>>>>  }
>>>>  
>>>> +static inline void ext4_es_inc_seq(struct inode *inode)
>>>> +{
>>>> +	struct ext4_inode_info *ei = EXT4_I(inode);
>>>> +
>>>> +	WRITE_ONCE(ei->i_es_seq, READ_ONCE(ei->i_es_seq) + 1);
>>>> +}
>>>
>>> This looks potentially dangerous because we can loose i_es_seq updates this
>>> way. Like
>>>
>>> CPU1					CPU2
>>> x = READ_ONCE(ei->i_es_seq)
>>> 					x = READ_ONCE(ei->i_es_seq)
>>> 					WRITE_ONCE(ei->i_es_seq, x + 1)
>>> 					...
>>> 					potentially many times
>>> WRITE_ONCE(ei->i_es_seq, x + 1)
>>>   -> the counter goes back leading to possibly false equality checks
>>>
>>
>> In my current implementation, I don't think this race condition can
>> happen since all ext4_es_inc_seq() invocations are under
>> EXT4_I(inode)->i_es_lock. So I think it works fine now, or was I
>> missed something?
> 
> Hum, as far as I've checked, at least the place in ext4_es_insert_extent()
> where you call ext4_es_inc_seq() doesn't hold i_es_lock (yet). If you meant
> to protect the updates by i_es_lock, then move the call sites and please
> add a comment about it. Also it should be enough to do:
> 
> WRITE_ONCE(ei->i_es_seq, ei->i_es_seq + 1);
> 
> since we cannot be really racing with other writers.

Oh, sorry, I mentioned the wrong lock. What I intended to say is
i_data_sem.

Currently, all instances where we update the extent status tree will
hold i_data_sem in write mode, preventing any race conditions in these
scenarios. However, we may hold i_data_sem in read mode while loading
a new entry from the extent tree (e.g., ext4_map_query_blocks()). In
these cases, a race condition could occur, but it doesn't modify the
extents, and the new loading range should not be related to the
mapping range we obtained (If it covers with the range we have, it
must first remove the old extents entry, which is protected by
i_data_sem, ensuring that i_es_seq increases by at least one).
Therefore, it should not use stale mapping and trigger any real issues.

However, after thinking about it again, I agree with you that this
approach is subtle, fragile and make us hard to understand, now I think
we should move it into i_es_lock.

> 
>>> I think you'll need to use atomic_t and appropriate functions here.
>>>
>>>> @@ -872,6 +879,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>>>>  	BUG_ON(end < lblk);
>>>>  	WARN_ON_ONCE(status & EXTENT_STATUS_DELAYED);
>>>>  
>>>> +	ext4_es_inc_seq(inode);
>>>
>>> I'm somewhat wondering: Are extent status tree modifications the right
>>> place to advance the sequence counter? The counter needs to advance
>>> whenever the mapping information changes. This means that we'd be
>>> needlessly advancing the counter (and thus possibly forcing retries) when
>>> we are just adding new information from ordinary extent tree into cache.
>>> Also someone can be doing extent tree manipulations without touching extent
>>> status tree (if the information was already pruned from there). 
>>
>> Sorry, I don't quite understand here. IIUC, we can't modify the extent
>> tree without also touching extent status tree; otherwise, the extent
>> status tree will become stale, potentially leading to undesirable and
>> unexpected outcomes later on, as the extent lookup paths rely on and
>> always trust the status tree. If this situation happens, would it be
>> considered a bug? Additionally, I have checked the code but didn't find
>> any concrete cases where this could happen. Was I overlooked something?
> 
> What I'm worried about is that this seems a bit fragile because e.g. in
> ext4_collapse_range() we do:
> 
> ext4_es_remove_extent(inode, start, EXT_MAX_BLOCKS - start)
> <now go and manipulate the extent tree>
> 
> So if somebody managed to sneak in between ext4_es_remove_extent() and
> the extent tree manipulation, he could get a block mapping which is shortly
> after invalidated by the extent tree changes. And as I'm checking now,
> writeback code *can* sneak in there because during extent tree
> manipulations we call ext4_datasem_ensure_credits() which can drop
> i_data_sem to restart a transaction.
> 
> Now we do writeout & invalidate page cache before we start to do these
> extent tree dances so I don't see how this could lead to *actual* use
> after free issues but it makes me somewhat nervous. So that's why I'd like
> to have some clear rules from which it is obvious that the counter makes
> sure we do not use stale mappings.

Yes, I see. I think the rule should be as follows:

First, when the iomap infrastructure is creating or querying file
mapping information, we must ensure that the mapping information
always passes through the extent status tree, which means
ext4_map_blocks(), ext4_map_query_blocks(), and
ext4_map_create_blocks() should cache the extent status entries that
we intend to use.

Second, when updating the extent tree, we must hold the i_data_sem in
write mode and update the extent status tree atomically. Additionally,
if we cannot update the extent tree while holding a single i_data_sem,
we should first remove all related extent status entries within the
specified range, then manipulate the extent tree, ensuring that the
extent status entries are always up-to-date if they exist (as
ext4_collapse_range() does).

Finally, if we want to manipulate the extent tree without caching, we
should also remove the extent status entries first.

In summary, ensure that the extent status tree and the extent tree are
consistent under one i_data_sem. If we can't, remove the extent status
entry before manipulating the extent tree.

Do you agree?

> 
>>> So I think
>>> needs some very good documentation what are the expectations from the
>>> sequence counter and explanations why they are satisfied so that we don't
>>> break this in the future.
>>
>> Yeah, it's a good suggestion, where do you suggest putting this
>> documentation, how about in the front of extents_status.c?
> 
> I think at the function incrementing the counter would be fine.
> 

Sure, thanks for pointing this out.

Thanks,
Yi.


