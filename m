Return-Path: <linux-fsdevel+bounces-59002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B17D3B33DE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B563F1A82DF7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 11:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C782E7BDA;
	Mon, 25 Aug 2025 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="Mqq5WU5o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8CC2E62C7;
	Mon, 25 Aug 2025 11:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756121059; cv=none; b=FMtU/hATdAmSHf8hte64n5HX9aZztDuyrXQpVtQMtQ/VF+U0pCqyYHSKSJa/UFrrhv2KVuEu6BpVFgb/9JV6hRbiwRWNSLalSa9ih+3gj4FBwoec6uGuDb3IF52MVXW4WglZm9ukspZIhq0RzfDQCTXLyRQxKeOLAqlQo83P31c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756121059; c=relaxed/simple;
	bh=zPygxx/vRoMNtqmzghKwOct92xDJT5deX0kr36f1lmE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VAkvksNfPpB8F7CtiJTdFCJSg8lqLbMkfecJJ21aDlMKfDLcIGEohE3pOCkLBRE8hxWzrZFV4vS9ighPLkUUKX8ETlZOQaf5ushJhQitAVVljKa1D0hw61jM/SkbKQcJNzTqY5GooOqzKLUQt4VqRdpaT6fZSSWnmNoqT2Ey73Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=Mqq5WU5o; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8A5B243A68;
	Mon, 25 Aug 2025 11:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1756121048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mt4SUYjj6vEAPWrFWoIAkYL+7ohn6J8jCx8g/+XReEU=;
	b=Mqq5WU5oQJntazEicGPnLe5AXMktQ73Ns2GOziWyMEfEmIV4lSAbf/bp3c2j6KNkHhAVhX
	pAnOOtMAyQoJzOYuGw1BlnO0oGWXAzP18OBZvQ5gb0HcPNZlWejXERcmZQDKibdhKYZ+M1
	M2l7uhgUbd5AZQdp2WWjvnZZEzV3RH9NGBuwmAZg5MoVoa/uja2/e5DJ14WAP/mW+0Yxpf
	wv/Q+JI9AjC16KFB/znSuvSILYmDVtKyCOc/TVf0cMS65Fbh6Iw9oXP5mMUuk9lhod4izZ
	i4P1ZVy7Zc9F9KxarKRF9/EtG2V5j3NdYHaGrOG1DvI//UzBUdiTZc3sc+pJuw==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Amir Goldstein
 <amir73il@gmail.com>,  Theodore Tso <tytso@mit.edu>,
  linux-unionfs@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  kernel-dev@igalia.com
Subject: Re: [PATCH v6 6/9] ovl: Set case-insensitive dentry operations for
 ovl sb
In-Reply-To: <20250822-tonyk-overlayfs-v6-6-8b6e9e604fa2@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Fri, 22 Aug 2025 11:17:09 -0300")
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
	<20250822-tonyk-overlayfs-v6-6-8b6e9e604fa2@igalia.com>
Date: Mon, 25 Aug 2025 07:24:04 -0400
Message-ID: <87wm6r4pbf.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthhqredttderjeenucfhrhhomhepifgrsghrihgvlhcumfhrihhsmhgrnhcuuegvrhhtrgiiihcuoehgrggsrhhivghlsehkrhhishhmrghnrdgsvgeqnecuggftrfgrthhtvghrnhepfedtvdehffevtddujeffffejudeuuefgvdeujeduhedtgfehkeefheegjefgueeknecukfhppeejtddrkedvrddukedvrdeikeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeejtddrkedvrddukedvrdeikedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepghgrsghrihgvlheskhhrihhsmhgrnhdrsggvpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopegrnhgurhgvrghlmhgvihgusehighgrlhhirgdrtghomhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthihthhsohesmhhithdrvgguuhdprhgtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvr
 hhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhk
X-GND-Sasl: gabriel@krisman.be

Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:

> For filesystems with encoding (i.e. with case-insensitive support), set
> the dentry operations for the super block as ovl_dentry_ci_operations.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
> Changes in v6:
> - Fix kernel bot warning: unused variable 'ofs'
> ---
>  fs/overlayfs/super.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index b1dbd3c79961094d00c7f99cc622e515d544d22f..8db4e55d5027cb975fec9b922=
51f62fe5924af4f 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -161,6 +161,16 @@ static const struct dentry_operations ovl_dentry_ope=
rations =3D {
>  	.d_weak_revalidate =3D ovl_dentry_weak_revalidate,
>  };
>=20=20
> +#if IS_ENABLED(CONFIG_UNICODE)
> +static const struct dentry_operations ovl_dentry_ci_operations =3D {
> +	.d_real =3D ovl_d_real,
> +	.d_revalidate =3D ovl_dentry_revalidate,
> +	.d_weak_revalidate =3D ovl_dentry_weak_revalidate,
> +	.d_hash =3D generic_ci_d_hash,
> +	.d_compare =3D generic_ci_d_compare,
> +};
> +#endif
> +
>  static struct kmem_cache *ovl_inode_cachep;
>=20=20
>  static struct inode *ovl_alloc_inode(struct super_block *sb)
> @@ -1332,6 +1342,19 @@ static struct dentry *ovl_get_root(struct super_bl=
ock *sb,
>  	return root;
>  }
>=20=20
> +static void ovl_set_d_op(struct super_block *sb)
> +{
> +#if IS_ENABLED(CONFIG_UNICODE)
> +	struct ovl_fs *ofs =3D sb->s_fs_info;
> +
> +	if (ofs->casefold) {
> +		set_default_d_op(sb, &ovl_dentry_ci_operations);
> +		return;
> +	}
> +#endif
> +	set_default_d_op(sb, &ovl_dentry_operations);
> +}
> +
>  int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>  	struct ovl_fs *ofs =3D sb->s_fs_info;
> @@ -1443,6 +1466,8 @@ int ovl_fill_super(struct super_block *sb, struct f=
s_context *fc)
>  	if (IS_ERR(oe))
>  		goto out_err;
>=20=20
> +	ovl_set_d_op(sb);
> +

Absolutely minor, but fill_super is now calling
set_default_d_op(sb, &ovl_dentry_operations) twice, once here and once
at the beginning of the function.  You can remove the original call.

>  	/* If the upper fs is nonexistent, we mark overlayfs r/o too */
>  	if (!ovl_upper_mnt(ofs))
>  		sb->s_flags |=3D SB_RDONLY;

--=20
Gabriel Krisman Bertazi

