Return-Path: <linux-fsdevel+bounces-73218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F19D124E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 12:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70CC73013BC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 11:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5C2199230;
	Mon, 12 Jan 2026 11:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QprfuJkW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ipgtzgmb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QprfuJkW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ipgtzgmb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B9A354AF3
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 11:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768217470; cv=none; b=JjNRH7mmr5leGJPwZAPFog+DARqyNER/2jBsdR5BcMYQCq6IuPu8yOjsNx/yf380p59NgA4jDh4/zCETmLeLYb92vunm09WLUX+lADAQTETNxmSx34p/AC0IzPGbcDsSVOoHFbThq7t7GbjPSI3xd2d0mQjQihsbTtm8ZXN2K0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768217470; c=relaxed/simple;
	bh=AyVOWbxQiztaKcYTYtYbh8258D9zmBrBOGIn2hHF4GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hO7l7kPKsk62VquryPyxOiymIagetCdxTIRXx+xVZRxlD/4D8DUn5VGanjzUL+lPin8CHbiEWqxtRvuXWTICRjx3LsRld27XlKn9yD0Oe2kQBy+jxVBqW+syt1DhUufXHOgSBdE2a0QFLHSnTga4KVYFcLdkkL7OENVL4IaFkTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QprfuJkW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ipgtzgmb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QprfuJkW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ipgtzgmb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E9E45BD78;
	Mon, 12 Jan 2026 11:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768217464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DdrCnZwVPl0EIgOFrYlUhH/OF0W0bDAW0dPCL+G/8bw=;
	b=QprfuJkWmqTVDtyuQVJXqP+9GQNMfZlWqCn4akPuquEnWPt3x/Ix+OyMsrLIlPYak8s38U
	C5XWFAS3Kf+D17ut3u1x4ruzV9syEv1WVNJLXU6v7pcaYMhSUmIzdgZDGF1t80Ib857bFu
	WwIUW+ifgSAAzvxCqs1S5LfIHFiEvgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768217464;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DdrCnZwVPl0EIgOFrYlUhH/OF0W0bDAW0dPCL+G/8bw=;
	b=ipgtzgmbSot6bMVAo1rPo6LZyLj/OrFN9990+I8atVpwuB0bqktXa8yu20x/pbZMmES8Bt
	+xixvhGB08zy+ZCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QprfuJkW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ipgtzgmb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768217464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DdrCnZwVPl0EIgOFrYlUhH/OF0W0bDAW0dPCL+G/8bw=;
	b=QprfuJkWmqTVDtyuQVJXqP+9GQNMfZlWqCn4akPuquEnWPt3x/Ix+OyMsrLIlPYak8s38U
	C5XWFAS3Kf+D17ut3u1x4ruzV9syEv1WVNJLXU6v7pcaYMhSUmIzdgZDGF1t80Ib857bFu
	WwIUW+ifgSAAzvxCqs1S5LfIHFiEvgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768217464;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DdrCnZwVPl0EIgOFrYlUhH/OF0W0bDAW0dPCL+G/8bw=;
	b=ipgtzgmbSot6bMVAo1rPo6LZyLj/OrFN9990+I8atVpwuB0bqktXa8yu20x/pbZMmES8Bt
	+xixvhGB08zy+ZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32AAD3EA63;
	Mon, 12 Jan 2026 11:31:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zzL6C3jbZGkRNgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 12 Jan 2026 11:31:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D88E6A0A7E; Mon, 12 Jan 2026 12:31:03 +0100 (CET)
Date: Mon, 12 Jan 2026 12:31:03 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: move initializing f_mode before file_ref_init()
Message-ID: <3wzb7fku35m73rdmphtytszl5vafixxpt32q4ewzcqqlx4gweh@fhjo7ab6ytib>
References: <20260109211536.3565697-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109211536.3565697-1-amir73il@gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 3E9E45BD78
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On Fri 09-01-26 22:15:36, Amir Goldstein wrote:
> The comment above file_ref_init() says:
> "We're SLAB_TYPESAFE_BY_RCU so initialize f_ref last."
> but file_set_fsnotify_mode() was added after file_ref_init().
> 
> Move it right after setting f_mode, where it makes more sense.
> 
> Fixes: 711f9b8fbe4f4 ("fsnotify: disable pre-content and permission events by default")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

I agree logically this place makes more sense (although functionally it
doesn't really matter). Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/file_table.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/file_table.c b/fs/file_table.c
> index cd4a3db4659ac..34244fccf2edf 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -176,6 +176,11 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
>  
>  	f->f_flags	= flags;
>  	f->f_mode	= OPEN_FMODE(flags);
> +	/*
> +	 * Disable permission and pre-content events for all files by default.
> +	 * They may be enabled later by fsnotify_open_perm_and_set_mode().
> +	 */
> +	file_set_fsnotify_mode(f, FMODE_NONOTIFY_PERM);
>  
>  	f->f_op		= NULL;
>  	f->f_mapping	= NULL;
> @@ -197,11 +202,6 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
>  	 * refcount bumps we should reinitialize the reused file first.
>  	 */
>  	file_ref_init(&f->f_ref, 1);
> -	/*
> -	 * Disable permission and pre-content events for all files by default.
> -	 * They may be enabled later by fsnotify_open_perm_and_set_mode().
> -	 */
> -	file_set_fsnotify_mode(f, FMODE_NONOTIFY_PERM);
>  	return 0;
>  }
>  
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

