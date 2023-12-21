Return-Path: <linux-fsdevel+bounces-6665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECD281B4BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 12:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5B61C23776
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 11:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470216ABB5;
	Thu, 21 Dec 2023 11:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pnETPrJh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ojdikVS8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xvpDs7i3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8DwrDG7W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFE76BB44;
	Thu, 21 Dec 2023 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1A02C1FB74;
	Thu, 21 Dec 2023 11:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703157473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lMCSXvKrQmzSHPEjvHeGpGs44ARAmvqkLgvIRNnTtig=;
	b=pnETPrJhteg5RB0DUE8tAJB4EjfNapbjFUM/MIg8Vxwn8PEuU38AoDkJHCf9n8NfRJ2Wl0
	Psjv/OfoA80DlnoNnX6P+BnElZUKv6aPwgRco25bCxElC/gbOu7IgrRZP2cGGcGDKwzc14
	qN24jlQ9w/VYbuGuIBOgaRk+wFO5748=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703157473;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lMCSXvKrQmzSHPEjvHeGpGs44ARAmvqkLgvIRNnTtig=;
	b=ojdikVS8DkebDKlIGcdOCiUb+Ksp3CQnB0Vb6FbAGc7rcE1uHfFTXlWHSDyXg7dhPNE/dp
	TdlWZ4XnkUxrFcCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703157472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lMCSXvKrQmzSHPEjvHeGpGs44ARAmvqkLgvIRNnTtig=;
	b=xvpDs7i3BHZ9zXzzOMdoEgoZz+grtKOq+/JNvWYPoiVLx7fRP9bn+yfgPwNycufE53V3Ky
	hcr23WWkpNq0twQN1xLrh91VbDfbqGO0e+9KFG1iT4oZJS6kHkvoqcSsmLQwZHIUsX5aXp
	AeyqGvIQv6SwKysR4h4HFEgvwb7GwC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703157472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lMCSXvKrQmzSHPEjvHeGpGs44ARAmvqkLgvIRNnTtig=;
	b=8DwrDG7Wko8MrW6UV+mDy/nO7rxhMr4BQnUnXThk2rqn9xBGUn+AuiD/I0L+m9Wm1Mag8Z
	HkQl9eKaiYOJOTAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C9D713725;
	Thu, 21 Dec 2023 11:17:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7ME1A+AehGXpVwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Dec 2023 11:17:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 90645A07E3; Thu, 21 Dec 2023 12:17:43 +0100 (CET)
Date: Thu, 21 Dec 2023 12:17:43 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/17] writeback: Factor writeback_get_batch() out of
 write_cache_pages()
Message-ID: <20231221111743.sppmjkyah3u4ao6g@quack3>
References: <20231218153553.807799-1-hch@lst.de>
 <20231218153553.807799-8-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153553.807799-8-hch@lst.de>
X-Spam-Level: 
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xvpDs7i3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8DwrDG7W
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.95 / 50.00];
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,lst.de:email,suse.com:email,suse.cz:dkim,suse.cz:email];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.94)[86.52%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -1.95
X-Rspamd-Queue-Id: 1A02C1FB74
X-Spam-Flag: NO

On Mon 18-12-23 16:35:43, Christoph Hellwig wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This simple helper will be the basis of the writeback iterator.
> To make this work, we need to remember the current index
> and end positions in writeback_control.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> [hch: heavily rebased, add helpers to get the tag and end index,
>       don't keep the end index in struct writeback_control]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Just two nits below. However you decide about them feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> +static pgoff_t wbc_end(struct writeback_control *wbc)
> +{
> +	if (wbc->range_cyclic)
> +		return -1;
> +	return wbc->range_end >> PAGE_SHIFT;
> +}
> +
> +static void writeback_get_batch(struct address_space *mapping,
> +		struct writeback_control *wbc)
> +{
> +	folio_batch_release(&wbc->fbatch);
> +	cond_resched();

I'd prefer to have cond_resched() explicitely in the writeback loop instead
of hidden here in writeback_get_batch() where it logically does not make
too much sense to me...

> +	filemap_get_folios_tag(mapping, &wbc->index, wbc_end(wbc),
> +			wbc_to_tag(wbc), &wbc->fbatch);
> +}
> +
>  /**
>   * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
>   * @mapping: address space structure to write
> @@ -2419,38 +2442,30 @@ int write_cache_pages(struct address_space *mapping,
>  		      void *data)
>  {
>  	int error;
> -	int nr_folios;
> -	pgoff_t index;
>  	pgoff_t end;		/* Inclusive */
> -	xa_mark_t tag;
>  
>  	if (wbc->range_cyclic) {
> -		index = mapping->writeback_index; /* prev offset */
> +		wbc->index = mapping->writeback_index; /* prev offset */
>  		end = -1;
>  	} else {
> -		index = wbc->range_start >> PAGE_SHIFT;
> +		wbc->index = wbc->range_start >> PAGE_SHIFT;
>  		end = wbc->range_end >> PAGE_SHIFT;
>  	}

Maybe we should have:
	end = wbc_end(wbc);

when we have the helper? But I guess this gets cleaned up in later patches
anyway so whatever.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

