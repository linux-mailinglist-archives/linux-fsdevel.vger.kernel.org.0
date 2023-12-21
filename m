Return-Path: <linux-fsdevel+bounces-6674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A413081B545
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 12:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D10286BBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 11:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF746E2BD;
	Thu, 21 Dec 2023 11:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="khc6y35w";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ld55sd1l";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="khc6y35w";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ld55sd1l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5206A327;
	Thu, 21 Dec 2023 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 767E621E40;
	Thu, 21 Dec 2023 11:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703159509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tJU+N/X0wPpRyjLNSDyU7/A5nuKKkSG6fh2fZzUVbgg=;
	b=khc6y35ww4SWPoGtdOWsxicW1xqDkRHHnlvlkWaYajf7RbskdRX3lR/x28jBQPfEk9TvdW
	rJeq+NMXBp6PVTIg05LqmmhBdF1mtSi+YVUIShZjOQiw1drLVWbgoI2rpeVknC4/HnmB3Y
	cMXJu6PQ53DKjsyR1p5kX1+s8Dgd2OI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703159509;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tJU+N/X0wPpRyjLNSDyU7/A5nuKKkSG6fh2fZzUVbgg=;
	b=Ld55sd1lsp8FieBhjWWavqqa4BkYb0OMxpzkSjQnRx6UtuPnJY7xDfh3rIANd0A2VNMGbI
	N7y4zmX2Z8c9nYAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703159509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tJU+N/X0wPpRyjLNSDyU7/A5nuKKkSG6fh2fZzUVbgg=;
	b=khc6y35ww4SWPoGtdOWsxicW1xqDkRHHnlvlkWaYajf7RbskdRX3lR/x28jBQPfEk9TvdW
	rJeq+NMXBp6PVTIg05LqmmhBdF1mtSi+YVUIShZjOQiw1drLVWbgoI2rpeVknC4/HnmB3Y
	cMXJu6PQ53DKjsyR1p5kX1+s8Dgd2OI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703159509;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tJU+N/X0wPpRyjLNSDyU7/A5nuKKkSG6fh2fZzUVbgg=;
	b=Ld55sd1lsp8FieBhjWWavqqa4BkYb0OMxpzkSjQnRx6UtuPnJY7xDfh3rIANd0A2VNMGbI
	N7y4zmX2Z8c9nYAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6ACC813725;
	Thu, 21 Dec 2023 11:51:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FCcJGtUmhGVkYwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Dec 2023 11:51:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0F223A07E3; Thu, 21 Dec 2023 12:51:49 +0100 (CET)
Date: Thu, 21 Dec 2023 12:51:49 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/17] writeback: Add for_each_writeback_folio()
Message-ID: <20231221115149.ke74ddapwb7q6fdz@quack3>
References: <20231218153553.807799-1-hch@lst.de>
 <20231218153553.807799-16-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153553.807799-16-hch@lst.de>
X-Spam-Level: 
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
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,infradead.org:email];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Mon 18-12-23 16:35:51, Christoph Hellwig wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Wrap up the iterator with a nice bit of syntactic sugar.  Now the
> caller doesn't need to know about wbc->err and can just return error,
> not knowing that the iterator took care of storing errors correctly.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Not sure if the trick with 'error' variable isn't a bit too clever for us
;) We'll see how many bugs it will cause in the future... Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> +#define for_each_writeback_folio(mapping, wbc, folio, error)		\
> +	for (folio = writeback_iter_init(mapping, wbc);			\
> +	     folio || ((error = wbc->err), false);			\
> +	     folio = writeback_iter_next(mapping, wbc, folio, error))
> +
>  typedef int (*writepage_t)(struct folio *folio, struct writeback_control *wbc,
>  				void *data);
>  
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 0771f19950081f..fbffd30a9cc93f 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2463,7 +2463,7 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
>  	return folio;
>  }
>  
> -static struct folio *writeback_iter_init(struct address_space *mapping,
> +struct folio *writeback_iter_init(struct address_space *mapping,
>  		struct writeback_control *wbc)
>  {
>  	if (wbc->range_cyclic)
> @@ -2479,7 +2479,7 @@ static struct folio *writeback_iter_init(struct address_space *mapping,
>  	return writeback_get_folio(mapping, wbc);
>  }
>  
> -static struct folio *writeback_iter_next(struct address_space *mapping,
> +struct folio *writeback_iter_next(struct address_space *mapping,
>  		struct writeback_control *wbc, struct folio *folio, int error)
>  {
>  	unsigned long nr = folio_nr_pages(folio);
> @@ -2557,9 +2557,7 @@ int write_cache_pages(struct address_space *mapping,
>  	struct folio *folio;
>  	int error;
>  
> -	for (folio = writeback_iter_init(mapping, wbc);
> -	     folio;
> -	     folio = writeback_iter_next(mapping, wbc, folio, error))
> +	for_each_writeback_folio(mapping, wbc, folio, error)
>  		error = writepage(folio, wbc, data);
>  
>  	return wbc->err;
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

