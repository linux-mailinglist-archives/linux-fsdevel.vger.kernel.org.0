Return-Path: <linux-fsdevel+bounces-24187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0146F93AE65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 11:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75411F24A33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 09:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C909C15251B;
	Wed, 24 Jul 2024 09:16:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35AE136982;
	Wed, 24 Jul 2024 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721812590; cv=none; b=JhacaJAkGHEVjBL+vgqqkEyotAkreF63lPwi2jSRavVfdPGA6q/f4LD7ggiTxoble38i4JUISvuvhCIJjk6mXLp2e7sV9wlBH2NnTDecZfRywdXrBvt1CsBg2WkmZWu4jDxPQ3srobEZ6ES0LVYB561kIT3QmxL3765IFKPsUWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721812590; c=relaxed/simple;
	bh=B+/JsHJlzC4TmerN6ugwJQ7CYgG+ju/HUQuae7jz+f8=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=kKElY2X5yDyF1MdhErt4b6kb2fqVGl4LGo372CX5lyZQA4HFsllSxNUC/vKNVZxCv78Ovla/I6se8RD15+wHZhHNl/rml1OkyVXN8jWcD5NtDbQsY8YcIV1QSOOk6VQmL409+b/AnaKLKGI/WO+Je5mZGkjX+9MSLkHbRCVDPZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 02CBF3780BC2;
	Wed, 24 Jul 2024 09:16:25 +0000 (UTC)
From: "Adrian Ratiu" <adrian.ratiu@collabora.com>
In-Reply-To: <CAHk-=wiJL59WxvyHOuz2ChW+Vi1PTRKJ+w+9E8d1f4QZs9UFcg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240723171753.739971-1-adrian.ratiu@collabora.com> <CAHk-=wiJL59WxvyHOuz2ChW+Vi1PTRKJ+w+9E8d1f4QZs9UFcg@mail.gmail.com>
Date: Wed, 24 Jul 2024 10:16:25 +0100
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, kernel@collabora.com, gbiv@google.com, inglorion@google.com, ajordanr@google.com, "Doug Anderson" <dianders@chromium.org>, "Jeff Xu" <jeffxu@google.com>, "Jann Horn" <jannh@google.com>, "Kees Cook" <kees@kernel.org>, "Christian Brauner" <brauner@kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <27ea5-66a0c680-3-322bfd00@171174474>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?proc=3A?= add config & param to block 
 forcing mem writes
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Tuesday, July 23, 2024 21:30 EEST, Linus Torvalds <torvalds@linux-fo=
undation.org> wrote:

> On Tue, 23 Jul 2024 at 10:18, Adrian Ratiu <adrian.ratiu@collabora.co=
m> wrote:
> >
> > This adds a Kconfig option and boot param to allow removing
> > the FOLL=5FFORCE flag from /proc/pid/mem write calls because
> > it can be abused.
>=20
> Ack, this looks much simpler.
>=20
> That said, I think this can be prettied up some more:
>=20
> > +enum proc=5Fmem=5Fforce=5Fstate {
> > +       PROC=5FMEM=5FFORCE=5FALWAYS,
> > +       PROC=5FMEM=5FFORCE=5FPTRACE,
> > +       PROC=5FMEM=5FFORCE=5FNEVER
> > +};
> > +
> > +#if defined(CONFIG=5FPROC=5FMEM=5FALWAYS=5FFORCE)
> > +static enum proc=5Fmem=5Fforce=5Fstate proc=5Fmem=5Fforce=5Foverri=
de =5F=5Fro=5Fafter=5Finit =3D PROC=5FMEM=5FFORCE=5FALWAYS;
> > +#elif defined(CONFIG=5FPROC=5FMEM=5FFORCE=5FPTRACE)
> > +static enum proc=5Fmem=5Fforce=5Fstate proc=5Fmem=5Fforce=5Foverri=
de =5F=5Fro=5Fafter=5Finit =3D PROC=5FMEM=5FFORCE=5FPTRACE;
> > +#else
> > +static enum proc=5Fmem=5Fforce=5Fstate proc=5Fmem=5Fforce=5Foverri=
de =5F=5Fro=5Fafter=5Finit =3D PROC=5FMEM=5FFORCE=5FNEVER;
> > +#endif
>=20
> I think instead of that forest of #if defined(), we can just do
>=20
>   enum proc=5Fmem=5Fforce {
>         PROC=5FMEM=5FFORCE=5FALWAYS,
>         PROC=5FMEM=5FFORCE=5FPTRACE,
>         PROC=5FMEM=5FFORCE=5FNEVER
>   };
>=20
>   static enum proc=5Fmem=5Fforce proc=5Fmem=5Fforce=5Foverride =5F=5F=
ro=5Fafter=5Finit =3D
>       IS=5FENABLED(CONFIG=5FPROC=5FMEM=5FALWAYS=5FFORCE) ? PROC=5FMEM=
=5FFORCE=5FALWAYS :
>       IS=5FENABLED(CONFIG=5FPROC=5FMEM=5FFORCE=5FPTRACE) ? PROC=5FMEM=
=5FFORCE=5FPTRACE :
>       PROC=5FMEM=5FFORCE=5FNEVER;
>=20
> I also really thought we had some parser helper for this pattern:
>=20
> > +static int =5F=5Finit early=5Fproc=5Fmem=5Fforce=5Foverride(char *=
buf)
> > +{
> > +       if (!buf)
> > +               return -EINVAL;
> > +
> > +       if (strcmp(buf, "always") =3D=3D 0) {
> > +               proc=5Fmem=5Fforce=5Foverride =3D PROC=5FMEM=5FFORC=
E=5FALWAYS;
>  ....
>=20
> but it turns out we only really "officially" have it for filesystem
> superblock parsing.
>=20
> Oh well. We could do
>=20
>   #include <linux/fs=5Fparser.h>
>  ...
>   struct constant=5Ftable proc=5Fmem=5Fforce=5Ftable[] {
>         { "ptrace", PROC=5FMEM=5FFORCE=5FPTRACE },
>         { "never", PROC=5FMEM=5FFORCE=5FNEVER },
>         { }
>   };
>   ...
>   proc=5Fmem=5Fforce=5Foverride =3D lookup=5Fconstant(
>         proc=5Fmem=5Fforce=5Ftable, buf, PROC=5FMEM=5FFORCE=5FNEVER);
>=20
> but while that looks a bit prettier, the whole "fs=5Fparser.h" thing =
is
> admittedly odd.
>=20
> Anyway, I think the patch is ok, although I also happen to think it
> could be a bit prettier.

Thanks again, I am perfectly fine with using fs=5Fparser.h.

I'll wait a few days to give others a chance to review/respond,
then apply your changes and send a v3.

(this was actually v2, however git format-patch removed my
"Changes in v2" blurb and v2 title; will add them next time)


