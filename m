Return-Path: <linux-fsdevel+bounces-12351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9945D85E8ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29224285D7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 20:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDC986ACA;
	Wed, 21 Feb 2024 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdhjuIFd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8233883CB2;
	Wed, 21 Feb 2024 20:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708546756; cv=none; b=Bd5SZWLx5+xDSJyEMo6IbpbxK9zJSpXKVwtROsDDLHhoHExY959r28uBeThA/kAsvdnQMAOwQv3NuHCRLWXvJwwrxx+aXGa2nGiufK+5KVKcxLqZd/0aENx52wao3V0K00fv94sbcynvtkg1hdH27pSJV1dx3qpOR6hyOveZQfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708546756; c=relaxed/simple;
	bh=3MLf9ApObXt/rf0vuQJhZzlgEUk2/WyJwumEOjHoveg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pp56Q4hBLpzHqR9Ss285kKOKDzqw9UaTgQuDlGYb3brJg6oZrN1oKtFbmb4wAll3+xntmcoTp0jWpPzH3Px+aHY4oCE3ezGZBUpH8gUsHZ6tEmhDLbhIAt2FkKjE1THqkjjUAeOL20vh5F/t6aXzmmlRcHPcK+NXC33g7G8xAAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdhjuIFd; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcdb210cb6aso7881063276.2;
        Wed, 21 Feb 2024 12:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708546753; x=1709151553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dC0/jGGGg/HFaRyL81RjL7rrIVZv2xHBQs/cZSwhbtU=;
        b=WdhjuIFdX5/aCksBsOFxtsdSc0c1X7mZdRqVIt8SO/oS6EPcmTGBkOA3ztXcJkTupW
         Qlh12ZYPett2Oar79wVhk7F4FPXoANwr58Yc0X4d4KH8Ocz6Mvd9PGbmQxGt4qPgGLi/
         j+jPpSN9lk84L1N24eJpF+qpDf5BrwvuYDuw0ojutv/VBbdfzBRNTrrqWotziOUNWbMi
         PZL6901rAkqGRmBf5UgSIbIGWBfA3T08gXVRQNjN0CNdhXSsxooInZ6q7flxNMoOJ5lc
         IvdKgJu/uhokc6C4j7KSmmznLB06kienmN5fx4byi+TSEhFkYig36f+xcRtagMDBHN+0
         DR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708546753; x=1709151553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dC0/jGGGg/HFaRyL81RjL7rrIVZv2xHBQs/cZSwhbtU=;
        b=RxPzYfn/zEUApm6h+yIWipzzYO5RpOfPp6RrFgpQjUAHed+fPwbyW2gWjVjD2Vkb6t
         YcAi9ehMW1PwvQxTiimW2qsJdw3mgk636YH8FznPZENHMQjLQJd1DQR/HwktlUkQpLpw
         hE7dVC7zqsfWJVNGaVWWWBkm9gbYkGk/RUvFe29cSGpjEFtbO6RZkKfzI0kJwEgXvTZy
         /lEcnKqKzsttL/eFQ0eIw6/dAM+Ocsuf02DBCHF0PjUQ3JXIUzbKsf95NVkDYrhwArB6
         0+dbTyBgZRS+q6Z9LJ5E/22XPzOkiDUzpvG3XmzGRwUkcp34mWBBxO1JUVukAYcn3MNT
         xmvg==
X-Forwarded-Encrypted: i=1; AJvYcCWmt5XWAvh1ChutUM3+fhutuTOn+rIk6TJBtgdBKk7Zl6Ik2JYW/qahUI8mdLjIXzJWUncx8f7ReDsFMacxkZ5kq/itemaSZ7ErTWMjprdXayImL3oExGMRjUvkaEhx+DE+sHUl1YLLr8C77no2v5MA+hDQKYYzaiAJApjsbPAekW8kTAqOo1TikAh7cb1ZlUY0zjDkfJlm70xcV1UibdJ1RBoMjmCJIlwz3fajmOHTKlqZxUmBWOmun35wgcr8QkLXTc8=
X-Gm-Message-State: AOJu0YzQ+xaiWJ//9A9xGUVEh4r+q6QK+wuJhCKL67xkF4Ji5FxvFbWZ
	WXDseAdsCl2e9QHj+UTQMz4XmOybTgsexFVtKpezRxCLjDNnj/xP6UovtxME6Kz1HAS5ohHyi9w
	/pep9/knc4UVVL5o4PFokJ2RmTNU=
X-Google-Smtp-Source: AGHT+IH3LQerluMYb9fAN1mFFrYm7uBDz1sUFvXpU3AHFaytahksdyc6iEy7q2HkrUujPZEoOh6XClpzAjLcebGmCEk=
X-Received: by 2002:a25:a543:0:b0:dc7:497e:cddf with SMTP id
 h61-20020a25a543000000b00dc7497ecddfmr380363ybi.33.1708546753425; Wed, 21 Feb
 2024 12:19:13 -0800 (PST)
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
In-Reply-To: <e3a432c0fa9f5fe837e9d2fc7b36304709a34428.camel@intel.com>
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Wed, 21 Feb 2024 12:18:37 -0800
Message-ID: <CAMe9rOoUO-D7Uoj9s3eq+w9pJBZ=iucEDpU4hqtJYtPmW5T4dQ@mail.gmail.com>
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

On Wed, Feb 21, 2024 at 11:22=E2=80=AFAM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Wed, 2024-02-21 at 14:06 -0500, dalias@libc.org wrote:
> > Due to arbitrarily nestable signal frames, no, this does not suffice.
> > An interrupted operation using the lock could be arbitrarily delayed,
> > even never execute again, making any call to dlopen deadlock.
>
> Doh! Yep, it is not robust to this. The only thing that could be done
> would be a timeout in dlopen(). Which would make the whole thing just
> better than nothing.
>
> >
> > >
> >
> > It's fine to turn RDSSP into an actual emulated read of the SSP, or
> > at
> > least an emulated load of zero so that uninitialized data is not left
> > in the target register.
>
> We can't intercept RDSSP, but it becomes a NOP by default. (disclaimer
> x86-only knowledge).
>
> >  If doing the latter, code working with the
> > shadow stack just needs to be prepared for the possibility that it
> > could be async-disabled, and check the return value.
> >
> > I have not looked at all the instructions that become #UD but I
> > suspect they all have reasonable trivial ways to implement a
> > "disabled" version of them that userspace can act upon reasonably.
>
> This would have to be thought through functionally and performance
> wise. I'm not opposed if can come up with a fully fleshed out plan. How
> serious are you in pursuing musl support, if we had something like
> this?
>
> HJ, any thoughts on whether glibc would use this as well?

Assuming that we are talking about permissive mode,  if kernel can
suppress UD, we don't need to disable SHSTK.   Glibc can enable
ARCH_SHSTK_SUPPRESS_UD instead.

> It is probably worth mentioning that from the security side (as Mark
> mentioned there is always tension in the tradeoffs on these features),
> permissive mode is seen by some as something that weakens security too
> much. Apps could call dlopen() on a known unsupported DSO before doing
> ROP. I don't know if you have any musl users with specific shadow stack
> use cases to ask about this.



--=20
H.J.

