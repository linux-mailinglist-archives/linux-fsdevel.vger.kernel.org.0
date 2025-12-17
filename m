Return-Path: <linux-fsdevel+bounces-71568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE85CC7B4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 13:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16F1A303E019
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 12:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3873933A03A;
	Wed, 17 Dec 2025 12:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lw8Pqbvj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="amtyd3CT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iF4oLnYz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ehQQQuGw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD551A9FAC
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 12:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765976088; cv=none; b=NdiJIxdAuBNTvYwe/+e7hFdCo7nbmCC2x2YTZWN7e8dvCW+ukgWCq7uaMWh0Dn+EQJJyyc4e27hlhWVLAnBVXO8VrIbDcGS3jjvRpuboUB51K1V9mrH50C7COCdjWYaIbcfjeT8313/shQHfHCXtYg6fBp8Adoh7iKBh83oL8/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765976088; c=relaxed/simple;
	bh=bNd23k1RJD9GF7fCaOrUuA1Z6kLf0ZyajeaDQDBHIBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACIOgrOVeEW/ClbAD5d8meQ0MN/pP8YdWNaNi87y+Y8c7p9/6Humia/59PF9GO4TPbAjqKA27oTswR7QwwTFIo6UrYWTwsxMUZ/2lCw72w6EKwatNyUtIVys8wmo7y1ZMd9XMRfcmXL/Xa/g/unFSmxH6ela6yrfRmHaDAC4uvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lw8Pqbvj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=amtyd3CT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iF4oLnYz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ehQQQuGw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2F80A336C4;
	Wed, 17 Dec 2025 12:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765976085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XzEAnGLgeC5Eh11JFv7175d14qSACXt1bNrgucAFwZo=;
	b=lw8Pqbvja311IsDBhbScMFkP+k+hSd5CYKuoo2jME29eioGM6g1SeNjpJPfRTs0E+qfhVg
	6s+Cj4ndXKcpRQWCpKAzk3sHHAqLqU4mZnmcB1kV0YmYLr5Ts7JaGFUpNWxy3xoEKS7t82
	FWnamJYFjGBbQ+8T7FI1zYNufHvJ8MI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765976085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XzEAnGLgeC5Eh11JFv7175d14qSACXt1bNrgucAFwZo=;
	b=amtyd3CTrrK1y93fVcBUnTsTvzQwN/rwmCHpwpcBwe+lr8PwInVPczUvmWW9kVDFEwHojd
	S6dbvtM/n8/KJCAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iF4oLnYz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ehQQQuGw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765976084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XzEAnGLgeC5Eh11JFv7175d14qSACXt1bNrgucAFwZo=;
	b=iF4oLnYzN4KJPs3LzFzbTr5oCfw/bobmvLkTiPQ2IoPV5QZ18CaCmH5ufJKH5zGbEQAMhG
	phxbfwA4O7S0gdA986+9uoRh6XwJ0QI4qKXtK3qTEobdFSCVUDMEb6lZSYXnVqxlZlVOPU
	SdlXFkai54GG18CiYYVLhzDGXe/BOKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765976084;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XzEAnGLgeC5Eh11JFv7175d14qSACXt1bNrgucAFwZo=;
	b=ehQQQuGwZnvuKY7c1dZJwOHdOdd0L+Wle03yIcYo4GYhCaJ6hJcutj3QdJSg3gnqlXS4D5
	znyZKPfVVlPud7AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C1363EA63;
	Wed, 17 Dec 2025 12:54:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qQB7BhSoQmlHMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Dec 2025 12:54:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 81007A0927; Wed, 17 Dec 2025 13:54:43 +0100 (CET)
Date: Wed, 17 Dec 2025 13:54:43 +0100
From: Jan Kara <jack@suse.cz>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache: Replace simple_strtoul with kstrtoul in
 set_dhash_entries
Message-ID: <fnkyiadjcploybppeae542itv25o5nzm6jjlvmgvs5g6ygipq3@mmtzgdsds7nf>
References: <20251216145236.44520-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216145236.44520-2-thorsten.blum@linux.dev>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 2F80A336C4
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,linux.dev:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

On Tue 16-12-25 15:52:37, Thorsten Blum wrote:
> Replace simple_strtoul() with the recommended kstrtoul() for parsing the
> 'dhash_entries=' boot parameter.
> 
> Check the return value of kstrtoul() and reject invalid values. This
> adds error handling while preserving behavior for existing values, and
> removes use of the deprecated simple_strtoul() helper.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/dcache.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index dc2fff4811d1..ec275f4fd81c 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -3227,10 +3227,7 @@ EXPORT_SYMBOL(d_parent_ino);
>  static __initdata unsigned long dhash_entries;
>  static int __init set_dhash_entries(char *str)
>  {
> -	if (!str)
> -		return 0;
> -	dhash_entries = simple_strtoul(str, &str, 0);
> -	return 1;
> +	return kstrtoul(str, 0, &dhash_entries) == 0;
>  }
>  __setup("dhash_entries=", set_dhash_entries);
>  
> -- 
> Thorsten Blum <thorsten.blum@linux.dev>
> GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

