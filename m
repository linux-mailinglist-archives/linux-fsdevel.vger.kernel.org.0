Return-Path: <linux-fsdevel+bounces-28256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD6F96895C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 16:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83D15B213F2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 14:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4537920FA87;
	Mon,  2 Sep 2024 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jryn+5TM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zipPivgr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jryn+5TM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zipPivgr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB315201243;
	Mon,  2 Sep 2024 14:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725285864; cv=none; b=maZZFD6/J5sNm/WHl9o1Yja7lZnAiOxAeXOGiRmGiOxs4fYPQOtMqa4z2KrRy352felyjOh2COFVIJRDaU2kBhBmKmH1AloBmrOkErZnxZmTQcjANZAfdTjHcPs1hBDpyKxep32fdmOjAL7/2nPqZa0wlXokDhDR7vf8fswHoJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725285864; c=relaxed/simple;
	bh=KioGwqRB7T2wHpbIqCfIEPdkjpofAzl7Jz6PMgI8FvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o34H8RO3sZ/we+ACehUxrTK00UvcIZ4E8gTdrFIGytzjBE2uJFYy04iY3a0WMavrhASno0xsXRQ4ByFNzImy+0NqVZdtsugsuYJ0pnRbAZTFJlwtfWmKBMqBnGnZflqUtnRB8Lk2SiAvxJanDy1KwC5mk37PYdlBw24RDgcU2ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jryn+5TM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zipPivgr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jryn+5TM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zipPivgr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E80C61FBB3;
	Mon,  2 Sep 2024 14:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725285860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BLFgrE0hX0rbUu3GrIY7xeLR/IOTytLYpN9TQvXlIOI=;
	b=Jryn+5TM/lMKBgozB9Ghu89bnWJ29e/FH0PyrOXOcC42pNss9jSC4LKFAkzsjcD2j3D7SU
	AunrdsBjDTmdFvKvNweJ1BTYPKixip5pBQs7N0/TXa6fj+WvxJRu5ZIAH5Idn3nrRMlmdP
	a93eIuDU40GsCdD1VnSE+beEuasSs/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725285860;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BLFgrE0hX0rbUu3GrIY7xeLR/IOTytLYpN9TQvXlIOI=;
	b=zipPivgrqlWfVtpWW8qT2tAlldZBFt7CHxsP2gbzjdnWtuLsBW7QrJ29Xr6Ua+Gd1oveLO
	4dSpkOtgLmj93fDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725285860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BLFgrE0hX0rbUu3GrIY7xeLR/IOTytLYpN9TQvXlIOI=;
	b=Jryn+5TM/lMKBgozB9Ghu89bnWJ29e/FH0PyrOXOcC42pNss9jSC4LKFAkzsjcD2j3D7SU
	AunrdsBjDTmdFvKvNweJ1BTYPKixip5pBQs7N0/TXa6fj+WvxJRu5ZIAH5Idn3nrRMlmdP
	a93eIuDU40GsCdD1VnSE+beEuasSs/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725285860;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BLFgrE0hX0rbUu3GrIY7xeLR/IOTytLYpN9TQvXlIOI=;
	b=zipPivgrqlWfVtpWW8qT2tAlldZBFt7CHxsP2gbzjdnWtuLsBW7QrJ29Xr6Ua+Gd1oveLO
	4dSpkOtgLmj93fDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D46A113AE0;
	Mon,  2 Sep 2024 14:04:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /ACZM+TF1WZOLgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Sep 2024 14:04:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 62235A0965; Mon,  2 Sep 2024 16:04:20 +0200 (CEST)
Date: Mon, 2 Sep 2024 16:04:20 +0200
From: Jan Kara <jack@suse.cz>
To: imandevel@gmail.com
Cc: jack@suse.cz, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] inotify: set ret in inotify_read() to -EAGAIN only when
 O_NONBLOCK is set
Message-ID: <20240902140420.dz4xxreo77fupphy@quack3>
References: <20240901030150.76054-1-ImanDevel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901030150.76054-1-ImanDevel@gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat 31-08-24 23:01:50, imandevel@gmail.com wrote:
> From: Iman Seyed <ImanDevel@gmail.com>
> 
> Avoid setting ret to -EAGAIN unnecessarily. Only set
> it when O_NONBLOCK is specified; otherwise, leave ret
> unchanged and proceed to set it to -ERESTARTSYS.
> 
> Signed-off-by: Iman Seyed <ImanDevel@gmail.com>

Sorry, but this change is a pointless churn. There's no difference to
generated code and wrt source code appearance it is a matter of taste where
there's no strong preference one way or other in the kernel...

								Honza

> ---
>  fs/notify/inotify/inotify_user.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index 4ffc30606e0b..d5d4b306a33d 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -279,9 +279,11 @@ static ssize_t inotify_read(struct file *file, char __user *buf,
>  			continue;
>  		}
>  
> -		ret = -EAGAIN;
> -		if (file->f_flags & O_NONBLOCK)
> +		if (file->f_flags & O_NONBLOCK) {
> +			ret = -EAGAIN;
>  			break;
> +		}
> +
>  		ret = -ERESTARTSYS;
>  		if (signal_pending(current))
>  			break;
> -- 
> 2.46.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

