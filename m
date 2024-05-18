Return-Path: <linux-fsdevel+bounces-19703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB44B8C8F4B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2024 04:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B77B1F21C54
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2024 02:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004446FCB;
	Sat, 18 May 2024 02:01:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A6B10E5;
	Sat, 18 May 2024 02:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715997673; cv=none; b=NMUIne2BDSOIMW42GNGGFIzVlPH2Ve5yYkr9m7pJBjcjuZwPrXwsFU6UztSIs01nUJh0a1xrfR2CyojGVLqMKXLS4KuWgasOIuuZWyz9syOUlYLsJSNdnv8pT1SXrDW4AyGWFf3fNfTW+N5pGnRtSmoVacE1odhCF3nei+K5lGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715997673; c=relaxed/simple;
	bh=W+N7bDWaP8vymfF5B5R5X+wCEHlotFJrTVJmPP7Nhtg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=risFDVLkKHVjd5DFzbIq7C2E8DpEIpQUr9in8g8KZ1Jnxc+uAqjGdlXcd09Nkw2aXUYsZKLt7+kKXn12mGHpNnrtYvLtW3zdkNMlN6MsX7fXeQYqo1YboJInNrt/nRhh0pk+90pbIyxYzwsxz9b2AvNE/Oyc8w5xZmhANAMzCIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vh6Vx66wGz4f3jrg;
	Sat, 18 May 2024 10:00:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 9AF1F1A08FC;
	Sat, 18 May 2024 10:01:06 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgBXfA_gC0hmjqAhNQ--.5912S3;
	Sat, 18 May 2024 10:01:06 +0800 (CST)
Subject: Re: [PATCH v3 1/3] iomap: pass blocksize to iomap_truncate_page()
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@infradead.org,
 brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
 jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240517111355.233085-1-yi.zhang@huaweicloud.com>
 <20240517111355.233085-2-yi.zhang@huaweicloud.com>
 <20240517172925.GB360919@frogsfrogsfrogs>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <f30761af-6335-6c81-3860-95823b83a68e@huaweicloud.com>
Date: Sat, 18 May 2024 10:01:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240517172925.GB360919@frogsfrogsfrogs>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBXfA_gC0hmjqAhNQ--.5912S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXF45WryUAFW5WF1fGr1xXwb_yoWrXrW5pF
	1vkF45CFs7Xryj9Fn2gFyjvw1Fq3Z5Gr40krySgr98uF9Fqr1IyFn2k3WF9F4jqrs7Cr4j
	vFZ8Kay8WF45AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 2024/5/18 1:29, Darrick J. Wong wrote:
> On Fri, May 17, 2024 at 07:13:53PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> iomap_truncate_page() always assumes the block size of the truncating
>> inode is i_blocksize(), this is not always true for some filesystems,
>> e.g. XFS does extent size alignment for realtime inodes. Drop this
>> assumption and pass the block size for zeroing into
>> iomap_truncate_page(), allow filesystems to indicate the correct block
>> size.
>>
>> Suggested-by: Dave Chinner <david@fromorbit.com>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  fs/iomap/buffered-io.c | 13 +++++++++----
>>  fs/xfs/xfs_iomap.c     |  3 ++-
>>  include/linux/iomap.h  |  4 ++--
>>  3 files changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> index 0926d216a5af..a0a0ac2c659c 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/bio.h>
>>  #include <linux/sched/signal.h>
>>  #include <linux/migrate.h>
>> +#include <linux/math64.h>
>>  #include "trace.h"
>>  
>>  #include "../internal.h"
>> @@ -1445,11 +1446,15 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>>  EXPORT_SYMBOL_GPL(iomap_zero_range);
>>  
>>  int
>> -iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
>> -		const struct iomap_ops *ops)
>> +iomap_truncate_page(struct inode *inode, loff_t pos, unsigned int blocksize,
>> +		bool *did_zero, const struct iomap_ops *ops)
>>  {
>> -	unsigned int blocksize = i_blocksize(inode);
>> -	unsigned int off = pos & (blocksize - 1);
>> +	unsigned int off;
>> +
>> +	if (is_power_of_2(blocksize))
>> +		off = pos & (blocksize - 1);
>> +	else
>> +		div_u64_rem(pos, blocksize, &off);
> 
> I wish this was a helper in math64.h somewhere.
> 
> static inline u32 rem_u64(u64 dividend, u32 divisor)
> {
> 	if (likely(is_power_of_2(divisor)))
> 		return dividend & (divisor - 1);
> 
> 	return dividend % divisor;
> }
> 
> That way we skip the second division in div_u64_rem entirely, and the
> iomap/dax code becomes:
> 
> 	unsigned int off = rem_u64(pos, blocksize); /* pos in block */
> 
> Otherwise this looks like a straightforward mechanical change to me.
> 

Yeah, we do need this helper.

Thanks,
Yi.

> 
>>  
>>  	/* Block boundary? Nothing to do */
>>  	if (!off)
>> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
>> index 2857ef1b0272..31ac07bb8425 100644
>> --- a/fs/xfs/xfs_iomap.c
>> +++ b/fs/xfs/xfs_iomap.c
>> @@ -1467,10 +1467,11 @@ xfs_truncate_page(
>>  	bool			*did_zero)
>>  {
>>  	struct inode		*inode = VFS_I(ip);
>> +	unsigned int		blocksize = i_blocksize(inode);
>>  
>>  	if (IS_DAX(inode))
>>  		return dax_truncate_page(inode, pos, did_zero,
>>  					&xfs_dax_write_iomap_ops);
>> -	return iomap_truncate_page(inode, pos, did_zero,
>> +	return iomap_truncate_page(inode, pos, blocksize, did_zero,
>>  				   &xfs_buffered_write_iomap_ops);
>>  }
>> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
>> index 6fc1c858013d..d67bf86ec582 100644
>> --- a/include/linux/iomap.h
>> +++ b/include/linux/iomap.h
>> @@ -273,8 +273,8 @@ int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
>>  		const struct iomap_ops *ops);
>>  int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
>>  		bool *did_zero, const struct iomap_ops *ops);
>> -int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
>> -		const struct iomap_ops *ops);
>> +int iomap_truncate_page(struct inode *inode, loff_t pos, unsigned int blocksize,
>> +		bool *did_zero, const struct iomap_ops *ops);
>>  vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf,
>>  			const struct iomap_ops *ops);
>>  int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>> -- 
>> 2.39.2
>>
>>


