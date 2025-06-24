Return-Path: <linux-fsdevel+bounces-52734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 183CEAE60E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 11:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C361925C96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 09:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D79627A92A;
	Tue, 24 Jun 2025 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xt/a11Du";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fbfk9lah";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xt/a11Du";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fbfk9lah"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4366D25BEE7
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 09:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750757505; cv=none; b=nCifknheqQLY2+gIuXNqGHSBILiE0yQ6GDmmC6w368uhVpf07NUS2OJBVCjK1P2okfg8HljJ7e+321CDy491UqYCBUn94Pt39ezCEJsvMiHANb0tnZZf0uWN9YlYE12KkEnPES3KrGDHguAdz0XiZcEaUCQ9tOZvFkXWciQtLXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750757505; c=relaxed/simple;
	bh=uriC+rMaDwYnkkVrhM6zHLtVT33Y3k3d4w1iDI5oXb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtOnYaOK2Oh1A9iw7YpiSEoi4B4mnFZJ3wVtT4Heh2m8pkkfQBiDrj+aU8u80IjKAXSE4obsFHbvR01nQKDDELgezCTEAm5PEJjSIF+Io9IUeBhPO4baiSo3r5cmzKEzYMC7xr0oKAT/HJbEWsYFKqwFFX9d3eSPx0kbrZEBOBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xt/a11Du; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fbfk9lah; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xt/a11Du; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fbfk9lah; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 784711F391;
	Tue, 24 Jun 2025 09:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750757502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f/8d0GInx12ly85R9pzTCJWeiaLUtUkkI73UqLDMH4M=;
	b=Xt/a11DurzNAGxLcV18edzt4gsF66IvXGmsZpwkYKAURo5hknK8z0SKIxS8R7GNcf8iSmZ
	A5XoVsKX2NS15hwQIaq5sFxsj4K3uCrAiYQIS2nwWTaOsSpyf2Efof+lbw3Djm0GVZS2Gh
	KstXaBVQZYa5naaAHPq/QgKERTOYDzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750757502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f/8d0GInx12ly85R9pzTCJWeiaLUtUkkI73UqLDMH4M=;
	b=fbfk9lah6+gb1ejob8lD1d+4FV44hgI+W3XHecJA0Gam6+Oq3ZPbPS3qfDSqj5xfbiGeFX
	nxIq3YKeXentDsCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750757502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f/8d0GInx12ly85R9pzTCJWeiaLUtUkkI73UqLDMH4M=;
	b=Xt/a11DurzNAGxLcV18edzt4gsF66IvXGmsZpwkYKAURo5hknK8z0SKIxS8R7GNcf8iSmZ
	A5XoVsKX2NS15hwQIaq5sFxsj4K3uCrAiYQIS2nwWTaOsSpyf2Efof+lbw3Djm0GVZS2Gh
	KstXaBVQZYa5naaAHPq/QgKERTOYDzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750757502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f/8d0GInx12ly85R9pzTCJWeiaLUtUkkI73UqLDMH4M=;
	b=fbfk9lah6+gb1ejob8lD1d+4FV44hgI+W3XHecJA0Gam6+Oq3ZPbPS3qfDSqj5xfbiGeFX
	nxIq3YKeXentDsCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D35E13751;
	Tue, 24 Jun 2025 09:31:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vSSwGn5wWmgxHwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Jun 2025 09:31:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2CF4AA0A03; Tue, 24 Jun 2025 11:31:42 +0200 (CEST)
Date: Tue, 24 Jun 2025 11:31:42 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 03/11] fhandle: rename to get_path_anchor()
Message-ID: <quukedog6iyo5ilk6a7oofmzxm4akakoziijnqdgiwaomipsns@dpefnwgrrrde>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
 <20250624-work-pidfs-fhandle-v2-3-d02a04858fe3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-work-pidfs-fhandle-v2-3-d02a04858fe3@kernel.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,suse.cz,gmail.com,ffwll.ch,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue 24-06-25 10:29:06, Christian Brauner wrote:
> Rename as we're going to expand the function in the next step. The path
> just serves as the anchor tying the decoding to the filesystem.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fhandle.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 73f56f8e7d5d..d8d32208c621 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -168,7 +168,7 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
>  	return err;
>  }
>  
> -static int get_path_from_fd(int fd, struct path *root)
> +static int get_path_anchor(int fd, struct path *root)
>  {
>  	if (fd == AT_FDCWD) {
>  		struct fs_struct *fs = current->fs;
> @@ -338,7 +338,7 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
>  	    FILEID_USER_FLAGS(f_handle.handle_type) & ~FILEID_VALID_USER_FLAGS)
>  		return -EINVAL;
>  
> -	retval = get_path_from_fd(mountdirfd, &ctx.root);
> +	retval = get_path_anchor(mountdirfd, &ctx.root);
>  	if (retval)
>  		return retval;
>  
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

