Return-Path: <linux-fsdevel+bounces-35904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCD29D97CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 13:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ADCD163395
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 12:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FD71D45E5;
	Tue, 26 Nov 2024 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yHJDejV+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OVNsP/rF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yHJDejV+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OVNsP/rF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A931D4169
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2024 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625934; cv=none; b=ackJ/GIX4utJsoLM4Wrj/PJ7exEdePkIupG5RpyPyUnNXbND6fAG4YMVCsQWqblMCcTVVGMmAXUoaYiNG89w8566g4nxvvaqW5S7nvN9dMvBxOpGcj8kH+J/OZzcZmUe3MLvZDZE457HiReKV90seztAOpP4ljnL1M1aXx8/J+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625934; c=relaxed/simple;
	bh=CYyviQiAYsjw6vztQngBsxN8YG0NlaB8XY23Kcg/Yl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fF+C1T3dar2oXAFVDfF+Cm9ayjgl5v+N/fPA/7gx7i9zOb5akW9jaRwutfsA8w5DQrEnvaw83jPtZV4bS6UoNjt+Rdue63BdADvKaeiZye4TloG9yk0nxuq2Bqw7GAX/CpR1UhLhGGTEaaw6K3riZYrDXhbQuxI6ZCCNaYZjXks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yHJDejV+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OVNsP/rF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yHJDejV+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OVNsP/rF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 604361F747;
	Tue, 26 Nov 2024 12:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732625930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dqS5/2BoA76EnxgFcDba1/oZ+7WJvZnx6YYqVLaJZCU=;
	b=yHJDejV+0HzTAvySiOZFX5tEpsk7ibsNoLFwFMLGFpVay2q2izevXjS0DsHRAsWMPH40+O
	MDCdN1d8+7MVja+dtWVB5Jy++KxvYM0whsn0L+HjlOCBOZjVW0IbOgsDSizypAhTGPLdIR
	wpgHD/uUPilfZYxz63CJFKYXsypwOMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732625930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dqS5/2BoA76EnxgFcDba1/oZ+7WJvZnx6YYqVLaJZCU=;
	b=OVNsP/rFii3ZAFiIPhSY644BiT82u+7N4zWx5B76M5f5WSbGlcfLyB7vO4NZF+LVUUn/iA
	Nc9MIteHvbVwxVDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732625930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dqS5/2BoA76EnxgFcDba1/oZ+7WJvZnx6YYqVLaJZCU=;
	b=yHJDejV+0HzTAvySiOZFX5tEpsk7ibsNoLFwFMLGFpVay2q2izevXjS0DsHRAsWMPH40+O
	MDCdN1d8+7MVja+dtWVB5Jy++KxvYM0whsn0L+HjlOCBOZjVW0IbOgsDSizypAhTGPLdIR
	wpgHD/uUPilfZYxz63CJFKYXsypwOMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732625930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dqS5/2BoA76EnxgFcDba1/oZ+7WJvZnx6YYqVLaJZCU=;
	b=OVNsP/rFii3ZAFiIPhSY644BiT82u+7N4zWx5B76M5f5WSbGlcfLyB7vO4NZF+LVUUn/iA
	Nc9MIteHvbVwxVDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 549F913890;
	Tue, 26 Nov 2024 12:58:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cbWfFArGRWeyWQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 26 Nov 2024 12:58:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0F523A08CA; Tue, 26 Nov 2024 13:58:50 +0100 (CET)
Date: Tue, 26 Nov 2024 13:58:50 +0100
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] isofs: Partially convert zisofs_read_folio to use a folio
Message-ID: <20241126125850.l7o74nstlv37u3xl@quack3>
References: <20241125180117.2914311-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125180117.2914311-1-willy@infradead.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Mon 25-11-24 18:01:14, Matthew Wilcox (Oracle) wrote:
> Remove several hidden calls to compound_head() and references
> to page->index.  More needs to be done to use folios throughout
> the zisofs code.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Thanks! Added to my tree.

								Honza

> ---
>  fs/isofs/compress.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
> index 34d5baa5d88a..5f3b6da0e022 100644
> --- a/fs/isofs/compress.c
> +++ b/fs/isofs/compress.c
> @@ -301,7 +301,6 @@ static int zisofs_fill_pages(struct inode *inode, int full_page, int pcount,
>   */
>  static int zisofs_read_folio(struct file *file, struct folio *folio)
>  {
> -	struct page *page = &folio->page;
>  	struct inode *inode = file_inode(file);
>  	struct address_space *mapping = inode->i_mapping;
>  	int err;
> @@ -311,16 +310,15 @@ static int zisofs_read_folio(struct file *file, struct folio *folio)
>  		PAGE_SHIFT <= zisofs_block_shift ?
>  		(1 << (zisofs_block_shift - PAGE_SHIFT)) : 0;
>  	struct page **pages;
> -	pgoff_t index = page->index, end_index;
> +	pgoff_t index = folio->index, end_index;
>  
>  	end_index = (inode->i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
>  	/*
> -	 * If this page is wholly outside i_size we just return zero;
> +	 * If this folio is wholly outside i_size we just return zero;
>  	 * do_generic_file_read() will handle this for us
>  	 */
>  	if (index >= end_index) {
> -		SetPageUptodate(page);
> -		unlock_page(page);
> +		folio_end_read(folio, true);
>  		return 0;
>  	}
>  
> @@ -338,10 +336,10 @@ static int zisofs_read_folio(struct file *file, struct folio *folio)
>  	pages = kcalloc(max_t(unsigned int, zisofs_pages_per_cblock, 1),
>  					sizeof(*pages), GFP_KERNEL);
>  	if (!pages) {
> -		unlock_page(page);
> +		folio_unlock(folio);
>  		return -ENOMEM;
>  	}
> -	pages[full_page] = page;
> +	pages[full_page] = &folio->page;
>  
>  	for (i = 0; i < pcount; i++, index++) {
>  		if (i != full_page)
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

