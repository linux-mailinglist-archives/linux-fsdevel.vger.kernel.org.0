Return-Path: <linux-fsdevel+bounces-21657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CF790784D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 18:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84BE91F21F26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 16:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B041448ED;
	Thu, 13 Jun 2024 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egRfCbv3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C262C80;
	Thu, 13 Jun 2024 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718296262; cv=none; b=nDsesyjxBQGo3XU3toUv7AALEythwS05DMuvatc2NDfBX1h4dTGdCXj6ke4twvlHMSiY9MeAMjReXxX1acZVyEF6d1CziSZwidQqaKxULZ1co/sAPUfBTtEft+WDDOu8+zQqBourR/UioTXnGqRT5CXnZxS9SKH7o7P3+iZUzE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718296262; c=relaxed/simple;
	bh=IqOshH+3NtW6LgDbCLrcCvzFRZD6Ag+RJPv0ggdyq2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLxEa8KN1RecaNK0mSjISHhR+bWnuosvIdNwETCDlms3Xznw1nAQpoBkS8fO/vHY/E7rSOwfd4s3q2bYijPRn92pNXPXcKo68NXJOQeLR3wRCwMPEbr7+9IgZBUPXIccX/BxvXBM+It9ddkXQ81KP1994U3VcV78dPxRzAyfc0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egRfCbv3; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6f9b5bc97baso703547a34.0;
        Thu, 13 Jun 2024 09:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718296259; x=1718901059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/xQDUQkQkXZSewCHGCYidY7ntUnzyPAgvU909rXsNE=;
        b=egRfCbv3D7EK1GrVHXlw5zNQndyygNvnJ9E3HQNALWDLrItk23Avab5kF+VNVlNUx+
         rOEZjBgvfdktV9P0pb2xmEACvp68HXWWbCbRx9XHzXWo1sFEItkzDCDf6wh4PVTllWU1
         s/TswBA90n67xtYaH6n9armlVmidU+OHRFHDHextbaPVIdAt5iRSX0V6V3xOmtpylphn
         T/tZOf/O6Ys3uQRAJG/Sk3D7hZwoc4TvtLgfFf8cxD5Iozzofd6Ay2tEC2RClS/YmHMY
         GFB+P+BhM0TUnNxaDqfuKW1dmA9r1ONOPr5Di1JLjsJpt6sU8M4n1pSSybYB+F9LVjEl
         /vpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718296259; x=1718901059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/xQDUQkQkXZSewCHGCYidY7ntUnzyPAgvU909rXsNE=;
        b=sgE8Q7nrrK0x/wrIWQ9HPNH/GNAplXgRbv+22aBTNbCBQf4H/uxYhclNLNcISIyM2U
         MUHoFP9RA8j3yanC8zJjhnxanvDyY7IOrzn6nTyZqXOOEsgaSkCuqTfBRUkIaIjMoTpP
         1S1JS97J9tUaoKQUmIIVPn4LpoK4K6cLj/wnnkD3ZcWaccdgbzIKfq+Wxx7/Fsg5fo2m
         RzE2ai++6cU8Ag4cg+/2T0EcAMpyLCaGzHsbJ9nntpnmyJpZnzd9AyhSkSM/m7F8GgXQ
         wiTZM8f0WuIozA22yDiirJlaqq4/B8ii5nOq7Qv5XzPSNZ7azM6e2MRVlmyJ1DadntHv
         qXfg==
X-Forwarded-Encrypted: i=1; AJvYcCXP+nKi2kGapUDegNuAQve3kFlBX+TGJqEVLYCU2PZ8tjZj6qn56WOnSueSSJE2CFCGpnAGNtoDjp6Igt+ypayCKciPBVligvXePSFVBGDipoIgPtrLjQs/IQGeX9W8ampvVGEM9/s+7XaMb/Yd/g+x8tIPhXRDx56ZZo0U5ilGqpM5t68oGkE=
X-Gm-Message-State: AOJu0Yw0JykziiPJZJpT89VftUnz7JNNl/NhRSa5n7qym96jPTTpBRtl
	ACGwCYI8CJ6JPKgb8RpagGyQYPfEkSknQPbrgHwPiMtrXJ6BHAr3
X-Google-Smtp-Source: AGHT+IHwFVJixei88Rxkp/sFGEHh3v1G3Dr0Ysp8cDcd+fUGWk//eWkUZmoRtez0cWgxv3IlizQUJg==
X-Received: by 2002:a05:6830:2018:b0:6f9:89dd:edd7 with SMTP id 46e09a7af769-6fb93b0ee7bmr230805a34.36.1718296258768;
        Thu, 13 Jun 2024 09:30:58 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aacc5267sm65463685a.18.2024.06.13.09.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 09:30:58 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 177071200043;
	Thu, 13 Jun 2024 12:30:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 13 Jun 2024 12:30:57 -0400
X-ME-Sender: <xms:wB5rZlQDP15NYqqa2GCA3T1oyIrN0TeOvBx9ypN8ZpQO1NaCUNtIOg>
    <xme:wB5rZuz-N--h2ec81KEXlyv7MX9rUerjjSoaGBv1GlMujS0W3C6Rcu-qOE5SRXJrl
    CagXw_tQ7fYxreufg>
X-ME-Received: <xmr:wB5rZq3qz8o4YMkFgo70BP6jwqmYfDPReAocx3eVJFLAM9jtM3GrEjYBkgI8TQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedujedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhfefhfeelieffveetfffggeffhfeluddvtedtgedufefgteetiefgjeev
    ieehvdenucffohhmrghinhepughotghsrdhrshenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:wB5rZtDFvclFjf_8MJgIyO2ZGEg6qkBtejoRSVRWpJMsSYmeU4F5LQ>
    <xmx:wB5rZujdiV1kzawIFX9nZXwIq2rnaI5JKWuSUveuKBGMiJM4eZKEGQ>
    <xmx:wB5rZhqI2PPPNfOG6kheYMIP-Mi3wEGLJZeZQ8IR5UFdBT5KMRmF5g>
    <xmx:wB5rZpjgDtSNqbsLSg56TaGEk6UZhugXYXxCJxyvCj5jkCteR_bepw>
    <xmx:wR5rZpT97owrzRnWgiAN44FGPS9ePdSHjWTKIzugoHbT_OXktczmG2ti>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 12:30:56 -0400 (EDT)
Date: Thu, 13 Jun 2024 09:30:26 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Gary Guo <gary@garyguo.net>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, llvm@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>,	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
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
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,	Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,	torvalds@linux-foundation.org,
 linux-arm-kernel@lists.infradead.org,	linux-fsdevel@vger.kernel.org,
 Trevor Gross <tmgross@umich.edu>,	dakr@redhat.com
Subject: Re: [RFC 2/2] rust: sync: Add atomic support
Message-ID: <ZmseosxVQXdsQjNB@boqun-archlinux>
References: <20240612223025.1158537-1-boqun.feng@gmail.com>
 <20240612223025.1158537-3-boqun.feng@gmail.com>
 <20240613144432.77711a3a@eugeo>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613144432.77711a3a@eugeo>

On Thu, Jun 13, 2024 at 02:44:32PM +0100, Gary Guo wrote:
> On Wed, 12 Jun 2024 15:30:25 -0700
> Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> > Provide two atomic types: AtomicI32 and AtomicI64 with the existing
> > implemenation of C atomics. These atomics have the same semantics of the
> > corresponding LKMM C atomics, and using one memory (ordering) model
> > certainly reduces the reasoning difficulty and potential bugs from the
> > interaction of two different memory models.
> > 
> > Also bump my role to the maintainer of ATOMIC INFRASTRUCTURE to reflect
> > my responsiblity on these Rust APIs.
> > 
> > Note that `Atomic*::new()`s are implemented vi open coding on struct
> > atomic*_t. This allows `new()` being a `const` function, so that it can
> > be used in constant contexts.
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  MAINTAINERS                       |    4 +-
> >  arch/arm64/kernel/cpufeature.c    |    2 +
> >  rust/kernel/sync.rs               |    1 +
> >  rust/kernel/sync/atomic.rs        |   63 ++
> >  rust/kernel/sync/atomic/impl.rs   | 1375 +++++++++++++++++++++++++++++
> >  scripts/atomic/gen-atomics.sh     |    1 +
> >  scripts/atomic/gen-rust-atomic.sh |  136 +++
> >  7 files changed, 1581 insertions(+), 1 deletion(-)
> >  create mode 100644 rust/kernel/sync/atomic.rs
> >  create mode 100644 rust/kernel/sync/atomic/impl.rs
> >  create mode 100755 scripts/atomic/gen-rust-atomic.sh
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d6c90161c7bf..a8528d27b260 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3458,7 +3458,7 @@ F:	drivers/input/touchscreen/atmel_mxt_ts.c
> >  ATOMIC INFRASTRUCTURE
> >  M:	Will Deacon <will@kernel.org>
> >  M:	Peter Zijlstra <peterz@infradead.org>
> > -R:	Boqun Feng <boqun.feng@gmail.com>
> > +M:	Boqun Feng <boqun.feng@gmail.com>
> >  R:	Mark Rutland <mark.rutland@arm.com>
> >  L:	linux-kernel@vger.kernel.org
> >  S:	Maintained
> > @@ -3467,6 +3467,8 @@ F:	arch/*/include/asm/atomic*.h
> >  F:	include/*/atomic*.h
> >  F:	include/linux/refcount.h
> >  F:	scripts/atomic/
> > +F:	rust/kernel/sync/atomic.rs
> > +F:	rust/kernel/sync/atomic/
> >  
> >  ATTO EXPRESSSAS SAS/SATA RAID SCSI DRIVER
> >  M:	Bradley Grove <linuxdrivers@attotech.com>
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index 48e7029f1054..99e6e2b2867f 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -1601,6 +1601,8 @@ static bool
> >  has_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
> >  {
> >  	u64 val = read_scoped_sysreg(entry, scope);
> > +	if (entry->capability == ARM64_HAS_LSE_ATOMICS)
> > +		return false;
> >  	return feature_matches(val, entry);
> >  }
> >  
> > diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> > index 0ab20975a3b5..66ac3752ca71 100644
> > --- a/rust/kernel/sync.rs
> > +++ b/rust/kernel/sync.rs
> > @@ -8,6 +8,7 @@
> >  use crate::types::Opaque;
> >  
> >  mod arc;
> > +pub mod atomic;
> >  mod condvar;
> >  pub mod lock;
> >  mod locked_by;
> > diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> > new file mode 100644
> > index 000000000000..b0f852cf1741
> > --- /dev/null
> > +++ b/rust/kernel/sync/atomic.rs
> > @@ -0,0 +1,63 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Atomic primitives.
> > +//!
> > +//! These primitives have the same semantics as their C counterparts, for precise definitions of
> > +//! the semantics, please refer to tools/memory-model. Note that Linux Kernel Memory (Consistency)
> > +//! Model is the only model for Rust development in kernel right now, please avoid to use Rust's
> > +//! own atomics.
> > +
> > +use crate::bindings::{atomic64_t, atomic_t};
> > +use crate::types::Opaque;
> > +
> > +mod r#impl;
> > +
> > +/// Atomic 32bit signed integers.
> > +pub struct AtomicI32(Opaque<atomic_t>);
> > +
> > +/// Atomic 64bit signed integers.
> > +pub struct AtomicI64(Opaque<atomic64_t>);
> 
> 
> Can we avoid two types and use a generic `Atomic<T>` and then implement
> on `Atomic<i32>` and `Atomic<i64>` instead? Like the recent
> generic NonZero in Rust standard library or the atomic crate
> (https://docs.rs/atomic/).
> 

We can always add a layer on top of what we have here to provide the
generic `Atomic<T>`. However, I personally don't think generic
`Atomic<T>` is a good idea, for a few reasons:

*	I'm not sure it will bring benefits to users, the current atomic
	users in kernel are pretty specific on the size of atomic they
	use, so they want to directly use AtomicI32 or AtomicI64 in
	their type definitions rather than use a `Atomic<T>` where their
	users can provide type later.

*	I can also see the future where we have different APIs on
	different types of atomics, for example, we could have a:

		impl AtomicI64 {
		    pub fn split(&self) -> (&AtomicI32, &AtomicI32)
		}

	which doesn't exist for AtomicI32. Note this is not a UB because
	we write our atomic implementation in asm, so it's perfectly
	fine for mix-sized atomics.

So let's start with some basic and simple until we really have a need
for generic `Atomic<T>`. Thoughts?

Regards,
Boqun

> I think this is better for ergonomics. The impl do need some extra
> casting though.
> 
> Best,
> Gary

