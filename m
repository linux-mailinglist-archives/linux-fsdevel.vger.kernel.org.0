Return-Path: <linux-fsdevel+bounces-6671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8966581B51C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 12:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28AA91F23F78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 11:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFD56DCF9;
	Thu, 21 Dec 2023 11:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D+whZSpu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y2TE2OBd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D+whZSpu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y2TE2OBd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C71D1DA3B;
	Thu, 21 Dec 2023 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A07101FB73;
	Thu, 21 Dec 2023 11:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703158921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHGj/QWNdjAWrYVT+sev2QMbn9CEKZZ/Yw7K3T4SC9k=;
	b=D+whZSpuxgib93oNZ0IF1mLee1O3AL+iNCX0uDYMGIOE9ywMBVsgZS2LACAABhhIPgrQdu
	z9u+ttw+qlAlUV29460x/JHoeIPQtC2ORQlsNZnTQzZhEl09RxcVRzQAUOLS6Km8Q82bVK
	QkBVtcQx4RjcTII8A1uyjml6J9I/Z70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703158921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHGj/QWNdjAWrYVT+sev2QMbn9CEKZZ/Yw7K3T4SC9k=;
	b=Y2TE2OBdyc8UnRUTNf5Y3YBYbTw2MHEaQj3rUmP3226n4Chbqpg+sTTDaztz3SJCkJFS/5
	A4lIU6vN8/O7VHAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703158921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHGj/QWNdjAWrYVT+sev2QMbn9CEKZZ/Yw7K3T4SC9k=;
	b=D+whZSpuxgib93oNZ0IF1mLee1O3AL+iNCX0uDYMGIOE9ywMBVsgZS2LACAABhhIPgrQdu
	z9u+ttw+qlAlUV29460x/JHoeIPQtC2ORQlsNZnTQzZhEl09RxcVRzQAUOLS6Km8Q82bVK
	QkBVtcQx4RjcTII8A1uyjml6J9I/Z70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703158921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHGj/QWNdjAWrYVT+sev2QMbn9CEKZZ/Yw7K3T4SC9k=;
	b=Y2TE2OBdyc8UnRUTNf5Y3YBYbTw2MHEaQj3rUmP3226n4Chbqpg+sTTDaztz3SJCkJFS/5
	A4lIU6vN8/O7VHAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 952B013725;
	Thu, 21 Dec 2023 11:42:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kVZmJIkkhGUAYAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Dec 2023 11:42:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3ECABA07E3; Thu, 21 Dec 2023 12:41:53 +0100 (CET)
Date: Thu, 21 Dec 2023 12:41:53 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/17] writeback: Factor writeback_get_folio() out of
 write_cache_pages()
Message-ID: <20231221114153.2ktiwixqedsk5adw@quack3>
References: <20231218153553.807799-1-hch@lst.de>
 <20231218153553.807799-14-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153553.807799-14-hch@lst.de>
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [-1.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,suse.cz:email,suse.com:email];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.60)[92.44%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -1.20
X-Spam-Flag: NO

On Mon 18-12-23 16:35:49, Christoph Hellwig wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Move the loop for should-we-write-this-folio to its own function.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

But I'd note that the call stack depth of similarly called helper functions
(with more to come later in the series) is getting a bit confusing. Maybe
we should inline writeback_get_next() into its single caller
writeback_get_folio() to reduce confusion a bit...

								Honza

> +static struct folio *writeback_get_folio(struct address_space *mapping,
> +		struct writeback_control *wbc)
> +{
> +	struct folio *folio;
> +
> +	for (;;) {
> +		folio = writeback_get_next(mapping, wbc);
> +		if (!folio)
> +			return NULL;
> +		folio_lock(folio);
> +		if (likely(should_writeback_folio(mapping, wbc, folio)))
> +			break;
> +		folio_unlock(folio);
> +	}
> +
> +	trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
> +	return folio;
> +}
> +
>  static struct folio *writeback_iter_init(struct address_space *mapping,
>  		struct writeback_control *wbc)
>  {
> @@ -2455,7 +2474,7 @@ static struct folio *writeback_iter_init(struct address_space *mapping,
>  
>  	wbc->err = 0;
>  	folio_batch_init(&wbc->fbatch);
> -	return writeback_get_next(mapping, wbc);
> +	return writeback_get_folio(mapping, wbc);
>  }
>  
>  /**
> @@ -2498,17 +2517,9 @@ int write_cache_pages(struct address_space *mapping,
>  
>  	for (folio = writeback_iter_init(mapping, wbc);
>  	     folio;
> -	     folio = writeback_get_next(mapping, wbc)) {
> +	     folio = writeback_get_folio(mapping, wbc)) {
>  		unsigned long nr;
>  
> -		folio_lock(folio);
> -		if (!should_writeback_folio(mapping, wbc, folio)) {
> -			folio_unlock(folio);
> -			continue;
> -		}
> -
> -		trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
> -
>  		error = writepage(folio, wbc, data);
>  		nr = folio_nr_pages(folio);
>  		wbc->nr_to_write -= nr;
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

