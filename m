Return-Path: <linux-fsdevel+bounces-29023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D7297391B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 15:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924361F261B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 13:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724FB192B8B;
	Tue, 10 Sep 2024 13:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJImo14G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BA218CBE0
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725976299; cv=none; b=TFLfAI9naOlFNduXLL6s4Rm+LJLG14cXywdaK6tcL4XO29LV7/dW8rkgwJdSjyp9vFEl9biXCh2b1MgSCB2DGLZNseWVg69zLNyRdwKO42WE/6/jkNsJ8EYjtCGrPAzvB24A1slghbLBoj4iXaBmLHSu5Hm4V5DR20W6dXGsWkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725976299; c=relaxed/simple;
	bh=HKRM6pfTQbJNkmKdINLi0KaVoAkaWfUGtxppquLoIKY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cRvF4Sy5Vgg3tJMN8P19gppJdpvFU+bnG3a2GOrVBHxD9n0QKHZ2FTPTJKJ5b9V/MtEHsIK+Xdagv+EsXwjjO6N1izGK/ly5/HU4lu2lpZiAOxUbW8snCug8nveMDvuYoyciNQIAEzfmtvcV8+asZsn1oKVjEKJzKwSOXW+eYKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJImo14G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5971C4CEC3;
	Tue, 10 Sep 2024 13:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725976299;
	bh=HKRM6pfTQbJNkmKdINLi0KaVoAkaWfUGtxppquLoIKY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=qJImo14Gd74g6Rv8A+O81RN8wnHLXRuVaZG2mTjaSNOO1O3r8lFLlrMf2torr5ss6
	 v35tlSf8XQUDyg/fXfoFKwelhuZN+TF3r7h/mMJ/uRyPh+/LP1Dy4VHUGwocwCLuGp
	 K/E7qFxVwctaGhaPRefGu48T1Qv/y/73x18WoKvCV6qvzNmCiQ9n5Dea5dhvYKiiMm
	 fLFC1LgWsgUg0+snKgoTfl3BAV7fhlQRjCBX/kPgHm5MsNZu0ljFcWrklo3FZH6lWk
	 pJlt/NtSll1THTKpMFBK9yn/ssV9IxCi3wWb2Z6IvLYAb1zSy9XsuIWkNRcFKU9NfO
	 mvL3rpOihQ21w==
Message-ID: <80c0e982a5a55f6c0a0eeb4e717b9fc32d93de3f.camel@kernel.org>
Subject: Re: [PATCH] uidgid: make sure we fit into one cacheline
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, Amir Goldstein
	 <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>
Date: Tue, 10 Sep 2024 09:51:37 -0400
In-Reply-To: <20240910-work-uid_gid_map-v1-1-e6bc761363ed@kernel.org>
References: <20240910-work-uid_gid_map-v1-1-e6bc761363ed@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-09-10 at 10:16 +0200, Christian Brauner wrote:
> When I expanded uidgid mappings I intended for a struct uid_gid_map to
> fit into a single cacheline on x86 as they tend to be pretty
> performance sensitive (idmapped mounts etc). But a 4 byte hole was added
> that brought it over 64 bytes. Fix that by adding the static extent
> array and the extent counter into a substruct. C's type punning for
> unions guarantees that we can access ->nr_extents even if the last
> written to member wasn't within the same object. This is also what we
> rely on in struct_group() and friends. This of course relies on
> non-strict aliasing which we don't do.
>=20
> 99) If the member used to read the contents of a union object is not the
>     same as the member last used to store a value in the object, the
>     appropriate part of the object representation of the value is
>     reinterpreted as an object representation in the new type as
>     described in 6.2.6 (a process sometimes called "type punning").
>=20
> Link: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2310.pdf
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> Before:
>=20
> struct uid_gid_map {
>         u32                        nr_extents;           /*     0     4 *=
/
>=20
>         /* XXX 4 bytes hole, try to pack */
>=20
>         union {
>                 struct uid_gid_extent extent[5];         /*     8    60 *=
/
>                 struct {
>                         struct uid_gid_extent * forward; /*     8     8 *=
/
>                         struct uid_gid_extent * reverse; /*    16     8 *=
/
>                 };                                       /*     8    16 *=
/
>         };                                               /*     8    64 *=
/
>=20
>         /* size: 72, cachelines: 2, members: 2 */
>         /* sum members: 68, holes: 1, sum holes: 4 */
>         /* last cacheline: 8 bytes */
> };
>=20
> After:
>=20
> struct uid_gid_map {
>         union {
>                 struct {
>                         struct uid_gid_extent extent[5]; /*     0    60 *=
/
>                         u32        nr_extents;           /*    60     4 *=
/
>                 };                                       /*     0    64 *=
/
>                 struct {
>                         struct uid_gid_extent * forward; /*     0     8 *=
/
>                         struct uid_gid_extent * reverse; /*     8     8 *=
/
>                 };                                       /*     0    16 *=
/
>         };                                               /*     0    64 *=
/
>=20
>         /* size: 64, cachelines: 1, members: 1 */
> };
> ---
>  include/linux/user_namespace.h | 6 ++++--
>  kernel/user.c                  | 6 +++---
>  2 files changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespac=
e.h
> index 6030a8235617..3625096d5f85 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -21,9 +21,11 @@ struct uid_gid_extent {
>  };
> =20
>  struct uid_gid_map { /* 64 bytes -- 1 cache line */
> -	u32 nr_extents;
>  	union {
> -		struct uid_gid_extent extent[UID_GID_MAP_MAX_BASE_EXTENTS];
> +		struct {
> +			struct uid_gid_extent extent[UID_GID_MAP_MAX_BASE_EXTENTS];
> +			u32 nr_extents;
> +		};

Is this any different from just moving nr_extents to the end of
struct_uid_gid_map? I don't quite get how moving it into the union
improves things.

>  		struct {
>  			struct uid_gid_extent *forward;
>  			struct uid_gid_extent *reverse;
> diff --git a/kernel/user.c b/kernel/user.c
> index aa1162deafe4..f46b1d41163b 100644
> --- a/kernel/user.c
> +++ b/kernel/user.c
> @@ -36,33 +36,33 @@ EXPORT_SYMBOL_GPL(init_binfmt_misc);
>   */
>  struct user_namespace init_user_ns =3D {
>  	.uid_map =3D {
> -		.nr_extents =3D 1,
>  		{
>  			.extent[0] =3D {
>  				.first =3D 0,
>  				.lower_first =3D 0,
>  				.count =3D 4294967295U,
>  			},
> +			.nr_extents =3D 1,
>  		},
>  	},
>  	.gid_map =3D {
> -		.nr_extents =3D 1,
>  		{
>  			.extent[0] =3D {
>  				.first =3D 0,
>  				.lower_first =3D 0,
>  				.count =3D 4294967295U,
>  			},
> +			.nr_extents =3D 1,
>  		},
>  	},
>  	.projid_map =3D {
> -		.nr_extents =3D 1,
>  		{
>  			.extent[0] =3D {
>  				.first =3D 0,
>  				.lower_first =3D 0,
>  				.count =3D 4294967295U,
>  			},
> +			.nr_extents =3D 1,
>  		},
>  	},
>  	.ns.count =3D REFCOUNT_INIT(3),
>=20
> ---
> base-commit: 698e7d1680544ef114203b0cf656faa0c1216ebc
> change-id: 20240910-work-uid_gid_map-cce46aee1b76
>=20


Jeff Layton <jlayton@kernel.org>

