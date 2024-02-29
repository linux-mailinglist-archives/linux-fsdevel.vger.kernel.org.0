Return-Path: <linux-fsdevel+bounces-13174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F3A86C464
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 10:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7FB1F281D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 09:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E4556B7B;
	Thu, 29 Feb 2024 08:59:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53705674B;
	Thu, 29 Feb 2024 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709197188; cv=none; b=V9GP2HaZWDVQ+9YEdsiHLblEa9Rsj46ZRZdcp7e3DLOxrJM1ah4cjBEi1SJm7Iam97HFjAdRQNsHfYyDnDofcm576Aw3opckfd3AJIpLPVRdIBPQ9EZqD/ibfAZPIzvVNgN9Gn3cVEHuyHsRvdnwA2q40H3jr7lbCslIC2GM0Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709197188; c=relaxed/simple;
	bh=G27e/cZk6SCpGUGSgkKDJkfrqLVdTK2xuXg/Z4zqBQQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=X1nTiJEQmvpDs2HnRzsZpEWjTEfOWcFpRhQycC1F7acAey/T1P6i9WulbLktqGth+JxEv719GBivIhfHMwcMPweJ5Tw9DqBCP9517hYOF4MX8U5c7Bwre8AV5AcnpqeZq4gSOUWQqbdWDAlVJy2BN6sNItoH4UMG+qaQ/913v6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TllXK5Fzzz4f3mHS;
	Thu, 29 Feb 2024 16:59:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 15ADB1A016E;
	Thu, 29 Feb 2024 16:59:37 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxB2R+Bl8TYDFg--.4638S3;
	Thu, 29 Feb 2024 16:59:36 +0800 (CST)
Subject: Re: [RFC PATCH v3 07/26] iomap: don't increase i_size if it's not a
 write operation
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>, djwong@kernel.org,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
 ritesh.list@gmail.com, willy@infradead.org, zokeefe@google.com,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
 wangkefeng.wang@huawei.com
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
 <20240127015825.1608160-8-yi.zhang@huaweicloud.com>
 <ZcsCP4h-ExNOcdD6@infradead.org>
 <9b0040ef-3d9d-6246-4bdd-82b9a8f55fa2@huaweicloud.com>
 <Zd+y2VP8HpbkDu41@dread.disaster.area>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <45c1607a-805d-e7a2-a5ca-3fd7e507a664@huaweicloud.com>
Date: Thu, 29 Feb 2024 16:59:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zd+y2VP8HpbkDu41@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxB2R+Bl8TYDFg--.4638S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Zw4DXr1kJr13Xr4fAw15XFb_yoWkJFykpF
	W0g3WUK34ktry7Arn7AFsFqa40k3yfJFW8WrW5tr9Fvrn8Cr1IgFn7GayY9FWDWrn7Ar10
	qF48W34xCwn8ZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Hello, Dave!

On 2024/2/29 6:25, Dave Chinner wrote:
> On Wed, Feb 28, 2024 at 04:53:32PM +0800, Zhang Yi wrote:
>> On 2024/2/13 13:46, Christoph Hellwig wrote:
>>> Wouldn't it make more sense to just move the size manipulation to the
>>> write-only code?  An untested version of that is below.  With this
>>> the naming of the status variable becomes even more confusing than
>>> it already is, maybe we need to do a cleanup of the *_write_end
>>> calling conventions as it always returns the passed in copied value
>>> or 0.
>>>
>>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>>> index 3dab060aed6d7b..8401a9ca702fc0 100644
>>> --- a/fs/iomap/buffered-io.c
>>> +++ b/fs/iomap/buffered-io.c
>>> @@ -876,34 +876,13 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
>>>  		size_t copied, struct folio *folio)
>>>  {
>>>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>>> -	loff_t old_size = iter->inode->i_size;
>>> -	size_t ret;
>>> -
>>> -	if (srcmap->type == IOMAP_INLINE) {
>>> -		ret = iomap_write_end_inline(iter, folio, pos, copied);
>>> -	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
>>> -		ret = block_write_end(NULL, iter->inode->i_mapping, pos, len,
>>> -				copied, &folio->page, NULL);
>>> -	} else {
>>> -		ret = __iomap_write_end(iter->inode, pos, len, copied, folio);
>>> -	}
>>> -
>>> -	/*
>>> -	 * Update the in-memory inode size after copying the data into the page
>>> -	 * cache.  It's up to the file system to write the updated size to disk,
>>> -	 * preferably after I/O completion so that no stale data is exposed.
>>> -	 */
>>> -	if (pos + ret > old_size) {
>>> -		i_size_write(iter->inode, pos + ret);
>>> -		iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
>>> -	}
>>
>> I've recently discovered that if we don't increase i_size in
>> iomap_zero_iter(), it would break fstests generic/476 on xfs. xfs
>> depends on iomap_zero_iter() to increase i_size in some cases.
>>
>>  generic/476 75s ... _check_xfs_filesystem: filesystem on /dev/pmem2 is inconsistent (r)
>>  (see /home/zhangyi/xfstests-dev/results//xfs/generic/476.full for details)
>>
>>  _check_xfs_filesystem: filesystem on /dev/pmem2 is inconsistent (r)
>>  *** xfs_repair -n output ***
>>  Phase 1 - find and verify superblock...
>>  Phase 2 - using internal log
>>          - zero log...
>>          - scan filesystem freespace and inode maps...
>>  sb_fdblocks 10916, counted 10923
>>          - found root inode chunk
>>  ...
>>
>> After debugging and analysis, I found the root cause of the problem is
>> related to the pre-allocations of xfs. xfs pre-allocates some blocks to
>> reduce fragmentation during buffer append writing, then if we write new
>> data or do file copy(reflink) after the end of the pre-allocating range,
>> xfs would zero-out and write back the pre-allocate space(e.g.
>> xfs_file_write_checks() -> xfs_zero_range()), so we have to update
>> i_size before writing back in iomap_zero_iter(), otherwise, it will
>> result in stale delayed extent.
> 
> Ok, so this is long because the example is lacking in clear details
> so to try to understand it I've laid it out in detail to make sure
> I've understood it correctly.
> 

Thanks for the graph, the added detail makes things clear and easy to
understand. To be honest, it's not exactly the same as the results I
captured and described (the position A\B\C\D\E\F I described is
increased one by one), but the root cause of the problem is the same,
so it doesn't affect our understanding of the problem.

>>
>> For more details, let's think about this case,
>> 1. Buffered write from range [A, B) of an empty file foo, and
>>    xfs_buffered_write_iomap_begin() prealloc blocks for it, then create
>>    a delayed extent from [A, D).
> 
> So we have a delayed allocation extent  and the file size is now B
> like so:
> 
> 	A                      B                    D
> 	+DDDDDDDDDDDDDDDDDDDDDD+dddddddddddddddddddd+
> 	                      EOF
> 			  (in memory)
> 
> where 'd' is a delalloc block with no data and 'D' is a delalloc
> block with dirty folios over it.
> 

Yes

>> 2. Write back process map blocks but only convert above delayed extent
>>    from [A, C) since the lack of a contiguous physical blocks, now we
>>    have a left over delayed extent from [C, D), and the file size is B.
> 
> So this produces:
> 
> 	A          C           B                    D
> 	+wwwwwwwwww+DDDDDDDDDDD+dddddddddddddddddddd+
> 	          EOF         EOF
>                (on disk)  (in memory)
> 
> where 'w' contains allocated written data blocks.
> 

The results I captured is:

 	A                      B         C          D
 	+wwwwwwwwwwwwwwwwwwwwww+uuuuuuuuu+ddddddddddd+
 	                      EOF
                          (in memory)
                           (on disk)

>> 3. Copy range from another file to range [E, F), then
>>    xfs_reflink_zero_posteof() would zero-out post eof range [B, E), it
>>    writes zero, dirty and write back [C, E).
> 
> I'm going to assume that [E,F) is located like this because you
> are talking about post-eof zeroing from B to E:
> 
> 	A          C           B     E       F      D
> 	+wwwwwwwwww+DDDDDDDDDDD+ddddd+rrrrrrr+dddddd+
> 	          EOF         EOF
>                (on disk)  (in memory)
> 
> where 'r' is the clone destination over dellaloc blocks.
> 
> Did I get that right?
> 

The results I captured is:

 	A                      B         C          D      E       F
 	+wwwwwwwwwwwwwwwwwwwwww+uuuuuuuuu+dddddddddd+hhhhhh+rrrrrrr+
 	                      EOF
                          (in memory)
                           (on disk)

where 'h' contains a hole.

> And so reflink wants to zero [B,E] before it updates the file size,
> just like a truncate(E) would. iomap_zero_iter() will see a delalloc
> extent (IOMAP_DELALLOC) for [B,E], so it will write zeros into cache
> for it. We then have:
> 
> 	A          C           B     E       F      D
> 	+wwwwwwwwww+DDDDDDDDDDD+ZZZZZ+rrrrrrr+dddddd+
> 	          EOF         EOF
>                (on disk)  (in memory)
> 
> where 'Z' is delalloc blocks with zeroes in cache.
> 

The results I captured is:

 	A                      B         C          D      E       F
 	+wwwwwwwwwwwwwwwwwwwwww+uuuuuuuuu+ZZZZZZZZZZ+hhhhhh+rrrrrrr+
 	                      EOF
                          (in memory)
                           (on disk)

> Because the destination is post EOF, xfs_reflink_remap_prep() then
> does:
> 
>         /*
>          * If pos_out > EOF, we may have dirtied blocks between EOF and
>          * pos_out. In that case, we need to extend the flush and unmap to cover
>          * from EOF to the end of the copy length.
>          */
>         if (pos_out > XFS_ISIZE(dest)) {
>                 loff_t  flen = *len + (pos_out - XFS_ISIZE(dest));
>                 ret = xfs_flush_unmap_range(dest, XFS_ISIZE(dest), flen);
> 	} ....
> 
> Which attempts to flush from the current in memory EOF up to the end
> of the clone destination range. This should result in:
> 
> 	A          C           B     E       F      D
> 	+wwwwwwwwww+DDDDDDDDDDD+zzzzz+rrrrrrr+dddddd+
> 	          EOF         EOF
>                (on disk)  (in memory)
> 
> Where 'z' is zeroes on disk.
> 
> Have I understood this correctly?
> 

The results I captured is:

 	A                      B         C          D      E       F
 	+wwwwwwwwwwwwwwwwwwwwww+uuuuuuuuu+zzzzzzzzzz+hhhhhh+rrrrrrr+
 	                      EOF
                          (in memory)
                           (on disk)

Since we don't update i_size in iomap_zero_iter(), the zeroed C to D
in cache would never write back to disk (iomap_writepage_handle_eof()
would skip them since it's entirely ouside of i_size) and the
'i_size & i_disksize' is still at B, after reflink, the i_size would
be update to F, so the delayed C to D cannot be freed by
xfs_free_eofblocks().

 	A                      B         C          D      E       F
 	+wwwwwwwwwwwwwwwwwwwwww+uuuuuuuuu+dddddddddd+hhhhhh+rrrrrrr+
 	                                                          EOF
                                                              (in memory)
                                                               (on disk)

Although the result is not exactly the same as your understanding,
the situation you describe still triggers the problem.

> However, if this did actually write zeroes to disk, this would end
> up with:
> 
> 	A          C           B     E       F      D
> 	+wwwwwwwwww+DDDDDDDDDDD+zzzzz+rrrrrrr+dddddd+
> 	                      EOF   EOF
>                       (in memory)   (on disk)
> 
> Which is wrong - the file extension and zeros should not get exposed
> to the user until the entire reflink completes. This would expose
> zeros at the EOF and a file size that the user never asked for after
> a crash. Experience tells me that they would report this as
> "filesystem corrupting data on crash".
> 
> If we move where i_size gets updated by iomap_zero_iter(), we get:
> 
> 	A          C           B     E       F      D
> 	+wwwwwwwwww+DDDDDDDDDDD+zzzzz+rrrrrrr+dddddd+
> 	                            EOF
>                                 (in memory)
> 		                 (on disk)
> 
> Which is also wrong, because now the user can see the size change
> and read zeros in the middle of the clone operation, which is also
> wrong.
> 
> IOWs, we do not want to move the in-memory or on-disk EOF as a
> result of zeroing delalloc extents beyond EOF as it opens up
> transient, non-atomic on-disk states in the event of a crash.
> 
> So, catch-22: we need to move the in-memory EOF to write back zeroes
> beyond EOF, but that would move the on-disk EOF to E before the
> clone operation starts. i.e. it makes clone non-atomic.

Make sense. IIUC, I also notice that xfs_file_write_checks() zero
out EOF blocks if the later write offset is beyond the size of the
file. Think about if we replace the reflink operation to a buffer
write E to F, although it doesn't call xfs_flush_unmap_range()
directly, but if it could be raced by another background write
back, and trigger the same problem (I've not try to reproduce it,
so please correct me if I understand wrong).

> 
> What should acutally result from the iomap_zero_range() call from
> xfs_reflink_remap_prep() is a state like this:
> 
> 	A          C           B     E       F      D
> 	+wwwwwwwwww+DDDDDDDDDDD+uuuuu+rrrrrrr+dddddd+
> 	          EOF         EOF
>                (on disk)  (in memory)
> 
> where 'u' are unwritten extent blocks.
> 

Yeah, this is a good solution.

In xfs_file_write_checks(), I don't fully understand why we need
the xfs_zero_range(). Theoretically, iomap have already handled
partial block zeroing for both buffered IO and DIO, so I guess
the only reason we still need it is to handle pre-allocated blocks
(no?). If so，would it be better to call xfs_free_eofblocks() to
release all the preallocated extents in range? If not, maybe we
could only zero out mapped partial blocks and also release
preallocated extents?

In xfs_reflink_remap_prep(), I read the commit 410fdc72b05a ("xfs:
zero posteof blocks when cloning above eof"), xfs used to release
preallocations, the change log said it didn't work because of the
PREALLOC flag, but the 'force' parameter is 'true' when calling
xfs_can_free_eofblocks(), so I don't get the problem met. Could we
fall back to use xfs_free_eofblocks() and make a state like this?

 	A          C           B     E       F      D
 	+wwwwwwwwww+DDDDDDDDDDD+hhhhh+rrrrrrr+dddddd+
 	          EOF         EOF
                (on disk)  (in memory)


Thanks,
Yi.

> i.e. instead of writing zeroes through the page cache for
> IOMAP_DELALLOC ranges beyond EOF, we should be converting those
> ranges to unwritten and invalidating any cached data over that range
> beyond EOF.
> 
> IOWs, it looks to me like the problem is that
> xfs_buffered_write_iomap_begin() is doing the wrong thing for
> IOMAP_ZERO operations for post-EOF regions spanned by speculative
> delalloc. It should be converting the region to unwritten so it has
> zeroes on disk, not relying on the page cache to be able to do
> writeback beyond the current EOF....
> 
>> 4. Since we don't update i_size in iomap_zero_iter()，the writeback
>>    doesn't write anything back, also doesn't convert the delayed extent.
>>    After copy range, the file size will update to F.
> 
> Yup, this is all, individually, correct behaviour. But when put
> together, the wrong thing happens. I suspect xfs_zero_range() needs
> to provide a custom set of iomap_begin/end callbacks rather than
> overloading the normal buffered write mechanisms.
> 
> -Dave.
> 


