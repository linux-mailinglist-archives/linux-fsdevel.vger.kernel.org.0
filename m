Return-Path: <linux-fsdevel+bounces-31460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ABD997060
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 18:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EBC41C216DD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 16:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AE11F8EFA;
	Wed,  9 Oct 2024 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gqSerZbq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ODENQEQ/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h7cr0TMC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZDAifS4z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E2F1A00C9;
	Wed,  9 Oct 2024 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488347; cv=none; b=IoVQPWNfD+m41+BiOp5ylBxd0apXc6p3275rqnlHhg+ZpiuCHjbTdhl2uksqfGSVs1PseUHxsHf5aO3ou+xRIBxXf5x0HHlR4FXOD+Al0oEpH9PuIvn+ML8h10kzcAjFnbSTDD9C3I3N4HMh4nNYBsLpXg/fxtkRn4elTNz9rZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488347; c=relaxed/simple;
	bh=dXxiUZjJaOULNJ0EMfbX/wHdHa7hVffABqxUcGGd1sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUMxrvq3XaN2BnpS8wSVT/jtvq5jtO5XDi5BdRpqdHCDhlIBKYrLzSQNfNLYDQpECQdHNa8UnKLuGH4QLMEma4hTao90mDduMHk4ISEqhzQYpzwPRSbh+ouJQwTgVUSXMU/6Vc93S4cFxpUeZg+4N+nlqKE9X3JCeFXj+IVb04M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gqSerZbq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ODENQEQ/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h7cr0TMC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZDAifS4z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC3F721F69;
	Wed,  9 Oct 2024 15:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728488332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M/TA6Q3ii8645i5aJ6kKXUi/x/v2doufdkll3lxsZmE=;
	b=gqSerZbqHMtOfY0JKO7cxRHJRPmIeoFfH2KRWze1z0Zt8c8JA403yIZ3n706JkXePIHutF
	sOrUO5Vtw9cmoLSdEU7/dltlLl62WwuiUUZIUlacbg5+C6vix17OTgGrmuMjDh3UHQahk1
	b2V9044m3Kq/W5PaEKDeGsbmq2DSWl4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728488332;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M/TA6Q3ii8645i5aJ6kKXUi/x/v2doufdkll3lxsZmE=;
	b=ODENQEQ/fD/V+ip2QWM4V77F9/9JftVjrkD/R66sGT+OAqLU2t4vqbCOapLxAzMmEBcHS0
	ULiPUxpiJghQPsAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728488331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M/TA6Q3ii8645i5aJ6kKXUi/x/v2doufdkll3lxsZmE=;
	b=h7cr0TMCR56nZHNoZgufFP+Mm6ouEEvIMsi63d8x8BRzYM7Sif2FwK5sWMJ4l80cAdApzV
	yzysVW9zBplPfmcRnQDSJ2YzKAmmdIleZVhOk/EUDPsN2RhKVAPtHORlZbfYWTH/AczXoz
	4KyJYXJxRvbPSa6E0XwHd0oMvKg0+Eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728488331;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M/TA6Q3ii8645i5aJ6kKXUi/x/v2doufdkll3lxsZmE=;
	b=ZDAifS4zOZN7uLtMxUOICdox4ahGpYUb/Sea0wdyJzYyme0sRDTGPo7pXt9C/TfBsngVnJ
	gL9FSQ3Y7pMymCBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99A1413A58;
	Wed,  9 Oct 2024 15:38:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J7c4JYujBmeWWwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 09 Oct 2024 15:38:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4CA77A0896; Wed,  9 Oct 2024 17:38:36 +0200 (CEST)
Date: Wed, 9 Oct 2024 17:38:36 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alejandro Colomar <alx.manpages@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fanotify.7,fanotify_mark.2: update documentation of
 fanotify w.r.t fsid
Message-ID: <20241009153836.xkuzuei2gxeh2ghj@quack3>
References: <20241008094503.368923-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008094503.368923-1-amir73il@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Tue 08-10-24 11:45:03, Amir Goldstein wrote:
> Clarify the conditions for getting the -EXDEV and -ENODEV errors.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

But I've read somewhere that Alejandro stepped down as manpages maintainer
so they are officially unmaintained?

								Honza

> Hi Alejandro,
> 
> This is a followup on fanotify changes from v6.8
> that are forgot to follow up on at the time.
> 
> Thanks,
> Amir.
> 
>  man/man2/fanotify_mark.2 | 27 +++++++++++++++++++++------
>  man/man7/fanotify.7      | 10 ++++++++++
>  2 files changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/man/man2/fanotify_mark.2 b/man/man2/fanotify_mark.2
> index fc9b83459..b5e091c25 100644
> --- a/man/man2/fanotify_mark.2
> +++ b/man/man2/fanotify_mark.2
> @@ -659,17 +659,16 @@ The filesystem object indicated by
>  .I dirfd
>  and
>  .I pathname
> -is not associated with a filesystem that supports
> +is associated with a filesystem that reports zero
>  .I fsid
>  (e.g.,
>  .BR fuse (4)).
> -.BR tmpfs (5)
> -did not support
> -.I fsid
> -prior to Linux 5.13.
> -.\" commit 59cda49ecf6c9a32fae4942420701b6e087204f6
>  This error can be returned only with an fanotify group that identifies
>  filesystem objects by file handles.
> +Since Linux 6.8,
> +.\" commit 30ad1938326bf9303ca38090339d948975a626f5
> +this error can be returned only when
> +trying to add a mount or filesystem mark.
>  .TP
>  .B ENOENT
>  The filesystem object indicated by
> @@ -768,6 +767,22 @@ which uses a different
>  than its root superblock.
>  This error can be returned only with an fanotify group that identifies
>  filesystem objects by file handles.
> +Since Linux 6.8,
> +.\" commit 30ad1938326bf9303ca38090339d948975a626f5
> +this error will be returned
> +when trying to add a mount or filesystem mark on a subvolume,
> +when trying to add inode marks in different subvolumes,
> +or when trying to add inode marks in a
> +.BR btrfs (5)
> +subvolume and in another filesystem.
> +Since Linux 6.8,
> +.\" commit 30ad1938326bf9303ca38090339d948975a626f5
> +this error will also be returned
> +when trying to add marks in different filesystems,
> +where one of the filesystems reports zero
> +.I fsid
> +(e.g.,
> +.BR fuse (4)).
>  .SH STANDARDS
>  Linux.
>  .SH HISTORY
> diff --git a/man/man7/fanotify.7 b/man/man7/fanotify.7
> index 449af949c..db8fe6c00 100644
> --- a/man/man7/fanotify.7
> +++ b/man/man7/fanotify.7
> @@ -575,6 +575,16 @@ and contains the same value as
>  .I f_fsid
>  when calling
>  .BR statfs (2).
> +Note that some filesystems (e.g.,
> +.BR fuse (4))
> +report zero
> +.IR fsid .
> +In these cases, it is not possible to use
> +.I fsid
> +to associate the event with a specific filesystem instance,
> +so monitoring different filesystem instances that report zero
> +.I fsid
> +with the same fanotify group is not supported.
>  .TP
>  .I handle
>  This field contains a variable-length structure of type
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

