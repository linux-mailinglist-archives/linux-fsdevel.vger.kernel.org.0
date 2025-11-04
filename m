Return-Path: <linux-fsdevel+bounces-66866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 658DEC2E83C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 01:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A07D0189AD14
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 00:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC83F42A8B;
	Tue,  4 Nov 2025 00:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="IehWa5/X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jBUPRqxZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A45DDD2;
	Tue,  4 Nov 2025 00:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762214827; cv=none; b=TM2h1eKRECsjJ6M/B2ahJmz+x77Wj+U92OJo6fYBBJGl2m37JU2PkcqUBrKjfJ4+t32KS19zX7QRhGV0BrYL7eKhqSBQqAdcI72/JFgV7IrwHOVb1X5OTCpEvg1HmgecFT6yG3gFrPbl/CmB23Qp4m8Q3ixmGyLU2xd7CGp3IUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762214827; c=relaxed/simple;
	bh=hqxkjWiznuwSwInnXBYOqC3AkwUyx+wftZ51BD4uuFo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=QlD4EpNM81tDKbJjfU1NwmHMy/IaqJIavsfjDAafdYehCZgyLHJM3g9oqP0vb/aYZWCR/AzVkbfdb5ASN0lyeA/3sM7ZrCo7vS1RJFBiInw/voVClgVPfr7qhBd2+5aCJdTKvVMh059D07XJ9C+LoRbk3YApzuHSn3K3GRSxv60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=IehWa5/X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jBUPRqxZ; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id C175B1300249;
	Mon,  3 Nov 2025 19:07:01 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 03 Nov 2025 19:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762214821; x=1762222021; bh=94oeGAK0r88apEjJfQglOhFfZqxC4NAb3cb
	WH+rsjBk=; b=IehWa5/XbOL02ENDC9UBzgsrZdMOoYGtHmDgM2P/imQQ9R9fU7d
	G7WHJ9Ygism9teLz+ePIPmIwvyslQcYIApS56nVdpi3C7kCmCBMuOCtKVll2xYsI
	JBBPnrOwFP4NicmjNC/WcBgkIgM4o0sfgl2cV9w9H5X5BuXIi9qGE31wTVrOFPiu
	6phkqeDERF+CdA9Nbvb+Ckmsy5SbdcblHXEIItXALT3Z9bsRHhib/BkxwDyX3aXt
	AV1fQuWLuZqQ/xpoERX+cnMw+MC0eYjuF95du39X0xEEYRsoZOiP4Kkzsi/nhBn3
	kSX0U/HGQyhLt8MvFi613HA2L3vevJeB+Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762214821; x=
	1762222021; bh=94oeGAK0r88apEjJfQglOhFfZqxC4NAb3cbWH+rsjBk=; b=j
	BUPRqxZ2msM7yC4ocH/BlrZ+H469sJ5R5J4mWUlPL6pK+KMef2Ltx1mtBpDcgHZW
	pDqlzOoUYhGd2vsQY8IlbcWXMqdNZNRPko+LP6Mk/bbIcqALLEy8MYmt2N8hFtuE
	x9X9yYB26c/rrh9qAFo7sWBiccL7g6RwFR6EnE9q+dvJad2KrV5nQPC5HLnL/eLA
	RGm54kuD+sOyup9aql7FImUForoaPsAPkrbCMAsRZtkYoAgtYKwZkEHIWB/1iJk1
	A3ZkG5w4PvuuETOjT2R69EdsONIZVnWfhEWQgMUCZqKqv13dmR2qhFP/TS1QEhnV
	WO5zo5edr9z9D1Z0QyhYg==
X-ME-Sender: <xms:o0MJaaiblHFhiJ4oik5JrXdy-8CL16Y411RnEO2wDHjvlu8hzOC0pQ>
    <xme:o0MJaaCXiI-D_PMW2jhIVQShtynvscxAhr1Kjs6yz6rciBsKErwlcv0_O9fVTQBLg
    UbuwMaMbn3loIWH-c_0qJAC_qup_itQZriG6H9pNZxGYIANJg>
X-ME-Received: <xmr:o0MJaaXmiIy78vA_-TLv3cOURz94IGPXczgzetAgP-7D_6U5oJob751tTaBT6q1QW16k6lNmQPnzHsUdb22HtthY1rc-1XuyAj_Ptht2BABr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeelheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgeefpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqgihfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqtghifhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepvggtrhihphhtfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:o0MJafqHELEaQZJsRDNjYPG6V_Pt2G8rxtPfLSqrmlTW3OzRQH8A_w>
    <xmx:o0MJaRWYTVcEFuaHTtTzRRdgJkGOa7CvXAnVizxb8Vof7jg9FVCaog>
    <xmx:o0MJaeautq61wYllmpZ7JRzO6vkYr5zgzScUnDFE2wNyL7LRIEvKVw>
    <xmx:o0MJaRmhnP2XJ4sk_h_9SNFozRkausOe_Jt-XkVpa8dJv8E1iDpuzg>
    <xmx:pUMJaT-QCiPKUKxOskHEi_nD69_l_HyfI51gs72DNovSp8OW89kPrk8m>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 19:06:49 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Miklos Szeredi" <miklos@szeredi.hu>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Alexander Aring" <alex.aring@gmail.com>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Steve French" <sfrench@samba.org>,
 "Paulo Alcantara" <pc@manguebit.org>,
 "Ronnie Sahlberg" <ronniesahlberg@gmail.com>,
 "Shyam Prasad N" <sprasad@microsoft.com>, "Tom Talpey" <tom@talpey.com>,
 "Bharath SM" <bharathsm@microsoft.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>,
 "David Howells" <dhowells@redhat.com>, "Tyler Hicks" <code@tyhicks.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Amir Goldstein" <amir73il@gmail.com>,
 "Namjae Jeon" <linkinjeon@kernel.org>,
 "Steve French" <smfrench@gmail.com>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "Carlos Maiolino" <cem@kernel.org>,
 "Kuniyuki Iwashima" <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, netfs@lists.linux.dev,
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 linux-xfs@vger.kernel.org, netdev@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH v4 09/17] vfs: add struct createdata for passing arguments
 to vfs_create()
In-reply-to: <20251103-dir-deleg-ro-v4-9-961b67adee89@kernel.org>
References: <20251103-dir-deleg-ro-v4-0-961b67adee89@kernel.org>,
 <20251103-dir-deleg-ro-v4-9-961b67adee89@kernel.org>
Date: Tue, 04 Nov 2025 11:06:45 +1100
Message-id: <176221480589.1793333.7801494824880510264@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 03 Nov 2025, Jeff Layton wrote:
> vfs_create() has grown an uncomfortably long argument list, and a
> following patch will add another. Convert it to take a new struct
> createdata pointer and fix up the callers to pass one in.
>=20

I know Christian asked for this and he is a Maintainer so.....

but I would like say that I don't think this is a win.  The argument
list isn't *that* long, and all the args are quite different so there is
little room for confusion.

I would be in favour of dropping the "dir" arg because it is always
   d_inode(dentry->d_parent)
which is stable.

I would rather pass the vfsmnt rather than the idmap, then we could pass
"struct path", for both that and dentry, but I know Christian disagrees.

So if anyone really thinks the arg list is too long, I think there are
better solutions.  But I don't even think the length is a problem.

NeilBrown


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ecryptfs/inode.c      | 11 ++++++++---
>  fs/namei.c               | 33 ++++++++++++++++++++-------------
>  fs/nfsd/nfs3proc.c       |  9 ++++++++-
>  fs/nfsd/vfs.c            | 19 ++++++++++++-------
>  fs/open.c                |  9 ++++++---
>  fs/overlayfs/overlayfs.h |  7 ++++++-
>  fs/smb/server/vfs.c      |  9 +++++++--
>  include/linux/fs.h       | 13 +++++++++++--
>  8 files changed, 78 insertions(+), 32 deletions(-)
>=20
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 88631291b32535f623a3fbe4ea9b6ed48a306ca0..51accd166dbf515eb5221b6a39b=
204622a6b0f7c 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -187,9 +187,14 @@ ecryptfs_do_create(struct inode *directory_inode,
>  	struct inode *inode;
> =20
>  	rc =3D lock_parent(ecryptfs_dentry, &lower_dentry, &lower_dir);
> -	if (!rc)
> -		rc =3D vfs_create(&nop_mnt_idmap, lower_dir,
> -				lower_dentry, mode, true);
> +	if (!rc) {
> +		struct createdata args =3D { .idmap =3D &nop_mnt_idmap,
> +					   .dir =3D lower_dir,
> +					   .dentry =3D lower_dentry,
> +					   .mode =3D mode,
> +					   .excl =3D true };
> +		rc =3D vfs_create(&args);
> +	}
>  	if (rc) {
>  		printk(KERN_ERR "%s: Failure to create dentry in lower fs; "
>  		       "rc =3D [%d]\n", __func__, rc);
> diff --git a/fs/namei.c b/fs/namei.c
> index f439429bdfa271ccc64c937771ef4175597feb53..fdf4e78cd041de8c564b7d1d89a=
46ba2aaf79d53 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3460,23 +3460,22 @@ static inline umode_t vfs_prepare_mode(struct mnt_i=
dmap *idmap,
> =20
>  /**
>   * vfs_create - create new file
> - * @idmap:	idmap of the mount the inode was found from
> - * @dir:	inode of the parent directory
> - * @dentry:	dentry of the child file
> - * @mode:	mode of the child file
> - * @want_excl:	whether the file must not yet exist
> + * @args:	struct createdata describing create to be done
>   *
>   * Create a new file.
>   *
>   * If the inode has been found through an idmapped mount the idmap of
> - * the vfsmount must be passed through @idmap. This function will then take
> - * care to map the inode according to @idmap before checking permissions.
> + * the vfsmount must be passed through @args->idmap. This function will th=
en take
> + * care to map the inode according to @args->idmap before checking permiss=
ions.
>   * On non-idmapped mounts or if permission checking is to be performed on =
the
>   * raw inode simply pass @nop_mnt_idmap.
>   */
> -int vfs_create(struct mnt_idmap *idmap, struct inode *dir,
> -	       struct dentry *dentry, umode_t mode, bool want_excl)
> +int vfs_create(struct createdata *args)
>  {
> +	struct mnt_idmap *idmap =3D args->idmap;
> +	struct inode *dir =3D args->dir;
> +	struct dentry *dentry =3D args->dentry;
> +	umode_t mode =3D args->mode;
>  	int error;
> =20
>  	error =3D may_create(idmap, dir, dentry);
> @@ -3490,7 +3489,7 @@ int vfs_create(struct mnt_idmap *idmap, struct inode =
*dir,
>  	error =3D security_inode_create(dir, dentry, mode);
>  	if (error)
>  		return error;
> -	error =3D dir->i_op->create(idmap, dir, dentry, mode, want_excl);
> +	error =3D dir->i_op->create(idmap, dir, dentry, mode, args->excl);
>  	if (!error)
>  		fsnotify_create(dir, dentry);
>  	return error;
> @@ -4382,12 +4381,20 @@ static int do_mknodat(int dfd, struct filename *nam=
e, umode_t mode,
> =20
>  	idmap =3D mnt_idmap(path.mnt);
>  	switch (mode & S_IFMT) {
> -		case 0: case S_IFREG:
> -			error =3D vfs_create(idmap, path.dentry->d_inode,
> -					   dentry, mode, true);
> +		case 0:
> +		case S_IFREG:
> +		{
> +			struct createdata args =3D { .idmap =3D idmap,
> +						   .dir =3D path.dentry->d_inode,
> +						   .dentry =3D dentry,
> +						   .mode =3D mode,
> +						   .excl =3D true };
> +
> +			error =3D vfs_create(&args);
>  			if (!error)
>  				security_path_post_mknod(idmap, dentry);
>  			break;
> +		}
>  		case S_IFCHR: case S_IFBLK:
>  			error =3D vfs_mknod(idmap, path.dentry->d_inode,
>  					  dentry, mode, new_decode_dev(dev));
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index b6d03e1ef5f7a5e8dd111b0d56c061f1e91abff7..dcd7de465e7e33d1c66ee0272c4=
f220d55e85928 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -258,6 +258,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh=
 *fhp,
>  	struct nfsd_attrs attrs =3D {
>  		.na_iattr	=3D iap,
>  	};
> +	struct createdata cargs =3D { };
>  	__u32 v_mtime, v_atime;
>  	struct inode *inode;
>  	__be32 status;
> @@ -344,7 +345,13 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_f=
h *fhp,
>  	status =3D fh_fill_pre_attrs(fhp);
>  	if (status !=3D nfs_ok)
>  		goto out;
> -	host_err =3D vfs_create(&nop_mnt_idmap, inode, child, iap->ia_mode, true);
> +
> +	cargs.idmap =3D &nop_mnt_idmap;
> +	cargs.dir =3D inode;
> +	cargs.dentry =3D child;
> +	cargs.mode =3D iap->ia_mode;
> +	cargs.excl =3D true;
> +	host_err =3D vfs_create(&cargs);
>  	if (host_err < 0) {
>  		status =3D nfserrno(host_err);
>  		goto out;
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index c400ea94ff2e837fd59719bf2c4b79ef1d064743..e4ed1952f02c0a66c64528e5945=
3cc9b2352c18f 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1527,11 +1527,12 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
>  		   struct nfsd_attrs *attrs,
>  		   int type, dev_t rdev, struct svc_fh *resfhp)
>  {
> -	struct dentry	*dentry, *dchild;
> -	struct inode	*dirp;
> -	struct iattr	*iap =3D attrs->na_iattr;
> -	__be32		err;
> -	int		host_err =3D 0;
> +	struct dentry		*dentry, *dchild;
> +	struct inode		*dirp;
> +	struct iattr		*iap =3D attrs->na_iattr;
> +	__be32			err;
> +	int			host_err =3D 0;
> +	struct createdata	cargs =3D { };
> =20
>  	dentry =3D fhp->fh_dentry;
>  	dirp =3D d_inode(dentry);
> @@ -1552,8 +1553,12 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
>  	err =3D 0;
>  	switch (type) {
>  	case S_IFREG:
> -		host_err =3D vfs_create(&nop_mnt_idmap, dirp, dchild,
> -				      iap->ia_mode, true);
> +		cargs.idmap =3D &nop_mnt_idmap;
> +		cargs.dir =3D dirp;
> +		cargs.dentry =3D dchild;
> +		cargs.mode =3D iap->ia_mode;
> +		cargs.excl =3D true;
> +		host_err =3D vfs_create(&cargs);
>  		if (!host_err)
>  			nfsd_check_ignore_resizing(iap);
>  		break;
> diff --git a/fs/open.c b/fs/open.c
> index fdaa6f08f6f4cac5c2fefd3eafa5e430e51f3979..006cc2aeb1fbbb3db48b32db798=
108da120f75c2 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1164,6 +1164,11 @@ struct file *dentry_open_nonotify(const struct path =
*path, int flags,
>  struct file *dentry_create(const struct path *path, int flags, umode_t mod=
e,
>  			   const struct cred *cred)
>  {
> +	struct createdata cargs =3D { .idmap =3D mnt_idmap(path->mnt),
> +				    .dir =3D d_inode(path->dentry->d_parent),
> +				    .dentry =3D path->dentry,
> +				    .mode =3D mode,
> +				    .excl =3D true };
>  	struct file *f;
>  	int error;
> =20
> @@ -1171,9 +1176,7 @@ struct file *dentry_create(const struct path *path, i=
nt flags, umode_t mode,
>  	if (IS_ERR(f))
>  		return f;
> =20
> -	error =3D vfs_create(mnt_idmap(path->mnt),
> -			   d_inode(path->dentry->d_parent),
> -			   path->dentry, mode, true);
> +	error =3D vfs_create(&cargs);
>  	if (!error)
>  		error =3D vfs_open(path, f);
> =20
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index d215d7349489686b66bb66e939b27046f7d836f6..5fa939ac842ed04df8f0088233f=
4cba4ac703c05 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -235,7 +235,12 @@ static inline int ovl_do_create(struct ovl_fs *ofs,
>  				struct inode *dir, struct dentry *dentry,
>  				umode_t mode)
>  {
> -	int err =3D vfs_create(ovl_upper_mnt_idmap(ofs), dir, dentry, mode, true);
> +	struct createdata cargs =3D { .idmap =3D ovl_upper_mnt_idmap(ofs),
> +				    .dir =3D dir,
> +				    .dentry =3D dentry,
> +				    .mode =3D mode,
> +				    .excl =3D true };
> +	int err =3D vfs_create(&cargs);
> =20
>  	pr_debug("create(%pd2, 0%o) =3D %i\n", dentry, mode, err);
>  	return err;
> diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> index c5f0f3170d586cb2dc4d416b80948c642797fb82..fbc3c34e14b870f1750b9453493=
35afb62d89d0d 100644
> --- a/fs/smb/server/vfs.c
> +++ b/fs/smb/server/vfs.c
> @@ -173,6 +173,7 @@ void ksmbd_vfs_query_maximal_access(struct mnt_idmap *i=
dmap,
>   */
>  int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mo=
de)
>  {
> +	struct createdata cargs =3D { };
>  	struct path path;
>  	struct dentry *dentry;
>  	int err;
> @@ -188,8 +189,12 @@ int ksmbd_vfs_create(struct ksmbd_work *work, const ch=
ar *name, umode_t mode)
>  	}
> =20
>  	mode |=3D S_IFREG;
> -	err =3D vfs_create(mnt_idmap(path.mnt), d_inode(path.dentry),
> -			 dentry, mode, true);
> +	cargs.idmap =3D mnt_idmap(path.mnt);
> +	cargs.dir =3D d_inode(path.dentry);
> +	cargs.dentry =3D dentry;
> +	cargs.mode =3D mode;
> +	cargs.excl =3D true;
> +	err =3D vfs_create(&cargs);
>  	if (!err) {
>  		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry),
>  					d_inode(dentry));
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 12873214e1c7811735ea5d2dee3d57e2a5604d8f..b61873767b37591aecadd147623=
d7dfc866bef82 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2111,8 +2111,17 @@ bool inode_owner_or_capable(struct mnt_idmap *idmap,
>  /*
>   * VFS helper functions..
>   */
> -int vfs_create(struct mnt_idmap *, struct inode *,
> -	       struct dentry *, umode_t, bool);
> +
> +struct createdata {
> +	struct mnt_idmap *idmap;	// idmap of the mount the inode was found from
> +	struct inode *dir;		// inode of parent directory
> +	struct dentry *dentry;		// dentry of the child file
> +	umode_t mode;			// mode of the child file
> +	bool excl;			// whether the file must not yet exist
> +};
> +
> +int vfs_create(struct createdata *);
> +
>  struct dentry *vfs_mkdir(struct mnt_idmap *, struct inode *,
>  			 struct dentry *, umode_t, struct delegated_inode *);
>  int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
>=20
> --=20
> 2.51.1
>=20
>=20


