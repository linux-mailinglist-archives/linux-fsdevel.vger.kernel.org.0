Return-Path: <linux-fsdevel+bounces-36611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FE49E685C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 09:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B948282A6C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 08:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7121DF73C;
	Fri,  6 Dec 2024 07:59:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28361DD88F;
	Fri,  6 Dec 2024 07:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733471994; cv=none; b=tXlqgL5t+WA5VQWsExlROI6nHFy+6vrDkZOYYLSv2kxORhE6BNAmqbQyQ9kjSMNOtvEXlEq3N/89Zsj5WMo+gXm8q/QsHeMhds2+0K0jsfC2jS3QCJ60RDNumfLW5lrdwZ9AEHhcy8IugX9skg0xQ2DBJkDmv4GaUKP7cdji/bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733471994; c=relaxed/simple;
	bh=jbR+UZZ+L7tyrh/KOmvNFM8tf+WapdgPnE3t8Ao/uig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9blkYi5O9tS6S+Wga5HA96KWGbXQ0jZpZmcoNyyLpJdZlin1WRQuNXNy9A/80n9hlURW/f/1BdQ/73UIOE9hKQz27doHPpe/ju4ZZTjiUYKivdJutjtygvi7xbcfqXl9SEDo4imD9ayhSosBQexEgfZG+8va413C4fBvEusAag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y4NvM0l0jz4f3lWD;
	Fri,  6 Dec 2024 15:59:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2B4C31A06D7;
	Fri,  6 Dec 2024 15:59:47 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDHo4fxrlJnFBc9Dw--.33706S3;
	Fri, 06 Dec 2024 15:59:46 +0800 (CST)
Message-ID: <d31e0298-edbc-4e2b-9acd-f1191409f149@huaweicloud.com>
Date: Fri, 6 Dec 2024 15:59:44 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/27] ext4: remove writable userspace mappings before
 truncating page cache
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ritesh.list@gmail.com, hch@infradead.org, djwong@kernel.org,
 david@fromorbit.com, zokeefe@google.com, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
 <20241022111059.2566137-2-yi.zhang@huaweicloud.com>
 <20241204111310.3yzbaozrijll4qx5@quack3>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20241204111310.3yzbaozrijll4qx5@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDHo4fxrlJnFBc9Dw--.33706S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKFWDGF15CF1xXFWDXr4DXFb_yoW7ur1rpF
	y7GF13CrWxua1DuF10v3W8Zr1rK34DAFW5J343Kry7Zr95Z3WxKrn7tw1j9F4UKrs7Jr10
	vF4UJrZ2gF15ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/12/4 19:13, Jan Kara wrote:
> I'm sorry for the huge delay here...
> 
It's fine, I know you're probably been busy lately, and this series has
undergone significant modifications, which should require considerable
time for review. Thanks a lot for taking time to review this series!

> On Tue 22-10-24 19:10:32, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> When zeroing a range of folios on the filesystem which block size is
>> less than the page size, the file's mapped partial blocks within one
>> page will be marked as unwritten, we should remove writable userspace
>> mappings to ensure that ext4_page_mkwrite() can be called during
>> subsequent write access to these folios. Otherwise, data written by
>> subsequent mmap writes may not be saved to disk.
>>
>>  $mkfs.ext4 -b 1024 /dev/vdb
>>  $mount /dev/vdb /mnt
>>  $xfs_io -t -f -c "pwrite -S 0x58 0 4096" -c "mmap -rw 0 4096" \
>>                -c "mwrite -S 0x5a 2048 2048" -c "fzero 2048 2048" \
>>                -c "mwrite -S 0x59 2048 2048" -c "close" /mnt/foo
>>
>>  $od -Ax -t x1z /mnt/foo
>>  000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
>>  *
>>  000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59
>>  *
>>  001000
>>
>>  $umount /mnt && mount /dev/vdb /mnt
>>  $od -Ax -t x1z /mnt/foo
>>  000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
>>  *
>>  000800 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>  *
>>  001000
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> This is a great catch! I think this may be source of the sporadic data
> corruption issues we observe with blocksize < pagesize.
> 
>> +static inline void ext4_truncate_folio(struct inode *inode,
>> +				       loff_t start, loff_t end)
>> +{
>> +	unsigned long blocksize = i_blocksize(inode);
>> +	struct folio *folio;
>> +
>> +	if (round_up(start, blocksize) >= round_down(end, blocksize))
>> +		return;
>> +
>> +	folio = filemap_lock_folio(inode->i_mapping, start >> PAGE_SHIFT);
>> +	if (IS_ERR(folio))
>> +		return;
>> +
>> +	if (folio_mkclean(folio))
>> +		folio_mark_dirty(folio);
>> +	folio_unlock(folio);
>> +	folio_put(folio);
> 
> I don't think this is enough. In your example from the changelog, this would
> leave the page at index 0 dirty and still with 0x5a values in 2048-4096 range.
> Then truncate_pagecache_range() does nothing, ext4_alloc_file_blocks()
> converts blocks under 2048-4096 to unwritten state. But what handles
> zeroing of page cache in 2048-4096 range? ext4_zero_partial_blocks() zeroes
> only partial blocks, not full blocks. Am I missing something?
> 

Sorry, I don't understand why truncate_pagecache_range() does nothing? In my
example, the variable 'start' is 2048, the variable 'end' is 4096, and the
call process truncate_pagecache_range(inode, 2048, 4096-1)->..->
truncate_inode_partial_folio()->folio_zero_range() does zeroing the 2048-4096
range. I also tested it below, it was zeroed.

  xfs_io -t -f -c "pwrite -S 0x58 0 4096" -c "mmap -rw 0 4096" \
               -c "mwrite -S 0x5a 2048 2048" \
               -c "fzero 2048 2048" -c "close" /mnt/foo

  od -Ax -t x1z /mnt/foo
  000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
  *
  000800 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
  *
  001000

> If I'm right, I'd keep it simple and just writeout these partial folios with
> filemap_write_and_wait_range() and expand the range
> truncate_pagecache_range() removes to include these partial folios. The

What I mean is the truncate_pagecache_range() has already covered the partial
folios. right?

> overhead won't be big and it isn't like this is some very performance
> sensitive path.
> 
>> +}
>> +
>> +/*
>> + * When truncating a range of folios, if the block size is less than the
>> + * page size, the file's mapped partial blocks within one page could be
>> + * freed or converted to unwritten. We should call this function to remove
>> + * writable userspace mappings so that ext4_page_mkwrite() can be called
>> + * during subsequent write access to these folios.
>> + */
>> +void ext4_truncate_folios_range(struct inode *inode, loff_t start, loff_t end)
> 
> Maybe call this ext4_truncate_page_cache_block_range()? And assert that
> start & end are block aligned. Because this essentially prepares page cache
> for manipulation with a block range.

Ha, it's a good idea, I agree with you that move truncate_pagecache_range()
and the hunk of flushing in journal data mode into this function. But I don't
understand why assert that 'start & end' are block aligned? I think
ext4_truncate_page_cache_block_range() should allow passing unaligned input
parameters and aligned them itself, especially, after patch 04 and 05,
ext4_zero_range() and ext4_punch_hole() will passing offset and offset+len
directly, which may block unaligned.

Thanks,
Yi.

> 
>> +{
>> +	unsigned long blocksize = i_blocksize(inode);
>> +
>> +	if (end > inode->i_size)
>> +		end = inode->i_size;
>> +	if (start >= end || blocksize >= PAGE_SIZE)
>> +		return;
>> +
>> +	ext4_truncate_folio(inode, start, min(round_up(start, PAGE_SIZE), end));
>> +	if (end > round_up(start, PAGE_SIZE))
>> +		ext4_truncate_folio(inode, round_down(end, PAGE_SIZE), end);
>> +}
> 
> So I'd move the following truncate_pagecache_range() into
> ext4_truncate_folios_range(). And also the preceding:
> 
>                 /*
>                  * For journalled data we need to write (and checkpoint) pages
>                  * before discarding page cache to avoid inconsitent data on
>                  * disk in case of crash before zeroing trans is committed.
>                  */
>                 if (ext4_should_journal_data(inode)) {
>                         ret = filemap_write_and_wait_range(mapping, start,
>                                                            end - 1);
> 		...
> 
> into this function. So that it can be self-contained "do the right thing
> with page cache to prepare for block range manipulations".
> 
> 								Honza


