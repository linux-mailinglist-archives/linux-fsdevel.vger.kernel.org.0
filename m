Return-Path: <linux-fsdevel+bounces-40503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D763A2411D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 17:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10FE163F85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 16:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8384F1EE039;
	Fri, 31 Jan 2025 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZJy6y91"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ACC13213E;
	Fri, 31 Jan 2025 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738342474; cv=none; b=XbVwwXli3qb7IFJ0TDYQNRflCRw66/DlyHdJ8DsWWFsBjwHdLGKiqh3fzuelkxFUExKrl0jhMyK05+tBx0EPAxe9cDbSs6XvmLr9bXP3b2TK3S7o7gD8is7NalKR0k5/K33PPeAyTAqLjxHxjVfeo2zTRMdM4Ri3nuCIHeykUjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738342474; c=relaxed/simple;
	bh=7Hl3GljDjAhtN6pmOcEy1UlbVLzmS0WmXIW/DQQ3PiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDuGJPaKg0xArXY+lsKRwmAUFEzsDmHjUJjwTR9OEpuqQdZcdg9bGHRFuQ63CmecSx1ReKnTlpcBZZJhY7Vj3qPIsXZySzP10dcbAHg2COO/JatGfQYSHSwsySOLh4mjNvHr4StoaOoUa+Csl6IQVBhMoMUlIEawxtMDp9CD/RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZJy6y91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1622C4CED3;
	Fri, 31 Jan 2025 16:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738342473;
	bh=7Hl3GljDjAhtN6pmOcEy1UlbVLzmS0WmXIW/DQQ3PiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AZJy6y91Vv1HZtJR8WflihFkJ/rqTfbZ1FKuyaSEsO+rRESNkufWToIr8vsIyAHPn
	 iwrqhMfTwhvqTIbu+//DqynolEY2R0aLQFRbOcBoKCiJ2Ty/5vAWrVr613mMbUtPPu
	 kFfrYqU5XYVpxevgUR0q2B5wmXt9IsyUPoLZYNYeMhMw6gHiC9uXwgyap60f3S73H4
	 Fx+/dvKi/JkmRKx+wjGdYX1Rk84gtiELgf+Bn0Uq+VMCB3DkLMxmlcJvzNRU1beS2r
	 NWCfBhVu7I+3u2eKAXDNofdgeG9l8XlbCva8bcmzs1OOZXdNlcbR5RyIHLSD4xCDom
	 fOgS0LcUDS1mQ==
Date: Fri, 31 Jan 2025 08:54:31 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: hare@suse.de, dave@stgolabs.net, david@fromorbit.com, djwong@kernel.org,
	kbusch@kernel.org, john.g.garry@oracle.com, hch@lst.de,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
Subject: Re: [PATCH 0/5] fs/buffer: strack reduction on async read
Message-ID: <Z50AR0RKSKmsumFN@bombadil.infradead.org>
References: <20241218022626.3668119-1-mcgrof@kernel.org>
 <Z2MrCey3RIBJz9_E@casper.infradead.org>
 <Z2OEmALBGB8ARLlc@bombadil.infradead.org>
 <Z2OYRkpRcUFIOFog@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2OYRkpRcUFIOFog@casper.infradead.org>

On Thu, Dec 19, 2024 at 03:51:34AM +0000, Matthew Wilcox wrote:
> On Wed, Dec 18, 2024 at 06:27:36PM -0800, Luis Chamberlain wrote:
> > On Wed, Dec 18, 2024 at 08:05:29PM +0000, Matthew Wilcox wrote:
> > > On Tue, Dec 17, 2024 at 06:26:21PM -0800, Luis Chamberlain wrote:
> > > > This splits up a minor enhancement from the bs > ps device support
> > > > series into its own series for better review / focus / testing.
> > > > This series just addresses the reducing the array size used and cleaning
> > > > up the async read to be easier to read and maintain.
> > > 
> > > How about this approach instead -- get rid of the batch entirely?
> > 
> > Less is more! I wish it worked, but we end up with a null pointer on
> > ext4/032 (and indeed this is the test that helped me find most bugs in
> > what I was working on):
> 
> Yeah, I did no testing; just wanted to give people a different approach
> to consider.
> 
> > [  106.034851] BUG: kernel NULL pointer dereference, address: 0000000000000000
> > [  106.046300] RIP: 0010:end_buffer_async_read_io+0x11/0x90
> > [  106.047819] Code: f2 ff 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 53 48 8b 47 10 48 89 fb 48 8b 40 18 <48> 8b 00 f6 40 0d 40 74 0d 0f b7 00 66 25 00 f0 66 3d 00 80 74 09
> 
> That decodes as:
> 
>    5:	53                   	push   %rbx
>    6:	48 8b 47 10          	mov    0x10(%rdi),%rax
>    a:	48 89 fb             	mov    %rdi,%rbx
>    d:	48 8b 40 18          	mov    0x18(%rax),%rax
>   11:*	48 8b 00             	mov    (%rax),%rax		<-- trapping instruction
>   14:	f6 40 0d 40          	testb  $0x40,0xd(%rax)
> 
> 6: bh->b_folio
> d: b_folio->mapping
> 11: mapping->host
> 
> So folio->mapping is NULL.
> 
> Ah, I see the problem.  end_buffer_async_read() uses the buffer_async_read
> test to decide if all buffers on the page are uptodate or not.  So both
> having no batch (ie this patch) and having a batch which is smaller than
> the number of buffers in the folio can lead to folio_end_read() being
> called prematurely (ie we'll unlock the folio before finishing reading
> every buffer in the folio).

But:

a) all batched buffers are locked in the old code, we only unlock
   the currently evaluated buffer, the buffers from our pivot are locked
   and should also have the async flag set. That fact that buffers ahead
   should have the async flag set should prevent from calling
   folio_end_read() prematurely as I read the code, no?

b) In the case we're evaluting the last buffer, we can unlock and call
   folio_end_read(), but that seems fine given the previous batch work
   was in charge of finding candidate buffers which need a read, so in
   this case there should be no pending read.

So I don't see how we yet can call folio_end_read() prematurely.

We do however unlock the buffer in end_buffer_async_read(), but in case
of an inconsistency we simply bail on the loop, and since we only called
end_buffer_async_read() in case of the buffer being up to date, the only
iconsistency we check for is if (!buffer_uptodate(tmp)) in which case
the folio_end_read() will be called but without a success being annoted.

> Once the folio is unlocked, it can be truncated.  That's a second-order
> problem, but it's the one your test happened to hit.
> 
> 
> This should fix the problem; we always have at least one BH held in
> the submission path with the async_read flag set, so
> end_buffer_async_read() will not end it prematurely.

But this alternative does not call end_buffer_async_read(), in fact
we only call folio_end_read() in case of no pending reads being needed.

> diff --git a/fs/buffer.c b/fs/buffer.c
> index cc8452f60251..fd2633e4a5d2 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2361,9 +2361,9 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
>  {
>  	struct inode *inode = folio->mapping->host;
>  	sector_t iblock, lblock;
> -	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
> +	struct buffer_head *bh, *head, *prev = NULL;
>  	size_t blocksize;
> -	int nr, i;
> +	int i;
>  	int fully_mapped = 1;
>  	bool page_error = false;
>  	loff_t limit = i_size_read(inode);
> @@ -2380,7 +2380,6 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
>  	iblock = div_u64(folio_pos(folio), blocksize);
>  	lblock = div_u64(limit + blocksize - 1, blocksize);
>  	bh = head;
> -	nr = 0;
>  	i = 0;
>  
>  	do {
> @@ -2411,40 +2410,33 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
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
>  	} while (i++, iblock++, (bh = bh->b_this_page) != head);
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

Do we want to keep mentioning end_buffer_async_read() here?

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

Becuase we only call folio_end_read() in the above code in case we had
no pending read IO determined. In case we had to at least issue one read
for one buffer we never call folio_end_read(). We didn't before unless
we ran into a race where a pending batched read coincided with a read
being issued and updating our buffer by chance, and we determined we
either completed that read fine or with an error.

Reason I'm asking these things is I'm trying to determine if there was
an issue before we're trying to fix other than the simplification with
the new un-batched strategy. I don't see it yet. If we're fixing
something here, it is still a bit obscure to me and I'd like to make
sure we document it properly.

  Luis

