Return-Path: <linux-fsdevel+bounces-18826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 952F68BCCBF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 13:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983781C21DBF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 11:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149CF143868;
	Mon,  6 May 2024 11:22:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B477514262C;
	Mon,  6 May 2024 11:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714994520; cv=none; b=An8FmfSTMzt1F5krzRo52X/o2pLuE6a8hg1fTnqQQAT5kIB+cfevDKmVPGJAHO2VW13baFPRxsL+lkmo+SlANP6G1zDoTuJShAgsH4TGpqfSeMhd05fZ5d4kBhjOILhz0JcganL6W0hymy5Vh2BHyJjnX6ijqm+v4YqtXgvWfjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714994520; c=relaxed/simple;
	bh=DzA1qNG1rre/xnKZN/arluttKfjtjS8U924sZWRNitU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RYdG0+qsDM2PnA2uY6ySSvg2hSOgyhKKxN6QhEnWSkZUhqqdSk2Ez0zB68B817FPwGPGJ57iJQvum3multbFzarwLbKXJ5m82NVCRDNTtDMudskMFguJWOJi0FMBkozNQbEOO10jao8VPUKWFtE4PTUTeI5cRIFICPFcI8CbgW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VXzWY1kNdz4f3jR7;
	Mon,  6 May 2024 19:21:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 69BA61A017D;
	Mon,  6 May 2024 19:21:53 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgDnCw9PvThmHTPKMA--.36325S3;
	Mon, 06 May 2024 19:21:53 +0800 (CST)
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
 <ZjH5Ia+dWGss5Duv@dread.disaster.area>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <4adbf8aa-e417-1997-c83d-90e7623f2916@huaweicloud.com>
Date: Mon, 6 May 2024 19:21:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZjH5Ia+dWGss5Duv@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDnCw9PvThmHTPKMA--.36325S3
X-Coremail-Antispam: 1UD129KBjvJXoWxurW5Gw1UXw48GrW3tF1kKrg_yoW5Kry8pF
	ZxKF45GF4aqrya9F4fXr48XF1Ska18Jr4UJrWag345ur90yr10gF40gF1Yv3W5Ar4xAF1x
	ZF4YkF18Gw42yrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 2024/5/1 16:11, Dave Chinner wrote:
> On Wed, Apr 10, 2024 at 10:29:38PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Implement buffered write iomap path, use ext4_da_map_blocks() to map
>> delalloc extents and add ext4_iomap_get_blocks() to allocate blocks if
>> delalloc is disabled or free space is about to run out.
>>
>> Note that we always allocate unwritten extents for new blocks in the
>> iomap write path, this means that the allocation type is no longer
>> controlled by the dioread_nolock mount option. After that, we could
>> postpone the i_disksize updating to the writeback path, and drop journal
>> handle in the buffered dealloc write path completely.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  fs/ext4/ext4.h  |   3 +
>>  fs/ext4/file.c  |  19 +++++-
>>  fs/ext4/inode.c | 168 ++++++++++++++++++++++++++++++++++++++++++++++--
>>  3 files changed, 183 insertions(+), 7 deletions(-)
>>
[...]
>> +#define IOMAP_F_EXT4_DELALLOC		IOMAP_F_PRIVATE
>> +
>> +static int __ext4_iomap_buffered_io_begin(struct inode *inode, loff_t offset,
>>  				loff_t length, unsigned int iomap_flags,
>> -				struct iomap *iomap, struct iomap *srcmap)
>> +				struct iomap *iomap, struct iomap *srcmap,
>> +				bool delalloc)
>>  {
>> -	int ret;
>> +	int ret, retries = 0;
>>  	struct ext4_map_blocks map;
>>  	u8 blkbits = inode->i_blkbits;
>>  
>> @@ -3537,20 +3580,133 @@ static int ext4_iomap_buffered_io_begin(struct inode *inode, loff_t offset,
>>  		return -EINVAL;
>>  	if (WARN_ON_ONCE(ext4_has_inline_data(inode)))
>>  		return -ERANGE;
>> -
>> +retry:
>>  	/* Calculate the first and last logical blocks respectively. */
>>  	map.m_lblk = offset >> blkbits;
>>  	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
>>  			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
>> +	if (iomap_flags & IOMAP_WRITE) {
>> +		if (delalloc)
>> +			ret = ext4_da_map_blocks(inode, &map);
>> +		else
>> +			ret = ext4_iomap_get_blocks(inode, &map);
>>  
>> -	ret = ext4_map_blocks(NULL, inode, &map, 0);
>> +		if (ret == -ENOSPC &&
>> +		    ext4_should_retry_alloc(inode->i_sb, &retries))
>> +			goto retry;
>> +	} else {
>> +		ret = ext4_map_blocks(NULL, inode, &map, 0);
>> +	}
>>  	if (ret < 0)
>>  		return ret;
>>  
>>  	ext4_set_iomap(inode, iomap, &map, offset, length, iomap_flags);
>> +	if (delalloc)
>> +		iomap->flags |= IOMAP_F_EXT4_DELALLOC;
>> +
>> +	return 0;
>> +}
> 
> Why are you implementing both read and write mapping paths in
> the one function? The whole point of having separate ops vectors for
> read and write is that it allows a clean separation of the read and
> write mapping operations. i.e. there is no need to use "if (write)
> else {do read}" code constructs at all.
> 
> You can even have a different delalloc mapping function so you don't
> need "if (delalloc) else {do nonda}" branches everiywhere...
> 

Because current ->iomap_begin() for ext4 buffered IO path
(i.e. __ext4_iomap_buffered_io_begin()) is simple, almost only the map
blocks handlers are different for read, da write and no da write paths,
the rest of the function parameter check and inode status check are
the same, and I noticed that the ->iomap_begin() for direct IO path
(i.e. ext4_iomap_begin()) also implemented in one function. So I'd
like to save some code now, and it looks like implement them in one
function doesn't make this function too complicated, I guess we could
split them if things change in the future.

But think about it again, split them now could make things more clear,
it's also fine to me.

Thanks,
Yi.


