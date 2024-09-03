Return-Path: <linux-fsdevel+bounces-28345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 961E2969A2A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 12:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 336CDB21B3A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 10:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844151B9837;
	Tue,  3 Sep 2024 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EidoO7fh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gExD3/yP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EidoO7fh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gExD3/yP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC8F1A0BEC
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359418; cv=none; b=lE1aGqnSMVZJmqcf5FjklzfOe/4IXz0RJyL88Yqu0GwocrG52AD35xuFP0DGYLlrY5S+p8hHMoZpwDPfoZ+ixJrSudz7eytfaX1Q7GlV/5RUqVrlwq0VVO4YkPzaayRqmE/SYUqU2Pobx2tv8Lb7RDcvGYZ/jyX5UcUd+jHh56U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359418; c=relaxed/simple;
	bh=fzZZIZ2QIymsOsoJZzJ9t/wUBxvdxRmIlJVoAr4+gyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTW6jxvbT64GQ86eZNB27pfFJzGVwcTSxMWJNb272GYh9e3u1cPtQrEEb7PLmZScgUf0KLNZySQTQiW/s+NlpFkMz2DJ9Rg5RUum/hwKIVlzCAzSXc4w3rh/EVfPq7kvbq6UoyoopkhdwpU2HpF9fcDewyPb0xJr4/9TPvODknY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EidoO7fh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gExD3/yP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EidoO7fh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gExD3/yP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4E9D521BF2;
	Tue,  3 Sep 2024 10:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725359414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w+CZqtsg8BjAjqkERgl8ZUysvuQJmTg8oW7hwZmMA30=;
	b=EidoO7fhLB+xG3v0j+qTljytuTIRpAB+1BwF3lnrupv1MEjN+4Ps5ptyWPMsOglEUGRjv1
	fa8DTudalez7QXsFZfomiatYSrdRmpQXNRdR6gUGtv1iOF6jWDOoo6RW+DToGra31q/3kN
	FTD1OVuxIqDY3qspP27J0Sybme6nzq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725359414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w+CZqtsg8BjAjqkERgl8ZUysvuQJmTg8oW7hwZmMA30=;
	b=gExD3/yPYXqNXhSYDV55xro625yFDEv2MWj523qpdTGFDfdd1HZe2lI19QhQ9lmzqoX03y
	suZoVfAJEWxasZCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725359414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w+CZqtsg8BjAjqkERgl8ZUysvuQJmTg8oW7hwZmMA30=;
	b=EidoO7fhLB+xG3v0j+qTljytuTIRpAB+1BwF3lnrupv1MEjN+4Ps5ptyWPMsOglEUGRjv1
	fa8DTudalez7QXsFZfomiatYSrdRmpQXNRdR6gUGtv1iOF6jWDOoo6RW+DToGra31q/3kN
	FTD1OVuxIqDY3qspP27J0Sybme6nzq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725359414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w+CZqtsg8BjAjqkERgl8ZUysvuQJmTg8oW7hwZmMA30=;
	b=gExD3/yPYXqNXhSYDV55xro625yFDEv2MWj523qpdTGFDfdd1HZe2lI19QhQ9lmzqoX03y
	suZoVfAJEWxasZCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 456F213A80;
	Tue,  3 Sep 2024 10:30:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bzDxEDbl1mZvDgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Sep 2024 10:30:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0E910A096C; Tue,  3 Sep 2024 12:30:14 +0200 (CEST)
Date: Tue, 3 Sep 2024 12:30:14 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 02/20] adi: remove unused f_version
Message-ID: <20240903103014.opoiljqddsuxtu33@quack3>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-2-6d3e4816aa7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830-vfs-file-f_version-v1-2-6d3e4816aa7b@kernel.org>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 30-08-24 15:04:43, Christian Brauner wrote:
> It's not used for adi so don't bother with it at all.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Furthermore we allocate new files with kzalloc. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/char/adi.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/char/adi.c b/drivers/char/adi.c
> index 751d7cc0da1b..c091a0282ad0 100644
> --- a/drivers/char/adi.c
> +++ b/drivers/char/adi.c
> @@ -196,7 +196,6 @@ static loff_t adi_llseek(struct file *file, loff_t offset, int whence)
>  
>  	if (offset != file->f_pos) {
>  		file->f_pos = offset;
> -		file->f_version = 0;
>  		ret = offset;
>  	}
>  
> 
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

