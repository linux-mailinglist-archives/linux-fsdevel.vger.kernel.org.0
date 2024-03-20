Return-Path: <linux-fsdevel+bounces-14899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA2F88127A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 14:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9765285AAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 13:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445D54207F;
	Wed, 20 Mar 2024 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eU92nmlr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2AB4120C;
	Wed, 20 Mar 2024 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710942174; cv=none; b=tcxmIDcXfT9lxEHd+fM0+nnPF/GYwKcFEZtsmwkuV57oXo0AY5kH8Ym7NDIsBwplADx2O5c3m+9wmQANeAkaJ1V89ifSzmrcMDiUo5TDNnThs8r7+0mi5KB6SMhXWyD8blWOSyRbp+VMKW4TNQJlays/QWIjzD6e5m6sF1hrHEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710942174; c=relaxed/simple;
	bh=SL7EEqxB06odAsm7W+93qYmrjXMwy6G5bg6bHVOjX4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HV4sUEGpstgXm77j0VrOYuXSqAtbZSVKNvqw9zhcO5UDbzrqh7/gCFmEYKUeYBOEptzDyo7PxF2zxdZrVeXvtHrmioeoYg8lN0CaxiNVyU4m5LKf83pSssnrPFvXPZBSMLf1NVyX7Xw1TbDCbQEfQ0aMDor+YmUlnLXZeMqyb0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eU92nmlr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068A1C433F1;
	Wed, 20 Mar 2024 13:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710942173;
	bh=SL7EEqxB06odAsm7W+93qYmrjXMwy6G5bg6bHVOjX4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eU92nmlr0GgktT6+bpsfmN+xC5VvXw5CpLfwFEwtc5AI+tOUb/Y+LyFVBQymaGUgi
	 WN36NQnrdDRFhd+zvg2dD0Qb/O4nVB7z5uUfzFipL+xdE3OskfqvKoynC0DSJBj+L2
	 L24/fz+d5jFyMZLE8D2/DqorwLJk7xpQ08sbWY9Y8ZaWe8h3vzfC9c6laNosm0/aqO
	 Esqxqf++mSLwyiOf/PgEk6IABgu37OL3s1Qj96/v/8dSImS8H9L6uozkCOpY2Txz7h
	 dvvaiYvSchaZv5AIf3Opfz24chH4J04CfvAcABhqejZ9pyKlfmtt1lsllgMDBILzKm
	 VBFifxxs//eyA==
Date: Wed, 20 Mar 2024 14:42:41 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Howells <dhowells@redhat.com>, 
	Tyler Hicks <code@tyhicks.com>, Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	netfs@lists.linux.dev, ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC 08/24] vfs: make vfs_mknod break delegations on
 parent directory
Message-ID: <20240320-jaguar-bildband-699e7ef5dc64@brauner>
References: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
 <20240315-dir-deleg-v1-8-a1d6209a3654@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240315-dir-deleg-v1-8-a1d6209a3654@kernel.org>

>  int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
> -              umode_t, dev_t);
> +              umode_t, dev_t, struct inode **);

So we will have at least the following helpers with an additional
delegated inode argument.

vfs_unlink()
vfs_link()
notify_change()
vfs_create()
vfs_mknod()
vfs_mkdir()
vfs_rmdir()

From looking at callers all these helpers will be called with non-NULL
delegated inode argument in vfs only. Unless it is generally conceivable
that other callers will want to pass a non-NULL inode argument over time
it might make more sense to add vfs_<operation>_delegated() or
__vfs_<operation>() and make vfs_mknod() and friends exported wrappers
around it.

I mean it's a matter of preference ultimately but this seems cleaner to
me. So at least for the new ones we should consider it. Would also make
the patch smaller.

>  int vfs_symlink(struct mnt_idmap *, struct inode *,
>  		struct dentry *, const char *);
>  int vfs_link(struct dentry *, struct mnt_idmap *, struct inode *,
> @@ -1879,7 +1879,7 @@ static inline int vfs_whiteout(struct mnt_idmap *idmap,
>  			       struct inode *dir, struct dentry *dentry)
>  {
>  	return vfs_mknod(idmap, dir, dentry, S_IFCHR | WHITEOUT_MODE,
> -			 WHITEOUT_DEV);
> +			 WHITEOUT_DEV, NULL);
>  }
>  
>  struct file *kernel_tmpfile_open(struct mnt_idmap *idmap,
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 0748e7ea5210..34fbcc90c984 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1227,7 +1227,7 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
>  	idmap = mnt_idmap(parent.mnt);
>  	err = security_path_mknod(&parent, dentry, mode, 0);
>  	if (!err)
> -		err = vfs_mknod(idmap, d_inode(parent.dentry), dentry, mode, 0);
> +		err = vfs_mknod(idmap, d_inode(parent.dentry), dentry, mode, 0, NULL);
>  	if (err)
>  		goto out_path;
>  	err = mutex_lock_interruptible(&u->bindlock);
> 
> -- 
> 2.44.0
> 

