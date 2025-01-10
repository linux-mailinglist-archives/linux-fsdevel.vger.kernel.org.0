Return-Path: <linux-fsdevel+bounces-38840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF36EA08BE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 10:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21E23ABDA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 09:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31B120C028;
	Fri, 10 Jan 2025 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZKqBhPN3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kfYDuGk5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZKqBhPN3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kfYDuGk5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4239E20C00D;
	Fri, 10 Jan 2025 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500928; cv=none; b=Q1Tx7gWqIjop3uyUVa6sDo9CKx5yTt4hGVoF89sfenoAfndddqSjW0N3HQUZoMaMhVovFwhJ0ZG5Sy8g6C7x/WffUmKBzgXK+wKo3hVMSphnaapRFh0r9i35APPsDszD1dyoBV7RofIkqpRAb5awRuOHVZuPoY2/aqxUs+1IQ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500928; c=relaxed/simple;
	bh=5dsvbYgIlw2A7i4sLHSvOSt+J+OcdXjSGQ//riCKsRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbVc3rnTXsapLXnP660NJUXB3ZLzn3ZSbH7nPJyJbnLYcgrM4xGQwZxIekTsiw4ly6S4y08AvfsPvdrzywbBqsWrDyhS1/QYfJ7Fu6yjUXoy33RBOugS1AXGkvM80uz3+YEIQ+IC5+EN4HR3MDaIMDetfv4DoGyliMpnzIY/Lu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZKqBhPN3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kfYDuGk5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZKqBhPN3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kfYDuGk5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 68C7E21137;
	Fri, 10 Jan 2025 09:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736500924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=usDpA/jprYU1ettqNPzphXnMW8FITnUyf2Ibhb6BoV0=;
	b=ZKqBhPN3/Iov0p/AxyszmrRldSc2gFzHbGSDJjWS1ravKapGpbKrK/OH5lGDRzw5RL/ZWj
	p1rNOJ+wJGvBZcr4wYEWyIBuzYIWFmvtO0rQQWvz6E2BH21jizgjoA9AhA7s+hY98sKrpT
	/CvvuMu2avgztOUwXpQ8c3jlAJeT/6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736500924;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=usDpA/jprYU1ettqNPzphXnMW8FITnUyf2Ibhb6BoV0=;
	b=kfYDuGk5WKrrjyuCCUo6rOUcgxtbOfHMhwCL/Fu4ilZZeFHW1n1nwuQawaGQFWhlcOtzdw
	b4hBkwqhvpJYqmAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736500924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=usDpA/jprYU1ettqNPzphXnMW8FITnUyf2Ibhb6BoV0=;
	b=ZKqBhPN3/Iov0p/AxyszmrRldSc2gFzHbGSDJjWS1ravKapGpbKrK/OH5lGDRzw5RL/ZWj
	p1rNOJ+wJGvBZcr4wYEWyIBuzYIWFmvtO0rQQWvz6E2BH21jizgjoA9AhA7s+hY98sKrpT
	/CvvuMu2avgztOUwXpQ8c3jlAJeT/6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736500924;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=usDpA/jprYU1ettqNPzphXnMW8FITnUyf2Ibhb6BoV0=;
	b=kfYDuGk5WKrrjyuCCUo6rOUcgxtbOfHMhwCL/Fu4ilZZeFHW1n1nwuQawaGQFWhlcOtzdw
	b4hBkwqhvpJYqmAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52D1113763;
	Fri, 10 Jan 2025 09:22:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Gi4zFLzmgGerDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Jan 2025 09:22:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0C012A0889; Fri, 10 Jan 2025 10:21:56 +0100 (CET)
Date: Fri, 10 Jan 2025 10:21:56 +0100
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, agruenba@redhat.com, amir73il@gmail.com, 
	brauner@kernel.org, ceph-devel@vger.kernel.org, dhowells@redhat.com, 
	hubcap@omnibond.com, jack@suse.cz, krisman@kernel.org, linux-nfs@vger.kernel.org, 
	miklos@szeredi.hu, torvalds@linux-foundation.org
Subject: Re: [PATCH 01/20] make sure that DNAME_INLINE_LEN is a multiple of
 word size
Message-ID: <sj4yg5jrrdqtxeee4kvfthtxq44guc63y73ajct7fodnjpcczh@cfgj6zpznkbc>
References: <20250110023854.GS1977892@ZenIV>
 <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,gmail.com,kernel.org,omnibond.com,suse.cz,szeredi.hu,linux-foundation.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 10-01-25 02:42:44, Al Viro wrote:
> ... calling the number of words DNAME_INLINE_WORDS.
> 
> The next step will be to have a structure to hold inline name arrays
> (both in dentry and in name_snapshot) and use that to alias the
> existing arrays of unsigned char there.  That will allow both
> full-structure copies and convenient word-by-word accesses.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/dcache.c            | 4 +---
>  include/linux/dcache.h | 8 +++++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index b4d5e9e1e43d..ea0f0bea511b 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -2748,9 +2748,7 @@ static void swap_names(struct dentry *dentry, struct dentry *target)
>  			/*
>  			 * Both are internal.
>  			 */
> -			unsigned int i;
> -			BUILD_BUG_ON(!IS_ALIGNED(DNAME_INLINE_LEN, sizeof(long)));
> -			for (i = 0; i < DNAME_INLINE_LEN / sizeof(long); i++) {
> +			for (int i = 0; i < DNAME_INLINE_WORDS; i++) {
>  				swap(((long *) &dentry->d_iname)[i],
>  				     ((long *) &target->d_iname)[i]);
>  			}
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index bff956f7b2b9..42dd89beaf4e 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -68,15 +68,17 @@ extern const struct qstr dotdot_name;
>   * large memory footprint increase).
>   */
>  #ifdef CONFIG_64BIT
> -# define DNAME_INLINE_LEN 40 /* 192 bytes */
> +# define DNAME_INLINE_WORDS 5 /* 192 bytes */
>  #else
>  # ifdef CONFIG_SMP
> -#  define DNAME_INLINE_LEN 36 /* 128 bytes */
> +#  define DNAME_INLINE_WORDS 9 /* 128 bytes */
>  # else
> -#  define DNAME_INLINE_LEN 44 /* 128 bytes */
> +#  define DNAME_INLINE_WORDS 11 /* 128 bytes */
>  # endif
>  #endif
>  
> +#define DNAME_INLINE_LEN (DNAME_INLINE_WORDS*sizeof(unsigned long))
> +
>  #define d_lock	d_lockref.lock
>  
>  struct dentry {
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

