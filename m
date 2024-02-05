Return-Path: <linux-fsdevel+bounces-10262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 861F9849903
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85E41F221C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 11:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4166A199A7;
	Mon,  5 Feb 2024 11:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DiWSnUbU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6lQcoCAj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DiWSnUbU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6lQcoCAj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660FF18EB8;
	Mon,  5 Feb 2024 11:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707133183; cv=none; b=lM9KzuJz9HzZbQ7ZgyofgdT0c1zzg+wxhh6fJJSShzghBgwmIywnbbncWxWWwhRpGVvXN1xsFnTpNXDMZwdl1qZ1ktDaXMMzKIAWNXZemP1azPZVSXxhOs1GIFZituXLBA0GyTWUMeXBxr63jr6VLCvALzEXPCpjHJSFKprxeqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707133183; c=relaxed/simple;
	bh=mRlwFY7kRp/G7DPQmASAu2DajK9cQJbqykE/u6l2bEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCZh2qxuJOtzrtocAuEYyMnrctA4PuMoXipxc8ZV/p9l9icj169FdkebGjF+x+EY+ad8kG+BdBF+MNCNeTn/FX6BJpMH0lgVV3q7C3tl4DNxXHV/3HrzofsGz8pgLER94Lfc1SCBKGy2ZBhNG1YhX1z/ad9tPJxXSKSjB6Hygyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DiWSnUbU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6lQcoCAj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DiWSnUbU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6lQcoCAj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 849FB1F8BB;
	Mon,  5 Feb 2024 11:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707133179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fIuM3Q6VzAnAPyVLX/OqZgZYlF68gRw2R0OsX5yqsfw=;
	b=DiWSnUbU33o+QdXrbCoPoyiOxTxQAWeX++TkNFX3HMbVhYD83OnnGoLlh5ct2bR3i5ddgZ
	FKSSe4x2K/snmwpt+IHnWYpr8Kqinebr0tCxEXPYDW9YrROGhTJD1hPr5rUXL0ZLq7DW8F
	mo8dE4pdt/yq77JGMTvIUMl/83elFOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707133179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fIuM3Q6VzAnAPyVLX/OqZgZYlF68gRw2R0OsX5yqsfw=;
	b=6lQcoCAj0LI1ZrFqiK+bB1kD5fg8wqKi1BpR0BSZUP2J7qTPXC+LnSZ9po6VTpx7PmGDXo
	x6qBGb8z89cEZqDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707133179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fIuM3Q6VzAnAPyVLX/OqZgZYlF68gRw2R0OsX5yqsfw=;
	b=DiWSnUbU33o+QdXrbCoPoyiOxTxQAWeX++TkNFX3HMbVhYD83OnnGoLlh5ct2bR3i5ddgZ
	FKSSe4x2K/snmwpt+IHnWYpr8Kqinebr0tCxEXPYDW9YrROGhTJD1hPr5rUXL0ZLq7DW8F
	mo8dE4pdt/yq77JGMTvIUMl/83elFOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707133179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fIuM3Q6VzAnAPyVLX/OqZgZYlF68gRw2R0OsX5yqsfw=;
	b=6lQcoCAj0LI1ZrFqiK+bB1kD5fg8wqKi1BpR0BSZUP2J7qTPXC+LnSZ9po6VTpx7PmGDXo
	x6qBGb8z89cEZqDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71D44136F5;
	Mon,  5 Feb 2024 11:39:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eziDG/vIwGWGQwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 Feb 2024 11:39:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0EF07A0809; Mon,  5 Feb 2024 12:39:31 +0100 (CET)
Date: Mon, 5 Feb 2024 12:39:31 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/13] writeback: add a writeback iterator
Message-ID: <20240205113931.m4sictdqr3gd5rtl@quack3>
References: <20240203071147.862076-1-hch@lst.de>
 <20240203071147.862076-13-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203071147.862076-13-hch@lst.de>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DiWSnUbU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6lQcoCAj
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 849FB1F8BB
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Sat 03-02-24 08:11:46, Christoph Hellwig wrote:
> Refactor the code left in write_cache_pages into an iterator that the
> file system can call to get the next folio for a writeback operation:
> 
> 	struct folio *folio = NULL;
> 
> 	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
> 		error = <do per-foli writeback>;
> 	}
> 
> The twist here is that the error value is passed by reference, so that
> the iterator can restore it when breaking out of the loop.
> 
> Handling of the magic AOP_WRITEPAGE_ACTIVATE value stays outside the
> iterator and needs is just kept in the write_cache_pages legacy wrapper.
> in preparation for eventually killing it off.
> 
> Heavily based on a for_each* based iterator from Matthew Wilcox.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/writeback.h |   4 +
>  mm/page-writeback.c       | 192 ++++++++++++++++++++++----------------
>  2 files changed, 118 insertions(+), 78 deletions(-)
> 
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index f67b3ea866a0fb..9845cb62e40b2d 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -82,6 +82,7 @@ struct writeback_control {
>  	/* internal fields used by the ->writepages implementation: */
>  	struct folio_batch fbatch;
>  	pgoff_t index;
> +	int saved_err;
>  
>  #ifdef CONFIG_CGROUP_WRITEBACK
>  	struct bdi_writeback *wb;	/* wb this writeback is issued under */
> @@ -366,6 +367,9 @@ int balance_dirty_pages_ratelimited_flags(struct address_space *mapping,
>  
>  bool wb_over_bg_thresh(struct bdi_writeback *wb);
>  
> +struct folio *writeback_iter(struct address_space *mapping,
> +		struct writeback_control *wbc, struct folio *folio, int *error);
> +
>  typedef int (*writepage_t)(struct folio *folio, struct writeback_control *wbc,
>  				void *data);
>  
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 3abb053e70580e..5fe4cdb7dbd61a 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2325,18 +2325,18 @@ void __init page_writeback_init(void)
>  }
>  
>  /**
> - * tag_pages_for_writeback - tag pages to be written by write_cache_pages
> + * tag_pages_for_writeback - tag pages to be written by writeback
>   * @mapping: address space structure to write
>   * @start: starting page index
>   * @end: ending page index (inclusive)
>   *
>   * This function scans the page range from @start to @end (inclusive) and tags
> - * all pages that have DIRTY tag set with a special TOWRITE tag. The idea is
> - * that write_cache_pages (or whoever calls this function) will then use
> - * TOWRITE tag to identify pages eligible for writeback.  This mechanism is
> - * used to avoid livelocking of writeback by a process steadily creating new
> - * dirty pages in the file (thus it is important for this function to be quick
> - * so that it can tag pages faster than a dirtying process can create them).
> + * all pages that have DIRTY tag set with a special TOWRITE tag.  The caller
> + * can then use the TOWRITE tag to identify pages eligible for writeback.
> + * This mechanism is used to avoid livelocking of writeback by a process
> + * steadily creating new dirty pages in the file (thus it is important for this
> + * function to be quick so that it can tag pages faster than a dirtying process
> + * can create them).
>   */
>  void tag_pages_for_writeback(struct address_space *mapping,
>  			     pgoff_t start, pgoff_t end)
> @@ -2434,69 +2434,68 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
>  }
>  
>  /**
> - * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
> + * writeback_iter - iterate folio of a mapping for writeback
>   * @mapping: address space structure to write
> - * @wbc: subtract the number of written pages from *@wbc->nr_to_write
> - * @writepage: function called for each page
> - * @data: data passed to writepage function
> + * @wbc: writeback context
> + * @folio: previously iterated folio (%NULL to start)
> + * @error: in-out pointer for writeback errors (see below)
>   *
> - * If a page is already under I/O, write_cache_pages() skips it, even
> - * if it's dirty.  This is desirable behaviour for memory-cleaning writeback,
> - * but it is INCORRECT for data-integrity system calls such as fsync().  fsync()
> - * and msync() need to guarantee that all the data which was dirty at the time
> - * the call was made get new I/O started against them.  If wbc->sync_mode is
> - * WB_SYNC_ALL then we were called for data integrity and we must wait for
> - * existing IO to complete.
> - *
> - * To avoid livelocks (when other process dirties new pages), we first tag
> - * pages which should be written back with TOWRITE tag and only then start
> - * writing them. For data-integrity sync we have to be careful so that we do
> - * not miss some pages (e.g., because some other process has cleared TOWRITE
> - * tag we set). The rule we follow is that TOWRITE tag can be cleared only
> - * by the process clearing the DIRTY tag (and submitting the page for IO).
> - *
> - * To avoid deadlocks between range_cyclic writeback and callers that hold
> - * pages in PageWriteback to aggregate IO until write_cache_pages() returns,
> - * we do not loop back to the start of the file. Doing so causes a page
> - * lock/page writeback access order inversion - we should only ever lock
> - * multiple pages in ascending page->index order, and looping back to the start
> - * of the file violates that rule and causes deadlocks.
> + * This function returns the next folio for the writeback operation described by
> + * @wbc on @mapping and  should be called in a while loop in the ->writepages
> + * implementation.
>   *
> - * Return: %0 on success, negative error code otherwise
> + * To start the writeback operation, %NULL is passed in the @folio argument, and
> + * for every subsequent iteration the folio returned previously should be passed
> + * back in.
> + *
> + * If there was an error in the per-folio writeback inside the writeback_iter()
> + * loop, @error should be set to the error value.
> + *
> + * Once the writeback described in @wbc has finished, this function will return
> + * %NULL and if there was an error in any iteration restore it to @error.
> + *
> + * Note: callers should not manually break out of the loop using break or goto
> + * but must keep calling writeback_iter() until it returns %NULL.
> + *
> + * Return: the folio to write or %NULL if the loop is done.
>   */
> -int write_cache_pages(struct address_space *mapping,
> -		      struct writeback_control *wbc, writepage_t writepage,
> -		      void *data)
> +struct folio *writeback_iter(struct address_space *mapping,
> +		struct writeback_control *wbc, struct folio *folio, int *error)
>  {
> -	int ret = 0;
> -	int error;
> -	struct folio *folio;
> -	pgoff_t end;		/* Inclusive */
> -
> -	if (wbc->range_cyclic) {
> -		wbc->index = mapping->writeback_index; /* prev offset */
> -		end = -1;
> -	} else {
> -		wbc->index = wbc->range_start >> PAGE_SHIFT;
> -		end = wbc->range_end >> PAGE_SHIFT;
> -	}
> -	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> -		tag_pages_for_writeback(mapping, wbc->index, end);
> -
> -	folio_batch_init(&wbc->fbatch);
> +	if (!folio) {
> +		folio_batch_init(&wbc->fbatch);
> +		wbc->saved_err = *error = 0;
>  
> -	for (;;) {
> -		folio = writeback_get_folio(mapping, wbc);
> -		if (!folio)
> -			break;
> +		/*
> +		 * For range cyclic writeback we remember where we stopped so
> +		 * that we can continue where we stopped.
> +		 *
> +		 * For non-cyclic writeback we always start at the beginning of
> +		 * the passed in range.
> +		 */
> +		if (wbc->range_cyclic)
> +			wbc->index = mapping->writeback_index;
> +		else
> +			wbc->index = wbc->range_start >> PAGE_SHIFT;
>  
> -		error = writepage(folio, wbc, data);
> +		/*
> +		 * To avoid livelocks when other processes dirty new pages, we
> +		 * first tag pages which should be written back and only then
> +		 * start writing them.
> +		 *
> +		 * For data-integrity writeback we have to be careful so that we
> +		 * do not miss some pages (e.g., because some other process has
> +		 * cleared the TOWRITE tag we set).  The rule we follow is that
> +		 * TOWRITE tag can be cleared only by the process clearing the
> +		 * DIRTY tag (and submitting the page for I/O).
> +		 */
> +		if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> +			tag_pages_for_writeback(mapping, wbc->index,
> +					wbc_end(wbc));
> +	} else {
>  		wbc->nr_to_write -= folio_nr_pages(folio);
>  
> -		if (error == AOP_WRITEPAGE_ACTIVATE) {
> -			folio_unlock(folio);
> -			error = 0;
> -		}
> +		WARN_ON_ONCE(*error > 0);
>  
>  		/*
>  		 * For integrity writeback we have to keep going until we have
> @@ -2510,33 +2509,70 @@ int write_cache_pages(struct address_space *mapping,
>  		 * wbc->nr_to_write or encounter the first error.
>  		 */
>  		if (wbc->sync_mode == WB_SYNC_ALL) {
> -			if (error && !ret)
> -				ret = error;
> +			if (*error && !wbc->saved_err)
> +				wbc->saved_err = *error;
>  		} else {
> -			if (error || wbc->nr_to_write <= 0)
> +			if (*error || wbc->nr_to_write <= 0)
>  				goto done;
>  		}
>  	}
>  
> -	/*
> -	 * For range cyclic writeback we need to remember where we stopped so
> -	 * that we can continue there next time we are called.  If  we hit the
> -	 * last page and there is more work to be done, wrap back to the start
> -	 * of the file.
> -	 *
> -	 * For non-cyclic writeback we always start looking up at the beginning
> -	 * of the file if we are called again, which can only happen due to
> -	 * -ENOMEM from the file system.
> -	 */
> -	folio_batch_release(&wbc->fbatch);
> -	if (wbc->range_cyclic)
> -		mapping->writeback_index = 0;
> -	return ret;
> +	folio = writeback_get_folio(mapping, wbc);
> +	if (!folio) {
> +		/*
> +		 * To avoid deadlocks between range_cyclic writeback and callers
> +		 * that hold pages in PageWriteback to aggregate I/O until
> +		 * the writeback iteration finishes, we do not loop back to the
> +		 * start of the file.  Doing so causes a page lock/page
> +		 * writeback access order inversion - we should only ever lock
> +		 * multiple pages in ascending page->index order, and looping
> +		 * back to the start of the file violates that rule and causes
> +		 * deadlocks.
> +		 */
> +		if (wbc->range_cyclic)
> +			mapping->writeback_index = 0;
> +
> +		/*
> +		 * Return the first error we encountered (if there was any) to
> +		 * the caller.
> +		 */
> +		*error = wbc->saved_err;
> +	}
> +	return folio;
>  
>  done:
>  	folio_batch_release(&wbc->fbatch);
>  	if (wbc->range_cyclic)
>  		mapping->writeback_index = folio->index + folio_nr_pages(folio);
> +	return NULL;
> +}
> +
> +/**
> + * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
> + * @mapping: address space structure to write
> + * @wbc: subtract the number of written pages from *@wbc->nr_to_write
> + * @writepage: function called for each page
> + * @data: data passed to writepage function
> + *
> + * Return: %0 on success, negative error code otherwise
> + *
> + * Note: please use writeback_iter() instead.
> + */
> +int write_cache_pages(struct address_space *mapping,
> +		      struct writeback_control *wbc, writepage_t writepage,
> +		      void *data)
> +{
> +	struct folio *folio = NULL;
> +	int error;
> +
> +	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
> +		error = writepage(folio, wbc, data);
> +		if (error == AOP_WRITEPAGE_ACTIVATE) {
> +			folio_unlock(folio);
> +			error = 0;
> +		}
> +	}
> +
>  	return error;
>  }
>  EXPORT_SYMBOL(write_cache_pages);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

