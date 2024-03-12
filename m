Return-Path: <linux-fsdevel+bounces-14203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAA5879434
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 13:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F991F246BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 12:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F57D56750;
	Tue, 12 Mar 2024 12:32:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035A9BE4E;
	Tue, 12 Mar 2024 12:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710246733; cv=none; b=XBICoIVGRklg5JpsQQfxm3nuI9LWgltO7FrCFw8rlKkcuvbCf01CiRtdwabv5xW3nkDbuuiMIytRFjJCZRdo4ys6sg58XYaOfeAUniU6F34Fn+cjdxSR51XMGRVs0IPAGINVhKW5L05uQxg71/j35QJ3C5A+eutekpBCNgzXrMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710246733; c=relaxed/simple;
	bh=/g7B/ioTRVrLBJ0KUmDdgTSPZPbItDsNOgmeSr4A6T4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EKDqm4M36S4SR3mC5KbQhjI8tVbCX5rDr1qncIs8Uw+nwNxYXV27S1+J0sx6F2mNuwRkyb9Eu06W6fNTA53J00X3q+CbZKSMK5ue/EBQtPys7GUI9dPDgBo/Pb6GSVQC9XiIdhUe6UU5qMRcRs7j+EgKUSWZpuwVYTyjNic8Yho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TvCgv00xrz4f3jcx;
	Tue, 12 Mar 2024 20:31:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A63171A0199;
	Tue, 12 Mar 2024 20:32:00 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBE+S_BlweXlGg--.27994S3;
	Tue, 12 Mar 2024 20:32:00 +0800 (CST)
Subject: Re: [PATCH 2/4] xfs: convert delayed extents to unwritten when
 zeroing post eof blocks
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
 david@fromorbit.com, tytso@mit.edu, jack@suse.cz, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240311122255.2637311-1-yi.zhang@huaweicloud.com>
 <20240311122255.2637311-3-yi.zhang@huaweicloud.com>
 <20240311153737.GT1927156@frogsfrogsfrogs>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <aab454d0-d8f3-61c8-0d14-a5ae4c35746e@huaweicloud.com>
Date: Tue, 12 Mar 2024 20:31:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240311153737.GT1927156@frogsfrogsfrogs>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCXaBE+S_BlweXlGg--.27994S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4fZw4ruFW3trWrZFykGrg_yoWrur4UpF
	Z3K3W5GF43tw12vwn7AFn8Ww1Fvas7Cr48Ar13Wwn5Z3sIyr1IgFykC3WY9w18C39Iy3W2
	vF4UWFyI9w4YvFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 2024/3/11 23:37, Darrick J. Wong wrote:
> On Mon, Mar 11, 2024 at 08:22:53PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Current clone operation could be non-atomic if the destination of a file
>> is beyond EOF, user could get a file with corrupted (zeroed) data on
>> crash.
>>
>> The problem is about to pre-alloctions. If you write some data into a
>> file [A, B) (the position letters are increased one by one), and xfs
>> could pre-allocate some blocks, then we get a delayed extent [A, D).
>> Then the writeback path allocate blocks and convert this delayed extent
>> [A, C) since lack of enough contiguous physical blocks, so the extent
>> [C, D) is still delayed. After that, both the in-memory and the on-disk
>> file size are B. If we clone file range into [E, F) from another file,
>> xfs_reflink_zero_posteof() would call iomap_zero_range() to zero out the
>> range [B, E) beyond EOF and flush range. Since [C, D) is still a delayed
>> extent, it will be zeroed and the file's in-memory && on-disk size will
>> be updated to D after flushing and before doing the clone operation.
>> This is wrong, because user can user can see the size change and read
>> zeros in the middle of the clone operation.
>>
>> We need to keep the in-memory and on-disk size before the clone
>> operation starts, so instead of writing zeroes through the page cache
>> for delayed ranges beyond EOF, we convert these ranges to unwritten and
>> invalidating any cached data over that range beyond EOF.
>>
>> Suggested-by: Dave Chinner <david@fromorbit.com>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  fs/xfs/xfs_iomap.c | 29 +++++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>
>> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
>> index ccf83e72d8ca..2b2aace25355 100644
>> --- a/fs/xfs/xfs_iomap.c
>> +++ b/fs/xfs/xfs_iomap.c
>> @@ -957,6 +957,7 @@ xfs_buffered_write_iomap_begin(
>>  	struct xfs_mount	*mp = ip->i_mount;
>>  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
>>  	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
>> +	xfs_fileoff_t		eof_fsb = XFS_B_TO_FSBT(mp, XFS_ISIZE(ip));
>>  	struct xfs_bmbt_irec	imap, cmap;
>>  	struct xfs_iext_cursor	icur, ccur;
>>  	xfs_fsblock_t		prealloc_blocks = 0;
>> @@ -1035,6 +1036,22 @@ xfs_buffered_write_iomap_begin(
>>  	}
>>  
>>  	if (imap.br_startoff <= offset_fsb) {
>> +		/*
>> +		 * For zeroing out delayed allocation extent, we trim it if
>> +		 * it's partial beyonds EOF block, or convert it to unwritten
>> +		 * extent if it's all beyonds EOF block.
>> +		 */
>> +		if ((flags & IOMAP_ZERO) &&
>> +		    isnullstartblock(imap.br_startblock)) {
>> +			if (offset_fsb > eof_fsb)
>> +				goto convert_delay;
>> +			if (end_fsb > eof_fsb) {
>> +				end_fsb = eof_fsb + 1;
>> +				xfs_trim_extent(&imap, offset_fsb,
>> +						end_fsb - offset_fsb);
>> +			}
>> +		}
>> +
>>  		/*
>>  		 * For reflink files we may need a delalloc reservation when
>>  		 * overwriting shared extents.   This includes zeroing of
>> @@ -1158,6 +1175,18 @@ xfs_buffered_write_iomap_begin(
>>  	xfs_iunlock(ip, lockmode);
>>  	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0, seq);
>>  
>> +convert_delay:
>> +	end_fsb = min(end_fsb, imap.br_startoff + imap.br_blockcount);
>> +	xfs_iunlock(ip, lockmode);
>> +	truncate_pagecache_range(inode, offset, XFS_FSB_TO_B(mp, end_fsb));
>> +	error = xfs_iomap_write_direct(ip, offset_fsb, end_fsb - offset_fsb,
>> +				       flags, &imap, &seq);
> 
> I expected this to be a direct call to xfs_bmapi_convert_delalloc.
> What was the reason not for using that?
> 

It's because xfs_bmapi_convert_delalloc() isn't guarantee to convert
enough blocks once a time, it may convert insufficient blocks since lack
of enough contiguous free physical blocks. If we are going to use it, I
suppose we need to introduce a new helper something like
xfs_convert_blocks(), add a loop to do the conversion.

xfs_iomap_write_direct() has done all the work of converting, but the
name of this function is non-obviousness than xfs_bmapi_convert_delalloc(),
I can change to use it if you think xfs_bmapi_convert_delalloc() is
better. :)

Thanks,
Yi.

> --D
> 
>> +	if (error)
>> +		return error;
>> +
>> +	trace_xfs_iomap_alloc(ip, offset, count, XFS_DATA_FORK, &imap);
>> +	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_NEW, seq);
>> +
>>  found_cow:
>>  	seq = xfs_iomap_inode_sequence(ip, 0);
>>  	if (imap.br_startoff <= offset_fsb) {
>> -- 
>> 2.39.2
>>
>>


