Return-Path: <linux-fsdevel+bounces-60483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6B3B488AB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 11:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61ACE16C5F6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 09:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39862EC55F;
	Mon,  8 Sep 2025 09:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GDCDtN+6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="elh4ASjF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GDCDtN+6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="elh4ASjF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE45127F4F5
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324327; cv=none; b=N0+NEGxmm1QUJ+2DTNvxuLlN9q3cosKm440TwOaUpmvl44Rj3fM8O80OT/Emb6j8vszFrgV4hM98dRDRVHoAGNlGRL1m7Dlulp3/SlNFrnBgqbboM95Eqw8vu/RHssu3kan78IMj3hoG3zZFprFfOa2ZEgsrHOK/iipAr14v2ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324327; c=relaxed/simple;
	bh=fp2PjkrPBPjPAMtEi+i69tanXV7i/EBxMOp47LJIvJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koV8xE7v7UmXDo3fQQ1ZG8cOuhscII/TwQfWzEPFEHWZf/7/msYqyhaG5pCL71bLiyUwnGEPkyRHAzddKRvvqtrRtDYtexURQHnrAOPYSMwUbUTOvmtyCUhHPSLxxYHBiWQOtCA2zxn0q3I2UBFTXXdBh6/pa+uBHI0tcRolHmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GDCDtN+6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=elh4ASjF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GDCDtN+6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=elh4ASjF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CCFB9267EA;
	Mon,  8 Sep 2025 09:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757324322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1s2xCHashTwFlpYHkNEuJFO+jeXc+ieidyedsfsFZ1M=;
	b=GDCDtN+6Qloii+Vz5nUGhw+3MgBGztaHK/27gFlNcz97GPmyLxNPf/nrJE8c5kvEE1Ws+5
	L9i7uVim2VV8Yt/FYBeKlP9PCS3vJacwwCSwM6fAsq2Jz0ZxGU2d+QjLpsrRwkFymrmCOT
	QVRN+fNyX7+a0kqeIcJBREXh/Sj9Il0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757324322;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1s2xCHashTwFlpYHkNEuJFO+jeXc+ieidyedsfsFZ1M=;
	b=elh4ASjFNHQjrZb1AywIFZhJwGYdSOeyyMr2UjQirSy+GwYbB7QZhOeU0/Scq0d2we3Hz8
	AUKvWUfR9jD/RhCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757324322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1s2xCHashTwFlpYHkNEuJFO+jeXc+ieidyedsfsFZ1M=;
	b=GDCDtN+6Qloii+Vz5nUGhw+3MgBGztaHK/27gFlNcz97GPmyLxNPf/nrJE8c5kvEE1Ws+5
	L9i7uVim2VV8Yt/FYBeKlP9PCS3vJacwwCSwM6fAsq2Jz0ZxGU2d+QjLpsrRwkFymrmCOT
	QVRN+fNyX7+a0kqeIcJBREXh/Sj9Il0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757324322;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1s2xCHashTwFlpYHkNEuJFO+jeXc+ieidyedsfsFZ1M=;
	b=elh4ASjFNHQjrZb1AywIFZhJwGYdSOeyyMr2UjQirSy+GwYbB7QZhOeU0/Scq0d2we3Hz8
	AUKvWUfR9jD/RhCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C37AB13869;
	Mon,  8 Sep 2025 09:38:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XeC3LyKkvmhhbAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Sep 2025 09:38:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 82FEFA0A2D; Mon,  8 Sep 2025 11:38:42 +0200 (CEST)
Date: Mon, 8 Sep 2025 11:38:42 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 01/21] backing_file_user_path(): constify struct path *
Message-ID: <hbqwvajpcrolskdzxcoy7zu3xs5ao4cplk4qnpwljk5en2vqsi@tq6ii7abfyb2>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-1-viro@zeniv.linux.org.uk>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,suse.cz,linux-foundation.org,gmail.com,oracle.com,apparmor.net];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Sat 06-09-25 10:11:17, Al Viro wrote:
> Callers never use the resulting pointer to modify the struct path it
> points to (nor should they).
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> ---
>  fs/file_table.c    | 2 +-
>  include/linux/fs.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 81c72576e548..85b53e39138d 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -54,7 +54,7 @@ struct backing_file {
>  
>  #define backing_file(f) container_of(f, struct backing_file, file)
>  
> -struct path *backing_file_user_path(const struct file *f)
> +const struct path *backing_file_user_path(const struct file *f)
>  {
>  	return &backing_file(f)->user_path;
>  }
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index d7ab4f96d705..3bcc878817be 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2879,7 +2879,7 @@ struct file *dentry_open_nonotify(const struct path *path, int flags,
>  				  const struct cred *cred);
>  struct file *dentry_create(const struct path *path, int flags, umode_t mode,
>  			   const struct cred *cred);
> -struct path *backing_file_user_path(const struct file *f);
> +const struct path *backing_file_user_path(const struct file *f);
>  
>  /*
>   * When mmapping a file on a stackable filesystem (e.g., overlayfs), the file
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

