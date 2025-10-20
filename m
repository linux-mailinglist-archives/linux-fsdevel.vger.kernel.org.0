Return-Path: <linux-fsdevel+bounces-64646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BA4BEF504
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 06:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C266C3E0A5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 04:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8972C027E;
	Mon, 20 Oct 2025 04:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bVoQwAyu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6561E9919;
	Mon, 20 Oct 2025 04:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760936009; cv=none; b=TnxX+P/akLv4+FXrjYmld4yUrpVxyvpT/bBT8+hrXtNdJ2WoNetjzqkxwZxcfG7cLQu1oFC62G0enQvvY53TMz7sgX8FzsrZ8AHjCoxz9uLGr8kgTMtk89+6lvO9YHcz/z9JQpWIPO/1CDmWHoYaOQ7Ao6mRdod7sGWHqqtABKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760936009; c=relaxed/simple;
	bh=xw6wua+9An7R6Pk+rGlLYtknBm2NgeItgTQplrPZ2hA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PubThNAYhMHphBq5sq1LYF6fAcXqaQs9TjMB2i2bgN/5PUSQlLhT9VFW0BhBNsn5CeGFiT95ObL4xhuZ7gl1NDMH01jOZHKxnomVuEraN7o7And9rKwyeU/BOQHQcpXNAoOrD+IwL4PhWFAFqq6uPjoWi/Bvhv0DWdtmfN6RlPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bVoQwAyu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1507AC4CEF9;
	Mon, 20 Oct 2025 04:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1760936009;
	bh=xw6wua+9An7R6Pk+rGlLYtknBm2NgeItgTQplrPZ2hA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bVoQwAyuKyviRKF9fU9nSvYcvfJLo505wTKzAodqnmecEG25NtrUVsVVX3hh96TFO
	 qAX90unR2OF/trDqqF+2U4dm7Ax7V7YeBxFFNf4t6HhBM88JzxEepXBjaCWr2/w+cG
	 jmz/xn7/KEukpHBxvrIF2ExzXYjvu+d2Q6VxBUic=
Date: Sun, 19 Oct 2025 21:53:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: David Hildenbrand <david@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Kiryl
 Shutsemau <kas@kernel.org>, Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
Message-Id: <20251019215328.3b529dc78222787226bd4ffe@linux-foundation.org>
In-Reply-To: <20251017141536.577466-1-kirill@shutemov.name>
References: <20251017141536.577466-1-kirill@shutemov.name>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Oct 2025 15:15:36 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:

> From: Kiryl Shutsemau <kas@kernel.org>
> 
> The protocol for page cache lookup is as follows:
> 
>   1. Locate a folio in XArray.
>   2. Obtain a reference on the folio using folio_try_get().
>   3. If successful, verify that the folio still belongs to
>      the mapping and has not been truncated or reclaimed.
>   4. Perform operations on the folio, such as copying data
>      to userspace.
>   5. Release the reference.
> 
> For short reads, the overhead of atomic operations on reference
> manipulation can be significant, particularly when multiple tasks access
> the same folio, leading to cache line bouncing.
> 
> To address this issue, introduce i_pages_delete_seqcnt, which increments
> each time a folio is deleted from the page cache and implement a modified
> page cache lookup protocol for short reads:
> 
>   1. Locate a folio in XArray.
>   2. Take note of the i_pages_delete_seqcnt.
>   3. Copy the data to a local buffer on the stack.
>   4. Verify that the i_pages_delete_seqcnt has not changed.
>   5. Copy the data from the local buffer to the iterator.
> 
> If any issues arise in the fast path, fallback to the slow path that
> relies on the refcount to stabilize the folio.

Well this is a fun patch.

> The new approach requires a local buffer in the stack. The size of the
> buffer determines which read requests are served by the fast path. Set
> the buffer to 1k. This seems to be a reasonable amount of stack usage
> for the function at the bottom of the call stack.

A use case for alloca() or equiv.  That would improve the average-case
stack depth but not the worst-case.

The 1k guess-or-giggle is crying out for histogramming - I bet 0.1k
covers the great majority.  I suspect it wouldn't be hard to add a new
ad-hoc API into memory allocation profiling asking it to profile
something like this for us, given an explicit request to to do.

Is there really no way to copy the dang thing straight out to
userspace, skip the bouncing?

> The fast read approach demonstrates significant performance
> improvements, particularly in contended cases.
> 
> 16 threads, reads from 4k file(s), mean MiB/s (StdDev)
> 
>  -------------------------------------------------------------
> | Block |  Baseline  |  Baseline   |  Patched   |  Patched    |
> | size  |  same file |  diff files |  same file | diff files  |
>  -------------------------------------------------------------
> |     1 |    10.96   |     27.56   |    30.42   |     30.4    |
> |       |    (0.497) |     (0.114) |    (0.130) |     (0.158) |
> |    32 |   350.8    |    886.2    |   980.6    |    981.8    |
> |       |   (13.64)  |     (2.863) |    (3.361) |     (1.303) |
> |   256 |  2798      |   7009.6    |  7641.4    |   7653.6    |
> |       |  (103.9)   |    (28.00)  |   (33.26)  |    (25.50)  |

tl;dr, 256-byte reads from the same file nearly tripled.

> |  1024 | 10780      |  27040      | 29280      |  29320      |
> |       |  (389.8)   |    (89.44)  |  (130.3)   |    (83.66)  |
> |  4096 | 43700      | 103800      | 48420      | 102000      |
> |       | (1953)     |    (447.2)  | (2012)     |     (0)     |
>  -------------------------------------------------------------
> 
> 16 threads, reads from 1M file(s), mean MiB/s (StdDev)
> 
>  --------------------------------------------------------------
> | Block |  Baseline   |  Baseline   |  Patched    |  Patched   |
> | size  |  same file  |  diff files |  same file  | diff files |
>  ---------------------------------------------------------
> |     1 |     26.38   |     27.34   |     30.38   |    30.36   |
> |       |     (0.998) |     (0.114) |     (0.083) |    (0.089) |
> |    32 |    824.4    |    877.2    |    977.8    |   975.8    |
> |       |    (15.78)  |     (3.271) |     (2.683) |    (1.095) |
> |   256 |   6494      |   6992.8    |   7619.8    |   7625     |
> |       |   (116.0)   |    (32.39)  |    (10.66)  |    (28.19) |
> |  1024 |  24960      |  26840      |  29100      |  29180     |
> |       |   (606.6)   |   (151.6)   |   (122.4)   |    (83.66) |
> |  4096 |  94420      | 100520      |  95260      |  99760     |
> |       |  (3144)     |   (672.3)   |  (2874)     |   (134.1)  |
> | 32768 | 386000      | 402400      | 368600      | 397400     |
> |       | (36599)     | (10526)     | (47188)     |  (6107)    |
>  --------------------------------------------------------------
> 
> There's also improvement on kernel build:
> 
> Base line: 61.3462 +- 0.0597 seconds time elapsed  ( +-  0.10% )
> Patched:   60.6106 +- 0.0759 seconds time elapsed  ( +-  0.13% )
> 
> ...
>
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
>
> ...
>
> -ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
> -		ssize_t already_read)
> +static inline unsigned long filemap_read_fast_rcu(struct address_space *mapping,
> +						  loff_t pos, char *buffer,
> +						  size_t size)
> +{
> +	XA_STATE(xas, &mapping->i_pages, pos >> PAGE_SHIFT);
> +	struct folio *folio;
> +	loff_t file_size;
> +	unsigned int seq;
> +
> +	lockdep_assert_in_rcu_read_lock();
> +
> +	/* Give up and go to slow path if raced with page_cache_delete() */
> +	if (!raw_seqcount_try_begin(&mapping->i_pages_delete_seqcnt, seq))
> +		return false;

	return 0;

> +
> +	folio = xas_load(&xas);
> +	if (xas_retry(&xas, folio))
> +		return 0;
> +
> +	if (!folio || xa_is_value(folio))
> +		return 0;
> +
> +	if (!folio_test_uptodate(folio))
> +		return 0;
> +
> +	/* No fast-case if readahead is supposed to started */

Please expand this comment.  "explain why, not what".  Why do we care
if it's under readahead?  It's uptodate, so just grab it??

> +	if (folio_test_readahead(folio))
> +		return 0;
> +	/* .. or mark it accessed */

This comment disagrees with the code which it is commenting.

> +	if (!folio_test_referenced(folio))
> +		return 0;
> +
> +	/* i_size check must be after folio_test_uptodate() */

why?

> +	file_size = i_size_read(mapping->host);
> +	if (unlikely(pos >= file_size))
> +		return 0;
> +	if (size > file_size - pos)
> +		size = file_size - pos;

min() is feeling all sad?

> +	/* Do the data copy */

We can live without this comment ;)

> +	size = memcpy_from_file_folio(buffer, folio, pos, size);
> +	if (!size)
> +		return 0;
> +
> +	/* Give up and go to slow path if raced with page_cache_delete() */

I wonder if truncation is all we need to worry about here.  For
example, direct-io does weird stuff.

> +	if (read_seqcount_retry(&mapping->i_pages_delete_seqcnt, seq))
> +		return 0;
> +
> +	return size;
> +}
> +
> +#define FAST_READ_BUF_SIZE 1024
> +
> +static noinline bool filemap_read_fast(struct kiocb *iocb, struct iov_iter *iter,
> +				       ssize_t *already_read)
> +{
> +	struct address_space *mapping = iocb->ki_filp->f_mapping;
> +	struct file_ra_state *ra = &iocb->ki_filp->f_ra;
> +	char buffer[FAST_READ_BUF_SIZE];
> +	size_t count;
> +
> +	if (ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE)
> +		return false;

why?  (comment please)

> +	if (iov_iter_count(iter) > sizeof(buffer))
> +		return false;
> +
> +	count = iov_iter_count(iter);

It'd be a tinier bit tidier to swap the above to avoid evaluating
iov_iter_count() twice.  Yes, iov_iter_count() happens to be fast, but
we aren't supposed to know that here.

> +	/* Let's see if we can just do the read under RCU */
> +	rcu_read_lock();
> +	count = filemap_read_fast_rcu(mapping, iocb->ki_pos, buffer, count);
> +	rcu_read_unlock();
> +
> +	if (!count)
> +		return false;
> +
> +	count = copy_to_iter(buffer, count, iter);
> +	if (unlikely(!count))
> +		return false;
> +
> +	iocb->ki_pos += count;
> +	ra->prev_pos = iocb->ki_pos;
> +	file_accessed(iocb->ki_filp);
> +	*already_read += count;
> +
> +	return !iov_iter_count(iter);
> +}
> +
> +static noinline ssize_t filemap_read_slow(struct kiocb *iocb,
> +					  struct iov_iter *iter,
> +					  ssize_t already_read)
>  {
>  	struct file *filp = iocb->ki_filp;
>  	struct file_ra_state *ra = &filp->f_ra;


