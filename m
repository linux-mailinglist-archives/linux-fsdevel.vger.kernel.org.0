Return-Path: <linux-fsdevel+bounces-34660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC0D9C7487
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 15:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53E81F28C86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 14:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EE7202F6B;
	Wed, 13 Nov 2024 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KUCIX847";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lwFFRyOU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KUCIX847";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lwFFRyOU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD00C1FF7A4;
	Wed, 13 Nov 2024 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508613; cv=none; b=Am1ii7w8BEjpOZ9kGvhe+XFojvTHoSpH1uQFlXOZ+5eO7hFysLThDi49RBf6t7QccN4ToJuqHuNklE1mannaI9aWBYD6b5/Nl83yR/rFSCBRZyuhlLkEaObcgSmWmfxuQJU5fAl8SrZjTuVi1zrGfQKbi920qT2G6Gx/Fi/RNKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508613; c=relaxed/simple;
	bh=Ws6Qc4ADw/3aDOrzbSyVVczBRIe+7o/PF5lH4I7hlNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Owzfw8nDr1kBsVeagMiY31nCLuPDv66LF3h5qbIr4jsTdL8jThXc5DHnof8RrX0/TGU3DZrSxZHIwdkBuX2xKA8DqNGpC6KWHEc7E0Rf/izlNLjpwly0vCRl23OdItu8lCjbuIL1b+i7TeZsoqGvry7jZh3s49LbInMixltq2Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KUCIX847; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lwFFRyOU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KUCIX847; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lwFFRyOU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D8EC61F7B8;
	Wed, 13 Nov 2024 14:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731508609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MHRfzyO7OCkN7ImdtoMw8oxijZxAWv3a9uKIm7J/ERI=;
	b=KUCIX847MVA8UNvP7sVf+dfsehKOz8cK7o+xgM/USQSpICBlOBEP4UIqDoDmFY/R9tkynq
	mrBKve7VIrPLlNCjSxeaEgeRfOr1ID/gqAGaJEz+1+lbGhcPaHUVGtzdkkxT+Jon3jrtAy
	7y84OK9nYyS7yznmyMH6fU7Pht3vbGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731508609;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MHRfzyO7OCkN7ImdtoMw8oxijZxAWv3a9uKIm7J/ERI=;
	b=lwFFRyOUTLBtLHTqGQ4hVwZMAnd8J0/bwzZf9rkUVAOiKM6x+Ldlp5dCja4JcBSStR7oQx
	Ae2t/kAEswrYB5BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731508609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MHRfzyO7OCkN7ImdtoMw8oxijZxAWv3a9uKIm7J/ERI=;
	b=KUCIX847MVA8UNvP7sVf+dfsehKOz8cK7o+xgM/USQSpICBlOBEP4UIqDoDmFY/R9tkynq
	mrBKve7VIrPLlNCjSxeaEgeRfOr1ID/gqAGaJEz+1+lbGhcPaHUVGtzdkkxT+Jon3jrtAy
	7y84OK9nYyS7yznmyMH6fU7Pht3vbGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731508609;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MHRfzyO7OCkN7ImdtoMw8oxijZxAWv3a9uKIm7J/ERI=;
	b=lwFFRyOUTLBtLHTqGQ4hVwZMAnd8J0/bwzZf9rkUVAOiKM6x+Ldlp5dCja4JcBSStR7oQx
	Ae2t/kAEswrYB5BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C430813A6E;
	Wed, 13 Nov 2024 14:36:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WFmWL4G5NGepeAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 13 Nov 2024 14:36:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6F03BA08D0; Wed, 13 Nov 2024 15:36:45 +0100 (CET)
Date: Wed, 13 Nov 2024 15:36:45 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] fs: reduce pointer chasing in is_mgtime() test
Message-ID: <20241113143645.45652s6afeg3kdmt@quack3>
References: <20241113-mgtime-v1-1-84e256980e11@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113-mgtime-v1-1-84e256980e11@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed 13-11-24 09:17:51, Jeff Layton wrote:
> The is_mgtime test checks whether the FS_MGTIME flag is set in the
> fstype. To get there from the inode though, we have to dereference 3
> pointers.
> 
> Add a new IOP_MGTIME flag, and have inode_init_always() set that flag
> when the fstype flag is set. Then, make is_mgtime test for IOP_MGTIME
> instead.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

I guess this makes sense. I'd say inode->i_sb is likely in cache anyway by
the time we get to updating inode timestamps but the sb->s_type->fs_flags
dereferences are likely cache cold. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> I had always had a little concern around the amount of pointer chasing
> in this helper. Given the discussion around Josef's fsnotify patches, I
> figured I'd draft up a patch to cut that down.
> 
> Sending this as an RFC since we're getting close to the end of the merge
> window and I haven't done any performance testing with this.  I think
> it's a reasonable thing to consider doing though, given how hot the
> write() codepaths can be.
> ---
>  fs/inode.c         | 2 ++
>  include/linux/fs.h | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 838be0b49a63bd8d5700db0e6103c47e251793c3..70a2f8c717e063752a0b87c6eb27cde7a18d6879 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -243,6 +243,8 @@ int inode_init_always_gfp(struct super_block *sb, struct inode *inode, gfp_t gfp
>  	inode->i_opflags = 0;
>  	if (sb->s_xattr)
>  		inode->i_opflags |= IOP_XATTR;
> +	if (sb->s_type->fs_flags & FS_MGTIME)
> +		inode->i_opflags |= IOP_MGTIME;
>  	i_uid_write(inode, 0);
>  	i_gid_write(inode, 0);
>  	atomic_set(&inode->i_writecount, 0);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index aa37083436096df9969d2f63f6ec4d1dc8b260d2..d32c6f6298b17c44ff22d922516028da31cec14d 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -623,6 +623,7 @@ is_uncached_acl(struct posix_acl *acl)
>  #define IOP_NOFOLLOW	0x0004
>  #define IOP_XATTR	0x0008
>  #define IOP_DEFAULT_READLINK	0x0010
> +#define IOP_MGTIME	0x0020
>  
>  /*
>   * Keep mostly read-only and often accessed (especially for
> @@ -2581,7 +2582,7 @@ struct file_system_type {
>   */
>  static inline bool is_mgtime(const struct inode *inode)
>  {
> -	return inode->i_sb->s_type->fs_flags & FS_MGTIME;
> +	return inode->i_opflags & IOP_MGTIME;
>  }
>  
>  extern struct dentry *mount_bdev(struct file_system_type *fs_type,
> 
> ---
> base-commit: 80ce1b3dc72ceab16a967e2aa222c5cc06ad6042
> change-id: 20241113-mgtime-9aad7b90c64a
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

