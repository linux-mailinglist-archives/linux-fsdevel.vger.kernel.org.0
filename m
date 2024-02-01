Return-Path: <linux-fsdevel+bounces-9832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7891484544F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3A81C24E81
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 09:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6381615B115;
	Thu,  1 Feb 2024 09:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z2DDrAIk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="efTk+6so";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i4N8QDIz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UIIWaKgo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D464D9FF;
	Thu,  1 Feb 2024 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780464; cv=none; b=QWWyMyOB9+EvJSAQV3c8ThmOsDvZe+cRPinnk0sRv8yV3UsWbK0lWqwab/Zrj0GA8Y+wiP45FThK8QfEz5FA4GlKdgeZvWEXQa8cgo+n14qjJCAP8cmoqtUxfD9mYZ0fK9ogTT9d8EvRA1kJOO0ppjHlsuZb+6tgZuF0qK96RQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780464; c=relaxed/simple;
	bh=5esOVjkoJ2eWOHPTOdq4XkAFzqGI5J9sRUt0mPBSjpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWDuVuAmNcVvRncGFkSg+o8JxB0QRWWM4HR2YNffXUL4oLIDpaKhKwd5hfEv62Mp95eqb9PCn+yH0qJOxjQw/QYVgDFhxXVq1/v/T+QjGAT0HUX0/PPDGHiXdMmR4HMbMx9wof7cSM9tfXsu9h9I54z7jbE+L2amyToFJfoRF4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z2DDrAIk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=efTk+6so; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i4N8QDIz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UIIWaKgo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E856D221BF;
	Thu,  1 Feb 2024 09:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706780460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+OssChrIzAfno30EBsYpK2X0uaKO2TaBkF0UnlgyMp8=;
	b=Z2DDrAIkJKBo3Iyl1XE6oWTNJMfQBqhN2kAhWc2f2lg7eygtqs8ycoPKNaIJpGrBN2c8dx
	Aakjqt7/FrrERfyGt8mv7/ROaH6jwxUd3lva9/cFf479jstR2p7tCOUh4JLE+ItKe8edgq
	dpcVl2aJT9m9EVnWyAqS5biZUA+xjJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706780460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+OssChrIzAfno30EBsYpK2X0uaKO2TaBkF0UnlgyMp8=;
	b=efTk+6soIkhhyoX4DSW3OhRPxlpmBbMO8BArLZ1Cid1SYfkR2NHN39l8vuKhmqBUNpA3S4
	6PVwtn4HyQin+7Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706780459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+OssChrIzAfno30EBsYpK2X0uaKO2TaBkF0UnlgyMp8=;
	b=i4N8QDIzBh3L/YdH37lPGy7Pe+yQKHUplvzY+pnNiJaVoz86ffRQTVgQzRe2v9yMTo/x8Z
	KNM/aBua+7Ke+zK8bbNPHZxJynw4HPgGezHqr3CU8FFSw8PlP8ZXCqhgsdhEQU/mc+qXnY
	wbSrp6ge54etpzadFTh7wCdFoWqtju8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706780459;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+OssChrIzAfno30EBsYpK2X0uaKO2TaBkF0UnlgyMp8=;
	b=UIIWaKgo1ifc3OAiBYBoPgz+YHCNAUoGINQY2iuLpI42m7jqaUakv19mFF9DgDLMIMxw4Q
	ejTQkl+XeCHDCGDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D450D13594;
	Thu,  1 Feb 2024 09:40:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ihBiMytnu2VKVQAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 09:40:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 80AB0A0809; Thu,  1 Feb 2024 10:40:59 +0100 (CET)
Date: Thu, 1 Feb 2024 10:40:59 +0100
From: Jan Kara <jack@suse.cz>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mbcache: Simplify the allocation of slab caches
Message-ID: <20240201094059.3ov6qgv5etlgtxta@quack3>
References: <20240201093426.207932-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201093426.207932-1-chentao@kylinos.cn>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.75
X-Spamd-Result: default: False [-3.75 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.95)[99.77%]
X-Spam-Flag: NO

On Thu 01-02-24 17:34:26, Kunwu Chan wrote:
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/mbcache.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/mbcache.c b/fs/mbcache.c
> index 82aa7a35db26..fe2624e17253 100644
> --- a/fs/mbcache.c
> +++ b/fs/mbcache.c
> @@ -426,9 +426,8 @@ EXPORT_SYMBOL(mb_cache_destroy);
>  
>  static int __init mbcache_init(void)
>  {
> -	mb_entry_cache = kmem_cache_create("mbcache",
> -				sizeof(struct mb_cache_entry), 0,
> -				SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD, NULL);
> +	mb_entry_cache = KMEM_CACHE(mb_cache_entry,
> +					 SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD);
>  	if (!mb_entry_cache)
>  		return -ENOMEM;
>  	return 0;
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

