Return-Path: <linux-fsdevel+bounces-29961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2269A984257
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 11:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69C01F2141F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 09:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6E415688C;
	Tue, 24 Sep 2024 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rDQIRM53";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6F4n2u+t";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rDQIRM53";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6F4n2u+t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22146126C0B;
	Tue, 24 Sep 2024 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170711; cv=none; b=gQcUbqN8DmmNDkjCMpcARf1Jts103igs4U8s8yJcQ5e17wj6oTtFWVyYyNkYXEEFDYXL0sCIJgrmHQjdxb3DV6x7UC0CQM0vLgvKyrGlfwHCO5j8bujAXvJM/DgZbQS+4c/1IoFY5T80N9a7kXdpbIfsJJOa5zbo+O0TnXwkEPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170711; c=relaxed/simple;
	bh=v5C4c7u8cbIqgaUMAvlJIh3OE7NzmUFVACLRjGQEF+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLduB6oBzxMtvrf7X67BNsP115crk7UCxeqmEkknW1JSXqASMcNTpcGRnsRZ2w41wz1gx28A+fkpych/wz+FVxk0J/KWdYspSDaT2Nu/j4qEKQKWSEU0Acf56717w32iaxIO1f3ibKWhOD/k7Py4EyU1tOWzkI4qDkG3/VmfI2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rDQIRM53; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6F4n2u+t; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rDQIRM53; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6F4n2u+t; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0F46C1FBF9;
	Tue, 24 Sep 2024 09:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727170707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rFcrkv4lQpbEK6811dsJxQvAFHOaqZUvMV8MAD/YSso=;
	b=rDQIRM53RnwmMIxEbR2BrfmlzplC3U6m/szFkiWvJ7HwFnthCDkIfBcQtHaQi1OKYyBGWU
	ocG9BoTtXFaoiCy2mfnyEY3Dc7+Upjff7njMjNuAQmKEnH1Ll/X9cyiH89IX5Nt+dgKvY/
	2GKLQJaBAwqu6+jifLkVy2gQHNsQ1PQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727170707;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rFcrkv4lQpbEK6811dsJxQvAFHOaqZUvMV8MAD/YSso=;
	b=6F4n2u+tbGayhP8GqR5XLfl0uGpBrht0+3Ec9GU2/JwdHg9ci5IxuDzfBSR/xk0K5vsMKa
	Qk7Mjub6S9s0wsDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rDQIRM53;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6F4n2u+t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727170707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rFcrkv4lQpbEK6811dsJxQvAFHOaqZUvMV8MAD/YSso=;
	b=rDQIRM53RnwmMIxEbR2BrfmlzplC3U6m/szFkiWvJ7HwFnthCDkIfBcQtHaQi1OKYyBGWU
	ocG9BoTtXFaoiCy2mfnyEY3Dc7+Upjff7njMjNuAQmKEnH1Ll/X9cyiH89IX5Nt+dgKvY/
	2GKLQJaBAwqu6+jifLkVy2gQHNsQ1PQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727170707;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rFcrkv4lQpbEK6811dsJxQvAFHOaqZUvMV8MAD/YSso=;
	b=6F4n2u+tbGayhP8GqR5XLfl0uGpBrht0+3Ec9GU2/JwdHg9ci5IxuDzfBSR/xk0K5vsMKa
	Qk7Mjub6S9s0wsDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02D2B13AA8;
	Tue, 24 Sep 2024 09:38:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a0mtAJOI8mbTDQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Sep 2024 09:38:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A7729A088D; Tue, 24 Sep 2024 11:38:26 +0200 (CEST)
Date: Tue, 24 Sep 2024 11:38:26 +0200
From: Jan Kara <jack@suse.cz>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] acl: Annotate struct posix_acl with __counted_by()
Message-ID: <20240924093826.e2eh4ub7fw2zuo7r@quack3>
References: <20240923213809.235128-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923213809.235128-2-thorsten.blum@linux.dev>
X-Rspamd-Queue-Id: 0F46C1FBF9
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 23-09-24 23:38:05, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> a_entries to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Use struct_size() to calculate the number of bytes to allocate for new
> and cloned acls and remove the local size variables.
> 
> Change the posix_acl_alloc() function parameter count from int to
> unsigned int to match posix_acl's a_count data type. Add identifier
> names to the function definition to silence two checkpatch warnings.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/posix_acl.c            | 13 ++++++-------
>  include/linux/posix_acl.h |  4 ++--
>  2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index 6c66a37522d0..4050942ab52f 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -200,11 +200,11 @@ EXPORT_SYMBOL(posix_acl_init);
>   * Allocate a new ACL with the specified number of entries.
>   */
>  struct posix_acl *
> -posix_acl_alloc(int count, gfp_t flags)
> +posix_acl_alloc(unsigned int count, gfp_t flags)
>  {
> -	const size_t size = sizeof(struct posix_acl) +
> -	                    count * sizeof(struct posix_acl_entry);
> -	struct posix_acl *acl = kmalloc(size, flags);
> +	struct posix_acl *acl;
> +
> +	acl = kmalloc(struct_size(acl, a_entries, count), flags);
>  	if (acl)
>  		posix_acl_init(acl, count);
>  	return acl;
> @@ -220,9 +220,8 @@ posix_acl_clone(const struct posix_acl *acl, gfp_t flags)
>  	struct posix_acl *clone = NULL;
>  
>  	if (acl) {
> -		int size = sizeof(struct posix_acl) + acl->a_count *
> -		           sizeof(struct posix_acl_entry);
> -		clone = kmemdup(acl, size, flags);
> +		clone = kmemdup(acl, struct_size(acl, a_entries, acl->a_count),
> +				flags);
>  		if (clone)
>  			refcount_set(&clone->a_refcount, 1);
>  	}
> diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
> index 0e65b3d634d9..83b2c5fba1d9 100644
> --- a/include/linux/posix_acl.h
> +++ b/include/linux/posix_acl.h
> @@ -30,7 +30,7 @@ struct posix_acl {
>  	refcount_t		a_refcount;
>  	struct rcu_head		a_rcu;
>  	unsigned int		a_count;
> -	struct posix_acl_entry	a_entries[];
> +	struct posix_acl_entry	a_entries[] __counted_by(a_count);
>  };
>  
>  #define FOREACH_ACL_ENTRY(pa, acl, pe) \
> @@ -62,7 +62,7 @@ posix_acl_release(struct posix_acl *acl)
>  /* posix_acl.c */
>  
>  extern void posix_acl_init(struct posix_acl *, int);
> -extern struct posix_acl *posix_acl_alloc(int, gfp_t);
> +extern struct posix_acl *posix_acl_alloc(unsigned int count, gfp_t flags);
>  extern struct posix_acl *posix_acl_from_mode(umode_t, gfp_t);
>  extern int posix_acl_equiv_mode(const struct posix_acl *, umode_t *);
>  extern int __posix_acl_create(struct posix_acl **, gfp_t, umode_t *);
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

