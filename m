Return-Path: <linux-fsdevel+bounces-9634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05320843CFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 11:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C876AB2C9B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 10:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13EC6A03D;
	Wed, 31 Jan 2024 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZRZTDeEm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i3NPAvBW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZRZTDeEm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i3NPAvBW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09FD69E08;
	Wed, 31 Jan 2024 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706697650; cv=none; b=EHCy6Odc/9CCLTWsBTXe3C9We5jC2wzGhzn6JgpOjOKapX1iwyT3XH8hCxLE5jD4xmeWBFjCX0xIyhxDB2tn8LeNJH+pPny4K9SmfY/lWGRs84ZS6eUTCBjd+8Xtw03bbWYRRYs/QXuq02meQLqTp6cSFnbBrasnFARRNyUEHIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706697650; c=relaxed/simple;
	bh=d/nXT1q2zn2ci4I6hykfWt4RZtJJql4mao3cw3YEgvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpBDRZJmIo6CdopENkh5KVs2FUrk2Z9Z/B+1bnlXsRjSdMhwNHHwE/3bOmUO2QaUp5hjd3/jS2rMeuJIjgwYJ0LDZghyAnjT4h0YyeehcXS3lfaEvXOUXJeCZHCm4Ze+KK0ElZrqUhCocZw+Z1OKGVAF8cylf7Z7K0+aGU+wMas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZRZTDeEm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i3NPAvBW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZRZTDeEm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i3NPAvBW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B4AF722054;
	Wed, 31 Jan 2024 10:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706697645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dPcLX73r3YpQEEGzySZYAJEksezsG5Bmi9BufYjnANg=;
	b=ZRZTDeEmDc/cnenutt7MpAtBmVvI2fD+FkXDjxvkeDMBhx2VgK7k5wphsnedmOkrspsS/y
	TxN32QgixN6qtjDZHc6zU8xy7GAJqMmft1b03lcjlR1x/rxzuGj2x/XfgSwuuKruM2Zb8q
	eiCjApvfP2ErePpeJ306CA9bRSHkUqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706697645;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dPcLX73r3YpQEEGzySZYAJEksezsG5Bmi9BufYjnANg=;
	b=i3NPAvBWC6FJoTL70zaa+aePduGYa6q2sAPRijmmitCV7YPgpIzy/06ENFnUqA9EOznEK6
	FHG3hq5D9SAcAbBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706697645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dPcLX73r3YpQEEGzySZYAJEksezsG5Bmi9BufYjnANg=;
	b=ZRZTDeEmDc/cnenutt7MpAtBmVvI2fD+FkXDjxvkeDMBhx2VgK7k5wphsnedmOkrspsS/y
	TxN32QgixN6qtjDZHc6zU8xy7GAJqMmft1b03lcjlR1x/rxzuGj2x/XfgSwuuKruM2Zb8q
	eiCjApvfP2ErePpeJ306CA9bRSHkUqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706697645;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dPcLX73r3YpQEEGzySZYAJEksezsG5Bmi9BufYjnANg=;
	b=i3NPAvBWC6FJoTL70zaa+aePduGYa6q2sAPRijmmitCV7YPgpIzy/06ENFnUqA9EOznEK6
	FHG3hq5D9SAcAbBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A8562132FA;
	Wed, 31 Jan 2024 10:40:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id c/QTKa0jumWNNwAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 31 Jan 2024 10:40:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 488DBA0809; Wed, 31 Jan 2024 11:40:45 +0100 (CET)
Date: Wed, 31 Jan 2024 11:40:45 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/19] writeback: simplify writeback iteration
Message-ID: <20240131104045.ojke3u3t6bj4vhr7@quack3>
References: <20240125085758.2393327-1-hch@lst.de>
 <20240125085758.2393327-20-hch@lst.de>
 <20240130104605.2i6mmdncuhwwwfin@quack3>
 <20240130141601.GA31330@lst.de>
 <20240130215016.npofgza5nmoxuw6m@quack3>
 <20240131071437.GA17336@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131071437.GA17336@lst.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Wed 31-01-24 08:14:37, Christoph Hellwig wrote:
> On Tue, Jan 30, 2024 at 10:50:16PM +0100, Jan Kara wrote:
> > Well, batch release needs to be only here because if writeback_get_folio()
> > returns NULL, the batch has been already released by it.
> 
> Indeed.
> 
> > So what would be
> > duplicated is only the error assignment. But I'm fine with the version in
> > the following email and actually somewhat prefer it compared the yet
> > another variant you've sent.
> 
> So how about another variant, this is closer to your original suggestion.
> But I've switched around the ordered of the folio or not branches
> from my original patch, and completely reworked and (IMHO) improved the
> comments.  it replaces patch 19 instead of being incremental to be
> readable:

Yes, this looks very good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 58b3661f5eac9e..1593a783176ca2 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1985,12 +1985,13 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
>  		struct iomap_writepage_ctx *wpc,
>  		const struct iomap_writeback_ops *ops)
>  {
> -	struct folio *folio;
> -	int ret;
> +	struct folio *folio = NULL;
> +	int ret = 0;
>  
>  	wpc->ops = ops;
> -	for_each_writeback_folio(mapping, wbc, folio, ret)
> +	while ((folio = writeback_iter(mapping, wbc, folio, &ret)))
>  		ret = iomap_do_writepage(folio, wbc, wpc);
> +
>  	if (!wpc->ioend)
>  		return ret;
>  	return iomap_submit_ioend(wpc, wpc->ioend, ret);
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index 2416da933440e2..fc4605627496fc 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -367,15 +367,8 @@ int balance_dirty_pages_ratelimited_flags(struct address_space *mapping,
>  
>  bool wb_over_bg_thresh(struct bdi_writeback *wb);
>  
> -struct folio *writeback_iter_init(struct address_space *mapping,
> -		struct writeback_control *wbc);
> -struct folio *writeback_iter_next(struct address_space *mapping,
> -		struct writeback_control *wbc, struct folio *folio, int error);
> -
> -#define for_each_writeback_folio(mapping, wbc, folio, error)		\
> -	for (folio = writeback_iter_init(mapping, wbc);			\
> -	     folio || ((error = wbc->err), false);			\
> -	     folio = writeback_iter_next(mapping, wbc, folio, error))
> +struct folio *writeback_iter(struct address_space *mapping,
> +		struct writeback_control *wbc, struct folio *folio, int *error);
>  
>  typedef int (*writepage_t)(struct folio *folio, struct writeback_control *wbc,
>  				void *data);
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 0763c4353a676a..eefcb00cb7b227 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2360,29 +2360,6 @@ void tag_pages_for_writeback(struct address_space *mapping,
>  }
>  EXPORT_SYMBOL(tag_pages_for_writeback);
>  
> -static void writeback_finish(struct address_space *mapping,
> -		struct writeback_control *wbc, pgoff_t done_index)
> -{
> -	folio_batch_release(&wbc->fbatch);
> -
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
> -	if (wbc->range_cyclic) {
> -		if (wbc->err || wbc->nr_to_write <= 0)
> -			mapping->writeback_index = done_index;
> -		else
> -			mapping->writeback_index = 0;
> -	}
> -}
> -
>  static xa_mark_t wbc_to_tag(struct writeback_control *wbc)
>  {
>  	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> @@ -2442,10 +2419,8 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
>  		filemap_get_folios_tag(mapping, &wbc->index, wbc_end(wbc),
>  				wbc_to_tag(wbc), &wbc->fbatch);
>  		folio = folio_batch_next(&wbc->fbatch);
> -		if (!folio) {
> -			writeback_finish(mapping, wbc, 0);
> +		if (!folio)
>  			return NULL;
> -		}
>  	}
>  
>  	folio_lock(folio);
> @@ -2458,60 +2433,107 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
>  	return folio;
>  }
>  
> -struct folio *writeback_iter_init(struct address_space *mapping,
> -		struct writeback_control *wbc)
> +/**
> + * writepage_iter - iterate folio of a mapping for writeback
> + * @mapping: address space structure to write
> + * @wbc: writeback context
> + * @folio: previously iterated folio (%NULL to start)
> + * @error: in-out pointer for writeback errors (see below)
> + *
> + * This function should be called in a while loop in the ->writepages
> + * implementation and returns the next folio for the writeback operation
> + * described by @wbc on @mapping.
> + *
> + * To start writeback @folio should be passed as NULL, for every following
> + * iteration the folio returned by this function previously should be passed.
> + * @error should contain the error from the previous writeback iteration when
> + * calling writeback_iter.
> + *
> + * Once the writeback described in @wbc has finished, this function will return
> + * %NULL and if there was an error in any iteration restore it to @error.
> + *
> + * Note: callers should not manually break out of the loop using break or goto.
> + */
> +struct folio *writeback_iter(struct address_space *mapping,
> +		struct writeback_control *wbc, struct folio *folio, int *error)
>  {
> -	if (wbc->range_cyclic)
> -		wbc->index = mapping->writeback_index; /* prev offset */
> -	else
> -		wbc->index = wbc->range_start >> PAGE_SHIFT;
> -
> -	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> -		tag_pages_for_writeback(mapping, wbc->index, wbc_end(wbc));
> -
> -	wbc->err = 0;
> -	folio_batch_init(&wbc->fbatch);
> -	return writeback_get_folio(mapping, wbc);
> -}
> +	if (!folio) {
> +		folio_batch_init(&wbc->fbatch);
> +		wbc->err = 0;
>  
> -struct folio *writeback_iter_next(struct address_space *mapping,
> -		struct writeback_control *wbc, struct folio *folio, int error)
> -{
> -	unsigned long nr = folio_nr_pages(folio);
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
> -	wbc->nr_to_write -= nr;
> +		/*
> +		 * To avoid livelocks when other processes dirty new pages, we
> +		 * first tag pages which should be written back and only then
> +		 * start writing them.
> +		 *
> +		 * For data-integrity sync we have to be careful so that we do
> +		 * not miss some pages (e.g., because some other process has
> +		 * cleared the TOWRITE tag we set).  The rule we follow is that
> +		 * TOWRITE tag can be cleared only by the process clearing the
> +		 * DIRTY tag (and submitting the page for I/O).
> +		 */
> +		if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> +			tag_pages_for_writeback(mapping, wbc->index,
> +					wbc_end(wbc));
> +	} else {
> +		wbc->nr_to_write -= folio_nr_pages(folio);
>  
> -	/*
> -	 * Handle the legacy AOP_WRITEPAGE_ACTIVATE magic return value.
> -	 * Eventually all instances should just unlock the folio themselves and
> -	 * return 0;
> -	 */
> -	if (error == AOP_WRITEPAGE_ACTIVATE) {
> -		folio_unlock(folio);
> -		error = 0;
> +		/*
> +		 * For integrity writeback  we have to keep going until we have
> +		 * written all the folios we tagged for writeback prior to
> +		 * entering the writeback loop, even if we run past
> +		 * wbc->nr_to_write or encounter errors, and just stash away
> +		 * the first error we encounter in wbc->err so that it can
> +		 * be retrieved on return.
> +		 *
> +		 * This is because the file system may still have state to clear
> +		 * for each folio.  We'll eventually return the first error
> +		 * encountered.
> +		 */
> +		if (wbc->sync_mode == WB_SYNC_ALL) {
> +			if (*error && !wbc->err)
> +				wbc->err = *error;
> +		} else {
> +			if (*error || wbc->nr_to_write <= 0)
> +				goto done;
> +		}
>  	}
>  
> -	if (error && !wbc->err)
> -		wbc->err = error;
> +	folio = writeback_get_folio(mapping, wbc);
> +	if (!folio) {
> +		/*
> +		 * For range cyclic writeback not finding another folios means
> +		 * that we are at the end of the file.  In that case go back
> +		 * to the start of the file for the next call.
> +		 */
> +		if (wbc->range_cyclic)
> +			mapping->writeback_index = 0;
>  
> -	/*
> -	 * For integrity sync  we have to keep going until we have written all
> -	 * the folios we tagged for writeback prior to entering the writeback
> -	 * loop, even if we run past wbc->nr_to_write or encounter errors.
> -	 * This is because the file system may still have state to clear for
> -	 * each folio.   We'll eventually return the first error encountered.
> -	 *
> -	 * For background writeback just push done_index past this folio so that
> -	 * we can just restart where we left off and media errors won't choke
> -	 * writeout for the entire file.
> -	 */
> -	if (wbc->sync_mode == WB_SYNC_NONE &&
> -	    (wbc->err || wbc->nr_to_write <= 0)) {
> -		writeback_finish(mapping, wbc, folio->index + nr);
> -		return NULL;
> +		/*
> +		 * Return the first error we encountered (if there was any) to
> +		 * the caller now that we are done.
> +		 */
> +		*error = wbc->err;
>  	}
> +	return folio;
>  
> -	return writeback_get_folio(mapping, wbc);
> +done:
> +	if (wbc->range_cyclic)
> +		mapping->writeback_index = folio->index + folio_nr_pages(folio);
> +	folio_batch_release(&wbc->fbatch);
> +	return NULL;
>  }
>  
>  /**
> @@ -2549,13 +2571,18 @@ int write_cache_pages(struct address_space *mapping,
>  		      struct writeback_control *wbc, writepage_t writepage,
>  		      void *data)
>  {
> -	struct folio *folio;
> -	int error;
> +	struct folio *folio = NULL;
> +	int error = 0;
>  
> -	for_each_writeback_folio(mapping, wbc, folio, error)
> +	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
>  		error = writepage(folio, wbc, data);
> +		if (error == AOP_WRITEPAGE_ACTIVATE) {
> +			folio_unlock(folio);
> +			error = 0;
> +		}
> +	}
>  
> -	return wbc->err;
> +	return error;
>  }
>  EXPORT_SYMBOL(write_cache_pages);
>  
> @@ -2563,13 +2590,17 @@ static int writeback_use_writepage(struct address_space *mapping,
>  		struct writeback_control *wbc)
>  {
>  	struct blk_plug plug;
> -	struct folio *folio;
> -	int err;
> +	struct folio *folio = NULL;
> +	int err = 0;
>  
>  	blk_start_plug(&plug);
> -	for_each_writeback_folio(mapping, wbc, folio, err) {
> +	while ((folio = writeback_iter(mapping, wbc, folio, &err))) {
>  		err = mapping->a_ops->writepage(&folio->page, wbc);
>  		mapping_set_error(mapping, err);
> +		if (err == AOP_WRITEPAGE_ACTIVATE) {
> +			folio_unlock(folio);
> +			err = 0;
> +		}
>  	}
>  	blk_finish_plug(&plug);
>  
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

