Return-Path: <linux-fsdevel+bounces-64084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AE3BD7752
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 07:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32A83E646E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 05:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7209D29ACEE;
	Tue, 14 Oct 2025 05:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="eEEsbyrv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u2xR65Sj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB76C26E6F2;
	Tue, 14 Oct 2025 05:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760420262; cv=none; b=ByrBfmFlJc7PnLjUhjAVOoHo5CVIN73gqOKXFYEXdtpPtpp7oyAZoT/bumVVzXYjR6fl408eAux5f4NJtQgElez0E5BI0C3er6X5vRts9Wg6hphpSKeQjF0mBWN/4FS6w4wCV1pEAfy27gB/PPUvjV3qryqZsoo3wVmQc0tuX70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760420262; c=relaxed/simple;
	bh=6uxmdvXEio8HIVppsMuImkhBA623p6fVc1eix1tJy+8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=opR1O+6dUB+8MxkwR9F1kcHxSu3RRedXsf1HvFLWEZXbuGhxZZ2VB4LeBMgI5VZLzkUfwn5L+Rm3Zil4qy3a7lk03C+o5pJ4WJS8hxsV4v723mvQMHY+eDGR1k7EPmy2YcuT95czvIZfe9+6JZmEYPEe39+Q0cqziXeBqM3HNb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=eEEsbyrv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u2xR65Sj; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 0CD47130001D;
	Tue, 14 Oct 2025 01:37:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 14 Oct 2025 01:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760420258; x=1760427458; bh=VEqB9l9ap/RXCUPGqavgRw+7zJim+VH8Qx5
	U9WCtKw8=; b=eEEsbyrvB5yw69rJN7kg4jea/5QDVuRRK8P4sWYi9RtGqLoaaJo
	MRDZOgC/lA1u4RqxESxjDE37jJf64rE/LRDCZB7yoLrTeHOiGMoU7a6jIwkmF411
	zDbmIDVtKUkZfKqhZmJGii569vJep7SIID2aH3R01cBU1TJlQo6VkVHjXdLr8gIs
	XYldIG5mWoCGz2OXPnpNLFKMNUea1RSqeGM4yGdbknPLitO26enYeo/Bz79fjgvK
	N/7wauxMshxEYevDARx0zgOqAu9QrRDKrnd12fturcW6ZoK5UUlUg5d8PNd7oQ9o
	F32R2NpQaMPUiQnmeGG/o+1Ktk8vTmhtMFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760420258; x=
	1760427458; bh=VEqB9l9ap/RXCUPGqavgRw+7zJim+VH8Qx5U9WCtKw8=; b=u
	2xR65SjBzBcXzGnRcPWgqDCRVxLZjyTCrcNEpgFlT0+rOgS/QiD4H0G/j08nIdnW
	mbMx5QNyVO7Hz8fyxlWiF6nzE0BMVmRfksIvhLTMgdGs819ynBTCzUPZGGD9cmXm
	Up3+vGOl8PLL1qu8kMBMCIBZIxF2YzllbI8r8uYOsWYClfOFl4SdapTr4bE97Eqx
	Q2pxMhTE0+mtfjc4FCzyJH6O+wJW4BZzWXhJs5VlHkXxKeIiMfUE8eaVPDjb61HQ
	DXeCrGOAT/J5FJPyLyd8VxTYvF+5tssEKYJP0qZTWSlkI/+pxM609d3J4eCoRXgu
	F995qph2JeCY0BblWO2sg==
X-ME-Sender: <xms:oeHtaHCyxHu-ycKrvxZrlWQTHHhddeobSu2UGk34kZo1hAz2zfy1EA>
    <xme:oeHtaMj62YoRf5-Laxs0JRLkSxnK2NFZzMXLh0UYyaT6ji1XkiZKXvElBMPkqZKhd
    4o_THhW07WOL4T52q9EuCcjnWjwvuqJDsZRxxdA4V-EAC8sIg>
X-ME-Received: <xmr:oeHtaK0OJsbtrRG3k3jf2ffKhEc0iiQ6xtz474FJHW1zbC7uFuGKrIUKezPWFVadrCoj6VMB3vEZFx_Kx8rhbW5g4roPL1smCuZDRg-or27s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudeljeduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:oeHtaGLDUUJX3puo8-bveOMqIyIr0Z36y2e4LcLGxIfpo0y-AQourg>
    <xmx:oeHtaF1TU79fF6mFCzgvtQVVioFMnxVr0AaNTQahbeYFnX42KimeiQ>
    <xmx:oeHtaI4cyjVtBgI0DrIOmGwqt5c7zSzAF_WbOtdBsd_X8k5z93em8Q>
    <xmx:oeHtaKFBR7z0RxJFHa__a9YDnwF1lrxEG_25uXBlo8faz3BKtOLvwQ>
    <xmx:ouHtaMevqkc40FxHaOWD_Wum2ToejVeHdlne4sidu3b2CwuCRPOQ0fCA>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 01:37:27 -0400 (EDT)
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
Subject: Re: [PATCH 01/13] filelock: push the S_ISREG check down to ->setlease
 handlers
In-reply-to: <20251013-dir-deleg-ro-v1-1-406780a70e5e@kernel.org>
References: <20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org>,
 <20251013-dir-deleg-ro-v1-1-406780a70e5e@kernel.org>
Date: Tue, 14 Oct 2025 16:37:25 +1100
Message-id: <176042024558.1793333.16859845484527356211@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 14 Oct 2025, Jeff Layton wrote:
> When nfsd starts requesting directory delegations, setlease handlers may
> see requests for leases on directories. Push the !S_ISREG check down
> into the non-trivial setlease handlers, so we can selectively enable
> them where they're supported.
>=20
> FUSE is special: It's the only filesystem that supports atomic_open and
> allows kernel-internal leases. Ensure that we don't allow directory
> leases by default going forward by explicitly disabling them there.

What is special about atomic_open w.r.t leases?

Thanks,
NeilBrown


>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/fuse/dir.c          | 1 +
>  fs/locks.c             | 5 +++--
>  fs/nfs/nfs4file.c      | 2 ++
>  fs/smb/client/cifsfs.c | 3 +++
>  4 files changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index ecaec0fea3a132e7cbb88121e7db7fb504d57d3c..667774cc72a1d49796f531fcb34=
2d2e4878beb85 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -2230,6 +2230,7 @@ static const struct file_operations fuse_dir_operatio=
ns =3D {
>  	.fsync		=3D fuse_dir_fsync,
>  	.unlocked_ioctl	=3D fuse_dir_ioctl,
>  	.compat_ioctl	=3D fuse_dir_compat_ioctl,
> +	.setlease	=3D simple_nosetlease,
>  };
> =20
>  static const struct inode_operations fuse_common_inode_operations =3D {
> diff --git a/fs/locks.c b/fs/locks.c
> index 04a3f0e2072461b6e2d3d1cd12f2b089d69a7db3..0b16921fb52e602ea2e0c3de39d=
9d772af98ba7d 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1929,6 +1929,9 @@ static int generic_delete_lease(struct file *filp, vo=
id *owner)
>  int generic_setlease(struct file *filp, int arg, struct file_lease **flp,
>  			void **priv)
>  {
> +	if (!S_ISREG(file_inode(filp)->i_mode))
> +		return -EINVAL;
> +
>  	switch (arg) {
>  	case F_UNLCK:
>  		return generic_delete_lease(filp, *priv);
> @@ -2018,8 +2021,6 @@ vfs_setlease(struct file *filp, int arg, struct file_=
lease **lease, void **priv)
> =20
>  	if ((!vfsuid_eq_kuid(vfsuid, current_fsuid())) && !capable(CAP_LEASE))
>  		return -EACCES;
> -	if (!S_ISREG(inode->i_mode))
> -		return -EINVAL;
>  	error =3D security_file_lock(filp, arg);
>  	if (error)
>  		return error;
> diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
> index 7f43e890d3564a000dab9365048a3e17dc96395c..7317f26892c5782a39660cae87e=
c1afea24e36c0 100644
> --- a/fs/nfs/nfs4file.c
> +++ b/fs/nfs/nfs4file.c
> @@ -431,6 +431,8 @@ void nfs42_ssc_unregister_ops(void)
>  static int nfs4_setlease(struct file *file, int arg, struct file_lease **l=
ease,
>  			 void **priv)
>  {
> +	if (!S_ISREG(file_inode(file)->i_mode))
> +		return -EINVAL;
>  	return nfs4_proc_setlease(file, arg, lease, priv);
>  }
> =20
> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> index 05b1fa76e8ccf1e86f0c174593cd6e1acb84608d..03c44c1d9bb631b87a8b67aa16e=
481d6bb3c7d14 100644
> --- a/fs/smb/client/cifsfs.c
> +++ b/fs/smb/client/cifsfs.c
> @@ -1149,6 +1149,9 @@ cifs_setlease(struct file *file, int arg, struct file=
_lease **lease, void **priv
>  	struct inode *inode =3D file_inode(file);
>  	struct cifsFileInfo *cfile =3D file->private_data;
> =20
> +	if (!S_ISREG(inode->i_mode))
> +		return -EINVAL;
> +
>  	/* Check if file is oplocked if this is request for new lease */
>  	if (arg =3D=3D F_UNLCK ||
>  	    ((arg =3D=3D F_RDLCK) && CIFS_CACHE_READ(CIFS_I(inode))) ||
>=20
> --=20
> 2.51.0
>=20
>=20


