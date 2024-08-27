Return-Path: <linux-fsdevel+bounces-27341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726AF96068A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 12:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1812887B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 10:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBE919B3EC;
	Tue, 27 Aug 2024 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="anJzIiLA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cga5pB6q";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="anJzIiLA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cga5pB6q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8F5364A9;
	Tue, 27 Aug 2024 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752849; cv=none; b=J9f1hUbPgbYNtI9nwXlgQ3Kx5cLVIbGUzDJUySq3tXHYosTNn94sVgBqncWKKkpGuNYZJE/VdypcB/nB1annikQm4VpmmZKbfXK6wVsX6W5bYroELSwsaAYkM+0qDkLjphEQGfOMPUliPyizt7grdD65oFuDWwqTDSsVWldT6cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752849; c=relaxed/simple;
	bh=VI9dtI/WAkLKuR/tijciKts/9rXXeGlBaovyd+X7OeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgk1QZ+bXmHaw3TQIr/hgvQYYkUY6/Qf9AP0FY9OGy3bl91UdP7Z5VYmZ9SpbeN1JZZa6KPj1zT0cDz/gqZjNqva4wdQTuRSfBPB7yvOoeHgIwJoYY87RLO8vV9AiSTMEO+iuu0hhwgi1B8QF5knB4na0Gv+vH2zfR9fsPXAQ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=anJzIiLA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cga5pB6q; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=anJzIiLA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cga5pB6q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 70BCF21B0C;
	Tue, 27 Aug 2024 10:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724752845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9162i3i+o72LGv4bQrnFxBt/xA3Dpeirq/7V6JbFMBk=;
	b=anJzIiLAWuu+v4JMeweySNYi6rR+tnrWrORd2SGRXaZAe6ptYeSU3uPXzcN2oL6pBYPvlp
	5PeTzT8kZSV0S9JD3TvFLopyTgDCqg8CVLEKvbiuXEMyBXWdvKp9cn5UXmghJqxuOqv/9H
	bF11iixGyyjcQP08Gai17dkYZvN4p1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724752845;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9162i3i+o72LGv4bQrnFxBt/xA3Dpeirq/7V6JbFMBk=;
	b=Cga5pB6qymLRKsIV6DE55Gvz+PvdKdMF5ANlUc6lMMOoO1ZY2RPbAEQQptbxUgCsmFckQl
	GtG2BpFcIPkxkpDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724752845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9162i3i+o72LGv4bQrnFxBt/xA3Dpeirq/7V6JbFMBk=;
	b=anJzIiLAWuu+v4JMeweySNYi6rR+tnrWrORd2SGRXaZAe6ptYeSU3uPXzcN2oL6pBYPvlp
	5PeTzT8kZSV0S9JD3TvFLopyTgDCqg8CVLEKvbiuXEMyBXWdvKp9cn5UXmghJqxuOqv/9H
	bF11iixGyyjcQP08Gai17dkYZvN4p1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724752845;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9162i3i+o72LGv4bQrnFxBt/xA3Dpeirq/7V6JbFMBk=;
	b=Cga5pB6qymLRKsIV6DE55Gvz+PvdKdMF5ANlUc6lMMOoO1ZY2RPbAEQQptbxUgCsmFckQl
	GtG2BpFcIPkxkpDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C10813A44;
	Tue, 27 Aug 2024 10:00:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AZN1Fs2jzWZrMAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 27 Aug 2024 10:00:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1C6BEA0965; Tue, 27 Aug 2024 12:00:45 +0200 (CEST)
Date: Tue, 27 Aug 2024 12:00:45 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] vfs: elide smp_mb in iversion handling in the common case
Message-ID: <20240827100045.m3mpko3tvmmjkmvm@quack3>
References: <20240815083310.3865-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815083310.3865-1-mjguzik@gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 15-08-24 10:33:10, Mateusz Guzik wrote:
> According to bpftrace on these routines most calls result in cmpxchg,
> which already provides the same guarantee.
> 
> In inode_maybe_inc_iversion elision is possible because even if the
> wrong value was read due to now missing smp_mb fence, the issue is going
> to correct itself after cmpxchg. If it appears cmpxchg wont be issued,
> the fence + reload are there bringing back previous behavior.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
> 
> chances are this entire barrier guarantee is of no significance, but i'm
> not signing up to review it

Jeff might have a ready answer here - added to CC. I think the barrier is
needed in principle so that you can guarantee that after a data change you
will be able to observe an i_version change.

> I verified the force flag is not *always* set (but it is set in the most
> common case).

Well, I'm not convinced the more complicated code is really worth it.
'force' will be set when we update timestamps which happens once per tick
(usually 1-4 ms). So that is common case on lightly / moderately loaded
system. On heavily write(2)-loaded system, 'force' should be mostly false
and unless you also heavily stat(2) the modified files, the common path is
exactly the "if (!force && !(cur & I_VERSION_QUERIED))" branch. So saving
one smp_mb() on moderately loaded system per couple of ms (per inode)
doesn't seem like a noticeable win...

									Honza
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 8aa34870449f..61ae4811270a 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1990,13 +1990,19 @@ bool inode_maybe_inc_iversion(struct inode *inode, bool force)
>  	 * information, but the legacy inode_inc_iversion code used a spinlock
>  	 * to serialize increments.
>  	 *
> -	 * Here, we add full memory barriers to ensure that any de-facto
> -	 * ordering with other info is preserved.
> +	 * We add a full memory barrier to ensure that any de facto ordering
> +	 * with other state is preserved (either implicitly coming from cmpxchg
> +	 * or explicitly from smp_mb if we don't know upfront if we will execute
> +	 * the former).
>  	 *
> -	 * This barrier pairs with the barrier in inode_query_iversion()
> +	 * These barriers pair with inode_query_iversion().
>  	 */
> -	smp_mb();
>  	cur = inode_peek_iversion_raw(inode);
> +	if (!force && !(cur & I_VERSION_QUERIED)) {
> +		smp_mb();
> +		cur = inode_peek_iversion_raw(inode);
> +	}
> +
>  	do {
>  		/* If flag is clear then we needn't do anything */
>  		if (!force && !(cur & I_VERSION_QUERIED))
> @@ -2025,20 +2031,22 @@ EXPORT_SYMBOL(inode_maybe_inc_iversion);
>  u64 inode_query_iversion(struct inode *inode)
>  {
>  	u64 cur, new;
> +	bool fenced = false;
>  
> +	/*
> +	 * Memory barriers (implicit in cmpxchg, explicit in smp_mb) pair with
> +	 * inode_maybe_inc_iversion(), see that routine for more details.
> +	 */
>  	cur = inode_peek_iversion_raw(inode);
>  	do {
>  		/* If flag is already set, then no need to swap */
>  		if (cur & I_VERSION_QUERIED) {
> -			/*
> -			 * This barrier (and the implicit barrier in the
> -			 * cmpxchg below) pairs with the barrier in
> -			 * inode_maybe_inc_iversion().
> -			 */
> -			smp_mb();
> +			if (!fenced)
> +				smp_mb();
>  			break;
>  		}
>  
> +		fenced = true;
>  		new = cur | I_VERSION_QUERIED;
>  	} while (!atomic64_try_cmpxchg(&inode->i_version, &cur, new));
>  	return cur >> I_VERSION_QUERIED_SHIFT;
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

