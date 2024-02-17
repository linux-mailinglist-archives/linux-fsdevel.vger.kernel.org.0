Return-Path: <linux-fsdevel+bounces-11909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55509858E4A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 10:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C43821F21F2E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 09:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000941D53C;
	Sat, 17 Feb 2024 09:14:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007511CFA8;
	Sat, 17 Feb 2024 09:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708161285; cv=none; b=oSQBApvlLaPUsxCkdsomDhce0QbqRSwEN9X18RnCW3mxEiuBTKWcj5LqnhMT0+ZOcbO752u2Q631gq3kC3hYrebLst3kAxpSkzvtk+8j/F1zkKwxxgQuhjDUxL/R3Yg4teN8r7DqwwEyLPB5FalKh6BeM8WY1JTGbXUCGBZ6m0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708161285; c=relaxed/simple;
	bh=1hnntFnpL+B0bxwjndXaJRsgWy/yqq6rJPou9nkkkT8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TypI47SLhxH3rSi+RncWAsVn8+vNwEYbidaWXH32eAE8eitpMMys0wc+m+Eb8p9YuwFZyeMalERQ0fG7u2rLMPXFwSTUCnfXIRn0by2luQF76VCyAKYX+m2ABFn+s3B9Hdztb10CvYxUGv9JmaKTZsgHO+WqISJ/gQcHb0OScQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TcN1c56fMz4f3jHj;
	Sat, 17 Feb 2024 16:55:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 855A61A09F9;
	Sat, 17 Feb 2024 16:55:53 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ6XdNBl_ygdEQ--.60286S3;
	Sat, 17 Feb 2024 16:55:53 +0800 (CST)
Subject: Re: [RFC PATCH v3 07/26] iomap: don't increase i_size if it's not a
 write operation
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
 djwong@kernel.org, willy@infradead.org, zokeefe@google.com,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
 wangkefeng.wang@huawei.com
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
 <20240127015825.1608160-8-yi.zhang@huaweicloud.com>
 <ZcsCP4h-ExNOcdD6@infradead.org>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <74ab3c3e-3daf-5374-75e5-bcb25ffdb527@huaweicloud.com>
Date: Sat, 17 Feb 2024 16:55:51 +0800
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
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBHZQ6XdNBl_ygdEQ--.60286S3
X-Coremail-Antispam: 1UD129KBjvJXoWxur4UGw45Cw47Gr4xtr48tFb_yoWruw1rpr
	yq93yDCFs3tF17Wr1kJFZ8XryYka4rKrW2kryxGw43ZFnIyr9rKF1rGa4Yv3Z8J3sxAr4f
	JF4kAa4kWF1UAr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU13rcDUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/2/13 13:46, Christoph Hellwig wrote:
> Wouldn't it make more sense to just move the size manipulation to the
> write-only code?  An untested version of that is below.  With this

Sorry for the late reply and thanks for your suggestion, The reason why
I introduced this new helper iomap_write_end_simple() is I don't want to
open code __iomap_put_folio() in each caller since corresponding to
iomap_write_begin(), it's the responsibility for iomap_write_end_*() to
put and unlock folio, so I'd like to keep it in iomap_write_end_*().
But I don't feel strongly about it, it's also fine by me to just move
the size manipulation to the write-only code if you think it's better.

> the naming of the status variable becomes even more confusing than
> it already is, maybe we need to do a cleanup of the *_write_end
> calling conventions as it always returns the passed in copied value
> or 0.

Indeed, it becomes more confused and deserve a cleanup.

Thanks,
Yi.

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
> -	__iomap_put_folio(iter, pos, ret, folio);
>  
> -	if (old_size < pos)
> -		pagecache_isize_extended(iter->inode, old_size, pos);
> -	if (ret < len)
> -		iomap_write_failed(iter->inode, pos + ret, len - ret);
> -	return ret;
> +	if (srcmap->type == IOMAP_INLINE)
> +		return iomap_write_end_inline(iter, folio, pos, copied);
> +	if (srcmap->flags & IOMAP_F_BUFFER_HEAD)
> +		return block_write_end(NULL, iter->inode->i_mapping, pos, len,
> +					copied, &folio->page, NULL);
> +	return __iomap_write_end(iter->inode, pos, len, copied, folio);
>  }
>  
>  static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
> @@ -918,6 +897,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  
>  	do {
>  		struct folio *folio;
> +		loff_t old_size;
>  		size_t offset;		/* Offset into folio */
>  		size_t bytes;		/* Bytes to write to folio */
>  		size_t copied;		/* Bytes copied from user */
> @@ -964,7 +944,24 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  
>  		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
>  		status = iomap_write_end(iter, pos, bytes, copied, folio);
> +		/*
> +		 * Update the in-memory inode size after copying the data into
> +		 * the page cache.  It's up to the file system to write the
> +		 * updated size to disk, preferably after I/O completion so that
> +		 * no stale data is exposed.
> +		 */
> +		old_size = iter->inode->i_size;
> +		if (pos + status > old_size) {
> +			i_size_write(iter->inode, pos + status);
> +			iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
> +		}
> +		__iomap_put_folio(iter, pos, status, folio);
>  
> +		if (old_size < pos)
> +			pagecache_isize_extended(iter->inode, old_size, pos);
> +		if (status < bytes)
> +			iomap_write_failed(iter->inode, pos + status,
> +						bytes - status);
>  		if (unlikely(copied != status))
>  			iov_iter_revert(i, copied - status);
>  
> @@ -1334,6 +1331,7 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
>  			bytes = folio_size(folio) - offset;
>  
>  		bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
> +		__iomap_put_folio(iter, pos, bytes, folio);
>  		if (WARN_ON_ONCE(bytes == 0))
>  			return -EIO;
>  
> @@ -1398,6 +1396,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  		folio_mark_accessed(folio);
>  
>  		bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
> +		__iomap_put_folio(iter, pos, bytes, folio);
>  		if (WARN_ON_ONCE(bytes == 0))
>  			return -EIO;
>  
> 


