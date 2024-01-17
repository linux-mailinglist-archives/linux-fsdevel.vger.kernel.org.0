Return-Path: <linux-fsdevel+bounces-8192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A93830C58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 19:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1B73B21D89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 18:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786E422EF4;
	Wed, 17 Jan 2024 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hcCxNxzr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3Otj8Y7v";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hcCxNxzr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3Otj8Y7v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DCE22EE3
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705514398; cv=none; b=uS7PePHNjyr1voKFE59jupCK2fMI4kUnYBsvknOroyoUig7DKFqrcCtAjcCEEunW/KlrIvVsEfrwUvSINK6sfYMnsqNQaoADU1NCsvyHdS5tDdX75pg0pkvTvSkBTynhxmh6cy+Tsp2FwEGpxZ6SfkRHdPYG+fW4SbDLeSlDg9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705514398; c=relaxed/simple;
	bh=M8p4goAroSIHfMl9lsOraZ/+h+Rcw3XQsne3RZHcBag=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Level:X-Spam-Score:
	 X-Spamd-Result:X-Spam-Flag; b=OnHcg3Sj0apxT7ALz3BoGZEF7XJYBUTD5ARY+wxYlikcQR8boEL6MSX2LHan7uXDoF9Ln5rFJe6+fhRG0aCdkZmHeslIqJYZNtfaQdGiFA9c9XcOoKI+/cJ/Rt96wkVe0PEPLWn2EL++e6SbJvqs8aJ1F702IWNlvDnQZPvFfxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hcCxNxzr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3Otj8Y7v; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hcCxNxzr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3Otj8Y7v; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 13B7A22280;
	Wed, 17 Jan 2024 17:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705514395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kNXu5WPz/trXv/fh8ZiIJjL0Fe3to6onh3H1k5jUYGM=;
	b=hcCxNxzr5dZ8aULUxs1PCx9oPtdz9lJ3rwGkjuTm8w1RpOJXvKaP9iPoyk6GioTvlewoly
	77UafQ0TZEhDmsDfn+NprnV/Vk9WwzuIOCeg5971SnTh4olEO74DVtoI/q9kPXgkspthQy
	CdfSCF5WjBv2aP3oRgJHBZJ2QwNnMgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705514395;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kNXu5WPz/trXv/fh8ZiIJjL0Fe3to6onh3H1k5jUYGM=;
	b=3Otj8Y7v0oQx/l4oXGVvBdOWucPdW/9dEtbdmp/WQm1noV+SibRcJAFV7bxPVjAWP3pC9r
	QlydTTpvd4Tjw2Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705514395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kNXu5WPz/trXv/fh8ZiIJjL0Fe3to6onh3H1k5jUYGM=;
	b=hcCxNxzr5dZ8aULUxs1PCx9oPtdz9lJ3rwGkjuTm8w1RpOJXvKaP9iPoyk6GioTvlewoly
	77UafQ0TZEhDmsDfn+NprnV/Vk9WwzuIOCeg5971SnTh4olEO74DVtoI/q9kPXgkspthQy
	CdfSCF5WjBv2aP3oRgJHBZJ2QwNnMgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705514395;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kNXu5WPz/trXv/fh8ZiIJjL0Fe3to6onh3H1k5jUYGM=;
	b=3Otj8Y7v0oQx/l4oXGVvBdOWucPdW/9dEtbdmp/WQm1noV+SibRcJAFV7bxPVjAWP3pC9r
	QlydTTpvd4Tjw2Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0935713751;
	Wed, 17 Jan 2024 17:59:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Lo05ApsVqGVJSQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jan 2024 17:59:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9DA62A0803; Wed, 17 Jan 2024 18:59:54 +0100 (CET)
Date: Wed, 17 Jan 2024 18:59:54 +0100
From: Jan Kara <jack@suse.cz>
To: cem@kernel.org
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] Enable support for tmpfs quotas
Message-ID: <20240117175954.jikporwmchenbkrk@quack3>
References: <20240109134651.869887-1-cem@kernel.org>
 <20240109134651.869887-4-cem@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109134651.869887-4-cem@kernel.org>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.97
X-Spamd-Result: default: False [-0.97 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.996];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.17)[70.00%]
X-Spam-Flag: NO

On Tue 09-01-24 14:46:05, cem@kernel.org wrote:
> From: Carlos Maiolino <cem@kernel.org>
> 
> To achieve so, add a new function handle_quota() to the quotaio subsystem,
> this will call do_quotactl() with or without a valid quotadev, according to the
> filesystem type.
> 
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>

Thanks for the patch. Some comments bewow.

> diff --git a/quotaio.c b/quotaio.c
> index 9bebb5e..3cc2bb7 100644
> --- a/quotaio.c
> +++ b/quotaio.c
> @@ -34,6 +34,22 @@ struct disk_dqheader {
>  	u_int32_t dqh_version;
>  } __attribute__ ((packed));
>  
> +int handle_quota(int cmd, struct quota_handle *h, int id, void *addr)

Call this quotactl_handle()?

> +{
> +	int err = -EINVAL;
> +
> +	if (!h)
> +		return err;
> +
> +	if (!strcmp(h->qh_fstype, MNTTYPE_TMPFS))
> +		err = do_quotactl(QCMD(cmd, h->qh_type), NULL, h->qh_dir,
> +					id, addr);
> +	else
> +		err = do_quotactl(QCMD(cmd, h->qh_type), h->qh_quotadev,
> +					h->qh_dir, id, addr);
> +
> +	return err;
> +}

...

> diff --git a/quotasys.c b/quotasys.c
> index 903816b..1f66302 100644
> --- a/quotasys.c
> +++ b/quotasys.c
> @@ -1384,7 +1390,11 @@ alloc:
>  			continue;
>  		}
>  
> -		if (!nfs_fstype(mnt->mnt_type)) {
> +		/*
> +		 * If devname and mnt->mnt_fsname matches, there is no real
> +		 * underlyin device, so skip these checks
> +		 */
> +		if (!nfs_fstype(mnt->mnt_type) && strcmp(devname, mnt->mnt_fsname)) {
>  			if (stat(devname, &st) < 0) {	/* Can't stat mounted device? */
>  				errstr(_("Cannot stat() mounted device %s: %s\n"), devname, strerror(errno));
>  				free((char *)devname);

I'm a bit uneasy about the added check because using device name the same
as filesystem name is just a common agreement but not enforced in any way.
So perhaps just add an explicit check for tmpfs? Later we can generalize
this if there are more filesystems like this...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

