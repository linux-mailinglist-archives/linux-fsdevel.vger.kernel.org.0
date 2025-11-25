Return-Path: <linux-fsdevel+bounces-69795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F0AC854D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 15:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8023F351D44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 14:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534FD327BE6;
	Tue, 25 Nov 2025 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="UWRocTrK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A04326D79
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764079207; cv=none; b=KbBWzEKuhAlLAtttD08xyjgebVMUq96P+//dgx7giwV/65GQblUqeeKGjGw2c73Dd+1FtU+8aD9BfTjkeg+6HXVr7noLyuMOKmrConuUMJW/5m0+bVw75blJ7GfQ7phrM8/RV+5Bxyiv+mz4h06xI+28kF3Yegb0OjjGFab2fVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764079207; c=relaxed/simple;
	bh=C8XIwA19HrNwiDIWcAp9ATXIQ3+6lATQ5Ks12sTRPrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5Bfv25wzqa/9ox6FW01wcVzromLD8+pd1al7IXyWOGBkJIfDBhBrqDuQiWtMBOBZnCF6e4icoOA5DMbjniiYyZv7B1ucwQ2IZ1qbIkLl4lDWPEi2NDy5TVn0MkSazA/iItjwMFq0vQwTxR+iyB++GEStxeP+ccOIIKHhYtEpzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=UWRocTrK; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso9322115a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 06:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764079203; x=1764684003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPADEzDInP+4EgYdCnNY22SOys+qqvVd9B9lyZm9LUs=;
        b=UWRocTrKMri7yCN1LuVyAaLVUt6HcfVLWsWlC9rXpDVD1z1xTnlpjqW3EVtOdTRWR0
         dklfGTyD8cgo07ZHESMoU4KIRcRvhw2U3n9YL+33L1JaxHBe3+PbyHAhekvPTOudEhIU
         KNdnfRO++KTMV4v1Mg8Kbdpm10tMbRCP6YgrDQUeIvdVcVZS9K9MhenTAThLTsDjueSL
         lWL5+5Vmg7X0GxC3JEumniwlqz/C1FLdWFqelgJ/5EkAAOCNbkxc2VkKFb3MVsQqv8s9
         DWlg/9B8bqORvIXMZDhijac7T5Dd35d31eMWFlNkaLBVftZc4LTnp37xbD2betgIScR/
         yi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764079203; x=1764684003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gPADEzDInP+4EgYdCnNY22SOys+qqvVd9B9lyZm9LUs=;
        b=tUqidWFynEdmLQLYkpR7CBR+FKdraMpnBaa4cepAg99SNVCbNX2JCp/IF90WVaEaE5
         7Nw21DCcglbfVw8hQ6pQuopmrh6TZ/ENBASaom4yQ3n3ziJB89CF49wxNqFfSGWRuHr7
         UV3z9aZJrz+0ro84BUsarkHM8miYGnT27Lp3ahU/LW5HVDZUX/p0WYvRRIchZlMmCKfj
         Un6AgYcuCejXqNooOmL4Zb7Q4PVpP1m+qJE0Mpdkphk90CSj/VHjFOjzcPmFi50KjQM4
         dy++hERJFkcLZHHSoASgRKfnCONJMCqltZvjyNq7ja31RhxNtlm/qulGH5zP85K3Td8U
         a3Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVkqVGH2mXTIdS9+0M6Ce+GQ7HklbA1s4s9DMCZnIBXIu0Ieftmt0U2vP56DHni+IuDp8U5s4ybIsh/+Dxq@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ek6ImngqK0NRqvT8QesOMr1U6OkOS+k5zy+45zR2CygE8pGY
	LEMWD0tmZySNEJoetWWWS1OiYxG2oaaygRWZKzxcAlDR2MNzgZbnUOT/0GNxkm3UvnlIa9jIxtd
	4K2E+eyG2uneU6sgmYDoXybcuzgZKq7UdEWu9DyLI4w==
X-Gm-Gg: ASbGncsBbmdu//b7DaYIVWG53ofsoMfhMNwzMmaG+Y5bfhzwomynjF5iGhBKnDpJWED
	0uM9tRvFBq70EenB48jv3Wv8FjuzbQTj9ZAjDDvBxNzO89xA+lyBlAB5Po5v0BNHUHBZ6DSfEae
	v5sQvVSQEovMiqEYXzkvvOZ1MlmvDw/W36j4amDnH+xJFrqZtKIGcaugLeuzSDEcjsaDHC4FcjS
	ivbHlreT60ZMDkwv9U6sRUgkk8kOeHUcNwaJO5IFIsbRJAbMfj/11hAvttrpn/X4shR
X-Google-Smtp-Source: AGHT+IGQvP3sp8P5QdaHoU5hl5stQ/R78sD1t68LmqHbhIYjocvMZQNdcinW6IeCcPNYJc/WOurXaWpr8WBXOL4qx2M=
X-Received: by 2002:a05:6402:35d5:b0:643:18c2:123b with SMTP id
 4fb4d7f45d1cf-645544420fcmr15551385a12.3.1764079203274; Tue, 25 Nov 2025
 06:00:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-3-pasha.tatashin@soleen.com> <aSLvo0uXLOaE2JW6@kernel.org>
 <CA+CK2bCj2OAQjM-0rD+DP0t4v71j70A=HHdQ212ASxX=xoREXw@mail.gmail.com>
 <aSMXUKMhroThYrlU@kernel.org> <CA+CK2bABbDYfu8r4xG3n30HY4cKFe74_RJP5nYJeOtAOOj+OUQ@mail.gmail.com>
 <aSWqQWbeijvruDqf@kernel.org>
In-Reply-To: <aSWqQWbeijvruDqf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 25 Nov 2025 08:59:26 -0500
X-Gm-Features: AWmQ_bkHTYlHlGxKmBiHNdm6t2thzT9HecweCk3JjWHiloeJgWPSmfHodz7nV6A
Message-ID: <CA+CK2bC2yptSzT+FJaef_K3bvOeDmmOzZVf3VakaKn6r7qk+dQ@mail.gmail.com>
Subject: Re: [PATCH v7 02/22] liveupdate: luo_core: integrate with KHO
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 8:08=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Sun, Nov 23, 2025 at 01:23:51PM -0500, Pasha Tatashin wrote:
> > On Sun, Nov 23, 2025 at 9:17=E2=80=AFAM Mike Rapoport <rppt@kernel.org>=
 wrote:
> > > > > > +static int __init liveupdate_early_init(void)
> > > > > > +{
> > > > > > +     int err;
> > > > > > +
> > > > > > +     err =3D luo_early_startup();
> > > > > > +     if (err) {
> > > > > > +             luo_global.enabled =3D false;
> > > > > > +             luo_restore_fail("The incoming tree failed to ini=
tialize properly [%pe], disabling live update\n",
> > > > > > +                              ERR_PTR(err));
> > > > >
> > > > > What's wrong with a plain panic()?
> > > >
> > > > Jason suggested using the luo_restore_fail() function instead of
> > > > inserting panic() right in code somewhere in LUOv3 or earlier. It
> > > > helps avoid sprinkling panics in different places, and also in case=
 if
> > > > we add the maintenance mode that we have discussed in LUOv6, we cou=
ld
> > > > update this function as a place where that mode would be switched o=
n.
> > >
> > > I'd agree if we were to have a bunch of panic()s sprinkled in the cod=
e.
> > > With a single one it's easier to parse panic() than lookup what
> > > luo_restore_fail() means.
> >
> > The issue is that removing luo_restore_fail() removes the only
> > dependency on luo_internal.h in this patch. This would require me to
> > move the introduction of that header file to a later patch in the
> > series, which is difficult to handle via a simple fix-up.
> >
> > Additionally, I still believe the abstraction is cleaner for future
> > extensibility (like the maintenance mode), even if it currently wraps
> > a single panic (which is actually a good thing, I have cleaned-up
> > things substantially to have  a single point  of panic since v2).
> > Therefore, it is my preference to keep it as is, unless a full series
> > is needed to be re-sent.
>
> Well, let's keep it. If we won't see new users or extensions to
> luo_restore_fail() we can kill it later.

SGTM.

>
> > Pasha
>
> --
> Sincerely yours,
> Mike.

