Return-Path: <linux-fsdevel+bounces-27598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B70EE962B58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 17:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A7D2866E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 15:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E5A1A3BB3;
	Wed, 28 Aug 2024 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzX2mLfI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993741891AC;
	Wed, 28 Aug 2024 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724857755; cv=none; b=ecjiVYLEV6kDp841C4eq/OSj5O50VqD+XWXqdpcCl6i5yiZjDRkq0myLNS6jILxlao7dGCpdrL2sDm3RY1EAt75MA6JkbkmjTcr/dn70JxY9IPNZpzz5bQ0fG7J2hBpeOnhLEJLRUAZaeFS2J/MTTJ5QRydrods96FYfKf4grGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724857755; c=relaxed/simple;
	bh=2dSGJx9DwCGU9inaMNC9w/ZuZvcpZXpFhNbyIbDXFXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HM9vWhQm8Db/vZumyL9kYmuyu7y9Lmz7/y2dETXiVKeGhMr1fdAFE+O8SNWXAiozocsdm8OeOyum3MSCitz7S4Ob/s7q4hiw6rc0k3SSE91XPALYkyYLYPZIRWscz1ytP+nMUvuCkj8b6L3AeMo5Og/21qQJEy7Zvj6gh98HuDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzX2mLfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B325CC4CEC1;
	Wed, 28 Aug 2024 15:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724857755;
	bh=2dSGJx9DwCGU9inaMNC9w/ZuZvcpZXpFhNbyIbDXFXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MzX2mLfIg6MsGjolLr+V4iGnkKTQUdjm/EaJhLDbZvuJ66i2qkoGxZkO0ahAeXSdZ
	 w0oCrFV6JtXAsleAblrSSNSVD9dFHJ0vrg3QkfqAS1/8U20Rzb14APD9K3tmZDJ6GK
	 CR4Dl1yuEAannx47U0uCzgYJILYF9LdXJXWNUfl7nNIE49/dESf9Abd7xAUmTxni17
	 nc95Xa/TzQiWQ+tq/H0ZbZrk7Htb3mVLOLBSQS2h3kJfVSREuRRDhSrxAxG8RtEwvG
	 8Yo853oQ5RDwkuAxKSPdqth8jdfeROhvvFlts3CkhJ2C/SW9eezgX8my3EQlKOcR+8
	 iHTOc/MxGSYRg==
Date: Wed, 28 Aug 2024 17:09:08 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, 
	torvalds@linux-foundation.org, justinstitt@google.com, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, catalin.marinas@arm.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>, 
	Matus Jokay <matus.jokay@stuba.sk>, "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v8 1/8] Get rid of __get_task_comm()
Message-ID: <ynrircglkinhherehtjz7woq55te55y4ol4rtxhfh75pvle3d5@uxp5esxt4slq>
References: <20240828030321.20688-1-laoar.shao@gmail.com>
 <20240828030321.20688-2-laoar.shao@gmail.com>
 <lql4y2nvs3ewadszhmv4m6fnqja4ff4ymuurpidlwvgf4twvru@esnh37a2jxbd>
 <n2fxqs3tekvljezaqpfnwhsmjymch4vb47y744zwmy7urf3flv@zvjtepkem4l7>
 <CALOAHbBAYHjDnKBVw63B8JBFc6U-2RNUX9L=ryA2Gbz7nnJfsQ@mail.gmail.com>
 <7839453E-CA06-430A-A198-92EB906F94D9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="utmrbzzw4vz6dwo3"
Content-Disposition: inline
In-Reply-To: <7839453E-CA06-430A-A198-92EB906F94D9@kernel.org>


--utmrbzzw4vz6dwo3
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
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>, 
	Matus Jokay <matus.jokay@stuba.sk>, "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v8 1/8] Get rid of __get_task_comm()
References: <20240828030321.20688-1-laoar.shao@gmail.com>
 <20240828030321.20688-2-laoar.shao@gmail.com>
 <lql4y2nvs3ewadszhmv4m6fnqja4ff4ymuurpidlwvgf4twvru@esnh37a2jxbd>
 <n2fxqs3tekvljezaqpfnwhsmjymch4vb47y744zwmy7urf3flv@zvjtepkem4l7>
 <CALOAHbBAYHjDnKBVw63B8JBFc6U-2RNUX9L=ryA2Gbz7nnJfsQ@mail.gmail.com>
 <7839453E-CA06-430A-A198-92EB906F94D9@kernel.org>
MIME-Version: 1.0
In-Reply-To: <7839453E-CA06-430A-A198-92EB906F94D9@kernel.org>

Hi Kees,

On Wed, Aug 28, 2024 at 06:48:39AM GMT, Kees Cook wrote:

[...]

> >Thank you for your suggestion. How does the following commit log look
> >to you? Does it meet your expectations?
> >
> >    string: Use ARRAY_SIZE() in strscpy()
> >
> >    We can use ARRAY_SIZE() instead to clarify that they are regular cha=
racters.
> >
> >    Co-developed-by: Alejandro Colomar <alx@kernel.org>
> >    Signed-off-by: Alejandro Colomar <alx@kernel.org>
> >    Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> >
> >diff --git a/arch/um/include/shared/user.h b/arch/um/include/shared/user=
=2Eh
> >index bbab79c0c074..07216996e3a9 100644
> >--- a/arch/um/include/shared/user.h
> >+++ b/arch/um/include/shared/user.h
> >@@ -14,7 +14,7 @@
> >  * copying too much infrastructure for my taste, so userspace files
> >  * get less checking than kernel files.
> >  */
> >-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> >+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]) + __must_be_array(x))
> >
> > /* This is to get size_t and NULL */
> > #ifndef __UM_HOST__
> >@@ -60,7 +60,7 @@ static inline void print_hex_dump(const char *level,
> >const char *prefix_str,
> > extern int in_aton(char *str);
> > extern size_t strlcat(char *, const char *, size_t);
> > extern size_t sized_strscpy(char *, const char *, size_t);
> >-#define strscpy(dst, src)      sized_strscpy(dst, src, sizeof(dst))
> >+#define strscpy(dst, src)      sized_strscpy(dst, src, ARRAY_SIZE(dst))
>=20
> Uh, but why? strscpy() copies bytes, not array elements. Using sizeof() i=
s already correct and using ARRAY_SIZE() could lead to unexpectedly small c=
ounts (in admittedly odd situations).
>=20
> What is the problem you're trying to solve here?

I suggested that here:
<https://lore.kernel.org/all/2jxak5v6dfxlpbxhpm3ey7oup4g2lnr3ueurfbosf5wdo6=
5dk4@srb3hsk72zwq/>

There, you'll find the rationale (and also for avoiding the _pad calls
where not necessary --I ignore if it's necessary here--).

Have a lovely day!
Alex

>=20
> -Kees
>=20
> --=20
> Kees Cook

--=20
<https://www.alejandro-colomar.es/>

--utmrbzzw4vz6dwo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmbPPZQACgkQnowa+77/
2zLbhBAAlmo97hSALOMFZhNvjtiifi8OS3Fmi4WyEj8YDnX4pfh+3drVAhe2b44u
nrvjsBMEM1AHDiXa+gp3sUheR3N1kFuX1oyxlPsb9crUH3IfubT4kG0tQ6qLqE8M
Tv0OfPWGdqeGMgvvTEiQVb4xcs/OMT5T4hVdwAtws8Lw0f1ofW5uE5Vlhu5GUXUB
Mbz0DBwkRwBtEmnOCDeZE8zBL8ifIc7k5lQ7Kp1hr4gg/89oLXSABSSxtkyx2U20
8Q1u2OXUiGq4J1BPkNs/5REFb+DJ5bpor7fMecfxoIKms1HXU4w3BjLO6x0ijCTc
cKtZD6eMdpBVNhzXDsJpwMEePaKmJ8k9M4XEVFzBGvdKZ7nAx2meA0rmRssG8tVN
PkNk/kswZIw0qi+m7Lo5uoWOoyKt/s3/UxyUehrIs2k836Zxc9gNdXzX3V9l/R7l
KStxOPruRK2CjPtIE+OBeCpkVxVpFnNhyOVRADi9sWf4ztjwoo8acuXuDNjBDRoP
ggNzOacqXIv8N0Ly6pn+01O6jUg5VNLndq9hOMveyamHwRAZVTDiJMh2xmJqBW41
jIckyXwpnHly1Ag/DEWDiLlgjL0KTcqLGn3Y3oG4jd6PKxqUpxZHGw5UvLPq4QOk
Oy6ZjqF9XGRi8kCgo0hGVLIKxJX7RfAZydaWmAjQVouEODj3TvU=
=wcL8
-----END PGP SIGNATURE-----

--utmrbzzw4vz6dwo3--

