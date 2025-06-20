Return-Path: <linux-fsdevel+bounces-52356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB79AE22CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 21:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46C057B0EAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 19:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB963221F3C;
	Fri, 20 Jun 2025 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpwzTw9I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076AD136988;
	Fri, 20 Jun 2025 19:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750447683; cv=none; b=GiFbbhRIiEZl47ZiCdcsqQk6JAPnkWcG06QHhdh5tdohtTeo4xEs2z9D6H4g8UeCB/xaa61mYSk65ql8Ha4xDCYOmbk/FILV9nH+r0hgQTc/dGC743biaJSTSa9iFZW1pPR5L+TBwZ1lz+lUIeuiFSBuR2SZbfs1DQBvbseHyq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750447683; c=relaxed/simple;
	bh=cn/6JcRaDFX87TWF9svpZm2FBoNjx7rdRv/7BeBn7Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/R3xAI5QuJyrqVZ1MtEQuvvQd18i9O6OErfdi82WprzUPs1hbGtbTWBIqpgeaC7HAmrcoR46Rt45Mbus4Y+91vndH2pA6+kla8PnUpkSeGPvXdpi2LItQueCsj5nCju7Ez4+SCB5gCdhVqJchpKlK96lRErnD6mBOCk9AouPsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpwzTw9I; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b31d4886c50so319921a12.2;
        Fri, 20 Jun 2025 12:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750447681; x=1751052481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6O+NLJYl3DeRxEV2J0Dr2QZh4LtEyIweUhFcpRxzf5M=;
        b=PpwzTw9I5muT7LbXm9texmbzy3X2vGdjT/OwrjOiyDBmn0I6QNZJqMneQScO/5XcZn
         8+6M+6l0DaI/QU3uKIu4VsfZzFaC80l1AL7ID50AzakwT2zlxdNNwN1cTRwIAqE/0Gss
         p4vWe2JbJjrLDt2tkpAqmTUaxm+mvv6Nrml4HwOMKk5popJSe4Pv8wMvWMvrQNmUqSVI
         Anik8gggHDbG0IBoUzDajN4kMPNDK9qb4+lZ4Lc6LyXUC9X8yHzJiIN7MDIWi6oUVtX3
         Sf2va5H7aQ16EvFXPbS/UqlkbxrSVcICMbPdNYE092X1X21xK0gQuM3Hi0IqCgnkPMVB
         XKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750447681; x=1751052481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6O+NLJYl3DeRxEV2J0Dr2QZh4LtEyIweUhFcpRxzf5M=;
        b=uZNOcCWiT1ZbJSTzS/qcvDGqS/CuG50yhFMh6D1kFpM61f6BfoI0DRRAPakcAhEsNr
         5fbAHjEDodAe/T5fjUWMVTD4cbSg5ScITHQVPHyS+lVjtXCRvQVlP7AT7HW4+gpOje9g
         YWofm1s7a/Fx0sAL2EssCHsyQzF2RYh6zP9a4qDbWYv7ta/WIExZluHV2TzJAUb2LGkw
         F2wGICwcQBdMIWTsp8JNO6Vjb/SVXA9cD127+0GrNG1EhhVnzJt4LoM/906XIK/qyFtb
         vD3GMkgTLKlEyMHiwVvSvIbJKWj61NR83A9j+SZJ9p2WJXpY7JdPJHBxURChP88WDYjz
         bz0w==
X-Forwarded-Encrypted: i=1; AJvYcCWeDTXi+11BmpBLZUb4qlWgHDhLkmPx+hHY0f2TSdGwUNeVvBMJuPsDYPb8gz8s/wZfC3KIvjUnmfEpqdK3UVA=@vger.kernel.org, AJvYcCWsSILxhAkUXjeVQNufgiDYjBYMR1zvgn/bpe+c9t734kEcjPM1E0Y0AHoAodzRuqJ+gTbHMnAQNWrIsbOm@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Z43roVkrp8I1VzX1+sGDMQ4LiBM8zCdcdqZoktzjp+Bt2SkX
	JSs7iSXzq8uCCye/PcDAcxh2TjdNDGG1sNqZ+7axZwPVWs552c1Dge2vwRtm1RyqnVD4XL8zuES
	jkOL0TkK/5JzqZYr3oamXtVSDgOwykDw=
X-Gm-Gg: ASbGnctJAKx8yhhPUqzoWYTJ3JjqkLDmptijUrI9OQqRFgsAY+RcfXFVVfqjJVUknc6
	xoiOXH6R82scECzoat3mZD6NhP/3fEk7GPu1pIrpPylHcCz06SRmdCM4sKRaEX5SYeFvmqVMD4R
	8e7PKnfVtn67lDoCSGNauYU9XLNdOvrecj14fE4com2hA=
X-Google-Smtp-Source: AGHT+IG4MKXW8zlr2z6uyS9Q0XIyvGscIIVe3mG6CNxVp8fAjfDiRz61DAxviJcZkiPUVh8fuZcFI6C8trKbZxOdYB4=
X-Received: by 2002:a17:90a:fc48:b0:310:cf92:7899 with SMTP id
 98e67ed59e1d1-3159d8ca80dmr2407666a91.3.1750447681176; Fri, 20 Jun 2025
 12:28:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d5ea8adb198eb6b6d2f6accaf044b543631f7a72.camel@ibm.com>
 <4fce1d92-4b49-413d-9ed1-c29eda0753fd@vivo.com> <1ab023f2e9822926ed63f79c7ad4b0fed4b5a717.camel@ibm.com>
 <DAQREKHTS45A.98MH00SWH3PU@kernel.org> <CANiq72k5SensLERt3PkyDfDWiQsds_3GpS4nQqPPPMVSiWwSfg@mail.gmail.com>
 <c212d2e1ca41fa0f2e4bc7c6d9fe0186ca5e839e.camel@ibm.com> <CANiq72nF+Hn-vPttAYDEjRvKa+-C=pGkkAKjMQmWB78Afq4HBg@mail.gmail.com>
 <dc52fb4df4f1a54ece43c27245606b80c2b75ded.camel@ibm.com>
In-Reply-To: <dc52fb4df4f1a54ece43c27245606b80c2b75ded.camel@ibm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 20 Jun 2025 21:27:48 +0200
X-Gm-Features: Ac12FXxOhNBAMS3xCZzTiFXfQhCEl8lk1lFg-F5UYkEQESVGh2za1dYjh0fjCdY
Message-ID: <CANiq72=q2md+GBvKtT3=VBYKc9MF9hnfiBhW9Hvkhjqr50uCgA@mail.gmail.com>
Subject: Re: [RFC] Should we consider to re-write HFS/HFS+ in Rust?
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "frank.li@vivo.com" <frank.li@vivo.com>, 
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "lossin@kernel.org" <lossin@kernel.org>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Ariel Miculas <ariel.miculas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 8:10=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> I don't have plans to re-write the whole Linux kernel. :) Because, any
> particular file system driver needs to interact with VFS, memory subsyste=
m and
> block layer. So, pure Rust implementation means that everything should be=
 re-
> written in Rust. But it's mission impossible any time soon. :)

There is no need to do everything at once, but avoiding to write/use
safe abstractions completely for common facilities is not the goal.

But, to be clear, we are not suggesting rewriting VFS or others in Rust.

As for "mission impossible", a couple filesystems were prototyped on
top of the (read-only) VFS abstractions I linked. I am not saying the
abstractions are complete or that it will be easy or that HFS (not
even HFS+) is comparable to those or anything (I don't know), but you
could check them out  / try them to get a feeling for the approach.

Others may be able to tell you more about their experience with those.

> I am considering of re-writing HFS/HFS+ in Rust but still surviving in th=
e C
> implemented environment. I don't think that even VFS will be completely r=
e-
> written in Rust and adopted any time soon. So, I am talking only about HF=
S/HFS+
> "abstractions" now.

Again, nobody suggested rewriting VFS etc.. It is about abstracting
(using) existing C infrastructure.

Please look at the patches I linked above.

> Even if you have bugs in read path only, then end user will not have acce=
ss to
> data. As a result, end-user will think that data is lost anyway because t=
he data
> cannot be accessed.

That is not what I meant. If you have bugs in your read path (or,
generally, in the kernel), then you will have a big problem in both
scenarios. That is not a difference.

And, yes, you can have systems that end up losing data when fed with
untrusted/garbage data, or a user could discard their original drive
after thinking a copy was correct, and things like that.

But when you also promise to do writes properly, that introduces
complexity and new use cases -- you will have users saving new data
and expecting that to be kept no matter what, you could corrupt
existing unrelated data, and so on.

> Also, anyway, C implementation and Rust implementation needs to co-exist,=
 at
> minimum, for some time, I assume.

That depends on you as a maintainer, as well as what architectures
your current users use and so on.

But there are cases where Rust-only functionality is fine (which is
easier to justify too).

Thanks!

Cheers,
Miguel

