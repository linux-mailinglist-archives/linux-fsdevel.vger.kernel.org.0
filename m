Return-Path: <linux-fsdevel+bounces-6669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0A181B4E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 12:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72C0288CDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 11:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948C36BB57;
	Thu, 21 Dec 2023 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Aw+Z00eg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yhuRwjmw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Aw+Z00eg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yhuRwjmw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A4B6AB8F;
	Thu, 21 Dec 2023 11:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 94F9B21DBA;
	Thu, 21 Dec 2023 11:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703158096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mNV4sKWjBzrSblGFdnAtW7MuJWksBQI9Sijhka+UDuM=;
	b=Aw+Z00eg2ud5SAR3cPWmKoamQhO6/HyNIIlQsO/WP6yP1Q+ODJ45joERxjMXVLMqXgR6RD
	5AahVpNnmWP/yJivpglPO5LRwG+O8bxyiwaEfr/0XfDrlR1FfR70h0E8ZQVJaV8nRyKX5X
	0sMbseKgN2ylVrK56/guYI7D945s+iE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703158096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mNV4sKWjBzrSblGFdnAtW7MuJWksBQI9Sijhka+UDuM=;
	b=yhuRwjmwAb8CoCCtD0gdfRAEstxW+G9ztS6GS37ZL9k2CxGxEIZl8r5rzPjrNsczTuRPKw
	Xg/PokBZyUiT/iAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703158096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mNV4sKWjBzrSblGFdnAtW7MuJWksBQI9Sijhka+UDuM=;
	b=Aw+Z00eg2ud5SAR3cPWmKoamQhO6/HyNIIlQsO/WP6yP1Q+ODJ45joERxjMXVLMqXgR6RD
	5AahVpNnmWP/yJivpglPO5LRwG+O8bxyiwaEfr/0XfDrlR1FfR70h0E8ZQVJaV8nRyKX5X
	0sMbseKgN2ylVrK56/guYI7D945s+iE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703158096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mNV4sKWjBzrSblGFdnAtW7MuJWksBQI9Sijhka+UDuM=;
	b=yhuRwjmwAb8CoCCtD0gdfRAEstxW+G9ztS6GS37ZL9k2CxGxEIZl8r5rzPjrNsczTuRPKw
	Xg/PokBZyUiT/iAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8922213725;
	Thu, 21 Dec 2023 11:28:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UGN4IVAhhGVMWwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Dec 2023 11:28:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 31D20A07E3; Thu, 21 Dec 2023 12:28:12 +0100 (CET)
Date: Thu, 21 Dec 2023 12:28:12 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/17] writeback: Use the folio_batch queue iterator
Message-ID: <20231221112812.fkjumae6xexnw2lk@quack3>
References: <20231218153553.807799-1-hch@lst.de>
 <20231218153553.807799-12-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153553.807799-12-hch@lst.de>
X-Spam-Level: *
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.17 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,lst.de:email,suse.cz:dkim,suse.cz:email,infradead.org:email];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.36)[76.64%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Aw+Z00eg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yhuRwjmw
X-Spam-Score: -0.17
X-Rspamd-Queue-Id: 94F9B21DBA

On Mon 18-12-23 16:35:47, Christoph Hellwig wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Instead of keeping our own local iterator variable, use the one just
> added to folio_batch.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index c7983ea3040be4..70f42fd9a95b5d 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2397,13 +2397,19 @@ static pgoff_t wbc_end(struct writeback_control *wbc)
>  	return wbc->range_end >> PAGE_SHIFT;
>  }
>  
> -static void writeback_get_batch(struct address_space *mapping,
> +static struct folio *writeback_get_next(struct address_space *mapping,
>  		struct writeback_control *wbc)
>  {
> +	struct folio *folio = folio_batch_next(&wbc->fbatch);
> +
> +	if (folio)
> +		return folio;
> +
>  	folio_batch_release(&wbc->fbatch);
>  	cond_resched();
>  	filemap_get_folios_tag(mapping, &wbc->index, wbc_end(wbc),
>  			wbc_to_tag(wbc), &wbc->fbatch);
> +	return folio_batch_next(&wbc->fbatch);
>  }
>  
>  static bool should_writeback_folio(struct address_space *mapping,
> @@ -2473,7 +2479,6 @@ int write_cache_pages(struct address_space *mapping,
>  {
>  	int error;
>  	pgoff_t end;		/* Inclusive */
> -	int i = 0;
>  
>  	if (wbc->range_cyclic) {
>  		wbc->index = mapping->writeback_index; /* prev offset */
> @@ -2489,18 +2494,12 @@ int write_cache_pages(struct address_space *mapping,
>  	wbc->err = 0;
>  
>  	for (;;) {
> -		struct folio *folio;
> +		struct folio *folio = writeback_get_next(mapping, wbc);
>  		unsigned long nr;
>  
> -		if (i == wbc->fbatch.nr) {
> -			writeback_get_batch(mapping, wbc);
> -			i = 0;
> -		}
> -		if (wbc->fbatch.nr == 0)
> +		if (!folio)
>  			break;
>  
> -		folio = wbc->fbatch.folios[i++];
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

