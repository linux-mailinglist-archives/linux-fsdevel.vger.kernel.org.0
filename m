Return-Path: <linux-fsdevel+bounces-12358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D49985E9B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 22:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603BF1C249CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053631272CC;
	Wed, 21 Feb 2024 21:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6n/OMIH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF623126F0F;
	Wed, 21 Feb 2024 21:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550007; cv=none; b=t8vHtUoRd6TzTWfmm9zGFZB5pQLlEM5z1pMuVwveP2GpRHOrI3Vbx3Xfq9NFzbDVMoyKTKQkF9zsXIM3QqeZF17gaYBgrPYmD3sRaqvy2aziU7GYwwewrwZK7DPzIaHVG84qr7n9B/ls0ILGTx/o/wRsKSOO5QbN6sVD3HXA+xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550007; c=relaxed/simple;
	bh=VOXFL6Fr7ubdKKttigCoBGrhHgzzc2o+UtL3EmWAn2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVnI+8usH6SNx9CfwEmayj9/PMRpPgWOryAAnHh19JfmgK8zReY1H4plyXfUCvaiWZS+6IDjDzLIz2tTfpq713P2WY3kbnU7rhhJTbnCotG6hW8kj79YHYkmZN7SF+Jp8lJ80XNYu5oeXe5bjGmLJWHNY4QYn51jMZBBpl7ej4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6n/OMIH; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d7881b1843so9000045ad.3;
        Wed, 21 Feb 2024 13:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708550005; x=1709154805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOe8CQ1Fe+hIMHxzKX7XWlTimkc/iuaovpymvDphgj4=;
        b=M6n/OMIH/jYZ4aDE0h/vIdcXoPWdKuXb95YWmtq84Zodgyf5J0VTtZty0eMHm4uDU7
         wMIO7jnNlSEWiPaFkpNokGQVWYm0DSxFQydVO1jm0A/xAXt5yoa//YZu23xZhgV8il3w
         HqrmszxCtB0cjmzDFSFNiP4HHr1fPFyP5qrZhxafJ+baQD2HvrIwkOZT6DfBaT608pRV
         eqcgmQhjlYBiKUx3xv79LMMPLGfpuqG1TyU7Q1QjGelRn7NzZdqbukWk4fPm+0zmq8yC
         ScpMlVuMYYjce57CQDanc17QwvwaThN+MQJ1RWCCBapx36LORLIFdU5I3K8Q/AoFpJbj
         pNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708550005; x=1709154805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOe8CQ1Fe+hIMHxzKX7XWlTimkc/iuaovpymvDphgj4=;
        b=siGJDOZt3tAXyImTbL0f/U9wHYkRUNX5uLr5E0itYzkDlVJ2b0VKiuC+XV7KOZwXim
         OPl9H8QBBtLL0m/Nuek2V2wR5isaVjYmTwl6A9xdJY2BfYNImMdIVTAy/KQsHDy49gfL
         +02pjivykzt/t1pL6XHtX/oOtd2K8VeJXu6m9OgYYTlbfnjfu2Hrw/GuFJu1MWmjiWPE
         WmlCwbeGA3z4StuBvTtCnqiKsBHE2JuG/+FgB2VxoeiE6BNfALH7+JPs0n0x7yWvENXb
         w2UeWAeHkd3sNKfdIhwZpvl1rQMvZ/3dgx1+1CKQ04GQx0leJzGK/pd8q8P1P/7h0trk
         E9dg==
X-Forwarded-Encrypted: i=1; AJvYcCWLUuLZx6neTPVNVEbSmOY49pu/cHUwpcH/dHQ61phE5WD/U3TqcX2Rx/wF4v0+07YxaPb/tqhgQVIZ68oG8pNqB+KCHVF1/rzOksrWpgl4PCxWcHfvw4WveXkOxQJN0U4k2/AWf3YX8L+6/bKvyhN2qXWjA5bdeDeh0jajc04EerRqrD8JUjz0/jLZGvkxxorhZDwNSrd6VKakxd85Tcl7BFr17O5nAJ48l5QnLx9aL3h+CLywXDKErJdkK9IS7sJPqCA=
X-Gm-Message-State: AOJu0YxAa8uvlvj7jkGG/xNQZM+kCvV378b5vRjFb33Cb+I6pEUl/Wml
	KZC5ktQz5yjHD9By1Ic0Y6Cq3lYmvSehxQHqrGgLF+dtEtTdHFOmEHFbaTu8hmjxYHCZaYVpJcX
	WJdBh3CTUSpGP1gD+/nBfz3VwOMc=
X-Google-Smtp-Source: AGHT+IGhaBTSHgXe8Ob108OXBWpnIgIuyMFeVcBje1ELrXkN/4PqTmNclSgXiBJchbcFk4tPPGc/HanP+MFeXILDTxM=
X-Received: by 2002:a17:90a:d911:b0:299:e9d1:fc52 with SMTP id
 c17-20020a17090ad91100b00299e9d1fc52mr6242900pjv.0.1708550004870; Wed, 21 Feb
 2024 13:13:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220235415.GP4163@brightrain.aerifal.cx> <a57d6c7eada4b9a7c35addbc8556f5b53a0c3e6f.camel@intel.com>
 <20240221012736.GQ4163@brightrain.aerifal.cx> <d18f060d-37ac-48b1-9f67-a5c5db79b34e@sirena.org.uk>
 <20240221145800.GR4163@brightrain.aerifal.cx> <4a3809e8-61b2-4341-a868-292ba6e64e8a@sirena.org.uk>
 <20240221175717.GS4163@brightrain.aerifal.cx> <f4a54297767eb098d903404cbe8860d655d79bed.camel@intel.com>
 <20240221183055.GT4163@brightrain.aerifal.cx> <c3085fbe10193dfe59b25bc7da776e60779b0e8c.camel@intel.com>
 <20240221190639.GU4163@brightrain.aerifal.cx> <e3a432c0fa9f5fe837e9d2fc7b36304709a34428.camel@intel.com>
 <CAMe9rOoUO-D7Uoj9s3eq+w9pJBZ=iucEDpU4hqtJYtPmW5T4dQ@mail.gmail.com> <CAMe9rOr1frpnKSnVQrqeiKK3aAR3xpG=VAiPYLOR9OpHnHhYUw@mail.gmail.com>
In-Reply-To: <CAMe9rOr1frpnKSnVQrqeiKK3aAR3xpG=VAiPYLOR9OpHnHhYUw@mail.gmail.com>
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Wed, 21 Feb 2024 13:12:47 -0800
Message-ID: <CAMe9rOoo55aFHHuLf=zdc4PNvU+Tu9rtpWaMUdRL=JtHGbE3pA@mail.gmail.com>
Subject: Re: [musl] Re: [PATCH v8 00/38] arm64/gcs: Provide support for GCS in userspace
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "dalias@libc.org" <dalias@libc.org>, 
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, 
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>, 
	"musl@lists.openwall.com" <musl@lists.openwall.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, "corbet@lwn.net" <corbet@lwn.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "broonie@kernel.org" <broonie@kernel.org>, 
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"debug@rivosinc.com" <debug@rivosinc.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
	"shuah@kernel.org" <shuah@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "maz@kernel.org" <maz@kernel.org>, 
	"oleg@redhat.com" <oleg@redhat.com>, "fweimer@redhat.com" <fweimer@redhat.com>, 
	"keescook@chromium.org" <keescook@chromium.org>, "james.morse@arm.com" <james.morse@arm.com>, 
	"ebiederm@xmission.com" <ebiederm@xmission.com>, "will@kernel.org" <will@kernel.org>, 
	"brauner@kernel.org" <brauner@kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "ardb@kernel.org" <ardb@kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"thiago.bauermann@linaro.org" <thiago.bauermann@linaro.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "sorear@fastmail.com" <sorear@fastmail.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 12:25=E2=80=AFPM H.J. Lu <hjl.tools@gmail.com> wrot=
e:
>
> On Wed, Feb 21, 2024 at 12:18=E2=80=AFPM H.J. Lu <hjl.tools@gmail.com> wr=
ote:
> >
> > On Wed, Feb 21, 2024 at 11:22=E2=80=AFAM Edgecombe, Rick P
> > <rick.p.edgecombe@intel.com> wrote:
> > >
> > > On Wed, 2024-02-21 at 14:06 -0500, dalias@libc.org wrote:
> > > > Due to arbitrarily nestable signal frames, no, this does not suffic=
e.
> > > > An interrupted operation using the lock could be arbitrarily delaye=
d,
> > > > even never execute again, making any call to dlopen deadlock.
> > >
> > > Doh! Yep, it is not robust to this. The only thing that could be done
> > > would be a timeout in dlopen(). Which would make the whole thing just
> > > better than nothing.
> > >
> > > >
> > > > >
> > > >
> > > > It's fine to turn RDSSP into an actual emulated read of the SSP, or
> > > > at
> > > > least an emulated load of zero so that uninitialized data is not le=
ft
> > > > in the target register.
> > >
> > > We can't intercept RDSSP, but it becomes a NOP by default. (disclaime=
r
> > > x86-only knowledge).
> > >
> > > >  If doing the latter, code working with the
> > > > shadow stack just needs to be prepared for the possibility that it
> > > > could be async-disabled, and check the return value.
> > > >
> > > > I have not looked at all the instructions that become #UD but I
> > > > suspect they all have reasonable trivial ways to implement a
> > > > "disabled" version of them that userspace can act upon reasonably.
> > >
> > > This would have to be thought through functionally and performance
> > > wise. I'm not opposed if can come up with a fully fleshed out plan. H=
ow
> > > serious are you in pursuing musl support, if we had something like
> > > this?
> > >
> > > HJ, any thoughts on whether glibc would use this as well?
> >
> > Assuming that we are talking about permissive mode,  if kernel can
> > suppress UD, we don't need to disable SHSTK.   Glibc can enable
> > ARCH_SHSTK_SUPPRESS_UD instead.
>
> Kernel must suppress all possible SHSTK UDs.

If SHSTK is disabled by kernel, not by glibc,  there can be 2 issues:

1.  Glibc and kernel may be out of sync on SHSTK.
2.  When kernel disables SHSTK, glibc may be in the middle of reading
shadow stack in longjmp, searching for a restore token.

> > > It is probably worth mentioning that from the security side (as Mark
> > > mentioned there is always tension in the tradeoffs on these features)=
,
> > > permissive mode is seen by some as something that weakens security to=
o
> > > much. Apps could call dlopen() on a known unsupported DSO before doin=
g
> > > ROP. I don't know if you have any musl users with specific shadow sta=
ck
> > > use cases to ask about this.
> >
> >
> >
> > --
> > H.J.
>
>
>
> --
> H.J.



--=20
H.J.

