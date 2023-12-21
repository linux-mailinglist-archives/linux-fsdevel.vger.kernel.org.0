Return-Path: <linux-fsdevel+bounces-6673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEF281B527
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 12:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19BC1C2488F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 11:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DA86E2A1;
	Thu, 21 Dec 2023 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3VQTdVtm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5DbusDg5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JJ0Lr7Us";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kZu9TC90"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7186BB47;
	Thu, 21 Dec 2023 11:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CF7FE21E3E;
	Thu, 21 Dec 2023 11:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703159208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8dO5uqpEU5oXY6n+R8pV+MqdfZSYD5IInOM8E+njSIY=;
	b=3VQTdVtmBVWQEIaOt/kgB0fFwteyyJUHOYv36c4X/J4elS7A6JsxMu+5OuSGfGssREDOzZ
	QbUmtKJ/dapZjNDuW60g5RMEOkHTWicJWSzg4nqFQUNm1/+KxPNHIbjt39YjEjoedm5zbx
	3nRz60zNeamRVhvlBpHyWiZwaqtDByk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703159208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8dO5uqpEU5oXY6n+R8pV+MqdfZSYD5IInOM8E+njSIY=;
	b=5DbusDg5X2MH8j+AeP+ksP1kQDBm6Ua/FfWGC8wE4WTbMcIYz6qBPAN/mEP8cKXlrCG4Zf
	KYTlfYuBpZ4EniDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703159207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8dO5uqpEU5oXY6n+R8pV+MqdfZSYD5IInOM8E+njSIY=;
	b=JJ0Lr7Us+yKSW3d29mG8sL6Dj1h+BW+sSvkYszPHxFvbqTdmWH0CgBKT8wWFQPTPay9GWa
	H2tpgRaks7Rgdl0XLbU6J7RZCAcTFtT/lHw6tHrR/asZ9cd9hMYYqR066n7pMd6/UA16We
	5UgpKoil4VclIp90aOfMiZbJmhXoGGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703159207;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8dO5uqpEU5oXY6n+R8pV+MqdfZSYD5IInOM8E+njSIY=;
	b=kZu9TC908huPzG1Xeiz42+19dKlsTpqRO0gIJHTOqUII6xbzpP7lZmm29eOHBFBFwKujqD
	pvo02p6OkrMJDHAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3BB313725;
	Thu, 21 Dec 2023 11:46:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7FjIL6clhGWCYQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Dec 2023 11:46:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7C461A07E3; Thu, 21 Dec 2023 12:46:43 +0100 (CET)
Date: Thu, 21 Dec 2023 12:46:43 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/17] writeback: Factor writeback_iter_next() out of
 write_cache_pages()
Message-ID: <20231221114643.y5opxgchscyj7rwn@quack3>
References: <20231218153553.807799-1-hch@lst.de>
 <20231218153553.807799-15-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153553.807799-15-hch@lst.de>
X-Spam-Level: 
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JJ0Lr7Us;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kZu9TC90
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,suse.com:email,suse.cz:dkim,suse.cz:email];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: CF7FE21E3E
X-Spam-Flag: NO

On Mon 18-12-23 16:35:50, Christoph Hellwig wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Pull the post-processing of the writepage_t callback into a
> separate function.  That means changing writeback_finish() to
> return NULL, and writeback_get_next() to call writeback_finish()
> when we naturally run out of folios.

The part about writeback_finish() does not seem to be true anymore.
Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/page-writeback.c | 85 ++++++++++++++++++++++++---------------------
>  1 file changed, 45 insertions(+), 40 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 9d37dd5e58ffb6..0771f19950081f 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2449,8 +2449,10 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
>  
>  	for (;;) {
>  		folio = writeback_get_next(mapping, wbc);
> -		if (!folio)
> +		if (!folio) {
> +			writeback_finish(mapping, wbc, 0);
>  			return NULL;
> +		}
>  		folio_lock(folio);
>  		if (likely(should_writeback_folio(mapping, wbc, folio)))
>  			break;
> @@ -2477,6 +2479,46 @@ static struct folio *writeback_iter_init(struct address_space *mapping,
>  	return writeback_get_folio(mapping, wbc);
>  }
>  
> +static struct folio *writeback_iter_next(struct address_space *mapping,
> +		struct writeback_control *wbc, struct folio *folio, int error)
> +{
> +	unsigned long nr = folio_nr_pages(folio);
> +
> +	wbc->nr_to_write -= nr;
> +
> +	/*
> +	 * Handle the legacy AOP_WRITEPAGE_ACTIVATE magic return value.
> +	 * Eventually all instances should just unlock the folio themselves and
> +	 * return 0;
> +	 */
> +	if (error == AOP_WRITEPAGE_ACTIVATE) {
> +		folio_unlock(folio);
> +		error = 0;
> +	}
> +
> +	if (error && !wbc->err)
> +		wbc->err = error;
> +
> +	/*
> +	 * For integrity sync  we have to keep going until we have written all
> +	 * the folios we tagged for writeback prior to entering the writeback
> +	 * loop, even if we run past wbc->nr_to_write or encounter errors.
> +	 * This is because the file system may still have state to clear for
> +	 * each folio.   We'll eventually return the first error encountered.
> +	 *
> +	 * For background writeback just push done_index past this folio so that
> +	 * we can just restart where we left off and media errors won't choke
> +	 * writeout for the entire file.
> +	 */
> +	if (wbc->sync_mode == WB_SYNC_NONE &&
> +	    (wbc->err || wbc->nr_to_write <= 0)) {
> +		writeback_finish(mapping, wbc, folio->index + nr);
> +		return NULL;
> +	}
> +
> +	return writeback_get_folio(mapping, wbc);
> +}
> +
>  /**
>   * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
>   * @mapping: address space structure to write
> @@ -2517,47 +2559,10 @@ int write_cache_pages(struct address_space *mapping,
>  
>  	for (folio = writeback_iter_init(mapping, wbc);
>  	     folio;
> -	     folio = writeback_get_folio(mapping, wbc)) {
> -		unsigned long nr;
> -
> +	     folio = writeback_iter_next(mapping, wbc, folio, error))
>  		error = writepage(folio, wbc, data);
> -		nr = folio_nr_pages(folio);
> -		wbc->nr_to_write -= nr;
> -
> -		/*
> -		 * Handle the legacy AOP_WRITEPAGE_ACTIVATE magic return value.
> -		 * Eventually all instances should just unlock the folio
> -		 * themselves and return 0;
> -		 */
> -		if (error == AOP_WRITEPAGE_ACTIVATE) {
> -			folio_unlock(folio);
> -			error = 0;
> -		}
> -
> -		if (error && !wbc->err)
> -			wbc->err = error;
>  
> -		/*
> -		 * For integrity sync  we have to keep going until we have
> -		 * written all the folios we tagged for writeback prior to
> -		 * entering this loop, even if we run past wbc->nr_to_write or
> -		 * encounter errors.  This is because the file system may still
> -		 * have state to clear for each folio.   We'll eventually return
> -		 * the first error encountered.
> -		 *
> -		 * For background writeback just push done_index past this folio
> -		 * so that we can just restart where we left off and media
> -		 * errors won't choke writeout for the entire file.
> -		 */
> -		if (wbc->sync_mode == WB_SYNC_NONE &&
> -		    (wbc->err || wbc->nr_to_write <= 0)) {
> -			writeback_finish(mapping, wbc, folio->index + nr);
> -			return error;
> -		}
> -	}
> -
> -	writeback_finish(mapping, wbc, 0);
> -	return 0;
> +	return wbc->err;
>  }
>  EXPORT_SYMBOL(write_cache_pages);
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

