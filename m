Return-Path: <linux-fsdevel+bounces-72998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE33BD07512
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 07:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BBC3302BA7C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 06:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA2E29A9E9;
	Fri,  9 Jan 2026 06:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="E9po9ShY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF4E27FB32;
	Fri,  9 Jan 2026 06:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767938620; cv=none; b=SJNBCER0xA1tCc285kS5kwhfPF4XyB3cr1wYw01obCfIoHaaJLLPm+tkkxQw+9DmL/gftQZn0BmP9DqkvDAMRTCiu7blFjix3ldWkvw9lM3RT/CmRFa2uiQS7MPaX6D6QB6ZGfALfvJRWok76nLJpnSCc5wIcPI6QeA3Cmm9+mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767938620; c=relaxed/simple;
	bh=grGHqgFpfqMI3N2TJSrH8NfYKVEdLw29nJluqMQc7Ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UG+jsuRkT4cYW28Ey3k+J7XZaWhTg7Zy2u9b/ji+7zdsswhIOgp6ZymXHebVc49GwgvYSr0WgL+f5UtP/tOkISvBxgnNaXzGWv9v50DAgJMYjkjo7veqyHh0ghJwp9LWI3qUe7FTb329WwVdIS0bRwRMTdC3DJrEGusix1uPBPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=E9po9ShY; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767938609; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WSn8tUN5ji0ImOXN+znur1HXqv1SL9DZ3ghCylvKI/M=;
	b=E9po9ShYHg/Z3Zepkhl36gbtOA5nqX8HHJQAqSSj/JRQnEH2sQ6pQ6ShULNRHd1iSw62387yUFxAROey4IF49RZjnluuhEiVZePLU9vpoeg+tr+FhalcJfmfrOsIVFtw+scRdFBxAlYHhuu+R6bmD+foS22ETh1rdPfIwZWow8U=
Received: from 30.221.131.232(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wwf8qgt_1767938608 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 09 Jan 2026 14:03:29 +0800
Message-ID: <d1d84c90-9bca-4f14-a635-6199ce84df48@linux.alibaba.com>
Date: Fri, 9 Jan 2026 14:03:28 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 01/10] iomap: stash iomap read ctx in the private
 field of iomap_iter
To: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
 Christian Brauner <brauner@kernel.org>
Cc: amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Chao Yu <chao@kernel.org>, Hongbo Li <lihongbo22@huawei.com>
References: <20260109030140.594936-1-lihongbo22@huawei.com>
 <20260109030140.594936-2-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260109030140.594936-2-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christoph, Darrick, Christian,

On 2026/1/9 11:01, Hongbo Li wrote:
> It's useful to get filesystem-specific information using the
> existing private field in the @iomap_iter passed to iomap_{begin,end}
> for advanced usage for iomap buffered reads, which is much like the
> current iomap DIO.
> 
> For example, EROFS needs it to:
> 
>   - implement an efficient page cache sharing feature, since iomap
>     needs to apply to anon inode page cache but we'd like to get the
>     backing inode/fs instead, so filesystem-specific private data is
>     needed to keep such information;
> 
>   - pass in both struct page * and void * for inline data to avoid
>     kmap_to_page() usage (which is bogus).
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Could you help review or ack this patch?

This feature is almost in shape for the upcoming cycle,
I do hope this iomap patch could be reviewed, thanks!

Thanks,
Gao Xiang

> ---
>   fs/fuse/file.c         | 4 ++--
>   fs/iomap/buffered-io.c | 6 ++++--
>   include/linux/iomap.h  | 8 ++++----
>   3 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 01bc894e9c2b..f5d8887c1922 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -979,7 +979,7 @@ static int fuse_read_folio(struct file *file, struct folio *folio)
>   		return -EIO;
>   	}
>   
> -	iomap_read_folio(&fuse_iomap_ops, &ctx);
> +	iomap_read_folio(&fuse_iomap_ops, &ctx, NULL);
>   	fuse_invalidate_atime(inode);
>   	return 0;
>   }
> @@ -1081,7 +1081,7 @@ static void fuse_readahead(struct readahead_control *rac)
>   	if (fuse_is_bad(inode))
>   		return;
>   
> -	iomap_readahead(&fuse_iomap_ops, &ctx);
> +	iomap_readahead(&fuse_iomap_ops, &ctx, NULL);
>   }
>   
>   static ssize_t fuse_cache_read_iter(struct kiocb *iocb, struct iov_iter *to)
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index e5c1ca440d93..5f7dcbabbda3 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -555,13 +555,14 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
>   }
>   
>   void iomap_read_folio(const struct iomap_ops *ops,
> -		struct iomap_read_folio_ctx *ctx)
> +		struct iomap_read_folio_ctx *ctx, void *private)
>   {
>   	struct folio *folio = ctx->cur_folio;
>   	struct iomap_iter iter = {
>   		.inode		= folio->mapping->host,
>   		.pos		= folio_pos(folio),
>   		.len		= folio_size(folio),
> +		.private	= private,
>   	};
>   	size_t bytes_submitted = 0;
>   	int ret;
> @@ -620,13 +621,14 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
>    * the filesystem to be reentered.
>    */
>   void iomap_readahead(const struct iomap_ops *ops,
> -		struct iomap_read_folio_ctx *ctx)
> +		struct iomap_read_folio_ctx *ctx, void *private)
>   {
>   	struct readahead_control *rac = ctx->rac;
>   	struct iomap_iter iter = {
>   		.inode	= rac->mapping->host,
>   		.pos	= readahead_pos(rac),
>   		.len	= readahead_length(rac),
> +		.private = private,
>   	};
>   	size_t cur_bytes_submitted;
>   
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 520e967cb501..441d614e9fdf 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -341,9 +341,9 @@ ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
>   		const struct iomap_ops *ops,
>   		const struct iomap_write_ops *write_ops, void *private);
>   void iomap_read_folio(const struct iomap_ops *ops,
> -		struct iomap_read_folio_ctx *ctx);
> +		struct iomap_read_folio_ctx *ctx, void *private);
>   void iomap_readahead(const struct iomap_ops *ops,
> -		struct iomap_read_folio_ctx *ctx);
> +		struct iomap_read_folio_ctx *ctx, void *private);
>   bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
>   struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len);
>   bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
> @@ -595,7 +595,7 @@ static inline void iomap_bio_read_folio(struct folio *folio,
>   		.cur_folio	= folio,
>   	};
>   
> -	iomap_read_folio(ops, &ctx);
> +	iomap_read_folio(ops, &ctx, NULL);
>   }
>   
>   static inline void iomap_bio_readahead(struct readahead_control *rac,
> @@ -606,7 +606,7 @@ static inline void iomap_bio_readahead(struct readahead_control *rac,
>   		.rac		= rac,
>   	};
>   
> -	iomap_readahead(ops, &ctx);
> +	iomap_readahead(ops, &ctx, NULL);
>   }
>   #endif /* CONFIG_BLOCK */
>   


