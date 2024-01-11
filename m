Return-Path: <linux-fsdevel+bounces-7812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A34E82B597
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 20:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED0691F21909
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 19:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E2C5811E;
	Thu, 11 Jan 2024 19:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KramjmLO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E94957886
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 19:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uou0cT/8m7klP36GgRznY3Wz+wT7vW2E2yQT0CAip0Q=; b=KramjmLOm64eus34D6EZkm5YsP
	MsTveq3sdSOFrFNh6agktWy9GpTjYN5ti3gt/eOOI0Zg11C6iSbEQ0iK4tjoFjMDETwHlaaq24uzf
	70zroYMtnfCOesrkLRtPPxI1kJ0s9RIVQgpwNSJkGd1naqiBZC06THq7o2t7cqp1teaHi0fN1VTgb
	X5QaMwHiqn020KYgMvQhfhyr269+k6SU7X6fv9U68fiRykDA4ciLYnx7TiQA2DMfl67ETpPiBNNl6
	k0gFPBQ0oixMQsH1qBOB3XQB7iy/z9F9Sa6DPzXtQw9ueFMOa8lyDMSFUN1pv7sQ4gI9YyYCn5crj
	0q9dLIZg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rO1Aq-00Em7G-L9; Thu, 11 Jan 2024 19:57:08 +0000
Date: Thu, 11 Jan 2024 19:57:08 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] filemap: Convert generic_perform_write() to support
 large folios
Message-ID: <ZaBIFPQqzWHnaeaX@casper.infradead.org>
References: <20240111192513.3505769-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111192513.3505769-1-willy@infradead.org>

On Thu, Jan 11, 2024 at 07:25:13PM +0000, Matthew Wilcox (Oracle) wrote:
> Modelled after the loop in iomap_write_iter(), copy larger chunks from
> userspace if the filesystem has created large folios.

Heh, I hadn't tested this on ext4, and it blows up spectacularly.

We hit the first of these two BUG_ONs:

+++ b/fs/buffer.c
@@ -2078,8 +2078,8 @@ int __block_write_begin_int(struct folio *folio, loff_t pos, unsigned len,
        struct buffer_head *bh, *head, *wait[2], **wait_bh=wait;

        BUG_ON(!folio_test_locked(folio));
-       BUG_ON(to > folio_size(folio));
-       BUG_ON(from > to);
+       if (from < to || to > folio_size(folio))
+               to = folio_size(folio);

        head = folio_create_buffers(folio, inode, 0);
        blocksize = head->b_size;

I'm just doing an xfstests run now, but I think this will fix the problem
(it's up to 400 seconds after crashing at 6 seconds the first time).
Essentially if we pass in a length larger than the folio we find, we
just clamp the amount of work we do to the size of the folio.

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/filemap.c | 40 +++++++++++++++++++++++++---------------
>  1 file changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 750e779c23db..964d5d7b9721 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3893,6 +3893,7 @@ EXPORT_SYMBOL(generic_file_direct_write);
>  ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
>  {
>  	struct file *file = iocb->ki_filp;
> +	size_t chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
>  	loff_t pos = iocb->ki_pos;
>  	struct address_space *mapping = file->f_mapping;
>  	const struct address_space_operations *a_ops = mapping->a_ops;
> @@ -3901,16 +3902,18 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
>  
>  	do {
>  		struct page *page;
> -		unsigned long offset;	/* Offset into pagecache page */
> -		unsigned long bytes;	/* Bytes to write to page */
> +		struct folio *folio;
> +		size_t offset;		/* Offset into folio */
> +		size_t bytes;		/* Bytes to write to folio */
>  		size_t copied;		/* Bytes copied from user */
>  		void *fsdata = NULL;
>  
> -		offset = (pos & (PAGE_SIZE - 1));
> -		bytes = min_t(unsigned long, PAGE_SIZE - offset,
> -						iov_iter_count(i));
> +		bytes = iov_iter_count(i);
> +retry:
> +		offset = pos & (chunk - 1);
> +		bytes = min(chunk - offset, bytes);
> +		balance_dirty_pages_ratelimited(mapping);
>  
> -again:
>  		/*
>  		 * Bring in the user page that we will copy from _first_.
>  		 * Otherwise there's a nasty deadlock on copying from the
> @@ -3932,11 +3935,16 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
>  		if (unlikely(status < 0))
>  			break;
>  
> +		folio = page_folio(page);
> +		offset = offset_in_folio(folio, pos);
> +		if (bytes > folio_size(folio) - offset)
> +			bytes = folio_size(folio) - offset;
> +
>  		if (mapping_writably_mapped(mapping))
> -			flush_dcache_page(page);
> +			flush_dcache_folio(folio);
>  
> -		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
> -		flush_dcache_page(page);
> +		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
> +		flush_dcache_folio(folio);
>  
>  		status = a_ops->write_end(file, mapping, pos, bytes, copied,
>  						page, fsdata);
> @@ -3954,14 +3962,16 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
>  			 * halfway through, might be a race with munmap,
>  			 * might be severe memory pressure.
>  			 */
> -			if (copied)
> +			if (chunk > PAGE_SIZE)
> +				chunk /= 2;
> +			if (copied) {
>  				bytes = copied;
> -			goto again;
> +				goto retry;
> +			}
> +		} else {
> +			pos += status;
> +			written += status;
>  		}
> -		pos += status;
> -		written += status;
> -
> -		balance_dirty_pages_ratelimited(mapping);
>  	} while (iov_iter_count(i));
>  
>  	if (!written)
> -- 
> 2.43.0
> 

