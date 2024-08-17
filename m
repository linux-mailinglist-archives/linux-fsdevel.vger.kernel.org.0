Return-Path: <linux-fsdevel+bounces-26178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 320AA955668
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 10:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F3E1C20BFB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 08:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0584A14534A;
	Sat, 17 Aug 2024 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4qRGs68"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D1883A06;
	Sat, 17 Aug 2024 08:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723883944; cv=none; b=Tb5ZN1o4hVdGBeyU2c9N0EpHk7K7x7iLQyUqAUAXqX/cx3IZ9iVDUinkqPzqvT5AMBhvS0VlgJXlNjRcW9Ne+VKO9TQfBZfUIiCbpUaRJ87X4OaU7fFaLFQ74aZZtrhDYDWw2otl0/IyIx10OsNnKx+2ibLvSjVAXoTB4n+c0ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723883944; c=relaxed/simple;
	bh=drcR0Ggvob9Xsaq04tuibw0a3w723D1cXfmcavnp7v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7BwKmLHyHTYMfLYBG633ylyJqnndLX6ON95yyfoQNUdtZvcAbYVUDP9dXtEgxYhwmOXVx5mONVcbxdKZPpVWaQou0Go+aQryP0nuw2Ou5eeQo12tmf4eDrg+8263elIfIcxNF1Pk+pdz1c5+WQmMjCXtmNBT3EAmDEagSVivYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4qRGs68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30869C116B1;
	Sat, 17 Aug 2024 08:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723883943;
	bh=drcR0Ggvob9Xsaq04tuibw0a3w723D1cXfmcavnp7v8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X4qRGs68mHWdMwsIm8IcqoC0AjlA9unRAZyZItSaeap7PHizirk/hNNBeXaBbSGyi
	 8TXQAjPdxFfBxyi7yYHq6mqApaR7yxkD08nUzjQj/awldhvM9VJr1i07GxDJn/8scG
	 h28lmq1aJ4tliJZ6C4qTmJbhnufQdVSICkHH28rbualNjCN+dMGOAKFWA7bYRML9Dp
	 zwk6+UUbpp+JiZxIrb3mn6+4/C5QLDZrwDqVugy8N3Q+dWQyhmirfyEUCVdCO3dsJH
	 B0bz++Fwz+qpQzZ2Ia9SU0OIHOlNdgLk+3ah1rTJqAY9M7W4pASoQ/+TjDqoROGXH3
	 JeShGAxlHtFsQ==
Date: Sat, 17 Aug 2024 10:38:58 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, 
	justinstitt@google.com, ebiederm@xmission.com, alexei.starovoitov@gmail.com, 
	rostedt@goodmis.org, catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH v7 4/8] bpftool: Ensure task comm is always NUL-terminated
Message-ID: <teajtay63uw2ukcwhna7yfblnjeyrppw4zcx2dfwtdz3tapspn@rntw3luvstci>
References: <20240817025624.13157-1-laoar.shao@gmail.com>
 <20240817025624.13157-5-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="psoj2t3rvkbpqmnp"
Content-Disposition: inline
In-Reply-To: <20240817025624.13157-5-laoar.shao@gmail.com>


--psoj2t3rvkbpqmnp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, 
	justinstitt@google.com, ebiederm@xmission.com, alexei.starovoitov@gmail.com, 
	rostedt@goodmis.org, catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH v7 4/8] bpftool: Ensure task comm is always NUL-terminated
References: <20240817025624.13157-1-laoar.shao@gmail.com>
 <20240817025624.13157-5-laoar.shao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20240817025624.13157-5-laoar.shao@gmail.com>

Hi Yafang,

On Sat, Aug 17, 2024 at 10:56:20AM GMT, Yafang Shao wrote:
> Let's explicitly ensure the destination string is NUL-terminated. This wa=
y,
> it won't be affected by changes to the source string.
>=20
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Reviewed-by: Quentin Monnet <qmo@kernel.org>
> ---
>  tools/bpf/bpftool/pids.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
> index 9b898571b49e..23f488cf1740 100644
> --- a/tools/bpf/bpftool/pids.c
> +++ b/tools/bpf/bpftool/pids.c
> @@ -54,6 +54,7 @@ static void add_ref(struct hashmap *map, struct pid_ite=
r_entry *e)
>  		ref =3D &refs->refs[refs->ref_cnt];
>  		ref->pid =3D e->pid;
>  		memcpy(ref->comm, e->comm, sizeof(ref->comm));
> +		ref->comm[sizeof(ref->comm) - 1] =3D '\0';

Why doesn't this use strscpy()?  Isn't the source terminated?

Both the source and the destination measure 16 characters.  If it is
true that the source is not terminated, then this copy might truncate
the (non-)string by overwriting the last byte with a NUL.  Is that
truncation a good thing?

>  		refs->ref_cnt++;
> =20
>  		return;
> @@ -77,6 +78,7 @@ static void add_ref(struct hashmap *map, struct pid_ite=
r_entry *e)
>  	ref =3D &refs->refs[0];
>  	ref->pid =3D e->pid;
>  	memcpy(ref->comm, e->comm, sizeof(ref->comm));
> +	ref->comm[sizeof(ref->comm) - 1] =3D '\0';

Same question here.

>  	refs->ref_cnt =3D 1;
>  	refs->has_bpf_cookie =3D e->has_bpf_cookie;
>  	refs->bpf_cookie =3D e->bpf_cookie;
> --=20
> 2.43.5
>=20

--=20
<https://www.alejandro-colomar.es/>

--psoj2t3rvkbpqmnp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmbAYZwACgkQnowa+77/
2zKmIA/9Gqjb53CpMspqZM8sUUCdmGhqPv1cYcL2EDkg7W9lkRgn0GLudREK/roq
y4QBmGljgAhm3UbecLPiKvAPtiYmGoOmndrjJ4mq8E6lSqkMjHoaiMZ2EEPI7u+p
xPTHJklCQHIAndCjVjC7A4cIx2RZuBtx6Xg/JMgO7i/s0jtb2SqiQtXEEIHjuUd5
q0YybNl407qq/IRSt72qEL+rKEBVdcZppyDfoxPVKEZYOgbmhYpyyViq6Rli9HhU
loprXpAdwiumkNZQHJ7It8nXlC5/J3VDuazDN193PNRprMfzC5TjBpWezf+KY7Wn
Vx5tAC4H6ZTNdhD5a+NwfaApt9xqOcRVaYe2E1m1dMfIgojmUvJYd4zcRZBYRE5M
uhQxkrRLueuJoKeqVcIlbPRTafIUd6lev0ccKam+Ao9J5Nt4TmqAUMyYIOymQ90B
ldUgSSiofzyioNhrKNS1mLBCOVjTKClEBH+rbjKfO7KLf6Qo2dtvLoOCC5f7YZvy
k9GsCv9jGEF64bGdcK82pM+LjftAWuTbO3Uwlw7qUNDKJb7OWjQS5BtejgQpiOh6
RB4z4wZkDZ/Skwke7F16AsEeMugdcRyD1Wyl4paqcw8sXhc1AquvuymC6OPV5u8z
GZt0uJeVRKbg7CVQEny1jGFO8BiPLK6JzTHLRV3KRlTKCGc5vEY=
=fb44
-----END PGP SIGNATURE-----

--psoj2t3rvkbpqmnp--

