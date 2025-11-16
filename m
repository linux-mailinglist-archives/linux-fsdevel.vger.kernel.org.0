Return-Path: <linux-fsdevel+bounces-68607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 852F2C613F1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 12:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 3EACD28DA0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 11:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5742C21DC;
	Sun, 16 Nov 2025 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Khwgttj1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD2523F26A;
	Sun, 16 Nov 2025 11:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763293988; cv=none; b=cal6nnqZRuvfcVDFOGsxZUISfY/611pQX+a0BAlXl1lL4BQ+VK8EzpS6bCgudzPn5jsYr+G6lUhR1UpkEF4tlG6M7SH1D6POsag4V91bJiyUkOYg5e6YvuatfRx4n2/l+4DYX59EgH9q5dFPp+NLP8Gbo6rOaUqKpBxI0IueV3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763293988; c=relaxed/simple;
	bh=bfAdZQX2hMkFOP5j26yvMufxcR7G1GW5dZDbepO38E8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AkEWbqurZ2HdiweqVyfxXQYHMXOsV2vF9tTvo5bzNoxWb5Kq1YAD4Gv8l77YRfZ3TShvfMGWH6ZB1r2BFGRnmOeBujqo8NheAGYW6VpRF1Tt4QVGZpAhAZqjWo3/BUPsi0Fnt9dwTbXZy8GXhjCFxJCkWmb/PGpuxq5AEfMTur8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Khwgttj1; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763293982; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1ZEpqh4H+XHx/nCqMadPKeLPzQIshIyntSPO0k8Dcsc=;
	b=Khwgttj1/DrcXjymaip8CizLuAxAJgVY3JRfQa7SYgWQX30W+cEPHFHkioPG87puI1ukCduajDz3rY7QP2MjAmFSYp2NG028BOZA/G/cd0gN4YRUwd2QBRC62QE229CmnjPSYMg5U89PBKBlls8tvblu7To491ljXykIy8UcduU=
Received: from 30.170.196.81(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WsSHQRa_1763293981 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 16 Nov 2025 19:53:02 +0800
Message-ID: <f50c667a-bad6-431c-9196-235c7a519590@linux.alibaba.com>
Date: Sun, 16 Nov 2025 19:53:01 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/9] iomap: stash iomap read ctx in the private field
 of iomap_iter
To: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
 djwong@kernel.org, amir73il@gmail.com, joannelkoong@gmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20251114095516.207555-1-lihongbo22@huawei.com>
 <20251114095516.207555-2-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251114095516.207555-2-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/11/14 17:55, Hongbo Li wrote:
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
> ---
>   fs/fuse/file.c         | 4 ++--
>   fs/iomap/buffered-io.c | 6 ++++--
>   include/linux/iomap.h  | 8 ++++----
>   3 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 8275b6681b9b..98dd20f0bb53 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -973,7 +973,7 @@ static int fuse_read_folio(struct file *file, struct folio *folio)
>   		return -EIO;
>   	}
>   
> -	iomap_read_folio(&fuse_iomap_ops, &ctx);
> +	iomap_read_folio(&fuse_iomap_ops, &ctx, NULL);
>   	fuse_invalidate_atime(inode);
>   	return 0;
>   }
> @@ -1075,7 +1075,7 @@ static void fuse_readahead(struct readahead_control *rac)
>   	if (fuse_is_bad(inode))
>   		return;
>   
> -	iomap_readahead(&fuse_iomap_ops, &ctx);
> +	iomap_readahead(&fuse_iomap_ops, &ctx, NULL);
>   }
>   
>   static ssize_t fuse_cache_read_iter(struct kiocb *iocb, struct iov_iter *to)
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 6ae031ac8058..8e79303c074e 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -496,13 +496,14 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
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
>   	size_t bytes_pending = 0;
>   	int ret;
> @@ -560,13 +561,14 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
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
>   	size_t cur_bytes_pending;
>   
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 8b1ac08c7474..c3ecbbdb14e8 100644
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
> @@ -594,7 +594,7 @@ static inline void iomap_bio_read_folio(struct folio *folio,
>   		.cur_folio	= folio,
>   	};
>   
> -	iomap_read_folio(ops, &ctx);
> +	iomap_read_folio(ops, &ctx, NULL);
>   }
>   
>   static inline void iomap_bio_readahead(struct readahead_control *rac,
> @@ -605,7 +605,7 @@ static inline void iomap_bio_readahead(struct readahead_control *rac,
>   		.rac		= rac,
>   	};
>   
> -	iomap_readahead(ops, &ctx);
> +	iomap_readahead(ops, &ctx, NULL);
>   }
>   #endif /* CONFIG_BLOCK */
>   


