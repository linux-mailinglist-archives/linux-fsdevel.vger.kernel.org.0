Return-Path: <linux-fsdevel+bounces-13055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3E686AA79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 09:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7A4C1F2419A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 08:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD84C2D622;
	Wed, 28 Feb 2024 08:53:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A97C2D604;
	Wed, 28 Feb 2024 08:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110421; cv=none; b=KWG7I93jmhcbzz52vPSmRZ/pASas2GLaKaC6XbsVgZqa4TVIx0YCZfVt2OM4+QnPY0PYAPv/ZvfBw42Q1nj5jTfUzYsusBNUmN3+B9OnUTjpVOzfd2OKfZd7t36ihsKl5UweKAOYF8Huk02Mfh3atPM+6uaV76OR4Tu0/9WlJaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110421; c=relaxed/simple;
	bh=LmMn4l1GClZilnMTAowDg6HVHEvvOnMdx2YPGsYQJJE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dPUJ4hSltk7sFEhkgCSuV6FJQi9ZQkNurciFwsbIDDG0wgQE4pzkKvSsjOIDCyasxzdnitlT/5BSk9R2BH9AabdlGKY9+F2MjazCNA5pYfwLMhVDW/wibwnQDBw5P9+UzS/QbRzWLdc0pmH8N1d5fkwn3N3evS92YkjtFwg+dvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tl7Rv0pkKz4f3kKQ;
	Wed, 28 Feb 2024 16:53:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 722071A0172;
	Wed, 28 Feb 2024 16:53:34 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RGM9N5lUE2aFQ--.30440S3;
	Wed, 28 Feb 2024 16:53:34 +0800 (CST)
Subject: Re: [RFC PATCH v3 07/26] iomap: don't increase i_size if it's not a
 write operation
To: Christoph Hellwig <hch@infradead.org>, djwong@kernel.org,
 Dave Chinner <david@fromorbit.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
 ritesh.list@gmail.com, willy@infradead.org, zokeefe@google.com,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
 wangkefeng.wang@huawei.com
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
 <20240127015825.1608160-8-yi.zhang@huaweicloud.com>
 <ZcsCP4h-ExNOcdD6@infradead.org>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <9b0040ef-3d9d-6246-4bdd-82b9a8f55fa2@huaweicloud.com>
Date: Wed, 28 Feb 2024 16:53:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZcsCP4h-ExNOcdD6@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+RGM9N5lUE2aFQ--.30440S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AF4fXry7uF47AFy5Zw13urg_yoW7GF4rpF
	909F4jkan7t3yfWr1kZFs5Xry0vwsaqF4UCry7KrW3Z3Z8JFyIgF17uFWYkFWUXr9xAr1a
	qF4vva4fuF1UCFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 2024/2/13 13:46, Christoph Hellwig wrote:
> Wouldn't it make more sense to just move the size manipulation to the
> write-only code?  An untested version of that is below.  With this
> the naming of the status variable becomes even more confusing than
> it already is, maybe we need to do a cleanup of the *_write_end
> calling conventions as it always returns the passed in copied value
> or 0.
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 3dab060aed6d7b..8401a9ca702fc0 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -876,34 +876,13 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
>  		size_t copied, struct folio *folio)
>  {
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> -	loff_t old_size = iter->inode->i_size;
> -	size_t ret;
> -
> -	if (srcmap->type == IOMAP_INLINE) {
> -		ret = iomap_write_end_inline(iter, folio, pos, copied);
> -	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
> -		ret = block_write_end(NULL, iter->inode->i_mapping, pos, len,
> -				copied, &folio->page, NULL);
> -	} else {
> -		ret = __iomap_write_end(iter->inode, pos, len, copied, folio);
> -	}
> -
> -	/*
> -	 * Update the in-memory inode size after copying the data into the page
> -	 * cache.  It's up to the file system to write the updated size to disk,
> -	 * preferably after I/O completion so that no stale data is exposed.
> -	 */
> -	if (pos + ret > old_size) {
> -		i_size_write(iter->inode, pos + ret);
> -		iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
> -	}

I've recently discovered that if we don't increase i_size in
iomap_zero_iter(), it would break fstests generic/476 on xfs. xfs
depends on iomap_zero_iter() to increase i_size in some cases.

 generic/476 75s ... _check_xfs_filesystem: filesystem on /dev/pmem2 is inconsistent (r)
 (see /home/zhangyi/xfstests-dev/results//xfs/generic/476.full for details)

 _check_xfs_filesystem: filesystem on /dev/pmem2 is inconsistent (r)
 *** xfs_repair -n output ***
 Phase 1 - find and verify superblock...
 Phase 2 - using internal log
         - zero log...
         - scan filesystem freespace and inode maps...
 sb_fdblocks 10916, counted 10923
         - found root inode chunk
 ...

After debugging and analysis, I found the root cause of the problem is
related to the pre-allocations of xfs. xfs pre-allocates some blocks to
reduce fragmentation during buffer append writing, then if we write new
data or do file copy(reflink) after the end of the pre-allocating range,
xfs would zero-out and write back the pre-allocate space(e.g.
xfs_file_write_checks() -> xfs_zero_range()), so we have to update
i_size before writing back in iomap_zero_iter(), otherwise, it will
result in stale delayed extent.

For more details, let's think about this case,
1. Buffered write from range [A, B) of an empty file foo, and
   xfs_buffered_write_iomap_begin() prealloc blocks for it, then create
   a delayed extent from [A, D).
2. Write back process map blocks but only convert above delayed extent
   from [A, C) since the lack of a contiguous physical blocks, now we
   have a left over delayed extent from [C, D), and the file size is B.
3. Copy range from another file to range [E, F), then
   xfs_reflink_zero_posteof() would zero-out post eof range [B, E), it
   writes zero, dirty and write back [C, E).
4. Since we don't update i_size in iomap_zero_iter()，the writeback
   doesn't write anything back, also doesn't convert the delayed extent.
   After copy range, the file size will update to F.
5. Finally, the delayed extent becomes stale, and the free blocks count
   becomes incorrect.

So, we have to handle above case for xfs. I suppose we could keep
increasing i_size if the zeroed folio is entirely outside of i_size,
make sure we could write back and allocate blocks for the
zeroed & delayed extent, something like below, any suggestions ?


@@ -1390,6 +1390,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)

 	do {
 		struct folio *folio;
+		loff_t old_size;
 		int status;
 		size_t offset;
 		size_t bytes = min_t(u64, SIZE_MAX, length);
@@ -1408,6 +1409,28 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		folio_mark_accessed(folio);

 		bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
+
+		/*
+		 * If folio is entirely outside of i_size, update the
+		 * in-memory inode size after zeroing the data in the page
+		 * cache to prevent the write-back process from not writing
+		 * back zeroed pages.
+		 */
+		old_size = iter->inode->i_size;
+		if (pos + bytes > old_size) {
+			size_t offset = offset_in_folio(folio, old_size);
+			pgoff_t end_index = old_size >> PAGE_SHIFT;
+
+			if (folio->index > end_index ||
+			    (folio->index == end_index && offset == 0)) {
+				i_size_write(iter->inode, pos + bytes);
+				iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
+			}
+		}
+		__iomap_put_folio(iter, pos, bytes, folio);
+		if (old_size < pos)
+			pagecache_isize_extended(iter->inode, old_size, pos);
+
 		if (WARN_ON_ONCE(bytes == 0))
 			return -EIO;

Thansk,
Yi.


