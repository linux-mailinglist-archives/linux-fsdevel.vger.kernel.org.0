Return-Path: <linux-fsdevel+bounces-52537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C99CFAE3E6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 13:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 541C87A21AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 11:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A8224A06E;
	Mon, 23 Jun 2025 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zsq3Zl5Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vPdrVY8G";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zsq3Zl5Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vPdrVY8G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED06248F5A
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679189; cv=none; b=DisNlgbH6kiZi3kz9/jQXTtU8Rr11FJKazhfjVlOsUNthPZ4gh6Cv283U2JcCUTkSUqQ0Wm+XFb/WUDZl5AwMhjbIBJKN3mpQeeyZOaU8GVhXavfGXWvJemoU34QkWMxwkbI+GazZ59rjegyTfcQf7sNKumZumpr4qDqal2sWcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679189; c=relaxed/simple;
	bh=b9EMD2zr7NJcDch7wdPYSpByDj2wRh7nn9I6GszH5Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAeCmyP4lhSgDQABy6UtmDlupUjFVxsnX/wydBTm5f7/DG+2zAKNdqZYAQS3RYm33HnSqebIFoD3C+ISOM4IQfzTsdue/ydydcmlaYSf9jvXe/E552guLojOTPn3HfebOKiii8qGOrfWmzmnbo1WyqGE2yjQNGPM6poQC532Xpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zsq3Zl5Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vPdrVY8G; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zsq3Zl5Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vPdrVY8G; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E59F2116F;
	Mon, 23 Jun 2025 11:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750679186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d5vjSGnZCwRwLP59/5uVzuK7Sf1YoCOdHuZ22gInZ38=;
	b=zsq3Zl5QmmGYtk631hgXq7mNzZDgBj/xKTX+sESf8AapbujvD2QOsGu6HEmEORuWOBFcmj
	9fjK5/xasgVZSobrY7QX8sxGZ/dKftfn3H1lCnTTs9FikWKxMk3Qcqx1+gAmWhfFhCPimi
	Wi/BakD+dv+HgG8rouoCrVi2gWxXs/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750679186;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d5vjSGnZCwRwLP59/5uVzuK7Sf1YoCOdHuZ22gInZ38=;
	b=vPdrVY8Go6zIH/k0j5caC3vjyDeSndGtxaZQPYTWk7sRS4qAMoye2lP09vyMeTSDT7geUu
	dmr+3MOULUzSQfAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zsq3Zl5Q;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vPdrVY8G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750679186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d5vjSGnZCwRwLP59/5uVzuK7Sf1YoCOdHuZ22gInZ38=;
	b=zsq3Zl5QmmGYtk631hgXq7mNzZDgBj/xKTX+sESf8AapbujvD2QOsGu6HEmEORuWOBFcmj
	9fjK5/xasgVZSobrY7QX8sxGZ/dKftfn3H1lCnTTs9FikWKxMk3Qcqx1+gAmWhfFhCPimi
	Wi/BakD+dv+HgG8rouoCrVi2gWxXs/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750679186;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d5vjSGnZCwRwLP59/5uVzuK7Sf1YoCOdHuZ22gInZ38=;
	b=vPdrVY8Go6zIH/k0j5caC3vjyDeSndGtxaZQPYTWk7sRS4qAMoye2lP09vyMeTSDT7geUu
	dmr+3MOULUzSQfAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72BEF13A27;
	Mon, 23 Jun 2025 11:46:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SkwCHJI+WWhnNQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Jun 2025 11:46:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2C2DEA076C; Mon, 23 Jun 2025 13:46:22 +0200 (CEST)
Date: Mon, 23 Jun 2025 13:46:22 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 4/9] pidfs: add pidfs_root_path() helper
Message-ID: <hew5yudw4zgfjv2di53gqqhne7tx3tenah2o4qyacjztb2lj5x@j6r3bsaoom7f>
References: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
 <20250623-work-pidfs-fhandle-v1-4-75899d67555f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623-work-pidfs-fhandle-v1-4-75899d67555f@kernel.org>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7E59F2116F
X-Rspamd-Action: no action
X-Spam-Flag: NO
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,suse.cz,gmail.com,ffwll.ch,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -4.01
X-Spam-Level: 

On Mon 23-06-25 11:01:26, Christian Brauner wrote:
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
> index 1cf66fd9961e..1b7bd14366dc 100644
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
> @@ -1065,4 +1073,7 @@ void __init pidfs_init(void)
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

