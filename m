Return-Path: <linux-fsdevel+bounces-74414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 847E8D3A202
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 09:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73AC4300699F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4B13002A9;
	Mon, 19 Jan 2026 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VmamIK6h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bfxdZwqe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xORcQbxZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X01pzAEu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2C134EF11
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768812439; cv=none; b=JDvHqIlTO8chBvGlHxk+hk+6hUp+aujqON4jZdSwzoFaybXHFQ8NTbEartgsWNpwXmRCKvZWO93al10RnS0hP+X1ngBvNdPpcqXw7dSrIMyluQ4GHd13DJWlkjOHSCuCnuBzVqLkke3Ic2mfhSnv4SEWq+wq6aW8ym5jBGlRkyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768812439; c=relaxed/simple;
	bh=sbPq4r5GK96zlF1/Btr8N39b/3wBxyNQDP77CupZtN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcxUz6M7so/iJq9ast8ZXQcZSaSY87ZzBDVSlLByCM1tdb1SqMte1anbZplyDCA0HbcJIaKmRdHSXnmcVvjn1tG73ZsWKOh7whT4qTHOOhiY7yh7RJQZhpz/U/QefJG9mlIxyhB9RUdkKGXqYqgNZTPletVoAbJkFmZQWuTtHyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VmamIK6h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bfxdZwqe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xORcQbxZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=X01pzAEu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 40390336A9;
	Mon, 19 Jan 2026 08:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768812433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/XRdlH7phwJwoniHK9lXXKlJYloNBPp2k3Zwk0QvRMo=;
	b=VmamIK6hxMJznUAjFuYTIAPOYZkgJahgJSbyrA0Yu/I6hXNWhupRaFOk5xF7E5/yf49zAq
	DzpYQsrl5RIPEvTf8NMM+2514Es0ewtsmziRngourb+nH+DGNEoLK0xktO1FDGTvS3yDcr
	KgmEgRhBevfYAcD+A5fPENJo1wbRIwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768812433;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/XRdlH7phwJwoniHK9lXXKlJYloNBPp2k3Zwk0QvRMo=;
	b=bfxdZwqeOD7X4yPPk1grkjjTY9mB95vfIqWsltyr+LWKRjWiW97b7criICW87L79o9KWJj
	WIwZsrjbYccTVvBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768812431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/XRdlH7phwJwoniHK9lXXKlJYloNBPp2k3Zwk0QvRMo=;
	b=xORcQbxZM+eJ8BoA+K++IN+gyJD8xGEAQ9vDp+Qr2s86QPN+5lL1dvN6VjzEWt+YDuNRnJ
	DOhdwhPE1kYdTrTUj8Kr+G3j5y5dpzpPGvqsPft1MOa97J9wqT1nTkZ2KkM4Y0Wh99Jsv9
	MDh/6EINTajjk8kyeFZ00cq23GjjZLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768812431;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/XRdlH7phwJwoniHK9lXXKlJYloNBPp2k3Zwk0QvRMo=;
	b=X01pzAEufDwLz6qAN+WmqK3PZuvEVQdy8Shez47V+VXLN51nkCCeSRc6GfILpV+BmdC+xQ
	lz+HDeYKaWYykoBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36C063EA63;
	Mon, 19 Jan 2026 08:47:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lIFYDY/vbWniKAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 19 Jan 2026 08:47:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0063DA0A29; Mon, 19 Jan 2026 09:47:10 +0100 (CET)
Date: Mon, 19 Jan 2026 09:47:10 +0100
From: Jan Kara <jack@suse.cz>
To: Jay Winston <jaybenjaminwinston@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/namei: fix kernel-doc markup for dentry_create
Message-ID: <xan43ktoyfvjb62aaodarup5d5rlk2suyggwsoftd3maxi4wcb@rtnlr3wswquc>
References: <20260118110401.2651-1-jaybenjaminwinston@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118110401.2651-1-jaybenjaminwinston@gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Sun 18-01-26 13:04:01, Jay Winston wrote:
> O_ is interpreted as a broken hyperlink target. Escape _ with a backslash.
> 
> The asterisk in "struct file *" is interpreted as an opening emphasis
> string that never closes. Replace double quotes with rST backticks.
> 
> Change "a ERR_PTR" to "an ERR_PTR".
> 
> Signed-off-by: Jay Winston <jaybenjaminwinston@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>
	
								Honza

> ---
>  fs/namei.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index b19890758646..f511288af463 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4975,7 +4975,7 @@ EXPORT_SYMBOL(start_creating_user_path);
>  /**
>   * dentry_create - Create and open a file
>   * @path: path to create
> - * @flags: O_ flags
> + * @flags: O\_ flags
>   * @mode: mode bits for new file
>   * @cred: credentials to use
>   *
> @@ -4986,7 +4986,7 @@ EXPORT_SYMBOL(start_creating_user_path);
>   * the new file is to be created. The parent directory and the
>   * negative dentry must reside on the same filesystem instance.
>   *
> - * On success, returns a "struct file *". Otherwise a ERR_PTR
> + * On success, returns a ``struct file *``. Otherwise an ERR_PTR
>   * is returned.
>   */
>  struct file *dentry_create(struct path *path, int flags, umode_t mode,
> -- 
> 2.46.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

