Return-Path: <linux-fsdevel+bounces-8047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D36C82ECD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 11:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56E0E1C23028
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 10:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F5713AD7;
	Tue, 16 Jan 2024 10:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T4iXctF+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9Flumjhr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T4iXctF+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9Flumjhr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726B213AC0;
	Tue, 16 Jan 2024 10:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 45EB3220F7;
	Tue, 16 Jan 2024 10:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705401523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XsQ+QDzc+dLNKivH9YysIOMA0F3Q91RojSCj5RO994Q=;
	b=T4iXctF+el0onzrMKQkvhu2I97CzCmnTvafVPBHkTOlEadIbBiW9sP2fdAXiyTzGVucyLp
	wjZlX0LhA9oNIkd+JVbvw1/aXw3TpezhRgleGsWVEV04eT4CQjR3eabnxKhBzcXLjsyA7+
	Qa/3BP9wZlQ0ZcTNMT/+UkSgnBaph9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705401523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XsQ+QDzc+dLNKivH9YysIOMA0F3Q91RojSCj5RO994Q=;
	b=9FlumjhrocENccD//Kz+pMPHhuppwUvUMvn3YXaz7etoTVMBLyuHeTakz31/Xe5JOgr2Ht
	3M1ZITvfC5xW71AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705401523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XsQ+QDzc+dLNKivH9YysIOMA0F3Q91RojSCj5RO994Q=;
	b=T4iXctF+el0onzrMKQkvhu2I97CzCmnTvafVPBHkTOlEadIbBiW9sP2fdAXiyTzGVucyLp
	wjZlX0LhA9oNIkd+JVbvw1/aXw3TpezhRgleGsWVEV04eT4CQjR3eabnxKhBzcXLjsyA7+
	Qa/3BP9wZlQ0ZcTNMT/+UkSgnBaph9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705401523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XsQ+QDzc+dLNKivH9YysIOMA0F3Q91RojSCj5RO994Q=;
	b=9FlumjhrocENccD//Kz+pMPHhuppwUvUMvn3YXaz7etoTVMBLyuHeTakz31/Xe5JOgr2Ht
	3M1ZITvfC5xW71AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3870413751;
	Tue, 16 Jan 2024 10:38:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CiXEDbNcpmUPKgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 16 Jan 2024 10:38:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C3E16A0803; Tue, 16 Jan 2024 11:38:42 +0100 (CET)
Date: Tue, 16 Jan 2024 11:38:42 +0100
From: Jan Kara <jack@suse.cz>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] buffer: Use KMEM_CACHE instead of kmem_cache_create()
Message-ID: <20240116103842.g2dxbqno2owkuaqt@quack3>
References: <20240116091137.92375-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116091137.92375-1-chentao@kylinos.cn>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=T4iXctF+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9Flumjhr
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_IN_DNSWL_HI(-1.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[29.65%]
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 45EB3220F7
X-Spam-Flag: NO

On Tue 16-01-24 17:11:37, Kunwu Chan wrote:
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index d3bcf601d3e5..9c8156cce9b7 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -3121,12 +3121,8 @@ void __init buffer_init(void)
>  	unsigned long nrpages;
>  	int ret;
>  
> -	bh_cachep = kmem_cache_create("buffer_head",
> -			sizeof(struct buffer_head), 0,
> -				(SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|
> -				SLAB_MEM_SPREAD),
> -				NULL);
> -
> +	bh_cachep = KMEM_CACHE(buffer_head,
> +				SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|SLAB_MEM_SPREAD);
>  	/*
>  	 * Limit the bh occupancy to 10% of ZONE_NORMAL
>  	 */
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

