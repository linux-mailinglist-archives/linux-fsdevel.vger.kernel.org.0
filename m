Return-Path: <linux-fsdevel+bounces-59642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB17EB3B90E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 12:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525C43A1143
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 10:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1B630ACFC;
	Fri, 29 Aug 2025 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jqE7bPUU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="c0ABS8KD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jqE7bPUU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="c0ABS8KD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED333093C6
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464005; cv=none; b=YsEMoYj1moJanT6r86QIS2FwoKwUyvtg3NP0R2c3ALxWXXVSOzhxSEYjcFyCa6wc088+sCUovBpFR3YNnZXm55dAaG6zRQkR//9mKBerCp/TddcnGbS5p/5LwibS+BGNVBJX800FHbqN+d9a100psakmzktKj+CWfWbiGc/r4SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464005; c=relaxed/simple;
	bh=M7hsdmB/EI+Zj5IYFz0UaBCDGRYBqgtwedClHbFW7Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AE2q3wjHLpbeSKmuEg//XKZymrqu8MW+Rgtv0UfmnfDabLLdsDNIDIk305wwvm8M6PAjK5UOALO6IqZis32gecGm6kAYGliymfOCrNnaEYaYpQoauDorSWdWpmLOX9A6bFXwnoNJLprsDas86RG/N60bpxB1IXj/L9z+NRQ8Qa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jqE7bPUU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=c0ABS8KD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jqE7bPUU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=c0ABS8KD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC1DB33CEE;
	Fri, 29 Aug 2025 10:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756464000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J+Y66ukEooW5ffJXMRFc/3r29D2ClCT0DoqhBX0ZrhI=;
	b=jqE7bPUUONC6pasY9Oh5+BcoiNv6e6y+mchCYq24mnz/ARiFPy2ewKxrElMOdAlIZZyrfG
	goiNE+Ergek07XrUCk8Jio8eKADHLdtbCI7LXAC5sLMA8qI3bhS0OwGZGtZhgdE0QMM/13
	xSo4O2lQaf8isHw0eUFm1t+0aA4wWPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756464000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J+Y66ukEooW5ffJXMRFc/3r29D2ClCT0DoqhBX0ZrhI=;
	b=c0ABS8KDNKcITQ1cVOo0a6lcz7oJl8kjaMauXtI5SfpxsIFsn38rl+G46YFFvK2yVQ6BLd
	WB0UxX+x8yCtY9Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756464000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J+Y66ukEooW5ffJXMRFc/3r29D2ClCT0DoqhBX0ZrhI=;
	b=jqE7bPUUONC6pasY9Oh5+BcoiNv6e6y+mchCYq24mnz/ARiFPy2ewKxrElMOdAlIZZyrfG
	goiNE+Ergek07XrUCk8Jio8eKADHLdtbCI7LXAC5sLMA8qI3bhS0OwGZGtZhgdE0QMM/13
	xSo4O2lQaf8isHw0eUFm1t+0aA4wWPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756464000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J+Y66ukEooW5ffJXMRFc/3r29D2ClCT0DoqhBX0ZrhI=;
	b=c0ABS8KDNKcITQ1cVOo0a6lcz7oJl8kjaMauXtI5SfpxsIFsn38rl+G46YFFvK2yVQ6BLd
	WB0UxX+x8yCtY9Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 907C113A3E;
	Fri, 29 Aug 2025 10:40:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iXZAI4CDsWj1SQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 29 Aug 2025 10:40:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 25C58A099C; Fri, 29 Aug 2025 12:39:56 +0200 (CEST)
Date: Fri, 29 Aug 2025 12:39:56 +0200
From: Jan Kara <jack@suse.cz>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Replace offsetof() with struct_size()
Message-ID: <53c374bjebongkfj5kejf7hb3blgdfvp7e4j4pzahcpw6ubdxp@6vwxcf576ll6>
References: <20250829100328.618903-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829100328.618903-1-zhao.xichao@vivo.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,vivo.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Fri 29-08-25 18:03:28, Xichao Zhao wrote:
> When dealing with structures containing flexible arrays, struct_size()
> provides additional compile-time checks compared to offsetof(). This
> enhances code robustness and reduces the risk of potential errors.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namei.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 10f7caff7f0f..70a71b1b8abc 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -178,7 +178,7 @@ getname_flags(const char __user *filename, int flags)
>  	 * userland.
>  	 */
>  	if (unlikely(len == EMBEDDED_NAME_MAX)) {
> -		const size_t size = offsetof(struct filename, iname[1]);
> +		const size_t size = struct_size(result, iname, 1);
>  		kname = (char *)result;
>  
>  		/*
> @@ -253,7 +253,7 @@ struct filename *getname_kernel(const char * filename)
>  	if (len <= EMBEDDED_NAME_MAX) {
>  		result->name = (char *)result->iname;
>  	} else if (len <= PATH_MAX) {
> -		const size_t size = offsetof(struct filename, iname[1]);
> +		const size_t size = struct_size(result, iname, 1);
>  		struct filename *tmp;
>  
>  		tmp = kmalloc(size, GFP_KERNEL);
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

