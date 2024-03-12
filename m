Return-Path: <linux-fsdevel+bounces-14207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6808794B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 13:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809541C21B35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 12:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1094E79DD0;
	Tue, 12 Mar 2024 12:59:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9323A1F95F;
	Tue, 12 Mar 2024 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710248365; cv=none; b=CpdQuV/rB5ScEej3EKT6R0/EXO/vtUeA5NSDqf7/Eksmm3wdJ591oe4jA/kMw6Cm1kEYvDIqhD7Cel/1ld4Fe8Tgl28PeRhJ/vmyCVUnNmWoGftLoby7GPJrCDqeI9xvlV/JdXWNJr7d+S4yOiCWqg0ixXuZzNz8HUvs3pe2rHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710248365; c=relaxed/simple;
	bh=7tSnGJBsA/vNSf47BJiztKMZrl6p5LWxW1fFH8nv4jQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=m0maPNgBDl0XW1uCO6WH/TGHlMQ8IFbf1TjqHBJiPnLf0yYMd41dBymwBWHk2m/XGs0re/hxFhXS0rOLLnVuXeWjHT3isN8dIZdtwaLK3yRWnBrfQeUvL02NLBUpb7cXT3SQvEy9IBgeymPWZZDy3TKbmi5mjDY2a7Q4Iyh5dJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TvDHL2ypGz4f3lfX;
	Tue, 12 Mar 2024 20:59:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1B4BC1A0199;
	Tue, 12 Mar 2024 20:59:18 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBGjUfBlZsnnGg--.25952S3;
	Tue, 12 Mar 2024 20:59:17 +0800 (CST)
Subject: Re: [PATCH 3/4] iomap: don't increase i_size if it's not a write
 operation
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
 david@fromorbit.com, tytso@mit.edu, jack@suse.cz, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240311122255.2637311-1-yi.zhang@huaweicloud.com>
 <20240311122255.2637311-4-yi.zhang@huaweicloud.com>
 <20240311154829.GU1927156@frogsfrogsfrogs>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <4a9e607e-36d1-4ea7-1754-c443906b3a1c@huaweicloud.com>
Date: Tue, 12 Mar 2024 20:59:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240311154829.GU1927156@frogsfrogsfrogs>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBXKBGjUfBlZsnnGg--.25952S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtFy7KF1kCr4xAr48WFWkXrb_yoW7Cr4fpr
	98KayDCF4ktF47Wr1DJF98Xr1Yy34rKrW7Cry7Gay3ZF1qyr4xKF18Wa4F9F1UJ3sxAr4f
	XF4vy3s5WF15Ar7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
	1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/3/11 23:48, Darrick J. Wong wrote:
> On Mon, Mar 11, 2024 at 08:22:54PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Increase i_size in iomap_zero_range() and iomap_unshare_iter() is not
>> needed, the caller should handle it. Especially, when truncate partial
>> block, we could not increase i_size beyond the new EOF here. It doesn't
>> affect xfs and gfs2 now because they set the new file size after zero
>> out, it doesn't matter that a transient increase in i_size, but it will
>> affect ext4 because it set file size before truncate.
> 
>>                                                       At the same time,
>> iomap_write_failed() is also not needed for above two cases too, so
>> factor them out and move them to iomap_write_iter() and
>> iomap_zero_iter().
> 
> This change should be a separate patch with its own justification.
> Which is, AFAICT, something along the lines of:
> 
> "Unsharing and zeroing can only happen within EOF, so there is never a
> need to perform posteof pagecache truncation if write begin fails."

Sure.

> 
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Doesn't this patch fix a bug in ext4?

Yeah, the same as Christoph answered.

> 
>> ---
>>  fs/iomap/buffered-io.c | 59 +++++++++++++++++++++---------------------
>>  1 file changed, 30 insertions(+), 29 deletions(-)
>>
>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> index 093c4515b22a..19f91324c690 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
>> @@ -786,7 +786,6 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
>>  
>>  out_unlock:
>>  	__iomap_put_folio(iter, pos, 0, folio);
>> -	iomap_write_failed(iter->inode, pos, len);
>>  
>>  	return status;
>>  }
>> @@ -838,34 +837,13 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
>>  		size_t copied, struct folio *folio)
>>  {
>>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>> -	loff_t old_size = iter->inode->i_size;
>> -	size_t ret;
>> -
>> -	if (srcmap->type == IOMAP_INLINE) {
>> -		ret = iomap_write_end_inline(iter, folio, pos, copied);
>> -	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
>> -		ret = block_write_end(NULL, iter->inode->i_mapping, pos, len,
>> -				copied, &folio->page, NULL);
>> -	} else {
>> -		ret = __iomap_write_end(iter->inode, pos, len, copied, folio);
>> -	}
>>  
>> -	/*
>> -	 * Update the in-memory inode size after copying the data into the page
>> -	 * cache.  It's up to the file system to write the updated size to disk,
>> -	 * preferably after I/O completion so that no stale data is exposed.
>> -	 */
>> -	if (pos + ret > old_size) {
>> -		i_size_write(iter->inode, pos + ret);
>> -		iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
>> -	}
>> -	__iomap_put_folio(iter, pos, ret, folio);
>> -
>> -	if (old_size < pos)
>> -		pagecache_isize_extended(iter->inode, old_size, pos);
>> -	if (ret < len)
>> -		iomap_write_failed(iter->inode, pos + ret, len - ret);
>> -	return ret;
>> +	if (srcmap->type == IOMAP_INLINE)
>> +		return iomap_write_end_inline(iter, folio, pos, copied);
>> +	if (srcmap->flags & IOMAP_F_BUFFER_HEAD)
>> +		return block_write_end(NULL, iter->inode->i_mapping, pos, len,
>> +				       copied, &folio->page, NULL);
>> +	return __iomap_write_end(iter->inode, pos, len, copied, folio);
>>  }
>>  
>>  static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>> @@ -880,6 +858,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>>  
>>  	do {
>>  		struct folio *folio;
>> +		loff_t old_size;
>>  		size_t offset;		/* Offset into folio */
>>  		size_t bytes;		/* Bytes to write to folio */
>>  		size_t copied;		/* Bytes copied from user */
>> @@ -912,8 +891,10 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>>  		}
>>  
>>  		status = iomap_write_begin(iter, pos, bytes, &folio);
>> -		if (unlikely(status))
>> +		if (unlikely(status)) {
>> +			iomap_write_failed(iter->inode, pos, bytes);
>>  			break;
>> +		}
>>  		if (iter->iomap.flags & IOMAP_F_STALE)
>>  			break;
>>  
>> @@ -927,6 +908,24 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>>  		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
>>  		status = iomap_write_end(iter, pos, bytes, copied, folio);
>>  
>> +		/*
>> +		 * Update the in-memory inode size after copying the data into
>> +		 * the page cache.  It's up to the file system to write the
>> +		 * updated size to disk, preferably after I/O completion so that
>> +		 * no stale data is exposed.
>> +		 */
>> +		old_size = iter->inode->i_size;
>> +		if (pos + status > old_size) {
>> +			i_size_write(iter->inode, pos + status);
>> +			iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
>> +		}
>> +		__iomap_put_folio(iter, pos, status, folio);
> 
> Why is it necessary to hoist the __iomap_put_folio calls from
> iomap_write_end into iomap_write_iter, iomap_unshare_iter, and
> iomap_zero_iter?  None of those functions seem to use it, and it makes
> more sense to me that iomap_write_end releases the folio that
> iomap_write_begin returned.
> 

Because we have to update i_size before __iomap_put_folio() in
iomap_write_iter(). If not, once we unlock folio, it could be raced
by the backgroud write back which could start writing back and call
folio_zero_segment() (please see iomap_writepage_handle_eof()) to
zero out the valid data beyond the not updated i_size. So we
have to move out __iomap_put_folio() out together with the i_size
updating.

Thanks,
Yi.


