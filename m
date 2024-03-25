Return-Path: <linux-fsdevel+bounces-15257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A269988B228
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 22:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57BAC2A3842
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 21:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83B15D73B;
	Mon, 25 Mar 2024 21:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGzjJ8NC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE11D5BAFA;
	Mon, 25 Mar 2024 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400435; cv=none; b=gY+9J64wP3Av0s/RifNHikfB+IJpBA3SOsXH2iJAYf7BowOouPyYQNf6xNRxTFq2gFQdfhtzkVzxcGBjXyV9YNrnBRglTmqzJOA4EvrKNwiLzSRtmTmbzMyq53ke/XBDWpanxHRJWqhdKLsCzPtk77skVPmW+B8qIi5WkEanveA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400435; c=relaxed/simple;
	bh=4/DCfORHZvvO5HUER8a/EYr7x51a5ySHQFviZ6wk7tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFD8bqJeoWDYZAQsX9eTZr6lY9yNzalylIKBwdC94QamIILfO5ytrd8CTp9M2ST5sS+ZeqOSKB0jvwdT4ddfQLVLRbU7HgxWdNxgjhF+4evOgbw0i3iIpa5dU0nauCi77dBkL8094zh3twR646oVbd5QwsKNPdsGQqye5iAlcA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGzjJ8NC; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78a01a3012aso339323285a.2;
        Mon, 25 Mar 2024 14:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711400432; x=1712005232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aIiJsbK/FOYiRULxUQpBOQ0+fV2pbpaO5YH9xL5kFE=;
        b=nGzjJ8NCiv1FyRq5tzrvDyMvLDsN8QDz3EwXuqD+36BHZAizW4rtV9N+Fagx4kk+GF
         rUK+Y50Bu1PLFTLzHvyTZWrcrhsF8Y+mRXuUEC3qRalgUwxnWrHpbwV7kGL5/3eH3FKO
         KWIxdxkP7clhSH2FDHGiG9mdETSPdlYMQplxltjjApgtJC5OXtoWEeCM9F60pZ2cVBWs
         dQUAIwQ80uDdKypN7dyJMolhgul2348YZpyK8my3PX3OfYHCFCTa1dOcqrQ7+N/Bw2S9
         1a32TRNTiJNXd44cWjR19cF7ukLM1YKqS2dgY8M+gNZSSO41VJ5VNYs5oMu4+eqcxx4N
         /Mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711400432; x=1712005232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0aIiJsbK/FOYiRULxUQpBOQ0+fV2pbpaO5YH9xL5kFE=;
        b=mlSaU2jdAMtvll4tO9TWn3HevnPmo5lAyMRYiFZFnsGuDX1hlRExyFJ7BttNQqaG6V
         tB78yfXGR7ato/QUG/wwYSmLhHBtrgXqURu0OVVyjU7TunIcsZnDnF0+HhN9W7s2NGLI
         qxyC4mcQ0aMywT2RLXo5vMAcyCuryjw9oly1KFwV8WwsfxAVb8MHIwDxK8AsznWddfAk
         oEqlyNY41hCFFObFJINgzEJKGXrHI6q1SWvj+vM+gVTiMyofMshyWuVM4f/K1sAsi58y
         eBZWWjIONVzF87kJwCFt+giXOVLgY3rGiU6V1esB54Z01xDg6HFCBRtZ+uas8Eqd661E
         t9uw==
X-Forwarded-Encrypted: i=1; AJvYcCVj0lb1JefuJC4I/U4Twty9rtdzWfcmeKLaxef3rkmG95zuwi0aLhw31W/uyyRKh0G3N+Zuwz3B0vtyrINu02CzaRxSc5KYyWqBw+J+lKxow2bbUef2qB27iD7RTMe5XW5mT0y1tNVUbyufHNax8elJuh+Sni31JRNaMsSxLmSCSANOo4jiHzw=
X-Gm-Message-State: AOJu0YzUBYyTUmGqPRvINHst9N0D5vzU+zIhIVZ+J02/7Ic0wSvjg0Ic
	+b/HSFmWWHHWxdezUvzcOHhEjTle0p3OE+fxUIgiTiMpcnpCcV6B
X-Google-Smtp-Source: AGHT+IEmrJY2YuqwFggGagE/+e8uVbOWYgKk3UIvG8boqku1ije64OUVXZ9orjGM9gQQ0wlamMqAZQ==
X-Received: by 2002:ae9:ee13:0:b0:78a:5ed7:be26 with SMTP id i19-20020ae9ee13000000b0078a5ed7be26mr974913qkg.65.1711400431680;
        Mon, 25 Mar 2024 14:00:31 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id k1-20020a05620a0b8100b0078a4fe9bf69sm1715548qkh.57.2024.03.25.14.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 14:00:31 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 1821F1200043;
	Mon, 25 Mar 2024 17:00:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 25 Mar 2024 17:00:30 -0400
X-ME-Sender: <xms:6-UBZpM5Tshc-CtjpTkTKmhsk51vaHkOzddxRXkfq_dO9MF5hdrnzg>
    <xme:6-UBZr-xgmbJWemwti49N0igXBZWLCoJ9fpADD9F86xX6x6K1xiOyYH_gs-b4g58c
    4zVedC4v1KP5dX9bA>
X-ME-Received: <xmr:6-UBZoSgy4aSWX_9lia6EwdlN0ENgdev2pW8onGnMsooPvP7p1nb0OxUlfwIeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduuddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeffleejleehveelteeltedugffhhedvkefgvdehfeeiffeihfeigfdvtdeu
    hfdtteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvg
X-ME-Proxy: <xmx:6-UBZltcfQ0QB0cAeGdnsDsuL7jndG7Ucoe-gE-opPwfdGN7ntgmpQ>
    <xmx:6-UBZhfZgamJm562i4cZaL6MromTCguYiehjc-XJwwQuvuTANbmrxQ>
    <xmx:6-UBZh21bmniCmLuxrubcoY_-5tFBxlCX2DaU_fPcF4P8r0JY9k3pA>
    <xmx:6-UBZt-8NOr3p4SFiX8GqA0t7n1p4qdkiQSMwTFBQhIX_pm-Y-eu9A>
    <xmx:7uUBZvv9S3sdCDei9n1d78JQM-fTSpBTEoSwu9vmACzzWsAxJcpzGsfOEmAkrhi4>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 17:00:26 -0400 (EDT)
Date: Mon, 25 Mar 2024 13:59:55 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, llvm@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>,	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,	Gary Guo <gary@garyguo.net>,
	"Bj\"orn Roy Baron" <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,	kent.overstreet@gmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com,
	Thomas Gleixner <tglx@linutronix.de>,	Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,	torvalds@linux-foundation.org,
 linux-arm-kernel@lists.infradead.org,	linux-fsdevel@vger.kernel.org
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
Message-ID: <ZgHly_fioG7X4wGE@boqun-archlinux>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
 <ZgFVnar3nS4F8eIX@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgFVnar3nS4F8eIX@FVFF77S0Q05N>

On Mon, Mar 25, 2024 at 10:44:45AM +0000, Mark Rutland wrote:
[...]
> > 
> > * I choose to re-implement atomics in Rust `asm` because we are still
> >   figuring out how we can make it easy and maintainable for Rust to call
> >   a C function _inlinely_ (Gary makes some progress [2]). Otherwise,
> >   atomic primitives would be function calls, and that can be performance
> >   bottleneck in a few cases.
> 
> I don't think we want to maintain two copies of each architecture's atomics.
> This gets painful very quickly (e.g. as arm64's atomics get patched between
> LL/SC and LSE forms).
> 

No argument here ;-)

> Can we start off with out-of-line atomics, and see where the bottlenecks are?
> 
> It's relatively easy to do that today, at least for the atomic*_*() APIs:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=atomics/outlined&id=e0a77bfa63e7416d610769aa4ab62bc06993ce56
> 
> ... which IIUC covers the "AtomicI32, AtomicI64 and AtomicUsize" cases you
> mention above.
> 

Thanks! Yes, I know I should check with you before I finalize the
implementation ;-) I will try to integrate that but things to notice:

* For module usage, we need to EXPORT_SYMBOL_GPL() all the atomics, I'm
  OK with that, but I don't know how others feel about it.

* Alice reported performance gap between inline and out-of-line refcount
  operations in Rust binder driver:

	https://github.com/Darksonn/linux/commit/b4be1bd6c44225bf7276a4666fd30b8da9cba517	

  I don't know how much worse since I don't have the data, but that's
  one of the reasons I started with inline asm.

That being said, I totally agree that we could start with out-of-line
atomics, and maybe provide inline version for performance critical
paths. Hoping is we can figure out how Rust could inline a C function
eventually.

Regards,
Boqun

> Mark.

