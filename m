Return-Path: <linux-fsdevel+bounces-5357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DD980AC3B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 19:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52AAC1F211F5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E3D47A63
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/9D5yry"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B47123;
	Fri,  8 Dec 2023 09:44:15 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b83fc26e4cso1495220b6e.2;
        Fri, 08 Dec 2023 09:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702057455; x=1702662255; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=STnIY6jHnonlNBGjhvoP/XKEjxCdoqekmjCFEwWOqqs=;
        b=R/9D5yryzeBwlns2fWxYB9mVg6xgKF9etEDsO7YvVAKJrjzKPlLhqfPy/a+EXnBWG4
         DraJxuTGQVZkvqutvStNe/cLZb5DQEIk5WpzOc98YT6YfECY/bP/SCEtaXNtEPG4+J+Q
         xh+yHFisuh9L9so5hIG5XrnlqlWLQfQ2oyFo464RtOwR+sKtsqwxutCfBiBRYPdNRXxo
         ULJh3KpeQfk/LAGA/enkHiv0tSzvFn98/w3ihK2gWJER/l9bKJ7aQxcOZiLa8AmQfE7d
         P8vitSAP8SeUxzkxy4neTTpYxrRTcjsEoBDbygvKeEnXZHXLmA3ge0H0pWB+q++g7uww
         kNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702057455; x=1702662255;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=STnIY6jHnonlNBGjhvoP/XKEjxCdoqekmjCFEwWOqqs=;
        b=FBfII8UqbC7lWG9sDPzR0WYPgf1Va3lNbkEINr14U0zDkQoJJkHIL2NX5qPOPNx54B
         VRLbTPqB4MAs605J1pwhSNhLyvD5lWDbsoHDTAdC4CPDVxcdaTFDHSZTFWtJWnCl4YZK
         X2osy5Hs98szjJwulmcHksaNgQXhrf3lr6Y9uMcLNOZCuohnIN42zmVNCyGNnNKbQGA9
         BQSC+xD7c0I9SYa6h/MKExAC7Ben6GN4nzqDVvViNiV/f/UuxEzIXzHM3irbDvdZJPRe
         rMsvih7EJ83cqTKoNyGpXxJWqzkpw6ZXmCRtBJQSCODSaFLK4f+8tGTs7v0rEqgrHiRp
         9IJg==
X-Gm-Message-State: AOJu0YxnDPs2jZZueA2httz5Eec6uZ/zF9a51cKtCs3AaDqJitIU/XXk
	RhXFFwMtXjwSKf+0Rph12+k=
X-Google-Smtp-Source: AGHT+IEzT+HZ9WmsP8OSljEsqprb6rwe8jXFEjOkdMdIcoynbuF30OJkUHTP42lwHHlv2AFGEvJFuw==
X-Received: by 2002:a05:6808:124a:b0:3b8:b063:8261 with SMTP id o10-20020a056808124a00b003b8b0638261mr354407oiv.99.1702057454735;
        Fri, 08 Dec 2023 09:44:14 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id ud11-20020a05620a6a8b00b0077d90497738sm841756qkn.102.2023.12.08.09.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:44:14 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailauth.nyi.internal (Postfix) with ESMTP id A51C027C0054;
	Fri,  8 Dec 2023 12:44:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 08 Dec 2023 12:44:13 -0500
X-ME-Sender: <xms:7FVzZYW7dgchrPjOkXhW0sb6EU31ic_Y-GmkHi5aMNZaED6mo0f2CQ>
    <xme:7FVzZclxmVbT3_sDjTjWP1NLmwpNcykkBAnVjEKbLCOC9jL3qFRi_NP_1vmqF2wpK
    XCTb3UIOKsm0zamHw>
X-ME-Received: <xmr:7FVzZcZgPObt-xFpDA44jJZ_CB5HXvN9D2_jGBI22_zYY3755PmOX21sK58>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekiedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepueho
    qhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledthffgheegkeekiefgudek
    hffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeeh
    tdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmse
    hfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:7FVzZXWEEnbUgdWHrTi0rsh1UBWoGrrYLSY3vXlj-IImUQJ3_Dk17g>
    <xmx:7FVzZSlIA7eJfcOsPnymAgr8gDAxN-AKO7N_MpiDmjBUy0SmUeiFMw>
    <xmx:7FVzZccr7XOY28eMqoEef8LbTvmueOQPB9jiSOF34DNQW7hgKIGzMg>
    <xmx:7VVzZewcjWCPXENIzmDM7mNs-k1EYIZLIK0xtFtbNNO3epM_UHl-yA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Dec 2023 12:44:11 -0500 (EST)
Date: Fri, 8 Dec 2023 09:43:00 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,	comex <comexk@gmail.com>,
 Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,	Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>,	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Kees Cook <keescook@chromium.org>,	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/7] rust: file: add `Kuid` wrapper
Message-ID: <ZXNVpCn0g_aBCpTE@boqun-archlinux>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-5-f81afe8c7261@google.com>
 <20231129-etappen-knapp-08e2e3af539f@brauner>
 <20231129164815.GI23596@noisy.programming.kicks-ass.net>
 <20231130-wohle-einfuhr-1708e9c3e596@brauner>
 <A0BFF59C-311C-4C44-9474-65DB069387BD@gmail.com>
 <CANiq72k4H2_NZuQcpeKANqyi_9W01fLC0WxXon5cx4z=WsgeXQ@mail.gmail.com>
 <CAKwvOdkgDwnC_jaGjXjk9yKYo=zWDR_3x7Drw3i=KX0Wyij6ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdkgDwnC_jaGjXjk9yKYo=zWDR_3x7Drw3i=KX0Wyij6ew@mail.gmail.com>

On Fri, Dec 08, 2023 at 09:08:47AM -0800, Nick Desaulniers wrote:
> On Fri, Dec 8, 2023 at 8:19 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > On Fri, Dec 8, 2023 at 6:28 AM comex <comexk@gmail.com> wrote:
> > >
> > > Regarding the issue of wrappers not being inlined, it's possible to get LLVM to optimize C and Rust code together into an object file, with the help of a compatible Clang and LLD:
> > >
> > > @ rustc -O --emit llvm-bc a.rs
> > > @ clang --target=x86_64-unknown-linux-gnu -O2 -c -emit-llvm -o b.bc b.c
> > > @ ld.lld -r -o c.o a.bc b.bc
> > >
> > > Basically LTO but within the scope of a single object file.  This would be redundant in cases where kernel-wide LTO is enabled.
> > >
> > > Using this approach might slow down compilation a bit due to needing to pass the LLVM bitcode between multiple commands, but probably not very much.
> > >
> > > Just chiming in as someone not involved in Rust for Linux but familiar with these tools.  Perhaps this has been considered before and rejected for some reason; I wouldn’t know.
> >
> > Thanks comex for chiming in, much appreciated.
> >
> > Yeah, this is what we have been calling the "local-LTO hack" and it
> > was one of the possibilities we were considering for non-LTO kernel
> > builds for performance reasons originally. I don't recall who
> > originally suggested it in one of our meetings (Gary or Björn
> > perhaps).
> >
> > If LLVM folks think LLVM-wise nothing will break, then we are happy to
> 
> On paper, nothing comes to mind.  No promises though.
> 
> From a build system perspective, I'd rather just point users towards
> LTO if they have this concern.  We support full and thin lto.  This
> proposal would add a third variant for just rust drivers.  Each
> variation on LTO has a maintenance cost and each have had their own
> distinct fun bugs in the past.  Not sure an additional variant is
> worth the maintenance cost, even if it's technically feasible.
> 

Actually, the "LTO" in "local-LTO" may be misleading ;-) The problem we
want to resolve here is letting Rust code call small C functions (or
macros) without exporting the symbols. To me, it's really just "static
linking" a library (right now it's rust/helpers.o) contains small C
functions and macros used by Rust into a Rust driver kmodule, the "LTO"
part can be optional: let the linker make the call.

Regards,
Boqun

> > go ahead with that (since it also solves the performance side), but it
> > would be nice to know if it will always be OK to build like that, i.e.
> > I think Andreas actually tried it and it seemed to work and boot, but
> > the worry is whether there is something subtle that could have bad
> > codegen in the future.
> >
> > (We will also need to worry about GCC.)
> >
> > Cheers,
> > Miguel
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers

