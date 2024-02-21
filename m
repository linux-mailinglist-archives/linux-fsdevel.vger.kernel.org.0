Return-Path: <linux-fsdevel+bounces-12352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B112F85E8FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2039E1F26FDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 20:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45B886AE5;
	Wed, 21 Feb 2024 20:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXJvB53F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A63A85958;
	Wed, 21 Feb 2024 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708547145; cv=none; b=CK9hIprvKLoxuh/ciZlvw/bskDc71VqBCVABOguiAQZOxD6kfuYF82RTTW2SXtFxz15YXWA+xSuVUoAdpgh+5P+e8ETLpiRdaBQbKZwaBiWfZ1kAynslmz3EERw3bX9dQ/6a3sBt9QeEq3Ze2PrHXTYCuQnxwT3YuihtIvWRyk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708547145; c=relaxed/simple;
	bh=ctqglnnCAjYhrU7DgoFcCYpe21K+LqH9msD+JxCEk8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1fB5bGYpKLnQURZ9fqXLszzzd4WZpv2Z21mWVqfCELa/XF5Dd8X0BidG1y7OJk2Q3ezKzZOvEmVp+tTzjZyDAjWB8n6Vu52F1RCDhXSO/kg0ak+iwUpy5u1dwu43wMCsOwq4AQ+Rfgtoq9NX6AAkgUXBadVHq/c853RdhFLgCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXJvB53F; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so7347067276.2;
        Wed, 21 Feb 2024 12:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708547142; x=1709151942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUZZ04EW9/qUv3qL29C/Oq6T36PR4Q6EbgcYZzQ1nWg=;
        b=CXJvB53FdF2inK8jk9wO2zptQSqDu+Zxhe3+4/pIN1AY7sFtJ1Pk8QAcId214t79od
         HF+YAY2kLt26GZ/8tKP3vXlxmb2rWXpKTqVCGxuQx3BmK4S0da2XtlQa2oGddEA6vo+A
         XmXXIm7yaLBlIAGgJfjaCU9cwdgehlCTAeoUkTDDr6i4CANDXjFLzjaJqMfjjFjuZrgg
         6EMbYDF/pacSNmj7Uhc43mlc8RytVfwmye/sGndpiZSzXPoz9jOiKe376nVyEfBycMKB
         u7DhtFsJYxZ/wPEQlcSQ2DxTc6Ze7c6e5I6hFy3j9wvKFA4Qvb3BHC1EM6Qny0aKeanD
         ofVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708547142; x=1709151942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUZZ04EW9/qUv3qL29C/Oq6T36PR4Q6EbgcYZzQ1nWg=;
        b=ZYiLcqP8Eh0plARBI8zkjPWq0/X1WQt42I6TyRfIrMFl+2uYXWfC0f1JBqRU/SdCAY
         Z12470ai2RvrzCRRvn1WXQgQfMPTmYWxymhidwd6V4YrDDg46ImKk3UQIhOu/tLwft4s
         sPoDjj0GBcULLxt11p8JO8xsit+DfLymBE8XF7wP3C6bcb29JiSDWz5zI0FQvuB4zVTw
         vLUqw34XxSe+9H6Hk7o+mlGoqEdeAbKT6AWC7PeBnIw816PNIRKW3LLWnuJtsBrS3ilj
         2dzWC0P0wmqzNHBDkOQJnrIuv2tqVzGWt318yWhblVaSOy3c9+h4Izla94pdCLeWSG8Z
         vnYg==
X-Forwarded-Encrypted: i=1; AJvYcCXOuIpvE5g86kH2IFKZlvjQRNuQVtImbh+wE2dAhAOv4fghoIpfInBQztIA0lokalOS6dlEcN2CadVsayad998XjAlMk3Yzxla/qO+baw1LznXjttK6LCjBYEX+WuINQVbYGYFS6M8WNLhrh6Vq8urSZNDwgOewMYxLTEKgxlrwcX4TN/EfPponbzxJMXMPG/PDgyEc8jdpLPAhc0L+wytkvAqq06xF5BNLYltCBugdatoGWVvM8+YgUc8zH5xobjaJLbw=
X-Gm-Message-State: AOJu0YzV1y/KGW6NlgEMnz0XxfOsWrfh3Tc06CFG3revtGvcBPbvhw8W
	LBqoCzdcD6a/jQKEpb/MjXlWog1lUpu6q55jIhZvPpPPjKnkOmvc5ddMGG+ZgsvuG4bhb5dIVwG
	PNmiCCraExD+nhPcha9qpXT490QU=
X-Google-Smtp-Source: AGHT+IHulW4fhdXYsgZSX5RqxAxS95jeQrXQWkLqG01c1LAdpuKIFalEI/fkzodUlC0P2/EUntFG0c+fYBgzVA4WA2w=
X-Received: by 2002:a25:1f8b:0:b0:dc7:46ef:8b9e with SMTP id
 f133-20020a251f8b000000b00dc746ef8b9emr389206ybf.29.1708547142617; Wed, 21
 Feb 2024 12:25:42 -0800 (PST)
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
 <CAMe9rOoUO-D7Uoj9s3eq+w9pJBZ=iucEDpU4hqtJYtPmW5T4dQ@mail.gmail.com>
In-Reply-To: <CAMe9rOoUO-D7Uoj9s3eq+w9pJBZ=iucEDpU4hqtJYtPmW5T4dQ@mail.gmail.com>
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Wed, 21 Feb 2024 12:25:06 -0800
Message-ID: <CAMe9rOr1frpnKSnVQrqeiKK3aAR3xpG=VAiPYLOR9OpHnHhYUw@mail.gmail.com>
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

On Wed, Feb 21, 2024 at 12:18=E2=80=AFPM H.J. Lu <hjl.tools@gmail.com> wrot=
e:
>
> On Wed, Feb 21, 2024 at 11:22=E2=80=AFAM Edgecombe, Rick P
> <rick.p.edgecombe@intel.com> wrote:
> >
> > On Wed, 2024-02-21 at 14:06 -0500, dalias@libc.org wrote:
> > > Due to arbitrarily nestable signal frames, no, this does not suffice.
> > > An interrupted operation using the lock could be arbitrarily delayed,
> > > even never execute again, making any call to dlopen deadlock.
> >
> > Doh! Yep, it is not robust to this. The only thing that could be done
> > would be a timeout in dlopen(). Which would make the whole thing just
> > better than nothing.
> >
> > >
> > > >
> > >
> > > It's fine to turn RDSSP into an actual emulated read of the SSP, or
> > > at
> > > least an emulated load of zero so that uninitialized data is not left
> > > in the target register.
> >
> > We can't intercept RDSSP, but it becomes a NOP by default. (disclaimer
> > x86-only knowledge).
> >
> > >  If doing the latter, code working with the
> > > shadow stack just needs to be prepared for the possibility that it
> > > could be async-disabled, and check the return value.
> > >
> > > I have not looked at all the instructions that become #UD but I
> > > suspect they all have reasonable trivial ways to implement a
> > > "disabled" version of them that userspace can act upon reasonably.
> >
> > This would have to be thought through functionally and performance
> > wise. I'm not opposed if can come up with a fully fleshed out plan. How
> > serious are you in pursuing musl support, if we had something like
> > this?
> >
> > HJ, any thoughts on whether glibc would use this as well?
>
> Assuming that we are talking about permissive mode,  if kernel can
> suppress UD, we don't need to disable SHSTK.   Glibc can enable
> ARCH_SHSTK_SUPPRESS_UD instead.

Kernel must suppress all possible SHSTK UDs.

> > It is probably worth mentioning that from the security side (as Mark
> > mentioned there is always tension in the tradeoffs on these features),
> > permissive mode is seen by some as something that weakens security too
> > much. Apps could call dlopen() on a known unsupported DSO before doing
> > ROP. I don't know if you have any musl users with specific shadow stack
> > use cases to ask about this.
>
>
>
> --
> H.J.



--=20
H.J.

