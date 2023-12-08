Return-Path: <linux-fsdevel+bounces-5298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0E7809C78
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 07:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C64282014
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 06:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195A7DF4A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 06:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FStLKhW4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8CE1708;
	Thu,  7 Dec 2023 21:28:21 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5c66e7eafabso1434024a12.0;
        Thu, 07 Dec 2023 21:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702013301; x=1702618101; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUGmPEbpW20dc17tUbVamxt8gw7gwKEC4FwZ3bTqHfg=;
        b=FStLKhW4VJO/dzygcS3r4iEzvjZPu+Glw17zY1SWmE5l4ww1ZYBXuPos67/TOjSLZJ
         ub36WDDJBvMdLCVm1Pst2zY9Swh2LfCt6VmaiqIBqTzj0GdhkSK2YeRTQ3AufuygWNxZ
         U0BZ5R5ex1ROxdhWh7lu56BV3xwofqbSZeSL6v9gb1SQxELsVhTfPEJFBeqLRrrG9rrQ
         CPlNoS2/CyxJPr112Wb9jVafzkr8kOksMEgIAfxIIOLAEduEbijSbOhk9VWyWgGbp39q
         HLscicbWJb0mszy0vPY6OrdsyRVDVQl8EdU8pp5XDNblwHSXAd184AsrylPtAQKs1YSd
         /HQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702013301; x=1702618101;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUGmPEbpW20dc17tUbVamxt8gw7gwKEC4FwZ3bTqHfg=;
        b=LuIavFHaFHYKDNDImX7bauqRFB56DC4YnUSEA3nFEVFx/9OS7Imck3TQ23RmpwbsRx
         Tjm1eeQESOZkM56eD8UURzeSQTET2lZLwoTUhQiQ3vRTaTVSwFLADnHBUtItfO2/D9Lo
         sPE5yuTRG5u8ZN/Pe/dQk+bVMRrp2beXsO+OAx3oyQb4lYyLU2Zbbv4SoghTigkL4RDa
         wqBGoZJ32egD5tD76Vwkg2AP4UE9wFFQgO/sNZZDq5ldis3qH827thhU06s6GeEHTf9q
         /uzwZJHJq0w/mmKPcxCTbLM33PHJElnSNJI7CeUkqQEf1o8YIhjE85/FiVfjephNgbQY
         yulA==
X-Gm-Message-State: AOJu0YyZi6gxkmztdxunMzQSC+vxEytPZWk3bCz2RDmTlxQUadsvPiS8
	VaBJeRkzr1r1AmticoEr6fI=
X-Google-Smtp-Source: AGHT+IGj1T0uSHej29ptuixe+XoVelY+Ka5cBypKJ64qn3JuPT/jgsVKS/9TR+relrXm1kDUFvCxGg==
X-Received: by 2002:a17:90b:3b50:b0:286:6cc0:caca with SMTP id ot16-20020a17090b3b5000b002866cc0cacamr3711007pjb.65.1702013301134;
        Thu, 07 Dec 2023 21:28:21 -0800 (PST)
Received: from smtpclient.apple ([2601:647:4b00:6db0:b844:97a8:fed6:b1f7])
        by smtp.gmail.com with ESMTPSA id sc1-20020a17090b510100b002867adefbd4sm848049pjb.48.2023.12.07.21.28.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Dec 2023 21:28:20 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.42\))
Subject: Re: [PATCH 5/7] rust: file: add `Kuid` wrapper
From: comex <comexk@gmail.com>
In-Reply-To: <20231130-wohle-einfuhr-1708e9c3e596@brauner>
Date: Thu, 7 Dec 2023 21:28:06 -0800
Cc: Peter Zijlstra <peterz@infradead.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>,
 Martijn Coenen <maco@android.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Carlos Llamas <cmllamas@google.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Kees Cook <keescook@chromium.org>,
 Matthew Wilcox <willy@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Daniel Xu <dxu@dxuuu.xyz>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A0BFF59C-311C-4C44-9474-65DB069387BD@gmail.com>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-5-f81afe8c7261@google.com>
 <20231129-etappen-knapp-08e2e3af539f@brauner>
 <20231129164815.GI23596@noisy.programming.kicks-ass.net>
 <20231130-wohle-einfuhr-1708e9c3e596@brauner>
To: Christian Brauner <brauner@kernel.org>
X-Mailer: Apple Mail (2.3774.300.42)



> On Nov 30, 2023, at 4:46=E2=80=AFAM, Christian Brauner =
<brauner@kernel.org> wrote:
>=20
> I wouldn't even
> complain if it they were somehow auto-generated but as you say that
> might be out of scope.

FYI, rust-bindgen got an experimental feature of this nature earlier =
this year:

https://github.com/rust-lang/rust-bindgen/pull/2335

Though apparently it has significant limitations meriting it the =
=E2=80=9Cexperimental=E2=80=9D title.

Regarding the issue of wrappers not being inlined, it's possible to get =
LLVM to optimize C and Rust code together into an object file, with the =
help of a compatible Clang and LLD:

@ rustc -O --emit llvm-bc a.rs                                        =20=

@ clang --target=3Dx86_64-unknown-linux-gnu -O2 -c -emit-llvm -o b.bc =
b.c
@ ld.lld -r -o c.o a.bc b.bc

Basically LTO but within the scope of a single object file.  This would =
be redundant in cases where kernel-wide LTO is enabled.

Using this approach might slow down compilation a bit due to needing to =
pass the LLVM bitcode between multiple commands, but probably not very =
much.

Just chiming in as someone not involved in Rust for Linux but familiar =
with these tools.  Perhaps this has been considered before and rejected =
for some reason; I wouldn=E2=80=99t know.=

