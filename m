Return-Path: <linux-fsdevel+bounces-18872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 477488BDA89
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 07:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E7A1F22BFB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 05:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214E66BFA2;
	Tue,  7 May 2024 05:11:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2976FD5;
	Tue,  7 May 2024 05:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715058670; cv=none; b=Sjd3P3LNRQKl9BXvLyrIFSfswFMZ21rdRcWCQeZamz43TiT4GHVBWVxRGzz2MdCiDBjZzT/klj+hZq37FHd68eZ7Rrjd8kGW5TZuysP8gnScwHO6g1XbOR4dOLNn49jZtm35apQhndvjulTybpAFR/vVFpH8TptK/lTYG8dc8VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715058670; c=relaxed/simple;
	bh=UmIeR8qcIuhAuHOl+IkBi5wLE0AxUhxJCHntjGWPRPs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UHwnaIpMMTMBVHWkMH2NK2p+o3vbcz1EXsIy1WymlIgtczzKF+SLLhxn9B6R7TiHRY4FkzSIntLETi/tLd/pgWK0KzoG6dzf12Sxpzc2edF206D/dVymNAIt9uGG5PXZHzbd7MZ8ZJTGkYtpgLZ6QtPRLiBHHNmEM0yGHyx9t7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VYRFG01sJz4f3lXf;
	Tue,  7 May 2024 13:10:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 4523C1A0179;
	Tue,  7 May 2024 13:11:03 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgCnyw7dtzlmM08RMQ--.26968S3;
	Tue, 07 May 2024 13:10:55 +0800 (CST)
Subject: Re: [RFC PATCH v4 24/34] ext4: implement buffered write iomap path
To: Dave Chinner <david@fromorbit.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
 hch@infradead.org, djwong@kernel.org, willy@infradead.org,
 zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com, wangkefeng.wang@huawei.com
References: <20240410142948.2817554-1-yi.zhang@huaweicloud.com>
 <20240410142948.2817554-25-yi.zhang@huaweicloud.com>
 <ZjH5Ia+dWGss5Duv@dread.disaster.area> <ZjH+QFVXLlcDkSdh@dread.disaster.area>
 <96bbdb25-b420-67b1-d4c4-b838a5c70f9f@huaweicloud.com>
 <ZjllkHuyOedA/Tzg@dread.disaster.area>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <998cae29-61c3-bb10-b05b-853edfd176b0@huaweicloud.com>
Date: Tue, 7 May 2024 13:10:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZjllkHuyOedA/Tzg@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCnyw7dtzlmM08RMQ--.26968S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AFyDKFyDZrWrJw1kArW8JFb_yoW3JrWxpr
	Z8KFyUKrn8Xr1xWr1qva18WF1Fkw1xGry7Wr45WryUZF90vr1fKa4DKF1Y9FWxArZ2kF1j
	qF4UKFyxXa4jya7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 2024/5/7 7:19, Dave Chinner wrote:
> On Mon, May 06, 2024 at 07:44:44PM +0800, Zhang Yi wrote:
>> On 2024/5/1 16:33, Dave Chinner wrote:
>>> On Wed, May 01, 2024 at 06:11:13PM +1000, Dave Chinner wrote:
>>>> On Wed, Apr 10, 2024 at 10:29:38PM +0800, Zhang Yi wrote:
>>>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>>>
>>>>> Implement buffered write iomap path, use ext4_da_map_blocks() to map
>>>>> delalloc extents and add ext4_iomap_get_blocks() to allocate blocks if
>>>>> delalloc is disabled or free space is about to run out.
>>>>>
>>>>> Note that we always allocate unwritten extents for new blocks in the
>>>>> iomap write path, this means that the allocation type is no longer
>>>>> controlled by the dioread_nolock mount option. After that, we could
>>>>> postpone the i_disksize updating to the writeback path, and drop journal
>>>>> handle in the buffered dealloc write path completely.
>>> .....
>>>>> +/*
>>>>> + * Drop the staled delayed allocation range from the write failure,
>>>>> + * including both start and end blocks. If not, we could leave a range
>>>>> + * of delayed extents covered by a clean folio, it could lead to
>>>>> + * inaccurate space reservation.
>>>>> + */
>>>>> +static int ext4_iomap_punch_delalloc(struct inode *inode, loff_t offset,
>>>>> +				     loff_t length)
>>>>> +{
>>>>> +	ext4_es_remove_extent(inode, offset >> inode->i_blkbits,
>>>>> +			DIV_ROUND_UP_ULL(length, EXT4_BLOCK_SIZE(inode->i_sb)));
>>>>>  	return 0;
>>>>>  }
>>>>>  
>>>>> +static int ext4_iomap_buffered_write_end(struct inode *inode, loff_t offset,
>>>>> +					 loff_t length, ssize_t written,
>>>>> +					 unsigned int flags,
>>>>> +					 struct iomap *iomap)
>>>>> +{
>>>>> +	handle_t *handle;
>>>>> +	loff_t end;
>>>>> +	int ret = 0, ret2;
>>>>> +
>>>>> +	/* delalloc */
>>>>> +	if (iomap->flags & IOMAP_F_EXT4_DELALLOC) {
>>>>> +		ret = iomap_file_buffered_write_punch_delalloc(inode, iomap,
>>>>> +			offset, length, written, ext4_iomap_punch_delalloc);
>>>>> +		if (ret)
>>>>> +			ext4_warning(inode->i_sb,
>>>>> +			     "Failed to clean up delalloc for inode %lu, %d",
>>>>> +			     inode->i_ino, ret);
>>>>> +		return ret;
>>>>> +	}
>>>>
>>>> Why are you creating a delalloc extent for the write operation and
>>>> then immediately deleting it from the extent tree once the write
>>>> operation is done?
>>>
>>> Ignore this, I mixed up the ext4_iomap_punch_delalloc() code
>>> directly above with iomap_file_buffered_write_punch_delalloc().
>>>
>>> In hindsight, iomap_file_buffered_write_punch_delalloc() is poorly
>>> named, as it is handling a short write situation which requires
>>> newly allocated delalloc blocks to be punched.
>>> iomap_file_buffered_write_finish() would probably be a better name
>>> for it....
>>>
>>>> Also, why do you need IOMAP_F_EXT4_DELALLOC? Isn't a delalloc iomap
>>>> set up with iomap->type = IOMAP_DELALLOC? Why can't that be used?
>>>
>>> But this still stands - the first thing
>>> iomap_file_buffered_write_punch_delalloc() is:
>>>
>>> 	if (iomap->type != IOMAP_DELALLOC)
>>>                 return 0;
>>>
>>
>> Thanks for the suggestion, the delalloc and non-delalloc write paths
>> share the same ->iomap_end() now (i.e. ext4_iomap_buffered_write_end()),
>> I use the IOMAP_F_EXT4_DELALLOC to identify the write path.
> 
> Again, you don't need that. iomap tracks newly allocated
> IOMAP_DELALLOC extents via the IOMAP_F_NEW flag that should be
> getting set in the ->iomap_begin() call when it creates a new
> delalloc extent.
> 
> Please look at the second check in
> iomap_file_buffered_write_punch_delalloc():
> 
> 	if (iomap->type != IOMAP_DELALLOC)
>                 return 0;
> 
>         /* If we didn't reserve the blocks, we're not allowed to punch them. */
>         if (!(iomap->flags & IOMAP_F_NEW))
>                 return 0;
> 
>> For
>> non-delalloc path, If we have allocated more blocks and copied less, we
>> should truncate extra blocks that newly allocated by ->iomap_begin().
> 
> Why? If they were allocated as unwritten, then you can just leave
> them there as unwritten extents, same as XFS. Keep in mind that if
> we get a short write, it is extremely likely the application is
> going to rewrite the remaining data immediately, so if we allocated
> blocks they are likely to still be needed, anyway....
> 

Make sense, we don't need to free the extra blocks beyond EOF since they
are unwritten, we can drop this handle for non-delalloc path on ext4 now.

>> If we use IOMAP_DELALLOC, we can't tell if the blocks are
>> pre-existing or newly allocated, we can't truncate the
>> pre-existing blocks, so I have to introduce IOMAP_F_EXT4_DELALLOC.
>> But if we split the delalloc and non-delalloc handler, we could
>> drop IOMAP_F_EXT4_DELALLOC.
> 
> As per above: IOMAP_F_NEW tells us -exactly- this.
> 
> IOMAP_F_NEW should be set on any newly allocated block - delalloc or
> real - because that's the flag that tells the iomap infrastructure
> whether zero-around is needed for partial block writes. If ext4 is
> not setting this flag on delalloc regions allocated by
> ->iomap_begin(), then that's a serious bug.
> 
>> I also checked xfs, IIUC, xfs doesn't free the extra blocks beyond EOF
>> in xfs_buffered_write_iomap_end() for non-delalloc case since they will
>> be freed by xfs_free_eofblocks in some other inactive paths, like
>> xfs_release()/xfs_inactive()/..., is that right?
> 
> XFS doesn't care about real blocks beyond EOF existing -
> xfs_free_eofblocks() is an optimistic operation that does not
> guarantee that it will remove blocks beyond EOF. Similarly, we don't
> care about real blocks within EOF because we alway allocate data
> extents as unwritten, so we don't have any stale data exposure
> issues to worry about on short writes leaving allocated blocks
> behind.
> 
> OTOH, delalloc extents without dirty page cache pages over them
> cannot be allowed to exist. Without dirty pages, there is no trigger
> to convert those to real extents (i.e. nothing to write back). Hence
> the only sane thing that can be done with them on a write error or
> short write is remove them in the context where they were created.
> 
> This is the only reason that the
> iomap_file_buffered_write_punch_delalloc() exists - it abstracts
> this nasty corner case away from filesystems that support delalloc
> so they don't have to worry about getting this right. That's whole
> point of having delalloc aware infrastructure - individual
> filesysetms don't need to handle all these weird corner cases
> themselves because the infrastructure takes care of them...
> 

Yeah, thanks for the explanation. The iomap_file_buffered_write_punch_delalloc()
is very useful, it find pages that have dirty data still pending in the page
cache, punch out all the delalloc blocks beside those blocks. I realized that
it is used to fix a race condition between either writeback or mmap page
faults that xfs encountered [1].

We will meet the same problem for ext3 and ext2 which are not extent based.
Their new allocated blocks were written, we need to free them if we get a short
write, but we can't simply do it through ext2_write_failed() and
ext4_truncate_failed_write(), we still need to use
iomap_file_buffered_write_punch_delalloc().

[1] https://lore.kernel.org/all/20221123055812.747923-6-david@fromorbit.com/

Thanks,
Yi.


