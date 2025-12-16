Return-Path: <linux-fsdevel+bounces-71455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D094CC19F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 09:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B46EF303F2BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 08:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B87314A8D;
	Tue, 16 Dec 2025 08:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ureASUOa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AIBP9r7g";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c97JD+w/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kT7x9VtW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDF21CD1E4
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 08:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765874474; cv=none; b=WAP8nx/zmJgTiwQpWKlB+WjxCcjhNDLCZA4ncrQIqz21pLCdl/CwhPx+lE94+Z3O9qrcSfIxLKh5Z7RVqfm+7edu1s444kKDT81ZHkeXBE8HlaMc0hKoh+icPxDB/5mGVWIvMB3Au8/nlBPH16ISxSlVZmB+Nk1oBOngFkIqjVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765874474; c=relaxed/simple;
	bh=woGpMLJm8tqi9Z6nLnUJdY6h8xLpHw9/sDVeinrfqXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyoQ4Hbh03Pqo1T9bxgKG73lQjUsPpg1zN4mFhTMBppk+bdOYfhqJsznN/nsuEJIW6f7HrkafKv8KcUNPvRykX8GD5IdSRzG0MyA9+6C8duEEqc27e8rAhOBf5CAbH0LKk/P8kxQFluzpfeTSEDP8xf1S9l4fV5WgpoKMOuiVqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ureASUOa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AIBP9r7g; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c97JD+w/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kT7x9VtW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AD82A33697;
	Tue, 16 Dec 2025 08:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765874469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GLVWwa1HwE4FI9wBRw8kxuaGXBODatqcJC7Y1O2d4OQ=;
	b=ureASUOaaUM64DY85fYKpNMipVBdMmG2zWmyrN8+pJKHCB2WQ/fjs4RyB10n4rybUSrshO
	VwQhZp8DiK+82Y3ashn0reralglpneHM4iFVHW/9INEV/faNh7VIf38s4JUGT56A7DpC00
	lNYoq6qpTiODtWTM/xwR3zSg7b8dvo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765874469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GLVWwa1HwE4FI9wBRw8kxuaGXBODatqcJC7Y1O2d4OQ=;
	b=AIBP9r7giZj1FTppTh73sAb9tuipen4dn6l9O8yolO2fLSNEevCEuqP9HIJbPelMy1b7rK
	HhDsEWQYn2/KrrCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="c97JD+w/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kT7x9VtW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765874468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GLVWwa1HwE4FI9wBRw8kxuaGXBODatqcJC7Y1O2d4OQ=;
	b=c97JD+w/uCWq63L/Ws46Hst3zMJkrtG9ZAscVotJ33psdaBg2yd+ghuq6bjcME94hreJxe
	0eDbn+S8cnAyW+x0uzYU6CJsycx+juG7DY1HfQ+o3ZP/C8jtTmqOyU3hWkyh2Tzq1uefBj
	zSVLkqFQAxzvegqm3T/uxDwsvnOZ9o8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765874468;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GLVWwa1HwE4FI9wBRw8kxuaGXBODatqcJC7Y1O2d4OQ=;
	b=kT7x9VtW+j3nt0pMWHX1GaBTqxvqLlyfNZSIbZhOFAHF5mE4hlCUrWG4fstmcGAK4cKPi1
	llkFED+YfO0GzRCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A06B43EA65;
	Tue, 16 Dec 2025 08:41:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HW0iJyQbQWkGDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 16 Dec 2025 08:41:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 63D03A09E1; Tue, 16 Dec 2025 09:41:08 +0100 (CET)
Date: Tue, 16 Dec 2025 09:41:08 +0100
From: Jan Kara <jack@suse.cz>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] namespace: Replace simple_strtoul with kstrtoul to parse
 boot params
Message-ID: <rsiev2lo6zgfe2nhc2rvipcq7lr67v45d3znzdqozbhrlorvzi@7hpgsgmnibmy>
References: <20251214153141.218953-2-thorsten.blum@linux.dev>
 <3hnvigpwa2jomy6wimsdkkz4da64x7nsk4ffoko47ocpokqbou@fqymwie5damt>
 <E07BDF4C-F76A-4050-A4B9-3D2A362A3ABE@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E07BDF4C-F76A-4050-A4B9-3D2A362A3ABE@linux.dev>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: AD82A33697
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
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

On Mon 15-12-25 15:17:14, Thorsten Blum wrote:
> On 15. Dec 2025, at 10:15, Jan Kara wrote:
> > On Sun 14-12-25 16:31:42, Thorsten Blum wrote:
> >> Replace simple_strtoul() with the recommended kstrtoul() for parsing the
> >> 'mhash_entries=' and 'mphash_entries=' boot parameters.
> >> 
> >> Check the return value of kstrtoul() and reject invalid values. This
> >> adds error handling while preserving behavior for existing values, and
> >> removes use of the deprecated simple_strtoul() helper.
> >> 
> >> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > 
> > ...
> > 
> >> @@ -49,20 +49,14 @@ static unsigned int mp_hash_shift __ro_after_init;
> >> static __initdata unsigned long mhash_entries;
> >> static int __init set_mhash_entries(char *str)
> >> {
> >> -	if (!str)
> >> -		return 0;
> >> -	mhash_entries = simple_strtoul(str, &str, 0);
> >> -	return 1;
> >> +	return kstrtoul(str, 0, &mhash_entries) == 0;
> >> }
> >> __setup("mhash_entries=", set_mhash_entries);
> > 
> > I'm not very experienced with the cmdline option parsing but AFAICT the
> > 'str' argument can be indeed NULL and kstrtoul() will not be happy with
> > that?
> 
> I don't think 'str' can be NULL. If you don't pass a value, 'str' will
> be the empty string (just tested this).

Ah, ok. The NULL value can happen only for early parameters and for
arguments without '=' sign in the name. So I'm retracting my objection and
feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>


								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

