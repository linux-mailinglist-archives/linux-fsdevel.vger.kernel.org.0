Return-Path: <linux-fsdevel+bounces-73025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAE3D089E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 11:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 202213019E02
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 10:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FAD339705;
	Fri,  9 Jan 2026 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3OncSyU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0543382D5
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 10:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767955115; cv=none; b=HhpLmIV2W2YfhlXBXKHbLRuQBbbmqerRCT0yO+qv6tSd6EY7say1xqTpbDjSxFca03QSFaEIA5cr5iNe4wpNSHMueOMA2TUMHNr8VIb7JUoARhZ04lFxWhytA4XPE5SCnRPqXfMG2nT/cjp+QAT4i/sAcXVKxeM0oSAqBCOHYMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767955115; c=relaxed/simple;
	bh=c+ZhJi0bXxqFuXDXgywqPB3RNPjIqKEqdODCPobZw6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r17SnH8G9b7XACvN+76+u9Dua46e8UnW9AlKrEpbVGQxbqBWTjkRxq17ncXI5blK/cXash/wC7eXC3UyN0NqRTccMFIU23ALrXOAQ1AOBb/PJIJE6dZqI1ziHDooozY2M30C0bQkOKBriTvCQD2zTTxLrHvmDCp+BK3REnFurUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3OncSyU; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so2256703f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 02:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767955112; x=1768559912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z80Y99EDQQAWvdag25MBGlQJoO8vUt97h03J11RRGQI=;
        b=W3OncSyU5fuNmRY2A0G2qHeaui7u7K9nEiEXwC1GZP7XqKc6I8uEXo8BrNWCCoCsF9
         F17+jKVb+34VCOj7zKzyCr+GltUGO8dAIjgzDKNVcOT4yzFBSGweLx89b8dCybR5fYCj
         nl2pdhlIvZ5dsgUo05S72Vzl6QnY4gOvyFM4mZ+ijZqPreN1tRK8bvnHaeahtFerfyWi
         M0Z+wTVBK1XNZ5Z4sSWP/jUyysDgsJLIDm/OQjPmgY7nJG7b6UtSgk2zcjaiCFDeZ6rL
         UXtFkzVqmRC8BEwdnwjH1VHIW6zzrKrzo8xETYGaNKqLJlOqRv6JijGhU9mtsJ/W0YfJ
         UDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767955112; x=1768559912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z80Y99EDQQAWvdag25MBGlQJoO8vUt97h03J11RRGQI=;
        b=RWZlAVV+iU8TRfZZvIKTm+kL3KTvYejhT81be1oVQqm9WnwTMKtOHSa2IKdjtWP9j1
         VhmpC3Bah4588uuL0NFnZUNNW+o4hFj4ey7pjo0hTrYWJRF7I67n8XeNYAaP2HGuXFHy
         dY4v2Bb9SL4XRs6+HycQWJjtnOIXsF/+tv0pTgMKybV1t+iwFmovPqsO3MnL7swcvveg
         HxNk4SaKtXrcw7g93qZ3imYlSEkUdxLku9viqjeNBcrIj3VV7EsWnjgrjE7dMmyi9QbA
         6DEpxjQrCrM0JpgPZJwbFbsGNJRIOXCc7RG3RfEdj831Swvjr/XYQ5CPp7CILLgDsm09
         ciUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9zgtWJXH3k1ktGS2Vbg7ou8wlPElk0kXGEyyZHubigiokuLg0g6NYGmG9Eywasz2CeO56JL1P0qK91UZq@vger.kernel.org
X-Gm-Message-State: AOJu0YxS4QY3NvF5Z/xgQqNyj+rVwumxzInA3EqEFiQ44HHnlzCWhq6A
	FkKfNKrOf0N/baX6mdP8cpdLw2mYb4xc0D1ony8B6VeFK2nxpGGXcmDQ
X-Gm-Gg: AY/fxX5VYZid6NZh4RqMUhXJw2RxhvRHPpHtx8gUqYXSvbhQEbx6CGWfW2avUY/iDeq
	WW5yCB6BjYZhu/EpzjI/1osWSYBu5tIOCZ8Ry9Eg0n9CHCN7updm5q0A7XPyHQGOCMZbAxOD844
	6zlYg0gFLBt+mYtTkynx1PW2pu0J1TYwKS1D64SSWoNwJg6cwCheAqGhajAqfToVtC9hesACdhT
	HXUzr3hQFJ0KDc5vm8NwPeicgl6WKVMvQA2LdSMF1uHrGHAg+5d6hCUOLYBU4FSpR/+GqHOTPrD
	7Q4j1odl4pHJTeuK/xytyS+rtFsWQzIdDxYSXsOETTtrH1FhvsX7qewwu8xohJ7LKe+KBbL1CcU
	7KxZZJXzas3vD+ww0N4Dsj28943cgKd+HHquQQqyuIydNga8rv6PEqEiUGdISZWR6yQQsWtmeWP
	tSTh+Id5DIq6Zt3OJFvk9ZxoR1EpKwQD6OUG/uP2NO6dMVibTPdSkiUj3T2JHjDRo=
X-Google-Smtp-Source: AGHT+IGoW+a8J/WoHD2PfbgH/34JdxcjznAC6FiDXmVAjsc1Fbs01hlM4un1BpydrdNwh9k2l1Ng/g==
X-Received: by 2002:a05:6000:3104:b0:430:fdb8:850c with SMTP id ffacd0b85a97d-432c37c380cmr10699593f8f.61.1767955111819;
        Fri, 09 Jan 2026 02:38:31 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df8besm20778549f8f.26.2026.01.09.02.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 02:38:31 -0800 (PST)
Date: Fri, 9 Jan 2026 10:38:27 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>
Cc: Bernd Schubert <bernd@bsbernd.com>, Arnd Bergmann <arnd@arndb.de>,
 Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fuse: uapi: use UAPI types
Message-ID: <20260109103827.1dc704f2@pumpkin>
In-Reply-To: <20260109085917-e316ce57-5e78-4827-96d7-4a48a68aa752@linutronix.de>
References: <20251230-uapi-fuse-v2-1-5a8788d62525@linutronix.de>
	<8efcbf41-7c74-4baf-9d75-1512f4f3fb03@bsbernd.com>
	<b975404f-fd6d-42aa-9743-c11e0088596b@bsbernd.com>
	<20260105092847-f05669a4-f8a1-498d-a8b4-dc1c5a0ac1f8@linutronix.de>
	<51731990-37fe-4821-9feb-7ee75829d3a0@bsbernd.com>
	<2c1dc014-e5aa-4c1d-a301-e10f47c74c7d@app.fastmail.com>
	<e22544a1-dea4-44d0-9a72-b60d38eeac19@bsbernd.com>
	<20260109085917-e316ce57-5e78-4827-96d7-4a48a68aa752@linutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 9 Jan 2026 09:11:28 +0100
Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> wrote:

> On Thu, Jan 08, 2026 at 11:12:29PM +0100, Bernd Schubert wrote:
> >=20
> >=20
> > On 1/5/26 13:09, Arnd Bergmann wrote: =20
> > > On Mon, Jan 5, 2026, at 09:50, Bernd Schubert wrote: =20
...
> > > I don't think we'll find a solution that won't break somewhere,
> > > and using the kernel-internal types at least makes it consistent
> > > with the rest of the kernel headers.
> > >=20
> > > If we can rely on compiling with a modern compiler (any version of
> > > clang, or gcc-4.5+), it predefines a __UINT64_TYPE__ macro that
> > > could be used for custom typedef:
> > >=20
> > > #ifdef __UINT64_TYPE__
> > > typedef __UINT64_TYPE__		fuse_u64;
> > > typedef __INT64_TYPE__		fuse_s64;
> > > typedef __UINT32_TYPE__		fuse_u32;
> > > typedef __INT32_TYPE__		fuse_s32;
> > > ...
> > > #else
> > > #include <stdint.h>
> > > typedef uint64_t		fuse_u64;
> > > typedef int64_t			fuse_s64;
> > > typedef uint32_t		fuse_u32;
> > > typedef int32_t			fuse_s32;
> > > ...
> > > #endif =20
> >=20
> > I personally like this version. =20
>=20
> Ack, I'll use this. Although I am not sure why uint64_t and __UINT64_TYPE=
__
> should be guaranteed to be identical.

Indeed, on 64bit the 64bit types could be 'long' or 'long long'.
You've still got the problem of the correct printf format specifier.
On 32bit the 32bit types could be 'int' or 'long'.

stdint.h 'solves' the printf issue with the (horrid) PRIu64 defines.
But I don't know how you find out what gcc's format checking uses.
So you might have to cast all the values to underlying C types in
order pass the printf format checks.
At which point you might as well have:
typedef unsigned int fuse_u32;
typedef unsigned long long fuse_u64;
_Static_assert(sizeof (fuse_u32) =3D=3D 4 && sizeof (fuse_u64) =3D=3D 8);
And then use %x and %llx in the format strings.

	David

