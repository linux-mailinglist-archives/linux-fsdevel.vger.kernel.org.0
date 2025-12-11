Return-Path: <linux-fsdevel+bounces-71094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7ABCB55AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 10:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 253E5301586E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 09:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66C92F6934;
	Thu, 11 Dec 2025 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tsY/rASf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7yNgbLD7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oBs2LR18";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="70tYS6uH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52092E62A2
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765445038; cv=none; b=VWNkpStuh429ntjLDmNJeEDTAF0x52yq/BRdeW/yfrwVeT1V/GuroHf/xpIu+qRRjWdol4k3ufVJxkIAhPaKOCTGytvTWN1TsPoru3fda1+zU54TleZuCIlsfD4UnIIqO8giLvf5URnDm7VaQCRktNmjwKsfVrblAvDQ9XC6eN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765445038; c=relaxed/simple;
	bh=2rXGHe79D8qwD/zSu56VI9mCMlyPvFT5Qaf/bKTD9jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkGJ3EEVKIaRce6bAfxcWAGeZtsgNhQc7iUMpojvQKHcqmJW4V5fhWqql9hx1hJmcdIE1GsTCSRvfsy5KWPPOzScYrQXhCuggwrhwpU5Cr7wKar/LvuSix5KAxnjP0LBFX5kaxwPCDmG+DKXm5HeoEADl1jHR/lJZFC6rcfA5x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tsY/rASf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7yNgbLD7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oBs2LR18; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=70tYS6uH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B6822337FC;
	Thu, 11 Dec 2025 09:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765445034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sYemMym4/AZ5WKzC6rKGejU7zXFUtAHtG4YwluyWhhM=;
	b=tsY/rASfFYY8PknuGJ7TcQUCyXpOK3gfMzWTq+F1JcRR5VaDn4DFfXNg7PG6FNy2HO0uOP
	zTUrWSex8GGAGFoXf8HnAXHOtsF+yEIJW+fWECoDHOKGmC6wsyX8KRk87mbevxjZR9lNGu
	zqD1i6PRlkTIOY/QJc7JWqDeWFRUbbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765445034;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sYemMym4/AZ5WKzC6rKGejU7zXFUtAHtG4YwluyWhhM=;
	b=7yNgbLD7LqbiuLTID1MTtsmXijUS+HIMYAqKSvL7agGT982stSKagWGUdiE1zekULTIsqf
	HL7dLutiPUDE1LAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oBs2LR18;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=70tYS6uH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765445033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sYemMym4/AZ5WKzC6rKGejU7zXFUtAHtG4YwluyWhhM=;
	b=oBs2LR18d4TkgrjrSZ5YedE5oIkwvp8BP0nZ5O85ICb8uEYjAlcQv9JuM1FLjXOhK0zZ2r
	+k1KsXlB9glBkr2rektp8wj55gYlKFNTOCdzc+Xeltkex3+xNlMypwbhsKUeXUY8rfKcxN
	JVW5eM4rByaZlD9cnrp8GJfAvvph2aM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765445033;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sYemMym4/AZ5WKzC6rKGejU7zXFUtAHtG4YwluyWhhM=;
	b=70tYS6uHyX9regOmrNbkEKUXpy6wu10ZAD1AQe47UcDZGujc6fYdQKGodJ9sXP/EY3dRwa
	P7OCIN+Ou/kaHUBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC73E3EA63;
	Thu, 11 Dec 2025 09:23:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x+IWKqmNOmnOdgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 11 Dec 2025 09:23:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6C324A0A04; Thu, 11 Dec 2025 10:23:53 +0100 (CET)
Date: Thu, 11 Dec 2025 10:23:53 +0100
From: Jan Kara <jack@suse.cz>
To: Deepakkumar Karn <dkarn@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/buffer: add alert in try_to_free_buffers() for folios
 without buffers
Message-ID: <pt6xr3w5ne22gqvgxzbdhwfm45wiiwqmycajofgnnzlrzowmeh@iek3vsmkvs5j>
References: <20251210180228.211655-1-dkarn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210180228.211655-1-dkarn@redhat.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: B6822337FC
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
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

On Wed 10-12-25 23:32:28, Deepakkumar Karn wrote:
> try_to_free_buffers() can be called on folios with no buffers attached
> when filemap_release_folio() is invoked on a folio belonging to a mapping
> with AS_RELEASE_ALWAYS set but no release_folio operation defined.
> 
> In such cases, folio_needs_release() returns true because of the
> AS_RELEASE_ALWAYS flag, but the folio has no private buffer data. This
> causes try_to_free_buffers() to call drop_buffers() on a folio with no
> buffers, leading to a null pointer dereference.
> 
> Adding a check in try_to_free_buffers() to return early if the folio has no
> buffers attached, with WARN_ON_ONCE() to alert about the misconfiguration.
> This provides defensive hardening.
> 
> Signed-off-by: Deepakkumar Karn <dkarn@redhat.com>
> ---
>  fs/buffer.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 838c0c571022..b229baa77055 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2948,6 +2948,10 @@ bool try_to_free_buffers(struct folio *folio)
>  	if (folio_test_writeback(folio))
>  		return false;
>  
> +	/* Misconfigured folio check */
> +	if (WARN_ON_ONCE(!folio_buffers(folio)))
> +		return false;

This should really be returning true. Otherwise the folio will never get
released.

								Honza

> +
>  	if (mapping == NULL) {		/* can this still happen? */
>  		ret = drop_buffers(folio, &buffers_to_free);
>  		goto out;
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

