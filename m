Return-Path: <linux-fsdevel+bounces-41897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD530A38E37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 22:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5C8188D48A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 21:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CBD1A9B40;
	Mon, 17 Feb 2025 21:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P9L6uob3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420592A8C1;
	Mon, 17 Feb 2025 21:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739828410; cv=none; b=eRCD0/s1CMsYdFY37qZIRQwVkMcwhLgqixbBZS2R5mC5+GiUPF9M9aQBP8YDff6pyNDeKrtQi5AVOYevH2zNU/NtarQhkobfLY8cLfh8IGxZ8gcMM8EREU8tIyaZcUXNhkiNQQf+5aT6dw/BbwXXx1aL5AN1uuDiwzOd/x7i/7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739828410; c=relaxed/simple;
	bh=mDOJpH9wr0GAuWGnE8twFQUiLYLbrcXebGiv62ABvJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilKc2KsXGfk7+tL7+lEPC0c4hVJsEGRY8MgSkYA9bcY36NGQjT/tbaI3NwrL32TZdOVf9J+aAObMMosH4m4dv2oixJoMAyuTdx+refF69KT6rYlE8yTftFzJwMT4J2B8ZMUdP5vxQrNdcQJoODN3l16KA5eMfcKAtxL96EozxSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P9L6uob3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KY8nyubrU5h1fWAeCYwM70hwEZhksrwYllCElbQXlTA=; b=P9L6uob3gnsA9z7fl3KVtM5ac1
	eVA7gQ/xKeKMmu5K/T68/i7b2E7FfiSjoVn6j7pKgh1O40M1rEvWGcgf0YGXHMmfNYX9En37jJpGL
	xJke9LGh+DVVO0EVQkQSfA1rd53OPsx3VcQIvnbmvmp07QmR4qh9BUkbrFKWhXoVaQSb++xbVU/mF
	24r9uZvwgbLme2F5nkNGmATd66YThEBl6PsgnKbzWDOwoeryQSd3vmhFu8vUAM8HH1JzvQlJFnLoL
	I7nRalertEjJ+MhNEKuVc926mVYTTIqe7kRm/bmHIwsNSzKmmGj4EWlykONbrj0JHXU6bgX8klIr8
	3z46BjHw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk8qO-00000001yqZ-0ysr;
	Mon, 17 Feb 2025 21:40:00 +0000
Date: Mon, 17 Feb 2025 21:40:00 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: hare@suse.de, dave@stgolabs.net, david@fromorbit.com, djwong@kernel.org,
	kbusch@kernel.org, john.g.garry@oracle.com, hch@lst.de,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
Subject: Re: [PATCH v2 2/8] fs/buffer: remove batching from async read
Message-ID: <Z7OssHQSgVEVzbSZ@casper.infradead.org>
References: <20250204231209.429356-1-mcgrof@kernel.org>
 <20250204231209.429356-3-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204231209.429356-3-mcgrof@kernel.org>

On Tue, Feb 04, 2025 at 03:12:03PM -0800, Luis Chamberlain wrote:
> From: Matthew Wilcox <willy@infradead.org>

From: Matthew Wilcox (Oracle) <willy@infradead.org>

block_read_full_folio() currently puts all !uptodate buffers into
an array allocated on the stack, then iterates over it twice, first
locking the buffers and then submitting them for read.  We want to
remove this array because it occupies too much stack space on
configurations with a larger PAGE_SIZE (eg 512 bytes with 8 byte
pointers and a 64KiB PAGE_SIZE).

We cannot simply submit buffer heads as we find them as the completion
handler needs to be able to tell when all reads are finished, so it can
end the folio read.  So we keep one buffer in reserve (using the 'prev'
variable) until the end of the function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> diff --git a/fs/buffer.c b/fs/buffer.c
> index b99560e8a142..167fa3e33566 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2361,9 +2361,8 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
>  {
>  	struct inode *inode = folio->mapping->host;
>  	sector_t iblock, lblock;
> -	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
> +	struct buffer_head *bh, *head, *prev = NULL;
>  	size_t blocksize;
> -	int nr, i;
>  	int fully_mapped = 1;
>  	bool page_error = false;
>  	loff_t limit = i_size_read(inode);
> @@ -2380,7 +2379,6 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
>  	iblock = div_u64(folio_pos(folio), blocksize);
>  	lblock = div_u64(limit + blocksize - 1, blocksize);
>  	bh = head;
> -	nr = 0;
>  
>  	do {
>  		if (buffer_uptodate(bh))
> @@ -2410,40 +2408,33 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
>  			if (buffer_uptodate(bh))
>  				continue;
>  		}
> -		arr[nr++] = bh;
> +
> +		lock_buffer(bh);
> +		if (buffer_uptodate(bh)) {
> +			unlock_buffer(bh);
> +			continue;
> +		}
> +
> +		mark_buffer_async_read(bh);
> +		if (prev)
> +			submit_bh(REQ_OP_READ, prev);
> +		prev = bh;
>  	} while (iblock++, (bh = bh->b_this_page) != head);
>  
>  	if (fully_mapped)
>  		folio_set_mappedtodisk(folio);
>  
> -	if (!nr) {
> -		/*
> -		 * All buffers are uptodate or get_block() returned an
> -		 * error when trying to map them - we can finish the read.
> -		 */
> -		folio_end_read(folio, !page_error);
> -		return 0;
> -	}
> -
> -	/* Stage two: lock the buffers */
> -	for (i = 0; i < nr; i++) {
> -		bh = arr[i];
> -		lock_buffer(bh);
> -		mark_buffer_async_read(bh);
> -	}
> -
>  	/*
> -	 * Stage 3: start the IO.  Check for uptodateness
> -	 * inside the buffer lock in case another process reading
> -	 * the underlying blockdev brought it uptodate (the sct fix).
> +	 * All buffers are uptodate or get_block() returned an error
> +	 * when trying to map them - we must finish the read because
> +	 * end_buffer_async_read() will never be called on any buffer
> +	 * in this folio.
>  	 */
> -	for (i = 0; i < nr; i++) {
> -		bh = arr[i];
> -		if (buffer_uptodate(bh))
> -			end_buffer_async_read(bh, 1);
> -		else
> -			submit_bh(REQ_OP_READ, bh);
> -	}
> +	if (prev)
> +		submit_bh(REQ_OP_READ, prev);
> +	else
> +		folio_end_read(folio, !page_error);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(block_read_full_folio);
> -- 
> 2.45.2
> 

