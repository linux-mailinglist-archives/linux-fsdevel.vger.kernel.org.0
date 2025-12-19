Return-Path: <linux-fsdevel+bounces-71748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE7FCD0240
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 14:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C399D3093FA9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 13:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAEC324B09;
	Fri, 19 Dec 2025 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e5+IbRoD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iukwmGOd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QbOC2Aqu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oJud9F3m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1B41E7C34
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766152330; cv=none; b=m/Zu/ihFotXKmkKJ6XQjKbQJM1ByImTXnHSbLTn+XzTrNtS018YTIogE8kQdSBovHMD9eBAhsP2YGuBY3GRkKqpnXcF7gR+yb2wpgJ/79F0RbDWt0cDRa/9ZAmtOJdzawQJodFsCK+32HlQHYtrO5Ih94sDkKXxUvAd7ULC1C00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766152330; c=relaxed/simple;
	bh=kqcu6qEZM3MDVa2jQmNjPSemWCOCbM9AhOsppOvavgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPBzLUJYu0aULfEHTJ0aU7LxUv7Rp42JOd/L4jxUxoXGCS7TvojYP6GgfCHi7vUpN0yyA9l2jmSSwhpGRLMU9nBiMkept0BwrhkQ+oorta1RqxEunN6Y7vGPQSPGROm++oz1BhGgvFK4uzEFWH5qgMIUTSsKfSsYwJWrQmI3NkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e5+IbRoD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iukwmGOd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QbOC2Aqu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oJud9F3m; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B03BC3378A;
	Fri, 19 Dec 2025 13:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766152325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=53hNUa+MCXc25E9rF3v+NHVwjXhyWkYUHlwp4mlUtUA=;
	b=e5+IbRoD3gyCzPqmmfmt3e2HzynvxyfA0oGxuhpfOUcMtpHnY30QnCtnIg/PwP994/Hv9H
	HyKz3Z79LUslyof55j4R+5IVP+f+MZRhAB5c7m6B6/xSM2+fDzkExk+IyVOihQhFsc+TJK
	8pwD7S/yOsNqUIBWd2MzfBsce4F4ITk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766152325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=53hNUa+MCXc25E9rF3v+NHVwjXhyWkYUHlwp4mlUtUA=;
	b=iukwmGOdJ7CTWNIxsyjyhWfETajZGvtgEXwDSzG7kufRBXsJ1+yNwAf6RQ1kEeh47bjiyZ
	nG8hwrD2de/qQ+DA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QbOC2Aqu;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=oJud9F3m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766152324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=53hNUa+MCXc25E9rF3v+NHVwjXhyWkYUHlwp4mlUtUA=;
	b=QbOC2Aqu5csQopiXnqGQj8Cei24OU5Z2PzAgCx9FcgDaZndz5re68z9m2pn2PmkDAD/fcC
	hid0+pX9pdRE5BWxawKVaPIZxH0vLL6IBlWjdXW487P/PULmpYUCto+QT/gNCNPyOQ81x6
	RodaZVY3+YuavNK6KYi79dpg5fLrBPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766152324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=53hNUa+MCXc25E9rF3v+NHVwjXhyWkYUHlwp4mlUtUA=;
	b=oJud9F3m0jxKSrei4ZK5Io7xPwcslYuwCmLwkJqu3SaBMrbMWpmn+4+eViqP7OiX1fbnXv
	LHeqleGXtJQgHACA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A37433EA63;
	Fri, 19 Dec 2025 13:52:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1qDgJ4RYRWl6MwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 19 Dec 2025 13:52:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 68246A090B; Fri, 19 Dec 2025 14:51:56 +0100 (CET)
Date: Fri, 19 Dec 2025 14:51:56 +0100
From: Jan Kara <jack@suse.cz>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Mateusz Guzik <mjguzik@gmail.com>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 2/2] VFS: fix __start_dirop() kernel-doc warnings
Message-ID: <ifsfc5ha6ooxrl5pqlr3x7sou2kvtbubn5slxgcurd46psywgq@pfrmqdg24cpe>
References: <20251219024620.22880-1-bagasdotme@gmail.com>
 <20251219024620.22880-3-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219024620.22880-3-bagasdotme@gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com,brown.name];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: B03BC3378A
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Fri 19-12-25 09:46:20, Bagas Sanjaya wrote:
> Sphinx report kernel-doc warnings:
> 
> WARNING: ./fs/namei.c:2853 function parameter 'state' not described in '__start_dirop'
> WARNING: ./fs/namei.c:2853 expecting prototype for start_dirop(). Prototype was for __start_dirop() instead
> 
> Fix them up.
> 
> Fixes: ff7c4ea11a05c8 ("VFS: add start_creating_killable() and start_removing_killable()")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namei.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index bf0f66f0e9b92c..91fd3a786704e2 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2836,10 +2836,11 @@ static int filename_parentat(int dfd, struct filename *name,
>  }
>  
>  /**
> - * start_dirop - begin a create or remove dirop, performing locking and lookup
> + * __start_dirop - begin a create or remove dirop, performing locking and lookup
>   * @parent:       the dentry of the parent in which the operation will occur
>   * @name:         a qstr holding the name within that parent
>   * @lookup_flags: intent and other lookup flags.
> + * @state:        task state bitmask
>   *
>   * The lookup is performed and necessary locks are taken so that, on success,
>   * the returned dentry can be operated on safely.
> -- 
> An old man doll... just what I always wanted! - Clara
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

