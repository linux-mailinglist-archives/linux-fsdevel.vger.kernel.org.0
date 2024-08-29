Return-Path: <linux-fsdevel+bounces-27708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989AB9636DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 02:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE2B1C215DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 00:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75655E57D;
	Thu, 29 Aug 2024 00:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4lHRAJg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0099474;
	Thu, 29 Aug 2024 00:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724891107; cv=none; b=uKy12cj72ZObc5AXxE2CknTLbrALmshn/1xpOh8XvDZ+1x2RqNn8mAtslBUJq6BWkX+AuyuHDmzgvgMBXFE8WnkuifbIbRWPkzLD7c7lArm90iB5ZEIQ+ookc7HYwjU6t68UaatoXdr24QsFt89Rwcd9CCOltEAz7rtq43h8bA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724891107; c=relaxed/simple;
	bh=nCM8XvqCff53EEr64RnHMSHTUq4K5/SJ/d7fShpXRWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeya4sFpWSYXo65Huz9yXThz9K943E000DOU76vXAxhMojMRKC7EQGWm8EY6IgOxM908Achf6eY41dFlivI7chHFlOvOVU0A830s5wiutWxYi7DhV/JMxcwRtNyajp96HUFuQyAh7goBmQbufcILa/8CT6jxlGuntFvWE3JPRqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4lHRAJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C767C4CEC0;
	Thu, 29 Aug 2024 00:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724891107;
	bh=nCM8XvqCff53EEr64RnHMSHTUq4K5/SJ/d7fShpXRWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B4lHRAJg6X7XqkRKlrJ+YCiTKqMVqdBCKwXygNvBCntYpT5Vq6fZbbC+Nl0QovgDE
	 BFcwORztl1ocSysdnEElSTbXDVJQ9CxTFxF+BSpUYXYJtMKiShrT5IEZ1V38H8RA6N
	 Hf/pEQMJVXY5VRKwDto8lQoZMKdmlkI5keOQcIeRZZGqi8FY16e8TvC2FYJQmAJuYW
	 yf/9525rDiO7baZJw4ny+zdrGylPp6H1khY2PrsBSc200YRIlkH5k14t2QGtrQI5BA
	 HkIXGqgoBXNSYKoma2iEL73nWmWUkWMtVdW2JxHb5ffcxRp0a7mDeklktF8oiSQ0S3
	 MQmp6Wq+CgrJQ==
Date: Thu, 29 Aug 2024 02:25:00 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, 
	torvalds@linux-foundation.org, justinstitt@google.com, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, catalin.marinas@arm.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matus Jokay <matus.jokay@stuba.sk>, 
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v8 1/8] Get rid of __get_task_comm()
Message-ID: <q6xvpwqj7dkgu2cay5mgahscfgdwu2ohzxs7xd3nw3xa622sh4@u35topnxx36b>
References: <20240828030321.20688-1-laoar.shao@gmail.com>
 <20240828030321.20688-2-laoar.shao@gmail.com>
 <lql4y2nvs3ewadszhmv4m6fnqja4ff4ymuurpidlwvgf4twvru@esnh37a2jxbd>
 <n2fxqs3tekvljezaqpfnwhsmjymch4vb47y744zwmy7urf3flv@zvjtepkem4l7>
 <CALOAHbBAYHjDnKBVw63B8JBFc6U-2RNUX9L=ryA2Gbz7nnJfsQ@mail.gmail.com>
 <7839453E-CA06-430A-A198-92EB906F94D9@kernel.org>
 <ynrircglkinhherehtjz7woq55te55y4ol4rtxhfh75pvle3d5@uxp5esxt4slq>
 <202408281712.F78440FF@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o6w5uwkuyqtfps7p"
Content-Disposition: inline
In-Reply-To: <202408281712.F78440FF@keescook>


--o6w5uwkuyqtfps7p
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, 
	torvalds@linux-foundation.org, justinstitt@google.com, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, catalin.marinas@arm.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matus Jokay <matus.jokay@stuba.sk>, 
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v8 1/8] Get rid of __get_task_comm()
References: <20240828030321.20688-1-laoar.shao@gmail.com>
 <20240828030321.20688-2-laoar.shao@gmail.com>
 <lql4y2nvs3ewadszhmv4m6fnqja4ff4ymuurpidlwvgf4twvru@esnh37a2jxbd>
 <n2fxqs3tekvljezaqpfnwhsmjymch4vb47y744zwmy7urf3flv@zvjtepkem4l7>
 <CALOAHbBAYHjDnKBVw63B8JBFc6U-2RNUX9L=ryA2Gbz7nnJfsQ@mail.gmail.com>
 <7839453E-CA06-430A-A198-92EB906F94D9@kernel.org>
 <ynrircglkinhherehtjz7woq55te55y4ol4rtxhfh75pvle3d5@uxp5esxt4slq>
 <202408281712.F78440FF@keescook>
MIME-Version: 1.0
In-Reply-To: <202408281712.F78440FF@keescook>

Hi Kees,

On Wed, Aug 28, 2024 at 05:17:55PM GMT, Kees Cook wrote:
> On Wed, Aug 28, 2024 at 05:09:08PM +0200, Alejandro Colomar wrote:
> > Hi Kees,
> >=20
> > On Wed, Aug 28, 2024 at 06:48:39AM GMT, Kees Cook wrote:
> >=20
> > [...]
> >=20
> > > >Thank you for your suggestion. How does the following commit log look
> > > >to you? Does it meet your expectations?
> > > >
> > > >    string: Use ARRAY_SIZE() in strscpy()
> > > >
> > > >    We can use ARRAY_SIZE() instead to clarify that they are regular=
 characters.
> > > >
> > > >    Co-developed-by: Alejandro Colomar <alx@kernel.org>
> > > >    Signed-off-by: Alejandro Colomar <alx@kernel.org>
> > > >    Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > >
> > > >diff --git a/arch/um/include/shared/user.h b/arch/um/include/shared/=
user.h
> > > >index bbab79c0c074..07216996e3a9 100644
> > > >--- a/arch/um/include/shared/user.h
> > > >+++ b/arch/um/include/shared/user.h
> > > >@@ -14,7 +14,7 @@
> > > >  * copying too much infrastructure for my taste, so userspace files
> > > >  * get less checking than kernel files.
> > > >  */
> > > >-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> > > >+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]) + __must_be_array=
(x))
> > > >
> > > > /* This is to get size_t and NULL */
> > > > #ifndef __UM_HOST__
> > > >@@ -60,7 +60,7 @@ static inline void print_hex_dump(const char *leve=
l,
> > > >const char *prefix_str,
> > > > extern int in_aton(char *str);
> > > > extern size_t strlcat(char *, const char *, size_t);
> > > > extern size_t sized_strscpy(char *, const char *, size_t);
> > > >-#define strscpy(dst, src)      sized_strscpy(dst, src, sizeof(dst))
> > > >+#define strscpy(dst, src)      sized_strscpy(dst, src, ARRAY_SIZE(d=
st))
> > >=20
> > > Uh, but why? strscpy() copies bytes, not array elements. Using sizeof=
() is already correct and using ARRAY_SIZE() could lead to unexpectedly sma=
ll counts (in admittedly odd situations).
> > >=20
> > > What is the problem you're trying to solve here?
> >=20
> > I suggested that here:
> > <https://lore.kernel.org/all/2jxak5v6dfxlpbxhpm3ey7oup4g2lnr3ueurfbosf5=
wdo65dk4@srb3hsk72zwq/>
> >=20
> > There, you'll find the rationale (and also for avoiding the _pad calls
> > where not necessary --I ignore if it's necessary here--).
>=20
> Right, so we only use byte strings for strscpy(), so sizeof() is
> sufficient. There's no technical need to switch to ARRAY_SIZE(), and I'd
> like to minimize any changes to such core APIs without a good reason.

Makes sense.  My original proposal was ignoring that the wrapper was
already using __must_be_array().  Having already sizeof() +
__must_be_array(), I'd leave it like that, since both do effectively the
same.

> And for the _pad change, we are also doing strncpy() replacement via
> case-by-case analysis, but with a common function like get_task_comm(),
> I don't want to change the behavior without a complete audit of the
> padding needs of every caller.

Agree.  I had the same problem with shadow.  Removing padding was the
worst part, because it was hard to justify that nothing was relying on
the padding.

> Since that's rather a lot for this series,
> I'd rather we just leave the existing behavior as-is, and if padding
> removal is wanted after that, we can do it on a case-by-case basis then.
>=20
> -Kees

Have a lovely night!
Alex

>=20
> --=20
> Kees Cook

--=20
<https://www.alejandro-colomar.es/>

--o6w5uwkuyqtfps7p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmbPv9wACgkQnowa+77/
2zLmfhAAqsMngDf8es0F6qRd7cwzD5RwLYJ8tk1KfFfVJjLJN6kb3mV29YiA0pl7
LsZlkqQ/rmDcqE2Ex9UoiAlIrJw154+Dg63MqkrOYnXf3vDpMopi4jtGlBSG3cJn
Jm9toPA7lNWwiDe6q19RzLraVFl4+t2ik2wUWtC+SYxBN/vFkU0CRQqwbSg78DMJ
S3ZIJfLKdkkSeSV9wbddJTwtolje98WEKLtGxbnc7urnmtlvIFqcYACYe9MGVeqf
kuq//H0SGfCjVEpzizecG93wlp5B2q1Q1sulb1l7mj5rfgaaNE/NilFGv7y/+GwY
zEyhm6rEjbWZjsh1PxuofuN4ftlJyqlpioondQryrcE370W1Ugfcac6oP5t8ornD
pdjU1JgIVwY+3Nug3vBKggFwOuy3aQOYP2s6E06KnDEP7GYY1xpzVE6WRbPPzO/T
FNisBNfvY1FE9M09QiaSkbbePpvTbvYK3RSR7goiKWRMj7gB5NyTuimpZX4Z3Hxa
y190DotOM8xuALV0EQnx/2quq2+GgT0+N2Et4UdB0U9ENq0X8hAcYYtF1MGnOsCj
cn3A+JU5VJjLEkFyLF9g9j2dimru4mnxyT7IKtO0NqPjEb7R7TLQPWA1yqwt0Sfm
pf5ipWUVNTfZ/CEKirXNhGKFwGyva449J3Pu8od1GEbyS8yEj7Q=
=UqVz
-----END PGP SIGNATURE-----

--o6w5uwkuyqtfps7p--

