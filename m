Return-Path: <linux-fsdevel+bounces-73052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D3FD0A624
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 14:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE2F230274F6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 13:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FE235BDA8;
	Fri,  9 Jan 2026 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Okt6TiEn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED4A35B159
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767964298; cv=none; b=bAkrxInk5jwmM4MVQmDfl5yCzi2OJ8Nz1aawVVqud0sw7YlP0u+k4ZEe0HUTTC2PIiLfyNPpCbvhQtQvbfxVxua3V5jDntdcZuW4RPnvxBG05vzAfLurP4kBjn2BzV8S4DICA104QLqE9ccOlS/6fzenh2EjfhaGY8FjidRmYuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767964298; c=relaxed/simple;
	bh=nzBrqUdESh3luJAwG3VnWJZEvXtqK5464e5cAmC20/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RtZEpfgBW1FJXtPbgpLIc/zmXEcNxTnsb92PtK9Fbb0UVXoy3K2nhwfQk7q+BgPdH3chl9EInGogQ/ZcbLEmqUnQUQjmZDDQTuYmKmOLO4mTz7+y7YYfnUZ/bA88FGDRABlIhcpFfj2Z37UZp/C6BmVu1QP6APDTCQl96QD/hk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Okt6TiEn; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso20213655e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 05:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767964296; x=1768569096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlKot51Pmid6Kv0dVzijvlBc7+hWhcVyo1qqHAl1Qnk=;
        b=Okt6TiEnus3HbnwVb4ftGt/WI+u4GUYgm09C8xRsTIXUCCOzPVHohQdBB5MfHnojLW
         aVihL+XcN0PNTaDvrmNCHQt8K5e/giO2DDc5fOuHkUrjgx3APW0rWoRsFVcTvQpdX+Mt
         bfLy4eeUYRQEvgsOHsc/Sy1eCCbpAus4P5VXCgctMmAArc4ftYOsnXrP2W+r2zSitVb1
         HDLR1FDxIBeFSZm6VYgPLyS6tNdXQFO6v1fCVZFXxgBZ9xV0Qv6XZ2Yt3AycXsQA3HxL
         Bidk0BdJ5p5giPzQmJpQoKmPp84l0ra4v4sz9hFjXpWa8Tzdh4+8MezzNd1fzNR+Z1xo
         PKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767964296; x=1768569096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qlKot51Pmid6Kv0dVzijvlBc7+hWhcVyo1qqHAl1Qnk=;
        b=ErvbjB3E3a0hjMN7QrcqGjS2cbR8tZalQQIRPlf+/NIzVJFReBmoDgJihASEWqGeoe
         jSuLzh8BguH4C2QfPXZPPudAcfkadwv2Cv+KjClvQOWmeXYrdfSh8tqIn4LkeJsj9u2W
         vAyDwnPMGNF/x2imvXCjBY9O6iqXPD55fScT0z0j28H7W2FCmpYh0t68O63oSDAjFeKN
         Zlr/oyn6W2ykMO370ZDbepUZf6+5/2lj665TRxInz0QhgerR8FS+XnTUZDCMDovxM9o4
         CRm9taHXCbjS0pXn4eUkFLtPXpz5KqGW2xY712Bz7IZsytBQReIRLPkUl+lCa4bgk3EO
         ih0A==
X-Forwarded-Encrypted: i=1; AJvYcCUJUxFC860MyRsSHUY7mNYIAgOokHXkUevkTeoOBVTzV9qrpVXjanwZG7p5bUMJT/rcUvXfISLFnGbcU1x+@vger.kernel.org
X-Gm-Message-State: AOJu0YwPqHZTNYN6hRsP6fcMzrWPhCFKzTxJxYkvFyS957rU+gk4t6NU
	YG4md3cfz3VcVymBWXF8R3G1I8mtk/uy2QYV6vnCSA/PLp8AlmowLJMp
X-Gm-Gg: AY/fxX51QyECT0p8vY1NIEYULnRR6on0/BKQlWETHOvTvOujU1jMnlszDUyY2MENJRy
	92f821LRavy+fzt/eA7eDnzeMRm4i+migNH3b5q/eLkJzG3+m+cs8w7j4xu3Tf1pEIqaXkz6XQn
	zlKiwlX2j7dgG47d771mD0c3DBc5WE/KYyocb+z+IcGBv08xhgfm8Balgju0Lvbn49gEM8jZQFc
	mMaP3PKg30LXno0RuY8Vl2FIUtYmX+GH06iSgjKfolRVdrvHIwW2xvVcIxgYRKvppenkjFnEzLp
	Yn6QzvAhNcwlM90zuzYut+sldwihBXRYNbkIxlWucwcAQzKXPE4ZKZh7ip3yyyGMr8PasYAKYTp
	yA+nI5NTy9K+RndXLfbZliG5b7Ksj3JScENpW99i9VIzgZ0qNFW8P5WALa3ZTAHYPsJnFTRrsXv
	oryJIk9tB0wrzrZSSaZioH0Xy5NqtdhaziPzYoXWchJh7OKVb59QSK
X-Google-Smtp-Source: AGHT+IGy+h8obyOsYe4+h4J8qbkAamK63ydWQgVz/JlL42A3uiFki5hcGpha2jvjXjSUcpxLdLVplQ==
X-Received: by 2002:a05:600c:82c3:b0:477:9392:8557 with SMTP id 5b1f17b1804b1-47d84b3463fmr99833235e9.18.1767964295793;
        Fri, 09 Jan 2026 05:11:35 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee5e3sm22415557f8f.35.2026.01.09.05.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:11:35 -0800 (PST)
Date: Fri, 9 Jan 2026 13:11:34 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>
Cc: Bernd Schubert <bernd@bsbernd.com>, Arnd Bergmann <arnd@arndb.de>,
 Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fuse: uapi: use UAPI types
Message-ID: <20260109131134.7aba4acf@pumpkin>
In-Reply-To: <20260109114918-1c5ea28d-f32d-49e5-affb-cc3c74c4dd5b@linutronix.de>
References: <20251230-uapi-fuse-v2-1-5a8788d62525@linutronix.de>
	<8efcbf41-7c74-4baf-9d75-1512f4f3fb03@bsbernd.com>
	<b975404f-fd6d-42aa-9743-c11e0088596b@bsbernd.com>
	<20260105092847-f05669a4-f8a1-498d-a8b4-dc1c5a0ac1f8@linutronix.de>
	<51731990-37fe-4821-9feb-7ee75829d3a0@bsbernd.com>
	<2c1dc014-e5aa-4c1d-a301-e10f47c74c7d@app.fastmail.com>
	<e22544a1-dea4-44d0-9a72-b60d38eeac19@bsbernd.com>
	<20260109085917-e316ce57-5e78-4827-96d7-4a48a68aa752@linutronix.de>
	<20260109103827.1dc704f2@pumpkin>
	<ccdbf9b8-68d1-4af6-9ed4-f2259d1cecb4@bsbernd.com>
	<20260109114918-1c5ea28d-f32d-49e5-affb-cc3c74c4dd5b@linutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 9 Jan 2026 11:55:30 +0100
Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> wrote:

> On Fri, Jan 09, 2026 at 11:45:33AM +0100, Bernd Schubert wrote:
> >=20
> >=20
> > On 1/9/26 11:38, David Laight wrote: =20
> > > On Fri, 9 Jan 2026 09:11:28 +0100
> > > Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> wrote:
> > >  =20
> > >> On Thu, Jan 08, 2026 at 11:12:29PM +0100, Bernd Schubert wrote: =20
> > >>>
> > >>>
> > >>> On 1/5/26 13:09, Arnd Bergmann wrote:   =20
> > >>>> On Mon, Jan 5, 2026, at 09:50, Bernd Schubert wrote:   =20
> > > ... =20
> > >>>> I don't think we'll find a solution that won't break somewhere,
> > >>>> and using the kernel-internal types at least makes it consistent
> > >>>> with the rest of the kernel headers.
> > >>>>
> > >>>> If we can rely on compiling with a modern compiler (any version of
> > >>>> clang, or gcc-4.5+), it predefines a __UINT64_TYPE__ macro that
> > >>>> could be used for custom typedef:
> > >>>>
> > >>>> #ifdef __UINT64_TYPE__
> > >>>> typedef __UINT64_TYPE__		fuse_u64;
> > >>>> typedef __INT64_TYPE__		fuse_s64;
> > >>>> typedef __UINT32_TYPE__		fuse_u32;
> > >>>> typedef __INT32_TYPE__		fuse_s32;
> > >>>> ...
> > >>>> #else
> > >>>> #include <stdint.h>
> > >>>> typedef uint64_t		fuse_u64;
> > >>>> typedef int64_t			fuse_s64;
> > >>>> typedef uint32_t		fuse_u32;
> > >>>> typedef int32_t			fuse_s32;
> > >>>> ...
> > >>>> #endif   =20
> > >>>
> > >>> I personally like this version.   =20
> > >>
> > >> Ack, I'll use this. Although I am not sure why uint64_t and __UINT64=
_TYPE__
> > >> should be guaranteed to be identical. =20
> > >=20
> > > Indeed, on 64bit the 64bit types could be 'long' or 'long long'.
> > > You've still got the problem of the correct printf format specifier.
> > > On 32bit the 32bit types could be 'int' or 'long'.
> > >=20
> > > stdint.h 'solves' the printf issue with the (horrid) PRIu64 defines.
> > > But I don't know how you find out what gcc's format checking uses.
> > > So you might have to cast all the values to underlying C types in
> > > order pass the printf format checks.
> > > At which point you might as well have:
> > > typedef unsigned int fuse_u32;
> > > typedef unsigned long long fuse_u64;
> > > _Static_assert(sizeof (fuse_u32) =3D=3D 4 && sizeof (fuse_u64) =3D=3D=
 8);
> > > And then use %x and %llx in the format strings. =20
>=20
> These changes to format strings are what we are trying to avoid.

Where do PRIu64 (and friends) come from if you don't include stdint.h ?
I think Linux kernel always uses 'int' and 'long long', but other
compilation environments might use 'long' for one of them [1].
So while you can define ABI correct PRIu64 and PRIu32 you can't define
ones that pass compiler format checking without knowing the underlying
C types.

[1] I can't remember where, but it might have been NetBSD where different
architectures managed to have different definitions!

	David

>=20
> > The test PR from Thomas succeeds in compilation and build testing. Which
> > includes 32-bit cross compilation
> >=20
> > https://github.com/libfuse/libfuse/pull/1417 =20
>=20
> Unforunately there might still be issues on configurations not tested by =
the CI
> where the types between the compiler and libc won't match.
> But if it works sufficiently for you, I'm fine with it.
>=20
> Also with the proposal from Arnd there were format strings warnings when
> building the kernel, so now I have this:
>=20
> #if defined(__KERNEL__)
> #include <linux/types.h>
> typedef __u64		fuse_u64;
> ...
>=20
> #elif defined(__UINT64_TYPE__)
> typedef __UINT64_TYPE__		fuse_u64;
> ...
>=20
> #else
> #include <stdint.h>
> typedef uint64_t		fuse_u64;
> ...
> #endif =20
>=20
>=20
> Thomas


