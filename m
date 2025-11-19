Return-Path: <linux-fsdevel+bounces-69037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7F5C6C47D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 02:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 269A535D440
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 01:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3732459DC;
	Wed, 19 Nov 2025 01:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="KufHchDi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oebLLX7K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F714A07;
	Wed, 19 Nov 2025 01:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763516520; cv=none; b=G2ri7yPY5etBN8ZpiE/ycftbcrRT3Pj3EQjTXV/s6Uy54phdC2uMU5mbsju1z3F/fX9GHCyP5RcCqPJtat3/ZrgG+c0OIcjQ6rIR5Uj3O1g8AhBxeKRFIBSuDAzsQx3tmHHBxol/nvMDNy7vM+hwu2ziTg6rUDDDST8WgrjkTno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763516520; c=relaxed/simple;
	bh=9zx6PRWxiuorYGN9hUJfJjzYBWtLPrz42DSIdSv0NGI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=JcDYTgpfMMNONLui9EiMI77snwPNRw2oEm3K0qoKzXuh/d6i+Yt2bysRlL6i1EyVyiur6tmVvqSGJqdJRFcRdy5dSAwgwVDNiu6XvDT0d2TpoqFjCptUl4naZK+alpvQiBT4e+jC8K3IB5/eAtFJhpejRFH80loOGWdXHc6rMFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=KufHchDi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oebLLX7K; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E38A67A0158;
	Tue, 18 Nov 2025 20:41:56 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 18 Nov 2025 20:41:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1763516516; x=1763602916; bh=ZpBsCDWU6THsmo9uFpTvF33wiOwigBPz6V+
	GM1yD//E=; b=KufHchDiERV58Ou2bwjeJjt7swGhBwQ20BN4poEpP5LehIFWHdO
	N091+Q2qkcmEsGZ2azhAly6dc8tU/GPZDpPB0jTjQkYq1wtqZNO5Idd+cA5KR6yP
	v9SrrpFkvbmm8Tq+XDaVycN1uRiOTvz4MGHrZmbVotQMJ8tuIUoVu0YK+eBe0uiD
	TPCScJNw73xws4qiOf7F5VViiWIhmfZQVjY6mEIUzxlD+gnlEI4BLN3HCjGzCMb7
	WEYSH4mz5j8ZTTqKngVTK4e9Zkgxgp/dGmlDLFWR5vmlOMhahu87OZMGSujmmyla
	whaRQFkFTqW8aIJj0S1+bJTkfTpYPN2/Yww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763516516; x=
	1763602916; bh=ZpBsCDWU6THsmo9uFpTvF33wiOwigBPz6V+GM1yD//E=; b=o
	ebLLX7KdlvwSh3M7JV7i3YGtQFN+8gKfaeX6UeNG3rznU0U3+h59gfyduZPExzRX
	9YZ1KKAsGNuCcyKAxRWU0fRsJ/hTQXKLQvFIvQd6DHhoqL5yoSTJaPQfHWBRyp8o
	MLEHUtz7VKV44V7y8AQw4XELhjgOPRLi/LLLD3niX5KvV1gyScU8VMBcwzKVW72K
	CALiKi7jxd8rpU65P4uZNqZ4F0cbzL25dkl4/KnUIhG1ovO/IJ2tEzI8BBTmwRIC
	OHj5H+QIwUC4eL/NKY6qm6K68fb9wsOIY5qF4tG4Eff0q/Dgmm87Fr3pq+YQuzsh
	qotJs/gLv/bXPaQi/ox4w==
X-ME-Sender: <xms:ZCAdaT311pSZgnFkaEpBXeQD6MjvWrrv3jyD2NVY2pqtWn7V-ev_lQ>
    <xme:ZCAdacdNTAGE6z3T6E-n0EIv7vjAogVb-5wi8tkhrLX4w9nvboTmPTVIi5gUb0Hjq
    3hHt6BYopRcPsnjv7s_Ii58xD2DTNKojkhxrWzBbyhl1476cQ>
X-ME-Received: <xmr:ZCAdaaCHmA3SlRm7-l6uOefALoyk9VH30ZtdG1RkVgWqX3qE875K5ScRQ7UWW2tTITouf8bEMLkGAYzHcpbXUBT_VfOEGWasyU2aKTFhYEqi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddvleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepjhgrtghkse
    hsuhhsvgdrtgiipdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtth
    hopegurghirdhnghhosehorhgrtghlvgdrtghomh
X-ME-Proxy: <xmx:ZCAdaT-jsrbF-qTC5b1MCNnNY2alLdmKIudULvyMeNPhyCoDuzr_7Q>
    <xmx:ZCAdaeog-fzc-V5K8-FtXS3az7KvZFMGKCG1y9M7Zct4DDLJBOOfqA>
    <xmx:ZCAdadGyBwHSGExcqG0OJ8vil02sBt3wSN-7rFy-wEdgQ-9A2XA95g>
    <xmx:ZCAdaS9ZftLH0JuFB4lvZCo8mlOzzJptVgfjUXIvj2a3ax_JCR3FpQ>
    <xmx:ZCAdaXDl9He-qGf93OfQsegDGcdAZqkyjJ6yQtxqfH0JrWuKjCyZpwUx>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 20:41:52 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Benjamin Coddington" <bcodding@hammerspace.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 "Trond Myklebust" <trondmy@kernel.org>, "Mike Snitzer" <snitzer@kernel.org>
Subject:
 Re: [PATCH v1 3/3] VFS/knfsd: Teach dentry_create() to use atomic_open()
In-reply-to: =?utf-8?q?=3C149570774f6cb48bf469514ca37cd636612f49b1=2E1763483?=
 =?utf-8?q?341=2Egit=2Ebcodding=40hammerspace=2Ecom=3E?=
References: <cover.1763483341.git.bcodding@hammerspace.com>, =?utf-8?q?=3C14?=
 =?utf-8?q?9570774f6cb48bf469514ca37cd636612f49b1=2E1763483341=2Egit=2Ebcodd?=
 =?utf-8?q?ing=40hammerspace=2Ecom=3E?=
Date: Wed, 19 Nov 2025 12:41:46 +1100
Message-id: <176351650615.634289.9329113019464329973@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 19 Nov 2025, Benjamin Coddington wrote:
> While knfsd offers combined exclusive create and open results to clients,
> on some filesystems those results may not be atomic.  This behavior can be
> observed.  For example, an open O_CREAT with mode 0 will succeed in creating
> the file but unexpectedly return -EACCES from vfs_open().
>=20
> Additionally reducing the number of remote RPC calls required for O_CREAT
> on network filesystem provides a performance benefit in the open path.
>=20
> Teach knfsd's helper create_dentry() to use atomic_open() for filesystems
> that support it.
>=20
> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> ---
>  fs/namei.c         | 43 ++++++++++++++++++++++++++++++++++++-------
>  fs/nfsd/nfs4proc.c |  8 +++++---
>  include/linux/fs.h |  2 +-
>  3 files changed, 42 insertions(+), 11 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index 9c0aad5bbff7..70ab74fb5e95 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4208,21 +4208,50 @@ EXPORT_SYMBOL(user_path_create);
>   * On success, returns a "struct file *". Otherwise a ERR_PTR
>   * is returned.
>   */
> -struct file *dentry_create(const struct path *path, int flags, umode_t mod=
e,
> +struct file *dentry_create(struct path *path, int flags, umode_t mode,

I don't like that you dropped "const" without telling us why.
It is because we not assign to path->dentry, which is because
atomic_open() returns a dentry....  which will only be different for
directories (I think).

But do we need to update path?  The returned file will point to the
correct dentry - isn't that all that matters?

I guess that I'd like an explanation for why the const is being dropped,
and why 'path' is being changed.

Thanks,
NeilBrown



>  			   const struct cred *cred)
>  {
> +	struct dentry *dentry =3D path->dentry;
> +	struct dentry *dir =3D dentry->d_parent;
> +	struct inode *dir_inode =3D d_inode(dir);
> +	struct mnt_idmap *idmap;
>  	struct file *file;
> -	int error;
> +	int error, create_error;
> =20
>  	file =3D alloc_empty_file(flags, cred);
>  	if (IS_ERR(file))
>  		return file;
> =20
> -	error =3D vfs_create(mnt_idmap(path->mnt),
> -			   d_inode(path->dentry->d_parent),
> -			   path->dentry, mode, true);
> -	if (!error)
> -		error =3D vfs_open(path, file);
> +	idmap =3D mnt_idmap(path->mnt);
> +
> +	if (dir_inode->i_op->atomic_open) {
> +		path->dentry =3D dir;
> +		mode =3D vfs_prepare_mode(idmap, dir_inode, mode, S_IALLUGO, S_IFREG);
> +
> +		create_error =3D may_o_create(idmap, path, dentry, mode);
> +		if (create_error)
> +			flags &=3D ~O_CREAT;
> +
> +		dentry =3D atomic_open(path, dentry, file, flags, mode);
> +		error =3D PTR_ERR_OR_ZERO(dentry);
> +
> +		if (unlikely(create_error) && error =3D=3D -ENOENT)
> +			error =3D create_error;
> +
> +		if (!error) {
> +			if (file->f_mode & FMODE_CREATED)
> +				fsnotify_create(dir->d_inode, dentry);
> +			if (file->f_mode & FMODE_OPENED)
> +				fsnotify_open(file);
> +		}
> +
> +		path->dentry =3D dentry;
> +
> +	} else {
> +		error =3D vfs_create(idmap, dir_inode, dentry, mode, true);
> +		if (!error)
> +			error =3D vfs_open(path, file);
> +	}
> =20
>  	if (unlikely(error)) {
>  		fput(file);
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 71b428efcbb5..7ff7e5855e58 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -194,7 +194,7 @@ static inline bool nfsd4_create_is_exclusive(int create=
mode)
>  }
> =20
>  static __be32
> -nfsd4_vfs_create(struct svc_fh *fhp, struct dentry *child,
> +nfsd4_vfs_create(struct svc_fh *fhp, struct dentry **child,
>  		 struct nfsd4_open *open)
>  {
>  	struct file *filp;
> @@ -214,9 +214,11 @@ nfsd4_vfs_create(struct svc_fh *fhp, struct dentry *ch=
ild,
>  	}
> =20
>  	path.mnt =3D fhp->fh_export->ex_path.mnt;
> -	path.dentry =3D child;
> +	path.dentry =3D *child;
>  	filp =3D dentry_create(&path, oflags, open->op_iattr.ia_mode,
>  			     current_cred());
> +	*child =3D path.dentry;
> +
>  	if (IS_ERR(filp))
>  		return nfserrno(PTR_ERR(filp));
> =20
> @@ -353,7 +355,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh=
 *fhp,
>  	status =3D fh_fill_pre_attrs(fhp);
>  	if (status !=3D nfs_ok)
>  		goto out;
> -	status =3D nfsd4_vfs_create(fhp, child, open);
> +	status =3D nfsd4_vfs_create(fhp, &child, open);
>  	if (status !=3D nfs_ok)
>  		goto out;
>  	open->op_created =3D true;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 601d036a6c78..772b734477e5 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2878,7 +2878,7 @@ struct file *dentry_open(const struct path *path, int=
 flags,
>  			 const struct cred *creds);
>  struct file *dentry_open_nonotify(const struct path *path, int flags,
>  				  const struct cred *cred);
> -struct file *dentry_create(const struct path *path, int flags, umode_t mod=
e,
> +struct file *dentry_create(struct path *path, int flags, umode_t mode,
>  			   const struct cred *cred);
>  struct path *backing_file_user_path(const struct file *f);
> =20
> --=20
> 2.50.1
>=20
>=20


