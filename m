Return-Path: <linux-fsdevel+bounces-17859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DDE8B3051
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 08:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8D71C231A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 06:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F64E13A884;
	Fri, 26 Apr 2024 06:24:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482382F2F;
	Fri, 26 Apr 2024 06:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714112673; cv=none; b=h8jMkIBVpaWqbDM7v60xJdZDrwnly9QbweXxZH0rc/g5eQxdwPDeceIf51Yst8+DWANllZaCbn/SwiYKyzYnms6TmAkvo1arrnCsni4hmvpbg/ILSWq/b8OItkjfpGQ9PageBCFdjlZmIKFu7nXQKCe+G8lp88Wjz3uARgvIyys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714112673; c=relaxed/simple;
	bh=XQnuMcIYKRdbws5Pv+8e5wtQFLp076vw3Hhu8svUKyo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VeMVRTm6e0zoY+jDBU/ZoI02BKzNPcLQ887cmGYKLN9nZj6MDsUAgE+5ksevZJJxTU6hglo3QXH1/PI6jjzLW6w0uN129Qvm2eHkNq3sBOTo4XW1EPGoOxR57cPbbzMw7xA47ZcaqzY5MWswkWHuapQx5tyjkDysjyTO1FmPmDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VQjNq6HpFz4f3mHy;
	Fri, 26 Apr 2024 14:24:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 29C441A016E;
	Fri, 26 Apr 2024 14:24:21 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBGTSCtm2W_3Kw--.24233S3;
	Fri, 26 Apr 2024 14:24:20 +0800 (CST)
Subject: Re: [PATCH v5 4/9] xfs: convert delayed extents to unwritten when
 zeroing post eof blocks
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
 david@fromorbit.com, chandanbabu@kernel.org, tytso@mit.edu, jack@suse.cz,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240425131335.878454-1-yi.zhang@huaweicloud.com>
 <20240425131335.878454-5-yi.zhang@huaweicloud.com>
 <20240425182904.GA360919@frogsfrogsfrogs>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <3be86418-e629-c7e6-fd73-f59f97a73a89@huaweicloud.com>
Date: Fri, 26 Apr 2024 14:24:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240425182904.GA360919@frogsfrogsfrogs>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCXaBGTSCtm2W_3Kw--.24233S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWw47Kw4fXr13JFy8WFWDCFg_yoW7Gr43pF
	Z3K3W5KF4Dtw1avw1Iv3W5Kw1F93Z3Cr47Ary3Xrn3Za4Yyr1fKF17K3Wjgry8CrZ3A3Wj
	vFWjg3s293s0vFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/4/26 2:29, Darrick J. Wong wrote:
> On Thu, Apr 25, 2024 at 09:13:30PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Current clone operation could be non-atomic if the destination of a file
>> is beyond EOF, user could get a file with corrupted (zeroed) data on
>> crash.
>>
>> The problem is about preallocations. If you write some data into a file:
>>
>> 	[A...B)
>>
>> and XFS decides to preallocate some post-eof blocks, then it can create
>> a delayed allocation reservation:
>>
>> 	[A.........D)
>>
>> The writeback path tries to convert delayed extents to real ones by
>> allocating blocks. If there aren't enough contiguous free space, we can
>> end up with two extents, the first real and the second still delalloc:
>>
>> 	[A....C)[C.D)
>>
>> After that, both the in-memory and the on-disk file sizes are still B.
>> If we clone into the range [E...F) from another file:
>>
>> 	[A....C)[C.D)      [E...F)
>>
>> then xfs_reflink_zero_posteof() calls iomap_zero_range() to zero out the
>> range [B, E) beyond EOF and flush it. Since [C, D) is still a delalloc
>> extent, its pagecache will be zeroed and both the in-memory and on-disk
>> size will be updated to D after flushing but before cloning. This is
>> wrong, because the user can see the size change and read the zeroes
>> while the clone operation is ongoing.
>>
>> We need to keep the in-memory and on-disk size before the clone
>> operation starts, so instead of writing zeroes through the page cache
>> for delayed ranges beyond EOF, we convert these ranges to unwritten and
>> invalidate any cached data over that range beyond EOF.
>>
>> Suggested-by: Dave Chinner <david@fromorbit.com>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>> Changes since v4:
>>
>> Move the delalloc converting hunk before searching the COW fork. Because
>> if the file has been reflinked and copied on write,
>> xfs_bmap_extsize_align() aligned the range of COW delalloc extent, after
>> the writeback, there might be some unwritten extents left over in the
>> COW fork that overlaps the delalloc extent we found in data fork.
>>
>>   data fork  ...wwww|dddddddddd...
>>   cow fork          |uuuuuuuuuu...
>>                     ^
>>                   i_size
>>
>> In my v4, we search the COW fork before checking the delalloc extent,
>> goto found_cow tag and return unconverted delalloc srcmap in the above
>> case, so the delayed extent in the data fork will have no chance to
>> convert to unwritten, it will lead to delalloc extent residue and break
>> generic/522 after merging patch 6.
> 
> Hmmm.  I suppose that works, but it feels a little funny to convert the
> delalloc mapping in the data fork to unwritten /while/ there's unwritten
> extents in the cow fork too.  Would it make more sense to remap the cow
> fork extents here?
> 

Yeah, it looks more reasonable. But from the original scene, the
xfs_bmap_extsize_align() aligned the new extent that added to the cow fork
could overlaps the unreflinked range, IIUC, I guess that spare range is
useless exactly, is there any situation that would use it?

> OTOH unwritten extents in the cow fork get changed to written ones by
> all the cow remapping functions.  Soooo maybe we don't want to go
> digging /that/ deep into the system.
> 

Yeah, I think it's okay now unless there's some strong claims.

> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> --D
> 
>>
>>  fs/xfs/xfs_iomap.c | 29 +++++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>
>> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
>> index 236ee78aa75b..2857ef1b0272 100644
>> --- a/fs/xfs/xfs_iomap.c
>> +++ b/fs/xfs/xfs_iomap.c
>> @@ -1022,6 +1022,24 @@ xfs_buffered_write_iomap_begin(
>>  		goto out_unlock;
>>  	}
>>  
>> +	/*
>> +	 * For zeroing, trim a delalloc extent that extends beyond the EOF
>> +	 * block.  If it starts beyond the EOF block, convert it to an
>> +	 * unwritten extent.
>> +	 */
>> +	if ((flags & IOMAP_ZERO) && imap.br_startoff <= offset_fsb &&
>> +	    isnullstartblock(imap.br_startblock)) {
>> +		xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
>> +
>> +		if (offset_fsb >= eof_fsb)
>> +			goto convert_delay;
>> +		if (end_fsb > eof_fsb) {
>> +			end_fsb = eof_fsb;
>> +			xfs_trim_extent(&imap, offset_fsb,
>> +					end_fsb - offset_fsb);
>> +		}
>> +	}
>> +
>>  	/*
>>  	 * Search the COW fork extent list even if we did not find a data fork
>>  	 * extent.  This serves two purposes: first this implements the
>> @@ -1167,6 +1185,17 @@ xfs_buffered_write_iomap_begin(
>>  	xfs_iunlock(ip, lockmode);
>>  	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0, seq);
>>  
>> +convert_delay:
>> +	xfs_iunlock(ip, lockmode);
>> +	truncate_pagecache(inode, offset);
>> +	error = xfs_bmapi_convert_delalloc(ip, XFS_DATA_FORK, offset,
>> +					   iomap, NULL);
>> +	if (error)
>> +		return error;
>> +
>> +	trace_xfs_iomap_alloc(ip, offset, count, XFS_DATA_FORK, &imap);
>> +	return 0;
>> +
>>  found_cow:
>>  	seq = xfs_iomap_inode_sequence(ip, 0);
>>  	if (imap.br_startoff <= offset_fsb) {
>> -- 
>> 2.39.2
>>
>>


