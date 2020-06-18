Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A651FDABB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 03:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgFRBGA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 21:06:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbgFRBF7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:05:59 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3420E21527;
        Thu, 18 Jun 2020 01:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442359;
        bh=fCKvWeZHV681pg3LNgZSQbejrSkS+9SbuvF+zjEAulA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=APtuJ/AWPatfvPNmx/3CBgL56NJJjWfNJ/A2S0+7BCrQAJlgCh+5AqEY6R+xiNsmt
         UuYz3NQh6Pe+hPCTYLrrfHZEtqE0UOMNjbAi8mn1cfQe5u0ORKsA5H7Qxi7+x8BbiH
         SUte9/ml3rR00eV8OpZ/OHU/MrjPssnDeaSd9BME=
Date:   Wed, 17 Jun 2020 18:05:58 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] fs: generic_file_buffered_read() now uses
 find_get_pages_contig
Message-Id: <20200617180558.9722e7337cbe3b88c4767126@linux-foundation.org>
In-Reply-To: <20200610013642.4171512-2-kent.overstreet@gmail.com>
References: <20200610001036.3904844-1-kent.overstreet@gmail.com>
        <20200610013642.4171512-2-kent.overstreet@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue,  9 Jun 2020 21:36:42 -0400 Kent Overstreet <kent.overstreet@gmail.com> wrote:

> Convert generic_file_buffered_read() to get pages to read from in
> batches, and then copy data to userspace from many pages at once - in
> particular, we now don't touch any cachelines that might be contended
> while we're in the loop to copy data to userspace.
> 
> This is is a performance improvement on workloads that do buffered reads
> with large blocksizes, and a very large performance improvement if that
> file is also being accessed concurrently by different threads.
> 
> On smaller reads (512 bytes), there's a very small performance
> improvement (1%, within the margin of error).
> 

checkpatch goes fairly crazy over this one, mostly legitimate.

> @@ -2255,6 +2194,79 @@ generic_file_buffered_read_no_cached_page(struct kiocb *iocb,
>  	return generic_file_buffered_read_readpage(filp, mapping, page);
>  }
>  
> +static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
> +						struct iov_iter *iter,
> +						struct page **pages,
> +						unsigned nr)
> +{
> +	struct file *filp = iocb->ki_filp;
> +	struct address_space *mapping = filp->f_mapping;
> +	struct file_ra_state *ra = &filp->f_ra;
> +	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
> +	pgoff_t last_index = (iocb->ki_pos + iter->count + PAGE_SIZE-1) >> PAGE_SHIFT;
> +	int i, j, ret, err = 0;
> +
> +	nr = min_t(unsigned long, last_index - index, nr);
> +find_page:
> +	if (fatal_signal_pending(current))
> +		return -EINTR;
> +
> +	ret = find_get_pages_contig(mapping, index, nr, pages);
> +	if (ret)
> +		goto got_pages;
> +
> +	if (iocb->ki_flags & IOCB_NOWAIT)
> +		return -EAGAIN;
> +
> +	page_cache_sync_readahead(mapping, ra, filp, index, last_index - index);
> +
> +	ret = find_get_pages_contig(mapping, index, nr, pages);
> +	if (ret)
> +		goto got_pages;
> +
> +	pages[0] = generic_file_buffered_read_no_cached_page(iocb, iter);
> +	err = PTR_ERR_OR_ZERO(pages[0]);
> +	ret = !IS_ERR_OR_NULL(pages[0]);

what?

> +got_pages:
> +	for (i = 0; i < ret; i++) {

Comparing i with ret here just hurts my brain.  Two lines ago ret was a
boolean, now it's a scalar.

> +		struct page *page = pages[i];
> +		pgoff_t pg_index = index +i;
> +		loff_t pg_pos = max(iocb->ki_pos,
> +				    (loff_t) pg_index << PAGE_SHIFT);

hm.  I guess we can't use max_t here because we need to cast the
pgoff_t before the << to avoid overflows on 32-bit.  Perhaps this could
be cleaned up by using additional suitably typed and named locals.

> +		loff_t pg_count = iocb->ki_pos + iter->count - pg_pos;
> +
> +		if (PageReadahead(page))
> +			page_cache_async_readahead(mapping, ra, filp, page,
> +					pg_index, last_index - pg_index);
> +
> +		if (!PageUptodate(page)) {
> +			if (iocb->ki_flags & IOCB_NOWAIT) {
> +				for (j = i; j < ret; j++)
> +					put_page(pages[j]);
> +				ret = i;
> +				err = -EAGAIN;
> +				break;
> +			}
> +
> +			page = generic_file_buffered_read_pagenotuptodate(filp,
> +						iter, page, pg_pos, pg_count);
> +			if (IS_ERR_OR_NULL(page)) {
> +				for (j = i + 1; j < ret; j++)
> +					put_page(pages[j]);
> +				ret = i;
> +				err = PTR_ERR_OR_ZERO(page);
> +				break;
> +			}
> +		}
> +	}
> +
> +	if (likely(ret))
> +		return ret;
> +	if (err)
> +		return err;
> +	goto find_page;
> +}
> +
>  /**
>   * generic_file_buffered_read - generic file read routine
>   * @iocb:	the iocb to read
> @@ -2275,86 +2287,108 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  		struct iov_iter *iter, ssize_t written)
>  {
>  	struct file *filp = iocb->ki_filp;
> +	struct file_ra_state *ra = &filp->f_ra;
>  	struct address_space *mapping = filp->f_mapping;
>  	struct inode *inode = mapping->host;
> -	struct file_ra_state *ra = &filp->f_ra;
>  	size_t orig_count = iov_iter_count(iter);
> -	pgoff_t last_index;
> -	int error = 0;
> +	struct page *page_array[8], **pages;
> +	unsigned nr_pages = ARRAY_SIZE(page_array);
> +	unsigned read_nr_pages = ((iocb->ki_pos + iter->count + PAGE_SIZE-1) >> PAGE_SHIFT) -
> +		(iocb->ki_pos >> PAGE_SHIFT);
> +	int i, pg_nr, error = 0;
> +	bool writably_mapped;
> +	loff_t isize, end_offset;
>  
>  	if (unlikely(iocb->ki_pos >= inode->i_sb->s_maxbytes))
>  		return 0;
>  	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
>  
> -	last_index = (iocb->ki_pos + iter->count + PAGE_SIZE-1) >> PAGE_SHIFT;
> -
> -	for (;;) {
> -		pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
> -		struct page *page;
> +	if (read_nr_pages > nr_pages &&
> +	    (pages = kmalloc_array(read_nr_pages, sizeof(void *), GFP_KERNEL)))

I agree with checkpatch!

> +		nr_pages = read_nr_pages;
> +	else
> +		pages = page_array;
>  
> +	do {
>  		cond_resched();
>
> ...
>

Please, can we make all this code nice to read?

