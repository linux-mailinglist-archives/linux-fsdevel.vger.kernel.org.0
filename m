Return-Path: <linux-fsdevel+bounces-73087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB64D0C05B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 20:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3DA4304F100
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 19:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312C42E8B9F;
	Fri,  9 Jan 2026 19:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6aszFdu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4252DFA3A
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 19:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767986019; cv=none; b=e+NUDvk8dVhx+97QMMVdtHQ+5/c/wP0CZB2/gOZCC+7qaQD8s5BXd0Q8hwjOEUUJz0l6huuyTgEJIa9Pm9wJE6Cb1iPtxNkGAIBeL0UHv2me6ZgkKeZdwGSYk+q6rpL7zUJwtaHbHoOGdZVrOfhAf4vtzbqvdKw4PfEt419jfb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767986019; c=relaxed/simple;
	bh=mVe3a4x+Xf9izzeH1nMO6cG5fRFO7E2iLNPnBx/aYQc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HCzObYiIRN1GSKi+N7GG2hRkOAONT6gBaokEMSnWT0ry4URD/gCvO39wIyteWZnqXpnxIX/1BEN4kT7qwEBtGn8ScMyQjglUTOMe5mUyafSMIGYRxIC8/iOZWojN+l/uAoNklxS4pPqIyjh+S4+8LrPrtUuOe9LROdW1r0lRC+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6aszFdu; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4f1b212ba25so39792071cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 11:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767986017; x=1768590817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAbGBdKfZWhiud4JJjy+Srhy+srE9kGSFCkEN7+Ee98=;
        b=Q6aszFduu3GpUA26YHzkV3DQBphe7ehkdo9xNhItpOZCrdTKvDn/BQa/gM33GYk9jL
         t+aazTp/0MT6Nlvr9E/0Jh6ojYEY7VEkuHA+HG0mUEKzzbZYL6EK1ly73Fhgt/MQ/cGF
         nIe460tZ4+K69+xysU5IZMfx2KmaHibVODqAoJ6EhH/RWJAhi/J50EUSWsOmR0ODON4b
         kujqygEYD/lzXdig6K+F5mqoUobMKmqjMhin0tJ2zOT2l1bL7C76btlg9pMwaJx97w6t
         u52IIf/KO/6ok1R7CFlqJDWRvGcG/Jl6OVeY9ytkZhI9kaCVqOE5lEx0bnFdFcZU7fhu
         +I8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767986017; x=1768590817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TAbGBdKfZWhiud4JJjy+Srhy+srE9kGSFCkEN7+Ee98=;
        b=setlaIoubnvN27PYEjbuBvhGhLY7+iVwh7EV6X6O1gPVt0Du7q2uMKd2qfdZDtUtIX
         SvI+Gjpba/vXLTveuXW2Fd/PlhYQUOR+VDMHtKQDGJwNZQ9aknLEu7yNv1aFB+Af4/wb
         eNlDQHxRnMEbME83RG+W/uf7N4UzJGlcs5LFBJb0E2Xjg874EJUHZ31D1ALnOjIJ6jXn
         T61ShfmLL1B2UcuPtLr4s18dZnv7rP+WLqqOaW5BTjdoSoCFmRhk7C1K5t/X6EZEh0fl
         AJ3nxPFkxtvi3Z+x/WWxHdOzrLpWuFXtYh30rtFI7lVDretSSmIFLWYA4wlsDHupWpZe
         UURg==
X-Forwarded-Encrypted: i=1; AJvYcCUewzZ+ewQbNT0OgQkPh8QnNaJqIhqhhG7U86e3Vyzwb9BIT5nvXz6yHVo1p8TG1wH6P6anaidS0vZvxZAn@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzy524R9dswkqaMT9P5JjZZpAhobGJAxS92l9lcaUaLrADPdHp
	KZo2oIKnafUSlfjH4GrPMBf/UxnwKINXW+6fdZZVMdEDBCbmn2m3yaja
X-Gm-Gg: AY/fxX7NJgyx4cFyUEX2Pjt6OIKiFBFuGih4374IUIUnlUVyxDQ2bTidGdV79KLkJbu
	uLepWg0oWDyT4ooTuACp1Ko5nVp55nmNwxj35Ea+90b3H404j6MSGsPrVrYTqnkErDCjwT1fWmR
	0GOspQIsQzjdGbkX1w/sFs3U2yWlsKiKxCIxkoOo6SMVxRHTa/Sz1aW3U072BOx5keSNSeRv/er
	ZUbGG7bkvyutPut2Yljr6IXnAf/zIKt+dgdcdVi1hDWV3jWGwsuXvzn3VVVIgDbymgk8BS8favC
	V72rSr3btpBDkp+2VbVsE8eoXo30JWHZ/RDVba+iMG3z+qW59hQYn6UKbhyfuL0vc94cEIVbor8
	pIoJiRvrX7iR+UphyZmqRelDst4G8uazhO/2T2edILedwH3jkHRu0oBgMEtlHFBy6ZeZtzd6Ofu
	y+K2TZwFkur+nktp/k53ujcjL9262sx46HVVyRX31St93NGhCPll51
X-Google-Smtp-Source: AGHT+IEiDct/J6kDHFO34j6HlpzLUhRX05gxT5R+Hps5SBUP0wHRbRg5BCKl4NIyotg1aayFyIgqtw==
X-Received: by 2002:a05:622a:88:b0:4ee:7ee:df70 with SMTP id d75a77b69052e-4ffb4a6069emr144350721cf.80.1767986016870;
        Fri, 09 Jan 2026 11:13:36 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8d39230sm75391501cf.6.2026.01.09.11.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 11:13:36 -0800 (PST)
Date: Fri, 9 Jan 2026 19:13:33 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, Miklos Szeredi <miklos@szeredi.hu>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fuse: uapi: use UAPI types
Message-ID: <20260109191333.4b266966@pumpkin>
In-Reply-To: <deff86e1-f124-4e5d-9313-d7339bcc664a@bsbernd.com>
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
	<20260109131134.7aba4acf@pumpkin>
	<deff86e1-f124-4e5d-9313-d7339bcc664a@bsbernd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 9 Jan 2026 14:46:02 +0100
Bernd Schubert <bernd@bsbernd.com> wrote:

> On 1/9/26 14:11, David Laight wrote:
> > On Fri, 9 Jan 2026 11:55:30 +0100
> > Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> wrote:
> >  =20
> >> On Fri, Jan 09, 2026 at 11:45:33AM +0100, Bernd Schubert wrote: =20
> >>>
> >>>
> >>> On 1/9/26 11:38, David Laight wrote:   =20
> >>>> On Fri, 9 Jan 2026 09:11:28 +0100
> >>>> Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> wrote:
> >>>>    =20
> >>>>> On Thu, Jan 08, 2026 at 11:12:29PM +0100, Bernd Schubert wrote:   =
=20
> >>>>>>
> >>>>>>
> >>>>>> On 1/5/26 13:09, Arnd Bergmann wrote:     =20
> >>>>>>> On Mon, Jan 5, 2026, at 09:50, Bernd Schubert wrote:     =20
> >>>> ...   =20
> >>>>>>> I don't think we'll find a solution that won't break somewhere,
> >>>>>>> and using the kernel-internal types at least makes it consistent
> >>>>>>> with the rest of the kernel headers.
> >>>>>>>
> >>>>>>> If we can rely on compiling with a modern compiler (any version of
> >>>>>>> clang, or gcc-4.5+), it predefines a __UINT64_TYPE__ macro that
> >>>>>>> could be used for custom typedef:
> >>>>>>>
> >>>>>>> #ifdef __UINT64_TYPE__
> >>>>>>> typedef __UINT64_TYPE__		fuse_u64;
> >>>>>>> typedef __INT64_TYPE__		fuse_s64;
> >>>>>>> typedef __UINT32_TYPE__		fuse_u32;
> >>>>>>> typedef __INT32_TYPE__		fuse_s32;
> >>>>>>> ...
> >>>>>>> #else
> >>>>>>> #include <stdint.h>
> >>>>>>> typedef uint64_t		fuse_u64;
> >>>>>>> typedef int64_t			fuse_s64;
> >>>>>>> typedef uint32_t		fuse_u32;
> >>>>>>> typedef int32_t			fuse_s32;
> >>>>>>> ...
> >>>>>>> #endif     =20
> >>>>>>
> >>>>>> I personally like this version.     =20
> >>>>>
> >>>>> Ack, I'll use this. Although I am not sure why uint64_t and __UINT6=
4_TYPE__
> >>>>> should be guaranteed to be identical.   =20
> >>>>
> >>>> Indeed, on 64bit the 64bit types could be 'long' or 'long long'.
> >>>> You've still got the problem of the correct printf format specifier.
> >>>> On 32bit the 32bit types could be 'int' or 'long'.
> >>>>
> >>>> stdint.h 'solves' the printf issue with the (horrid) PRIu64 defines.
> >>>> But I don't know how you find out what gcc's format checking uses.
> >>>> So you might have to cast all the values to underlying C types in
> >>>> order pass the printf format checks.
> >>>> At which point you might as well have:
> >>>> typedef unsigned int fuse_u32;
> >>>> typedef unsigned long long fuse_u64;
> >>>> _Static_assert(sizeof (fuse_u32) =3D=3D 4 && sizeof (fuse_u64) =3D=
=3D 8);
> >>>> And then use %x and %llx in the format strings.   =20
> >>
> >> These changes to format strings are what we are trying to avoid. =20
> >=20
> > Where do PRIu64 (and friends) come from if you don't include stdint.h ?
> > I think Linux kernel always uses 'int' and 'long long', but other
> > compilation environments might use 'long' for one of them [1].
> > So while you can define ABI correct PRIu64 and PRIu32 you can't define
> > ones that pass compiler format checking without knowing the underlying
> > C types. =20
>=20
> libfuse uses PRIu64 and it make heavy usage of stdint.h in general, I
> don't think building it in that no-libc environment would work. But that
> doesn't mean the header couldn't be included in another lib that works
> differently.

That means you need to 'fake up' definitions equivalent to those from
stdint.h when it isn't available.
I don't think checking for __UINT64_TYPE__ will work if you need printf
to work - since I don't remember the compiler having anything that will
help you generate a correct PRIu64.
(And I wouldn't like to guarantee that stdint.h always matches the compiler
internal configuration.)

If stdint.h is already included PRIu64 (etc) will be defined and all is fin=
e.
If __KERNEL__ is defined then you can use 'long long' and 'int' (and define
matching PRIu64 if needed for consistency).
Otherwise you need to include stdint.h.

Perhaps you could check '#if defined(__KERNEL__) || defined(__NO_STDINT_H__)
then an environment that doesn't have stdint.h would still compile (with an
extra -D__NO_STDINT_H__ on the command line).

	David

>=20
> Thanks,
> Bernd


