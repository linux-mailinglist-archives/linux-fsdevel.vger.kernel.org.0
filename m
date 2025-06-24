Return-Path: <linux-fsdevel+bounces-52735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA96AAE60E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 11:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F147C3ACBB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 09:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED4426ACB;
	Tue, 24 Jun 2025 09:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Eg4w8eUo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YrPj0hdd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Eg4w8eUo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YrPj0hdd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50661ADFFB
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 09:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750757522; cv=none; b=nIf92fp23xRSw3ewZNP+/a8vngskNJ/j1xKkQOvxPIlWUSe1fBd3kSPZHxnCweIkD0csAvw1SHUS5zv/tkKEUSe0nfJGQVG+vgWUdFgkLbNZVSw4SaR0lScgSoSB90+HENxmzUGyoU8YE7o9dWzfHQwHLMqMfU11sXdbUevMjsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750757522; c=relaxed/simple;
	bh=bsscPn8jEfGc+Kj1VhJSV/fo5lNsZ3Io3lnazog9IW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqZX9gA2paevTeL+vS7HDStagZgTBDtuWd488h52PyklO1ML02YcqLRJIFPqjWx81gsrPxapjMUd1Fv+r5sGqlS51cZ8qtNsmkmNckJxgouiTJ9IxG7rA384aY8VbhgNrKm9Gk0hBi6pxuk6jz+/y/abwcFAU2zIOhB82N1ITI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Eg4w8eUo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YrPj0hdd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Eg4w8eUo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YrPj0hdd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0279C21188;
	Tue, 24 Jun 2025 09:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750757519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LesgELZYHrLruY0MHKk4YGyuic81zzg0dfK3AqY2qK4=;
	b=Eg4w8eUoJdb4BVmfi+YokgDYvYFFD45WIoQXMVDN0u/YO7Xl6lEl4iBj86vE00FZfQnyoR
	PJhV4T4QA/j3G+QX6xg/d7kO+vBeO1cxzFjmVzM0jSyDthB4AksVsY3JRij8E/0zSVObSy
	jj7QaSyNbYONP2JiT5u9v4uxRhuklbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750757519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LesgELZYHrLruY0MHKk4YGyuic81zzg0dfK3AqY2qK4=;
	b=YrPj0hdduzvAfMdobjv8BJah2kjktwVfOiPvMzC057E5ng5bmDG1VZCDbCUqOz0UG0QLDc
	OZ6K1tIJv8sN4RDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Eg4w8eUo;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YrPj0hdd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750757519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LesgELZYHrLruY0MHKk4YGyuic81zzg0dfK3AqY2qK4=;
	b=Eg4w8eUoJdb4BVmfi+YokgDYvYFFD45WIoQXMVDN0u/YO7Xl6lEl4iBj86vE00FZfQnyoR
	PJhV4T4QA/j3G+QX6xg/d7kO+vBeO1cxzFjmVzM0jSyDthB4AksVsY3JRij8E/0zSVObSy
	jj7QaSyNbYONP2JiT5u9v4uxRhuklbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750757519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LesgELZYHrLruY0MHKk4YGyuic81zzg0dfK3AqY2qK4=;
	b=YrPj0hdduzvAfMdobjv8BJah2kjktwVfOiPvMzC057E5ng5bmDG1VZCDbCUqOz0UG0QLDc
	OZ6K1tIJv8sN4RDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB7D113751;
	Tue, 24 Jun 2025 09:31:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DnF8OY5wWmheHwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Jun 2025 09:31:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AAB7FA0A03; Tue, 24 Jun 2025 11:31:58 +0200 (CEST)
Date: Tue, 24 Jun 2025 11:31:58 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 04/11] pidfs: add pidfs_root_path() helper
Message-ID: <nprpdzdtvr7xnwh7karphfhyhc63ji6mglubrrznjjmdlrrdrw@bxq4c2xd5yyz>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
 <20250624-work-pidfs-fhandle-v2-4-d02a04858fe3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-work-pidfs-fhandle-v2-4-d02a04858fe3@kernel.org>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,suse.cz,gmail.com,ffwll.ch,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 0279C21188
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

On Tue 24-06-25 10:29:07, Christian Brauner wrote:
> Allow to return the root of the global pidfs filesystem.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/internal.h |  1 +
>  fs/pidfs.c    | 11 +++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/fs/internal.h b/fs/internal.h
> index 22ba066d1dba..ad256bccdc85 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -353,3 +353,4 @@ int anon_inode_getattr(struct mnt_idmap *idmap, const struct path *path,
>  		       unsigned int query_flags);
>  int anon_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  		       struct iattr *attr);
> +void pidfs_get_root(struct path *path);
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index ba526fdd4c4d..69b0541042b5 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -31,6 +31,14 @@
>  static struct kmem_cache *pidfs_attr_cachep __ro_after_init;
>  static struct kmem_cache *pidfs_xattr_cachep __ro_after_init;
>  
> +static struct path pidfs_root_path = {};
> +
> +void pidfs_get_root(struct path *path)
> +{
> +	*path = pidfs_root_path;
> +	path_get(path);
> +}
> +
>  /*
>   * Stashes information that userspace needs to access even after the
>   * process has been reaped.
> @@ -1066,4 +1074,7 @@ void __init pidfs_init(void)
>  	pidfs_mnt = kern_mount(&pidfs_type);
>  	if (IS_ERR(pidfs_mnt))
>  		panic("Failed to mount pidfs pseudo filesystem");
> +
> +	pidfs_root_path.mnt = pidfs_mnt;
> +	pidfs_root_path.dentry = pidfs_mnt->mnt_root;
>  }
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

