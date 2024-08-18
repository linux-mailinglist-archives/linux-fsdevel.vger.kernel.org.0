Return-Path: <linux-fsdevel+bounces-26204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF018955BED
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2024 10:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70993B21202
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2024 08:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A350717C79;
	Sun, 18 Aug 2024 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHZkHNV5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD964134B2;
	Sun, 18 Aug 2024 08:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723969537; cv=none; b=dB7Ouxn84zDLYwo7sCHwGLv2g3MaQCnknqf47H4XFAd1tvSgg6jctY71rXr1YxQscgnwz4d3VNspW197zPgkhkK847KeaD9Vg07RtB7P2POPvlYenX/tFQXb1vszhjAjtNQaKYqtH8/XdQMToQ1nM+ww4qECY6o3Iyx4Sj0Vacw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723969537; c=relaxed/simple;
	bh=HNPlU0M/3vqiQI+da9DTWN8QwJm2bLjTnAaFdwzaWig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPttER1GaWchJ4kvblETLq+25BF4I2PXCI0HeMjCyrUXpZ+FYvTy+zSoXufvpk6/JY6E44icWs+FS1+V4BJqqTGXlSNEhqK/LstB4YFBj+IjOQpMPHl4zlWtIjZVoYGR5pGrDhNg2hZOwbeTs2ZtYi9D8tknvQTLK9XHOoeZylk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHZkHNV5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79F9C32786;
	Sun, 18 Aug 2024 08:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723969536;
	bh=HNPlU0M/3vqiQI+da9DTWN8QwJm2bLjTnAaFdwzaWig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vHZkHNV5oUFehXU9H208C3BbvikBh69Map7MNwYhsAz/H+RCy1qVmhkneBJXg6XjJ
	 A4yHeH0HSJKwxa7FLYPOTmemN1bnz5cRIh6lcVsrPvla+TthtasHx5rjtn8C4jsDQk
	 yFp0s7cOZozpGsEjAghDarTvbyerVUBwdhHxnSfOD9KlTBerTrANtAUJssjdzPrjNl
	 EhSD2ZYUuJmNQNe1xBJ/twr+KdnK0XkPc9svL3TfLFPiHpoxVJoRf5gEij63/YgQR2
	 vdZEieAN5ajY1WQBCTOuo56n3Dt/ZdoRgYqRpXRd3S9XddtW7UgbZC41BpdvWHqRIm
	 XHhHkzQ8KNsPg==
Date: Sun, 18 Aug 2024 10:25:30 +0200
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
Message-ID: <gmhyl3zdnxy6q2tn5wtasqbuhxpfbejmh7qxeuk7lnbhcdlfsc@b3b56vgdrzgm>
References: <20240817025624.13157-1-laoar.shao@gmail.com>
 <20240817025624.13157-5-laoar.shao@gmail.com>
 <teajtay63uw2ukcwhna7yfblnjeyrppw4zcx2dfwtdz3tapspn@rntw3luvstci>
 <CALOAHbAzSAQMtts5x+OMDDy1ZY5icUJv2wAM5w74ffhtEbN1mQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bqpbjdxuldrazcxq"
Content-Disposition: inline
In-Reply-To: <CALOAHbAzSAQMtts5x+OMDDy1ZY5icUJv2wAM5w74ffhtEbN1mQ@mail.gmail.com>


--bqpbjdxuldrazcxq
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
 <teajtay63uw2ukcwhna7yfblnjeyrppw4zcx2dfwtdz3tapspn@rntw3luvstci>
 <CALOAHbAzSAQMtts5x+OMDDy1ZY5icUJv2wAM5w74ffhtEbN1mQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CALOAHbAzSAQMtts5x+OMDDy1ZY5icUJv2wAM5w74ffhtEbN1mQ@mail.gmail.com>

Hi Yafang,

On Sun, Aug 18, 2024 at 10:27:01AM GMT, Yafang Shao wrote:
> On Sat, Aug 17, 2024 at 4:39=E2=80=AFPM Alejandro Colomar <alx@kernel.org=
> wrote:
> >
> > Hi Yafang,
> >
> > On Sat, Aug 17, 2024 at 10:56:20AM GMT, Yafang Shao wrote:
> > > Let's explicitly ensure the destination string is NUL-terminated. Thi=
s way,
> > > it won't be affected by changes to the source string.
> > >
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > Reviewed-by: Quentin Monnet <qmo@kernel.org>
> > > ---
> > >  tools/bpf/bpftool/pids.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
> > > index 9b898571b49e..23f488cf1740 100644
> > > --- a/tools/bpf/bpftool/pids.c
> > > +++ b/tools/bpf/bpftool/pids.c
> > > @@ -54,6 +54,7 @@ static void add_ref(struct hashmap *map, struct pid=
_iter_entry *e)
> > >               ref =3D &refs->refs[refs->ref_cnt];
> > >               ref->pid =3D e->pid;
> > >               memcpy(ref->comm, e->comm, sizeof(ref->comm));
> > > +             ref->comm[sizeof(ref->comm) - 1] =3D '\0';
> >
> > Why doesn't this use strscpy()?
>=20
> bpftool is a userspace tool, so strscpy() is only applicable in kernel
> code, correct?

Ahh, makes sense.  LGTM, then.  Maybe the closest user-space function to
strscpy(9) would be strlcpy(3), but I don't know how old of a glibc you
support.  strlcpy(3) is currently in POSIX, and supported by both glibc
and musl, but that's too recent.

Have a lovely day!
Alex

> --
> Regards
> Yafang

--=20
<https://www.alejandro-colomar.es/>

--bqpbjdxuldrazcxq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmbBr/oACgkQnowa+77/
2zKlWg//bIam9Z2S2oGYdx1Es2yhqgRhsYrxX1OVGAonZ9d+7XaXBTpsSjfcy8AT
EqipznL0pk8B0uQ+sagT8w6h0H2StHg59E+gR4M8YKp5s/X6Rhq+aim+k19Qh53S
afYHd+jfvzFBe1dXQXm5Pe80X1ncmIcISMqXh/O3ykzqpuPWanKo4torJlbqtXMM
yGxL8yJu15D00/cwjEwT9mh7KB9zsmVNyHPiY3aTvtjd0F/tNlP9qvnxgi+81duU
ciTElwVWSG14g9TcDFWHkNBarUuBiHe240JQE7ARDPJmPkZrzHo6GcpC4AdydU6Q
yvA/1Hp4dCFLoiXspmTWmAyR3Q+Nnn1wetdU555oIpEhYk+dpgAdO1MAYOJ+izdh
f71cefEGfG60FG0tkzgwkbpa4xPUaCEi5L/5Voms4yRIoj5eYvmQs0+/N8IM2Fbk
HSLIjf+5YiMw0SycNUP0XKFZGJ2MbXU8c+MBM4pTwfl4MFhgVPvI53j0J+5D43x8
AgvgLJ3kp44JOC+FoeCDgraJ7ZD5nasDl1YBaNUS7lCxAAJ80V4CMWzi9kX0YOrG
HRB6XOquSAF0pGarE6FLeKCmwKRTcsrDTrVPRgkrHgxt/lYqJJFnaWY1lLKDQViF
zUzZFqndM8ocPo0p3o645SxxtVDEvxgJolM+5sdOdjqMKUmKg+U=
=rl7R
-----END PGP SIGNATURE-----

--bqpbjdxuldrazcxq--

