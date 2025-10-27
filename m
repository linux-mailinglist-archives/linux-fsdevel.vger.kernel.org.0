Return-Path: <linux-fsdevel+bounces-65731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DCBC0F367
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 17:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A0C94F7ECE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 16:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A43F3115A2;
	Mon, 27 Oct 2025 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+i1bPcQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEAF3019A3;
	Mon, 27 Oct 2025 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581547; cv=none; b=IYHGXHwPU9MuQDfvEbBMmnJZIPZHcrd3+8f4YJRSe9ff5uWCI3+enWLMGaG6o1XVVgIqFDudJK0Ol6P0eF8wzdhno4BMOnF9ZqCBq+p1Apzb8n8jOJk5A4KC565A8p+qgF217SBYlUMKCC6fd8zNaKgAw0CWY56OiKjdwv4+jyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581547; c=relaxed/simple;
	bh=OT4dULXaWTFB1oGvlfq4J69c17KE+KMzhBNENI9G6VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2Z1vx8qNBjY/tmybVhkEWQCJzVuoU+a1JkE2uzoHMdlWGcK7KLYYprXv7grMWuml3soZZpQf3eCeE78dYEJXpVQsrOVcqJgH0vBstX9CtwdvpvpVUpTyISt9okZRqxzU2f5CXpT8vr0HJG6R5D0Ig8YdXhCAVKs1A/Rv/yP7ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+i1bPcQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE320C4CEF1;
	Mon, 27 Oct 2025 16:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761581547;
	bh=OT4dULXaWTFB1oGvlfq4J69c17KE+KMzhBNENI9G6VQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E+i1bPcQTPjNdfQW3DyMNiYbIxG/Vfw82bJWRkH8OAhQyViy5D9QYVyw7GikL+bC1
	 WetrbcORvXpxVZNphk+pXVuDj2tGDAjLGnqSzjPWU7bXOdbwMYA4fb/mB0H8UkqOkG
	 wdyd3NqK0oY9xhLqGwWqZPOrI3cmMSGAcPOZdoa2HMyoBUzj1HZ7u3ei27zW3iUgSe
	 jbIf/+5ZGuy3lO5tnNIyVnRWRywBGk1ZqhTLjKXxz20cYmnNJ5u6h+mBIMM2TXyT53
	 mtqBm3c9tiOzvlmGUw9VmnNiD32GjPU2pFik1k8QL7O4PXVrGAkfY4q8lue/9mxani
	 lCBMpRqs8/wfA==
Date: Mon, 27 Oct 2025 09:12:26 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] FIXUP: iomap: also apply IOMAP_DIO_FSBLOCK_ALIGNED
 to the iomap range
Message-ID: <20251027161226.GU3356773@frogsfrogsfrogs>
References: <20251023135559.124072-1-hch@lst.de>
 <20251023135559.124072-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023135559.124072-4-hch@lst.de>

On Thu, Oct 23, 2025 at 03:55:44PM +0200, Christoph Hellwig wrote:
> Not just the bios created by bio_iov_iter_get_pages need to be aligned
> to the file system block size when IOMAP_DIO_FSBLOCK_ALIGNED is used,
> but also the iomap mapped region.  Use the local alignment variable
> for this check as well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Heh, silly diff for eliminating context to save a few lines :P
This makes sense to me.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/direct-io.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 8d094d6f5f3e..13def8418659 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -338,9 +338,6 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  	size_t orig_count;
>  	unsigned int alignment;
>  
> -	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1))
> -		return -EINVAL;
> -
>  	/*
>  	 * File systems that write out of place and always allocate new blocks
>  	 * need each bio to be block aligned as that's the unit of allocation.
> @@ -350,6 +347,9 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  	else
>  		alignment = bdev_logical_block_size(iomap->bdev);
>  
> +	if ((pos | length) & (alignment - 1))
> +		return -EINVAL;
> +
>  	if (dio->flags & IOMAP_DIO_WRITE) {
>  		bio_opf |= REQ_OP_WRITE;
>  
> -- 
> 2.47.3
> 
> 

