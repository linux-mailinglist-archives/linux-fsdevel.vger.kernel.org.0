Return-Path: <linux-fsdevel+bounces-6667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6187B81B4DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 12:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2120E2889DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 11:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741ED6E2D8;
	Thu, 21 Dec 2023 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BTe4KvlF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nyqi6SfY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BTe4KvlF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nyqi6SfY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3399A6E2A0;
	Thu, 21 Dec 2023 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 36D911FB42;
	Thu, 21 Dec 2023 11:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703157894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gpLOwhQDWouiGcVDXpIifh6pZTYZjbA5NrwZ5EtKOwU=;
	b=BTe4KvlFeMKXD4GzKy6tugrUnZv+8GzxU8Pl0LlKXOQ8e1voM9n0fr4cv+0IC0ZpEedEV7
	1QYzLhM6wXotz9D48H4nwucDCrJdEjXQyg/jhvF6IFr+C1Mf015IAL5D7OpPL/Y+GrUF0R
	HLAEoehPBvcnIQu73kjH5HYmqp9eOCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703157894;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gpLOwhQDWouiGcVDXpIifh6pZTYZjbA5NrwZ5EtKOwU=;
	b=nyqi6SfYR/+bfXNK4QMDxTcneXkkOuV59UF9iRYKAfmZVx7KGCkj8RRbxSGBYW0jgY8ZjO
	TCwKp/mJyF2cm7Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703157894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gpLOwhQDWouiGcVDXpIifh6pZTYZjbA5NrwZ5EtKOwU=;
	b=BTe4KvlFeMKXD4GzKy6tugrUnZv+8GzxU8Pl0LlKXOQ8e1voM9n0fr4cv+0IC0ZpEedEV7
	1QYzLhM6wXotz9D48H4nwucDCrJdEjXQyg/jhvF6IFr+C1Mf015IAL5D7OpPL/Y+GrUF0R
	HLAEoehPBvcnIQu73kjH5HYmqp9eOCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703157894;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gpLOwhQDWouiGcVDXpIifh6pZTYZjbA5NrwZ5EtKOwU=;
	b=nyqi6SfYR/+bfXNK4QMDxTcneXkkOuV59UF9iRYKAfmZVx7KGCkj8RRbxSGBYW0jgY8ZjO
	TCwKp/mJyF2cm7Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27C1B13725;
	Thu, 21 Dec 2023 11:24:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8VZvCYYghGVCWgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Dec 2023 11:24:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AC402A07E3; Thu, 21 Dec 2023 12:24:53 +0100 (CET)
Date: Thu, 21 Dec 2023 12:24:53 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/17] writeback: Simplify the loops in
 write_cache_pages()
Message-ID: <20231221112453.4gggfki67lxwtor7@quack3>
References: <20231218153553.807799-1-hch@lst.de>
 <20231218153553.807799-10-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153553.807799-10-hch@lst.de>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
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
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,lst.de:email,suse.com:email,infradead.org:email];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Mon 18-12-23 16:35:45, Christoph Hellwig wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Collapse the two nested loops into one.  This is needed as a step
> towards turning this into an iterator.
> 
> Note that this drops the "index <= end" check in the previous outer loop
> and just relies on filemap_get_folios_tag() to return 0 entries when
> index > end.  This actually has a subtle implication when end == -1
> because then the returned index will be -1 as well and thus if there is
> page present on index -1, we could be looping indefinitely. But as the
> comment in filemap_get_folios_tag documents this as already broken anyway
> we should not worry about it here either.  The fix for that would
> probably a change to the filemap_get_folios_tag() calling convention.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> [hch: updated the commit log based on feedback from Jan Kara]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c | 94 ++++++++++++++++++++++-----------------------
>  1 file changed, 46 insertions(+), 48 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 2a004c0b9bdfbf..c7983ea3040be4 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2473,6 +2473,7 @@ int write_cache_pages(struct address_space *mapping,
>  {
>  	int error;
>  	pgoff_t end;		/* Inclusive */
> +	int i = 0;
>  
>  	if (wbc->range_cyclic) {
>  		wbc->index = mapping->writeback_index; /* prev offset */
> @@ -2487,63 +2488,60 @@ int write_cache_pages(struct address_space *mapping,
>  	folio_batch_init(&wbc->fbatch);
>  	wbc->err = 0;
>  
> -	while (wbc->index <= end) {
> -		int i;
> -
> -		writeback_get_batch(mapping, wbc);
> +	for (;;) {
> +		struct folio *folio;
> +		unsigned long nr;
>  
> +		if (i == wbc->fbatch.nr) {
> +			writeback_get_batch(mapping, wbc);
> +			i = 0;
> +		}
>  		if (wbc->fbatch.nr == 0)
>  			break;
>  
> -		for (i = 0; i < wbc->fbatch.nr; i++) {
> -			struct folio *folio = wbc->fbatch.folios[i];
> -			unsigned long nr;
> +		folio = wbc->fbatch.folios[i++];
>  
> -			folio_lock(folio);
> -			if (!should_writeback_folio(mapping, wbc, folio)) {
> -				folio_unlock(folio);
> -				continue;
> -			}
> +		folio_lock(folio);
> +		if (!should_writeback_folio(mapping, wbc, folio)) {
> +			folio_unlock(folio);
> +			continue;
> +		}
>  
> -			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
> +		trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
>  
> -			error = writepage(folio, wbc, data);
> -			nr = folio_nr_pages(folio);
> -			wbc->nr_to_write -= nr;
> +		error = writepage(folio, wbc, data);
> +		nr = folio_nr_pages(folio);
> +		wbc->nr_to_write -= nr;
>  
> -			/*
> -			 * Handle the legacy AOP_WRITEPAGE_ACTIVATE magic return
> -			 * value.  Eventually all instances should just unlock
> -			 * the folio themselves and return 0;
> -			 */
> -			if (error == AOP_WRITEPAGE_ACTIVATE) {
> -				folio_unlock(folio);
> -				error = 0;
> -			}
> -		
> -			if (error && !wbc->err)
> -				wbc->err = error;
> +		/*
> +		 * Handle the legacy AOP_WRITEPAGE_ACTIVATE magic return value.
> +		 * Eventually all instances should just unlock the folio
> +		 * themselves and return 0;
> +		 */
> +		if (error == AOP_WRITEPAGE_ACTIVATE) {
> +			folio_unlock(folio);
> +			error = 0;
> +		}
>  
> -			/*
> -			 * For integrity sync  we have to keep going until we
> -			 * have written all the folios we tagged for writeback
> -			 * prior to entering this loop, even if we run past
> -			 * wbc->nr_to_write or encounter errors.  This is
> -			 * because the file system may still have state to clear
> -			 * for each folio.   We'll eventually return the first
> -			 * error encountered.
> -			 *
> -			 * For background writeback just push done_index past
> -			 * this folio so that we can just restart where we left
> -			 * off and media errors won't choke writeout for the
> -			 * entire file.
> -			 */
> -			if (wbc->sync_mode == WB_SYNC_NONE &&
> -			    (wbc->err || wbc->nr_to_write <= 0)) {
> -				writeback_finish(mapping, wbc,
> -						folio->index + nr);
> -				return error;
> -			}
> +		if (error && !wbc->err)
> +			wbc->err = error;
> +
> +		/*
> +		 * For integrity sync  we have to keep going until we have
> +		 * written all the folios we tagged for writeback prior to
> +		 * entering this loop, even if we run past wbc->nr_to_write or
> +		 * encounter errors.  This is because the file system may still
> +		 * have state to clear for each folio.   We'll eventually return
> +		 * the first error encountered.
> +		 *
> +		 * For background writeback just push done_index past this folio
> +		 * so that we can just restart where we left off and media
> +		 * errors won't choke writeout for the entire file.
> +		 */
> +		if (wbc->sync_mode == WB_SYNC_NONE &&
> +		    (wbc->err || wbc->nr_to_write <= 0)) {
> +			writeback_finish(mapping, wbc, folio->index + nr);
> +			return error;
>  		}
>  	}
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

