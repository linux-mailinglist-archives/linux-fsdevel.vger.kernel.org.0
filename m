Return-Path: <linux-fsdevel+bounces-71747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68769CD01CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 14:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CDF43019181
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 13:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0422FFF87;
	Fri, 19 Dec 2025 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WuhWbLGC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o7vHX1WT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WKJJPf6I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lG0FKxlA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AA31E7C34
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766152230; cv=none; b=f9ga7eVsGsIqVP3leNco+PakP5f80Mr0Lq8Ch36tz8+DCHL0V8lPTlXj9gciIarfDcVQbzf8hkENW0KMjPZitcn2ZpgwwFUz8573Xv79Q9qplAxRrEYSjaeH5HT2QD4SPi8CeM3mH5UsTswWrg/vvMldmvKcV5xU8YpktrpDEuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766152230; c=relaxed/simple;
	bh=uSkJbWOgVUfugRYXq0e8tPxwMHGF0N3R4BQipRi1kWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRwgOcdEo/0GgkVnEGzMSMXZt1S2Iz2bFFNxZKvSpb/nvZCR1EFvSDb+Im3MJXmhiiKucjXtrcAaBgJo4jHJXbRLvyzJMftJsqt5Lbzgy4iFI1zIYmRQ3QxC1n608ZkjNTXUoqS8Ub4qy0fHLh/bXzG+iugZSYqk/TwaDpW3ILA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WuhWbLGC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o7vHX1WT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WKJJPf6I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lG0FKxlA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B99FD5BD3A;
	Fri, 19 Dec 2025 13:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766152226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RfwpUequWA+T7+J2mQ5sDtN5JtdbuLida7gLNS8TPWQ=;
	b=WuhWbLGCcHZnx7UYwF/GwEdWrYjA5w+8Eqb+4j03aJWADSR54z5kjrbRmbARKPUQny4j9W
	hwq577QymcpwVBDYzAEriWYNULo3KdXxP0IbnWCZQRAMDm/pcg7M7NfV8rYicwS39KGbLN
	ZTLKCI1Jya/WIquftivmueuLb41NRGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766152226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RfwpUequWA+T7+J2mQ5sDtN5JtdbuLida7gLNS8TPWQ=;
	b=o7vHX1WTdNO975gy92N4YnKWjUaqCzVvWKWmb+suRDcFwcxv3J8NPsM2W6kFFOoLzEQdzO
	Mo8XNjM7eA+DG5Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WKJJPf6I;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lG0FKxlA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766152224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RfwpUequWA+T7+J2mQ5sDtN5JtdbuLida7gLNS8TPWQ=;
	b=WKJJPf6IByvlgVc+bLyq9fyjNTtP2QLXr0ALjfD9UIp+TS/iL3gJdwvRSh1w3iAQQHIK+h
	M42SHEvYZBgu4FkUpU7onGKlSkURzPSFOsoFMy8g0e1q7UoydfUBURf4UzAFAXEcLWulOI
	j+T8q/ldDLmOVwNb2S16Qh03mwHFwt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766152224;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RfwpUequWA+T7+J2mQ5sDtN5JtdbuLida7gLNS8TPWQ=;
	b=lG0FKxlAzH0ghry4ToeWjccPS/4UwdwS7m9JHwFRfyc9Qutl1QXaV2nI4Gdcwx7ockNP7F
	q7v4esuJypvobeDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AECA43EA63;
	Fri, 19 Dec 2025 13:50:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qMGpKiBYRWk3MwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 19 Dec 2025 13:50:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 64360A090B; Fri, 19 Dec 2025 14:50:24 +0100 (CET)
Date: Fri, 19 Dec 2025 14:50:24 +0100
From: Jan Kara <jack@suse.cz>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Mateusz Guzik <mjguzik@gmail.com>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 1/2] fs: Describe @isnew parameter in ilookup5_nowait()
Message-ID: <w3tm4tlylon4wm3tjty46psodlloqy6nxfnp3xbxgpu46i6jm2@455xekzztppc>
References: <20251219024620.22880-1-bagasdotme@gmail.com>
 <20251219024620.22880-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219024620.22880-2-bagasdotme@gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
X-Rspamd-Queue-Id: B99FD5BD3A
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Fri 19-12-25 09:46:19, Bagas Sanjaya wrote:
> Sphinx reports kernel-doc warning:
> 
> WARNING: ./fs/inode.c:1607 function parameter 'isnew' not described in 'ilookup5_nowait'
> 
> Describe the parameter.
> 
> Fixes: a27628f4363435 ("fs: rework I_NEW handling to operate without fences")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/inode.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 521383223d8a45..379f4c19845c95 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1593,6 +1593,9 @@ EXPORT_SYMBOL(igrab);
>   * @hashval:	hash value (usually inode number) to search for
>   * @test:	callback used for comparisons between inodes
>   * @data:	opaque data pointer to pass to @test
> + * @isnew:	return argument telling whether I_NEW was set when
> + *		the inode was found in hash (the caller needs to
> + *		wait for I_NEW to clear)
>   *
>   * Search for the inode specified by @hashval and @data in the inode cache.
>   * If the inode is in the cache, the inode is returned with an incremented
> -- 
> An old man doll... just what I always wanted! - Clara
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

