Return-Path: <linux-fsdevel+bounces-15164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA26887A28
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 20:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2475A2816C4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 19:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581125A0F8;
	Sat, 23 Mar 2024 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaB99T0h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620FE59149;
	Sat, 23 Mar 2024 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711221261; cv=none; b=ZprRYzRQ5oFvJbHIMcHSLnXq3vsdCaX+Lq12H8Z2o+uveS+c1M3TPlP9j6ssrYb0Ta8djhFBPmPKPsJx6VO134wL0TTz7w7ej2K4gylpxzObUHsCF1v0aY/hM1sEC6fL7VU/Ckuz7uuiYgBDpqWG2ANhm7/s3eVOKA64RxZ+pZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711221261; c=relaxed/simple;
	bh=m18NgGo2FWorgOirXh/+wwWWyKLlg/fRucbQqieOhHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZMMYyFugpUtb8toW7/G/6WpIQEeV/fgJwGG84gE9PKVKKWZTTDb1tmyPM3NrgDPMjelq7APFX9qMaOkml2FS0bwlWt2EhyGR7Z+w7+Ozf8WeBg6zcNM+EyiZYE8DGCGzvnKMkn2FFreTwyIcbKAO+dJKXQl4CWXpgczjSa09+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZaB99T0h; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29c5f8bc830so2105219a91.2;
        Sat, 23 Mar 2024 12:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711221260; x=1711826060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m18NgGo2FWorgOirXh/+wwWWyKLlg/fRucbQqieOhHM=;
        b=ZaB99T0h2cPk2KUFKw3bwld9suchWaPYpC92a96/GwDE/IfFt1x9wrI96NR3100Imm
         vAyEhnZkRM9aLdMWWbjIYqHBHSObMAd/hLD2HzVn+DMGA/PD4S5oTXNqIL1np9uDjNge
         pbW9z2i6YRfs8+BznA74SJaAYlKbPO3xtTuswRLnFsb1HABIU6JYOuRyvs3Gi0mE8+Tr
         V1KopbfnaaFwTcsW5qmXwRIWvIMWgs1I9lmUARbk5I2CZSbLdOpEHHt6zcJMhFGyIfUd
         XJAVDk5eVFIcxRt/2TK7wUM2tLB0F7EwNNN5nAaYROkcSdtSP7STi++oAqiUuvQEMgmJ
         H+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711221260; x=1711826060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m18NgGo2FWorgOirXh/+wwWWyKLlg/fRucbQqieOhHM=;
        b=r6OimSkqzVVV4F+eiZHxhvNkFKYW/UrB/ys0bzdk7So5euto7lUeRV711uf7xfa5mb
         mWEs2254RRE9tJaYngK+Xms2G04I7bmITB9x3e4D/xOqRNyr7EGDscKkDU4TV05A/63Y
         GT6w/ejzrozPHvLfrsZhaP1xxUhYWg++LGHO87Om+GNkmdcHE1aPRpsgU4/A6yvbiAcL
         nIXtHu1FrpY2fgook5kH27ed/zMB8WpJM4iFSYOU/pJ2DHzCv0SkCLY5hXqQkiuEOfUY
         xqmJxaUdC5dLcILM7njUnmZzgH00JTwOXBEcdSo/n+hatcTmoq6ahw8nl6a+lLkPFVCg
         Hgkg==
X-Forwarded-Encrypted: i=1; AJvYcCU7qbL8Xr5qcg1fn3RByH1yFUuswJMw/112tjZC3dZxQQgm33uyE7EOR34Os+K5kQkPvZ4a13k24jGvDf30l5ClckN8zBhamsWQCLTcBwwV3Q45iGMXpfxYgZ3YHz+OhZo1jyTs+0Rng0dUJ4TA6goBcD3Ko8ZrC7eMed4icPWs7Yqfo7HjWdTeKfc1P0RWN630/9YE5CrHcASJs1CoMbEU9VVIJ111yw==
X-Gm-Message-State: AOJu0Yz7jREwOnL1qx7y9vBTMWjknviq6O/MSN1jkUOWztpY3IUEnolK
	97MPiufYb1ZQPPQsZ8voVOcOGdBRLOmEbno68Bbz8ntT/dGjF3RdxfDXi/JsikrRw+4fc1FPrIo
	JTERyTDJcAyjphNqEHmb7clwacsw+F5buSmc=
X-Google-Smtp-Source: AGHT+IFieHr7GIKgA8NSDY8f0+kxSP5yP41UkldkdC6ObMKKBwdCbcEVZVYtXOFgAvSxmZmwCpgD/3wOXn3BFAmZ1uQ=
X-Received: by 2002:a17:90b:190f:b0:2a0:40df:fa37 with SMTP id
 mp15-20020a17090b190f00b002a040dffa37mr2297623pjb.39.1711221259633; Sat, 23
 Mar 2024 12:14:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322233838.868874-1-boqun.feng@gmail.com> <20240322233838.868874-2-boqun.feng@gmail.com>
 <068a5983-8216-48a5-9eb5-784a42026836@lunn.ch> <Zf4cP6lx7LHmt3dz@boqun-archlinux>
In-Reply-To: <Zf4cP6lx7LHmt3dz@boqun-archlinux>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 23 Mar 2024 20:13:56 +0100
Message-ID: <CANiq72=tB=uxaL9XGbnTBpXmj1pXEbxHQJDtAcA_yDiLjTVkRA@mail.gmail.com>
Subject: Re: [WIP 1/3] rust: Introduce atomic module
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Alan Stern <stern@rowland.harvard.edu>, 
	Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, 
	David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, 
	Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, kent.overstreet@gmail.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, torvalds@linux-foundation.org, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 1:03=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> I can continue to look an elegant way, now since we compile our own
> `core` crate (where Rust atomic library locates), we can certain do a
> sed trick to exclude the atomic code from Rust. It's pretty hacky, but
> maybe others know how to teach linter to help.

Yeah, but it requires copying the source and so on, like we did for
`rusttest`. I would prefer to avoid another hack like that though (and
the plan is to get rid of the existing hack anyway).

Cheers,
Miguel

