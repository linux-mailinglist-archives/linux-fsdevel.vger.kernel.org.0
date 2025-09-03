Return-Path: <linux-fsdevel+bounces-60142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE23B41C94
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 13:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B035626EA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 11:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3AA2F4A17;
	Wed,  3 Sep 2025 11:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JAmKM1kb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rSUK1wDv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JAmKM1kb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rSUK1wDv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E8C2F3C0A
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756897465; cv=none; b=b1t6tDs8QHfTJeu3ghb5+cj9k0WHrGXoBqF5XKvVapGdhKJKCSAZvIK21TxDasc1qC7ilG4JPNXjjra+E+KhjgQn8ERqgWFtZhjRLnxxO4P81j6DlbGOri+hiKCpz7lghcr4dpnwnUS1wRVDPXGsz9ncHfr77lEycaBR/y4AkB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756897465; c=relaxed/simple;
	bh=fZ8AP/bIDgxJgoa+C3tfuZxRU5wild3eBN7crAa9Cas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNw5MRyeSdJKyl+x3ziwXCti4MTNWBIAgsCpcYK6KWkpX499AkxaqnLwke7pIJPCHV7s9cqumnL422rBmBU7z5ppQtDA1MK5NP+ehI0AOiMEm5za3+J8/dsnWPJTZT1RforRxQPHIlBGGrJPgvexQ4PEGkDsSzD8bMgnjMUOb6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JAmKM1kb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rSUK1wDv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JAmKM1kb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rSUK1wDv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 79DE01F453;
	Wed,  3 Sep 2025 11:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756897461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=42UAPVcSApsZe1j7ADJ0rBBXxxQZOSxwLxvKqo+L584=;
	b=JAmKM1kbfW4ZUsXPwFwv6Kwj/NHBsMS1v+wFoXVifCmOmdbxngxfGwJoXPZgA0+tKCC5Ov
	N/ojQVtnjPsXhEdqlHAQiNnz01r/MJEg+Rgii/tEQBpoanQk2HaWqvGwEweIrky3KoYZRk
	o2Yx9mlOIfLJBV6SMaF7t4PewvnOi8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756897461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=42UAPVcSApsZe1j7ADJ0rBBXxxQZOSxwLxvKqo+L584=;
	b=rSUK1wDvD2/5MdpEUzSubJ422COzhsVihCgmCEURuHjwo0YvlhvSxNlJ0yALk2KBLG0nHA
	LVKRKWD+AJ7Zu9CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JAmKM1kb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rSUK1wDv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756897461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=42UAPVcSApsZe1j7ADJ0rBBXxxQZOSxwLxvKqo+L584=;
	b=JAmKM1kbfW4ZUsXPwFwv6Kwj/NHBsMS1v+wFoXVifCmOmdbxngxfGwJoXPZgA0+tKCC5Ov
	N/ojQVtnjPsXhEdqlHAQiNnz01r/MJEg+Rgii/tEQBpoanQk2HaWqvGwEweIrky3KoYZRk
	o2Yx9mlOIfLJBV6SMaF7t4PewvnOi8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756897461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=42UAPVcSApsZe1j7ADJ0rBBXxxQZOSxwLxvKqo+L584=;
	b=rSUK1wDvD2/5MdpEUzSubJ422COzhsVihCgmCEURuHjwo0YvlhvSxNlJ0yALk2KBLG0nHA
	LVKRKWD+AJ7Zu9CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7028113888;
	Wed,  3 Sep 2025 11:04:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /CNcG7UguGgrEgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 03 Sep 2025 11:04:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 23E8DA0809; Wed,  3 Sep 2025 13:04:21 +0200 (CEST)
Date: Wed, 3 Sep 2025 13:04:21 +0200
From: Jan Kara <jack@suse.cz>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, jack@suse.cz, djwong@kernel.org
Subject: Re: [PATCH RFC 1/2] iomap: prioritize iter.status error over
 ->iomap_end()
Message-ID: <6loqwledskxhpmzjahgnvwqh3fncr3xbxny454zp7ya6iazccz@ls3p5367ghyi>
References: <20250902150755.289469-1-bfoster@redhat.com>
 <20250902150755.289469-2-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902150755.289469-2-bfoster@redhat.com>
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
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 79DE01F453
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Tue 02-09-25 11:07:54, Brian Foster wrote:
> Jan Kara reports that commit bc264fea0f6f subtly changed error
> handling behavior in iomap_iter() in the case where both iter.status
> and ->iomap_end() return error codes. Previously, iter.status had
> priority and would return to the caller regardless of the
> ->iomap_end() result. After the change, an ->iomap_end() error
> returns immediately.
> 
> This had the unexpected side effect of enabling a DIO fallback to
> buffered write on ext4 because ->iomap_end() could return -ENOTBLK
> and overload an -EINVAL error from the core iomap direct I/O code.
> 
> This has been fixed independently in ext4, but nonetheless the
> change in iomap was unintentional. Since other filesystems may use
> this in similar ways, restore long standing behavior and always
> return the value of iter.status if it happens to contain an error
> code.
> 
> Fixes: bc264fea0f6f ("iomap: support incremental iomap_iter advances")
> Diagnosed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Brian Foster <bfoster@redhat.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/iomap/iter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> index cef77ca0c20b..7cc4599b9c9b 100644
> --- a/fs/iomap/iter.c
> +++ b/fs/iomap/iter.c
> @@ -80,7 +80,7 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
>  				iomap_length_trim(iter, iter->iter_start_pos,
>  						  olen),
>  				advanced, iter->flags, &iter->iomap);
> -		if (ret < 0 && !advanced)
> +		if (ret < 0 && !advanced && !iter->status)
>  			return ret;
>  	}
>  
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

