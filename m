Return-Path: <linux-fsdevel+bounces-56806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC117B1BF0C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 05:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66050625F5C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 03:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9D91DF97D;
	Wed,  6 Aug 2025 03:10:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A8122F01;
	Wed,  6 Aug 2025 03:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754449843; cv=none; b=HoR6KYo0M2wivQY7wbRvIAKOwAJTyBnIXMMqXeIr+i5FFG9WDFZ+LuLTM18apLJThsghqiSsaMS+xoK5CaGMbuknTCW/RaPOBuvJuaATpEjXwJ1p6Fpa6bRIGmBiPkIxvT5Sn4I0hn8nL4jQpOO6knLbRzNL+4VChRPfe6WkJNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754449843; c=relaxed/simple;
	bh=sJenFqwYEZj/e24GydxFf/tp0pf1cMHK8HXO9hg+vGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUivLYk1jHR8GfJAtQwHUbCJ8OXn609axFlGI4bn6Y5NPpY4wD2X2l4U9WhFA91yp1+WPGuYi/ib53c2mz5GG7p0phs17w0EOkAJKiJbAAIx4ycP2rVyw2QQZuKE2o2AKRxUPKObxHf4e61Uj6DIhJ5kDmbqq2HvruyGVqx08UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bxZzs29sdzKHMTt;
	Wed,  6 Aug 2025 11:10:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 59CC71A07BB;
	Wed,  6 Aug 2025 11:10:32 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgA3sxOmx5JolRvnCg--.42172S3;
	Wed, 06 Aug 2025 11:10:32 +0800 (CST)
Message-ID: <9c09377d-5a88-4935-9d28-5683a8263de5@huaweicloud.com>
Date: Wed, 6 Aug 2025 11:10:30 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] iomap: optional zero range dirty folio processing
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, hch@infradead.org, willy@infradead.org,
 "Darrick J. Wong" <djwong@kernel.org>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>
References: <20250714204122.349582-1-bfoster@redhat.com>
 <20250714204122.349582-4-bfoster@redhat.com>
 <20250715052259.GO2672049@frogsfrogsfrogs>
 <e6333d2d-cc30-44d3-8f23-6a6c5ea0134d@huaweicloud.com>
 <aHpQxq6mDyLL1Nfj@bfoster>
 <09b7c1cf-7bfa-4798-b9de-f49620046664@huaweicloud.com>
 <aIobh49Bb0Vqz10I@bfoster>
 <c12ae271-63ba-4028-8da1-131d95727764@huaweicloud.com>
 <aJICOpY5FU1vHZvm@bfoster>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <aJICOpY5FU1vHZvm@bfoster>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgA3sxOmx5JolRvnCg--.42172S3
X-Coremail-Antispam: 1UD129KBjvAXoW3uw1rXF43WFWUtrykCr1kGrg_yoW8CF18Wo
	WfXw4xXF48tr98AFW8C3srGryUu3Z8ur18JrWUZr4YqF90q3yUCw4xGwsrXay3JrWUCr47
	J348J3Z8ArW7XF1fn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUU5M7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/8/5 21:08, Brian Foster wrote:
> On Sat, Aug 02, 2025 at 03:19:54PM +0800, Zhang Yi wrote:
>> On 2025/7/30 21:17, Brian Foster wrote:
>>> On Sat, Jul 19, 2025 at 07:07:43PM +0800, Zhang Yi wrote:
>>>> On 2025/7/18 21:48, Brian Foster wrote:
>>>>> On Fri, Jul 18, 2025 at 07:30:10PM +0800, Zhang Yi wrote:
>>>>>> On 2025/7/15 13:22, Darrick J. Wong wrote:
>>>>>>> On Mon, Jul 14, 2025 at 04:41:18PM -0400, Brian Foster wrote:
>>>>>>>> The only way zero range can currently process unwritten mappings
>>>>>>>> with dirty pagecache is to check whether the range is dirty before
>>>>>>>> mapping lookup and then flush when at least one underlying mapping
>>>>>>>> is unwritten. This ordering is required to prevent iomap lookup from
>>>>>>>> racing with folio writeback and reclaim.
>>>>>>>>
>>>>>>>> Since zero range can skip ranges of unwritten mappings that are
>>>>>>>> clean in cache, this operation can be improved by allowing the
>>>>>>>> filesystem to provide a set of dirty folios that require zeroing. In
>>>>>>>> turn, rather than flush or iterate file offsets, zero range can
>>>>>>>> iterate on folios in the batch and advance over clean or uncached
>>>>>>>> ranges in between.
>>>>>>>>
>>>>>>>> Add a folio_batch in struct iomap and provide a helper for fs' to
>>>>>>>
>>>>>>> /me confused by the single quote; is this supposed to read:
>>>>>>>
>>>>>>> "...for the fs to populate..."?
>>>>>>>
>>>>>>> Either way the code changes look like a reasonable thing to do for the
>>>>>>> pagecache (try to grab a bunch of dirty folios while XFS holds the
>>>>>>> mapping lock) so
>>>>>>>
>>>>>>> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>>>>>>>
>>>>>>> --D
>>>>>>>
>>>>>>>
>>>>>>>> populate the batch at lookup time. Update the folio lookup path to
>>>>>>>> return the next folio in the batch, if provided, and advance the
>>>>>>>> iter if the folio starts beyond the current offset.
>>>>>>>>
>>>>>>>> Signed-off-by: Brian Foster <bfoster@redhat.com>
>>>>>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>>>>>> ---
>>>>>>>>  fs/iomap/buffered-io.c | 89 +++++++++++++++++++++++++++++++++++++++---
>>>>>>>>  fs/iomap/iter.c        |  6 +++
>>>>>>>>  include/linux/iomap.h  |  4 ++
>>>>>>>>  3 files changed, 94 insertions(+), 5 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>>>>>>>> index 38da2fa6e6b0..194e3cc0857f 100644
>>>>>>>> --- a/fs/iomap/buffered-io.c
>>>>>>>> +++ b/fs/iomap/buffered-io.c
>>>>>> [...]
>>>>>>>> @@ -1398,6 +1452,26 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>>>>>>>>  	return status;
>>>>>>>>  }
>>>>>>>>  
>>>>>>>> +loff_t
>>>>>>>> +iomap_fill_dirty_folios(
>>>>>>>> +	struct iomap_iter	*iter,
>>>>>>>> +	loff_t			offset,
>>>>>>>> +	loff_t			length)
>>>>>>>> +{
>>>>>>>> +	struct address_space	*mapping = iter->inode->i_mapping;
>>>>>>>> +	pgoff_t			start = offset >> PAGE_SHIFT;
>>>>>>>> +	pgoff_t			end = (offset + length - 1) >> PAGE_SHIFT;
>>>>>>>> +
>>>>>>>> +	iter->fbatch = kmalloc(sizeof(struct folio_batch), GFP_KERNEL);
>>>>>>>> +	if (!iter->fbatch)
>>>>>>
>>>>>> Hi, Brian!
>>>>>>
>>>>>> I think ext4 needs to be aware of this failure after it converts to use
>>>>>> iomap infrastructure. It is because if we fail to add dirty folios to the
>>>>>> fbatch, iomap_zero_range() will flush those unwritten and dirty range.
>>>>>> This could potentially lead to a deadlock, as most calls to
>>>>>> ext4_block_zero_page_range() occur under an active journal handle.
>>>>>> Writeback operations under an active journal handle may result in circular
>>>>>> waiting within journal transactions. So please return this error code, and
>>>>>> then ext4 can interrupt zero operations to prevent deadlock.
>>>>>>
>>>>>
>>>>> Hi Yi,
>>>>>
>>>>> Thanks for looking at this.
>>>>>
>>>>> Huh.. so the reason for falling back like this here is just that this
>>>>> was considered an optional optimization, with the flush in
>>>>> iomap_zero_range() being default fallback behavior. IIUC, what you're
>>>>> saying means that the current zero range behavior without this series is
>>>>> problematic for ext4-on-iomap..? 
>>>>
>>>> Yes.
>>>>
>>>>> If so, have you observed issues you can share details about?
>>>>
>>>> Sure.
>>>>
>>>> Before delving into the specific details of this issue, I would like
>>>> to provide some background information on the rule that ext4 cannot
>>>> wait for writeback in an active journal handle. If you are aware of
>>>> this background, please skip this paragraph. During ext4 writing back
>>>> the page cache, it may start a new journal handle to allocate blocks,
>>>> update the disksize, and convert unwritten extents after the I/O is
>>>> completed. When starting this new journal handle, if the current
>>>> running journal transaction is in the process of being submitted or
>>>> if the journal space is insufficient, it must wait for the ongoing
>>>> transaction to be completed, but the prerequisite for this is that all
>>>> currently running handles must be terminated. However, if we flush the
>>>> page cache under an active journal handle, we cannot stop it, which
>>>> may lead to a deadlock.
>>>>
>>>
>>> Ok, makes sense.
>>>
>>>> Now, the issue I have observed occurs when I attempt to use
>>>> iomap_zero_range() within ext4_block_zero_page_range(). My current
>>>> implementation are below(based on the latest fs-next).
>>>>
>>>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>>>> index 28547663e4fd..1a21667f3f7c 100644
>>>> --- a/fs/ext4/inode.c
>>>> +++ b/fs/ext4/inode.c
>>>> @@ -4147,6 +4147,53 @@ static int ext4_iomap_buffered_da_write_end(struct inode *inode, loff_t offset,
>>>>  	return 0;
>>>>  }
>>>>
>>>> +static int ext4_iomap_buffered_zero_begin(struct inode *inode, loff_t offset,
>>>> +			loff_t length, unsigned int flags, struct iomap *iomap,
>>>> +			struct iomap *srcmap)
>>>> +{
>>>> +	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
>>>> +	struct ext4_map_blocks map;
>>>> +	u8 blkbits = inode->i_blkbits;
>>>> +	int ret;
>>>> +
>>>> +	ret = ext4_emergency_state(inode->i_sb);
>>>> +	if (unlikely(ret))
>>>> +		return ret;
>>>> +
>>>> +	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
>>>> +		return -EINVAL;
>>>> +
>>>> +	/* Calculate the first and last logical blocks respectively. */
>>>> +	map.m_lblk = offset >> blkbits;
>>>> +	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
>>>> +			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
>>>> +
>>>> +	ret = ext4_map_blocks(NULL, inode, &map, 0);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	/*
>>>> +	 * Look up dirty folios for unwritten mappings within EOF. Providing
>>>> +	 * this bypasses the flush iomap uses to trigger extent conversion
>>>> +	 * when unwritten mappings have dirty pagecache in need of zeroing.
>>>> +	 */
>>>> +	if ((map.m_flags & EXT4_MAP_UNWRITTEN) &&
>>>> +	    map.m_lblk < EXT4_B_TO_LBLK(inode, i_size_read(inode))) {
>>>> +		loff_t end;
>>>> +
>>>> +		end = iomap_fill_dirty_folios(iter, map.m_lblk << blkbits,
>>>> +					      map.m_len << blkbits);
>>>> +		if ((end >> blkbits) < map.m_lblk + map.m_len)
>>>> +			map.m_len = (end >> blkbits) - map.m_lblk;
>>>> +	}
>>>> +
>>>> +	ext4_set_iomap(inode, iomap, &map, offset, length, flags);
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +const struct iomap_ops ext4_iomap_buffered_zero_ops = {
>>>> +	.iomap_begin = ext4_iomap_buffered_zero_begin,
>>>> +};
>>>>
>>>>  const struct iomap_ops ext4_iomap_buffered_write_ops = {
>>>>  	.iomap_begin = ext4_iomap_buffered_write_begin,
>>>> @@ -4611,6 +4658,17 @@ static int __ext4_block_zero_page_range(handle_t *handle,
>>>>  	return err;
>>>>  }
>>>>
>>>> +static inline int ext4_iomap_zero_range(struct inode *inode, loff_t from,
>>>> +					loff_t length)
>>>> +{
>>>> +	WARN_ON_ONCE(!inode_is_locked(inode) &&
>>>> +		     !rwsem_is_locked(&inode->i_mapping->invalidate_lock));
>>>> +
>>>> +	return iomap_zero_range(inode, from, length, NULL,
>>>> +				&ext4_iomap_buffered_zero_ops,
>>>> +				&ext4_iomap_write_ops, NULL);
>>>> +}
>>>> +
>>>>  /*
>>>>   * ext4_block_zero_page_range() zeros out a mapping of length 'length'
>>>>   * starting from file offset 'from'.  The range to be zero'd must
>>>> @@ -4636,6 +4694,8 @@ static int ext4_block_zero_page_range(handle_t *handle,
>>>>  	if (IS_DAX(inode)) {
>>>>  		return dax_zero_range(inode, from, length, NULL,
>>>>  				      &ext4_iomap_ops);
>>>> +	} else if (ext4_test_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP)) {
>>>> +		return ext4_iomap_zero_range(inode, from, length);
>>>>  	}
>>>>  	return __ext4_block_zero_page_range(handle, mapping, from, length);
>>>>  }
>>>>
>>>> The problem is most calls to ext4_block_zero_page_range() occur under
>>>> an active journal handle, so I can reproduce the deadlock issue easily
>>>> without this series.
>>>>
>>>>>
>>>>> FWIW, I think your suggestion is reasonable, but I'm also curious what
>>>>> the error handling would look like in ext4. Do you expect to the fail
>>>>> the higher level operation, for example? Cycle locks and retry, etc.?
>>>>
>>>> Originally, I wanted ext4_block_zero_page_range() to return a failure
>>>> to the higher level operation. However, unfortunately, after my testing
>>>> today, I discovered that even though we implement this, this series still
>>>> cannot resolve the issue. The corner case is:
>>>>
>>>> Assume we have a dirty folio covers both hole and unwritten mappings.
>>>>
>>>>    |- dirty folio  -|
>>>>    [hhhhhhhhuuuuuuuu]                h:hole, u:unwrtten
>>>>
>>>> If we punch the range of the hole, ext4_punch_hole()->
>>>> ext4_zero_partial_blocks() will zero out the first half of the dirty folio.
>>>> Then, ext4_iomap_buffered_zero_begin() will skip adding this dirty folio
>>>> since the target range is a hole. Finally, iomap_zero_range() will still
>>>> flush this whole folio and lead to deadlock during writeback the latter
>>>> half of the folio.
>>>>
>>>
>>> Hmm.. Ok. So it seems there are at least a couple ways around this
>>> particular quirk. I suspect one is that you could just call the fill
>>> helper in the hole case as well, but that's kind of a hack and not
>>> really intended use.
>>>
>>> The other way goes back to the fact that the flush for the hole case was
>>> kind of a corner case hack in the first place. The original comment for
>>> that seems to have been dropped, but see commit 7d9b474ee4cc ("iomap:
>>> make zero range flush conditional on unwritten mappings") for reference
>>> to the original intent.
>>>
>>> I'd have to go back and investigate if something regresses with that
>>> taken out, but my recollection is that was something that needed proper
>>> fixing eventually anyways. I'm particularly wondering if that is no
>>> longer an issue now that pagecache_isize_extended() handles the post-eof
>>> zeroing (the caveat being we might just need to call it in some
>>> additional size extension cases besides just setattr/truncate).
>>
>> Yeah, I agree with you. I suppose the post-EOF partial folio zeroing in
>> pagecache_isize_extended() should work.
>>
> 
> Ok..
> 
>>>
>>>>>
>>>>> The reason I ask is because the folio_batch handling has come up through
>>>>> discussions on this series. My position so far has been to keep it as a
>>>>> separate allocation and to keep things simple since it is currently
>>>>> isolated to zero range, but that may change if the usage spills over to
>>>>> other operations (which seems expected at this point). I suspect that if
>>>>> a filesystem actually depends on this for correct behavior, that is
>>>>> another data point worth considering on that topic.
>>>>>
>>>>> So that has me wondering if it would be better/easier here to perhaps
>>>>> embed the batch in iomap_iter, or maybe as an incremental step put it on
>>>>> the stack in iomap_zero_range() and initialize the iomap_iter pointer
>>>>> there instead of doing the dynamic allocation (then the fill helper
>>>>> would set a flag to indicate the fs did pagecache lookup). Thoughts on
>>>>> something like that?
>>>>>
>>>>> Also IIUC ext4-on-iomap is still a WIP and review on this series seems
>>>>> to have mostly wound down. Any objection if the fix for that comes along
>>>>> as a followup patch rather than a rework of this series?
>>>>
>>>> It seems that we don't need to modify this series, we need to consider
>>>> other solutions to resolve this deadlock issue.
>>>>
>>>> In my v1 ext4-on-iomap series [1], I resolved this issue by moving all
>>>> instances of ext4_block_zero_page_range() out of the running journal
>>>> handle(please see patch 19-21). But I don't think this is a good solution
>>>> since it's complex and fragile. Besides, after commit c7fc0366c6562
>>>> ("ext4: partial zero eof block on unaligned inode size extension"), you
>>>> added more invocations of ext4_zero_partial_blocks(), and the situation
>>>> has become more complicated (Althrough I think the calls in the three
>>>> write_end callbacks can be removed).
>>>>
>>>> Besides, IIUC, it seems that ext4 doesn't need to flush dirty folios
>>>> over unwritten mappings before zeroing partial blocks. This is because
>>>> ext4 always zeroes the in-memory page cache before zeroing(e.g, in
>>>> ext4_setattr() and ext4_punch_hole()), it means if the target range is
>>>> still dirty and unwritten when calling ext4_block_zero_page_range(), it
>>>> must has already been zeroed. Was I missing something? Therefore, I was
>>>> wondering if there are any ways to prevent flushing in
>>>> iomap_zero_range()? Any ideas?
>>>
>>> It's certainly possible that the quirk fixed by the flush the hole case
>>> was never a problem on ext4, if that's what you mean. Most of the
>>> testing for this was on XFS since ext4 hadn't used iomap for buffered
>>> writes.
>>>
>>> At the end of the day, the batch mechanism is intended to facilitate
>>> avoiding the flush entirely. I'm still paging things back in here.. but
>>> if we had two smallish changes to this code path to 1. eliminate the
>>> dynamic folio_batch allocation and 2. drop the flush on hole mapping
>>> case, would that address the issues with iomap zero range for ext4?
>>>
>>
>> Thank you for looking at this!
>>
>> I made a simple modification to the iomap_zero_range() function based
>> on the second solution you mentioned, then tested it using kvm-xfstests
>> these days. This solution works fine on ext4 and I don't find any other
>> risks by now. (Since my testing environment has sufficient memory, I
>> have not yet handled the case of memory allocation failure).
>>
> 
> Great, thanks for evaluating that. I've been playing around with the
> exact same change the past few days. As it turns out, this still breaks
> something with XFS. I've narrowed it down to an interaction between a
> large eof folio that fails to split on truncate due to being dirty, COW
> prealloc and insert range racing with writeback in such a way that this
> results in a mapped post-eof block on the file. Technically that isn't
> the end of the world so long as it is zeroed, but a subsequent zero
> range can warn if the folio is reclaimed and we now end up with a new
> one that starts beyond EOF, because those folios don't write back.
> 
> I have a mix of hacks that seems to address the generic/363 failure, but
> it still needs further testing and analysis to unwind my mess of various
> experiments and whatnot. ;P

OK, thanks for debugging and analyzing this.

> 
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
>> @@ -1520,7 +1520,7 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>> 		     srcmap->type == IOMAP_UNWRITTEN)) {
>> 			s64 status;
>>
>> -			if (range_dirty) {
>> +			if (range_dirty && srcmap->type == IOMAP_UNWRITTEN) {
>> 				range_dirty = false;
>> 				status = iomap_zero_iter_flush_and_stale(&iter);
>> 			} else {
>>
>> Another thing I want to mention (although there are no real issues at
>> the moment, I still want to mention it) is that there appears to be
>> no consistency guarantee between the lookup of the mapping and the
>> follo_batch. For example, assume we have a file which contains two
>> dirty folio and two unwritten extents, one folio corresponds to one
>> extent. We zero out these two folios.
>>
>>     | dirty folio 1  || dirty folio 2   |
>>     [uuuuuuuuuuuuuuuu][uuuuuuuuuuuuuuuuu]
>>
>> In the first call to ->iomap_begin(), we get the unwritten extent 1.
>> At the same time, another thread writes back folio 1 and clears this
>> folio, so this folio will not be added to the follo_batch. Then
>> iomap_zero_range() will still flush those two folios. When flushing
>> the second folio, there is still a risk of deadlock due to changes in
>> metadata.
>>
> 
> Hmm.. not sure I follow the example. The folio batch should include the
> folio in any case other than where it can look up, lock it and confirm
> it is clean. If the folio is clean and thus not included, the iomap
> logic should still see the empty folio batch and skip over the mapping
> if unwritten. (I want to replace this with a flag to address your memory
> allocation concern, but that is orthogonal to this logic.)
> 
> Of course this should happen under appropriate fs locks such that iomap
> either sees the folio in dirty/writeback state where the mapping is
> unwritten, or if the folio has been cleaned, the mapping is reported as
> written.
> 
> If I'm still missing something with your example above, can you
> elaborate a bit further? Thanks.
> 

Sorry for not make things clear. The race condition is the following,

zero range                            sync_file_range
iomap_zero_range() //folio 1+2
 range_dirty = filemap_range_needs_writeback()
 //range_dirty is set to 'ture'
 iomap_iter()
   ext4_iomap_buffer_zero_begin()
     ext4_map_blocks()
     //get unwritten extent 1
                                      sync_file_range() //folio 1
                                        iomap_writepages()
                                        ...
                                        iomap_finish_ioend()
                                          folio_end_writeback()
                                          //clear folio 1, and
                                          //extent 1 becomes written
     iomap_fill_dirty_folios()
     //do not add folio 1 to batch
  iomap_zero_iter_flush_and_stale()
  //!fbatch && IOMAP_UNWRITTEN && range_dirty
  //flush folio 1+2, folio 2 is still dirty, then deadlock

Besides, if the range of folio 1 is initially clean and unwritten
(folio 2 is still dirty), the flush can also be triggered without the
concurrent sync_file_range.

The problem is that we initially checked `range_dirty` only once, and
if was done for the entire zero range, instead of checking it each
iteration, and there is no fs lock can prevent a concurrent write-back.
Perhaps we need to check 'dirty_range' for each iteration?

Regards,
Yi.


