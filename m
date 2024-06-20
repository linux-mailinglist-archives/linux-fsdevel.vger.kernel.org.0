Return-Path: <linux-fsdevel+bounces-21954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABBD910466
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 14:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41F401C22628
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 12:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC2F1AD3FE;
	Thu, 20 Jun 2024 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dq2FtOWh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ap81WPdL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mzRFjrzN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gupUr3Y8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F031ACE9B;
	Thu, 20 Jun 2024 12:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718887599; cv=none; b=greOTr3FA0jClI1Td8GEC+ZecWT6ZS0P6uTK5j2jOvqV7al7v4/PiCOUfgkEtuMnOLEgk26lhECgTFKh77K8R73IUacGqumO5MZ1TC7S+ioUrVxJU2Mib1qXC2aXvefqaUiQ6WVvwp8ucgpFVNRYkVAxEUCrR84/WVkEfV7TSQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718887599; c=relaxed/simple;
	bh=OlLK18B2Mc1sRo3g0zwW6egnIfIuRG4uQiDdvGcHyRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ln6KZSKQO7z22anwKUfHEHmdYWuzYXGDpv48bN4WGLOP0fTvijQQZM6I/qwmDZJjgsOn0N9i2fzSlSsujOmtsAtBTrpWY80LQNwpHLbmF8GWm2MQW8K/BJgFc6U9s4LyCmRaXsB8Y74qej7bHBYRWbwipqx2hoVa3dFKT9RkwZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dq2FtOWh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ap81WPdL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mzRFjrzN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gupUr3Y8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CB32521ACA;
	Thu, 20 Jun 2024 12:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718887595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JGgpyf1k89PJp/KcChAtnGCA2mEFLa143dyYihiIwnk=;
	b=dq2FtOWhZ4hivy6GNRL8nnTvmytELOg6+hu0nMJvV2pIdHocCFOn6U/wApgozDqyiazlz1
	kiWsrUK1CqNQgBi5j7txl+jC9ASEg89DNSN2SMPBq/j+0nw0Riz2Qlxy90cjhQ5vJAX249
	2n8yuqcYKmHM/vtZGhHkrdQ2sh9Fqe0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718887595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JGgpyf1k89PJp/KcChAtnGCA2mEFLa143dyYihiIwnk=;
	b=ap81WPdLL8vBwZNgjBKbw25LGRMOiulv/8hKHWv8YerowWT+vQPZwEjdFWXuLaXhS7n/bu
	uoYiC8vHopS59EBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mzRFjrzN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gupUr3Y8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718887593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JGgpyf1k89PJp/KcChAtnGCA2mEFLa143dyYihiIwnk=;
	b=mzRFjrzNvmvkinZcYQwceH0dQPfK+JennfaRA+zkadNYJ95iojoZutYBfXz9y2bHa0A8TJ
	/YGCKq4XpakDeMGhwdqhc9UQorYUUyUQ87Hiqv1D+IvQP69bLXWbqvyz2LxyUphz0MHbxJ
	7/pxZbwcWpsO+cz1CF0xdunytRXagek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718887593;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JGgpyf1k89PJp/KcChAtnGCA2mEFLa143dyYihiIwnk=;
	b=gupUr3Y8z8dsBjVweLeHWwJOWkPcNvz4wEdP9h33TDlrW+GvCbkl5B+jv+sFjnzyUNZKtL
	GSNHmYXWYppmdRBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B76181369F;
	Thu, 20 Jun 2024 12:46:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oR5wLKkkdGYKPAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 20 Jun 2024 12:46:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5DCAEA0881; Thu, 20 Jun 2024 14:46:33 +0200 (CEST)
Date: Thu, 20 Jun 2024 14:46:33 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: reorder checks in may_create_in_sticky
Message-ID: <20240620124633.nwknjgfvivbfmad4@quack3>
References: <20240620120359.151258-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620120359.151258-1-mjguzik@gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CB32521ACA
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Thu 20-06-24 14:03:59, Mateusz Guzik wrote:
> The routine is called for all directories on file creation and weirdly
> postpones the check if the dir is sticky to begin with. Instead it first
> checks fifos and regular files (in that order), while avoidably pulling
> globals.
> 
> No functional changes.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Yeah, putting the sticky bit check first makes sense also logically. Feel
free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namei.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 63d1fb06da6b..b1600060ecfb 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1246,9 +1246,9 @@ static int may_create_in_sticky(struct mnt_idmap *idmap,
>  	umode_t dir_mode = nd->dir_mode;
>  	vfsuid_t dir_vfsuid = nd->dir_vfsuid;
>  
> -	if ((!sysctl_protected_fifos && S_ISFIFO(inode->i_mode)) ||
> -	    (!sysctl_protected_regular && S_ISREG(inode->i_mode)) ||
> -	    likely(!(dir_mode & S_ISVTX)) ||
> +	if (likely(!(dir_mode & S_ISVTX)) ||
> +	    (S_ISREG(inode->i_mode) && !sysctl_protected_regular) ||
> +	    (S_ISFIFO(inode->i_mode) && !sysctl_protected_fifos) ||
>  	    vfsuid_eq(i_uid_into_vfsuid(idmap, inode), dir_vfsuid) ||
>  	    vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode), current_fsuid()))
>  		return 0;
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

