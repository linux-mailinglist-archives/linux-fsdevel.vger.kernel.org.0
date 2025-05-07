Return-Path: <linux-fsdevel+bounces-48342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BFEAADCC7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 12:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EADD1BC7B8A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 10:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EBD215184;
	Wed,  7 May 2025 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qty4ydjr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="geS4IeA4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qty4ydjr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="geS4IeA4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656EE204090
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746615177; cv=none; b=FUMjoiayWlZyPGtv9ZCn8qWzQPvHf/zG7nyjJ1Jw6Al7KaariyHurkcowV763+9tOEY9Z5bH90pHvdtrQMdMRhxkVUtSvzB9tcgthiZbEAeebxRbibrfcS87QyGV4w+Gtz/hGuK/VNavtlaehKA+BS9ifDdC53GP3Ug6oGAlgFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746615177; c=relaxed/simple;
	bh=iLBWhMAyOpeg/hd7KE6EIffAc+zqQ58yYTlO+vnTccE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRRWaz6qLsPopyZaep4hXB0QenopEcdhVv0ZGzwKHFGWTA8RiM+C30KvAcxDYb9Gy+PtCSq1ECQ3jHq0qnqNYIEo6atRiWHVobZImGeDqnqxf/K9SZXonSZjdybczGtXnpLikIa+ll/AE/2fJdM9A0TinAIjJVRcKW+8z1L8gW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qty4ydjr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=geS4IeA4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qty4ydjr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=geS4IeA4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 450962122F;
	Wed,  7 May 2025 10:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746615173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wiJKzgwQF8wXYiZsza7JD7SHOyx3eGpRenU7FT4JJ8M=;
	b=Qty4ydjrp6NzrzhSrtFKpxn2rU2e3lEeg7vOnZujAXhN1w7Y0kQY62Tp9MoafHnBEKUjtS
	WM4VX72RKNpfayTlLh4yql+aL+m3gWgd65fk1Sj8Fya4A4ByPDL6e5x20hCk1WPsQBYoqF
	Vh10z1DbW2wxtd1imkA1cKZiQY/B73s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746615173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wiJKzgwQF8wXYiZsza7JD7SHOyx3eGpRenU7FT4JJ8M=;
	b=geS4IeA4vLu/V82sKiLUsIPyGRTwnRzCgtcHKN2Quyh4mBDVAjUlCYx4o16UkSNGCR7JER
	jw5wey6kiTeh8uCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Qty4ydjr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=geS4IeA4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746615173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wiJKzgwQF8wXYiZsza7JD7SHOyx3eGpRenU7FT4JJ8M=;
	b=Qty4ydjrp6NzrzhSrtFKpxn2rU2e3lEeg7vOnZujAXhN1w7Y0kQY62Tp9MoafHnBEKUjtS
	WM4VX72RKNpfayTlLh4yql+aL+m3gWgd65fk1Sj8Fya4A4ByPDL6e5x20hCk1WPsQBYoqF
	Vh10z1DbW2wxtd1imkA1cKZiQY/B73s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746615173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wiJKzgwQF8wXYiZsza7JD7SHOyx3eGpRenU7FT4JJ8M=;
	b=geS4IeA4vLu/V82sKiLUsIPyGRTwnRzCgtcHKN2Quyh4mBDVAjUlCYx4o16UkSNGCR7JER
	jw5wey6kiTeh8uCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AB8113882;
	Wed,  7 May 2025 10:52:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DlxRDoU7G2gEFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 May 2025 10:52:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DE90EA09BE; Wed,  7 May 2025 12:52:52 +0200 (CEST)
Date: Wed, 7 May 2025 12:52:52 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: use writeback_iter directly in mpage_writepages
Message-ID: <yfaqqehmgyv5gexqs5wg4cm2gaynwcxt26e4ho3cp7hj4hmwkt@kqfpyqs3uhpt>
References: <20250507062124.3933305-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507062124.3933305-1-hch@lst.de>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 450962122F
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,suse.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action

On Wed 07-05-25 08:21:24, Christoph Hellwig wrote:
> Stop using write_cache_pages and use writeback_iter directly.  This
> removes an indirect call per written folio and makes the code easier
> to follow.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/mpage.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/mpage.c b/fs/mpage.c
> index ad7844de87c3..c5fd821fd30e 100644
> --- a/fs/mpage.c
> +++ b/fs/mpage.c
> @@ -445,10 +445,9 @@ static void clean_buffers(struct folio *folio, unsigned first_unmapped)
>  		try_to_free_buffers(folio);
>  }
>  
> -static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
> -		      void *data)
> +static int mpage_write_folio(struct writeback_control *wbc, struct folio *folio,
> +		struct mpage_data *mpd)
>  {
> -	struct mpage_data *mpd = data;
>  	struct bio *bio = mpd->bio;
>  	struct address_space *mapping = folio->mapping;
>  	struct inode *inode = mapping->host;
> @@ -656,14 +655,16 @@ mpage_writepages(struct address_space *mapping,
>  	struct mpage_data mpd = {
>  		.get_block	= get_block,
>  	};
> +	struct folio *folio = NULL;
>  	struct blk_plug plug;
> -	int ret;
> +	int error;
>  
>  	blk_start_plug(&plug);
> -	ret = write_cache_pages(mapping, wbc, __mpage_writepage, &mpd);
> +	while ((folio = writeback_iter(mapping, wbc, folio, &error)))
> +		error = mpage_write_folio(wbc, folio, &mpd);
>  	if (mpd.bio)
>  		mpage_bio_submit_write(mpd.bio);
>  	blk_finish_plug(&plug);
> -	return ret;
> +	return error;
>  }
>  EXPORT_SYMBOL(mpage_writepages);
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

