Return-Path: <linux-fsdevel+bounces-9518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 265BD8421D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 11:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4840A1C23DFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 10:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F273F67744;
	Tue, 30 Jan 2024 10:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gtMjDf5s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4wMoKlQh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tg8PAfjr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8q27gk6s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE5560EDB;
	Tue, 30 Jan 2024 10:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611572; cv=none; b=MipXPr2ePM9JYUXPCjNhgTks+5X/v1rkDf9QcyeoRcrnQK18KqxPPGUuyplRNQ+pYTt8xugya9w9JgsEFxK6iIgnj5eUU2vv3Rj2HucBpuZh76lZDLGqVckaMCqSFACSMoWjuy+UrnvwhNt1XsE0DIBCl30+8sxutBnsU2Exang=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611572; c=relaxed/simple;
	bh=uck9Y05f7mfsXQNO/8efqYRcDvUO0vN93MooUwG+OQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNuiW9X1MuuV9yWmYlMTyuSP4gpW5Wb2XaMgBIqMfc3xapQtl6Tu6vEfLd4MZoi0hlOKWtUTFVmIJ1XvuCMPUqu8+wGsDoqlNfxXpkkfTRG2cKVW64JTOdUIO+jzzjl5Yxm+KQmR1tWaZr0TcodipBd7o/wATedUbmCeQlVZ8YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gtMjDf5s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4wMoKlQh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tg8PAfjr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8q27gk6s; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 19B95222D9;
	Tue, 30 Jan 2024 10:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706611568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rd4laTPRq+btQlxHww6bI0r93gTPlM9zRmVQJZwHTLA=;
	b=gtMjDf5sG1IhZDPGpqVgyLrBptiO3pdwyR6jSHrYN3bjxdtYkzIxL2PdF50p5YbseJZvnB
	/8H4Jly+YqPnRVFvwKAu/RMtXGeT7FRjpkzT2Eb/4nbw8rD9aagEZl/l1UN4VxX+C7fxon
	XAiihgKbqPn2n0nVEMN864QKS4y3gSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706611568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rd4laTPRq+btQlxHww6bI0r93gTPlM9zRmVQJZwHTLA=;
	b=4wMoKlQhXkMR2/C0sJSU6HKIX2Sd1aklC78v8F5E2KwhCPXc9JhMdN2tmMHj0d7a9tnQ/4
	UQ6Xa2pWGryJfGBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706611566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rd4laTPRq+btQlxHww6bI0r93gTPlM9zRmVQJZwHTLA=;
	b=Tg8PAfjrkj0kivWc0IYSydT3PR5xS+P2VVhiWGnnx1hJtX0IXfcISdM7fvXSE1WYmaaMYW
	g8M970sxT6nF49Oh5mS9SwocltuFO21lkg53abt1EhUmhYbMHrV/34/v/VDwFExs7m2kZ9
	E1VMnW+MFWmCm3eWtvfKHQqBDXZN2nM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706611566;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rd4laTPRq+btQlxHww6bI0r93gTPlM9zRmVQJZwHTLA=;
	b=8q27gk6sjeXkl3adNWaO5+zphzC4qxeJ/QthFB/SGTHyc6MFq2gEf+K5pJdUP2/43lWE9q
	E7ieQCnAT+r3X2BQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EE27413212;
	Tue, 30 Jan 2024 10:46:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 1dscOm3TuGVEfQAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 30 Jan 2024 10:46:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8D741A0807; Tue, 30 Jan 2024 11:46:05 +0100 (CET)
Date: Tue, 30 Jan 2024 11:46:05 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/19] writeback: simplify writeback iteration
Message-ID: <20240130104605.2i6mmdncuhwwwfin@quack3>
References: <20240125085758.2393327-1-hch@lst.de>
 <20240125085758.2393327-20-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125085758.2393327-20-hch@lst.de>
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
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Thu 25-01-24 09:57:58, Christoph Hellwig wrote:
> Based on the feedback from Jan I've tried to figure out how to
> avoid the error magic in the for_each_writeback_folio.  This patch
> tries to implement this by switching to an open while loop over a
> single writeback_iter() function:
> 
> 	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
> 		...
> 	}
> 
> the twist here is that the error value is passed by reference, so that
> the iterator can restore it when breaking out of the loop.
> 
> Additionally it moves the AOP_WRITEPAGE_ACTIVATE out of the iterator
> and into the callers, in preparation for eventually killing it off
> with the phase out of write_cache_pages().
> 
> To me this form of the loop feels easier to follow, and it has the
> added advantage that writeback_iter() can actually be nicely used in
> nested loops, which should help with further iterizing the iomap
> writeback code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looking at it now I'm thinking whether we would not be better off to
completely dump the 'error' argument of writeback_iter() /
writeback_iter_next() and just make all .writepage implementations set
wbc->err directly. But that means touching all the ~20 writepage
implementations we still have...

Couple of comments regarding this implementation below (overall I agree it
seems somewhat easier to follow the code).

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
> -	unsigned long nr = folio_nr_pages(folio);
> +	if (folio) {
> +		wbc->nr_to_write -= folio_nr_pages(folio);
> +		if (*error && !wbc->err)
> +			wbc->err = *error;
>  
> -	wbc->nr_to_write -= nr;
> -
> -	/*
> -	 * Handle the legacy AOP_WRITEPAGE_ACTIVATE magic return value.
> -	 * Eventually all instances should just unlock the folio themselves and
> -	 * return 0;
> -	 */
> -	if (error == AOP_WRITEPAGE_ACTIVATE) {
> -		folio_unlock(folio);
> -		error = 0;
> +		/*
> +		 * For integrity sync  we have to keep going until we have
> +		 * written all the folios we tagged for writeback prior to
> +		 * entering the writeback loop, even if we run past
> +		 * wbc->nr_to_write or encounter errors.
> +		 *
> +		 * This is because the file system may still have state to clear
> +		 * for each folio.  We'll eventually return the first error
> +		 * encountered.
> +		 *
> +		 * For background writeback just push done_index past this folio
> +		 * so that we can just restart where we left off and media
> +		 * errors won't choke writeout for the entire file.
> +		 */
> +		if (wbc->sync_mode == WB_SYNC_NONE &&
> +		    (wbc->err || wbc->nr_to_write <= 0))
> +			goto finish;

I think it would be a bit more comprehensible if we replace the goto with:
			folio_batch_release(&wbc->fbatch);
			if (wbc->range_cyclic)
				mapping->writeback_index =
					folio->index + folio_nr_pages(folio);
			*error = wbc->err;
			return NULL;

> +	} else {
> +		if (wbc->range_cyclic)
> +			wbc->index = mapping->writeback_index; /* prev offset */
> +		else
> +			wbc->index = wbc->range_start >> PAGE_SHIFT;
> +		if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> +			tag_pages_for_writeback(mapping, wbc->index,
> +					wbc_end(wbc));
> +		folio_batch_init(&wbc->fbatch);
> +		wbc->err = 0;
>  	}
>  
> -	if (error && !wbc->err)
> -		wbc->err = error;
> +	folio = writeback_get_folio(mapping, wbc);
> +	if (!folio)
> +		goto finish;

And here we just need to do:
		if (wbc->range_cyclic)
			mapping->writeback_index = 0;
		*error = wbc->err;
		return NULL;

> +	return folio;
> +
> +finish:
> +	folio_batch_release(&wbc->fbatch);
>  
>  	/*
> -	 * For integrity sync  we have to keep going until we have written all
> -	 * the folios we tagged for writeback prior to entering the writeback
> -	 * loop, even if we run past wbc->nr_to_write or encounter errors.
> -	 * This is because the file system may still have state to clear for
> -	 * each folio.   We'll eventually return the first error encountered.
> +	 * For range cyclic writeback we need to remember where we stopped so
> +	 * that we can continue there next time we are called.  If  we hit the
> +	 * last page and there is more work to be done, wrap back to the start
> +	 * of the file.
>  	 *
> -	 * For background writeback just push done_index past this folio so that
> -	 * we can just restart where we left off and media errors won't choke
> -	 * writeout for the entire file.
> +	 * For non-cyclic writeback we always start looking up at the beginning
> +	 * of the file if we are called again, which can only happen due to
> +	 * -ENOMEM from the file system.
>  	 */
> -	if (wbc->sync_mode == WB_SYNC_NONE &&
> -	    (wbc->err || wbc->nr_to_write <= 0)) {
> -		writeback_finish(mapping, wbc, folio->index + nr);
> -		return NULL;
> +	if (wbc->range_cyclic) {
> +		WARN_ON_ONCE(wbc->sync_mode != WB_SYNC_NONE);
> +		if (wbc->err || wbc->nr_to_write <= 0)
> +			mapping->writeback_index =
> +				folio->index + folio_nr_pages(folio);
> +		else
> +			mapping->writeback_index = 0;
>  	}
> -
> -	return writeback_get_folio(mapping, wbc);
> +	*error = wbc->err;
> +	return NULL;
>  }
>  
>  /**
> @@ -2563,13 +2575,17 @@ static int writeback_use_writepage(struct address_space *mapping,
>  		struct writeback_control *wbc)
>  {
>  	struct blk_plug plug;
> -	struct folio *folio;
> -	int err;
> +	struct folio *folio = 0;
			     ^^ NULL please


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
> @@ -2590,6 +2606,8 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
>  			ret = mapping->a_ops->writepages(mapping, wbc);
>  		} else if (mapping->a_ops->writepage) {
>  			ret = writeback_use_writepage(mapping, wbc);
> +			if (!ret)
> +				ret = wbc->err;

AFAICT this should not be needed as writeback_iter() made sure wbc->err is
returned when set?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

