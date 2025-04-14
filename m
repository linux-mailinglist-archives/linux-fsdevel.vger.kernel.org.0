Return-Path: <linux-fsdevel+bounces-46371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FD8A8818E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 15:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433B23A77BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 13:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8814A2D1F4B;
	Mon, 14 Apr 2025 13:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tOoSzLEZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m5XMjYlV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tOoSzLEZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m5XMjYlV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD624594A
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636676; cv=none; b=E2A5K2C3UkaNaUaZ2BqfWKjuIJfdLyRtsBuT8dvdShoxCHyIJmoZ/nFbDneNzP2g1479FfxzxJOV+gHcFVWK/dhJG3usRoW4duhRu+XGt805qoNzG3Ksm1uZ73Nd0sggJYUetqIz6KEmDakaZd7MHR++X2zXvmxwMNH/E3EWcrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636676; c=relaxed/simple;
	bh=CKy6vWqX6n7t35He7yvaKX/u/mgAG0viU6lx94CgZcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lY7HvO5pbD6EdzoAXd3uQw1AEYApovzZr6OpaUOMq8YlD4qKmQl19T5QRvBzGidsf6VAviQuNlbHo+v/6ZGWepZ2dJmXzBInrN0TL0rYagEKs6rkKv4p4gi/AEO/npLdbDEvsIoVHHNSSk8iW7mvknIVGkG4hvseA5yX9s+bNqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tOoSzLEZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m5XMjYlV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tOoSzLEZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m5XMjYlV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 12E801F80E;
	Mon, 14 Apr 2025 13:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744636672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cbgemuGnlaKe1p5x1f82wXpF+J8wx9HvzivI2BFjeR4=;
	b=tOoSzLEZtgmrk2M/SP51rOoO7tGj1cILfi4vPiAeJIHlacKSyJrYRTzJb4/9A1RAU9QlFn
	i+05yOnYuXTN1KvjF1DkOULutrl9+LeoEiEQyqy36NzO2skbLGlFMRtw2+rfuClynJ7oiR
	Nk17tkJdBN156C/QhYMhDQmpksJgIJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744636672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cbgemuGnlaKe1p5x1f82wXpF+J8wx9HvzivI2BFjeR4=;
	b=m5XMjYlVbVKG7ru1vqrEHpU+WTEtcyXN3uGyGFeAZVH/PjhtwvNpedi9USvkLm00x0Jkgd
	BhONV3GUMDODThDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tOoSzLEZ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=m5XMjYlV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744636672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cbgemuGnlaKe1p5x1f82wXpF+J8wx9HvzivI2BFjeR4=;
	b=tOoSzLEZtgmrk2M/SP51rOoO7tGj1cILfi4vPiAeJIHlacKSyJrYRTzJb4/9A1RAU9QlFn
	i+05yOnYuXTN1KvjF1DkOULutrl9+LeoEiEQyqy36NzO2skbLGlFMRtw2+rfuClynJ7oiR
	Nk17tkJdBN156C/QhYMhDQmpksJgIJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744636672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cbgemuGnlaKe1p5x1f82wXpF+J8wx9HvzivI2BFjeR4=;
	b=m5XMjYlVbVKG7ru1vqrEHpU+WTEtcyXN3uGyGFeAZVH/PjhtwvNpedi9USvkLm00x0Jkgd
	BhONV3GUMDODThDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05D64136A7;
	Mon, 14 Apr 2025 13:17:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IWRrAf8K/WfIeQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Apr 2025 13:17:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B70AAA094B; Mon, 14 Apr 2025 15:17:46 +0200 (CEST)
Date: Mon, 14 Apr 2025 15:17:46 +0200
From: Jan Kara <jack@suse.cz>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v2 2/2] fs/fs_parse: Fix 3 issues for
 validate_constant_table()
Message-ID: <pgxiizhnhcuaol2vhwikrtqfcp6b3g4cxs26rwxzdxuyjnadtv@smpxafscsxod>
References: <20250411-fix_fs-v2-0-5d3395c102e4@quicinc.com>
 <20250411-fix_fs-v2-2-5d3395c102e4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411-fix_fs-v2-2-5d3395c102e4@quicinc.com>
X-Rspamd-Queue-Id: 12E801F80E
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[icloud.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[icloud.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 11-04-25 23:31:41, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Constant table array array[] which must end with a empty entry and fix
> below issues for validate_constant_table(array, ARRAY_SIZE(array), ...):
> 
> - Always return wrong value for good constant table array which ends
>   with a empty entry.
> 
> - Imprecise error message for missorted case.
> 
> - Potential NULL pointer dereference since the last pr_err() may use
>   'tbl[i].name' NULL pointer to print the last constant entry's name.
> 
> Fortunately, the function has no caller currently.
> Fix these issues mentioned above.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

As discussed, I'd rather drop this function since it is unused as well.

								Honza

> ---
>  fs/fs_parser.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> index e635a81e17d965df78ffef27f6885cd70996c6dd..ef7876340a917876bc40df9cdde9232204125a75 100644
> --- a/fs/fs_parser.c
> +++ b/fs/fs_parser.c
> @@ -399,6 +399,9 @@ bool validate_constant_table(const struct constant_table *tbl, size_t tbl_size,
>  	}
>  
>  	for (i = 0; i < tbl_size; i++) {
> +		if (!tbl[i].name && (i + 1 == tbl_size))
> +			break;
> +
>  		if (!tbl[i].name) {
>  			pr_err("VALIDATE C-TBL[%zu]: Null\n", i);
>  			good = false;
> @@ -411,13 +414,13 @@ bool validate_constant_table(const struct constant_table *tbl, size_t tbl_size,
>  				good = false;
>  			}
>  			if (c > 0) {
> -				pr_err("VALIDATE C-TBL[%zu]: Missorted %s>=%s\n",
> +				pr_err("VALIDATE C-TBL[%zu]: Missorted %s>%s\n",
>  				       i, tbl[i-1].name, tbl[i].name);
>  				good = false;
>  			}
>  		}
>  
> -		if (tbl[i].value != special &&
> +		if (tbl[i].name && tbl[i].value != special &&
>  		    (tbl[i].value < low || tbl[i].value > high)) {
>  			pr_err("VALIDATE C-TBL[%zu]: %s->%d const out of range (%d-%d)\n",
>  			       i, tbl[i].name, tbl[i].value, low, high);
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

