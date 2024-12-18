Return-Path: <linux-fsdevel+bounces-37732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8698D9F6660
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 14:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBDFF1893A83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 13:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6131ACEC7;
	Wed, 18 Dec 2024 13:02:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A881A23A1;
	Wed, 18 Dec 2024 13:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734526949; cv=none; b=YxWrsA+se+iVPK1Xl1prJ0hporuiLim/74P5ZlQeqE05rBxKFuuT6rb7RokOPwIRaXlDLgl+au86J9V9USO//b8t599kNTZQPWJSb4TrfBl0+C9JbbnV3D2KZozdrTh7Mo0jk2bC1IMpiF8hFcEE2eyiGqLKhWiricDXsTTYztI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734526949; c=relaxed/simple;
	bh=JhfrtdX9zId8iPMl9CCj1AZmejdrukph9NewOcZ7Mvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cABzVLSh2VOvBnJpFxAHKUYvdqk2N7xhhhimw+TCnSz0krVbaVtG/JXVpZbf1Mi6gIiWgkVuFEYUN4BNwgNxlXhEObMQ+X9HhVUJTVtFB9rUctI+GGZAWCC6rBoCJKfsZyApL3oNQWgjt5Mb3hcdHQAI56k/uE/WSUflwxafDgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YCv323Kgjz4f3jtC;
	Wed, 18 Dec 2024 21:02:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E4AD41A018D;
	Wed, 18 Dec 2024 21:02:20 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCnzoLbx2Jn9IXQEw--.25670S3;
	Wed, 18 Dec 2024 21:02:20 +0800 (CST)
Message-ID: <a2be273d-f7d2-48e4-84c8-27066d8136b1@huaweicloud.com>
Date: Wed, 18 Dec 2024 21:02:18 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] ext4: remove writable userspace mappings before
 truncating page cache
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com, yangerkun@huawei.com
References: <20241216013915.3392419-1-yi.zhang@huaweicloud.com>
 <20241216013915.3392419-2-yi.zhang@huaweicloud.com>
 <Z2KcZt91otMCYqvi@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <Z2KcZt91otMCYqvi@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnzoLbx2Jn9IXQEw--.25670S3
X-Coremail-Antispam: 1UD129KBjvJXoW3WFyDXF15Aw4DGFWDKrW3Wrg_yoWxKw18pr
	9xGF13Cr48ZasruF1SvF17Zw1Fg3s7ZFW7Ary3Kw1UZasIq3Z7KF1Dtry8uF4jkrWkJr40
	vF4Ut39F9F45AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUzt
	xhDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/12/18 17:56, Ojaswin Mujoo wrote:
> On Mon, Dec 16, 2024 at 09:39:06AM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> When zeroing a range of folios on the filesystem which block size is
>> less than the page size, the file's mapped blocks within one page will
>> be marked as unwritten, we should remove writable userspace mappings to
>> ensure that ext4_page_mkwrite() can be called during subsequent write
>> access to these partial folios. Otherwise, data written by subsequent
>> mmap writes may not be saved to disk.
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
>> Fix this by introducing ext4_truncate_page_cache_block_range() to remove
>> writable userspace mappings when truncating a partial folio range.
>> Additionally, move the journal data mode-specific handlers and
>> truncate_pagecache_range() into this function, allowing it to serve as a
>> common helper that correctly manages the page cache in preparation for
>> block range manipulations.
> 
> Hi Zhang,
> 
> Thanks for the fix, just to confirm my understanding, the issue arises
> because of the following flow:
> 
> 1. page_mkwrite() makes folio dirty when we write to the mmap'd region
> 
> 2. ext4_zero_range (2kb to 4kb)
>     truncate_pagecache_range
>       truncate_inode_pages_range
>         truncate_inode_partial_folio
>           folio_zero_range (2kb to 4kb)
>             folio_invalidate
>               ext4_invalidate_folio
>                 block_invalidate_folio -> clear the bh dirty bit
> 
> 3. mwrite (2kb to 4kb): Again we write in pagecache but the bh is not
>    dirty hence after a remount the data is not seen on disk
> 
> Also, we won't see this issue if we are zeroing a page aligned range
> since we end up unmapping the pages from the proccess address space in 
> that case. Correct?

Thank you for review! Yes, it's correct.

> 
> I have also tested the patch in PowerPC with 64k pagesize and 4k blocks
> size and can confirm that it fixes the data loss issue. That being said,
> I have a few minor comments on the patch below:
> 

Thank you for the test.

>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  fs/ext4/ext4.h    |  2 ++
>>  fs/ext4/extents.c | 19 ++++-----------
>>  fs/ext4/inode.c   | 62 +++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 69 insertions(+), 14 deletions(-)
>>
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 74f2071189b2..8843929b46ce 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -3016,6 +3016,8 @@ extern int ext4_inode_attach_jinode(struct inode *inode);
>>  extern int ext4_can_truncate(struct inode *inode);
>>  extern int ext4_truncate(struct inode *);
>>  extern int ext4_break_layouts(struct inode *);
>> +extern int ext4_truncate_page_cache_block_range(struct inode *inode,
>> +						loff_t start, loff_t end);
>>  extern int ext4_punch_hole(struct file *file, loff_t offset, loff_t length);
>>  extern void ext4_set_inode_flags(struct inode *, bool init);
>>  extern int ext4_alloc_da_blocks(struct inode *inode);
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index a07a98a4b97a..8dc6b4271b15 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -4667,22 +4667,13 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>>  			goto out_mutex;
>>  		}
>>  
>> -		/*
>> -		 * For journalled data we need to write (and checkpoint) pages
>> -		 * before discarding page cache to avoid inconsitent data on
>> -		 * disk in case of crash before zeroing trans is committed.
>> -		 */
>> -		if (ext4_should_journal_data(inode)) {
>> -			ret = filemap_write_and_wait_range(mapping, start,
>> -							   end - 1);
>> -			if (ret) {
>> -				filemap_invalidate_unlock(mapping);
>> -				goto out_mutex;
>> -			}
>> +		/* Now release the pages and zero block aligned part of pages */
>> +		ret = ext4_truncate_page_cache_block_range(inode, start, end);
>> +		if (ret) {
>> +			filemap_invalidate_unlock(mapping);
>> +			goto out_mutex;
>>  		}
>>  
>> -		/* Now release the pages and zero block aligned part of pages */
>> -		truncate_pagecache_range(inode, start, end - 1);
>>  		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
>>  
>>  		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 89aade6f45f6..c68a8b841148 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -31,6 +31,7 @@
>>  #include <linux/writeback.h>
>>  #include <linux/pagevec.h>
>>  #include <linux/mpage.h>
>> +#include <linux/rmap.h>
>>  #include <linux/namei.h>
>>  #include <linux/uio.h>
>>  #include <linux/bio.h>
>> @@ -3902,6 +3903,67 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
>>  	return ret;
>>  }
>>  
>> +static inline void ext4_truncate_folio(struct inode *inode,
>> +				       loff_t start, loff_t end)
>> +{
>> +	unsigned long blocksize = i_blocksize(inode);
>> +	struct folio *folio;
>> +
>> +	/* Nothing to be done if no complete block needs to be truncated. */
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
>> +}
>> +
>> +int ext4_truncate_page_cache_block_range(struct inode *inode,
>> +					 loff_t start, loff_t end)
>> +{
>> +	unsigned long blocksize = i_blocksize(inode);
>> +	int ret;
>> +
>> +	/*
>> +	 * For journalled data we need to write (and checkpoint) pages
>> +	 * before discarding page cache to avoid inconsitent data on disk
>> +	 * in case of crash before freeing or unwritten converting trans
>> +	 * is committed.
>> +	 */
>> +	if (ext4_should_journal_data(inode)) {
>> +		ret = filemap_write_and_wait_range(inode->i_mapping, start,
>> +						   end - 1);
>> +		if (ret)
>> +			return ret;
>> +		goto truncate_pagecache;
>> +	}
>> +
>> +	/*
>> +	 * If the block size is less than the page size, the file's mapped
>> +	 * blocks within one page could be freed or converted to unwritten.
>> +	 * So it's necessary to remove writable userspace mappings, and then
>> +	 * ext4_page_mkwrite() can be called during subsequent write access
>> +	 * to these partial folios.
>> +	 */
>> +	if (blocksize < PAGE_SIZE && start < inode->i_size) {
> 
> Maybe we should only call ext4_truncate_folio() if the range is not page
> aligned, rather than calling it everytime for bs < ps?

I agree with you, so how about below？

	if (!IS_ALIGNED(start | end, PAGE_SIZE) &&
	    blocksize < PAGE_SIZE && start < inode->i_size && )

> 
>> +		loff_t start_boundary = round_up(start, PAGE_SIZE);
> 
> I think page_boundary seems like a more suitable name for the variable.

Yeah, it looks fine to me.

Thanks,
Yi.


