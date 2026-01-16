Return-Path: <linux-fsdevel+bounces-74081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 696D4D2F11C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 10:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F831301FF43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 09:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1A022173A;
	Fri, 16 Jan 2026 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3lXhKEP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7138B224AEF
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768557067; cv=none; b=mVvngq7ahCONwAU43EMhVIPmD03OdUbwevlGlDSgJtqOj3ucWtgkTvhmUbsnb07bcanawjUoH+YqGP4oUgA2JNk1hCFe9P/P48QYJnpn3Fz9gQON7EuLSuvNx2LSred8wdspn7LQYqrL3ovYKmqju/b17tDR9RD6Lj+zefaBEzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768557067; c=relaxed/simple;
	bh=psZd7HdWPPYH98/Od+c496P/RixyuzZpPGf6Ow27TUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IljDnb3YgxcGQVmRSUJnllqTzj2fyRo4geaa1l0HHHy3BtrZClgolOyJXt21GAJx7Ns1bnFvbiVSVMaz4Q/0c2DYyE6AggPI4yKgoBhONUHSYXxuoDx+EfA5xhFisNTsLFn7sqagHczdDoBomFByYMv7z4SNM30f9iF2JUrlxV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3lXhKEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C107C116C6;
	Fri, 16 Jan 2026 09:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768557067;
	bh=psZd7HdWPPYH98/Od+c496P/RixyuzZpPGf6Ow27TUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t3lXhKEPpqyyeo+W+a3xI3IqS/eNuDwTsl4GYOS8iHIWVyiz+4JRShSC/d8Y8mS93
	 pkV8bYOnBvFsV/dVeavP9WFF7pKyEn09aMQIhyZyhpltLDT/1pS6+qUaDWqGQLbj8p
	 GQpZeObC6ye02j2j2emg0EDzvXUGenb6P/3NcD6oMJ7xofJ+ZmBchM7xGJNsC27uLN
	 fKDMO1aojTIsJtoOb9N9JOLIC3v9oh9Aq2S8g9AsYQZDH3Js6bNS74yBPUIAvd+wjs
	 HXEmaxOoMkf1hQRh2p/MInDUZ0lFKUqhPLfbDiZNI0aA9+GP43oxlqPuet2/U9DN39
	 gBV/JI+5Plp5Q==
Date: Fri, 16 Jan 2026 10:51:03 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] posix_acl: make posix_acl_to_xattr() alloc the buffer
Message-ID: <20260116-bankintern-delikat-4d2f21af7eef@brauner>
References: <20260115122341.556026-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260115122341.556026-1-mszeredi@redhat.com>

Nice cleanup.

> diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
> index 1564eacc253d..34e853fdd0a9 100644
> --- a/fs/ceph/acl.c
> +++ b/fs/ceph/acl.c
> @@ -90,7 +90,8 @@ struct posix_acl *ceph_get_acl(struct inode *inode, int type, bool rcu)
>  int ceph_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>  		 struct posix_acl *acl, int type)
>  {
> -	int ret = 0, size = 0;
> +	int ret = 0;
> +	size_t size = 0;
>  	const char *name = NULL;
>  	char *value = NULL;
>  	struct iattr newattrs;
> @@ -126,16 +127,11 @@ int ceph_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>  	}
>  
>  	if (acl) {
> -		size = posix_acl_xattr_size(acl->a_count);
> -		value = kmalloc(size, GFP_NOFS);
> +		value = posix_acl_to_xattr(&init_user_ns, acl, &size, GFP_NOFS);
>  		if (!value) {
>  			ret = -ENOMEM;
>  			goto out;
>  		}
> -
> -		ret = posix_acl_to_xattr(&init_user_ns, acl, value, size);
> -		if (ret < 0)
> -			goto out_free;
>  	}
>  
>  	if (new_mode != old_mode) {
> @@ -172,7 +168,7 @@ int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
>  	struct posix_acl *acl, *default_acl;
>  	size_t val_size1 = 0, val_size2 = 0;
>  	struct ceph_pagelist *pagelist = NULL;
> -	void *tmp_buf = NULL;
> +	void *tmp_buf1 = NULL, *tmp_buf2 = NULL;
>  	int err;
>  
>  	err = posix_acl_create(dir, mode, &default_acl, &acl);
> @@ -192,15 +188,6 @@ int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
>  	if (!default_acl && !acl)
>  		return 0;
>  
> -	if (acl)
> -		val_size1 = posix_acl_xattr_size(acl->a_count);
> -	if (default_acl)
> -		val_size2 = posix_acl_xattr_size(default_acl->a_count);
> -
> -	err = -ENOMEM;
> -	tmp_buf = kmalloc(max(val_size1, val_size2), GFP_KERNEL);
> -	if (!tmp_buf)
> -		goto out_err;

The ENOMEM needs to be retained otherwise you return 0 on
ceph_pagelist_alloc_failure afaict.

I'll fix that up as well.

>  	pagelist = ceph_pagelist_alloc(GFP_KERNEL);
>  	if (!pagelist)
>  		goto out_err;

