Return-Path: <linux-fsdevel+bounces-58995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F2FB33D14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A2B948374D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 10:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3612D7382;
	Mon, 25 Aug 2025 10:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="Z/ZsG5x4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C432D73B4;
	Mon, 25 Aug 2025 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756118586; cv=none; b=Vjyexd7hT+wI11L1SLVet7OmOV3+samOwT9P3XtmF6XEEOzuMCi5GOGwMyO6gmIrMzfav6zOeDjKaWQvcp7iYWNt+s5JwFySmn84vaOPoqQrGwylxraTI+Sxz0h6kCq/IxWuzePmO0q8iojt/RzVlOAbgKiSHQaV1rPnCUQNAfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756118586; c=relaxed/simple;
	bh=8OH/oFef91VNFir2tRo/hKrDxHlYQnDxTphIBEtUQSg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tsw+uOlYJqKeuRg7xE93OhtVlyFKTPlk6eX6wBTi9D6t/I3241/9UGq6PwNTzTN69pzTKfLqaEfIgJwlLf+XISK5VeiHZAtCXTRx+R+KM4ZzO5FEv+M1ZCIUYvGfi3pD03/zq4M9cP0YCiSM0eitwleYZ16TMQWx8g+yO3eIvzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=Z/ZsG5x4; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id D46A1431F2;
	Mon, 25 Aug 2025 10:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1756118576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hBsTH86xs+DJ2xN6Y98Y0wPML2aErKmzjQBwO4teuOk=;
	b=Z/ZsG5x4yw2K6JWCXIO2p3AIU/F7xAhkpDttvu5uB0/AHXQnq7YpXYyy59Y5e8ORXahrMo
	u/c45Pj1DXqbMjzCWPf/MAXY1kWvkUGnrI2VeCJFeCk/1y6CFwzc1p0Qtr2wNQ7qLde443
	/5ZuHXqFLG0GIhht/pgYyJ9GVEDGg+AnZvewcjyvIRWFX/+poqMIjiysZedcaJoYww5iQY
	Ix035V2wRfRmDS3/jlTna5IMgqwsGBgCYg9XMdBTazwdca6UXRgMT9EkMee+btyE9OwWKq
	QtUjFafNx2BGgxfXrliqwk6nN+qfpq029kLZKSs0CVpAR7aAWfJ2DDu3Ruei7A==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Amir Goldstein
 <amir73il@gmail.com>,  Theodore Tso <tytso@mit.edu>,
  linux-unionfs@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  kernel-dev@igalia.com
Subject: Re: [PATCH v6 3/9] ovl: Prepare for mounting case-insensitive
 enabled layers
In-Reply-To: <20250822-tonyk-overlayfs-v6-3-8b6e9e604fa2@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Fri, 22 Aug 2025 11:17:06 -0300")
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
	<20250822-tonyk-overlayfs-v6-3-8b6e9e604fa2@igalia.com>
Date: Mon, 25 Aug 2025 06:42:51 -0400
Message-ID: <87a53n65sk.fsf@mailhost.krisman.be>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthhqredttderjeenucfhrhhomhepifgrsghrihgvlhcumfhrihhsmhgrnhcuuegvrhhtrgiiihcuoehgrggsrhhivghlsehkrhhishhmrghnrdgsvgeqnecuggftrfgrthhtvghrnhepfedtvdehffevtddujeffffejudeuuefgvdeujeduhedtgfehkeefheegjefgueeknecukfhppeejtddrkedvrddukedvrdeikeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeejtddrkedvrddukedvrdeikedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepghgrsghrihgvlheskhhrihhsmhgrnhdrsggvpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopegrnhgurhgvrghlmhgvihgusehighgrlhhirgdrtghomhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthihthhsohesmhhithdrvgguuhdprhgtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvr
 hhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhk
X-GND-Sasl: gabriel@krisman.be

Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:

> Prepare for mounting layers with case-insensitive dentries in order to
> supporting such layers in overlayfs, while enforcing uniform casefold
> layers.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>


Reviewed-by: Gabriel Krisman Bertazi <gabriel@krisman.be>

> ---
>  fs/overlayfs/ovl_entry.h |  1 +
>  fs/overlayfs/params.c    | 15 ++++++++++++---
>  fs/overlayfs/params.h    |  1 +
>  3 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> index 4c1bae935ced274f93a0d23fe10d34455e226ec4..1d4828dbcf7ac4ba9657221e6=
01bbf79d970d225 100644
> --- a/fs/overlayfs/ovl_entry.h
> +++ b/fs/overlayfs/ovl_entry.h
> @@ -91,6 +91,7 @@ struct ovl_fs {
>  	struct mutex whiteout_lock;
>  	/* r/o snapshot of upperdir sb's only taken on volatile mounts */
>  	errseq_t errseq;
> +	bool casefold;
>  };
>=20=20
>  /* Number of lower layers, not including data-only layers */
> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> index f4e7fff909ac49e2f8c58a76273426c1158a7472..63b7346c5ee1c127a9c33b12c=
3704aa035ff88cf 100644
> --- a/fs/overlayfs/params.c
> +++ b/fs/overlayfs/params.c
> @@ -276,17 +276,26 @@ static int ovl_mount_dir(const char *name, struct p=
ath *path)
>  static int ovl_mount_dir_check(struct fs_context *fc, const struct path =
*path,
>  			       enum ovl_opt layer, const char *name, bool upper)
>  {
> +	bool is_casefolded =3D ovl_dentry_casefolded(path->dentry);
>  	struct ovl_fs_context *ctx =3D fc->fs_private;
> +	struct ovl_fs *ofs =3D fc->s_fs_info;
>=20=20
>  	if (!d_is_dir(path->dentry))
>  		return invalfc(fc, "%s is not a directory", name);
>=20=20
>  	/*
>  	 * Allow filesystems that are case-folding capable but deny composing
> -	 * ovl stack from case-folded directories.
> +	 * ovl stack from inconsistent case-folded directories.
>  	 */
> -	if (ovl_dentry_casefolded(path->dentry))
> -		return invalfc(fc, "case-insensitive directory on %s not supported", n=
ame);
> +	if (!ctx->casefold_set) {
> +		ofs->casefold =3D is_casefolded;
> +		ctx->casefold_set =3D true;
> +	}
> +
> +	if (ofs->casefold !=3D is_casefolded) {
> +		return invalfc(fc, "case-%ssensitive directory on %s is inconsistent",
> +			       is_casefolded ? "in" : "", name);
> +	}
>=20=20
>  	if (ovl_dentry_weird(path->dentry))
>  		return invalfc(fc, "filesystem on %s not supported", name);
> diff --git a/fs/overlayfs/params.h b/fs/overlayfs/params.h
> index c96d939820211ddc63e265670a2aff60d95eec49..ffd53cdd84827cce827e8852f=
2de545f966ce60d 100644
> --- a/fs/overlayfs/params.h
> +++ b/fs/overlayfs/params.h
> @@ -33,6 +33,7 @@ struct ovl_fs_context {
>  	struct ovl_opt_set set;
>  	struct ovl_fs_context_layer *lower;
>  	char *lowerdir_all; /* user provided lowerdir string */
> +	bool casefold_set;
>  };
>=20=20
>  int ovl_init_fs_context(struct fs_context *fc);

--=20
Gabriel Krisman Bertazi

