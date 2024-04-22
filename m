Return-Path: <linux-fsdevel+bounces-17443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1CB8AD6C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 23:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D56051F21969
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 21:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768621CF94;
	Mon, 22 Apr 2024 21:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ySM2TsnW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FSHmzQ1y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CIoilH/5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JngOAzM6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49601CD2E
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Apr 2024 21:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713823078; cv=none; b=qCvlkmdWOqPfnHocJAQsOqFM3rP5kqrF2yJZfzLk6OR8S1tEC5XPLu/33QQq/87VEI5+9QrtWjUK6NZhFBcj7Jr5hmYhj/quASvvNiJ0h+Q358rwOGiqxPH1P5kQPHnfgbIrMAX6O8nzHar73mMqYFX44LcBZIBvDZBmbWa7h8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713823078; c=relaxed/simple;
	bh=VxhrhW8ulC3ySwT/8675FsfNanpfXEA0tKyph9wR7WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I12LE3dY5+G9E7XrGwkTfsSBOCeBVLQVx70EfhGKGUUAkn3LBOW8kmtDb/wCuY3KOJct7+x/+IqWFTXvIL+DY76J06ah7VJgufyebulZPnZMSB5tBTwcCKLagDNiObfZ27gtArI2bwwdKYGv0OiLjiHt0UHeZDgxoOmLBdS5ido=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ySM2TsnW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FSHmzQ1y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CIoilH/5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JngOAzM6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B82D3750F;
	Mon, 22 Apr 2024 21:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713823075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=doNIcOfbT18oyVJCgggxD896QvWZ5ypRnlRzDszG9nk=;
	b=ySM2TsnWHS9WZGGTRhFtSAU1tqx7nE3uF3mOdGY8+WfDP1jRcae9dM3AcamE4G1Qj7oibx
	X6vZDlvakHRH+T3hBSmKT15kihc4cqtvh3aKGqvkdnV/bbIFIDYFNsW4ZU4duBL+H61B/A
	/LNKal0IneHXHNSt1YiEDgR9g2HYNA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713823075;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=doNIcOfbT18oyVJCgggxD896QvWZ5ypRnlRzDszG9nk=;
	b=FSHmzQ1yq2zCSCdnWeaiArRrcB4YkkX7VznLaxf8SLfjOiG0GtxMABhzH5RP/UQdhH8T5p
	seUmo4EXdEAqMrDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="CIoilH/5";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JngOAzM6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713823073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=doNIcOfbT18oyVJCgggxD896QvWZ5ypRnlRzDszG9nk=;
	b=CIoilH/5vwaaYgy3pBFAHP/VXGbu4h+uodzdtajXtFdgRO0oAkmoFTbHZtniQ8HhttL7xr
	Lu5O9m9J3eq1JRQ/pEXfXAT2IX+1gbn82/Tr0335rLaVs5R98rJxOKzaJIi+I5eVovQSIB
	j2p4Vfm/HcB70z9jfeeTd0QAfa+MoUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713823073;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=doNIcOfbT18oyVJCgggxD896QvWZ5ypRnlRzDszG9nk=;
	b=JngOAzM6YMvfelznfqCUs/+lUhfo3P+C90pN2DnJBBi1xMZWdQzqdX540HBU6cMQ/46Py7
	J24FuGjv9o6J+tDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E237136ED;
	Mon, 22 Apr 2024 21:57:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tkFRImHdJmZhZgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Apr 2024 21:57:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 40069A085A; Mon, 22 Apr 2024 23:57:53 +0200 (CEST)
Date: Mon, 22 Apr 2024 23:57:53 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 13/30] isofs: Remove calls to set/clear the error flag
Message-ID: <20240422215753.ppmbki53e4yx7p4p@quack3>
References: <20240420025029.2166544-1-willy@infradead.org>
 <20240420025029.2166544-14-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420025029.2166544-14-willy@infradead.org>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9B82D3750F
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,infradead.org:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]

On Sat 20-04-24 03:50:08, Matthew Wilcox (Oracle) wrote:
> Nobody checks the error flag on isofs folios, so stop setting and
> clearing it.
> 
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Do you plan to merge this together or should I pick this up myself?

Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/isofs/compress.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
> index c4da3f634b92..34d5baa5d88a 100644
> --- a/fs/isofs/compress.c
> +++ b/fs/isofs/compress.c
> @@ -346,8 +346,6 @@ static int zisofs_read_folio(struct file *file, struct folio *folio)
>  	for (i = 0; i < pcount; i++, index++) {
>  		if (i != full_page)
>  			pages[i] = grab_cache_page_nowait(mapping, index);
> -		if (pages[i])
> -			ClearPageError(pages[i]);
>  	}
>  
>  	err = zisofs_fill_pages(inode, full_page, pcount, pages);
> @@ -356,8 +354,6 @@ static int zisofs_read_folio(struct file *file, struct folio *folio)
>  	for (i = 0; i < pcount; i++) {
>  		if (pages[i]) {
>  			flush_dcache_page(pages[i]);
> -			if (i == full_page && err)
> -				SetPageError(pages[i]);
>  			unlock_page(pages[i]);
>  			if (i != full_page)
>  				put_page(pages[i]);
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

