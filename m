Return-Path: <linux-fsdevel+bounces-17070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0388A72E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 20:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36AC8284DE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 18:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF561369B8;
	Tue, 16 Apr 2024 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heJ3p54w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD378134CD4;
	Tue, 16 Apr 2024 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713291151; cv=none; b=gwAsldPZOciEMa6ihtz7MGCR6DN9bnk1RvqkFN6VPbBwSctV9N/Uk9wBXBrxzruM9cC7yKLjZoi+W3XTDOaSgedwGx+63ymyGF0TTNV1eWJmEBokK3FBI3AP/lg+T9Dv+q07lO4ltlRQXHNl4EdA3poeUcoMS2NnPrnxVOilr68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713291151; c=relaxed/simple;
	bh=o/Pz18+RKaep+hg8mtEP9kW2B/vTbdfUmQG+bVJKW20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfmRvLYL57p3HBjgfcfW7THHcpfvYtPFlAPtqx0u6W2CN2XnogLXMuZAqwB71HCRElvOetnMW8YUd1y1+nKeLIz0iQMGHgdOLDWEE63t1YbV9mLBmkRFEDP/Y5NE3X76SAJJrFq+Sh4v1krrgXUdTjsLDahZKOej658jPBi3Ckc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heJ3p54w; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6eb8ae9b14eso1044890a34.0;
        Tue, 16 Apr 2024 11:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713291149; x=1713895949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKA01nHZWWeCUMwezGVKQPv6dB8WRSswCOMzscXKYBI=;
        b=heJ3p54wCh+Vu5wIz2uayiU9dyUbZxLrWAv1WTjzFOCjbiE79JFK3LDV8PipJALN/6
         e568ozu5vwDOZPG4C3m7OgW1Hxs85oxEUaU8/GoZlfd629aqLNDnu79R2StPeI98ZpLF
         DhHCjTdPVYLS5a1uc1//P8SGODC5AJ56KOCaFMinIR3aw+iYlxW0TUldIGQqXExDUkin
         8A9BmDCxHvAWq8JekbzDW50Ddh/0AAVL5E/ExYURIdOebDKiSUHdPyJypbw0WBYplt7c
         2MZPG0VE/xFTPAYoE+Pf88YB77TJp/Sr73rDYymTsIBkCvDEHbOrnZ04+slgMzJFpX5v
         W59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713291149; x=1713895949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKA01nHZWWeCUMwezGVKQPv6dB8WRSswCOMzscXKYBI=;
        b=r7qq5R0bPw8EB3XuKBw13g6HPMmG0ZulezUlfQfTZD0bIHwfvq1DWd2PmRfzc+YXG7
         edtDnSxUILsMVTe3RTQ7Szt5Ahy4UKl97Kkislmv9I2MNLZxfaBstsV+Q7y9YruISvPf
         P4aquINR3hOWoy4raPX5kMFh5DS3q4nBXW1R9fFeXQqCVVPWaxfyJb6iZM4nYSWqWnjB
         G8DfRS6cVdYSZV0orDyW7h5iXi227WyDRo6VEpJn95PZg4XL5rlZWfgwCGFxV8CEVQjs
         KaG+LN0m7WWzyEfdUHhetlyiSsnx5nftduGNXLY+9roI6EJTdOlX4tkkIAqvaZ36KzFI
         14oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbffWMoZDWX+piLgzm4VLzZNITVKNVIa2wvj4l1Yv7VVva6KiuYT241OeQrPmDrpM9kLFKy7nt4urxGTfNLO9gEah04Bzj/KDzTd30CBa08kNTF5Id1+GvsSVLSb3+a9P2R30iNzDB8uLL7RBmdq1hAwzT1yW7CbRTQLOxKt03sHG8fTF+d/Z+x4IiLuCQ1ObCmdK9loDgtJ9pv+JaUUlS9tbUPZunCA==
X-Gm-Message-State: AOJu0YxSApu6IvetWOUq4FjnBRZL2004FGG8CoHEPXpCiIoJtVAYaYUf
	QUYogQew185tUZr4TzYpxUNaus2WLH3Cz1o0jbszacnHV2bQ0wrS
X-Google-Smtp-Source: AGHT+IEsvpJ9PHMdwG/Acyze2YUbjWscWF8ldU9oec4TpSg6OiR2NDXpJYNLstl4DLb3bNX7ulcKpA==
X-Received: by 2002:a9d:4d95:0:b0:6eb:7bc3:12a5 with SMTP id u21-20020a9d4d95000000b006eb7bc312a5mr7305200otk.32.1713291148792;
        Tue, 16 Apr 2024 11:12:28 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id c25-20020a05620a135900b0078edf6393edsm3676965qkl.73.2024.04.16.11.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:12:28 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 028C71200077;
	Tue, 16 Apr 2024 14:12:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 16 Apr 2024 14:12:27 -0400
X-ME-Sender: <xms:ir8eZgbEqxjfyHkI9qB6eRHZtvYXA4CtzwbfjRa8Q9nQWC1N5sjDCg>
    <xme:ir8eZrb2vQTeWI0X7Cgm8I1_h9eZ_azk6RYDQZwGdjAgFWUPWz2sMDBoBJpE1i8mN
    _PnYtt-AwnaAXB2RA>
X-ME-Received: <xmr:ir8eZq_nseswGJfnz61rVpvbjRq6ebg_nJ6t-u9aaEFSnOUchA8Tr1r6beQs5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejiedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeethfejhfekjeffueegieejudegjeetveeuhfelhfevvdfgfeekkeevkeel
    veekgfenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhgnhhurdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgv
    shhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehhe
    ehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:ir8eZqpLHs0k5ul5Kl4J28dibHTNjP5Vh5cyp9QHQJQd6yPUbs_FNg>
    <xmx:ir8eZrq33PYRO9PrGL2Yfs8a7lJGFjsKKbnSWmqOANo95-kfzbZrTQ>
    <xmx:ir8eZoTyaZUzqZWAFPHRd6_-J5x-ZoqDEyCPR7Fw_thdspTrBtD85Q>
    <xmx:ir8eZrprTEoLpgQxmH34yK7TRsic4zq1awIzCuzXq0KRGHL30-39mg>
    <xmx:ir8eZg7He--6XEZRAbQoK6NRHu9hhc_fg22dV2jkYR8ZhJ7QNBonEKn4>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Apr 2024 14:12:26 -0400 (EDT)
Date: Tue, 16 Apr 2024 11:12:07 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,	Gary Guo <gary@garyguo.net>,
	"Bj\"orn Roy Baron" <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,	Will Deacon <will@kernel.org>,
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
Message-ID: <Zh6_d1T48qpANoCk@boqun-archlinux>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
 <ZgFVnar3nS4F8eIX@FVFF77S0Q05N>
 <ZgHly_fioG7X4wGE@boqun-archlinux>
 <20240409105015.GC21779@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409105015.GC21779@noisy.programming.kicks-ass.net>

On Tue, Apr 09, 2024 at 12:50:15PM +0200, Peter Zijlstra wrote:
> On Mon, Mar 25, 2024 at 01:59:55PM -0700, Boqun Feng wrote:
> > On Mon, Mar 25, 2024 at 10:44:45AM +0000, Mark Rutland wrote:
> > [...]
> > > > 
> > > > * I choose to re-implement atomics in Rust `asm` because we are still
> > > >   figuring out how we can make it easy and maintainable for Rust to call
> > > >   a C function _inlinely_ (Gary makes some progress [2]). Otherwise,
> > > >   atomic primitives would be function calls, and that can be performance
> > > >   bottleneck in a few cases.
> > > 
> > > I don't think we want to maintain two copies of each architecture's atomics.
> > > This gets painful very quickly (e.g. as arm64's atomics get patched between
> > > LL/SC and LSE forms).
> > > 
> > 
> > No argument here ;-)
> 
> Didn't we talk about bindgen being able to convert inline C functions
> into equivalent inline Rust functions? ISTR that getting stuck on Rust

Yes, we did.

> not having a useful inline asm.
> 

Mostly two features were missing: 1) asm goto and 2) memory operands,
#1 gets implemented[1] by Gary, and should be available in Rust 1.78
(plan to release at May 2, 2024); For #2, my understanding is that
arch-specific effort is needed (since different architectures may have
different contraints on memory operands), I haven't yet found anyone is
working on this.

(background explanation for broader audience: in GCC's inline asm, you
can specify an memory location, other than a register location, as an
input or output of an asm block's operand[2], but current Rust inline
asm doesn't provide this functionality, by default, without option
"pure", "nomem", etc, every asm block in Rust can be thought as a C asm
block with "memory" clobber)

That being said, if you look at the link I shared or this gist from
Gary:

	https://gist.github.com/nbdd0121/d4bf7dd7f9b6d6b50fa18b1092f45a3c

there is another way (yeah, we probably also have discussed this
previously), basically what it does is compiling the functions in a C
file as LLVM IR, so that Rust can call these functions at LLVM IR level.
This in theory is doing some local LTO, and I've tested that it works
for asm blocks. We still need to tweak our build system to make this
work, but should it work, it would mean that Rust can call a C function
in a pretty efficient way.

> But fixing all that in a hurry seems like the much saner path forward.

So a sane plan to me is wiring our atomics into Rust functions via what
Mark has (i.e. starting off as FFI calls), then we can switch to the
"local LTO" approach when it's ready. In case that "local LTO" needs
more work and we do have performance need, we can always either 1)
manually implement some primitives in Rust asm, or 2) look into how
bindgen or other tools can translate simple C functions (asm blocks)
into Rust.

Regards,
Boqun

[1]: https://github.com/rust-lang/rust/pull/119365
[2]: https://gcc.gnu.org/onlinedocs/gcc/Simple-Constraints.html#index-m-in-constraint

