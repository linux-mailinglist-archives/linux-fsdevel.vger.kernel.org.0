Return-Path: <linux-fsdevel+bounces-35069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FE49D0B24
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 09:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DED25B22AF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 08:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF3118C939;
	Mon, 18 Nov 2024 08:42:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA9213D28F;
	Mon, 18 Nov 2024 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731919356; cv=none; b=h1n+XOMfQret5U+3iH/QmRW9iLnttlGCB4LsjmZu3tDlB0fP+RCtjQZJKoUDDE9eff/OBJRxrDgus4C6jMfAVjHvwcKC/rWwkghBdqf/40/ioXEPuk8vw4bOEwHxjpL2/A7Yz3VeKB9+MgpuqVUTfoB31LuG481+BFHav4h0r4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731919356; c=relaxed/simple;
	bh=NJk4dTR0bI8XvHZ5QN8n8S1bH0X2uE6U3zNWG86A7bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=azyZiMbmw9NhVYopNje8OeB2nlMBE4JWHkzY3VSioNL5Pp1ESXy8RZSHQC2u5+Gk63Rks6A5Oc3elhYnF7SJWkEsowW6RFIuGBhaH4PIlBylYeBQkRz9abveIoWhCC/Z8denYM95vd/6UW2aHESkz107aQh81OBDlJIOpBrezsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XsLg00LDrz1T4sT;
	Mon, 18 Nov 2024 16:40:28 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id E1E54140138;
	Mon, 18 Nov 2024 16:42:24 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 18 Nov
 2024 16:42:23 +0800
Message-ID: <01fadf73-6b0f-44ff-9325-515fae37d968@huawei.com>
Date: Mon, 18 Nov 2024 16:42:23 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/17] mm/filemap: make buffered writes work with
 RWF_UNCACHED
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<hannes@cmpxchg.org>, <clm@meta.com>, <linux-kernel@vger.kernel.org>,
	<willy@infradead.org>, <kirill@shutemov.name>, <linux-btrfs@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<bfoster@redhat.com>, Yang Erkun <yangerkun@huawei.com>
References: <20241114152743.2381672-2-axboe@kernel.dk>
 <20241114152743.2381672-12-axboe@kernel.dk>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20241114152743.2381672-12-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2024/11/14 23:25, Jens Axboe wrote:
> If RWF_UNCACHED is set for a write, mark new folios being written with
> uncached. This is done by passing in the fact that it's an uncached write
> through the folio pointer. We can only get there when IOCB_UNCACHED was
> allowed, which can only happen if the file system opts in. Opting in means
> they need to check for the LSB in the folio pointer to know if it's an
> uncached write or not. If it is, then FGP_UNCACHED should be used if
> creating new folios is necessary.
>
> Uncached writes will drop any folios they create upon writeback
> completion, but leave folios that may exist in that range alone. Since
> ->write_begin() doesn't currently take any flags, and to avoid needing
> to change the callback kernel wide, use the foliop being passed in to
> ->write_begin() to signal if this is an uncached write or not. File
> systems can then use that to mark newly created folios as uncached.
>
> This provides similar benefits to using RWF_UNCACHED with reads. Testing
> buffered writes on 32 files:
>
> writing bs 65536, uncached 0
>    1s: 196035MB/sec
>    2s: 132308MB/sec
>    3s: 132438MB/sec
>    4s: 116528MB/sec
>    5s: 103898MB/sec
>    6s: 108893MB/sec
>    7s: 99678MB/sec
>    8s: 106545MB/sec
>    9s: 106826MB/sec
>   10s: 101544MB/sec
>   11s: 111044MB/sec
>   12s: 124257MB/sec
>   13s: 116031MB/sec
>   14s: 114540MB/sec
>   15s: 115011MB/sec
>   16s: 115260MB/sec
>   17s: 116068MB/sec
>   18s: 116096MB/sec
>
> where it's quite obvious where the page cache filled, and performance
> dropped from to about half of where it started, settling in at around
> 115GB/sec. Meanwhile, 32 kswapds were running full steam trying to
> reclaim pages.
>
> Running the same test with uncached buffered writes:
>
> writing bs 65536, uncached 1
>    1s: 198974MB/sec
>    2s: 189618MB/sec
>    3s: 193601MB/sec
>    4s: 188582MB/sec
>    5s: 193487MB/sec
>    6s: 188341MB/sec
>    7s: 194325MB/sec
>    8s: 188114MB/sec
>    9s: 192740MB/sec
>   10s: 189206MB/sec
>   11s: 193442MB/sec
>   12s: 189659MB/sec
>   13s: 191732MB/sec
>   14s: 190701MB/sec
>   15s: 191789MB/sec
>   16s: 191259MB/sec
>   17s: 190613MB/sec
>   18s: 191951MB/sec
>
> and the behavior is fully predictable, performing the same throughout
> even after the page cache would otherwise have fully filled with dirty
> data. It's also about 65% faster, and using half the CPU of the system
> compared to the normal buffered write.
>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   include/linux/fs.h      |  5 +++++
>   include/linux/pagemap.h |  9 +++++++++
>   mm/filemap.c            | 12 +++++++++++-
>   3 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 45510d0b8de0..122ae821989f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2877,6 +2877,11 @@ static inline ssize_t generic_write_sync(struct kiocb *iocb, ssize_t count)
>   				(iocb->ki_flags & IOCB_SYNC) ? 0 : 1);
>   		if (ret)
>   			return ret;
> +	} else if (iocb->ki_flags & IOCB_UNCACHED) {
> +		struct address_space *mapping = iocb->ki_filp->f_mapping;
> +
> +		filemap_fdatawrite_range_kick(mapping, iocb->ki_pos,
> +					      iocb->ki_pos + count);
>   	}
>   

Hi Jens,

The filemap_fdatawrite_range_kick() helper function is not added until
the next patch, so you should swap the order of patch 10 and patch 11.

Regards,
Baokun

>   	return count;
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index d55bf995bd9e..cc02518d338d 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -14,6 +14,7 @@
>   #include <linux/gfp.h>
>   #include <linux/bitops.h>
>   #include <linux/hardirq.h> /* for in_interrupt() */
> +#include <linux/writeback.h>
>   #include <linux/hugetlb_inline.h>
>   
>   struct folio_batch;
> @@ -70,6 +71,14 @@ static inline int filemap_write_and_wait(struct address_space *mapping)
>   	return filemap_write_and_wait_range(mapping, 0, LLONG_MAX);
>   }
>   
> +/*
> + * Value passed in to ->write_begin() if IOCB_UNCACHED is set for the write,
> + * and the ->write_begin() handler on a file system supporting FOP_UNCACHED
> + * must check for this and pass FGP_UNCACHED for folio creation.
> + */
> +#define foliop_uncached			((struct folio *) 0xfee1c001)
> +#define foliop_is_uncached(foliop)	(*(foliop) == foliop_uncached)
> +
>   /**
>    * filemap_set_wb_err - set a writeback error on an address_space
>    * @mapping: mapping in which to set writeback error
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 13815194ed8a..297cb53332ff 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -4076,7 +4076,7 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
>   	ssize_t written = 0;
>   
>   	do {
> -		struct folio *folio;
> +		struct folio *folio = NULL;
>   		size_t offset;		/* Offset into folio */
>   		size_t bytes;		/* Bytes to write to folio */
>   		size_t copied;		/* Bytes copied from user */
> @@ -4104,6 +4104,16 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
>   			break;
>   		}
>   
> +		/*
> +		 * If IOCB_UNCACHED is set here, we now the file system
> +		 * supports it. And hence it'll know to check folip for being
> +		 * set to this magic value. If so, it's an uncached write.
> +		 * Whenever ->write_begin() changes prototypes again, this
> +		 * can go away and just pass iocb or iocb flags.
> +		 */
> +		if (iocb->ki_flags & IOCB_UNCACHED)
> +			folio = foliop_uncached;
> +
>   		status = a_ops->write_begin(file, mapping, pos, bytes,
>   						&folio, &fsdata);
>   		if (unlikely(status < 0))



