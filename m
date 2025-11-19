Return-Path: <linux-fsdevel+bounces-69036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40863C6C40E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 02:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id EE88729936
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 01:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D5A23EABA;
	Wed, 19 Nov 2025 01:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="KYNg/gMv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FpAtXxPI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427C81DFF0;
	Wed, 19 Nov 2025 01:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763515951; cv=none; b=pis5b5nbZGIeBZOc5r4r4zB8eGk6ld8rAeN+uDQaFMWHSZxxxiGfGXNN1OtSHOEapFYvGBpuLjdIwmqT2+KZYqAQkaLSdgOCeA89F89T15cNpx30NjoTBmrSDR9CdzriHGdJY7iERX0GQwcFzQ39f1Q1vw28em6bg9FtR7vxJ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763515951; c=relaxed/simple;
	bh=ZMaEExuy0R7E3HiwV+cFQtBGnv3p6z3fGHZRS46B1Gs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=S4AyTieW5Yo2z42EjwKn/LsH3Gyo8p72WoOjG6a0badCWlI6sQId3KHQitBPrpLX7wy+A391QALtb+EEdvJEdSu2RygsxuNBtMijOH3sHNklqgvY66GrjFo1VYGR/TiYyFdDz1oEbJMY4Aswh9nzWG8evz1RGcF3q5U3XUjJCAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=KYNg/gMv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FpAtXxPI; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E95E77A018D;
	Tue, 18 Nov 2025 20:32:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 18 Nov 2025 20:32:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1763515947; x=1763602347; bh=uyvlm+7slp3Xhn6FwDY2xuuurVl4pI+qbti
	kYgXbSzU=; b=KYNg/gMvOMYEccaXzH/hbbBXQVKiA86OW+mWuOHwK3KW3YL1ofo
	eL3SURW7Q8exFHZ0T24qQ9p0blxSjyOwesIx6lepRAvG1RVYrP6pWSFV9nIdYPRB
	xQTKDCexUrHv8DOTngFinB1vpBEe2XRWmfwS7r3DmadMlyZwM2m/HkiveDwKAHDH
	vv8uT1I0oNjXtY0Ta4nObHw6IhFG+xhmRe8raRtLjJ9CNjQ0G6mbxNHYuHLEfM6n
	vMkMoaVx6R/N26G8zGKV5Kv7TFqZcGEwqbStPt51akU1Dx/Gh8yNxreA9vvTdGZF
	aBei67e1vFfbxx/tKlVs7fJqSX+8clUZlxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763515947; x=
	1763602347; bh=uyvlm+7slp3Xhn6FwDY2xuuurVl4pI+qbtikYgXbSzU=; b=F
	pAtXxPIvjwuyDJafId4n4Y4oThcnzgBOSWRR+nJP4vJw6CFkd0shvabTo5DvfEYu
	+v5dq7h5c9SuPHe61cIaNo8i8reSX/2Zw4cnpSBci/F4kJvOWBo96pGEMMsJ2JS8
	JkdpgNoTbC8yyej1X2e99rfH+EKZMSBD2toJdFma6XVqNZt+HshM/1QxyH2ug5Ii
	24jrmy/Zhq8PWD8e6tpVF1X7Mb0xdsxxvTt3aJqPrC7ID92ujJ1lO+qtaKilvsSV
	FBBTOVSBKBhpj6Z/FnrLaSudu5L8iept48wa+DrVsPgXUo0mIujwW2pqw2/rE2nC
	WzujydwadH0mWoUL2yl0g==
X-ME-Sender: <xms:Kx4daf7I3hxdyoiDyh81pVkpdhlzzlXaCFCUHOmspmW8PW44ZMigOw>
    <xme:Kx4dafTczIg0o7iffC1YqC0r1t_KfpcTZCkr6DuvQxdY_54MzAaq2YMVOM8Ugll6v
    xS93fqfq6Z7b9O1hp9npjsv5qduKbjOJbXzIEb3cFRFje89Nis>
X-ME-Received: <xmr:Kx4dacnrc0O7JBN5DwxfrXOWBMyodj_45_Hgcz6ZOuoQDSGMi2EhZw54bWCkZHO01HEJC9Kfr25VfKhQWMheB2lJBESh8w5yy3XUexthzxDK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddvkeelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Kx4dabQe5aQ44_mLzRrEeOCOUXwBZU9im07xwWzD_xRtZODLtDAenQ>
    <xmx:Kx4dabvPPglEzDnRZJ6J88vcWFm8MMC-TAzInqZammEGWrfKObZmdA>
    <xmx:Kx4dac7nbjycc_WWxdJDpPvsHfCVRFdowiUEH4zk5SlVpoU9I5znHA>
    <xmx:Kx4daeg2RxYEW_R0iuN-Najmwp_eIpGrNOG_G7B9R5Qcvrw4UHW94w>
    <xmx:Kx4daem0XdWhkpCYKA7g6MNs8TjTertgigpaPa-Jii_IdhVYTob-AjQ7>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 20:32:23 -0500 (EST)
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
Subject: Re: [PATCH v1 2/3] VFS: Prepare atomic_open() for dentry_create()
In-reply-to: =?utf-8?q?=3C333c7f8940bd9b14a2311d5e65b6c007e8079966=2E1763483?=
 =?utf-8?q?341=2Egit=2Ebcodding=40hammerspace=2Ecom=3E?=
References: <cover.1763483341.git.bcodding@hammerspace.com>, =?utf-8?q?=3C33?=
 =?utf-8?q?3c7f8940bd9b14a2311d5e65b6c007e8079966=2E1763483341=2Egit=2Ebcodd?=
 =?utf-8?q?ing=40hammerspace=2Ecom=3E?=
Date: Wed, 19 Nov 2025 12:32:21 +1100
Message-id: <176351594168.634289.2632498932696325048@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 19 Nov 2025, Benjamin Coddington wrote:
> The next patch allows dentry_create() to call atomic_open(), but it does
> not have fabricated nameidata.  Let atomic_open() take a path instead.

I think this commit message could usefully be longer and more details.

 atomic_open() currently takes a nameidata of which it only uses the
 path and the flags.  Flags are only used to update open_flags.  That
 update can happen before atomic_open() is called which would mean that
 only the path need be passed to atomic_open() rather than the whole
 nameidata.  This will make it easier for dentry_create() To call
 atomic_open().
=09
Thanks,
NeilBrown

>=20
> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> ---
>  fs/namei.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index e2bfd2a73cba..9c0aad5bbff7 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3552,19 +3552,16 @@ static int may_o_create(struct mnt_idmap *idmap,
>   *
>   * Returns an error code otherwise.
>   */
> -static struct dentry *atomic_open(struct nameidata *nd, struct dentry *den=
try,
> +static struct dentry *atomic_open(const struct path *path, struct dentry *=
dentry,
>  				  struct file *file,
>  				  int open_flag, umode_t mode)
>  {
>  	struct dentry *const DENTRY_NOT_SET =3D (void *) -1UL;
> -	struct inode *dir =3D  nd->path.dentry->d_inode;
> +	struct inode *dir =3D  path->dentry->d_inode;
>  	int error;
> =20
> -	if (nd->flags & LOOKUP_DIRECTORY)
> -		open_flag |=3D O_DIRECTORY;
> -
>  	file->f_path.dentry =3D DENTRY_NOT_SET;
> -	file->f_path.mnt =3D nd->path.mnt;
> +	file->f_path.mnt =3D path->mnt;
>  	error =3D dir->i_op->atomic_open(dir, dentry, file,
>  				       open_to_namei_flags(open_flag), mode);
>  	d_lookup_done(dentry);
> @@ -3676,7 +3673,10 @@ static struct dentry *lookup_open(struct nameidata *=
nd, struct file *file,
>  	if (create_error)
>  		open_flag &=3D ~O_CREAT;
>  	if (dir_inode->i_op->atomic_open) {
> -		dentry =3D atomic_open(nd, dentry, file, open_flag, mode);
> +		if (nd->flags & LOOKUP_DIRECTORY)
> +			open_flag |=3D O_DIRECTORY;
> +
> +		dentry =3D atomic_open(&nd->path, dentry, file, open_flag, mode);
>  		if (unlikely(create_error) && dentry =3D=3D ERR_PTR(-ENOENT))
>  			dentry =3D ERR_PTR(create_error);
>  		return dentry;
> --=20
> 2.50.1
>=20
>=20


