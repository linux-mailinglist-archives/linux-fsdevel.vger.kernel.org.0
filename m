Return-Path: <linux-fsdevel+bounces-6670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EED81B4EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 12:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591532819AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 11:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DEB6BB5A;
	Thu, 21 Dec 2023 11:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R5hSwd5l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aBv5zKwx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bSqK6InS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KAYg9i7z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539EF6A34B;
	Thu, 21 Dec 2023 11:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 78E901FDAA;
	Thu, 21 Dec 2023 11:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703158204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=collHDGGumjW8qJbYtol2//lRSPeWpd6YSa6qeEokGw=;
	b=R5hSwd5ljiBreUag5bpe26RA2Dib9xWRSV/QlS/3nrZjR3YvcP5lqg0EKSpmh0aXFdPdFC
	jNQnjf4KAlEnJVvKa+FKM+XVUasXG4un0cpuI3bD7XNao3NCIzDzIazds9JSISDvWluSyY
	ePYN6JLvZWw1EmfLOEj+fZ14TxWc0kQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703158204;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=collHDGGumjW8qJbYtol2//lRSPeWpd6YSa6qeEokGw=;
	b=aBv5zKwxXGp22hWnr06AJDGuNmzdxlk6VCN5FWEIT8F6L8UdmTiy/pcZN8ezyLfo8GO07Q
	g1wSq6RJMSKIeBCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703158203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=collHDGGumjW8qJbYtol2//lRSPeWpd6YSa6qeEokGw=;
	b=bSqK6InSzvg37MNHX9AIIVbyuK05c1VwhItUctNBqWE0yoPGIAEAnMDcteL0MLv+bbKc/z
	e+ODmi4h6YvZtwWPsrAYX03/RKcam2FBLV/i3D36KVY7Cdt1LcEdd8tNEP8L07zjPqp7of
	KZvAnEgWO/KYXCt/Qankm1sAxyQ6tZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703158203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=collHDGGumjW8qJbYtol2//lRSPeWpd6YSa6qeEokGw=;
	b=KAYg9i7zFcAH75mXRS/00Q5UnZXz80vQjKHM4zwbrMdKc8EPSx5zheHSAbZYlae6RSCeyt
	dcFNZ9qVnFAOW4AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D47E13725;
	Thu, 21 Dec 2023 11:30:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Bu+uGrshhGXdWwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Dec 2023 11:30:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1FE0EA07E3; Thu, 21 Dec 2023 12:29:59 +0100 (CET)
Date: Thu, 21 Dec 2023 12:29:59 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/17] writeback: Factor writeback_iter_init() out of
 write_cache_pages()
Message-ID: <20231221112959.du2lplmxa2uquuf6@quack3>
References: <20231218153553.807799-1-hch@lst.de>
 <20231218153553.807799-13-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153553.807799-13-hch@lst.de>
X-Spam-Level: *
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bSqK6InS;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KAYg9i7z
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.24 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.cz:dkim,suse.cz:email,infradead.org:email,suse.com:email];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.23)[72.50%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -1.24
X-Rspamd-Queue-Id: 78E901FDAA
X-Spam-Flag: NO

On Mon 18-12-23 16:35:48, Christoph Hellwig wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Make it return the first folio in the batch so that we can use it
> in a typical for() pattern.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c | 39 ++++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 70f42fd9a95b5d..efcfffa800884d 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2442,6 +2442,22 @@ static bool should_writeback_folio(struct address_space *mapping,
>  	return true;
>  }
>  
> +static struct folio *writeback_iter_init(struct address_space *mapping,
> +		struct writeback_control *wbc)
> +{
> +	if (wbc->range_cyclic)
> +		wbc->index = mapping->writeback_index; /* prev offset */
> +	else
> +		wbc->index = wbc->range_start >> PAGE_SHIFT;
> +
> +	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> +		tag_pages_for_writeback(mapping, wbc->index, wbc_end(wbc));
> +
> +	wbc->err = 0;
> +	folio_batch_init(&wbc->fbatch);
> +	return writeback_get_next(mapping, wbc);
> +}
> +
>  /**
>   * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
>   * @mapping: address space structure to write
> @@ -2477,29 +2493,14 @@ int write_cache_pages(struct address_space *mapping,
>  		      struct writeback_control *wbc, writepage_t writepage,
>  		      void *data)
>  {
> +	struct folio *folio;
>  	int error;
> -	pgoff_t end;		/* Inclusive */
>  
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
> -	wbc->err = 0;
> -
> -	for (;;) {
> -		struct folio *folio = writeback_get_next(mapping, wbc);
> +	for (folio = writeback_iter_init(mapping, wbc);
> +	     folio;
> +	     folio = writeback_get_next(mapping, wbc)) {
>  		unsigned long nr;
>  
> -		if (!folio)
> -			break;
> -
>  		folio_lock(folio);
>  		if (!should_writeback_folio(mapping, wbc, folio)) {
>  			folio_unlock(folio);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

