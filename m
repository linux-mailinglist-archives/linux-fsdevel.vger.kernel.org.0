Return-Path: <linux-fsdevel+bounces-21788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE347909E3F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 17:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F081C20BD9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 15:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9CA17C6C;
	Sun, 16 Jun 2024 15:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVzRDmtu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCF717543;
	Sun, 16 Jun 2024 15:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718553254; cv=none; b=DeRsX9PJC+RncCy1h1uOQwuq7LpWio9A7DocEES1feVJI3jGCH2I+PIdUVI3+CTarVtaaAfbde/hDphKUAbtjqk2fNOKoCFNj9ZWjNp9fmSnC2g0n4IZg6cRzmdaADJqFNbWOAoHQG9413Fbzhi4ui2kvnU2XiyycoEYtp635h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718553254; c=relaxed/simple;
	bh=R2WX+0UUb/+vujXGKC/bEJXTUNlTwtbjolcWJMf3z8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJKmbx8gOvQS9YRGzFsFij3wCkTgez0Zm87kg+/X5XkGtLW+SQdGYEqh3PtgDYubrCFSpW9rQJ2E9K6YnuWQxjnIXEfUfcHDVlKQnZoFv36VpwLha9Tj164HGQj2vhNrLmEwD2Rq1WXmbCdkQQ/z/FWVYEN5O36SlvREDF4+3jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVzRDmtu; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d23a0a32afso2118206b6e.3;
        Sun, 16 Jun 2024 08:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718553252; x=1719158052; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Den/1z1anEDN62vUgoFYzRYPggQf712PLr0MqmeLw5s=;
        b=LVzRDmtuWH1WiR7I3/0dTjNRBE1KykJFf4d2frDIAmYc0YtkT2tFfjqeUomubZZDHq
         TRkg1/IOPCvI+mLMlWwIKKJL8i9LluxzF+jfGe614pf9IiYT3J4ZVrFcv5a/CmeUTUx6
         Fk9e5WrwRMrG1yFFxIcwDXSCv3dOEVvpgKK58MF6XRBD2iGVn2pBzau1h6X8uHkg6nZ8
         nZrNUw1iA+0F2OFaggKokInnxOHB9eSPWE0K7Vu3nnEqlnQLB9u768VsQRuEJprxxz5R
         yKr3gHaBtMXPJr+TWvHBuO0IUX73z4iNgevQUPFTZoVo+5LDSqoXtI9a0ZV3Wz39AP/H
         hv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718553252; x=1719158052;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Den/1z1anEDN62vUgoFYzRYPggQf712PLr0MqmeLw5s=;
        b=Qizu3fmakQoSI85YkjgRpd2SqkgmU+MHaoM1TBEjHCpciUSK8ccElPUQklnkkbua+e
         YEUT9RLYx4lg7mJRqiUS214nOyfWkqJoakHvjLOyBT73mfHH55fYE72zo0dPTa27uRna
         1/Z4IMek20cF5lJW5WOrA2eu2Gvkjxy8HwnfuVbvsBXh+PcPTD97OCUbyzjtHCziE4HU
         4u9UZGMUh7o9qASq1cd4s1bku7qBX/x3HvJALXZUmTNMXA6sNh2z4p9isDq/lL8zoikn
         BRt/a+7yq53Pm8YXN8v8Zav4z4D2wBIw+6/VOzbho+a2N5Q1qyL7XxhA++RoV1ZKxLmj
         JkIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGiT4K5WZO6ecOrzR2rFITGgtf6ggnxIYEXCnVndOlbKwvfPiNq5kVpPF2i6cpYKKNKuej5hx1l3eull+vZuvzbjU/yj6LOEhWA6Zlz4EItmCJoshLScOtgBnferkHqnp3Cby3YfkyfxQ9DF5ocTGUNdbaZBGFRg06Xriwb6O+Hgc915UZLpYmWXCKzeGY8xoJuKhH6FmwnWh6aHvFR1UFEJyWVnNrTw==
X-Gm-Message-State: AOJu0Yyq+wEr9fUz4IJVaYApTPI5dTuRsCheRb9DXHFB/9lpLFZYC1uK
	YVg7ypmBVFzgdmo3HSJDBI81XVvvYP5gUVjU7fo1Rx/RvbTIr24t
X-Google-Smtp-Source: AGHT+IHDvxUTXfVltv71Hz0qCRr5nwagnmoPpnsgdrxerLfOV1wrFqvVvIBF3cjJ1pV5xZY4wKrXgQ==
X-Received: by 2002:a05:6808:21a9:b0:3d2:15a6:4015 with SMTP id 5614622812f47-3d24e8ef7fdmr9070711b6e.24.1718553252287;
        Sun, 16 Jun 2024 08:54:12 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abc0719fsm348763885a.83.2024.06.16.08.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 08:54:11 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id BFA591200043;
	Sun, 16 Jun 2024 11:54:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 16 Jun 2024 11:54:10 -0400
X-ME-Sender: <xms:ogpvZhYqS0nqTHmstWbcwxpfqUWCsHdje8FzXUvE1GemGKU1Zi6-uA>
    <xme:ogpvZobLDuXNYgiO5UCjgQbOtJRa_51PpXADHRFHRaVKTYjyR0NuuawLemEP5NV_e
    CwQ9D4lpRXLKPhjAQ>
X-ME-Received: <xmr:ogpvZj9kD51wY0yQq0TPJ_yXS6l6sm1UEKCPUWuS8ZfUe-zHKfWdUQw6Vg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvfedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfhgfehgeekkeeigfdukefh
    gfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:ogpvZvq0lQQ3RwHq776CaDr9JsEgF3yl8Wci1uNlUCCZ4gX_rBVhjQ>
    <xmx:ogpvZspuElNYw5dkXJBXc2ZXFaII_bWSZxY5gGSpZQlcGV2V8XYVhw>
    <xmx:ogpvZlREgb1UqllbrNN-n0xg2rYFaDLp6F37EXyjbSUgyOomyh5qzQ>
    <xmx:ogpvZkohexvqUnWT7w37_m_ewKpRvbXSX_T7pexz2_icI-bu5NIcWw>
    <xmx:ogpvZl51Pjj-LlA4ClcTALGdN4fmFeMEDQ9y1iEn3H3db2o25Auin6H0>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Jun 2024 11:54:09 -0400 (EDT)
Date: Sun, 16 Jun 2024 08:54:09 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Benno Lossin <benno.lossin@proton.me>, Gary Guo <gary@garyguo.net>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, llvm@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>,	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
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
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,	Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,	torvalds@linux-foundation.org,
 linux-arm-kernel@lists.infradead.org,	linux-fsdevel@vger.kernel.org,
 Trevor Gross <tmgross@umich.edu>,	dakr@redhat.com
Subject: Re: [RFC 2/2] rust: sync: Add atomic support
Message-ID: <Zm8KoUNQ4v7UvVOE@Boquns-Mac-mini.home>
References: <CANiq72=JdqTRPiUfT=-YMTTN+bHeAe2Pba8nERxU3cN8Q-BEOw@mail.gmail.com>
 <ZmxUxaIwHWnB42h-@Boquns-Mac-mini.home>
 <c1c45a2e-afdf-40a6-9f44-142752368d5e@proton.me>
 <ZmzvVr7lYfR6Dpca@Boquns-Mac-mini.home>
 <b692945b-8fa4-4918-93f6-783fbcde375c@proton.me>
 <Zm4R0XwTpsASpBhx@Boquns-Mac-mini.home>
 <5lwylk6fhlvqfgxmt7xdoxdrhtvmplo5kazpdbt3kxpnlltxit@v5xbpiv3dnqq>
 <Zm7zvt7cNT2YpiIi@Boquns-Mac-mini.home>
 <CANiq72mz=OzzHJJyOPeWcxEtppP+v0KUq63_u5NB7-R84avaPg@mail.gmail.com>
 <4pez6kilgykarr5qeutgaw3pvkxf2nmh4lzuftadshmkke7d3q@3jfgvjveqdbz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4pez6kilgykarr5qeutgaw3pvkxf2nmh4lzuftadshmkke7d3q@3jfgvjveqdbz>

On Sun, Jun 16, 2024 at 11:32:31AM -0400, Kent Overstreet wrote:
> On Sun, Jun 16, 2024 at 05:14:56PM +0200, Miguel Ojeda wrote:
> > On Sun, Jun 16, 2024 at 4:16 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > >
> > > Hmm? Have you seen the email I replied to John, a broader Rust community
> > > seems doesn't appreciate the idea of generic atomics.
> > 
> > I don't think we can easily draw that conclusion from those download
> > numbers / dependent crates.
> > 
> > portable-atomic may be more popular simply because it provides
> > features for platforms the standard library does not. The interface
> > being generic or not may have nothing to do with it. Or perhaps
> > because it has a 1.x version, while the other doesn't, etc.
> > 
> > In fact, the atomic crate is essentially about providing `Atomic<T>`,
> > so one could argue that all those downloads are precisely from people
> > that want a generic atomic.
> > 
> > Moreover, I noticed portable-atomic's issue #1 in GitHub is,
> > precisely, adding `Atomic<T>` support. The maintainer has a PR for
> > that updated over time, most recently a few hours ago.
> > 
> > There is also `AtomicCell<T>` from crossbeam, which is the first
> > feature listed in its docs.
> > 
> > Anyway...
> > 
> > The way I see it, both approaches seem similar (i.e. for what we are
> > going to use them for today, at least) and neither apparently has a
> > major downside today for those use cases (apart from needed refactors
> > later to go to another approach).
> > 
> > (By the "generic approach", by the way, I mean just providing
> > `Atomic<{i32,i64}>`, not a complex design)
> > 
> > So it is up to you on what you send for the non-RFC patches, of
> > course, and if nobody has the time / wants to do the work for the
> > "simple" generic approach, then we can just go ahead with this for the
> > moment. But I think it would be nice to at least consider the "simple"
> > generic approach to see how much worse it would be.
> > 
> > Other bits to consider, that perhaps give you arguments for one or the
> > other: consequences on the compilation time, on inlining, on the error
> > messages for new users, on the generated documentation, on how easy to
> > grep they are, etc.
> 
> Yeah, rereading the thread - I'm with Miguel and Gary.
> 
> Generics are simply the correct way to do it, if the wider rust
> community didn't do it that way I think that can be chalked up more to
> historical baggage or needlessly copying the base integer type scheme.
> 
> Let's please do it right here, and generics are the correct approach.

If so, maybe we should do u<Wide> instead of u8, u16, oh, and probably
just Integer<Sign, Wide> instead of i{8,16,32,64) and u{8,16,32,64} ;-)

Regards,
Boqun

