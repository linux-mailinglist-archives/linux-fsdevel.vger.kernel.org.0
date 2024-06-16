Return-Path: <linux-fsdevel+bounces-21790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46464909E95
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 18:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 937A9B20E9C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 16:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54921CFB6;
	Sun, 16 Jun 2024 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2yGMo+H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27F58F5E;
	Sun, 16 Jun 2024 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718555460; cv=none; b=Ht9SlRVCjbfA1rXWjtskqjIGduR+0pzBFiqIh5660mgUlW6YBSijh27xZJa9lyAZiNzuchObEWIpEVGIrjU/6S9Ky6MTLd7yevV0CA1PSxfifyPAtoTm8fHqnKucxWgekv3cUUrc6R/kJdMm+0x3dcnMg9Lq3qUY2dGHCUiA1Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718555460; c=relaxed/simple;
	bh=l7JOGDgsbkUYg7PyRqn7qrLFjhtzle2nD2NUpBjh/lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ta1gUnwOAbc/ppy2jqiSSZmADcWBhb0f8iYtJSafnP0KTbFlwB26M/YTI4JJ2TTQ2y2lmMu26xlwDfl0J2X7BkDbptMufkMur1M3cXg2f9rMsBv3kOrpHp4UkEtUbRwu6vEnFK2Tgy8vDAV7QlCvNKqh9neEkF96PKYmnBvJ/ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2yGMo+H; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dff17fd97b3so2393554276.2;
        Sun, 16 Jun 2024 09:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718555457; x=1719160257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1u4eH5dugHh0yA2cMSq+DYOozUbC6STVml/uLjhxZuc=;
        b=a2yGMo+H/YVB3ntMBUyfGXq+ZRRMXRDKJ1xkpJEqFiOtJ+hCEGmUpEGhEi7KH5PdRR
         utLX+EHPAPnVVKzWRb7arBp7qP7AbhuIhg8h7nCLvH5K0EXOA0ZlTawcffbML36njyk2
         Zh62ZowS0DukLmSFX1X5hT5WXG6Ua1HLk3PdQrc1FwYl3SO+ytMxjgjTFC072kQSK/Dp
         meNhFO/c6mWHpIuBLcXPKufXDho9jRlx3SXU6tCR2LK+9J5FULFb2RskX1M/fOW9Exgw
         0HNXLyQ22LdxYy5Da4EUKPPplSVRYgmCz8d/KEDC4zKRbedf0ayaJuNOsvlepKjx4N4p
         nL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718555457; x=1719160257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1u4eH5dugHh0yA2cMSq+DYOozUbC6STVml/uLjhxZuc=;
        b=JFD+w1DVdx14yY9ol3rWAjbiia4bBmgVT35jsrJErgRrOF11YvD8H9KOmcXGYZdiLE
         D94Nx3JZ39pwDvRkjxrs9rFl8Jj8uSAwVRN6oqmUtkJ+9OCahee7fj+RhnNkvXMrMtqg
         /GbhVAbOf/x+M+NwlYk0PAE7u8/2+1NuVQcOdjQxRKofEtZxTd4LSI+A8L3NRg210069
         9ZUilU8l1Nn96PXnIVB4Bus8Pz1KKvaagUCFmHEDQuB15HOrqA2NvWNaN/40u5AAMh3a
         XKQb7lwsfatfAyWQ1LwLD0KzDcgbWgT/KJQMXgzq1dA3zcWUOWDTnWymElDtS0AxFIIV
         aG2A==
X-Forwarded-Encrypted: i=1; AJvYcCULAUdHe2KwtEFWpxQEgLEe0NCo1s4lCyXkpB4SuvpyY1qZc0TJB5Vu/fZyzF3y+XKAlEsk6qJiKQN7ea5CQYk3HG8vM+9kDkKIC3K/d7h91NIYUANAy0dw38XhgvkNTyeRf0RRY85gyPKi3uZVvPo1+oKS+C4x3iIIhxkdgyWEj75oV1Zkjn+zZpVLOlvKpqeb0HG2xqBjqHubxVDr3uOBSTWHsH2Fnw==
X-Gm-Message-State: AOJu0YyLjbA08IV7i/TWKav2eMZ9eRDtx80CtPYlgsD+T/xQvgwCciOH
	dzAg5qKIjAck/3W5FjtJ7BbuezZbAXO591uZvbI8JQ1rTKdP9fmE
X-Google-Smtp-Source: AGHT+IHLrkBz2GU7uiilBicmeb7dfbdnfSLCgOSqhUBo77rGvX0na2iuTCcvozdmQkE3oUG8YFK8KQ==
X-Received: by 2002:a25:6b4a:0:b0:dff:34dd:bc3f with SMTP id 3f1490d57ef6-dff34ddbfb9mr2662474276.19.1718555457407;
        Sun, 16 Jun 2024 09:30:57 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4435c59ecacsm10342021cf.79.2024.06.16.09.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 09:30:56 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id C513D1200043;
	Sun, 16 Jun 2024 12:30:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 16 Jun 2024 12:30:55 -0400
X-ME-Sender: <xms:PxNvZoMssICeArUvFENGho4TiyJ7WbBULErVblU7pXsEDgLGvaaaOg>
    <xme:PxNvZu_Buv2fBzusasmqoDbfLjDXhZZdz-sKNLYrj8KXgDRr_auFo7QVPolGSiXXA
    9xzKfR2sMKJ-ZGb0A>
X-ME-Received: <xmr:PxNvZvSkddTBeVtWijHXSJtFKCZDdwTq680S0YcMag6avjkZyrV1RLD8Ng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvfedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeeg
    vddvhedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:PxNvZgvgHRbYa5ZR_zr0B_23WfKp_WiuK7I9DQEkJZ2glUyrsyPWBA>
    <xmx:PxNvZgcLapK6DHBGVR3wiAIrNCyMkvVvMVOXyqVLOupsB-KtsNVjmQ>
    <xmx:PxNvZk2YaVqlreNnwIjTGxItIRHaC9WtzA1_sKanhyMeh1nlE1MEuw>
    <xmx:PxNvZk-YZP1xoN6s7HK-P6OAy1832ZoZnha1GSZAVfU54OdHdszNrA>
    <xmx:PxNvZn-gMDhzABzV3_Di0MWxp3xrHFVit02ug3RBmjOZqf65o6t0EiwW>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Jun 2024 12:30:54 -0400 (EDT)
Date: Sun, 16 Jun 2024 09:30:53 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
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
Message-ID: <Zm8TPRK-h2mDUX0b@Boquns-Mac-mini.home>
References: <20240612223025.1158537-3-boqun.feng@gmail.com>
 <c1c45a2e-afdf-40a6-9f44-142752368d5e@proton.me>
 <ZmzvVr7lYfR6Dpca@Boquns-Mac-mini.home>
 <b692945b-8fa4-4918-93f6-783fbcde375c@proton.me>
 <Zm4R0XwTpsASpBhx@Boquns-Mac-mini.home>
 <d67aeb8c-3499-4498-aaf9-4ac459c2f747@proton.me>
 <Zm7xySzPJcddF-I_@Boquns-Mac-mini.home>
 <f29cb2fd-651b-4bc5-8055-e3a412192e29@proton.me>
 <Zm8F7ZFnUFJkFGQ3@Boquns-Mac-mini.home>
 <0653b5d5-7a62-4baa-a500-4c110d816ba0@proton.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0653b5d5-7a62-4baa-a500-4c110d816ba0@proton.me>

On Sun, Jun 16, 2024 at 03:55:12PM +0000, Benno Lossin wrote:
[...]
> >>
> >> I don't think that the idea was to "do the design later". I don't even
> >> know how you would do that, since you need the design to submit a patch.
> >>
> > 
> > Then I might mis-understand Gary? He said:
> > 
> > "Can we avoid two types and use a generic `Atomic<T>` and then implement
> > on `Atomic<i32>` and `Atomic<i64>` instead?"
> > 
> > , which means just replace `impl AtomicI32` with `impl Atomic<i32>` to
> > me.
> 
> This is a fair interpretation, but what prevents you from merging the
> impls of functions that can be? I assumed that you would do that
> automatically.
> 

I think you missed the point, Gary's suggestion at that time sounds
like: let's impl Atomic<i32> and Atomic<i64> first, and leave rest of
the work for later, that is a "do the design later" to me.

> >> I can't offer you a complete API description, since that would require
> >> me writing it up myself. But I would recommend trying to get it to work
> >> with generics. I got a few other comments:
> > 
> > We should work on things that are concrete, right? It's fine that the
> > design is not complete, and it's fine if you just recommend. But without
> > a somewhat concrete design (doesn't have to be complete), I cannot be
> > sure about whether we have the same vision of the future of generic
> > atomics (see my question to Gary), that's a bit hard for me to try to
> 
> Sorry, which question?

	https://lore.kernel.org/rust-for-linux/Zm7_XWe6ciy1yN-h@Boquns-Mac-mini.home/

> Also to be aligned on the vision, I think we should rather talk about
> the vision and not the design, since the design that we want to have now
> can be different from the vision. On that note, what do you envision the
> future of the atomic API?
> 

Mine is simple, just providing AtomicI32 and AtomicI64 first, since
there are immediate users right now, and should we learn more needs from
the users, we get more idea about what a good API is, and we evolve from
there.

> > work something out (plus I personally don't think it's a good idea, it's
> > OK to me, but not good). Anyway, I wasn't trying to refuse to do this
> > just based on personal reasons, but I do need to understand what you are
> > all proposing, because I don't have one myself.
> 
> I went back through the thread and here is what I think your argument
> against generics is: people should think about size and alignment when
> using atomics, which is problematic when allowing users to leave the
> atomic generic.
> But as I argued before, this is not an issue. Have I overlooked another

You mean you said it's a non-issue but gave me two counteract? If it's
really a non-issue, you won't need a couneraction, right? In other words
non-generic atomics do provide some value.

> argument? Because I don't see anything else.
> 
> >> - I don't think that we should resort to a script to generate the Rust
> >>   code since it prevents adding good documentation & examples to the
> >>   various methods. AFAIU you want to generate the functions from
> >>   `scripts/atomic/atomics.tbl` to keep it in sync with the C side. I
> >>   looked at the git log of that file and it hasn't been changed
> >>   significantly since its inception. I don't think that there is any
> >>   benefit to generating the functions from that file.
> > 
> > I'll leave this to other atomic maintainers.
> > 
> >> - most of the documented functions say "See `c_function`", I don't like
> >>   this, can we either copy the C documentation (I imagine it not
> >>   changing that often, or is that assumption wrong?) or write our own?
> > 
> > You're not wrong. AN in C side, we do have some documentation template
> > to generate the comments (see scripts/atomic/kerneldoc). But first the
> > format is for doxygen(I guess?), and second as you just bring up, the
> > templates are tied with the bash script.
> 
> I see a bash script similarly to how Wedson sees proc macros ;)
> We should try *hard* to avoid them and only use them when there is no
> other way.
> 

I will just start with the existing mechanism and try to evolve, whether
it's a script or proc macro, I don't mind, I want to get the work done
and most relevant people can understand in the way the they prefer and
step-by-step, move it to the place I think is the best for the project.

> >> - we should try to use either const generic or normal parameters for the
> >>   access ordering instead of putting it in the function name.
> > 
> > Why is it important? Keeping it in the current way brings the value that
> > it's not too much different than their C counterparts. Could you explain
> > a bit the pros and cons on suffix vs const generic approach?
> 
> Reduce code duplication, instead of 3 different variants, we can have
> one. It allows people to build ergonomic APIs that allows the user to
> decide which synchronization they use under the hood.
> 

I already mentioned why I think it's good in the current way, I will
defer it to others on their inputs.

> >> - why do we need both non-return and return variants?
> >>
> > 
> > Historical reason I guess. Plus maybe some architectures have a better
> > implementation on non-return atomics IIRC.
> 
> Could we get some more concrete arguments for why we would need these in
> rust? If the reason is purely historical, then we shouldn't expose the

Sure. Look like my memory is correct, at least on ARM64 they are
different instructions (see arch/arm64/include/asm/atomic_lse.h)

non-return atomics on ARM64:

	#define ATOMIC_OP(op, asm_op)						\
	static __always_inline void						\
	__lse_atomic_##op(int i, atomic_t *v)					\
	{									\
		asm volatile(							\
		__LSE_PREAMBLE							\
		"	" #asm_op "	%w[i], %[v]\n"				\
		: [v] "+Q" (v->counter)						\
		: [i] "r" (i));							\
	}

value-return atomics on ARM64:

	#define ATOMIC_FETCH_OP(name, mb, op, asm_op, cl...)			\
	static __always_inline int						\
	__lse_atomic_fetch_##op##name(int i, atomic_t *v)			\
	{									\
		int old;							\
										\
		asm volatile(							\
		__LSE_PREAMBLE							\
		"	" #asm_op #mb "	%w[i], %w[old], %[v]"			\
		: [v] "+Q" (v->counter),					\
		  [old] "=r" (old)						\
		: [i] "r" (i)							\
		: cl);								\
										\
		return old;							\
	}

It may not be easy to see the different instructions from the pasted
code, but you can find them in the header file, also you could notice
that the number of operands is different?

> non-return variant IMO. If it is because of performance, then we can
> only expose them in the respective arches.
> 

Hmm.. so we ask user to write arch-specific code like:

	pub fn increase_counter(&self) {
	    #[cfg(CONFIG_ARM64)]
	    self.counter.inc();

	    #[cfg(CONFIG_X86_64)]
	    let _ = self.counter.inc_return();
	}

are you sure it's a good idea?

Regards,
Boqun

> ---
> Cheers,
> Benno
> 

