Return-Path: <linux-fsdevel+bounces-45325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C19A763D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 12:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7370E165182
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 10:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7AD1DF26F;
	Mon, 31 Mar 2025 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KnajPwFO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cpjoI/yf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KnajPwFO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cpjoI/yf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAD41BD00C
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743415635; cv=none; b=mGOUbK67Z7TpWL6fkNYqCgTVONqgzXAmERcw+hYikyG+TZlyky+waZYjr0KFJdTWDWssf57TbZ4dVX2iyEn86tY5C62HW8l0KYzrQP04Yio2tBONzqJygeXfbZufKXrykIwzt3o0cu8OdKoGH8eVNHBMQRlNS4BjJbg5GnJNJzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743415635; c=relaxed/simple;
	bh=G32fO3JLad6IzN+TyCWyAuJlVsBgLclIpshmQmh4fXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpglhhODnfrzsXU9qjF3t5l6y7sfSd/UZrc/OrprxALGZ4GyPTEMs4VglF3z/sjsf7mA6m8lLVZUuDFpLejrsh3MsDs2rNK+EmT6QYgHeDBHbtmKGNf4To37g+HP5am0gyFAqmrvjtp8f8GKUAGciX4lcUm+dsJFrcPQlVSlqiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KnajPwFO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cpjoI/yf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KnajPwFO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cpjoI/yf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 836EA211E4;
	Mon, 31 Mar 2025 10:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743415632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zf7GU5WugshLecU3OJwnpajVE6FXpnp9GQVpmxdv1+I=;
	b=KnajPwFOrPrUVwouvJcFYNlWM2T5ywwbWUmdO1NE8LeQWg3vZ0ABa/Yl7amSDkBUEXpfRo
	1TXg5s9zf4o2qJmy6oSUYgAvJiIWMovqjHdIL4PVozY6rzBQK5KG/v5ykZRGfyYnq1QMVI
	6L8WD26IdO+QHaApyb8HCuQ3S8JseUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743415632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zf7GU5WugshLecU3OJwnpajVE6FXpnp9GQVpmxdv1+I=;
	b=cpjoI/yfpbVWWngLPYMaK/rL4xJMefqzkpNMfnQ80Zp0xV3vaBooVNsYn9FhE8v49LJmGd
	25Z629UQtMTLTjBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KnajPwFO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="cpjoI/yf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743415632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zf7GU5WugshLecU3OJwnpajVE6FXpnp9GQVpmxdv1+I=;
	b=KnajPwFOrPrUVwouvJcFYNlWM2T5ywwbWUmdO1NE8LeQWg3vZ0ABa/Yl7amSDkBUEXpfRo
	1TXg5s9zf4o2qJmy6oSUYgAvJiIWMovqjHdIL4PVozY6rzBQK5KG/v5ykZRGfyYnq1QMVI
	6L8WD26IdO+QHaApyb8HCuQ3S8JseUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743415632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zf7GU5WugshLecU3OJwnpajVE6FXpnp9GQVpmxdv1+I=;
	b=cpjoI/yfpbVWWngLPYMaK/rL4xJMefqzkpNMfnQ80Zp0xV3vaBooVNsYn9FhE8v49LJmGd
	25Z629UQtMTLTjBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 736C0139A1;
	Mon, 31 Mar 2025 10:07:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L0AoHFBp6mf0XQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 31 Mar 2025 10:07:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2EB3FA08D2; Mon, 31 Mar 2025 12:07:12 +0200 (CEST)
Date: Mon, 31 Mar 2025 12:07:12 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	linux-kernel@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, rafael@kernel.org, 
	djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH v2 5/6] super: use common iterator (Part 2)
Message-ID: <mmzfke3c6ioply3ezhushtoxnca5e3kx3ynteie6sf7cye3bqm@yu7wpqctwbrb>
References: <20250329-work-freeze-v2-0-a47af37ecc3d@kernel.org>
 <20250329-work-freeze-v2-5-a47af37ecc3d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250329-work-freeze-v2-5-a47af37ecc3d@kernel.org>
X-Rspamd-Queue-Id: 836EA211E4
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.cz,hansenpartnership.com,kernel.org,infradead.org,fromorbit.com,redhat.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Sat 29-03-25 09:42:18, Christian Brauner wrote:
> Use a common iterator for all callbacks. We could go for something even
> more elaborate (advance step-by-step similar to iov_iter) but I really
> don't think this is warranted.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good, one nit below. With that fixed feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> +#define invalid_super list_entry_is_head

Why do you have this invalid_super define? I find it rather confusing in
the loop below and list_entry_is_head() would be much more
understandable...

								Honza

> +
> +static void __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
> +			     enum super_iter_flags_t flags)
>  {
>  	struct super_block *sb, *p = NULL;
> +	bool excl = flags & SUPER_ITER_EXCL;
>  
> -	spin_lock(&sb_lock);
> -	list_for_each_entry(sb, &super_blocks, s_list) {
> -		bool locked;
> +	guard(spinlock)(&sb_lock);
>  
> +	for (sb = first_super(flags); !invalid_super(sb, &super_blocks, s_list);
> +	     sb = next_super(sb, flags)) {
>  		if (super_flags(sb, SB_DYING))
>  			continue;
>  		sb->s_count++;
>  		spin_unlock(&sb_lock);
>  
> -		locked = super_lock(sb, excl);
> -		if (locked) {
> +		if (flags & SUPER_ITER_UNLOCKED) {
> +			f(sb, arg);
> +		} else if (super_lock(sb, excl)) {
>  			f(sb, arg);
>  			super_unlock(sb, excl);
>  		}
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

