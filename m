Return-Path: <linux-fsdevel+bounces-21695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC1C908446
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 09:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EC441F228C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 07:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916F214883F;
	Fri, 14 Jun 2024 07:18:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7104D19D88A;
	Fri, 14 Jun 2024 07:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718349499; cv=none; b=DmcU0rf63dNte2NM4V3frLPv0I62OYmGecJPyYP8CKPANnIaJTeesl5dm6xNh7Svty4Lw0k1Pp6WODw3csYZvUKI57b7og6qst3iTx+iPeR10/2058JL9rH+4SF1bw14EV65q2u+xL/R5fiX7Y3GJKafJdd21InLy+i6z3MJX5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718349499; c=relaxed/simple;
	bh=J/eoe0h+3js10+DWPsnOUtalfUW5casYxooODFA3ark=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Iv/tXfeXZKJFD9kF8Am0JgNRssPuhmj4QiArohedJkJIcrogVxBDH2kUjzwJCcOhLXj9p+a+LGIF7xS6C1J0LNQ3CVD/jGLWQHJXmyPh3vLhU4Y1LKQMfNui+VjX9L+AZ1wWQCtCd69jL2+7h4fTrDDxuGPuuZJxuf0+z3V76Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W0rGH6cy2z4f3kv6;
	Fri, 14 Jun 2024 15:17:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 766D51A0568;
	Fri, 14 Jun 2024 15:18:11 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgDnCw+v7mtmcrhSPw--.45646S3;
	Fri, 14 Jun 2024 15:18:09 +0800 (CST)
Subject: Re: [PATCH -next v5 7/8] xfs: speed up truncating down a big realtime
 inode
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, djwong@kernel.org, brauner@kernel.org,
 david@fromorbit.com, chandanbabu@kernel.org, jack@suse.cz,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
 John Garry <john.g.garry@oracle.com>
References: <20240613090033.2246907-1-yi.zhang@huaweicloud.com>
 <20240613090033.2246907-8-yi.zhang@huaweicloud.com>
 <ZmveZolfY0Q0--1k@infradead.org>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <399680eb-cd60-4c27-ef2b-2704e470d228@huaweicloud.com>
Date: Fri, 14 Jun 2024 15:18:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZmveZolfY0Q0--1k@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDnCw+v7mtmcrhSPw--.45646S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGw1rtF4fGr1fKr1xCryDWrg_yoWrCFy7pF
	Z7Ga45CrWkt34jkas7ZF1Yqw1Y9wnaya17AFy5XryxAas8Jr1fKrn3tryrJ3yjkr48WFWv
	qFs5K347Z3WaqFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 2024/6/14 14:08, Christoph Hellwig wrote:
> On Thu, Jun 13, 2024 at 05:00:32PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> If we truncate down a big realtime inode, zero out the entire aligned
>> EOF extent could gets slow down as the rtextsize increases. Fortunately,
>> __xfs_bunmapi() would align the unmapped range to rtextsize, split and
>> convert the blocks beyond EOF to unwritten. So speed up this by
>> adjusting the unitsize to the filesystem blocksize when truncating down
>> a large realtime inode, let __xfs_bunmapi() convert the tail blocks to
>> unwritten, this could improve the performance significantly.
>>
>>  # mkfs.xfs -f -rrtdev=/dev/pmem1s -f -m reflink=0,rmapbt=0, \
>>             -d rtinherit=1 -r extsize=$rtextsize /dev/pmem2s
>>  # mount -ortdev=/dev/pmem1s /dev/pmem2s /mnt/scratch
>>  # for i in {1..1000}; \
>>    do dd if=/dev/zero of=/mnt/scratch/$i bs=$rtextsize count=1024; done
>>  # sync
>>  # time for i in {1..1000}; \
>>    do xfs_io -c "truncate 4k" /mnt/scratch/$i; done
>>
>>  rtextsize       8k      16k      32k      64k     256k     1024k
>>  before:       9.601s  10.229s  11.153s  12.086s  12.259s  20.141s
>>  after:        9.710s   9.642s   9.958s   9.441s  10.021s  10.526s
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  fs/xfs/xfs_inode.c | 10 ++++++++--
>>  fs/xfs/xfs_iops.c  |  9 +++++++++
>>  2 files changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
>> index 92daa2279053..5e837ed093b0 100644
>> --- a/fs/xfs/xfs_inode.c
>> +++ b/fs/xfs/xfs_inode.c
>> @@ -1487,6 +1487,7 @@ xfs_itruncate_extents_flags(
>>  	struct xfs_trans	*tp = *tpp;
>>  	xfs_fileoff_t		first_unmap_block;
>>  	int			error = 0;
>> +	unsigned int		unitsize = xfs_inode_alloc_unitsize(ip);
>>  
>>  	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
>>  	if (atomic_read(&VFS_I(ip)->i_count))
>> @@ -1510,9 +1511,14 @@ xfs_itruncate_extents_flags(
>>  	 *
>>  	 * We have to free all the blocks to the bmbt maximum offset, even if
>>  	 * the page cache can't scale that far.
>> +	 *
>> +	 * For big realtime inode, don't aligned to allocation unitsize,
>> +	 * it'll split the extent and convert the tail blocks to unwritten.
>>  	 */
>> +	if (xfs_inode_has_bigrtalloc(ip))
>> +		unitsize = i_blocksize(VFS_I(ip));
>> +	first_unmap_block = XFS_B_TO_FSB(mp, roundup_64(new_size, unitsize));
> 
> If you expand what xfs_inode_alloc_unitsize and xfs_inode_has_bigrtalloc
> this is looking a bit silly:
> 
> 	unsigned int            blocks = 1;
> 
> 	if (XFS_IS_REALTIME_INODE(ip))
> 		blocks = ip->i_mount->m_sb.sb_rextsize;
> 
> 	unitsize = XFS_FSB_TO_B(ip->i_mount, blocks);
> 	if (XFS_IS_REALTIME_INODE(ip) && ip->i_mount->m_sb.sb_rextsize > 1)
> 		unsitsize = i_blocksize(inode);
> 
> So I think we can simply drop this part now that the variant that zeroes
> the entire rtextent is gone.
> 
Thanks for your suggestion.

Yeah, we could fix the realtime inode problem by just drop this part, but
for the upcoming forcealign feature and atomic feature by John, IIUC, we
couldn't split and convert the tail extent like RT inode does, we should
zero out the entire tail force aligned extent, if not, atomic write could
be broken by submitting unaligned bios.

Jone had already expand the xfs_inode_alloc_unitsize() [1], so I think
we should keep this part for forcealign feature and deal with realtime
inode separately, is that right?

[1]
https://lore.kernel.org/linux-xfs/20240607143919.2622319-1-john.g.garry@oracle.com/T/#m73ccaa7b6fec9988f24b881e013fc367429405d6
https://lore.kernel.org/linux-xfs/20240607143919.2622319-1-john.g.garry@oracle.com/T/#m1a6312428e4addc4d0d260fbf33ad7bcffb98e0d

Thanks,
Yi.

>> @@ -862,6 +862,15 @@ xfs_setattr_truncate_data(
>>  	/* Truncate down */
>>  	blocksize = xfs_inode_alloc_unitsize(ip);
>>  
>> +	/*
>> +	 * If it's a big realtime inode, zero out the entire EOF extent could
>> +	 * get slow down as the rtextsize increases, speed it up by adjusting
>> +	 * the blocksize to the filesystem blocksize, let __xfs_bunmapi() to
>> +	 * split the extent and convert the tail blocks to unwritten.
>> +	 */
>> +	if (xfs_inode_has_bigrtalloc(ip))
>> +		blocksize = i_blocksize(inode);
> 
> Same here.  And with that probably also the passing of the block size
> to the truncate_page helpers.
> 


