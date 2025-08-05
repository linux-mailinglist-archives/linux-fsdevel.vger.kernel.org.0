Return-Path: <linux-fsdevel+bounces-56772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D805DB1B6EE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 16:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA88A4E072C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 14:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5464B279795;
	Tue,  5 Aug 2025 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="LwnR5bwG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA39B2264A0;
	Tue,  5 Aug 2025 14:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754405814; cv=none; b=eymTH1lMd39kdTf5MPxpdC/h4p0VyvTuynSDBMjTf2iCLJqwW7UeCOkStq/MQWktex6lzpO+trAnL1Y02ZoVfMukJGsVVolv4BYtFt1FMdgqm4L4j9nGyqUfB7QrEjqqbCrYjVdM5Vr9+xsS/JdpuLvwrBOOWhku5hfnIkCIUVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754405814; c=relaxed/simple;
	bh=1uW6JAFmjM9oa8YMn3oXwvBowZ/5iDKJOMwkXbv44co=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dm7Y3TtD8Uq/MX1Q9ijHH8A+plVbKrei/jZREcuuDPqDewHhAiPz69b4OQXdYbVQbCWvPZj6f3S0FB7TIqqLfrRU4yPVmCwb9GktymOmjbys5OFeW3IIPobpmeno+ERNlZZjlrst73skfGryoXYOBJoj1xjB+MJ/ypNFUSiyq50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=LwnR5bwG; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id B740F44275;
	Tue,  5 Aug 2025 14:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1754405810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ygpX4acl3ZoXdt5UguQSJswZINbjERZaJP3QHEcb5DA=;
	b=LwnR5bwGtoLyRzkNl6Cdjnqb39MzU9Dv15v3YMRIG2IC5k2NxCc4XOecF9EbjLd9oTgJn8
	qPV6+mpIsF8sOPK4K/30Hxy6RoG6Po3SuLC7eC0jvcoMn5zaNNR3wY8577lQec8aSeWE8H
	GVohOg7fQWTBOzp51FiriANSbOafpgMtGlYwPMXrdhNukzFFToBDvV08D8bV6gAJcsOaHx
	zBE2QmJrd+qWvj4QWSJQ5C2cOyHcH5sTfgT6bYxMkJ9fiFQCfhu/01K5yWuG+BlIc9MfrB
	ZzGQ1aLG02RwIohPFdETzkVH82II8x9feDyMVDykRrmruXC0LRJhylndpXVqCg==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Amir Goldstein
 <amir73il@gmail.com>,  Theodore Tso <tytso@mit.edu>,
  linux-unionfs@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  kernel-dev@igalia.com
Subject: Re: [PATCH RFC v2 2/8] ovl: Create ovl_strcmp() with casefold support
In-Reply-To: <20250805-tonyk-overlayfs-v2-2-0e54281da318@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Tue, 05 Aug 2025 00:09:06 -0300")
References: <20250805-tonyk-overlayfs-v2-0-0e54281da318@igalia.com>
	<20250805-tonyk-overlayfs-v2-2-0e54281da318@igalia.com>
Date: Tue, 05 Aug 2025 10:56:45 -0400
Message-ID: <87o6stakb6.fsf@mailhost.krisman.be>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehgeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthhqredttderjeenucfhrhhomhepifgrsghrihgvlhcumfhrihhsmhgrnhcuuegvrhhtrgiiihcuoehgrggsrhhivghlsehkrhhishhmrghnrdgsvgeqnecuggftrfgrthhtvghrnhepfedtvdehffevtddujeffffejudeuuefgvdeujeduhedtgfehkeefheegjefgueeknecukfhppeejtddrkedvrddukedvrdeikeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeejtddrkedvrddukedvrdeikedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepghgrsghrihgvlheskhhrihhsmhgrnhdrsggvpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopegrnhgurhgvrghlmhgvihgusehighgrlhhirgdrtghomhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthihthhsohesmhhithdrvgguuhdprhgtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvr
 hhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhk

Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:

> To add overlayfs support casefold filesystems, create a new function
> ovl_strcmp() with support for casefold names.
>
> If the ovl_cache_entry have stored a casefold name, use it and create
> a casfold version of the name that is going to be compared to.
>
> For the casefold support, just comparing the strings does not work
> because we need the dentry enconding, so make this function find the
> equivalent dentry for a giving directory, if any.
>
> As this function is used for search and insertion in the red-black tree,
> that means that the tree node keys are going to be the casefolded
> version of the dentry's names. Otherwise, the search would not work for
> case-insensitive mount points.
>
> For the non-casefold names, nothing changes.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
> I wonder what should be done here if kmalloc fails, if the strcmp()
> should fail as well or just fallback to the normal name?
> ---
>  fs/overlayfs/readdir.c | 42 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)
>
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 83bca1bcb0488461b08effa70b32ff2fefba134e..1b8eb10e72a229ade40d18795=
746d3c779797a06 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -72,6 +72,44 @@ static struct ovl_cache_entry *ovl_cache_entry_from_no=
de(struct rb_node *n)
>  	return rb_entry(n, struct ovl_cache_entry, node);
>  }
>=20=20
> +/*
> + * Compare a string with a cache entry, with support for casefold names.
> + */
> +static int ovl_strcmp(const char *str, struct ovl_cache_entry *p, int le=
n)
> +{

Why do you need to re-casefold str on every call to ovl_strcmp?  Isn't
it done in a loop while walking the rbtree with a constant "str" (i.e.,
the name being added, see ovl_cache_entry_find)? Can't you do it once,
outside of ovl_strcmp? This way you don't repeatedly allocate/free
memory for each node of the tree (as Viro mentioned), and you don't have
to deal with kmalloc failures here.

> +
> +	const struct qstr qstr =3D { .name =3D str, .len =3D len };
> +	const char *p_name =3D p->name, *name =3D str;
> +	char *dst =3D NULL;
> +	int cmp, cf_len;
> +
> +	if (p->cf_name)
> +		p_name =3D p->cf_name;

This should check IS_ENABLED(CONFIG_UNICODE) so it can be
compiled out by anyone doing CONFIG_UNICODE=3Dn

> +
> +	if (p->map && !is_dot_dotdot(str, len)) {
> +		dst =3D kmalloc(OVL_NAME_LEN, GFP_KERNEL);
> +
> +		/*
> +		 * strcmp can't fail, so we fallback to the use the original
> +		 * name
> +		 */
> +		if (dst) {
> +			cf_len =3D utf8_casefold(p->map, &qstr, dst, OVL_NAME_LEN);

utf8_casefold can fail, as you know and checked.  But if it does, a
negative cf_len is passed to strncmp and cast to a very high
value.

> +
> +			if (cf_len > 0) {
> +				name =3D dst;
> +				dst[cf_len] =3D '\0';
> +			}

utf8_casefold ensures the string is NULL-terminated on success already.

> +		}
> +	}
> +
> +	cmp =3D strncmp(name, p_name, cf_len);
> +
> +	kfree(dst);
> +
> +	return cmp;
> +}
> +
>  static bool ovl_cache_entry_find_link(const char *name, int len,
>  				      struct rb_node ***link,
>  				      struct rb_node **parent)
> @@ -85,7 +123,7 @@ static bool ovl_cache_entry_find_link(const char *name=
, int len,
>=20=20
>  		*parent =3D *newp;
>  		tmp =3D ovl_cache_entry_from_node(*newp);
> -		cmp =3D strncmp(name, tmp->name, len);
> +		cmp =3D ovl_strcmp(name, tmp, len);
>  		if (cmp > 0)
>  			newp =3D &tmp->node.rb_right;
>  		else if (cmp < 0 || len < tmp->len)
> @@ -107,7 +145,7 @@ static struct ovl_cache_entry *ovl_cache_entry_find(s=
truct rb_root *root,
>  	while (node) {
>  		struct ovl_cache_entry *p =3D ovl_cache_entry_from_node(node);
>=20=20
> -		cmp =3D strncmp(name, p->name, len);
> +		cmp =3D ovl_strcmp(name, p, len);
>  		if (cmp > 0)
>  			node =3D p->node.rb_right;
>  		else if (cmp < 0 || len < p->len)

--=20
Gabriel Krisman Bertazi

