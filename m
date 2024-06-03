Return-Path: <linux-fsdevel+bounces-20834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A24C8D84AF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 16:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8091C20F26
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 14:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1416912E1EE;
	Mon,  3 Jun 2024 14:15:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B140757E0;
	Mon,  3 Jun 2024 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717424132; cv=none; b=kcNpj7NQgQpitwW7NUcW2vJRBkNsmlxLjwND9qvw5pyKdGLJGfHRysMwF3pbqK2iXEKFXxhDs6vOdsWA6WyHrbltvsLo8ovIat9mwK3CtNCYU5soC2Pep4WEctFNVOVnqnT2bNtc36QlVzfASp44LlCp2LLN3xasV/huEGIDQcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717424132; c=relaxed/simple;
	bh=ZHYDKpcdSoeZxdhVpyMxTink1TrnNK2idMe7QsWzkLQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UVnC8AJdog9ZlHrlVdIunqODTdJeVZqMCfqve6WLbPw2aLDlO/CefVPLED4eceGo8CnS0xRk1mLR/f74dXWxGq7m5Y9A4XKuqJn+Y1U+6bvstTcWByFBYNiF0LdAf79pof7bybm/b5Qr7K3k7/K+Q1H6VSrk6+frwbW1y9DwmFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VtG2q5430z4f3m7g;
	Mon,  3 Jun 2024 22:15:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id B98971A0A1E;
	Mon,  3 Jun 2024 22:15:26 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgBHaw78z11mfUdPOw--.15169S3;
	Mon, 03 Jun 2024 22:15:26 +0800 (CST)
Subject: Re: [RFC PATCH v4 5/8] xfs: refactor the truncating order
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
 david@fromorbit.com, chandanbabu@kernel.org, jack@suse.cz,
 willy@infradead.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <20240529095206.2568162-6-yi.zhang@huaweicloud.com>
 <20240531154420.GO52987@frogsfrogsfrogs>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <680a8658-e0e9-25c6-545d-a09d63e7d016@huaweicloud.com>
Date: Mon, 3 Jun 2024 22:15:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240531154420.GO52987@frogsfrogsfrogs>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBHaw78z11mfUdPOw--.15169S3
X-Coremail-Antispam: 1UD129KBjvJXoW3KryxCFy8Aw4DXF17KFW7Jwb_yoWDCFyDpr
	93Gas8Gr4kGFyUZr1kZF1jqw1Sg3WkJrWIkFyIgF97uas8Zr1xtF97Kry0ga1jkrs3Ww4F
	9F4kJayfu3Z5AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUrR6zUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/5/31 23:44, Darrick J. Wong wrote:
> On Wed, May 29, 2024 at 05:52:03PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> When truncating down an inode, we call xfs_truncate_page() to zero out
>> the tail partial block that beyond new EOF, which prevents exposing
>> stale data. But xfs_truncate_page() always assumes the blocksize is
>> i_blocksize(inode), it's not always true if we have a large allocation
>> unit for a file and we should aligned to this unitsize, e.g. realtime
>> inode should aligned to the rtextsize.
>>
>> Current xfs_setattr_size() can't support zeroing out a large alignment
>> size on trucate down since the process order is wrong. We first do zero
>> out through xfs_truncate_page(), and then update inode size through
>> truncate_setsize() immediately. If the zeroed range is larger than a
>> folio, the write back path would not write back zeroed pagecache beyond
>> the EOF folio, so it doesn't write zeroes to the entire tail extent and
>> could expose stale data after an appending write into the next aligned
>> extent.
>>
>> We need to adjust the order to zero out tail aligned blocks, write back
>> zeroed or cached data, update i_size and drop cache beyond aligned EOF
>> block, preparing for the fix of realtime inode and supporting the
>> upcoming forced alignment feature.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  fs/xfs/xfs_iomap.c |   2 +-
>>  fs/xfs/xfs_iomap.h |   3 +-
>>  fs/xfs/xfs_iops.c  | 107 ++++++++++++++++++++++++++++-----------------
>>  3 files changed, 69 insertions(+), 43 deletions(-)
>>
>> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
>> index 8cdfcbb5baa7..0369b64cc3f4 100644
>> --- a/fs/xfs/xfs_iomap.c
>> +++ b/fs/xfs/xfs_iomap.c
>> @@ -1468,10 +1468,10 @@ int
>>  xfs_truncate_page(
>>  	struct xfs_inode	*ip,
>>  	loff_t			pos,
>> +	unsigned int		blocksize,
>>  	bool			*did_zero)
>>  {
>>  	struct inode		*inode = VFS_I(ip);
>> -	unsigned int		blocksize = i_blocksize(inode);
>>  
>>  	if (IS_DAX(inode))
>>  		return dax_truncate_page(inode, pos, blocksize, did_zero,
>> diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
>> index 4da13440bae9..feb1610cb645 100644
>> --- a/fs/xfs/xfs_iomap.h
>> +++ b/fs/xfs/xfs_iomap.h
>> @@ -25,7 +25,8 @@ int xfs_bmbt_to_iomap(struct xfs_inode *ip, struct iomap *iomap,
>>  
>>  int xfs_zero_range(struct xfs_inode *ip, loff_t pos, loff_t len,
>>  		bool *did_zero);
>> -int xfs_truncate_page(struct xfs_inode *ip, loff_t pos, bool *did_zero);
>> +int xfs_truncate_page(struct xfs_inode *ip, loff_t pos,
>> +		unsigned int blocksize, bool *did_zero);
>>  
>>  static inline xfs_filblks_t
>>  xfs_aligned_fsb_count(
>> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
>> index d44508930b67..d24927075022 100644
>> --- a/fs/xfs/xfs_iops.c
>> +++ b/fs/xfs/xfs_iops.c
>> @@ -812,6 +812,7 @@ xfs_setattr_size(
>>  	int			error;
>>  	uint			lock_flags = 0;
>>  	bool			did_zeroing = false;
>> +	bool			write_back = false;
>>  
>>  	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL);
>>  	ASSERT(S_ISREG(inode->i_mode));
>> @@ -853,30 +854,7 @@ xfs_setattr_size(
>>  	 * the transaction because the inode cannot be unlocked once it is a
>>  	 * part of the transaction.
>>  	 *
>> -	 * Start with zeroing any data beyond EOF that we may expose on file
>> -	 * extension, or zeroing out the rest of the block on a downward
>> -	 * truncate.
>> -	 */
>> -	if (newsize > oldsize) {
>> -		trace_xfs_zero_eof(ip, oldsize, newsize - oldsize);
>> -		error = xfs_zero_range(ip, oldsize, newsize - oldsize,
>> -				&did_zeroing);
>> -	} else if (newsize != oldsize) {
>> -		error = xfs_truncate_page(ip, newsize, &did_zeroing);
>> -	}
>> -
>> -	if (error)
>> -		return error;
>> -
>> -	/*
>> -	 * We've already locked out new page faults, so now we can safely remove
>> -	 * pages from the page cache knowing they won't get refaulted until we
>> -	 * drop the XFS_MMAP_EXCL lock after the extent manipulations are
>> -	 * complete. The truncate_setsize() call also cleans partial EOF page
>> -	 * PTEs on extending truncates and hence ensures sub-page block size
>> -	 * filesystems are correctly handled, too.
>> -	 *
>> -	 * We have to do all the page cache truncate work outside the
>> +	 * And we have to do all the page cache truncate work outside the
> 
> Style nit: don't start a paragraph with "and".

Sure, thanks for point this out.

> 
>>  	 * transaction context as the "lock" order is page lock->log space
>>  	 * reservation as defined by extent allocation in the writeback path.
>>  	 * Hence a truncate can fail with ENOMEM from xfs_trans_alloc(), but
>> @@ -884,27 +862,74 @@ xfs_setattr_size(
>>  	 * user visible changes). There's not much we can do about this, except
>>  	 * to hope that the caller sees ENOMEM and retries the truncate
>>  	 * operation.
>> -	 *
>> -	 * And we update in-core i_size and truncate page cache beyond newsize
>> -	 * before writeback the [i_disk_size, newsize] range, so we're
>> -	 * guaranteed not to write stale data past the new EOF on truncate down.
>>  	 */
>> -	truncate_setsize(inode, newsize);
>> +	write_back = newsize > ip->i_disk_size && oldsize != ip->i_disk_size;
>> +	if (newsize < oldsize) {
>> +		unsigned int blocksize = i_blocksize(inode);
>>  
>> -	/*
>> -	 * We are going to log the inode size change in this transaction so
>> -	 * any previous writes that are beyond the on disk EOF and the new
>> -	 * EOF that have not been written out need to be written here.  If we
>> -	 * do not write the data out, we expose ourselves to the null files
>> -	 * problem. Note that this includes any block zeroing we did above;
>> -	 * otherwise those blocks may not be zeroed after a crash.
>> -	 */
>> -	if (did_zeroing ||
>> -	    (newsize > ip->i_disk_size && oldsize != ip->i_disk_size)) {
>> -		error = filemap_write_and_wait_range(VFS_I(ip)->i_mapping,
>> -						ip->i_disk_size, newsize - 1);
>> +		/*
>> +		 * Zeroing out the partial EOF block and the rest of the extra
>> +		 * aligned blocks on a downward truncate.
>> +		 */
>> +		error = xfs_truncate_page(ip, newsize, blocksize, &did_zeroing);
>>  		if (error)
>>  			return error;
>> +
>> +		/*
>> +		 * We are going to log the inode size change in this transaction
>> +		 * so any previous writes that are beyond the on disk EOF and
>> +		 * the new EOF that have not been written out need to be written
>> +		 * here.  If we do not write the data out, we expose ourselves
>> +		 * to the null files problem. Note that this includes any block
>> +		 * zeroing we did above; otherwise those blocks may not be
>> +		 * zeroed after a crash.
>> +		 */
>> +		if (did_zeroing || write_back) {
>> +			error = filemap_write_and_wait_range(inode->i_mapping,
>> +					min_t(loff_t, ip->i_disk_size, newsize),
>> +					roundup_64(newsize, blocksize) - 1);
>> +			if (error)
>> +				return error;
>> +		}
>> +
>> +		/*
>> +		 * Updating i_size after writing back to make sure the zeroed
> 
> "Update the incore i_size after flushing dirty tail pages to disk, and
> drop all the pagecache beyond the allocation unit containing EOF." ?

Yep.

> 
>> +		 * blocks could been written out, and drop all the page cache
>> +		 * range that beyond blocksize aligned new EOF block.
>> +		 *
>> +		 * We've already locked out new page faults, so now we can
>> +		 * safely remove pages from the page cache knowing they won't
>> +		 * get refaulted until we drop the XFS_MMAP_EXCL lock after the
>> +		 * extent manipulations are complete.
>> +		 */
>> +		i_size_write(inode, newsize);
>> +		truncate_pagecache(inode, roundup_64(newsize, blocksize));
> 
> I'm not sure why we need to preserve the pagecache beyond eof having
> zeroed and then written the post-eof blocks out to disk, but I'm
> guessing this is why you open-code truncate_setsize?

Yeah, xfs_truncate_page() already done the zero out, if we keep passing the
newsize to truncate_pagecache() through truncate_setsize(), it would zero out
partial folio which cover the already zeroed blocks. What we should do at
this moment is just drop all the page cache beyond aligned EOF block, so I
roundup the newsize, just a small optimization.

> 
>> +	} else {
>> +		/*
>> +		 * Start with zeroing any data beyond EOF that we may expose on
>> +		 * file extension.
>> +		 */
>> +		if (newsize > oldsize) {
>> +			trace_xfs_zero_eof(ip, oldsize, newsize - oldsize);
>> +			error = xfs_zero_range(ip, oldsize, newsize - oldsize,
>> +					       &did_zeroing);
>> +			if (error)
>> +				return error;
>> +		}
>> +
>> +		/*
>> +		 * The truncate_setsize() call also cleans partial EOF page
>> +		 * PTEs on extending truncates and hence ensures sub-page block
>> +		 * size filesystems are correctly handled, too.
>> +		 */
>> +		truncate_setsize(inode, newsize);
>> +
>> +		if (did_zeroing || write_back) {
>> +			error = filemap_write_and_wait_range(inode->i_mapping,
>> +					ip->i_disk_size, newsize - 1);
>> +			if (error)
>> +				return error;
>> +		}
>>  	}
> 
> At this point I wonder if these three truncate cases (down, up, and
> unchanged) should just be broken out into three helpers without so much
> twisty logic.
> 
> xfs_setattr_truncate_down():
> 	xfs_truncate_page(..., &did_zeroing);
> 
> 	if (did_zeroing || extending_ondisk_eof)
> 		filemap_write_and_wait_range(...);
> 
> 	truncate_setsize(...); /* or your opencoded version */
> 
> xfs_setattr_truncate_up():
> 	xfs_zero_range(..., &did_zeroing);
> 
> 	truncate_setsize(...);
> 
> 	if (did_zeroing || extending_ondisk_eof)
> 		filemap_write_and_wait_range(...);
> 
> xfs_setattr_truncate_unchanged():
> 	truncate_setsize(...);
> 
> 	if (extending_ondisk_eof)
> 		filemap_write_and_wait_range(...);
> 
> So then the callsite becomes:
> 
> 	if (newsize > oldsize)
> 		xfs_settattr_truncate_up();
> 	else if (newsize < oldsize)
> 		xfs_setattr_truncate_down();
> 	else
> 		xfs_setattr_truncate_unchanged();

Sounds good.

> 
> But, I dunno.  Most of the code is really just extensive commenting.
> 

Yeah, the extensive comments also bothers me, too. I will try to make
it more clear in the next iteration, I hope.

Thanks,
Yi.

> --D
> 
>> +			if (error)
>> +				return error;
>> +		}
>> +
>> +		/*
>> +		 * The truncate_setsize() call also cleans partial EOF page
>> +		 * PTEs on extending truncates and hence ensures sub-page block
>> +		 * size filesystems are correctly handled, too.
>> +		 */
>> +		truncate_setsize(inode, newsize);
>> +
>> +		if (did_zeroing || write_back) {
>> +			error = filemap_write_and_wait_range(inode->i_mapping,
>> +					ip->i_disk_size, newsize - 1);
> 
> 
> 
>>  
>>  	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0, &tp);
>> -- 
>> 2.39.2
>>
>>


