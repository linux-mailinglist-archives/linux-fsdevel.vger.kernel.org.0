Return-Path: <linux-fsdevel+bounces-21792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7AB909ECC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 19:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DFFF282E26
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 17:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEDE3B782;
	Sun, 16 Jun 2024 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtGM5N1m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B2A1946B;
	Sun, 16 Jun 2024 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718559009; cv=none; b=HuxJebKBoeYqmoQoybVAUtoxWThj5Z2nPvGfDsUsOY1VgOhsSc/rInEWaQYZPVXVSw1BNk5QiWza8Z2aK6aZdDA50RTLJBC1t9GjMc+grrI1wrB42Q/9tw3GMFBEL1DC77m+P4djkM/IdNgn1bII8FqMbObG3owgHBiUQWMheao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718559009; c=relaxed/simple;
	bh=YYPRvJuMbdP+DqpVZ+wvMU/+2eTody1ahJhl0TxFmgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+K9VOJPsEsfIUe/c1RSuKJUd2EABBuf18UNQFcWQ2evtzwZlCX5uArYZ0T99sWZxZlBxJUANzbIEqCewfKGfNv6gR4BtB0o5E+QSRtk7S8dKph/SelR6lia87fAR1LUq1Q1vCvEroQ9KWsvTogox5JJjwWXLDUZsQ83bnpwE70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtGM5N1m; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-79a3f1d007fso103445185a.1;
        Sun, 16 Jun 2024 10:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718559007; x=1719163807; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JmxJHYyKzSP+huyZ3h4SyddcKqp+ekNG/X00GfFHNDw=;
        b=PtGM5N1m63UOVlU9WlPe4A+SsL2KXozB8bSgFGwiD5pKB1hVYjkX8xXqD98nHf4jn9
         uV/D+xRy+x2CJqkFKFv+hdBlsG1Ln3U2Mmpdhs0R6gm1tAcr54x0kCoSZqPw2MI9qegB
         BrzRCSgZ2U92fwLhRw0/bx9LpMpFZiBw7olAxduUEgOV+zPwGCzhjkWniywXGhJyf/Wr
         hsi6JDdYBS4tvcR5Kwp+XSwVJiy5ni+y7UnRruBWsWzSDU2HxlUgfQzJaG4e+RzB1mvw
         PE+m6lFpKpZRptfAL3EggOWmfUiI3p5G21OAPYBX5ssNvuiaZBNxQuuvEtC7AmTJhO4a
         rYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718559007; x=1719163807;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JmxJHYyKzSP+huyZ3h4SyddcKqp+ekNG/X00GfFHNDw=;
        b=gznlZz+W54BeE0y3M6IoAZSC6SHvrSbsg8MIQvEy7S28+VSEk7hiwJJf6+QCdyzlQL
         nOyqW1flv8T9kVhKpHn97HC0+KYKQ8I1L/zaYjOb8ua8ePF42EyVh8EWFuyHULhf0AiW
         9XQRV6b/6kfouhxLDJV+44MvNeOJqNY7Jw6BFwZ8/gPDe+O8loAxIkfGoAG63Urt0kiy
         gNAS5wy7Cgoa5GSs1hsfXqxJB3vPI7lzYbKMqHlyPcZTCIRLLY5to6JlH55QX+pcyBaz
         Xo8D1sRi8LJf4y0Qlm3ipQ7cRKHjMEyvjo5JJxDh3xqDsJwDMt7yHe22WrWJSh3XtS3h
         IQDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjR5x37Xmt1WWoM9PQGj9atx9w+vG2jnJsR3aTlTGbDMjjtjRX+5tKHOVfEWM8dmusfP4C2G4c+LNP5O1455gbcR0AmSeTJIH++x5XaAyb7o52orpdYTO99uU2lxBAi33CAvEmgomZu9mUoLwr99DcxSpUzYmv9anhLXZ4DVl7xmBx81I4IscP2NVsG51DQ8dc7kldPxmSFc4fc9I5I/+RkQ69Ltc0Qg==
X-Gm-Message-State: AOJu0YxEK9ic0+ubp/yK6rq4evJudedxz2x/QgnKd3Athi8adGd6AdbW
	kOA6JGeeWLEeKDj6cw8O9dUTsEps2NppYZYYrWNbHsZlHJ72u3Ag
X-Google-Smtp-Source: AGHT+IGD0LBYpLjhnDJ8/c78ZEe8vd+3798taTNVryqcrkBUQwNhtIxR2qGRwtBRr7oBG3T2TvxzMg==
X-Received: by 2002:a05:620a:444a:b0:795:9eb8:31e with SMTP id af79cd13be357-798d243af92mr990827285a.45.1718559007198;
        Sun, 16 Jun 2024 10:30:07 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aacae71esm355603985a.17.2024.06.16.10.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 10:30:06 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 741E21200068;
	Sun, 16 Jun 2024 13:30:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 16 Jun 2024 13:30:05 -0400
X-ME-Sender: <xms:HSFvZgsUctLCC0oyYySwNG1sFuDZ4tZUylyYAo8Dn6mmtPB6wEUhaA>
    <xme:HSFvZteGrmRQDUTw3RAMfIjx9C5AqdSJT7VE9f0Ih-vcaPk73Anzsv9ipq5R-tdv2
    9e9DoA6ePpTqlcMjw>
X-ME-Received: <xmr:HSFvZrzrCGPFC9DjUZcw3b-CniYLdJQrF0hi2gbUmEtdCQ2h_wiuUDjMVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvfedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepueho
    qhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledthffgheegkeekiefgudek
    hffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeeh
    tdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmse
    hfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:HSFvZjOzyszX57_ZBFFag5QjmKUHO-ZmiVubPxrTYt8Cgp8benUnqA>
    <xmx:HSFvZg_jlfiKkxp4-FJOnvi_HPWn-zKZHVoUbJRVDvJVrnHBnjT1IA>
    <xmx:HSFvZrXDi1byzz6EIMgiVRN9pNkvFzpmjYmdcxpSKIgEpxfSNoRadA>
    <xmx:HSFvZpeD0D74A3UlQrIYXOgma5OhQWBcoeESiNOLzd51orEqCEhm4w>
    <xmx:HSFvZid-5l57RCBHqQzdjR1bZho8OR9unqqz7yphfBOSei0XvBZtofWB>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Jun 2024 13:30:03 -0400 (EDT)
Date: Sun, 16 Jun 2024 10:30:03 -0700
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
Message-ID: <Zm8hG58nuE3HrnyS@Boquns-Mac-mini.home>
References: <ZmxUxaIwHWnB42h-@Boquns-Mac-mini.home>
 <c1c45a2e-afdf-40a6-9f44-142752368d5e@proton.me>
 <ZmzvVr7lYfR6Dpca@Boquns-Mac-mini.home>
 <b692945b-8fa4-4918-93f6-783fbcde375c@proton.me>
 <Zm4R0XwTpsASpBhx@Boquns-Mac-mini.home>
 <5lwylk6fhlvqfgxmt7xdoxdrhtvmplo5kazpdbt3kxpnlltxit@v5xbpiv3dnqq>
 <Zm7zvt7cNT2YpiIi@Boquns-Mac-mini.home>
 <CANiq72mz=OzzHJJyOPeWcxEtppP+v0KUq63_u5NB7-R84avaPg@mail.gmail.com>
 <4pez6kilgykarr5qeutgaw3pvkxf2nmh4lzuftadshmkke7d3q@3jfgvjveqdbz>
 <Zm8KoUNQ4v7UvVOE@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zm8KoUNQ4v7UvVOE@Boquns-Mac-mini.home>

On Sun, Jun 16, 2024 at 08:54:09AM -0700, Boqun Feng wrote:
> On Sun, Jun 16, 2024 at 11:32:31AM -0400, Kent Overstreet wrote:
> > On Sun, Jun 16, 2024 at 05:14:56PM +0200, Miguel Ojeda wrote:
> > > On Sun, Jun 16, 2024 at 4:16 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > >
> > > > Hmm? Have you seen the email I replied to John, a broader Rust community
> > > > seems doesn't appreciate the idea of generic atomics.
> > > 
> > > I don't think we can easily draw that conclusion from those download
> > > numbers / dependent crates.
> > > 
> > > portable-atomic may be more popular simply because it provides
> > > features for platforms the standard library does not. The interface
> > > being generic or not may have nothing to do with it. Or perhaps
> > > because it has a 1.x version, while the other doesn't, etc.
> > > 
> > > In fact, the atomic crate is essentially about providing `Atomic<T>`,
> > > so one could argue that all those downloads are precisely from people
> > > that want a generic atomic.
> > > 
> > > Moreover, I noticed portable-atomic's issue #1 in GitHub is,
> > > precisely, adding `Atomic<T>` support. The maintainer has a PR for
> > > that updated over time, most recently a few hours ago.
> > > 
> > > There is also `AtomicCell<T>` from crossbeam, which is the first
> > > feature listed in its docs.
> > > 
> > > Anyway...
> > > 
> > > The way I see it, both approaches seem similar (i.e. for what we are
> > > going to use them for today, at least) and neither apparently has a
> > > major downside today for those use cases (apart from needed refactors
> > > later to go to another approach).
> > > 
> > > (By the "generic approach", by the way, I mean just providing
> > > `Atomic<{i32,i64}>`, not a complex design)
> > > 
> > > So it is up to you on what you send for the non-RFC patches, of
> > > course, and if nobody has the time / wants to do the work for the
> > > "simple" generic approach, then we can just go ahead with this for the
> > > moment. But I think it would be nice to at least consider the "simple"
> > > generic approach to see how much worse it would be.
> > > 
> > > Other bits to consider, that perhaps give you arguments for one or the
> > > other: consequences on the compilation time, on inlining, on the error
> > > messages for new users, on the generated documentation, on how easy to
> > > grep they are, etc.
> > 
> > Yeah, rereading the thread - I'm with Miguel and Gary.
> > 
> > Generics are simply the correct way to do it, if the wider rust
> > community didn't do it that way I think that can be chalked up more to
> > historical baggage or needlessly copying the base integer type scheme.
> > 
> > Let's please do it right here, and generics are the correct approach.
> 

I think the disagreement here is not non-generic atomic vs generic
atomic, it's pure generic atomic vs. AtomicI{32,64} etc + generic
atomic. I said multiple times that I'm OK with generic atomics if there
are real users, just I'm not sure it's something we want to do right now
(or we have enough information to go fully on that direction). And I
think it's fine to have non-generic atomic and generic atomic coexist.

Regards,
Boqun

> If so, maybe we should do u<Wide> instead of u8, u16, oh, and probably
> just Integer<Sign, Wide> instead of i{8,16,32,64) and u{8,16,32,64} ;-)
> 
> Regards,
> Boqun

