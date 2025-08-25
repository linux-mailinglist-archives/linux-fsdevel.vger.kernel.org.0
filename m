Return-Path: <linux-fsdevel+bounces-59000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBB8B33DC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23F937A9E3F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 11:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6347A2E54C3;
	Mon, 25 Aug 2025 11:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="ntGJgKcP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D032E5411;
	Mon, 25 Aug 2025 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756120629; cv=none; b=L70j6v2wo4GRWSWThtmcrvLFSfzWSYjbWD5DF6LiBQRlDpnTb2UDTWtQNjRaPQgD5L1dv5WcBJnqnZ5OFVGGlCq6mOg8gi3JCbDLSXLcW2Pw49kgq6ZztzJtDLrSw8Ypg1YoVHOoblx51xxQiY8rIiB2W3akLdHZYAyB3BeBOIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756120629; c=relaxed/simple;
	bh=Nex9WygFR2p/2v+xa5Xt7H2GQpWFE3o8wISvk7723OA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VK77lbF08+JUm7+KsdDIrao8V4oETjlUjfuHvt8YRxCw5R59DLGWpokOj3std9BfAgJL2akj3Y4uF8VkIKW7firTgKg4DN9E1A+P1tWbyEAXE5yc/Xw4bNm+Zy/S6SpaKkRo6t9np3IHNzs9ybwB03mMkNnmkIiEjaKgQJGowNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=ntGJgKcP; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF3EB43252;
	Mon, 25 Aug 2025 11:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1756120625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5HDYS8rY76FdOS8DdrTzgO2ornOcFriVXaaNrkTiLRc=;
	b=ntGJgKcPwygDSo8XHovhiLbW8PanYDet/O1PWhUNSekNiUb0bFkN7rczY03UNHCMrFFocl
	def0G2ZHn7xwYDw2R5Jyfo0qsQdA3JBc41uaxKQdBsGJvqTfQ7R3A8aXqOD2BkqGdWqNON
	8DEjJfTiBtbZI08SUw3p4ByWCLukuPH94fLmbtAmZBqhYPnp3WW+WgwA+EBvAOfQDQ9o65
	3RLAl1rygZVlIqtdDkorK5OffrSMZp8B51KsmiXTSS+jTEqxPOXp2nGDCh58/2wvy7p9d9
	VDxbi1//c1DrurpszuQgOV36JKnSDWM09MCiECPYLoIPnNpkXdqhZ1xyG3e4vg==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Amir Goldstein
 <amir73il@gmail.com>,  Theodore Tso <tytso@mit.edu>,
  linux-unionfs@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  kernel-dev@igalia.com
Subject: Re: [PATCH v6 5/9] ovl: Ensure that all layers have the same encoding
In-Reply-To: <20250822-tonyk-overlayfs-v6-5-8b6e9e604fa2@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Fri, 22 Aug 2025 11:17:08 -0300")
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
	<20250822-tonyk-overlayfs-v6-5-8b6e9e604fa2@igalia.com>
Date: Mon, 25 Aug 2025 07:17:02 -0400
Message-ID: <871poz647l.fsf@mailhost.krisman.be>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthhqredttderjeenucfhrhhomhepifgrsghrihgvlhcumfhrihhsmhgrnhcuuegvrhhtrgiiihcuoehgrggsrhhivghlsehkrhhishhmrghnrdgsvgeqnecuggftrfgrthhtvghrnhepfedtvdehffevtddujeffffejudeuuefgvdeujeduhedtgfehkeefheegjefgueeknecukfhppeejtddrkedvrddukedvrdeikeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeejtddrkedvrddukedvrdeikedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepghgrsghrihgvlheskhhrihhsmhgrnhdrsggvpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopegrnhgurhgvrghlmhgvihgusehighgrlhhirgdrtghomhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthihthhsohesmhhithdrvgguuhdprhgtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvr
 hhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhk
X-GND-Sasl: gabriel@krisman.be

Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:

> When merging layers from different filesystems with casefold enabled,
> all layers should use the same encoding version and have the same flags
> to avoid any kind of incompatibility issues.
>
> Also, set the encoding and the encoding flags for the ovl super block as
> the same as used by the first valid layer.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  fs/overlayfs/super.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index df85a76597e910d00323018f1d2cd720c5db921d..b1dbd3c79961094d00c7f99cc=
622e515d544d22f 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -991,6 +991,18 @@ static int ovl_get_data_fsid(struct ovl_fs *ofs)
>  	return ofs->numfs;
>  }
>=20=20
> +/*
> + * Set the ovl sb encoding as the same one used by the first layer
> + */
> +static void ovl_set_encoding(struct super_block *sb, struct super_block =
*fs_sb)
> +{
> +#if IS_ENABLED(CONFIG_UNICODE)
> +	if (sb_has_encoding(fs_sb)) {
> +		sb->s_encoding =3D fs_sb->s_encoding;
> +		sb->s_encoding_flags =3D fs_sb->s_encoding_flags;
> +	}
> +#endif
> +}
>=20=20
>  static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
>  			  struct ovl_fs_context *ctx, struct ovl_layer *layers)
> @@ -1024,6 +1036,9 @@ static int ovl_get_layers(struct super_block *sb, s=
truct ovl_fs *ofs,
>  	if (ovl_upper_mnt(ofs)) {
>  		ofs->fs[0].sb =3D ovl_upper_mnt(ofs)->mnt_sb;
>  		ofs->fs[0].is_lower =3D false;
> +
> +		if (ofs->casefold)
> +			ovl_set_encoding(sb, ofs->fs[0].sb);
>  	}
>=20=20
>  	nr_merged_lower =3D ctx->nr - ctx->nr_data;
> @@ -1083,6 +1098,16 @@ static int ovl_get_layers(struct super_block *sb, =
struct ovl_fs *ofs,
>  		l->name =3D NULL;
>  		ofs->numlayer++;
>  		ofs->fs[fsid].is_lower =3D true;
> +
> +		if (ofs->casefold) {
> +			if (!ovl_upper_mnt(ofs) && !sb_has_encoding(sb))
> +				ovl_set_encoding(sb, ofs->fs[fsid].sb);
> +
> +			if (!sb_has_encoding(sb) || !sb_same_encoding(sb, mnt->mnt_sb)) {

Minor nit, but isn't the sb_has_encoding()  check redundant here?  sb_same_=
encoding
will check the sb->encoding matches the mnt_sb already.

> +				pr_err("all layers must have the same encoding\n");
> +				return -EINVAL;
> +			}
> +		}
>  	}
>
>  	/*

--=20
Gabriel Krisman Bertazi

