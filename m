Return-Path: <linux-fsdevel+bounces-21059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D858FD207
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 17:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D671C22496
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 15:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183073D96A;
	Wed,  5 Jun 2024 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jRzta799";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="35OBxY+Z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jRzta799";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="35OBxY+Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70331450EE;
	Wed,  5 Jun 2024 15:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717602516; cv=none; b=rdAt9YA6Dz+c4BM+QArn63wdb0iBEIjWo89a43pWGRxIXYDk2LGtBdqzzyyqxm5HIcAhdYhBybYkyYfcu+w1Y56jGn05eaFOiMJrRRzpqOk4ZefjA3BK9pBZwYuI92aPCbNxCSaEOteCd4+AQr6rFG69pvWZItxJC4gOKYDf9sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717602516; c=relaxed/simple;
	bh=ffvgPtzkqvOcsRWKWpZyAYcy1Rvk582K895JW0pVYEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btzKVm33BBh3/I5WbehAeZuXsB0zo7b9NDi9KxvW14a9KuelGrhRlz3XQs9yJ7+VOPWri7ZzDNO3Nx+s0RMjP0oLN8NCgAfqx1xlOEgcJlR4yubgPb87UkQLLgyv6Y7SCCdFhSI2+RTzGcDJYmGtcQV1dqRck6rPoiCvoGVHLYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jRzta799; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=35OBxY+Z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jRzta799; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=35OBxY+Z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 644711F82B;
	Wed,  5 Jun 2024 15:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717602512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SbYatQcBbHQ+HP7N+an4tl4z77CnNHz62nCO4njPXR0=;
	b=jRzta799d+3U4Qf6SzlMcPEGkvNeNmBoh8OPCi3pqr6uq7lCoScRASjjZ6vJYL2MWZwr0H
	l18uy6Hmlu9ydMZMXNbzc/g2sYng04EO5/dupr9jPXrppyFBAkAIQyXePgRDuwaLFdO63w
	YaKMiZkLavi4bB17xj8D+XuAPrPZY/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717602512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SbYatQcBbHQ+HP7N+an4tl4z77CnNHz62nCO4njPXR0=;
	b=35OBxY+ZjY0/LlYTe820j0ESSOT9FDGgRmYdIkFlBqKfueiBXrP7K9UEbkXsSPIyQ+9Zji
	ydWQNpD74nb2BFCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717602512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SbYatQcBbHQ+HP7N+an4tl4z77CnNHz62nCO4njPXR0=;
	b=jRzta799d+3U4Qf6SzlMcPEGkvNeNmBoh8OPCi3pqr6uq7lCoScRASjjZ6vJYL2MWZwr0H
	l18uy6Hmlu9ydMZMXNbzc/g2sYng04EO5/dupr9jPXrppyFBAkAIQyXePgRDuwaLFdO63w
	YaKMiZkLavi4bB17xj8D+XuAPrPZY/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717602512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SbYatQcBbHQ+HP7N+an4tl4z77CnNHz62nCO4njPXR0=;
	b=35OBxY+ZjY0/LlYTe820j0ESSOT9FDGgRmYdIkFlBqKfueiBXrP7K9UEbkXsSPIyQ+9Zji
	ydWQNpD74nb2BFCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 538EF13A24;
	Wed,  5 Jun 2024 15:48:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a+4aFNCIYGYYTgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Jun 2024 15:48:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E9DF5A086C; Wed,  5 Jun 2024 17:48:31 +0200 (CEST)
Date: Wed, 5 Jun 2024 17:48:31 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] vfs: stop using user_path_at_empty in do_readlinkat
Message-ID: <20240605154831.6gdqv4uk7o6ufgha@quack3>
References: <20240604155257.109500-1-mjguzik@gmail.com>
 <20240604155257.109500-2-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604155257.109500-2-mjguzik@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]

On Tue 04-06-24 17:52:55, Mateusz Guzik wrote:
> It is the only consumer and it saddles getname_flags with an argument set
> to NULL by everyone else.
> 
> Instead the routine can do the empty check on its own.
> 
> Then user_path_at_empty can get retired and getname_flags can lose the
> argument.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/stat.c | 43 ++++++++++++++++++++++++-------------------
>  1 file changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/stat.c b/fs/stat.c
> index 70bd3e888cfa..7f7861544500 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -488,34 +488,39 @@ static int do_readlinkat(int dfd, const char __user *pathname,
>  			 char __user *buf, int bufsiz)
>  {
>  	struct path path;
> +	struct filename *name;
>  	int error;
> -	int empty = 0;
>  	unsigned int lookup_flags = LOOKUP_EMPTY;
>  
>  	if (bufsiz <= 0)
>  		return -EINVAL;
>  
>  retry:
> -	error = user_path_at_empty(dfd, pathname, lookup_flags, &path, &empty);
> -	if (!error) {
> -		struct inode *inode = d_backing_inode(path.dentry);
> +	name = getname_flags(pathname, lookup_flags, NULL);
> +	error = filename_lookup(dfd, name, lookup_flags, &path, NULL);
> +	if (unlikely(error)) {
> +		putname(name);
> +		return error;
> +	}
>  
> -		error = empty ? -ENOENT : -EINVAL;
> -		/*
> -		 * AFS mountpoints allow readlink(2) but are not symlinks
> -		 */
> -		if (d_is_symlink(path.dentry) || inode->i_op->readlink) {
> -			error = security_inode_readlink(path.dentry);
> -			if (!error) {
> -				touch_atime(&path);
> -				error = vfs_readlink(path.dentry, buf, bufsiz);
> -			}
> -		}
> -		path_put(&path);
> -		if (retry_estale(error, lookup_flags)) {
> -			lookup_flags |= LOOKUP_REVAL;
> -			goto retry;
> +	/*
> +	 * AFS mountpoints allow readlink(2) but are not symlinks
> +	 */
> +	if (d_is_symlink(path.dentry) ||
> +	    d_backing_inode(path.dentry)->i_op->readlink) {
> +		error = security_inode_readlink(path.dentry);
> +		if (!error) {
> +			touch_atime(&path);
> +			error = vfs_readlink(path.dentry, buf, bufsiz);
>  		}
> +	} else {
> +		error = (name->name[0] == '\0') ? -ENOENT : -EINVAL;
> +	}
> +	path_put(&path);
> +	putname(name);
> +	if (retry_estale(error, lookup_flags)) {
> +		lookup_flags |= LOOKUP_REVAL;
> +		goto retry;
>  	}
>  	return error;
>  }
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

