Return-Path: <linux-fsdevel+bounces-66444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DA4C1F5BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 10:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02CFF3A8AC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 09:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756113446BD;
	Thu, 30 Oct 2025 09:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oRS3ftIl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bgtqVEsd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oRS3ftIl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bgtqVEsd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672B7343D70
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817339; cv=none; b=oOWQ7QcuseMY3TbMgRjPVbgzd0XV3ezC8Bfx/n9h58hdQMzytakAAzmpLXTWoBLEGv7XQzCh9rO2UObvHRMiAja2BGlAIY8Gb459jWxjJXKTbGNq0X64OMYSav9rKjPdLTLW1uy/axDVYlLnl9Q7dpDaAG4Vh0K+qeyONfXLmRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817339; c=relaxed/simple;
	bh=19q2xk8gAkPo3W+pcVsQ3hp1J7t/o9hU1rQF7pxosHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RohxVHJEFCjOoGFi+px5inPuAtAPrTOAcfylIVuop0rMWP/q9anx1ASj/tXwnieQue3G3h+013rnudNttkTl1+04aXyWpzUsHxM1WPFLYf8ywA7YTrkxdGhTxDSijwUrr8MHIbBot8cLJvz5G1KaJzsUxtSnr9JcjFMUAk6OBs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oRS3ftIl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bgtqVEsd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oRS3ftIl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bgtqVEsd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A66221F80C;
	Thu, 30 Oct 2025 09:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761817335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jm/r0DsdTbclhs38JspBlhV6MYmhbmYRHj2ITGvvUio=;
	b=oRS3ftIlHved6GE5BE/p0NAzF+pGPqVinqaW/Fu9KIlc7sWgUGzBHB+NCGOFN7YVZTZS5f
	aHKOcu+frx+zALrB3AyOnyKNlw+rEhl/H5SuLqbO5Og+7nnbnvWJdtY1ugRnQFcbenKfBJ
	jSe1yz4rp6hrQIooAWaDCiwQEKS5bi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761817335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jm/r0DsdTbclhs38JspBlhV6MYmhbmYRHj2ITGvvUio=;
	b=bgtqVEsdTPhGmEZtbqydTpodqri3sN1Xth19DmNqOsMcAKw7esBvyI8gI4AVZWP7g+tToI
	K6DCcKD/fJvYlLCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761817335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jm/r0DsdTbclhs38JspBlhV6MYmhbmYRHj2ITGvvUio=;
	b=oRS3ftIlHved6GE5BE/p0NAzF+pGPqVinqaW/Fu9KIlc7sWgUGzBHB+NCGOFN7YVZTZS5f
	aHKOcu+frx+zALrB3AyOnyKNlw+rEhl/H5SuLqbO5Og+7nnbnvWJdtY1ugRnQFcbenKfBJ
	jSe1yz4rp6hrQIooAWaDCiwQEKS5bi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761817335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jm/r0DsdTbclhs38JspBlhV6MYmhbmYRHj2ITGvvUio=;
	b=bgtqVEsdTPhGmEZtbqydTpodqri3sN1Xth19DmNqOsMcAKw7esBvyI8gI4AVZWP7g+tToI
	K6DCcKD/fJvYlLCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BB521396A;
	Thu, 30 Oct 2025 09:42:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aJ/+JfcyA2m+fwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 30 Oct 2025 09:42:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 551B4A0AD6; Thu, 30 Oct 2025 10:42:15 +0100 (CET)
Date: Thu, 30 Oct 2025 10:42:15 +0100
From: Jan Kara <jack@suse.cz>
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 03/21] select: rename BITS() to FDS_BITS()
Message-ID: <4drjqnnq6gt7wrltl744fob4wyrhrohmbq5p5iesktxjxc2leb@sj3nbutobr5t>
References: <20251025164023.308884-1-yury.norov@gmail.com>
 <20251025164023.308884-4-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025164023.308884-4-yury.norov@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Sat 25-10-25 12:40:02, Yury Norov (NVIDIA) wrote:
> In preparation for adding generic BITS() macro, rename the local one.
> 
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

Looks fine. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/select.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/select.c b/fs/select.c
> index 082cf60c7e23..ad5bfb4907ea 100644
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -412,7 +412,7 @@ void zero_fd_set(unsigned long nr, unsigned long *fdset)
>  #define FDS_OUT(fds, n)		(fds->out + n)
>  #define FDS_EX(fds, n)		(fds->ex + n)
>  
> -#define BITS(fds, n)	(*FDS_IN(fds, n)|*FDS_OUT(fds, n)|*FDS_EX(fds, n))
> +#define FDS_BITS(fds, n)	(*FDS_IN(fds, n)|*FDS_OUT(fds, n)|*FDS_EX(fds, n))
>  
>  static int max_select_fd(unsigned long n, fd_set_bits *fds)
>  {
> @@ -428,7 +428,7 @@ static int max_select_fd(unsigned long n, fd_set_bits *fds)
>  	open_fds = fdt->open_fds + n;
>  	max = 0;
>  	if (set) {
> -		set &= BITS(fds, n);
> +		set &= FDS_BITS(fds, n);
>  		if (set) {
>  			if (!(set & ~*open_fds))
>  				goto get_max;
> @@ -438,7 +438,7 @@ static int max_select_fd(unsigned long n, fd_set_bits *fds)
>  	while (n) {
>  		open_fds--;
>  		n--;
> -		set = BITS(fds, n);
> +		set = FDS_BITS(fds, n);
>  		if (!set)
>  			continue;
>  		if (set & ~*open_fds)
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

