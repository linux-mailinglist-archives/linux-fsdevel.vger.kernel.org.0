Return-Path: <linux-fsdevel+bounces-66867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C695C2E8FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 01:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555DB189BFC6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 00:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A27C220F37;
	Tue,  4 Nov 2025 00:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="P0Gvr8ua";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DM2QyAbM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9561F1C860E;
	Tue,  4 Nov 2025 00:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215268; cv=none; b=M/HzczI18/SOVt/S2XtU6CvZcZWhxnpqbHQlGYU+PNjPddPdR47kZ/c8rEnH5ISvNttbE5GEUWXHcg2pBOQlecUbwyYNG6tmBzGFvFick1Psnj221svfXjlOrlWg+H1mQIYnjg9yihOoorkJ+h4/tyIZW3PoIch7Qn6pWEuc50w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215268; c=relaxed/simple;
	bh=lDu7U3HKT8e2Bh2Cfa3RV3/5MUFAiMce2puwzkrYqpo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Y/C6CVSdzhbZ0IRpesOZKhoxth+i9UT3i1BKTyUOeEE9zJFW0gU1oF6dkV5f9O9xxvX1+3cC8RxEIsZ92GX6dRsfGXo2tfoxlfzqa5Ea4reqSrlNG1JeYHj11+03VQjW+AwebGB42GKWczCxPK9OJzDvuQ6JEdIFY0+rwyotQ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=P0Gvr8ua; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DM2QyAbM; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 8118C130060B;
	Mon,  3 Nov 2025 19:14:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 03 Nov 2025 19:14:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762215264; x=1762222464; bh=zPY5MGIDBrrr6B4gNu/kBPWs9qfGdcWC3vI
	G8DrNGVQ=; b=P0Gvr8uanewFUuiBSv2+iKLCjC4AYh6qMkGkEwYHA45YOKFTVkW
	QD0y66piRdTTwFXBVWz/q/cQzncKp9Aqqch0/Ksnp/H6bSWD3XACxOkKC/1Xh9cd
	JKdtxKVrj2NUxWyrDn4A+8Y1i3eXS+AjzkAf4gpyUTLExCwi/zH+I1Z01uSc6vmx
	sIBETke3P0Q8AMcsjW1pmt+qBaPJ+WQ6PPqxUQdE3wYr1WzM0avM9A5nIY6Cwzv5
	+y0A50Z6rzb6KreJwTrFOv6vULtHcbNxDxLdioI8z6tESsLNcIkajE67e/57Po43
	yHfDW9XcGdGnDaktGY30axKxy+uoq5crIaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762215264; x=
	1762222464; bh=zPY5MGIDBrrr6B4gNu/kBPWs9qfGdcWC3vIG8DrNGVQ=; b=D
	M2QyAbMpO/VgrkOpfn9xQp4HPKgQpFlw3CQy2vxnKmhNrVS3rr/mGui/YfRDecBJ
	szBZz9HyIqja9n9LfuvrjnJA1bXh3NtyrumygV8DJMKq9PM7LguiaJN1+x73tflx
	S9xV5rzkNBMVLTg0wk1UKN6tPo7R9z4h7N+72pQe8QI/IbSKYhxzQhJO6Q/tZIXC
	Jb6SDSxoZrp/vZv1TKck1xQzjlDH2EpvYem8MDHXp1WbnS+wlIwKVbHwBlNvT3hE
	PlyBfY4BCzhqFD0E97FoAp/MUY3D8c8f3AQDWVIy+jzz8OhvdfjlmQ1xY1M/t4UP
	bWM1kuAtZxYERaR2tPA0w==
X-ME-Sender: <xms:X0UJaWrOr11-wK8gFvvJIfhAtpPHar-Za8HdQDul2bHe5aNyIHXyTw>
    <xme:X0UJaTqAj40Yjo0FuNTe57yPsxTD7MsKweIMYsRyQTzOyeI1znfoCko13ehsC13SL
    6wPE8QPLGPMNV1BtQnbKvtWW1b70yt__CxHwdVnDQVINWa8kE0>
X-ME-Received: <xmr:X0UJaTdMbOSy4MjcsN57aEkM5ojLJbfOBbt0REp3moTgRrlMJGOP2mCslGS-oFscREGT287ijYS7Q39hB_nA2OC4bp-r_Xg_CulHPCH5fr-9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeelheegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:X0UJaSTzu6h2EXS9QEqmg8J2H3tuM0CJ8ECIxgfKcWj6hMhsAWhEGQ>
    <xmx:X0UJaff0SQT8gzgwIpzb6p5oFqYmw8aSWxs_58nogTOWL879knBwng>
    <xmx:X0UJaSBH9a3obXYKofMc-99Lu6qf8G8dSGdHVEmMdI08McrYw41mBQ>
    <xmx:X0UJacuNf4nLs_Wpd_yqBTLs6XjwFjlrY9eKFQ1CE1_omychABrJrg>
    <xmx:YEUJabFqNK7qjjx86xINMV8iL3gMB3zlGluDix097j1AbMtB0R1skzWx>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 19:14:12 -0500 (EST)
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
Subject: Re: [PATCH v4 10/17] vfs: make vfs_create break delegations on parent
 directory
In-reply-to: <20251103-dir-deleg-ro-v4-10-961b67adee89@kernel.org>
References: <20251103-dir-deleg-ro-v4-0-961b67adee89@kernel.org>,
 <20251103-dir-deleg-ro-v4-10-961b67adee89@kernel.org>
Date: Tue, 04 Nov 2025 11:14:11 +1100
Message-id: <176221525113.1793333.253208063990645256@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 03 Nov 2025, Jeff Layton wrote:
> In order to add directory delegation support, we need to break
> delegations on the parent whenever there is going to be a change in the
> directory.
>=20
> Add a delegated_inode parameter to struct createdata. Most callers just
> leave that as a NULL pointer, but do_mknodat() is changed to wait for a
> delegation break if there is one.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/namei.c         | 26 +++++++++++++++++---------
>  include/linux/fs.h |  2 +-
>  2 files changed, 18 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index fdf4e78cd041de8c564b7d1d89a46ba2aaf79d53..e8973000a312fb05ebb63a0d9bd=
83b9a5f8f805d 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3487,6 +3487,9 @@ int vfs_create(struct createdata *args)
> =20
>  	mode =3D vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
>  	error =3D security_inode_create(dir, dentry, mode);
> +	if (error)
> +		return error;
> +	error =3D try_break_deleg(dir, args->delegated_inode);
>  	if (error)
>  		return error;
>  	error =3D dir->i_op->create(idmap, dir, dentry, mode, args->excl);
> @@ -4359,6 +4362,8 @@ static int may_mknod(umode_t mode)
>  static int do_mknodat(int dfd, struct filename *name, umode_t mode,
>  		unsigned int dev)
>  {
> +	struct delegated_inode delegated_inode =3D { };
> +	struct createdata cargs =3D { };

If we must have 'createdata', can it have a 'struct delegated_inode'
rather than a pointer to it?

NeilBrown


>  	struct mnt_idmap *idmap;
>  	struct dentry *dentry;
>  	struct path path;
> @@ -4383,18 +4388,16 @@ static int do_mknodat(int dfd, struct filename *nam=
e, umode_t mode,
>  	switch (mode & S_IFMT) {
>  		case 0:
>  		case S_IFREG:
> -		{
> -			struct createdata args =3D { .idmap =3D idmap,
> -						   .dir =3D path.dentry->d_inode,
> -						   .dentry =3D dentry,
> -						   .mode =3D mode,
> -						   .excl =3D true };
> -
> -			error =3D vfs_create(&args);
> +			cargs.idmap =3D idmap,
> +			cargs.dir =3D path.dentry->d_inode,
> +			cargs.dentry =3D dentry,
> +			cargs.delegated_inode =3D &delegated_inode;
> +			cargs.mode =3D mode,
> +			cargs.excl =3D true,
> +			error =3D vfs_create(&cargs);
>  			if (!error)
>  				security_path_post_mknod(idmap, dentry);
>  			break;
> -		}
>  		case S_IFCHR: case S_IFBLK:
>  			error =3D vfs_mknod(idmap, path.dentry->d_inode,
>  					  dentry, mode, new_decode_dev(dev));
> @@ -4406,6 +4409,11 @@ static int do_mknodat(int dfd, struct filename *name=
, umode_t mode,
>  	}
>  out2:
>  	end_creating_path(&path, dentry);
> +	if (is_delegated(&delegated_inode)) {
> +		error =3D break_deleg_wait(&delegated_inode);
> +		if (!error)
> +			goto retry;
> +	}
>  	if (retry_estale(error, lookup_flags)) {
>  		lookup_flags |=3D LOOKUP_REVAL;
>  		goto retry;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index b61873767b37591aecadd147623d7dfc866bef82..cfcb20a7c4ce4b6dcec98b3eccb=
db5ec8bab6fa9 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2116,12 +2116,12 @@ struct createdata {
>  	struct mnt_idmap *idmap;	// idmap of the mount the inode was found from
>  	struct inode *dir;		// inode of parent directory
>  	struct dentry *dentry;		// dentry of the child file
> +	struct delegated_inode *delegated_inode; // returns parent inode, if dele=
gated
>  	umode_t mode;			// mode of the child file
>  	bool excl;			// whether the file must not yet exist
>  };
> =20
>  int vfs_create(struct createdata *);
> -
>  struct dentry *vfs_mkdir(struct mnt_idmap *, struct inode *,
>  			 struct dentry *, umode_t, struct delegated_inode *);
>  int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
>=20
> --=20
> 2.51.1
>=20
>=20


