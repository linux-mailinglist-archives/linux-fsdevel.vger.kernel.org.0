Return-Path: <linux-fsdevel+bounces-53496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 043BFAEF8E3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 14:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79DB94E0707
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 12:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC25B273D91;
	Tue,  1 Jul 2025 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B/jRYJtV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ykog9zq+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B/jRYJtV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ykog9zq+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0639E2741AB
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751373595; cv=none; b=C7JMp0nanUcByM79dDbnRkLBJHBwk20FSuZyoMlc0iFLokLVRxti3TFxT/MlHhN3ay9jWIeASw+EMdLwKTdfzn+7KZYrKrZd/m/QGo2SlrYwLCpUE2+2/EzTZaOBHM/nBfGHVn089B5EvhAMnuUKawoEMjimPKXZWtqBNeG4mPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751373595; c=relaxed/simple;
	bh=4Rw9z24taiz8OuFxzSd2zDtbEuHpv6snnXvhuHKLGFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqlsnuZYm5NzG1nBbBV1aE1zTef7zWnGdZuLLUs1M9gvpswyPfqVQWCcv9TiI91SEJflM5x/510QFoZD8ZE0UCYOoFlo3JA/h19pjlGTAboQjZgnjfVJ0h5mMIJk9zU6Ww5ZuOMAuSs7S+1o4io9LSUY3Lk1J9V5V2gt7d6ZSSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B/jRYJtV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ykog9zq+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B/jRYJtV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ykog9zq+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3672C211FE;
	Tue,  1 Jul 2025 12:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751373591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0A2LB0xCjDUw81DCPIf/r205tCBiwgHOaWXbDEPN/jw=;
	b=B/jRYJtV7DzYWT6gSwVW/R7sqZ6WSF3gljAxfNzlbMlqNFzy471ROL8TfG38zLrTQ38aTQ
	T/7PM+lbx6VtuPfqw/2JrDxZPzQ2nW8Z674Ct1aAoNDuI9rG0E+i4XXdoBHkT4So1z8pIZ
	qG8OWYxJ7ZVf+TGGBkKqABSM6m9/Uuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751373591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0A2LB0xCjDUw81DCPIf/r205tCBiwgHOaWXbDEPN/jw=;
	b=ykog9zq+Ax195xghNYdYOOfwuN5oDHOh1JOc6ki9fHGseEfQ76uIUKIHjgPNT6KeiP61Gh
	N+8OnYpHTQnlnpBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751373591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0A2LB0xCjDUw81DCPIf/r205tCBiwgHOaWXbDEPN/jw=;
	b=B/jRYJtV7DzYWT6gSwVW/R7sqZ6WSF3gljAxfNzlbMlqNFzy471ROL8TfG38zLrTQ38aTQ
	T/7PM+lbx6VtuPfqw/2JrDxZPzQ2nW8Z674Ct1aAoNDuI9rG0E+i4XXdoBHkT4So1z8pIZ
	qG8OWYxJ7ZVf+TGGBkKqABSM6m9/Uuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751373591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0A2LB0xCjDUw81DCPIf/r205tCBiwgHOaWXbDEPN/jw=;
	b=ykog9zq+Ax195xghNYdYOOfwuN5oDHOh1JOc6ki9fHGseEfQ76uIUKIHjgPNT6KeiP61Gh
	N+8OnYpHTQnlnpBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1822F1364B;
	Tue,  1 Jul 2025 12:39:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y6/iBRfXY2hebAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 01 Jul 2025 12:39:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A3625A0A23; Tue,  1 Jul 2025 14:39:50 +0200 (CEST)
Date: Tue, 1 Jul 2025 14:39:50 +0200
From: Jan Kara <jack@suse.cz>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v6 2/6] lsm: introduce new hooks for setting/getting
 inode fsxattr
Message-ID: <6ab5frkvjgp2rvprv7mdphnsonixlcdlbbkrsviwenux24oxzg@h3rzd5moaecc>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-2-c4e3bc35227b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630-xattrat-syscall-v6-2-c4e3bc35227b@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,arndb.de,schaufler-ca.com,kernel.org,suse.cz,paul-moore.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Level: 

On Mon 30-06-25 18:20:12, Andrey Albershteyn wrote:
> Introduce new hooks for setting and getting filesystem extended
> attributes on inode (FS_IOC_FSGETXATTR).
> 
> Cc: selinux@vger.kernel.org
> Cc: Paul Moore <paul@paul-moore.com>
> 
> Acked-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

									Honza

> ---
>  fs/file_attr.c                | 19 ++++++++++++++++---
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      | 16 ++++++++++++++++
>  security/security.c           | 30 ++++++++++++++++++++++++++++++
>  4 files changed, 64 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> index 2910b7047721..be62d97cc444 100644
> --- a/fs/file_attr.c
> +++ b/fs/file_attr.c
> @@ -76,10 +76,15 @@ EXPORT_SYMBOL(fileattr_fill_flags);
>  int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
>  {
>  	struct inode *inode = d_inode(dentry);
> +	int error;
>  
>  	if (!inode->i_op->fileattr_get)
>  		return -ENOIOCTLCMD;
>  
> +	error = security_inode_file_getattr(dentry, fa);
> +	if (error)
> +		return error;
> +
>  	return inode->i_op->fileattr_get(dentry, fa);
>  }
>  EXPORT_SYMBOL(vfs_fileattr_get);
> @@ -242,12 +247,20 @@ int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
>  		} else {
>  			fa->flags |= old_ma.flags & ~FS_COMMON_FL;
>  		}
> +
>  		err = fileattr_set_prepare(inode, &old_ma, fa);
> -		if (!err)
> -			err = inode->i_op->fileattr_set(idmap, dentry, fa);
> +		if (err)
> +			goto out;
> +		err = security_inode_file_setattr(dentry, fa);
> +		if (err)
> +			goto out;
> +		err = inode->i_op->fileattr_set(idmap, dentry, fa);
> +		if (err)
> +			goto out;
>  	}
> +
> +out:
>  	inode_unlock(inode);
> -
>  	return err;
>  }
>  EXPORT_SYMBOL(vfs_fileattr_set);
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index bf3bbac4e02a..9600a4350e79 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -157,6 +157,8 @@ LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, const char *name)
>  LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
>  	 const char *name)
> +LSM_HOOK(int, 0, inode_file_setattr, struct dentry *dentry, struct fileattr *fa)
> +LSM_HOOK(int, 0, inode_file_getattr, struct dentry *dentry, struct fileattr *fa)
>  LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
>  LSM_HOOK(void, LSM_RET_VOID, inode_post_set_acl, struct dentry *dentry,
> diff --git a/include/linux/security.h b/include/linux/security.h
> index dba349629229..9ed0d0e0c81f 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -451,6 +451,10 @@ int security_inode_listxattr(struct dentry *dentry);
>  int security_inode_removexattr(struct mnt_idmap *idmap,
>  			       struct dentry *dentry, const char *name);
>  void security_inode_post_removexattr(struct dentry *dentry, const char *name);
> +int security_inode_file_setattr(struct dentry *dentry,
> +			      struct fileattr *fa);
> +int security_inode_file_getattr(struct dentry *dentry,
> +			      struct fileattr *fa);
>  int security_inode_need_killpriv(struct dentry *dentry);
>  int security_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry);
>  int security_inode_getsecurity(struct mnt_idmap *idmap,
> @@ -1052,6 +1056,18 @@ static inline void security_inode_post_removexattr(struct dentry *dentry,
>  						   const char *name)
>  { }
>  
> +static inline int security_inode_file_setattr(struct dentry *dentry,
> +					      struct fileattr *fa)
> +{
> +	return 0;
> +}
> +
> +static inline int security_inode_file_getattr(struct dentry *dentry,
> +					      struct fileattr *fa)
> +{
> +	return 0;
> +}
> +
>  static inline int security_inode_need_killpriv(struct dentry *dentry)
>  {
>  	return cap_inode_need_killpriv(dentry);
> diff --git a/security/security.c b/security/security.c
> index 596d41818577..711b4de40b8d 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2622,6 +2622,36 @@ void security_inode_post_removexattr(struct dentry *dentry, const char *name)
>  	call_void_hook(inode_post_removexattr, dentry, name);
>  }
>  
> +/**
> + * security_inode_file_setattr() - check if setting fsxattr is allowed
> + * @dentry: file to set filesystem extended attributes on
> + * @fa: extended attributes to set on the inode
> + *
> + * Called when file_setattr() syscall or FS_IOC_FSSETXATTR ioctl() is called on
> + * inode
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_inode_file_setattr(struct dentry *dentry, struct fileattr *fa)
> +{
> +	return call_int_hook(inode_file_setattr, dentry, fa);
> +}
> +
> +/**
> + * security_inode_file_getattr() - check if retrieving fsxattr is allowed
> + * @dentry: file to retrieve filesystem extended attributes from
> + * @fa: extended attributes to get
> + *
> + * Called when file_getattr() syscall or FS_IOC_FSGETXATTR ioctl() is called on
> + * inode
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_inode_file_getattr(struct dentry *dentry, struct fileattr *fa)
> +{
> +	return call_int_hook(inode_file_getattr, dentry, fa);
> +}
> +
>  /**
>   * security_inode_need_killpriv() - Check if security_inode_killpriv() required
>   * @dentry: associated dentry
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

