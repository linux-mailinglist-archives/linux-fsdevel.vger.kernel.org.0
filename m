Return-Path: <linux-fsdevel+bounces-21779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 186FD909DF4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 16:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76A1281E2F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 14:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD56712E5B;
	Sun, 16 Jun 2024 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sg2QUCXu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F61819D8B5;
	Sun, 16 Jun 2024 14:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718548563; cv=none; b=tK1vSU02ZgHv0dB44ASSiOfCwc4BHHtc24MF9GgIzrzJ0zFsI1Aebb3ONgv8VVFYIyDXLWMTCDLkEhMX5Ck3Bq3j0SKvsTa1IfnJGFAQDENaQOcVKgElp56XC+zymOPxXrgC2ZFP1qqFnj0v0s4GBZhB8zyTzu8u9gfbssbWbFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718548563; c=relaxed/simple;
	bh=7e9CZmd124XeWsjsaTuz81EPjeNmZoFf85hV+ZcTGZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sc7S54DLphzUFN5ZPxZMBvhiPn5TWo91qDrvMnm7MihR/ZjiJDw2mkmxAl1tIVrA7ys7yD5i+Mz+osmf6tdWI0i3QxiJpTBQ4tz/atszSwSqmZtncfaSaRisHnvBPWb7n2B4sPIqXbYgJkoJqHFFPs884BIyajdLWdTZHkPjl7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sg2QUCXu; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-797b24b8944so333255185a.0;
        Sun, 16 Jun 2024 07:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718548560; x=1719153360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9qsPYBwH3Sp7/6c6yDAa2y8gJfd287HNf312thuud8=;
        b=Sg2QUCXuD40yZ8DV6ixtS64ElV0Ovv0NSv8oBu3I+95ivZxcemgZm+hm1yZw3p6dhw
         Su91sH4P4RexCAhCzrO808D7T9q0lsJode6vEur9aGwxZUIi0dNHGyKp7RGCmy51aCln
         AbkcAA9AfCGmEm1Uj1aBYAHh3w9tVPxr8qCPmr5nM9zHTvcdBfnzEXuJbQpDTrl5lEIU
         xLH6pVpKwKPc9JOH8qTCWEZgcMTOzRCxX1FaPgkD/gxzE+TLw0o7bXTrGagr6bLjwzQk
         UnmRXE74CpEsH8+Na14RpVnGMk+H5wtqK/3L5M3JT1r+VLRUolTlGvNG4er8y03xlID7
         4+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718548560; x=1719153360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9qsPYBwH3Sp7/6c6yDAa2y8gJfd287HNf312thuud8=;
        b=jikag+0I8HT2KH4exYSV3Pl96zf3mytIMMTkuAYQl5TqoTOdRFCZw8L9lewY1/4cCi
         8JPKl3FvriIio8vkImIfIsf63K91jkuNAogHMB7KeaoNolxaTPSJikgeX7gACjRTRk3E
         7SHlQW/t4cE5cKKYScK2kwcfyRyT7CVNNSDgGUuQIoQt12kgBV9yDuyZxgvPyPKU1xAy
         i3MF0N+Wmc6g43qYlwTnkdrD4vd/MsENc7+eY+zhvjdvnazu4ZtxfIhNlCkGFQEM5HUj
         SPjXY4VcuJfO2gln8s+/q6Pd/0KKZ+ekHykiKcK88Jp5aQ8j596fByebTtSD8PFmrBEc
         kmfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWGD3xKqTZDEM9xgK/mL650AgIf4fBaJXMX7yqFo5kklf5w6TEdi3Df0MIPRePoj9Vwx9tXVuB69IjZ38MJHzGHzuj3Yv4ASUwnQ4Ja1lQPjmhtcRe+TuVyBObWfMmCjpakM+Y3edR7UN/0NkDagivVfU91gms4XIxWYXbHOk6ThHf5Qiki5bXpmjMxn3hJRqHK5uiESiRfB6fzP4Lxq6DAYOvu1Z/4Q==
X-Gm-Message-State: AOJu0Yx+OQohqQexjqRRwC+SL+3ofGJgfeNqIyjFpyEPj5SEbGYHEsmd
	EwjWqdMxwIx+YofzPJNtMm/FkfwGMb6z/wlODzuPZCqhW9vv6h5a
X-Google-Smtp-Source: AGHT+IE4znSN0CJN5q1n8JV3DeDpQHBV3vnA5qh9mxdOQC/KkdziwRzH+gkuO6qgwfyCqvW4Z/5i6A==
X-Received: by 2002:a05:620a:4510:b0:792:c32f:caf0 with SMTP id af79cd13be357-798d26b521amr864146585a.70.1718548560454;
        Sun, 16 Jun 2024 07:36:00 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f2ff9418sm37282091cf.86.2024.06.16.07.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 07:36:00 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id F0D271200043;
	Sun, 16 Jun 2024 10:35:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 16 Jun 2024 10:35:59 -0400
X-ME-Sender: <xms:TvhuZl-WuvCVZ9oBGYqbO6-oIa-PYM0cF6PrK3dAFc5bbLUIyPmqdQ>
    <xme:TvhuZpt8FWyn1-J3XL8esS5egboM3gKdscTntpeVqP7dsBhUz4B3uPePqdUKGGhNn
    zYVPvqiCaqNWGpErg>
X-ME-Received: <xmr:TvhuZjCoXZPo8lMk7Gz9v8hT9VtPxaRJSJcxIPalf_zOxe0KDemSvjhvgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvfedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:TvhuZpcoH9X3uZBbI_1Wkku1Oc8DCXdgNIFZ2Z4QLrtNxDKkzvGTSA>
    <xmx:TvhuZqO2M1ZQJTw53lseHEqb5jmKUrD0ddhvQDMq5AfVlt_xfi2tIg>
    <xmx:TvhuZrnRRWPs7bFON7P4I8UB1o0KBPEm9r4wkXDL0N36qmLMzrZjJQ>
    <xmx:TvhuZksTUDZwGORis8-HSQ9pOWUF0IVpU0nxk48NbMFYfslb76YbNA>
    <xmx:TvhuZstlQu2ZiepvJh5ljeT_2Y9MAIiV0JCWUucbXfJE0eFCM1ME6xFD>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Jun 2024 10:35:58 -0400 (EDT)
Date: Sun, 16 Jun 2024 07:35:57 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Benno Lossin <benno.lossin@proton.me>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
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
Message-ID: <Zm74TbphTAU_1aBV@Boquns-Mac-mini.home>
References: <CANiq72myhoCCWs7j0eZuxfoYMbTez7cPa795T57+gz2Dpd+xAw@mail.gmail.com>
 <ZmtC7h7v1t6XJ6EI@boqun-archlinux>
 <CANiq72=JdqTRPiUfT=-YMTTN+bHeAe2Pba8nERxU3cN8Q-BEOw@mail.gmail.com>
 <ZmxUxaIwHWnB42h-@Boquns-Mac-mini.home>
 <c1c45a2e-afdf-40a6-9f44-142752368d5e@proton.me>
 <ZmzvVr7lYfR6Dpca@Boquns-Mac-mini.home>
 <b692945b-8fa4-4918-93f6-783fbcde375c@proton.me>
 <Zm4R0XwTpsASpBhx@Boquns-Mac-mini.home>
 <5lwylk6fhlvqfgxmt7xdoxdrhtvmplo5kazpdbt3kxpnlltxit@v5xbpiv3dnqq>
 <Zm7zvt7cNT2YpiIi@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zm7zvt7cNT2YpiIi@Boquns-Mac-mini.home>

On Sun, Jun 16, 2024 at 07:16:30AM -0700, Boqun Feng wrote:
> On Sun, Jun 16, 2024 at 05:51:07AM -0400, Kent Overstreet wrote:
> > On Sat, Jun 15, 2024 at 03:12:33PM -0700, Boqun Feng wrote:
> > > What's the issue of having AtomicI32 and AtomicI64 first then? We don't
> > > need to do 1 or 2 until the real users show up.
> > > 
> > > And I'd like also to point out that there are a few more trait bound
> > > designs needed for Atomic<T>, for example, Atomic<u32> and Atomic<i32>
> > > have different sets of API (no inc_unless_negative() for u32).
> > > 
> > > Don't make me wrong, I have no doubt we can handle this in the type
> > > system, but given the design work need, won't it make sense that we take
> > > baby steps on this? We can first introduce AtomicI32 and AtomicI64 which
> > > already have real users, and then if there are some values of generic
> > > atomics, we introduce them and have proper discussion on design.
> > > 
> > > To me, it's perfectly fine that Atomic{I32,I64} co-exist with Atomic<T>.
> > > What's the downside? A bit specific example would help me understand
> > > the real concern here.
> > 
> > Err, what?
> > 
> > Of course we want generic atomics, and we need that for properly
> > supporting cmpxchg.
> > 
> 
> Nope. Note this series only introduces the atomic types (atomic_ C
> APIs), but cmpxchg C APIs (no atomic_ prefix) are probably presented via
> a different API, where we need to make it easier to interact with normal
> types, and we may use generic there.
> 

Or it could be a generic function instead of generic type like:

	pub unsafe fn cmpxchg<T>(ptr: * mut T, old: T, new T) -> T

the "unsafe" part is due to `ptr` may not be a valid pointer or this may
make normal accesses data race.

Regards,
Boqun

> > Bogun, you've got all the rust guys pushing for doing this with
> > generics, I'm not sure why you're being stubborn here?
> 
> Hmm? Have you seen the email I replied to John, a broader Rust community
> seems doesn't appreciate the idea of generic atomics.
> 
> Regards,
> Boqun

