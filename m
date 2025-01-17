Return-Path: <linux-fsdevel+bounces-39491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2F4A15126
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 15:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F0C93A1F6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 14:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5443200BA2;
	Fri, 17 Jan 2025 14:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2FzkpTg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3E01FFC67;
	Fri, 17 Jan 2025 14:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737122728; cv=none; b=ZIGQBG/25Cwe/Y56UHfrk4Ve9VkPqtLq5eS8DHTD0nkSfhoVLZmLYPy8FX0tFGgCc6DuxfayTJCpWWGdruIlM5pkxt3O9Su++nqlXEofFUkzssH6s8EAI0PMEFT93/1uMOGtce0rVLc1vnxxyrsGGeIh9fiyInZjUX99lb9sI/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737122728; c=relaxed/simple;
	bh=l+qiHU6T4rVjfgUUrI1egwfzPnw2yJEOOvd1gn166NY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZbjcNmF27mrneC+YgxvO4XiEYjq18NjWtWRMqI8xzDkYvczdULbK/Cfx5Es0e1nfshvX6g1G8m+Y4+njTLtl6ZUs38JYrgHgu/xYPF3FRi93rwA4F6bCOyAF4wTONGDm19rUx5qvdKOfb+x9N2+xhC0tP+7qMRyPzgQmwzkEjxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2FzkpTg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6575BC4CEE1;
	Fri, 17 Jan 2025 14:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737122727;
	bh=l+qiHU6T4rVjfgUUrI1egwfzPnw2yJEOOvd1gn166NY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=S2FzkpTg5w8bOvlGmbZ4H0AwSDfHjzHFLyyX/bl7pJvLaOIXmQLuHDz1lig+G1Brl
	 Xh/18OAoL8zYtzw9v4EiQIlSsFdvUW9sdqGcJLkuEszyWTEnoxbTtOpzCZ/wR4M879
	 UZB872+cF3GnP5/nqApNVOKTCA3/N4HMVfuMddkUK3TBJs3mikjBZ2iXKl05mow+k9
	 SgElR9c2pB5fc5bjncLBYP3vXQdBG3rtxOpp3/rE98rD1wY1r2jXmHjApEYWbWj771
	 dWoDyj0vEgqf7z90v1VmyWfSLQOCUt1vxeCdK+usOxkdXeCLME3VN4HLqhGfWJs8KI
	 kejzwf21EvxZQ==
Message-ID: <f35e66eaada0e85a2586cfe6e990e924bc1933e9.camel@kernel.org>
Subject: Re: [PATCH v2 16/20] nfs{,4}_lookup_validate(): use stable parent
 inode passed by caller
From: Jeff Layton <jlayton@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: agruenba@redhat.com, amir73il@gmail.com, brauner@kernel.org, 
	ceph-devel@vger.kernel.org, dhowells@redhat.com, hubcap@omnibond.com,
 jack@suse.cz, 	krisman@kernel.org, linux-nfs@vger.kernel.org,
 miklos@szeredi.hu, 	torvalds@linux-foundation.org
Date: Fri, 17 Jan 2025 09:05:25 -0500
In-Reply-To: <20250116052317.485356-16-viro@zeniv.linux.org.uk>
References: <20250116052103.GF1977892@ZenIV>
	 <20250116052317.485356-1-viro@zeniv.linux.org.uk>
	 <20250116052317.485356-16-viro@zeniv.linux.org.uk>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-01-16 at 05:23 +0000, Al Viro wrote:
> we can't kill __nfs_lookup_revalidate() completely, but ->d_parent boiler=
plate
> in it is gone
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/nfs/dir.c | 43 +++++++++++++------------------------------
>  1 file changed, 13 insertions(+), 30 deletions(-)
>=20
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 9910d9796f4c..c28983ee75ca 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -1732,8 +1732,8 @@ static int nfs_lookup_revalidate_dentry(struct inod=
e *dir,
>   * cached dentry and do a new lookup.
>   */
>  static int
> -nfs_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
> -			 unsigned int flags)
> +nfs_do_lookup_revalidate(struct inode *dir, const struct qstr *name,
> +			 struct dentry *dentry, unsigned int flags)
>  {
>  	struct inode *inode;
>  	int error =3D 0;
> @@ -1785,39 +1785,26 @@ nfs_do_lookup_revalidate(struct inode *dir, struc=
t dentry *dentry,
>  }
> =20
>  static int
> -__nfs_lookup_revalidate(struct dentry *dentry, unsigned int flags,
> -			int (*reval)(struct inode *, struct dentry *, unsigned int))
> +__nfs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
>  {
> -	struct dentry *parent;
> -	struct inode *dir;
> -	int ret;
> -
>  	if (flags & LOOKUP_RCU) {
>  		if (dentry->d_fsdata =3D=3D NFS_FSDATA_BLOCKED)
>  			return -ECHILD;
> -		parent =3D READ_ONCE(dentry->d_parent);
> -		dir =3D d_inode_rcu(parent);
> -		if (!dir)
> -			return -ECHILD;
> -		ret =3D reval(dir, dentry, flags);
> -		if (parent !=3D READ_ONCE(dentry->d_parent))
> -			return -ECHILD;
>  	} else {
>  		/* Wait for unlink to complete - see unblock_revalidate() */
>  		wait_var_event(&dentry->d_fsdata,
>  			       smp_load_acquire(&dentry->d_fsdata)
>  			       !=3D NFS_FSDATA_BLOCKED);
> -		parent =3D dget_parent(dentry);
> -		ret =3D reval(d_inode(parent), dentry, flags);
> -		dput(parent);
>  	}
> -	return ret;
> +	return 0;
>  }
> =20
>  static int nfs_lookup_revalidate(struct inode *dir, const struct qstr *n=
ame,
>  				 struct dentry *dentry, unsigned int flags)
>  {
> -	return __nfs_lookup_revalidate(dentry, flags, nfs_do_lookup_revalidate)=
;
> +	if (__nfs_lookup_revalidate(dentry, flags))
> +		return -ECHILD;
> +	return nfs_do_lookup_revalidate(dir, name, dentry, flags);
>  }
> =20
>  static void block_revalidate(struct dentry *dentry)
> @@ -2216,11 +2203,14 @@ int nfs_atomic_open(struct inode *dir, struct den=
try *dentry,
>  EXPORT_SYMBOL_GPL(nfs_atomic_open);
> =20
>  static int
> -nfs4_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
> -			  unsigned int flags)
> +nfs4_lookup_revalidate(struct inode *dir, const struct qstr *name,
> +		       struct dentry *dentry, unsigned int flags)
>  {
>  	struct inode *inode;
> =20
> +	if (__nfs_lookup_revalidate(dentry, flags))
> +		return -ECHILD;
> +
>  	trace_nfs_lookup_revalidate_enter(dir, dentry, flags);
> =20
>  	if (!(flags & LOOKUP_OPEN) || (flags & LOOKUP_DIRECTORY))
> @@ -2259,14 +2249,7 @@ nfs4_do_lookup_revalidate(struct inode *dir, struc=
t dentry *dentry,
>  	return nfs_lookup_revalidate_dentry(dir, dentry, inode, flags);
> =20
>  full_reval:
> -	return nfs_do_lookup_revalidate(dir, dentry, flags);
> -}
> -
> -static int nfs4_lookup_revalidate(struct inode *dir, const struct qstr *=
name,
> -				  struct dentry *dentry, unsigned int flags)
> -{
> -	return __nfs_lookup_revalidate(dentry, flags,
> -			nfs4_do_lookup_revalidate);
> +	return nfs_do_lookup_revalidate(dir, name, dentry, flags);
>  }
> =20
>  #endif /* CONFIG_NFSV4 */

Much nicer without the "reval" callback.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

