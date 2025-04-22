Return-Path: <linux-fsdevel+bounces-46945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E3EA96D13
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 15:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34DC8171E4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 13:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFA028150A;
	Tue, 22 Apr 2025 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YSmAOLHX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xw1kZpSo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YSmAOLHX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xw1kZpSo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59BA27CCD9
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745329126; cv=none; b=HykeI8j9Gga4VAnUHrvq8gNDJLCdXo5fG823mmJABbUR+EaZx9bPs8NWEZLMdwOVrqI+vZLbLQLAiJMA2dutso1vw7pZOoy9ET7pkc1IP1VUcdde+QNq9TURsvgw+9aq/BFIfnt1LpiJFRy9D9040u8nldyejnoDy+A1XD31/oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745329126; c=relaxed/simple;
	bh=dZpbEwZ2L5izo5f/sGMVoQGDs2QQAOEJmO5ii1SAKyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyAmWyON9ExgTO4Rw7/atnXVWv6Ba+LavNDBVpLymY3YYs5+j3Oe45pDU3YAldbLyQVsQbUZfpPnYWrpyAVWRPZvkhHJMjNCNnfIL0+tcYJm7Za3/lKu4ecycFPKykDoLNxRysiwEn93kFNF3/IF1GWPyd0to1UKPR5TAhxZq8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YSmAOLHX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xw1kZpSo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YSmAOLHX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xw1kZpSo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1B289211F8;
	Tue, 22 Apr 2025 13:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745329122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q9BNnUwsfZwvAsN3E65m0jL6rnSPub8k+ssmpsS/XN0=;
	b=YSmAOLHXrqk6/Raeh+g2fkZCuvOJ1FgyhMxTmCMHtYmg+9rBJ8+yWFPjiGrBdlIxRe0Afj
	29YUuxTIPlQEt1EmLuqN8+LwkUcnVg7yoRQouO27LGYRRdDirO9hWq6Vnlpy1nts0n0czB
	eoiEbd4ypXL+h/a+Aw9mcpKvbVnKft8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745329122;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q9BNnUwsfZwvAsN3E65m0jL6rnSPub8k+ssmpsS/XN0=;
	b=Xw1kZpSoBb9H4h0LcZjazUGKiW30guwm26u2OnipTNh2+ECdTwLC5vCWTX+U4ln5opBNb8
	kV5E9BucTGMJN/Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745329122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q9BNnUwsfZwvAsN3E65m0jL6rnSPub8k+ssmpsS/XN0=;
	b=YSmAOLHXrqk6/Raeh+g2fkZCuvOJ1FgyhMxTmCMHtYmg+9rBJ8+yWFPjiGrBdlIxRe0Afj
	29YUuxTIPlQEt1EmLuqN8+LwkUcnVg7yoRQouO27LGYRRdDirO9hWq6Vnlpy1nts0n0czB
	eoiEbd4ypXL+h/a+Aw9mcpKvbVnKft8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745329122;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q9BNnUwsfZwvAsN3E65m0jL6rnSPub8k+ssmpsS/XN0=;
	b=Xw1kZpSoBb9H4h0LcZjazUGKiW30guwm26u2OnipTNh2+ECdTwLC5vCWTX+U4ln5opBNb8
	kV5E9BucTGMJN/Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04EA2139D5;
	Tue, 22 Apr 2025 13:38:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kC8sAeKbB2hhOwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 22 Apr 2025 13:38:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 90E42A0734; Tue, 22 Apr 2025 15:38:41 +0200 (CEST)
Date: Tue, 22 Apr 2025 15:38:41 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2] fs: fall back to file_ref_put() for non-last reference
Message-ID: <r6r5osn7darsuaqv7cjkonaq63zioo6kup7ds3wyeyxjyohiso@hb3ftogkuw6m>
References: <20250418125756.59677-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418125756.59677-1-mjguzik@gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo,intel.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 18-04-25 14:57:56, Mateusz Guzik wrote:
> This reduces the slowdown in face of multiple callers issuing close on
> what turns out to not be the last reference.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202504171513.6d6f8a16-lkp@intel.com

Yeah, this looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> v2:
> - fix a copy pasto with bad conditional
> 
>  fs/file.c                |  2 +-
>  include/linux/file_ref.h | 19 ++++++-------------
>  2 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index dc3f7e120e3e..3a3146664cf3 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -26,7 +26,7 @@
>  
>  #include "internal.h"
>  
> -bool __file_ref_put_badval(file_ref_t *ref, unsigned long cnt)
> +static noinline bool __file_ref_put_badval(file_ref_t *ref, unsigned long cnt)
>  {
>  	/*
>  	 * If the reference count was already in the dead zone, then this
> diff --git a/include/linux/file_ref.h b/include/linux/file_ref.h
> index 7db62fbc0500..31551e4cb8f3 100644
> --- a/include/linux/file_ref.h
> +++ b/include/linux/file_ref.h
> @@ -61,7 +61,6 @@ static inline void file_ref_init(file_ref_t *ref, unsigned long cnt)
>  	atomic_long_set(&ref->refcnt, cnt - 1);
>  }
>  
> -bool __file_ref_put_badval(file_ref_t *ref, unsigned long cnt);
>  bool __file_ref_put(file_ref_t *ref, unsigned long cnt);
>  
>  /**
> @@ -178,20 +177,14 @@ static __always_inline __must_check bool file_ref_put(file_ref_t *ref)
>   */
>  static __always_inline __must_check bool file_ref_put_close(file_ref_t *ref)
>  {
> -	long old, new;
> +	long old;
>  
>  	old = atomic_long_read(&ref->refcnt);
> -	do {
> -		if (unlikely(old < 0))
> -			return __file_ref_put_badval(ref, old);
> -
> -		if (old == FILE_REF_ONEREF)
> -			new = FILE_REF_DEAD;
> -		else
> -			new = old - 1;
> -	} while (!atomic_long_try_cmpxchg(&ref->refcnt, &old, new));
> -
> -	return new == FILE_REF_DEAD;
> +	if (likely(old == FILE_REF_ONEREF)) {
> +		if (likely(atomic_long_try_cmpxchg(&ref->refcnt, &old, FILE_REF_DEAD)))
> +			return true;
> +	}
> +	return file_ref_put(ref);
>  }
>  
>  /**
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

