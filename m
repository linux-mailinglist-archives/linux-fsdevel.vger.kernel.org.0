Return-Path: <linux-fsdevel+bounces-31891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 307CA99CC6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 16:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542001C220E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 14:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987A01AAE09;
	Mon, 14 Oct 2024 14:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AVEwdfJz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jyTmS8na";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AVEwdfJz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jyTmS8na"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B0AE571;
	Mon, 14 Oct 2024 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728915122; cv=none; b=OKsugl0gS3/8X2LQSdxtMP0EXmE6K26njzNVV3d1qohAkpyXuNyDHoZb7mcIvn650e+yGHN7+l0Z2HyvkxwUzzeRM0HVLCGBFzkE65YqzooCGIk1zhj+BrBpZL7aE8qRI7TAIKf9UpgRkMuy5uzM9s7x5RR/LI11EBAleRTWUPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728915122; c=relaxed/simple;
	bh=dSf4L2whuvkbcI3nEOvgGxh1I2nvQsWTfruIQ8S6ei4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhtdEXBsP1W04l8mKHvYsBBMTAoJr5+6QqkqJhX+EwRwt4EIAu3Jp95r93HyIvQcEwimPJOyPaWLtjTmj21PYlSch8VBMyf1rnroaJURD68GYTjZfACyD+UO9LL6VEuVYbmSeOlsmztdyGAvRshitxMJwR7lECqSWml3oRiwwUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AVEwdfJz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jyTmS8na; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AVEwdfJz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jyTmS8na; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2794B1F790;
	Mon, 14 Oct 2024 14:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728915118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aNiAvtzI6q96KeEs/j2nWQ1DffOJQcr3Q26A1F6d4Uw=;
	b=AVEwdfJzbIuX67WCCKxQLRuzM/BUyJaM0Ub+Sh3tjuMYGfMxpOuH1pPI3OmpsohPn/T6rr
	EIzovc5r1SVrNz73eBbmwVzJYD99DLZOJGtku+bAvOWxBufoucp0oaZlrNn5DFljwi11ej
	S8w3ErKKxTGR70qOFEZpFK5tCOtKM9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728915118;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aNiAvtzI6q96KeEs/j2nWQ1DffOJQcr3Q26A1F6d4Uw=;
	b=jyTmS8naPWKK/QwUgtdc1qGuXh3wJ3inRufjuGOwzRRdgNb2dAsl/AVHWKMPCsl+HR39/0
	ZPbdcEBvXWvTeNCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AVEwdfJz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jyTmS8na
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728915118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aNiAvtzI6q96KeEs/j2nWQ1DffOJQcr3Q26A1F6d4Uw=;
	b=AVEwdfJzbIuX67WCCKxQLRuzM/BUyJaM0Ub+Sh3tjuMYGfMxpOuH1pPI3OmpsohPn/T6rr
	EIzovc5r1SVrNz73eBbmwVzJYD99DLZOJGtku+bAvOWxBufoucp0oaZlrNn5DFljwi11ej
	S8w3ErKKxTGR70qOFEZpFK5tCOtKM9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728915118;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aNiAvtzI6q96KeEs/j2nWQ1DffOJQcr3Q26A1F6d4Uw=;
	b=jyTmS8naPWKK/QwUgtdc1qGuXh3wJ3inRufjuGOwzRRdgNb2dAsl/AVHWKMPCsl+HR39/0
	ZPbdcEBvXWvTeNCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 055C713A51;
	Mon, 14 Oct 2024 14:11:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q4lIAa4mDWdXYwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Oct 2024 14:11:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B419FA0896; Mon, 14 Oct 2024 16:11:53 +0200 (CEST)
Date: Mon, 14 Oct 2024 16:11:53 +0200
From: Jan Kara <jack@suse.cz>
To: Song Liu <song@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, kernel-team@fb.com
Subject: Re: [PATCH] fsnotify, lsm: Separate fsnotify_open_perm() and
 security_file_open()
Message-ID: <20241014141153.swwzlqa22ndkzbhn@quack3>
References: <20241011203722.3749850-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011203722.3749850-1-song@kernel.org>
X-Rspamd-Queue-Id: 2794B1F790
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Fri 11-10-24 13:37:22, Song Liu wrote:
> Currently, fsnotify_open_perm() is called from security_file_open(). This
> is not right for CONFIG_SECURITY=n and CONFIG_FSNOTIFY=y case, as
> security_file_open() in this combination will be a no-op and not call
> fsnotify_open_perm(). Fix this by calling fsnotify_open_perm() directly.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> 
> ---
> 
> PS: I didn't included a Fixes tag. This issue was probably introduced 15
> years ago in [1]. If we want to back port this to stable, we will need
> another version for older kernel because of [2].

Well, this is not a problem because CONFIG_FANOTIFY_ACCESS_PERMISSIONS has
"depends on SECURITY". So fsnotify_open_perm() can have anything to do only
if CONFIG_SECURITY is enabled. That being said I agree it makes sense to
decouple security & fsnotify because there's no significant benefit and
only confusion. So I like the patch but please update the changelog and
also finish the split as Amir suggests.

								Honza

> [1] c4ec54b40d33 ("fsnotify: new fsnotify hooks and events types for access decisions")
> [2] 36e28c42187c ("fsnotify: split fsnotify_perm() into two hooks")
> ---
>  fs/open.c           | 4 ++++
>  security/security.c | 9 +--------
>  2 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index acaeb3e25c88..6c4950f19cfb 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -946,6 +946,10 @@ static int do_dentry_open(struct file *f,
>  	if (error)
>  		goto cleanup_all;
>  
> +	error = fsnotify_open_perm(f);
> +	if (error)
> +		goto cleanup_all;
> +
>  	error = break_lease(file_inode(f), f->f_flags);
>  	if (error)
>  		goto cleanup_all;
> diff --git a/security/security.c b/security/security.c
> index 6875eb4a59fc..a72cc62c0a07 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -19,7 +19,6 @@
>  #include <linux/kernel.h>
>  #include <linux/kernel_read_file.h>
>  #include <linux/lsm_hooks.h>
> -#include <linux/fsnotify.h>
>  #include <linux/mman.h>
>  #include <linux/mount.h>
>  #include <linux/personality.h>
> @@ -3102,13 +3101,7 @@ int security_file_receive(struct file *file)
>   */
>  int security_file_open(struct file *file)
>  {
> -	int ret;
> -
> -	ret = call_int_hook(file_open, file);
> -	if (ret)
> -		return ret;
> -
> -	return fsnotify_open_perm(file);
> +	return call_int_hook(file_open, file);
>  }
>  
>  /**
> -- 
> 2.43.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

