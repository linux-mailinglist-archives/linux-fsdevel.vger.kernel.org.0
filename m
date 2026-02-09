Return-Path: <linux-fsdevel+bounces-76695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PrOCy6+iWneBQUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 11:59:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3D110E78C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 11:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12B7A302A534
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 10:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A6736998F;
	Mon,  9 Feb 2026 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LLdLbtbl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i2ScIvsM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LLdLbtbl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i2ScIvsM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336FF369231
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770634571; cv=none; b=f7Job/w4nFt8YX/jMABEiWO3+xYy3UQTZUhf4YZbb5bATnvZk9g1HYskKhWxYYhmvZpsJysXlRxDdSsu4jXIE4O5hWjZHSiUChBrysV9tGTcU+TYn6bblw/xssYBeGqzimG1HQuddD9BB+u1J0EUn99SOSMwZR+ZHVtK5UafYlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770634571; c=relaxed/simple;
	bh=1cAqssX9I3mDX/9nfmkWvlxFXReOewsAvjQ89XCwBwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsSq2J+RPLBx7RSvMiLp9QLSsjP/jIJ9WkUT305F27ig29lL46L3OoLcOpWywRn4205QzW99UPDs5My9kcdaQYbrr2mrdFcGI58ath0GmNpwATz6OEen8GOU1nrlE/91ClmmzfPdk4hB86HOJ5jIIa1Bo/D6kho6RPeUW0Cpsv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LLdLbtbl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i2ScIvsM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LLdLbtbl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i2ScIvsM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 77A623E6E7;
	Mon,  9 Feb 2026 10:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770634569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bipua3Ir60MfzXCM9F8PX40hI/RZj553n1aw8TfsLp4=;
	b=LLdLbtblriPMs7oqHgHrWSZw+9TIGxDWed6JJXEBvYd+Z0X7qDMcC5007CDpU4vP9uGlxX
	yLT5IBmAzvKnprPK5plWAuq31uEf2FrbHsBElc90PHluZ1i23OdNSgsW2u42kNSgjWHw0I
	tr8HXIlhYNcc3Q9mD5MFQ5XRZ5Me2Ng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770634569;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bipua3Ir60MfzXCM9F8PX40hI/RZj553n1aw8TfsLp4=;
	b=i2ScIvsM/XtQxyptLXc4xVw7Ux+pBJNJU80dR1KczOckVNhCT2UJVxyFgKU4gzmADrnOXA
	y+XrvAw5dQTIB2Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LLdLbtbl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=i2ScIvsM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770634569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bipua3Ir60MfzXCM9F8PX40hI/RZj553n1aw8TfsLp4=;
	b=LLdLbtblriPMs7oqHgHrWSZw+9TIGxDWed6JJXEBvYd+Z0X7qDMcC5007CDpU4vP9uGlxX
	yLT5IBmAzvKnprPK5plWAuq31uEf2FrbHsBElc90PHluZ1i23OdNSgsW2u42kNSgjWHw0I
	tr8HXIlhYNcc3Q9mD5MFQ5XRZ5Me2Ng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770634569;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bipua3Ir60MfzXCM9F8PX40hI/RZj553n1aw8TfsLp4=;
	b=i2ScIvsM/XtQxyptLXc4xVw7Ux+pBJNJU80dR1KczOckVNhCT2UJVxyFgKU4gzmADrnOXA
	y+XrvAw5dQTIB2Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62F7A3EA63;
	Mon,  9 Feb 2026 10:56:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MEcmGEm9iWl+WAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Feb 2026 10:56:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2102CA061E; Mon,  9 Feb 2026 11:56:01 +0100 (CET)
Date: Mon, 9 Feb 2026 11:56:01 +0100
From: Jan Kara <jack@suse.cz>
To: klourencodev@gmail.com
Cc: linux-mm@kvack.org, jack@suse.cz, rppt@kernel.org, 
	akpm@linux-foundation.org, david@kernel.org, vbabka@suse.cz, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] mm/fadvise: validate offset in generic_fadvise
Message-ID: <yty3z2cd5icaoyjmw6sq5x5gvkcibfl33ilvsq7ajdic7xkemq@x73k2uvtn6ut>
References: <CAFveykMPrkb=VYwQAjCEARsC_WAGfQXMz_gf8Q0CTHWHooNHVA@mail.gmail.com>
 <20260208135738.18992-1-klourencodev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260208135738.18992-1-klourencodev@gmail.com>
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_FROM(0.00)[bounces-76695-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8C3D110E78C
X-Rspamd-Action: no action

On Sun 08-02-26 14:57:38, klourencodev@gmail.com wrote:
> From: Kevin Lourenco <klourencodev@gmail.com>
> 
> When converted to (u64) for page calculations, a negative offset can
> produce extremely large page indices. This may lead to issues in certain
> advice modes (excessive readahead or cache invalidation).
> 
> Reject negative offsets with -EINVAL for consistent argument validation
> and to avoid silent misbehavior.
> 
> POSIX and the man page do not clearly define behavior for negative
> offset/len. FreeBSD rejects negative offsets as well, so failing with
> -EINVAL is consistent with existing practice. The man page can be
> updated separately to document the Linux behavior.
> 
> Signed-off-by: Kevin Lourenco <klourencodev@gmail.com>

Indeed. That looks like an oversight. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/fadvise.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/fadvise.c b/mm/fadvise.c
> index 67028e30aa91..b63fe21416ff 100644
> --- a/mm/fadvise.c
> +++ b/mm/fadvise.c
> @@ -43,7 +43,7 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
>  		return -ESPIPE;
>  
>  	mapping = file->f_mapping;
> -	if (!mapping || len < 0)
> +	if (!mapping || len < 0 || offset < 0)
>  		return -EINVAL;
>  
>  	bdi = inode_to_bdi(mapping->host);
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

