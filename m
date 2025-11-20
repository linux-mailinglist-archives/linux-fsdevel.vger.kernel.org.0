Return-Path: <linux-fsdevel+bounces-69273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 110BDC76325
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 21:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8924435C462
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 20:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B4F2F691B;
	Thu, 20 Nov 2025 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="DUvC0xQW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A2E272E6D
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 20:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763670369; cv=none; b=UZZIAp/dlt5tlc7sfxzeQR5gIb5Kzf8RWV6qRpx7PjmV70As5ZyHl2vr45smx9dnTGT9WQoraLGRg6YbHgmwSdrKedJSN8muo9zz2+04xtINsVTuDGcvgw8/aOYTaDtQkmIpDL6svcWvjnA674r3F/3hQjpWxHZFQqABGRtBDDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763670369; c=relaxed/simple;
	bh=HKxsUP6rFBXmI1OJ4IRjGQED9rRjHTGRy52TJYhr6qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fp8+eDLuYKxGxGpl7/byPCloFT+QMQLajBqakubh6Ua5jQHsAhE9e9vmsofWrQAs2anqyTSC7hWxpyZ9bxaiW4mhChoO1U3N8/3DS74VuQDrzP7vcPBT4mr21NKg6IixICG+Dbv3BJvxBq1fxD1LyTYf3NHoYdrFJgu7d3gKe4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=DUvC0xQW; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so2081335a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 12:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763670366; x=1764275166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqIhtMYQq6hQ/aIE/gJLhPbAAZf5g6u9uLXykoPMVFQ=;
        b=DUvC0xQWjSl6K3pBfNMrNN7YpNjnN2gaTyS84y1E0fMSFXARjhmf2ji3hvbuEt+cCI
         DZ7YOCDqbJIOloHNudl6j7TFPc6m3yl8OZ66Xu4nP8VqvjlHxh/jcVMP34z3HXeVy99g
         gn6tcO1iGP7ERKr4fBr/EhRYSEpq43VF1PGD1OgwXW8d6w3IIIUQ9q3YLusV/0NtmC1g
         PoQQ8UvDwMoxgemRHDEQE7EIO/mx9W3glx9sdwREhTE2EiDaydYo6dhrjKQ8BZ5Ijfcv
         vUy+HRqV16ZOnur01VyBFjVBC1duBaGjM+Tp8Dp8GNszEBgXOZnSrm6g2jtEz7pb233o
         //yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763670366; x=1764275166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PqIhtMYQq6hQ/aIE/gJLhPbAAZf5g6u9uLXykoPMVFQ=;
        b=th5JOyVd40UQsXIwxKEi1gP9XP7FtxloGJKrqZGB5N24ZiRER7ABavJ9oQSSppQd0n
         vCPLHjkB2QZQBpXv/JkuOhaO4pnDldp7ARjyrcPi0G4qq3Z10ejKI+z1UbHczp29bzDu
         EuQ1w1ud2hkuVQrAxNBJwIr48fKWcjUIdzdpN0oBjiUb2Iwo8p//8oXe5nrn+y9GSr2U
         BVVB4lGjE+5ofoUxh86EK7kobPKWHjj24BPDEgBFBt5OCakudXpxAcmPIVffXsriEApy
         J6MeoW6GqC2wrnPGd7+/smt+8MJisOxQuNih582xsz0HfIONy1QTqevrNPp03kKIFaXL
         2alw==
X-Forwarded-Encrypted: i=1; AJvYcCUzbR+meb1+2K5y77fwX0ogZgqwO7O4zG5BTpMgv50VXzLfuXkZAmnZER51b7/KOjyMz0EYPtitBB9tICCP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8oIa7BfshmrGHtXszmY7hmQuKLHVW9Z4wFLTSZkRJ4TOAJyIL
	EhJ/XjWxxcbcd4NwwNPc2HTKr/Zoxf6QiBuXPc6dP3GudIqSz5XIKwP0JhSWT8ueQwllo4trKJJ
	4BF0ldmI7hHu0lQsQNbsQKWvYZRpnsoHfpBu3wR7fIQ==
X-Gm-Gg: ASbGncvMVl8QM1tVM8n1fWXhBHxt1nNN6L0YwrH4QW8u/gBgvv+IEFJOinR5uf2dhNI
	EWGkCsgD1mSE36NZdKFHcgB/FP8ca5fdiUX9voEfdaTYUc/mCGBuBBr5UBEtIE1YqjB6QQ5WYJq
	Ht+GoMcEA00gNYB0bwH7fz4Ah7NKODSFXLicqTVgVjC+etGJ1znp6c6192QQte7g0ruYt1pWn1D
	hanFiafCnNHjNYBFDA4wBku+FjvhcBAhZKBiANlTp/IPyoUO8gcYVG9VfeZRYqOGE2EGJVACU40
	ppk=
X-Google-Smtp-Source: AGHT+IHQa+0J7ga3uOxgiO5UWDnt3zS3XFLtQ5KrArOQzn1GSk7RNpL77vJHQpSi8zpQevLWXRXWPqNncA9R8gIVg0E=
X-Received: by 2002:a05:6402:510b:b0:643:e03:db14 with SMTP id
 4fb4d7f45d1cf-6455468513dmr12410a12.19.1763670366147; Thu, 20 Nov 2025
 12:26:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-7-pasha.tatashin@soleen.com> <aRoU1DSgVmplHr3E@kernel.org>
 <CA+CK2bBFS754hdPfNAkMp_PqNpOB2nY02OkWbhRdoUiZ+ah=jw@mail.gmail.com> <aR9N14KWaz6SdFcw@kernel.org>
In-Reply-To: <aR9N14KWaz6SdFcw@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 20 Nov 2025 15:25:29 -0500
X-Gm-Features: AWmQ_bkGcmBhhiXsN0wvCp8At9RZAkpij5uzcyGIDeVMn-hUhCRg5LgwnVtdQKA
Message-ID: <CA+CK2bDMS7g_9Z4aC1n-rYOGcXP9X+12cJhpYbx1HpsDfaMcfg@mail.gmail.com>
Subject: Re: [PATCH v6 06/20] liveupdate: luo_file: implement file systems callbacks
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

On Thu, Nov 20, 2025 at 12:20=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
> On Mon, Nov 17, 2025 at 12:50:56PM -0500, Pasha Tatashin wrote:
> > > > +struct liveupdate_file_handler;
> > > > +struct liveupdate_session;
> > >
> > > Why struct liveupdate_session is a part of public LUO API?
> >
> > It is an obscure version of private "struct luo_session", in order to
> > give subsystem access to:
> > liveupdate_get_file_incoming(s, token, filep)
> > liveupdate_get_token_outgoing(s, file, tokenp)
> >
> > For example, if your FD depends on another FD within a session, you
> > can check if another FD is already preserved via
> > liveupdate_get_token_outgoing(), and during retrieval time you can
> > retrieve the "struct file" for your dependency.
>
> And it's essentially unused right now.

I am going to move this API to the end of the series, next to FLB :-)

>
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +
> > > > +exit_err:
> > > > +     fput(file);
> > > > +     luo_session_free_files_mem(session);
> > >
> > > The error handling in this function is a mess. Pasha, please, please,=
 use
> > > goto consistently.
> >
> > How is this a mess? There is a single exit_err destination, no
> > exception, no early returns except at the very top of the function
> > where we do early returns before fget() which makes total sense.
> >
> > Do you want to add a separate destination for
> > luo_session_free_files_mem() ? But that is not necessary, in many
> > places it is considered totally reasonable for free(NULL) to work
> > correctly...
>
> You have a mix of releasing resources with goto or inside if (err).
> And while basic free() primitives like kfree() and vfree() work correctly
> with NULL as a parameter, luo_session_free_files_mem() is already not a
> basic primitive and it may grow with a time. It already has two condition=
s
> that essentially prevent anything from freeing and this will grow with th=
e
> time.
>
> So yes, I want a separate goto destination for freeing each resource and =
a
> goto for
>
>         err =3D fh->ops->preserve(&args);
>         if (err)

Thanks, I made the change.

>
> case.
>
> > > > +             luo_file =3D kzalloc(sizeof(*luo_file), GFP_KERNEL);
> > > > +             if (!luo_file)
> > > > +                     return -ENOMEM;
> > >
> > > Shouldn't we free files allocated on the previous iterations?
> >
> > No, for the same reason explained in luo_session.c :-)
>
> A comment here as well please :)

Done

>
> > > > +int liveupdate_get_file_incoming(struct liveupdate_session *s, u64=
 token,
> > > > +                              struct file **filep)
> > > > +{
> > >
> > > Ditto.
> >
> > These two functions are part of the public API allowing dependency
> > tracking for vfio->iommu->memfd during preservation.
>
> So like with FLB, until we get actual users for them they are dead code.
> And until it's clear how exactly dependency tracking for vfio->iommu->mem=
fd
> will work, we won't know if this API is useful at all or we'll need
> something else in the end.

SGTM

>
> --
> Sincerely yours,
> Mike.

