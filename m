Return-Path: <linux-fsdevel+bounces-51012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23680AD1C62
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 13:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8AA83ACD7C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 11:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678FA2566F5;
	Mon,  9 Jun 2025 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SHBQQjq0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VoLZ4iyh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SHBQQjq0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VoLZ4iyh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C012550C2
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749468322; cv=none; b=gPdwvUV6nTaBOcUNqely4Ka9H1IOhOk/C9BC/1+drr49QiAXQStgECmeX1V35lI2HldrhbHIEn61+dnSNQQk4Kg8/OYLHe8iA8kOC3MHBzJNxfEZ8MGMTxCQTgTKE3pcLPXFM0fM9LYY+pBbUMvC3tUsnLxtA4epgJJfRIDv4cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749468322; c=relaxed/simple;
	bh=PAtdEJ9v9jfzk9L7TyadJUNVA2PMKdNcs1u9d3LhNWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l23oPYY+7+010oOadzzYlNq2b7CIyW+J1Pm/Ifox1PWjTTTvbAiGvo9ZFOQXLNAqyWgL815LHlV/zy+fpiGM9wJaECE7LIbtpfVQfJcO7YCwxROwDXO6oYT2NLuJ3kCuq1fpfcvFKY1egsRReeCPVsURbHIK+1g8FEt9YkN9ThU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SHBQQjq0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VoLZ4iyh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SHBQQjq0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VoLZ4iyh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 021A721182;
	Mon,  9 Jun 2025 11:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749468318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hsBQltkCVe5D2i0wiUV1DVAyAaiF31Q0/ZQK/fFHigE=;
	b=SHBQQjq0Xd/pKI4LTO6+4uuqxy4pMrq1JxxfGlhBzcvE4WlBFlkUpz+WXuv/fNE8MC4Zku
	+UrT1+04+4HLjSijs028c/igQ398jYXydf78Wl1KHKXZj8NPTr0O/MUhQd604jIBvO7SZG
	E4eh2S34IKKWGEZo8IiB0rCDTzKaBPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749468318;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hsBQltkCVe5D2i0wiUV1DVAyAaiF31Q0/ZQK/fFHigE=;
	b=VoLZ4iyh6N6pIX+VgRHdtXvf+a08nglTf6SQ4S11geiXHgyExZKl9DAr/gcMkvklvh8Fov
	twVHak2Trn6e1dCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SHBQQjq0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VoLZ4iyh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749468318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hsBQltkCVe5D2i0wiUV1DVAyAaiF31Q0/ZQK/fFHigE=;
	b=SHBQQjq0Xd/pKI4LTO6+4uuqxy4pMrq1JxxfGlhBzcvE4WlBFlkUpz+WXuv/fNE8MC4Zku
	+UrT1+04+4HLjSijs028c/igQ398jYXydf78Wl1KHKXZj8NPTr0O/MUhQd604jIBvO7SZG
	E4eh2S34IKKWGEZo8IiB0rCDTzKaBPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749468318;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hsBQltkCVe5D2i0wiUV1DVAyAaiF31Q0/ZQK/fFHigE=;
	b=VoLZ4iyh6N6pIX+VgRHdtXvf+a08nglTf6SQ4S11geiXHgyExZKl9DAr/gcMkvklvh8Fov
	twVHak2Trn6e1dCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E79A0137FE;
	Mon,  9 Jun 2025 11:25:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5pY5OJ3ERmg0OwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Jun 2025 11:25:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A046DA094C; Mon,  9 Jun 2025 13:25:17 +0200 (CEST)
Date: Mon, 9 Jun 2025 13:25:17 +0200
From: Jan Kara <jack@suse.cz>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	kees@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] binfmt_elf: use check_mul_overflow() for size calc
Message-ID: <j7qo6dmmx2hu34453zfdp6rjrtlsyckjilm6qufe2qyj4dc6ei@su6omrup5rli>
References: <20250607082844.8779-1-pranav.tyagi03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250607082844.8779-1-pranav.tyagi03@gmail.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 021A721182
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -2.51
X-Spam-Level: 

On Sat 07-06-25 13:58:44, Pranav Tyagi wrote:
> Use check_mul_overflow() to safely compute the total size of ELF program
> headers instead of relying on direct multiplication.
> 
> Directly multiplying sizeof(struct elf_phdr) with e_phnum risks integer
> overflow, especially on 32-bit systems or with malformed ELF binaries
> crafted to trigger wrap-around. If an overflow occurs, kmalloc() could
> allocate insufficient memory, potentially leading to out-of-bound
> accesses, memory corruption or security vulnerabilities.
> 
> Using check_mul_overflow() ensures the multiplication is performed
> safely and detects overflows before memory allocation. This change makes
> the function more robust when handling untrusted or corrupted binaries.
> 
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> Link: https://github.com/KSPP/linux/issues/92

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/binfmt_elf.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index a43363d593e5..774e705798b8 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -518,7 +518,10 @@ static struct elf_phdr *load_elf_phdrs(const struct elfhdr *elf_ex,
>  
>  	/* Sanity check the number of program headers... */
>  	/* ...and their total size. */
> -	size = sizeof(struct elf_phdr) * elf_ex->e_phnum;
> +	
> +	if (check_mul_overflow(sizeof(struct elf_phdr), elf_ex->e_phnum, &size))
> +		goto out;
> +
>  	if (size == 0 || size > 65536 || size > ELF_MIN_ALIGN)
>  		goto out;
>  
> -- 
> 2.49.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

