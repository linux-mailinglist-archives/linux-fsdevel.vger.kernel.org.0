Return-Path: <linux-fsdevel+bounces-19706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6938C8FD4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2024 08:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7A661C210CB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2024 06:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941E7D517;
	Sat, 18 May 2024 06:35:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA35BE49;
	Sat, 18 May 2024 06:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716014114; cv=none; b=ThEm9ffQS4PYBQaeAKHn/7uoCVuwSYLMIifw6N8RCRKLxRbAFnKL6O4+QRVdCaU5kIHs8Pk0hcD9O9WWAqJv1bDdyOqVKLH0QrV151qxGvORf2KnDT61iehTvERVDk/6l3t/Q9Ug/HAr6UnE07MS0U2/X+rnetB1OB2dgnFkjoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716014114; c=relaxed/simple;
	bh=QlXpXX60V1p6MmH0m1H698LHqkeS2DTu2nZqFsgOlZU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=inofamqyeQiyOrNZ0W2lePZZx+5T7T43gxtu6T5dhHyCZjwJhNVDR3QkWQdTl6H0IyW3Fm4AlGNdOyDFZsmA06iSJ0yZJi5zV02TMyBnUcjaAqv0yXAtPHsyATPxjcrnBjJuYLOhUJbRvIEhqRbMeqsd+3nCzthavO+Nn2UAh2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VhDb447gHz4f3l1b;
	Sat, 18 May 2024 14:34:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id D78061A01A7;
	Sat, 18 May 2024 14:35:06 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgAXPA8WTEhm1OUzNQ--.15562S3;
	Sat, 18 May 2024 14:35:04 +0800 (CST)
Subject: Re: [PATCH v3 3/3] xfs: correct the zeroing truncate range
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@infradead.org,
 brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
 jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240517111355.233085-1-yi.zhang@huaweicloud.com>
 <20240517111355.233085-4-yi.zhang@huaweicloud.com>
 <20240517175900.GC360919@frogsfrogsfrogs>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <fc050e5c-cdc5-9e3d-2787-ce09ec3b888e@huaweicloud.com>
Date: Sat, 18 May 2024 14:35:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240517175900.GC360919@frogsfrogsfrogs>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAXPA8WTEhm1OUzNQ--.15562S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtF1Dtry5Wr1DuF1rXrW5Jrb_yoW3tw17pF
	WxK3WDCrykK34xZr1xZF1qqw1F9a1rJr4I9ryfJrn7Zwn8Xr1xtrnFgayFgF4qkrs7Cw40
	qF40yayxGrn7AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
	1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUrR6zUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/5/18 1:59, Darrick J. Wong wrote:
> On Fri, May 17, 2024 at 07:13:55PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> When truncating a realtime file unaligned to a shorter size,
>> xfs_setattr_size() only flush the EOF page before zeroing out, and
>> xfs_truncate_page() also only zeros the EOF block. This could expose
>> stale data since 943bc0882ceb ("iomap: don't increase i_size if it's not
>> a write operation").
>>
>> If the sb_rextsize is bigger than one block, and we have a realtime
>> inode that contains a long enough written extent. If we unaligned
>> truncate into the middle of this extent, xfs_itruncate_extents() could
>> split the extent and align the it's tail to sb_rextsize, there maybe
>> have more than one blocks more between the end of the file. Since
>> xfs_truncate_page() only zeros the trailing portion of the i_blocksize()
>> value, so it may leftover some blocks contains stale data that could be
>> exposed if we append write it over a long enough distance later.
> 
> IOWs, any time we truncate down, we need to zero every byte from the new
> EOF all the way to the end of the allocation unit, correct?

Yeah.

> 
> Maybe pictures would be easier to reason with.  Say you have
> rextsize=30 and a partially written rtextent; each 'W' is a written
> fsblock and 'u' is an unwritten fsblock:
> 
> WWWWWWWWWWWWWWWWWWWWWuuuuuuuuu
>                     ^ old EOF
> 
> Now you want to truncate down:
> 
> WWWWWWWWWWWWWWWWWWWWWuuuuuuuuu
>      ^ new EOF      ^ old EOF
> 
> Currently, iomap_truncate_blocks only zeroes up to the next i_blocksize,
> so the truncate leaves the file in this state:
> 
> WWWWWzWWWWWWWWWWWWWWWuuuuuuuuu
>      ^ new EOF      ^ old EOF
> 
> (where 'z' is a written block with zeroes after EOF)
> 
> This is bad because the "W"s between the new and old EOF still contain
> old credit card info or whatever.  Now if we mmap the file or whatever,
> we can access those old contents.
> 
> So your new patch amends iomap_truncate_page so that it'll zero all the
> way to the end of the @blocksize parameter.  That fixes the exposure by 
> writing zeroes to the pagecache before we truncate down:
> 
> WWWWWzzzzzzzzzzzzzzzzuuuuuuuuu
>      ^ new EOF      ^ old EOF
> 
> Is that correct?
> 

Yes, it's correct. However, not only write zeros to the pagecache, but
also flush to disk, please see below for details.

> If so, then why don't we make xfs_truncate_page convert the post-eof
> rtextent blocks back to unwritten status:
> 
> WWWWWzuuuuuuuuuuuuuuuuuuuuuuuu
>      ^ new EOF      ^ old EOF
> 
> If we can do that, then do we need the changes to iomap_truncate_page?
> Converting the mapping should be much faster than dirtying potentially
> a lot of data (rt extents can be 1GB in size).

Now that the exposed stale data range (should be zeroed) is only one
rtextsize unit, if we convert the post-eof rtextent blocks to unwritten,
it breaks the alignment of rtextent and the definition of "extsize is used
to specify the size of the blocks in the real-time section of the
filesystem", is it fine? And IIUC, the upcoming xfs force alignment
extent feature seems also need to follow this alignment, right?

> 
>> xfs_truncate_page() should flush, zeros out the entire rtextsize range,
>> and make sure the entire zeroed range have been flushed to disk before
>> updating the inode size.
>>
>> Fixes: 943bc0882ceb ("iomap: don't increase i_size if it's not a write operation")
>> Reported-by: Chandan Babu R <chandanbabu@kernel.org>
>> Link: https://lore.kernel.org/linux-xfs/0b92a215-9d9b-3788-4504-a520778953c2@huaweicloud.com
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  fs/xfs/xfs_iomap.c | 35 +++++++++++++++++++++++++++++++----
>>  fs/xfs/xfs_iops.c  | 10 ----------
>>  2 files changed, 31 insertions(+), 14 deletions(-)
>>
>> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
>> index 4958cc3337bc..fc379450fe74 100644
>> --- a/fs/xfs/xfs_iomap.c
>> +++ b/fs/xfs/xfs_iomap.c
>> @@ -1466,12 +1466,39 @@ xfs_truncate_page(
>>  	loff_t			pos,
>>  	bool			*did_zero)
>>  {
>> +	struct xfs_mount	*mp = ip->i_mount;
>>  	struct inode		*inode = VFS_I(ip);
>>  	unsigned int		blocksize = i_blocksize(inode);
>> +	int			error;
>> +
>> +	if (XFS_IS_REALTIME_INODE(ip))
>> +		blocksize = XFS_FSB_TO_B(mp, mp->m_sb.sb_rextsize);
> 
> Don't opencode xfs_inode_alloc_unitsize, please.

Ha, I missed the latest added helper, thanks for pointing this out.

> 
>> +
>> +	/*
>> +	 * iomap won't detect a dirty page over an unwritten block (or a
>> +	 * cow block over a hole) and subsequently skips zeroing the
>> +	 * newly post-EOF portion of the page. Flush the new EOF to
>> +	 * convert the block before the pagecache truncate.
>> +	 */
>> +	error = filemap_write_and_wait_range(inode->i_mapping, pos,
>> +					     roundup_64(pos, blocksize));
>> +	if (error)
>> +		return error;pos_in_block
> 
> Ok so this is hoisting the filemap_write_and_wait_range call from
> xfs_setattr_size.  It's curious that we need to need to twiddle anything
> other than the EOF block itself though?

Since we planed to zero out the dirtied range which is ailgned to the
extsize instead of the blocksize, ensure one block is not unwritten is
not enough, we should also make sure that the range which is going to
zero out is not unwritten, or else the iomap_zero_iter() will skip
zeroing out the extra blocks.

For example:

before zeroing:
           |<-    extszie   ->|
        ...dddddddddddddddddddd
        ...UUUUUUUUUUUUUUUUUUUU
           ^                  ^
        new EOF             old EOF    (where 'd' means the pagecache is dirty)

if we only flush the new EOF block, the result becomes:

           |<-    extszie   ->|
           zddddddddddddddddddd
           ZUUUUUUUUUUUUUUUUUUU
           ^                  ^
        new EOF             old EOF


then the dirty extent range that between new EOF block and the old EOF
block can't be zeroed sine it's still unwritten. So we have to flush the
whole range before zeroing out.

> 
>>  
>>  	if (IS_DAX(inode))
>> -		return dax_truncate_page(inode, pos, blocksize, did_zero,
>> -					&xfs_dax_write_iomap_ops);
>> -	return iomap_truncate_page(inode, pos, blocksize, did_zero,
>> -				   &xfs_buffered_write_iomap_ops);
>> +		error = dax_truncate_page(inode, pos, blocksize, did_zero,
>> +					  &xfs_dax_write_iomap_ops);
>> +	else
>> +		error = iomap_truncate_page(inode, pos, blocksize, did_zero,
>> +					    &xfs_buffered_write_iomap_ops);
>> +	if (error)
>> +		return error;
>> +
>> +	/*
>> +	 * Write back path won't write dirty blocks post EOF folio,
>> +	 * flush the entire zeroed range before updating the inode
>> +	 * size.
>> +	 */
>> +	return filemap_write_and_wait_range(inode->i_mapping, pos,
>> +					    roundup_64(pos, blocksize));
> 
> ...but what is the purpose of the second filemap_write_and_wait_range
> call?  Is that to flush the bytes between new and old EOF to disk before
> truncate_setsize invalidates the (zeroed) pagecache?
> 

The second filemap_write_and_wait_range() call is used to make sure that
the zeroed data be flushed to disk before we updating i_size. If we don't
add this one, once the i_size is been changed, the zeroed data which
beyond the new EOF folio(block) couldn't be write back, because
iomap_writepage_map()->iomap_writepage_handle_eof() skip that range, so
the stale data problem is still there.

For example:

before zeroing:
           |<-    extszie   ->|
           wwwwwwwwwwwwwwwwwwww (pagecache)
        ...WWWWWWWWWWWWWWWWWWWW (disk)
           ^                  ^
        new EOF               EOF   (where 'w' means the pagecache contains data)

then iomap_truncate_page() zeroing out the pagecache:

           |<-    extszie   ->|
           zzzzzzzzzzzzzzzzzzzz (pagecache)
           WWWWWWWWWWWWWWWWWWWW (disk)
           ^                  ^
        new EOF               EOF

then update i_size, sync and drop cache:

           |<-    extszie   ->|
           ZWWWWWWWWWWWWWWWWWWW (disk)
           ^
           EOF

Thanks,
Yi.

> 
>>  }
>> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
>> index 66f8c47642e8..baeeddf4a6bb 100644
>> --- a/fs/xfs/xfs_iops.c
>> +++ b/fs/xfs/xfs_iops.c
>> @@ -845,16 +845,6 @@ xfs_setattr_size(
>>  		error = xfs_zero_range(ip, oldsize, newsize - oldsize,
>>  				&did_zeroing);
>>  	} else {
>> -		/*
>> -		 * iomap won't detect a dirty page over an unwritten block (or a
>> -		 * cow block over a hole) and subsequently skips zeroing the
>> -		 * newly post-EOF portion of the page. Flush the new EOF to
>> -		 * convert the block before the pagecache truncate.
>> -		 */
>> -		error = filemap_write_and_wait_range(inode->i_mapping, newsize,
>> -						     newsize);
>> -		if (error)
>> -			return error;
>>  		error = xfs_truncate_page(ip, newsize, &did_zeroing);
>>  	}
>>  
>> -- 
>> 2.39.2
>>
>>


